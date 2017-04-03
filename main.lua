local HC = require "libs.HC"

isDebug = false;

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
  backgroundController.update(dt)
  playerController.update(dt)
  meteorsController.update(dt)
  enemiesController.update(dt)

  if meteorsController.GenNumMeteors()==0 then
     meteorsController.generateMeteors()
     enemiesController.generateEnemies()
  end
end

function love.draw()
  backgroundController.draw()
  playerController.draw()
  meteorsController.draw()
  enemiesController.draw()
  love.graphics.print(string.format("Press 'p' key to enter HC debug mode (currently set to: %s)", isDebug), 10, 10)
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

  if(key == "p") then
    isDebug = not isDebug
    playerController.isDebug = isDebug
    meteorsController.isDebug = isDebug
  end

end
