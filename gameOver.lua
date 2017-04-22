local gameOver = {}

function gameOver.draw()
  -- game over
  love.graphics.setFont(titoloMedio)
  love.graphics.setColor(222, 33, 57, 255)
  love.graphics.printf(text_3, 0, 160, love.graphics.getWidth(), "center") --love.graphics.getWidth() : wrap line

  -- insert coin
  love.graphics.setFont(sottotitolo)
  love.graphics.setColor(blinkColor.r, blinkColor.g, blinkColor.b, blinkColor.a)
  love.graphics.printf(text_4, 0, 350, love.graphics.getWidth(), "center")

  --  scelta per continuare a giocare
  if (love.keyboard.isDown("y")) then
    gameState = "playing"
    playerController.status = "play"
  elseif (love.keyboard.isDown("n")) then
    gameState = "quit"
  end
end
return gameOver
