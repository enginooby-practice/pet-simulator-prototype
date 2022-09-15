local InventorySlot = require(game.StarterPlayer.StarterPlayerScripts.ClientModules.InventorySlot)
type Pet = typeof(require(game.ReplicatedStorage.CommonModules.Pet).new())

Inventory = {}
Inventory.__index = Inventory
Inventory.frame = nil :: Frame

function Inventory.new(slotAmount: number)
    local self = {}
    setmetatable(self, Inventory)

    self.frame = nil :: Frame
    self.slots = {}

    for i = 1, slotAmount, 1 do
        local slot = InventorySlot.new(false)
        table.insert(self.slots, slot)

        slot:GetButton().MouseButton1Click:Connect(function()
            self:Equip(i)
        end)

        slot:GetButton().MouseButton2Click:Connect(function()
            -- TODO: Implement destroy pet model
            -- slot:RemovePet()
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

function Inventory:AddPet(pet: Pet)
    for _, slot in ipairs(self.slots) do
        if slot.pet == nil then
            slot:AddPet(pet)
            return
        end
    end
end

return Inventory
