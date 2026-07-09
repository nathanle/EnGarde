import "CoreLibs/graphics"
import "CoreLibs/object"
import "CoreLibs/sprites"

local playerSprite = nil
local Player = {}
local gfx <const> = playdate.graphics


dvd={}
class("dvd").extends()


function Player:init()
	
	Player.super.init(self)

	self.playerImages = playdate.graphics.imagetable.new('images/sword4_rot')
	self:setImage(self.playerImages:getImage(1))
	self:setZIndex(1000)
	self:setCenter(0.5, 1)	-- set center point to center bottom middle
	self:moveTo(102, 210)
	self:setCollideRect(2,0,16-4,32)
	
	self.position = Point.new(102, 210)
	self.velocity = vector2D.new(0,0)
	self:setCollideRect(0, 0, 48, 48)
	self:setZIndex(800)
	self:reset()
	self:addSprite()
end

function dvd:init(xspeed, yspeed)
	--local playerImage = gfx.image.new("images/sword4")
	-- playerSprite = gfx.sprite.new(playerImage)
	-- playerSprite:moveTo(200, 120)
	-- playerSprite:add()
    self.label = {
		x = 155,
		y = 110,
		xspeed = xspeed,
		yspeed = yspeed,
		width = 100,
		height = 20,
		angle = 0
	}
end

function dvd:swapColors()
	if (gfx.getBackgroundColor() == gfx.kColorWhite) then
		gfx.setBackgroundColor(gfx.kColorBlack)
		gfx.setImageDrawMode("inverted")
	else
		gfx.setBackgroundColor(gfx.kColorWhite)
		gfx.setImageDrawMode("copy")
	end
end

function dvd:update()
    local label = self.label;
    local swap = false
	label.angle = tostring(playdate.getCrankPosition())
	print(tostring(playdate.getCrankPosition()))
    --[[
	if (label.x + label.width >= 400 or label.x <= 0) then
        label.xspeed = -label.xspeed;
		swap = true
    end
    
    if (label.y + label.height >= 240 or label.y <= 0) then
        label.yspeed = -label.yspeed;
		swap = true
	end

	if (swap) then
		self:swapColors()
	end

	label.x += label.xspeed
	label.y += label.yspeed
	--]]
end

function dvd:draw()
	gfx.sprite.update()
    local label = self.label;
    -- gfx.drawTextInRect(label.angle, label.x, label.y, label.width, label.height)
end
