local Chromatic={}
local TweenService=game:GetService("TweenService")
local Lighting=game:GetService("Lighting")
function Chromatic:Init(Config)
    self.Config=Config; self.Effect=Lighting:FindFirstChild("ImpactChromatic") or Instance.new("ColorCorrectionEffect"); self.Effect.Name="ImpactChromatic"; self.Effect.Parent=Lighting; self.Effect.Contrast=0; self.Effect.TintColor=Color3.new(1,1,1)
end
function Chromatic:Pulse(strength,duration)
    if not self.Config.Settings.Camera.ChromaticEnabled then return end
    local e=self.Effect; e.TintColor=Color3.fromRGB(255,220,220); e.Contrast=(strength or self.Config.Effects.ChromaticStrength)*2
    TweenService:Create(e,TweenInfo.new(duration or .18,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),{Contrast=0,TintColor=Color3.new(1,1,1)}):Play()
end
function Chromatic:Cleanup() if self.Effect then pcall(function() self.Effect:Destroy() end); self.Effect=nil end end
return Chromatic
