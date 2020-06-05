/////////////////////////
// written by desc/jo  //
// free to use         //
// no pasterino        //
// for onetap.su/com   //
/////////////////////////

//Just saying that the script is loaded.
Global.PrintChat("Loaded Hitbox(es) on key script by desc/jo")

//Storing User's Chosen Hitboxes.
autoHitboxes = (UI.GetValue("Rage", "AUTOSNIPER", "Hitboxes"))
awpHitboxes = (UI.GetValue("Rage", "AWP", "Hitboxes"))
scoutHitboxes = (UI.GetValue("Rage", "SCOUT", "Hitboxes"))
hvypistolHitboxes = (UI.GetValue("Rage", "HEAVY PISTOL", "Hitboxes"))
pistolHitboxes = (UI.GetValue("Rage", "PISTOL", "Hitboxes"))
generalHitboxes = (UI.GetValue("Rage", "GENERAL", "Hitboxes"))

//Checkboxes, Hotkeys, and Dropdowns.
UI.AddLabel("_________________________________________")
UI.AddCheckbox("Enable Force Hitbox On Key")
UI.AddHotkey("Head On Key")
UI.AddHotkey("Body On Key")
UI.AddMultiDropdown("Body Hitboxes", ["IGNORE ME, HEAD", "Upper Chest", "Chest", "Lower Chest", "Stomach", "Pelvis", "Legs", "Feet"]);
UI.AddLabel("_________________________________________")

//Runs every frame, main function.
function main() {
    if (World.GetServerString() != "") { 
        if (UI.GetValue("Misc", "JAVASCRIPT", "Script items", "Enable Force Hitbox On Key")) {
            
            //Declaring what each hotkey does/is linked to.
            var forceHeadOnly = UI.IsHotkeyActive("Misc", "JAVASCRIPT", "Script items", "Head On Key")
            var forceBodyOnly = UI.IsHotkeyActive("Misc", "JAVASCRIPT", "Script items", "Body On Key")

            //Declaring what the body hitboxes are via dropdown.
            bodyHitboxes = (UI.GetValue("Misc", "JAVASCRIPT", "Script items", "Body Hitboxes"));
            
            //Detecting if the hotkeys are pressed, if not make a small indicator in the bottom left corner.
            if (forceHeadOnly) {
                font = Render.AddFont("Arial Black", 15, 100);
                Render.StringCustom(10, 1000, 0, "HEAD", [ 51, 204, 51, 255 ], font );
                UI.SetValue("Rage", "AUTOSNIPER", "Targeting", "Hitboxes", 1)
                UI.SetValue("Rage", "AWP", "Hitboxes", 1)
                UI.SetValue("Rage", "SCOUT", "Hitboxes", 1)
                UI.SetValue("Rage", "HEAVY PISTOL", "Hitboxes", 1)
                UI.SetValue("Rage", "PISTOL", "Hitboxes", 1)
                UI.SetValue("Rage", "GENERAL", "Hitboxes", 1)
            } else if (forceBodyOnly) {
                font = Render.AddFont("Arial Black", 15, 100);
                Render.StringCustom(10, 1000, 0, "BODY", [ 51, 204, 51, 255 ], font );
                UI.SetValue("Rage", "AUTOSNIPER", "Targeting", "Hitboxes", bodyHitboxes)
                UI.SetValue("Rage", "AWP", "Hitboxes", bodyHitboxes)
                UI.SetValue("Rage", "SCOUT", "Hitboxes", bodyHitboxes)
                UI.SetValue("Rage", "HEAVY PISTOL", "Hitboxes", bodyHitboxes)
                UI.SetValue("Rage", "PISTOL", "Hitboxes", bodyHitboxes)
                UI.SetValue("Rage", "GENERAL", "Hitboxes", bodyHitboxes)
            } else {
                font = Render.AddFont("Arial Black", 15, 100);
                Render.StringCustom(10, 1000, 0, "NORMAL", [ 255, 64, 0, 255 ], font );
                UI.SetValue("Rage", "AUTOSNIPER", "Hitboxes", autoHitboxes)
                UI.SetValue("Rage", "AWP", "Hitboxes", awpHitboxes)
                UI.SetValue("Rage", "SCOUT", "Hitboxes", scoutHitboxes)
                UI.SetValue("Rage", "HEAVY PISTOL", "Hitboxes", hvypistolHitboxes)
                UI.SetValue("Rage", "PISTOL", "Hitboxes", pistolHitboxes)
                UI.SetValue("Rage", "GENERAL", "Hitboxes", generalHitboxes)
            }
        }
    }
}

Global.RegisterCallback("Draw", "main");