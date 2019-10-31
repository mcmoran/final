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

  -- arena constants
  arenaWidth = 800
  arenaHeight = 600

  -- player constants
  playerSpeed = 100
  playerWidth = 30
  playerHeight = 30

  function reset()

    -- player resets
    playerX = arenaWidth / 2 - playerWidth / 2
    playerY = arenaHeight / 2 - playerHeight / 2
    playerSpeedX = 0
    playerSpeedY = 0

    timer = 0

    -- because we always need a randomseed ...
    math.randomseed(os.time())

  end -- reset

  reset()

end -- load

-- UPDATE FUNCTION --------------------------------------------------
function love.update(dt)

  -- generic timer
  timer = timer + dt

  -- player movement\
  if love.keyboard.isDown('up') then
      playerY = playerY - playerSpeed * dt
  elseif love.keyboard.isDown('down') then
      playerY = playerY + playerSpeed * dt
  elseif love.keyboard.isDown('left') then
      playerX = playerX - playerSpeed * dt
  elseif love.keyboard.isDown('right') then
      playerX = playerX + playerSpeed * dt
  end

  -- player position - loops around screen
  playerX = (playerX + playerSpeedX * dt) % arenaWidth
  playerY = (playerY + playerSpeedY * dt) % arenaHeight

end -- update

-- DRAW FUNCTION --------------------------------------------------
function love.draw()

  -- if the game hasn't started, show the splash screen text
  if not gamestart then

    splashText();  -- need to get this working

  -- if the game has started, then do all this
  elseif gamestart then

    -- background
    love.graphics.setColor(1, 1, 1)
    love.graphics.rectangle('fill', 0, 0, 800, 600)

    -- player
    love.graphics.setColor(1, 0, 0)
    love.graphics.rectangle('fill', playerX, playerY, playerWidth, playerHeight)

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
    gamestart = true
  end

end -- keypressed
