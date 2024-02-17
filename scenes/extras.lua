local sceneBase = {
    active = false
}

local exitButton = {253, 4, 313, 3, 310, 55, 257, 59}
local musicButton = {110, 47, 209, 47, 213, 102, 112, 105}
local infiniteTimeButton = {110, 47, 209, 47, 213, 102, 112, 105} --ussed be to 112, 147, 212, 146, 213, 203, 111, 202

local touchCallback = nil

function sceneBase:setTouchCallback(callback)
    touchCallback = callback
end

local musicToggle, checkerboardPattern

function sceneBase:load()
    --love.graphics.setDefaultFilter("nearest", "nearest", 1)

    musicToggle = {}
    musicToggle.enabled = true
    musicToggle.image = toggle
    musicToggle.text = "(ON)"

    infiniteTimeToggle = {}
    infiniteTimeToggle.enabled = false
    infiniteTimeToggle.image = toggle
    infiniteTimeToggle.text = "(OFF)"

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
    love.graphics.printf("Extras!!", 110, 15, 100, "center", 0, 2, 2)
    

    love.graphics.print("by Eran", 170 - 90, 210)
    love.graphics.print("by Mple", 170 + 100, 210)

    love.graphics.setColor(1,1,1)

    love.graphics.push()
    love.graphics.scale(0.7, 0.7)
    love.graphics.draw(fanart1, 37, 55)
    love.graphics.pop()

    love.graphics.push()
    love.graphics.scale(0.35, 0.35)
    love.graphics.draw(fanart2, 675, 175)
    love.graphics.pop()
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

    love.graphics.print("Infinite Time? (Deluxe) ".. infiniteTimeToggle.text , 35, 120) --y used to be 120
    --love.graphics.print("Music? ".. musicToggle.text, 108, 20)

    love.graphics.push()
    love.graphics.scale(0.25, 0.25)
    --love.graphics.draw(musicToggle.image, 450, 100)
    love.graphics.draw(infiniteTimeToggle.image, 450, 100, 0) -- y used to be 500
    love.graphics.pop()

    --simpleButtons:debug({exitButton, musicButton, infiniteTimeButton})
end

function sceneBase:update(dt)
    checkerboardPattern.x = checkerboardPattern.x - (dt * 2)
    checkerboardPattern.y = checkerboardPattern.y - (dt * 2)

    if simpleButtons:pressedButtonHitbox(exitButton) then 
        switchScene("mainMenu")
    end

    --if simpleButtons:pressedButtonHitbox(musicButton) then 
    if false then 
        if musicToggle.enabled == true then 
            musicToggle.enabled = false
            musicEnabled = false
            musicToggle.text = "(OFF)"
            --mainMusic:setVolume(0)
            mainMusic:stop()
        else 
            musicToggle.enabled = true
            musicEnabled = true 
            musicToggle.text = "(ON)"
            --mainMusic:setVolume(1)
            mainMusic:play()
        end
    end

    if simpleButtons:pressedButtonHitbox(infiniteTimeButton) then 
        if infiniteTimeToggle.enabled == true then 
            infiniteTimeToggle.enabled = false
            infiniteTimeToggle.text = "(OFF)"
            infiniteTime = false 
        else 
            infiniteTimeToggle.enabled = true
            infiniteTimeToggle.text = "(ON)"
            infiniteTime = true 
        end
    end

    if musicToggle.enabled == true then 
        musicToggle.image = toggleOn
    else 
        musicToggle.image = toggle
    end

    if infiniteTimeToggle.enabled == true then 
        infiniteTimeToggle.image = toggleOn
    else 
        infiniteTimeToggle.image = toggle
    end
end

function switchScene(what)
    if touchCallback then
        touchCallback(what)  -- You can pass any relevant data here
    end
end

return sceneBase