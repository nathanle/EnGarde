import "CoreLibs/animation"
import "CoreLibs/object"
import "CoreLibs/graphics"
import "CoreLibs/sprites"

local gfx = playdate.graphics

local accumulatedRotation = 0
local speed = 2


local spriteSheet, message = gfx.imagetable.new("images/sword4-table-76-76")
assert(spriteSheet, message)

local animationLoop, message = gfx.animation.loop.new(200, spriteSheet, true)
assert(animationLoop, message)

local mySprite = gfx.sprite.new(animationLoop:image())
mySprite:moveTo(200, 120)
mySprite:add()

function playdate.update()
    local x, y = mySprite:getPosition()
    local crankDelta = playdate.getCrankChange()
    if playdate.buttonIsPressed(playdate.kButtonUp) then
        y = y - speed
    elseif playdate.buttonIsPressed(playdate.kButtonDown) then
        y = y + speed
    end

    if playdate.buttonIsPressed(playdate.kButtonLeft) then
        x = x - speed
    elseif playdate.buttonIsPressed(playdate.kButtonRight) then
        x = x + speed
    end
    
    if crankDelta ~= 0 then
        accumulatedRotation = accumulatedRotation + crankDelta
        mySprite:setRotation(accumulatedRotation)
    end
    
    --mySprite:setImage(animationLoop:image())
    mySprite:moveTo(x, y)
    gfx.sprite.update()
end