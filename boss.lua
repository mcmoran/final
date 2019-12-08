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

wisp = {}

for i = 1, wispCount do
  table.insert(wisp, {
    name = ("wisp" .. i),
    x = math.random(1000, 2600),
    y = math.random(64, 544),
    h = 32, w = 32,
    speedX = 100, speedY = 100,
    shotsToKill = 1})
end

-- demon knight: Very slow enemy, has slash attacks like the player does but reaches a farther area. Shoots at the player occasionally but not a lot.

demon = {}

for i = 1, demonCount do
  table.insert(demon, {
    name = ("demon" .. i),
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
    name = ("raptor" .. i),
    x = math.random(1350, 1550), y = math.random(300, 400),
    h = 64, w = 64,
    speedX = 200, speedY = 200,
    shotsToKill = 1})
end

-- stegosaurus: Slow enemy, spread around the map, peaceful until hit. Take 3 hits to kill.

stego = {}

for i = 1, stegoCount do
  table.insert(stego, {
    name = ("stego" .. i),
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
