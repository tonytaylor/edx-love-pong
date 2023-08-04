push = require('push')

WINDOW_WIDTH  = 1280
WINDOW_HEIGHT = 720

VIRTUAL_WIDTH  = 432
VIRTUAL_HEIGHT = 243

PADDLE_SPEED = 200

GAME_STATE = { IDLE = 0, PLAY = 1 }



function love.load()
    love.graphics.setDefaultFilter('nearest', 'nearest')

    math.randomseed(os.time())
    
    smallFont = love.graphics.newFont('font.ttf', 8)
    scoreFont = love.graphics.newFont('font.ttf', 32)
    
    love.graphics.setFont(smallFont)

    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        fullscreen = false,
        resizable = false,
        vsync = true
    })

    p1Score = 0
    p2Score = 0

    p1Y = 30
    p2Y = VIRTUAL_HEIGHT - 50

    ballX = VIRTUAL_WIDTH / 2 - 2
    ballY = VIRTUAL_HEIGHT / 2 - 2

    ballDX = math.random(2) == 1 and 100 or -100
    ballDY = math.random(-50, 50)

    gameState = GAME_STATE.IDLE
end

function love.update(dt)
    managePlayer(1, dt)
    managePlayer(2, dt)
    manageBall(dt)
end

function love.keypressed(key)
    if key == 'escape' then
        love.event.quit()
    elseif key == 'enter' or key == 'return' then
        if gameState == GAME_STATE.IDLE then
            gameState = GAME_STATE.PLAY
        else
            gameState = GAME_STATE.IDLE
        end
    end
end

function love.draw()
    push:apply('start')
    -- wipes the entire screen with a color defined by a RGBA set, each component a value from 0 - 255
    love.graphics.setFont(smallFont)
    love.graphics.clear(40/255, 45/255, 52/255, 255/255)
    
    renderTitle()
    renderScore()
    renderActors()

    push:apply('end')
end

function renderTitle()
    love.graphics.printf('Hello Pong!', 0, 20, VIRTUAL_WIDTH, 'center')
    --if gameState == 'playing' then
    --    love.graphics.printf("Let's go!", 0, 20, VIRTUAL_WIDTH, 'center')
    --end
end

function renderScore()
    love.graphics.setFont(scoreFont)
    love.graphics.print(tostring(p1Score), VIRTUAL_WIDTH / 2 - 50, VIRTUAL_HEIGHT / 3)
    love.graphics.print(tostring(p2Score), VIRTUAL_WIDTH / 2 + 30, VIRTUAL_HEIGHT / 3)
end

function renderActors()
    love.graphics.rectangle('fill', 10, p1Y, 5, 20) -- player one paddle
    love.graphics.rectangle('fill', VIRTUAL_WIDTH - 10, p2Y, 5, 20) -- player two paddle
    love.graphics.rectangle('fill', ballX, ballY, 4, 4) -- ball (center)
end

-- Player Management
function managePlayer(id, dt)
    if id == 1 then
        if love.keyboard.isDown('w') then
            p1Y = math.max(0, p1Y + -PADDLE_SPEED * dt)
        elseif love.keyboard.isDown('s') then
            p1Y = math.min(VIRTUAL_HEIGHT - 20, p1Y + PADDLE_SPEED * dt)
        end
    elseif id == 2 then
        if love.keyboard.isDown('up') then
            -- p2Y = p2Y + -PADDLE_SPEED * dt
            p2Y = math.max(0, p2Y + - PADDLE_SPEED * dt)
        elseif love.keyboard.isDown('down') then
            -- p2Y = p2Y + PADDLE_SPEED * dt
            p2Y = math.min(VIRTUAL_HEIGHT - 20, p2Y + PADDLE_SPEED * dt)
        end
    end
end

function manageBall(dt)
    if gameState == GAME_STATE.PLAY then
        ballX = ballX + ballDX * dt
        ballY = ballY + ballDY * dt
    end
end