Food = Class{}

FOOD_WIDTH, FOOD_HEIGHT = 15, 15

function Food:init()
    local isSnakeBody = true
    while (isSnakeBody) do
        self.m_x = math.random(0, math.floor((WINDOW_WIDTH - FOOD_WIDTH) / FOOD_WIDTH)) * FOOD_WIDTH
        self.m_y = math.random(0, math.floor((WINDOW_HEIGHT - FOOD_HEIGHT) / FOOD_HEIGHT)) * FOOD_HEIGHT

        for i = 1, #snake.m_body do
            if (checkCollision(self.m_x, self.m_y, FOOD_WIDTH, FOOD_HEIGHT, snake.m_body[i].m_x, snake.m_body[i].m_y, BLOCK_WIDTH, BLOCK_HEIGHT)) then
                break
            end
            if (i == #snake.m_body) then isSnakeBody = false end
        end
    end
    print(self.m_x.." "..self.m_y)
end

function Food:render()
    love.graphics.rectangle("fill", self.m_x, self.m_y, FOOD_WIDTH, FOOD_HEIGHT)
end