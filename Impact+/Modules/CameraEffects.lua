--==============================================================--
-- Impact+
-- CameraEffects.lua
--
-- Version: 1.0.1
--
-- Changelog:
-- 1.0.0 - Camera shake and client-side hit-stop effects
-- 1.0.1 - Fixed Shake method being overwritten by shake state
--==============================================================--

local CameraEffects = {}

local RunService = game:GetService("RunService")
local RNG = Random.new()

function CameraEffects:Init(Config)
    self.Config = Config
    self.BaseFOV = 70

    -- Runtime state must not use the same key as the Shake method.
    self.ShakeAmount = 0
    self.Token = 0

    self.Connection = RunService.RenderStepped:Connect(function(dt)
        local camera = workspace.CurrentCamera

        if not camera then
            return
        end

        if self.ShakeAmount > 0 and Config.Settings.Camera.ShakeEnabled then
            local amount =
                self.ShakeAmount * Config.Settings.Camera.ShakeIntensity

            camera.CFrame = camera.CFrame * CFrame.Angles(
                math.rad(RNG:NextNumber(-amount, amount)),
                math.rad(RNG:NextNumber(-amount, amount)),
                math.rad(RNG:NextNumber(-amount, amount))
            )

            self.ShakeAmount = math.max(
                0,
                self.ShakeAmount - dt * amount * 7
            )
        end
    end)
end

function CameraEffects:Shake(strength, duration)
    if not self.Config.Settings.Camera.ShakeEnabled then
        return
    end

    self.ShakeAmount = math.max(
        self.ShakeAmount,
        strength or self.Config.Effects.NormalShakeStrength
    )

    if duration then
        local token = self.Token + 1
        self.Token = token

        task.delay(duration, function()
            if self.Token == token then
                self.ShakeAmount = 0
            end
        end)
    end
end

function CameraEffects:CriticalShake()
    self:Shake(
        self.Config.Effects.CriticalShakeStrength,
        0.3
    )
end

function CameraEffects:SlowMotion(duration)
    if not self.Config.Settings.Camera.SlowMotionEnabled then
        return
    end

    duration = duration or self.Config.Effects.SlowMotionDuration

    local character =
        game:GetService("Players").LocalPlayer.Character

    local humanoid =
        character and character:FindFirstChildOfClass("Humanoid")

    local tracks =
        humanoid and humanoid:GetPlayingAnimationTracks() or {}

    local previousSpeeds = {}

    for _, track in ipairs(tracks) do
        previousSpeeds[track] = track.Speed

        pcall(function()
            track:AdjustSpeed(math.max(0.05, track.Speed * 0.08))
        end)
    end

    local token = os.clock()
    self.SlowToken = token

    task.delay(duration, function()
        if self.SlowToken ~= token then
            return
        end

        for track, speed in pairs(previousSpeeds) do
            if track and track.Parent then
                pcall(function()
                    track:AdjustSpeed(speed)
                end)
            end
        end
    end)
end

function CameraEffects:Cleanup()
    if self.Connection then
        self.Connection:Disconnect()
        self.Connection = nil
    end

    self.ShakeAmount = 0
end

return CameraEffects
