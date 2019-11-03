-- Global config values
CHANNEL = 0
AXE_FX_NAME = "Axe-Fx III MIDI Out"

-- Message types:
CC_MESSAGE = 176
PC_MESSAGE = 192

-- Reserved CC values:
CC_PRESET_INCREMENT = 8
CC_PRESET_DECREMENT = 9
CC_SCENE_INCREMENT = 10
CC_SCENE_DECREMENT = 11
CC_SCENE_SELECT = 12
CC_TUNER = 13

-- The commands we want to run:
COMMANDS = {
    ["AxeOff"] = function() SendPC(0, 0) end,
    ["AxePresetDecrement"] = function() SendCC(CC_PRESET_DECREMENT) end,
    ["AxePresetIncrement"] = function() SendCC(CC_PRESET_INCREMENT) end,
    ["AxeScene1"] = function() SelectScene(0) end,
    ["AxeScene2"] = function() SelectScene(1) end,
    ["AxeScene3"] = function() SelectScene(2) end,
    ["AxeScene4"] = function() SelectScene(3) end,
    ["AxeScene5"] = function() SelectScene(4) end,
    ["AxeSceneDecrement"] = function() SendCC(CC_SCENE_DECREMENT) end,
    ["AxeSceneIncrement"] = function() SendCC(CC_SCENE_INCREMENT) end,
    ["AxeTunerOn"] = function() SendCC(CC_TUNER, 125) end,
    ["AxeTunerOff"] = function() SendCC(CC_TUNER, 0) end,
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

function SendPC(pc, val)
    val = val or 0
    found, device = FindAxe()
    if found then
        SendMessage(device, PC_MESSAGE, CHANNEL, pc, val)
    end
end

function SelectScene(scene)
    SendCC(CC_SCENE_SELECT, scene)
end

function get_file_name(source)
    name = source:match("[^\\]*.lua$"):match("(.*).lua")
    --reaper.ShowConsoleMsg(name .. "\n")
    return name
end

function HandleAction(action)
    COMMANDS[action]()
end
