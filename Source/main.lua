import "CoreLibs/animation"
import "CoreLibs/object"
import "CoreLibs/graphics"
import "CoreLibs/sprites"

local gfx = playdate.graphics

local accumulatedRotation = 0

local spriteSheet, message = gfx.imagetable.new("images/sword4-table-76-76")
assert(spriteSheet, message)

local animationLoop, message = gfx.animation.loop.new(200, spriteSheet, true)
assert(animationLoop, message)

local mySprite = gfx.sprite.new(animationLoop:image())
mySprite:moveTo(200, 120)
mySprite:add()

function playdate.update()
    local crankDelta = playdate.getCrankChange()
    
    -- 3. Update rotation if the crank is moving
    if crankDelta ~= 0 then
        accumulatedRotation = accumulatedRotation + crankDelta
        mySprite:setRotation(accumulatedRotation)
    end
    
    --mySprite:setImage(animationLoop:image())
    gfx.sprite.update()
end