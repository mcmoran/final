

function shooting (dt)

  -- weapon shoots
if level == 1 then
  if love.keyboard.isDown('space') then
    swordSlash:play()
    if player.facing == 'right' or player.facing == 'up' then
      knight2AttackRight:draw(knight2AttackSprite, player.x + player.w / 2, player.y, 0, player.dir, 1, player.w / 2, 0)
    elseif player.facing == 'left' or player.facing == 'down' then
      knight2AttackLeft:draw(knight2AttackSprite, player.x + player.w / 2, player.y, 0, player.dir, 1, player.w / 2, 0)
    end
    if weaponTimer >= 1 then
      weaponTimer = 0
      table.insert(shots, {x = weapon.x, y = weapon.y, w = weapon.w, h = weapon.h, dirX = weapon.dirX, dirY = weapon.dirY, timeLeft = 0.05})
    end
  end
end

if level == 2 then
  if love.keyboard.isDown('space') then
    arrowShot:play()
    if weaponTimer >= 1.4 then
      weaponTimer = 0
      table.insert(shots, {x = weapon.x, y = weapon.y, w = weapon.w, h = weapon.h, dirX = weapon.dirX, dirY = weapon.dirY, timeLeft = 4})
    end
  end
end

if level == 3 then
  if love.keyboard.isDown('space') then
    retroLazerShot:play()
    if weaponTimer >= 1 then
      weaponTimer = 0
      table.insert(shots, {x = weapon.x, y = weapon.y, w = weapon.w, h = weapon.h, dirX = weapon.dirX, dirY = weapon.dirY, timeLeft = 4})
    end
  end
end
  -- shot location & collision detection
  for shotsIndex = #shots, 1, -1 do
    local shot = shots[shotsIndex]

    shot.timeLeft = shot.timeLeft - dt
    if shot.timeLeft <= 0 then
      table.remove(shots, shotsIndex)
    else
      shot.x = (shot.x + shot.dirX * weapon.maxSpeed * dt)
      shot.y = (shot.y + shot.dirY * weapon.maxSpeed * dt)
    end
    if shot.x > (player.x + 500) then
      table.remove(shots, shotsIndex)
    end
    if shot.x < (player.x - 500) then
      table.remove(shots, shotsIndex)
    end
  end

end

function collision (dt)

  -- COLLISION FOR ENEMIES
if level == 1 then
  -- collision detection for wisps
  for i = #wisp, 1, -1 do
    -- check player vs. wisps
    if AABB(player.x, player.y, player.w, player.h, wisp[i].x, wisp[i].y, wisp[i].w, wisp[i].h) then
      --gamestart = false
      gameOver()
      lives = lives - 1
      reset()
    end
    -- check weapon vs. wisps
    if AABB(weapon.x, weapon.y, weapon.w, weapon.h, wisp[i].x, wisp[i].y, wisp[i].w, wisp[i].h) then
      table.remove(wisp, i)
      score = score + 1
      break
    end
    -- check shot vs. wisps
    for j = #shots, 1, -1 do
      if AABB(shots[j].x, shots[j].y, shots[j].w, shots[j].h, wisp[i].x, wisp[i].y, wisp[i].w, wisp[i].h) then
        table.remove(wisp, i)
        table.remove(shots, j)
        score = score + 1
        break
      end
    end
  end

  -- collision detection for demon
  for i = #demon, 1, -1 do
    if AABB(player.x, player.y, player.w, player.h, demon[i].x, demon[i].y, demon[i].w, demon[i].h) then
      --gamestart = false
      gameOver()
      lives = lives - 1
      reset()
    end
    -- check weapon vs. demon
    if AABB(weapon.x, weapon.y, weapon.w, weapon.h, demon[i].x, demon[i].y, demon[i].w, demon[i].h) then
      table.remove(demon, i)
      score = score + 1
      enemiesShot = true
      break
    end
    -- check shot vs. demon
    for j = #shots, 1, -1 do
      if AABB(shots[j].x, shots[j].y, shots[j].w, shots[j].h, demon[i].x, demon[i].y, demon[i].w, demon[i].h) then
        table.remove(demon, i)
        table.remove(shots, j)
        enemiesShot = true
        score = score + 1
        break
      end
    end
  end
end

  -- collision detection for raptor
if level == 2 then
for i = #raptor, 1, -1 do
    if AABB(player.x, player.y, player.w, player.h, raptor[i].x, raptor[i].y, raptor[i].w, raptor[i].h) then
      --gamestart = false
      gameOver()
      lives = lives - 1
      reset()
    end
    -- check weapon vs. raptor
    if AABB(weapon.x, weapon.y, weapon.w, weapon.h, raptor[i].x, raptor[i].y, raptor[i].w, raptor[i].h) then
      table.remove(wisp, i)
      score = score + 1
      break
    end
    -- check shot vs. raptor
    for j = #shots, 1, -1 do
      if AABB(shots[j].x, shots[j].y, shots[j].w, shots[j].h, raptor[i].x, raptor[i].y, raptor[i].w, raptor[i].h) then
        table.remove(raptor, i)
        table.remove(shots, j)
        score = score + 1
        break
      end
    end
  end

  -- collision detection for stego
  for i = #stego, 1, -1 do
    if AABB(player.x, player.y, player.w, player.h, stego[i].x, stego[i].y, stego[i].w, stego[i].h) then
      --gamestart = false
      lives = lives - 1
      reset()
    end
    -- check weapon vs. stego
    if AABB(weapon.x, weapon.y, weapon.w, weapon.h, stego[i].x, stego[i].y, stego[i].w, stego[i].h) then
      table.remove(stego, i)
      score = score + 1
      break
    end
    -- check shot vs. stego
    for j = #shots, 1, -1 do
      if AABB(shots[j].x, shots[j].y, shots[j].w, shots[j].h, stego[i].x, stego[i].y, stego[i].w, stego[i].h) then
        table.remove(stego, i)
        table.remove(shots, j)
        score = score + 1
        break
      end
    end
  end

  -- collision detection for spino
  for i = #spino, 1, -1 do
    if AABB(player.x, player.y, player.w, player.h, spino[i].x, spino[i].y, spino[i].w, spino[i].h) then
      --gamestart = false
      lives = lives - 1
      gameOver()
      reset()
    end
    -- check weapon vs. spino
    if AABB(weapon.x, weapon.y, weapon.w, weapon.h, spino[i].x, spino[i].y, spino[i].w, spino[i].h) then
      table.remove(spino, i)
      score = score + 1
      break
    end
    -- check shot vs. spino
    for j = #shots, 1, -1 do
      if AABB(shots[j].x, shots[j].y, shots[j].w, shots[j].h, spino[i].x, spino[i].y, spino[i].w, spino[i].h) then
        table.remove(spino, i)
        table.remove(shots, j)
        score = score + 1
        break
      end
    end
  end

  -- collision detection for trex
  for i = #trex, 1, -1 do
    if AABB(player.x, player.y, player.w, player.h, trex[i].x, trex[i].y, trex[i].w, trex[i].h) then
      --gamestart = false
      lives = lives - 1
      gameOver()
      reset()
    end
    -- check weapon vs. trex
    if AABB(weapon.x, weapon.y, weapon.w, weapon.h, trex[i].x, trex[i].y, trex[i].w, trex[i].h) then
      table.remove(trex, i)
      score = score + 1
      break
    end
    -- check shot vs. trex
    for j = #shots, 1, -1 do
      if AABB(shots[j].x, shots[j].y, shots[j].w, shots[j].h, trex[i].x, trex[i].y, trex[i].w, trex[i].h) then
        table.remove(trex, i)
        table.remove(shots, j)
        score = score + 1
        enemiesShot = true
        break
      end
    end
  end
end
  -- collision detection for soldier
if level == 3 then
for i = #soldier, 1, -1 do
    if AABB(player.x, player.y, player.w, player.h, soldier[i].x, soldier[i].y, soldier[i].w, soldier[i].h) then
      --gamestart = false
      lives = lives - 1
      gameOver()
      reset()
    end
    -- check weapon vs. soldier
    if AABB(weapon.x, weapon.y, weapon.w, weapon.h, soldier[i].x, soldier[i].y, soldier[i].w, soldier[i].h) then
      table.remove(soldier, i)
      score = score + 1
      break
    end
    -- check shot vs. soldier
    for j = #shots, 1, -1 do
      if AABB(shots[j].x, shots[j].y, shots[j].w, shots[j].h, soldier[i].x, soldier[i].y, soldier[i].w, soldier[i].h) then
        table.remove(soldier, i)
        table.remove(shots, j)
        score = score + 1
        break
      end
    end
  end

  -- collision detection for fodder
  for i = #fodder, 1, -1 do
    if AABB(player.x, player.y, player.w, player.h, fodder[i].x, fodder[i].y, fodder[i].w, fodder[i].h) then
    --gamestart = false
    lives = lives - 1
    gameOver()
    reset()
    end
    -- check weapon vs. fodder
    if AABB(weapon.x, weapon.y, weapon.w, weapon.h, fodder[i].x, fodder[i].y, fodder[i].w, fodder[i].h) then
      table.remove(fodder, i)
      score = score + 1
      break
    end
    -- check shot vs. fodder
    for j = #shots, 1, -1 do
      if AABB(shots[j].x, shots[j].y, shots[j].w, shots[j].h, fodder[i].x, fodder[i].y, fodder[i].w, fodder[i].h) then
        table.remove(fodder, i)
        table.remove(shots, j)
        score = score + 1
        break
      end
    end
  end

  -- collision detection for alien
  for i = #alien, 1, -1 do
    if AABB(player.x, player.y, player.w, player.h, alien[i].x, alien[i].y, alien[i].w, alien[i].h) then
    --gamestart = false
    lives = lives - 1
    gameOver()
    reset()
    end
    -- check weapon vs. alien
    if AABB(weapon.x, weapon.y, weapon.w, weapon.h, alien[i].x, alien[i].y, alien[i].w, alien[i].h) then
      table.remove(alien, i)
      score = score + 1
      break
    end
    -- check shot vs. alien
    for j = #shots, 1, -1 do
      if AABB(shots[j].x, shots[j].y, shots[j].w, shots[j].h, alien[i].x, alien[i].y, alien[i].w, alien[i].h) then
        table.remove(alien, i)
        table.remove(shots, j)
        score = score + 1
        enemiesShot = true
        break
      end
    end
  end
end
end -- end function
