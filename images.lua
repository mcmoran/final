--[[
this file is where we can set up images and
image manipulations like sprites
]]--

-- image loading

logo = love.graphics.newImage("images/logo.png")
splash = love.graphics.newImage("images/splash960.png")

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

--level 2
swamp1 = love.graphics.newImage("images/swamp1.jpg")
swamp2 = love.graphics.newImage("images/swamp2.jpg")
swampground = love.graphics.newImage("images/swampground.jpg")
swampwater = love.graphics.newImage("images/swampwater.jpg")
swampshoreup = love.graphics.newImage("images/swampshoreup.jpg")
swampshoredown = love.graphics.newImage("images/swampshoredown.jpg")
swampshoreleft = love.graphics.newImage("images/swampshoreleft.jpg")
swampshoreright = love.graphics.newImage("images/swampshoreright.jpg")
swamp4 = love.graphics.newImage("images/swamp4.jpg")
swamp5 = love.graphics.newImage("images/swamp5.jpg")
swamp6 = love.graphics.newImage("images/swamp6.jpg")
swamp7 = love.graphics.newImage("images/swamp7.jpg")
swamp8 = love.graphics.newImage("images/swamp8.jpg")
swamp9 = love.graphics.newImage("images/swamp9.jpg")
swamp10 = love.graphics.newImage("images/swamp10.jpg")
swamp11 = love.graphics.newImage("images/swamp11.jpg")
swampclutter1 = love.graphics.newImage("images/swampclutter1.png")
swampclutter2 = love.graphics.newImage("images/swampclutter2.png")
swampclutter3 = love.graphics.newImage("images/swampclutter3.png")
swampclutter4 = love.graphics.newImage("images/swampclutter4.png")
swampclutter5 = love.graphics.newImage("images/swampclutter5.png")

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
futurePuddle1 = love.graphics.newImage("images/future-puddle.png")
futurePuddle2 = love.graphics.newImage("images/future-puddling.png")
futurePit = love.graphics.newImage("images/futuristic-pit.png")

--Cinematics
opening = love.graphics.newVideo("videos/Opening Cinematic.ogg")
opening:play()
ending = love.graphics.newVideo("videos/Ending Cinematic.ogg")
ending:play()

-- player images
--knightWalkImage = love.graphics.newImage("knight.png") -- the sprite for the knight
knightRightWalkImage = love.graphics.newImage("images/knightRight.png")
knightLeftWalkImage = love.graphics.newImage("images/knightLeft.png")
knightBackWalkImage = love.graphics.newImage("images/knightBack.png")
knightFrontWalkImage = love.graphics.newImage("images/knightFront.png")
knightStandImage = love.graphics.newImage("images/knightStand.png")

--Stage 2 Knight
knightLVL2Attack = love.graphics.newImage("images/KnightSpriteSheet Stage 2 Attack 88px.png")
knightLVL2Walk = love.graphics.newImage("images/KnightSpriteSheet Stage 2 walking 64px.png")

--Stage 3 Knight
knightLVL3Attack = love.graphics.newImage("images/KnightSpriteSheet Stage 3 Attack 88px.png")
knightLVL3Walk = love.graphics.newImage("images/KnightSpriteSheet Stage 3 walking 88px.png")

-- from teacher's assets
playerIdleImage = love.graphics.newImage('images/robotIdle.png') --the master sprite sheets of the animation.
playerWalkImage = love.graphics.newImage('images/robotWalk.png')
