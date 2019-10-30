-- GAME START STATES --------------------------------------------------
gamestart = false

-- UPDATE FUNCTION --------------------------------------------------
function love.load()
  -- requirements
  require "images" -- images.lua file
  require "audio" -- audio.lua file
  require "text" -- text.lua file

  -- player variables -> eventually we can put this in it's own file

end -- load

-- UPDATE FUNCTION --------------------------------------------------
function love.update(dt)

end -- update

-- UPDATE FUNCTION --------------------------------------------------
function love.run()

end -- return

-- OTHER FUNCTIONS --------------------------------------------------

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
end
