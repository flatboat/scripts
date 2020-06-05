/////////////////////////
// written by desc/jo  //
// free to use         //
// no pasterino        //
// for onetap.su/com   //
/////////////////////////

Global.PrintChat("Loaded Indicator script by desc/jo")

UI.AddLabel("_________________________________________")
UI.AddHotkey("Left Manual AA")
UI.AddHotkey("Back Manual AA")
UI.AddHotkey("Right Manual AA")
UI.AddColorPicker("Anti-Aim Arrows Color")
UI.AddSliderInt("Anti-Aim Arrow Scale", 0, 100)
UI.AddLabel("_________________________________________")

ss = Render.GetScreenSize();

var currentAA;

var target = "NONE";
function targetID(){
    target = Ragebot.GetTarget()
}
function main(){
    if (World.GetServerString() != "") { 
        var tgt = Entity.GetName(target)
        if (target === 0) {tgt = "NONE"}
        font = Render.AddFont("Arial Black", 15, 100);
        Render.StringCustom(10, ss[1] - 100, 0, "TARGET: " + tgt, [ 255, 64, 0, 255 ], font );

        if (UI.IsHotkeyActive("Rage", "GENERAL", "Exploits", "Doubletap")) {
            Render.StringCustom(10, ss[1] - 120, 0, "DT", [ 51, 204, 51, 255 ], font );
        } else {
            Render.StringCustom(10, ss[1] - 120, 0, "DT", [ 255, 64, 0, 255 ], font );
        }

        if (UI.IsHotkeyActive("Rage", "GENERAL", "Exploits", "Hide shots")) {
            Render.StringCustom(10, ss[1] - 140, 0, "HIDE", [ 51, 204, 51, 255 ], font );
        } else {
            Render.StringCustom(10, ss[1] - 140, 0, "HIDE", [ 255, 64, 0, 255 ], font );
        }

        if (UI.IsHotkeyActive("Misc", "JAVASCRIPT", "Script items", "Left Manual AA")) {
            UI.SetValue("Anti-Aim", "Rage Anti-Aim", "Yaw offset", -90)
            //Render.StringCustom(10, ss[1] - 160, 0, "LEFT", [ 51, 204, 51, 255 ], font );
        } else if (UI.IsHotkeyActive("Misc", "JAVASCRIPT", "Script items", "Back Manual AA")) {
            UI.SetValue("Anti-Aim", "Rage Anti-Aim", "Yaw offset", 0)
            //Render.StringCustom(10, ss[1] - 160, 0, "BACK", [ 51, 204, 51, 255 ], font );
        } else if (UI.IsHotkeyActive("Misc", "JAVASCRIPT", "Script items", "Right Manual AA")) {
            UI.SetValue("Anti-Aim", "Rage Anti-Aim", "Yaw offset", 90)
            //Render.StringCustom(10, ss[1] - 160, 0, "RIGHT", [ 51, 204, 51, 255 ], font );
        }

        var aascale = UI.GetValue("Misc", "JAVASCRIPT", "Script items", "Anti-Aim Arrow Scale")
        var aaincolor = UI.GetColor("Misc", "JAVASCRIPT", "Script items", "Anti-Aim Arrows Color")
        if (UI.GetValue("Anti-Aim", "Rage Anti-Aim", "Yaw offset") === -90) {
            Render.StringCustom(10, ss[1] - 160, 0, "LEFT", [ 51, 204, 51, 255 ], font );
            Render.Polygon([[910 + aascale, 535 - aascale], [910 + aascale, 545 + aascale], [900 - aascale, 540]], [aaincolor[0], aaincolor[1], aaincolor[2], 255]);
        } else if (UI.GetValue("Anti-Aim", "Rage Anti-Aim", "Yaw offset") === 0) {
            Render.StringCustom(10, ss[1] - 160, 0, "BACK", [ 51, 204, 51, 255 ], font );
            Render.Polygon([[955 - aascale, 590 - aascale], [965 + aascale, 590.0 - aascale], [960, 600 + aascale]], [aaincolor[0], aaincolor[1], aaincolor[2], 255]); 
        } else if (UI.GetValue("Anti-Aim", "Rage Anti-Aim", "Yaw offset") === 90) {
            Render.StringCustom(10, ss[1] - 160, 0, "RIGHT", [ 51, 204, 51, 255 ], font );
            Render.Polygon([[1010 - aascale, 545 + aascale], [1010 - aascale, 535 - aascale], [1020 + aascale, 540]], [aaincolor[0], aaincolor[1], aaincolor[2], 255]); 
        } 
    }
}

Cheat.RegisterCallback("CreateMove", "targetID")
Cheat.RegisterCallback("Draw", "main")