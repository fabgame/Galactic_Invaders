local menuStart = {}

function menuStart.draw()
  --titolo
  love.graphics.setFont(titolo)
  love.graphics.setColor(090, 160, 30, 250)
  love.graphics.printf(text_1, 0, 160, love.graphics.getWidth(), "center")
  -- press start
  love.graphics.setFont(sottotitolo)
  love.graphics.setColor(blinkColor.r, blinkColor.g, blinkColor.b, blinkColor.a)
  love.graphics.printf(text_2, 0, 400, love.graphics.getWidth(), "center")
end

return menuStart
