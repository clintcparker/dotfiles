-- hammerspoon config

--#region requires
-- these are nice to have loaded when generating docs. idk if there's an overhead cost
require("hs.ipc")

-- hs.ipc.cliInstall() requires write access to /usr/local/bin and /usr/local/share/man/man1 to install the command line client and man page.
-- If you've installed Homebrew in its traditional location, this should be taken care of for you; if you're using an M1 Mac,
-- and installed Homebrew in the recommended alternate location, then I think it's using /opt/homebrew instead...
-- you could try hs.ipc.cliInstall("/opt/homebrew") which will leverage the already writable
-- directories and path addition that Homebrew required.


require("hs.doc")

--#endregion requires

--#region loggers
local configLog = hs.logger.new("config", "info")
--#endregion loggers

--#region Spoons
--
hs.loadSpoon("Transcription")
hs.loadSpoon("LitraGlow")

hs.loadSpoon("Rewind")

hs.loadSpoon("GoogleMeetManager")
spoon.GoogleMeetManager:start()

--#endregion Spoons

--#region key bindings
local hyper = {"shift", "cmd", "alt", "ctrl"}
--#endregion key bindings

--#region Watchers registration

local function cameraOn()
    spoon.LitraGlow:turnOn()
    spoon.Rewind:turnOn()
end

local function cameraOff()
    spoon.LitraGlow:turnOff()
    spoon.Rewind:turnOff()
end
-- this pattern seems to be the safest way to register a watcher
local usbw = hs.usb.watcher
local pow = hs.caffeinate.watcher
local config = hs.pathwatcher
local camcord = hs.loadSpoon("CamCord")
camcord.visualIndicator = true
local camWatcher = camcord:newWatcher(cameraOn, cameraOff)
--#endregion Watchers registration

--#region Utils

-- shorthand for hs.inspect.inspect(obj) — intentionally global for console use
function inspect(tbl)
    return hs.inspect.inspect(tbl)
end
--#endregion Utils

--#region Callbacks
local function on_usb(data)
    configLog.i("USB Event " ..data.productName.. " " ..data.eventType.. "");
    if data.productName == "Litra Glow" then
        if data.eventType == "added" then
            spoon.LitraGlow:showMenu();
        elseif data.eventType == "removed" then
            spoon.LitraGlow:hideMenu();
        end
    end
end

local function cycleCamWatcher()
    camWatcher:stop();
    camWatcher:start();
end

local function on_pow(event)
    local name = "?"
    for key,val in pairs(pow) do
      if event == val then name = key end
    end
    if event == pow.screensDidUnlock or event == pow.screensaverDidStop then
      configLog.i("Screen awakened!");
      cycleCamWatcher()
      return
    end
    if event == pow.screensDidLock or event == pow.screensaverDidStart then
      configLog.i("Screen locked.")
      spoon.LitraGlow:turnOff()
      return
    end
end

local function reloadConfig(files)
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

--#endregion Callbacks

--#region Watchers start

local uw = usbw.new(on_usb)
uw:start()
configLog.i("USB events watcher started.")

local cw = pow.new(on_pow)
cw:start()
configLog.i("Power events watcher started.")

local conw = config.new(os.getenv("HOME") .. "/.hammerspoon/", reloadConfig)
conw:start()
configLog.i("Config files watcher started.")

camWatcher:start()

--#endregion Watchers start

--#region finally
local configNotify = hs.notify.new({title="Config",subTitle="loaded", informativeText=os.date("%I:%M %p"), autoWithdraw=true, alwaysPresent=true, withdrawAfter=10})
configNotify:send()
configLog.i("Config loaded");
--#endregion finally
