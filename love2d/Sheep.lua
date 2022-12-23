Sheep = Object.extend(Object)

function Sheep.new(self, x, y, width, height)
    self.x = x
    self.y = y
    self.sprite = love.graphics.newImage("sheep.png")
    self.width = width
    self.height = height
end

function Sheep.draw(self)
    love.graphics.setColor(1,1,1)
    love.graphics.draw(self.sprite, 50, 50, 10, 2, 2, self.width/2, self.height/2)
end
