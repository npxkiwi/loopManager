---@class LoopData
---@field callback fun() Function executed on each iteration
---@field delay integer Delay between iterations in milliseconds
---@field running boolean Whether the loop is currently running

---@class LoopModule
local loop = {}

---@type table<string, LoopData>
local loops = {}

---Create a new loop.
---@param name string Unique identifier for the loop
---@param callback fun() Function executed on each iteration
---@param delay? integer Delay between iterations in milliseconds (default: 0)
---@return nil
function loop.create(name, callback, delay)
    loops[name] = {
        callback = callback,
        delay = delay or 0,
        running = false
    }
end

---Toggle a loop's running state.
---@param name string Unique identifier of the loop
---@return nil
function loop.toggle(name)
    local l = loops[name]
    if not l then return end

    l.running = not l.running

    if l.running then
        CreateThread(function()
            while l.running do
                l.callback()
                Wait(l.delay)
            end
        end)
    end
end

---Get the current state of a loop.
---@param name string Unique identifier of the loop
---@return boolean|nil running True if running, false if stopped, nil if the loop doesn't exist
function loop.state(name)
    return loops[name] and loops[name].running
end

---Destroy a loop.
---@param name string Unique identifier of the loop
---@return nil
function loop.destroy(name)
    local l = loops[name]
    if not l then return end

    l.running = false
    loops[name] = nil
end

return loop
