local localPlayer = game.Players.LocalPlayer
local inventory: Frame = localPlayer:WaitForChild('PlayerGui'):WaitForChild('Main'):WaitForChild('Inventory')
local InventorySlot = require(game.StarterPlayer.StarterPlayerScripts.ClientModules.InventorySlot)
local Pet = require(game.ReplicatedStorage.CommonModules.Pet)

Inventory = {}
Inventory.__index = Inventory

function Inventory.new(slotAmount: number)
    local _ = {}
    setmetatable(_, Inventory)

    _.player = localPlayer
    _.frame = inventory
    _.slots = {}

    for i = 1, slotAmount, 1 do
        _:CreateSlot()
    end

    return _
end

function Inventory:CreateSlot()
    local slot = InventorySlot.new()
    table.insert(self.slots, slot)
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

    if pet then
        pet:AttachTo(self.player)
        self.slots[slotIndex]:RemovePet()
    end
end

return Inventory
