--[[
In this file we can set up audio files and functions related to sound
]]

levelMusic1 = "audio/dinosaur-jungle.mp3"
levelMusic2 = "audio/knight-fight.mp3"
levelMusic3 = "audio/future-distrubia.mp3"

--[[ all the level one sounds can be put in this function
function levelOneSounds()
  bgMusic1 = love.audio.newSource("audio/dinosaur-jungle.mp3", 'stream')
    bgMusic:setLooping(true)
    bgMusic:setVolume(0.5)
    bgMusic:play()
end


-- all the level one sounds can be put in this function
function levelTwoSounds()
  bgMusic2 = love.audio.newSource("audio/knight-fight.mp3", 'stream')
    bgMusic:setLooping(true)
    bgMusic:setVolume(0.5)
    bgMusic:play()
end


-- all the level one sounds can be put in this function
function levelThreeSounds()
  bgMusic3 = love.audio.newSource("audio/future-distrubia.mp3", 'stream')
    bgMusic:setLooping(true)
    bgMusic:setVolume(0.5)
    bgMusic:play()
end

]]--

-- stops the music
function quiet()
  bgMusic:stop()
end
