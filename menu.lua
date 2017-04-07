local menu = {}


function menu.load(arg)
  --  menu start
  titolo = love.graphics.newFont("assets/font/coalition.ttf", 90)
  titoloMedio = love.graphics.newFont("assets/font/coalition.ttf", 60)
  titoloPiccolo = love.graphics.newFont("assets/font/coalition.ttf", 20)
  sottotitolo = love.graphics.newFont("assets/font/coalition.ttf", 30)

  -- effetto blink
  color1 = {
    r = 140, g = 030, b = 220, a = 250
  }
  color2 = {
    r = 0, g = 0, b = 0, a = 0
  }

  -- effetto testo illuminato menu
  color3 = {
    r = 030, g = 090, b = 160, a = 250
  }
  color4 = {
    r = 150, g = 150, b = 240, a = 255
  }

  blinkColor = color1 -- definisce ed inizializza il colore da visualizzare
  menuColor_n = color3 -- colore testo new game
  menuColor_c = color3 -- colore testo credits
  menuColor_q = color3 -- colore testo quit

  timer = 0 -- definisce il timer
  blinkTime = 0.6  -- definisce ogni quanto  "blinkare"
  music = love.audio.newSource("assets/audio/ost/bensound.wav")
  audio1 = love.audio.newSource("assets/audio/fx_audio/select.wav")
  audio2 = love.audio.newSource("assets/audio/fx_audio/start.wav")
  audio3 = love.audio.newSource("assets/audio/fx_audio/escape.wav")
  audio4 = love.audio.newSource("assets/audio/fx_audio/press_start.wav")

  -- testi
  text_1 = "Galatic Invaders"
  text_2 = "Press Start"
  text_3 = "Game Over"
  text_4 = "Insert Coins to Continue?\n\n(Y) or (N)"
  text_5 = "New Game"
  text_6 = "Credits"
  text_7 = "Quit"
  text_8 = "Pietro Taormina"
  text_9 = "Created by"
  text_10 = "Select Your Ship"
  text_11 = "Fabio Varni"
  text_12 = "Project Manager"
  text_13 = "Marco Secchi"
  text_14 = "Francesco Sorbello"
end

function menu.update(dt)
  if selector == 0 then
    menuColor_n = color4
    menuColor_c = color3
    menuColor_q = color3
  end
  if selector == 1 then
    menuColor_c = color4
    menuColor_n = color3
    menuColor_q = color3
  end
  if selector == 2 then
    menuColor_c = color3
    menuColor_n = color3
    menuColor_q = color4
  end
  function love.keypressed(key, unicode)
    if (love.keyboard.isDown("up")) then
      selector = selector - 1
      audio1:play()
    end
    if (love.keyboard.isDown("down")) then
      selector = selector + 1
      audio1:play()
    end
    if (selector > 2) then
      selector = 2
      audio1:stop()
    end
    if (selector < 0) then
      selector = 0
      audio1:stop()
    end

    if (love.keyboard.isDown("return"))and selector == 0 then
      audio2:play()
      gameState = "select"
    end
    if (love.keyboard.isDown("return"))and selector == 1 then
      audio4:play()
      gameState = "credits"
    end
    if (love.keyboard.isDown("return"))and selector == 2 then
      audio4:play()
      gameState = "quit"
    end
  end
end

function menu.draw()
  -- new game
  love.graphics.setColor(menuColor_n.r,menuColor_n.g,menuColor_n.b,menuColor_n.a)
  love.graphics.setFont(sottotitolo)
  love.graphics.print(text_5,530,200)
  -- credits
  love.graphics.setColor(menuColor_c.r,menuColor_c.g,menuColor_c.b,menuColor_c.a)
  love.graphics.setFont(sottotitolo)
  love.graphics.print(text_6,600,250)
  -- testo quit
  love.graphics.setColor(menuColor_q.r,menuColor_q.g,menuColor_q.b,menuColor_q.a)
  love.graphics.setFont(sottotitolo)
  love.graphics.print(text_7,675,300)
end

return menu
