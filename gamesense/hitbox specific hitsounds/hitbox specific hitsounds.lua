local client_exec, client_set_event_callback = client.exec, client.set_event_callback

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
        client_exec("play aim_sounds/spread.wav")
    elseif e.reason == '?' then
        client_exec("play aim_sounds/unknown.wav")
    elseif e.reason == 'prediction' then
        client_exec("play aim_sounds/prediction.wav")       
    end
end
client_set_event_callback("aim_miss", missHandler)

-- hit sounds
local function hitHandler(e)
    if hitboxes[e.hitgroup + 1] == "head" then
        client_exec("play aim_sounds/head.wav")
    elseif hitboxes[e.hitgroup + 1] == "chest" then
        client_exec("play aim_sounds/chest.wav")
    elseif hitboxes[e.hitgroup + 1] == "stomach" then
        client_exec("play aim_sounds/stomach.wav")
    elseif hitboxes[e.hitgroup + 1] == "left arm" or hitboxes[e.hitgroup + 1] == "right arm" then 
        client_exec("play aim_sounds/arms.wav")
    elseif hitboxes[e.hitgroup + 1] == "left leg" or hitboxes[e.hitgroup + 1] == "right leg" then
        client_exec("play aim_sounds/legs.wav")
    end
end
client_set_event_callback("aim_hit", hitHandler)
