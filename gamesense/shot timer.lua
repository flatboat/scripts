-- local variables for API functions. any changes to the line below will be lost on re-generation
local client_exec, client_key_state, client_screen_size, client_set_event_callback, database_read, database_write, entity_get_local_player, entity_get_player_weapon, entity_get_prop, entity_is_alive, globals_curtime, math_floor, renderer_rectangle, renderer_text, ui_get, ui_is_menu_open, ui_mouse_position, ui_new_checkbox, ui_new_color_picker, ui_new_combobox, ui_new_hotkey, ui_new_label, ui_new_multiselect, ui_new_slider, ui_reference, ui_set, ui_set_callback, ui_set_visible = client.exec, client.key_state, client.screen_size, client.set_event_callback, database.read, database.write, entity.get_local_player, entity.get_player_weapon, entity.get_prop, entity.is_alive, globals.curtime, math.floor, renderer.rectangle, renderer.text, ui.get, ui.is_menu_open, ui.mouse_position, ui.new_checkbox, ui.new_color_picker, ui.new_combobox, ui.new_hotkey, ui.new_label, ui.new_multiselect, ui.new_slider, ui.reference, ui.set, ui.set_callback, ui.set_visible

--references
local rFLag = ui_reference("AA", "Fake lag", "Limit")
local rFStanding = { ui_reference("AA", "Anti-aimbot angles", "Freestanding") }
local rMaxUsrCmdProcessTicks = ui_reference("MISC", "Settings", "sv_maxusrcmdprocessticks")
local rVariance = ui_reference("AA", "Fake lag", "Variance")
local rMainEnable = ui_reference("AA", "Fake lag", "Enabled")
local rQuickPeek = { ui_reference("RAGE", "Other", "Quick peek assist") }
local rAmount = ui_reference("AA", "Fake lag", "Amount")
local rFLEnabled = ui_reference("AA", "Fake lag", "Enabled")
local rDTHotkey = { ui_reference("RAGE", "Other", "Double tap") }
local rPingSpike = { ui_reference("MISC", "Miscellaneous", "Ping spike") }

--variables/new menu items
local nEnableDesolateTick = ui_new_checkbox("AA", "Fake lag", "Enable desolate tick")
local nText = ui_new_label("AA", "Fake lag", "------------Desolate Tick------------")
local nTextDescription = ui_new_label("AA", "Fake lag", "Recommended settings for limit:")
local nTextDescription2 = ui_new_label("AA", "Fake lag", "1 tick trigger limit, max normal limit,")
local nTextDescription3 = ui_new_label("AA", "Fake lag", "15% variance, and fluctuate amount")
local nMainKey = ui_new_hotkey("AA", "Fake lag", "Desolate tick")
local nVariance = ui_new_slider("AA", "Fake lag", "Variance", 0, 100, 0, true, "%")
local nnFLag = ui_new_slider("AA", "Fake lag", "Normal Limit", 1, 15, 1, true)
local ntFLag = ui_new_slider("AA", "Fake lag", "Trigger Limit", 1, 5, 1, true)
local nAmount = ui_new_combobox("AA", "Fake lag", "Fake lag amount", "Dynamic", "Maximum", "Fluctuate")
local nFeatureCombo = ui_new_multiselect("AA", "Fake lag", "Features", "indicators", "freestand", "quickpeek", "high tickbase", "ping spike")
local nDesolateColor = ui_new_color_picker("AA", "Fake lag", "Indicator color", 255, 0, 0, 255)
local ssx, ssy = client_screen_size()
local nDTHotkey = ui_new_combobox("AA", "Fake lag", "Doubletap hotkey mode", "On hotkey", "Toggle", "Off hotkey")
local nPingSpikeAmt = ui_new_slider("AA", "Fake lag", "Ping spike amount", 1, 100, 0, true, "ms")

--functions
--stole this from teamskeet v4, didnt feel like writing one myself (plus it looks like one I found on stackoverflow lol)
local function contains(table, value)

	if table == nil then
		return false
	end

	table = ui_get(table)
	for i=0, #table do
		if table[i] == value then
			return true
		end
	end
	return false
end

--client.log("Fakelag is set to: " .. ui_get(rFLag));
local function handle_desolate()
	local r, g, b, a = ui_get(nDesolateColor)
	--main switch
	if ui_get(nEnableDesolateTick) then

		--if hotkey is pressed do shit
		if ui_get(nMainKey) then
			ui_set(rDTHotkey[2], "Always on")
			ui_set(rFLag, ui_get(ntFLag))
		else
			ui_set(rDTHotkey[2], ui_get(nDTHotkey))
			ui_set(rFLag, ui_get(nnFLag))
		end

		if ui_get(nMainKey) and contains(nFeatureCombo, "freestand") then
			ui_set(rFStanding[1], "Default")
			ui_set(rFStanding[2], "Always on")
		else
			ui_set(rFStanding[1], "")
			ui_set(rFStanding[2], "On hotkey")
		end

		if ui_get(nMainKey) and contains(nFeatureCombo, "quickpeek") then
			ui_set(rQuickPeek[1], true)
			ui_set(rQuickPeek[2], "Always on")
		else
			ui_set(rQuickPeek[2], "On hotkey")
		end

		if ui_get(nMainKey) and contains(nFeatureCombo, "high tickbase") then
			ui_set(rMaxUsrCmdProcessTicks, 19)
		end

		if contains(nFeatureCombo, "indicators") then
			if ui_get(nMainKey) then
				renderer_text(ssx / 2, ssy / 2 + 120, 149, 184, 6, a, "c", 0, "✓ desolate tick ✓")
			else
				renderer_text(ssx / 2, ssy / 2 + 120, r, g, b, a, "c", 0, "✗ desolate tick ✗")
			end
		end

		if contains(nFeatureCombo, "ping spike") then
			ui_set_visible(nPingSpikeAmt, true)
		else
			ui_set_visible(nPingSpikeAmt, false)
		end

		if ui_get(nMainKey) and contains(nFeatureCombo, "ping spike") then
			ui_set(rPingSpike[1], true)
			ui_set(rPingSpike[2], "Always on")
			ui_set(rPingSpike[3], ui_get(nPingSpikeAmt))
		else
			ui_set(rPingSpike[1], false)
			ui_set(rPingSpike[2], "On hotkey")
		end

		ui_set(rAmount, ui_get(nAmount))

		ui_set(rVariance, ui_get(nVariance))
	else
		ui_set_visible(rFLag, true)
		ui_set_visible(rVariance, true)
		ui_set_visible(rAmount, true)
		ui_set_visible(rFLEnabled, true)
		ui_set_visible(nMainKey, false)
		ui_set_visible(nVariance, false)
		ui_set_visible(nnFLag, false)
		ui_set_visible(ntFLag, false)
		ui_set_visible(nFeatureCombo, false)
		ui_set_visible(nText, false)
		ui_set_visible(nTextDescription, false)
		ui_set_visible(nTextDescription2, false)
		ui_set_visible(nTextDescription3, false)
		ui_set_visible(nAmount, false)
		ui_set_visible(nDTHotkey, false)
		ui_set_visible(nPingSpikeAmt, false)
	end
end

--callbacks
client_set_event_callback("paint", handle_desolate)

ui_set_callback(nEnableDesolateTick, function()
ui_set_visible(rFLEnabled, false)
ui_set_visible(rFLag, false)
ui_set_visible(rVariance, false)
ui_set_visible(rAmount, false)
ui_set_visible(nMainKey, true)
ui_set_visible(nVariance, true)
ui_set_visible(nnFLag, true)
ui_set_visible(ntFLag, true)
ui_set_visible(nFeatureCombo, true)
ui_set_visible(nText, true)
ui_set_visible(nTextDescription, true)
ui_set_visible(nTextDescription2, true)
ui_set_visible(nTextDescription3, true)
ui_set_visible(nAmount, true)
ui_set_visible(nDTHotkey, true)
ui_set_visible(nPingSpikeAmt, true)
end)

client_set_event_callback("shutdown", function()
ui_set_visible(rFLag, true)
ui_set_visible(rVariance, true)
ui_set_visible(rAmount, true)
ui_set_visible(rFLEnabled, true)
end)local ssx, ssy = client_screen_size()
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
