local Audio={}
local TweenService=game:GetService("TweenService")
local CoreGui=game:GetService("CoreGui")

function Audio:Init(Config)
    self.Config=Config; self.Active={}; self.Music=nil
end
function Audio:_asset(path)
    if type(getcustomasset)~="function" or type(isfile)~="function" or not isfile(path) then return nil end
    local ok,id=pcall(getcustomasset,path); return ok and id or nil
end
function Audio:PlayAsset(name,volume,looped)
    local asset=self:_asset(self.Config.Paths.Root.."/Sounds/"..name); if not asset then return nil end
    local s=Instance.new("Sound"); s.Name="ImpactAudio_"..name:gsub("%W",""); s.SoundId=asset; s.Volume=volume or self.Config.Settings.Audio.SFXVolume; s.Looped=looped==true; s.Parent=CoreGui; s:Play(); table.insert(self.Active,s)
    if not s.Looped then s.Ended:Once(function() if s.Parent then s:Destroy() end end) end
    return s
end
function Audio:PlayId(id,volume)
    if not id then return nil end
    local s=Instance.new("Sound"); s.SoundId=id; s.Volume=volume or self.Config.Settings.Audio.SFXVolume; s.Parent=CoreGui; s:Play(); s.Ended:Once(function() if s.Parent then s:Destroy() end end); table.insert(self.Active,s); return s
end
function Audio:PlayMusic()
    if not self.Config.Settings.Audio.MusicEnabled then return nil end
    if self.Music and self.Music.Parent then return self.Music end
    local asset=self:_asset(self.Config.Paths.Root.."/Music/"..self.Config.Assets.Music.Kokusen); if not asset then return nil end
    local s=Instance.new("Sound"); s.Name="ImpactKokusenMusic"; s.SoundId=asset; s.Volume=self.Config.Settings.Audio.MusicVolume; s.Looped=true; s.Parent=CoreGui; s:Play(); self.Music=s; return s
end
function Audio:DuckMusic(target,duration) if self.Music then TweenService:Create(self.Music,TweenInfo.new(duration or .25),{Volume=target}):Play() end end
function Audio:StopMusic() if self.Music then pcall(function() self.Music:Stop(); self.Music:Destroy() end); self.Music=nil end end
function Audio:PlayCritical() return self:PlayId(self.Config.AssetIds.Critical) end
function Audio:PlayNormal() return self:PlayId(self.Config.AssetIds.Normal) end
function Audio:PlayEquip() return self:PlayId(self.Config.AssetIds.EquipWhoosh) end
function Audio:PlayNarrator()
    if not self.Config.Settings.Audio.NarratorEnabled then return nil end
    local s=self:PlayAsset(self.Config.Assets.Sounds.Narrator,self.Config.Settings.Audio.NarratorVolume)
    if s then self:DuckMusic(.35,.25); s.Ended:Once(function() self:DuckMusic(self.Config.Settings.Audio.MusicVolume,.5) end) end
    return s
end
function Audio:Finisher()
    local localSound=self:PlayAsset(self.Config.Assets.Sounds.Finisher)
    if localSound then return localSound end
    -- The repository does not currently contain Finisher.mp3. Do not fail the
    -- entire script merely because this optional asset is absent.
    return nil
end
function Audio:Cleanup()
    self:StopMusic()
    for _,s in ipairs(self.Active or {}) do pcall(function() if s.Parent then s:Destroy() end end) end
    self.Active={}
end
return Audio
