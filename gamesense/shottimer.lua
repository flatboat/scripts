-- local variables for API functions. any changes to the line below will be lost on re-generation
local client_exec, client_key_state, client_screen_size, client_set_event_callback, database_read, database_write, entity_get_local_player, entity_get_player_weapon, entity_get_prop, entity_is_alive, globals_curtime, math_floor, renderer_rectangle, renderer_text, ui_get, ui_is_menu_open, ui_mouse_position, ui_new_checkbox, ui_new_color_picker, ui_new_slider, ui_set_visible = client.exec, client.key_state, client.screen_size, client.set_event_callback, database.read, database.write, entity.get_local_player, entity.get_player_weapon, entity.get_prop, entity.is_alive, globals.curtime, math.floor, renderer.rectangle, renderer.text, ui.get, ui.is_menu_open, ui.mouse_position, ui.new_checkbox, ui.new_color_picker, ui.new_slider, ui.set_visible

local ssx, ssy = client_screen_size()
local enableShotTimer = ui_new_checkbox("Visuals", "Other ESP", "Enable Shot Timer")
local enableSound = ui_new_checkbox("Visuals", "Other ESP", "Play Sound When Ready")
local soundVolume = ui_new_slider("Visuals", "Other ESP", "Sound Volume", 0, 100, 50, true, "%")
local colors = ui_new_color_picker("Visuals", "Other ESP", "Shot Timer Color", 138, 255, 169, 255)
local hslider = ui_new_slider("Visuals", "Other ESP", "Shot Timer Line Thickness", 1, 15, 1)
local timeToShoot = 0
local bPlaySound = false

local DataBaseName = "ShotTimerPosition"
if not database_read(DataBaseName) then
	database_write(DataBaseName, {x = 20, y = 600})
end
local Movement = {
	Position = database_read(DataBaseName),
	GrabOffset = {},
	IsMoving = false,
	CanMoveOutsideOfRect = false, --If mouse is off of rect but should still be able to drag
	ClickedOutsideOfRect = false --Prevent movement if has clicked before being on rect
}

ui_set_visible(hslider, false)
ui_set_visible(enableSound, false)
ui_set_visible(soundVolume, false)

--the real code haha lol
local function on_paint()
	if ui_get(enableShotTimer) then
		ui_set_visible(hslider, true)
		ui_set_visible(enableSound, true)
		local local_player = entity_get_local_player()
		local local_player_weapon = entity_get_player_weapon(local_player)

		if entity_is_alive(local_player) then
			local r, g, b, a = ui_get(colors)
			local h = ui_get(hslider)

			local cur = globals_curtime()
			if cur < entity_get_prop(local_player_weapon, "m_flNextPrimaryAttack") then
				timeToShoot = entity_get_prop(local_player_weapon, "m_flNextPrimaryAttack") - cur
				bPlaySound = true
			elseif cur < entity_get_prop(local_player, "m_flNextAttack") then
				timeToShoot = entity_get_prop(local_player, "m_flNextAttack") - cur
				bPlaySound = true
			end

			if math_floor((timeToShoot * 1000) + 0.5) <= 10 then
				timeToShoot = 0
			end

			if timeToShoot > 1.9 then
				timeToShoot = 0
			end

			if ui_get(enableSound) then
				ui_set_visible(soundVolume, true)
			else
				ui_set_visible(soundVolume, false)
			end

			if timeToShoot == 0 and bPlaySound == true and ui_get(enableSound) then
				client_exec("playvol ui/beep07 " .. ui_get(soundVolume) / 100)
				bPlaySound = false
			end

			renderer_rectangle(Movement.Position.x - 5, Movement.Position.y - 5, 200, 25 + h, 0, 0, 0, 210) --Should use sizes as variables
			renderer_text(
			Movement.Position.x - 1,
			Movement.Position.y,
			r,
			g,
			b,
			a,
			"",
			0,
			math_floor((timeToShoot * 1000) + 0.5) .. "ms"
			)
			renderer_text(Movement.Position.x + 135, Movement.Position.y, r, g, b, a, "", 0, "Shot Timer")
			renderer_rectangle(Movement.Position.x, Movement.Position.y + 12, timeToShoot * 100, h, r, g, b, a)
			local Min = {x = Movement.Position.x - 5, y = Movement.Position.y - 5}
			local Max = {x = Min.x + 200, y = Min.y + (h + 25)}
			if ui_is_menu_open() then
				local mouseX, mouseY = ui_mouse_position()
				if client_key_state(0x01) then
					if
					(((mouseX > Min.x and mouseX < Max.x) and (mouseY > Min.y and mouseY < Max.y)) or
					Movement.CanMoveOutsideOfRect) and
					(not Movement.ClickedOutsideOfRect)
					then
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
		ui_set_visible(hslider, false)
		ui_set_visible(soundVolume, false)
	end
end
client_set_event_callback("paint", on_paint)
client_set_event_callback("shutdown", function() database_write(DataBaseName, Movement.Position)end)
