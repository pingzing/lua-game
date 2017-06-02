require "map-functions"
require "dialogue"

function love.load()
    loadMap("maps/cafe.lua")
    loadDialogue("dialogscripts/test.lua")       
end

function love.update(deltaTime)
    
end

function love.draw()
   drawMap()
   drawDialogue()
end

function love.keypressed(key)
    if isDialogueOpen() and key == "space" then
         displayNextLine()
    end
end

function love.keyreleased(key)
    --
end

function love.quit()    
    love.graphics.print("Thanks for playing!", 400, 400)   
    love.update()
end