-- libraries and requirements
local ref = require "ref_lib"

-- variables
local hitboxes = {
    "generic",
    "head",
    "chest",
    "stomach",
    "left arm",
    "right arm",
    "left leg",
    "right leg",
    "neck",
    "?",
    "gear"
}

-- miss sounds
local function missHandler(e)
    if e.reason == 'spread' then
        client.log("spread")
    elseif e.reason == '?' then
        client.log("?")
    elseif e.reason == 'prediction' then
        client.log("pred")
    else
        client.log("unknown")
    end
end
client.set_event_callback("aim_miss", missHandler)

-- hit sounds
local function hitHandler(e)
    if hitboxes[e.hitgroup + 1] == "head" then
        client.exec("play aim_sounds/head.wav")
    elseif hitboxes[e.hitgroup + 1] == "chest" then
        client.exec("play aim_sounds/chest.wav")
    elseif hitboxes[e.hitgroup + 1] == "stomach" then
        client.exec("play aim_sounds/stomach.wav")
    elseif hitboxes[e.hitgroup + 1] == "left arm" or hitboxes[e.hitgroup + 1] == "right arm" then 
        client.exec("play aim_sounds/arms.wav")
    elseif hitboxes[e.hitgroup + 1] == "left leg" or hitboxes[e.hitgroup + 1] == "right leg" then
        client.exec("play aim_sounds/legs.wav")
    end
end

client.set_event_callback("aim_hit", hitHandler)
