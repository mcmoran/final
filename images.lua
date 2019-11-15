--[[
this file is where we can set up images and
image manipulations like sprites
]]--

-- image loading

-- background images
grass = love.graphics.newImage("bg-grass.png")
bridge = love.graphics.newImage("bridge.png")

-- player images
--knightWalkImage = love.graphics.newImage("knight.png") -- the sprite for the knight
knightRightWalkImage = love.graphics.newImage("knightRight.png")
knightLeftWalkImage = love.graphics.newImage("knightLeft.png")
knightBackWalkImage = love.graphics.newImage("knightBack.png")
knightFrontWalkImage = love.graphics.newImage("knightFront.png")
knightStandImage = love.graphics.newImage("knightStand.png")


-- from teacher's assets
playerIdleImage = love.graphics.newImage('robotIdle.png') --the master sprite sheets of the animation.
playerWalkImage = love.graphics.newImage('robotWalk.png')
