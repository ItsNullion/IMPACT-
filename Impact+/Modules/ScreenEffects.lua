--==============================================================--
-- Impact+
-- ScreenEffects.lua
--
-- Version: 1.0.0
--
-- Changelog:
-- 1.0.0 - Black/red impact distortion and flash frames
--==============================================================--
local ScreenEffects = {}
local TweenService = game:GetService("TweenService")
local CoreGui = game:GetService("CoreGui")

function ScreenEffects:Init(Config)
    self.Config=Config
    self.Gui=Instance.new("ScreenGui")
    self.Gui.Name="ImpactScreenEffects"
    self.Gui.IgnoreGuiInset=true
    self.Gui.ResetOnSpawn=false
    self.Gui.ZIndexBehavior=Enum.ZIndexBehavior.Sibling
    self.Gui.Parent=CoreGui
end

function ScreenEffects:Flash(critical)
    if not self.Config.Settings.Visuals.ScreenFlashes then return end
    local frame=Instance.new("Frame")
    frame.Size=UDim2.fromScale(1,1); frame.BackgroundColor3=critical and Color3.fromRGB(110,0,0) or Color3.new(0,0,0); frame.BackgroundTransparency=0; frame.BorderSizePixel=0; frame.ZIndex=100
    frame.Parent=self.Gui
    TweenService:Create(frame,TweenInfo.new(critical and 0.45 or 0.16,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),{BackgroundTransparency=1}):Play()
    task.delay(critical and 0.5 or 0.2,function() if frame.Parent then frame:Destroy() end end)
end

function ScreenEffects:Distortion()
    if not self.Config.Settings.Visuals.Distortion then return end
    local frame=Instance.new("Frame")
    frame.Size=UDim2.fromScale(1,1); frame.BackgroundTransparency=1; frame.BorderSizePixel=0; frame.ZIndex=99; frame.Parent=self.Gui
    local lines=Instance.new("Frame"); lines.Size=UDim2.fromScale(1,1); lines.BackgroundTransparency=1; lines.Parent=frame
    for i=1,8 do
        local line=Instance.new("Frame"); line.BorderSizePixel=0; line.BackgroundColor3=(i%2==0) and Color3.fromRGB(255,0,0) or Color3.new(0,0,0); line.BackgroundTransparency=0.82; line.Size=UDim2.new(1,0,0,math.random(1,4)); line.Position=UDim2.new(0,0,math.random(),0); line.Parent=lines
    end
    task.delay(0.12,function() if frame.Parent then frame:Destroy() end end)
end

function ScreenEffects:Cleanup() if self.Gui then self.Gui:Destroy(); self.Gui=nil end end
return ScreenEffects
