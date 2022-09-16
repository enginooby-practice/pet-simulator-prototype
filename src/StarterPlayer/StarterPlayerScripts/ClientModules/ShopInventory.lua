local Inventory = require(game.StarterPlayer.StarterPlayerScripts.ClientModules.Inventory)
local InventorySlot = require(game.StarterPlayer.StarterPlayerScripts.ClientModules.InventorySlot)
local localPlayer = game.Players.LocalPlayer
local inventoryFrame = localPlayer:WaitForChild('PlayerGui'):WaitForChild('Main'):WaitForChild('Shop')
local slotParent = inventoryFrame:WaitForChild('Frame'):WaitForChild('ScrollingFrame')
type Pet = typeof(require(game.ReplicatedStorage.CommonModules.Pet).new())

ShopInventory = {}
ShopInventory.__index = ShopInventory

setmetatable(ShopInventory, Inventory)

function ShopInventory.new(slotAmount: number)
    local self = Inventory.new(slotAmount)
    setmetatable(self, ShopInventory)

    self.frame = inventoryFrame

    for i = 1, slotAmount, 1 do
        local slot = InventorySlot.new(false, slotParent)
        table.insert(self.slots, slot)

        slot:GetButton().MouseButton1Click:Connect(function()
            self.slots[i]:Sell()
        end)
    end

    self:SetupCloseButton()

    return self
end

return ShopInventory
