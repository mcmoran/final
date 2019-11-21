function collision ()


  -- weapon shoots
  if love.keyboard.isDown('space') then
    if weaponTimer >= 0.5 then
      weaponTimer = 0
      table.insert(shots, {x = weapon.x, y = weapon.y, w = weapon.w, h = weapon.h, dirX = weapon.dirX, dirY = weapon.dirY, timeLeft = 4})
    end
  end

  -- shot location
  for shotsIndex = #shots, 1, -1 do
    local shot = shots[shotsIndex]

    shot.timeLeft = shot.timeLeft - dt
    if shot.timeLeft <= 0 then
      table.remove(shots, shotsIndex)
    else
      shot.x = (shot.x + shot.dirX * weapon.maxSpeed * dt)
      shot.y = (shot.y + shot.dirY * weapon.maxSpeed * dt)
    end

    -- weapon shot collision detection
    if AABB(shot.x, shot.y, shot.w, shot.h, enemy.x, enemy.y, enemy.w, enemy.h) then
      enemy.x = math.random(player.w, MAX_WINDOW_X - player.w)
      enemy.y = math.random(player.h, MAX_WINDOW_Y - player.h)
      table.remove(shots, shotsIndex)
      enemiesShot = enemiesShot + 1
    end
  end

  -- weapon collision detection
  if AABB(weapon.x, weapon.y, weapon.w, weapon.h, enemy.x, enemy.y, enemy.w, enemy.h) then
    --enemy.x = math.random(player.w, MAX_WINDOW_X - player.w)
    --enemy.y = math.random(player.h, MAX_WINDOW_Y - player.h)
    enemiesShot = enemiesShot + 1
  end

  -- player collision detection ends game
  if AABB(player.x, player.y, player.w, player.h, enemy.x, enemy.y, enemy.w, enemy.h) then
    gamestart = false
    reset()
  end

end -- end function 
