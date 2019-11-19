-- this is where we can put functions and information related to the boss
-- or enemies


-- ENEMIES

--1) Fae

wisp = {}

for i = 1, 4 do
  table.insert(wisp, {x = 0, y = 0, h = 32, w = 32, speedX = 1200, speedY = 100, shotsToKill = 1})
end

wisp[1].x = 1200
wisp[1].y = 900

wisp[2].x = 1600
wisp[2].y = 400

wisp[3].x = 2200
wisp[3].y = 320

wisp[4].x = 2600
wisp[4].y = 200


--2) Dinosaurs

  --a) Raptor
  raptor = {}
  raptor.x = 1800
  raptor.y = 300
  raptor.speedx = 200
  raptor.speedy = 200
  raptorHitsToKill = 1
  -- Fast enemy, spread around the map, chases player when they get close. Take 1 hit to kill.

  --b) Stegosaurus
  stego = {}
  stego.x = 800
  stego.y = 300
  stego.speedx = 70
  stego.speedy = 70
  stegoHitsToKill = 3
  -- Slow enemy, spread around the map, peaceful until hit. Take 3 hits to kill.

  --c) Spinosaurus
  spino = {}
  spino.x = 2000
  spino.y = 300
  spino.speedx = 50
  spino.speedy = 50
  spinoHitsToKill = 3
  -- Slow enemy, hunts down the player around the map.Take 3 hits to kill.


--3) Aliens

  --a) Soldier
  soldier = {}
  soldier.x = 600
  soldier.y = 300
  soldier.speedx = 0
  soldier.speedy = 0
  soldierHitsToKill = 3
  -- Spread around the map, shoots the player on sight, doesn't move towards the player. Take 3 shots from gun to kill. Takes 1 hit to kill

  --b) Fodder
  fodder = {}
  fodder.x = 300
  fodder.y = 300
  fodder.speedx = 150
  fodder.speedy = 150
  fodderHitsToKill = 1
  -- Spread around the map, chases down the player. Take 1 shot/hit to kill.


  -- BOSSES

  --1) The "Demon" Knight
  demon = {}
  demon.x = 3600
  demon.y = 300
  demon.speedx = 50
  demon.speedy = 50
  demonHitsToKill = 10
  -- Very slow enemy, has slash attacks like the player does but reaches a farther area. Shoots at the player occasionally but not a lot.


  --2) T-rex
  trex = {}
  trex.x = 3000
  trex.y = 300
  trex.speedx = 50
  trex.speedy = 50
  trexHitsToKill = 10
  -- Very big and slow enemy, charges in a straight line at a the player's position.


  --3) UFO/Big Alien
  alien = {}
  alien.x = 3300
  alien.y = 300
  alien.speedx = 50
  alien.speedy = 50
  alienHitsToKill = 10
  -- Big and slow enemy. Shoots at the player, charges at the player, and has an area of effect attack.
