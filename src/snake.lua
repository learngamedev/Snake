Snake = Class {}

local SNAKE_SPEED = 15
local MOVE_COUNTDOWN = 50

function Snake:init()
    self.m_x, self.m_y = 0, 0
    -- Create 1 block long snake
    self.m_body = {}
    table.insert(self.m_body, BodyBlock())
    self.m_body[1]:init(self.m_x, self.m_y)
    -- Set starting move directions
    self.m_deltaX = 0
    self.m_deltaY = 1
    self.m_turned = false
end

function Snake:render()
    for k, v in ipairs(self.m_body) do
        v:render()
    end
end

function Snake:update(dt)
    if (MOVE_COUNTDOWN ~= 0) then
        Snake:turn(self, dt)
        Snake:eatFood(self, dt)
    end

    if (Snake:crash(self)) then GAME_OVER = true end

    if (MOVE_COUNTDOWN == 0) then
        Snake:move(self, dt)
        -- reset move timer
        MOVE_COUNTDOWN = 50
        self.m_turned = false
    else MOVE_COUNTDOWN = math.max(0, MOVE_COUNTDOWN - 100 * dt) end
end

function Snake:turn(self, dt)
    if (not self.m_turned) then
        if (love.keyboard.wasPressed("up")) and (self.m_deltaY ~= 1) then self.m_deltaX, self.m_deltaY, self.m_turned = 0, -1, true
        else if (love.keyboard.wasPressed("down")) and (self.m_deltaY ~= -1) then self.m_deltaX, self.m_deltaY, self.m_turned = 0, 1, true
            else if (love.keyboard.wasPressed("right")) and (self.m_deltaX ~= -1) then self.m_deltaX, self.m_deltaY, self.m_turned = 1, 0, true
                elseif (love.keyboard.wasPressed("left")) and (self.m_deltaX ~= 1) then self.m_deltaX, self.m_deltaY, self.m_turned = -1, 0, true end
            end
        end
    end
end

function Snake:move(self, dt)
    -- Update body of snake's position
    for i = #self.m_body, 2, -1 do
        (self.m_body[i]):move(self.m_body[i - 1].m_x, self.m_body[i - 1].m_y)
    end
    -- Update head of snake's position
    self.m_body[1]:move(self.m_x + self.m_deltaX * SNAKE_SPEED, self.m_y + self.m_deltaY * SNAKE_SPEED)
    self.m_x, self.m_y = self.m_x + self.m_deltaX * SNAKE_SPEED, self.m_y + self.m_deltaY * SNAKE_SPEED
end

function Snake:eatFood(self, dt)
    if (checkCollision(self.m_x, self.m_y, BLOCK_WIDTH, BLOCK_HEIGHT, food.m_x, food.m_y, FOOD_WIDTH, FOOD_HEIGHT)) then
        food:init()
        Snake:addTail(self)
    end
end

function Snake:addTail(self)
    table.insert(self.m_body, BodyBlock())
    if (#self.m_body == 2) then
        self.m_body[2]:init(self.m_x - BLOCK_WIDTH * self.m_deltaX, self.m_y - BLOCK_HEIGHT * self.m_deltaY)
    else
        local lastX, lastY = self.m_body[#self.m_body - 1].m_x, self.m_body[#self.m_body - 1].m_y
        local lastDeltaX = (self.m_body[#self.m_body - 2].m_x - lastX) / BLOCK_WIDTH
        local lastDeltaY = (self.m_body[#self.m_body - 2].m_y - lastY) / BLOCK_HEIGHT
        self.m_body[#self.m_body]:init(lastX - lastDeltaX * BLOCK_WIDTH, lastY - lastDeltaY * BLOCK_HEIGHT)
    end
end

function Snake:crash(self)
    -- Check if hit body
    for i = 2, #self.m_body do
        if checkCollision(self.m_x, self.m_y, BLOCK_WIDTH, BLOCK_HEIGHT, self.m_body[i].m_x, self.m_body[i].m_y, BLOCK_WIDTH, BLOCK_HEIGHT) then
            return true
        end
    end
    -- Check if hit walls
    if (self.m_x < 0) or (self.m_y < 0) or (self.m_x >= WINDOW_WIDTH) or (self.m_y >= WINDOW_HEIGHT) then print("Wall") return true end
    return false
end