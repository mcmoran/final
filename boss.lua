-- how many of each are there?

wispCount = 30
demonCount = 1

raptorCount = 5
stegoCount = 2
spinoCount = 2
trexCount = 1

soldierCount = 3
fodderCount = 10
alienCount = 1


-- all the enemy creations are set up as tables with specific parameters for reaches

-- FAE

wisp = {}

for i = 1, wispCount do
  table.insert(wisp, {
    name = ("wisp" .. i),
    x = math.random(400, 2800),
    y = math.random(64, 544),
    h = 64, w = 64,
    speedX = 100, speedY = 100,
    shotsToKill = 1,
    path = math.random(1, 6),
    state = 'patrol',
    angle = 0,
    timer = 0.5})
end

-- demon knight: Very slow enemy, has slash attacks like the player does but reaches a farther area. Shoots at the player occasionally but not a lot.

demon = {}

for i = 1, demonCount do
  table.insert(demon, {
    name = ("demon" .. i),
    x = 3600, y = 300,
    h = 128, w = 128,
    speedX = 50, speedY = 50,
    shotsToKill = 10,
    angle = 0})
end

-- DINOSAURS

-- raptor: Fast enemy, spread around the map, chases player when they get close. Take 1 hit to kill.

raptor = {}

for i = 1, raptorCount do
  table.insert(raptor, {
    name = ("raptor" .. i),
    x = math.random(2000, 2200), y = math.random(100, 500),
    h = 90, w = 90,
    speedX = 120, speedY = 120,
    shotsToKill = 1,
    angle = 0})
end

-- stegosaurus: Slow enemy, spread around the map, peaceful until hit. Take 3 hits to kill.

stego = {}

for i = 1, stegoCount do
  table.insert(stego, {
    name = ("stego" .. i),
    x = math.random(700, 900), y = math.random(200, 400),
    h = 150, w = 150,
    speedX = 70, speedY = 70,
    shotsToKill = 3})
end

-- spinosaurus - Slow enemy, hunts down the player around the map.Take 3 hits to kill.

spino = {}

for i = 1, spinoCount do
  table.insert(spino, {
    x = math.random(2400, 2600), y = math.random(50, 200),
    h = 300, w = 300,
    speedX = 50, speedY = 50,
    shotsToKill = 3})
end

-- trex: Very big and slow enemy, charges in a straight line at a the player's position.

trex = {}

for i = 1, trexCount do
  table.insert(trex, {
    x = math.random(3500, 3500), y = math.random(200, 300),
    h = 300, w = 300,
    speedX = 50, speedY = 50,
    shotsToKill = 10})
end

-- ALIENS

-- soldier: Spread around the map, shoots the player on sight, doesn't move towards the player. Take 3 shots from gun to kill. Takes 1 hit to kill

soldier = {}

for i = 1, soldierCount do
  table.insert(soldier, {
    x = math.random(300, 2100), y = math.random(200, 500),
    h = 200, w = 200,
    speedX = 0, speedY = 0,
    shotsToKill = 1})
end

-- Fodder: Spread around the map, chases down the player. Take 1 shot/hit to kill.

fodder = {}

for i = 1, fodderCount do
  table.insert(fodder, {
    name = ("fodder" .. i),
    x = math.random(500, 2800), y = math.random(200, 500),
    h = 100, w = 100,
    speedX = 80, speedY = 80,
    shotsToKill = 1,
    angle = 0})
end


-- UFO/Big alien: Big and slow enemy. Shoots at the player, charges at the player, and has an area of effect attack.

alien = {}

for i = 1, alienCount do
  table.insert(alien, {
    x = math.random(3300, 3300), y = math.random(300, 300),
    h = 300, w = 300,
    speedX = 50, speedY = 50,
    shotsToKill = 10})
end
