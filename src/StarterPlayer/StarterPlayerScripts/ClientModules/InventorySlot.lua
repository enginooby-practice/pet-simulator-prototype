local Pet = require(game.ReplicatedStorage.CommonModules.Pet)
local localPlayer = game.Players.LocalPlayer
local inventory: Frame = localPlayer:WaitForChild('PlayerGui'):WaitForChild('Main'):WaitForChild('Inventory')
local slotPrefab: Instance = inventory:WaitForChild('Frame'):WaitForChild('ScrollingFrame'):WaitForChild('Slot')

InventorySlot = {}
InventorySlot.__index = InventorySlot

function InventorySlot.new()
    local _ = {}
    setmetatable(_, InventorySlot)

    _.button = slotPrefab:Clone() :: TextButton
    _.button.Parent = slotPrefab.Parent
    _.button.Visible = true
    _:RemovePet()

    return _
end

function InventorySlot:AddPet(pet: Pet)
    self.pet = pet :: Pet
    self.button.PetName.Text = pet.name
    self.button.PetLevel.Text = pet.level
end

function InventorySlot:RemovePet()
    self.pet = nil
    self.button.PetName.Text = ''
    self.button.PetLevel.Text = ''
end

return InventorySlot
