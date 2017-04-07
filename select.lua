local select = {}


select.x = 0
select.y = 0
select.img = nil
select.img2 = nil
select.width = 0
select.height = 0

-- percorso immagini button
local sprite = {"assets/img/players/S1_ShipBlue.png","assets/img/players/S1_ShipGreen.png","assets/img/players/S1_ShipOrange.png","assets/img/players/S1_ShipRed.png","assets/img/players/S2_ShipBlue.png","assets/img/players/S2_ShipGreen.png","assets/img/players/S2_ShipOrange.png","assets/img/players/S2_ShipRed.png","assets/img/players/S3_ShipBlue.png","assets/img/players/S3_ShipGreen.png","assets/img/players/S3_ShipOrange.png","assets/img/players/S3_ShipRed.png","assets/img/players/S1_ShipBlue.png","assets/img/players/S1_ShipGreen.png","assets/img/players/S1_ShipOrange.png","assets/img/players/S1_ShipRed.png"}

function select.load() --load
  ship = 0
  -- immagini button
  select.img = {love.graphics.newImage(sprite[1]),love.graphics.newImage(sprite[2]),love.graphics.newImage(sprite[3]),love.graphics.newImage(sprite[4]),love.graphics.newImage(sprite[5]),love.graphics.newImage(sprite[6]),love.graphics.newImage(sprite[7]),love.graphics.newImage(sprite[8]),love.graphics.newImage(sprite[9]),love.graphics.newImage(sprite[10]),love.graphics.newImage(sprite[11]),love.graphics.newImage(sprite[12]),love.graphics.newImage(sprite[13]),love.graphics.newImage(sprite[14]),love.graphics.newImage(sprite[15]),love.graphics.newImage(sprite[16])}

  select.width = select.img[1]:getWidth()
  select.height = select.img[1]:getHeight()
  select.x = 100 --love.graphics.getWidth() / 2
  select.y = 300 --love.graphics.getHeight() - 80
end

function select.update(dt) -- update
  if ship == 0 then
    select.img[1] = select.img[5]
    select.img[2] = select.img[14]
    select.img[3] = select.img[3]
    select.img[4] = select.img[4]
    select.img[5] = select.img[5]
    select.img[6] = select.img[6]
    select.img[7] = select.img[7]
    select.img[8] = select.img[8]
  end
  if ship == 1 then
    select.img[1] = select.img[13]
    select.img[2] = select.img[6]
    select.img[3] = select.img[15]
    select.img[4] = select.img[4]
    select.img[5] = select.img[5]
    select.img[6] = select.img[6]
    select.img[7] = select.img[7]
    select.img[8] = select.img[8]
  end
  if ship == 2 then
    select.img[1] = select.img[1]
    select.img[2] = select.img[14]
    select.img[3] = select.img[7]
    select.img[4] = select.img[16]
    select.img[5] = select.img[5]
    select.img[6] = select.img[6]
    select.img[7] = select.img[7]
    select.img[8] = select.img[8]
  end
  if ship == 3 then
    select.img[1] = select.img[1]
    select.img[2] = select.img[2]
    select.img[3] = select.img[15]
    select.img[4] = select.img[8]
    select.img[5] = select.img[5]
    select.img[6] = select.img[6]
    select.img[7] = select.img[7]
    select.img[8] = select.img[8]
  end
end
  function select.keypressed(key, unicode)
    if (love.keyboard.isDown("left")) then
      ship = ship - 1
      audio1:play()
    end
    if (love.keyboard.isDown("right")) then
      ship = ship + 1
      audio1:play()
    end
    if (ship > 3) then
      ship = 3
      audio1:stop()
    end
    if (ship < 0) then
      ship = 0
      audio1:stop()
    end

    if (love.keyboard.isDown("return"))and ship == 0 then
      changeShip = 0
      audio2:play()
      gameState = "playing"
    end
    if (love.keyboard.isDown("return"))and ship == 1 then
      changeShip = changeShip + 1
      audio2:play()
      gameState = "playing"
    end
    if (love.keyboard.isDown("return"))and ship == 2 then
      changeShip = changeShip + 2
      audio2:play()
      gameState = "playing"
    end
    if (love.keyboard.isDown("return"))and ship == 3 then
      changeShip = changeShip +3
      audio2:play()
      gameState = "playing"
    end
  end

function select.draw() -- draw
  love.graphics.setColor(menuColor_n.r,menuColor_n.g,menuColor_n.b,menuColor_n.a)
  love.graphics.setFont(sottotitolo)
  love.graphics.print(text_10,200,150)
  love.graphics.setColor(255, 255, 255, 255)
  love.graphics.draw(select.img[1], select.x, select.y)
  love.graphics.draw(select.img[2], (select.x + 150), select.y)
  love.graphics.draw(select.img[3], (select.x + 300), select.y)
  love.graphics.draw(select.img[4], (select.x + 450), select.y)

end

return select
