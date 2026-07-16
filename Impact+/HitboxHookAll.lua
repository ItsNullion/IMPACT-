local ReplicatedStorage = game:GetService("ReplicatedStorage")

local HitboxesFolder = ReplicatedStorage:WaitForChild("EventTypes"):WaitForChild("Hitboxes")

local function tableToString(tbl, indent)
    if not indent then indent = 0 end
    local formatting = string.rep("  ", indent)
    local result = "{\n"
    for k, v in pairs(tbl) do
        local formatType = type(v)
        local valStr = tostring(v)
        if formatType == "table" then
            if indent < 2 then 
                valStr = tableToString(v, indent + 1)
            else
                valStr = "{ ... }"
            end
        elseif formatType == "string" then
            valStr = '"' .. v .. '"'
        end
        result = result .. formatting .. "  [" .. tostring(k) .. "] = " .. valStr .. ",\n"
    end
    return result .. formatting .. "}"
end

local hookedModules = {}

for _, module in ipairs(HitboxesFolder:GetChildren()) do
    if module:IsA("ModuleScript") then
        local success, req = pcall(require, module)
        if success and type(req) == "table" and type(req.onLivePlay) == "function" then
            local original
            original = hookfunction(req.onLivePlay, function(...)
                local args = {...}
                print("\n--- HITBOX TRIGGERED: " .. module.Name .. " ---")
                
                for i, v in ipairs(args) do
                    print("ARG " .. i .. " (" .. typeof(v) .. "):")
                    if typeof(v) == "Instance" then
                        print("  Name:", v.Name, "Class:", v.ClassName)
                    elseif type(v) == "table" then
                        print(tableToString(v, 1))
                    else
                        print("  " .. tostring(v))
                    end
                end
                
                print("---------------------------------------\n")
                return original(...)
            end)
            table.insert(hookedModules, module.Name)
        end
    end
end

print("Hooked the following Hitbox modules: " .. table.concat(hookedModules, ", "))
print("Go hit a dummy now!")
