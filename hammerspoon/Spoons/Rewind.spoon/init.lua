--- === Rewind ===
---
--- Rewind Audio Toggle
---
--- This module provides a number of functions for working with Rewind
local obj={}
obj.__index = obj

-- Metadata
obj.name = "Rewind"
obj.version = "1.0"
obj.author = "clintcparker <clintcparker@gmail.com>"
obj.homepage = "https://clintparker.com"
obj.license = "MIT - https://opensource.org/licenses/MIT"
obj.logger = hs.logger.new(obj.name, "info")
obj.home = os.getenv("HOME")




--- Rewind:turnOn()
--- Method
--- Turn on the mic
---
--- Parameters:
---  * None
function obj:turnOn()
    obj.logger.i("on")
    hs.task.new(obj.home .. "/.bin/resumeRewindAudio", function(exitCode, _, _)
        if exitCode ~= 0 then obj.logger.w("resumeRewindAudio failed (exit " .. exitCode .. ")") end
    end):start()
end

--- Rewind:turnOff()
--- Method
--- Turn off the mic
---
--- Parameters:
---  * None
function obj:turnOff()
    obj.logger.i("off")
    hs.task.new(obj.home .. "/.bin/pauseRewindAudio", function(exitCode, _, _)
        if exitCode ~= 0 then obj.logger.w("pauseRewindAudio failed (exit " .. exitCode .. ")") end
    end):start()
end

--- Rewind:init()
--- Method
--- Initialize the module
---
--- Parameters:
---  * None
function obj:init()
    hs.urlevent.bind("rewind", function(_, params)
        if params["action"] == "on" then
            obj:turnOn()
        end
        if params["action"] == "off" then
            obj:turnOff()
        end
    end)
end


return obj