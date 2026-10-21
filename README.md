# Contents
- [Usage](#usage)

## <a id="usage"></a>Usage
### Create loop
```lua
local loop = require 'cl-loopManager'

loop.create('example', function()
    print('Loop running')
end, 1000)

loop.toggle('example') -- Start
print(loop.state('example')) -- true

loop.toggle('example') -- Stop
loop.destroy('example') -- Remove
```
