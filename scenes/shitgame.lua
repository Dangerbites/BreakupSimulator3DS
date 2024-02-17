local sceneBase = {
    active = false
}

local dialogueIndex = 0
local time = 60

local backgroundImage

local touchCallback = nil

function sceneBase:setTouchCallback(callback)
    touchCallback = callback
end

local talkDeltaStuff = {}
talkDeltaStuff.enabled = false
talkDeltaStuff.time = 0
talkDeltaStuff.speed = 0
talkDeltaStuff.currentWordINdex = 0
talkDeltaStuff.text = ""
talkDeltaStuff.swap = 0
talkDeltaStuff.showButtons = false
talkDeltaStuff.buttonInput = false

local screenHitbox = {5, 6, 310, 7, 312, 230, 7, 231}

local button1 = {}
button1.text = ""
button1.hitbox = {54, 29, 270, 28, 272, 112, 52, 112}
button1.hide = false

local button2 = {}
button2.text = ""
button2.hitbox = {56, 129, 268, 129, 267, 225, 55, 214}
button2.hide = false

local win = false 
local lose = false 
local winHitbox = false 

local winscreenTrans = {
    black = 0,
    white = 0
}

function sceneBase:load()
    backgroundImage = bg

    winscreenTrans.black = 0
    winscreenTrans.white = 0

    winHitbox = false 

    win = false 
    lose = false 
    button2.hide = false
    button1.hide = false

    if infiniteTime then 
        time = "Infinite Time Enabled"
    else 
        time = 60
    end

    --love.graphics.setDefaultFilter("nearest", "nearest", 1)

    catgrill = {}
    catgrill.sprite = catgrill_happy
    catgrill.posY = 90

    -- dilogue shit was here ----
    dialogueStep = dialogue[1]

    --talk("Thanks for inviting \n me to this fancy \n restaurant!!", 25, catgrill_happy, "Youre Welcome", "Youre not welcome")
    talk(formatString("Thanks for inviting me to this fancy restaurant!!"), 25, catgrill_happy, "Youre Welcome", "Youre not welcome")
end

function sceneBase:drawTop()
    love.graphics.push()
    love.graphics.scale(1, 1)
    love.graphics.draw(backgroundImage, 0, -85)
    love.graphics.pop()

    love.graphics.push()
    love.graphics.scale(0.5, 0.5)
    love.graphics.draw(catgrill.sprite, -15, catgrill.posY)
    love.graphics.pop()

    love.graphics.push()
    love.graphics.scale(0.4, 0.35)
    love.graphics.draw(textBox, 470, 60)
    love.graphics.pop()

    love.graphics.setColor(146/255,0/255,81/255)

    line_thickness = 1.5

    love.graphics.printf(talkDeltaStuff.text:sub( 1, talkDeltaStuff.currentWordINdex ), 35 + line_thickness, 40, 500, "center")
    love.graphics.printf(talkDeltaStuff.text:sub( 1, talkDeltaStuff.currentWordINdex ), 35 - line_thickness, 40, 500, "center")

    love.graphics.printf(talkDeltaStuff.text:sub( 1, talkDeltaStuff.currentWordINdex ), 35, 40 + line_thickness, 500, "center")
    love.graphics.printf(talkDeltaStuff.text:sub( 1, talkDeltaStuff.currentWordINdex ), 35, 40 - line_thickness, 500, "center")

    love.graphics.setColor(1,1,1)

    love.graphics.setColor(1,1,1)
    love.graphics.printf(talkDeltaStuff.text:sub( 1, talkDeltaStuff.currentWordINdex ), 35, 40, 500, "center")
    love.graphics.setColor(1,1,1)

    line_thickness = 2

    love.graphics.setColor(0,0,0)
    love.graphics.printf(time, 5 + line_thickness, 5, 500, "left", 0, 1, 1)
    love.graphics.printf(time, 5 - line_thickness, 5, 500, "left", 0, 1, 1)
    love.graphics.printf(time, 5, 5 + line_thickness, 500, "left", 0, 1, 1)
    love.graphics.printf(time, 5, 5 - line_thickness, 500, "left", 0, 1, 1)
    love.graphics.setColor(1,1,1)

    love.graphics.setColor(1,1,1)
    love.graphics.printf(time, 5, 5, 500, "left", 0, 1, 1)

    if win or lose then 
        love.graphics.push()
        love.graphics.setColor(0,0,0, winscreenTrans.black)
        love.graphics.rectangle("fill", 0, 0, 500, 500)
        love.graphics.setColor(1,1,1,winscreenTrans.white)
        love.graphics.pop()

        if win then 
            love.graphics.printf("You win!!", 100, 45, 100, "center", 0, 2, 2)
            love.graphics.printf("Tap anywhere on the screen to return", -45, 100, 500, "center")
        else
            love.graphics.printf("You lose!!", 100, 45, 100, "center", 0, 2, 2)
            love.graphics.printf("Tap anywhere on the screen to return", -45, 100, 500, "center")
        end
    end

    love.graphics.setColor(1,1,1, 1)
end

function sceneBase:drawBottom()
    love.graphics.push()
    love.graphics.scale(1, 1)
    love.graphics.draw(backgroundImage, 0, -85)
    love.graphics.pop()

    if talkDeltaStuff.showButtons then

        love.graphics.push()
        love.graphics.scale(0.4, 0.4)
        if not button1.hide then 
            love.graphics.draw(Button, 160, 100 - 165)
        end
        if not button2.hide then 
            love.graphics.draw(Button, 160, 350 - 165)
        end
        love.graphics.pop()

        love.graphics.setColor(146/255,0/255,81/255)
        if not button1.hide then 
            love.graphics.printf(button1.text, -85, 65, 500, "center")
        end  
        if not button2.hide then 
            love.graphics.printf(button2.text, -85, 165, 500, "center")
        end
        love.graphics.setColor(1,1,1)

    end

    --simpleButtons:debug({button1.hitbox, button2.hitbox, screenHitbox})

    if win or lose then 
        love.graphics.push()
        love.graphics.setColor(0,0,0, winscreenTrans.black)
        love.graphics.rectangle("fill", 0, 0, 500, 500)
        love.graphics.setColor(1,1,1,1)
        love.graphics.pop()
    end
end

local secondsPassed = 0

function sceneBase:update(dt)
    flux.update(dt)
    --print(infiniteTime)

    secondsPassed = secondsPassed + dt  

    if secondsPassed >= 1 and infiniteTime == false then 
        if time <= 0 then 
            loseScreen()
            time = 1
        end

        secondsPassed = 0
        time = time - 1
    end

    if talkDeltaStuff.enabled then 
        talkDeltaStuff.time = talkDeltaStuff.time + (dt * talkDeltaStuff.speed)

        if talkDeltaStuff.time > 1 then

            if catgrill.sprite == dangerbites or catgrill.sprite == eran or catgrill.sprite == haynster then 
                guy_talk:play()
            else
                cg_talk:play()
            end

            talkDeltaStuff.swap = talkDeltaStuff.swap + 1 
            talkDeltaStuff.time = 0
            talkDeltaStuff.currentWordINdex = talkDeltaStuff.currentWordINdex + 1
        end

        if talkDeltaStuff.swap >= 2 then 
            talkDeltaStuff.swap = 0
        end

        if talkDeltaStuff.swap == 1 then 
            catgrill.posY = 90
        else
            catgrill.posY = 95
        end

        if talkDeltaStuff.currentWordINdex > #talkDeltaStuff.text then 
            talkDeltaStuff.enabled = false
            talkDeltaStuff.time = 0
            talkDeltaStuff.speed = 0
            talkDeltaStuff.showButtons = true 
            talkDeltaStuff.buttonInput = true 
        end
    end

    if talkDeltaStuff.buttonInput then 
        if simpleButtons:pressedButtonHitbox(button1.hitbox) then 
            if button1.text ~= "" then 
                talkDeltaStuff.buttonInput = false
                updateTalk(1)
            end
        end

        if simpleButtons:pressedButtonHitbox(button2.hitbox) then 
            if button2.text ~= "" then 
                talkDeltaStuff.buttonInput = false
                updateTalk(2)
            end
        end
    end

    if win or lose then 
        if simpleButtons:pressedButtonHitbox(screenHitbox) and winHitbox then 
            loadingScreen = false 
            switchScene("mainMenu")
        end
    end
end

function switchScene(what)
    if touchCallback then
        touchCallback(what)  -- You can pass any relevant data here
    end
end

function sceneBase:unload()
    -- Unload images to free up memory
    self.bg = nil
    self.textBox = nil
    self.Button = nil

    self.catgrill = nil
end

---------- game functions ---------------

function talk(what, speed, sprite, button1text, button2text)
    print(#what)
    catgrill.sprite = sprite
    talkDeltaStuff.enabled = true 
    talkDeltaStuff.speed = speed
    talkDeltaStuff.currentWordINdex = 0
    talkDeltaStuff.text = what
    talkDeltaStuff.buttonInput = false
    talkDeltaStuff.showButtons = false
    talkDeltaStuff.time = 0

    button1.text = button1text
    button2.text = button2text

    talkDeltaStuff.showButtons = false
end

function formatString(inputString)
    local formattedString = ""
    local count = 0

    for i = 1, #inputString do
        formattedString = formattedString .. inputString:sub(i, i)
        count = count + 1

        if count == 15 then
            formattedString = formattedString .. "\n"
            count = 0
        end
    end

    return formattedString
end

function updateTalk(buttonChosen)
    dialogueIndex = dialogueIndex + 1

    --dialogueStep = dialogueStep[6][buttonChosen]
    dialogueStep = dialogueStep[6][buttonChosen]

    if dialogueStep[1] == "*WIN" then 
        winScreen()
        return 
    end

    if dialogueStep[1] == "*LOSE" then 
        loseScreen()
        return 
    end

    if dialogueStep[7] ~= nil then 
        if dialogueStep[7] == "kitchen" then 
            backgroundImage = kitchen
        end

        if dialogueStep[7] == "main" then 
            backgroundImage = bg
        end
    end

    if dialogueStep[4] == "" then 
        button1.hide = true
    else 
        button1.hide = false
    end

    if dialogueStep[5] == "" then 
        button2.hide = true
    else 
        button2.hide = false
    end

    if dialogueStep[5] == "" then 
        talk(formatString(dialogueStep[1]), dialogueStep[2], dialogueStep[3], dialogueStep[4], "")
    else 
        talk(formatString(dialogueStep[1]), dialogueStep[2], dialogueStep[3], dialogueStep[4], dialogueStep[5])
    end

    --talk(formatString(dialogueStep[1]), dialogueStep[2], dialogueStep[3], dialogueStep[4], dialogueStep[5])


    print(dialogueStep[1])
end

function winScreen() 
    win = true 

    flux.to(winscreenTrans, 0.5, { black = 0.7 }):ease("linear"):oncomplete(function()
        winHitbox = true 
    end)

    flux.to(winscreenTrans, 0.5, { white = 1 }):ease("linear"):oncomplete(function()
        winHitbox = true 
    end)
end

function loseScreen()
    lose = true 

    flux.to(winscreenTrans, 0.5, { black = 0.7 }):ease("linear"):oncomplete(function()
        winHitbox = true 
    end)

    flux.to(winscreenTrans, 0.5, { white = 1 }):ease("linear"):oncomplete(function()
        winHitbox = true 
    end)
end

--[[
    local winscreenTrans = {
        black = 0
        white = 0
    }
]]

return sceneBase