-- Impact+ 2.1.0-fixed — canonical entry point
-- Repository layout: <repo>/Impact+/Main.lua and <repo>/Impact+/Modules/*.lua

local GEN = (getgenv and getgenv()) or _G
local ROOT = "Impact+"
local RAW = "https://raw.githubusercontent.com/ItsNullion/IMPACT-/main/Impact%2B"
local VERSION = "2.1.0-fixed"

local function log(x)
    print("[Impact+] " .. tostring(x))
end

local function fail(x)
    error("[Impact+] " .. tostring(x), 0)
end

if GEN.__ImpactPlus and type(GEN.__ImpactPlus.Destroy) == "function" then
    pcall(GEN.__ImpactPlus.Destroy)
end

local Runtime = {Connections = {}, Modules = {}, Destroyed = false}
GEN.__ImpactPlus = Runtime

local function conn(c)
    if c then table.insert(Runtime.Connections, c) end
    return c
end

local function disconnectAll()
    for i = #Runtime.Connections, 1, -1 do
        local c = Runtime.Connections[i]
        Runtime.Connections[i] = nil
        pcall(function() c:Disconnect() end)
    end
end

local function ensure(path)
    if type(isfolder) ~= "function" or type(makefolder) ~= "function" then
        return false
    end
    if not isfolder(path) then
        pcall(makefolder, path)
    end
    return isfolder(path)
end

local function read(path)
    if type(isfile) ~= "function" or type(readfile) ~= "function" or not isfile(path) then
        return nil
    end
    local ok, s = pcall(readfile, path)
    return ok and type(s) == "string" and #s > 0 and s or nil
end

local function download(url, path)
    if type(writefile) ~= "function" or not game:FindFirstChild("HttpGet") then
        return nil
    end
    local ok, body = pcall(function() return game:HttpGet(url) end)
    if not ok or type(body) ~= "string" or #body == 0 then
        warn("[Impact+] Download failed: [" .. url .. "]")
        return nil
    end
    local parent = path:match("^(.*)/[^/]+$")
    if parent then ensure(parent) end
    if pcall(writefile, path, body) then
        return body
    end
    warn("[Impact+] Could not cache: " .. path)
    return body
end

local function source(relative)
    local path = ROOT .. "/" .. relative
    local s = read(path)
    if s then return s, path, "cache" end
    s = download(RAW .. "/" .. relative, path)
    if s then return s, path, "remote" end
    return nil, path, "missing"
end

local function module(name)
    local s, path, where = source("Modules/" .. name .. ".lua")
    if not s then
        fail(name .. ".lua unavailable. Expected local file " .. path .. " or repository URL " .. RAW .. "/Modules/" .. name .. ".lua")
    end
    local fn, err = loadstring(s, "@" .. path)
    if not fn then
        fail(name .. ".lua compile error: " .. tostring(err))
    end
    local ok, result = pcall(fn)
    if not ok then
        fail(name .. ".lua runtime error: " .. tostring(result))
    end
    if type(result) ~= "table" then
        fail(name .. ".lua returned " .. type(result) .. " instead of a table")
    end
    Runtime.Modules[name] = result
    log(name .. " loaded (" .. where .. ")")
    return result
end

Runtime.Destroy = function()
    if Runtime.Destroyed then return end
    Runtime.Destroyed = true
    disconnectAll()
    for _, m in pairs(Runtime.Modules) do
        if type(m) == "table" then
            if type(m.Cleanup) == "function" then
                pcall(function() m:Cleanup() end)
            end
            if type(m.Destroy) == "function" then
                pcall(function() m:Destroy() end)
            end
        end
    end
    local ok, core = pcall(game.GetService, game, "CoreGui")
    if ok and core then
        for _, n in ipairs({"ImpactSettingsUI", "ImpactScreenEffects"}) do
            local g = core:FindFirstChild(n)
            if g then
                pcall(g.Destroy, g)
            end
        end
    end
end

ensure(ROOT)
ensure(ROOT .. "/Modules")
ensure(ROOT .. "/Assets")
ensure(ROOT .. "/Sounds")
ensure(ROOT .. "/Music")
ensure(ROOT .. "/Images")

for _, api in ipairs({"loadstring", "writefile", "readfile", "isfile", "isfolder", "makefolder", "getcustomasset"}) do
    if type(GEN[api]) ~= "function" and type(_G[api]) ~= "function" then
        fail("Required executor API missing: " .. api)
    end
end

log("Booting " .. VERSION)

local Config = module("Config")
local AssetManager = module("AssetManager")

if type(AssetManager.Initialize) ~= "function" then
    fail("AssetManager.Initialize() missing")
end

AssetManager:Initialize(Config)

local names = {"Utilities", "Audio", "CameraEffects", "ScreenEffects", "Shockwave", "MotionBlur", "Chromatic", "Finishers", "CharacterDatabase", "MoveDatabase", "BackpackWatcher", "CursedEnergy", "Settings", "UI"}

for _, n in ipairs(names) do
    module(n)
end

local M = Runtime.Modules

local function init(n, ...)
    if type(M[n].Init) ~= "function" then
        fail(n .. ":Init() missing")
    end
    local ok, e = pcall(function() M[n]:Init(...) end)
    if not ok then
        fail(n .. ":Init failed: " .. tostring(e))
    end
end

init("Audio", Config)
init("CameraEffects", Config)
init("ScreenEffects", Config)
init("Shockwave", Config)
init("MotionBlur", Config)
init("Chromatic", Config)
init("Settings", Config)
init("CursedEnergy", Config, M.Audio)
init("Finishers", Config, M.Audio, M.ScreenEffects, M.Shockwave)
init("BackpackWatcher", Config, M.CharacterDatabase, M.MoveDatabase, M.CursedEnergy)
init("UI", Config, M.Settings)

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local LP = Players.LocalPlayer
local RNG = Random.new()
local watched = {}
local criticalActive = {}

Runtime.__Watched = watched
Runtime.__CriticalActive = criticalActive

local function cleanupHumanoid(h)
    local s = watched[h]
    if not s then return end
    if s.Connection then
        pcall(function() s.Connection:Disconnect() end)
    end
    watched[h] = nil
    criticalActive[h] = nil
end

local function flash(critical)
    M.ScreenEffects:Flash(critical)
    if critical then
        M.ScreenEffects:Distortion()
    end
end

local function highlight()
    local camera = workspace.CurrentCamera
    if not camera then return end
    local h = camera:FindFirstChild("ImpactBlackFlashHighlight")
    if h then return h end
    h = Instance.new("Highlight")
    h.Name = "ImpactBlackFlashHighlight"
    h.DepthMode = Enum.HighlightDepthMode.Occluded
    h.FillColor = Color3.new(0, 0, 0)
    h.OutlineColor = Color3.fromRGB(255, 0, 0)
    h.Parent = camera
    return h
end

local function standard(cf)
    flash(false)
    local h = highlight()
    if h then
        h.FillTransparency = 0.15
        TweenService:Create(h, TweenInfo.new(0.25), {FillTransparency = 1}):Play()
    end
    M.CameraEffects:Shake(Config.Effects.NormalShakeStrength, 0.12)
    M.Shockwave:Emit(cf.Position, Color3.fromRGB(150, 0, 0), Config.Effects.ShockwaveRadius * 0.65, 0.18)
end

local function critical(cf, character, h, s)
    criticalActive[h] = os.clock()
    flash(true)
    M.CameraEffects:CriticalShake()
    M.CameraEffects:SlowMotion(Config.Effects.SlowMotionDuration)
    M.MotionBlur:Pulse(Config.Effects.BlurSize, 0.22)
    M.Chromatic:Pulse(Config.Effects.ChromaticStrength, 0.2)
    M.Shockwave:Emit(cf.Position, Color3.fromRGB(220, 0, 0), Config.Effects.ShockwaveRadius, Config.Effects.ShockwaveDuration)
    local hl = highlight()
    if hl then
        hl.FillColor = Color3.fromRGB(60, 0, 0)
        hl.FillTransparency = 0
        task.delay(0.35, function()
            if hl.Parent then
                TweenService:Create(hl, TweenInfo.new(0.3), {FillTransparency = 1}):Play()
            end
        end)
    end
    s.LastHitTime = os.clock()
    s.LastHitWasCritical = true
    if Config.Settings.Audio.MusicEnabled then
        M.Audio:PlayMusic()
    end
    if Config.Settings.Audio.NarratorEnabled then
        M.Audio:PlayNarrator()
    end
end

local function detect(character, humanoid)
    local my = LP.Character
    local myRoot = my and my:FindFirstChild("HumanoidRootPart")
    local theirRoot = character and character:FindFirstChild("HumanoidRootPart")
    if not myRoot or not theirRoot or humanoid.Health <= 0 then return end
    if (myRoot.Position - theirRoot.Position).Magnitude > Config.Runtime.HitDistance then return end
    local state = watched[humanoid]
    if not state then return end
    local now = os.clock()
    if now - state.LastHit < 0.4 then return end
    state.LastHit = now
    local best = math.huge
    local bestName = ""
    for _, part in ipairs(character:GetChildren()) do
        if part:IsA("BasePart") then
            local d = (myRoot.Position - part.Position).Magnitude
            if d < best then
                best = d
                bestName = part.Name:lower()
            end
        end
    end
    local isCritical = best < Config.Runtime.HitDistance * 0.45 and (bestName:find("head", 1, true) or bestName:find("leg", 1, true) or bestName:find("foot", 1, true)) ~= nil
    if isCritical then
        M.Audio:PlayCritical()
        critical(theirRoot.CFrame, character, humanoid, state)
    else
        M.Audio:PlayNormal()
        standard(theirRoot.CFrame)
        state.LastHitTime = now
        state.LastHitWasCritical = false
    end
end

local function watch(character)
    if not character or character == LP.Character then return end
    local h = character:FindFirstChildOfClass("Humanoid")
    if not h or watched[h] then return end
    local state = {LastHit = 0, LastHitTime = 0, LastHitWasCritical = false}
    watched[h] = state
    state.Connection = character.ChildAdded:Connect(function(child)
        if child:IsA("Accessory") and child.Name == "ForwardDashPushed" then
            task.defer(detect, character, h)
        end
    end)
    if character:FindFirstChild("ForwardDashPushed") then
        task.defer(detect, character, h)
    end
    state.Died = h.Died:Connect(function()
        if state.LastHitWasCritical and os.clock() - state.LastHitTime <= 1.2 and M.Finishers then
            pcall(function() M.Finishers:Play(character) end)
        end
        cleanupHumanoid(h)
    end)
end

if Config.Features.CursedEnergy then
    M.BackpackWatcher:Start()
end

local input = game:GetService("UserInputService")

conn(input.InputBegan:Connect(function(i, gp)
    if gp then return end
    if i.KeyCode == Enum.KeyCode.F2 then
        M.UI:ToggleSettingsMenu()
    elseif i.KeyCode == Enum.KeyCode.F1 then
        M.CursedEnergy:ToggleEnabled()
    end
end))

conn(LP.CharacterAdded:Connect(function()
    task.wait(0.25)
    if Runtime.Destroyed then return end
    M.CursedEnergy:Apply()
end))

for _, p in ipairs(Players:GetPlayers()) do
    if p ~= LP then
        if p.Character then
            watch(p.Character)
        end
        conn(p.CharacterAdded:Connect(watch))
    end
end

conn(Players.PlayerAdded:Connect(function(p)
    if p ~= LP then
        conn(p.CharacterAdded:Connect(watch))
        if p.Character then
            watch(p.Character)
        end
    end
end))

for _, d in ipairs(workspace:GetDescendants()) do
    if d:IsA("Humanoid") and d.Parent then
        watch(d.Parent)
    end
end

conn(workspace.DescendantAdded:Connect(function(d)
    if d:IsA("Humanoid") and d.Parent then
        task.defer(watch, d.Parent)
    end
end))

M.CursedEnergy:Apply()

log("READY — modules: " .. #names .. "/" .. #names .. "; detector active.")

return Runtime
