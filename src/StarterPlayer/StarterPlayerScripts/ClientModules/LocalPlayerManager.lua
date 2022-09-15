local module = {}

local localPlayer = game.Players.LocalPlayer
Inventory = Inventory or require(game.StarterPlayer.StarterPlayerScripts.ClientModules.Inventory)
Pet = Pet or require(game.ReplicatedStorage.CommonModules.Pet)

task.wait(5)
print('>>> Initilized inventory')
local inventory = Inventory.new(10, 2)
inventory:AddPet(Pet.new('Fox', 'Foxy', localPlayer))
inventory:AddPet(Pet.new('Bat', 'Battie', localPlayer))
inventory:AddPet(Pet.new('Dog', 'Dog', localPlayer))
inventory:AddPet(Pet.new('Cow', 'Cow', localPlayer))

module.inventory = inventory
module.equippedPets = {}
module.player = localPlayer

function module:GetGold(): number
    return localPlayer.leaderstats.Gold.Value
end

function module:AddGold(amount: number)
    localPlayer.leaderstats.Gold.Value += amount
end

return module
