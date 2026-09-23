--==============================================================--
-- Impact+
-- Utilities.lua
--
-- Version: 1.0.0
--
-- Changelog:
-- 1.0.0 - Initial version
--==============================================================--
local Utilities = {}

function Utilities:FindChildPartial(parent, name)
    if not parent then return nil end
    local needle = tostring(name):lower()
    for _, child in ipairs(parent:GetChildren()) do
        if child.Name:lower():find(needle, 1, true) then return child end
    end
    return nil
end

function Utilities:GetCharacter(player)
    return player and player.Character or nil
end

function Utilities:GetRoot(character)
    return character and character:FindFirstChild("HumanoidRootPart") or nil
end

function Utilities:GetHumanoid(character)
    return character and character:FindFirstChildOfClass("Humanoid") or nil
end

function Utilities:IsAlive(humanoid)
    return humanoid and humanoid.Health > 0
end

function Utilities:SafeCall(label, callback, ...)
    local ok, result = pcall(callback, ...)
    if not ok then warn("[Impact+][" .. tostring(label) .. "] " .. tostring(result)) end
    return ok, result
end

function Utilities:LerpNumber(a, b, t)
    return a + (b - a) * t
end

return Utilities
