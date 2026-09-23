--==============================================================--
-- Impact+
-- UI.lua
--
-- Version: 1.0.0
--
-- Changelog:
-- 1.0.0 - Draggable animated settings panel
--==============================================================--
local UI={}
local Players=game:GetService("Players")
local TweenService=game:GetService("TweenService")
local CoreGui=game:GetService("CoreGui")
local UserInputService=game:GetService("UserInputService")

local function corner(obj,r) local c=Instance.new("UICorner"); c.CornerRadius=UDim.new(0,r); c.Parent=obj end
local function stroke(obj,color) local s=Instance.new("UIStroke"); s.Color=color; s.Transparency=0.35; s.Thickness=1; s.Parent=obj end

function UI:Init(Config,Settings)
    self.Config=Config; self.Settings=Settings
    if not Config.Features.SettingsMenu then return end
    self.Gui=Instance.new("ScreenGui"); self.Gui.Name="ImpactSettingsUI"; self.Gui.IgnoreGuiInset=true; self.Gui.ResetOnSpawn=false; self.Gui.Parent=CoreGui
    self:_build()
end
function UI:_button(parent,text,y)
    local b=Instance.new("TextButton"); b.Size=UDim2.new(1,-32,0,36); b.Position=UDim2.new(0,16,0,y); b.BackgroundColor3=self.Config.Theme.Secondary; b.TextColor3=self.Config.Theme.Text; b.Font=Enum.Font.GothamMedium; b.TextSize=13; b.Text=text; b.AutoButtonColor=false; b.Parent=parent; corner(b,10); stroke(b,self.Config.Theme.Border)
    b.MouseEnter:Connect(function() TweenService:Create(b,self.Config.Tween.Fast,{BackgroundColor3=self.Config.Theme.Primary}):Play() end)
    b.MouseLeave:Connect(function() TweenService:Create(b,self.Config.Tween.Fast,{BackgroundColor3=self.Config.Theme.Secondary}):Play() end)
    return b
end
function UI:_toggle(parent,label,y,path)
    local b=self:_button(parent,label,y)
    local function refresh() b.Text=label.."  ["..(self.Settings:Get(path) and "ON" or "OFF").."]" end
    refresh(); b.Activated:Connect(function() self.Settings:Set(path,not self.Settings:Get(path)); refresh() end)
end
function UI:_slider(parent,label,y,path,min,max)
    local holder=Instance.new("Frame"); holder.Size=UDim2.new(1,-32,0,48); holder.Position=UDim2.new(0,16,0,y); holder.BackgroundTransparency=1; holder.Parent=parent
    local text=Instance.new("TextLabel"); text.Size=UDim2.new(1,0,0,20); text.BackgroundTransparency=1; text.TextColor3=self.Config.Theme.Text; text.Font=Enum.Font.Gotham; text.TextSize=12; text.TextXAlignment=Enum.TextXAlignment.Left; text.Parent=holder
    local bar=Instance.new("Frame"); bar.Position=UDim2.new(0,0,0,27); bar.Size=UDim2.new(1,0,0,8); bar.BackgroundColor3=Color3.fromRGB(30,30,34); bar.Parent=holder; corner(bar,8)
    local fill=Instance.new("Frame"); fill.Size=UDim2.new(0,0,1,0); fill.BackgroundColor3=self.Config.Theme.Accent; fill.Parent=bar; corner(fill,8)
    local function set(x)
        local ratio=math.clamp((x-bar.AbsolutePosition.X)/bar.AbsoluteSize.X,0,1); local value=min+(max-min)*ratio; self.Settings:Set(path,value); fill.Size=UDim2.new(ratio,0,1,0); text.Text=label.."  "..string.format("%.1f",value)
    end
    local function refresh() local value=self.Settings:Get(path,min); local ratio=(value-min)/(max-min); fill.Size=UDim2.new(math.clamp(ratio,0,1),0,1,0); text.Text=label.."  "..string.format("%.1f",value) end
    refresh(); bar.InputBegan:Connect(function(i) if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then set(i.Position.X) end end); UserInputService.InputChanged:Connect(function(i) if (i.UserInputType==Enum.UserInputType.MouseMovement or i.UserInputType==Enum.UserInputType.Touch) and self.DragSlider==bar then set(i.Position.X) end end); bar.InputBegan:Connect(function(i) if i.UserInputType==Enum.UserInputType.MouseButton1 then self.DragSlider=bar end end); UserInputService.InputEnded:Connect(function(i) if i.UserInputType==Enum.UserInputType.MouseButton1 and self.DragSlider==bar then self.DragSlider=nil end end)
end
function UI:ToggleSettingsMenu() if self._toggle then self._toggle() end end
function UI:_build()
    local open=Instance.new("ImageButton"); open.Name="SettingsButton"; open.Size=UDim2.fromOffset(48,48); open.Position=UDim2.new(1,-64,0,18); open.BackgroundColor3=self.Config.Theme.Background; open.Image=""; open.Parent=self.Gui; corner(open,14); stroke(open,self.Config.Theme.Border)
    local imagePath=self.Config.Paths.Root.."/Images/"..self.Config.Assets.Images.SettingsButton
    if type(getcustomasset)=="function" and type(isfile)=="function" and isfile(imagePath) then local ok,id=pcall(getcustomasset,imagePath); if ok then open.Image=id end end
    local panel=Instance.new("Frame"); panel.Name="SettingsPanel"; panel.Size=UDim2.fromOffset(360,520); panel.Position=UDim2.new(1,20,0.5,-260); panel.BackgroundColor3=self.Config.Theme.Background; panel.Parent=self.Gui; corner(panel,18); stroke(panel,self.Config.Theme.Border)
    local gradient=Instance.new("UIGradient"); gradient.Color=ColorSequence.new({ColorSequenceKeypoint.new(0,self.Config.Theme.Primary),ColorSequenceKeypoint.new(0.35,self.Config.Theme.Secondary),ColorSequenceKeypoint.new(1,self.Config.Theme.Background)}); gradient.Rotation=25; gradient.Parent=panel
    task.spawn(function() while panel.Parent do gradient.Rotation=(gradient.Rotation+0.15)%360; task.wait(0.03) end end)
    local title=Instance.new("TextLabel"); title.Size=UDim2.new(1,-32,0,45); title.Position=UDim2.new(0,16,0,10); title.BackgroundTransparency=1; title.Text="IMPACT+  /  SETTINGS"; title.TextColor3=self.Config.Theme.Text; title.Font=Enum.Font.GothamBold; title.TextSize=18; title.TextXAlignment=Enum.TextXAlignment.Left; title.Parent=panel
    local scroll=Instance.new("ScrollingFrame"); scroll.Size=UDim2.new(1,0,1,-65); scroll.Position=UDim2.new(0,0,0,60); scroll.BackgroundTransparency=1; scroll.BorderSizePixel=0; scroll.ScrollBarThickness=3; scroll.CanvasSize=UDim2.fromOffset(0,650); scroll.Parent=panel
    self:_toggle(scroll,"Music",0,"Audio.MusicEnabled"); self:_toggle(scroll,"Narrator",44,"Audio.NarratorEnabled"); self:_toggle(scroll,"Camera Shake",88,"Camera.ShakeEnabled"); self:_toggle(scroll,"Motion Blur",132,"Camera.MotionBlurEnabled"); self:_toggle(scroll,"Chromatic",176,"Camera.ChromaticEnabled"); self:_toggle(scroll,"Shockwaves",220,"Visuals.Shockwaves"); self:_slider(scroll,"Music Volume",270,"Audio.MusicVolume",0,10); self:_slider(scroll,"Narrator Volume",322,"Audio.NarratorVolume",0,10); self:_slider(scroll,"SFX Volume",374,"Audio.SFXVolume",0,10); self:_slider(scroll,"Hit Distance",426,"Gameplay.HitDistance",5,60)
    local openPos=UDim2.new(1,-380,0.5,-260); local closedPos=UDim2.new(1,20,0.5,-260); local visible=false
    local function toggle() visible=not visible; TweenService:Create(panel,self.Config.Tween.Elastic,{Position=visible and openPos or closedPos}):Play() end
    self._toggle=toggle
    open.Activated:Connect(toggle)
    local dragging=false; local dragStart; local startPos
    panel.InputBegan:Connect(function(input) if input.UserInputType==Enum.UserInputType.MouseButton1 then dragging=true; dragStart=input.Position; startPos=panel.Position end end)
    UserInputService.InputChanged:Connect(function(input) if dragging and input.UserInputType==Enum.UserInputType.MouseMovement then local delta=input.Position-dragStart; panel.Position=UDim2.new(startPos.X.Scale,startPos.X.Offset+delta.X,startPos.Y.Scale,startPos.Y.Offset+delta.Y) end end)
    UserInputService.InputEnded:Connect(function(input) if input.UserInputType==Enum.UserInputType.MouseButton1 then dragging=false end end)
end

function UI:Cleanup() if self.Gui then self.Gui:Destroy(); self.Gui=nil end; self._toggle=nil end
return UI
