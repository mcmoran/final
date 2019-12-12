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

swordSlash = love.audio.newSource("audio/sword-slash.mp3", "static")
arrowShot = love.audio.newSource("audio/arrow-shooting.wav", "static")

-- all the level one sounds can be put in this function

function playMusic()
  if level == 1 then
    bgMusic1 = love.audio.newSource("audio/knight-fight.mp3", 'stream')
    bgMusic1:setLooping(true)
    bgMusic1:setVolume(0.5)
    bgMusic1:play()
  elseif level == 2 then
    bgMusic2 = love.audio.newSource("audio/dinosaur-jungle.mp3", 'stream')
    bgMusic2:setLooping(true)
    bgMusic2:setVolume(0.5)
    bgMusic2:play()
  elseif level == 3 then
    bgMusic3 = love.audio.newSource("audio/future-distrubia.mp3", 'stream')
    bgMusic3:setLooping(true)
    bgMusic3:setVolume(0.5)
    bgMusic3:play()
  end 
end

--

-- stops the music
function quiet()
  if bgMusic1 then
    bgMusic1:stop()
    elseif bgMusic2 then
    bgMusic2:stop()
    elseif bgMusic3 then
    bgMusic3:stop()
  end
end
