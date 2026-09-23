local CameraEffects={}
local RunService=game:GetService("RunService")
local RNG=Random.new()
function CameraEffects:Init(Config)
    self.Config=Config; self.Shake=0; self.Token=0; self.Connection=RunService.RenderStepped:Connect(function(dt)
        local camera=workspace.CurrentCamera
        if camera and self.Shake>0 and Config.Settings.Camera.ShakeEnabled then
            local amount=self.Shake*Config.Settings.Camera.ShakeIntensity
            camera.CFrame=camera.CFrame*CFrame.Angles(math.rad(RNG:NextNumber(-amount,amount)),math.rad(RNG:NextNumber(-amount,amount)),math.rad(RNG:NextNumber(-amount,amount)))
            self.Shake=math.max(0,self.Shake-dt*math.max(amount,.1)*7)
        end
    end) end
function CameraEffects:Shake(strength,duration)
    if not self.Config.Settings.Camera.ShakeEnabled then return end
    self.Shake=math.max(self.Shake,strength or self.Config.Effects.NormalShakeStrength)
    if duration then local token=self.Token+1; self.Token=token; task.delay(duration,function() if self.Token==token then self.Shake=0 end end) end
end
function CameraEffects:CriticalShake() self:Shake(self.Config.Effects.CriticalShakeStrength,.3) end
function CameraEffects:SlowMotion(duration)
    if not self.Config.Settings.Camera.SlowMotionEnabled then return end
    local hum=game:GetService("Players").LocalPlayer.Character and game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass("Humanoid"); if not hum then return end
    local previous={}; for _,track in ipairs(hum:GetPlayingAnimationTracks()) do previous[track]=track.Speed; pcall(function() track:AdjustSpeed(math.max(.05,track.Speed*.08)) end) end
    local token=os.clock(); self.SlowToken=token; task.delay(duration or self.Config.Effects.SlowMotionDuration,function() if self.SlowToken~=token then return end; for track,speed in pairs(previous) do if track and track.Parent then pcall(function() track:AdjustSpeed(speed) end) end end end)
end
function CameraEffects:Cleanup() if self.Connection then self.Connection:Disconnect(); self.Connection=nil end; self.Shake=0 end
return CameraEffects
