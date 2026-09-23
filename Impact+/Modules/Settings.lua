local Settings={}
function Settings:Init(Config) self.Config=Config end
function Settings:Get(path,default)
    local node=self.Config and self.Config.Settings
    for part in tostring(path):gmatch("[^%.]+") do node=node and node[part] end
    return node==nil and default or node
end
function Settings:Set(path,value)
    local parts={}; for part in tostring(path):gmatch("[^%.]+") do parts[#parts+1]=part end
    if #parts==0 then return false end
    local node=self.Config.Settings
    for i=1,#parts-1 do node=node and node[parts[i]]; if not node then return false end end
    if not node then return false end
    node[parts[#parts]]=value
    if path=="Gameplay.HitDistance" then self.Config.Runtime.HitDistance=math.max(1,tonumber(value) or 30) end
    return true
end
return Settings
