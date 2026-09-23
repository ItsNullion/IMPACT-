--==============================================================--
-- Impact+
-- Audio.lua
--
-- Version: 1.0.0
--
-- Changelog:
-- 1.0.0 - Centralized audio and volume controls
--==============================================================--
local Audio = {}
local TweenService = game:GetService("TweenService")
local CoreGui = game:GetService("CoreGui")

function Audio:Init(Config)
    self.Config = Config
    self.Active = {}
    self.Folder = Config.Paths.Root
end

function Audio:_asset(path)
    if type(getcustomasset) ~= "function" or type(isfile) ~= "function" then return nil end
    if not isfile(path) then return nil end
    local ok, result = pcall(getcustomasset, path)
    return ok and result or nil
end

function Audio:PlayAsset(name, volume, looped)
    local path = self.Folder .. "/Sounds/" .. name
    local asset = self:_asset(path)
    if not asset then return nil end
    local sound = Instance.new("Sound")
    sound.Name = "ImpactAudio_" .. name:gsub("%W", "")
    sound.SoundId = asset
    sound.Volume = volume or self.Config.Settings.Audio.SFXVolume
    sound.Looped = looped == true
    sound.Parent = CoreGui
    sound:Play()
    if not sound.Looped then sound.Ended:Once(function() sound:Destroy() end) end
    table.insert(self.Active, sound)
    return sound
end

function Audio:PlayId(assetId, volume)
    local sound = Instance.new("Sound")
    sound.SoundId = assetId
    sound.Volume = volume or self.Config.Settings.Audio.SFXVolume
    sound.Parent = CoreGui
    sound:Play()
    sound.Ended:Once(function() sound:Destroy() end)
    return sound
end

function Audio:PlayMusic()
    if not self.Config.Settings.Audio.MusicEnabled then return nil end
    if self.Music and self.Music.Parent then return self.Music end
    local path = self.Folder .. "/Music/" .. self.Config.Assets.Music.Kokusen
    local asset = self:_asset(path)
    if not asset then return nil end
    local music = Instance.new("Sound")
    music.Name = "ImpactKokusenMusic"
    music.SoundId = asset
    music.Volume = self.Config.Settings.Audio.MusicVolume
    music.Looped = true
    music.Parent = CoreGui
    music:Play()
    self.Music = music
    return music
end

function Audio:DuckMusic(target, duration)
    if not self.Music then return end
    TweenService:Create(self.Music, TweenInfo.new(duration or 0.25), {Volume = target}):Play()
end

function Audio:StopMusic()
    if self.Music then self.Music:Stop(); self.Music:Destroy(); self.Music=nil end
end

function Audio:PlayCritical()
    self:PlayId(self.Config.AssetIds.Critical, self.Config.Settings.Audio.SFXVolume)
end

function Audio:PlayNormal()
    self:PlayId(self.Config.AssetIds.Normal, self.Config.Settings.Audio.SFXVolume)
end

function Audio:PlayEquip()
    self:PlayId(self.Config.AssetIds.EquipWhoosh, self.Config.Settings.Audio.SFXVolume)
end

function Audio:PlayNarrator()
    if not self.Config.Settings.Audio.NarratorEnabled then return end
    local path = self.Folder .. "/Sounds/" .. self.Config.Assets.Sounds.Narrator
    local asset = self:_asset(path)
    if not asset then return end
    local narrator = Instance.new("Sound")
    narrator.Name = "ImpactNarrator"
    narrator.SoundId = asset
    narrator.Volume = self.Config.Settings.Audio.NarratorVolume
    narrator.Parent = CoreGui
    self:DuckMusic(0.35, 0.25)
    narrator:Play()
    narrator.Ended:Once(function()
        self:DuckMusic(self.Config.Settings.Audio.MusicVolume, 0.5)
        narrator:Destroy()
    end)
    return narrator
end

function Audio:Finisher()
    local sound = self:PlayAsset(self.Config.Assets.Sounds.Finisher, self.Config.Settings.Audio.SFXVolume)
    return sound
end

function Audio:Cleanup()
    self:StopMusic()
    for _, sound in ipairs(self.Active or {}) do if sound and sound.Parent then sound:Destroy() end end
    self.Active = {}
end

return Audio
