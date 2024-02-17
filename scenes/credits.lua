local sceneBase = {
    active = false
}

local exitButton = {253, 4, 313, 3, 310, 55, 257, 59}

local touchCallback = nil

function sceneBase:setTouchCallback(callback)
    touchCallback = callback
end

local checkerboardPattern

function sceneBase:load()
    --love.graphics.setDefaultFilter("nearest", "nearest", 1)

    checkerboardPattern = {}
    checkerboardPattern.sprite = checkers
    checkerboardPattern.x = 0
    checkerboardPattern.y = 0
end

function sceneBase:drawTop()
    love.graphics.setColor(1,0.1,0,0.1)
    love.graphics.push()
    love.graphics.scale(5, 5)
    love.graphics.draw(checkerboardPattern.sprite,checkerboardPattern.x,checkerboardPattern.y)
    love.graphics.pop()
    love.graphics.setColor(1,1,1)

    love.graphics.setColor(0,0,0, 0.4)
    love.graphics.rectangle("fill", 0, 0, 500, 500)
    love.graphics.setColor(1,1,1,1)

    --love.graphics.setColor(255/255,150/255,156/255)
    --love.graphics.print("Extras!!", 170, 20)
    love.graphics.printf("Credits!!", 100, 15, 100, "center", 0, 2, 2)
    

    love.graphics.print("Original game made by Haynster", 5, 75)
    love.graphics.print("Art and Music - Dangerbites and Haynster", 5, 100)
    love.graphics.print("3DS Port Code - Dangerbites", 5, 125)
    love.graphics.print("Art that catgrill holds up - Eran", 5, 150)
    love.graphics.print("Fancy Restaurant BG - https://commons.uikimedia.org/wiki/File-Island_Shangri-La,_Hong_Kong_-_Restouront_Petrus.png", 5, 175)
    love.graphics.print("GMTK Game Jam 2023 fr fr", 5, 200)

    love.graphics.setColor(1,1,1)

end

function sceneBase:drawBottom()
    love.graphics.setColor(1,0.1,0,0.1)
    love.graphics.push()
    love.graphics.scale(5, 5)
    love.graphics.draw(checkerboardPattern.sprite,checkerboardPattern.x,checkerboardPattern.y)
    love.graphics.pop()
    love.graphics.setColor(1,1,1)

    love.graphics.push()
    love.graphics.setColor(0,0,0, 0.4)
    love.graphics.rectangle("fill", 0, 0, 500, 500)
    love.graphics.setColor(1,1,1,1)
    love.graphics.pop()

    love.graphics.push()
    love.graphics.scale(0.175, 0.175)
    love.graphics.draw(X, 1500, 30)
    love.graphics.pop()

    --love.graphics.print("Infinite Time? (Deluxe) (OFF)", 35, 120)
    --love.graphics.print("Music? (ON)", 108, 20)

    love.graphics.push()
    love.graphics.scale(1, 1)
    love.graphics.draw(nibbleLogo, 40, -10)
    love.graphics.pop()

    --simpleButtons:debug({exitButton})
end

function sceneBase:update(dt)
    checkerboardPattern.x = checkerboardPattern.x - (dt * 2)
    checkerboardPattern.y = checkerboardPattern.y - (dt * 2)

    if simpleButtons:pressedButtonHitbox(exitButton) then 
        switchScene("mainMenu")
    end
end

function switchScene(what)
    if touchCallback then
        touchCallback(what)  -- You can pass any relevant data here
    end
end

return sceneBase