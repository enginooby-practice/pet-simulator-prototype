local Players = game:GetService("Players")
local ServerStorage = game:GetService("ServerStorage")
local PetModule = require(ServerStorage.ServerModules.PetModule)

local function OnPlayerAdded(player)
    InitGoldStat(player)

    task.wait(5)
    PetModule.EquipPet(player, "Fox")
end

function InitGoldStat(player)
    local leaderstats = Instance.new("Folder", player)
    leaderstats.Name = "leaderstats"

    local gold = Instance.new("IntValue", leaderstats)
    gold.Name = "Gold"
    gold.Value = 0
end

Players.PlayerAdded:Connect(OnPlayerAdded)
