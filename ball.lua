Ball = {}

function Ball:load()
    self.x = love.graphics.getWidth() / 2
    self.y = love.graphics.getHeight() / 2
    self.sprite = love.graphics.newImage("assets/ball.png")
    self.width = self.sprite:getWidth()
    self.height = self.sprite:getHeight()
    self.speed = 200
    self.xVelocity = -self.speed
    self.yVelocity = 0
end

function Ball:update(dt)
    self:move(dt)
    self:collision()
end

function Ball:move(dt)  
    self.x = self.x + self.xVelocity * dt
    self.y = self.y + self.yVelocity * dt
end

function Ball:collision()
    self:playerCollision()
    self:opponentCollision()
    self:boundaryCollision()
    self:updateScore()
end

function Ball:playerCollision()
    if checkCollisions(self, Player) then
        self.xVelocity = self.speed
        local middleBall = self.y + self.height / 2
        local middlePlayer = Player.y + Player.height / 2
        local collisionPosition = middleBall - middlePlayer
        self.yVelocity = collisionPosition * 5
    end
end

function Ball:opponentCollision()
    if checkCollisions(self, Opponent) then
        self.xVelocity = -self.speed
        local middleBall = self.y + self.height / 2
        local middleOpponent = Opponent.y + Opponent.height / 2
        local collisionPosition = middleBall - middleOpponent
        self.yVelocity = collisionPosition * 5
    end
end

function Ball:boundaryCollision()
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
        self:resetPosition(1)
        Score.computer = Score.computer + 1
    elseif self.x + self.width > love.graphics.getWidth() then
        self:resetPosition(-1)
        Score.player = Score.player + 1
    end
end

function Ball:resetPosition(direction)
    self.x = love.graphics.getWidth() / 2
    self.y = love.graphics.getHeight() / 2
    self.xVelocity = self.speed * direction
    self.yVelocity = 0
end

function Ball:draw()
    love.graphics.draw(self.sprite, self.x, self.y)
end