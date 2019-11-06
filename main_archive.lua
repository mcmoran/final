-- this is an archive of previous versions of main.lua

-- GAME START STATES --------------------------------------------------
gamestart = false

--[[ ---------------------------------------------------------------
  LOVE.LOAD
--------------------------------------------------------------------]]
function love.load()

  -- requirements
  require "images" -- images.lua file
  require "audio" -- audio.lua file
  require "text" -- text.lua file
  require "player" -- player.lua file
  require "levels" -- levels.lua file
  require "boss" -- boss.lua file

  -- external requirements
  Camera = require "camera" -- camera.lua file
  moonshine = require 'moonshine' -- moonshine
  flux = require "flux" -- flux

  -- bgMusic
  --levelOneSounds()

  -- arena constants
  arenaWidth = 800
  arenaHeight = 600

  SCREEN_X = 800
  SCREEN_Y = 600

  MAX_WINDOW_X = SCREEN_X * 2
  MAX_WINDOW_Y = SCREEN_Y * 2

  -- setting the player stats
  player = {x = SCREEN_X / 2, y = SCREEN_Y / 2, w = 50, h = 50, maxSpeed = 300, dir = 1, speedX = 0, speedY = 0, dirX = 0, dirY = 0}

  -- setting the weapon stats
  weapon = {x = SCREEN_X / 2, y = SCREEN_Y / 2, w = 10, h = 10, maxSpeed = 600, dir = 1, speedX = 0, speedY = 0, dirX = 0, dirY = 0}


  bg = love.graphics.newImage('bg.jpg')
  love.graphics.setDefaultFilter('nearest', 'nearest')
  love.window.setMode(SCREEN_X, SCREEN_Y)

  -- camera
  camera = Camera(player.x, player.y, SCREEN_X, SCREEN_Y)
  camera:setFollowStyle('SCREEN_BY_SCREEN')
  camera:setFollowLerp(0.2)
  camera:setFollowLead(0)
  camera:setBounds(0, 0, MAX_WINDOW_X, MAX_WINDOW_Y)

  --[[ game constants
  musicLevel1 = levelOneSounds()
  musicLevel2 = levelTwoSounds()
  musicLevel3 = levelThreeSounds()
  --musicLevel = {levelOneSounds(), levelTwoSounds(), levelThreeSounds()}
]]
  -- player constants
  --[[playerSpeed = 300
  playerWidth = 30
  playerHeight = 30

  -- weapon constants
  weaponLong = 10
  weaponShort = 5
  weaponSpeed = 500
  weaponShots = {}
  weaponTimer = 0
]]
  -- enemy constants
  enemy = {x = 0, y = 0, w = 30, h = 30, speed = 100}

  function reset()

    -- because we always need a randomseed ...
    math.randomseed(os.time())

    -- game resets
    level = 1

    -- player resets
    player.x = SCREEN_X / 2
    player.y = SCREEN_Y / 2
    player.speedX = 0
    player.speedY = 0
    player.dir = 1 -- 1 = up, 2 = right, 3 = down, 4 = left
    weapon.x = player.x + player.w / 2 - weapon.w / 2
    weapon.y = player.y - player.h / 2

    -- enemy resets
    enemy.x = math.random(10, 790)
    enemy.y = math.random(10, 590)
    enemy.speedX = 0
    enemy.speedY = 0
    shots = 0

    timer = 0


  end -- reset

  reset()

end -- load

--[[ ---------------------------------------------------------------
  LOVE.UPDATE
--------------------------------------------------------------------]]
function love.update(dt)

  -- generic timer
  timer = timer + dt
  weaponTimer = weaponTimer + dt

  -- camera update
  camera:update(dt)

  -- flux update
  flux.update(dt)

  --[[ moonshine loader (example)
  effect = moonshine(moonshine.effects.filmgrain)
          .chain(moonshine.effects.vignette)
  effect.filmgrain.size = 2
  ]]--

  -- player movement\
  if love.keyboard.isDown('up') then
      player.dir = 1
      player.y = player.y - player.maxSpeed * dt
      weaponPosition()
  elseif love.keyboard.isDown('down') then
      player.dir = 3
      player.y = player.y + player.maxSpeed * dt
      weaponPosition()
  elseif love.keyboard.isDown('left') then
      player.dir = 4
      player.x = player.x - player.maxSpeed * dt
      weaponPosition()
  elseif love.keyboard.isDown('right') then
      player.dir = 2
      player.x = player.x + player.maxSpeed * dt
      weaponPosition()
  end


  -- weapon position and direction
  function weaponPosition()
    if playerDirection == 1 then
      weapon.dirX = 0
      weapon.dirY = -1
      weapon.x = player.x + player.w / 2 - weapon.w / 2
      weapon.y = player.y - player.h / 2
    elseif playerDirection == 2 then
      weapon.dirX = 1
      weapon.dirY = 0
      weapon.x = player.x + player.w + weapon.w / 2
      weapon.y = player.y + player.h / 2 - weapon.h / 2
    elseif playerDirection == 3 then
      weapon.dirX = 0
      weapon.dirY = 1
      weapon.x = player.x + player.w / 2 - weapon.w / 2
      weapon.y = player.y + player.h + weapon.h / 2
    elseif playerDirection == 4 then
      weapon.dirX = -1
      weapon.dirY = 0
      weapon.x = player.x - player.w / 2 - weapon.h / 2
      weapon.y = player.y + player.h / 2 - weapon.h / 2
    end
  end

  -- weapon shooting
  if love.keyboard.isDown('space') then
    if weaponTimer >= 0.5 then
      weaponTimer = 0

      table.insert(shots, {x = weapon.x, y = weapon.y, dirY = weapon.dirX, dirY = weapon.dirY, timeLeft = 4})
    end
  end

  -- shots coming out of the weapon
  for shotsIndex = #shots, 1, -1 do
    local shot = shots[shotsIndex]

    shot.timeLeft = shot.timeLeft - dt
    if shot.timeLeft <= 0 then
      table.remove(shots, shotsIndex)
    else

      shot.x = (shot.x + shot.dirX * weapon.maxSpeed * dt) --% arenaWidth
      shot.y = (shot.y + shot.dirY * weapon.maxSpeed * dt) --% arenaHeight
    end

    -- weapon shot collision detection
    if AABB(shot.x, shot.y, 5, 5, enemy.x, enemy.y, enemy.w, enemy.h) then
      enemy.x = math.random(50, 750)
      enemy.y = math.random(50, 550)
      table.remove(shots, shotsIndex)
      shot = shot + 1
    end
  end



  -- player position - loops around screen
  player.x = (player.x + player.speedX * dt) --% arenaWidth
  player.y = (player.y + player.speedY * dt) --% arenaHeight

  -- weapon collision detection
  if AABB(weapon.x, weapon.y, weapon.w, weapon.h, enemy.x, enemy.y, enemy.w, enemy.h) then
    enemy.x = math.random(50, 750)
    enemy.y = math.random(50, 550)
    shot = shot + 1
  end

  -- player collision detection ends game
  if AABB(player.x, player.y, player.w, player.h, enemy.x, enemy.y, enemy.w, enemy.h) then
    gamestart = false
    reset()
  end

  if enemiesShot == 5 then
    level = 2
  end
--[[
  bgMusic = love.audio.newSource("levelMusic".level, 'stream')
    bgMusic:setLooping(true)
    bgMusic:setVolume(0.5)
    bgMusic:play()

--[[ this doesn't work yet
  if enemiesShot > 4 and enemiesShot < 10 then
    level = 2
    quiet()
    levelTwoSounds()
  elseif enemiesShot > 9 and enemiesShot < 15 then
    level = 3
    quiet()
    levelThreeSounds()
  elseif enemiesShot > 14 then
    level = 4
    quiet()
    levelOneSounds()
  end
]]

end -- update

--[[ ---------------------------------------------------------------
  LOVE.DRAW
--------------------------------------------------------------------]]
function love.draw()

  -- if the game hasn't started, show the splash screen text
  if not gamestart then

    camera:attach()

    splashText();  -- need to get this working

    camera:detach()
    --camera:draw()
  -- if the game has started, then do all this
  elseif gamestart then

    -- start camera function
    camera:attach()

    --[[ monshine wrapper example
    effect(function()
      love.graphics.rectangle("fill", 300,200, 200,200)
    end)
    ]]

    -- background
    --love.graphics.setColor(.8, .8, .8)
    --love.graphics.rectangle('fill', 0, 0, 800, 600)
    love.graphics.setColor(1, 1, 1)
    love.graphics.draw(bg, 0, 0)

    -- player
    love.graphics.setColor(0, 0, 1)
    love.graphics.rectangle('fill', playerX, playerY, playerWidth, playerHeight)

    -- weapon
    love.graphics.setColor(0.5, 0, 0)
    love.graphics.rectangle('fill', weaponX, weaponY, weaponWidth, weaponHeight)

    for weaponShotIndex, weaponShot in ipairs(weaponShots) do
      love.graphics.setColor(0.5, 0, 0)
      love.graphics.rectangle('fill', weaponShot.x, weaponShot.y, 5, 5)
    end

    -- enemy
    love.graphics.setColor(1, 0, 0)
    --love.graphics.print(enemyHeight, 200, 200)
    love.graphics.rectangle('fill', enemyX, enemyY, enemyWidth, enemyHeight)


    scoreText()

    camera:detach()
    --camera:draw() -- Call this here if you're using camera:fade,
                  -- camera:flash or debug drawing the deadzone
  end -- if else

end -- draw

--[[ ---------------------------------------------------------------
  OTHER FUNCTIONS
--------------------------------------------------------------------]]


-- AABB collision detection function.
-- Takes two objects' x, y coordinates with width and height values.
function AABB(x1, y1, w1, h1, x2, y2, w2, h2)

  return x1 < x2 + w2 and
         x2 < x1 + w1 and
         y1 < y2 + h2 and
         y2 < y1 + h1

end -- AABB


-- key press function
function love.keypressed(key)

  -- escape the game anytime with "escape" key
  if key == "escape" then
    love.event.push("quit")
  end

  -- starts game with "return" key
  if key == "return" then
    camera:fade(1, {0, 0, 0, 1})
    gamestart = true
    camera:fade(1, {0, 0, 0, 0})
  end

end -- keypressed
