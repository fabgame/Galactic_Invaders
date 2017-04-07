local HC = require "libs.HC"

isDebug = false
isPaused = false
isPaused_music =false

playerController = require ("playerController")
backgroundController = require ("backgroundController")
meteorsController = require ("meteorsController")
enemiesController = require ("enemiesController")
select = require ("select")
menu = require ("menu")
credits = require ("credits")
menuStart = require ("menuStart")
gameOver = require ("gameOver")

function love.load(arg)
  music = love.audio.newSource("assets/Linkin Park - Points Of Authority.mp3")
  backgroundController.load()
  playerController.load()

  font = love.graphics.newFont("assets/kenvector_future.ttf", 20)

  select.load()
  menu.load()
  --  stato del gioco
  gameState = "start"

  -- cambio ship
  changeShip = 0

  -- menu di selezione
  selector = 0

end

function love.update(dt)
  -- testo blink
  timer = timer + dt -- aggiunge al timer il tempo intercorso tra un frame e l'altro

  if(timer >= blinkTime) then     -- se il timer ha superato il tempo di "blinking"...
    if(blinkColor == color1) then -- ... effettua il cambio di colore
      blinkColor = color2
    else
      blinkColor = color1
    end
    timer = 0 -- azzera il timer
  end
<<<<<<< HEAD
=======

>>>>>>> origin/master
  -- stato del gioco
    if gameState == "playing" then -- start game
      backgroundController.update(dt)
      playerController.update(dt)
      meteorsController.update(dt)
      enemiesController.update(dt)
      musicMenu:stop()
      music:play()

        if meteorsController.GenNumMeteors()==0 and enemiesController.GenNumEnemies() == 0 then
          if love.math.random(10) >5 then
            meteorsController.generateMeteors()
          else
            enemiesController.generateEnemies()
          end
        end
      elseif gameState == "gameOver" then
        music:play()
      elseif gameState == "start" then  -- musica e press start
        musicMenu:play()
<<<<<<< HEAD
      --  function love.keypressed(key, unicode)
          if (love.keyboard.isDown("return"and "space")) then
            audio4:play()
            gameState = "menu"
          end
        --end
=======
--        function love.keypressed(key, unicode)
          if (love.keyboard.isDown("return","space")) then
            audio4:play()
            gameState = "menu"
          end
  --      end
>>>>>>> origin/master
      elseif gameState == "menu" then -- menu
        menu.update(dt)

      elseif gameState == "paused" then
        if isPaused_music then
          music:stop()
        end

        if isPaused then return
        end
        --[[function love.keypressed(key, unicode)
          if (love.keyboard.isDown("return","escape","p")) then
            audio3:play()
          gameState = "playing"
          end
        end]]--
      elseif gameState == "quit" then
        love.event.push('quit')
      elseif gameState == "select" then
        select.update()
      end
end

function love.draw()

  if gameState == "start" then
    menuStart.draw()
  elseif gameState == "gameOver" then
    audio3:stop()
    gameOver.draw()

  elseif gameState == "credits" then
    audio1:stop()
    credits.draw()
    if (love.keyboard.isDown("escape")) then
      audio3:play()
      gameState = "menu"
    end
    -- menu del gioco
  elseif gameState == "menu" then
    menu.draw()

  elseif gameState == "paused" then -- pausa
    button_paused()
  elseif gameState == "select" then -- pausa
    select.draw()
  elseif gameState == "playing" then  -- grafica e funzioni del gioco
    backgroundController.draw()
    playerController.draw()
    meteorsController.draw()
    enemiesController.draw()

    love.graphics.print(string.format("Press 'h' key to enter HC debug mode (currently set to: %s)", isDebug), 10, 10)
 end
end

function love.keypressed(key, scancode, isrepeat)
  -- se è premuto 'escape' chiude il gioco
  if(key == "escape") then
    love.event.push('quit')
  end

  if(key == "space" and playerController.status == "game over") then
    playerController.lives=3
    playerController.status = "play"
  elseif(key == "space") then
    playerController.fireBullet()
  end

  if(key == "c") then
    isDebug = not isDebug
    playerController.isDebug = isDebug
    meteorsController.isDebug = isDebug
  end

  if (key=="p") then
    isPaused=not isPaused
  end

  if (key=="m") then
    isPaused_music=not isPaused_music
  end

  if gameState == "select" then
    select.keypressed(key, scancode)
  end
  if gameState == "menu" then
    menu.keypressed(key, scancode)
  end
end
