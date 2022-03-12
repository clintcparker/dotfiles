-- hammerspoon config

--#region requires
-- these are nice to have loaded when generating docs. idk if there's an overhead cost
require("hs.ipc")
require("hs.doc")

--#endregion requires

--#region loggers
local configLog = hs.logger.new("config", "info")
--#endregion loggers

--#region Spoons

hs.loadSpoon("Zoom")
hs.loadSpoon("LitraGlow")

hs.loadSpoon("MMMute")
local muter = spoon.MMMute
muter:setDefaultVolume(75)

hs.loadSpoon("WiFun")
--#endregion Spoons

--#region key bindings
local hyper = {"shift", "cmd", "alt", "ctrl"}
muter:bindHotkeys({toggle = {hyper, "M"}})
--#endregion key bindings

--#region Watchers registration
-- this pattern seems to be the safest way to register a watcher
local camName = "USB2.0 FHD UVC WebCam"
local usbw = hs.usb.watcher
local pow = hs.caffeinate.watcher
local config = hs.pathwatcher
--#endregion Watchers registration

--#region Utils
local function setWifi()
    -- is there a connected usb device named "USB 10/100/1000 LAN"
    -- maybe this could be more clever based on network config?
    local usb = hs.usb.attachedDevices()
    for _,device in pairs(usb) do
        if device.productName == "USB 10/100/1000 LAN" then
            spoon.WiFun:disconnectWiFi()
            return
        end
    end
    spoon.WiFun:reconnectWiFi()
end



local function on_cam(cam, prop, scope, element)
    print("in camw")
    print("cam:name():  "..cam:name().. "")
    print("prop: "..prop.. "")
    print("scope: "..scope.. "")
    print("element: "..element.. "")
end

function startCamWatcher()
    print("in startCamWatcher")
    for i,cam in pairs(hs.camera.allCameras()) do
        print(i, cam)
        if cam:name() == camName then
            configLog.i("found camera: " .. camName)
            configLog.i("starting camera watcher")
            cam:setPropertyWatcherCallback(on_cam):startPropertyWatcher()
            break;
        end
    end
end

local function stopCamWatcher()
    configLog.i("stopping camera watcher")
end

-- this method is stupid. Use hs.inspect.inspect(obj) instead
function inspect(tbl)
    return hs.inspect.inspect(tbl)
end
--#endregion Utils

--#region Callbacks
local function on_usb(data)
    configLog.i("USB Event " ..data.productName.. " " ..data.eventType.. "");
    if data.productName == "USB 10/100/1000 LAN" then
        if data.eventType == "added" then
            configLog.i("USB Event " ..data.productName.. " " ..data.eventType.. "");
            spoon.WiFun:disconnectWiFi()
            -- hs.notify.show("Monitor", "connected", "");
        elseif data.eventType == "removed" then
            configLog.i("USB Event " ..data.productName.. " " ..data.eventType.. "");
            spoon.WiFun:reconnectWiFi()
            -- hs.notify.show("Monitor", "disconnected", "");
        end
    end
    -- if data.productName == camName then
    --     if data.eventType == "added" then
    --         startCamWatcher()
    --     elseif data.eventType == "removed" then
    --         stopCamWatcher()
    --     end
    -- end
end


local function on_pow(event)
    local name = "?"
    for key,val in pairs(pow) do
      if event == val then name = key end
    end
    configLog.f("Power event %d => %s", event, name)
    if event == pow.screensDidUnlock
      or event == pow.screensaverDidStop
    then
      configLog.i("Screen awakened!")
      setWifi()
      return
    end
    if event == pow.screensDidLock
      or event == pow.screensaverDidStart
    then
      configLog.i("Screen locked.")
      return
    end
end

function reloadConfig(files)
    local doReload = false
    for _,file in pairs(files) do
        if file:sub(-4) == ".lua" then
            doReload = true
        end
    end
    if doReload then
        hs.reload()
    end
end

zoomStatusMenuBarItem = hs.menubar.new(nil)
zoomStatusMenuBarItem:setClickCallback(function()
    spoon.Zoom:toggleMute()
end)

updateZoomStatus = function(event)
--   hs.printf("updateZoomStatus(%s)", event)
--   hs.http.get("")
    if (event == "videoStarted" or event == "from-running-to-meeting") then
        hs.urlevent.openURL("hammerspoon://lights?action=on")
    end
    if (event == "from-meeting-to-running" or event == "from-running-to-closed") then
        hs.urlevent.openURL("hammerspoon://lights?action=off")
    end
end
--#endregion Callbacks

--#region Watchers start
spoon.Zoom:setStatusCallback(updateZoomStatus)
spoon.Zoom:pollStatus(1)
spoon.Zoom:start()

uw = usbw.new(on_usb)
uw:start()
configLog.i("USB events watcher started.")

cw = pow.new(on_pow)
cw:start()
configLog.i("Power events watcher started.")

conw = config.new(os.getenv("HOME") .. "/.hammerspoon/", reloadConfig)
conw:start()
configLog.i("Config files watcher started.")

hs.urlevent.bind("lights", function(eventName, params)
    print(eventName)
    print(params["action"])
    if params["action"] == "on" then
        spoon.LitraGlow:turnOn()
        hs.timer.doAfter(1, function()    
            spoon.LitraGlow:turnOn()
        end)
        hs.timer.doAfter(2, function()  
            spoon.LitraGlow:turnOn()
        end)
    end
    if params["action"] == "off" then
        spoon.LitraGlow:turnOff()
        hs.timer.doAfter(1, function()    
            spoon.LitraGlow:turnOff()
        end)
        hs.timer.doAfter(2, function()  
            spoon.LitraGlow:turnOff()
        end)
    end
end)

--#endregion Watchers start

--#region Setup

-- call reloadConfig every day at midnight, and refresh every hour
hs.timer.doAt(0,hs.timer.hours(1), hs.reload):start()

-- set wifi on startup
setWifi()
--#endregion Setup

--#region finally
local configNotify = hs.notify.new({title="Config",subTitle="loaded", informativeText=os.date("%I:%M %p"), autoWithdraw=true, alwaysPresent=true, withdrawAfter=10})
configNotify:send()
configLog.i("Config loaded");
--#endregion finally