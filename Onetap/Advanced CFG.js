/////////////////////////
// written by desc/jo  //
// free to use         //
// no pasterino        //
// for onetap.su/com   //
/////////////////////////

//List of all guns that aren't in a category in RAGEBOT
const shotguns = ["mag 7", "nova", "sawed off", "xm1014"]
const lmgs = ["m249", "negev"]
const smgs = ["mac 10", "mp7", "mp9", "mp5 sd", "pp bizon", "p90", "ump 45"]
const rifles = ["ak 47", "aug", "famas", "galil ar", "m4a1 s", "m4a4", "sg 553"]

//checkboxes
UI.AddLabel("_________________________________________")
UI.AddCheckbox("Enable Advanced CFG");

//vars/arrays
const wpn = "";

//I hardcoded autostop + autoscope so i dont get ppl saying "hitchance isnt coded properly ajskldhalskdh"
UI.SetValue("Rage", "GENERAL", "Accuracy", "Auto stop", true)
UI.SetValue("Rage", "GENERAL", "Accuracy", "Auto stop mode", 2)
UI.SetValue("Rage", "GENERAL", "General", "Auto scope", true)

//prints in chat that the script was loaded
Cheat.PrintChat("Loaded Advanced CFG Script by desc/jo");

//Config sliders/switches
//SMG CFG
UI.AddDropdown("Weapon", ["SMG", "LMG", "RIFLE", "SHOTGUN"]);
UI.AddSliderInt("SMG Hitchance", 0, 100);
UI.AddSliderInt("SMG Min DMG", 0, 100);
//LMG CFG
UI.AddSliderInt("LMG Hitchance", 0, 100);
UI.AddSliderInt("LMG Min DMG", 0, 100);
//Rifle CFG
UI.AddSliderInt("RIFLE Hitchance", 0, 100);
UI.AddSliderInt("RIFLE Min DMG", 0, 100);
//Shotgun CFG
UI.AddSliderInt("SHOTGUN Hitchance", 0, 100);
UI.AddSliderInt("SHOTGUN Min DMG", 0, 100);
UI.AddMultiDropdown("SMG Hitboxes", ["Head", "Upper Chest", "Chest", "Lower Chest", "Stomach", "Pelvis", "Legs", "Feet"]);
UI.AddMultiDropdown("LMG Hitboxes", ["Head", "Upper Chest", "Chest", "Lower Chest", "Stomach", "Pelvis", "Legs", "Feet"]);
UI.AddMultiDropdown("RIFLE Hitboxes", ["Head", "Upper Chest", "Chest", "Lower Chest", "Stomach", "Pelvis", "Legs", "Feet"]);
UI.AddMultiDropdown("SHOTGUN Hitboxes", ["Head", "Upper Chest", "Chest", "Lower Chest", "Stomach", "Pelvis", "Legs", "Feet"]);
UI.AddLabel("_________________________________________")

UI.SetEnabled("Misc", "JAVASCRIPT", "Script items", "SMG Hitchance", false);
UI.SetEnabled("Misc", "JAVASCRIPT", "Script items", "SMG Min DMG", false);
UI.SetEnabled("Misc", "JAVASCRIPT", "Script items", "LMG Hitchance", false);
UI.SetEnabled("Misc", "JAVASCRIPT", "Script items", "LMG Min DMG", false);
UI.SetEnabled("Misc", "JAVASCRIPT", "Script items", "RIFLE Hitchance", false);
UI.SetEnabled("Misc", "JAVASCRIPT", "Script items", "RIFLE Min DMG", false);
UI.SetEnabled("Misc", "JAVASCRIPT", "Script items", "SHOTGUN Hitchance", false);
UI.SetEnabled("Misc", "JAVASCRIPT", "Script items", "SHOTGUN Min DMG", false);
UI.SetEnabled("Misc", "JAVASCRIPT", "Script items", "SMG Hitboxes", false);
UI.SetEnabled("Misc", "JAVASCRIPT", "Script items", "LMG Hitboxes", false);
UI.SetEnabled("Misc", "JAVASCRIPT", "Script items", "RIFLE Hitboxes", false);
UI.SetEnabled("Misc", "JAVASCRIPT", "Script items", "SHOTGUN Hitboxes", false);

function main() {
    if (World.GetServerString() != "") {
        if (UI.GetValue("Misc", "JAVASCRIPT", "Script items", "Enable Advanced CFG")) {

            //Detects what gun we're holding
            const localplayer_index = Entity.GetLocalPlayer();
            const localplayer_weapon = Entity.GetWeapon(localplayer_index);
            const weapon_name = Entity.GetName(localplayer_weapon);
            UI.SetEnabled("Misc", "JAVASCRIPT", "Script items", "Weapon", true);
            
            if(UI.GetValue("Misc", "JAVASCRIPT", "Script items", "Weapon") === 0) {
                UI.SetEnabled("Misc", "JAVASCRIPT", "Script items", "SMG Hitchance", true);
                UI.SetEnabled("Misc", "JAVASCRIPT", "Script items", "SMG Min DMG", true);
                UI.SetEnabled("Misc", "JAVASCRIPT", "Script items", "SMG Hitboxes", true);
            } else {
                UI.SetEnabled("Misc", "JAVASCRIPT", "Script items", "SMG Hitchance", false);
                UI.SetEnabled("Misc", "JAVASCRIPT", "Script items", "SMG Min DMG", false);
                UI.SetEnabled("Misc", "JAVASCRIPT", "Script items", "SMG Hitboxes", false);
            }

            if(UI.GetValue("Misc", "JAVASCRIPT", "Script items", "Weapon") === 1) {
                UI.SetEnabled("Misc", "JAVASCRIPT", "Script items", "LMG Hitchance", true);
                UI.SetEnabled("Misc", "JAVASCRIPT", "Script items", "LMG Min DMG", true);
                UI.SetEnabled("Misc", "JAVASCRIPT", "Script items", "LMG Hitboxes", true);
            } else {
                UI.SetEnabled("Misc", "JAVASCRIPT", "Script items", "LMG Hitchance", false);
                UI.SetEnabled("Misc", "JAVASCRIPT", "Script items", "LMG Min DMG", false);
                UI.SetEnabled("Misc", "JAVASCRIPT", "Script items", "LMG Hitboxes", false);
            }

            if(UI.GetValue("Misc", "JAVASCRIPT", "Script items", "Weapon") === 2) {
                UI.SetEnabled("Misc", "JAVASCRIPT", "Script items", "RIFLE Hitchance", true);
                UI.SetEnabled("Misc", "JAVASCRIPT", "Script items", "RIFLE Min DMG", true);
                UI.SetEnabled("Misc", "JAVASCRIPT", "Script items", "RIFLE Hitboxes", true);
            } else {
                UI.SetEnabled("Misc", "JAVASCRIPT", "Script items", "RIFLE Hitchance", false);
                UI.SetEnabled("Misc", "JAVASCRIPT", "Script items", "RIFLE Min DMG", false);
                UI.SetEnabled("Misc", "JAVASCRIPT", "Script items", "RIFLE Hitboxes", false);
            }

            if(UI.GetValue("Misc", "JAVASCRIPT", "Script items", "Weapon") === 3) {
                UI.SetEnabled("Misc", "JAVASCRIPT", "Script items", "SHOTGUN Hitchance", true);
                UI.SetEnabled("Misc", "JAVASCRIPT", "Script items", "SHOTGUN Min DMG", true);
                UI.SetEnabled("Misc", "JAVASCRIPT", "Script items", "SHOTGUN Hitboxes", true);
            } else {
                UI.SetEnabled("Misc", "JAVASCRIPT", "Script items", "SHOTGUN Hitchance", false);
                UI.SetEnabled("Misc", "JAVASCRIPT", "Script items", "SHOTGUN Min DMG", false);
                UI.SetEnabled("Misc", "JAVASCRIPT", "Script items", "SHOTGUN Hitboxes", false);
            }

            for(i in shotguns) {
                if(weapon_name == shotguns[i]) {
                    UI.SetValue("Rage", "GENERAL", "Accuracy", "Hitchance", UI.GetValue("Script Items", "SHOTGUN Hitchance"));
                    UI.SetValue("Rage", "GENERAL", "Targeting", "Minimum damage", UI.GetValue("Script Items", "SHOTGUN Min DMG"));
                    UI.SetValue("Rage", "GENERAL", "Targeting", "Hitboxes", UI.GetValue("Script Items", "SHOTGUN Hitboxes"));
                }
            }
            for(i in lmgs) {
                if(weapon_name == lmgs[i]) {
                    UI.SetValue("Rage", "GENERAL", "Accuracy", "Hitchance", UI.GetValue("Script Items", "LMG Hitchance"));
                    UI.SetValue("Rage", "GENERAL", "Targeting", "Minimum damage", UI.GetValue("Script Items", "LMG Min DMG"));
                    UI.SetValue("Rage", "GENERAL", "Targeting", "Hitboxes", UI.GetValue("Script Items", "LMG Hitboxes"));
                }
            }
            for(i in smgs) {
                if(weapon_name == smgs[i]) {
                    UI.SetValue("Rage", "GENERAL", "Accuracy", "Hitchance", UI.GetValue("Script Items", "SMG Hitchance"));
                    UI.SetValue("Rage", "GENERAL", "Targeting", "Minimum damage", UI.GetValue("Script Items", "SMG Min DMG"));
                    UI.SetValue("Rage", "GENERAL", "Targeting", "Hitboxes", UI.GetValue("Script Items", "SMG Hitboxes"));
                }
            }
            for(i in rifles) {
                if(weapon_name == rifles[i]) {
                    UI.SetValue("Rage", "GENERAL", "Accuracy", "Hitchance", UI.GetValue("Script Items", "RIFLE Hitchance"));
                    UI.SetValue("Rage", "GENERAL", "Targeting", "Minimum damage", UI.GetValue("Script Items", "RIFLE Min DMG"));
                    UI.SetValue("Rage", "GENERAL", "Targeting", "Hitboxes", UI.GetValue("Script Items", "RIFLE Hitboxes"));
                }
            }
        } else {
            UI.SetEnabled("Misc", "JAVASCRIPT", "Script items", "SMG Hitchance", false);
            UI.SetEnabled("Misc", "JAVASCRIPT", "Script items", "SMG Min DMG", false);
            UI.SetEnabled("Misc", "JAVASCRIPT", "Script items", "LMG Hitchance", false);
            UI.SetEnabled("Misc", "JAVASCRIPT", "Script items", "LMG Min DMG", false);
            UI.SetEnabled("Misc", "JAVASCRIPT", "Script items", "RIFLE Hitchance", false);
            UI.SetEnabled("Misc", "JAVASCRIPT", "Script items", "RIFLE Min DMG", false);
            UI.SetEnabled("Misc", "JAVASCRIPT", "Script items", "SHOTGUN Hitchance", false);
            UI.SetEnabled("Misc", "JAVASCRIPT", "Script items", "SHOTGUN Min DMG", false);
            UI.SetEnabled("Misc", "JAVASCRIPT", "Script items", "SMG Hitboxes", false);
            UI.SetEnabled("Misc", "JAVASCRIPT", "Script items", "LMG Hitboxes", false);
            UI.SetEnabled("Misc", "JAVASCRIPT", "Script items", "RIFLE Hitboxes", false);
            UI.SetEnabled("Misc", "JAVASCRIPT", "Script items", "SHOTGUN Hitboxes", false);
            UI.SetEnabled("Misc", "JAVASCRIPT", "Script items", "Weapon", false);
        }
    };
}

Global.RegisterCallback("Draw", "main")
