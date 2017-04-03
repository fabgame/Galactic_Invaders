local HC = require "libs.HC"

isDebug = false
isPaused = false

playerController = require ("playerController")
backgroundController = require ("backgroundController")
meteorsController = require ("meteorsController")
enemiesController = require ("enemiesController")

function love.load(arg)
  backgroundController.load()
  playerController.load()
  --meteorsController.load()
end

function love.update(dt)
  if love.keypressed("p") then
    isPaused = not isPaused
    return
  end
  backgroundController.update(dt)
  playerController.update(dt)
  meteorsController.update(dt)
  enemiesController.update(dt)

  if meteorsController.GenNumMeteors()==0 and enemiesController.GenNumEnemies() == 0 then
    if love.math.random(10) >5 then
        meteorsController.generateMeteors()
    else
        enemiesController.generateEnemies()
    end
  end
end

function love.draw()
  backgroundController.draw()
  playerController.draw()
  meteorsController.draw()
  enemiesController.draw()
  love.graphics.print(string.format("Press 'h' key to enter HC debug mode (currently set to: %s)", isDebug), 10, 10)
end

function love.keypressed(key, scancode, isrepeat)
  -- se è premuto 'escape' chiude uil gioco
  if(key == "escape") then
    love.event.push('quit')
  end

  if(key == "space" and playerController.status == "game over") then
    playerController.status = "play"
  elseif(key == "space") then
    playerController.fireBullet()
  end

  if(key == "h") then
    isDebug = not isDebug
    playerController.isDebug = isDebug
    meteorsController.isDebug = isDebug
  end
end
