local HC = require "libs.HC"
local meteorsController = require ("meteorsController")

--[[
  *** VARIABILI LOCALI ***
]]

local playerController = {}

local sprite = {"assets/img/players/ShipBlue.png",
"assets/img/players/ShipGreen.png",
"assets/img/players/ShipOrange.png",
"assets/img/players/ShipRed.png"
}
local fire = "assets/fire03.png"
local bulletSprite = "assets/laser01.png"
local life = "assets/player_50_2.png"
local bulletAudioSource = "assets/laser01.wav"
local meteorExplosionAudioSource = "assets/meteorExplosion.wav"
local explosionAudioSource = "assets/explosion.wav"

local bulletList = {} -- tabella che conterrà i dati dei proiettili

local points = 0
local undead = false
local count=0

playerController.x = 0
playerController.y = 0
playerController.img = nil
playerController.velX = 0
playerController.velY = 0
playerController.acc = 6
playerController.dec = 0.3
playerController.maxVel = 9
playerController.isDebug = true
playerController.status = "play"
playerController.lives = 3


--[[
  *** FUNZIONI LOCALI ***
]]

local function createBullet()
  local img = love.graphics.newImage(bulletSprite)
  bullet = HC.rectangle(playerController.x, playerController.y - playerController.img[1]:getHeight() - 20, img:getWidth(), img:getHeight());
  bullet.img = img
  bullet.type = "Bullet"
  bullet.speed = 25

  table.insert(bulletList, bullet)

  love.audio.newSource(bulletAudioSource, "static"):play()
end

local function updateBullets(dt)
  -- muove i proiettili
  for k,bullet in pairs(bulletList) do
    local x, y = bullet:center()
    y = y - bullet.speed
    bullet:moveTo(x, y)

    if(y < -50) then
      HC.remove(bullet)
      table.remove(bulletList, k)
    end

    for shape, delta in pairs(HC.collisions(bullet)) do
      if(shape.type == "enemy") then
        -- print("Collision with: " .. shape.type .. "(" .. shape.points .. " points)")
        points = points + shape.points
        if points==500 then undead=true end

        -- distrugge il meteorite
        HC.remove(shape)
        if shape.subtype == "meteor" then
          meteorsController.remove(shape)
        elseif shape.subtype == "ship" then
          enemiesController.remove(shape)
        end
        love.audio.newSource(meteorExplosionAudioSource, "static"):play()

        -- distrugge il proiettile
        HC.remove(bullet)
        for i,value in ipairs(bulletList) do
          if bullet == value then
            table.remove(bulletList, i)
            break
          end
        end
      end
    end
  end
end

local function drawBullets()
  for k,bullet in pairs(bulletList) do
    local x, y = bullet:center()
    love.graphics.draw(bullet.img, x, y, 0, 1, 1, bullet.img:getWidth() / 2, bullet.img:getHeight() / 2)
    if isDebug then
        love.graphics.setColor(255, 0, 0, 140)
        bullet:draw('fill')
        love.graphics.setColor(255, 255, 255, 255)
    end
  end
end

--[[
  *** FUNZIONI GLOBALI ***
]]

-- inizializza i dati della navicella
function playerController.load()
    playerController.img = {love.graphics.newImage(sprite[1]),
    love.graphics.newImage(sprite[2]),
    love.graphics.newImage(sprite[3]),
    love.graphics.newImage(sprite[4])
  }
  playerController.fire = love.graphics.newImage(fire)
  playerController.width = playerController.img[1]:getWidth()
  playerController.height = playerController.img[1]:getHeight()
  playerController.x = love.graphics.getWidth() / 2
  playerController.y = love.graphics.getHeight() - 80
  playerController.life = love.graphics.newImage(life)

  -- crea il poligono per le collisioni
  playerController.shapeHC = HC.polygon(0, -60, playerController.img[1]:getWidth() / 2, 0, -playerController.img[1]:getWidth() / 2, 0)

end

function playerController.update(dt)

  -- cambio astronave
  if changeShip == 0 then
    playerController.img[1] = playerController.img[1]
  end
  if changeShip == 1 then
    playerController.img[1] = playerController.img[2]
  end
  if changeShip == 2 then
    playerController.img[1] = playerController.img[3]
  end
  if changeShip == 3 then
    playerController.img[1] = playerController.img[4]
  end

  -- se il gioco è finito, ritorna senza aggiornare nulla
  if playerController.status == "game over" then
    gameState = "gameOver"
    points = 0
  end

  -- controllo il movimento della navicella
  if (love.keyboard.isDown("left","a")) then
    playerController.velX = playerController.velX - playerController.acc
  elseif(love.keyboard.isDown("right","d")) then
    playerController.velX = playerController.velX + playerController.acc
  elseif(playerController.velX > 0) then
    playerController.velX = playerController.velX - playerController.dec
  elseif(playerController.velX < 0) then
    playerController.velX = playerController.velX + playerController.dec
  end

  -- se velX è estremamente piccola, per sicurezza, la setto a zero
  if(
    playerController.velX < 0.3 and
    playerController.velX > -0.3
  ) then
    playerController.velX = 0
  end

  -- controllo il movimento orizzontale (bordi, etc.)
  if (playerController.x < playerController.img[1]:getWidth() / 2 - playerController.velX) then
    playerController.velX = 0
    playerController.x = playerController.img[1]:getWidth() / 2
  elseif (playerController.x > 512 - playerController.velX - playerController.img[1]:getWidth() / 2) then
    playerController.velX = 0
    playerController.x = 512 - playerController.img[1]:getWidth() / 2
  else
    if(playerController.velX > playerController.maxVel) then
      playerController.velX = playerController.maxVel
    elseif((playerController.velX < -playerController.maxVel)) then
      playerController.velX = -playerController.maxVel
    end
    playerController.x = playerController.x + playerController.velX
  end

  if (love.keyboard.isDown("up","w")) then
    playerController.velY = playerController.velY - playerController.acc
  elseif(love.keyboard.isDown("down","s")) then
    playerController.velY = playerController.velY + playerController.acc
  elseif(playerController.velY > 0) then
    playerController.velY = playerController.velY - playerController.dec
  elseif(playerController.velY < 0) then
    playerController.velY = playerController.velY + playerController.dec
  end

  -- se velY è estremamente piccola, per sicurezza, la setto a zero
  if (playerController.velY < 0.3 and playerController.velY > -0.3) then
      playerController.velY = 0
  end

  -- controllo il movimento verticale (bordi, etc.)
  if (playerController.y < playerController.img[1]:getHeight() / 2 - playerController.velY+200) then
    playerController.velY = 0
    playerController.y = playerController.img[1]:getHeight() / 2+200
  elseif (playerController.y > love.graphics.getHeight() - playerController.velY - playerController.img[1]:getHeight() / 2) then
    playerController.velY = 0
    playerController.y = love.graphics.getHeight() - playerController.img[1]:getHeight() / 2
  else
    if(playerController.velY > playerController.maxVel) then
      playerController.velY = playerController.maxVel
    elseif(playerController.velY < -playerController.maxVel) then
      playerController.velY = -playerController.maxVel
    end
      playerController.y = playerController.y + playerController.velY
  end

  playerController.shapeHC:moveTo(playerController.x, playerController.y)

  updateBullets(dt)

  for shape, delta in pairs(HC.collisions(playerController.shapeHC)) do
    if(shape.type == "enemy") then

      -- distrugge il meteorite
      HC.remove(shape)
      if shape.subtype == "meteor" then
        meteorsController.remove(shape)
        meteorsController.remove(playerController.shapeHC)
      elseif shape.subtype == "ship" then
        enemiesController.remove(shape)
        enemiesController.remove(playerController.shapeHC)
      end
      love.audio.newSource(explosionAudioSource, "static"):play()
      playerController.lives = playerController.lives-1
      -- playerController.status = "play"
      if undead then if count<10 then count=count+1 else undead=false; break end
      playerController.status  = "play"
      else
        if (playerController.lives<=0) then
            playerController.status = "game over"
            end
      end
    end
  end
  --if (playerController.lives<=0) then
    --    playerController.status = "game over"
      --  end
end

function playerController.draw()
  --[[ se il gioco è finito, ritorna senza disegnare nulla
  love.graphics.setFont(font)
  if playerController.status == "game over" then
    love.graphics.printf("GAME OVER\n", 0, love.graphics.getHeight() / 2-40, love.graphics.getWidth()-280, "center")
    love.graphics.printf("\nPress spacebar to play again", 0, love.graphics.getHeight() / 2-40 + 20, love.graphics.getWidth()-280, "center")
    return
  end ]]--

  love.graphics.draw(playerController.img[1], playerController.x, playerController.y, 0, 1, 1, playerController.img[1]:getWidth() / 2, playerController.img[1]:getHeight() / 2)
  love.graphics.setColor(255, love.math.random(255), 0, love.math.random(255))
  love.graphics.draw(playerController.fire, playerController.x, playerController.y+55, 0, 1, 1, playerController.fire:getWidth() / 2, playerController.fire:getHeight() / 2)
  love.graphics.setColor(255,255,255,255)
  love.graphics.draw(playerController.life, 600, 525)
  drawBullets()

  -- se in debug mode, mostra gli elementi di HC
  if isDebug then
      love.graphics.setColor(255, 0, 0, 255)
      playerController.shapeHC:draw('line')
      love.graphics.setColor(255, 0, 0, 100)
      playerController.shapeHC:draw('fill')
  end


  love.graphics.setColor(100,100,255,255)

  love.graphics.setFont(font)

  love.graphics.print("Points: " .. points, 600, love.graphics.getHeight() - 30)
  love.graphics.print(playerController.lives, 670, love.graphics.getHeight() - 70)
  love.graphics.setColor(255,255,255,255)
end

-- crea un proiettile
function playerController.fireBullet()
  createBullet()
end

return playerController
