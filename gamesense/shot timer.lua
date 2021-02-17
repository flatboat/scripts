local ssx, ssy = client.screen_size()
local enableShotTimer = ui.new_checkbox("Visuals", "Other ESP", "Enable Shot Timer")
local enableSound = ui.new_checkbox("Visuals", "Other ESP", "Play Sound When Ready")
local soundVolume = ui.new_slider("Visuals", "Other ESP", "Sound Volume", 0, 100, 50, true, "%")
local colors = ui.new_color_picker("Visuals", "Other ESP", "Shot Timer Color", 138, 255, 169, 255)
local hslider = ui.new_slider("Visuals", "Other ESP", "Shot Timer Line Thickness", 1, 15, 1)
local timeToShoot = 0
local bPlaySound = false

local DataBaseName = "ShotTimerPosition"
if not database.read(DataBaseName) then
	database.write(DataBaseName, {x = 20 , y = 600})
end
local Movement = 
{
	Position = database.read(DataBaseName),
	GrabOffset = {},
	IsMoving = false,
	CanMoveOutsideOfRect = false, --If mouse is off of rect but should still be able to drag
	ClickedOutsideOfRect = false, --Prevent movement if has clicked before being on rect
}


ui.set_visible(hslider, false)
ui.set_visible(enableSound, false)
ui.set_visible(soundVolume, false)

--the real code haha lol
local function on_paint()
    if ui.get(enableShotTimer) then
        ui.set_visible(hslider, true)
        ui.set_visible(enableSound, true)
        local local_player = entity.get_local_player()
        local local_player_weapon = entity.get_player_weapon(local_player)

        if entity.is_alive(local_player) then
            local r, g, b, a = ui.get(colors)
            local h = ui.get(hslider)
            
            
            local cur = globals.curtime()
            if cur < entity.get_prop(local_player_weapon, "m_flNextPrimaryAttack") then
                timeToShoot = entity.get_prop(local_player_weapon, "m_flNextPrimaryAttack") - cur
                bPlaySound = true
            elseif cur < entity.get_prop(local_player, "m_flNextAttack") then
                timeToShoot = entity.get_prop(local_player, "m_flNextAttack") - cur
                bPlaySound = true
            end

            if math.floor((timeToShoot * 1000) + 0.5) <= 10 then
                timeToShoot = 0
            end

            if timeToShoot > 1.9 then
                timeToShoot = 0
            end

            if ui.get(enableSound) then
                ui.set_visible(soundVolume, true)
            else
                ui.set_visible(soundVolume, false)
            end
            
            if timeToShoot == 0 and bPlaySound == true and ui.get(enableSound) then
                client.exec("playvol ui/beep07 " .. ui.get(soundVolume) / 100)
                bPlaySound = false
            end

            renderer.rectangle(Movement.Position.x - 5, Movement.Position.y - 5, 200, 25 + h, 0, 0, 0, 210) --Should use sizes as variables
            renderer.text(Movement.Position.x - 1, Movement.Position.y, r, g, b, a, "", 0, math.floor((timeToShoot * 1000) + 0.5) .. "ms")
            renderer.text(Movement.Position.x + 135, Movement.Position.y, r, g, b, a, "", 0, "Shot Timer")
            renderer.rectangle(Movement.Position.x, Movement.Position.y + 12, timeToShoot * 100, h, r, g, b, a)
			local Min = {x = Movement.Position.x - 5, y = Movement.Position.y - 5}
			local Max = {x = Min.x + 200, y = Min.y + (h + 25)}
            if ui.is_menu_open() then
                local mouseX, mouseY = ui.mouse_position()
				if client.key_state(0x01) then
					if (((mouseX > Min.x and mouseX < Max.x) and (mouseY > Min.y and mouseY < Max.y)) or Movement.CanMoveOutsideOfRect) and (not Movement.ClickedOutsideOfRect)then
						if not Movement.IsMoving then
							Movement.GrabOffset = {x = mouseX - Movement.Position.x, y = mouseY - Movement.Position.y}
							Movement.IsMoving = true
						end
						Movement.CanMoveOutsideOfRect = true
						Movement.Position = {x = mouseX - Movement.GrabOffset.x, y = mouseY - Movement.GrabOffset.y}
					else
						Movement.ClickedOutsideOfRect = true
					end
				else
					Movement.CanMoveOutsideOfRect = false
					Movement.ClickedOutsideOfRect = false
					Movement.IsMoving = false
				end
            end   
        end
    else
        ui.set_visible(hslider, false)
        ui.set_visible(soundVolume, false)
    end
end
client.set_event_callback("paint", on_paint)
client.set_event_callback('shutdown', function ()
	database.write(DataBaseName, Movement.Position)
end)
