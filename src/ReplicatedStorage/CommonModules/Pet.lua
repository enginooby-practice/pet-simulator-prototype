Pet = {}
Pet.__index = Pet

function Pet.new(prefabName: string, name: string)
    local clone = {}
    setmetatable(clone, Pet)

    local petPrefab: Instance = game.ReplicatedStorage.Pets:FindFirstChild(prefabName)

    clone.model = petPrefab:Clone()
    clone.prefabName = prefabName
    -- clone.name = prefabName .. math.random(1, 9999)
    clone.name = name
    clone.level = 1
    clone.exp = 0

    return clone
end

function Pet:AttachTo(player: Player)
    local petModel = self.model
    petModel.Parent = workspace.Pets
    petModel.PrimaryPart.CFrame = player.Character.HumanoidRootPart.CFrame
    petModel.PrimaryPart:SetNetworkOwner(player)

    local attachment0 = Instance.new('Attachment', petModel.PrimaryPart)
    attachment0.Name = 'Attachment0'

    local attachment1 = Instance.new('Attachment', player.Character.HumanoidRootPart)
    attachment1.Position = petModel:FindFirstChild('AttachmentPosition').Value
    attachment1.Name = 'Attachment1'

    local alignPosition: AlignPosition = Instance.new('AlignPosition', petModel.PrimaryPart)
    alignPosition.Attachment0 = attachment0
    alignPosition.Attachment1 = attachment1
    alignPosition.RigidityEnabled = false
    alignPosition.MaxForce = 25000
    alignPosition.Responsiveness = 5

    local alignRotation: AlignOrientation = Instance.new('AlignOrientation', petModel.PrimaryPart)
    alignRotation.Attachment0 = attachment0
    alignRotation.Attachment1 = attachment1
    alignRotation.RigidityEnabled = false
    alignRotation.MaxTorque = 25000
    alignRotation.Responsiveness = 5
end

function Pet:AddExp(amount: number) end

return Pet
