local localPlayer = game.Players.LocalPlayer
local Pet = require(game.ReplicatedStorage.CommonModules.Pet)
type Pet = typeof(Pet.new())

InventorySlot = {}
InventorySlot.__index = InventorySlot

function InventorySlot.new(isEquipmentSlot: boolean, parent: Instance)
    local self = {}
    setmetatable(self, InventorySlot)

    local inventory: Frame = localPlayer:WaitForChild('PlayerGui'):WaitForChild('Main'):WaitForChild('Inventory')
    local slotPrefab: Instance = inventory:WaitForChild('Frame'):WaitForChild('ScrollingFrame'):WaitForChild('Slot')
    local equipmentSlotPrefab: Instance =
        inventory:WaitForChild('Frame'):WaitForChild('EquipmentSlots'):WaitForChild('Slot')

    self.pet = nil
    self.button = if isEquipmentSlot then equipmentSlotPrefab:Clone() else slotPrefab:Clone() :: TextButton
    self.button.Parent = parent
    if not parent then
        self.button.Parent = if isEquipmentSlot then equipmentSlotPrefab.Parent else slotPrefab.Parent
    end
    self.button.Visible = true
    self:RemovePet()

    return self
end

function InventorySlot:AddPet(pet: Pet)
    self.pet = pet
    self.button.PetName.Text = pet.name
    self.button.PetLevel.Text = 'Lv.' .. pet.level
    self.button:WaitForChild('Icon').Image = pet.icon
end

function InventorySlot:RemovePet()
    self.button.PetName.Text = ''
    self.button.PetLevel.Text = ''
    self.button:WaitForChild('Icon').Image = ''
    self.pet = nil
end

function InventorySlot:GetButton(): TextButton
    return self.button :: TextButton
end

return InventorySlot
