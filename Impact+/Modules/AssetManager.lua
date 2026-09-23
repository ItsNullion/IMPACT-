--==============================================================--
-- Impact+
-- AssetManager.lua
--
-- Version: 1.0.0
--
-- Changelog:
-- 1.0.0 - Initial version
--==============================================================--
local AssetManager = {}

local function canFS()
    return type(isfile) == "function" and type(writefile) == "function" and type(makefolder) == "function"
end

local function ensureFolder(path)
    if type(isfolder) ~= "function" or not isfolder(path) then
        pcall(makefolder, path)
    end
end

function AssetManager:Initialize(Config)
    self.Config = Config
    if not canFS() then
        warn("[Impact+] Executor file APIs are unavailable; local asset caching is disabled.")
        return false
    end
    ensureFolder(Config.Paths.Root)
    for _, path in pairs(Config.Paths) do
        if type(path) == "string" and path ~= Config.Paths.Root then
            ensureFolder(Config.Paths.Root .. "/" .. path)
        end
    end
    return true
end

function AssetManager:Download(url, localPath, force)
    if not canFS() then return false end
    if not force and isfile(localPath) then return true end
    local ok, body = pcall(function() return game:HttpGet(url) end)
    if not ok or type(body) ~= "string" or #body == 0 then
        warn("[Impact+] Failed to download: " .. tostring(url))
        return false
    end
    local wrote = pcall(writefile, localPath, body)
    return wrote
end

function AssetManager:EnsureModule(moduleName)
    local path = self.Config:GetAssetPath(self.Config.Paths.Modules, moduleName:gsub("%.lua$", "") .. ".lua")
    local url = self.Config:GetModuleURL(moduleName)
    if self:Download(url, path) then return path end
    return nil
end

function AssetManager:EnsureAsset(folder, assetName)
    local localPath = self.Config:GetAssetPath(folder, assetName)
    local urlFolder = self.Config.GitHub[folder]
    if not urlFolder then
        local map = {Sounds="Sounds", Music="Music", Images="Images", Particles="Particles"}
        urlFolder = map[folder]
    end
    if not urlFolder then return nil end
    if self:Download(self.Config:GetAssetURL(urlFolder:gsub("^Assets/", ""), assetName), localPath) then
        return localPath
    end
    return nil
end

function AssetManager:LoadModule(moduleName)
    local path = self:EnsureModule(moduleName)
    if not path or type(readfile) ~= "function" or type(loadstring) ~= "function" then return nil end
    local ok, result = pcall(function() return loadstring(readfile(path), "@" .. path)() end)
    if not ok then
        warn("[Impact+] Module load failed: " .. moduleName .. " -> " .. tostring(result))
        return nil
    end
    return result
end

return AssetManager
