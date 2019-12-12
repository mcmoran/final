--openingVideo = love.graphics.newVideo( "videos/opening-cinematic.ogg" )
--endingVideo = love.graphics.newVideo( "videos/ending-cinematic.ogg" )


-- CREATING IMAGE VARIABLES FROM SPRITES
  local spriteOne = love.graphics.newImage("images/level1_ss.png")
  local gridOne = anim8.newGrid(640, 480, spriteOne:getWidth(), spriteOne:getHeight())

-- SETTING THE ANIMATIONS
  levelOneAnim = anim8.newAnimation(gridOne('1 - 5', 1), 0.05)
