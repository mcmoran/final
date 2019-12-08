
-- GAME START STATES --------------------------------------------------
gamestart = false

--[[----------------------------------------------------------------
  LOVE.LOAD
--------------------------------------------------------------------]]
function love.load()


  -- 3rd party
  anim8 = require 'anim8'
  camera = require "camera" -- camera
  moonshine = require 'moonshine' -- moonshine
  flux = require "flux" -- flux
  bump = require "bump" -- bump

  -- requirements
  require "images" -- images.lua file
  require "audio" -- audio.lua file
  require "text" -- text.lua file
  require "player" -- player.lua file
  require "levels" -- levels.lua file
  require "boss" -- boss.lua file
  require "collision" -- collision.lua file
  require "sprites" -- sprites.lua

  -- world creation (bump)
  world = bump.newWorld()

  --blocks variable for the items in the world that have collisions
  blocks1 = {}
  blocks2 = {}
  blocks3 = {}

  -- gamescreen constants
  SCREEN_X = 960
  SCREEN_Y = 640
  -- these are the level sizes
  MAX_WINDOW_X = SCREEN_X * 4
  MAX_WINDOW_Y = SCREEN_Y * 1
  -- tile sizes
  TILE_SIZE = 32

  --level setting
  level = 1
  change = false
  fadeLevel = false
  changeTimer = 1

  -- player specs
  test = {}
  player = {x = (SCREEN_X / 2), y = (SCREEN_Y / 2), w = (TILE_SIZE * 2), h = (TILE_SIZE * 2),
            speedX = 0, speedY = 0, maxSpeed = 300,
            dir = 1, facing = ('right'), dirX = 0, dirY = 0, idle = true}

  -- sprites for the knight have been moved to their lua file

  -- weapon
  weapon = {x = SCREEN_X / 2, y = SCREEN_Y / 2, w = 12, h = 12,
            speedX = 0, speedY = 0, maxSpeed = 600,
            dir = 1, dirX = 0, dirY = 0}

  -- enemies
  enemies = {}
  enemy = {x = 0, y = 0, w = 32, h = 32, speed = 100,
          timer = 0.5, path = math.random(1, 6), state = 'patrol', angle = 0}

  -- setting window mode
  love.window.setMode(SCREEN_X, SCREEN_Y, {fullscreen = false})
  love.graphics.setDefaultFilter('nearest', 'nearest')

  -- adding player and testing enemy for bump
  world:add (player, player.x, player.y, player.w, player.h)
  world:add (enemy, enemy.x, enemy.y, enemy.w, enemy.h)

  -- creating the level map based on what is in levels.lua
  for j = 1, #levelMap1 do
    local row = levelMap1[j]
    for k = 1, #row do
      if levelMap1[j][k] == 1 or levelMap1[j][k] == 2 then -- if the tile is a 1 then we add it to the bump world in this example.
        --love tables start at 1 but the window dimensions start at 0, so we minus 1 to start at 0. it's weird but that's how it goes.
        addBlock((k - 1) * TILE_SIZE, (j - 1) * TILE_SIZE, TILE_SIZE, TILE_SIZE)
      end
    end
  end

  -- grabbing sounds from audio.lua
  levelOneSounds()

  -- camera parameters
  camera = camera(player.x, player.y, SCREEN_X, SCREEN_Y)
  camera:setFollowStyle('SCREEN_BY_SCREEN')
  camera:setFollowLerp(0.2)
  camera:setFollowLead(0)
  camera:setBounds(0, 0, MAX_WINDOW_X, MAX_WINDOW_Y)

  -- resetting things for new games
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

    -- testing enemy reset
    enemy.x = math.random(player.w, MAX_WINDOW_X - player.w)
    enemy.y = math.random(player.h, MAX_WINDOW_Y - player.h)
    enemy.state = 'patrol'
    enemiesShot = 0

    distance = 250

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
  enemy.timer = enemy.timer - dt

  -- flux update
  flux.update(dt)

  collision_length = 0
  updatePlayer(dt)

  -- Animation Updates

    -- level 1
    knight1WalkLeft:update(dt)
    knight1WalkRight:update(dt)
    knight1WalkBack:update(dt)
    knight1WalkFront:update(dt)
    -- level 2
    knight2WalkLeft:update(dt)
    knight2WalkRight:update(dt)
    knight2WalkUp:update(dt)
    knight2WalkDown:update(dt)
    knight2IdleLeft:update(dt)
    knight2IdleRight:update(dt)
    knight2IdleFront:update(dt)
    knight2IdleBack:update(dt)
    -- level 3
    knight3WalkLeft:update(dt)
    knight3WalkRight:update(dt)
    knight3WalkUp:update(dt)
    knight3WalkDown:update(dt)
    knight3IdleLeft:update(dt)
    knight3IdleRight:update(dt)
    knight3IdleFront:update(dt)
    knight3IdleBack:update(dt)


  -- checking the distance between the player and the testing enemy
  local detect = getDistance(player.x + player.w / 2, player.y + player.h / 2, enemy.x + enemy.w / 2, enemy.y + enemy.h / 2)

  -- enemy behavior based on distance
  if detect <= distance then
    enemy.state = 'charge'
  else
    enemy.state = 'patrol'
  end

  -- dx and dy?
  local dx, dy = 0, 0
  if enemy.state == 'patrol' then
    if enemy.timer <= 0 then
      enemy.timer = 0.5
      enemy.angle = math.random() * 2 * math.pi --random angle generation
    end

    dx = (dx + math.cos(enemy.angle) * 2 * enemy.speed * dt)
    dy = (dy + math.sin(enemy.angle) * 2 * enemy.speed * dt)
  end

  if enemy.state == 'charge' then
    enemy.angle = math.atan2(player.y - enemy.y, player.x - enemy.x)

    dx = (dx + math.cos(enemy.angle) * 2 * enemy.speed * dt)
    dy = (dy + math.sin(enemy.angle) * 2 * enemy.speed * dt)
  end

  -- if the distance for x and y isn't zero then the enemy can move
  if dx ~= 0 or dy ~= 0 then
    local collisions
    enemy.x, enemy.y, collisions, collision_length = world:move(enemy, enemy.x + dx, enemy.y + dy)
  end

  -- fade level conditional
  if fadeLevel then
    changeTimer = changeTimer - dt
    camera:fade(0.25, {0, 0, 0, 1})
  end

  -- helping with the level fade and reset
  if changeTimer <= 0 then
    changeTimer = 1
    camera:fade(1, {0, 0, 0, 0})
    fadeLevel = false
    change = true
    levelReset()
  end

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
    player.x = SCREEN_X / 2
    player.y = SCREEN_Y / 2
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
    player.x = SCREEN_X / 2
    player.y = SCREEN_Y / 2
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
    player.x = SCREEN_X / 2
    player.y = SCREEN_Y / 2
  end

  -- draw level 4
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
    player.x = SCREEN_X / 2
    player.y = SCREEN_Y / 2
  end

  -- game play functions

  shooting(dt)
  collision(dt)

  -- level conditionals
  if enemiesShot == 2 and level == 1 then
    fadeLevel = true
    bgMusic1:stop()
  end

  if enemiesShot == 2 and level == 2 then
    bgMusic2:stop()
    fadeLevel = true
  end

  if enemiesShot == 2 and level == 3 then
    bgMusic3:stop()
    fadeLevel = true
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

      -- player walking animation and movement
      love.graphics.setColor(1, 1, 1)
      -- level 1
      if level == 1 then
        if player.idle then
          love.graphics.draw(knight1IdleSprite, player.x, player.y)
        elseif player.facing == 'right' then
          knight1WalkRight:draw(knight1WalkRSprite, player.x + player.w / 2, player.y, 0, player.dir, 1, player.w / 2, 0)
        elseif player.facing == 'left' then
          knight1WalkLeft:draw(knight1WalkLSprite, player.x + player.w / 2, player.y, 0, player.dir, 1, player.w / 2, 0)
        elseif player.facing == 'up' then
          knight1WalkBack:draw(knight1WalkBSprite, player.x + player.w / 2, player.y, 0, player.dir, 1, player.w / 2, 0)
        elseif player.facing == 'down' then
          knight1WalkFront:draw(knight1WalkFSprite, player.x + player.w / 2, player.y, 0, player.dir, 1, player.w / 2, 0)
        end
      elseif level == 2 then
        if player.idle then
          knight2IdleFront:draw(knight2WalkSprite, player.x, player.y)
        elseif player.facing == 'right' then
          knight2WalkRight:draw(knight2WalkSprite, player.x + player.w / 2, player.y, 0, player.dir, 1, player.w / 2, 0)
        elseif player.facing == 'left' then
          knight2WalkLeft:draw(knight2WalkSprite, player.x + player.w / 2, player.y, 0, player.dir, 1, player.w / 2, 0)
        elseif player.facing == 'up' then
          knight2WalkUp:draw(knight2WalkSprite, player.x + player.w / 2, player.y, 0, player.dir, 1, player.w / 2, 0)
        elseif player.facing == 'down' then
          knight2WalkDown:draw(knight2WalkSprite, player.x + player.w / 2, player.y, 0, player.dir, 1, player.w / 2, 0)
        end
      elseif level == 3 then
        if player.idle then
          knight3IdleFront:draw(knight3WalkSprite, player.x, player.y)
        elseif player.facing == 'right' then
          knight3WalkRight:draw(knight3WalkSprite, player.x + player.w / 2, player.y, 0, player.dir, 1, player.w / 2, 0)
        elseif player.facing == 'left' then
          knight3WalkLeft:draw(knight3WalkSprite, player.x + player.w / 2, player.y, 0, player.dir, 1, player.w / 2, 0)
        elseif player.facing == 'up' then
          knight3WalkUp:draw(knight3WalkSprite, player.x + player.w / 2, player.y, 0, player.dir, 1, player.w / 2, 0)
        elseif player.facing == 'down' then
          knight3WalkDown:draw(knight3WalkSprite, player.x + player.w / 2, player.y, 0, player.dir, 1, player.w / 2, 0)
        end
      end

      -- weapon
      love.graphics.setColor(0, 0, 0)
      love.graphics.rectangle('fill', weapon.x, weapon.y, weapon.w, weapon.h)

      -- shots
      for shotIndex, shot in ipairs(shots) do
        love.graphics.setColor(0, 0, 0)
        love.graphics.rectangle('fill', shot.x, shot.y, weapon.w, weapon.h)
      end

      -- test enemy
      love.graphics.setColor(1, 0, 0)
      if enemy.state == 'patrol' then
        love.graphics.setColor(1, 0, 0)
      elseif enemy.state == 'charge' then
        love.graphics.setColor(1, 1, 0)
      end
      love.graphics.rectangle('fill', enemy.x, enemy.y, enemy.w, enemy.h)

-- draw enemies for each level

if level == 1 then
      --wisp
      for i = 1, #wisp do
        -- need to create behavior
        love.graphics.setColor(1, 0, 1)
        love.graphics.rectangle('fill', wisp[i].x, wisp[i].y, wisp[i].h, wisp[i].w)
        --world.add(wisp[i].name, wisp[i].x, wisp[i].y, wisp[i].h, wisp[i].w)
      end

      --demon knight
      for i = 1, #demon do
        -- need to create behavior
        love.graphics.setColor(0, 0, 0)
        love.graphics.rectangle('fill', demon[i].x, demon[i].y, demon[i].h, demon[i].w)
      end

end

if level == 2 then
      --raptor
      for i = 1, #raptor do
        -- need to create behavior
        love.graphics.setColor(0, 0, 1)
        love.graphics.rectangle('fill', raptor[i].x, raptor[i].y, raptor[i].h, raptor[i].w)
        --world.add(raptor[i].name, raptor[i].x, raptor[i].y, raptor[i].h, raptor[i].w)
      end

      --stegosaurus
      for i = 1, #stego do
        -- need to create behavior
        love.graphics.setColor(0, 1, 1)
        love.graphics.rectangle('fill', stego[i].x, stego[i].y, stego[i].h, stego[i].w)
        --world:add(stego[i].name, stego[i].x, stego[i].y, stego[i].h, stego[i].w)
      end

      --spinosaurus
      for i = 1, #spino do
        -- need to create behavior
        love.graphics.setColor(0, 0, 0)
        love.graphics.rectangle('fill', spino[i].x, spino[i].y, spino[i].h, spino[i].w)
        --world:add(spino[i], spino[i].x, spino[i].y, spino[i].h, spino[i].w)
      end

      --T-Rex
      for i = 1, #trex do
        -- need to create behavior
        love.graphics.setColor(0, 0, 0)
        love.graphics.rectangle('fill', trex[i].x, trex[i].y, trex[i].h, trex[i].w)
        --world:add(trex[i], trex[i].x, trex[i].y, trex[i].h, trex[i].w)
      end

end

if level == 3 then
      --alien soldier
      for i = 1, #soldier do
        -- need to create behavior
        love.graphics.setColor(0, 1, 0)
        love.graphics.rectangle('fill', soldier[i].x, soldier[i].y, soldier[i].h, soldier[i].w)
        --world:add(soldier[i], soldier[i].x, soldier[i].y, soldier[i].h, soldier[i].w)
      end

      --alien fodder
      for i = 1, #fodder do
        -- need to create behavior
        love.graphics.setColor(0, 1, 0)
        love.graphics.rectangle('fill', fodder[i].x, fodder[i].y, fodder[i].h, fodder[i].w)
        --world:add(fodder[i], fodder[i].x, fodder[i].y, fodder[i].h, fodder[i].w)
      end

      --UFO/Big Alien
      for i = 1, #alien do
        -- need to create behavior
        love.graphics.setColor(0, 0, 0)
        love.graphics.rectangle('fill', alien[i].x, alien[i].y, alien[i].h, alien[i].w)
        --world:add(alien[i], alien[i].x, alien[i].y, alien[i].h, alien[i].w)
      end
end

    camera:detach()
    camera:draw()

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
  if level < 4 then
    level = level + 1
  end
  if level == 2 then
    levelTwoSounds()
  elseif level == 3 then
    levelThreeSounds()
  end
end
-- player drawing
function updatePlayer(dt)
  local speed = player.speed

  local dx, dy = 0, 0
  if love.keyboard.isDown('right') then
    player.idle = false
    player.facing = 'right'
    player.dir = 1
    weapon.dirX = 1
    weapon.dirY = 0
    weapon.x = player.x + player.w
    weapon.y = player.y + player.h / 2 - weapon.h / 2
    dx = player.maxSpeed * dt
  elseif love.keyboard.isDown('left') then
    player.idle = false
    player.facing = 'left'
    player.dir = 1
    weapon.dirX = -1
    weapon.dirY = 0
    weapon.x = player.x - weapon.w
    weapon.y = player.y + player.h / 2 - weapon.h / 2
    dx = -player.maxSpeed * dt
  end
  if love.keyboard.isDown('down') then
    player.idle = false
    player.facing = 'down'
    player.dir = 1
    weapon.dirX = 0
    weapon.dirY = 1
    weapon.y = player.y + player.h
    weapon.x = player.x + player.w / 2 - weapon.w / 2
    dy = player.maxSpeed * dt
  elseif love.keyboard.isDown('up') then
    player.idle = false
    player.facing = 'up'
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

  if key == "f" then
    level = level + 1
  end

end -- keypressed

function love.keyreleased(key)
  if key == 'up' or key == 'down' or key == 'left' or key == 'right' then
    player.idle = true
  end
end

-- get distance for enemy
function getDistance(x1,y1, x2,y2)
  return ((x2-x1)^2+(y2-y1)^2)^0.5
end

-- what happens when the game ends
function gameOver()
end
