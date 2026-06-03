# Loop Manager

A lightweight loop manager for FiveM that allows you to create, start, stop, toggle, and monitor loops without manually managing multiple `CreateThread` calls.

---

## Features

- Create named loops
- Start and stop loops dynamically
- Toggle loop states
- Check if a loop is running
- Destroy unused loops
- Keep resources organized and modular

---

## Installation

Create a file called `loop.lua`.

```lua
loop = {}

local loops = {}

function loop.create(name, callback, delay)
    loops[name] = {
        callback = callback,
        delay = delay or 0,
        running = false
    }
end

function loop.start(name)
    local l = loops[name]
    if not l or l.running then return end

    l.running = true

    CreateThread(function()
        while l.running do
            l.callback()
            Wait(l.delay)
        end
    end)
end

function loop.stop(name)
    local l = loops[name]
    if l then
        l.running = false
    end
end

function loop.toggle(name)
    local l = loops[name]
    if not l then return end

    if l.running then
        loop.stop(name)
    else
        loop.start(name)
    end
end

function loop.state(name)
    return loops[name] and loops[name].running or false
end

function loop.destroy(name)
    loops[name] = nil
end
```

---

# API

## loop.create

Creates a new loop.

### Syntax

```lua
loop.create(name, callback, delay)
```

### Parameters

| Name | Type | Description |
|--------|--------|-------------|
| name | string | Unique loop identifier |
| callback | function | Function executed every iteration |
| delay | number | Delay between iterations (milliseconds) |

### Example

```lua
loop.create('player_check', function()
    print('Checking player...')
end, 1000)
```

---

## loop.start

Starts a loop.

### Syntax

```lua
loop.start(name)
```

### Example

```lua
loop.start('player_check')
```

---

## loop.stop

Stops a loop.

### Syntax

```lua
loop.stop(name)
```

### Example

```lua
loop.stop('player_check')
```

---

## loop.toggle

Toggles a loop's running state.

### Syntax

```lua
loop.toggle(name)
```

### Example

```lua
loop.toggle('player_check')
```

---

## loop.state

Returns whether a loop is currently running.

### Syntax

```lua
loop.state(name)
```

### Returns

```lua
boolean
```

### Example

```lua
if loop.state('player_check') then
    print('Loop is running')
end
```

---

## loop.destroy

Removes a loop from memory.

### Syntax

```lua
loop.destroy(name)
```

### Example

```lua
loop.destroy('player_check')
```

---

# Basic Example

```lua
loop.create('peds_creator', function()

    local ped = PlayerPedId()
    local coords = GetEntityCoords(ped)

    DrawMarker(
        1,
        coords.x,
        coords.y,
        coords.z - 1.0,
        0.0, 0.0, 0.0,
        0.0, 0.0, 0.0,
        0.2, 0.2, 0.2,
        255, 0, 0, 100,
        false, true
    )

end, 0)
```

Start the loop:

```lua
loop.start('peds_creator')
```

Stop the loop:

```lua
loop.stop('peds_creator')
```

---

# Command Example

```lua
RegisterCommand('creator', function()

    loop.toggle('peds_creator')

    print(('Creator State: %s'):format(
        loop.state('peds_creator')
    ))

end)
```

---

# Best Practices

### Use descriptive names

```lua
loop.create('vehicle_spawner', ...)
loop.create('admin_noclip', ...)
loop.create('zone_checker', ...)
```

### Avoid expensive operations every frame

Bad:

```lua
loop.create('objects', function()
    GetGamePool('CObject')
end, 0)
```

Good:

```lua
loop.create('objects', function()
    GetGamePool('CObject')
end, 1000)
```

### Destroy loops you no longer need

```lua
loop.stop('vehicle_spawner')
loop.destroy('vehicle_spawner')
```

---

# Resource Structure

```text
client/
├── loop.lua
├── creator.lua
├── noclip.lua
└── zones.lua
```

```lua
-- creator.lua

loop.create('peds_creator', function()
    -- creator logic
end)

-- noclip.lua

loop.create('noclip', function()
    -- noclip logic
end)

-- zones.lua

loop.create('zone_checker', function()
    -- zone logic
end, 500)
```

This pattern allows systems to be enabled and disabled dynamically while keeping your codebase clean and maintainable.
