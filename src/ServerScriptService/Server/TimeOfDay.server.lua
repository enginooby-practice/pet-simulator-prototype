local lighting = game:GetService('Lighting')
local TIME_SCALE = 1

while true do
    local currentMinutesAfterMidnight = lighting:GetMinutesAfterMidnight() + 1 * TIME_SCALE
    lighting:SetMinutesAfterMidnight(currentMinutesAfterMidnight)
    task.wait(0.4 / TIME_SCALE)
end
