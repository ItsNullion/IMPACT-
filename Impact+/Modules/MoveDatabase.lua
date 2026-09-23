--==============================================================--
-- Impact+
-- MoveDatabase.lua
--
-- Version: 1.0.0
--
-- Changelog:
-- 1.0.0 - Move-to-color definitions
--==============================================================--
local Database = {}

Database.Moves = {
    ["normal punch"]={Character="saitama", Color=Color3.fromRGB(255,35,35)}, ["consecutive punches"]={Character="saitama", Color=Color3.fromRGB(255,35,35)}, ["shove"]={Character="saitama", Color=Color3.fromRGB(255,35,35)}, ["uppercut"]={Character="saitama", Color=Color3.fromRGB(255,35,35)},
    ["death counter"]={Character="saitama", Color=Color3.fromRGB(255,35,35)}, ["table flip"]={Character="saitama", Color=Color3.fromRGB(255,35,35)}, ["serious punch"]={Character="saitama", Color=Color3.fromRGB(255,35,35)}, ["omni directional punch"]={Character="saitama", Color=Color3.fromRGB(255,35,35)},
    ["flowing water"]={Character="hero hunter", Color=Color3.fromRGB(35,90,255)}, ["lethal whirlwind stream"]={Character="hero hunter", Color=Color3.fromRGB(35,90,255)}, ["hunter's grasp"]={Character="hero hunter", Color=Color3.fromRGB(35,90,255)}, ["prey's peril"]={Character="hero hunter", Color=Color3.fromRGB(35,90,255)},
    ["water stream cutting fist"]={Character="hero hunter", Color=Color3.fromRGB(35,90,255)}, ["the final hunt"]={Character="hero hunter", Color=Color3.fromRGB(35,90,255)}, ["rock splitting fist"]={Character="hero hunter", Color=Color3.fromRGB(35,90,255)}, ["crushed rock"]={Character="hero hunter", Color=Color3.fromRGB(35,90,255)},
    ["doom dive"]={Character="hero hunter: monst", Color=Color3.fromRGB(125,0,0)}, ["crowd buster"]={Character="hero hunter: monst", Color=Color3.fromRGB(125,0,0)}, ["hammer heel"]={Character="hero hunter: monst", Color=Color3.fromRGB(125,0,0)}, ["binding cloth"]={Character="hero hunter: monst", Color=Color3.fromRGB(125,0,0)},
    ["hunter's mark"]={Character="hero hunter: monst", Color=Color3.fromRGB(125,0,0)}, ["great fajin"]={Character="hero hunter: monst", Color=Color3.fromRGB(125,0,0)}, ["god slayer"]={Character="hero hunter: monst", Color=Color3.fromRGB(125,0,0)}, ["sky ripping fist"]={Character="hero hunter: monst", Color=Color3.fromRGB(125,0,0)},
    ["nuclear fission"]={Character="hero hunter: cosmic", Color=Color3.fromRGB(155,70,255)}, ["singularity"]={Character="hero hunter: cosmic", Color=Color3.fromRGB(155,70,255)},
    ["machine gun blows"]={Character="destructive cyborg", Color=Color3.fromRGB(255,105,20)}, ["ignition burst"]={Character="destructive cyborg", Color=Color3.fromRGB(255,105,20)}, ["blitz shot"]={Character="destructive cyborg", Color=Color3.fromRGB(255,105,20)}, ["jet dive"]={Character="destructive cyborg", Color=Color3.fromRGB(255,105,20)}, ["thunder kick"]={Character="destructive cyborg", Color=Color3.fromRGB(255,105,20)}, ["speedblitz dropkick"]={Character="destructive cyborg", Color=Color3.fromRGB(255,105,20)}, ["flamewave cannon"]={Character="destructive cyborg", Color=Color3.fromRGB(255,105,20)}, ["incinerate"]={Character="destructive cyborg", Color=Color3.fromRGB(255,105,20)},
    ["flash strike"]={Character="deadly ninja", Color=Color3.fromRGB(95,25,150)}, ["whirlwind kick"]={Character="deadly ninja", Color=Color3.fromRGB(95,25,150)}, ["scatter"]={Character="deadly ninja", Color=Color3.fromRGB(95,25,150)}, ["explosive shuriken"]={Character="deadly ninja", Color=Color3.fromRGB(95,25,150)}, ["twinblade rush"]={Character="deadly ninja", Color=Color3.fromRGB(95,25,150)}, ["straight on"]={Character="deadly ninja", Color=Color3.fromRGB(95,25,150)}, ["carnage"]={Character="deadly ninja", Color=Color3.fromRGB(95,25,150)}, ["fourfold flashstrike"]={Character="deadly ninja", Color=Color3.fromRGB(95,25,150)},
    ["homerun"]={Character="brutal demon", Color=Color3.fromRGB(170,170,180)}, ["beatdown"]={Character="brutal demon", Color=Color3.fromRGB(170,170,180)}, ["grand slam"]={Character="brutal demon", Color=Color3.fromRGB(170,170,180)}, ["foul ball"]={Character="brutal demon", Color=Color3.fromRGB(170,170,180)}, ["savage tornado"]={Character="brutal demon", Color=Color3.fromRGB(170,170,180)}, ["brutal beatdown"]={Character="brutal demon", Color=Color3.fromRGB(170,170,180)}, ["strength difference"]={Character="brutal demon", Color=Color3.fromRGB(170,170,180)}, ["death blow"]={Character="brutal demon", Color=Color3.fromRGB(170,170,180)},
    ["quick slice"]={Character="blade master", Color=Color3.fromRGB(220,90,15)}, ["atmos cleave"]={Character="blade master", Color=Color3.fromRGB(220,90,15)}, ["pinpoint cut"]={Character="blade master", Color=Color3.fromRGB(220,90,15)}, ["split second counter"]={Character="blade master", Color=Color3.fromRGB(220,90,15)}, ["sunset"]={Character="blade master", Color=Color3.fromRGB(220,90,15)}, ["solar cleave"]={Character="blade master", Color=Color3.fromRGB(220,90,15)}, ["sunrise"]={Character="blade master", Color=Color3.fromRGB(220,90,15)}, ["atomic slash"]={Character="blade master", Color=Color3.fromRGB(220,90,15)},
    ["crushing pull"]={Character="wild psychic", Color=Color3.fromRGB(40,210,75)}, ["windstorm fury"]={Character="wild psychic", Color=Color3.fromRGB(40,210,75)}, ["stone coffin"]={Character="wild psychic", Color=Color3.fromRGB(40,210,75)}, ["expulsive push"]={Character="wild psychic", Color=Color3.fromRGB(40,210,75)}, ["cosmic strike"]={Character="wild psychic", Color=Color3.fromRGB(40,210,75)}, ["psychic ricochet"]={Character="wild psychic", Color=Color3.fromRGB(40,210,75)}, ["terrible tornado"]={Character="wild psychic", Color=Color3.fromRGB(40,210,75)}, ["sky snatcher"]={Character="wild psychic", Color=Color3.fromRGB(40,210,75)},
    ["bullet barrage"]={Character="martial artist", Color=Color3.fromRGB(155,45,210)}, ["vanishing kick"]={Character="martial artist", Color=Color3.fromRGB(155,45,210)}, ["whirlwind drop"]={Character="martial artist", Color=Color3.fromRGB(155,45,210)}, ["head first"]={Character="martial artist", Color=Color3.fromRGB(155,45,210)}, ["grand fissure"]={Character="martial artist", Color=Color3.fromRGB(155,45,210)}, ["twin fangs"]={Character="martial artist", Color=Color3.fromRGB(155,45,210)}, ["earth splitting strike"]={Character="martial artist", Color=Color3.fromRGB(155,45,210)}, ["last breath"]={Character="martial artist", Color=Color3.fromRGB(155,45,210)},
    ["weboom"]={Character="tech prodigy", Color=Color3.fromRGB(130,205,255)}, ["plasma cannon"]={Character="tech prodigy", Color=Color3.fromRGB(130,205,255)}, ["trinity tear"]={Character="tech prodigy", Color=Color3.fromRGB(130,205,255)}, ["twin burst"]={Character="tech prodigy", Color=Color3.fromRGB(130,205,255)}, ["photon edge"]={Character="tech prodigy", Color=Color3.fromRGB(130,205,255)}, ["photon dive"]={Character="tech prodigy", Color=Color3.fromRGB(130,205,255)}, ["conquest"]={Character="tech prodigy", Color=Color3.fromRGB(130,205,255)}, ["missiles"]={Character="tech prodigy", Color=Color3.fromRGB(130,205,255)},
    ["grave maker"]={Character="undying hero", Color=Color3.fromRGB(15,125,55)}, ["blast breaker"]={Character="undying hero", Color=Color3.fromRGB(15,125,55)}, ["point blank"]={Character="undying hero", Color=Color3.fromRGB(15,125,55)}, ["cross fire"]={Character="undying hero", Color=Color3.fromRGB(15,125,55)},
    ["ravage"]={Character="kj", Color=Color3.fromRGB(175,0,0)}, ["swift sweep"]={Character="kj", Color=Color3.fromRGB(175,0,0)}, ["collateral ruin"]={Character="kj", Color=Color3.fromRGB(175,0,0)}, ["spiraling storm"]={Character="kj", Color=Color3.fromRGB(175,0,0)}, ["stoic bomb"]={Character="kj", Color=Color3.fromRGB(175,0,0)}, ["20-20-20 dropkick"]={Character="kj", Color=Color3.fromRGB(175,0,0)}, ["five seasons"]={Character="kj", Color=Color3.fromRGB(175,0,0)}, ["unlimited flex works"]={Character="kj", Color=Color3.fromRGB(175,0,0)},
    ["infinity"]={Character="sorcerer", Color=Color3.fromRGB(55,145,255)}, ["repulse"]={Character="sorcerer", Color=Color3.fromRGB(55,145,255)}, ["erase"]={Character="sorcerer", Color=Color3.fromRGB(55,145,255)}, ["attract"]={Character="sorcerer", Color=Color3.fromRGB(55,145,255)},
}

function Database:Normalize(value)
    return tostring(value or ""):lower():gsub("_", " "):gsub("%s+", " "):gsub("^%s*(.-)%s*$", "%1")
end

function Database:Get(moveName)
    local n = self:Normalize(moveName)
    if n == "" then return nil end
    if self.Moves[n] then return self.Moves[n] end
    for key, data in pairs(self.Moves) do
        if n:find(key, 1, true) or key:find(n, 1, true) then return data end
    end
end

return Database
