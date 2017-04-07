button = {}
button2 = {}

function button_spawn(text,x,y,id)
  table.insert(button, {text = text,x = x, y = y, id = id})
end

function button_spawnPaused(text,x,y,id)
  table.insert(button2, {text = text,x = x, y = y, id = id})
end

function button_draw()
  for i,v in ipairs(button) do
    love.graphics.setColor(30, 90, 160, 250)
    love.graphics.setFont(sottotitolo)
    love.graphics.print(v.text,v.x,v.y)
  end
end

function button_paused()
  for i,v in ipairs(button2) do
    love.graphics.setColor(090, 160, 30, 250)
    love.graphics.setFont(titoloMedio)
    love.graphics.printf(v.text, 0, love.graphics.getHeight() / 2, love.graphics.getWidth(), "center")
  end
end
