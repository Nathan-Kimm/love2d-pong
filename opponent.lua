Opponent = {}

function Opponent:load()
    self.width = 20
    self.height = 100
    self.x = love.graphics.getWidth() - self.width - 50
    self.y = love.graphics.getHeight() / 2 - self.height / 2
    self.speed = 600
    self.xVelocity = 0
    self.yVelocity = 0
end

function Opponent:update(dt)
    self:move(dt)
    self:trackTarget()
end

function Opponent:move(dt)
    self.y = self.y + self.yVelocity * dt
end

function Opponent:trackTarget()
    if Ball.y < self.y then
        self.yVelocity = -self.speed
    elseif Ball.y > self.y + self.height then
        self.yVelocity = self.speed
    else 
        self.yVelocity = 0
    end
end
 
function Opponent:draw()
    love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)
end
