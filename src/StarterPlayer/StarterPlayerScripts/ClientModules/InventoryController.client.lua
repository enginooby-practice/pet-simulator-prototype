local UserInputService = game:GetService('UserInputService')
local Inventory = require(game.StarterPlayer.StarterPlayerScripts.ClientModules.Inventory)
local Pet = require(game.ReplicatedStorage.CommonModules.Pet)

task.wait(5)
print('>>> Initilized inventory')
local inventory = Inventory.new(10)
local fox = Pet.new('Fox', 'Foxy')
local bat = Pet.new('Bat', 'Battie')
inventory:AddPet(fox)
inventory:AddPet(bat)

local function onInputEnded(inputObject: InputObject, gameProcessedEvent)
    if gameProcessedEvent then
        return
    end

    if inputObject.UserInputType ~= Enum.UserInputType.Keyboard then
        return
    end

    if inputObject.KeyCode == Enum.KeyCode.U then
        inventory:Toggle()
    end

    if not inventory:IsOpen() then
        return
    end

    inventory:Equip(inputObject.KeyCode.Value - 48)
end

UserInputService.InputEnded:Connect(onInputEnded)
