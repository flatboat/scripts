local originalDmg = ui.get(ui.reference("RAGE", "Aimbot", "Minimum damage"))
local mindmg_dt = ui.new_slider("RAGE", "Aimbot", "DT min dmg", 0, 100)
local double_tap, double_tap_key = ui.reference("RAGE", "Other", "Double tap")
local minDmg = ui.reference("RAGE", "Aimbot", "Minimum damage")
local dt_mindamage = ui.reference("RAGE", "Aimbot", "DT min dmg")


local function dt_minDmg()
    if ui.get(double_tap_key) == true then
        ui.set(minDmg, ui.get(dt_mindamage))
    else
        ui.set(minDmg, originalDmg)
    end 
end

client.set_event_callback('net_update_start', dt_minDmg)
