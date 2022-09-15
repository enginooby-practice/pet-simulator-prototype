Inventory = {}
Inventory.__index = Inventory

Inventory.frame = nil :: Frame

function Inventory.new(slotAmount: number, equipmentSlotAmount: number)
    local self = {}
    setmetatable(self, Inventory)

    local localPlayer = game.Players.LocalPlayer
    if not localPlayer then
        return
    end
    local inventoryFrame = localPlayer:WaitForChild('PlayerGui'):WaitForChild('Main'):WaitForChild('Inventory')
    local InventorySlot = require(game.StarterPlayer.StarterPlayerScripts.ClientModules.InventorySlot)

    self.frame = inventoryFrame
    self.slots = {}
    self.equipmentSlots = {}
    self.player = localPlayer

    for i = 1, slotAmount, 1 do
        local slot = InventorySlot.new(false)
        table.insert(self.slots, slot)

        slot:GetButton().MouseButton1Click:Connect(function()
            self:Equip(i)
        end)

        slot:GetButton().MouseButton2Click:Connect(function()
            slot:RemovePet()
        end)
    end

    for i = 1, equipmentSlotAmount, 1 do
        local slot = InventorySlot.new(true)
        table.insert(self.equipmentSlots, slot)

        slot:GetButton().MouseButton1Click:Connect(function()
            self:Unequip(i)
        end)

        slot:GetButton().MouseButton2Click:Connect(function()
            slot:RemovePet()
        end)
    end

    return self
end

function Inventory:Open()
    self.frame.Visible = true
end

function Inventory:Close()
    self.frame.Visible = false
end

function Inventory:Toggle()
    self.frame.Visible = not self.frame.Visible
end

function Inventory:IsOpen(): boolean
    return self.frame.Visible
end

function Inventory:AddPet(pet)
    for _, slot in ipairs(self.slots) do
        if slot.pet == nil then
            slot:AddPet(pet)
            return
        end
    end
end

function Inventory:Equip(slotIndex: number)
    if slotIndex > table.getn(self.slots) or slotIndex < 1 then
        return
    end

    local pet = self.slots[slotIndex].pet

    if not pet then
        return
    end

    for _, equipmentSlot in ipairs(self.equipmentSlots) do
        if equipmentSlot.pet == nil then
            equipmentSlot:AddPet(pet)
            pet:Equip(self.player)
            self.slots[slotIndex]:RemovePet()
            local LocalPlayerManager = require(game.StarterPlayer.StarterPlayerScripts.ClientModules.LocalPlayerManager)
            table.insert(LocalPlayerManager.equippedPets, pet)
            return
        end
    end
end

function Inventory:Unequip(equipmentSlotIndex: number)
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

return Inventory
