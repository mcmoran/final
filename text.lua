--[[
use this file to set fonts, print out text to the screen, etc.
]]

-- set fonts
defaultFont = love.graphics.newFont(14)

-- splash Screen Text function
function splashText()

  love.graphics.setColor(1, 1, 1)
  love.graphics.rectangle('fill', 0, 0, 800, 600)
  love.graphics.setColor(0, 0, 0)
  love.graphics.setFont(defaultFont)
  love.graphics.print("Press Return to start the game.", arenaWidth / 2 - 100, arenaHeight / 2)
  love.graphics.print("Arrow keys move the player around", arenaWidth / 2 - 100, arenaHeight / 2 + 20)
  love.graphics.print("Press escape to leave the game", arenaWidth / 2 - 100, arenaHeight / 2 + 40)

end -- splashText
