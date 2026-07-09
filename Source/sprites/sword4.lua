local gfx <const> = playdate.graphics

local imageTable, message = gfx.imagetable.new(images.sword4)
assert(imageTable, message)

class("Swords").extends(gfx.sprite)

function Swords:init()
    Swords.super.init(self, imageTable[self.index])

    self:moveTo(200, 120)

    self.index = 1
end

function Swords:update()
    if self.index < #imageTable then
        self.index += 1
    else
        self.index = 1
    end

    self:setImage(imageTable[self.index])
end