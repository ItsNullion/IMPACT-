local ASSETS_TO_PLAY = {
    "rbxassetid://102896911709401",
    "rbxassetid://127621297686566",
    "rbxassetid://121170635692427"
}

print("[DEBUG] Testing sound playback...")
for _, assetId in ipairs(ASSETS_TO_PLAY) do
    local sound = Instance.new("Sound")
    sound.SoundId = assetId
    sound.Parent = game:GetService("CoreGui")
    sound.Volume = 1
    sound:Play()
    print("[DEBUG] Played sound:", assetId)
    sound.Ended:Connect(function()
        sound:Destroy()
    end)
end
