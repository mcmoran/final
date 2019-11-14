-- this is where we can put functions and information related to the boss
-- or enemies


-- ENEMIES

--1) Fae

  --a) Wisps
if level == 1 and change then
  wisps = {}
  wisps.x = 1800
  wisps.y = 300
  wisps.speedX = 100
  wisps.speedY = 100
  wispsHitsToKill = 1
  -- Have already around the map and will chase player when they get close. Take 1 hit to kill.


--2) Dinosaurs

  --a) Raptor
  raptor = {}
  raptor.x =
  raptor.y =
  raptor.speedx = 200
  raptor.speedy = 200
  raptorHitsToKill = 1
  -- Fast enemy, spread around the map, chases player when they get close. Take 1 hit to kill.

  --b) Stegosaurus
  stego = {}
  stego.x =
  stego.y =
  stego.speedx = 70
  stego.speedy = 70
  stegoHitsToKill = 3
  -- Slow enemy, spread around the map, peaceful until hit. Take 3 hits to kill.

  --c) Spinosaurus
  spino = {}
  spino.x =
  spino.y =
  spino.speedx =
  spino.speedy =
  spinoHitsToKill = 3
  -- Slow enemy, hunts down the player around the map.Take 3 hits to kill.


--3) Aliens

  --a) Soldier
  soldier = {}
  soldier.x =
  soldier.y =
  soldier.speedx = 0
  soldier.speedy = 0
  soldierHitsToKill = 3
  -- Spread around the map, shoots the player on sight, doesn't move towards the player. Take 3 shots from gun to kill. Takes 1 hit to kill

  --b) Fodder
  fodder = {}
  fodder.x =
  fodder.y =
  fodder.speedx = 150
  fodder.speedy = 150
  fodderHitsToKill = 1
  -- Spread around the map, chases down the player. Take 1 shot/hit to kill.


  -- BOSSES

  --1) The "Demon" Knight
  demon = {}
  demon.x =
  demon.y =
  demon.speedx = 50
  demon.speedy = 50
  demonHitsToKill = 10
  -- Very slow enemy, has slash attacks like the player does but reaches a farther area. Shoots at the player occasionally but not a lot.


  --2) T-rex
  trex = {}
  trex.x =
  trex.y =
  trex.speedx = 50
  trex.speedy = 50
  trexHitsToKill = 10
  -- Very big and slow enemy, charges in a straight line at a the player's position.


  --3) UFO/Big Alien
  alien = {}
  alien.x =
  alien.y =
  alien.speedx = 50
  alien.speedy = 50
  alienHitsToKill = 10
  -- Big and slow enemy. Shoots at the player, charges at the player, and has an area of effect attack.
