local nightSound = workspace.AmbientSounds.nightSound
local daySound = workspace.AmbientSounds.daySound
local customMusic = workspace.AmbientSounds.CustomMusic

local function IsDay(): boolean
    local Time = game.Lighting.TimeOfDay
    Time = (Time:gsub('[:\r]', ''))
    Time = tonumber(Time)

    return Time >= 180000 or Time < 60000
end

local function PlayDayAudio()
    task.wait(0.1)
    if daySound.Playing and customMusic.Playing then
        daySound:Stop()
        customMusic:Stop()
    end
    if not nightSound.Playing then
        nightSound:Play()
    end
end

local function PlayNightAudio()
    if nightSound.Playing then
        nightSound:Stop()
    end
    task.wait(0.1)
    if not daySound.Playing and not customMusic.Playing then
        daySound:Play()
        customMusic:Play()
    end
end

while true do
    if IsDay() then
        PlayDayAudio()
    else
        PlayNightAudio()
    end
end
