local UserInputService = game:GetService('UserInputService')
local LocalPlayerManager = require(game.StarterPlayer.StarterPlayerScripts.ClientModules.LocalPlayerManager)

local inventory = LocalPlayerManager.inventory

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
