push = require 'push'

Class = require 'class'

require 'Paddle'

require 'Ball'

-- tamaño de la ventana
WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

-- tamaño de la pantalla virtual
VIRTUAL_WIDTH = 432
VIRTUAL_HEIGHT = 243

PADDLE_SPEED = 200

-- funcion para configurar la pantalla
function love.load()
    love.graphics.setDefaultFilter('nearest','nearest')

    math.randomseed(os.time())
    
    smallFont = love.graphics.newFont('font.ttf', 8)

    love.graphics.setFont(smallFont)

    push:setupScreen(VIRTUAL_WIDTH,VIRTUAL_HEIGHT,WINDOW_WIDTH, WINDOW_HEIGHT, {
        fullscreen = false,
        resizable = false,
        vsync = true
    })


    player1 = Paddle(10, 30, 5, 20)
    player2 = Paddle(VIRTUAL_WIDTH - 10, VIRTUAL_HEIGHT - 30, 5, 20)
    ball = Ball(VIRTUAL_WIDTH / 2 * 2, VIRTUAL_HEIGHT / 2 - 2, 4, 4)
    gameState = 'start'

end

function love.update(dt)
    -- movimientos jugador 1
    if love.keyboard.isDown('w') then 
        player1.dy = -PADDLE_SPEED
    elseif love.keyboard.isDown('s') then
        player1.dy = PADDLE_SPEED
    else
        player1.dy = 0
    end

    -- movimientos jugador 2
    if love.keyboard.isDown('up') then 
        player2.dy = -PADDLE_SPEED
    elseif love.keyboard.isDown('down') then
        player2.dy = PADDLE_SPEED
    else
        player2.dy = 0
    end

    if gameState == 'play' then 
        ball:update(dt)
    end

    player1:update(dt)
    player2:update(dt)
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
            ball:reset() 
        end
    end
end

-- funcion para dibujar la pantalla
function love.draw()
    scoreFont =  love.graphics.newFont('font.ttf', 32)

    push:start()

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

    player1:render()
    player2:render()
    ball:render()
    push:finish()
end




