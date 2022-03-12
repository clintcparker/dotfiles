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

function obj:turnOn()
    hs.execute(" ~/Source/hidapitester/hidapitester --vidpid 046D/C900 --open --length 20 --send-output 0x11,0xff,0x04,0x1c,0x01 \
    ~/Source/hidapitester/hidapitester --vidpid 046D/C900 --open --length 20 --send-output 0x11,0xff,0x04,0x1c,0x01  \
    ~/Source/hidapitester/hidapitester --vidpid 046D/C900 --open --length 20 --send-output 0x11,0xff,0x04,0x1c,0x01  \
    ~/Source/hidapitester/hidapitester --vidpid 046D/C900 --open --length 20 --send-output 0x11,0xff,0x04,0x1c,0x01  \
    ~/Source/hidapitester/hidapitester --vidpid 046D/C900 --open --length 20 --send-output 0x11,0xff,0x04,0x1c,0x01  ")
end

function obj:turnOff()
    hs.execute("            ~/Source/hidapitester/hidapitester --vidpid 046D/C900 --open --length 20 --send-output 0x11,0xff,0x04,0x1c,0x00 \
    ~/Source/hidapitester/hidapitester --vidpid 046D/C900 --open --length 20 --send-output 0x11,0xff,0x04,0x1c,0x00 \
    ~/Source/hidapitester/hidapitester --vidpid 046D/C900 --open --length 20 --send-output 0x11,0xff,0x04,0x1c,0x00 \
    ~/Source/hidapitester/hidapitester --vidpid 046D/C900 --open --length 20 --send-output 0x11,0xff,0x04,0x1c,0x00 \
    ~/Source/hidapitester/hidapitester --vidpid 046D/C900 --open --length 20 --send-output 0x11,0xff,0x04,0x1c,0x00")
end

function obj:init()

end

return obj