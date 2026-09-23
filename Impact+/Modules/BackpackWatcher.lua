local Watcher={}
function Watcher:Init(Config,CharacterDatabase,MoveDatabase,CursedEnergy) self.Config=Config; self.CharacterDatabase=CharacterDatabase; self.MoveDatabase=MoveDatabase; self.CursedEnergy=CursedEnergy; self.Connections={}; self.Started=false end
function Watcher:_scan()
    local player=game:GetService("Players").LocalPlayer; local backpack=player and player:FindFirstChildOfClass("Backpack"); local character=player and player.Character
    if not backpack or not self.CursedEnergy then return end
    local charData=self.CharacterDatabase:ResolveFromBackpack(backpack)
    if charData then self.CursedEnergy:SetCharacterColor(charData.Color) end
    local equipped=character and character:FindFirstChildOfClass("Tool")
    if equipped then
        local move=self.MoveDatabase:Get(equipped.Name)
        if move then self.CursedEnergy:SetMoveColor(move.Color) else self.CursedEnergy:ClearMoveColor() end
    else
        self.CursedEnergy:ClearMoveColor()
    end
end
function Watcher:_watchCharacter(character)
    if not character then return end
    table.insert(self.Connections,character.ChildAdded:Connect(function(child) if child:IsA("Tool") then self:_scan(); self.CursedEnergy:EquipPulse() end end))
    table.insert(self.Connections,character.ChildRemoved:Connect(function(child) if child:IsA("Tool") then task.defer(function() self:_scan() end) end end))
end
function Watcher:Start()
    if self.Started or not self.Config.Features.BackpackDetection then return end
    self.Started=true
    local player=game:GetService("Players").LocalPlayer; local backpack=player:WaitForChild("Backpack")
    table.insert(self.Connections,backpack.ChildAdded:Connect(function() task.defer(function() self:_scan() end) end))
    table.insert(self.Connections,backpack.ChildRemoved:Connect(function() task.defer(function() self:_scan() end) end))
    table.insert(self.Connections,player.CharacterAdded:Connect(function(character) self:_watchCharacter(character); task.defer(function() self:_scan() end) end))
    self:_watchCharacter(player.Character); self:_scan()
end
function Watcher:Cleanup() for i=#self.Connections,1,-1 do pcall(function() self.Connections[i]:Disconnect() end); self.Connections[i]=nil end; self.Started=false end
return Watcher
