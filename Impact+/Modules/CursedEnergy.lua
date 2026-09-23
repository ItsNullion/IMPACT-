--==============================================================--
-- Impact+
-- CursedEnergy.lua
--
-- Version: 1.0.0
--
-- Changelog:
-- 1.0.0 - Character/move color system with black secondary color
--==============================================================--
local CE={}
local TweenService=game:GetService("TweenService")
local Players=game:GetService("Players")
function CE:Init(Config,Audio)
    self.Config=Config; self.Audio=Audio; self.Color=Color3.fromRGB(255,35,35); self.MoveColor=nil; self.Effects={}
end
function CE:_sequence(color)
    return ColorSequence.new({ColorSequenceKeypoint.new(0,color),ColorSequenceKeypoint.new(0.52,color),ColorSequenceKeypoint.new(1,Color3.new(0,0,0))})
end
function CE:SetCharacterColor(color) self.Color=color or self.Color; self:_refresh() end
function CE:SetMoveColor(color) self.MoveColor=color; self:_refresh() end
function CE:_refresh()
    local color=self.MoveColor or self.Color
    for _,emitter in ipairs(self.Effects) do if emitter and emitter.Parent then emitter.Color=self:_sequence(color) end end
end
function CE:_attach(part)
    if not part or not part:IsA("BasePart") then return end
    local emitter=part:FindFirstChild("ImpactCursedEnergy")
    if emitter then return end
    emitter=Instance.new("ParticleEmitter"); emitter.Name="ImpactCursedEnergy"; emitter.Texture="rbxasset://textures/particles/sparkles_main.dds"; emitter.Rate=7; emitter.Lifetime=NumberRange.new(0.18,0.35); emitter.Speed=NumberRange.new(0.3,1.5); emitter.SpreadAngle=Vector2.new(35,35); emitter.LightEmission=1; emitter.Size=NumberSequence.new({NumberSequenceKeypoint.new(0,0.18),NumberSequenceKeypoint.new(0.6,0.08),NumberSequenceKeypoint.new(1,0)}); emitter.Color=self:_sequence(self.MoveColor or self.Color); emitter.Parent=part
    table.insert(self.Effects,emitter)
end
function CE:Apply()
    local character=Players.LocalPlayer.Character
    if not character then return end
    for _,name in ipairs({"Right Arm","Left Arm","RightHand","LeftHand","RightLowerArm","LeftLowerArm"}) do self:_attach(character:FindFirstChild(name)) end
end
function CE:EquipPulse()
    if self.Audio then self.Audio:PlayEquip() end
    self:Apply()
end
return CE
