push = require 'push'

-- tamaño de la ventana
WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

-- tamaño de la pantalla virtual
VIRTUAL_WIDTH = 432
VIRTUAL_HEIGHT = 243

PADDLE_SPEED = 200

-- funcion para configurar la pantalla
function love.load()
    push:setupScreen(VIRTUAL_WIDTH,VIRTUAL_HEIGHT,WINDOW_WIDTH, WINDOW_HEIGHT, {
        fullscreen = false,
        resizable = false,
        vsync = true
    })

    player1Score = 0
    player2Score = 0

    player1Y = 30
    player2Y = VIRTUAL_HEIGHT - 50

    ballX = VIRTUAL_WIDTH / 2 - 2
    ballY = VIRTUAL_HEIGHT / 2 - 2
    ballDX = math.random(2) == 1 and 100 or -100
    ballDY = math.random(-50, 50)

    gameState = 'start'
end

function love.update(dt)
    -- movimientos jugador 1
    if love.keyboard.isDown('w') then 
        player1Y = math.max(0, player1Y - PADDLE_SPEED * dt)
    elseif love.keyboard.isDown('s') then
        player1Y = math.min(VIRTUAL_HEIGHT - 20, player1Y + PADDLE_SPEED * dt)
    end

    -- movimientos jugador 2
    if love.keyboard.isDown('up') then
        player2Y = math.max(0, player2Y - PADDLE_SPEED * dt)
    elseif love.keyboard.isDown('down') then
        player2Y = math.min(VIRTUAL_HEIGHT - 20, player2Y + PADDLE_SPEED * dt)
    end

    if gameState == 'play' then 
        ballX = ballX + ballDX * dt
        ballY = ballY + ballDY * dt
    end
end


-- funcion para manejar los eventos de teclado
function love.keypressed(key)
    if key == 'escape' then
        love.event.quit()
    elseif key == 'enter' or key == 'return' then
        if gameState == 'start' then
            gameState = 'play'
        else
            gameState = 'start'

            -- pelota al medio
            ballX = VIRTUAL_WIDTH / 2 - 2
            ballY = VIRTUAL_HEIGHT / 2 - 2

            ballDX = math.random(2) == 1 and 100 or -100
            ballDY = math.random(-50, 50) * 1.5
        end
    end
end

-- funcion para dibujar la pantalla
function love.draw()
    love.graphics.setDefaultFilter('nearest','nearest')

    math.randomseed(os.time())
    
    smallFont = love.graphics.newFont('font.ttf', 8)
    
    scoreFont =  love.graphics.newFont('font.ttf', 32)

    love.graphics.setFont(smallFont)
    push:apply('start')

    -- fondo de la pantalla
    -- LÖVE 11 usa colores de 0 a 1; el ejemplo de CS50 (0.10) usa 0 a 255
    love.graphics.clear(love.math.colorFromBytes(40, 45, 52, 255))
    -- texto en el centro de la pantalla
    if gameState == 'start' then
        love.graphics.printf('Hello Start State!', 0, 20, VIRTUAL_WIDTH, 'center')
    else
        love.graphics.printf('Hello Play State!', 0, 20, VIRTUAL_WIDTH, 'center')
    end

    love.graphics.setFont(scoreFont)
    love.graphics.print(tostring(player1Score), VIRTUAL_WIDTH / 2 - 50, VIRTUAL_HEIGHT / 3)
    love.graphics.print(tostring(player2Score), VIRTUAL_WIDTH / 2 + 30, VIRTUAL_HEIGHT / 3)

    -- primer rectangulo a la izquierda
    love.graphics.rectangle('fill', 10, player1Y, 5, 20)

    -- segundo rectangulo a la derecha
    love.graphics.rectangle('fill', VIRTUAL_WIDTH - 10, player2Y, 5, 20)

    -- pelota
    love.graphics.rectangle ('fill', ballX, ballY, 4 ,4)
    push:apply('end')
end
