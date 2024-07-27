-- GoogleMeetManager.spoon/init.lua

local obj = {}
obj.__index = obj

-- Spoon metadata
obj.name = "GoogleMeetManager"
obj.version = "1.0"
obj.author = "clintcparker <me@clintparker.com"
obj.homepage = "https://clintparker.com"
obj.license = "MIT - https://opensource.org/licenses/MIT"
obj.logger = hs.logger.new(obj.name, "info")

function obj:init()
    self.meetAppWatcher = nil
    -- Adjust the app filter to target 'Microsoft Edge' and the title pattern if needed
    self.windowFilter = hs.window.filter.new(false):setAppFilter('Google Meet')
end

function obj:start()
    self.windowFilter:subscribe(hs.window.filter.windowCreated, function(window) self:handleMeetWindow(window) end)
    self.meetAppWatcher = hs.application.watcher.new(function(appName, eventType, app)
        if appName == 'Google Meet' and eventType == hs.application.watcher.activated then
            self:manageMeetWindows()
        end
    end)
    self.meetAppWatcher:start()
end

function obj:stop()
    if self.meetAppWatcher then self.meetAppWatcher:stop() end
    self.windowFilter:unsubscribeAll()
end

function obj:handleMeetWindow(window)
    hs.timer.doAfter(1, function() self:manageMeetWindows() end) -- Delay to allow window title to update
end

function obj:manageMeetWindows()
    local meetWindows = self.windowFilter:getWindows()
    local activeMeetingFound = false

    for _, window in ipairs(meetWindows) do
        if self:isActiveMeeting(window) then
            window:focus()
            activeMeetingFound = true
            break
        end
    end

    -- if there is an active meeting, close all other windows
    if activeMeetingFound then
        for _, window in ipairs(meetWindows) do
            if not self:isActiveMeeting(window) then
                window:close()
            end
        end
    else
    -- close all winodws except the first one
        for i, window in ipairs(meetWindows) do
            if i > 1 then
                window:close()
            end
        end
    end
end

function obj:isActiveMeeting(window)
    -- This is a simplistic check based on window title. Adjust as necessary.
    -- Example window title is "Meet - ech-xpno-bqe"

    -- get the window title using the accessibility API (remember to use XCode Accessability Inspector)
    local windowTitle = hs.axuielement.windowElement(window):attributeValue("AXChildren")[1]:attributeValue("AXTitle")

    -- log the window title to the console 
    -- obj.logger.i(windowTitle)

    --match the start of the title using this regex: (Meet\s\-\s\w{3}\-\w{4}\-\w{3})
    local match = string.match(windowTitle, "Meet%s%-%s%w%w%w%-%w%w%w%w%-%w%w%w")
    -- if match then
    --     obj.logger.i("String contains a valid Google Meet ID.")
    -- else
    --     obj.logger.i("No valid Google Meet ID found in the string.")
    -- end
    return match
end

return obj