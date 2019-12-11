
-- GAME START STATES --------------------------------------------------
gamestart = false
videoPlay = true

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

  --blocks variable for the items in the world that have collisions
  blocks1 = {}
  blocks2 = {}
  blocks3 = {}

  -- videos

  openingVideo = love.graphics.newVideo( "videos/opening-cinematic.ogv" )
  endingVideo = love.graphics.newVideo( "videos/ending-cinematic.ogv" )
  openingVideo:play()
  endingVideo:play()

  -- gamescreen constants
  SCREEN_X = 960
  SCREEN_Y = 640
  -- these are the level sizes
  MAX_WINDOW_X = SCREEN_X * 4
  MAX_WINDOW_Y = SCREEN_Y * 1
  -- tile sizes
  TILE_SIZE = 32

  --level setting
  score = 0
  lives = 5
  level = 1
  change = false
  fadeLevel = false
  changeTimer = 1

  -- player specs
  test = {}
  player = {x = 100, y = (SCREEN_Y / 2), w = (TILE_SIZE * 2), h = (TILE_SIZE * 2),
            speedX = 0, speedY = 0, maxSpeed = 300,
            dir = 1, facing = ('right'), dirX = 0, dirY = 0, idle = true}

  -- sprites for the knight have been moved to their lua file

  -- weapon
  weapon = {x = SCREEN_X / 2, y = SCREEN_Y / 2, w = 12, h = 12,
            speedX = 0, speedY = 0, maxSpeed = 600,
            dir = 1, dirX = 0, dirY = 0}

  enemiesShot = false

  -- setting window mode
  love.window.setMode(SCREEN_X, SCREEN_Y, {fullscreen = false})
  love.graphics.setDefaultFilter('nearest', 'nearest')

  -- adding player for bump
  world:add (player, player.x, player.y, player.w, player.h)

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

  -- camera parameters
  camera = camera(player.x, player.y, SCREEN_X, SCREEN_Y)
  camera:setFollowStyle('SCREEN_BY_SCREEN')
  camera:setFollowLerp(0.2)
  camera:setFollowLead(0)
  camera:setBounds(0, 0, MAX_WINDOW_X, MAX_WINDOW_Y)

  -- resetting things for new games
  function reset()
    love.audio.stop( )
    if lives == 0 then
      love.event.quit("restart")
    end
    levelOneSounds()

    -- because we always need a randomseed ...
    math.randomseed(os.time())

    -- game resets
    --level = 1

    -- player resets
    player.x = 100
    player.y = SCREEN_Y / 2
    player.speedX = 0
    player.speedY = 0
    player.dir = 1 -- 1 = up, 2 = right, 3 = down, 4 = left

    distance = 250

    -- weapon stuff
    weapon.x = player.x + player.w / 2
    weapon.y = player.y + player.h / 2
    weaponTimer = 1
    shots = {}

    timer = 0

    distance = 250

  end -- reset

  reset()

end -- load

--[[----------------------------------------------------------------
  LOVE.UPDATE
--------------------------------------------------------------------]]
function love.update(dt)



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
end

if level == 3 then
  for i, fodder in ipairs(fodder) do
    if (fodder.x - player.x) < 500 then
        fodder.angle = math.atan2(player.y - fodder.y, player.x - fodder.x)
        fodder.x = (fodder.x + math.cos(fodder.angle) * 2 * fodder.speedX * dt)
        fodder.y = (fodder.y + math.sin(fodder.angle) * 2 * fodder.speedY * dt)
      end
    end

    for i, soldier in ipairs(soldier) do
    if (soldier.x - player.x) < 300 then
      soldier.angle = math.atan2(player.y - soldier.y, player.x - soldier.x)
        soldier.y = (soldier.y + math.sin(soldier.angle) * 2 * soldier.speedY * dt)
        end
      end
  end

  -- library updates
  camera:update(dt)
  camera:follow(player.x, player.y)

  -- timers
  timer = timer + dt
  weaponTimer = weaponTimer + dt

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
    -- enemy Updates
    raptorAttack:update(dt)
    stegoAttack:update(dt)
    spinoAttack:update(dt)
    trexAttack:update(dt)
    globAttack:update(dt)
    soldierAttack:update(dt)
    ufoAttack:update(dt)

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

  --[[ draw level 1
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
]]--

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
  if enemiesShot == true and level == 1 then
    fadeLevel = true
    enemiesShot = false
    --bgMusic1:stop()
  end

  if enemiesShot == true and level == 2 then
    fadeLevel = true
    enemiesShot = false
    --bgMusic2:stop()
  end

  if enemiesShot == true and level == 3 then
    fadeLevel = true
    enemiesShot = false
    --bgMusic3:stop()
  end

end -- update

--[[----------------------------------------------------------------
  LOVE.DRAW
--------------------------------------------------------------------]]
function love.draw()

  -- if the game hasn't started, show the splash screen text
  if not gamestart then


    if videoPlay then
      love.graphics.draw(openingVideo, 0, 0)
      -- wait until the video is done
      --videoTimer = 1
      --videoPlay = false
    else
      splashText();
    end

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
      if level == 1 then
        love.graphics.setColor(0, 0, 0, 0)
        -- no attached weapon
      elseif level == 2 then
        love.graphics.setColor(1, 1, 1, 0.5)
        if player.facing == "right" then
          for shotIndex, shot in ipairs(shots) do
            love.graphics.setColor(1, 1, 1)
            love.graphics.draw(arrowRight, shot.x, shot.y)
          end
        end

        if player.facing == "left" then
          for shotIndex, shot in ipairs(shots) do
            love.graphics.setColor(1, 1, 1)
            love.graphics.draw(arrowLeft, shot.x, shot.y)
          end
        end

        if player.facing == "up" then
          for shotIndex, shot in ipairs(shots) do
            love.graphics.setColor(1, 1, 1)
            love.graphics.draw(arrowUp, shot.x, shot.y)
          end
        end

        if player.facing == "down" then
          for shotIndex, shot in ipairs(shots) do
            love.graphics.setColor(1, 1, 1)
            love.graphics.draw(arrowDown, shot.x, shot.y)
          end
        end
      elseif level == 3 then
        love.graphics.setColor(1, 1, 0, 1)
        if player.facing == "right" then
          for shotIndex, shot in ipairs(shots) do
            love.graphics.setColor(1, 1, 1)
            love.graphics.draw(fireballRight, shot.x, shot.y)
          end
        end

        if player.facing == "left" then
          for shotIndex, shot in ipairs(shots) do
            love.graphics.setColor(1, 1, 1)
            love.graphics.draw(fireballLeft, shot.x, shot.y)
          end
        end

        if player.facing == "up" then
          for shotIndex, shot in ipairs(shots) do
            love.graphics.setColor(1, 1, 1)
            love.graphics.draw(fireballUp, shot.x, shot.y)
          end
        end

        if player.facing == "down" then
          for shotIndex, shot in ipairs(shots) do
            love.graphics.setColor(1, 1, 1)
            love.graphics.draw(fireballDown, shot.x, shot.y)
          end
        end
      elseif level == 4 then
        love.graphics.setColor(1, 0, 0, 1)
        if player.facing == "right" then
          for shotIndex, shot in ipairs(shots) do
            love.graphics.setColor(1, 1, 1)
            love.graphics.draw(fireballRight, shot.x, shot.y)
          end
        end

        if player.facing == "left" then
          for shotIndex, shot in ipairs(shots) do
            love.graphics.setColor(1, 1, 1)
            love.graphics.draw(fireballLeft, shot.x, shot.y)
          end
        end

        if player.facing == "up" then
          for shotIndex, shot in ipairs(shots) do
            love.graphics.setColor(1, 1, 1)
            love.graphics.draw(fireballUp, shot.x, shot.y)
          end
        end

        if player.facing == "down" then
          for shotIndex, shot in ipairs(shots) do
            love.graphics.setColor(1, 1, 1)
            love.graphics.draw(fireballDown, shot.x, shot.y)
          end
        end
      end

-- draw enemies for each level

if level == 1 then
  --wisp
  for i = 1, #wisp do
    -- need to create behavior
    love.graphics.setColor(1, 1, 1)
    love.graphics.draw(wispImage, wisp[i].x, wisp[i].y)
    --world.add(wisp[i].name, wisp[i].x, wisp[i].y, wisp[i].h, wisp[i].w)
  end

  --demon knight
  for i = 1, #demon do
    -- need to create behavior
    love.graphics.setColor(1, 1, 1)
    love.graphics.rectangle('fill', demon[i].x, demon[i].y, demon[i].h, demon[i].w)

  end

end

if level == 2 then
  --raptor
  for i = 1, #raptor do
    -- need to create behavior
    love.graphics.setColor(1, 1, 1)
    raptorIdle:draw(raptorSprite, raptor[i].x, raptor[i].y, 0, raptor[i].dir, 1, raptor[i].w / 2, 0)
    --love.graphics.rectangle('fill', raptor[i].x, raptor[i].y, raptor[i].h, raptor[i].w)
    --world.add(raptor[i].name, raptor[i].x, raptor[i].y, raptor[i].h, raptor[i].w)
  end

  --stegosaurus
  for i = 1, #stego do
    -- need to create behavior
    love.graphics.setColor(1, 1, 1)
    stegoIdle:draw(stegoSprite, stego[i].x, stego[i].y, 0, stego[i].dir, 1, stego[i].w / 2, 0)
    --love.graphics.rectangle('fill', stego[i].x, stego[i].y, stego[i].h, stego[i].w)
    --world:add(stego[i].name, stego[i].x, stego[i].y, stego[i].h, stego[i].w)
  end

  --spinosaurus
  for i = 1, #spino do
    -- need to create behavior
    love.graphics.setColor(1, 1, 1)
    spinoIdle:draw(spinoSprite, spino[i].x, spino[i].y, 0, spino[i].dir, 1, spino[i].w / 2, 0)
    --love.graphics.rectangle('fill', spino[i].x, spino[i].y, spino[i].h, spino[i].w)
    --world:add(spino[i], spino[i].x, spino[i].y, spino[i].h, spino[i].w)
  end

  --T-Rex
  for i = 1, #trex do
    -- need to create behavior
    love.graphics.setColor(1, 1, 1)
    trexIdle:draw(trexSprite, trex[i].x, trex[i].y, 0, trex[i].dir, 1, trex[i].w / 2, 0)
    --love.graphics.rectangle('fill', trex[i].x, trex[i].y, trex[i].h, trex[i].w)
    --world:add(trex[i], trex[i].x, trex[i].y, trex[i].h, trex[i].w)
  end

end

if level == 3 then
  --alien soldier
  for i = 1, #soldier do
    -- need to create behavior
    love.graphics.setColor(1, 1, 1)
    soldierIdle:draw(soldierSprite, soldier[i].x, soldier[i].y, 0, soldier[i].dir, 1, soldier[i].w / 2, 0)
    --world:add(soldier[i], soldier[i].x, soldier[i].y, soldier[i].h, soldier[i].w)
  end

  --alien fodder
  for i = 1, #fodder do
    -- need to create behavior
    love.graphics.setColor(1, 1, 1)
    globIdle:draw(globSprite, fodder[i].x, fodder[i].y, 0, fodder[i].dir, 1, fodder[i].w / 2, 0)
    --world:add(fodder[i], fodder[i].x, fodder[i].y, fodder[i].h, fodder[i].w)
  end

  --UFO/Big Alien
  for i = 1, #alien do
    -- need to create behavior
    love.graphics.setColor(1, 1, 1)
    ufoIdle:draw(ufoSprite, alien[i].x, alien[i].y, 0, alien[i].dir, 1, alien[i].w / 2, 0)
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
  enemiesShot = false

  if level == 2 then
    levelTwoSounds()
  elseif level == 3 then
    levelThreeSounds()
  end

  if level < 4 then
    level = level + 1
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
    if videoPlay then
      gamestart = true
      videoPlay = false
    end
  end

  if key == "f" then
    level = level + 1
    if level == 4 then
      level = 1
    end
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
  -- nothing yet
end
