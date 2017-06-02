local _currentText = nil
local _coroutine = nil

function loadDialogue(path)
    -- load the script and wrap it in a coroutine
    local func = love.filesystem.load(path)
    _coroutine = coroutine.create(func)
end

function displayNextLine()
    if _coroutine then
        coroutine.resume(_coroutine)        
    end
end

function drawDialogue()
    if _currentText then
        love.graphics.print(_currentText)
    end
end

function isDialogueOpen()
    return _coroutine and coroutine.status(_coroutine) ~= "dead"    
end

function say(str)
    _currentText = str
    coroutine.yield()
    _currentText = nil
end