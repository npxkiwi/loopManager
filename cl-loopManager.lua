loop = {}

local loops = {}

function loop.create(name, callback, delay)
    loops[name] = {
        callback = callback,
        delay = delay or 0,
        running = false
    }
end

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

function loop.state(name)
    return loops[name] and loops[name].running
end

function loop.destroy(name)
    loops[name] = nil
end

return loop