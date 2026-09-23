--==============================================================--
-- Impact+
-- MotionBlur.lua
--
-- Version: 1.0.0
--
-- Changelog:
-- 1.0.0 - Dynamic BlurEffect support
--==============================================================--
local MotionBlur={}
local TweenService=game:GetService("TweenService")
local Lighting=game:GetService("Lighting")
function MotionBlur:Init(Config)
    self.Config=Config
    self.Effect=Lighting:FindFirstChild("ImpactMotionBlur") or Instance.new("BlurEffect")
    self.Effect.Name="ImpactMotionBlur"; self.Effect.Size=0; self.Effect.Parent=Lighting
end
function MotionBlur:Pulse(size,duration)
    if not self.Config.Settings.Camera.MotionBlurEnabled then return end
    size=size or self.Config.Effects.BlurSize; duration=duration or 0.22
    TweenService:Create(self.Effect,TweenInfo.new(duration*0.35,Enum.EasingStyle.Quad),{Size=size}):Play()
    task.delay(duration*0.35,function()
        if self.Effect.Parent then TweenService:Create(self.Effect,TweenInfo.new(duration*0.65,Enum.EasingStyle.Quad),{Size=0}):Play() end
    end)
end
return MotionBlur
