## v3.73

- Fixed achievements not saving due to a regression.

## v3.72

- New 'OVERPOWER' setting: Allow "Strength" and "Superior Armor" skills to increase maximum health/armor.
- OverPower setting can be enabled/disabled globally by changing just one line of code.
- Fixed skills info displaying "Team Power" in Spanish.

## v3.70

- Updated save system, again. MAKE A BACKUP OF YOUR DATA BEFORE UPGRADING.
- Code cleaning. Seriously, it looked awful on some places.
- Added 15 new achievements, and made some easier to get.
- Changed multiplier time from real time to game time.
- Removed "classes", these were purely cosmetic and had no effect in-game.
- New 'NO_ANTIGRAV' setting: Disable the anti-gravity skill on this map.
- New 'ENABLE_FF' setting: Globally enable Friendly Fire on this map. Server operators can override this via 'mp_friendlyfire' CVar. 0 to use map setting, 1 to force ON, -1 to force OFF.
- New 'NO_HANDICAPS' setting: Disallow handicaps when skills are enabled.
- New 'HIDE_HUD' setting: SCXPM HUD will start disabled.
- The '/spectate' command can now be used even if SCXPM is disabled via settings. Use 'DISABLED|NO_SPECTATE' to disable this.
- Admins can now use the '/spectate' command even if the map disallows it.
- Players who reach "Champion" status can now gift levels, medals or multiplier to other players, regardless of status.
- Players no longer lose their daily rewards if they stop playing.
- Added new daily rewards
- Nerfed XP Modifiers.
- Added new XP Modifiers.
- Changed max medal limit from '9999' to '175'.
- Players can now choose whenever to automatically open the skill menu upon level or not. Set it with '/hudsettings', located in 'Show/Hide Visuals'.
- New "Health Crisis" handicap.
- Massively boosted the XP increase from handicaps.
- Players who reach "Champion" status can now convert their medals back to XP.
- Achievements can now be enabled/disabled globally by changing just one line of code.
- The special skill 'Demoman' no longer requires an M16 deployed. As long as the player has said weapon in its inventory, it will regenerate grenades.
- Deaths caused by friendly fire will now count as a death in the scoreboard.
- New 'scxpm_toggle_ff' entity: Allows server operators and mappers to enable/disable friendly fire on the fly.
- New 'scxpm_change_xpgain' entity: Allows server operators and mappers to change map XPGain on the fly.
- New 'scxpm_change_skills' entity: Allows server operators and mappers to change SCXPM behaviour on the fly.
- Server operators and mappers can now force handicaps upon players via 'trigger_changevalue' entity.
- Removed the 'event' folder. External maps/plugins can now communicate with SCXPM via custom keyvalues.
- Added plenty of missing documentation to the wiki.
- Probably other stuff I forgot. Hopefully I didn't break anything? :C

## v3.21

- Fixed SCXPM say commands overriding pParams.ShouldHide to other plugins.

## v3.20

- Updated save system.

Older SCXPM changelogs are kind of forgotten...
