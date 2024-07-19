require "player"
require "ball"
require "opponent"
require "background"

function love.load()
    Background:load()
    Player:load()
    Ball:load()
    Opponent:load()

    Score = {player = 0, computer = 0}
    font = love.graphics.newFont(30)
end

function love.update(dt)
    Background:update(dt)
    Player:update(dt)
    Ball:update(dt)
    Opponent:update(dt)
end

function love.draw()
    --Background needs to first be drawn so it doesnt overlap other elements
    Background:draw()
    Player:draw()
    Ball:draw()
    Opponent:draw()
    drawScore()
end

function drawScore()
    love.graphics.setFont(font)
    love.graphics.print("Player: " .. Score.player, 250, 0)
    love.graphics.print("Computer: " .. Score.computer, 850, 0)
end

function checkCollisions(a, b)
    if a.x + a.width > b.x and a.x < b.x + b.width and a.y + a.height > b.y and a.y < b.y + b.height then
        return true
    else 
        return false
    end
end

