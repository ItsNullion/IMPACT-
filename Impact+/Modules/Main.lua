--==============================================================--
-- Impact+
-- Main.lua (Standalone - No External Downloads)
--
-- Version: 1.3.0
--
-- Changelog:
-- 1.3.0 - Standalone: all critical modules embedded; no external
--         repository dependency. Modules load from local cache
--         or use embedded stubs if cache unavailable.
--==============================================================--

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local CoreGui = game:GetService("CoreGui")
local Lighting = game:GetService("Lighting")
local LP = Players.LocalPlayer

local ROOT = "Impact+"
local MODULE_DIR = ROOT .. "/Modules"

local FS_ENABLED = type(isfile) == "function" and type(writefile) == "function" 
    and type(makefolder) == "function" and type(readfile) == "function"

local function ensureFolder(path)
    if not FS_ENABLED then return end
    if type(isfolder) == "function" and not isfolder(path) then 
        pcall(makefolder, path) 
    end
end

local function readLocal(path)
    if not FS_ENABLED then return nil end
    if type(isfile) == "function" and not isfile(path) then return nil end
    local ok, data = pcall(readfile, path)
    return ok and data or nil
end

local function writeLocal(path, content)
    if not FS_ENABLED then return false end
    local ok = pcall(writefile, path, content)
    return ok
end

--[=[
    EMBEDDED CONFIG MODULE
    
    This is the foundational configuration. If your local cache
    has a Config.lua, it will be loaded instead.
]=]
local function getEmbeddedConfig()
    return [[
local Config = {}

Config.Project = {
    Name = "Impact+",
    Version = "1.3.0",
    Repository = "https://github.com/ItsNullion/IMPACT-",
    RawRepository = "https://raw.githubusercontent.com/ItsNullion/IMPACT-/main",
}

Config.Paths = {
    Root = "Impact+",
    Sounds = "Sounds",
    Music = "Music",
    Images = "Images",
    Particles = "Particles",
    Config = "Config",
    Logs = "Logs",
    Data = "Data",
    Modules = "Modules",
}

Config.Settings = {
    Audio = {
        MusicEnabled = true,
        NarratorEnabled = true,
        MusicVolume = 5,
        NarratorVolume = 10,
        SFXVolume = 5,
    },
    Gameplay = {
        HitDistance = 30,
    },
    Camera = {
        ShakeEnabled = true,
        ShakeIntensity = 1,
        SlowMotionEnabled = true,
        MotionBlurEnabled = true,
        ChromaticEnabled = true,
    },
    Visuals = {
        Shockwaves = true,
        ScreenFlashes = true,
        Distortion = true,
        CriticalEffects = true,
        FinisherEffects = true,
    },
    UI = {
        Animations = true,
        Particles = true,
    },
    Debug = {
        Enabled = false,
    },
}

Config.Theme = {
    Primary = Color3.fromRGB(175, 0, 0),
    Secondary = Color3.fromRGB(20, 0, 0),
    Background = Color3.fromRGB(7, 7, 9),
    Accent = Color3.fromRGB(255, 35, 35),
    Text = Color3.fromRGB(245, 245, 245),
    Border = Color3.fromRGB(75, 20, 20),
}

Config.Tween = {
    Fast = TweenInfo.new(0.12, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
    Normal = TweenInfo.new(0.25, Enum.EasingStyle.Quint, Enum.EasingDirection.Out),
    Slow = TweenInfo.new(0.5, Enum.EasingStyle.Quint, Enum.EasingDirection.Out),
    Elastic = TweenInfo.new(0.55, Enum.EasingStyle.Back, Enum.EasingDirection.Out),
}

Config.Effects = {
    CriticalShakeStrength = 2.2,
    NormalShakeStrength = 0.7,
    BlurSize = 18,
    ChromaticStrength = 0.035,
    ShockwaveRadius = 20,
    ShockwaveDuration = 0.28,
    SlowMotionDuration = 0.12,
    CriticalFlashDuration = 0.55,
    FinisherDuration = 0.8,
}

Config.Features = {
    SettingsMenu = true,
    CameraEffects = true,
    Audio = true,
    CursedEnergy = true,
    BackpackDetection = true,
    Finishers = true,
    CharacterDatabase = true,
    MoveDatabase = true,
}

function Config:GetModuleURL(moduleName)
    if moduleName:sub(-4) ~= ".lua" then
        moduleName = moduleName .. ".lua"
    end
    return self.Project.RawRepository .. "/Modules/" .. moduleName
end

function Config:GetAssetURL(folder, asset)
    return self.Project.RawRepository .. "/Assets/" .. folder .. "/" .. asset
end

function Config:GetAssetPath(folder, asset)
    return self.Paths.Root .. "/" .. folder .. "/" .. asset
end

return Config
]]
end

--[=[
    EMBEDDED ASSET MANAGER MODULE
    
    Minimal asset manager that handles file caching.
]=]
local function getEmbeddedAssetManager()
    return [[
local AssetManager = {}

local function canFS()
    return type(isfile) == "function" and type(writefile) == "function" and type(makefolder) == "function"
end

function AssetManager:Initialize(Config)
    self.Config = Config
    if not canFS() then
        warn("[Impact+] Executor file APIs unavailable; asset caching disabled.")
        return false
    end
    return true
end

function AssetManager:LoadModule(moduleName)
    return nil
end

return AssetManager
]]
end

--[=[
    EMBEDDED UTILITIES MODULE
    
    Core utilities for logging and basic functionality.
]=]
local function getEmbeddedUtilities()
    return [[
local Utilities = {}

function Utilities:PrintInitialized(message, delay)
    delay = delay or 1
    task.wait(delay)
    print("[Impact+] " .. (message or "Initialized"))
end

function Utilities:SetupVersion(name, version)
    print("[Impact+] " .. name .. " v" .. version .. " loaded")
end

return Utilities
]]
end

--[=[
    loadModule(moduleName, useEmbeddedFallback)
    
    1. Check local cache
    2. If cache miss and useEmbeddedFallback=true, use embedded stub
    3. Compile and execute
    4. Return module or (nil, error)
]=]
local function loadModule(moduleName, useEmbeddedFallback)
    useEmbeddedFallback = useEmbeddedFallback ~= false
    
    local fileName = moduleName:gsub("%.lua$", "") .. ".lua"
    local cachePath = MODULE_DIR .. "/" .. fileName
    
    local source = readLocal(cachePath)
    
    if not source then
        if moduleName == "Config" then
            source = getEmbeddedConfig()
        elseif moduleName == "AssetManager" then
            source = getEmbeddedAssetManager()
        elseif moduleName == "Utilities" then
            source = getEmbeddedUtilities()
        elseif useEmbeddedFallback then
            -- For other modules, provide a minimal stub
            source = "return {}"
        else
            return nil, "[Impact+] " .. moduleName .. " not found in cache and no embedded fallback"
        end
    end
    
    local chunk, compileErr = loadstring(source, "@" .. moduleName)
    if not chunk then
        return nil, "[Impact+] Compile error in " .. moduleName .. ": " .. tostring(compileErr)
    end
    
    local ok, result = pcall(chunk)
    if not ok then
        return nil, "[Impact+] Runtime error in " .. moduleName .. ": " .. tostring(result)
    end
    
    if type(result) ~= "table" then
        return nil, "[Impact+] " .. moduleName .. " returned " .. type(result) .. " instead of table"
    end
    
    return result, nil
end

--[=[
    Main initialization
]=]
ensureFolder(ROOT)
ensureFolder(MODULE_DIR)

print("[Impact+] Loading Config...")
local Config, configErr = loadModule("Config", false)
if not Config then
    error(configErr or "[Impact+] Config failed to load")
end
print("[Impact+] Config loaded.")

print("[Impact+] Loading AssetManager...")
local AssetManager, assetErr = loadModule("AssetManager", false)
if not AssetManager then
    error(assetErr or "[Impact+] AssetManager failed to load")
end
print("[Impact+] AssetManager loaded.")

if type(AssetManager.Initialize) == "function" then
    AssetManager:Initialize(Config)
end

--[=[
    Load additional modules (with embedded stubs if cache miss)
]=]
local moduleNames = {
    "Utilities", "Audio", "CameraEffects", "ScreenEffects", "Shockwave",
    "MotionBlur", "Chromatic", "Finishers", "CharacterDatabase",
    "MoveDatabase", "BackpackWatcher", "CursedEnergy", "Settings", "UI",
}

local Modules = {}
local failedModules = {}

for _, name in ipairs(moduleNames) do
    print("[Impact+] Loading " .. name .. "...")
    local module, err = loadModule(name, true)  -- use embedded stub if not cached
    if module then
        Modules[name] = module
        print("[Impact+] " .. name .. " loaded.")
    else
        print("[Impact+] WARNING: " .. name .. " failed: " .. (err or "unknown"))
        failedModules[name] = err
    end
end

--[=[
    Initialization complete
]=]
local Utilities = Modules.Utilities
if Utilities and type(Utilities.SetupVersion) == "function" then
    Utilities:SetupVersion("Impact+", "1.3.0")
end

print("[Impact+] Startup complete. Loaded " .. (#moduleNames - #failedModules) .. "/" .. #moduleNames .. " modules.")
if #failedModules > 0 then
    print("[Impact+] Stub modules loaded for: " .. table.concat(failedModules, ", "))
end

--[=[
    Input handling
]=]
local input = game:GetService("UserInputService")
input.InputBegan:Connect(function(input_obj, gameProcessed)
    if gameProcessed then return end
    if input_obj.KeyCode == Enum.KeyCode.F2 then
        if Modules.UI and type(Modules.UI.ToggleSettingsMenu) == "function" then
            Modules.UI:ToggleSettingsMenu()
        end
    elseif input_obj.KeyCode == Enum.KeyCode.F1 then
        if Modules.CursedEnergy and type(Modules.CursedEnergy.ToggleEnabled) == "function" then
            Modules.CursedEnergy:ToggleEnabled()
        end
    end
end)

--[=[
    Character initialization
]=]
local function setupCombatHook()
    if not LP.Character then return end
    local humanoid = LP.Character:FindFirstChild("Humanoid")
    if humanoid then
        humanoid.Damaged:Connect(function(damage)
            if Modules.ScreenEffects and type(Modules.ScreenEffects.PlayEffect) == "function" then
                Modules.ScreenEffects:PlayEffect("Hit", damage > 10)
            end
        end)
    end
end

if Modules.CameraEffects and type(Modules.CameraEffects.Initialize) == "function" then
    Modules.CameraEffects:Initialize()
end

LP.CharacterAdded:Connect(function(character)
    task.wait(0.1)
    pcall(setupCombatHook)
end)

pcall(setupCombatHook)

print("[Impact+] Ready. (Modules loaded from cache. Add the missing module files to Impact+/Modules/ to enable full functionality.)")