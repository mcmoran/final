--[[
use this file to set fonts, print out text to the screen, etc.
]]

worldName = ""

-- set fonts
defaultFont = love.graphics.newFont(14)
knightFont = love.graphics.newFont("ArterioNonCommercial.otf", 22)

-- splash Screen Text function
function splashText()

  love.graphics.setColor(1, 1, 1)
  love.graphics.draw(splash, 0, 0)
  love.graphics.setColor(0, 0, 0)
  love.graphics.setFont(defaultFont)
  --love.graphics.print("1. Press Return to start the game.", SCREEN_X / 2 - 100, SCREEN_Y / 2)
  --love.graphics.print("2. Press escape to leave the game", SCREEN_X / 2 - 100, SCREEN_Y / 2 + 20)
  --love.graphics.print("GAME CONTROLS:", SCREEN_X / 2 - 100, SCREEN_Y / 2 + 80)
  --love.graphics.print("Arrow keys move the player around", SCREEN_X / 2 - 100, SCREEN_Y / 2 + 100)
  --love.graphics.print("Space button shoots", SCREEN_X / 2 - 100, SCREEN_Y / 2 + 120)

end -- splashText

-- score record
function scoreText()

  --love.graphics.setColor(1, 1, 1, 0.3)
  --love.graphics.rectangle('fill', 20, 120, 200, 200)

  love.graphics.setColor(1, 1, 1)
  love.graphics.setFont(knightFont)
  love.graphics.print("World:", 20, 10)
  if level == 1 then
    worldName = "Medieval"
  elseif level == 2 then
    worldName = "Prehistoric"
  elseif level == 3 then
    worldName = "Futuristic"
  elseif level >= 4 then
    worldName = "???"
  end
  love.graphics.print(worldName, 115, 10)

  love.graphics.print("Score:", 750, 10)
  love.graphics.print(score, 850, 10)
  --love.graphics.print("Player X: ", 40, 150)
  --love.graphics.print(player.x, 140, 150)
  --love.graphics.print("Player Y: ", 40, 170)
  --love.graphics.print(player.y, 140, 170)

end
