require("src.dependencies")

function love.load()
    love.keyboard.keysPressed = {}
    snake = Snake()
    snake:init()

    food = Food()
    food:init()
end

function love.draw()
    if (not GAME_OVER) then
        food:render()
        snake:render()
    else love.graphics.print("GAME OVER", WINDOW_WIDTH / 2 - 35, WINDOW_HEIGHT / 2 - 10) end
end

function love.update(dt)
    if (not GAME_OVER) then
        snake:update(dt)
    end
    love.keyboard.keysPressed = {}
end