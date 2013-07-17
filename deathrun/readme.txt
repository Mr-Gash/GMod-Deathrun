Hey! You've downloaded a deathrun gamemode, good job being able to click the download button.

I made this gamemode because I felt bad people were using my old shitty one that I released. That gamemode was just to help me learn more about Lua, and is just awful. I apologize to all of those that have used it.

Installation:

Drop the "deathrun" folder inside /Server/orangebox/garrysmod/gamemodes/

Inside your server.cfg file, add:
gamemode "deathrun"

This !does not! have any weapons by default. If you want to have weapons, download a weapon pack and name them that of the CS:S weapons. For example, if you have a weapon_real_cs_ak47, rename it to weapon_ak47 to be used. The gamemode does NOT spawn the weapons automatically, the map does!
If you don't want to do this, you can of course have the gamemode spawn the weapons, but this means you will have to place them all manually. To do this, join the map you want to place weapons on. 
Look to where you want it to spawn, and type in your console "dr_add_weapon weapon_name" - you MUST be a superadmin to do this. To save the weapon, look at it and type "dr_save_weapon" in your console.

Don't forget to download some maps you can play! There are a lot you can find just by doing a Google search. Deathrun maps start with either "deathrun_" or "dr_"

ConVars:

dr_roundtime_seconds (default: 360)
Will set the round length, in seconds.

dr_highlight_admins (default: 1)
If set to 1, admins will be highlighted gold on the scoreboard and also have a shield icon.

dr_total_rounds (default: 10)
The amount of rounds to play before a map change.

dr_allow_death_suicide (default: 0)
If set to 1, "Deaths" will be able to kill themselves with the use of the "kill" command. If set to 0, nothing will happen with use of the command.

dr_allow_autojump (default: 1)
If set to 0, players will not autojump by holding down their spacebar (regardless if they have it enabled/disabled). I don't recommend disabling this.

dr_unlimited_ammo (default: 1)
If set to 1, primary ammo will not be taken when players shoot weapons. This won't work with default HL2 weapons.

dr_allow_death_pickup (default: 0)
If set to 0, players on the Death team will be unable to pick up any weapons aside from the crowbar.

dr_realistic_fall_damage (default: 1)
If set to 1, players will be damaged based on the speed at which they fall. If set to 0, the fall damage will be 10, regardless of speed or height.

dr_notify_rounds_left (default: 1)
Notify everyone on the server how many rounds are left as the prep phase begins.

dr_push_collide (default: 0)
If set to 1, when one player enters another, they will be pushed apart.

dr_death_rate (default: 0.25, minimum: 0.1, max: 0.9)
Percentage of total players that will become a death. The player amount is multiplied by this number, then rounded down.

dr_death_max (default: 6, minimum: 2 )
The maximum amount of deaths.

Hooks:

GetScoreboardNameColor (player)
Clientside
Called to get the color of a player on the scoreboard. Return a color to change it for this player. If you don't return anything, it will default to Color(255, 255, 255, 255) (white).

GetScoreboardIcon (player)
Clientside
Called to get an icon to show on the scoreboard- must be a png. Admins by defualt have the "icon16/shield.png" icon. Return a string to use that icon, return false to not use an icon (default).

OnRoundSet (round[, winner])
Serverside
Called when the round is set. It can be set to ROUND_... WAITING, PREPARING, ACTIVE, ENDING
If it is called with ROUND_ENDING, the second argument will be the winner of the round.

ChangePlayerModel (player)
Serverside
Return a string to have a player set to that model. Return false to have it set to one of the default models.

If you want help with the hooks, view hook_examples.lua in the same folder this file is in!

To change the text in the F1 menu, edit menutext.lua
Also, I apologize for the terrible logo/icon. I know that I'm bad at design work.

My Steam: http://steamcommunity.com/id/mrgash2
