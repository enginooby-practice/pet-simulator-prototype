local PetModule = require(game.ServerStorage.ServerModules.PetModule)

local function OnPlayerAdded(player: Player)
    InitGoldStat(player)

    -- TIP: Wait until player is completely spawned
    repeat
        task.wait()
    until player.Character

    PetModule.EquipPet(player, 'Fox')
    PetModule.EquipPet(player, 'Bat')
end

function InitGoldStat(player)
    local leaderstats = Instance.new('Folder', player)
    leaderstats.Name = 'leaderstats'

    local gold = Instance.new('IntValue', leaderstats)
    gold.Name = 'Gold'
    gold.Value = 0
end

game.Players.PlayerAdded:Connect(OnPlayerAdded)
