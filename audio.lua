--[[
In this file we can set up audio files and functions related to sound
]]

levelMusic1 = "audio/dinosaur-jungle.mp3"
levelMusic2 = "audio/knight-fight.mp3"
levelMusic3 = "audio/future-distrubia.mp3"

-- level one sound effects
retroEpicMusic = love.audio.newSource("audio/retro-epic-music.wav", "static")
retroExplosion = love.audio.newSource("audio/retro-explosion.wav", "static")
retroExplosion2 = love.audio.newSource("audio/retro-explosion2.wav", "static")
retroGroove = love.audio.newSource("audio/retro-groove.wav", "static")
retroLazerShot = love.audio.newSource("audio/retro-lazer-shot.wav", "static")
retroLowBass = love.audio.newSource("audio/retro-low-bass.wav", "static")
retroNegativeTune = love.audio.newSource("audio/retro-negative-tune.wav", "static")
retroPunch = love.audio.newSource("audio/retro-punch.wav", "static")
retroSynthMusic = love.audio.newSource("audio/retro-synth-music.wav", "static")
retroTune = love.audio.newSource("audio/retro-tune.wav", "static")
retroZap = love.audio.newSource("audio/retro-zap.wav", "static")

-- all the level one sounds can be put in this function
function levelOneSounds()
  bgMusic1 = love.audio.newSource("audio/knight-fight.mp3", 'stream')
    bgMusic1:setLooping(true)
    bgMusic1:setVolume(0.5)
    bgMusic1:play()
end


-- all the level one sounds can be put in this function
function levelTwoSounds()
  bgMusic2 = love.audio.newSource("audio/dinosaur-jungle.mp3", 'stream')
    bgMusic2:setLooping(true)
    bgMusic2:setVolume(0.5)
    bgMusic2:play()
end


-- all the level one sounds can be put in this function
function levelThreeSounds()
  bgMusic3 = love.audio.newSource("audio/future-distrubia.mp3", 'stream')
    bgMusic3:setLooping(true)
    bgMusic3:setVolume(0.5)
    bgMusic3:play()
end

--

-- stops the music
function quiet1()
  bgMusic1:stop()
end

function quiet2()
  bgMusic2:stop()
end

function quiet3()
  bgMusic3:stop()
end
