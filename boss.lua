-- this is where we can put functions and information related to the boss
-- or enemies


-- ENEMIES

--1) Fae

  --a) Wisps
<<<<<<< HEAD

=======
>>>>>>> 2cfd1c33b45a25176b76294e5eaf23fb3c463718
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
<<<<<<< HEAD
  raptor.x = 0
  raptor.y = 0
=======
  raptor.x = 1800
  raptor.y = 300
>>>>>>> 2cfd1c33b45a25176b76294e5eaf23fb3c463718
  raptor.speedx = 200
  raptor.speedy = 200
  raptorHitsToKill = 1
  -- Fast enemy, spread around the map, chases player when they get close. Take 1 hit to kill.

  --b) Stegosaurus
  stego = {}
<<<<<<< HEAD
  stego.x = 0
  stego.y = 0
=======
  stego.x = 800
  stego.y = 300
>>>>>>> 2cfd1c33b45a25176b76294e5eaf23fb3c463718
  stego.speedx = 70
  stego.speedy = 70
  stegoHitsToKill = 3
  -- Slow enemy, spread around the map, peaceful until hit. Take 3 hits to kill.

  --c) Spinosaurus
  spino = {}
<<<<<<< HEAD
  spino.x = 0
  spino.y = 0
  spino.speedx = 0
  spino.speedy = 0
=======
  spino.x = 2000
  spino.y = 300
  spino.speedx = 50
  spino.speedy = 50
>>>>>>> 2cfd1c33b45a25176b76294e5eaf23fb3c463718
  spinoHitsToKill = 3
  -- Slow enemy, hunts down the player around the map.Take 3 hits to kill.


--3) Aliens

  --a) Soldier
  soldier = {}
<<<<<<< HEAD
  soldier.x = 0
  soldier.y = 0
=======
  soldier.x = 600
  soldier.y = 300
>>>>>>> 2cfd1c33b45a25176b76294e5eaf23fb3c463718
  soldier.speedx = 0
  soldier.speedy = 0
  soldierHitsToKill = 3
  -- Spread around the map, shoots the player on sight, doesn't move towards the player. Take 3 shots from gun to kill. Takes 1 hit to kill

  --b) Fodder
  fodder = {}
<<<<<<< HEAD
  fodder.x = 0
  fodder.y = 0
=======
  fodder.x = 300
  fodder.y = 300
>>>>>>> 2cfd1c33b45a25176b76294e5eaf23fb3c463718
  fodder.speedx = 150
  fodder.speedy = 150
  fodderHitsToKill = 1
  -- Spread around the map, chases down the player. Take 1 shot/hit to kill.


  -- BOSSES

  --1) The "Demon" Knight
  demon = {}
<<<<<<< HEAD
  demon.x = 0
  demon.y = 0
=======
  demon.x = 3600
  demon.y = 300
>>>>>>> 2cfd1c33b45a25176b76294e5eaf23fb3c463718
  demon.speedx = 50
  demon.speedy = 50
  demonHitsToKill = 10
  -- Very slow enemy, has slash attacks like the player does but reaches a farther area. Shoots at the player occasionally but not a lot.


  --2) T-rex
  trex = {}
<<<<<<< HEAD
  trex.x = 0
  trex.y = 0
=======
  trex.x = 3000
  trex.y = 300
>>>>>>> 2cfd1c33b45a25176b76294e5eaf23fb3c463718
  trex.speedx = 50
  trex.speedy = 50
  trexHitsToKill = 10
  -- Very big and slow enemy, charges in a straight line at a the player's position.


  --3) UFO/Big Alien
  alien = {}
<<<<<<< HEAD
  alien.x = 0
  alien.y = 0
=======
  alien.x = 3300
  alien.y = 300
>>>>>>> 2cfd1c33b45a25176b76294e5eaf23fb3c463718
  alien.speedx = 50
  alien.speedy = 50
  alienHitsToKill = 10
  -- Big and slow enemy. Shoots at the player, charges at the player, and has an area of effect attack.
