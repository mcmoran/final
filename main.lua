-- GAME START STATES --------------------------------------------------
gamestart = false
videoPlay = true

--------------------------------------------------------------------
--  LOVE.LOAD
function love.load()
--------------------------------------------------------------------]]

  -- 3rd party requirements
  anim8 = require 'anim8' -- sprite animations
  camera = require "camera" -- screen camera
  moonshine = require 'moonshine' -- moonshine effects (not used?)
  flux = require "flux" -- flux
  bump = require "bump" -- bump collision detection

  -- requirements
  require "images" -- images.lua file
  require "video" -- video.lua file
  require "audio" -- audio.lua file
  require "text" -- text.lua file
  require "player" -- player.lua file
  require "levels" -- levels.lua file
  require "boss" -- boss.lua file
  require "collision" -- collision.lua file
  require "sprites" -- sprites.lua

  -- world creation (bump)
  world = bump.newWorld()

  -- gamescreen constants
  SCREEN_X = 960
  SCREEN_Y = 640
  -- these are the level sizes
  MAX_WINDOW_X = SCREEN_X * 4
  MAX_WINDOW_Y = SCREEN_Y * 1
  -- tile sizes
  TILE_SIZE = 32
  -- window mode
  love.window.setMode(SCREEN_X, SCREEN_Y, {fullscreen = false})
  love.graphics.setDefaultFilter('nearest', 'nearest')

  --blocks for bump and level items
  blocks1 = {}
  blocks2 = {}
  blocks3 = {}

  -- settings
  score = 0 -- player score
  lives = 5 -- lives left
  level = 1 -- current level
  change = false -- change the level?
  levelChange = false -- level changer
  enemiesShot = false

  -- player (knight)
  player = {x = 100, y = (SCREEN_Y / 2), w = (TILE_SIZE * 2), h = (TILE_SIZE * 2),
            speedX = 0, speedY = 0, maxSpeed = 300,
            dir = 1, facing = ('right'), dirX = 0, dirY = 0, idle = true}
  -- adding player to world
  world:add (player, player.x, player.y, player.w, player.h)
  -- camera parameters to follow player
  camera = camera(player.x, player.y, SCREEN_X, SCREEN_Y)
  camera:setFollowStyle('LOCKON')
  camera:setFollowLerp(0.2)
  camera:setFollowLead(0)
  camera:setBounds(0, 0, MAX_WINDOW_X, MAX_WINDOW_Y)

  -- weapon
  weapon = {x = SCREEN_X / 2, y = SCREEN_Y / 2, w = 12, h = 12,
            speedX = 0, speedY = 0, maxSpeed = 600,
            dir = 1, dirX = 0, dirY = 0}

  -- creating level 1 map
  for j = 1, #levelMap1 do
    local row = levelMap1[j]
    for k = 1, #row do
      if levelMap1[j][k] == 1 or levelMap1[j][k] == 2 then
        addBlock((k - 1) * TILE_SIZE, (j - 1) * TILE_SIZE, TILE_SIZE, TILE_SIZE)
      end
    end
  end

  -- main reset function  ---------------------------
  function reset()

    -- resets the game if all lives are lost
    if lives == 0 then
      love.event.quit("restart")
    end

    quiet()
    playMusic()

    math.randomseed(os.time())

    -- player resets
    player.x = 100
    player.y = 320

    -- weapon resets
    weapon.x = player.x + player.w / 2
    weapon.y = player.y + player.h / 2
    weaponTimer = 1
    shots = {}

    timer = 0

  end -- reset

  reset()

end -- load

------------------------------------------------------------------
--  LOVE.UPDATE
function love.update(dt)
--------------------------------------------------------------------]]

  -- enemy A.I. (moved to ai.lua)

  if level == 1 then
    for i, wisp in ipairs(wisp) do
      wisp.angle = math.random() * 2 * math.pi
      wisp.x = (wisp.x + math.cos(wisp.angle) * 2 * wisp.speedX * dt)
      wisp.y = (wisp.y + math.sin(wisp.angle) * 2 * wisp.speedX * dt)
    end

    for i, demon in ipairs(demon) do
      if (demon.x - player.x) < 500 then
        demon.angle = math.atan2(player.y - demon.y, player.x - demon.x)
        demon.x = (demon.x + math.cos(demon.angle) * 2 * demon.speedX * dt)
        demon.y = (demon.y + math.sin(demon.angle) * 2 * demon.speedY * dt)
      end
    end
  end

  if level == 2 then
    for i, raptor in ipairs(raptor) do
      if (raptor.x - player.x) < 900 then
        raptor.angle = math.atan2(player.y - raptor.y, player.x - raptor.x)
        raptor.x = (raptor.x + math.cos(raptor.angle) * 2 * raptor.speedX * dt)
        raptor.y = (raptor.y + math.sin(raptor.angle) * 2 * raptor.speedY * dt)
      end
    end

    for i, spino in ipairs(spino) do
      if (spino.x - player.x) < 500 then
        spino.angle = math.atan2(player.y - spino.y, player.x - spino.x)
        spino.x = (spino.x + math.cos(spino.angle) * 2 * spino.speedX * dt)
        spino.y = (spino.y + math.sin(spino.angle) * 2 * spino.speedY * dt)
      end
    end

    for i, trex in ipairs(trex) do
      trex.timer = trex.timer - dt

      if player.speedX == 0 and player.speedY == 0
        and (trex.x - player.x) < 500
        and trex.chargeTimer > 0 then
          trex.chargeTimer = trex.chargeTimer - dt
      end

      if trex.chargeTimer <= 0 then --if timer is 0 or less
        trex.angle = math.atan2(player.y - trex.y, player.x - trex.x)
        trex.chargeTimer = 3 --reset timer for another charge
        trex.state = 'charge' --set enemy state
      end

      if trex.state == 'charge' then
        trex.angle = math.atan2(player.y - trex.y, player.x - trex.x)
        trex.x = (trex.x + math.cos(trex.angle) * 6 * trex.speedX * dt)
        trex.y = (trex.y + math.sin(trex.angle) * 6 * trex.speedY * dt)
      end

      if trex.state == 'idle' then
        if trex.timer <= 0 then
          trex.path = math.random(1, 6)
          trex.timer = 0.75
        end
        if trex.path == 1 then
          trex.x = trex.x + 20 * dt
        elseif trex.path == 2 then
          trex.x = trex.x - 20 * dt
        elseif trex.path == 3 then
          trex.x, trex.y = trex.x + 0, trex.y + 0
        elseif trex.path == 4 then
          trex.y = trex.y + 20 * dt
        elseif trex.path == 5 then
          trex.y = trex.y - 20 * dt
        elseif trex.path == 6 then
          trex.x, trex.y = trex.x + 0, trex.y + 0
        end
      end
    end -- trex
  end -- level 2

  if level == 3 then
    for i, fodder in ipairs(fodder) do
      if (fodder.x - player.x) < 300 then
        fodder.angle = math.atan2(player.y - fodder.y, player.x - fodder.x)
        fodder.x = (fodder.x + math.cos(fodder.angle) * 2 * fodder.speedX * dt)
        fodder.y = (fodder.y + math.sin(fodder.angle) * 2 * fodder.speedY * dt)
      end
    end

    for i, soldier in ipairs(soldier) do
      if (soldier.x - player.x) < 500 then
        soldier.angle = math.atan2(player.y - soldier.y, player.x - soldier.x)
        soldier.y = (soldier.y + math.sin(soldier.angle) * 5 * soldier.speedY * dt)
      end
    end

    for i, alien in ipairs(alien) do
      if (alien.x - player.x) < 300 then
        alien.angle = math.atan2(player.y - alien.y, player.x - alien.x)
        alien.x = (alien.x + math.cos(alien.angle) * 2 * alien.speedX * dt)
        alien.y = (alien.y + math.sin(alien.angle) * 2 * alien.speedY * dt)
      end

      if (alien.x - player.x) > 300 then
        alien.angle = math.atan2(player.y + alien.y, player.x + alien.x)
        alien.x = (alien.x + math.cos(alien.angle) * 2 * alien.speedX * dt)
        alien.y = (alien.y + math.sin(alien.angle) * 2 * alien.speedY * dt)
      end
    end -- alien
  end -- level 3

  -- updates
  flux.update(dt)
  camera:update(dt)
  updatePlayer(dt)
  camera:follow(player.x, player.y)
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
    knight2AttackLeft:update(dt)
    knight2AttackRight:update(dt)
    -- level 3
    knight3WalkLeft:update(dt)
    knight3WalkRight:update(dt)
    knight3WalkUp:update(dt)
    knight3WalkDown:update(dt)
    knight3IdleLeft:update(dt)
    knight3IdleRight:update(dt)
    knight3IdleFront:update(dt)
    knight3IdleBack:update(dt)
    -- enemy Updates
    raptorAttack:update(dt)
    stegoAttack:update(dt)
    spinoAttack:update(dt)
    trexAttack:update(dt)
    globAttack:update(dt)
    soldierAttack:update(dt)
    ufoAttack:update(dt)

  -- timers
  timer = timer + dt
  weaponTimer = weaponTimer + dt
  flux.update(dt)
  collision_length = 0


  -- level reset
  if levelChange then
    change = true -- initiates level drawing
    levelChange = false -- turn off
    enemiesShot = false

    level = level + 1
    if level == 4 then
      level = 1
    end

    quiet()
    playMusic()
  end

  -- level drawing ------------------------

  -- draw level 2
  if level == 2 and change then
    removeBlocks()
    for j = 1, #levelMap2 do
      local row = levelMap2[j]
      for k = 1, #row do
        if levelMap2[j][k] == 1 or levelMap2[j][k] == 2 or (levelMap2[j][k] >= 20 and levelMap2[j][k] <= 32) then -- if the tile is a 1 then we add it to the bump world in this example.
          --love tables start at 1 but the window dimensions start at 0, so we minus 1 to start at 0. it's weird but that's how it goes.
          addBlock((k - 1) * TILE_SIZE, (j - 1) * TILE_SIZE, TILE_SIZE, TILE_SIZE)
        end
      end
    end
    change = false
    player.x = 100
    player.y = 300
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
    player.x = 100
    player.y = 300
  end

  -- game play

  shooting(dt)
  collision(dt)

  -- level conditionals
  if enemiesShot == true and level == 1 then
    levelChange = true
    enemiesShot = false
  end

  if enemiesShot == true and level == 2 then
    levelChange = true
    enemiesShot = false
  end

  if enemiesShot == true and level == 3 then
    levelChange = true
    enemiesShot = false
  end

end -- update

------------------------------------------------------------------
--  LOVE.DRAW
function love.draw()
--------------------------------------------------------------------]]

  -- game not started
  if not gamestart then

      splashText()

  -- start the game
  elseif gamestart then

    camera:attach()

      drawLevels()

      -- player animation
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

      -- weapon actions
      if level == 1 then
        love.graphics.setColor(0, 0, 0, 0)
        -- no attached weapon
      elseif level == 2 then
        love.graphics.setColor(1, 1, 1)
        -- right facing
        if player.facing == "right" then
          for shotIndex, shot in ipairs(shots) do
            love.graphics.setColor(1, 1, 1)
            love.graphics.draw(arrowRight, shot.x, shot.y)
          end
        end
        -- left facing
        if player.facing == "left" then
          for shotIndex, shot in ipairs(shots) do
            love.graphics.setColor(1, 1, 1)
            love.graphics.draw(arrowLeft, shot.x, shot.y)
          end
        end
        -- up
        if player.facing == "up" then
          for shotIndex, shot in ipairs(shots) do
            love.graphics.setColor(1, 1, 1)
            love.graphics.draw(arrowUp, shot.x, shot.y)
          end
        end
        -- down
        if player.facing == "down" then
          for shotIndex, shot in ipairs(shots) do
            love.graphics.setColor(1, 1, 1)
            love.graphics.draw(arrowDown, shot.x, shot.y)
          end
        end
      elseif level == 3 then
        love.graphics.setColor(1, 1, 0, 1)
        -- right
        if player.facing == "right" then
          for shotIndex, shot in ipairs(shots) do
            love.graphics.setColor(1, 1, 1)
            love.graphics.draw(fireballRight, shot.x, shot.y)
          end
        end
        -- left
        if player.facing == "left" then
          for shotIndex, shot in ipairs(shots) do
            love.graphics.setColor(1, 1, 1)
            love.graphics.draw(fireballLeft, shot.x, shot.y)
          end
        end
        -- up
        if player.facing == "up" then
          for shotIndex, shot in ipairs(shots) do
            love.graphics.setColor(1, 1, 1)
            love.graphics.draw(fireballUp, shot.x, shot.y)
          end
        end
        -- down
        if player.facing == "down" then
          for shotIndex, shot in ipairs(shots) do
            love.graphics.setColor(1, 1, 1)
            love.graphics.draw(fireballDown, shot.x, shot.y)
          end
        end
      end -- level 3

      -- draw enemies for each level

      if level == 1 then
        --wisp
        for i = 1, #wisp do
          -- need to create behavior
          love.graphics.setColor(1, 1, 1)
          love.graphics.draw(wispImage, wisp[i].x, wisp[i].y)
        end

        --demon knight
        for i = 1, #demon do
          -- need to create behavior
          love.graphics.setColor(1, 1, 1)
          love.graphics.draw(demonImage, demon[i].x, demon[i].y)
        end

      end

      if level == 2 then
        --raptor
        for i = 1, #raptor do
          love.graphics.setColor(1, 1, 1)
          raptorIdle:draw(raptorSprite, raptor[i].x, raptor[i].y, 0, raptor[i].dir, 1, raptor[i].w / 2, 0)
        end

        --stegosaurus
        for i = 1, #stego do
          love.graphics.setColor(1, 1, 1)
          stegoIdle:draw(stegoSprite, stego[i].x, stego[i].y, 0, stego[i].dir, 1, stego[i].w / 2, 0)
        end

        --spinosaurus
        for i = 1, #spino do
          love.graphics.setColor(1, 1, 1)
          spinoIdle:draw(spinoSprite, spino[i].x, spino[i].y, 0, spino[i].dir, 1, spino[i].w / 2, 0)
        end

        --T-Rex
        for i = 1, #trex do
          love.graphics.setColor(1, 1, 1)
          trexIdle:draw(trexSprite, trex[i].x, trex[i].y, 0, trex[i].dir, 1, trex[i].w / 2, 0)
        end

      end

      if level == 3 then
        --alien soldier
        for i = 1, #soldier do
          love.graphics.setColor(1, 1, 1)
          soldierIdle:draw(soldierSprite, soldier[i].x, soldier[i].y, 0, soldier[i].dir, 1, soldier[i].w / 2, 0)
        end

        --alien fodder
        for i = 1, #fodder do
          love.graphics.setColor(1, 1, 1)
          globIdle:draw(globSprite, fodder[i].x, fodder[i].y, 0, fodder[i].dir, 1, fodder[i].w / 2, 0)
        end

        --UFO/Big Alien
        for i = 1, #alien do
          love.graphics.setColor(1, 1, 1)
          ufoIdle:draw(ufoSprite, alien[i].x, alien[i].y, 0, alien[i].dir, 1, alien[i].w / 2, 0)
        end
      end

    camera:detach()
    camera:draw()

    -- gui from text.lua
    scoreText()

  end -- gamestart

end -- draw

------------------------------------------------------------------
--  OTHER FUNCTIONS
--------------------------------------------------------------------]]

-- player movement
function updatePlayer(dt)

  --if lives == 0 then
    --gameOver()
  --end

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

  -- world collision detection
  if dx ~= 0 or dy ~= 0 then
    local collisions
    player.x, player.y, collisions, collision_length = world:move(player, player.x + dx, player.y + dy)
  end
end -- player

-- add blocks to world
function addBlock(x, y, w, h)
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
  end
end

-- remove blocks from world (backwards)
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

-- AABB collision detection
function AABB(x1, y1, w1, h1, x2, y2, w2, h2)
  return x1 < x2 + w2 and
         x2 < x1 + w1 and
         y1 < y2 + h2 and
         y2 < y1 + h1
end -- AABB

-- key presses
function love.keypressed(key)

  -- escape the game anytime with "escape" key
  if key == "escape" then
    love.event.push("quit")
  end

  -- starts game with "return" key
  if key == "return" then
      gamestart = true
      --videoplay = true
      --video = 'none'
  end

  -- advance levels
  if key == "f" then
    level = level + 1
    if level == 4 then
      level = 1
    end
  end

end -- keypressed

-- key release
function love.keyreleased(key)
  if key == 'up' or key == 'down' or key == 'left' or key == 'right' then
    player.idle = true
  end
end

-- get distance for enemy
function getDistance(x1,y1, x2,y2)
  return ((x2-x1)^2+(y2-y1)^2)^0.5
end

-- game end
function gameOver()
  lives = 0
  reset()
end
