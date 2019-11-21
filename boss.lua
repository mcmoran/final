-- how many of each are there?

wispCount = 4
demonCount = 1

raptorCount = 3
stegoCount = 1
spinoCount = 1
trexCount = 1

soldierCount = 4
fodderCount = 4
alienCount = 1

-- all the enemy creations are set up as tables with specific parameters for reaches

-- FAE

<<<<<<< HEAD
--<<<<<<< HEAD
wisp = {}

for i = 1, 4 do
  table.insert(wisp, {x = 0, y = 0, h = 32, w = 32, speedX = 100, speedY = 100, shotsToKill = 1})
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
raptor = {}
for i = 1, 3 do
  table.insert(raptor, {x = 0, y = 0, h = 64, w = 64, speedX = 200, speedY = 200, shotsToKill = 1})
end

raptor[1].x = 1300
raptor[1].y = 200

raptor[2].x = 1500
raptor[2].y = 300

raptor[3].x = 1700
raptor[3].y = 400

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
=======
wisp = {}

for i = 1, wispCount do
  table.insert(wisp, {
    x = math.random(300, 2600), y = math.random(200, 900),
    h = 32, w = 32,
    speedX = 100, speedY = 100,
    shotsToKill = 1})
end

-- demon knight: Very slow enemy, has slash attacks like the player does but reaches a farther area. Shoots at the player occasionally but not a lot.

demon = {}

for i = 1, demonCount do
  table.insert(demon, {
    x = math.random(3600, 3600), y = math.random(300, 300),
    h = 128, w = 128,
    speedX = 50, speedY = 50,
    shotsToKill = 10})
end

-- DINOSAURS

-- raptor: Fast enemy, spread around the map, chases player when they get close. Take 1 hit to kill.

raptor = {}

for i = 1, raptorCount do
  table.insert(raptor, {
    x = math.random(1350, 1550), y = math.random(300, 400),
    h = 64, w = 64,
    speedX = 200, speedY = 200,
    shotsToKill = 1})
end

-- stegosaurus: Slow enemy, spread around the map, peaceful until hit. Take 3 hits to kill.

stego = {}

for i = 1, stegoCount do
  table.insert(stego, {
    x = math.random(700, 900), y = math.random(200, 400),
    h = 128, w = 64,
    speedX = 70, speedY = 70,
    shotsToKill = 3})
end

-- spinosaurus - Slow enemy, hunts down the player around the map.Take 3 hits to kill.

spino = {}

for i = 1, spinoCount do
  table.insert(spino, {
    x = math.random(1900, 2100), y = math.random(200, 400),
    h = 128, w = 64,
    speedX = 50, speedY = 50,
    shotsToKill = 3})
end

-- trex: Very big and slow enemy, charges in a straight line at a the player's position.

trex = {}

for i = 1, trexCount do
  table.insert(trex, {
    x = math.random(3000, 3000), y = math.random(300, 300),
    h = 192, w = 128,
    speedX = 50, speedY = 50,
    shotsToKill = 10})
end

-- ALIENS

-- soldier: Spread around the map, shoots the player on sight, doesn't move towards the player. Take 3 shots from gun to kill. Takes 1 hit to kill

soldier = {}

for i = 1, soldierCount do
  table.insert(soldier, {
    x = math.random(300, 2100), y = math.random(200, 500),
    h = 64, w = 32,
    speedX = 0, speedY = 0,
    shotsToKill = 1})
end

-- Fodder: Spread around the map, chases down the player. Take 1 shot/hit to kill.

fodder = {}

for i = 1, fodderCount do
  table.insert(soldier, {
    x = math.random(300, 2100), y = math.random(200, 500),
    h = 32, w = 32,
    speedX = 150, speedY = 150,
    shotsToKill = 1})
end


-- UFO/Big alien: Big and slow enemy. Shoots at the player, charges at the player, and has an area of effect attack.

alien = {}

for i = 1, alienCount do
  table.insert(alien, {
    x = math.random(3300, 3300), y = math.random(300, 300),
    h = 64, w = 128,
    speedX = 50, speedY = 50,
    shotsToKill = 10})
end
>>>>>>> ce17133a565f640ee3a3d7dcf9a30000160eeddc
