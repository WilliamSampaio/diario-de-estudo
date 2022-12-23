Object = require "classic"
require "Sheep"
require "Gun"

function Draw_crosshair(x, y)
	love.graphics.setColor(1, 0, 0, 0.9)
	love.graphics.rectangle("fill", x - 15, y - 1, 30, 2)
	love.graphics.rectangle("fill", x - 1, y - 15, 2, 30)
end

function love.load()
	Gun = Gun()
	Sheep = Sheep(0, 0, 50, 50)
	love.mouse.setVisible(false)
end

function love.update(dt)
	Gun.update(Gun)

	if love.mouse.isDown(1) then
		Gun.shot(Gun)
	end

	if love.keyboard.isDown("r") then
		Gun.reload(Gun)
	end
end

function love.draw()
	love.graphics.setBackgroundColor(0, 0, 0)

	-- Sheep.draw(Sheep)

	Gun.draw(Gun)

	Draw_crosshair(love.mouse.getX(), love.mouse.getY())

	-- love.graphics.line(Gun.x, Gun.y, love.mouse.getX(), Gun.y)
	-- love.graphics.line(Gun.x, Gun.y, Gun.x, love.mouse.getY())

	-- love.graphics.setColor(0, 1, 0)
	-- --The angle
	-- love.graphics.line(Gun.x, Gun.y, love.mouse.getX(), love.mouse.getY())
end
