--[[
use this file to set fonts, print out text to the screen, etc.
]]

-- set fonts
defaultFont = love.graphics.newFont(14)

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

  love.graphics.setColor(0, 0, 0)
  love.graphics.setFont(defaultFont)
  love.graphics.print("Current Level:", 40, 130)
  love.graphics.print(level, 140, 130)
  love.graphics.print("Player X: ", 40, 150)
  love.graphics.print(player.x, 140, 150)
  love.graphics.print("Player Y: ", 40, 170)
  love.graphics.print(player.y, 140, 170)

end
