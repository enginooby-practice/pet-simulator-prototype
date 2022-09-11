Pet = {}
Pet.__index = Pet

function Pet.new(prefabName: string, name: string)
    local _ = {}
    setmetatable(_, Pet)

    local petPrefab: Instance = game.ReplicatedStorage.Pets:FindFirstChild(prefabName)

    _.model = petPrefab:Clone()
    _.model.Name = name
    _.prefabName = prefabName :: string
    _.name = name :: string
    _.level = 1 :: number
    _.exp = 0 :: number

    return _
end

function Pet:Equip(player: Player)
    local model = self.model
    model.Parent = workspace.Pets
    model.PrimaryPart.CFrame = player.Character.HumanoidRootPart.CFrame
    --model.PrimaryPart:SetNetworkOwner(player)

    local attachment0 = Instance.new('Attachment', model.PrimaryPart)
    attachment0.Name = 'Attachment0'

    local attachment1 = Instance.new('Attachment', player.Character.HumanoidRootPart)
    attachment1.Position = model:FindFirstChild('AttachmentPosition').Value
    attachment1.Name = 'Attachment1'

    local alignPosition: AlignPosition = Instance.new('AlignPosition', model.PrimaryPart)
    alignPosition.Attachment0 = attachment0
    alignPosition.Attachment1 = attachment1
    alignPosition.RigidityEnabled = false
    alignPosition.MaxForce = 25000
    alignPosition.Responsiveness = 5

    local alignRotation: AlignOrientation = Instance.new('AlignOrientation', model.PrimaryPart)
    alignRotation.Attachment0 = attachment0
    alignRotation.Attachment1 = attachment1
    alignRotation.RigidityEnabled = false
    alignRotation.MaxTorque = 25000
    alignRotation.Responsiveness = 5
end

function Pet:AddExp(amount: number) end

return Pet
