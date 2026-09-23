local Database = {}
Database.Characters = {
    ["saitama"]={DisplayName="The Strongest Hero",Color=Color3.fromRGB(255,35,35)},
    ["hero hunter"]={DisplayName="Hero Hunter",Color=Color3.fromRGB(35,90,255)},
    ["hero hunter: monst"]={DisplayName="Hero Hunter: Monster Form",Color=Color3.fromRGB(125,0,0)},
    ["hero hunter: cosmic"]={DisplayName="Hero Hunter: Cosmic Form",Color=Color3.fromRGB(155,70,255)},
    ["destructive cyborg"]={DisplayName="Destructive Cyborg",Color=Color3.fromRGB(255,105,20)},
    ["deadly ninja"]={DisplayName="Deadly Ninja",Color=Color3.fromRGB(95,25,150)},
    ["brutal demon"]={DisplayName="Brutal Demon",Color=Color3.fromRGB(170,170,180)},
    ["blade master"]={DisplayName="Blade Master",Color=Color3.fromRGB(220,90,15)},
    ["wild psychic"]={DisplayName="Wild Psychic",Color=Color3.fromRGB(40,210,75)},
    ["martial artist"]={DisplayName="Martial Artist",Color=Color3.fromRGB(155,45,210)},
    ["tech prodigy"]={DisplayName="Tech Prodigy",Color=Color3.fromRGB(130,205,255)},
    ["undying hero"]={DisplayName="Undying Hero",Color=Color3.fromRGB(15,125,55)},
    ["kj"]={DisplayName="KJ",Color=Color3.fromRGB(175,0,0)},
    ["sorcerer"]={DisplayName="Sorcerer",Color=Color3.fromRGB(55,145,255)},
}
function Database:Normalize(value)
    return tostring(value or ""):lower():gsub("[%p_]", " "):gsub("%s+", " "):gsub("^%s*(.-)%s*$", "%1")
end
function Database:Get(name)
    local key=self:Normalize(name)
    if self.Characters[key] then return self.Characters[key] end
    for raw,data in pairs(self.Characters) do
        local normalized=self:Normalize(raw)
        if key:find(normalized,1,true) or normalized:find(key,1,true) then return data end
    end
end
function Database:ResolveFromBackpack(backpack)
    if not backpack then return nil end
    local names={}
    for _,item in ipairs(backpack:GetChildren()) do names[#names + 1] = self:Normalize(item.Name) end
    local priority={
        {"hero hunter: cosmic","cosmic"},{"hero hunter: monst","monst","monster"},{"destructive cyborg","cyborg"},
        {"deadly ninja","ninja"},{"brutal demon","demon"},{"blade master","blade"},{"wild psychic","psychic"},
        {"martial artist","martial"},{"tech prodigy","tech"},{"undying hero","undying"},{"hero hunter","hunter"},
        {"saitama","strongest","normal punch"},{"kj","ravage"},{"sorcerer","infinity"},
    }
    for _,row in ipairs(priority) do
        local key=self:Normalize(row[1])
        for _,needle in ipairs(row) do
            needle=self:Normalize(needle)
            for _,itemName in ipairs(names) do if itemName:find(needle,1,true) then return self.Characters[key] end end
        end
    end
end
return Database
