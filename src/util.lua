-- AABB collision check
function checkCollision(x1,y1,w1,h1,x2,y2,w2,h2)
    return x1 < x2+w2 and
           x2 < x1+w1 and
           y1 < y2+h2 and
           y2 < y1+h1
end

-- Keyboard input handler
function love.keypressed(key)
    -- Turn on/off debug mode
    if key == "rctrl" then --set to whatever key you want to use
        debug.debug()
    end

	love.keyboard.keysPressed[key] = true
end

function love.keyboard.wasPressed(key)
	return love.keyboard.keysPressed[key]
end