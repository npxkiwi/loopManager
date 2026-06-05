# Contents
- [Usage](#usage)

## <a id="usage"></a>Usage
### Create loop
```lua
local loop = require 'cl-loopManager'
CreateThread(function()
    loop.create("drawMarker", function()
        local _plr = cache.ped
        local _plrCoords = GetEntityCoords(_plr)
        local marker = lib.marker.new({
        	type = 1,
        	coords = _plrCoords,
        	color = { r = 255, g = 0, b = 0, a = 200 },
        })

        marker:draw()
    end, 0)
end)

RegisterCommand('drawMarker', function()
    loop.toggle('drawMarker')
end, false)
```
