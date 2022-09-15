local questPrefab = game.ReplicatedStorage:WaitForChild('Quest')
local openQuestPopupEvent: RemoteEvent = game.ReplicatedStorage.Remotes:WaitForChild('OpenQuestPopupEvent')
local Pet = require(game.ReplicatedStorage.CommonModules.Pet)
type Pet = typeof(Pet.new())

Quest = {}
Quest.__index = Quest

function Quest.new(
    position: Vector3,
    title: string,
    description: string,
    timeLimit: number,
    expReward: number,
    expPenalty: number,
    goldReward: number
)
    local self = {}
    setmetatable(self, Quest)

    self.title = title
    self.description = description
    self.timeLimit = timeLimit
    self.expReward = expReward
    self.expPenalty = expPenalty
    self.goldReward = goldReward
    self.isCompleted = false

    local model: Model = questPrefab:Clone()
    model.Parent = game.Workspace.Quests
    model:MoveTo(position)

    local clickDetector = Instance.new('ClickDetector', model)
    clickDetector.MaxActivationDistance = 15
    clickDetector.MouseClick:Connect(function(player: Player)
        self:SetTaker(player, nil)
        self:Show()
    end)

    return self
end

function Quest:SetTaker(player: Player, pet: Pet)
    self.player = player
    self.pet = pet
end

function Quest:Show()
    openQuestPopupEvent:FireClient(self.player, self)
end

function Quest:Hide() end

function Quest:Decline() end

function Quest:Start()
    task.wait(self.timeLimit)

    if not self.isCompleted then
        self:Fail()
    end
end

function Quest:Fail()
    self.pet:AddExp(self.expPenalty)
end

function Quest:Complete()
    self.isCompleted = true
    self.player.leaderstats.Gold.Value += self.goldReward
    self.pet:AddExp(self.expReward)
end

return Quest
