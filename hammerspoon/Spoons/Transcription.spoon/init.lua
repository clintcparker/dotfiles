--- === Transcription ===
---
---  Handles completed transcriptions from Talat.app
---
--- This module provides a few functions for handling transcriptions and sending them to the llm-wiki
local obj={}
obj.__index = obj

-- Metadata
obj.name = "Transcription"
obj.version = "1.0"
obj.author = "clintcparker <clintcparker@gmail.com>"
obj.homepage = "https://clintparker.com"
obj.license = "MIT - https://opensource.org/licenses/MIT"
obj.logger = hs.logger.new(obj.name, "info")
obj.home = os.getenv("HOME")





--- Transcription:init()
--- Method
--- Initialize the module
---
--- Parameters:
---  * None
function obj:init()
    hs.urlevent.bind("talt", function(_, params)
        obj.logger.info("title: " .. params["title"])
        obj.logger.info("id: " .. params["id"])
        obj.logger.info("date: " .. params["date"])
    end)
end


return obj