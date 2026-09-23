local MotionBlur={}
local TweenService=game:GetService("TweenService")
local Lighting=game:GetService("Lighting")
function MotionBlur:Init(Config)
    self.Config=Config; self.Effect=Lighting:FindFirstChild("ImpactMotionBlur") or Instance.new("BlurEffect"); self.Effect.Name="ImpactMotionBlur"; self.Effect.Size=0; self.Effect.Parent=Lighting
end
function MotionBlur:Pulse(size,duration)
    if not self.Config.Settings.Camera.MotionBlurEnabled then return end
    size=size or self.Config.Effects.BlurSize; duration=duration or .22
    TweenService:Create(self.Effect,TweenInfo.new(duration*.35,Enum.EasingStyle.Quad),{Size=size}):Play(); task.delay(duration*.35,function() if self.Effect and self.Effect.Parent then TweenService:Create(self.Effect,TweenInfo.new(duration*.65,Enum.EasingStyle.Quad),{Size=0}):Play() end end)
end
function MotionBlur:Cleanup() if self.Effect then pcall(function() self.Effect:Destroy() end); self.Effect=nil end end
return MotionBlur
