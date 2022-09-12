local module = {}

local Inventory = require(game.StarterPlayer.StarterPlayerScripts.ClientModules.Inventory)
local Pet = require(game.ReplicatedStorage.CommonModules.Pet)

task.wait(5)
print('>>> Initilized inventory')
local inventory = Inventory.new(10, 2)
local fox = Pet.new('Fox', 'Foxy')
local fox2 = Pet.new('Fox', 'Foxy2')
local bat = Pet.new('Bat', 'Battie')
inventory:AddPet(fox)
inventory:AddPet(fox2)
inventory:AddPet(bat)

module.inventory = inventory

return module
