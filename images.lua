--[[
this file is where we can set up images and
image manipulations like sprites
]]--

-- image loading

-- BACKGROUND IMAGES --
--level 1
grass = love.graphics.newImage("images/grass base.png")
grassv1 = love.graphics.newImage("images/bg-grass.png")
bridge = love.graphics.newImage("images/bridge.png")
grassv2 = love.graphics.newImage("images/grass v2.png")
grassv3 = love.graphics.newImage("images/grass v3 rocks.png")
grassv4 = love.graphics.newImage("images/grass v4 flowers.png")
rockwall = love.graphics.newImage("images/rockwall.png")
rockwallGrass = love.graphics.newImage("images/rockwall edge grass.png")

dirtpath1 = love.graphics.newImage("images/dirtpath1.jpg")
dirtpath2 = love.graphics.newImage("images/dirtpath2.jpg")
dirtpath3 = love.graphics.newImage("images/dirtpath3.jpg")
dirtpath4 = love.graphics.newImage("images/dirtpath4.jpg")
dirtpath5 = love.graphics.newImage("images/dirtpath5.jpg")
dirtpath6 = love.graphics.newImage("images/dirtpath6.jpg")
dirtpathedge = love.graphics.newImage("images/dirtpathedge.jpg")



--level 3
futureWall_a1 = love.graphics.newImage("images/future-wall_a1.png")
futureWall_a2 = love.graphics.newImage("images/future-wall_a2.png")
futureWall_a3 = love.graphics.newImage("images/future-wall_a3.png")
futureWall_a4 = love.graphics.newImage("images/future-wall_a4.png")
futureWall_a5 = love.graphics.newImage("images/future-wall_a5.png")
futureWall_b1 = love.graphics.newImage("images/future-wall_b1.png")
futureWall_b2 = love.graphics.newImage("images/future-wall_b2.png")

futurefloor1 = love.graphics.newImage("images/futurefloora1.png")
futurefloor2 = love.graphics.newImage("images/futurefloora2.png")
futurefloor3 = love.graphics.newImage("images/futurefloora3.png")
futurefloor4 = love.graphics.newImage("images/futurefloora4.png")
futurefloor5 = love.graphics.newImage("images/futurefloora5.png")
futurefloor6 = love.graphics.newImage("images/futurefloorb1.png")
futurefloor7 = love.graphics.newImage("images/futurefloorb2.png")
futurefloor8 = love.graphics.newImage("images/futurefloorb3.png")

futurePool1 = love.graphics.newImage("images/future-PuddleEdge.png")
futurePool2 = love.graphics.newImage("images/future-PuddlePool.png")



-- player images
--knightWalkImage = love.graphics.newImage("knight.png") -- the sprite for the knight
knightRightWalkImage = love.graphics.newImage("images/knightRight.png")
knightLeftWalkImage = love.graphics.newImage("images/knightLeft.png")
knightBackWalkImage = love.graphics.newImage("images/knightBack.png")
knightFrontWalkImage = love.graphics.newImage("images/knightFront.png")
knightStandImage = love.graphics.newImage("images/knightStand.png")


-- from teacher's assets
playerIdleImage = love.graphics.newImage('images/robotIdle.png') --the master sprite sheets of the animation.
playerWalkImage = love.graphics.newImage('images/robotWalk.png')
