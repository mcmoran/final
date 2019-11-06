-- GAME START STATES --------------------------------------------------
gamestart = false

--[[----------------------------------------------------------------
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

  -- gamescreen constants
  SCREEN_X = 800
  SCREEN_Y = 600
  MAX_WINDOW_X = SCREEN_X * 2
  MAX_WINDOW_Y = SCREEN_Y * 2

  bg = love.graphics.newImage('bg.jpg')
  --love.graphics.setDefaultFilter('nearest', 'nearest')
  love.window.setMode(SCREEN_X, SCREEN_Y)

  -- player
  player = {x = SCREEN_X / 2, y = SCREEN_Y / 2, w = 50, h = 50,
            speedX = 0, speedY = 0, maxSpeed = 300,
            dir = 1, dirX = 0, dirY = 0 }

  -- weapon
  weapon = {x = SCREEN_X / 2, y = SCREEN_Y / 2, w = 10, h = 10,
            speedX = 0, speedY = 0, maxSpeed = 600,
            dir = 1, dirX = 0, dirY = 0}

  -- enemy
  enemy = {x = 0, y = 0, w = 30, h = 30, speed = 100}

  -- 3rd party
  Camera = require "camera" -- camera
  moonshine = require 'moonshine' -- moonshine
  flux = require "flux" -- flux

  -- camera
  camera = Camera(player.x + player.w / 2, player.y + player.h / 2, SCREEN_X, SCREEN_Y)
    camera:setFollowStyle('SCREEN_BY_SCREEN')
    camera:setFollowLerp(0.2)
    --camera:setFollowLead(0)
    camera:setBounds(0, 0, MAX_WINDOW_X, MAX_WINDOW_Y)

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

    -- enemy resets
    enemy.x = math.random(10, 790)
    enemy.y = math.random(10, 590)
    enemy.speedX = 0
    enemy.speedY = 0
    enemiesShot = 0

    -- weapon stuff
    weapon.x = player.x + player.w / 2
    weapon.y = player.y + player.h / 2
    weaponTimer = 0
    shots = {}

    timer = 0

  end -- reset

  reset()

end -- load

--[[----------------------------------------------------------------
  LOVE.UPDATE
--------------------------------------------------------------------]]
function love.update(dt)

  -- timers
  timer = timer + dt
  weaponTimer = weaponTimer + dt

  -- library updates
  camera:update(dt)
  camera:follow(player.x, player.y)
  flux.update(dt)

  -- player movement
  if love.keyboard.isDown('up') then
      player.dir = 1
      weapon.dirX = 0
      weapon.dirY = -1
      player.y = player.y - player.maxSpeed * dt
      weapon.y = player.y - weapon.w
      weapon.x = player.x + player.w / 2 - weapon.w / 2
  elseif love.keyboard.isDown('right') then
      player.dir = 2
      weapon.dirX = 1
      weapon.dirY = 0
      player.x = player.x + player.maxSpeed * dt
      weapon.x = player.x + player.w
      weapon.y = player.y + player.h / 2 - weapon.h / 2
  elseif love.keyboard.isDown('down') then
      player.dir = 3
      weapon.dirX = 0
      weapon.dirY = 1
      player.y = player.y + player.maxSpeed * dt
      weapon.y = player.y + player.h
      weapon.x = player.x + player.w / 2 - weapon.w / 2
  elseif love.keyboard.isDown('left') then
      player.dir = 4
      weapon.dirX = -1
      weapon.dirY = 0
      player.x = player.x - player.maxSpeed * dt
      weapon.x = player.x - weapon.w
      weapon.y = player.y + player.h / 2 - weapon.h / 2
  end

  -- weapon shooting
  if love.keyboard.isDown('space') then
    if weaponTimer >= 0.5 then
      weaponTimer = 0
      table.insert(shots, {x = weapon.x, y = weapon.y, w = weapon.w, h = weapon.h, dirX = weapon.dirX, dirY = weapon.dirY, timeLeft = 4})
    end
  end

  -- weapon shooting
  for shotsIndex = #shots, 1, -1 do
    local shot = shots[shotsIndex]

    shot.timeLeft = shot.timeLeft - dt
    if shot.timeLeft <= 0 then
      table.remove(shots, shotsIndex)
    else
      shot.x = (shot.x + shot.dirX * weapon.maxSpeed * dt)
      shot.y = (shot.y + shot.dirY * weapon.maxSpeed * dt)
    end

    -- weapon shot collision detection
    if AABB(shot.x, shot.y, shot.w, shot.h, enemy.x, enemy.y, enemy.w, enemy.h) then
      enemy.x = math.random(50, 750)
      enemy.y = math.random(50, 550)
      table.remove(shots, shotsIndex)
      enemiesShot = enemiesShot + 1
    end
  end

  -- player position - loops around screen
  player.x = (player.x + player.speedX * dt) --% arenaWidth
  player.y = (player.y + player.speedY * dt) --% arenaHeight


  -- weapon collision detection
  if AABB(weapon.x, weapon.y, weapon.w, weapon.h, enemy.x, enemy.y, enemy.w, enemy.h) then
    enemy.x = math.random(50, 750)
    enemy.y = math.random(50, 550)
    enemiesShot = enemiesShot + 1
  end

  -- player collision detection ends game
  if AABB(player.x, player.y, player.w, player.h, enemy.x, enemy.y, enemy.w, enemy.h) then
    gamestart = false
    reset()
  end

  if enemiesShot == 5 then
    level = 2
  end

end -- update

--[[----------------------------------------------------------------
  LOVE.DRAW
--------------------------------------------------------------------]]
function love.draw()

  -- if the game hasn't started, show the splash screen text
  if not gamestart then

    --camera:attach()
      splashText();  -- need to get this working
    --camera:detach()

  -- if the game has started, then do all this
  elseif gamestart then

    camera:attach()
      -- background
      love.graphics.setColor(1, 1, 1)
      love.graphics.draw(bg, 0, 0)

      -- player
      love.graphics.setColor(0, 0, 1)
      love.graphics.rectangle('fill', player.x, player.y, player.w, player.h)

      -- weapon
      love.graphics.setColor(1, 1, 0)
      love.graphics.rectangle('fill', weapon.x, weapon.y, weapon.w, weapon.h)

      for shotIndex, shot in ipairs(shots) do
        love.graphics.setColor(1, 1, 0)
        love.graphics.rectangle('fill', shot.x, shot.y, weapon.w, weapon.h)
      end

      -- enemy
      love.graphics.setColor(1, 0, 0)
      love.graphics.rectangle('fill', enemy.x, enemy.y, enemy.w, enemy.h)

      scoreText()

    camera:detach()
  end -- if else

end -- draw

--[[----------------------------------------------------------------
  OTHER FUNCTIONS
--------------------------------------------------------------------]]

-- AABB collision detection function.
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
