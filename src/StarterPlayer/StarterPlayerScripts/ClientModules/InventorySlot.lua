local Pet = require(game.ReplicatedStorage.CommonModules.Pet)
local localPlayer = game.Players.LocalPlayer

InventorySlot = {}
InventorySlot.__index = InventorySlot

function InventorySlot.new(isEquipmentSlot: boolean)
    local _ = {}
    setmetatable(_, InventorySlot)

    local inventory: Frame = localPlayer:WaitForChild('PlayerGui'):WaitForChild('Main'):WaitForChild('Inventory')
    local slotPrefab: Instance = inventory:WaitForChild('Frame'):WaitForChild('ScrollingFrame'):WaitForChild('Slot')
    local equipmentSlotPrefab: Instance =
        inventory:WaitForChild('Frame'):WaitForChild('EquipmentSlots'):WaitForChild('Slot')

    _.button = if isEquipmentSlot then equipmentSlotPrefab:Clone() else slotPrefab:Clone() :: TextButton
    _.button.Parent = if isEquipmentSlot then equipmentSlotPrefab.Parent else slotPrefab.Parent
    _.button.Visible = true
    _.button:WaitForChild('Icon').Image = ''
    _:RemovePet()

    return _
end

function InventorySlot:AddPet(pet: Pet)
    self.pet = pet :: Pet
    self.button.PetName.Text = pet.name
    self.button.PetLevel.Text = 'Lv.' .. pet.level
    self.button:WaitForChild('Icon').Image = pet.icon
end

function InventorySlot:RemovePet()
    self.pet = nil
    self.button.PetName.Text = ''
    self.button.PetLevel.Text = ''
    self.button:WaitForChild('Icon').Image = ''
end

function InventorySlot:GetButton(): TextButton
    return self.button :: TextButton
end

return InventorySlot
