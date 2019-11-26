function shooting (dt)

  -- weapon shoots
  if love.keyboard.isDown('space') then
    if weaponTimer >= 0.5 then
      weaponTimer = 0
      table.insert(shots, {x = weapon.x, y = weapon.y, w = weapon.w, h = weapon.h, dirX = weapon.dirX, dirY = weapon.dirY, timeLeft = 4})
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

    --[[ weapon shot collision detection
    if AABB(shot.x, shot.y, shot.w, shot.h, enemy.x, enemy.y, enemy.w, enemy.h) then
      enemy.x = math.random(player.w, MAX_WINDOW_X - player.w)
      enemy.y = math.random(player.h, MAX_WINDOW_Y - player.h)
      table.remove(shots, shotsIndex)
      enemiesShot = enemiesShot + 1
    end ]]
  end

end

function collision (dt)

  -- weapon collision detection
  if AABB(weapon.x, weapon.y, weapon.w, weapon.h, enemy.x, enemy.y, enemy.w, enemy.h) then
    enemiesShot = enemiesShot + 1
  end

  -- player collision detection ends game
  if AABB(player.x, player.y, player.w, player.h, enemy.x, enemy.y, enemy.w, enemy.h) then
    --gamestart = false
    reset()
  end

  -- COLLISION FOR ENEMIES

  -- collision detection for wisps
  for i = 1, #wisp do
    if AABB(player.x, player.y, player.w, player.h, wisp[i].x, wisp[i].y, wisp[i].w, wisp[i].h) then
      --gamestart = false
      reset()
    end
  end

  -- collision detection for demon
  for i = 1, #demon do
    if AABB(player.x, player.y, player.w, player.h, demon[i].x, demon[i].y, demon[i].w, demon[i].h) then
      --gamestart = false
      reset()
    end
  end

  -- collision detection for raptor
  for i = 1, #raptor do
    if AABB(player.x, player.y, player.w, player.h, raptor[i].x, raptor[i].y, raptor[i].w, raptor[i].h) then
      --gamestart = false
      reset()
    end
  end

  -- collision detection for stego
  for i = 1, #stego do
    if AABB(player.x, player.y, player.w, player.h, stego[i].x, stego[i].y, stego[i].w, stego[i].h) then
      --gamestart = false
      reset()
    end
  end

  -- collision detection for spino
  for i = 1, #spino do
    if AABB(player.x, player.y, player.w, player.h, spino[i].x, spino[i].y, spino[i].w, spino[i].h) then
      --gamestart = false
      reset()
    end
  end

  -- collision detection for trex
  for i = 1, #trex do
    if AABB(player.x, player.y, player.w, player.h, trex[i].x, trex[i].y, trex[i].w, trex[i].h) then
      --gamestart = false
      reset()
    end
  end

  -- collision detection for soldier
  for i = 1, #soldier do
    if AABB(player.x, player.y, player.w, player.h, soldier[i].x, soldier[i].y, soldier[i].w, soldier[i].h) then
      --gamestart = false
      reset()
    end
  end

  -- collision detection for fodder
  for i = 1, #fodder do
    if AABB(player.x, player.y, player.w, player.h, fodder[i].x, fodder[i].y, fodder[i].w, fodder[i].h) then
    --gamestart = false
    reset()
    end
  end

  -- collision detection for alien
  for i = 1, #alien do
    if AABB(player.x, player.y, player.w, player.h, alien[i].x, alien[i].y, alien[i].w, alien[i].h) then
    --gamestart = false
    reset()
    end
  end

end -- end function
