push = require 'push'

-- tamaño de la ventana
WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

-- tamaño de la pantalla virtual
VIRTUAL_WIDTH = 432
VIRTUAL_HEIGHT = 243

-- funcion para configurar la pantalla
function love.load()
    push:setupScreen(VIRTUAL_WIDTH,VIRTUAL_HEIGHT,WINDOW_WIDTH, WINDOW_HEIGHT, {
        fullscreen = false,
        resizable = false,
        vsync = true
    })
end
-- funcion para manejar los eventos de teclado
function love.keypressed(key)
    if key == 'escape' then
        love.event.quit()
    end
end

-- funcion para dibujar la pantalla
function love.draw()
    love.graphics.setDefaultFilter('nearest','nearest')

    -- fuente pequeña
    smallFont = love.graphics.newFont('font.ttf', 8)
    love.graphics.setFont(smallFont)
    push:apply('start')

    -- fondo de la pantalla
    -- LÖVE 11 usa colores de 0 a 1; el ejemplo de CS50 (0.10) usa 0 a 255
    love.graphics.clear(love.math.colorFromBytes(40, 45, 52, 255))
    -- texto en el centro de la pantalla
    love.graphics.printf(
        'Hello Pong!',
        0,
        20,
        VIRTUAL_WIDTH,
        'center'
    )
    -- primer rectangulo a la izquierda
    love.graphics.rectangle('fill', 10, 30, 5, 20)

    -- segundo rectangulo a la derecha
    love.graphics.rectangle('fill', VIRTUAL_WIDTH - 10, VIRTUAL_HEIGHT - 50, 5, 20)

    -- pelota
    love.graphics.rectangle ('fill', VIRTUAL_WIDTH / 2 - 2, VIRTUAL_HEIGHT / 2 - 2, 4 ,4)
    push:apply('end')
end
