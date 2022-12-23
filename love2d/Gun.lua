Gun = Object.extend(Object)

function Gun.new(self)
    self.x = love.graphics.getWidth() / 2 - (30 / 2)
    self.y = love.graphics.getHeight()
    self.width = 120
    self.height = 30
    self.maxAmmo = 100
    self.ammo = 99
    self.maxMagazine = 10
    self.totalMagazine = 9
    self.damage = 10
    self.rateOfFire = 0.1
    self.turbo = false
    self.readyToShot = true
    self.sound = function()
        local rate      = 44100 -- samples per second
        local length    = 1 / 32 -- 0.03125 seconds
        local tone      = 128.0 -- Hz
        local p         = math.floor(rate / tone) -- 100 (wave length in samples)
        local soundData = love.sound.newSoundData(math.floor(length * rate), rate, 16, 1)
        for i = 0, soundData:getSampleCount() - 1 do
            soundData:setSample(i, math.sin(2 * math.pi * i / p)) -- sine wave.
            -- soundData:setSample(i, i%p<p/2 and 1 or -1)     -- square wave; the first half of the wave is 1, the second half is -1.
        end
        return love.audio.newSource(soundData):play()
    end
    self.timeLastShot = nil
end

function Gun.shot(self)
    if (self.ammo >= 1 and self.readyToShot == true) then
        self.ammo = self.ammo - 1
        self.readyToShot = false
        self.timeLastShot = love.timer.getTime()
        self.sound()
    end
end

function Gun.reload(self)
    if (self.totalMagazine >= 1 and self.ammo == 0) then
        self.ammo = self.maxAmmo
        self.totalMagazine = self.totalMagazine - 1
    end
end

function Gun.update(self)
    angle = math.atan2(love.mouse.getY() - self.y, love.mouse.getX() - self.x)
    if self.timeLastShot ~= nil then
        if love.timer.getTime() - self.timeLastShot >= self.rateOfFire then
            self.readyToShot = true
            self.timeLastShot = nil
        end
    end
end

function Gun.draw(self)
    love.graphics.setColor(1, 1, 0)
    local width = love.graphics.getWidth() / 20
    local height = 2
    local posY = love.graphics.getHeight() - height - 30
    for i = 1, self.ammo do
        love.graphics.rectangle("fill", love.graphics.getWidth() - width - 10, posY, width, height)
        posY = posY - height * 2
    end
    love.graphics.setColor(1,1,1)
    love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)
    love.graphics.print(
        self.ammo .. "/" .. self.maxAmmo .. " - " .. self.totalMagazine,
        love.graphics.getWidth() - width - 40,
        love.graphics.getHeight() - height - 20
    )
end
