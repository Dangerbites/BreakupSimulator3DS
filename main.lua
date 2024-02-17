require("lib/dslayout")
simpleButtons = require "lib/simpleButtons"
flux = require "lib/flux"

-- scene loading -------------------------------
scenes = {
    mainMenu = require("scenes/mainMenu"),
    shitgame = require("scenes/shitgame"),
    extras = require("scenes/extras"),
    credits = require("scenes/credits")
}
-----------------------------------------

local debug = false

-- global --
loadingScreen = false 
infiniteTime = false
musicEnabled = true 

function love.load()
    -- audio --
    mainMusic = love.audio.newSource("audio/SKBS-remix.wav", "stream")
    mainMusic:play()

    -- font --
    font = love.graphics.newFont("fonts/Pixellari.ttf", 20)

    -- shitgame --
    cg_talk = love.audio.newSource("audio/catgrill_talk.wav", "static")
    guy_talk = love.audio.newSource("audio/main_character_voice.wav", "static")

    bg = love.graphics.newImage("sprites/fancy resturant.png")
    kitchen = love.graphics.newImage("sprites/kitchen.png")

    textBox = love.graphics.newImage("sprites/textBoxDs.png")
    Button = love.graphics.newImage("sprites/optionbutton.png")

    catgrill_happy = love.graphics.newImage("sprites/cg_happy.png")
    catgrill_angry = love.graphics.newImage("sprites/cg_angry.png")
    catgrill_confused = love.graphics.newImage("sprites/confused.png")
    catgrill_shocked = love.graphics.newImage("sprites/shocked.png")
    catgrill_sad = love.graphics.newImage("sprites/sad.png")
    catgrill_eye = love.graphics.newImage("sprites/eye.png")
    catgrill_laughing = love.graphics.newImage("sprites/laughing.png")
    catgrill_WTF = love.graphics.newImage("sprites/WTF.png")

    eran = love.graphics.newImage("sprites/neutral.png")
    dangerbites = love.graphics.newImage("sprites/dangerbites.png")
    haynster = love.graphics.newImage("sprites/haynster.png")

    -- extras --
    X = love.graphics.newImage("sprites/X.png")
    toggle = love.graphics.newImage("sprites/toggle.png")
    toggleOn = love.graphics.newImage("sprites/toggleOn.png")

    fanart1 = love.graphics.newImage("sprites/ERAN.png")
    fanart2 = love.graphics.newImage("sprites/ERANSFRIEND.png")

    -- main menu --
    checkers = love.graphics.newImage("sprites/checker.png")
    coverArt = love.graphics.newImage("sprites/coverart.png")
    logo = love.graphics.newImage("sprites/logo.png")

    play = love.graphics.newImage("sprites/play.png")
    credits = love.graphics.newImage("sprites/credits.png")
    extras = love.graphics.newImage("sprites/extras.png")

    -- credits -- 
    nibbleLogo = love.graphics.newImage("sprites/NEWLOGO.png")

    for key, val in pairs(scenes) do 
        if val.active then
            val:load()
        end
        --val:load()
    end

    dslayout:init({
        color = { r = 0.2, g = 0.2, b = 0.25, a = 1 },
        title = "BreakupSim 3DS"
    })
    local touchx = -10
    local touchy = -10

    simpleButtons:setTouchCallback(eventFromScene)

    for key, val in pairs(scenes) do 
        val:setTouchCallback(eventFromScene)
    end

    -- dialogue System -----------------------------------
    dialogue = {
        {"Thanks for inviting me to this fancy restaurant!!", 25, catgrill_happy, "Youre Welcome", "Youre not welcome", {
            {"no way bbg!1!1!! hmmmmm, what do you wanna order??!1", 25, catgrill_happy, "Streak", "Cat Meat", {
                {"OMG!1!1!??! That sound so yummer!!!! I think ill order the oily greasy thick chickenm!!!", 40, catgrill_happy, "NEXT", "thats not on the menu", {
                    {"ayo welcum to nice nibbles foodhouse, watchu gays wanna order", 25, eran, "NEXT", "", {
                        {"oh yes!!!! i would like to order a big oily greasy thickass chicken and streak!!!!!!!! :3c", 30, catgrill_happy, "NEXT", "", {
                            {"kinda gay, but ok. Wait while we cook some shit.", 25, eran, "NEXT", "", {
                                {"Yoyo cant wait!!!11!", 30, catgrill_happy, "NEXT", "", {
                                    {"While we wait wanna play a short game~?", 30, catgrill_happy, "Sure :)", "", {
                                        {"Wait shit nvm our server cumming back bruh, And it looks like he doesnt have our food....", 30, catgrill_angry, "Ok", "", {
                                            {"ayo uhh your gays food look so yummer so i ate it. anyway that would be 6969 dollars", 25, eran, "NEXT", "", {
                                                {"ayo what the fuck?!1?! grrr let me talk to the owner", 30, catgrill_shocked, "NEXT", "", {
                                                    {"oh shit uh oh uhhh ok", 25, eran, "NEXT", "", {
                                                        {"Yo hamster!!11 We got a karen!!!!", 25, eran, "NEXT", "", {
                                                            {"Yo wtf!!11", 25, haynster, "NEXT", "", {
                                                                {"tell her to shut the fuck up cuz i'm cooking banger like heart stopper mini short epiode smh smh", 25, haynster, "NEXT", "", {
                                                                    {"B-BUT SHE WILL RATE US 1 STAR!1!1", 25, eran, "NEXT", "", {
                                                                        {"NAHH WTF?? NICE NIBBLES NEVER GET 1 STAR!1!1! FINE I WILL TALK TO HER SMH SMH", 25, haynster, "NEXT", "", {
                                                                            {"What happened here smh smh", 25, haynster, "NEXT", "", {
                                                                                {"the waiter here ate our food that we order!1!1!", 30, catgrill_angry, "NEXT", "", {
                                                                                    {"nahh wtf!! what you have to say cergay!!?", 25, haynster, "NEXT", "", {
                                                                                        {"it was yummer and banger what can i say", 25, eran, "NEXT", "", {
                                                                                            {"nah nah frfr glad that i ate that food with you", 25, haynster, "NEXT", "", {
                                                                                                {"what the fuck???", 30, catgrill_angry, "NEXT", "", {
                                                                                                    {"ayo it's the ceo of nice nibbles meaning that i got the nicest nibbles!!1", 30, dangerbites, "NEXT", "", {
                                                                                                        {"ayo what the fuck happened here", 30, dangerbites, "NEXT", "", {
                                                                                                            {"thanks god you're here!!! you see... the owner and the waiter ate our food!!!", 30, catgrill_happy, "NEXT", "", {
                                                                                                                {"ayo what can they say i ate the food too it was yummer", 30, dangerbites, "NEXT", "", {
                                                                                                                    {"HUH WHAT THE FUCK IS WRONG WITH THIS PLACE YOU KNOW WHAT FUCK YO U GUYS I'M LEAVING *leave the place cutely", 50, catgrill_shocked, "NEXT", "", {
                                                                                                                        {"ayyy she left the place!!!", 30, dangerbites, "NEXT", "", {
                                                                                                                            {"we didn't ate the food and we lie about eating them so that she got mad and leave you with more food", 30, dangerbites, "NEXT", "", {
                                                                                                                                {"so the food is yours for free player frfr!!", 30, dangerbites, "NEXT", "", {
                                                                                                                                    {"*WIN"},
                                                                                                                                }},
                                                                                                                                {}
                                                                                                                            }},
                                                                                                                            {}
                                                                                                                        }},
                                                                                                                        {}
                                                                                                                    }},
                                                                                                                    {}
                                                                                                                }},
                                                                                                                {}
                                                                                                            }},
                                                                                                            {}
                                                                                                        }},
                                                                                                        {}
                                                                                                    }},
                                                                                                    {}
                                                                                                }},
                                                                                                {}
                                                                                            }},
                                                                                            {}
                                                                                        }},
                                                                                        {}
                                                                                    }},
                                                                                    {}
                                                                                }},
                                                                                {}
                                                                            }, "main"},
                                                                            {}
                                                                        }},
                                                                        {}
                                                                    }},
                                                                    {}
                                                                }},
                                                                {}
                                                            }},
                                                            {}
                                                        }, "kitchen"},
                                                        {}
                                                    }},
                                                    {}
                                                }},
                                                {}
                                            }},
                                            {}
                                        }},
                                        {"*WIN"}
                                    }},
                                    {}
                                }},
                                {}
                            }},
                            {}
                        }},
                        {}
                    }},
                    {"YES IT IS BITCH", 99, catgrill_shocked, "", "NO IT ISNT", {
                        {},
                        {"YES IT IS GRAHH I CANT FUCKING DEAL WITH YOUR SHIT ANYMORE IM GOING TO FUCKING BITE YOUR THROAGTH OFF AND DUMP YOUR BODY IN A RIVER", 65, catgrill_WTF, "...", "", {
                            {"*LOSE"},
                        }}
                    }}
                }},
                {"WHAT THE FUCK", 40, catgrill_shocked, "NEXT", "", {
                    {"*WIN"}
                }}
            }},
            {"what?", 25, catgrill_confused, "Youre stinky", "FUCK YOU", {
                {"Thanks!! I pride myself on my stinkiness.", 25, catgrill_happy, "NEXT", "", {
                    {"I think the weather is good this week!! We should go on a picnic or something kawaii like that!!!", 25, catgrill_happy, "Okay", "no", {
                        {"OMG!!!! its gonna be so sugoi", 15, catgrill_happy, "NEXT", "", {
                            {"well, ive always dreamt of going to japan; it will be like my favorite anime..", 35, catgrill_happy, "NEXT", "", {
                                {"Watchu guys wanna order", 15, eran, "Steak", "Cat Meat", {
                                    {"mmm YUMMERS!!!! I think ill order the oily greased up chicken!", 25, catgrill_happy, "NEXT", "", {
                                        {"OMG bbg im recieveing visions from my third eye", 25, catgrill_eye, "what do they say", "", {
                                            {"they say... that you need to guess a number", 25, catgrill_eye, "4", "8", {
                                                {"they say... that you got it Right!!!!", 25, catgrill_eye, "NEXT", "", {
                                                    {"mannn IM SO HUNGRY", 25, catgrill_shocked, "4", "8", {
                                                        {"GRAHH STOP SAYING NUMBERS", 25, catgrill_angry, "NEXT", "", {
                                                            {"Im sorry for letting out my not so kawaii side.. im just really hungry, and if i dont get my oily greased up chicken with barbeque sauce right now im gonna shoot someowne", 25, catgrill_sad, "NEXT", "", {
                                                                {"Yo guys i was gonna bring the food but it just looked so yummer so i ate it!!! so youll need to order something else", 60, eran, "NEXT", "", {
                                                                    {"Ill have the waffles with bacon.... extra bacon!", 60, catgrill_happy, "Can i get one fucking word in", "", {
                                                                        {"*WIN"},
                                                                    }},
                                                                }},
                                                            }},
                                                        }},
                                                        {"GRAHH STOP SAYING NUMBERS", 40, catgrill_angry, "NEXT", "", {
                                                            {"Im sorry for letting out my not so kawaii side.. im just really hungry, and if i dont get my oily greased up chicken with barbeque sauce right now im gonna shoot someowne", 25, catgrill_sad, "NEXT", "", {
                                                                {"Yo guys i was gonna bring the food but it just looked so yummer so i ate it!!! so youll need to order something else", 60, eran, "NEXT", "", {
                                                                    {"Ill have the waffles with bacon.... extra bacon!", 60, catgrill_happy, "Can i get one fucking word in", "", {
                                                                        {"*WIN"},
                                                                    }},
                                                                }},
                                                            }},
                                                        }}
                                                    }},
                                                }},
                                                {"they say... that you got it WRONG. BITCH", 25, catgrill_eye, "NEXT", "", {
                                                    {"mannn IM SO HUNGRY", 25, catgrill_shocked, "4", "8", {
                                                        {"GRAHH STOP SAYING NUMBERS", 25, catgrill_angry, "NEXT", "", {
                                                            {"Im sorry for letting out my not so kawaii side.. im just really hungry, and if i dont get my oily greased up chicken with barbeque sauce right now im gonna shoot someowne", 25, catgrill_sad, "NEXT", "", {
                                                                {"Yo guys i was gonna bring the food but it just looked so yummer so i ate it!!! so youll need to order something else", 60, eran, "NEXT", "", {
                                                                    {"Ill have the waffles with bacon.... extra bacon!", 60, catgrill_happy, "Can i get one fucking word in", "", {
                                                                        {"*WIN"},
                                                                    }},
                                                                }},
                                                            }},
                                                        }},
                                                        {"GRAHH STOP SAYING NUMBERS", 40, catgrill_angry, "NEXT", "", {
                                                            {"Im sorry for letting out my not so kawaii side.. im just really hungry, and if i dont get my oily greased up chicken with barbeque sauce right now im gonna shoot someowne", 25, catgrill_sad, "NEXT", "", {
                                                                {"Yo guys i was gonna bring the food but it just looked so yummer so i ate it!!! so youll need to order something else", 60, eran, "NEXT", "", {
                                                                    {"Ill have the waffles with bacon.... extra bacon!", 60, catgrill_happy, "Can i get one fucking word in", "", {
                                                                        {},
                                                                    }},
                                                                }},
                                                            }},
                                                        }}
                                                    }},
                                                }}
                                            }},
                                        }},
                                    }},
                                    {"WHAT THE FUCK", 40, catgrill_shocked, "NEXT", "", {
                                        {"*WIN"},
                                    }}
                                }},
                            }},
                        }},
                        {"oh, okay.......", 15, catgrill_sad, "NEXT", "", {
                            {"well, ive always dreamt of going to japan; it will be like my favorite anime..", 35, catgrill_happy, "NEXT", "", {
                                {"Watchu guys wanna order", 15, eran, "Steak", "Cat Meat", {
                                    {"mmm YUMMERS!!!! I think ill order the oily greased up chicken!", 25, catgrill_happy, "NEXT", "", {
                                        {"OMG bbg im recieveing visions from my third eye", 25, catgrill_eye, "what do they say", "", {
                                            {"they say... that you need to guess a number", 25, catgrill_eye, "4", "8", {
                                                {"they say... that you got it Right!!!!", 25, catgrill_eye, "NEXT", "", {
                                                    {"mannn IM SO HUNGRY", 25, catgrill_shocked, "4", "8", {
                                                        {"GRAHH STOP SAYING NUMBERS", 25, catgrill_angry, "NEXT", "", {
                                                            {"Im sorry for letting out my not so kawaii side.. im just really hungry, and if i dont get my oily greased up chicken with barbeque sauce right now im gonna shoot someowne", 25, catgrill_sad, "NEXT", "", {
                                                                {"Yo guys i was gonna bring the food but it just looked so yummer so i ate it!!! so youll need to order something else", 60, eran, "NEXT", "", {
                                                                    {"Ill have the waffles with bacon.... extra bacon!", 60, catgrill_happy, "Can i get one fucking word in", "", {
                                                                        {"*WIN"},
                                                                    }},
                                                                }},
                                                            }},
                                                        }},
                                                        {"GRAHH STOP SAYING NUMBERS", 40, catgrill_angry, "NEXT", "", {
                                                            {"Im sorry for letting out my not so kawaii side.. im just really hungry, and if i dont get my oily greased up chicken with barbeque sauce right now im gonna shoot someowne", 25, catgrill_sad, "NEXT", "", {
                                                                {"Yo guys i was gonna bring the food but it just looked so yummer so i ate it!!! so youll need to order something else", 60, eran, "NEXT", "", {
                                                                    {"Ill have the waffles with bacon.... extra bacon!", 60, catgrill_happy, "Can i get one fucking word in", "", {
                                                                        {"*WIN"},
                                                                    }},
                                                                }},
                                                            }},
                                                        }}
                                                    }},
                                                }},
                                                {"they say... that you got it WRONG. BITCH", 25, catgrill_eye, "NEXT", "", {
                                                    {"mannn IM SO HUNGRY", 25, catgrill_shocked, "4", "8", {
                                                        {"GRAHH STOP SAYING NUMBERS", 25, catgrill_angry, "NEXT", "", {
                                                            {"Im sorry for letting out my not so kawaii side.. im just really hungry, and if i dont get my oily greased up chicken with barbeque sauce right now im gonna shoot someowne", 25, catgrill_sad, "NEXT", "", {
                                                                {"Yo guys i was gonna bring the food but it just looked so yummer so i ate it!!! so youll need to order something else", 60, eran, "NEXT", "", {
                                                                    {"Ill have the waffles with bacon.... extra bacon!", 60, catgrill_happy, "Can i get one fucking word in", "", {
                                                                        {"*WIN"},
                                                                    }},
                                                                }},
                                                            }},
                                                        }},
                                                        {"GRAHH STOP SAYING NUMBERS", 40, catgrill_angry, "NEXT", "", {
                                                            {"Im sorry for letting out my not so kawaii side.. im just really hungry, and if i dont get my oily greased up chicken with barbeque sauce right now im gonna shoot someowne", 25, catgrill_sad, "NEXT", "", {
                                                                {"Yo guys i was gonna bring the food but it just looked so yummer so i ate it!!! so youll need to order something else", 60, eran, "NEXT", "", {
                                                                    {"Ill have the waffles with bacon.... extra bacon!", 60, catgrill_happy, "Can i get one fucking word in", "", {
                                                                        {"*WIN"},
                                                                    }},
                                                                }},
                                                            }},
                                                        }}
                                                    }},
                                                }}
                                            }},
                                        }},
                                    }},
                                    {"WHAT THE FUCK", 40, catgrill_shocked, "NEXT", "", {
                                        {"*WIN"},
                                    }}
                                }},
                            }},
                        }}
                    }},
                }},
                {"OH YEAH? WHILE FUCK YOU TOO!!!!", 20, catgrill_shocked, "NEXT", "", {
                    {"*WIN"},
                }}
            }}
        }}
    }
    --dialogueStep = dialogue[1]
    ------------------------------------------------------
end

function love.draw(screen)

    dslayout:draw(screen, function()
        if debug then 
            love.graphics.setColor(255/255,150/255,156/255)
            love.graphics.print("Top Screen")
            love.graphics.setColor(1,1,1)
        end

        for key, val in pairs(scenes) do 
            if val.active then
                val:drawTop()
            end
        end

    end,function()

        for key, val in pairs(scenes) do 
            if val.active then
                val:drawBottom()
            end
        end

        if (touchx > 0 and touchy > 0) and debug then
            love.graphics.setColor(255/255,150/255,156/255)
            love.graphics.print("Bottom Screen")
            love.graphics.print("X: "..touchx,0,20)
            love.graphics.print("Y: "..touchy,0,40)
            love.graphics.setColor(1, 0, 0)
            love.graphics.circle("fill", touchx, touchy, 5)
            love.graphics.setColor(1, 1, 1)
        end
    end)
end

local timer = 0

function love.update(dt)
    timer = timer + dt 

    if timer > 0.25 then 
        timer = 0
        touchx = -10
        touchy = -10
    end
    
    for key, val in pairs(scenes) do 
        if val.active then
            val:update(dt)
        end
    end

	if not mainMusic:isPlaying() and musicEnabled then
		love.audio.play(mainMusic)
	end

end

function eventFromScene(what) -- SWITCH SCENES --
    --print("Switching scenes to ".. what)

    for key, val in pairs(scenes) do 
        val.active = false
    end

    scenes[what]:load()
    scenes[what].active = true
end

function love.gamepadpressed(joystick, button)
    love.event.quit()
end

function love.touchmoved(id,x,y,dx,dy,pressure)
    touchx = x;
    touchy = y;

    --simpleButtons:setTouchTable(touchx, touchy)
end

function love.mousemoved(x,y,dx,dy,istouch)
    dslayout:mousemoved(x,y,dx,dy,istouch)
end

function love.mousepressed(x, y, button, istouch, presses)
    dslayout:mousepressed(x, y, button, istouch, presses)
end

function love.mousereleased(x, y, button, istouch, presses)
    dslayout:mousereleased(x, y, button, istouch, presses)
    --simpleButtons:releasedLol()
end

function love.keypressed(key) 
    simpleButtons:keypressed(key) 
end