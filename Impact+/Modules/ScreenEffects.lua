local ScreenEffects={}
local TweenService=game:GetService("TweenService")
local CoreGui=game:GetService("CoreGui")
function ScreenEffects:Init(Config)
    self.Config=Config
    local old=CoreGui:FindFirstChild("ImpactScreenEffects"); if old then old:Destroy() end
    self.Gui=Instance.new("ScreenGui"); self.Gui.Name="ImpactScreenEffects"; self.Gui.IgnoreGuiInset=true; self.Gui.ResetOnSpawn=false; self.Gui.ZIndexBehavior=Enum.ZIndexBehavior.Sibling; self.Gui.Parent=CoreGui
end
function ScreenEffects:Flash(critical)
    if not self.Config.Settings.Visuals.ScreenFlashes or not self.Gui then return end
    local frame=Instance.new("Frame"); frame.Size=UDim2.fromScale(1,1); frame.BackgroundColor3=critical and Color3.fromRGB(110,0,0) or Color3.new(0,0,0); frame.BackgroundTransparency=0; frame.BorderSizePixel=0; frame.ZIndex=100; frame.Parent=self.Gui
    TweenService:Create(frame,TweenInfo.new(critical and .45 or .16,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),{BackgroundTransparency=1}):Play(); task.delay(critical and .5 or .2,function() if frame.Parent then frame:Destroy() end end)
end
function ScreenEffects:Distortion()
    if not self.Config.Settings.Visuals.Distortion or not self.Gui then return end
    local frame=Instance.new("Frame"); frame.Size=UDim2.fromScale(1,1); frame.BackgroundTransparency=1; frame.BorderSizePixel=0; frame.ZIndex=99; frame.Parent=self.Gui
    for i=1,8 do local line=Instance.new("Frame"); line.BorderSizePixel=0; line.BackgroundColor3=(i%2==0) and Color3.fromRGB(255,0,0) or Color3.new(0,0,0); line.BackgroundTransparency=.82; line.Size=UDim2.new(1,0,0,math.random(1,4)); line.Position=UDim2.new(0,0,math.random(),0); line.Parent=frame end
    task.delay(.12,function() if frame.Parent then frame:Destroy() end end)
end
function ScreenEffects:Cleanup() if self.Gui then pcall(function() self.Gui:Destroy() end); self.Gui=nil end end
return ScreenEffects
