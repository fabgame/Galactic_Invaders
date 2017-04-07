local credits = {}

  function credits.draw()
      -- credits
      love.graphics.setFont(sottotitolo)
      love.graphics.setColor(170, 190, 160, 250)
      love.graphics.printf(text_9, 0, 100, love.graphics.getWidth(), "center")

      -- pietro taormina
      love.graphics.setFont(titoloPiccolo)
      love.graphics.setColor(240, 160, 90, 250)
      love.graphics.printf(text_8, 0, 160, love.graphics.getWidth(), "center")

      -- Fabio varni
      love.graphics.setFont(titoloPiccolo)
      love.graphics.setColor(240, 160, 90, 250)
      love.graphics.printf(text_11, 0, 190, love.graphics.getWidth(), "center")

      -- francesco sorbello
      love.graphics.setFont(titoloPiccolo)
      love.graphics.setColor(240, 160, 90, 250)
      love.graphics.printf(text_14, 0, 220, love.graphics.getWidth(), "center")

      -- progect manager
      love.graphics.setFont(sottotitolo)
      love.graphics.setColor(170, 190, 160, 250)
      love.graphics.printf(text_12, 0, 340, love.graphics.getWidth(), "center")

      -- marco secchi
      love.graphics.setFont(titoloPiccolo)
      love.graphics.setColor(240, 160, 90, 250)
      love.graphics.printf(text_13, 0, 400, love.graphics.getWidth(), "center")

  end
return credits
