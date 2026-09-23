--==============================================================--
-- Impact+
-- Shockwave.lua
--
-- Version: 1.0.0
--
-- Changelog:
-- 1.0.0 - Radial expanding impact ring
--==============================================================--
local Shockwave={}
local TweenService=game:GetService("TweenService")
function Shockwave:Init(Config) self.Config=Config end
function Shockwave:Emit(position, color, radius, duration)
    if not self.Config.Settings.Visuals.Shockwaves then return end
    radius=radius or self.Config.Effects.ShockwaveRadius; duration=duration or self.Config.Effects.ShockwaveDuration
    local part=Instance.new("Part")
    part.Name="ImpactShockwave"; part.Anchored=true; part.CanCollide=false; part.CanTouch=false; part.CanQuery=false; part.Transparency=1; part.Size=Vector3.new(0.2,0.2,0.2); part.CFrame=CFrame.new(position); part.Parent=workspace
    local a=Instance.new("Attachment",part)
    local emitter=Instance.new("ParticleEmitter",a)
    emitter.Texture="rbxasset://textures/particles/sparkles_main.dds"
    emitter.Color=ColorSequence.new(color or Color3.fromRGB(180,0,0), Color3.new(0,0,0))
    emitter.LightEmission=1; emitter.Rate=0; emitter.Speed=NumberRange.new(0); emitter.Lifetime=NumberRange.new(duration); emitter.SpreadAngle=Vector2.new(360,360); emitter.Size=NumberSequence.new({NumberSequenceKeypoint.new(0,0.25),NumberSequenceKeypoint.new(1,0)})
    emitter:Emit(45)
    local mesh=Instance.new("SpecialMesh"); mesh.MeshType=Enum.MeshType.Cylinder; mesh.Scale=Vector3.new(0.05,0.05,0.05); mesh.Parent=part
    TweenService:Create(mesh,TweenInfo.new(duration,Enum.EasingStyle.Quint,Enum.EasingDirection.Out),{Scale=Vector3.new(radius,0.05,radius)}):Play()
    task.delay(duration,function() if part.Parent then part:Destroy() end end)
end
return Shockwave
