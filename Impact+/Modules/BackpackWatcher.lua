--==============================================================--
-- Impact+
-- BackpackWatcher.lua
--
-- Version: 1.0.0
--
-- Changelog:
-- 1.0.0 - Character/move backpack detection
--==============================================================--
local Watcher={}
function Watcher:Init(Config, CharacterDatabase, MoveDatabase, CursedEnergy)
    self.Config=Config; self.CharacterDatabase=CharacterDatabase; self.MoveDatabase=MoveDatabase; self.CursedEnergy=CursedEnergy
end
function Watcher:_scan()
    local player=game:GetService("Players").LocalPlayer
    local backpack=player and player:FindFirstChildOfClass("Backpack")
    local character=player and player.Character
    if not backpack then return end
    local charData=self.CharacterDatabase:ResolveFromBackpack(backpack)
    if charData then self.CursedEnergy:SetCharacterColor(charData.Color) end
    local equipped=character and character:FindFirstChildOfClass("Tool")
    local item=equipped or backpack:FindFirstChildOfClass("Tool")
    if item then
        local move=self.MoveDatabase:Get(item.Name)
        if move then self.CursedEnergy:SetMoveColor(move.Color) end
    end
end
function Watcher:Start()
    if not self.Config.Features.BackpackDetection then return end
    local player=game:GetService("Players").LocalPlayer
    local backpack=player:WaitForChild("Backpack")
    self.Connections={}
    table.insert(self.Connections,backpack.ChildAdded:Connect(function() task.defer(function() self:_scan() end) end))
    table.insert(self.Connections,backpack.ChildRemoved:Connect(function() task.defer(function() self:_scan() end) end))
    player.CharacterAdded:Connect(function(character)
        table.insert(self.Connections,character.ChildAdded:Connect(function(child) if child:IsA("Tool") then self:_scan(); self.CursedEnergy:EquipPulse() end end))
        self:_scan()
    end)
    self:_scan()
end
return Watcher
