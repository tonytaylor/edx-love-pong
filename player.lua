
Player = Class{}

function Player:init(paddle, playerType, playerId)
    self.paddle = paddle
    self.type = playerType
    self.id = playerId
end

function Player:render()
    if gameState == 'play' then
        love.graphics.setFont(smallFont)
        love.graphics.setColor(0, 255/255, 0, 255/255)
        love.graphics.print('Ball Y: ' .. tostring(ball.y), 10, 24)
        love.graphics.print('Player Paddle Y: ' .. tostring(player2.y), 10, 38)
        love.graphics.setColor(255, 255, 255, 255)
    end
end

function Player:handleInput()
    if self.type == 'human' then
        if self.id == 'player1' then
            if love.keyboard.isDown('w') then
                self.paddle.dy = -PADDLE_SPEED
            elseif love.keyboard.isDown('s') then
                self.paddle.dy = PADDLE_SPEED
            else
                self.paddle.dy = 0
            end
        end

        if self.id == 'player2' then
            if love.keyboard.isDown('up') then
                self.paddle.dy = -PADDLE_SPEED
            elseif love.keyboard.isDown('down') then
                self.paddle.dy = PADDLE_SPEED
            else
                self.paddle.dy = 0
            end
        end
    end 
end

function Player:update(dt)
    if self.type == 'computer' then
        if self.paddle.y > ball.y then
            self.paddle.dy = -PADDLE_SPEED
        elseif self.paddle.y < ball.y then
            self.paddle.dy = PADDLE_SPEED
        else
            self.paddle.dy = 0
        end
    end
end