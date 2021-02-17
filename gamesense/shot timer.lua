local ssx, ssy = client.screen_size()
local enableShotTimer = ui.new_checkbox("Visuals", "Other ESP", "Enable Shot Timer")
local colors = ui.new_color_picker("Visuals", "Other ESP", "Shot Timer Color", 138, 255, 169, 255)
--local xslider = ui.new_slider("Visuals", "Other ESP", "Shot Timer Indicator X", 0, ssx, 20)
--local yslider = ui.new_slider("Visuals", "Other ESP", "Shot Timer Indicator Y", 0, ssy, 600)
local hslider = ui.new_slider("Visuals", "Other ESP", "Shot Timer Line Thickness", 1, 15, 1)
local timeToShoot = 0
--ui.set_visible(xslider, false)
--ui.set_visible(yslider, false)
local x = 20
local y = 600

--the real code haha lol
local function on_paint()
    if ui.get(enableShotTimer) then
        ui.set_visible(hslider, true)
        local local_player = entity.get_local_player()
        local local_player_weapon = entity.get_player_weapon(local_player)

        if entity.is_alive(local_player) then
            --local x = ui.get(xslider)
            --local y = ui.get(yslider)
            local r, g, b, a = ui.get(colors)
            local h = ui.get(hslider)
            
            
            local cur = globals.curtime()
            if cur < entity.get_prop(local_player_weapon, "m_flNextPrimaryAttack") then
                timeToShoot = entity.get_prop(local_player_weapon, "m_flNextPrimaryAttack") - cur
            elseif cur < entity.get_prop(local_player, "m_flNextAttack") then
                timeToShoot = entity.get_prop(local_player, "m_flNextAttack") - cur
            end

            if math.floor((timeToShoot * 1000) + 0.5) <= 10 then
                timeToShoot = 0
            end

            if timeToShoot > 1.9 then
                timeToShoot = 0
            end
            
            renderer.rectangle(x - 5, y - 5, 200, 25 + h, 0, 0, 0, 210)
            renderer.text(x - 1, y, r, g, b, a, "", 0, math.floor((timeToShoot * 1000) + 0.5) .. "ms")
            renderer.text(x + 135, y, r, g, b, a, "", 0, "Shot Timer")
            renderer.rectangle(x, y + 12, timeToShoot * 100, h, r, g, b, a)
            
            if ui.is_menu_open() then
                local mouseX, mouseY = ui.mouse_position()
                if mouseX >= x and mouseX <= x + 205 and mouseY >= y and mouseY <= y + 25 + h and client.key_state(0x01) then
                    --print("mouse is being pressed: " .. mouseX .. ',' .. mouseY)
                    x = mouseX - 100
                    y = mouseY - 10
                end
            end   

        end
    else
        ui.set_visible(hslider, false)
    end
end

client.set_event_callback("paint", on_paint)
