local mainMenu = {
    active = true
}

--local flux = require "lib/flux"
--local simpleButtons = require "lib/simpleButtons"

-- buttons ---------------------
local playButton = {16, 48, 134, 37, 132, 109, 25, 113} 
local extrasButton = {79, 131, 233, 126, 235, 202, 77, 200}
local creditsButton = {167, 48, 303, 44, 307, 109, 172, 114}
--------------------------------

local touchCallback = nil
local touchenabled = false 

function mainMenu:setTouchCallback(callback)
    touchCallback = callback
end

local wait = {
    time = 0
}

function mainMenu:load()
    touchenabled = false 
    --love.graphics.setDefaultFilter("nearest", "nearest", 1)

    --sprites

    -- objects --
    catGrillMainMenu = {}
    catGrillMainMenu.y = 200

    -- checkerboardPattern --
    checkerboardPattern = {}
    checkerboardPattern.sprite = love.graphics.newImage("sprites/checker.png")
    checkerboardPattern.x = 0
    checkerboardPattern.y = 0


    -- game start -- 
    flux.to(catGrillMainMenu, 1, { y = 0 }):ease("sineout"):oncomplete(function() 
        touchenabled = true 
    end)
end

function mainMenu:drawTop()
    love.graphics.setFont(font)

    love.graphics.setColor(255/255,150/255,156/255)
    love.graphics.print("V1", 5, 5)
    love.graphics.print("3DS port made by Dangerbites", 125, 5)
    love.graphics.setColor(1,1,1)

    --main menu --
    love.graphics.push()
    love.graphics.scale(0.65, 0.65)
    love.graphics.draw(coverArt, 225, catGrillMainMenu.y)
    love.graphics.pop()

    love.graphics.push()
    love.graphics.scale(0.4, 0.4)
    love.graphics.draw(logo, 25, 75)
    love.graphics.pop()

    love.graphics.setBackgroundColor(255/255,244/255,253/255)

    if loadingScreen then 
        love.graphics.setColor(0,0,0, 0.4)
        love.graphics.rectangle("fill", 0, 0, 500, 500)
        love.graphics.setColor(1,1,1,1)  
        
        love.graphics.printf("Loading...", -50, 100, 500, "center")
    end
end

function mainMenu:drawBottom()

    love.graphics.setColor(1,0.1,0,0.1)
    love.graphics.push()
    love.graphics.scale(5, 5)
    love.graphics.draw(checkerboardPattern.sprite,checkerboardPattern.x,checkerboardPattern.y)
    love.graphics.pop()
    love.graphics.setColor(1,1,1)

    love.graphics.setBackgroundColor(255/255,244/255,253/255)

    love.graphics.push()
    love.graphics.scale(0.5, 0.5)
    yOffset = -50
    love.graphics.draw(play, 25, 75 + yOffset)
    love.graphics.draw(credits, 350, 75 + yOffset)
    love.graphics.draw(extras, 185, 250 + yOffset)
    love.graphics.pop()

    if loadingScreen then 
        love.graphics.setColor(0,0,0, 0.4)
        love.graphics.rectangle("fill", 0, 0, 500, 500)
        love.graphics.setColor(1,1,1,1)        
    end
    --simpleButtons:debug({playButton, extrasButton, creditsButton})
end

function mainMenu:update(dt)
    flux.update(dt)

    checkerboardPattern.x = checkerboardPattern.x - (dt * 2)
    checkerboardPattern.y = checkerboardPattern.y - (dt * 2)

    if not touchenabled then 
        return
    end


    if simpleButtons:pressedButtonHitbox(playButton) then 
        loadingScreen = true 
        touchenabled = false 

        flux.to(wait, 0.25, { time = 1 }):ease("linear"):oncomplete(function() 
            switchScene("shitgame")
        end)
    end

    if simpleButtons:pressedButtonHitbox(extrasButton) then 
        switchScene("extras")
    end

    if simpleButtons:pressedButtonHitbox(creditsButton) then 
        switchScene("credits")
    end

end

function switchScene(what)
    if touchCallback then
        touchCallback(what)  -- You can pass any relevant data here
    end
end

function mainMenu:unload()
    -- Unload images to free up memory
    self.coverArt = nil
    self.logo = nil
    self.play = nil
    self.credits = nil
    self.extras = nil
    self.font = nil
end

return mainMenu