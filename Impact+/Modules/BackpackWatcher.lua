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
function Database:ResolveFromBackpack(backpack)
    if not backpack then
        return nil
    end

    local names = {}

    for _, item in ipairs(backpack:GetChildren()) do
        names[#names + 1] = self:Normalize(item.Name)
    end

    local priority = {
        {"hero hunter: cosmic", "cosmic"},
        {"hero hunter: monst", "monst", "monster"},
        {"destructive cyborg", "cyborg"},
        {"deadly ninja", "ninja"},
        {"brutal demon", "demon"},
        {"blade master", "blade"},
        {"wild psychic", "psychic"},
        {"martial artist", "martial"},
        {"tech prodigy", "tech"},
        {"undying hero", "undying"},
        {"hero hunter", "hunter"},
        {"saitama", "strongest", "normal punch"},
        {"kj", "ravage"},
        {"sorcerer", "infinity"},
    }

    for _, row in ipairs(priority) do
        local key = self:Normalize(row[1])

        for _, needle in ipairs(row) do
            needle = self:Normalize(needle)

            for _, itemName in ipairs(names) do
                if itemName:find(needle, 1, true) then
                    return self.Characters[key]
                end
            end
        end
    end

    return nil
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
