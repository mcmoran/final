-- GAME START STATES --------------------------------------------------
gamestart = false

-- UPDATE FUNCTION --------------------------------------------------
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

  -- camera
  camera = Camera(400, 300, 800, 600)
  camera:setFollowStyle('SCREEN_BY_SCREEN')

  -- arena constants
  arenaWidth = 800
  arenaHeight = 600

  -- player constants
  playerSpeed = 200
  playerWidth = 30
  playerHeight = 30
  weaponLong = 10
  weaponShort = 5

  -- enemy constants
  enemySpeed = 100
  enemyWidth = 30
  enemyHeight = 30

  function reset()

    -- because we always need a randomseed ...
    math.randomseed(os.time())

    -- player resets
    playerX = arenaWidth / 2
    playerY = arenaHeight / 2
    playerSpeedX = 0
    playerSpeedY = 0
    playerDirection = 1 -- 1 = up, 2 = right, 3 = down, 4 = left
    weaponHeight = weaponLong
    weaponWidth = weaponShort
    weaponX = playerX
    weaponY = playerY

    -- enemy resets
    enemyX = math.random(10, 100)
    enemyY = math.random(10, 100)
    enemySpeedX = 0
    enemySpeedY = 0

    timer = 0


  end -- reset

  reset()

end -- load

-- UPDATE FUNCTION --------------------------------------------------
function love.update(dt)

  -- generic timer
  timer = timer + dt

  -- camera update
  camera:update(dt)

  -- player movement\
  if love.keyboard.isDown('up') then
      playerDirection = 1
      playerY = playerY - playerSpeed * dt
      weaponPosition()
  elseif love.keyboard.isDown('down') then
      playerDirection = 3
      playerY = playerY + playerSpeed * dt
      weaponPosition()
  elseif love.keyboard.isDown('left') then
      playerDirection = 4
      playerX = playerX - playerSpeed * dt
      weaponPosition()
  elseif love.keyboard.isDown('right') then
      playerDirection = 2
      playerX = playerX + playerSpeed * dt
      weaponPosition()
  end

  -- weapon position and direction
  function weaponPosition()
    if playerDirection == 1 then
      weaponHeight = weaponLong
      weaponWidth = weaponShort
      weaponX = playerX + playerWidth / 2 - weaponWidth / 2
      weaponY = playerY - playerHeight / 2
    elseif playerDirection == 2 then
      weaponHeight = weaponShort
      weaponWidth = weaponLong
      weaponX = playerX + playerWidth + weaponWidth / 2
      weaponY = playerY + playerHeight / 2 - weaponHeight / 2
    elseif playerDirection == 3 then
      weaponHeight = weaponLong
      weaponWidth = weaponShort
      weaponX = playerX + playerWidth / 2 - weaponWidth / 2
      weaponY = playerY + playerHeight + weaponHeight / 2
    elseif playerDirection == 4 then
      weaponHeight = weaponShort
      weaponWidth = weaponLong
      weaponX = playerX - playerWidth / 2 + weaponWidth / 2
      weaponY = playerY + playerHeight / 2 - weaponHeight / 2
    end
  end


  -- player position - loops around screen
  playerX = (playerX + playerSpeedX * dt) % arenaWidth
  playerY = (playerY + playerSpeedY * dt) % arenaHeight

  -- enemy position


end -- update

-- DRAW FUNCTION --------------------------------------------------
function love.draw()

  -- if the game hasn't started, show the splash screen text
  if not gamestart then

    camera:attach()

    splashText();  -- need to get this working

    camera:detach()
    camera:draw()
  -- if the game has started, then do all this
  elseif gamestart then

    -- start camera function
    camera:attach()

    -- background
    love.graphics.setColor(.8, .8, .8)
    love.graphics.rectangle('fill', 0, 0, 800, 600)

    -- player
    love.graphics.setColor(1, 0, 0)
    love.graphics.rectangle('fill', playerX, playerY, playerWidth, playerHeight)

    -- weapon
    love.graphics.setColor(0.5, 0, 0)
    love.graphics.rectangle('fill', weaponX, weaponY, weaponWidth, weaponHeight)

    -- enemy
    love.graphics.setColor(0, 0, 1)
    --love.graphics.print(enemyHeight, 200, 200)
    love.graphics.rectangle('fill', enemyX, enemyY, enemyWidth, enemyHeight)

    camera:detach()
    camera:draw() -- Call this here if you're using camera:fade,
                  -- camera:flash or debug drawing the deadzone
  end -- if else

end -- draw

-- OTHER FUNCTIONS --------------------------------------------------

--[[
-- AABB collision detection function.
-- Takes two objects' x, y coordinates with width and height values.

function AABB(x1, y1, w1, h1, x2, y2, w2, h2)

  return x1 < x2 + w2 and
         x2 < x1 + w1 and
         y1 < y2 + h2 and
         y2 < y1 + h1

end -- AABB
]]

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
