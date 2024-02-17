--[[Library made by Dangerbites. specifically for this game lmao
                                                                                                                                                                                                    
@@                                                   @                                                    
@ :@@                                               @@:@@                                                  
@@ --=:@@                                          @@-=@-= @                                                 
@@  * @:::@@              @@@                     @@.:@@=    @                                                
@   * @%++-.@@           @     @@@@@           @@-..*@:=  :. @                                                
@- : * %@=*=::.@@          @             #@@@@@@@@@@@@ +  ::  @                                                
@  : # @@:+@@@@@@ @@@@@@                            @@:. ::.  @                                                
@ :  *:@@@@*@@                                        @* .   @  @@                                             
@   *+@   %@@@                                         @  +@@@   @                                             
@:  +@                                                 @@@      @                                              
@ =@                                                          @                                               
@@                                                         @@-%@                                             
@                                            *.         @@     :@                                           
@@                                      -*****           @@  ::  @@                                          
@                                                         @   :  @                                          
@                                @@@@@@:                  @@ :. @                                          
 @@                           @@      @                  @@ .:: @                                          
@@  @@                        @                         @@  .=:. @                                          
@@     @@       @@@@:  @@       @@@@@:        -@@@@@#@@@      *:  @                                          
@@  :  @@      #@-         @@@@        @@@@@                   *= =@                                          
@  :: @@@       @ @@@@@@@        @@@@@@@%#@@           @        * @@                                          
@  ::    :@@             @@@@    @@@#%%%#@@-           @        * @@                                          
@@ ::::+:  @       @@@@@@@%#@@     @@@@#@@%           @         *  @@                                         
@  :::*   @       @@@#%%%#@@        @@@@            @@         *.   @                                        
@. ::-*    @       @@@@%#@@@                       @@         +   @                                          
@  :-=    @@         @@@@                        =@            @@                                           
@  :-+     @@                  @@@@             @           +@@@@@@                                         
@ .:*       @               @@@@@@           @@          :*:     @@                                        
@ .:=*       :@             @@   @        %@            *+:   @@@@    .@@                                  
@ .::=*        :@@            @  @     @@@            **-   @@+-  :--:  +@                                 
@: ::::=*          :@@%         *@  @@@@             **:   @*    *%#+===: @                                 
@    ::::=**             @@@@@@@@@#     @@@@             #@@   ::   *#===- @                                 
@@@         :**.       -=  @   :         @  @@* .#@@@@@# @*  ::::::  %=== :@                                 
    @@@@@@ :-+****+    %@@   =@@@      @@ @@.==       @   :::::::  #==. @                                  
  @@@@@*   :::::   @@@=  -@@     .@@@@= @@=  :::::  #@  ::::::::  ##=. @                                   
 @:      ::::::  @@    .   +@@@       @@+  .:  .:  @@  :::::::   ##-  @                                    
   @*    :::::: @@  ::::::.   +@@@@@@@+   :::=#   @   :::::    *%#: =@                                     
     @@.      . @  ::::::::::     ..    :::::  *  @@        *%%#+: #@                                      
        @@@@@   @ ::::::.  .:::::.   .:::::::  +@    @%*+=**#+=:  *@                                       
           @    @ ::::::.+# :::::::::::..::   @@@@@@   +@@@%%%%+@@@                                        
            @@@@@ ::::::. @  .:::      .:   @      @            @@                                         
                @  ::::::  %+     @@@@@: @@@     *@             @@                                         
                @  ::::::: *=+*@@*        @     @ @@            @                                          
                 @  ::::    @@     ::::::  @    @@ -@@@@@@    @@                                           
                 @@       @                 @              @@    
                 
]]

local simpleButtons = {}

local touchCallback = nil

local drawButtonHitboxes = true
local drawButtonHitboxesCount = 1
local debugHitbox = {}

local letGo = true 

function simpleButtons:setTouchCallback(callback)
    touchCallback = callback
end

function tableToString(tbl)
    local result = {}
    for k, v in pairs(tbl) do
        if type(k) == "number" then
            table.insert(result, v)
        else
            table.insert(result, k .. "=" .. v)
        end
    end
    return table.concat(result, ", ")
end

function simpleButtons:keypressed(key)
    if key == "c" then
        debugHitbox[drawButtonHitboxesCount] = touchx
        debugHitbox[drawButtonHitboxesCount + 1] = touchy
    
        drawButtonHitboxesCount = drawButtonHitboxesCount + 2
    
        print(tableToString(debugHitbox))
    end
end

touchx = 0
touchy = 0

function simpleButtons:setTouchTable(touchx, touchy)
    touchx = touchx
    touchy = touchy

    --switchScene("mainMenu")
end

function simpleButtons:debug(buttons)
    love.graphics.setColor(1, 0, 0, 1)
    for i in pairs(buttons) do
        love.graphics.polygon("line", buttons[i])
    end
    love.graphics.setColor(1, 1, 1, 1)
end

function switchScene(what)
    if touchCallback then
        touchCallback(what)  -- You can pass any relevant data here
    end
end

function simpleButtons:pressedButtonHitbox(hitBox)

    point1x = hitBox[1]
    point1y = hitBox[2]

    point2x = hitBox[3]
    point2y = hitBox[4]
    
    point3x = hitBox[5]
    point3y = hitBox[6]

    point4x = hitBox[7]
    point4y = hitBox[8]

    collided = false

    if touchx > point1x and touchx < point2x then
        if touchy < point3y and touchy > point1y then
            if true then 
                collided = true
                touchx = 0
                touchy = 0
            end
        end
    end

    return collided
end

return simpleButtons

--love.graphics.setColor(1, 0, 0)
--love.graphics.rectangle("line", button.x, button.y, button.width, button.height)