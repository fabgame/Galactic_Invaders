local HC = require "libs.HC"

--[[
  *** VARIABILI LOCALI ***
]]
local enemiesController = {}

local sprites = {"assets/enemyBlack1.png", "assets/enemyGreen5.png", "assets/enemyRed4.png"}
local enemyList = {}

--[[
  *** VARIABILI GLOBALI ***
]]
enemiesController.isDebug = true


function enemiesController.generateEnemies()
  -- genera tre meteoriti e li aggiunge alla lista
  for i=1,3 do
    local posX, posY = 130 * i, -100
    local img = love.graphics.newImage(sprites[i])
    local enemy = HC.circle(posX, posY, img:getWidth() / 2);
    enemy.type = "enemy"
    enemy.subtype = "ship"
    enemy.img = img
    enemy.points = 10 * i
    --meteor.rotation = 0
    --meteor.rotationSpeed = i
    enemy.speed = love.math.random(400, 600)

    table.insert(enemyList, enemy)
  end
end

--[[
  *** FUNZIONI GLOBALI ***
]]

--function enemiesController.load()
  --generateMeteors()
--end

function enemiesController.update(dt)
  for i,enemy in ipairs(enemyList) do
    --meteor.rotation = meteor.rotation + meteor.rotationSpeed * dt

    local x, y = enemy:center()
    y = y + dt * enemy.speed
    enemy:moveTo(x, y)
  end
end

function enemiesController.draw()
  for i,enemy in ipairs(enemyList) do
    local x, y = enemy:center()
    love.graphics.draw(enemy.img, x, y, 0, 1, 1, enemy.img:getWidth() / 2, enemy.img:getHeight() / 2)

    -- se in debug mode, mostra gli elementi di HC
    if isDebug then
        love.graphics.setColor(255, 0, 0, 255)
        enemy:draw('line')
        love.graphics.setColor(255, 0, 0, 100)
        enemy:draw('fill')
    end
    love.graphics.setColor(255,255,255, 255)

    if y>love.graphics.getHeight()+50 then
      enemiesController.remove(enemy)
    end
  end
end

function enemiesController.remove(enemy)
  -- rimuove un meteorite dalla lista
  for i,value in ipairs(enemyList) do
    if enemy == value then
      table.remove(enemyList, i)
      break
    end
  end

  -- se non esistono più meteoriti nella lista, rigenerali
--  if table.getn(meteorList) == 0 then
  --  generateMeteors()
  --end
end

function enemiesController.GenNumEnemies()
  return table.getn(enemyList)
end

return enemiesController
