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

  -- 3rd party
  bump = require "bump" -- bump
  camera = require "camera" -- camera
  moonshine = require 'moonshine' -- moonshine
  flux = require "flux" -- flux

  -- world creation
  world = bump.newWorld()
  --blocks variable for the items in the world that have collisions
  blocks = {}
  blocks2 = {}

  -- gamescreen constants
  SCREEN_X = 960
  SCREEN_Y = 640
  -- these are the level 1 sizes
  MAX_WINDOW_X = SCREEN_X * 4
  MAX_WINDOW_Y = SCREEN_Y * 1
  -- tile sizes
  TILE_SIZE = 64

  --levels
  level = 1
  change = false

  -- player
  player = {x = SCREEN_X / 2, y = SCREEN_Y / 2, w = 64, h = 64,
            speedX = 0, speedY = 0, maxSpeed = 300,
            dir = 1, dirX = 0, dirY = 0 }

  -- weapon
  weapon = {x = SCREEN_X / 2, y = SCREEN_Y / 2, w = 12, h = 12,
            speedX = 0, speedY = 0, maxSpeed = 600,
            dir = 1, dirX = 0, dirY = 0}

  -- enemy
  enemy = {x = 0, y = 0, w = 32, h = 32, speed = 100}



  --bg = love.graphics.newImage('bg.png')
  --love.graphics.setDefaultFilter('nearest', 'nearest')
  --love.window.setMode(SCREEN_X, SCREEN_Y)

  love.window.setMode(SCREEN_X, SCREEN_Y, {fullscreen = false})
  love.graphics.setDefaultFilter('nearest', 'nearest')
  world:add(player, player.x, player.y, player.w, player.h)

  for j = 1, #levelMap1 do
    local row = levelMap1[j]
    for k = 1, #row do
      if levelMap1[j][k] == 1 or levelMap1[j][k] == 2 then -- if the tile is a 1 then we add it to the bump world in this example.
        --love tables start at 1 but the window dimensions start at 0, so we minus 1 to start at 0. it's weird but that's how it goes.
        addBlock((k - 1) * TILE_SIZE, (j - 1) * TILE_SIZE, TILE_SIZE, TILE_SIZE)
      end
    end
  end

  -- camera parameters
  camera = camera(player.x, player.y, SCREEN_X, SCREEN_Y)
  camera:setFollowStyle('SCREEN_BY_SCREEN')
  camera:setFollowLerp(0.2)
  camera:setFollowLead(0)
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
    enemy.x = math.random(10, 1590)
    enemy.y = math.random(10, 1190)
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

  -- library updates
  camera:update(dt)
  camera:follow(player.x, player.y)

  -- timers
  timer = timer + dt
  weaponTimer = weaponTimer + dt

  flux.update(dt)

  collision_length = 0
  updatePlayer(dt)

  -- draw level 1
  if level == 1 and change then
    removeBlocks()

    for j = 1, #levelMap1 do
      local row = levelMap1[j]
      for k = 1, #row do
        if levelMap1[j][k] == 1 or levelMap1[j][k] == 2 then -- if the tile is a 1 then we add it to the bump world in this example.
          --love tables start at 1 but the window dimensions start at 0, so we minus 1 to start at 0. it's weird but that's how it goes.
          addBlock((k - 1) * TILE_SIZE, (j - 1) * TILE_SIZE, TILE_SIZE, TILE_SIZE)
        end
      end
    end
    change = false
  end

  -- draw level 2
  if level == 2 and change then
    removeBlocks()

    for j = 1, #levelMap2 do
      local row = levelMap2[j]
      for k = 1, #row do
        if levelMap2[j][k] == 1 or levelMap2[j][k] == 2 then -- if the tile is a 1 then we add it to the bump world in this example.
          --love tables start at 1 but the window dimensions start at 0, so we minus 1 to start at 0. it's weird but that's how it goes.
          addBlock((k - 1) * TILE_SIZE, (j - 1) * TILE_SIZE, TILE_SIZE, TILE_SIZE)
        end
      end
    end
    change = false
  end

  -- draw level 3
  if level == 3 and change then
    removeBlocks()

    for j = 1, #levelMap3 do
      local row = levelMap3[j]
      for k = 1, #row do
        if levelMap3[j][k] == 1 or levelMap3[j][k] == 2 then -- if the tile is a 1 then we add it to the bump world in this example.
          --love tables start at 1 but the window dimensions start at 0, so we minus 1 to start at 0. it's weird but that's how it goes.
          addBlock((k - 1) * TILE_SIZE, (j - 1) * TILE_SIZE, TILE_SIZE, TILE_SIZE)
        end
      end
    end
    change = false
  end

  -- weapon shoots
  if love.keyboard.isDown('space') then
    if weaponTimer >= 0.5 then
      weaponTimer = 0
      table.insert(shots, {x = weapon.x, y = weapon.y, w = weapon.w, h = weapon.h, dirX = weapon.dirX, dirY = weapon.dirY, timeLeft = 4})
    end
  end

  -- shot location
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
      enemy.x = math.random(50, 1550)
      enemy.y = math.random(50, 1150)
      table.remove(shots, shotsIndex)
      enemiesShot = enemiesShot + 1
    end
  end

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

  -- testing levels
  if enemiesShot == 5 then
    level = 2
  end

  if enemiesShot == 10 then
    level = 3
  end

end -- update

--[[----------------------------------------------------------------
  LOVE.DRAW
--------------------------------------------------------------------]]
function love.draw()

  -- if the game hasn't started, show the splash screen text
  if not gamestart then

      splashText();

  -- if the game has started, then do all this
  elseif gamestart then

    camera:attach()

      drawLevels()

      -- player
      love.graphics.setColor(0, 0, 1)
      love.graphics.rectangle('fill', player.x, player.y, player.w, player.h)

      -- weapon
      love.graphics.setColor(0, 0, 0)
      love.graphics.rectangle('fill', weapon.x, weapon.y, weapon.w, weapon.h)

      -- shots
      for shotIndex, shot in ipairs(shots) do
        love.graphics.setColor(0, 0, 0)
        love.graphics.rectangle('fill', shot.x, shot.y, weapon.w, weapon.h)
      end

      -- enemy
      love.graphics.setColor(0.5, 0.5, 0.5)
      love.graphics.rectangle('fill', enemy.x, enemy.y, enemy.w, enemy.h)


    camera:detach()

    scoreText()

  end -- if else

end -- draw

--[[----------------------------------------------------------------
  OTHER FUNCTIONS
--------------------------------------------------------------------]]

-- player drawing
function updatePlayer(dt)
  local speed = player.speed

  local dx, dy = 0, 0
  if love.keyboard.isDown('right') then
    player.dir = 2
    weapon.dirX = 1
    weapon.dirY = 0
    weapon.x = player.x + player.w
    weapon.y = player.y + player.h / 2 - weapon.h / 2
    dx = player.maxSpeed * dt
  elseif love.keyboard.isDown('left') then
    player.dir = 4
    weapon.dirX = -1
    weapon.dirY = 0
    weapon.x = player.x - weapon.w
    weapon.y = player.y + player.h / 2 - weapon.h / 2
    dx = -player.maxSpeed * dt
  end
  if love.keyboard.isDown('down') then
    player.dir = 3
    weapon.dirX = 0
    weapon.dirY = 1
    weapon.y = player.y + player.h
    weapon.x = player.x + player.w / 2 - weapon.w / 2
    dy = player.maxSpeed * dt
  elseif love.keyboard.isDown('up') then
    player.dir = 1
    weapon.dirX = 0
    weapon.dirY = -1
    weapon.y = player.y - weapon.w
    weapon.x = player.x + player.w / 2 - weapon.w / 2
    dy = -player.maxSpeed * dt
  end

  if dx ~= 0 or dy ~= 0 then
    local collisions
    player.x, player.y, collisions, collision_length = world:move(player, player.x + dx, player.y + dy)
  end
end

-- Block functions
function addBlock(x, y, w, h)
  --local block = {x = x, y = y, w = w, h = h}
  if level == 1 then
    local block = {x = x, y = y, w = w, h = h}
    blocks[#blocks + 1] = block
    world:add(block, x, y, w, h)

  elseif level == 2 then
    local block = {x = x, y = y, w = w, h = h}
    blocks2[#blocks2 + 1] = block
    world:add(block, x, y, w, h)
  end
end

function removeBlocks()
  if level == 2 then
    for i = 1, #blocks do
      world:remove(blocks[i])
    end
  end
  if level == 1 then
    for i = 1, #blocks2 do
      world:remove(blocks2[i])
    end
  end
end

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
