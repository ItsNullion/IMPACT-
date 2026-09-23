-- Impact+ Config
local Config = {}

Config.Project = {
    Name = "Impact+",
    Version = "2.1.0-fixed",
    Repository = "https://github.com/ItsNullion/IMPACT-",
    -- The repository's production files live under the Impact+ directory.
    RawRepository = "https://raw.githubusercontent.com/ItsNullion/IMPACT-/main/Impact%2B",
}

Config.Paths = {
    Root = "Impact+",
    Sounds = "Sounds", Music = "Music", Images = "Images", Particles = "Particles",
    Config = "Config", Logs = "Logs", Data = "Data", Modules = "Modules", Effects = "Effects",
}

Config.GitHub = {
    Modules = "Modules",
    Sounds = "Assets/Sounds",
    Music = "Assets/Music",
    Images = "Assets/Images",
    Particles = "Assets/Particles",
    Effects = "Effects",
}

Config.Settings = {
    Audio = { MusicEnabled=true, NarratorEnabled=true, MusicVolume=5, NarratorVolume=10, SFXVolume=5 },
    Gameplay = { HitDistance=30 },
    Camera = { ShakeEnabled=true, ShakeIntensity=1, SlowMotionEnabled=true, MotionBlurEnabled=true, ChromaticEnabled=true },
    Visuals = { Shockwaves=true, ScreenFlashes=true, Distortion=true, CriticalEffects=true, FinisherEffects=true },
    UI = { Animations=true, Particles=true },
    Debug = { Enabled=false },
}

Config.Theme = {
    Primary=Color3.fromRGB(175,0,0), Secondary=Color3.fromRGB(20,0,0), Background=Color3.fromRGB(7,7,9),
    Accent=Color3.fromRGB(255,35,35), Text=Color3.fromRGB(245,245,245), Border=Color3.fromRGB(75,20,20),
}

Config.Tween = {
    Fast=TweenInfo.new(0.12,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),
    Normal=TweenInfo.new(0.25,Enum.EasingStyle.Quint,Enum.EasingDirection.Out),
    Slow=TweenInfo.new(0.5,Enum.EasingStyle.Quint,Enum.EasingDirection.Out),
    Elastic=TweenInfo.new(0.55,Enum.EasingStyle.Back,Enum.EasingDirection.Out),
}

Config.Effects = {
    CriticalShakeStrength=2.2, NormalShakeStrength=0.7, BlurSize=18, ChromaticStrength=0.035,
    ShockwaveRadius=20, ShockwaveDuration=0.28, SlowMotionDuration=0.12, CriticalFlashDuration=0.55, FinisherDuration=0.8,
}

Config.Features = {
    SettingsMenu=true, CameraEffects=true, Audio=true, CursedEnergy=true, BackpackDetection=true,
    Finishers=true, CharacterDatabase=true, MoveDatabase=true,
}

Config.Assets = {
    Sounds={Sounds="Sounds", Narrator="Narrator.mp3", EquipWhoosh="EquipWhoosh.mp3", Critical="Critical.mp3", Normal="Normal.mp3", Finisher="Finisher.mp3"},
    Music={Kokusen="KOKUSEENNN!!.mp3"},
    Images={Logo="Logo.png",Orb="Orb.png",SettingsButton="dje079e-d810008d-670a-49a3-9c8e-2ef45bf3fe44.png"},
    Particles={CursedEnergy="CursedEnergy.rbxm",Shockwave="Shockwave.rbxm",Finishers="Finishers.rbxm"},
}

Config.AssetIds = {
    EquipWhoosh="rbxassetid://103611765317551",
    Critical="rbxassetid://138962827060940",
    Normal="rbxassetid://102896911709401",
}

Config.Runtime = { HitDistance=Config.Settings.Gameplay.HitDistance }

function Config:GetModuleURL(name)
    name = tostring(name):gsub("%.lua$", "") .. ".lua"
    return self.Project.RawRepository .. "/Modules/" .. name
end
function Config:GetAssetURL(folder, asset)
    return "https://raw.githubusercontent.com/ItsNullion/IMPACT-/main/Impact%2B/Assets/" .. tostring(folder) .. "/" .. tostring(asset)
end
function Config:GetEffectURL(name)
    return self.Project.RawRepository .. "/Effects/" .. tostring(name):gsub("%.lua$", "") .. ".lua"
end
function Config:GetAssetPath(folder, asset)
    return self.Paths.Root .. "/" .. tostring(folder) .. "/" .. tostring(asset)
end

return Config
