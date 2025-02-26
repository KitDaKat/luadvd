-- Start

function love.load()

    NewFont = love.graphics.newFont("Roboto-Regular.ttf", 30)
    love.graphics.setFont(NewFont)

    Hitaudio = love.audio.newSource("Hit.mp3", "static")
    Muted = false

    Paused = false

    love.window.setFullscreen(true)
    love.window.setTitle("Lua DVD Screensaver")

    DVDImage = love.graphics.newImage("DVD.png")

    DVD = {
        ["XPosition"] = 10,
        ["YPosition"] = 10,
        ["radius"] = 50,
        ["ChangeX"] = 480,
        ["ChangeY"] = 480,
    
    }

    function love.keypressed(key, scancode, isrepeat)
        if key == "escape" then 
            if Paused == true then Paused = false love.window.setTitle("Lua DVD Screensaver") else Paused = true love.window.setTitle("Lua DVD Screensaver (Paused)") end
        end

        if key == "w" then 
            if love.window.getFullscreen() == true then love.window.setFullscreen(false) else love.window.setFullscreen(true) end
        end

        if key == "m" then 
            if Muted == true then Muted = false else Muted = true end
        end

    end

    function love.mousepressed(x, y, button, istouch, presses)
        local font = love.graphics:getFont()
        if Paused == true and button == 1 and x >= 10 and x <= 10 + font:getWidth("click to open github page") and y >= 150 and y <= 150 + font:getHeight()/4 then
        love.system.openURL("https://github.com/KitDaKat/luadvd")
        end

    end

end

-- Every frame

function love.update(dt)

if Paused == false then

    DVD["XPosition"] = DVD["XPosition"] + (DVD["ChangeX"] * dt)
    DVD["YPosition"] = DVD["YPosition"] + (DVD["ChangeY"] * dt)

    if DVD["XPosition"] - 85 <= 0 or DVD["XPosition"] + 85 >= love.graphics.getWidth() then

        if DVD["XPosition"] - 85 <= 0 then DVD["XPosition"] = 85 else DVD["XPosition"] = love.graphics.getWidth() - 85 end
        DVD["ChangeX"] = 0 - DVD["ChangeX"]
        if Muted == false then
        love.audio.play(Hitaudio)
        end

    end

    if DVD["YPosition"] - 55 <= 0 or DVD["YPosition"] + 55 >= love.graphics.getHeight() then
            
        if DVD["YPosition"] - 55 <= 0 then DVD["YPosition"] = 55 else DVD["YPosition"] = love.graphics.getHeight() - 55 end
        DVD["ChangeY"] = 0 - DVD["ChangeY"]
        if Muted == false then
        love.audio.play(Hitaudio)
        end

    end

end

end

-- Graphics

function love.draw()

    love.graphics.setFont(NewFont)

    love.graphics.draw(DVDImage, DVD["XPosition"], DVD["YPosition"], 0, 1, 1, 85, 55)

    if Paused == true then 
        local font = love.graphics:getFont()
        love.graphics.print("paused", love.graphics.getWidth()/2, love.graphics.getHeight()/2, 0, 1, 1, font:getWidth("paused")/2, font:getHeight()/2)
        love.graphics.print("w - toggle fullscreen \n escape - pause/unpause \n m - mute audio", 50, 50, 0, 0.5, 0.5, font:getWidth("w - toggle fullscreen \n escape - pause/unpause")/4, font:getHeight()/4)
        love.graphics.print("click to open github page", 50, 150, 0, 0.5, 0.5, font:getWidth("click to open github page")/4, font:getHeight()/4)
    end

end