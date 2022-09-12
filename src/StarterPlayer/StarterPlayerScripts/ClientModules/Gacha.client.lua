local Pet = require(game.ReplicatedStorage.CommonModules.Pet)
local LocalPlayerManager = require(game.StarterPlayer.StarterPlayerScripts.ClientModules.LocalPlayerManager)

local speed = 0.5
local spinWheel = workspace:FindFirstChild('Spin Wheel')
local wheel = spinWheel:FindFirstChild('Wheel') :: Part
local wheelButton = spinWheel:FindFirstChild('Head', true)
local pop = wheelButton.Parent.Parent.pop

repeat
    task.wait()
until LocalPlayerManager.inventory

print('>>> Initialized Gacha')

local pets = {
    [1] = 'Bat',
    [2] = 'Fox',
    [3] = 'Bat',
    [4] = 'Fox',
    [5] = 'Bat',
    [6] = 'Fox',
}

function onClicked()
    if pop.TopParamB == 0 then
        pop.TopParamB = speed

        task.wait(math.random(3, 5))
        pop.TopParamB = 0

        local index = math.ceil(wheel.Rotation.X / 360 * #pets) + #pets / 2
        local pet = Pet.new(pets[index], pets[index] .. math.random(1, 999))
        LocalPlayerManager.inventory:AddPet(pet)
    end
end

wheelButton.ClickDetector.MouseClick:connect(onClicked)
