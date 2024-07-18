local playerScore = 0
local opponentScore = 0
Ball = {}

function Ball:load()
    self.x = love.graphics.getWidth() / 2
    self.y = love.graphics.getHeight() / 2
    self.width = 25
    self.height = 25
    self.speed = 200
    self.xVelocity = -self.speed
    self.yVelocity = 0
end

function Ball:update(dt)
    Ball:move(dt)
    Ball:collision()
    Ball:updateScore()
end

function Ball:move(dt)  
    self.x = self.x + self.xVelocity * dt
    self.y = self.y + self.yVelocity * dt
end

function Ball:collision()
    if checkCollisions(self, Player) then
        self.xVelocity = self.speed
        local middleBall = self.y + self.height / 2
        local middlePlayer = Player.y + Player.height / 2
        local collisionPosition = middleBall - middlePlayer
        self.yVelocity = collisionPosition * 5
    end

    if checkCollisions(self, Opponent) then
        self.xVelocity = -self.speed
        local middleBall = self.y + self.height / 2
        local middleOpponent = Opponent.y + Opponent.height / 2
        local collisionPosition = middleBall - middleOpponent
        self.yVelocity = collisionPosition * 5
    end

    if self.y < 0 then
        self.y = 0
        self.yVelocity = -self.yVelocity
    elseif self.y + self.height > love.graphics.getHeight() then
        self.y = love.graphics.getHeight() - self.height
        self.yVelocity = -self.yVelocity
    end
end

function Ball:updateScore()
    if self.x < 0 then
        opponentScore = opponentScore + 1
        self.x = love.graphics.getWidth() / 2
        self.y = love.graphics.getHeight() / 2
        self.xVelocity = self.speed
        self.yVelocity = 0
    elseif self.x + self.width > love.graphics.getWidth() then
        playerScore = playerScore + 1
        self.x = love.graphics.getWidth() / 2
        self.y = love.graphics.getHeight() / 2
        self.xVelocity = -self.speed
        self.yVelocity = 0
    end
end

function Ball:draw()
    love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)
end