--==============================================================--
-- Impact+
-- Chromatic.lua
--
-- Version: 1.0.0
--
-- Changelog:
-- 1.0.0 - Red/blue chromatic hit distortion
--==============================================================--
local Chromatic={}
local TweenService=game:GetService("TweenService")
local Lighting=game:GetService("Lighting")
function Chromatic:Init(Config)
    self.Config=Config
    self.Effect=Lighting:FindFirstChild("ImpactChromatic") or Instance.new("ColorCorrectionEffect")
    self.Effect.Name="ImpactChromatic"; self.Effect.Parent=Lighting
end
function Chromatic:Pulse(strength,duration)
    if not self.Config.Settings.Camera.ChromaticEnabled then return end
    strength=strength or self.Config.Effects.ChromaticStrength
    duration=duration or 0.18
    self.Effect.TintColor=Color3.fromRGB(255,220,220)
    self.Effect.Contrast=strength*2
    TweenService:Create(self.Effect,TweenInfo.new(duration,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),{Contrast=0,TintColor=Color3.new(1,1,1)}):Play()
end
return Chromatic
