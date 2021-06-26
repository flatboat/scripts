local function missHandler(e)
    client.exec('playerradio DeathCry "*cums* | I missed due to: '.. e.reason .. '"')
end

client.set_event_callback("aim_miss", missHandler)

local function hitHandler(e)
    client.exec('playerradio DeathCry "GOD i love gamesense.pub *cums*"')
end

client.set_event_callback("aim_hit", hitHandler)
