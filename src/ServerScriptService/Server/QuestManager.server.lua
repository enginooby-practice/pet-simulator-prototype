local SPAWN_AMOUNT = 3
local SPAWN_FREQUENCY = 3 * 60

local Quest = require(game.ReplicatedStorage.CommonModules.Quest)

-- UTIL
-- ! Must define local function before use
local function DestroyAllChildren(folder: Folder)
    for _, instance: Instance in pairs(folder:GetChildren()) do
        if instance then
            instance:Destroy()
        end
    end
end

local function SpawnQuest()
    local randomPosition = Vector3.new(math.random(-15, 112), 30.649, math.random(-27, 85)) -- REFACTOR
    local quest = Quest.new(randomPosition, 'Quest ' .. math.random(1, 1000), 'Description', 60, 30, 10, 20)
end

while true do
    -- PERF: Use pool
    DestroyAllChildren(game.Workspace.Quests)

    for i = 1, SPAWN_AMOUNT, 1 do
        SpawnQuest()
    end

    task.wait(SPAWN_FREQUENCY)
end
