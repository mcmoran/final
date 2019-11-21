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

dirtpath1 = love.graphics.newImage("dirtpath1.jpg")
dirtpath2 = love.graphics.newImage("dirtpath2.jpg")
dirtpath3 = love.graphics.newImage("dirtpath3.jpg")
dirtpath4 = love.graphics.newImage("dirtpath4.jpg")
dirtpath5 = love.graphics.newImage("dirtpath5.jpg")
dirtpath6 = love.graphics.newImage("dirtpath6.jpg")
dirtpathedge = love.graphics.newImage("dirtpathedge.jpg")



--level 3
futureWall_a1 = love.graphics.newImage("future-wall_a1.png")
futureWall_a2 = love.graphics.newImage("future-wall_a2.png")
futureWall_a3 = love.graphics.newImage("future-wall_a3.png")
futureWall_a4 = love.graphics.newImage("future-wall_a4.png")
futureWall_a5 = love.graphics.newImage("future-wall_a5.png")
futureWall_b1 = love.graphics.newImage("future-wall_b1.png")
futureWall_b2 = love.graphics.newImage("future-wall_b2.png")

futurefloor1 = love.graphics.newImage("futurefloora1.png")
futurefloor2 = love.graphics.newImage("futurefloora2.png")
futurefloor3 = love.graphics.newImage("futurefloora3.png")
futurefloor4 = love.graphics.newImage("futurefloora4.png")
futurefloor5 = love.graphics.newImage("futurefloora5.png")
futurefloor6 = love.graphics.newImage("futurefloorb1.png")
futurefloor7 = love.graphics.newImage("futurefloorb2.png")
futurefloor8 = love.graphics.newImage("futurefloorb3.png")




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
