local sceneBase = {
    active = false
}

local touchCallback = nil

function sceneBase:setTouchCallback(callback)
    touchCallback = callback
end

function sceneBase:load()

end

function sceneBase:drawTop()

end

function sceneBase:drawBottom()

end

function sceneBase:update(dt)

end

function switchScene(what)
    if touchCallback then
        touchCallback(what)  -- You can pass any relevant data here
    end
end

return sceneBase