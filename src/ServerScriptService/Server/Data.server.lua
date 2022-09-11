local Pet = require(game.ReplicatedStorage.CommonModules.Pet)

local function OnPlayerAdded(player: Player)
    InitGoldStat(player)

    -- TIP: Wait until player is completely spawned
    repeat
        task.wait()
    until player.Character

    local fox = Pet.new('Fox', 'Foxy')
    local bat = Pet.new('Bat', 'Battie')
    -- fox:AttachTo(player)
    -- bat:AttachTo(player)
end

function InitGoldStat(player)
    local leaderstats = Instance.new('Folder', player)
    leaderstats.Name = 'leaderstats'

    local gold = Instance.new('IntValue', leaderstats)
    gold.Name = 'Gold'
    gold.Value = 0
end

game.Players.PlayerAdded:Connect(OnPlayerAdded)
