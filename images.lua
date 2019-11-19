--[[
this file is where we can set up images and
image manipulations like sprites
]]--

-- image loading

-- BACKGROUND IMAGES --
--level 1
grass = love.graphics.newImage("grass base.png")
grassv1 = love.graphics.newImage("bg-grass.png")
bridge = love.graphics.newImage("bridge.png")
grassv2 = love.graphics.newImage("grass v2.png")
grassv3 = love.graphics.newImage("grass v3 rocks.png")
grassv4 = love.graphics.newImage("grass v4 flowers.png")
rockwall = love.graphics.newImage("rockwall.png")
rockwallGrass = love.graphics.newImage("rockwall edge grass.png")

--level 2
futureWall_a1 = love.graphics.newImage("future-wall_a1.png")
futureWall_a2 = love.graphics.newImage("future-wall_a2.png")
futureWall_a3 = love.graphics.newImage("future-wall_a3.png")
futureWall_a4 = love.graphics.newImage("future-wall_a4.png")
futureWall_a5 = love.graphics.newImage("future-wall_a5.png")


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
