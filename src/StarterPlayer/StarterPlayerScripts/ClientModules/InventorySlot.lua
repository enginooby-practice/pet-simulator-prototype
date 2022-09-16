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
        self.isPlayerInventory = true
    end
    self.button.Visible = true
    self:RemovePet()

    return self
end

function InventorySlot:AddPet(pet: Pet)
    self.pet = pet
    self.button.PetName.Text = pet.name
    self.button:WaitForChild('Icon').Image = pet.icon

    if self.isPlayerInventory then
        self.button.PetLevel.Text = 'Lv.' .. pet.level
    else
        self.button.PetLevel.Text = pet.price .. 'G'
    end
end

function InventorySlot:RemovePet()
    self.button.PetName.Text = ''
    self.button.PetLevel.Text = ''
    self.button:WaitForChild('Icon').Image = ''
    self.pet = nil
end

-- TODO: Subclass ShopInventorySlot & PlayerInventorySlot
-- for shop inventory only
function InventorySlot:Sell()
    if self.isPlayerInventory then
        return
    end

    local pet = self.pet :: Pet
    local LocalPlayerManager = require(game.StarterPlayer.StarterPlayerScripts.ClientModules.LocalPlayerManager)
    if LocalPlayerManager:GetGold() >= pet.price then
        LocalPlayerManager:AddGold(-pet.price)
        LocalPlayerManager.inventory:AddPet(pet)
        pet:SetPlayer(LocalPlayerManager.player)
        self:RemovePet()
    end
end

function InventorySlot:GetButton(): TextButton
    return self.button :: TextButton
end

return InventorySlot
