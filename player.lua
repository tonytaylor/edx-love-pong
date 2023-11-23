
Player = Class{}

function Player:init(paddle, playerType, playerId)
    self.paddle = paddle
    self.type = playerType
    self.id = playerId
end

function Player:handleInput()
    if self.type == 'human' then
        if self.id == 'p1' then
            if love.keyboard.isDown('w') then
                self.paddle.dy = -PADDLE_SPEED
            elseif love.keyboard.isDown('s') then
                self.paddle.dy = PADDLE_SPEED
            else
                self.paddle.dy = 0
            end
        end

        if self.id == 'p2' then
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