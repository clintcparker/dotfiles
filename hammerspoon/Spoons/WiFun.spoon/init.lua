--- === WiFun ===
---
--- WiFi tools
---
--- This module provides a number of functions for working with WiFi networks.

local obj={}
obj.__index = obj

-- Metadata
obj.name = "WiFun"
obj.version = "1.0"
obj.author = "clintcparker <clintcparker@gmail.com>"
obj.homepage = "https://clintparker.com"
obj.license = "MIT - https://opensource.org/licenses/MIT"
obj.logger = hs.logger.new(obj.name, "info")

--#region Utils

-- list all network interfaces by their display name and address
function listInterfaces()
    local interfaces = hs.network.interfaces()
    for interface in interfaces do
        obj.logger.i(hs.interfaceName(interface))
    end
end

-- open the network preferences pane and bring it to the front
function openNetworkPrefs()
    hs.application.launchOrFocus("System Preferences")
end
--#endregion Utils


--- WiFun:toggleWiFi()
--- Method
--- Toggle WiFi on/off
---
--- Parameters:
---  * None
function obj:toggleWiFi()
    obj.logger.i("toggleWiFi")
    local wifi = hs.wifi.currentNetwork()
    if wifi == nil then
        obj:reconnectWiFi()
    else
        obj:disconnectWiFi()
    end
    self:refreshWiFi()
end

--- WiFun:disconnectWiFi()
--- Method
--- Disconnect WiFi
---
--- Parameters:
---  * None
function obj:disconnectWiFi()
    obj.logger.i("disconnectWiFi")
    hs.wifi.setPower(false)
    self:refreshWiFi()
end

--- WiFun:reconnectWiFi()
--- Method
--- Reconnect WiFi
---
--- Parameters:
---  * None
function obj:reconnectWiFi()
    obj.logger.i("reconnectWiFi")
    hs.wifi.setPower(true)
    hs.timer.doAfter(3, function()    
        self:refreshWiFi()
    end)
    hs.timer.doAfter(10, function()    
        self:refreshWiFi()
    end)
end

--- WiFun:refreshWiFi()
--- Method
--- Refresh WiFi menu
---
--- Parameters:
---  * None
function obj:refreshWiFi()
    local wifi = hs.wifi.currentNetwork()
    if wifi == nil then
        self.wifi_menu:setTitle("WiFi Off")
        self.wifi_menu:setTooltip("WiFi Off")
        self.wifi_menu:setIcon(hs.image.imageFromPath("/System/Library/CoreServices/CoreTypes.bundle/Contents/Resources/NetworkNodeOffIcon.icns"))
    else
        self.wifi_menu:setTitle(wifi)
        self.wifi_menu:setTooltip(wifi)
        self.wifi_menu:setIcon(hs.image.imageFromPath("/System/Library/CoreServices/CoreTypes.bundle/Contents/Resources/NetworkNodeIcon.icns"))
    end
end


--- WiFun:init()
--- Method
--- Initialize the WiFun module.
---
--- Parameters:
---  * None
function obj:init()
    obj.wifi = hs.wifi.currentNetwork()
    obj.wifi_menu = hs.menubar.new()
    obj.wifi_menu:setTitle(obj.wifi)
    obj.wifi_menu:setClickCallback(function()
        obj:toggleWiFi()
    end)
    obj.wifi_menu:setTooltip("WiFi")
    obj.wifi_menu:setIcon(hs.image.imageFromPath("/System/Library/CoreServices/CoreTypes.bundle/Contents/Resources/NetworkNodeIcon.icns"))
    obj.wifi_menu:setMenu({
        {title = "Toggle WiFi", fn = function()
            obj:toggleWiFi()
        end},
        {title = "Disconnect", fn = function()
            obj:disconnectWiFi()
        end},
        {title = "Reconnect", fn = function()
            obj:reconnectWiFi()
        end},
        {title = "Refresh", fn = function()
            obj:refreshWiFi()
        end},
    })
    -- obj.wifi_menu:setClickCallback(function()
    --     obj.wifi_menu:setMenu({
    --         {title = "Toggle WiFi", fn = function()
    --             obj:toggleWiFi()
    --         end},
    --         {title = "Disconnect", fn = function()
    --             obj:disconnectWiFi()
    --         end},
    --         {title = "Reconnect", fn = function()
    --             obj:reconnectWiFi()
    --         end},
    --         {title = "Refresh", fn = function()
    --             obj:refreshWiFi()
    --         end},
    --     })
    -- end)
    obj:refreshWiFi()
end


return obj
