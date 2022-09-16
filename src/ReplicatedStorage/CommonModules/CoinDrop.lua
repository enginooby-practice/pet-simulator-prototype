local coinDropPrefab = game.ReplicatedStorage.Drops:FindFirstChild('CoinDrop')

CoinDrop = {}
CoinDrop.__index = CoinDrop
type CoinDrop = typeof(CoinDrop.new())

local function SendPet(player: Player, drop: CoinDrop)
    local dropPart = drop.part :: MeshPart
    print('Coin drop clicked by ' .. player.Name)

    -- FIX: GetChildren() doen't return children added at runtime
    local equippedPetFolder = workspace.Pets:FindFirstChild(player.Name).Equipped :: Folder
    local equippedPets = equippedPetFolder:GetChildren()

    print(#equippedPets)
    if #equippedPets == 0 then
        return
    end

    local pet = equippedPets[1]
    pet.AlignPosition.Attachment1 = dropPart.PrimaryPart.Attachment
    pet.AlignOrientation.Attachment1 = dropPart.PrimaryPart.Attachment
end

function CoinDrop.new()
    local self = {}
    setmetatable(self, CoinDrop)

    local part: MeshPart = coinDropPrefab:Clone()
    local randomPosition = Vector3.new(math.random(-15, 112), 30.649, math.random(-27, 85)) -- REFACTOR
    part.Parent = workspace.Drops
    part.Position = randomPosition

    local clickDetector = Instance.new('ClickDetector', part)
    clickDetector.MaxActivationDistance = 15

    clickDetector.MouseClick:Connect(function(player: Player)
        SendPet(player, self)
    end)

    return self
end

return CoinDrop
