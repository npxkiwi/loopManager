# cl-loopManager

A lightweight Lua loop manager for FiveM, allowing you to create, start, stop, check, and destroy named loops.

## ⚠️ Important

The original code was written by me. AI was used to help improve the code and add LuaLS annotations and parameter documentation.

## 📑 Contents

- [Usage](#usage)
  - [Create a loop](#create-a-loop)
  - [Toggle a loop](#toggle-a-loop)
  - [Check loop state](#check-loop-state)
  - [Destroy a loop](#destroy-a-loop)
- [Functions](#functions)

## Usage

### Create a loop

Use `loop.create()` to create a new loop with a unique name, callback, and optional delay in milliseconds.

```lua
local loop = require 'cl-loopManager'

loop.create('example', function()
    print('Loop running')
end, 1000)
```

### Toggle a loop

Use `loop.toggle()` to start or stop a loop.

```lua
loop.toggle('example') -- Start the loop
loop.toggle('example') -- Stop the loop
```

### Check loop state

Use `loop.state()` to check whether a loop is currently running.

```lua
print(loop.state('example')) -- true or false
```

Returns `nil` if the loop does not exist.

### Destroy a loop

Use `loop.destroy()` to stop and remove a loop.

```lua
loop.destroy('example')
```

## Functions

| Function | Parameters | Description |
|---|---|---|
| `loop.create()` | `name`, `callback`, `delay?` | Creates a new loop. |
| `loop.toggle()` | `name` | Starts or stops a loop. |
| `loop.state()` | `name` | Returns the loop's running state. |
| `loop.destroy()` | `name` | Stops and removes a loop. |

### Parameters

- `name` (`string`) — Unique identifier for the loop.
- `callback` (`function`) — Function executed on each iteration.
- `delay` (`integer?`) — Time in milliseconds to wait between iterations. Defaults to `0`.
