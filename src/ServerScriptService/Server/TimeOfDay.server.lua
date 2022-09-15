local TIME_SCALE = 1

local lighting = game:GetService('Lighting')

while true do
    local currentMinutesAfterMidnight = lighting:GetMinutesAfterMidnight() + 1 * TIME_SCALE
    lighting:SetMinutesAfterMidnight(currentMinutesAfterMidnight)
    task.wait(0.4 / TIME_SCALE)
end
