local Pet = require(game.ReplicatedStorage.CommonModules.Pet)
local ShopInventory = require(game.StarterPlayer.StarterPlayerScripts.ClientModules.ShopInventory)
local seller: Model = workspace:FindFirstChild('Shop'):FindFirstChild('Seller')

local shopInventory = ShopInventory.new(24)

print('>>> Initialized shop')

local clickDetector = Instance.new('ClickDetector', seller)
clickDetector.MaxActivationDistance = 15
clickDetector.MouseClick:Connect(function(player: Player)
    shopInventory:Toggle()
end)
