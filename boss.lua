-- this is where we can put functions and information related to the boss
-- or enemies


-- ENEMIES

--1) Fae

--<<<<<<< HEAD
wisp = {}

for i = 1, 4 do
  table.insert(wisp, {x = 0, y = 0, h = 32, w = 32, speedX = 1200, speedY = 100, shotsToKill = 1})
end

wisp[1].x = 1200
wisp[1].y = 200

wisp[2].x = 1600
wisp[2].y = 400

wisp[3].x = 2200
wisp[3].y = 320

wisp[4].x = 2600
wisp[4].y = 200

--=======
  --a) Wisps
  wisp1 = {}
  wisp1.x = 1200
  wisp1.y = 190
  wisp1.speedX = 100
  wisp1.speedY = 100
  wisp1HitsToKill = 1
  -- Have already around the map and will chase player when they get close. Take 1 hit to kill.

  wisp2 = {}
  wisp2.x = 1600
  wisp2.y = 400
  wisp2.speedX = 100
  wisp2.speedY = 100
  wisp2HitsToKill = 1

  wisp3 = {}
  wisp3.x = 2200
  wisp3.y = 320
  wisp3.speedX = 100
  wisp3.speedY = 100
  wisp3HitsToKill = 1

  wisp4 = {}
  wisp4.x = 2600
  wisp4.y = 200
  wisp4.speedX = 100
  wisp4.speedY = 100
  wisp4HitsToKill = 1
-->>>>>>> 5ae72807c84c0e96bd1000b37072f1831594a92e

--2) Dinosaurs

  --a) Raptor
  raptor1 = {}
  raptor1.x = 1350
  raptor1.y = 300
  raptor1.speedx = 200
  raptor1.speedy = 200
  raptor1HitsToKill = 1

  raptor2 = {}
  raptor2.x = 1450
  raptor2.y = 350
  raptor2.speedx = 200
  raptor2.speedy = 200
  raptor2HitsToKill = 1

  raptor3 = {}
  raptor3.x = 1550
  raptor3.y = 400
  raptor3.speedx = 200
  raptor3.speedy = 200
  raptor3HitsToKill = 1
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
