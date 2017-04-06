local backgroundController = {}

--[[
  *** VARIABILI GLOBALI ***
]]

backgroundController.img = nil

--[[
  *** VARIABILI LOCALI ***
]]

local layer1a = {}
local layer1b = {}
local layer2a = {}
local layer2b = {}

local layer1Speed = .5
local layer2Speed = 3

local sprite = "assets/bg1.png"
local sprite2 = "assets/bg3.png"
local sprite3 = "assets/cornice_titolo.png"

--[[
  *** FUNZIONI LOCALI ***
]]

--[[
  *** FUNZIONI GLOBALI ***
]]

-- inizializza i dati dello sfondo
function backgroundController.load()
  font2 = love.graphics.newFont("assets/kenvector_future.ttf", 13)
  backgroundController.img = love.graphics.newImage(sprite)
  backgroundController.img2 = love.graphics.newImage(sprite2)
  backgroundController.img3 = love.graphics.newImage(sprite3)

  layer1a.quad = love.graphics.newQuad(0, 0, backgroundController.img:getWidth(), backgroundController.img:getHeight(), backgroundController.img:getDimensions())
  layer1b.quad = love.graphics.newQuad(0, 0, backgroundController.img:getWidth(), backgroundController.img:getHeight(), backgroundController.img:getDimensions())
  layer2a.quad = love.graphics.newQuad(0, 0, backgroundController.img2:getWidth(), backgroundController.img2:getHeight(), backgroundController.img2:getDimensions())
  layer2b.quad = love.graphics.newQuad(0, 0, backgroundController.img2:getWidth(), backgroundController.img2:getHeight(), backgroundController.img2:getDimensions())
  layer1a.pos = 0
  layer1b.pos = layer1a.pos - backgroundController.img:getHeight()
  layer2a.pos = 0
  layer2b.pos = layer2a.pos - backgroundController.img:getHeight()

  cassa = dofile("cassa.lua")
  frame = 1;  -- definisci il frame selezionato
  frameDuration = 0.10  -- definisci la durata di un frame
  timeElapsed = 0 -- calcola il tempo per il cambiamento dei frame
end

function backgroundController.update(dt)
  layer1a.pos = layer1a.pos + layer1Speed
  layer1b.pos = layer1b.pos + layer1Speed
  layer2a.pos = layer2a.pos + layer2Speed
  layer2b.pos = layer2b.pos + layer2Speed

  if(layer1a.pos >= backgroundController.img:getHeight()) then
    layer1a.pos = layer1b.pos - backgroundController.img:getHeight()
  end
  if(layer1b.pos >= backgroundController.img:getHeight()) then
    layer1b.pos = layer1a.pos - backgroundController.img:getHeight()
  end
  if(layer2a.pos >= backgroundController.img:getHeight()) then
    layer2a.pos = layer2b.pos - backgroundController.img:getHeight()
  end
  if(layer2b.pos >= backgroundController.img:getHeight()) then
    layer2b.pos = layer2a.pos - backgroundController.img:getHeight()
  end

    timeElapsed = timeElapsed + dt -- aggiorna il tempo passato dall'ultimo cambio di frame
    if(timeElapsed >= frameDuration) then -- se è ora di cambiare frame...
      frame = frame + 1 -- ... aggiorna l'indice
      if frame > table.getn(cassa.animations) then -- se l'indice va oltre il numero di element dell'animazione...
        frame = 1 -- ... ritorna al primo frame
      end
      timeElapsed = 0 -- azzera il contatore del tempo
    end
  end

function backgroundController.draw()
  love.graphics.setColor(255,255,0,255)
  love.graphics.setFont(font2)
  love.graphics.print("Press \"P\" to PAUSE the game", 512, love.graphics.getHeight()-150)
  love.graphics.print("Press \"ESC\" to EXIT the game", 512, love.graphics.getHeight()-100)
  love.graphics.print("Press \"c\" to view collisions", 512, love.graphics.getHeight()-200)
  love.graphics.setColor(255,255,255,255)
  love.graphics.draw(backgroundController.img3, 512,0)
  love.graphics.draw(backgroundController.img, layer1a.quad, 0, layer1a.pos)
  love.graphics.draw(backgroundController.img, layer1b.quad, 0, layer1b.pos)
  love.graphics.setColor(255, 255, 255, 100)
  love.graphics.draw(backgroundController.img2, layer2a.quad, 0, layer2a.pos)
  love.graphics.draw(backgroundController.img2, layer2b.quad, 0, layer2b.pos)
  love.graphics.setColor(255, 255, 255, 255)
  image = love.graphics.newImage(cassa.animations[frame]) -- carica l'immagine corretta dalla mappa
  love.graphics.draw(image, 512, 267) -- disegna l'immagine a schermo
end

return backgroundController
