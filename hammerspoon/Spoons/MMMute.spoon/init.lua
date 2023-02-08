--- === MMMute ===
---
--- Mute Toggle and status indicator based on MicMute 
---
--- This module provides a number of functions for working with mics
local obj={}
obj.__index = obj

-- Metadata
obj.name = "MMMute"
obj.version = "1.0"
obj.author = "clintcparker <clintcparker@gmail.com>"
obj.homepage = "https://clintparker.com"
obj.license = "MIT - https://opensource.org/licenses/MIT"
obj.logger = hs.logger.new(obj.name, "info")

--- MMMute:updateMMMute(muted)
--- Method
--- Update MMMute
---
--- Parameters:
---  * muted - boolean
function obj:updateMMMute(muted)
	local mic = hs.audiodevice.defaultInputDevice()
	if muted == -1 then
		muted = mic:inputMuted() or mic:inputVolume() == 0
		-- muted = hs.audiodevice.defaultInputDevice():muted()
	end
	if muted then
		obj.mute_menu:setTitle("📵")
	else
		obj.mute_menu:setTitle("🎙")
	end
end

--- MMMute:toggleMMMute()
--- Method
--- Toggle mic mute on/off
---
--- Parameters:
---  * None
function obj:toggleMMMute()
	local mic = hs.audiodevice.defaultInputDevice()
	-- if the mic name contains 'AirPods' then call toggleInputVolume() and return
	if mic:name():find("AirPods") then
		obj:toggleInputVolume()
		return
	end
	local mic_name = mic:name();
	-- if muted, then unmute
	if mic:muted()then
		mic:setInputMuted(false)
		local msg = "Unmuting " .. mic_name.. " input"
		hs.alert.show(msg)
		obj.logger.i(msg)
		obj:unmuteZoom()
	else
		-- if not muted, then mute using input_vol
		mic:setInputMuted(true)
		local msg = "📵 Muting " .. mic_name.. " input 📵"
		hs.alert.show(msg)
		obj.logger.i(msg)
		obj:muteZoom()
	end
	obj:updateMMMute(-1)
end


--- MMMute:unmuteZoom()
--- Method
--- Unmute Zoom
---
--- Parameters:
---  * None
function obj:unmuteZoom()
	local zoom = hs.application'Zoom'
	if zoom then
		local ok = zoom:selectMenuItem'Unmute Audio'
		if not ok then
			hs.timer.doAfter(0.5, function()
				zoom:selectMenuItem'Unmute Audio'
			end)
		end
	end
end

--- MMMute:muteZoom()
--- Method
--- Mute Zoom
---
--- Parameters:
---  * None
function obj:muteZoom()
	local zoom = hs.application'Zoom'
	if zoom then
		local ok = zoom:selectMenuItem'Mute Audio'
		if not ok then
			hs.timer.doAfter(0.5, function()
				zoom:selectMenuItem'Mute Audio'
			end)
		end	
	end
end

--- MMMute:toggleInputVolume()
--- Method
--- Toggle mic mute on/off
---
--- Parameters:
---  * None
function obj:toggleInputVolume()
	local mic = hs.audiodevice.defaultInputDevice()
	local mic_name = mic:name();
	-- if muted, then unmute
	if mic:inputVolume() == 0 then
		local msg = "Unmuting " .. mic_name.. " input"
		hs.alert(msg)
		obj.logger.i(msg)
		mic:setInputMuted(false)
		mic:setInputVolume(obj.default_input_volume)
		obj:unmuteZoom()
	else
		-- if not muted, then mute using input_vol
		local msg = "📵 Muting " .. mic_name.. " input 📵"
		hs.alert(msg)
		obj.logger.i(msg)
		mic:setInputVolume(0)
		obj:muteZoom()
	end
	obj:updateMMMute(-1)
end


--- MMMute:bindHotkeys(mapping, latch_timeout)
--- Method
--- Binds hotkeys for MMMute
---
--- Parameters:
---  * mapping - A table containing hotkey modifier/key details for the following items:
---   * toggle - This will cause the microphone mute status to be toggled. Hold for momentary, press quickly for toggle.
---  * latch_timeout - Time in seconds to hold the hotkey before momentary mode takes over, in which the mute will be toggled again when hotkey is released. Latch if released before this time. 0.75 for 750 milliseconds is a good value.
function obj:bindHotkeys(mapping, latch_timeout)
	if (self.hotkey) then
		self.hotkey:delete()
	end
	local mods = mapping["toggle"][1]
	local key = mapping["toggle"][2]

	if latch_timeout then
		self.hotkey = hs.hotkey.bind(mods, key, function()
			self:toggleMMMute()
			self.time_since_mute = hs.timer.secondsSinceEpoch()
		end, function()
			if hs.timer.secondsSinceEpoch() > self.time_since_mute + latch_timeout then
				self:toggleMMMute()
			end
		end)
	else
		self.hotkey = hs.hotkey.bind(mods, key, function()
			self:toggleMMMute()
		end)
	end

	return self
end


--- MMMute:setDefaultVolume(default_input_volume)
--- Method
--- Sets the default volume for the input device
---
--- Parameters:
--- * default_input_volume - The default volume for the input device
function obj:setDefaultVolume(vol)
	obj.default_input_volume = vol
end

--- MMMute:init()
--- Method
--- Initialize the module
---
--- Parameters:
---  * None
function obj:init()
	hs.application.enableSpotlightForNameSearches(true)
	obj.time_since_mute = 0
	obj.mute_menu = hs.menubar.new()
	obj.mute_menu:setClickCallback(function()
		obj:toggleMMMute()
	end)
	obj.default_input_volume = hs.audiodevice.defaultInputDevice():inputVolume()
	if obj.default_input_volume == 0 then
		obj.default_input_volume = 50
	end
	obj:updateMMMute(-1)

	hs.audiodevice.watcher.setCallback(function(arg)
		if string.find(arg, "dIn ") then
			obj:updateMMMute(-1)
		end
	end)
	hs.audiodevice.watcher.start()
end

return obj