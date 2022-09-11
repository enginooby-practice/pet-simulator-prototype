local questPrefab = game.ReplicatedStorage:WaitForChild('Quest', 5)

-- UTIL
-- ! Must define function before use
function DestroyAllDescendants(folder: Folder)
  for _, desc: Instance in pairs(folder:GetDescendants()) do
    if not desc then return end
    desc:Destroy()
  end
end

function SpawnQuest() : Model
    local quest: Model = questPrefab:Clone()
    local randomPosition = Vector3.new(math.random(-15, 112), 30.649, math.random(-27, 85)) -- REFACTOR
    quest.Parent = game.Workspace.Quests
    quest:MoveTo(randomPosition)

    return quest
end

task.wait(10)
while true do
    task.wait(math.random(5,8))
    -- PERF: Use pool
    DestroyAllDescendants(game.Workspace.Quests)
    SpawnQuest()
    SpawnQuest()
    SpawnQuest()
end


