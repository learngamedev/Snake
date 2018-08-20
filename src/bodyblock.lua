BodyBlock = Class{}

BLOCK_WIDTH, BLOCK_HEIGHT = 15, 15

function BodyBlock:init(x, y)
    self.m_x, self.m_y = x, y
end

function BodyBlock:render()
    love.graphics.rectangle("line", self.m_x, self.m_y, BLOCK_WIDTH, BLOCK_HEIGHT)
end

function BodyBlock:move(newX, newY)
    self.m_x, self.m_y = newX, newY
end