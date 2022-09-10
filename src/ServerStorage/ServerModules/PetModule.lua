local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
local module = {}

function module.EquipPet(player: Player, petName)
  local petModel:Instance = ReplicatedStorage.Pets:FindFirstChild(petName)
  if not player or not petModel then return end

  local petAttachments = getOrCreateChild(player, "PetAttachments")
  if not petAttachments then return end

  petModel=petModel:Clone()
  petModel.Parent=workspace.Pets

  local attachment0 = Instance.new("Attachment", petModel.PrimaryPart)
  attachment0.Name="Attachment0"

  local attachment1 = Instance.new("Attachment", player.Character.HumanoidRootPart)
  attachment1.Position = petModel:FindFirstChild("AttachmentPosition").Value
  attachment1.Name="Attachment1"
  
local alignPosition:AlignPosition= Instance.new("AlignPosition", petModel.PrimaryPart)
  alignPosition.Attachment0=attachment0
  alignPosition.Attachment1=attachment1
  alignPosition.RigidityEnabled=false
  alignPosition.MaxForce=100000
  alignPosition.Responsiveness=25

  local alignRotation:AlignOrientation= Instance.new("AlignOrientation", petModel.PrimaryPart)
  alignRotation.Attachment0=attachment0
  alignRotation.Attachment1=attachment1
  alignRotation.RigidityEnabled=false
  alignRotation.MaxTorque=100000 
  alignRotation.Responsiveness=25
end 

function getOrCreateChild(player: Player, childName: string) : Instance
  if not player.Character.HumanoidRootPart:FindFirstChild(childName) then
    local child = Instance.new("Folder", player.Character.HumanoidRootPart)
    child.Name=childName
  end

  return player.Character.HumanoidRootPart:FindFirstChild(childName);
end

function module.UnequipPet(player)
  if not player then return end
end

function module.UnequipAllPets(player)
  if not player then return end
end

return module
