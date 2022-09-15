local SPEED = 0.5
local COST = 100

local Pet = require(game.ReplicatedStorage.CommonModules.Pet)
local LocalPlayerManager = require(game.StarterPlayer.StarterPlayerScripts.ClientModules.LocalPlayerManager)
local spinWheel = workspace:FindFirstChild('Spin Wheel')
local wheel = spinWheel:FindFirstChild('Wheel') :: Part
local wheelButton = spinWheel:FindFirstChild('Head', true)
local pop = wheelButton.Parent.Parent.pop
local gachaUI: Frame = game.Players.LocalPlayer:WaitForChild('PlayerGui'):WaitForChild('Main'):WaitForChild('Gacha')
local rewardedPetIcon: ImageLabel = gachaUI:WaitForChild('RewardedPetIcon')

repeat
    task.wait()
until LocalPlayerManager.inventory

print('>>> Initialized Gacha')

local pets = {
    [1] = 'Bat',
    [2] = 'Fox',
    [3] = 'Bat',
    [4] = 'Fox',
    [5] = 'Dog',
    [6] = 'Cow',
}

function onClicked()
    if LocalPlayerManager:GetGold() < COST then
        print('<<< Not enough gold.')
        return
    end

    -- FIX: Sometimes not spinning
    if pop.TopParamB == 0 then
        print('>>> Spinning')
        pop.TopParamB = SPEED

        task.wait(math.random(2.3, 4.2))
        pop.TopParamB = 0

        local index = math.ceil(wheel.Rotation.X / 360 * #pets) + #pets / 2
        local pet = Pet.new(pets[index], pets[index] .. math.random(1, 99), LocalPlayerManager.player)
        LocalPlayerManager.inventory:AddPet(pet)
        LocalPlayerManager:AddGold(-COST)

        gachaUI.Visible = true
        rewardedPetIcon.Image = pet.icon
        task.wait(1.5)
        gachaUI.Visible = false
    end
end

wheelButton.ClickDetector.MouseClick:connect(onClicked)
