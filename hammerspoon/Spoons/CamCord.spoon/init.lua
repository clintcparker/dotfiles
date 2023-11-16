--- === CamCord ===
---
--- Camera status indicator 
---
--- This module provides a number of functions for working with cameras
local obj={}
obj.__index = obj

-- Metadata
obj.name = "CamCord"
obj.version = "1.0"
obj.author = "clintcparker <clintcparker@gmail.com>"
obj.homepage = "https://clintparker.com"
obj.license = "MIT - https://opensource.org/licenses/MIT"
obj.logger = hs.logger.new(obj.name, "info")



-- Settings
obj.visualIndicator = true


--- CamCord:camState()
--- Method
--- Get the state of the camera
---
--- Parameters:
---  * cam - camera object
local function camState(cam)
    if cam:isInUse() then
        return "on"
    else
        return "off"
    end
end

local redDot = hs.menubar.new(false)

-- this function shows a red dot on the menubar
local function showRedDot(cam)
    redDot:returnToMenuBar():setTitle("🔴")
    redDot:setTooltip(cam:name());
end

local function hideRedDot()
    redDot:removeFromMenuBar()
end

local function anyCamInUse()
    for i,cam in pairs(hs.camera.allCameras()) do
        if cam:isInUse() then
            return true
        end
    end
    return false
end

--- CamCord:newWatcher()
--- Method
--- Create a new watcher
---
--- Parameters:
---  * cameraOn - callback function for when the camera is turned on
---  * cameraOff - callback function for when the camera is turned off
---
--- Returns:
---  * watcher - a new watcher object
function obj:newWatcher(cameraOn, cameraOff) 
    local watcher = {}
    watcher.__index = watcher
    watcher.cameraOnCallback = cameraOn
    watcher.cameraOffCallback = cameraOff
    local function on_cam_inner(cam, prop, scope, element)
        obj.logger.i(cam:name() .. " " .. camState(cam))
        if(cam:isInUse()) then
            if (obj.visualIndicator) then
                showRedDot(cam)
            end
            watcher.cameraOnCallback()
        else
            -- wait for 1 sencond then turn of the light if no other cameras are in use
            hs.timer.doAfter(1, function()
                if not anyCamInUse() then
                    if (obj.visualIndicator) then
                        hideRedDot()
                    end
                    watcher.cameraOffCallback()
                end
            end)
            
            -- turn off lights
            -- if (obj.visualIndicator) then
            --     hideRedDot()
            -- end
            -- watcher.cameraOffCallback()
        end
    end

    function watcher:start()
        for i,cam in pairs(hs.camera.allCameras()) do
            -- print(i, cam)
            -- if cam:name() == camName then
            obj.logger.i("starting camera watcher for " .. cam:name() .. "")
            cam:setPropertyWatcherCallback(on_cam_inner):startPropertyWatcher()
            if(cam:isInUse()) then
                if (obj.visualIndicator) then
                    showRedDot(cam)
                end
                watcher.cameraOnCallback()
                -- cam:setWatcherCallback(on_cam2):startWatcher()
                -- break;
            end
        end
    end

    function watcher:stop()
        for i,cam in pairs(hs.camera.allCameras()) do
            -- print(i, cam)
            -- if cam:name() == camName then
            obj.logger.i("stopping camera watcher for " .. cam:name() .. "")
                cam:stopPropertyWatcher()
                -- cam:setWatcherCallback(on_cam2):startWatcher()
                -- break;
            -- end
        end
    end

    return watcher;
end






--- CamCord:init()
--- Method
--- Initialize the module
---
--- Parameters:
---  * None
function obj:init()
    
end


return obj

