--[[
In this file we can set up audio files and functions related to sound
]]

-- all the level one sounds can be put in this function
function levelOneSounds()
  bgMusic = love.audio.newSource("audio/dinosaur-jungle.mp3", 'stream')
    bgMusic:setLooping(true)
    bgMusic:setVolume(0.5)
    bgMusic:play()
end


-- all the level one sounds can be put in this function
function levelTwoSounds()
  bgMusic = love.audio.newSource("audio/knight-fight.mp3", 'stream')
    bgMusic:setLooping(true)
    bgMusic:setVolume(0.5)
    bgMusic:play()
end


-- all the level one sounds can be put in this function
function levelThreeSounds()
  bgMusic = love.audio.newSource("audio/future-distrubia.mp3", 'stream')
    bgMusic:setLooping(true)
    bgMusic:setVolume(0.5)
    bgMusic:play()
end



-- stops the music
function quiet()
  bgMusic:stop()
end
