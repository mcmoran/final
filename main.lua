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
  anim8 = require 'anim8'
  bump = require "bump" -- bump
  camera = require "camera" -- camera
  moonshine = require 'moonshine' -- moonshine
  flux = require "flux" -- flux

  -- world creation
  world = bump.newWorld()
  --blocks variable for the items in the world that have collisions
  blocks1 = {}
  blocks2 = {}
  blocks3 = {}

  -- gamescreen constants
  SCREEN_X = 960
  SCREEN_Y = 640
  -- these are the level 1 sizes
  MAX_WINDOW_X = SCREEN_X * 4
  MAX_WINDOW_Y = SCREEN_Y * 1
  -- tile sizes
  TILE_SIZE = 32

  --levels
  level = 1
  change = false

  -- player
  player = {x = SCREEN_X / 2, y = SCREEN_Y / 2, w = 64, h = 64,
            speedX = 0, speedY = 0, maxSpeed = 600,
            dir = 1, dirX = 0, dirY = 0 }

  gridIdle = anim8.newGrid(70, 56, robotIdleImage:getWidth(), robotIdleImage:getHeight()) --this is a must. Tells Love2d the quad slices
  gridWalk = anim8.newGrid(70, 60, robotWalkImage:getWidth(), robotWalkImage:getHeight()) --of the animation frames. The first 2 numbers width/height of the frame sizes.

  robotIdle = anim8.newAnimation(gridIdle('1 - 4', 1), 0.2) --the actual defining of the animation.  The 1 - number are the frames from the sprite sheet.
  robotWalk = anim8.newAnimation(gridWalk('1 - 6', 1), 0.1)

  robot = {x = 80, y = 80, w = 64, h = 58, speed = 250, idle = true, dir = 1}
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
  world:add(robot, robot.x, robot.y, robot.w, robot.h)

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
    enemy.x = math.random(player.w, MAX_WINDOW_X - player.w)
    enemy.y = math.random(player.h, MAX_WINDOW_Y - player.h)
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
  camera:follow(robot.x, robot.y)

  -- timers
  timer = timer + dt
  weaponTimer = weaponTimer + dt

  flux.update(dt)

  collision_length = 0
  updatePlayer(dt)
  updateRobot(dt)
  robotIdle:update(dt) --updates the animations.
  robotWalk:update(dt)

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
    player.x = MAX_WINDOW_X / 2
    player.y = MAX_WINDOW_Y / 2
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

  -- draw level 3
  if level == 4 and change then
    removeBlocks()

    for j = 1, #levelMap4 do
      local row = levelMap4[j]
      for k = 1, #row do
        if levelMap4[j][k] == 1 or levelMap4[j][k] == 2 then -- if the tile is a 1 then we add it to the bump world in this example.
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
      enemy.x = math.random(player.w, MAX_WINDOW_X - player.w)
      enemy.y = math.random(player.h, MAX_WINDOW_Y - player.h)
      table.remove(shots, shotsIndex)
      enemiesShot = enemiesShot + 1
    end
  end

  -- weapon collision detection
  if AABB(weapon.x, weapon.y, weapon.w, weapon.h, enemy.x, enemy.y, enemy.w, enemy.h) then
    enemy.x = math.random(player.w, MAX_WINDOW_X - player.w)
    enemy.y = math.random(player.h, MAX_WINDOW_Y - player.h)
    enemiesShot = enemiesShot + 1
  end

  -- player collision detection ends game
  if AABB(player.x, player.y, player.w, player.h, enemy.x, enemy.y, enemy.w, enemy.h) then
    gamestart = false
    reset()
  end

  -- testing levels
  if enemiesShot == 2 and level == 1 then
    level = 2
    levelReset()

    enemiesShot = 0
  end

  if enemiesShot == 2 and level == 2 then
    level = 3
    levelReset()
  end

  if enemiesShot == 3 and level == 3 then
    level = 4
    levelReset()
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

      if robot.idle then
        love.graphics.setColor(0, 0, 0, 0.3)
        love.graphics.rectangle('fill', (robot.x + robot.w / 2) - 40, robot.y + 45, robot.w + 18, (robot.h - 16) / 2) --shadow
        love.graphics.setColor(1, 1, 1)
        robotIdle:draw(robotIdleImage, robot.x + robot.w / 2, robot.y, 0, robot.dir, 1, robot.w / 2, 0) --notice the x, y and robot.w offset
      else
        love.graphics.setColor(0, 0, 0, 0.3)
        love.graphics.rectangle('fill', (robot.x + robot.w / 2) - 40, robot.y + 45, robot.w + 18, (robot.h - 16) / 2)
        love.graphics.setColor(1, 1, 1)
        robotWalk:draw(robotWalkImage, robot.x + robot.w / 2, robot.y, 0, robot.dir, 1, robot.w / 2, 0)
      end

      -- player
      love.graphics.setColor(1, 1, 1)
      love.graphics.draw(tempLeftPlayer, player.x, player.y)
      --love.graphics.rectangle('fill', player.x, player.y, player.w, player.h)

      -- weapon
      love.graphics.setColor(0, 0, 0)
      love.graphics.rectangle('fill', weapon.x, weapon.y, weapon.w, weapon.h)

      -- shots
      for shotIndex, shot in ipairs(shots) do
        love.graphics.setColor(0, 0, 0)
        love.graphics.rectangle('fill', shot.x, shot.y, weapon.w, weapon.h)
      end

      -- enemy
      love.graphics.setColor(1, 0, 0)
      love.graphics.rectangle('fill', enemy.x, enemy.y, enemy.w, enemy.h)

      --wisps
      love.graphics.setColor (1, 1, 0)
      love.graphics.rectangle('fill', wisps.x, wisps.y, 32, 32)

      --raptor
      love.graphics.setColor(0, 0, 1)
      love.graphics.rectangle('fill', raptor.x, raptor.y, 64, 64)

      --stegosaurus
      love.graphics.setColor(0, 1, 1)
      love.graphics.rectangle('fill', stego.x, stego.y, 128, 64)

      --spinosaurus
      love.graphics.setColor(0, 0, 0)
      love.graphics.rectangle('fill', spino.x, spino.y, 128, 64)

      --alien soldier
      love.graphics.setColor(0, 1, 0)
      love.graphics.rectangle('fill', soldier.x, soldier.y, 64, 32)

      --alien fodder
      love.graphics.setColor(0, 1, 0)
      love.graphics.rectangle('fill', fodder.x, fodder.y, 32, 32)

      --The "Demon" Knight
      love.graphics.setColor(0, 0, 0)
      love.graphics.rectangle('fill', demon.x, demon.y, 128, 128)

      --T-Rex
      love.graphics.setColor(0, 0, 0)
      love.graphics.rectangle('fill', trex.x, trex.y, 192, 128)

      --UFO/Big Alien
      love.graphics.setColor(0, 0, 0)
      love.graphics.rectangle('fill', alien.x, alien.y, 64, 128)

    camera:detach()

    scoreText()

  end -- if else

end -- draw

--[[----------------------------------------------------------------
  OTHER FUNCTIONS
--------------------------------------------------------------------]]

-- levelReset function

function levelReset()

  player.x = 100
  player.y = 100
  weapon.x = player.x + player.w / 2
  weapon.y = player.y + player.h / 2
  enemiesShot = 0

end
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

function updateRobot(dt)
  local speed = robot.speed

  local dx, dy = 0, 0
  if love.keyboard.isDown('right') then
    dx = speed * dt
    robot.dir = 1
    robot.idle = false
  elseif love.keyboard.isDown('left') then
    dx = -speed * dt
    robot.dir = -1
    robot.idle = false
  end
  if love.keyboard.isDown('down') then
    dy = speed * dt
    robot.idle = false
  elseif love.keyboard.isDown('up') then
    dy = -speed * dt
    robot.idle = false
  end

  if dx ~= 0 or dy ~= 0 then
    --local collisions, actualX, actualY
    robot.x, robot.y, collisions, collision_length = world:move(robot, robot.x + dx, robot.y + dy)
  end
end

-- Block functions
function addBlock(x, y, w, h)
  --local block = {x = x, y = y, w = w, h = h}
  if level == 1 then
    local block = {x = x, y = y, w = w, h = h}
    blocks1[#blocks1 + 1] = block
    world:add(block, x, y, w, h)

  elseif level == 2 then
    local block = {x = x, y = y, w = w, h = h}
    blocks2[#blocks2 + 1] = block
    world:add(block, x, y, w, h)

  elseif level == 3 then
    local block = {x = x, y = y, w = w, h = h}
    blocks3[#blocks3 + 1] = block
    world:add(block, x, y, w, h)

  elseif level == 4 then
    local block = {x = x, y = y, w = w, h = h}
    blocks4[#blocks4 + 1] = block
    world:add(block, x, y, w, h)
  end
end

function removeBlocks()
  if level == 4 then
    for i = 1, #blocks3 do
      world:remove(blocks3[i])
    end
  end
  if level == 3 then
    for i = 1, #blocks2 do
      world:remove(blocks2[i])
    end
  end
  if level == 2 then
    for i = 1, #blocks1 do
      world:remove(blocks1[i])
    end
  end
  --[[if level == 1 then
    for i = 1, #blocks1 do
      world:remove(blocks1[i])
    end
  end]]
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

function love.keyreleased(key)
  if key == 'up' or key == 'down' or key == 'left' or key == 'right' then
    robot.idle = true
  end
end
