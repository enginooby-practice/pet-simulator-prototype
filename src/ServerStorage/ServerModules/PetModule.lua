local ReplicatedStorage = game:GetService('ReplicatedStorage')
local module = {}

function module.EquipPet(player: Player, petName: string)
    local petPrefab: Instance = ReplicatedStorage.Pets:FindFirstChild(petName)
    if not player or not petPrefab then
        return
    end

    local petAttachments = getOrCreateChild(player, 'PetAttachments')

    local petModel: Model = petPrefab:Clone()
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

-- UTIL
function getOrCreateChild(player: Player, childName: string): Instance
    if not player.Character.HumanoidRootPart:FindFirstChild(childName) then
        local child = Instance.new('Folder', player.Character.HumanoidRootPart)
        child.Name = childName
    end

    return player.Character.HumanoidRootPart:FindFirstChild(childName)
end

function module.UnequipPet(player: Player, petName: string)
    if not player then
        return
    end

    workspace.Pets:FindFirstChild(petName):Destroy()
end

function module.UnequipAllPets(player: Player)
    if not player then
        return
    end
end

return module
