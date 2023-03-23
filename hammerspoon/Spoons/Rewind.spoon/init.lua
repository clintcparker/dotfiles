--- === LitraGlow ===
---
--- LitraGlow Toggle and status indicator 
---
--- This module provides a number of functions for working with Logitech Litra Glow
local obj={}
obj.__index = obj

-- Metadata
obj.name = "Rewind"
obj.version = "1.0"
obj.author = "clintcparker <clintcparker@gmail.com>"
obj.homepage = "https://clintparker.com"
obj.license = "MIT - https://opensource.org/licenses/MIT"
obj.logger = hs.logger.new(obj.name, "info")
obj.loopcalls = 3




--- Rewind:turnOn()
--- Method
--- Turn on the mic
---
--- Parameters:
---  * None
function obj:turnOn()
    obj.logger.i("on")
    for i = 1, obj.loopcalls do
        hs.execute("~/.bin/resumeRewindAudio");
    end
end

--- Rewind:turnOff()
--- Method
--- Turn off the mic
---
--- Parameters:
---  * None
function obj:turnOff()
    obj.logger.i("off")
    for i = 1, obj.loopcalls do
        hs.execute("~/.bin/pauseRewindAudio");
    end
end

--- Rewind:init()
--- Method
--- Initialize the module
---
--- Parameters:
---  * None
function obj:init()
    hs.urlevent.bind("rewind", function(eventName, params)
        -- print(eventName)
        -- print(params["action"])
        if params["action"] == "on" then
            obj:turnOn()
        end
        if params["action"] == "off" then
            obj:turnOff()
        end
    end)
end


return obj


-- hs.usb.attachedDevices()