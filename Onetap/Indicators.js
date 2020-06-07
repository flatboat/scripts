/////////////////////////
// written by desc/jo  //
// free to use         //
// no pasterino        //
// for onetap.su/com   //
/////////////////////////

Cheat.PrintChat("Loaded Indicator script by desc/jo")

UI.AddLabel("_________________________________________")
UI.AddHotkey("Left Manual AA")
UI.AddHotkey("Back Manual AA")
UI.AddHotkey("Right Manual AA")
UI.AddColorPicker("Anti-Aim Arrows Color")
UI.AddSliderInt("Anti-Aim Arrow Scale", 0, 10)
UI.AddSliderInt("Anti-Aim Arrow Distance", 0, 100)
UI.AddLabel("_________________________________________")

ss = Render.GetScreenSize();

var localPlayer = Entity.GetLocalPlayer();

var target = "NONE";
function targetID(){
    target = Ragebot.GetTarget()
}

function main(){
    if (World.GetServerString() != "") { 
        if(!Entity.IsAlive(localPlayer)) {return;}
        var tgt = Entity.GetName(target)
        if (target === 0) {tgt = "NONE"}
        font = Render.AddFont("Arial Black", 15, 100);
        Render.StringCustom(10, ss[1] - 400, 0, "TARGET: " + tgt.toUpperCase(), [ 255, 64, 0, 255 ], font );

        if (UI.IsHotkeyActive("Rage", "GENERAL", "Exploits", "Doubletap")) {
            Render.StringCustom(10, ss[1] - 420, 0, "DT", [ 51, 204, 51, 255 ], font );
        } else {
            Render.StringCustom(10, ss[1] - 420, 0, "DT", [ 255, 64, 0, 255 ], font );
        }

        if (UI.IsHotkeyActive("Rage", "GENERAL", "Exploits", "Hide shots")) {
            Render.StringCustom(10, ss[1] - 440, 0, "HIDE", [ 51, 204, 51, 255 ], font );
        } else {
            Render.StringCustom(10, ss[1] - 440, 0, "HIDE", [ 255, 64, 0, 255 ], font );
        }

        if (UI.IsHotkeyActive("Anti-Aim", "Extra", "Fake duck")) {
            Render.StringCustom(10, ss[1] - 480, 0, "FD", [ 51, 204, 51, 255 ], font );
        } else {
            Render.StringCustom(10, ss[1] - 480, 0, "FD", [ 255, 64, 0, 255 ], font );
        }

        aatype = (UI.GetValue("Anti-Aim", "Fake angles", "LBY mode"))
        if (aatype === 0) {
            Render.StringCustom(10, ss[1] - 500, 0, "NORMAL", [ 51, 204, 51, 255 ], font );
        } else if (aatype === 1) {
            Render.StringCustom(10, ss[1] - 500, 0, "OPPOSITE", [ 51, 204, 51, 255 ], font );
        } else if (aatype === 2) {
            Render.StringCustom(10, ss[1] - 500, 0, "SWAY", [ 51, 204, 51, 255 ], font );
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

        var aadist = UI.GetValue("Misc", "JAVASCRIPT", "Script items", "Anti-Aim Arrow Distance")
        var aascale = UI.GetValue("Misc", "JAVASCRIPT", "Script items", "Anti-Aim Arrow Scale")
        var aaincolor = UI.GetColor("Misc", "JAVASCRIPT", "Script items", "Anti-Aim Arrows Color")
        if (UI.GetValue("Anti-Aim", "Rage Anti-Aim", "Yaw offset") === -90) {
            Render.StringCustom(10, ss[1] - 460, 0, "LEFT", [ 51, 204, 51, 255 ], font );
            Render.Polygon([[ss[0]/2 - 50 + aascale - aadist, ss[1]/2 - 5 - aascale], [ss[0]/2 - 50 + aascale - aadist, ss[1]/2 + 5 + aascale], [ss[0]/2 - 60  - aascale - aadist, ss[1]/2]], [aaincolor[0], aaincolor[1], aaincolor[2], 255]);
        } else if (UI.GetValue("Anti-Aim", "Rage Anti-Aim", "Yaw offset") === 0) {
            Render.StringCustom(10, ss[1] - 460, 0, "BACK", [ 51, 204, 51, 255 ], font );
            Render.Polygon([[ss[0]/2 - 5 - aascale, ss[1]/2 + 50 - aascale + aadist], [ss[0]/2 + 5 + aascale, ss[1]/2 + 50 - aascale + aadist], [ss[0]/2, ss[1]/2 + 60 + aascale + aadist]], [aaincolor[0], aaincolor[1], aaincolor[2], 255]); 
        } else if (UI.GetValue("Anti-Aim", "Rage Anti-Aim", "Yaw offset") === 90) {
            Render.StringCustom(10, ss[1] - 460, 0, "RIGHT", [ 51, 204, 51, 255 ], font );
            Render.Polygon([[ss[0]/2 + 50 - aascale + aadist, ss[1]/2 + 5 + aascale], [ss[0]/2 + 50 - aascale + aadist, ss[1]/2 - 5 - aascale], [ss[0]/2 + 60 + aascale + aadist, ss[1]/2]], [aaincolor[0], aaincolor[1], aaincolor[2], 255]); 
        } 
    }
}

Cheat.RegisterCallback("CreateMove", "targetID")
Cheat.RegisterCallback("Draw", "main")
