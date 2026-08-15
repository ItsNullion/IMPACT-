--==============================================================--
-- Impact+
-- Modules/Config.lua
--
-- Version: 1.0.0
--
-- Changelog:
-- 1.0.0 - Initial version
--==============================================================--

-- language: Luau, file: Modules/Config.lua, runtime: Roblox executor (UNC)
-- *getcustomasset is executor-side only — guard every call with isfile() before invoking*
-- *TweenInfo.new(table.unpack(Config.Tweens.Fast)) is the intended usage pattern*

local Config = {}

-- ═══════════════════════════════════════════════════════════════
--  PROJECT INFO
-- ═══════════════════════════════════════════════════════════════
Config.Project = {
    Name       = "Impact+",
    Version    = "1.0.0",
    Repository = "https://github.com/ItsNullion/IMPACT-",
    Branch     = "main",
}

-- ═══════════════════════════════════════════════════════════════
--  GITHUB BASE URLS
-- ═══════════════════════════════════════════════════════════════
Config.GitHub = {
    Raw       = "https://raw.githubusercontent.com/ItsNullion/IMPACT-/refs/heads/main/",
    Modules   = "https://raw.githubusercontent.com/ItsNullion/IMPACT-/refs/heads/main/Modules/",
    AssetBase = "https://raw.githubusercontent.com/ItsNullion/IMPACT-/refs/heads/main/Assets/",
    Sounds    = "https://raw.githubusercontent.com/ItsNullion/IMPACT-/refs/heads/main/Assets/Sounds/",
    Music     = "https://raw.githubusercontent.com/ItsNullion/IMPACT-/refs/heads/main/Assets/Music/",
    Images    = "https://raw.githubusercontent.com/ItsNullion/IMPACT-/refs/heads/main/Assets/Images/",
    Particles = "https://raw.githubusercontent.com/ItsNullion/IMPACT-/refs/heads/main/Assets/Particles/",
}

-- ═══════════════════════════════════════════════════════════════
--  LOCAL FOLDER PATHS  (executor workspace)
-- ═══════════════════════════════════════════════════════════════
Config.Paths = {
    Root      = "Impact+",
    Sounds    = "Impact+/Sounds",
    Music     = "Impact+/Music",
    Images    = "Impact+/Images",
    Particles = "Impact+/Particles",
    ConfigDir = "Impact+/Config",
    Logs      = "Impact+/Logs",
    Data      = "Impact+/Data",
}

-- ═══════════════════════════════════════════════════════════════
--  ASSET REGISTRY
--  Config.Assets.<Category>.<Key> = filename (no path prefix)
--  Resolve with Config:GetAssetPath() / Config:GetAssetURL()
-- ═══════════════════════════════════════════════════════════════
Config.Assets = {
    Sounds = {
        Narrator  = "Narrator.mp3",
        Whoosh    = "EquipWhoosh.mp3",   -- rbxassetid://103611765317551
        Critical  = "Critical.mp3",
        Normal    = "Normal.mp3",
        Finisher  = "Finisher.mp3",
    },
    Music = {
        Kokusen   = "KOKUSEENNN!!.mp3",
    },
    Images = {
        Logo           = "Logo.png",
        Orb            = "Orb.png",
        SettingsButton = "SettingsButton.png",
    },
    Particles = {
        CursedEnergy = "CursedEnergy.rbxm",
        Shockwave    = "Shockwave.rbxm",
        Finishers    = "Finishers.rbxm",
    },
    Data = {
        Characters = "Characters.json",
        Moves      = "Moves.json",
        Themes     = "Themes.json",
    },
    Config = {
        Settings = "Settings.json",
        Cache    = "Cache.json",
    },
}

-- ═══════════════════════════════════════════════════════════════
--  DEFAULT SETTINGS
--  Persisted to Impact+/Config/Settings.json on first run.
--  Audio.lua, CameraEffects.lua, UI.lua all read from here via
--  the Settings module — never hardcode these values downstream.
-- ═══════════════════════════════════════════════════════════════
Config.Defaults = {

    Audio = {
        MusicEnabled    = true,
        NarratorEnabled = true,
        MusicVolume     = 5,      -- absolute Sound.Volume; matches existing script
        NarratorVolume  = 10,     -- absolute Sound.Volume; matches existing script
        SFXVolume       = 1.0,    -- multiplier applied to per-hit sound instances
    },

    Gameplay = {
        HitDistance = 30,         -- studs; MAX_DISTANCE in main script
    },

    Camera = {
        ShakeEnabled      = true,
        ShakeIntensity    = 1.0,  -- multiplier; 1.0 = default, 2.0 = double
        SlowMotionEnabled = true,
        MotionBlurEnabled = true,
        ChromaticEnabled  = true,
    },

    Visuals = {
        ShockwaveEnabled   = true,
        ScreenFlashEnabled = true,
        DistortionEnabled  = true,
        CriticalFXEnabled  = true,
        FinisherFXEnabled  = true,
        ParticlesEnabled   = true,
    },

    UI = {
        AnimationsEnabled = true,
    },

    Debug = {
        DebugMode = false,        -- gates all [Impact+ DEBUG] print calls in main script
    },
}

-- ═══════════════════════════════════════════════════════════════
--  THEME
-- ═══════════════════════════════════════════════════════════════
Config.Theme = {
    Primary    = Color3.fromRGB(18,  0,   0),    -- near-black red base
    Secondary  = Color3.fromRGB(120, 0,   0),    -- deep red
    Background = Color3.fromRGB(10,  10,  10),   -- off-black
    Accent     = Color3.fromRGB(200, 0,   0),    -- vivid red
    Text       = Color3.fromRGB(230, 230, 230),  -- near-white
    Border     = Color3.fromRGB(60,  0,   0),    -- muted red border

    -- Settings panel gradient endpoints
    GradientA  = Color3.fromRGB(20,  0,   0),
    GradientB  = Color3.fromRGB(80,  0,   0),
}

-- ═══════════════════════════════════════════════════════════════
--  TWEEN PRESETS
--  Format: { Time, EasingStyle, EasingDirection, RepeatCount, Reverse, DelayTime }
--  Usage:  TweenInfo.new(table.unpack(Config.Tweens.Fast))
--  Or via: Config:MakeTween("Fast")
-- ═══════════════════════════════════════════════════════════════
Config.Tweens = {
    Fast    = { 0.15, Enum.EasingStyle.Quad,    Enum.EasingDirection.Out, 0, false, 0 },
    Normal  = { 0.3,  Enum.EasingStyle.Quad,    Enum.EasingDirection.Out, 0, false, 0 },
    Slow    = { 0.6,  Enum.EasingStyle.Cubic,   Enum.EasingDirection.Out, 0, false, 0 },
    Elastic = { 0.5,  Enum.EasingStyle.Elastic, Enum.EasingDirection.Out, 0, false, 0 },
}

-- ═══════════════════════════════════════════════════════════════
--  EFFECT VALUES
--  All numeric constants that would otherwise be hardcoded in
--  CameraEffects, ScreenEffects, Shockwave, Audio, etc.
-- ═══════════════════════════════════════════════════════════════
Config.Effects = {
    -- Camera shake
    CriticalShakeStrength = 1.2,   -- studs; passed to CameraEffects:CriticalShake()
    NormalShakeStrength   = 0.4,

    -- Post-processing
    BlurSize              = 20,    -- BlurEffect.Size peak on critical
    ChromaticStrength     = 8,     -- pixel offset for R/B channel separation

    -- Shockwave
    ShockwaveRadius       = 24,    -- max stud radius of expanding ring
    ShockwaveDuration     = 0.45,  -- seconds to full expansion

    -- Slow motion
    SlowMotionDuration    = 0.18,  -- seconds of time dilation (~11 frames @ 60 fps)
    SlowMotionScale       = 0.2,   -- RunService step override scale

    -- Audio timing (mirrors existing startKokusenAudio behaviour)
    KokusenAudioDelay     = 1.0,   -- seconds after critical hit before music/narrator start
    MusicDuckedVolume     = 0.35,  -- music volume during narrator playback
    MusicDuckFadeDuration = 0.6,   -- seconds to duck down
    MusicRestoreDuration  = 1.2,   -- seconds to restore after narrator Ended fires

    -- Finisher
    FinisherBlurPeak      = 30,
    FinisherFlashDuration = 0.25,
}

-- ═══════════════════════════════════════════════════════════════
--  FEATURE FLAGS
--  Toggle entire systems without modifying module files.
-- ═══════════════════════════════════════════════════════════════
Config.Features = {
    SettingsMenu      = true,
    CameraEffects     = true,
    Audio             = true,
    CursedEnergy      = true,
    BackpackDetection = true,
    Finishers         = true,
    CharacterDatabase = true,
    MoveDatabase      = true,
}

-- ═══════════════════════════════════════════════════════════════
--  CURSED ENERGY COLORS
--  Every entry: { Primary = Color3, Secondary = Color3.new(0,0,0) }
--  Secondary is always black per the cursed energy visual spec.
--  Used by CursedEnergy.lua to set particle colors on character detect.
-- ═══════════════════════════════════════════════════════════════
Config.CursedEnergyColors = {
    -- Character-level defaults (resolved from BackpackWatcher identity)
    Saitama          = { Primary = Color3.fromRGB(220, 0,   0),   Secondary = Color3.new(0, 0, 0) },   -- red
    HeroHunter       = { Primary = Color3.fromRGB(0,   80,  220), Secondary = Color3.new(0, 0, 0) },   -- blue
    HeroHunterMonst  = { Primary = Color3.fromRGB(139, 0,   0),   Secondary = Color3.new(0, 0, 0) },   -- crimson / deep red
    HeroHunterCosmic = { Primary = Color3.fromRGB(120, 0,   180), Secondary = Color3.new(0, 0, 0) },   -- cosmic purple
    DestructiveCyborg= { Primary = Color3.fromRGB(255, 100, 0),   Secondary = Color3.new(0, 0, 0) },   -- vibrant orange
    DeadlyNinja      = { Primary = Color3.fromRGB(60,  0,   90),  Secondary = Color3.new(0, 0, 0) },   -- dark purple
    BrutalDemon      = { Primary = Color3.fromRGB(160, 160, 160), Secondary = Color3.new(0, 0, 0) },   -- silver/grey
    BladeMaster      = { Primary = Color3.fromRGB(210, 80,  0),   Secondary = Color3.new(0, 0, 0) },   -- deep orange
    WildPsychic      = { Primary = Color3.fromRGB(0,   160, 30),  Secondary = Color3.new(0, 0, 0) },   -- green
    MartialArtist    = { Primary = Color3.fromRGB(100, 0,   160), Secondary = Color3.new(0, 0, 0) },   -- purple
    TechProdigy      = { Primary = Color3.fromRGB(100, 180, 255), Secondary = Color3.new(0, 0, 0) },   -- baby blue
    UndyingHero      = { Primary = Color3.fromRGB(0,   120, 40),  Secondary = Color3.new(0, 0, 0) },   -- deeper green
    KJ               = { Primary = Color3.fromRGB(160, 0,   0),   Secondary = Color3.new(0, 0, 0) },   -- deeper red
    Sorcerer         = { Primary = Color3.fromRGB(0,   140, 255), Secondary = Color3.new(0, 0, 0) },   -- bright blue
}

-- ═══════════════════════════════════════════════════════════════
--  MOVE DATABASE
--  Per-move color overrides for mixed-kit players.
--  When BackpackWatcher detects a mixed backpack, CursedEnergy.lua
--  switches to the move-level color for the move being used.
--  Format: [MoveName] = { Primary, Secondary }
-- ═══════════════════════════════════════════════════════════════
Config.MoveColors = {
    -- ── Saitama ──────────────────────────────────────────────
    ["Normal Punch"]           = { Primary = Color3.fromRGB(220, 0,   0),   Secondary = Color3.new(0,0,0) },
    ["Consecutive Punches"]    = { Primary = Color3.fromRGB(220, 0,   0),   Secondary = Color3.new(0,0,0) },
    ["Shove"]                  = { Primary = Color3.fromRGB(220, 0,   0),   Secondary = Color3.new(0,0,0) },
    ["Uppercut"]               = { Primary = Color3.fromRGB(220, 0,   0),   Secondary = Color3.new(0,0,0) },
    ["Death Counter"]          = { Primary = Color3.fromRGB(220, 0,   0),   Secondary = Color3.new(0,0,0) },
    ["Table Flip"]             = { Primary = Color3.fromRGB(220, 0,   0),   Secondary = Color3.new(0,0,0) },
    ["Serious Punch"]          = { Primary = Color3.fromRGB(220, 0,   0),   Secondary = Color3.new(0,0,0) },
    ["Omni Directional Punch"] = { Primary = Color3.fromRGB(220, 0,   0),   Secondary = Color3.new(0,0,0) },

    -- ── Hero Hunter ──────────────────────────────────────────
    ["Flowing Water"]          = { Primary = Color3.fromRGB(0,   80,  220), Secondary = Color3.new(0,0,0) },
    ["Lethal Whirlwind Stream"]= { Primary = Color3.fromRGB(0,   80,  220), Secondary = Color3.new(0,0,0) },
    ["Hunter's Grasp"]         = { Primary = Color3.fromRGB(0,   80,  220), Secondary = Color3.new(0,0,0) },
    ["Prey's Peril"]           = { Primary = Color3.fromRGB(0,   80,  220), Secondary = Color3.new(0,0,0) },
    ["Water Stream Cutting Fist"] = { Primary = Color3.fromRGB(0, 80,  220), Secondary = Color3.new(0,0,0) },
    ["The Final Hunt"]         = { Primary = Color3.fromRGB(0,   80,  220), Secondary = Color3.new(0,0,0) },
    ["Rock Splitting Fist"]    = { Primary = Color3.fromRGB(0,   80,  220), Secondary = Color3.new(0,0,0) },
    ["Crushed Rock"]           = { Primary = Color3.fromRGB(0,   80,  220), Secondary = Color3.new(0,0,0) },

    -- ── Hero Hunter: Monster Form ────────────────────────────
    ["Doom Dive"]              = { Primary = Color3.fromRGB(139, 0,   0),   Secondary = Color3.new(0,0,0) },
    ["Crowd Buster"]           = { Primary = Color3.fromRGB(139, 0,   0),   Secondary = Color3.new(0,0,0) },
    ["Hammer Heel"]            = { Primary = Color3.fromRGB(139, 0,   0),   Secondary = Color3.new(0,0,0) },
    ["Binding Cloth"]          = { Primary = Color3.fromRGB(139, 0,   0),   Secondary = Color3.new(0,0,0) },
    ["Hunter's Mark"]          = { Primary = Color3.fromRGB(139, 0,   0),   Secondary = Color3.new(0,0,0) },
    ["Great Fajin"]            = { Primary = Color3.fromRGB(139, 0,   0),   Secondary = Color3.new(0,0,0) },
    ["God Slayer"]             = { Primary = Color3.fromRGB(139, 0,   0),   Secondary = Color3.new(0,0,0) },
    ["Sky Ripping Fist"]       = { Primary = Color3.fromRGB(139, 0,   0),   Secondary = Color3.new(0,0,0) },

    -- ── Hero Hunter: Cosmic Form ─────────────────────────────
    ["Nuclear Fission"]        = { Primary = Color3.fromRGB(120, 0,   180), Secondary = Color3.new(0,0,0) },
    ["Singularity"]            = { Primary = Color3.fromRGB(120, 0,   180), Secondary = Color3.new(0,0,0) },
    -- Great Fajin and Sky Ripping Fist overlap with Monster Form;
    -- BackpackWatcher resolves identity before move-level lookup —
    -- Cosmic Form's kit takes precedence when that identity is active.

    -- ── Destructive Cyborg ───────────────────────────────────
    ["Machine Gun Blows"]      = { Primary = Color3.fromRGB(255, 100, 0),   Secondary = Color3.new(0,0,0) },
    ["Ignition Burst"]         = { Primary = Color3.fromRGB(255, 100, 0),   Secondary = Color3.new(0,0,0) },
    ["Blitz Shot"]             = { Primary = Color3.fromRGB(255, 100, 0),   Secondary = Color3.new(0,0,0) },
    ["Jet Dive"]               = { Primary = Color3.fromRGB(255, 100, 0),   Secondary = Color3.new(0,0,0) },
    ["Thunder Kick"]           = { Primary = Color3.fromRGB(255, 100, 0),   Secondary = Color3.new(0,0,0) },
    ["Speedblitz Dropkick"]    = { Primary = Color3.fromRGB(255, 100, 0),   Secondary = Color3.new(0,0,0) },
    ["Flamewave Cannon"]       = { Primary = Color3.fromRGB(255, 100, 0),   Secondary = Color3.new(0,0,0) },
    ["Incinerate"]             = { Primary = Color3.fromRGB(255, 100, 0),   Secondary = Color3.new(0,0,0) },

    -- ── Deadly Ninja ─────────────────────────────────────────
    ["Flash Strike"]           = { Primary = Color3.fromRGB(60,  0,   90),  Secondary = Color3.new(0,0,0) },
    ["Whirlwind Kick"]         = { Primary = Color3.fromRGB(60,  0,   90),  Secondary = Color3.new(0,0,0) },
    ["Scatter"]                = { Primary = Color3.fromRGB(60,  0,   90),  Secondary = Color3.new(0,0,0) },
    ["Explosive Shuriken"]     = { Primary = Color3.fromRGB(60,  0,   90),  Secondary = Color3.new(0,0,0) },
    ["Twinblade Rush"]         = { Primary = Color3.fromRGB(60,  0,   90),  Secondary = Color3.new(0,0,0) },
    ["Straight On"]            = { Primary = Color3.fromRGB(60,  0,   90),  Secondary = Color3.new(0,0,0) },
    ["Carnage"]                = { Primary = Color3.fromRGB(60,  0,   90),  Secondary = Color3.new(0,0,0) },
    ["Fourfold Flashstrike"]   = { Primary = Color3.fromRGB(60,  0,   90),  Secondary = Color3.new(0,0,0) },

    -- ── Brutal Demon ─────────────────────────────────────────
    ["Homerun"]                = { Primary = Color3.fromRGB(160, 160, 160), Secondary = Color3.new(0,0,0) },
    ["Beatdown"]               = { Primary = Color3.fromRGB(160, 160, 160), Secondary = Color3.new(0,0,0) },
    ["Grand Slam"]             = { Primary = Color3.fromRGB(160, 160, 160), Secondary = Color3.new(0,0,0) },
    ["Foul Ball"]              = { Primary = Color3.fromRGB(160, 160, 160), Secondary = Color3.new(0,0,0) },
    ["Savage Tornado"]         = { Primary = Color3.fromRGB(160, 160, 160), Secondary = Color3.new(0,0,0) },
    ["Brutal Beatdown"]        = { Primary = Color3.fromRGB(160, 160, 160), Secondary = Color3.new(0,0,0) },
    ["Strength Difference"]    = { Primary = Color3.fromRGB(160, 160, 160), Secondary = Color3.new(0,0,0) },
    ["Death Blow"]             = { Primary = Color3.fromRGB(160, 160, 160), Secondary = Color3.new(0,0,0) },

    -- ── Blade Master ─────────────────────────────────────────
    ["Quick Slice"]            = { Primary = Color3.fromRGB(210, 80,  0),   Secondary = Color3.new(0,0,0) },
    ["Atmos Cleave"]           = { Primary = Color3.fromRGB(210, 80,  0),   Secondary = Color3.new(0,0,0) },
    ["Pinpoint Cut"]           = { Primary = Color3.fromRGB(210, 80,  0),   Secondary = Color3.new(0,0,0) },
    ["Split Second Counter"]   = { Primary = Color3.fromRGB(210, 80,  0),   Secondary = Color3.new(0,0,0) },
    ["Sunset"]                 = { Primary = Color3.fromRGB(210, 80,  0),   Secondary = Color3.new(0,0,0) },
    ["Solar Cleave"]           = { Primary = Color3.fromRGB(210, 80,  0),   Secondary = Color3.new(0,0,0) },
    ["Sunrise"]                = { Primary = Color3.fromRGB(210, 80,  0),   Secondary = Color3.new(0,0,0) },
    ["Atomic Slash"]           = { Primary = Color3.fromRGB(210, 80,  0),   Secondary = Color3.new(0,0,0) },

    -- ── Wild Psychic ─────────────────────────────────────────
    ["Crushing Pull"]          = { Primary = Color3.fromRGB(0,   160, 30),  Secondary = Color3.new(0,0,0) },
    ["Windstorm Fury"]         = { Primary = Color3.fromRGB(0,   160, 30),  Secondary = Color3.new(0,0,0) },
    ["Stone Coffin"]           = { Primary = Color3.fromRGB(0,   160, 30),  Secondary = Color3.new(0,0,0) },
    ["Expulsive Push"]         = { Primary = Color3.fromRGB(0,   160, 30),  Secondary = Color3.new(0,0,0) },
    ["Cosmic Strike"]          = { Primary = Color3.fromRGB(0,   160, 30),  Secondary = Color3.new(0,0,0) },
    ["Psychic Ricochet"]       = { Primary = Color3.fromRGB(0,   160, 30),  Secondary = Color3.new(0,0,0) },
    ["Terrible Tornado"]       = { Primary = Color3.fromRGB(0,   160, 30),  Secondary = Color3.new(0,0,0) },
    ["Sky Snatcher"]           = { Primary = Color3.fromRGB(0,   160, 30),  Secondary = Color3.new(0,0,0) },

    -- ── Martial Artist ───────────────────────────────────────
    ["Bullet Barrage"]         = { Primary = Color3.fromRGB(100, 0,   160), Secondary = Color3.new(0,0,0) },
    ["Vanishing Kick"]         = { Primary = Color3.fromRGB(100, 0,   160), Secondary = Color3.new(0,0,0) },
    ["Whirlwind Drop"]         = { Primary = Color3.fromRGB(100, 0,   160), Secondary = Color3.new(0,0,0) },
    ["Head First"]             = { Primary = Color3.fromRGB(100, 0,   160), Secondary = Color3.new(0,0,0) },
    ["Grand Fissure"]          = { Primary = Color3.fromRGB(100, 0,   160), Secondary = Color3.new(0,0,0) },
    ["Twin Fangs"]             = { Primary = Color3.fromRGB(100, 0,   160), Secondary = Color3.new(0,0,0) },
    ["Earth Splitting Strike"] = { Primary = Color3.fromRGB(100, 0,   160), Secondary = Color3.new(0,0,0) },
    ["Last Breath"]            = { Primary = Color3.fromRGB(100, 0,   160), Secondary = Color3.new(0,0,0) },

    -- ── Tech Prodigy ─────────────────────────────────────────
    ["Weboom"]                 = { Primary = Color3.fromRGB(100, 180, 255), Secondary = Color3.new(0,0,0) },
    ["Plasma Cannon"]          = { Primary = Color3.fromRGB(100, 180, 255), Secondary = Color3.new(0,0,0) },
    ["Trinity Tear"]           = { Primary = Color3.fromRGB(100, 180, 255), Secondary = Color3.new(0,0,0) },
    ["Twin Burst"]             = { Primary = Color3.fromRGB(100, 180, 255), Secondary = Color3.new(0,0,0) },
    ["Photon Edge"]            = { Primary = Color3.fromRGB(100, 180, 255), Secondary = Color3.new(0,0,0) },
    ["Photon Dive"]            = { Primary = Color3.fromRGB(100, 180, 255), Secondary = Color3.new(0,0,0) },
    ["Conquest"]               = { Primary = Color3.fromRGB(100, 180, 255), Secondary = Color3.new(0,0,0) },
    ["Missiles"]               = { Primary = Color3.fromRGB(100, 180, 255), Secondary = Color3.new(0,0,0) },

    -- ── Undying Hero ─────────────────────────────────────────
    ["Grave Maker"]            = { Primary = Color3.fromRGB(0,   120, 40),  Secondary = Color3.new(0,0,0) },
    ["Blast Breaker"]          = { Primary = Color3.fromRGB(0,   120, 40),  Secondary = Color3.new(0,0,0) },
    ["Point Blank"]            = { Primary = Color3.fromRGB(0,   120, 40),  Secondary = Color3.new(0,0,0) },
    ["Cross Fire"]             = { Primary = Color3.fromRGB(0,   120, 40),  Secondary = Color3.new(0,0,0) },

    -- ── KJ ───────────────────────────────────────────────────
    ["Ravage"]                 = { Primary = Color3.fromRGB(160, 0,   0),   Secondary = Color3.new(0,0,0) },
    ["Swift Sweep"]            = { Primary = Color3.fromRGB(160, 0,   0),   Secondary = Color3.new(0,0,0) },
    ["Collateral Ruin"]        = { Primary = Color3.fromRGB(160, 0,   0),   Secondary = Color3.new(0,0,0) },
    ["Spiraling Storm"]        = { Primary = Color3.fromRGB(160, 0,   0),   Secondary = Color3.new(0,0,0) },
    ["Stoic Bomb"]             = { Primary = Color3.fromRGB(160, 0,   0),   Secondary = Color3.new(0,0,0) },
    ["20-20-20 Dropkick"]      = { Primary = Color3.fromRGB(160, 0,   0),   Secondary = Color3.new(0,0,0) },
    ["Five Seasons"]           = { Primary = Color3.fromRGB(160, 0,   0),   Secondary = Color3.new(0,0,0) },
    ["Unlimited Flex Works"]   = { Primary = Color3.fromRGB(160, 0,   0),   Secondary = Color3.new(0,0,0) },

    -- ── Sorcerer ─────────────────────────────────────────────
    ["Infinity"]               = { Primary = Color3.fromRGB(0,   140, 255), Secondary = Color3.new(0,0,0) },
    ["Repulse"]                = { Primary = Color3.fromRGB(0,   140, 255), Secondary = Color3.new(0,0,0) },
    ["Erase"]                  = { Primary = Color3.fromRGB(0,   140, 255), Secondary = Color3.new(0,0,0) },
    ["Attract"]                = { Primary = Color3.fromRGB(0,   140, 255), Secondary = Color3.new(0,0,0) },
}

-- ═══════════════════════════════════════════════════════════════
--  CHARACTER IDENTITY MAP
--  Maps a canonical character name to the set of move names that
--  definitively identify that character when the backpack is uniform.
--  BackpackWatcher.lua uses this to resolve identity before falling
--  back to per-move color lookup.
--  Key = character key matching Config.CursedEnergyColors
--  Value = table of move name subsets; ALL moves in one subset must
--          be present in the backpack for the identity to match.
-- ═══════════════════════════════════════════════════════════════
Config.CharacterMoves = {
    Saitama = {
        Base     = { "Normal Punch", "Consecutive Punches", "Shove", "Uppercut" },
        Ultimate = { "Death Counter", "Table Flip", "Serious Punch", "Omni Directional Punch" },
    },
    HeroHunter = {
        Base     = { "Flowing Water", "Lethal Whirlwind Stream", "Hunter's Grasp", "Prey's Peril" },
        Ultimate = { "Water Stream Cutting Fist", "The Final Hunt", "Rock Splitting Fist", "Crushed Rock" },
    },
    HeroHunterMonst = {
        Base     = { "Doom Dive", "Crowd Buster", "Hammer Heel", "Binding Cloth" },
        Ultimate = { "Hunter's Mark", "Great Fajin", "God Slayer", "Sky Ripping Fist" },
    },
    HeroHunterCosmic = {
        -- Cosmic Form shares Great Fajin + Sky Ripping Fist with Monster Form;
        -- Nuclear Fission + Singularity are the unambiguous discriminators.
        Base     = { "Nuclear Fission", "Singularity", "Great Fajin", "Sky Ripping Fist" },
        Ultimate = {},
    },
    DestructiveCyborg = {
        Base     = { "Machine Gun Blows", "Ignition Burst", "Blitz Shot", "Jet Dive" },
        Ultimate = { "Thunder Kick", "Speedblitz Dropkick", "Flamewave Cannon", "Incinerate" },
    },
    DeadlyNinja = {
        Base     = { "Flash Strike", "Whirlwind Kick", "Scatter", "Explosive Shuriken" },
        Ultimate = { "Twinblade Rush", "Straight On", "Carnage", "Fourfold Flashstrike" },
    },
    BrutalDemon = {
        Base     = { "Homerun", "Beatdown", "Grand Slam", "Foul Ball" },
        Ultimate = { "Savage Tornado", "Brutal Beatdown", "Strength Difference", "Death Blow" },
    },
    BladeMaster = {
        Base     = { "Quick Slice", "Atmos Cleave", "Pinpoint Cut", "Split Second Counter" },
        Ultimate = { "Sunset", "Solar Cleave", "Sunrise", "Atomic Slash" },
    },
    WildPsychic = {
        Base     = { "Crushing Pull", "Windstorm Fury", "Stone Coffin", "Expulsive Push" },
        Ultimate = { "Cosmic Strike", "Psychic Ricochet", "Terrible Tornado", "Sky Snatcher" },
    },
    MartialArtist = {
        Base     = { "Bullet Barrage", "Vanishing Kick", "Whirlwind Drop", "Head First" },
        Ultimate = { "Grand Fissure", "Twin Fangs", "Earth Splitting Strike", "Last Breath" },
    },
    TechProdigy = {
        Base     = { "Weboom", "Plasma Cannon", "Trinity Tear", "Twin Burst" },
        Ultimate = { "Photon Edge", "Photon Dive", "Conquest", "Missiles" },
    },
    UndyingHero = {
        Base     = { "Grave Maker", "Blast Breaker", "Point Blank", "Cross Fire" },
        Ultimate = {},   -- in progress; extend when data is available
    },
    KJ = {
        Base     = { "Ravage", "Swift Sweep", "Collateral Ruin", "Spiraling Storm" },
        Ultimate = { "Stoic Bomb", "20-20-20 Dropkick", "Five Seasons", "Unlimited Flex Works" },
    },
    Sorcerer = {
        Base     = { "Infinity", "Repulse", "Erase", "Attract" },
        Ultimate = {},
    },
}

-- ═══════════════════════════════════════════════════════════════
--  NARRATOR / MUSIC FADE FIX CONSTANTS
--  Referenced by Audio.lua when it replaces the inline audio logic
--  from the main script.  Documents the exact fix applied.
--
--  Root cause: narratorEnded callback fires after cleanupHumanoid
--  has already Destroyed the music Sound instance, so the TweenService
--  call targets a nil Parent.  The guard below must be applied
--  inside the Ended handler before any tween is created.
--
--  Required guard (pseudo):
--    narrator.Ended:Once(function()
--        if humanoid.Health <= 0 then return end
--        local music = activeKokusenSounds[1]
--        if not music or not music.Parent then return end
--        TweenService:Create(music, ..., { Volume = Config.Effects.MusicVolume }):Play()
--    end)
-- ═══════════════════════════════════════════════════════════════
Config.AudioFix = {
    -- The health guard and Parent check are the two required conditions.
    -- Audio.lua enforces both; this block documents intent for reviewers.
    NarratorEndedGuards = { "humanoid.Health > 0", "music.Parent ~= nil" },
}

-- ═══════════════════════════════════════════════════════════════
--  HELPER FUNCTIONS
-- ═══════════════════════════════════════════════════════════════

--- Returns the raw GitHub URL for a module file.
--- @param moduleName string  e.g. "Audio" → ".../Modules/Audio.lua"
function Config:GetModuleURL(moduleName)
    return self.GitHub.Modules .. moduleName .. ".lua"
end

--- Returns the raw GitHub URL for an asset.
--- @param folder string  e.g. "Sounds"
--- @param asset  string  e.g. "Narrator.mp3"
function Config:GetAssetURL(folder, asset)
    return self.GitHub.AssetBase .. folder .. "/" .. asset
end

--- Returns the local executor-side path for an asset.
--- @param folder string  e.g. "Sounds"
--- @param asset  string  e.g. "Narrator.mp3"
--- @return string  e.g. "Impact+/Sounds/Narrator.mp3"
function Config:GetAssetPath(folder, asset)
    return self.Paths.Root .. "/" .. folder .. "/" .. asset
end

--- Returns a TweenInfo built from a named preset.
--- Falls back to "Normal" if the preset name is not found.
--- @param presetName string  "Fast" | "Normal" | "Slow" | "Elastic"
--- @return TweenInfo
function Config:MakeTween(presetName)
    local preset = self.Tweens[presetName] or self.Tweens.Normal
    return TweenInfo.new(table.unpack(preset))
end

--- Returns the cursed energy color pair for a given move name.
--- Falls back to nil when the move is not registered.
--- @param moveName string
--- @return { Primary: Color3, Secondary: Color3 } | nil
function Config:GetMoveColor(moveName)
    return self.MoveColors[moveName]
end

--- Returns the character-level color pair for a given character key.
--- @param characterKey string  e.g. "Saitama", "HeroHunter"
--- @return { Primary: Color3, Secondary: Color3 } | nil
function Config:GetCharacterColor(characterKey)
    return self.CursedEnergyColors[characterKey]
end

return Config
