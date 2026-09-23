-- Impact+ AssetManager - strict cache/download layer
local AssetManager = {}

local function fsOK()
    return type(isfile)=="function" and type(readfile)=="function" and type(writefile)=="function" and type(isfolder)=="function" and type(makefolder)=="function"
end

local function ensure(path)
    if not fsOK() then return false end
    if not isfolder(path) then pcall(makefolder,path) end
    return isfolder(path)
end

function AssetManager:Initialize(Config)
    self.Config=Config
    if not fsOK() then return false end
    ensure(Config.Paths.Root)
    for _,folder in ipairs({"Sounds","Music","Images","Particles","Config","Logs","Data","Modules","Effects"}) do ensure(Config.Paths.Root.."/"..folder) end
    return true
end

function AssetManager:Download(url,path,force)
    if not fsOK() then return false end
    if not force and isfile(path) then return true end
    local ok,body=pcall(function() return game:HttpGet(url) end)
    if not ok or type(body)~="string" or #body==0 then warn("[Impact+] HTTP failed: "..url); return false end
    local parent=path:match("^(.*)/[^/]+$")
    if parent then ensure(parent) end
    local wrote=pcall(writefile,path,body)
    return wrote and isfile(path)
end

function AssetManager:EnsureModule(name)
    local file=tostring(name):gsub("%.lua$","")..".lua"
    local path=self.Config.Paths.Root.."/Modules/"..file
    return self:Download(self.Config:GetModuleURL(file),path) and path or nil
end

function AssetManager:EnsureEffect(name)
    local file=tostring(name):gsub("%.lua$","")..".lua"
    local path=self.Config.Paths.Root.."/Effects/"..file
    return self:Download(self.Config:GetEffectURL(file),path) and path or nil
end

function AssetManager:EnsureAsset(folder,assetName)
    local path=self.Config:GetAssetPath(folder,assetName)
    local urlFolder=self.Config.GitHub[folder]
    if not urlFolder then return nil end
    return self:Download(self.Config:GetAssetURL(urlFolder:gsub("^Assets/",""),assetName),path) and path or nil
end

function AssetManager:LoadModule(name)
    local path=self:EnsureModule(name)
    if not path then return nil,"download failed" end
    local ok,fn=pcall(loadstring,readfile(path),"@"..path)
    if not ok or not fn then return nil,tostring(fn) end
    local ran,result=pcall(fn)
    if not ran then return nil,tostring(result) end
    return result
end

function AssetManager:LoadEffect(name)
    local path=self:EnsureEffect(name)
    if not path then return nil,"download failed" end
    local ok,fn=pcall(loadstring,readfile(path),"@"..path)
    if not ok or not fn then return nil,tostring(fn) end
    local ran,result=pcall(fn)
    if not ran then return nil,tostring(result) end
    return result
end

return AssetManager
