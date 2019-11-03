-- Global config values
CHANNEL = 0
AXE_FX_NAME = "Axe-Fx III MIDI Out"

-- Message types:
CC_MESSAGE = 176

-- The commands we want to run:
COMMANDS = {
    ["SceneIncrement"] = function() SendCC(10) end,
    ["SceneDecrement"] = function() SendCC(11) end,
}
function FindAxe()
    outputs = reaper.GetNumMIDIOutputs()
    for i = 0, outputs do
        present, nameout = reaper.GetMIDIOutputName(i, "")
        if present then
            if nameout == AXE_FX_NAME then
                return true, i
            end
        end
    end
    return false, -1
end

function SendMessage(device, type, channel, b2, b3)
    b2 = b2 or 0
    b3 = b3 or 0
    --reaper.ShowConsoleMsg("Sending: " .. tostring(CC_MESSAGE + CHANNEL) .. " " .. tostring(CC) .. " " .. tostring(CC_VALUE) .. "\n")
    reaper.StuffMIDIMessage(16 + device, type + channel, b2, b3)
end

function SendCC(cc, val)
    val = val or 0
    found, device = FindAxe()
    if found then
        SendMessage(device, CC_MESSAGE, CHANNEL, cc, val)
    end
end

function get_file_name(source)
    name = source:match("[^\\]*.lua$"):match("(.*).lua")
    reaper.ShowConsoleMsg(name .. "\n")
    return name
end

function HandleAction(action)
    COMMANDS[action]()
end
