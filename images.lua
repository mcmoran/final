--[[
this file is where we can set up images and
image manipulations like sprites
]]--

-- image loading

logo = love.graphics.newImage("images/logo.png")
splash = love.graphics.newImage("images/splash960.png")

-- static images (animated ones are in sprite.lua)

wispImage = love.graphics.newImage("images/Wisp.png")

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

swampshoreupperright = love.graphics.newImage("images/swampshoreupperright.jpg")
swampshoreupperleft = love.graphics.newImage("images/swampshoreupperleft.jpg")
swampshorelowerright = love.graphics.newImage("images/swampshorelowerright.jpg")
swampshorelowerleft = love.graphics.newImage("images/swampshorelowerleft.jpg")

swampshoreIVupperright = love.graphics.newImage("images/swampshoreIVupperright.jpg")
swampshoreIVupperleft = love.graphics.newImage("images/swampshoreIVupperleft.jpg")
swampshoreIVlowerright = love.graphics.newImage("images/swampshoreIVlowerright.jpg")
swampshoreIVlowerleft = love.graphics.newImage("images/swampshoreIVlowerleft.jpg")


swamppebbles = love.graphics.newImage("images/swamppebbles.jpg")


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
futurefloor9 = love.graphics.newImage("images/floor-extra.png")

futurePool1 = love.graphics.newImage("images/future-PuddleEdge.png")
futurePool2 = love.graphics.newImage("images/future-PuddlePool.png")
futurePuddle1 = love.graphics.newImage("images/future-puddle.png")
futurePuddle2 = love.graphics.newImage("images/future-puddling.png")
futurePit = love.graphics.newImage("images/futuristic-pit.png")

hole = love.graphics.newImage("images/hole.png")

arrow = love.graphics.newImage("images/arrow.png")

futureCeilingNOpen = love.graphics.newImage("images/wall-edge1-1.png")
futureCeilingNSOpen = love.graphics.newImage("images/wall-edge1-2.png")
futureCeilingSOpen = love.graphics.newImage("images/wall-edge1-3.png")
futureCeilingWOpen = love.graphics.newImage("images/wall-edge2-1.png")
futureCeilingEWOpen = love.graphics.newImage("images/wall-edge2-2.png")
futureCeilingEOpen = love.graphics.newImage("images/wall-edge2-3.png")

futureCeilingWClosed = love.graphics.newImage("images/wall-edge4-1.png")
futureCeilingNClosed = love.graphics.newImage("images/wall-edge4-2.png")
futureCeilingEClosed = love.graphics.newImage("images/wall-edge4-3.png")
futureCeilingSClosed = love.graphics.newImage("images/wall-edge4-4.png")

futureCeilingCornerNEOpen = love.graphics.newImage("images/wall-corner1-1.png")
futureCeilingCornerSEOpen = love.graphics.newImage("images/wall-corner1-2.png")
futureCeilingCornerSWOpen = love.graphics.newImage("images/wall-corner1-3.png")
futureCeilingCornerNWOpen = love.graphics.newImage("images/wall-corner1-4.png")


--Cinematics
-- moved to video.lua

-- player images
  -- sprite images has been moved to sprites.lua
