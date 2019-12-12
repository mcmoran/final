--openingVideo = love.graphics.newVideo( "videos/opening-cinematic.ogg" )
--endingVideo = love.graphics.newVideo( "videos/ending-cinematic.ogg" )


-- CREATING IMAGE VARIABLES FROM SPRITES

  levelOneSprite = love.graphics.newImage("images/level1_spritesheet.png")

-- SETTING THE GRIDS

  levelOneGrid = anim8.newGrid(640, 480, 3200, 12480)

-- SETTING THE ANIMATIONS
  -- animating the knight walking
  levelOneAnim = anim8.newAnimation(levelOneGrid('1 - 127', 1), 0.05)
