local function OnPlayerAdded(player: Player)
    InitGoldStat(player)

    local petFolder = Instance.new('Folder', workspace.Pets)
    petFolder.Name = player.Name

    -- TIP: Wait until player is completely spawned
    repeat
        task.wait()
    until player.Character
end

function InitGoldStat(player)
    local leaderstats = Instance.new('Folder', player)
    leaderstats.Name = 'leaderstats'

    local gold = Instance.new('IntValue', leaderstats)
    gold.Name = 'Gold'
    gold.Value = 100
end

game.Players.PlayerAdded:Connect(OnPlayerAdded)
