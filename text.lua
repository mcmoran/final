--[[
use this file to set fonts, print out text to the screen, etc.
]]

-- exampleFont = love.graphics.newFont("fontname.tff", 30)

-- splash Screen Text function


--[[
Here is some previous text code for us to use as a reference

function splashText()

  love.graphics.setColor(1, 1, 1)
  love.graphics.draw(splashBG)
  love.graphics.setFont(titleScreenFont)
  love.graphics.setColor(0.2, 0.2, 0.2)
  love.graphics.print("トトロ vs. まっ黒黒すき。", 30, 50)
  love.graphics.setFont(englishScreenFont)
  love.graphics.print("Totoro vs. the Dust Mites", 40, 100)

end -- splashText

function counterText()

  love.graphics.setColor(1, 1, 1)
  love.graphics.setFont(englishScreenFont)
  love.graphics.print("Dust Mites Cleaned: ", 450, 50)
  love.graphics.setFont(titleScreenCommand)
  love.graphics.print(miteCounter, 700, 50)

end -- counterText

]]
