--==============================================================--
-- Impact+
-- Settings.lua
--
-- Version: 1.0.0
--
-- Changelog:
-- 1.0.0 - Runtime settings state and persistence-ready API
--==============================================================--
local Settings={}
function Settings:Init(Config) self.Config=Config end
function Settings:Get(path,default)
    local node=self.Config.Settings
    for part in string.gmatch(path,"[^%.]+") do node=node and node[part] end
    if node==nil then return default end
    return node
end
function Settings:Set(path,value)
    local node=self.Config.Settings; local parts={}
    for part in string.gmatch(path,"[^%.]+") do table.insert(parts,part) end
    for i=1,#parts-1 do node=node[parts[i]]; if not node then return false end end
    node[parts[#parts]]=value
    if path=="Gameplay.HitDistance" then self.Config.Runtime.HitDistance=value end
    return true
end
return Settings
