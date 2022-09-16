local SLOT_AMOUNT = 24

local Pet = require(game.ReplicatedStorage.CommonModules.Pet)
local ShopInventory = require(game.StarterPlayer.StarterPlayerScripts.ClientModules.ShopInventory)
local seller: Model = workspace:FindFirstChild('Shop'):FindFirstChild('Seller')
type Pet = typeof(Pet.new())

local shopInventory = ShopInventory.new(SLOT_AMOUNT)

local function AddRandomPet()
    local pets = { 'Bat', 'Dog', 'Fox', 'Cow' }
    local random = math.random(1, #pets)
    local pet = Pet.new(pets[random], pets[random], nil)
    shopInventory:AddPet(pet)
end

local clickDetector = Instance.new('ClickDetector', seller)
clickDetector.MaxActivationDistance = 15
clickDetector.MouseClick:Connect(function(player: Player)
    shopInventory:Toggle()
end)

for i = 1, SLOT_AMOUNT, 1 do
    AddRandomPet()
end

print('>>> Initialized shop')
