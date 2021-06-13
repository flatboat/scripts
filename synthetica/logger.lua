local hitbox_hit = ""
local dmg = ""

local function on_shot(shot_info)
    local result = shot_info.result
    local client_hitbox = shot_info.client_hitbox
    local server_hitbox = shot_info.server_hitbox
    local safe = shot_info.safe
    local target_index = shot_info.target_index
    local client_damage = shot_info.client_damage
    local server_damage = shot_info.server_damage
    local hitchance = shot_info.hitchance
    local backtrack_ticks = shot_info.backtrack_ticks
    local aim_point = shot_info.aim_point

    if result == "Resolver" then
        hitbox_hit = "-"
        dmg = "-"
    elseif result == "None" then
        result = "Unknown"
        hitbox_hit = "-" 
        dmg = "-"
    elseif result == "Hit" then 
        hitbox_hit = server_hitbox
        dmg = server_damage
    end

    client.log("[ synthetica ] Hitchance: " .. tostring(hitchance) .. " | Result: " .. tostring(result) .. " | Targeted Hitbox: " .. tostring(client_hitbox) .. " | Hit Hitbox: " .. tostring(hitbox_hit) .. " | Safe: " .. tostring(safe) .. " | Predicted Damage: " .. tostring(client_damage) .. " | Actual Damage: " .. tostring(dmg) .. " | Backtrack: " .. tostring(backtrack_ticks))
    console.execute('echo ' .. "[ synthetica ] Hitchance: " .. tostring(hitchance) .. " | Result: " .. tostring(result) .. " | Targeted Hitbox: " .. tostring(client_hitbox) .. " | Hit Hitbox: " .. tostring(hitbox_hit) .. " | Safe: " .. tostring(safe) .. " | Predicted Damage: " .. tostring(client_damage) .. " | Actual Damage: " .. tostring(dmg) .. " | Backtrack: " .. tostring(backtrack_ticks))
end

client.add_callback("on_shot", on_shot)
