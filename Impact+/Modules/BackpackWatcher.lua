local Watcher={}
function Watcher:Init(Config, CharacterDatabase, MoveDatabase, CursedEnergy)
    self.Config=Config; self.CharacterDatabase=CharacterDatabase; self.MoveDatabase=MoveDatabase; self.CursedEnergy=CursedEnergy
    self.Connections={}; self.Started=false
end
function Watcher:_scan()
    if not self.CursedEnergy then return end
    local player=game:GetService("Players").LocalPlayer
    local backpack=player and player:FindFirstChildOfClass("Backpack")
    local character=player and player.Character
    if not backpack then return end
    local charData=self.CharacterDatabase and self.CharacterDatabase:ResolveFromBackpack(backpack)
    if charData then self.CursedEnergy:SetCharacterColor(charData.Color) end
    local equipped=character and character:FindFirstChildOfClass("Tool")
    local item=equipped or backpack:FindFirstChildOfClass("Tool")
    local move=item and self.MoveDatabase and self.MoveDatabase:Get(item.Name)
    self.CursedEnergy:SetMoveColor(move and move.Color or nil)
end
function Watcher:Start()
    if self.Started or not self.Config.Features.BackpackDetection then return end
    self.Started=true
    local player=game:GetService("Players").LocalPlayer
    local backpack=player:WaitForChild("Backpack")
    table.insert(self.Connections,backpack.ChildAdded:Connect(function() task.defer(function() self:_scan() end) end))
    table.insert(self.Connections,backpack.ChildRemoved:Connect(function() task.defer(function() self:_scan() end) end))
    table.insert(self.Connections,player.CharacterAdded:Connect(function(character)
        table.insert(self.Connections,character.ChildAdded:Connect(function(child)
            if child:IsA("Tool") then self:_scan(); self.CursedEnergy:EquipPulse() end
        end))
        self:_scan()
    end))
    self:_scan()
end
function Watcher:Cleanup()
    for i,c in ipairs(self.Connections or {}) do pcall(function() c:Disconnect() end); self.Connections[i]=nil end
    self.Started=false
end
return Watcher
