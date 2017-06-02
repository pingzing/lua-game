local _tileWidth
local _tileHeight
local _quads
local _tileset
local _tileTable
local _entityInfo
local _entities

function loadMap(path)
    love.filesystem.load(path)()
end

function newMap(tileWidth, tileHeight, tileSetPath, quadInfo, tileString, entityInfo, entities)

    _tileWidth = tileWidth
    _tileHeight = tileHeight
    _tileset = love.graphics.newImage(tileSetPath)      
    _entityInfo = entityInfo
    _entities = entities
    _quads = { }

    local tilesetHeight = _tileset:getHeight()
    local tilesetWidth = _tileset:getWidth()
     
    for _, info in ipairs(quadInfo) do
        _quads[info[1]] = love.graphics.newQuad(info[2], info[3], _tileWidth, _tileHeight, tilesetWidth, tilesetHeight)
    end

    for _, info in ipairs(entityInfo) do
        _quads[info[1]] = love.graphics.newQuad(info[2], info[3], tileWidth, tileHeight, tilesetWidth, tilesetHeight)
    end

    _tileTable = {}
    local width = #(tileString:match("[^\n]+"))
    for x = 1, width, 1 do _tileTable[x] = {} end

    local y, x = 1, 1    
    for row in tileString:gmatch("[^\n]+") do
        assert(#row == width, 'Map is not aligned: width of row ' .. tostring(y) .. ' should be ' .. tostring(width) .. ', but it is ' .. tostring(#row))
        x = 1
        for character in row:gmatch(".") do
            _tileTable[x][y] = character
            x = x + 1
        end
        y = y + 1
    end
end

function map2World(mapX, mapY)
    return (mapX - 1) * _tileWidth, (mapY - 1) * _tileHeight
end

function drawMap()
    for columnIndex, column in ipairs(_tileTable) do        
        for rowIndex, char in ipairs(column) do            
            local x, y = map2World(columnIndex, rowIndex)
            love.graphics.draw(_tileset, _quads[char], x, y)
        end
    end

    -- draw entities
    for i, entity in ipairs(_entities) do
        local name = entity[1]
        local x, y = map2World(entity[2], entity[3])
        love.graphics.draw(_tileset, _quads[name], x, y)
    end

end