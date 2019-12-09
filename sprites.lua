-- CREATING IMAGE VARIABLES FROM SPRITES

  -- Stage 1 Knight sprites
  knight1WalkRSprite = love.graphics.newImage("images/knightRight.png")
  knight1WalkLSprite = love.graphics.newImage("images/knightLeft.png")
  knight1WalkBSprite = love.graphics.newImage("images/knightBack.png")
  knight1WalkFSprite = love.graphics.newImage("images/knightFront.png")
  knight1IdleSprite = love.graphics.newImage("images/knightStand.png")
  -- knight1AttackSprite = love.graphics.newImage("images/knight1Attack.png")

  --Stage 2 Knight sprites
  knight2AttackSprite = love.graphics.newImage("images/knightSprite2Attack.png")
  knight2WalkSprite = love.graphics.newImage("images/knightSprite2Walk.png")

  --Stage 3 Knight sprites
  knight3AttackSprite = love.graphics.newImage("images/knightSprite3Attack.png")
  knight3WalkSprite = love.graphics.newImage("images/knightSprite3Walk.png")

  -- ENEMY IMAGES --

  -- level 1
  wispSprite = love.graphics.newImage("images/Wisp.png")
  -- level 2
  raptorSprite = love.graphics.newImage("images/Raptor.png")
  spinoSprite = love.graphics.newImage("images/Spino.png")
  stegoSprite = love.graphics.newImage("images/Stego.png")
  trexSprite = love.graphics.newImage("images/trex.png")
  -- level 3
  globSprite = love.graphics.newImage("images/Glob.png")
  soldierSprite = love.graphics.newImage("images/Soldier.png")
  ufoSprite = love.graphics.newImage("images/ufo.png")

-- SETTING THE GRIDS

  -- setting the knight level 1 grids
  knight1WalkR = anim8.newGrid(64, 64, knight1WalkRSprite:getWidth(), knight1WalkRSprite:getHeight())
  knight1WalkL = anim8.newGrid(64, 64, knight1WalkLSprite:getWidth(), knight1WalkLSprite:getHeight())
  knight1WalkF  = anim8.newGrid(64, 64, knight1WalkFSprite:getWidth(), knight1WalkFSprite:getHeight())
  knight1WalkB  = anim8.newGrid(64, 64, knight1WalkBSprite:getWidth(), knight1WalkBSprite:getHeight())
  -- setting the knight level 2 grids
  knight2Walk = anim8.newGrid(64, 64, knight2WalkSprite:getWidth(), knight2WalkSprite:getHeight())
  knight2Attack = anim8.newGrid(88, 88, knight2AttackSprite:getWidth(), knight2AttackSprite:getHeight())
  -- setting the knight level 3 grids
  knight3Walk = anim8.newGrid(64, 64, knight3WalkSprite:getWidth(), knight3WalkSprite:getHeight())
  knight3Attack = anim8.newGrid(88, 88, knight3AttackSprite:getWidth(), knight3AttackSprite:getHeight())
  -- enemy level 1 grids

  -- enemy level 2 GRIDS
  raptorAnimation = anim8.newGrid(90, 90, raptorSprite:getWidth(), raptorSprite:getHeight())
  spinoAnimation = anim8.newGrid(300, 300, spinoSprite:getWidth(), spinoSprite:getHeight())
  stegoAnimation = anim8.newGrid(150, 150, stegoSprite:getWidth(), stegoSprite:getHeight())
  trexAnimation = anim8.newGrid(300, 300, trexSprite:getWidth(), trexSprite:getHeight())
  -- enemy level 3 grids
  globAnimation = anim8.newGrid(100, 100, globSprite:getWidth(), globSprite:getHeight())
  soldierAnimation = anim8.newGrid(200, 200, soldierSprite:getWidth(), soldierSprite:getHeight())
  ufoAnimation = anim8.newGrid(300, 300, ufoSprite:getWidth(), ufoSprite:getHeight())

-- SETTING THE ANIMATIONS

  -- animating the knight walking
  knight1WalkRight = anim8.newAnimation(knight1WalkR('1 - 9', 1), 0.05)
  knight1WalkLeft = anim8.newAnimation(knight1WalkL('1 - 9', 1), 0.05)
  knight1WalkBack = anim8.newAnimation(knight1WalkB('1 - 3', 1), 0.1)
  knight1WalkFront = anim8.newAnimation(knight1WalkF('1 - 3', 1), 0.1)
  -- level 2 knight animations
  knight2WalkRight = anim8.newAnimation(knight2Walk('18 - 26', 1), 0.05)
  knight2WalkLeft = anim8.newAnimation(knight2Walk('9 - 17', 1), 0.05)
  knight2WalkUp = anim8.newAnimation(knight2Walk('7 - 8', 1), 0.1)
  knight2WalkDown = anim8.newAnimation(knight2Walk('5 - 6', 1), 0.1)
  knight2IdleFront = anim8.newAnimation(knight2Walk('1 - 1', 1), 5)
  knight2IdleBack = anim8.newAnimation(knight2Walk('2 - 1', 1), 5)
  knight2IdleLeft = anim8.newAnimation(knight2Walk('3 - 3', 1), 5)
  knight2IdleRight = anim8.newAnimation(knight2Walk('4 - 4', 1), 5)
  -- level 3 knight animations
  knight3WalkRight = anim8.newAnimation(knight3Walk('18 - 26', 1), 0.05)
  knight3WalkLeft = anim8.newAnimation(knight3Walk('9 - 17', 1), 0.05)
  knight3WalkUp = anim8.newAnimation(knight3Walk('7 - 8', 1), 0.1)
  knight3WalkDown = anim8.newAnimation(knight3Walk('5 - 6', 1), 0.1)
  knight3IdleFront = anim8.newAnimation(knight3Walk('1 - 1', 1), 5)
  knight3IdleBack = anim8.newAnimation(knight3Walk('2 - 1', 1), 5)
  knight3IdleLeft = anim8.newAnimation(knight3Walk('3 - 3', 1), 5)
  knight3IdleRight = anim8.newAnimation(knight3Walk('4 - 4', 1), 5)
