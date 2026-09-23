--==============================================================--
-- Impact+
-- Finishers.lua
--
-- Version: 1.0.0
--
-- Changelog:
-- 1.0.0 - Client-side finisher visuals
--==============================================================--
local Finishers={}
local TweenService=game:GetService("TweenService")
function Finishers:Init(Config, Audio, ScreenEffects, Shockwave)
    self.Config=Config; self.Audio=Audio; self.ScreenEffects=ScreenEffects; self.Shockwave=Shockwave
end
function Finishers:Play(character)
    if not self.Config.Settings.Visuals.FinisherEffects then return end
    local root=character and character:FindFirstChild("HumanoidRootPart")
    if not root then return end
    self.ScreenEffects:Flash(true); self.ScreenEffects:Distortion(); self.Shockwave:Emit(root.Position,Color3.fromRGB(220,0,0),self.Config.Effects.ShockwaveRadius*1.35,self.Config.Effects.FinisherDuration)
    if self.Audio then self.Audio:Finisher() end
    local hl=Instance.new("Highlight"); hl.FillColor=Color3.fromRGB(100,0,0); hl.OutlineColor=Color3.new(0,0,0); hl.FillTransparency=0.25; hl.OutlineTransparency=0; hl.DepthMode=Enum.HighlightDepthMode.Occluded; hl.Parent=character
    TweenService:Create(hl,TweenInfo.new(self.Config.Effects.FinisherDuration),{FillTransparency=1,OutlineTransparency=1}):Play()
    task.delay(self.Config.Effects.FinisherDuration,function() if hl.Parent then hl:Destroy() end end)
end
return Finishers
