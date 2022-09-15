local function OnPlayerAdded(player: Player)
    InitGoldStat(player)
    CreatePetFolders(player)

    -- TIP: Wait until player is completely spawned
    repeat
        task.wait()
    until player.Character
end

-- ? Move to Pet module
function CreatePetFolders(player: Player)
    local petFolder = Instance.new('Folder', workspace.Pets)
    petFolder.Name = player.Name
    Instance.new('Folder', petFolder).Name = 'Equipped'
    Instance.new('Folder', petFolder).Name = 'Unequipped'
end

function InitGoldStat(player: Player)
    local leaderstats = Instance.new('Folder', player)
    leaderstats.Name = 'leaderstats'

    local gold = Instance.new('IntValue', leaderstats)
    gold.Name = 'Gold'
    gold.Value = 100
end

game.Players.PlayerAdded:Connect(OnPlayerAdded)
