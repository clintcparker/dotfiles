--- === LitraGlow ===
---
--- LitraGlow Toggle and status indicator 
---
--- This module provides a number of functions for working with Logitech Litra Glow
local obj={}
obj.__index = obj

-- Metadata
obj.name = "LitraGlow"
obj.version = "1.0"
obj.author = "clintcparker <clintcparker@gmail.com>"
obj.homepage = "https://clintparker.com"
obj.license = "MIT - https://opensource.org/licenses/MIT"
obj.logger = hs.logger.new(obj.name, "info")
obj.loopcalls = 10
obj.menu_title = "💡"
obj.usb_productName = "Litra Glow"




--- LitraGlow:turnOn()
--- Method
--- Turn on the LitraGlow
---
--- Parameters:
---  * None
function obj:turnOn()
    obj:callLitra("on")
end

--- LitraGlow:turnOff()
--- Method
--- Turn off the LitraGlow
---
--- Parameters:
---  * None
function obj:turnOff()
    obj:callLitra("off")
end


--- LitraGlow:callLitra()
--- Method
--- Call the LitraGlow with arbitrary arguments
---
--- Parameters:
---  * arguments1 - string of arguments to pass to litra-glow
--- 
--- Returns:
---  * None
--- 
--- Notes:
---  * https://github.com/ucomesdag/litra-glow
function obj:callLitra(arguments)
    obj.logger.i(arguments)
    for i = 1, obj.loopcalls do
        hs.execute("~/.bin/litra-glow " .. arguments);
    end
end

--- LitraGlow:showMenu()
--- Method
--- Show the menu
---
--- Parameters:
---  * None
function obj:showMenu()
    obj.logger.i("showMenu")
    obj.menu:returnToMenuBar():setTitle(obj.menu_title)
end

--- LitraGlow:hideMenu()
--- Method
--- Hide the menu
---
--- Parameters:
---  * None
function obj:hideMenu()
    obj.menu:removeFromMenuBar()
end

--- LitraGlow:init()
--- Method
--- Initialize the module
---
--- Parameters:
---  * None
function obj:init()
    obj.menu = hs.menubar.new()
    -- obj.menu:setTitle(obj.menu_title)
    obj.menu:setTooltip("Litra-Glow")
    obj.menu:setMenu({
        {title = "On", fn = function()
            obj:callLitra("on")
        end},
        {title = "Off", fn = function()
            obj:callLitra("off")
        end},
        {title = "Brightness", menu = {
            {title = "Glow", fn = function()
                obj:callLitra("on glow")
            end},
            {title = "Dim", fn = function()
                obj:callLitra("on dim")
            end},
            {title = "Normal", fn = function()
                obj:callLitra("on normal")
            end},
            {title = "Medium", fn = function()
                obj:callLitra("on medium")
            end},
            {title = "Bright", fn = function()
                obj:callLitra("on bright")
            end},
            {title = "Brightest", fn = function()
                obj:callLitra("on brightest")
            end},
        }},
        {title = "Temperature", menu = {
            {title = "Warmest", fn = function()
                obj:callLitra("on warmest")
            end},
            {title = "Warm", fn = function()
                obj:callLitra("on warm")
            end},
            {title = "Mild", fn = function()
                obj:callLitra("on mild")
            end},
            {title = "Neutral", fn = function()
                obj:callLitra("on neutral")
            end},
            {title = "Cool", fn = function()
                obj:callLitra("on cool")
            end},
            {title = "Cold", fn = function()
                obj:callLitra("on cold")
            end},
            {title = "Coldest", fn = function()
                obj:callLitra("on coldest")
            end},
        }}
    })
    

    hs.urlevent.bind("lights", function(eventName, params)
        -- print(eventName)
        -- print(params["action"])
        if params["action"] == "on" then
            obj:turnOn()
        end
        if params["action"] == "off" then
            obj:turnOff()
        end
    end)
    obj:hideMenu();
    for key,val in pairs(hs.usb.attachedDevices()) do 
        if val.productName == obj.usb_productName then
            obj:showMenu()
        end
    end
end


return obj


-- hs.usb.attachedDevices()