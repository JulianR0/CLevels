## v5.00

- Refactored most code, hopefully it does no longer sucks ass.
- Made most SCXPM mechanics easier to customize for server operators.
- Fixed Superior Armor skill allowing players to resurrect each other constantly for infinite armor.
- Fixed XP calcuations displaying the (in)famous "0 XP left for next level".
- Fixed some glitches that allowed a player to gain more skillpoints than usual. 
- Fixed Starting Attack not working on some monsters, or not dealing any damage.
- Fixed "Limited Equipment" handicap not removing all weapons.
- Fixed rare scenarios of forced handicaps not working correctly.
- Fixed limited respawns requiring the player to explicity respawn to be moved to observer mode, if no more respawns were available.
- Fixed math not mathing from XP multipliers. Seriously, those things were increasing XP gain by up to 5000%!
- Fixed simulated levels being able to yield XP Mods to players.
- Slighly increased the hitbox of the medkit dart. This should make long range healing a little less annoying.
- Made "Quick Heal" special skill more powerful.
- Made "Red Cross" special skill more powerful.
- Random ammo regeneration will no longer pick 9mm or 556 ammo on a frequent basis.
- Ammo regeneration now works with custom weapons.
- The "Realism" handicap will no longer hide the weapon HUD, should make changing weapons much easier.
- Changed random ammo regeneration of 9mm and 556 bullets.
- Long range healing done with "Medical Emergency" will now yield score to players.
- New players will now see on their HUD a message when they have unassigned skillpoints, this notification can be turned off on the settings menu.
- Players no longer lose their daily streak while offline. They will simply have to wait an extra 24 hours to redeem the next daily reward again.
- However, players that display 7 or more days of complete inactivity, will have their daily rewards reset to 0.
- Changed daily rewards, these will now repeat after some time, giving new life to medals/multipliers rewards.
- It is now possible to reset and gain more than 9 medals, by simply gathering more levels. The reset menu was updated.
- Added some coloring to most menus.
- The reward of all achievements is now visible on the menu.
- New "Legacy Achievements" - These are former v4 achievements that has been removed in this new release, and are only visible for players that managed to unlock it before this update.
- New "Hidden Achievements" - These achievements do not appear in the achievement menu until unlocked, making their objetive a secret. They contain much juicier rewards.
- New achievements has been added.
- Upon reaching 30 medals, 1 additional specialpoint can be adquired for every 10 extra medals, up to a maximum of 45 specialpoints.
- New `/resethandicaps` chat command to turn off all handicaps, without the need of doing so manually one by one on the menu.
- New `/autohandicaps` to automatically enable all required handicaps on a map that contains an achievement.
- Handicaps can now be turned on/off at any moment. It will still be a requirement to have them enabled on map start to unlock any achievement that relies of them.
- Golden Hammers can now be used to skip daily rewards by either +1 or +10 days.
- It is no longer necessary to reach Champion status to be able to gift levels/medals/multipliers to other players.
- Gifting levels and/or medals will now reset the owner's skills, but only if said player did not reach Champion status yet.
- Running out of respawns in maps with LIMITED_RESPAWN will now automatically move the player to Observer Mode.
- Maps with LIMITED_RESPAWN without a game_sparksout named entity will now inmediately end after 10 seconds, if all players lose all their respawns.
- Restored Friendly Fire, but only as a map config and with a twist: It is now MIRRORED friendly fire - All damages done to other players will be reflected back to the aggresor. Try it with the ENABLE_FF config.
- New internal SCXPM entity `scxpm_hide_hud` - Globally disables/reenables the SCXPM HUD.
- Auxiliary AMXX plugin no longer requires "HamSandwich" module - the old **hamdata.ini** file is now deprecated and should not be used.
- This changelog is so big it's likely I'm forgetting something :C

## v4.xx

- Check the "v4" branch for older changelogs.
