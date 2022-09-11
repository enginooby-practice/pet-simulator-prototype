local localPlayer = game.Players.LocalPlayer
local inventory: Frame = localPlayer:WaitForChild('PlayerGui'):WaitForChild('Main'):WaitForChild('Inventory')
local InventorySlot = require(game.StarterPlayer.StarterPlayerScripts.ClientModules.InventorySlot)
local Pet = require(game.ReplicatedStorage.CommonModules.Pet)

Inventory = {}
Inventory.__index = Inventory

function Inventory.new(slotAmount: number, equipmentSlotAmount: number)
    local _ = {}
    setmetatable(_, Inventory)

    _.frame = inventory
    _.slots = {}
    _.equipmentSlots = {}
    _.player = localPlayer

    for i = 1, slotAmount, 1 do
        local slot = InventorySlot.new(false)
        table.insert(_.slots, slot)

        slot:GetButton().MouseButton1Click:Connect(function()
            _:Equip(i)
        end)

        slot:GetButton().MouseButton2Click:Connect(function()
            slot:RemovePet()
        end)
    end

    for i = 1, equipmentSlotAmount, 1 do
        local slot = InventorySlot.new(true)
        table.insert(_.equipmentSlots, slot)

        slot:GetButton().MouseButton1Click:Connect(function()
            _:Unequip(i)
        end)

        slot:GetButton().MouseButton2Click:Connect(function()
            slot:RemovePet()
        end)
    end

    return _
end

function Inventory:Open()
    inventory.Visible = true
end

function Inventory:Close()
    inventory.Visible = false
end

function Inventory:Toggle()
    inventory.Visible = not inventory.Visible
end

function Inventory:IsOpen(): boolean
    return inventory.Visible
end

function Inventory:AddPet(pet: Pet)
    for _, slot: InventorySlot in ipairs(self.slots) do
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

    local pet = self.slots[slotIndex].pet :: Pet

    if not pet then
        return
    end

    for _, equipmentSlot in ipairs(self.equipmentSlots) do
        if equipmentSlot.pet == nil then
            equipmentSlot:AddPet(pet)
            pet:Equip(self.player)
            self.slots[slotIndex]:RemovePet()
            return
        end
    end
end

function Inventory:Unequip(equipmentSlotIndex: number)
    if equipmentSlotIndex > table.getn(self.equipmentSlots) or equipmentSlotIndex < 1 then
        return
    end

    local pet = self.equipmentSlots[equipmentSlotIndex].pet :: Pet

    if not pet then
        return
    end

    self:AddPet(pet)
    self.equipmentSlots[equipmentSlotIndex]:RemovePet()
end

function GetActivePets()
    return (workspace.Pets :: Folder):GetChildren()
end

return Inventory
