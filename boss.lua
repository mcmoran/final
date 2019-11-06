-- this is where we can put functions and information related to the boss
-- or enemies


-- ENEMIES

--1) Fae

  --a) Wisps
  wisps = {}
  wispsHitsToKill = 1
  wispsSpeed = 100
  -- Have already around the map and will chase player when they get close. Take 1 hit to kill.


--2) Dinosaurs

  --a) Raptor
  raptor = {}
  raptorHitsToKill = 1
  raptorSpeed = 200
  -- Fast enemy, spread around the map, chases player when they get close. Take 1 hit to kill.

  --b) Stegosaurus
  stego = {}
  stegoHitsToKill = 3
  stegoSpeed = 70
  -- Slow enemy, spread around the map, peaceful until hit. Take 3 hits to kill.

  --c) Spinosaurus
  spino = {}
  spinoHitsToKill = 3
  spinoSpeed = 70
  -- Slow enemy, hunts down the player around the map.Take 3 hits to kill.


--3) Aliens

  --a) Soldier
  soldier = {}
  soldierHitsToKill = 3
  soldierSpeed = 0
  -- Spread around the map, shoots the player on sight, doesn't move towards the player. Take 3 shots from gun to kill. Takes 1 hit to kill

  --b) Fodder
  fodder = {}
  fodderHitsToKill = 1
  fodderSpeed = 150
  -- Spread around the map, chases down the player. Take 1 shot/hit to kill.


  -- BOSSES

  --1) The "Demon" Knight
  demon = {}
  demonHitsToKill = 10
  demonSpeed = 50
  -- Very slow enemy, has slash attacks like the player does but reaches a farther area. Shoots at the player occasionally but not a lot.


  --2) T-rex
  trex = {}
  trexHitsToKill = 10
  trexSpeed = 50
  -- Very big and slow enemy, charges in a straight line at a the player's position.


  --3) UFO/Big Alien
  alien = {}
  alienHitsToKill = 10
  alienSpeed = 50
  -- Big and slow enemy. Shoots at the player, charges at the player, and has an area of effect attack.
