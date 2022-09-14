Pet = {}
Pet.__index = Pet

function Pet.new(prefabName: string, name: string, player: Player)
    local _ = {}
    setmetatable(_, Pet)

    if not player then
        return
    end

    local petPrefab: Instance = game.ReplicatedStorage.Pets:FindFirstChild(prefabName)

    _.model = petPrefab:Clone() :: Model
    _.model.Name = name
    _.prefabName = prefabName
    _.name = name
    _.level = 1
    _.exp = 0
    _.attachmentPosition = _.model:FindFirstChild('AttachmentPosition').Value
    _.player = player
    _.icon = (_.model:WaitForChild('Icon') :: ImageLabel).Image

    SetupAttachment(_.model)
    _:Unequip()

    return _
end

function Pet:Equip()
    local model: Model = self.model
    local playerHumanoid = self.player.Character.HumanoidRootPart
    model.Parent = workspace.Pets:FindFirstChild(self.player.Name).Equipped
    model.PrimaryPart.Anchored = false
    model.PrimaryPart.CFrame = playerHumanoid.CFrame
    --model.PrimaryPart:SetNetworkOwner(player)

    local playerAttachment1 = playerHumanoid:FindFirstChild('Attachment1' .. self.name) :: Attachment
    if not playerAttachment1 then
        playerAttachment1 = Instance.new('Attachment', playerHumanoid)
        playerAttachment1.Position = self.attachmentPosition
        playerAttachment1.Name = 'Attachment1' .. self.name
    end

    self:SetAttachment1(playerAttachment1)
end

function Pet:Unequip()
    self.model.Parent = workspace.Pets:FindFirstChild(self.player.Name).Unequipped
    local homePosition = Vector3.new(math.random(-70, -50), 33, math.random(-120, -100))
    self:SetPosition(homePosition)
end

-- to teleport
function Pet:SetPosition(position: Vector3)
    local model: Model = self.model
    model.PrimaryPart.Anchored = true
    self:SetAttachment1(nil)
    model:MoveTo(position)
end

-- to move towards then follow
function Pet:SetAttachment1(attachment1: Attachment)
    local model: Model = self.model
    model.PrimaryPart.AlignPosition.Attachment1 = attachment1
    model.PrimaryPart.AlignOrientation.Attachment1 = attachment1
end

function SetupAttachment(model: Model)
    local attachment0 = Instance.new('Attachment', model.PrimaryPart)
    attachment0.Name = 'Attachment0'

    local alignPosition: AlignPosition = Instance.new('AlignPosition', model.PrimaryPart)
    alignPosition.Attachment0 = attachment0
    alignPosition.RigidityEnabled = false
    alignPosition.MaxForce = 25000
    alignPosition.Responsiveness = 5

    local alignOrientation: AlignOrientation = Instance.new('AlignOrientation', model.PrimaryPart)
    alignOrientation.Attachment0 = attachment0
    alignOrientation.RigidityEnabled = false
    alignOrientation.MaxTorque = 25000
    alignOrientation.Responsiveness = 5
end

function Pet:AddExp(amount: number) end

return Pet
