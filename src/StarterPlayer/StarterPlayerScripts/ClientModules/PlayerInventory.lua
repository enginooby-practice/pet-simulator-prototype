local Inventory = require(game.StarterPlayer.StarterPlayerScripts.ClientModules.Inventory)
local InventorySlot = require(game.StarterPlayer.StarterPlayerScripts.ClientModules.InventorySlot)
type Pet = typeof(require(game.ReplicatedStorage.CommonModules.Pet).new())

PlayerInventory = {}
PlayerInventory.__index = PlayerInventory

setmetatable(PlayerInventory, Inventory)

function PlayerInventory.new(slotAmount: number, equipmentSlotAmount: number)
    local self = Inventory.new(slotAmount)
    setmetatable(self, PlayerInventory)

    local localPlayer = game.Players.LocalPlayer
    if not localPlayer then
        return
    end
    local inventoryFrame = localPlayer:WaitForChild('PlayerGui'):WaitForChild('Main'):WaitForChild('Inventory')

    self.frame = inventoryFrame
    self.equipmentSlots = {}
    self.player = localPlayer

    for i = 1, equipmentSlotAmount, 1 do
        local slot = InventorySlot.new(true)
        table.insert(self.equipmentSlots, slot)

        slot:GetButton().MouseButton1Click:Connect(function()
            self:Unequip(i)
        end)

        slot:GetButton().MouseButton2Click:Connect(function()
            -- slot:RemovePet()
        end)
    end

    return self
end

function PlayerInventory:Equip(slotIndex: number)
    if slotIndex > table.getn(self.slots) or slotIndex < 1 then
        return
    end

    local pet = self.slots[slotIndex].pet :: Pet

    if not pet then
        return
    end

    for _, equipmentSlot in ipairs(self.equipmentSlots) do
        if equipmentSlot.pet == nil then
            equipmentSlot:AddPet(pet)
            pet:Equip()
            self.slots[slotIndex]:RemovePet()
            local LocalPlayerManager = require(game.StarterPlayer.StarterPlayerScripts.ClientModules.LocalPlayerManager)
            table.insert(LocalPlayerManager.equippedPets, pet)
            return
        end
    end
end

function PlayerInventory:Unequip(equipmentSlotIndex: number)
    if equipmentSlotIndex > table.getn(self.equipmentSlots) or equipmentSlotIndex < 1 then
        return
    end

    local pet = self.equipmentSlots[equipmentSlotIndex].pet

    if not pet then
        return
    end

    self:AddPet(pet)
    self.equipmentSlots[equipmentSlotIndex]:RemovePet()
    pet:Unequip()
    local LocalPlayerManager = require(game.StarterPlayer.StarterPlayerScripts.ClientModules.LocalPlayerManager)
    table.remove(LocalPlayerManager.equippedPets, equipmentSlotIndex)
end

return PlayerInventory
