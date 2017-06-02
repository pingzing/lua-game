require "map-functions"

function love.load()
    loadMap("maps/cafe.lua")        
end

function love.update(deltaTime)
    
end

function love.draw()
   drawMap()
end

function love.keypressed(key)
    -- 
end

function love.keyreleased(key)
    --
end

function love.quit()    
    love.graphics.print("Thanks for playing!", 400, 400)   
    love.update()
end