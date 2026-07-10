import "CoreLibs/animation"
import "CoreLibs/object"
import "CoreLibs/graphics"
import "CoreLibs/sprites"

local gfx = playdate.graphics

local accumulatedRotation = 0

local geom = playdate.geometry

local speed = 2

-- import "needle"

local spriteSheet, message = gfx.imagetable.new("images/sword4-table-76-76")
assert(spriteSheet, message)

local animationLoop, message = gfx.animation.loop.new(200, spriteSheet, true)
assert(animationLoop, message)

local mySprite = gfx.sprite.new(animationLoop:image())
mySprite:moveTo(200, 120)
mySprite:add()

local myRect = geom.rect.new(300, 120, 20, 100)
local rx, ry, rw, rh = myRect:unpack()

gfx.sprite.setBackgroundDrawingCallback(
    function( x, y, width, height )
        gfx.setClipRect( x, y, width, height ) -- let's only draw the part of the screen that's dirty
        gfx.fillRect(rx, ry, rw, rh)
        gfx.clearClipRect() -- clear so we don't interfere with drawing that comes after this
        
    end
)


function playdate.update()

    local x, y = mySprite:getPosition()

    local crankAngle = 0
    local crankDelta = 0

    if not playdate.isCrankDocked() then
        crankDelta = playdate.getCrankChange()
        crankAngle = playdate.getCrankPosition()
    end

    if playdate.isCrankDocked() then
        crankDelta = 0
        crankAngle = 0
        mySprite:setRotation(0)
    end

    --local rect = geom.rect.new(200, 120, 20, 100)
    --local rectPolygon = rect:toPolygon()
    --local transform = geom.affineTransform.new()
    
    --transform:rotate(crankAngle, 200, 120)
    --local rotatedPoly = transform:transformedPolygon(rectPolygon)
    --gfx.drawPolygon(rotatedPoly)

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

 


    -- function Needle:draw()
    --    gfx.fillRect(0, 0, self.width, self.height)
    -- end

    mySprite:moveTo(x, y)
    gfx.sprite.update()
end