local openQuestPopupEvent: RemoteEvent = game.ReplicatedStorage.Remotes:WaitForChild('OpenQuestPopupEvent')
local player = game.Players.LocalPlayer
local popup: Frame = player:WaitForChild('PlayerGui'):WaitForChild('Main'):WaitForChild('Quest'):WaitForChild('Popup')
local titleLabel: TextLabel = popup:WaitForChild('Title')
local descriptionLabel: TextLabel = popup:WaitForChild('Description')
local expRewardLabel: TextLabel = popup:WaitForChild('ExpReward')
local goldRewardLabel: TextLabel = popup:WaitForChild('GoldReward')
local timeRequiredLabel: TextLabel = popup:WaitForChild('TimeRequired')
local acceptButton: TextButton = popup:WaitForChild('AcceptButton')
local declineButton: TextButton = popup:WaitForChild('DeclineButton')

local function OpenPopup(quest)
    titleLabel.Text = quest.title
    descriptionLabel.Text = quest.description
    expRewardLabel.Text = 'Exp: ' .. quest.expReward
    goldRewardLabel.Text = 'Gold: ' .. quest.goldReward
    timeRequiredLabel.Text = 'Time: ' .. quest.timeLimit

    popup.Visible = true
end

openQuestPopupEvent.OnClientEvent:Connect(OpenPopup)
declineButton.MouseButton1Click:Connect(function()
    popup.Visible = false
end)
