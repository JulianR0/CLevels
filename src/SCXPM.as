/*
	Giegue's SCXPM: Main Script
	Copyright (C) 2019-2026  Julian Rodriguez
	
	This program is free software: you can redistribute it and/or modify
	it under the terms of the GNU General Public License as published by
	the Free Software Foundation, either version 3 of the License, or
	(at your option) any later version.
	
	This program is distributed in the hope that it will be useful,
	but WITHOUT ANY WARRANTY; without even the implied warranty of
	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
	GNU General Public License for more details.
	
	You should have received a copy of the GNU General Public License
	along with this program. If not, see <https://www.gnu.org/licenses/>.
*/

/* *** CUSTOMIZATION BEGIN *** */

// PATHs to configuration and storage files
const string PATH_MAIN = "scripts/plugins/store/scxpm/data/";					// All player data goes here
const string PATH_PERMAINCREASE = "scripts/plugins/store/scxpm/permaincrease/";	// XP mods are stored here
const string PATH_ACHIEVEMENT = "scripts/plugins/store/scxpm/achievement/";		// Player achievements are saved here
const string PATH_LOGS = "scripts/plugins/store/scxpm/logs/";					// SCXPM logs get saved here
const string PATH_MAPS = "scripts/plugins/";									// Directory containing the "scxpm_mapsettings.ini" config file

// SCXPM sounds
const string SND_LEVEL_UP = "isc/scxpm/levelup.ogg";				// Level up
const string SND_MEDAL_GET = "isc/scxpm/medalget.ogg";				// Medal get
const string SND_ACHIEVEMENT_GET = "isc/scxpm/achievement.ogg";		// Achievement unlocked
const string SND_PENALTY = "adamr/blipblipblip.wav";				// Level down/Medal lost penalty
const string SND_CHAMPION = "ambience/goal_1.wav";					// Champion award
const string SND_SKILL_RAMMO = "items/9mmclip1.wav";				// Ammo Regeneration
const string SND_SKILL_DEMO = "items/9mmclip2.wav";					// Demoman (ARgrenade Regeneration)

// set this to FALSE if you are hosting under Windows, set TRUE otherwise
const bool IS_LINUX_SERVER = false;

// if hosting under Windows, set this value to your local timezone (UTC)
const int U_TIMEZONE = -3;

// list of weapons that can be affected by the ammo reincarnation basic skill
const array< string > _REGEN_WEAPONS =
{
	"weapon_9mmhandgun",	// Classic SC weapons
	"weapon_357",
	"weapon_9mmAR",
	"weapon_crossbow",
	"weapon_shotgun",
	"weapon_rpg",
	"weapon_gauss",
	"weapon_uzi",
	"weapon_sniperrifle",
	"weapon_m249",
	"weapon_sporelauncher",
	"weapon_eagle",
	"weapon_displacer",
	"weapon_m16",
	// add your custom weapons here
};

// list of weapons that can be affected by the practice shot special skill
const array< string > _PRACTICE_WEAPONS =
{
	"weapon_9mmhandgun",	// Classic SC weapons
	"weapon_357",
	"weapon_9mmAR",
	"weapon_crossbow",
	"weapon_shotgun",
	"weapon_sniperrifle",
	"weapon_m249",
	"weapon_eagle",
	"weapon_m16",
	// add your custom weapons here
};

// some weapons that make use of m_iClip2 might not necessarily be part of a
// secondary weapon fire (think CoF weapons and their semi-auto/burst-fire modes).
//
// because we can't automatically determine if they are, we need to manually
// insert the weapon to a list in order to know if they should become empty on reload.
//
// this list determines which weapons should have their m_iClip2 emptied when reloading
// while Dirty Mag handicap is active.
const array< string > _DIRTY_WEAPONS =
{
	"weapon_uzi"			// Akimbo Uzi
};

// extra xpgain (percent) that each handicap gives
const array< int > _XP_HANDICAP =
{
	22,		// Medical Phobia
	27,		// Obsolete Technology
	13,		// Nitrogen Blood
	18,		// Karmic Retribution
	22,		// Realism
	18,		// Big Explosion
	18,		// Limited Equipment
	18,		// Dead Weight
	13,		// Lacking Help
	22,		// Dirty Mag
	18,		// Lost Bullets
	31,		// Weak Restart
	13,		// Dangerous Waters
	18,		// Bleeding View
	13		// Health Crisis
};

// default base XP gain for all players
const double SCXPM_BASEXP = 1.0;

// how much to multiply map XP gain during time based events
const double HH_EXTRAPERCENT = 2.00; // Happy Hour
const double RT_EXTRAPERCENT = 1.50; // Runaway Time

// when to stop allowing skill resetting/handicap edits for achievements (in seconds, after map start)
const float GRACE_TIME = 120.0;

// !! Making players overpowered is heavily frowned upon.
// !! NO support will be given if you do.
// !! THIS IS YOUR ONLY WARNING.

// maximum capacity of basic skills
const array< int > _MAX_SKILLS =
{
	88,		// Strength
	88,		// Superior Armor
	70,		// Regeneration
	70,		// Nano Armor
	15,		// Ammo Reincarnation
	19,		// Anti-Gravity Device
	50,		// Awareness
	30,		// Team Power
	45		// Block Attack
};
const int _USABLE_SKILLS = 475; // max spendable skillpoints with NO ubercharge. ideally, the sum of all basic skills

// extra basic skill allocation, per ubercharge level
const array< int > _MAX_EXTRA =
{
	4,		// Strength
	4,		// Superior Armor
	3,		// Regeneration
	3,		// Nano Armor
	1,		// Ammo Reincarnation
	2,		// Anti-Gravity Device
	4,		// Awareness
	3,		// Team Power
	1		// Block Attack
};
const int _USABLE_EXTRA = 25; // extra spendable skillpoints per ubercharge level. ideally, the sum of all extra allocation

// maximum capacity of special skills
const array< int > _MAX_SPECIALS =
{
	9,		// Starting Attack
	1,		// Portable Dispencer (boolean)
	9,		// Ubercharge
	5,		// Quick Heal
	5,		// Demoman
	5,		// Practice Shot
	5,		// BioElectric
	1,		// Medical Emergency (boolean) 
	5		// Red Cross
};
const int _USABLE_SPECIALS = 45; // max spendable specialpoints. ideally, the sum of all specials skills

/* *** CUSTOMIZATION END *** */

#include "SCXPM_Achievements"

const string version = "v5.00";
const string lastupdate = "26/05/2026"; // DD/MM/YYYY

const int HIDEHUD_NONE = 0; // don't hide any HUD element

// gameBitSettings
const int DISABLED = ( 1 << 0 );
const int NO_ACHIEVEMENTS = ( 1 << 1 );
const int SINGLE_ACHIEVEMENT = ( 1 << 2 );
const int NO_SKILLS = ( 1 << 3 );
const int DELAYED_XP = ( 1 << 4 );
const int NO_SPECTATE = ( 1 << 5 );
const int ALLOW_HANDICAPS = ( 1 << 6 );
const int ALLOW_PVP_SCORE = ( 1 << 7 );
const int NO_EVENT = ( 1 << 8 );
const int ENABLE_FF = ( 1 << 9 );
const int LIMITED_RESPAWN = ( 1 << 10 );
const int NO_ANTIGRAV = ( 1 << 11 );
const int NO_HANDICAPS = ( 1 << 12 );
const int HIDE_HUD = ( 1 << 13 );
const int OVERPOWER = ( 1 << 14 );
const int NO_SAVE = ( 1 << 15 );
const int SIMULATED_LEVEL = ( 1 << 16 );

// playerBitSettings
const int HUD_XP = ( 1 << 0 );
const int HUD_LEVEL = ( 1 << 1 );
const int HUD_XPLEFT = ( 1 << 2 );
const int HUD_XPEARN = ( 1 << 3 );
const int HUD_MEDALS = ( 1 << 4 );
const int HUD_ACHIEVEMENTS = ( 1 << 5 );
const int HUD_SKILLS = ( 1 << 6 );
const int SKILL_DISPENCER = ( 1 << 7 );
const int SKILL_RANGEHEAL = ( 1 << 8 );
const int MENU_NOAUTOOPEN = ( 1 << 9 );
const int MENU_SAVEHANDICAPS = ( 1 << 10 );

// playerBitHandicaps
const int MEDICAL_PHOBIA = ( 1 << 0 );
const int OBSOLETE_TECHNOLOGY = ( 1 << 1 );
const int NITROGEN_BLOOD = ( 1 << 2 );
const int KARMIC_RETRIBUTION = ( 1 << 3 );
const int REALISM = ( 1 << 4 );
const int BIG_EXPLOSION = ( 1 << 5 );
const int LIMITED_EQUIPMENT = ( 1 << 6 );
const int DEAD_WEIGHT = ( 1 << 7 );
const int LACKING_HELP = ( 1 << 8 );
const int DIRTY_MAG = ( 1 << 9 );
const int LOST_BULLETS = ( 1 << 10 );
const int WEAK_RESTART = ( 1 << 11 );
const int DANGEROUS_WATERS = ( 1 << 12 );
const int BLEEDING_VIEW = ( 1 << 13 );
const int HEALTH_CRISIS = ( 1 << 14 );

enum achievementType
{
	NORMAL = 0,
	HIDDEN,
	LEGACY
};

enum achievementReward
{
	NONE = 0,
	XP,
	MEDAL,
	MULTIPLIER_2,
	MULTIPLIER_3,
	MULTIPLIER_4,
	MODIFIER,
	GOLDEN_HAMMER,
	OTHER
};

enum achievementStatus
{
	LOCKED = 0,
	UNLOCKED,
	UNCLAIMED,
	HAMMERED
};

enum achievementStruct
{
	tNAME = 0,
	tDESCRIPTION,
	tTYPE,
	tREWARD,
	tBOUNTY,
	tMODATA
};

// saved data
array< int > xp( 33 );
array< int > medals( 33 );

array< int > health( 33 );
array< int > armor( 33 );
array< int > rhealth( 33 );
array< int > rarmor( 33 );
array< int > rammo( 33 );
array< int > gravity( 33 );
array< int > speed( 33 );
array< int > dist( 33 );
array< int > dodge( 33 );

array< int > spawndmg( 33 );
array< int > ubercharge( 33 );
array< int > fastheal( 33 );
array< int > demoman( 33 );
array< int > practiceshot( 33 );
array< int > bioelectric( 33 );
array< int > redcross( 33 );

array< int > playerBits( 33 );
array< int > playerHandicaps( 33 );

array< RGBA > hudColor( 33 );
array< Vector2D > hudPosition( 33 );
array< int > hudEffect( 33 );

array< int > xpMultiplier( 33 );
array< int > xpMultiplierTime( 33 );
array< int > xpModifiers( 33 );

array< uDateTime > firstplay( 33 );

array< uDateTime > nextdaily( 33 );
array< int > dailyget( 33 );

array< int > hammers( 33 );

array< array< int >> playerAchievements( 33, array< int > ( 0 ) );

// internal vars
array< int > neededxp( 33 );
array< int > earnedxp( 33 );
array< int > playerlevel( 33 );

array< int > skillpoints( 33 );
array< int > specialpoints( 33 );

array< int > savedHandicaps( 33 );
array< int > forcedHandicaps( 33 );

array< float > rhealthwait( 33 );
array< float > rarmorwait( 33 );
array< float > rammowait( 33 );
array< float > rmedkitwait( 33 );

array< float > lastfrags( 33 );
array< bool > loaddata( 33 );
array< bool > spectator( 33 );
array< int > indexinspect( 33 );

array< float > lastBasicReset( 33 );
array< float > lastSpecialReset( 33 );
array< float > lastHandicapEdit( 33 );

float starthealth = 100.0;
float startarmor = 100.0;
float maxhealth = 100.0;
float maxarmor = 100.0;

bool onecount;
bool event_active;
bool engage_mode;

array< string > gameAchievements( 0 );
int gameNormalAchievements;
int gameMaxAchievements;

float gameStartTime;
int gameSettings;
int gameCfgParam;

double MAP_XPGAIN = 1.00;

dictionary g_MainVaultData;
dictionary g_AchievementVaultData;
dictionary g_ModifiersVaultData;
dictionary g_ChampionVaultData;
bool bVaultsReady;

void PluginInit()
{
	g_Module.ScriptInfo.SetAuthor( "Giegue" );
	g_Module.ScriptInfo.SetContactInfo( "https://github.com/JulianR0/CLevels" );
	
	g_Hooks.RegisterHook( Hooks::Player::ClientSay, @ClientSay );
	g_Hooks.RegisterHook( Hooks::Player::ClientPutInServer, @ClientPutInServer );
	g_Hooks.RegisterHook( Hooks::Player::ClientDisconnect, @ClientDisconnect );
	
	g_Hooks.RegisterHook( Hooks::Player::PlayerPreThink, @PlayerPreThink );
	g_Hooks.RegisterHook( Hooks::Player::PlayerKilled, @PlayerKilled );
	g_Hooks.RegisterHook( Hooks::Player::PlayerTakeDamage, @PlayerTakeDamage );
	g_Hooks.RegisterHook( Hooks::Player::PlayerSpawn, @PlayerSpawn );
	g_Hooks.RegisterHook( Hooks::Player::PlayerRevived, @PlayerRevived );
	
	g_Hooks.RegisterHook( Hooks::Weapon::WeaponPrimaryAttack, @WeaponPrimaryAttack );
	g_Hooks.RegisterHook( Hooks::Weapon::WeaponTertiaryAttack, @WeaponTertiaryAttack );
	
	g_Hooks.RegisterHook( Hooks::PickupObject::Collected, @WeaponPickUp );
	g_Hooks.RegisterHook( Hooks::PickupObject::CanCollect, @ItemCanCollect );
	
	g_Scheduler.SetInterval( "scxpm_sdac", 0.5, g_Scheduler.REPEAT_INFINITE_TIMES );
	g_Scheduler.SetInterval( "scxpm_multiplier_timer", 60.0, g_Scheduler.REPEAT_INFINITE_TIMES );
	g_Scheduler.SetInterval( "scxpm_event_think", 210.0, g_Scheduler.REPEAT_INFINITE_TIMES );
	g_Scheduler.SetInterval( "scxpm_spectate_fix", 0.1, g_Scheduler.REPEAT_INFINITE_TIMES );
	
	AchievementInit();
}

void MapInit()
{
	// Precache all SCXPM sounds
	g_SoundSystem.PrecacheSound( SND_LEVEL_UP );
	g_SoundSystem.PrecacheSound( SND_MEDAL_GET );
	g_SoundSystem.PrecacheSound( SND_ACHIEVEMENT_GET );
	g_SoundSystem.PrecacheSound( SND_PENALTY );
	g_SoundSystem.PrecacheSound( SND_CHAMPION );
	g_SoundSystem.PrecacheSound( SND_SKILL_RAMMO );
	g_SoundSystem.PrecacheSound( SND_SKILL_DEMO );
	g_SoundSystem.PrecacheSound( "null.wav" );
	g_SoundSystem.PrecacheSound( "buttons/blip2.wav" ); // For custom HUD color
	g_SoundSystem.PrecacheSound( "buttons/button3.wav" );
	g_SoundSystem.PrecacheSound( "buttons/button10.wav" );
	
	// Register (and precache) all auxiliary entities
	g_Game.PrecacheModel( "sprites/null.spr" );
	g_Game.PrecacheModel( "models/w_medkit.mdl" );
	g_CustomEntityFuncs.RegisterCustomEntity( "CFlyingMedkit", "scxpm_medkit_dart" );
	g_CustomEntityFuncs.RegisterCustomEntity( "CDelayedXP", "scxpm_give_xp" );
	g_CustomEntityFuncs.RegisterCustomEntity( "CFFToggler", "scxpm_toggle_ff" );
	g_CustomEntityFuncs.RegisterCustomEntity( "CSparkHandler", "scxpm_spark_handler" );
	g_CustomEntityFuncs.RegisterCustomEntity( "CChangeXPGain", "scxpm_change_xpgain" );
	g_CustomEntityFuncs.RegisterCustomEntity( "CSkillToggler", "scxpm_change_skills" );
	g_CustomEntityFuncs.RegisterCustomEntity( "CHideHUD", "scxpm_hide_hud" );
	g_CustomEntityFuncs.RegisterCustomEntity( "CSimulateLevel", "scxpm_simulate_level" );
	g_CustomEntityFuncs.RegisterCustomEntity( "CHCEnforcer", "scxpm_force_handicap" );
	g_CustomEntityFuncs.RegisterCustomEntity( "CAThinker", "scxpm_achievement_thinker" );
	
	array< string >@ states = pmenu_state.getKeys();
	for ( uint i = 0; i < states.length(); i++ )
	{
		MenuHandler@ state = cast< MenuHandler@ >( pmenu_state[ states[ i ] ] );
		if ( state.menu !is null )
			@state.menu = null;
	}
	
	// Reset player vars
	for ( uint i = 0; i < 33; i++ )
	{
		ResetVars( i );
	}
	
	// Reset global vars
	MAP_XPGAIN = 1.00;
	onecount = false;
	event_active = false;
	engage_mode = false;
	gameSettings = 0;
	gameCfgParam = 0;
	gameStartTime = 0.0;
	g_Hooks.RemoveHook( Hooks::Player::GetPlayerSpawnSpot );
	
	// Search game settings for this map
	GetGameSettings();
	
	if ( bVaultsReady )
		DumpVaults();
	else
		InitVaults();
}

void MapActivate()
{
	// Check time based events
	scxpm_event_think();
	
	// Create handler entity if limited respawning is active
	if ( IsBitSet( gameSettings, LIMITED_RESPAWN ) )
		g_EntityFuncs.Create( "scxpm_spark_handler", g_vecZero, g_vecZero, false );
}

dictionary pmenu_state;
class MenuHandler
{
	CTextMenu@ menu;
	
	void InitMenu( CBasePlayer@ pPlayer, TextMenuPlayerSlotCallback@ callback )
	{
		CTextMenu temp( @callback );
		@menu = @temp;
	}
	
	void OpenMenu( CBasePlayer@ pPlayer, int& in time, int& in page )
	{
		menu.Register();
		menu.Open( time, page, pPlayer );
	}
}

MenuHandler@ MenuGetPlayer( CBasePlayer@ pPlayer )
{
	string steamid = g_EngineFuncs.GetPlayerAuthId( pPlayer.edict() );
	if ( steamid == 'STEAM_ID_LAN' )
	{
		steamid = pPlayer.pev.netname;
	}
	
	if ( !pmenu_state.exists( steamid ) )
	{
		MenuHandler state;
		pmenu_state[ steamid ] = state;
	}
	return cast< MenuHandler@ >( pmenu_state[ steamid ] );
}

/** HOOK HANDLERS **/
HookReturnCode ClientPutInServer( CBasePlayer@ pPlayer )
{
	if ( IsBitSet( gameSettings, DISABLED ) )
		return HOOK_CONTINUE;
	
	int iPlayerIndex = pPlayer.entindex();
	
	ResetVars( iPlayerIndex );
	LoadData( iPlayerIndex );
	
	// consider the map "started" the moment a player joins
	if ( gameStartTime == 0.0 )
		gameStartTime = g_Engine.time;
	
	g_Scheduler.SetTimeout( "scxpm_showsettings", 10.0, iPlayerIndex );
	return HOOK_CONTINUE;
}

HookReturnCode ClientDisconnect( CBasePlayer@ pPlayer )
{
	if ( IsBitSet( gameSettings, DISABLED ) )
		return HOOK_CONTINUE;
	
	int iPlayerIndex = pPlayer.entindex();
	
	ResetVars( iPlayerIndex );
	
	return HOOK_CONTINUE;
}

HookReturnCode ClientSay( SayParameters@ pParams )
{
	CBasePlayer@ pPlayer = pParams.GetPlayer();
	
	const CCommand@ args = pParams.GetArguments();
	const string command = args[ 0 ].ToLowercase();
	const int iPlayerIndex = pPlayer.entindex();
	
	if ( command == "/spectate" )
	{
		pParams.ShouldHide = true;
		SCXPMSpectate( pPlayer );
		return HOOK_HANDLED;
	}
	
	if ( IsBitSet( gameSettings, DISABLED ) )
		return HOOK_CONTINUE;
	
	if ( command == "/selectskills" )
	{
		pParams.ShouldHide = true;
		SCXPMSkill( pPlayer );
		return HOOK_HANDLED;
	}
	else if ( command == "/selectspecials" )
	{
		pParams.ShouldHide = true;
		SCXPMSpecial( pPlayer );
		return HOOK_HANDLED;
	}
	else if ( command == "/resetskills" )
	{
		pParams.ShouldHide = true;
		SCXPMResetBasic( pPlayer );
		return HOOK_HANDLED;
	}
	else if ( command == "/resetspecials" )
	{
		pParams.ShouldHide = true;
		SCXPMResetSpecial( pPlayer );
		return HOOK_HANDLED;
	}
	else if ( command == "/hudsettings" )
	{
		pParams.ShouldHide = true;
		SCXPMSettings( pPlayer );
		return HOOK_HANDLED;
	}
	else if ( command == "/resetlevels" )
	{
		pParams.ShouldHide = true;
		SCXPMLevelToMedal( pPlayer );
		return HOOK_HANDLED;
	}
	else if ( command == "/resetmedals" )
	{
		pParams.ShouldHide = true;
		SCXPMMedalToLevel( pPlayer );
		return HOOK_HANDLED;
	}
	else if ( command == "/playerskills" )
	{
		pParams.ShouldHide = true;
		SCXPMOthers( pPlayer );
		return HOOK_HANDLED;
	}
	else if ( command == "/skillsinfo" )
	{
		pParams.ShouldHide = true;
		SCXPMSkillInfo( pPlayer );
		return HOOK_HANDLED;
	}
	else if ( command == "/specialsinfo" )
	{
		pParams.ShouldHide = true;
		SCXPMSpecialInfo( pPlayer );
		return HOOK_HANDLED;
	}
	else if ( command == "/scxpminfo" )
	{
		pParams.ShouldHide = true;
		SCXPMVersion( pPlayer );
		return HOOK_HANDLED;
	}
	else if ( command == "/handicaps" )
	{
		pParams.ShouldHide = true;
		SCXPMHandicaps( pPlayer );
		return HOOK_HANDLED;
	}
	else if ( command == "/handicapsinfo" )
	{
		pParams.ShouldHide = true;
		SCXPMHandicapsInfo( pPlayer );
		return HOOK_HANDLED;
	}
	else if ( command == "/xpgain" )
	{
		pParams.ShouldHide = true;
		SCXPMXPGain( pPlayer );
		return HOOK_HANDLED;
	}
	else if ( command == "/achievements" )
	{
		pParams.ShouldHide = true;
		SCXPMAchievements( pPlayer );
		return HOOK_HANDLED;
	}
	else if ( command == "/character" )
	{
		pParams.ShouldHide = true;
		SCXPMViewData( pPlayer, pPlayer.entindex() );
		return HOOK_HANDLED;
	}
	else if ( command == "/menu" )
	{
		pParams.ShouldHide = true;
		SCXPMMenu( pPlayer );
		return HOOK_HANDLED;
	}
	else if ( command == "/resethandicaps" )
	{
		pParams.ShouldHide = true;
		SCXPMResetHandicaps( pPlayer );
		return HOOK_HANDLED;
	}
	else if ( command == "/autohandicaps" )
	{
		pParams.ShouldHide = true;
		SCXPMAutoSelectHC( pPlayer );
		return HOOK_HANDLED;
	}
	else if ( command == "/inspect" )
	{
		pParams.ShouldHide = true;
		
		if ( args.ArgC() < 1 )
		{
			g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "[SCXPM] Usage: /inspect <Player>\n" );
			g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "[SCXPM] Shows detailed information of a player.\n" );
			return HOOK_HANDLED;
		}
		
		const int PLAYER = FindPlayer( args[ 1 ] );
		if ( PLAYER == 0 )
		{
			g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "[SCXPM] Player not found.\n" );
			return HOOK_HANDLED;
		}
		if ( PLAYER == -1 )
		{
			g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "[SCXPM] Multiple players found. Be more specific.\n" );
			return HOOK_HANDLED;
		}
		CBasePlayer@ pTarget = g_PlayerFuncs.FindPlayerByIndex( PLAYER );
		
		SCXPMViewData( pPlayer, pTarget.entindex() );
		return HOOK_HANDLED;
	}
	else if ( command == "/gift" )
	{
		pParams.ShouldHide = true;
		
		if ( args.ArgC() < 4 )
		{
			g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "[SCXPM] Usage: /gift <Player> <Type> <Amount>\n" );
			g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "[SCXPM] Gifts levels, medals, or multiplier time to a player.\n" );
			g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "[SCXPM] Type should be: \"level\", \"medal\", or \"multiplier\".\n" );
			return HOOK_HANDLED;
		}
		
		const int PLAYER = FindPlayer( args[ 1 ] );
		if ( PLAYER == 0 )
		{
			g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "[SCXPM] Player not found.\n" );
			return HOOK_HANDLED;
		}
		if ( PLAYER == -1 )
		{
			g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "[SCXPM] Multiple players found. Be more specific.\n" );
			return HOOK_HANDLED;
		}
		CBasePlayer@ pTarget = g_PlayerFuncs.FindPlayerByIndex( PLAYER );
		
		if ( pTarget is pPlayer )
		{
			g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "[SCXPM] You cannot give a gift to yourself.\n" );
			return HOOK_HANDLED;
		}
		
		const string TYPE = args[ 2 ].ToLowercase();
		const int AMOUNT = atoi( args[ 3 ] );
		
		scxpm_do_gift( pPlayer, pTarget, TYPE, AMOUNT );
		return HOOK_HANDLED;
	}
	
	return HOOK_CONTINUE;
}

HookReturnCode PlayerKilled( CBasePlayer@ pPlayer, CBaseEntity@ pAttacker, int iGib )
{
	if ( IsBitSet( gameSettings, DISABLED ) )
		return HOOK_CONTINUE;
	
	// Disallow players from gaining XP caused by friendly fire. Unless its a PvP map.
	if ( pAttacker.IsPlayer() && pAttacker !is pPlayer )
	{
		if ( !IsBitSet( gameSettings, ALLOW_PVP_SCORE ) )
			pAttacker.pev.frags -= 1.0;
		
		// A player death should also be counted as a normal death
		pPlayer.m_iDeaths++;
	}
	
	const int iPlayerIndex = pPlayer.entindex();
	
	if ( HasHandicap( iPlayerIndex, NITROGEN_BLOOD ) )
	{
		pPlayer.pev.solid = SOLID_NOT;
		pPlayer.GibMonster();
		pPlayer.pev.effects |= EF_NODRAW;
		
		// stop HEV chatter
		g_SoundSystem.EmitSoundDyn( pPlayer.edict(), CHAN_STATIC, "null.wav", VOL_NORM, ATTN_NORM, 0, PITCH_NORM );
		g_SoundSystem.EmitSoundDyn( pPlayer.edict(), CHAN_VOICE, "null.wav", VOL_NORM, ATTN_NORM, 0, PITCH_NORM );
	}
	
	if ( IsBitSet( gameSettings, LIMITED_RESPAWN ) )
	{
		if ( pPlayer.GetCustomKeyvalues().GetKeyvalue( "$i_scxpm_norespawn" ).GetInteger() == 1 )
		{
			CBaseEntity@ pHandler = g_EntityFuncs.FindEntityByClassname( null, "scxpm_spark_handler" );
			if ( pHandler !is null )
				HandleGameOver( pHandler );
		}
	}
	
	return HOOK_CONTINUE;
}

HookReturnCode PlayerPreThink( CBasePlayer@ pPlayer, uint& out dummy )
{
	if ( IsBitSet( gameSettings, DISABLED ) )
		return HOOK_CONTINUE;
	
	int iPlayerIndex = pPlayer.entindex();
	
	// Anti-Gravity skill
	if ( !IsBitSet( gameSettings, NO_SKILLS ) && !IsBitSet( gameSettings, NO_ANTIGRAV ) )
	{
		if ( IsBitSet( pPlayer.pev.button, IN_JUMP ) )
			gravityon( iPlayerIndex );
		else if ( IsBitSet( pPlayer.pev.oldbuttons, IN_JUMP ) )
			gravityoff( iPlayerIndex );
	}
	
	if ( HasHandicap( iPlayerIndex, DANGEROUS_WATERS ) && pPlayer.pev.waterlevel == WATERLEVEL_HEAD )
	{
		// Instant drowning underwater
		pPlayer.pev.air_finished = 0.0;
	}
	
	return HOOK_CONTINUE;
}

HookReturnCode PlayerTakeDamage( DamageInfo@ diData )
{
	if ( IsBitSet( gameSettings, DISABLED ) )
		return HOOK_CONTINUE;
	
	CBaseEntity@ pAttacker = diData.pAttacker;
	CBaseEntity@ pInflictor = diData.pInflictor;
	CBasePlayer@ pVictim = cast< CBasePlayer@ >( g_EntityFuncs.Instance( diData.pVictim.pev ) );
	
	int iPlayerIndex = pVictim.entindex();
	
	if ( HasHandicap( iPlayerIndex, KARMIC_RETRIBUTION ) )
	{
		if ( pAttacker !is null && !IsBitSet( diData.bitsDamageType, DMG_FALL ) ) // Exclude any falling damage
		{
			// Do not continuously poison the player if it is not taking any damage
			if ( pAttacker.entindex() != 0 && pInflictor.entindex() != iPlayerIndex )
			{
				// Set all damage to poison
				diData.bitsDamageType |= DMG_POISON;
			}
		}
	}
	
	if ( HasHandicap( iPlayerIndex, BIG_EXPLOSION ) )
	{
		// Only (types of) explosives
		if ( IsBitSet( diData.bitsDamageType, DMG_BLAST ) || IsBitSet( diData.bitsDamageType, DMG_MORTAR ) )
		{
			// Do not affect my own explosions, only the opposing ones!
			if ( pAttacker !is null && pAttacker.entindex() != iPlayerIndex )
			{
				// Increase damage. Armor absorbs plenty, so be a tiny bit lenient if there is none
				diData.flDamage *= pVictim.pev.armorvalue == 0.0 ? 1.66 : 1.75;
			}
		}
	}
	
	int DODGE = dodge[ iPlayerIndex ];
	if ( !IsBitSet( gameSettings, NO_SKILLS ) && DODGE > 0 )
	{
		const float AWARENESS = float( speed[ iPlayerIndex ] ) / 9.0;
		const float MEDALS = float( medals[ iPlayerIndex ] );
		
		const float LUCK = Math.RandomFloat( 0.0, 185.0 + DODGE + AWARENESS + ( !HasHandicap( iPlayerIndex, LACKING_HELP ) ? MEDALS : 0.0 ) );
		
		if ( LUCK > 185.0 )
		{
			// Don't fully block the TakeDamage call, we still want the player to know where the damage is coming from
			diData.bitsDamageType &= ~DMG_POISON; // a dodged attack should not poison the player
			diData.flDamage = 0.1;
		}
	}
	
	const int cvarFF = int( g_EngineFuncs.CVarGetFloat( "mp_friendlyfire" ) );
	if ( cvarFF >= 0 && IsBitSet( gameSettings, ENABLE_FF ) || cvarFF >= 1 )
	{
		if ( pAttacker !is null && pAttacker.Classify() == CLASS_PLAYER )
		{
			// only hitscan damages will work. other damages only work if player is self-damaged by it
			
			// PRE hook. change the classify to allow the damage
			pVictim.KeyValue( "classify", "-1" ); // CLASS_NONE
			g_Scheduler.SetTimeout( "PlayerTakeDamagePost", 0.000001, @pVictim );
			
			// should we mirror the damage back to the attacker?
			if ( !IsBitSet( gameSettings, ALLOW_PVP_SCORE ) && cvarFF == 0 )
			{
				pAttacker.TakeDamage( pAttacker.pev, pAttacker.pev, diData.flDamage, diData.bitsDamageType );
				diData.flDamage = 0.0;
			}
		}
	}
	
	return HOOK_CONTINUE;
}
void PlayerTakeDamagePost( CBasePlayer@ pPlayer )
{
	if ( pPlayer is null || !pPlayer.IsConnected() )
		return;
	
	pPlayer.KeyValue( "classify", "2" ); // CLASS_PLAYER
}

HookReturnCode PlayerSpawn( CBasePlayer@ pPlayer )
{
	// this gets called before ClientPutInServer, make it a POST method
	g_Scheduler.SetTimeout( "PlayerSpawnPost", 0.000001, @pPlayer );
	return HOOK_CONTINUE;
}
void PlayerSpawnPost( CBasePlayer@ pPlayer )
{
	if ( pPlayer is null || !pPlayer.IsConnected() )
		return;
	
	if ( IsBitSet( gameSettings, DISABLED ) )
		return;
	
	int iPlayerIndex = pPlayer.entindex();
	
	if ( IsBitSet( gameSettings, LIMITED_RESPAWN ) )
	{
		CBaseEntity@ pHandler = g_EntityFuncs.FindEntityByClassname( null, "scxpm_spark_handler" );
		if ( pHandler !is null )
		{
			// player respawned
			pHandler.Use( pPlayer, pPlayer, USE_TOGGLE, 0.0 );
		}
		else
		{
			g_Game.AlertMessage( at_logged, "[SCXPM] ERROR: Can't find entity \"scxpm_spark_handler\". LIMITED_RESPAWN disabled.\n" );
			SCXPM_Log( "ERROR: Can't find entity \"scxpm_spark_handler\". LIMITED_RESPAWN disabled.\n" );
			gameSettings &= ~LIMITED_RESPAWN;
		}
	}
	
	// Player is no longer alive, stop.
	if ( !pPlayer.IsAlive() )
		return;
	
	if ( !IsBitSet( gameSettings, NO_SKILLS ) )
	{
		// Adjust map starting health/armor
		starthealth = pPlayer.pev.health;
		startarmor = pPlayer.pev.armorvalue;
		
		float EXTRA_HEALTH = ( float( health[ iPlayerIndex ] ) / 2.0 );			// Strength
		float EXTRA_ARMOR = ( float( armor[ iPlayerIndex ] ) / 2.0 );			// Superior Armor
		const float MEDALS = Math.clamp( 0.0, 30.0, float( medals[ iPlayerIndex ] ) );
		
		// Setup player health/armor
		pPlayer.pev.health = EXTRA_HEALTH + starthealth + ( !HasHandicap( iPlayerIndex, LACKING_HELP ) ? MEDALS : 0.0 );
		if ( IsBitSet( gameSettings, OVERPOWER ) ) pPlayer.pev.max_health = EXTRA_HEALTH + maxhealth + ( !HasHandicap( iPlayerIndex, LACKING_HELP ) ? MEDALS : 0.0 );
		pPlayer.pev.armorvalue = EXTRA_ARMOR + startarmor + ( !HasHandicap( iPlayerIndex, LACKING_HELP ) ? MEDALS : 0.0 );
		if ( IsBitSet( gameSettings, OVERPOWER ) ) pPlayer.pev.armortype = EXTRA_ARMOR + maxarmor + ( !HasHandicap( iPlayerIndex, LACKING_HELP ) ? MEDALS : 0.0 );
		
		// Don't allow health/armor to become too high, unless OverPower mode is on
		// A 200 HP/AP limit is still to be held for maxhealth and maxarmor
		if ( pPlayer.pev.health > 200 )
		{
			if ( IsBitSet( gameSettings, OVERPOWER ) )
				pPlayer.pev.max_health = 200;
			else
				pPlayer.pev.health = 200;
			
			starthealth = 100;
		}
		if ( pPlayer.pev.armorvalue > 200 )
		{
			if ( IsBitSet( gameSettings, OVERPOWER ) )
				pPlayer.pev.armortype = 200;
			else
				pPlayer.pev.armorvalue = 200;
			
			startarmor = 100;
		}
		
		scxpm_spawndmg( iPlayerIndex );
	}
	
	// Reset Red Cross ammo data on spawn/respawn. Only if medkit can be recharged!
	if ( pPlayer.GetMaxAmmo( "health" ) > 0 )
	{
		if ( !IsBitSet( gameSettings, NO_SKILLS ) )
		{
			pPlayer.SetMaxAmmo( "health", 100 + ( redcross[ iPlayerIndex ] * 20 ) );
			if ( HasHandicap( iPlayerIndex, HEALTH_CRISIS ) )
				pPlayer.SetMaxAmmo( "health", 50 + ( redcross[ iPlayerIndex ] * 10 ) );
		}
		else if ( HasHandicap( iPlayerIndex, HEALTH_CRISIS ) )
			pPlayer.SetMaxAmmo( "health", 50 );
		
		pPlayer.RemoveExcessAmmo( "health" );
	}
	
	if ( HasHandicap( iPlayerIndex, REALISM ) )
		pPlayer.m_iHideHUD = HIDEHUD_FLASHLIGHT | HIDEHUD_HEALTH | HIDEHUD_SUITPOWER | HIDEHUD_CROSSHAIR | HIDEHUD_AMMO;
	
	// Put this handicap after starting attack to avoid spawnkilling
	if ( HasHandicap( iPlayerIndex, WEAK_RESTART ) )
	{
		pPlayer.pev.health = 25;
		pPlayer.pev.armorvalue = 0;
	}
}

HookReturnCode PlayerRevived( CBasePlayer@ pPlayer )
{
	if ( IsBitSet( gameSettings, DISABLED ) )
		return HOOK_CONTINUE;
	
	int iPlayerIndex = pPlayer.entindex();
	
	if ( !IsBitSet( gameSettings, NO_SKILLS ) )
	{
		float EXTRA_HEALTH = ( float( health[ iPlayerIndex ] ) / 2.0 );		// Strength
		float EXTRA_ARMOR = ( float( armor[ iPlayerIndex ] ) / 2.0 );		// Superior Armor
		const float MEDALS = Math.clamp( 0.0, 30.0, float( medals[ iPlayerIndex ] ) );
		
		pPlayer.pev.health += EXTRA_HEALTH + ( !HasHandicap( iPlayerIndex, LACKING_HELP ) ? MEDALS : 0.0 );
		
		if ( pPlayer.pev.armorvalue < startarmor )
			pPlayer.pev.armorvalue += EXTRA_ARMOR + ( !HasHandicap( iPlayerIndex, LACKING_HELP ) ? MEDALS : 0.0 );
	}
	
	if ( HasHandicap( iPlayerIndex, REALISM ) )
		pPlayer.m_iHideHUD = HIDEHUD_FLASHLIGHT | HIDEHUD_HEALTH | HIDEHUD_SUITPOWER | HIDEHUD_CROSSHAIR | HIDEHUD_AMMO;
	
	scxpm_spawndmg( iPlayerIndex );
	
	if ( HasHandicap( iPlayerIndex, WEAK_RESTART ) )
	{
		pPlayer.pev.health = 25;
		pPlayer.pev.armorvalue = 0;
	}
	
	return HOOK_CONTINUE;
}

HookReturnCode WeaponPrimaryAttack( CBasePlayer@ pPlayer, CBasePlayerWeapon@ pWeapon )
{
	if ( IsBitSet( gameSettings, DISABLED ) || IsBitSet( gameSettings, NO_SKILLS ) )
		return HOOK_CONTINUE;
	
	// Prevent rare NULL pointer access
	if ( pPlayer is null || pWeapon is null )
		return HOOK_HANDLED;
	
	int iPlayerIndex = pPlayer.entindex();
	
	const int PRACTICE = practiceshot[ iPlayerIndex ];
	if ( PRACTICE == 0 || HasHandicap( iPlayerIndex, LACKING_HELP ) )
		return HOOK_CONTINUE;
	
	// We can't reliably determine if the weapon can fire underwater or not.
	// Assume it's impossible.
	//if ( pPlayer.pev.waterlevel == WATERLEVEL_HEAD )
	//	return HOOK_CONTINUE;
	
	if ( _PRACTICE_WEAPONS.find( pWeapon.pev.classname ) == -1 )
		return HOOK_CONTINUE;
	
	// Clip size must have changed
	int iOldClip = pWeapon.GetCustomKeyvalues().GetKeyvalue( "$i_mm_oldclip" ).GetInteger();
	if ( pWeapon.m_iClip == 0 || pWeapon.m_iClip > 0 && iOldClip == pWeapon.m_iClip )
		return HOOK_CONTINUE;
	
	if ( Math.RandomLong( 1, 100 + ( PRACTICE * 5 ) ) > 100 )
		pWeapon.m_iClip++;
	
	pWeapon.KeyValue( "$i_mm_oldclip", string( pWeapon.m_iClip ) );
	return HOOK_CONTINUE;
}

HookReturnCode WeaponTertiaryAttack( CBasePlayer@ pPlayer, CBasePlayerWeapon@ pWeapon )
{
	if ( IsBitSet( gameSettings, DISABLED ) || IsBitSet( gameSettings, NO_SKILLS ) )
		return HOOK_CONTINUE;
	
	// Prevent rare NULL pointer access
	if ( pPlayer is null || pWeapon is null )
		return HOOK_HANDLED;
	
	int iPlayerIndex = pPlayer.entindex();
	
	const int playerBITS = playerBits[ iPlayerIndex ];
	if ( !IsBitSet( playerBITS, SKILL_RANGEHEAL ) || HasHandicap( iPlayerIndex, LACKING_HELP ) )
		return HOOK_CONTINUE;
	
	// Medkit only
	if ( pWeapon.m_iId != WEAPON_MEDKIT )
		return HOOK_CONTINUE;
	
	// Don't spam
	if ( g_Engine.time < pWeapon.m_flNextTertiaryAttack )
		return HOOK_CONTINUE;
	
	const int AMMO_MEDKIT = g_PlayerFuncs.GetAmmoIndex( "health" );
	const int AMMO_NEEDED = int( g_EngineFuncs.CVarGetFloat( "sk_plr_HpMedic" ) );
	
	// Enough ammo for this?
	if ( pPlayer.m_rgAmmo( AMMO_MEDKIT ) < AMMO_NEEDED )
		return HOOK_CONTINUE;
	
	// Get aiment
	g_EngineFuncs.MakeVectors( pPlayer.pev.v_angle );
	
	// Create medkit
	g_EntityFuncs.Create( "scxpm_medkit_dart", pPlayer.pev.origin + g_Engine.v_forward * 16, pPlayer.pev.v_angle, false, pPlayer.edict() );
	
	// Decrement ammo
	pPlayer.m_rgAmmo( AMMO_MEDKIT, pPlayer.m_rgAmmo( AMMO_MEDKIT ) - AMMO_NEEDED );
	
	// Wait 'till this time
	pWeapon.m_flNextTertiaryAttack = g_Engine.time + 0.5f;
	
	return HOOK_CONTINUE;
}

HookReturnCode WeaponPickUp( CBaseEntity@ pItem, CBaseEntity@ pPlayer )
{
	if ( IsBitSet( gameSettings, DISABLED ) || IsBitSet( gameSettings, NO_SKILLS ) )
		return HOOK_CONTINUE;
	
	CBasePlayerWeapon@ pWeapon = cast< CBasePlayerWeapon@ >( pItem );
	if ( pWeapon is null )
		return HOOK_CONTINUE;
	
	CBasePlayer@ ppPlayer = cast< CBasePlayer@ >( pPlayer );
	if ( ppPlayer is null )
		return HOOK_CONTINUE;
	
	const int iPlayerIndex = ppPlayer.entindex();
	
	// BioElectric skill
	const int EXTRA_AMMO = bioelectric[ iPlayerIndex ] * 10;
	
	if ( pWeapon.pev.classname == "weapon_shockrifle" )
	{
		const int AMMO_SHOCKRIFLE = g_PlayerFuncs.GetAmmoIndex( "shock charges" );
		ppPlayer.m_rgAmmo( AMMO_SHOCKRIFLE, ppPlayer.m_rgAmmo( AMMO_SHOCKRIFLE ) + ( EXTRA_AMMO ) );
	}
	else if ( pWeapon.pev.classname == "weapon_op4_shockrifle" )
	{
		const int AMMO_SHOCKRIFLE = g_PlayerFuncs.GetAmmoIndex( "opfor_shocks" );
		ppPlayer.m_rgAmmo( AMMO_SHOCKRIFLE, ppPlayer.m_rgAmmo( AMMO_SHOCKRIFLE ) + ( EXTRA_AMMO / 10 ) );
	}
	
	return HOOK_CONTINUE;
}

HookReturnCode ItemCanCollect( CBaseEntity@ pItem, CBaseEntity@ pPlayer, bool& out bCanCollect )
{
	if ( IsBitSet( gameSettings, DISABLED ) )
		return HOOK_CONTINUE;
	
	CBasePlayer@ ppPlayer = cast< CBasePlayer@ >( pPlayer );
	
	const int iPlayerIndex = ppPlayer.entindex();
	
	if ( HasHandicap( iPlayerIndex, MEDICAL_PHOBIA ) && string( pItem.pev.classname ) == "item_healthkit" )
		bCanCollect = false;
	
	if ( HasHandicap( iPlayerIndex, OBSOLETE_TECHNOLOGY ) && string( pItem.pev.classname ) == "item_battery" ) 
		bCanCollect = false;
	
	if ( HasHandicap( iPlayerIndex, LIMITED_EQUIPMENT ) && string( pItem.pev.classname ).StartsWith( "weapon_" ) && ppPlayer.HasWeapons() )
		bCanCollect = false;
	
	return HOOK_CONTINUE;
}

HookReturnCode GetPlayerSpawnSpot( CBasePlayer@ pPlayer, CBaseEntity@& out ppEntSpawnSpot )
{
	// only registed if LIMITED_RESPAWN
	if ( !pPlayer.IsAlive() && pPlayer.GetCustomKeyvalues().GetKeyvalue( "$i_scxpm_norespawn" ).GetInteger() == 1 )
	{
		@ppEntSpawnSpot = null;
		return HOOK_HANDLED;
	}
	
	return HOOK_CONTINUE;
}

/** UTILITY CODE **/
bool IsBitSet( int value, int bit )
{
	return ( ( value & bit ) != 0 );
}

// round
/* Rounds a float/double into an integer value */ 
enum round_method { round_round = 0, round_floor, round_ceil, round_tozero };
int round( double value, round_method method = round_round )
{
	double fA = value;
	
	switch ( method )
	{
		case round_floor: /* round downwards (truncate) */
		{
			fA = ROUND::Floor( fA );
			break;
		}
		case round_ceil: /* round upwards */
		{
			fA = ROUND::Ceil( fA );
			break;
		}
		case round_tozero: /* round towards zero */
		{
			if ( fA >= 0.0 )
				fA = ROUND::Floor( fA );
			else
				fA = ROUND::Ceil( fA );
			break;
		}
		default: /* standard, round to nearest */
		{
			if ( fA >= 0.0 )
				fA = ROUND::Floor( fA + 0.5 );
			else
				fA = ROUND::Floor( fA - 0.5 );
			break;
		}
	}
	
	return int( fA );
}
namespace ROUND
{
	double Floor( double value )
	{
		return double( int( value ) );
	}
	
	double Ceil( double value )
	{
		if ( value > 0.0 && ( value - int( value ) ) > 0.0 )
			return double( int( value + 1 ) );
		else if ( ( value - int( value ) ) < 0.0 )
			return double( int( value - 1 ) );
		
		return double( int( value ) );
	}
}

// Overload a few default functions
double abs( double value ) { return ( value >= 0.0 ? value : -value ); }
int abs( int value ) { return ( value >= 0 ? value : -value ); }
double sqrt( double value ) { return ( value ** 0.5 ); }

void scxpm_calcneedxp( const int iPlayerIndex )
{
	double m70 = double( playerlevel[ iPlayerIndex ] ) * 70.0;
	double mselfm3dot2 = double( playerlevel[ iPlayerIndex ] ) * double( playerlevel[ iPlayerIndex ] ) * 3.5;
	neededxp[ iPlayerIndex ] = round( m70 + mselfm3dot2 + 30.0 );
}

int scxpm_calc_lvl( const int XP )
{
	return round( -10.0 + sqrt( 100.0 - ( 60.0 / 7.0 - ( ( double( XP ) + 1.0 ) / 3.5 ) ) ), round_ceil );
}

int scxpm_calc_xp( int LEVEL )
{
	LEVEL--;
	return round( ( double( LEVEL ) * 70.0 ) + ( double( LEVEL ) * double( LEVEL ) * 3.5 ) + 30.0 );
}

void scxpm_calc_skillpoints( const int iPlayerIndex )
{
	// never go above max skill capacity, ubercharge included
	const int MAX = _USABLE_SKILLS + ( _USABLE_EXTRA * ubercharge[ iPlayerIndex ] );
	
	skillpoints[ iPlayerIndex ] = Math.clamp( 0, MAX, playerlevel[ iPlayerIndex ] );
	
	skillpoints[ iPlayerIndex ] -= health[ iPlayerIndex ];
	skillpoints[ iPlayerIndex ] -= armor[ iPlayerIndex ];
	skillpoints[ iPlayerIndex ] -= rhealth[ iPlayerIndex ];
	skillpoints[ iPlayerIndex ] -= rarmor[ iPlayerIndex ];
	skillpoints[ iPlayerIndex ] -= rammo[ iPlayerIndex ];
	skillpoints[ iPlayerIndex ] -= gravity[ iPlayerIndex ];
	skillpoints[ iPlayerIndex ] -= speed[ iPlayerIndex ];
	skillpoints[ iPlayerIndex ] -= dist[ iPlayerIndex ];
	skillpoints[ iPlayerIndex ] -= dodge[ iPlayerIndex ];
}

void scxpm_calc_specialpoints( const int iPlayerIndex )
{
	// never go above max skill capacity
	const int MAX = _USABLE_SPECIALS;
	
	// the first 30 are free
	int TOTAL_POINTS = 0;
	TOTAL_POINTS = Math.clamp( 0, 30, medals[ iPlayerIndex ] );
	
	// afterwards, it's 1 point every 10 medals. up to 15 extra points
	TOTAL_POINTS += Math.clamp( 0, 15, ( medals[ iPlayerIndex ] - 30 ) / 10 );
	
	specialpoints[ iPlayerIndex ] = Math.clamp( 0, MAX, TOTAL_POINTS );
	
	specialpoints[ iPlayerIndex ] -= spawndmg[ iPlayerIndex ];
	if ( IsBitSet( playerBits[ iPlayerIndex ], SKILL_DISPENCER ) ) specialpoints[ iPlayerIndex ]--;
	specialpoints[ iPlayerIndex ] -= ubercharge[ iPlayerIndex ];
	specialpoints[ iPlayerIndex ] -= fastheal[ iPlayerIndex ];
	specialpoints[ iPlayerIndex ] -= demoman[ iPlayerIndex ];
	specialpoints[ iPlayerIndex ] -= practiceshot[ iPlayerIndex ];
	specialpoints[ iPlayerIndex ] -= bioelectric[ iPlayerIndex ];
	if ( IsBitSet( playerBits[ iPlayerIndex ], SKILL_RANGEHEAL ) ) specialpoints[ iPlayerIndex ]--;
	specialpoints[ iPlayerIndex ] -= redcross[ iPlayerIndex ];
}

double scxpm_calc_xpgain( const int iPlayerIndex )
{
	const double BASEXP = SCXPM_BASEXP;
	
	double exp = BASEXP * MAP_XPGAIN;
	
	// forced handicaps do not increase xpgain
	const int HANDICAP = playerHandicaps[ iPlayerIndex ];
	
	int percent = 0;
	if ( IsBitSet( HANDICAP, MEDICAL_PHOBIA ) ) percent += _XP_HANDICAP[ 0 ];
	if ( IsBitSet( HANDICAP, OBSOLETE_TECHNOLOGY ) ) percent += _XP_HANDICAP[ 1 ];
	if ( IsBitSet( HANDICAP, NITROGEN_BLOOD ) ) percent += _XP_HANDICAP[ 2 ];
	if ( IsBitSet( HANDICAP, KARMIC_RETRIBUTION ) ) percent += _XP_HANDICAP[ 3 ];
	if ( IsBitSet( HANDICAP, REALISM ) ) percent += _XP_HANDICAP[ 4 ];
	if ( IsBitSet( HANDICAP, BIG_EXPLOSION ) ) percent += _XP_HANDICAP[ 5 ];
	if ( IsBitSet( HANDICAP, LIMITED_EQUIPMENT ) ) percent += _XP_HANDICAP[ 6 ];
	if ( IsBitSet( HANDICAP, DEAD_WEIGHT ) ) percent += _XP_HANDICAP[ 7 ];
	if ( IsBitSet( HANDICAP, LACKING_HELP ) ) percent += _XP_HANDICAP[ 8 ];
	if ( IsBitSet( HANDICAP, DIRTY_MAG ) ) percent += _XP_HANDICAP[ 9 ];
	if ( IsBitSet( HANDICAP, LOST_BULLETS ) ) percent += _XP_HANDICAP[ 10 ];
	if ( IsBitSet( HANDICAP, WEAK_RESTART ) ) percent += _XP_HANDICAP[ 11 ];
	if ( IsBitSet( HANDICAP, DANGEROUS_WATERS ) ) percent += _XP_HANDICAP[ 12 ];
	if ( IsBitSet( HANDICAP, BLEEDING_VIEW ) ) percent += _XP_HANDICAP[ 13 ];
	if ( IsBitSet( HANDICAP, HEALTH_CRISIS ) ) percent += _XP_HANDICAP[ 14 ];
	
	percent += Math.clamp( -500, 500, xpModifiers[ iPlayerIndex ] );
	
	// Increase XPGain based on medals
	percent += 3 * Math.clamp( 0, 30, medals[ iPlayerIndex ] );
	
	exp = exp * ( 100.0 + double( percent ) ) / 100.0;
	
	exp *= double( xpMultiplier[ iPlayerIndex ] );
	return exp;
}

void scxpm_showsettings( const int iPlayerIndex )
{
	CBasePlayer@ pPlayer = g_PlayerFuncs.FindPlayerByIndex( iPlayerIndex );
	if ( pPlayer is null || !pPlayer.IsConnected() )
		return;
	
	if ( IsBitSet( gameSettings, NO_ANTIGRAV ) )
		g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "[SCXPM] The \"Anti-Gravity Device\" skill has been disabled for this map.\n" );
	
	if ( IsBitSet( gameSettings, ENABLE_FF ) && !IsBitSet( gameSettings, ALLOW_PVP_SCORE ) )
		g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "[SCXPM] Mirror Friendly Fire is enabled on this map. Beware!\n" );
	
	if ( IsBitSet( gameSettings, SIMULATED_LEVEL ) )
		g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "[SCXPM] Your current level is being simulated. Your real level will be restored at map end.\n" );
}

// HasHandicap
/* Returns true if the player has this handicap activated. */
/* It can be either by choice or forced by the map. */
bool HasHandicap( const int iPlayerIndex, int handicapBit )
{
	int HANDICAP = playerHandicaps[ iPlayerIndex ];
	int FORCEDHC = forcedHandicaps[ iPlayerIndex ];
	
	if ( !AreHandicapsON() )
		HANDICAP = 0;
	
	return ( IsBitSet( HANDICAP, handicapBit ) || IsBitSet( FORCEDHC, handicapBit ) );
}

// AreHandicapsON
/* Returns true if the map allows usage of handicaps. */
/* Forced handicaps ignore this condition. */
bool AreHandicapsON()
{
	if ( IsBitSet( gameSettings, NO_SKILLS ) && !IsBitSet( gameSettings, ALLOW_HANDICAPS ) || IsBitSet( gameSettings, NO_HANDICAPS ) )
		return false;
	
	return true;
}

// GetGameSettings
/* Finds and sets SCXPM settings for this map */
void GetGameSettings()
{
	const string currentMap = string( g_Engine.mapname ).ToLowercase();
	SCXPM_Log( "-------- Mapchange to " + currentMap + " --------\n" );
	
	const string CONFIG_FILE = PATH_MAPS + "scxpm_mapsettings.ini";
	File@ fFile = g_FileSystem.OpenFile( CONFIG_FILE , OpenFile::READ );
	if ( fFile is null || !fFile.IsOpen() )
	{
		g_Game.AlertMessage( at_logged, "[SCXPM] WARNING: Cannot open config file \"" + CONFIG_FILE + "\"!\n" );
		return;
	}
	
	string line;
	while ( !fFile.EOFReached() )
	{
		fFile.ReadLine( line );
		if ( line.Length() == 0 || line[ 0 ] == ';' )
			continue;
		
		array< string > setting = line.Split( ' ' );
		setting[ 0 ].Trim(); setting[ 0 ].ToLowercase();
		setting[ 1 ].Trim(); setting[ 1 ].ToUppercase();
		
		if ( setting[ 0 ] == currentMap ) // Map found
		{
			array< string > modes = setting[ 1 ].Split( '|' );
			
			// ugly :C
			for ( uint i = 0; i < modes.length(); i++ )
			{
				if ( modes[ i ] == "DISABLED" )
				{
					gameSettings |= DISABLED;
					SCXPM_Log( "-------- SCXPM DISABLED FOR MAP: " + currentMap + " --------\n" );
				}
				else if ( modes[ i ] == "NO_ACHIEVEMENTS" ) gameSettings |= NO_ACHIEVEMENTS;
				else if ( modes[ i ] == "SINGLE_ACHIEVEMENT" ) gameSettings |= SINGLE_ACHIEVEMENT;
				else if ( modes[ i ] == "NO_SKILLS" ) gameSettings |= NO_SKILLS;
				else if ( modes[ i ] == "DELAYED_XP" ) gameSettings |= DELAYED_XP;
				else if ( modes[ i ] == "NO_SPECTATE" ) gameSettings |= NO_SPECTATE;
				else if ( modes[ i ] == "ALLOW_HANDICAPS" ) gameSettings |= ALLOW_HANDICAPS;
				else if ( modes[ i ] == "ALLOW_PVP_SCORE" ) gameSettings |= ALLOW_PVP_SCORE;
				else if ( modes[ i ] == "NO_EVENT" ) gameSettings |= NO_EVENT;
				else if ( modes[ i ] == "ENABLE_FF" ) gameSettings |= ENABLE_FF;
				else if ( modes[ i ] == "LIMITED_RESPAWN" ) gameSettings |= LIMITED_RESPAWN;
				else if ( modes[ i ] == "NO_ANTIGRAV" ) gameSettings |= NO_ANTIGRAV;
				else if ( modes[ i ] == "NO_HANDICAPS" ) gameSettings |= NO_HANDICAPS;
				else if ( modes[ i ] == "HIDE_HUD" ) gameSettings |= HIDE_HUD;
				else if ( modes[ i ] == "OVERPOWER" ) gameSettings |= OVERPOWER;
				else if ( modes[ i ] == "NO_SAVE" ) gameSettings |= NO_SAVE;
				else if ( modes[ i ] == "SIMULATED_LEVEL" ) gameSettings |= SIMULATED_LEVEL;
			}
			
			setting[ 2 ].Trim();
			MAP_XPGAIN = atod( setting[ 2 ] );
			
			const bool gSingleAchievement = IsBitSet( gameSettings, SINGLE_ACHIEVEMENT );
			const bool gLimitedRespawn = IsBitSet( gameSettings, LIMITED_RESPAWN );
			const bool gSimulatedLevel = IsBitSet( gameSettings, SIMULATED_LEVEL );
			
			if ( gSingleAchievement || gLimitedRespawn || gSimulatedLevel )
			{
				setting[ 3 ].Trim();
				gameCfgParam = atoi( setting[ 3 ] );
				
				if ( gLimitedRespawn )
				{
					g_Hooks.RegisterHook( Hooks::Player::GetPlayerSpawnSpot, @GetPlayerSpawnSpot );
					g_EngineFuncs.CVarSetFloat( "mp_observer_mode", 1.0 );
				}
			}
			
			break;
		}
	}
	
	fFile.Close();
}

// CheckConvertAmp
/* Performs conversion of multiplier/time for a player that already has an amplifier */
void CheckConvertAmp( const int iPlayerIndex, int iNewLevel, int iNewTime )
{
	CBasePlayer@ pPlayer = g_PlayerFuncs.FindPlayerByIndex( iPlayerIndex );
	if ( pPlayer is null || !pPlayer.IsConnected() )
		return;
	
	// If new level to give is equal to player's level, extend time. Otherwise convert to XP
	if ( iNewLevel == xpMultiplier[ iPlayerIndex ] )
	{
		// Add new time
		xpMultiplierTime[ iPlayerIndex ] += iNewTime;
		
		// Notify player
		g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "[SCXPM] Your multiplier longevity was extended by " + iNewTime + " minutes.\n" );
	}
	else
	{
		int base = 0;
		switch ( iNewLevel )
		{
			case 1: base = 40; break;
			case 2: base = 80; break;
			case 3: base = 160; break;
			case 4: base = 320; break;
		}
		
		int extra_xp = base * iNewTime;
		
		// Add and notify
		xp[ iPlayerIndex ] += extra_xp;
		if ( !IsBitSet( gameSettings, DELAYED_XP ) ) earnedxp[ iPlayerIndex ] += extra_xp; // Prevent double XP exploitation on delayed XP maps
		
		g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "[SCXPM] This reward has been converted to " + AddCommas( extra_xp ) + " XP.\n" );
	}
}

// ClientCMD
/* Executes a command to a player - !!! HANDLE WITH CARE !!! */
void ClientCMD( CBasePlayer@ pPlayer, string szCommand )
{
	NetworkMessage cmd( MSG_ONE, NetworkMessages::SVC_STUFFTEXT, g_vecZero, pPlayer.edict() );
	cmd.WriteString( szCommand + "\n" );
	cmd.End();
}

// FindPlayer
/* Locates a player by name, case insensitive. */
/* Returns -1 if multiple matches are found */
/* Returns 0 if no player was found */
/* Otherwise, returns found player index */
int FindPlayer( const string szName )
{
	int iPlayerIndex = 0, iTargets = 0;
	for ( int i = 1; i <= g_Engine.maxClients; i++ )
	{
		CBasePlayer@ iPlayer = g_PlayerFuncs.FindPlayerByIndex( i );
		
		if ( iPlayer !is null && iPlayer.IsConnected() )
		{
			string szCheck = iPlayer.pev.netname;
			uint iCheck = szCheck.Find( szName, 0, String::CaseInsensitive );
			if ( iCheck != String::INVALID_INDEX )
			{
				iTargets++;
				iPlayerIndex = i;
			}
		}
	}
	
	if ( iTargets == 1 )
		return iPlayerIndex;
	else if ( iTargets >= 2 )
		return -1;
	
	return 0;
}

// ShowMOTD
/* Shows a MOTD message to the player */
void ShowMOTD( CBasePlayer@ pPlayer, const string szTitle, const string szMessage )
{
	if ( pPlayer is null )
		return;
	
	NetworkMessage title( MSG_ONE_UNRELIABLE, NetworkMessages::ServerName, pPlayer.edict() );
	title.WriteString( szTitle );
	title.End();
	
	uint iChars = 0;
	string szSplitMsg = "AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA";
	
	for ( uint uChars = 0; uChars < szMessage.Length(); uChars++ )
	{
		szSplitMsg.SetCharAt( iChars, char( szMessage[ uChars ] ) );
		iChars++;
		if ( iChars == 32 )
		{
			NetworkMessage message( MSG_ONE_UNRELIABLE, NetworkMessages::MOTD, pPlayer.edict() );
			message.WriteByte( 0 );
			message.WriteString( szSplitMsg );
			message.End();
			
			iChars = 0;
		}
	}
	
	// If we reached the end, send the last letters of the message
	if ( iChars > 0 )
	{
		szSplitMsg.Truncate( iChars );
		
		NetworkMessage fix( MSG_ONE_UNRELIABLE, NetworkMessages::MOTD, pPlayer.edict() );
		fix.WriteByte( 0 );
		fix.WriteString( szSplitMsg );
		fix.End();
	}
	
	NetworkMessage endMOTD( MSG_ONE_UNRELIABLE, NetworkMessages::MOTD, pPlayer.edict() );
	endMOTD.WriteByte( 1 );
	endMOTD.WriteString( "\n" );
	endMOTD.End();
	
	NetworkMessage restore( MSG_ONE_UNRELIABLE, NetworkMessages::ServerName, pPlayer.edict() );
	restore.WriteString( g_EngineFuncs.CVarGetString( "hostname" ) );
	restore.End();
}

// SCXPM_Log
/* Customized logs */
void SCXPM_Log( const string szMessage )
{
	uDateTime thetime( UnixTimestamp() );
	int year = thetime.GetYear();
	int month = thetime.GetMonth();
	int day = thetime.GetDayOfMonth();
	int hour = thetime.GetHour();
	int minutes = thetime.GetMinutes();
	int seconds = thetime.GetSeconds();
	
	// Fix for one digit month/day/hour/minute/second
	string szMonths;
	string szDays;
	string szHours;
	string szMinutes;
	string szSeconds;
	if ( month < 10 ) szMonths = "0" + month;
	else szMonths = month;
	if ( day < 10 ) szDays = "0" + day;
	else szDays = day;
	if ( hour < 10 ) szHours = "0" + hour;
	else szHours = hour;
	if ( minutes < 10 ) szMinutes = "0" + minutes;
	else szMinutes = minutes;
	if ( seconds < 10 ) szSeconds = "0" + seconds;
	else szSeconds = seconds;
	
	string fullpath = PATH_LOGS + year + "-" + szMonths + "-" + szDays + ".log";
	File@ thefile = g_FileSystem.OpenFile( fullpath, OpenFile::APPEND );
	
	if ( thefile !is null && thefile.IsOpen() )
	{
		thefile.Write( szHours + ":" + szMinutes + ":" + szSeconds + " - " + szMessage );
		thefile.Close();
	}
}

// fl2Decimals
/* Converts a float value to a string, with a maximum of 2 decimals */
string fl2Decimals( const float value )
{
	// Convert float to string
	string original = string( value );
	
	// Split string using decimal point
	array< string > pre_convert = original.Split( '.' );
	
	string decimals = "";
	
	// Check if our value has any decimal places
	if ( pre_convert.length() > 1 )
	{
		// It has at least one. Use it
		decimals += pre_convert[ 1 ][ 0 ];
		
		// Does it have a second decimal?
		if ( isdigit( pre_convert[ 1 ][ 1 ] ) )
		{
			// Yep, add it
			decimals += pre_convert[ 1 ][ 1 ];
		}
		else
		{
			// Does not. Add a zero manually
			decimals += "0";
		}
	}
	else
	{
		// No decimals, add zeros manually
		decimals += "00";
	}
	
	// Copy integer part
	string number = pre_convert[ 0 ];
	
	// Now, build the full string
	string convert = string( number ) + "." + decimals;
	
	return convert;
}

// AddCommas
/* Add commas to integers */
string AddCommas( int iNum )
{
	string szOutput;
	string szTmp;
	uint iOutputPos = 0;
	uint iNumPos = 0;
	uint iNumLen;
	
	szTmp = string( iNum );
	iNumLen = szTmp.Length();
	
	if ( iNumLen <= 3 )
	{
		szOutput = szTmp;
	}
	else
	{
		szOutput = "?????????????";
		while ( ( iNumPos < iNumLen ) ) 
		{
			szOutput.SetCharAt( iOutputPos++, char( szTmp[ iNumPos++ ] ) );
			
			if( ( iNumLen - iNumPos ) != 0 && !( ( ( iNumLen - iNumPos ) % 3 ) != 0 ) ) 
				szOutput.SetCharAt( iOutputPos++, char( "," ) );
		}
		szOutput.Replace( "?", "" );
	}
	
	return szOutput;
}

// AddExternal
/* Yield stuff from external plugins/maps */
void AddExternal( const int iPlayerIndex )
{
	CBasePlayer@ pPlayer = g_PlayerFuncs.FindPlayerByIndex( iPlayerIndex );
	CustomKeyvalues@ pKVD = pPlayer.GetCustomKeyvalues();
	
	// Anything special to give?
	int iAddXP = pKVD.GetKeyvalue( "$i_ext_xp" ).GetInteger();
	if ( iAddXP != 0 )
	{
		xp[ iPlayerIndex ] += iAddXP;
		earnedxp[ iPlayerIndex ] += iAddXP;
		
		pPlayer.KeyValue( "$i_ext_xp", "0" );
	}
	
	int iAddMultiplier = pKVD.GetKeyvalue( "$i_ext_expamp" ).GetInteger();
	if ( iAddMultiplier > 1 )
	{
		int iAMPTime = pKVD.GetKeyvalue( "$i_ext_amptime" ).GetInteger();
		if ( iAMPTime == 0 ) iAMPTime = 60;
		
		if ( xpMultiplier[ iPlayerIndex ] > 1 )
			CheckConvertAmp( iPlayerIndex, iAddMultiplier, iAMPTime );
		else
		{
			xpMultiplier[ iPlayerIndex ] = iAddMultiplier;
			xpMultiplierTime[ iPlayerIndex ] = iAMPTime + 1;
		}
		
		pPlayer.KeyValue( "$i_ext_expamp", "0" );
		pPlayer.KeyValue( "$i_ext_amptime", "0" );
	}
	
	int iAddMedals = pKVD.GetKeyvalue( "$i_ext_medals" ).GetInteger();
	if ( iAddMedals != 0 )
	{
		medals[ iPlayerIndex ] += iAddMedals;
		if ( medals[ iPlayerIndex ] > 180 )
			medals[ iPlayerIndex ] = 180;
		scxpm_calc_specialpoints( iPlayerIndex );
		
		if ( medals[ iPlayerIndex ] >= 180 && !HasPermaIncrease( iPlayerIndex, "Infinite Reboot" ) )
			AddPermaIncrease( iPlayerIndex, 0, "Infinite Reboot", "Many would think that repeating every timeline\nover and over it's purposeless, and done only\nby maniacs.\n\nBut for this player, it's a day to day\nhabit of perseverance. A worthy achievement.\n\nAward for reaching 180 medals." );
		else if ( medals[ iPlayerIndex ] >= 42 && !HasPermaIncrease( iPlayerIndex, "The Answer" ) )
			AddPermaIncrease( iPlayerIndex, 36, "The Answer", "Everyone knows what this number is, but it is\nalso a distant memory from forgotten times.\n\nAward for reaching 42 medals." );
		
		pPlayer.KeyValue( "$i_ext_medals", "0" );
	}
	
	int iAddHammers = pKVD.GetKeyvalue( "$i_ext_hammers" ).GetInteger();
	if ( iAddHammers != 0 )
	{
		hammers[ iPlayerIndex ] += iAddHammers;
		
		pPlayer.KeyValue( "$i_ext_hammers", "0" );
	}
	
	string szAddPermaIncrease = pKVD.GetKeyvalue( "$s_ext_permaincrease" ).GetString();
	if ( szAddPermaIncrease.Length() > 0 )
	{
		string szPermaData = pKVD.GetKeyvalue( "$s_ext_permastring" ).GetString();
		if ( szPermaData.Length() > 0 )
		{
			int iPermaValue = pKVD.GetKeyvalue( "$i_ext_permavalue" ).GetInteger();
			
			if ( !HasPermaIncrease( iPlayerIndex, szAddPermaIncrease ) )
				AddPermaIncrease( iPlayerIndex, iPermaValue, szAddPermaIncrease, szPermaData );
		}
		
		pPlayer.KeyValue( "$s_ext_permaincrease", "" );
		pPlayer.KeyValue( "$s_ext_permastring", "" );
		pPlayer.KeyValue( "$i_ext_permavalue", "0" );
	}
}

// LoadEmptySkills
/* Initialize values for new player */
void LoadEmptySkills( const int iPlayerIndex )
{
	scxpm_calcneedxp( iPlayerIndex );
	
	playerBits[ iPlayerIndex ] = HUD_LEVEL | HUD_XPLEFT | HUD_MEDALS | HUD_ACHIEVEMENTS | HUD_SKILLS;
	
	hudPosition[ iPlayerIndex ].x = 0.5;
	hudPosition[ iPlayerIndex ].y = 0.04;
	
	hudColor[ iPlayerIndex ].r = 50;
	hudColor[ iPlayerIndex ].g = 135;
	hudColor[ iPlayerIndex ].b = 180;
	
	xpMultiplier[ iPlayerIndex ] = 1;
	
	firstplay[ iPlayerIndex ] = UnixTimestamp();
	nextdaily[ iPlayerIndex ] = uDateTime( UnixTimestamp() ) + ( 20 * 60 * 60 );
}

// ResetVars
/* Zero out all vars */
void ResetVars( const int iPlayerIndex )
{
	loaddata[ iPlayerIndex ] = false;
	lastfrags[ iPlayerIndex ] = 0.0;
	spectator[ iPlayerIndex ] = false;
	indexinspect[ iPlayerIndex ] = 0;
	
	lastBasicReset[ iPlayerIndex ] = 0.0;
	lastSpecialReset[ iPlayerIndex ] = 0.0;
	lastHandicapEdit[ iPlayerIndex ] = 0.0;
	
	xp[ iPlayerIndex ] = 0;
	earnedxp[ iPlayerIndex ] = 0;
	playerlevel[ iPlayerIndex ] = 0;
	medals[ iPlayerIndex ] = 0;
	
	playerBits[ iPlayerIndex ] = 0;
	playerHandicaps[ iPlayerIndex ] = 0;
	
	hudPosition[ iPlayerIndex ] = Vector2D( 0.0, 0.0 );
	hudColor[ iPlayerIndex ] = RGBA( g_vecZero, 0 );
	hudEffect[ iPlayerIndex ] = 0;
	
	health[ iPlayerIndex ] = 0;
	armor[ iPlayerIndex ] = 0;
	rhealth[ iPlayerIndex ] = 0;
	rarmor[ iPlayerIndex ] = 0;
	rammo[ iPlayerIndex ] = 0;
	gravity[ iPlayerIndex ] = 0;
	speed[ iPlayerIndex ] = 0;
	dist[ iPlayerIndex ] = 0;
	dodge[ iPlayerIndex ] = 0;
	
	spawndmg[ iPlayerIndex ] = 0;
	ubercharge[ iPlayerIndex ] = 0;
	fastheal[ iPlayerIndex ] = 0;
	demoman[ iPlayerIndex ] = 0;
	practiceshot[ iPlayerIndex ] = 0;
	bioelectric[ iPlayerIndex ] = 0;
	redcross[ iPlayerIndex ] = 0;
	
	skillpoints[ iPlayerIndex ] = 0;
	specialpoints[ iPlayerIndex ] = 0;
	
	forcedHandicaps[ iPlayerIndex ] = 0;
	savedHandicaps[ iPlayerIndex ] = -1;
	
	rarmorwait[ iPlayerIndex ] = 0.0;
	rhealthwait[ iPlayerIndex ] = 0.0;
	rammowait[ iPlayerIndex ] = 0.0;
	rmedkitwait[ iPlayerIndex ] = 0.0;
	
	xpMultiplier[ iPlayerIndex ] = 0;
	xpMultiplierTime[ iPlayerIndex ] = 0;
	xpModifiers[ iPlayerIndex ] = 0;
	
	firstplay[ iPlayerIndex ] = 0;
	
	nextdaily[ iPlayerIndex ] = 0;
	dailyget[ iPlayerIndex ] = 0;
	
	hammers[ iPlayerIndex ] = 0;
	
	for ( uint i = 0; i < playerAchievements[ iPlayerIndex ].length(); i++ )
	{
		playerAchievements[ iPlayerIndex ][ i ] = LOCKED;
	}
}

// CheckDaily
/* Checks if current time is within daily limits */
int CheckDaily( const int iPlayerIndex, uDateTime@ dtCurrentTime, uDateTime@ dtCheck )
{
	uTimeDifference tdCheck( dtCheck, dtCurrentTime );
	if ( tdCheck.GetTimeDifference() < 0 ) // Negative means current time is greater than last daily reward get.
	{
		uTimeDifference tdLostCheck( uDateTime( dtCheck.GetUnixTimestamp() + ( 168 * 60 * 60 ) ), dtCurrentTime ); // [ 168 * 60 * 60 ] = 7 days
		if ( tdLostCheck.GetTimeDifference() < 0 )
		{
			// Too lost in time, full reset
			return -1;
		}
		
		uTimeDifference tdLateCheck( uDateTime( dtCheck.GetUnixTimestamp() + ( 24 * 60 * 60 ) ), dtCurrentTime ); // [ 24 * 60 * 60 ] = 1 day
		if ( tdLateCheck.GetTimeDifference() < 0 )
		{
			// Not within 24 hours, try again.
			dtCurrentTime += ( 20 * 60 * 60 ); // ALMOST 1 day
			nextdaily[ iPlayerIndex ] = dtCurrentTime;
			return 0;
		}
		
		return 1;
	}
	
	return 0;
}

// GetAchievementMission
/* Gets and shows the objetive of an achievement in the user's language */
string GetAchievementMission( const int iAchievementID )
{
	string szReturn = "ERR_UNKNOWN_ACHIEVEMENT"; // default return string
	if ( iAchievementID >= int( gameAchievements.length() ) )
		return szReturn;
	
	array< string > A = gameAchievements[ iAchievementID ].Split( '#' );
	szReturn = A[ tDESCRIPTION ];
	
	if ( A[ tTYPE ] == LEGACY )
		szReturn += "\n\n\\rLEGACY ACHIEVEMENT:\\w Can no longer be adquired.";
	else if ( A[ tTYPE ] == HIDDEN )
		szReturn += "\n\n\\cHIDDEN ACHIEVEMENT:\\w Only you can see it.";
	
	return szReturn;
}

// GetAchievementClear
/* Returns how many achievements the player has unlocked */
int GetAchievementClear( const int iPlayerIndex )
{
	CBasePlayer@ pPlayer = g_PlayerFuncs.FindPlayerByIndex( iPlayerIndex );
	if ( pPlayer is null || !pPlayer.IsConnected() )
		return 0;
	
	int iClear = 0;
	for ( uint ID = 0; ID < gameAchievements.length(); ID++ )
	{
		if ( playerAchievements[ iPlayerIndex ][ ID ] != LOCKED )
			iClear++;
	}
	
	return iClear;
}

/** MENU HANDLERS **/
void SCXPMMenu( CBasePlayer@ pPlayer )
{
	const int iPlayerIndex = pPlayer.entindex();
	
	MenuHandler@ M = MenuGetPlayer( pPlayer );
	M.InitMenu( pPlayer, SCXPMMenu_CB );
	M.menu.SetTitle( "Main Menu\n" );
	
	const int SKILLS = skillpoints[ iPlayerIndex ];
	const int SPECIALS = specialpoints[ iPlayerIndex ];
	
	// Page 1
	M.menu.AddItem( ( SKILLS > 0 ? "\\g" : "" ) + "Skills\\w", any( 1 ) );
	M.menu.AddItem( ( SPECIALS > 0 ? "\\g" : "" ) + "Special Skills\\w\n", any( 2 ) );
	M.menu.AddItem( "\\oReset Skills\\w", any( 3 ) );
	M.menu.AddItem( "\\oReset Special Skills\\w\n", any( 4 ) );
	M.menu.AddItem( "Customize HUD\n", any( 5 ) );
	M.menu.AddItem( "Players Data\n", any( 6 ) );
	M.menu.AddItem( "My Character", any( 7 ) );
	
	// Page 2
	M.menu.AddItem( "\\cAchievements\\w", any( 8 ) );
	M.menu.AddItem( "XP Mods", any( 9 ) );
	M.menu.AddItem( "\\mHandicaps\\w\n", any( 10 ) );
	M.menu.AddItem( "\\oReset Level\\w", any( 11 ) );
	M.menu.AddItem( "\\oReset Medals\\w\n", any( 12 ) );
	M.menu.AddItem( "Daily Rewards\n", any( 13 ) );
	M.menu.AddItem( "\\yHelp and Info\\w", any( 14 ) );
	
	M.OpenMenu( pPlayer, 0, 0 );
}

void SCXPMMenu_CB( CTextMenu@ menu, CBasePlayer@ pPlayer, int page, const CTextMenuItem@ item )
{
	const int iPlayerIndex = pPlayer.entindex();
	if ( page == 10 ) return;
	
	int selection;
	item.m_pUserData.retrieve( selection );
	
	switch ( selection )
	{
		// Page 1
		case 1: g_Scheduler.SetTimeout( "SCXPMSkill", 0.000001, @pPlayer ); break;
		case 2: g_Scheduler.SetTimeout( "SCXPMSpecial", 0.000001, @pPlayer ); break;
		case 3: g_Scheduler.SetTimeout( "SCXPMResetBasic", 0.000001, @pPlayer, false ); break;
		case 4: g_Scheduler.SetTimeout( "SCXPMResetSpecial", 0.000001, @pPlayer, false ); break;
		case 5: g_Scheduler.SetTimeout( "SCXPMSettings", 0.000001, @pPlayer ); break;
		case 6: g_Scheduler.SetTimeout( "SCXPMOthers", 0.000001, @pPlayer ); break;
		case 7: g_Scheduler.SetTimeout( "SCXPMViewData", 0.000001, @pPlayer, pPlayer.entindex() ); break;
		// Page 2
		case 8: g_Scheduler.SetTimeout( "SCXPMAchievements", 0.000001, @pPlayer, 0, 0 ); break;
		case 9: g_Scheduler.SetTimeout( "SCXPMPermaIncrease", 0.000001, @pPlayer, 0, 0 ); break;
		case 10: g_Scheduler.SetTimeout( "SCXPMHandicaps", 0.000001, @pPlayer, 0 ); break;
		case 11: g_Scheduler.SetTimeout( "SCXPMLevelToMedal", 0.000001, @pPlayer ); break;
		case 12: g_Scheduler.SetTimeout( "SCXPMMedalToLevel", 0.000001, @pPlayer ); break;
		case 13: g_Scheduler.SetTimeout( "SCXPMDailyRewards", 0.000001, @pPlayer, 0 ); break;
		case 14: g_Scheduler.SetTimeout( "SCXPMHelpMenu", 0.000001, @pPlayer ); break;
	}
}

void SCXPMSkill( CBasePlayer@ pPlayer )
{
	const int iPlayerIndex = pPlayer.entindex();
	
	if ( skillpoints[ iPlayerIndex ] >= 25 )
		SCXPMIncrementMenu( pPlayer );
	else
		SCXPMSkillMenu( pPlayer );
}

void SCXPMIncrementMenu( CBasePlayer@ pPlayer )
{
	const int iPlayerIndex = pPlayer.entindex();
	
	MenuHandler@ M = MenuGetPlayer( pPlayer );
	
	M.InitMenu( pPlayer, SCXPMIncrementChoice );
	M.menu.SetTitle( "How many Skillpoints to use?\n\n" );
	
	M.menu.AddItem( "1 Skillpoint\n", any( 1 ) );
	M.menu.AddItem( "5 Skillpoint\n", any( 5 ) );
	M.menu.AddItem( "10 Skillpoint\n", any( 10 ) );
	M.menu.AddItem( "25 Skillpoint\n", any( 25 ) );
	
	if ( skillpoints[ iPlayerIndex ] >= 50 )
		M.menu.AddItem( "50 Skillpoint\n", any( 50 ) );
	
	if ( skillpoints[ iPlayerIndex ] >= 100 )
		M.menu.AddItem( "100 Skillpoint", any( 100 ) );
	
	M.OpenMenu( pPlayer, 0, 0 );
}

void SCXPMIncrementChoice( CTextMenu@ menu, CBasePlayer@ pPlayer, int page, const CTextMenuItem@ item )
{
	const int iPlayerIndex = pPlayer.entindex();
	if ( page == 10 ) return;
	
	int skillIncrement = 0;
	item.m_pUserData.retrieve( skillIncrement );
	
	g_Scheduler.SetTimeout( "SCXPMSkillMenu", 0.000001, @pPlayer, skillIncrement );
}

void SCXPMSkillMenu( CBasePlayer@ pPlayer, int skillIncrement = 1 )
{
	const int iPlayerIndex = pPlayer.entindex();
	
	MenuHandler@ M = MenuGetPlayer( pPlayer );
	M.InitMenu( pPlayer, SCXPMSkillChoice );
	
	// all this mess just for some colored numbers in the menu?
	const bool SKILLS_ENABLED = !IsBitSet( gameSettings, NO_SKILLS );
	const bool ANTIGRAV_ENABLED = !IsBitSet( gameSettings, NO_ANTIGRAV );
	
	const int MAX_1 = _MAX_SKILLS[ 0 ] + ( ubercharge[ iPlayerIndex ] * _MAX_EXTRA[ 0 ] ); // Strength
	const int MAX_2 = _MAX_SKILLS[ 1 ] + ( ubercharge[ iPlayerIndex ] * _MAX_EXTRA[ 1 ] ); // Superior Armor
	const int MAX_3 = _MAX_SKILLS[ 2 ] + ( ubercharge[ iPlayerIndex ] * _MAX_EXTRA[ 2 ] ); // Regeneration
	const int MAX_4 = _MAX_SKILLS[ 3 ] + ( ubercharge[ iPlayerIndex ] * _MAX_EXTRA[ 3 ] ); // Nano Armor
	const int MAX_5 = _MAX_SKILLS[ 4 ] + ( ubercharge[ iPlayerIndex ] * _MAX_EXTRA[ 4 ] ); // Ammo Reincarnation
	const int MAX_6 = _MAX_SKILLS[ 5 ] + ( ubercharge[ iPlayerIndex ] * _MAX_EXTRA[ 5 ] ); // Anti-Gravity Device
	const int MAX_7 = _MAX_SKILLS[ 6 ] + ( ubercharge[ iPlayerIndex ] * _MAX_EXTRA[ 6 ] ); // Awareness
	const int MAX_8 = _MAX_SKILLS[ 7 ] + ( ubercharge[ iPlayerIndex ] * _MAX_EXTRA[ 7 ] ); // Team Power
	const int MAX_9 = _MAX_SKILLS[ 8 ] + ( ubercharge[ iPlayerIndex ] * _MAX_EXTRA[ 8 ] ); // Block Attack
	
	const int CUR_1 = Math.clamp( 0, MAX_1, health[ iPlayerIndex ] );
	const int CUR_2 = Math.clamp( 0, MAX_2, armor[ iPlayerIndex ] );
	const int CUR_3 = Math.clamp( 0, MAX_3, rhealth[ iPlayerIndex ] );
	const int CUR_4 = Math.clamp( 0, MAX_4, rarmor[ iPlayerIndex ] );
	const int CUR_5 = Math.clamp( 0, MAX_5, rammo[ iPlayerIndex ] );
	const int CUR_6 = Math.clamp( 0, MAX_6, gravity[ iPlayerIndex ] );
	const int CUR_7 = Math.clamp( 0, MAX_7, speed[ iPlayerIndex ] );
	const int CUR_8 = Math.clamp( 0, MAX_8, dist[ iPlayerIndex ] );
	const int CUR_9 = Math.clamp( 0, MAX_9, dodge[ iPlayerIndex ] );
	
	string C1, C2, C3, C4, C5, C6, C7, C8, C9;
	if ( !SKILLS_ENABLED )
		C1 = C2 = C3 = C4 = C5 = C6 = C7 = C8 = C9 = "\\r";
	else if ( !ANTIGRAV_ENABLED )
		C6 = "\\r";
	
	if ( CUR_1 == MAX_1 ) C1 = "\\y";
	if ( CUR_2 == MAX_2 ) C2 = "\\y";
	if ( CUR_3 == MAX_3 ) C3 = "\\y";
	if ( CUR_4 == MAX_4 ) C4 = "\\y";
	if ( CUR_5 == MAX_5 ) C5 = "\\y";
	if ( ANTIGRAV_ENABLED && CUR_6 == MAX_6 ) C6 = "\\y";
	if ( CUR_7 == MAX_7 ) C7 = "\\y";
	if ( CUR_8 == MAX_8 ) C8 = "\\y";
	if ( CUR_9 == MAX_9 ) C9 = "\\y";
	
	if ( CUR_1 == 0 ) C1 = "\\d";
	if ( CUR_2 == 0 ) C2 = "\\d";
	if ( CUR_3 == 0 ) C3 = "\\d";
	if ( CUR_4 == 0 ) C4 = "\\d";
	if ( CUR_5 == 0 ) C5 = "\\d";
	if ( ANTIGRAV_ENABLED && CUR_6 == 0 ) C6 = "\\d";
	if ( CUR_7 == 0 ) C7 = "\\d";
	if ( CUR_8 == 0 ) C8 = "\\d";
	if ( CUR_9 == 0 ) C9 = "\\d";
	
	// now build the menu X_X
	string titletext = "Skills\n";
	titletext += "Available skillpoints: " + skillpoints[ iPlayerIndex ] + "\n\n";
	
	if ( !SKILLS_ENABLED ) titletext += "\\oAll skills\\w are \\rdisabled\\w\nPoints will have no effect on this map\n\n";
	if ( !ANTIGRAV_ENABLED ) titletext += "The \\oAnti-Gravity Device\\w skill is \\rdisabled\\w\nSuch points will have no effect on this map\n\n";
	
	string skill1text = "Strength [ " + C1 + CUR_1 + "\\w ]\n";
	string skill2text = "Superior Armor [ " + C2 + CUR_2 + "\\w ]\n";
	string skill3text = "Regeneration [ " + C3 + CUR_3 + "\\w ]\n";
	string skill4text = "Nano Armor [ " + C4 + CUR_4 + "\\w ]\n";
	string skill5text = "Ammo Reincarnation [ " + C5 + CUR_5 + "\\w ]\n";
	string skill6text = "Anti-Gravity Device [ " + C6 + CUR_6 + "\\w ]\n";
	string skill7text = "Awareness [ " + C7 + CUR_7 + "\\w ]\n";
	string skill8text = "Team Power [ " + C8 + CUR_8 + "\\w ]\n";
	string skill9text = "Block Attack [ " + C9 + CUR_9 + "\\w ]";
	
	M.menu.SetTitle( titletext );
	
	M.menu.AddItem( skill1text, any( skillIncrement ) );
	M.menu.AddItem( skill2text, any( skillIncrement ) );
	M.menu.AddItem( skill3text, any( skillIncrement ) );
	M.menu.AddItem( skill4text, any( skillIncrement ) );
	M.menu.AddItem( skill5text, any( skillIncrement ) );
	M.menu.AddItem( skill6text, any( skillIncrement ) );
	M.menu.AddItem( skill7text, any( skillIncrement ) );
	M.menu.AddItem( skill8text, any( skillIncrement ) );
	M.menu.AddItem( skill9text, any( skillIncrement ) );
	
	M.OpenMenu( pPlayer, 0, 0 );
}

void SCXPMSkillChoice( CTextMenu@ menu, CBasePlayer@ pPlayer, int page, const CTextMenuItem@ item )
{
	const int iPlayerIndex = pPlayer.entindex();
	if ( page == 10 ) return;
	
	if ( skillpoints[ iPlayerIndex ] == 0 )
	{
		g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "[SCXPM] You need at least 1 Skillpoint to enhance this skill.\n" );
		return;
	}
	
	const int MAX_1 = _MAX_SKILLS[ 0 ] + ( ubercharge[ iPlayerIndex ] * _MAX_EXTRA[ 0 ] ); // Strength
	const int MAX_2 = _MAX_SKILLS[ 1 ] + ( ubercharge[ iPlayerIndex ] * _MAX_EXTRA[ 1 ] ); // Superior Armor
	const int MAX_3 = _MAX_SKILLS[ 2 ] + ( ubercharge[ iPlayerIndex ] * _MAX_EXTRA[ 2 ] ); // Regeneration
	const int MAX_4 = _MAX_SKILLS[ 3 ] + ( ubercharge[ iPlayerIndex ] * _MAX_EXTRA[ 3 ] ); // Nano Armor
	const int MAX_5 = _MAX_SKILLS[ 4 ] + ( ubercharge[ iPlayerIndex ] * _MAX_EXTRA[ 4 ] ); // Ammo Reincarnation
	const int MAX_6 = _MAX_SKILLS[ 5 ] + ( ubercharge[ iPlayerIndex ] * _MAX_EXTRA[ 5 ] ); // Anti-Gravity Device
	const int MAX_7 = _MAX_SKILLS[ 6 ] + ( ubercharge[ iPlayerIndex ] * _MAX_EXTRA[ 6 ] ); // Awareness
	const int MAX_8 = _MAX_SKILLS[ 7 ] + ( ubercharge[ iPlayerIndex ] * _MAX_EXTRA[ 7 ] ); // Team Power
	const int MAX_9 = _MAX_SKILLS[ 8 ] + ( ubercharge[ iPlayerIndex ] * _MAX_EXTRA[ 8 ] ); // Block Attack
	
	int skillIncrement;
	item.m_pUserData.retrieve( skillIncrement );
	
	switch ( page )
	{
		case 1:
		{
			if ( health[ iPlayerIndex ] >= MAX_1 )
			{
				g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "[SCXPM] This skill is maxed out!\n" );
				g_Scheduler.SetTimeout( "SCXPMSkillMenu", 0.000001, @pPlayer, skillIncrement );
				return;
			}
			
			if ( skillIncrement + health[ iPlayerIndex ] >= MAX_1 )
				skillIncrement = MAX_1 - health[ iPlayerIndex ];
			
			skillpoints[ iPlayerIndex ] -= skillIncrement;
			health[ iPlayerIndex ] += skillIncrement;
			if ( IsBitSet( gameSettings, OVERPOWER ) ) pPlayer.pev.max_health += float( skillIncrement ) / 2.0;
			break;
		}
		case 2:
		{
			if ( armor[ iPlayerIndex ] >= MAX_2 )
			{
				g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "[SCXPM] This skill is maxed out!\n" );
				g_Scheduler.SetTimeout( "SCXPMSkillMenu", 0.000001, @pPlayer, skillIncrement );
				return;
			}
			
			if ( skillIncrement + armor[ iPlayerIndex ] >= MAX_2 )
				skillIncrement = MAX_2 - armor[ iPlayerIndex ];
			
			skillpoints[ iPlayerIndex ] -= skillIncrement;
			armor[ iPlayerIndex ] += skillIncrement;
			if ( IsBitSet( gameSettings, OVERPOWER ) ) pPlayer.pev.armortype += float( skillIncrement ) / 2.0;
			break;
		}
		case 3:
		{
			if ( rhealth[ iPlayerIndex ] >= MAX_3 )
			{
				g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "[SCXPM] This skill is maxed out!\n" );
				g_Scheduler.SetTimeout( "SCXPMSkillMenu", 0.000001, @pPlayer, skillIncrement );
				return;
			}
			
			if ( skillIncrement + rhealth[ iPlayerIndex ] >= MAX_3 )
				skillIncrement = MAX_3 - rhealth[ iPlayerIndex ];
			
			skillpoints[ iPlayerIndex ] -= skillIncrement;
			rhealth[ iPlayerIndex ] += skillIncrement;
			break;
		}
		case 4:
		{
			if ( rarmor[ iPlayerIndex ] >= MAX_4 )
			{
				g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "[SCXPM] This skill is maxed out!\n" );
				g_Scheduler.SetTimeout( "SCXPMSkillMenu", 0.000001, @pPlayer, skillIncrement );
				return;
			}
			
			if ( skillIncrement + rarmor[ iPlayerIndex ] >= MAX_4 )
				skillIncrement = MAX_4 - rarmor[ iPlayerIndex ];
			
			skillpoints[ iPlayerIndex ] -= skillIncrement;
			rarmor[ iPlayerIndex ] += skillIncrement;
			break;
		}
		case 5:
		{
			if ( rammo[ iPlayerIndex ] >= MAX_5 )
			{
				g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "[SCXPM] This skill is maxed out!\n" );
				g_Scheduler.SetTimeout( "SCXPMSkillMenu", 0.000001, @pPlayer, skillIncrement );
				return;
			}
			
			if ( skillIncrement + rammo[ iPlayerIndex ] >= MAX_5 )
				skillIncrement = MAX_5 - rammo[ iPlayerIndex ];
			
			skillpoints[ iPlayerIndex ] -= skillIncrement;
			rammo[ iPlayerIndex ] += skillIncrement;
			break;
		}
		case 6:
		{
			if ( gravity[ iPlayerIndex ] >= MAX_6 )
			{
				g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "[SCXPM] This skill is maxed out!\n" );
				g_Scheduler.SetTimeout( "SCXPMSkillMenu", 0.000001, @pPlayer, skillIncrement );
				return;
			}
			
			if ( skillIncrement + gravity[ iPlayerIndex ] >= MAX_6 )
				skillIncrement = MAX_6 - gravity[ iPlayerIndex ];
			
			skillpoints[ iPlayerIndex ] -= skillIncrement;
			gravity[ iPlayerIndex ] += skillIncrement;
			break;
		}
		case 7:
		{
			if ( speed[ iPlayerIndex ] >= MAX_7 )
			{
				g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "[SCXPM] This skill is maxed out!\n" );
				g_Scheduler.SetTimeout( "SCXPMSkillMenu", 0.000001, @pPlayer, skillIncrement );
				return;
			}
			
			if ( skillIncrement + speed[ iPlayerIndex ] >= MAX_7 )
				skillIncrement = MAX_7 - speed[ iPlayerIndex ];
			
			skillpoints[ iPlayerIndex ] -= skillIncrement;
			speed[ iPlayerIndex ] += skillIncrement;
			break;
		}
		case 8:
		{
			if ( dist[ iPlayerIndex ] >= MAX_8 )
			{
				g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "[SCXPM] This skill is maxed out!\n" );
				g_Scheduler.SetTimeout( "SCXPMSkillMenu", 0.000001, @pPlayer, skillIncrement );
				return;
			}
			
			if ( skillIncrement + dist[ iPlayerIndex ] >= MAX_8 )
				skillIncrement = MAX_8 - dist[ iPlayerIndex ];
			
			skillpoints[ iPlayerIndex ] -= skillIncrement;
			dist[ iPlayerIndex ] += skillIncrement;
			break;
		}
		case 9:
		{
			if ( dodge[ iPlayerIndex ] >= MAX_9 )
			{
				g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "[SCXPM] This skill is maxed out!\n" );
				g_Scheduler.SetTimeout( "SCXPMSkillMenu", 0.000001, @pPlayer, skillIncrement );
				return;
			}
			
			if ( skillIncrement + dodge[ iPlayerIndex ] >= MAX_9 )
				skillIncrement = MAX_9 - dodge[ iPlayerIndex ];
			
			skillpoints[ iPlayerIndex ] -= skillIncrement;
			dodge[ iPlayerIndex ] += skillIncrement;
			break;
		}
	}
	
	g_Scheduler.SetTimeout( "SCXPMSkill", 0.000001, @pPlayer );
}

void SCXPMSpecial( CBasePlayer@ pPlayer )
{
	const int iPlayerIndex = pPlayer.entindex();
	const int playerBITS = playerBits[ iPlayerIndex ];
	
	MenuHandler@ M = MenuGetPlayer( pPlayer );
	M.InitMenu( pPlayer, SCXPMSpecialChoice );
	
	// again?
	const bool SKILLS_ENABLED = !IsBitSet( gameSettings, NO_SKILLS );
	
	const int MAX_1 = _MAX_SPECIALS[ 0 ]; // Starting Attack
	const int MAX_3 = _MAX_SPECIALS[ 2 ]; // Ubercharge
	const int MAX_4 = _MAX_SPECIALS[ 3 ]; // Quick Heal
	const int MAX_5 = _MAX_SPECIALS[ 4 ]; // Demoman
	const int MAX_6 = _MAX_SPECIALS[ 5 ]; // Practice Shot
	const int MAX_7 = _MAX_SPECIALS[ 6 ]; // BioElectric
	const int MAX_9 = _MAX_SPECIALS[ 8 ]; // Red Cross
	
	const int CUR_1 = spawndmg[ iPlayerIndex ];
	const bool CUR_2 = IsBitSet( playerBITS, SKILL_DISPENCER );
	const int CUR_3 = ubercharge[ iPlayerIndex ];
	const int CUR_4 = fastheal[ iPlayerIndex ];
	const int CUR_5 = demoman[ iPlayerIndex ];
	const int CUR_6 = practiceshot[ iPlayerIndex ];
	const int CUR_7 = bioelectric[ iPlayerIndex ];
	const bool CUR_8 = IsBitSet( playerBITS, SKILL_RANGEHEAL );
	const int CUR_9 = redcross[ iPlayerIndex ];
	
	string C1, C2, C3, C4, C5, C6, C7, C8, C9;
	if ( !SKILLS_ENABLED )
		C1 = C2 = C3 = C4 = C5 = C6 = C7 = C8 = C9 = "\\r";
	
	if ( CUR_1 == MAX_1 ) C1 = "\\y";
	if ( CUR_2 ) C2 = "\\g";
	if ( CUR_3 == MAX_3 ) C3 = "\\y";
	if ( CUR_4 == MAX_4 ) C4 = "\\y";
	if ( CUR_5 == MAX_5 ) C5 = "\\y";
	if ( CUR_6 == MAX_6 ) C6 = "\\y";
	if ( CUR_7 == MAX_7 ) C7 = "\\y";
	if ( CUR_8 ) C8 = "\\g";
	if ( CUR_9 == MAX_9 ) C9 = "\\y";
	
	if ( CUR_1 == 0 ) C1 = "\\d";
	if ( !CUR_2 ) C2 = "\\d";
	if ( CUR_3 == 0 ) C3 = "\\d";
	if ( CUR_4 == 0 ) C4 = "\\d";
	if ( CUR_5 == 0 ) C5 = "\\d";
	if ( CUR_6 == 0 ) C6 = "\\d";
	if ( CUR_7 == 0 ) C7 = "\\d";
	if ( !CUR_8 ) C8 = "\\d";
	if ( CUR_9 == 0 ) C9 = "\\d";
	
	// *internal screaming*
	string titletext = "Special Skills\n";
	titletext += "Available skillpoints: " + specialpoints[ iPlayerIndex ] + "\n\n";
	
	if ( !SKILLS_ENABLED ) titletext += "\\oAll skills\\w are \\rdisabled\\w\nPoints will have no effect on this map\n\n";
	
	string skill2text = "Portable Dispencer ";
	skill2text += "[ " + C2 + ( CUR_2 ? "ON" : "OFF" ) + "\\w ]\n";
	
	string skill8text = "Medical Emergency ";
	skill8text += "[ " + C8 + ( CUR_8 ? "ON" : "OFF" ) + "\\w ]\n";
	
	string skill1text = "Starting Attack [ " + C1 + CUR_1 + "\\w ]\n";
	string skill3text = "Ubercharge [ " + C3 + CUR_3 + "\\w ]\n";
	string skill4text = "Quick Heal [ " + C4 + CUR_4 + "\\w ]\n";
	string skill5text = "Demoman [ " + C5 + CUR_5 + "\\w ]\n";
	string skill6text = "Practice Shot [ " + C6 + CUR_6 + "\\w ]\n";
	string skill7text = "BioElectric [ " + C7 + CUR_7 + "\\w ]\n";
	string skill9text = "Red Cross [ " + C9 + CUR_9 + "\\w ]";
	
	M.menu.SetTitle( titletext );
	
	M.menu.AddItem( skill1text, any( 1 ) );
	M.menu.AddItem( skill2text, any( 1 ) );
	M.menu.AddItem( skill3text, any( 1 ) );
	M.menu.AddItem( skill4text, any( 1 ) );
	M.menu.AddItem( skill5text, any( 1 ) );
	M.menu.AddItem( skill6text, any( 1 ) );
	M.menu.AddItem( skill7text, any( 1 ) );
	M.menu.AddItem( skill8text, any( 1 ) );
	M.menu.AddItem( skill9text, any( 1 ) );
	
	M.OpenMenu( pPlayer, 0, 0 );
}

void SCXPMSpecialChoice( CTextMenu@ menu, CBasePlayer@ pPlayer, int page, const CTextMenuItem@ item )
{
	const int iPlayerIndex = pPlayer.entindex();
	if ( page == 10 ) return;
	
	if ( specialpoints[ iPlayerIndex ] == 0 )
	{
		g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "[SCXPM] You need at least 1 Skillpoint to enhance this skill.\n" );
		return;
	}
	
	int skillIncrement;
	item.m_pUserData.retrieve( skillIncrement );
	
	switch ( page )
	{
		case 1:
		{
			if ( spawndmg[ iPlayerIndex ] >= _MAX_SPECIALS[ 0 ] )
			{
				g_Scheduler.SetTimeout( "SCXPMSpecial", 0.000001, @pPlayer );
				g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "[SCXPM] This skill is maxed out!\n" );
				return;
			}
			
			specialpoints[ iPlayerIndex ]--;
			spawndmg[ iPlayerIndex ]++;
			break;
		}
		case 2:
		{
			if ( IsBitSet( playerBits[ iPlayerIndex ], SKILL_DISPENCER ) )
			{
				g_Scheduler.SetTimeout( "SCXPMSpecial", 0.000001, @pPlayer );
				g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "[SCXPM] This skill is maxed out!\n" );
				return;
			}
			
			specialpoints[ iPlayerIndex ]--;
			playerBits[ iPlayerIndex ] |= SKILL_DISPENCER;
			break;
		}
		case 3:
		{
			if ( ubercharge[ iPlayerIndex ] >= _MAX_SPECIALS[ 2 ] )
			{
				g_Scheduler.SetTimeout( "SCXPMSpecial", 0.000001, @pPlayer );
				g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "[SCXPM] This skill is maxed out!\n" );
				return;
			}
			
			specialpoints[ iPlayerIndex ]--;
			ubercharge[ iPlayerIndex ]++;
			
			scxpm_calc_skillpoints( iPlayerIndex );
			break;
		}
		case 4:
		{
			if ( fastheal[ iPlayerIndex ] >= _MAX_SPECIALS[ 3 ] )
			{
				g_Scheduler.SetTimeout( "SCXPMSpecial", 0.000001, @pPlayer );
				g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "[SCXPM] This skill is maxed out!\n" );
				return;
			}
			
			specialpoints[ iPlayerIndex ]--;
			fastheal[ iPlayerIndex ]++;
			break;
		}
		case 5:
		{
			if ( demoman[ iPlayerIndex ] >= _MAX_SPECIALS[ 4 ] )
			{
				g_Scheduler.SetTimeout( "SCXPMSpecial", 0.000001, @pPlayer );
				g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "[SCXPM] This skill is maxed out!\n" );
				return;
			}
			
			specialpoints[ iPlayerIndex ]--;
			demoman[ iPlayerIndex ]++;
			break;
		}
		case 6:
		{
			if ( practiceshot[ iPlayerIndex ] >= _MAX_SPECIALS[ 5 ] )
			{
				g_Scheduler.SetTimeout( "SCXPMSpecial", 0.000001, @pPlayer );
				g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "[SCXPM] This skill is maxed out!\n" );
				return;
			}
			
			specialpoints[ iPlayerIndex ]--;
			practiceshot[ iPlayerIndex ]++;
			break;
		}
		case 7:
		{
			if ( bioelectric[ iPlayerIndex ] >= _MAX_SPECIALS[ 6 ] )
			{
				g_Scheduler.SetTimeout( "SCXPMSpecial", 0.000001, @pPlayer );
				g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "[SCXPM] This skill is maxed out!\n" );
				return;
			}
			
			specialpoints[ iPlayerIndex ]--;
			bioelectric[ iPlayerIndex ]++;
			break;
		}
		case 8:
		{
			if ( IsBitSet( playerBits[ iPlayerIndex ], SKILL_RANGEHEAL ) )
			{
				g_Scheduler.SetTimeout( "SCXPMSpecial", 0.000001, @pPlayer );
				g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "[SCXPM] This skill is maxed out!\n" );
				return;
			}
			
			specialpoints[ iPlayerIndex ]--;
			playerBits[ iPlayerIndex ] |= SKILL_RANGEHEAL;
			break;
		}
		case 9:
		{
			if ( redcross[ iPlayerIndex ] >= _MAX_SPECIALS[ 8 ] )
			{
				g_Scheduler.SetTimeout( "SCXPMSpecial", 0.000001, @pPlayer );
				g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "[SCXPM] This skill is maxed out!\n" );
				return;
			}
			
			specialpoints[ iPlayerIndex ]--;
			redcross[ iPlayerIndex ]++;
			
			if ( pPlayer.GetMaxAmmo( "health" ) > 0 )
			{
				pPlayer.SetMaxAmmo( "health", 100 + ( redcross[ iPlayerIndex ] * 20 ) );
				if ( HasHandicap( iPlayerIndex, HEALTH_CRISIS ) )
					pPlayer.SetMaxAmmo( "health", 50 + ( redcross[ iPlayerIndex ] * 10 ) );
			}
			break;
		}
	}
	
	g_Scheduler.SetTimeout( "SCXPMSpecial", 0.000001, @pPlayer );
}

void SCXPMResetBasic( CBasePlayer@ pPlayer, bool bSilent = false )
{
	const int iPlayerIndex = pPlayer.entindex();
	
	// No skills
	if ( IsBitSet( gameSettings, NO_SKILLS ) )
	{
		g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "[SCXPM] Skills are disabled on this map.\n" );
		return;
	}
	
	health[ iPlayerIndex ] = 0;
	armor[ iPlayerIndex ] = 0;
	rhealth[ iPlayerIndex ] = 0;
	rarmor[ iPlayerIndex ] = 0;
	rammo[ iPlayerIndex ] = 0;
	gravity[ iPlayerIndex ] = 0;
	speed[ iPlayerIndex ] = 0;
	dist[ iPlayerIndex ] = 0;
	dodge[ iPlayerIndex ] = 0;
	
	scxpm_calc_skillpoints( iPlayerIndex );
	lastBasicReset[ iPlayerIndex ] = g_Engine.time;
	
	const float MEDALS = Math.clamp( 0.0, 30.0, float( medals[ iPlayerIndex ] ) );
	
	const float HEALTH = starthealth + ( !HasHandicap( iPlayerIndex, LACKING_HELP ) ? MEDALS : 0.0 );
	const float ARMOR = startarmor + ( !HasHandicap( iPlayerIndex, LACKING_HELP ) ? MEDALS : 0.0 );
	
	if ( pPlayer.pev.health > HEALTH ) pPlayer.pev.health = HEALTH;
	if ( pPlayer.pev.armorvalue > ARMOR ) pPlayer.pev.armorvalue = ARMOR;
	
	if ( IsBitSet( gameSettings, OVERPOWER ) )
	{
		const float MAX_HEALTH = maxhealth + ( !HasHandicap( iPlayerIndex, LACKING_HELP ) ? MEDALS : 0.0 );
		const float MAX_ARMOR = maxarmor + ( !HasHandicap( iPlayerIndex, LACKING_HELP ) ? MEDALS : 0.0 );
		
		if ( pPlayer.pev.max_health > MAX_HEALTH ) pPlayer.pev.max_health = MAX_HEALTH;
		if ( pPlayer.pev.armortype > MAX_HEALTH ) pPlayer.pev.armortype = MAX_HEALTH;
	}
	
	pPlayer.pev.gravity = 1.0;
	
	if ( bSilent )
		return;
	
	if ( skillpoints[ iPlayerIndex ] == 0 )
	{
		g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "[SCXPM] No skills to reset.\n" );
		return;
	}
	
	g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "[SCXPM] Your skills has been reset.\n" );
	SCXPMSkill( pPlayer );
}

void SCXPMResetSpecial( CBasePlayer@ pPlayer, bool bSilent = false )
{
	const int iPlayerIndex = pPlayer.entindex();
	
	// No skills
	if ( IsBitSet( gameSettings, NO_SKILLS ) )
	{
		g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "[SCXPM] Skills are disabled on this map.\n" );
		return;
	}
	
	spawndmg[ iPlayerIndex ] = 0;
	ubercharge[ iPlayerIndex ] = 0;
	fastheal[ iPlayerIndex ] = 0;
	demoman[ iPlayerIndex ] = 0;
	practiceshot[ iPlayerIndex ] = 0;
	bioelectric[ iPlayerIndex ] = 0;
	redcross[ iPlayerIndex ] = 0;
	playerBits[ iPlayerIndex ] &= ~SKILL_DISPENCER;
	playerBits[ iPlayerIndex ] &= ~SKILL_RANGEHEAL;
	
	// Don't restore medkit ammo if the map disables its regen
	if ( pPlayer.GetMaxAmmo( "health" ) > 0 )
	{
		pPlayer.SetMaxAmmo( "health", 100 );
		pPlayer.RemoveExcessAmmo( "health" ); // Prevent overflow
	}
	
	int iExcessPoints = 0;
	
	// calculate any excess points from ubercharge
	if ( health[ iPlayerIndex ] > _MAX_SKILLS[ 0 ] ) iExcessPoints += health[ iPlayerIndex ] - _MAX_SKILLS[ 0 ];
	if ( armor[ iPlayerIndex ] > _MAX_SKILLS[ 1 ] ) iExcessPoints += armor[ iPlayerIndex ] - _MAX_SKILLS[ 1 ];
	if ( rhealth[ iPlayerIndex ] > _MAX_SKILLS[ 2 ] ) iExcessPoints += rhealth[ iPlayerIndex ] - _MAX_SKILLS[ 2 ];
	if ( rarmor[ iPlayerIndex ] > _MAX_SKILLS[ 3 ] ) iExcessPoints += rarmor[ iPlayerIndex ] - _MAX_SKILLS[ 3 ];
	if ( rammo[ iPlayerIndex ] > _MAX_SKILLS[ 4 ] ) iExcessPoints += rammo[ iPlayerIndex ] - _MAX_SKILLS[ 4 ];
	if ( gravity[ iPlayerIndex ] > _MAX_SKILLS[ 5 ] ) iExcessPoints += gravity[ iPlayerIndex ] - _MAX_SKILLS[ 5 ];
	if ( speed[ iPlayerIndex ] > _MAX_SKILLS[ 6 ] ) iExcessPoints += speed[ iPlayerIndex ] - _MAX_SKILLS[ 6 ];
	if ( dist[ iPlayerIndex ] > _MAX_SKILLS[ 7 ] ) iExcessPoints += dist[ iPlayerIndex ] - _MAX_SKILLS[ 7 ];
	if ( dodge[ iPlayerIndex ] > _MAX_SKILLS[ 8 ] ) iExcessPoints += dodge[ iPlayerIndex ] - _MAX_SKILLS[ 8 ];
	
	// clamp basic skills if ubercharge was active
	health[ iPlayerIndex ] = Math.clamp( 0, _MAX_SKILLS[ 0 ], health[ iPlayerIndex ] );
	armor[ iPlayerIndex ] = Math.clamp( 0, _MAX_SKILLS[ 1 ], armor[ iPlayerIndex ] );
	rhealth[ iPlayerIndex ] = Math.clamp( 0, _MAX_SKILLS[ 2 ], rhealth[ iPlayerIndex ] );
	rarmor[ iPlayerIndex ] = Math.clamp( 0, _MAX_SKILLS[ 3 ], rarmor[ iPlayerIndex ] );
	rammo[ iPlayerIndex ] = Math.clamp( 0, _MAX_SKILLS[ 4 ], rammo[ iPlayerIndex ] );
	gravity[ iPlayerIndex ] = Math.clamp( 0, _MAX_SKILLS[ 5 ], gravity[ iPlayerIndex ] );
	speed[ iPlayerIndex ] = Math.clamp( 0, _MAX_SKILLS[ 6 ], speed[ iPlayerIndex ] );
	dist[ iPlayerIndex ] = Math.clamp( 0, _MAX_SKILLS[ 7 ], dist[ iPlayerIndex ] );
	dodge[ iPlayerIndex ] = Math.clamp( 0, _MAX_SKILLS[ 8 ], dodge[ iPlayerIndex ] );
	
	skillpoints[ iPlayerIndex ] += iExcessPoints;
	scxpm_calc_specialpoints( iPlayerIndex );
	lastSpecialReset[ iPlayerIndex ] = 0.0;
	
	if ( bSilent )
		return;
	
	if ( specialpoints[ iPlayerIndex ] == 0 )
	{
		g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "[SCXPM] No special skills to reset.\n" );
		return;
	}
	
	g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "[SCXPM] Your special skills has been reset.\n" );
	SCXPMSpecial( pPlayer );
}

void SCXPMSettings( CBasePlayer@ pPlayer )
{
	const int iPlayerIndex = pPlayer.entindex();
	
	MenuHandler@ M = MenuGetPlayer( pPlayer );
	
	M.InitMenu( pPlayer, SCXPMSettings_CB );
	M.menu.SetTitle( "Customize HUD\n\n" );
	
	string opaquetext = "Opaque HUD? ";
	opaquetext += "[ " + ( hudColor[ iPlayerIndex ].a == 255 ? "\\gON" : "\\dOFF" ) + "\\w ]\n";
	
	M.menu.AddItem( "Color\n" );
	M.menu.AddItem( "Position\n" );
	M.menu.AddItem( opaquetext );
	M.menu.AddItem( "Effect\n" );
	M.menu.AddItem( "Show/Hide Visuals" );
	
	M.OpenMenu( pPlayer, 0, 0 );
}

void SCXPMSettings_CB( CTextMenu@ menu, CBasePlayer@ pPlayer, int page, const CTextMenuItem@ item )
{
	int iPlayerIndex = pPlayer.entindex();
	if ( page == 10 ) return;
	
	switch ( page )
	{
		case 1: g_Scheduler.SetTimeout( "SCXPMSettingsColor", 0.000001, @pPlayer ); break;
		case 2: g_Scheduler.SetTimeout( "SCXPMSettingsPosition", 0.000001, @pPlayer ); break;
		case 3:
		{
			hudColor[ iPlayerIndex ].a = ~hudColor[ iPlayerIndex ].a;
			g_Scheduler.SetTimeout( "SCXPMSettings", 0.000001, @pPlayer );
			break;
		}
		case 4: g_Scheduler.SetTimeout( "SCXPMSettingsEffect", 0.000001, @pPlayer ); break;
		case 5: g_Scheduler.SetTimeout( "SCXPMSettingsVisuals", 0.000001, @pPlayer ); break;
	}
}

void SCXPMSettingsColor( CBasePlayer@ pPlayer )
{
	const int iPlayerIndex = pPlayer.entindex();
	
	MenuHandler@ M = MenuGetPlayer( pPlayer );
	
	M.InitMenu( pPlayer, SCXPMSettingsColor_CB );
	M.menu.SetTitle( "Color\n\n" );
	
	M.menu.AddItem( "Default\n" );
	M.menu.AddItem( "White" );
	M.menu.AddItem( "Red" );
	M.menu.AddItem( "Green" );
	M.menu.AddItem( "Blue" );
	M.menu.AddItem( "Yellow" );
	M.menu.AddItem( "Magenta" );
	M.menu.AddItem( "Cyan\n" );
	M.menu.AddItem( "Custom color\n" );
	
	M.OpenMenu( pPlayer, 0, 0 );
}

void SCXPMSettingsColor_CB( CTextMenu@ menu, CBasePlayer@ pPlayer, int page, const CTextMenuItem@ item )
{
	const int iPlayerIndex = pPlayer.entindex();
	if ( page == 10 )
	{
		g_Scheduler.SetTimeout( "SCXPMSettings", 0.000001, @pPlayer );
		return;
	}
	
	switch ( page )
	{
		case 1: // Default
		{
			hudColor[ iPlayerIndex ].r = 50;
			hudColor[ iPlayerIndex ].g = 135;
			hudColor[ iPlayerIndex ].b = 180;
			break;
		}
		case 2: // White
		{
			hudColor[ iPlayerIndex ].r = 250;
			hudColor[ iPlayerIndex ].g = 250;
			hudColor[ iPlayerIndex ].b = 250;
			break;
		}
		case 3: // Red
		{
			hudColor[ iPlayerIndex ].r = 250;
			hudColor[ iPlayerIndex ].g = 10;
			hudColor[ iPlayerIndex ].b = 10;
			break;
		}
		case 4: // Green
		{
			hudColor[ iPlayerIndex ].r = 10;
			hudColor[ iPlayerIndex ].g = 250;
			hudColor[ iPlayerIndex ].b = 10;
			break;
		}
		case 5: // Blue
		{
			hudColor[ iPlayerIndex ].r = 10;
			hudColor[ iPlayerIndex ].g = 10;
			hudColor[ iPlayerIndex ].b = 250;
			break;
		}
		case 6: // Yellow
		{
			hudColor[ iPlayerIndex ].r = 250;
			hudColor[ iPlayerIndex ].g = 250;
			hudColor[ iPlayerIndex ].b = 10;
			break;
		}
		case 7: // Magenta
		{
			hudColor[ iPlayerIndex ].r = 250;
			hudColor[ iPlayerIndex ].g = 10;
			hudColor[ iPlayerIndex ].b = 250;
			break;
		}
		case 8: // Cyan
		{
			hudColor[ iPlayerIndex ].r = 10;
			hudColor[ iPlayerIndex ].g = 250;
			hudColor[ iPlayerIndex ].b = 250;
			break;
		}
		case 9: // Custom
		{
			g_Scheduler.SetTimeout( "SCXPMSettingsColorCustom", 0.000001, @pPlayer );
			return;
		}
	}
	
	g_Scheduler.SetTimeout( "SCXPMSettingsColor", 0.000001, @pPlayer );
}

void SCXPMSettingsColorCustom( CBasePlayer@ pPlayer )
{
	const int iPlayerIndex = pPlayer.entindex();
	
	MenuHandler@ M = MenuGetPlayer( pPlayer );
	
	M.InitMenu( pPlayer, SCXPMSettingsColorCustom_CB );
	
	string szTitle = "Custom color\n\n";
	
	string szInfo = "\\yType\\w now the \\oRGB Color Code\\w of your choice\nthen \\ypress ENTER\\w to confirm\n\n";
	szInfo += "Not working?\nUse the \\dPrompt\\w button to re-type\n\n";
	szInfo += "\\dExample for an orange colored HUD:\n255 128 0\\w\n";
	
	M.menu.SetTitle( szTitle + szInfo );
	
	M.menu.AddItem( "Prompt" );
	
	M.OpenMenu( pPlayer, 0, 0 );
	
	ClientCMD( pPlayer, "messagemode .RGBColor" );
	g_SoundSystem.EmitSoundDyn( pPlayer.edict(), CHAN_STATIC, "buttons/blip2.wav", VOL_NORM, ATTN_NONE, SND_SKIP_ORIGIN_USE_ENT, PITCH_NORM, iPlayerIndex );
}

void SCXPMSettingsColorCustom_CB( CTextMenu@ menu, CBasePlayer@ pPlayer, int page, const CTextMenuItem@ item )
{
	const int iPlayerIndex = pPlayer.entindex();
	if ( page == 10 )
	{
		g_Scheduler.SetTimeout( "SCXPMSettingsColor", 0.000001, @pPlayer );
		return;
	}
	
	g_Scheduler.SetTimeout( "SCXPMSettingsColorCustom", 0.000001, @pPlayer );
}

CClientCommand _PLAYER_SETCOLOR( "RGBColor", " - Sets custom HUD color.", @PLAYER_SETCOLOR, ConCommandFlag::None );
void PLAYER_SETCOLOR( const CCommand@ pArgs )
{
	CBasePlayer@ pPlayer = g_ConCommandSystem.GetCurrentPlayer();
	const int iPlayerIndex = pPlayer.entindex();
	
	uint R, G, B;
	array< string > COLOR;
	
	// writen from say (messagemode) passes the entire string as a single parameter
	if ( pArgs.ArgC() == 2 && ( COLOR = pArgs[ 1 ].Split( ' ' ) ).length() == 3 )
	{
		R = Math.clamp( 0, 255, atoui( COLOR[ 0 ] ) );
		G = Math.clamp( 0, 255, atoui( COLOR[ 1 ] ) );
		B = Math.clamp( 0, 255, atoui( COLOR[ 2 ] ) );
	}
	else if ( pArgs.ArgC() >= 4 )
	{
		R = Math.clamp( 0, 255, atoui( pArgs[ 1 ] ) );
		G = Math.clamp( 0, 255, atoui( pArgs[ 2 ] ) );
		B = Math.clamp( 0, 255, atoui( pArgs[ 3 ] ) );
	}
	else
	{
		g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "[SCXPM] Must have 3 components.\n" );
		ClientCMD( pPlayer, "messagemode .RGBColor" );
		g_SoundSystem.EmitSoundDyn( pPlayer.edict(), CHAN_STATIC, "buttons/button10.wav", VOL_NORM, ATTN_NONE, SND_SKIP_ORIGIN_USE_ENT, PITCH_NORM, iPlayerIndex );
		return;
	}
	
	hudColor[ iPlayerIndex ].r = R;
	hudColor[ iPlayerIndex ].g = G;
	hudColor[ iPlayerIndex ].b = B;
	
	g_SoundSystem.EmitSoundDyn( pPlayer.edict(), CHAN_STATIC, "buttons/button3.wav", VOL_NORM, ATTN_NONE, SND_SKIP_ORIGIN_USE_ENT, PITCH_NORM, iPlayerIndex );
	g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "[SCXPM] Custom color set!\n" );
}

void SCXPMSettingsPosition( CBasePlayer@ pPlayer )
{
	const int iPlayerIndex = pPlayer.entindex();
	
	MenuHandler@ M = MenuGetPlayer( pPlayer );
	
	M.InitMenu( pPlayer, SCXPMSettingsPosition_CB );
	M.menu.SetTitle( "Position\n\n" );
	
	M.menu.AddItem( "Default\n\n" );
	M.menu.AddItem( "Move up\n" );
	M.menu.AddItem( "Move down\n" );
	M.menu.AddItem( "Move left\n" );
	M.menu.AddItem( "Move right" );
	
	M.OpenMenu( pPlayer, 0, 0 );
}

void SCXPMSettingsPosition_CB( CTextMenu@ menu, CBasePlayer@ pPlayer, int page, const CTextMenuItem@ item )
{
	const int iPlayerIndex = pPlayer.entindex();
	if ( page == 10 )
	{
		g_Scheduler.SetTimeout( "SCXPMSettings", 0.000001, @pPlayer );
		return;
	}
	
	switch ( page )
	{
		case 1:
		{
			hudPosition[ iPlayerIndex ].x = 0.5;
			hudPosition[ iPlayerIndex ].y = 0.04;
			break;
		}
		case 2: hudPosition[ iPlayerIndex ].y -= 0.01; break;
		case 3: hudPosition[ iPlayerIndex ].y += 0.01; break;
		case 4: hudPosition[ iPlayerIndex ].x -= 0.01; break;
		case 5: hudPosition[ iPlayerIndex ].x += 0.01; break;
	}
	
	g_Scheduler.SetTimeout( "SCXPMSettingsPosition", 0.000001, @pPlayer );
}

void SCXPMSettingsEffect( CBasePlayer@ pPlayer )
{
	const int iPlayerIndex = pPlayer.entindex();
	
	MenuHandler@ M = MenuGetPlayer( pPlayer );
	
	M.InitMenu( pPlayer, SCXPMSettingsEffect_CB );
	M.menu.SetTitle( "Effect\n\n" );
	
	M.menu.AddItem( "None\n" );
	M.menu.AddItem( "Blinking\n" );
	M.menu.AddItem( "Multicolored\n" );
	
	M.OpenMenu( pPlayer, 0, 0 );
}

void SCXPMSettingsEffect_CB( CTextMenu@ menu, CBasePlayer@ pPlayer, int page, const CTextMenuItem@ item )
{
	const int iPlayerIndex = pPlayer.entindex();
	if ( page == 10 )
	{
		g_Scheduler.SetTimeout( "SCXPMSettings", 0.000001, @pPlayer );
		return;
	}
	
	switch ( page )
	{
		case 1: hudEffect[ iPlayerIndex ] = 0; break;
		case 2: hudEffect[ iPlayerIndex ] = 1; break;
		case 3: hudEffect[ iPlayerIndex ] = 2; break;
	}
	
	g_Scheduler.SetTimeout( "SCXPMSettingsEffect", 0.000001, @pPlayer );
}

void SCXPMSettingsVisuals( CBasePlayer@ pPlayer )
{
	const int iPlayerIndex = pPlayer.entindex();
	const int playerBITS = playerBits[ iPlayerIndex ];
	
	MenuHandler@ M = MenuGetPlayer( pPlayer );
	
	M.InitMenu( pPlayer, SCXPMSettingsVisuals_CB );
	M.menu.SetTitle( "Show/Hide Visuals\n\n" );
	
	string view1 = "Show XP? ";
	view1 += "[ " + ( IsBitSet( playerBITS, HUD_XP ) ? "\\gON" : "\\dOFF" ) + "\\w ]\n";
	
	string view2 = "Show level? ";
	view2 += "[ " + ( IsBitSet( playerBITS, HUD_LEVEL ) ? "\\gON" : "\\dOFF" ) + "\\w ]\n";
	
	string view3 = "Show remaining XP? ";
	view3 += "[ " + ( IsBitSet( playerBITS, HUD_XPLEFT ) ? "\\gON" : "\\dOFF" ) + "\\w ]\n";
	
	string view4 = "Show earned XP? ";
	view4 += "[ " + ( IsBitSet( playerBITS, HUD_XPEARN ) ? "\\gON" : "\\dOFF" ) + "\\w ]\n";
	
	string view5 = "Show medals? ";
	view5 += "[ " + ( IsBitSet( playerBITS, HUD_MEDALS ) ? "\\gON" : "\\dOFF" ) + "\\w ]\n";
	
	string view6 = "Show unlocked achievements? ";
	view6 += "[ " + ( IsBitSet( playerBITS, HUD_ACHIEVEMENTS ) ? "\\gON" : "\\dOFF" ) + "\\w ]\n";
	
	string view7 = "Notify unspent skillpoints? ";
	view7 += "[ " + ( IsBitSet( playerBITS, HUD_SKILLS ) ? "\\gON" : "\\dOFF" ) + "\\w ]\n";
	
	string view8 = "Open skill menu upon level up? ";
	view8 += "[ " + ( !IsBitSet( playerBITS, MENU_NOAUTOOPEN ) ? "\\gON" : "\\dOFF" ) + "\\w ]\n";
	
	M.menu.AddItem( view1 );
	M.menu.AddItem( view2 );
	M.menu.AddItem( view3 );
	M.menu.AddItem( view4 );
	M.menu.AddItem( view5 );
	M.menu.AddItem( view6 );
	M.menu.AddItem( view7 );
	M.menu.AddItem( view8 );
	
	M.OpenMenu( pPlayer, 0, 0 );
}

void SCXPMSettingsVisuals_CB( CTextMenu@ menu, CBasePlayer@ pPlayer, int page, const CTextMenuItem@ item )
{
	const int iPlayerIndex = pPlayer.entindex();
	if ( page == 10 )
	{
		g_Scheduler.SetTimeout( "SCXPMSettings", 0.000001, @pPlayer );
		return;
	}
	
	switch ( page )
	{
		case 1: playerBits[ iPlayerIndex ] ^= HUD_XP; break;
		case 2: playerBits[ iPlayerIndex ] ^= HUD_LEVEL; break;
		case 3: playerBits[ iPlayerIndex ] ^= HUD_XPLEFT; break;
		case 4: playerBits[ iPlayerIndex ] ^= HUD_XPEARN; break;
		case 5: playerBits[ iPlayerIndex ] ^= HUD_MEDALS; break;
		case 6: playerBits[ iPlayerIndex ] ^= HUD_ACHIEVEMENTS; break;
		case 7: playerBits[ iPlayerIndex ] ^= HUD_SKILLS; break;
		case 8: playerBits[ iPlayerIndex ] ^= MENU_NOAUTOOPEN; break;
	}
	
	g_Scheduler.SetTimeout( "SCXPMSettingsVisuals", 0.000001, @pPlayer );
}

void SCXPMOthers( CBasePlayer@ pPlayer )
{
	const int iPlayerIndex = pPlayer.entindex();
	
	string data = "Player               Level    Medals\n\n";
	
	for ( int otherIndex = 1; otherIndex <= g_Engine.maxClients; otherIndex++ )
	{
		CBasePlayer@ otherPlayer = g_PlayerFuncs.FindPlayerByIndex( otherIndex );
		if ( otherPlayer is null || !otherPlayer.IsConnected() )
			continue;
		
		string NAME = otherPlayer.pev.netname;
		if ( NAME.Length() > 20 )
		{
			// Restrict names to 20 characters
			NAME.Truncate( 20 );
		}
		
		int toadd = 24 - NAME.Length();
		
		// workaround for string->Resize() no longer working
		string spaces = "???????????????????????";
		for ( int i = 0; i < toadd; i++ )
		{
			spaces.SetCharAt( i, char( " " ) );
		}
		spaces.Replace( "?", "" );
		
		//string spaces = "                   ";
		//spaces.Resize( toadd );
		
		data += NAME + spaces + AddCommas( playerlevel[ otherIndex ] ) + "       " + medals[ otherIndex ] + "\n";
	}
	
	data += "\nTo see detailed player info, use chat command: '/inspect <Player>'";
	
	ShowMOTD( pPlayer, "Players Data", data );
}

void SCXPMViewData( CBasePlayer@ pPlayer, const int iPlayerInspect = 0 )
{
	const int iPlayerIndex = pPlayer.entindex();
	
	CBasePlayer@ pTarget = ( iPlayerInspect > 0 ? g_PlayerFuncs.FindPlayerByIndex( iPlayerInspect ) : @pPlayer );
	const int iTargetIndex = pTarget.entindex();
	
	MenuHandler@ M = MenuGetPlayer( pPlayer );
	M.InitMenu( pPlayer, SCXPMViewData_CB );
	
	indexinspect[ iPlayerIndex ] = pTarget.entindex();
	
	// Name and SteamID
	string title = string( pTarget.pev.netname ) + "\n";
	title += "\\d" + g_EngineFuncs.GetPlayerAuthId( pTarget.edict() ) + "\\w\n\n";
	
	// Level and Medals
	title += "Level: \\y" + AddCommas( playerlevel[ iTargetIndex ] ) + "\\w\n";
	title += "Medals: \\o" + AddCommas( medals[ iTargetIndex ] ) + "\\w\n\n";
	
	// Number of achievements
	const int NUM_CLEAR = GetAchievementClear( iTargetIndex );
	string COLOR = "\\d";
	if ( NUM_CLEAR >= gameMaxAchievements ) COLOR = "\\y";
	else if ( NUM_CLEAR > gameNormalAchievements ) COLOR = "\\c";
	else if ( NUM_CLEAR == gameNormalAchievements ) COLOR = "\\o";
	else if ( NUM_CLEAR > 0 ) COLOR = "\\g";
	
	title += "Achievements: " + COLOR + NUM_CLEAR + "\\w of " + gameNormalAchievements + " completed\n";
	
	// Total percent of all XP Mods
	if ( xpModifiers[ iTargetIndex ] > 0 ) COLOR = "\\y";
	else if ( xpModifiers[ iTargetIndex ] < 0 ) COLOR = "\\r";
	else COLOR = "\\d";
	
	title += "XP Mods: " + COLOR + ( xpModifiers[ iTargetIndex ] > 0 ? "+" : "" ) + xpModifiers[ iTargetIndex ] + "%\\w\n\n";
	
	// Date of first play
	title += "First play ever was on \\o" + GetDate( firstplay[ iTargetIndex ] ) + "\\w\n";
	
	// Total daily rewards adquired
	if ( dailyget[ iTargetIndex ] > 0 ) COLOR = "\\y";
	else COLOR = "\\d";
	title += "Daily rewards get: " + COLOR + dailyget[ iTargetIndex ] + "\\w\n";
	
	M.menu.SetTitle( title );
	M.menu.AddItem( ( pPlayer !is pTarget ? "View player achievements" : "Achievements" ), any( 1 ) );
	M.menu.AddItem( ( pPlayer !is pTarget ? "View player XP Mods" : "XP Mods" ) + "\n", any( 2 ) );
	if ( pPlayer !is pTarget ) M.menu.AddItem( "My Character", any( 3 ) );
	
	M.OpenMenu( pPlayer, 0, 0 );
}

void SCXPMViewData_CB( CTextMenu@ menu, CBasePlayer@ pPlayer, int page, const CTextMenuItem@ item )
{
	int iPlayerIndex = pPlayer.entindex();
	if ( page == 10 ) return;
	
	int selection;
	item.m_pUserData.retrieve( selection );
	
	switch ( selection )
	{
		case 1: g_Scheduler.SetTimeout( "SCXPMAchievements", 0.000001, @pPlayer, 0, indexinspect[ iPlayerIndex ] ); break;
		case 2: g_Scheduler.SetTimeout( "SCXPMPermaIncrease", 0.000001, @pPlayer, 0, indexinspect[ iPlayerIndex ] ); break;
		case 3: g_Scheduler.SetTimeout( "SCXPMViewData", 0.000001, @pPlayer, iPlayerIndex ); break;
	}
}

void SCXPMAchievements( CBasePlayer@ pPlayer, const int iPage = 0, const int iPlayerInspect = 0 )
{
	const int iPlayerIndex = pPlayer.entindex();
	
	if ( iPlayerInspect > 0 )
	{
		CBasePlayer@ pInspect = g_PlayerFuncs.FindPlayerByIndex( iPlayerInspect );
		if ( pInspect is null )
		{
			g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "[SCXPM] Player not found.\n" );
			return;
		}
	}
	
	MenuHandler@ M = MenuGetPlayer( pPlayer );
	
	M.InitMenu( pPlayer, SCXPMAchievements_CB );
	
	string title = "Achievements\n\n";
	M.menu.SetTitle( title );
	
	if ( iPlayerInspect > 0 )
		GetAchievementData( iPlayerInspect, M );
	else
	{
		indexinspect[ iPlayerIndex ] = 0;
		GetAchievementData( iPlayerIndex, M );
	}
	
	M.OpenMenu( pPlayer, 0, iPage );
}

void SCXPMAchievements_CB( CTextMenu@ menu, CBasePlayer@ pPlayer, int page, const CTextMenuItem@ item )
{
	const int iPlayerIndex = pPlayer.entindex();
	if ( page == 10 ) return;
	
	string rawData;
	item.m_pUserData.retrieve( rawData );
	
	array< string > menuData = rawData.Split( '#' );
	
	int iAchievementID = atoi( menuData[ 0 ] );
	int iMenuID = atoi( menuData[ 1 ] );
	
	g_Scheduler.SetTimeout( "SCXPMAchievementsInfo", 0.000001f, @pPlayer, iAchievementID, indexinspect[ iPlayerIndex ], ( iMenuID / 7 ) );
}

void SCXPMAchievementsInfo( CBasePlayer@ pPlayer, const int iAchievementID, const int iInspect = 0, const int iPage = 0 )
{
	const int iPlayerIndex = pPlayer.entindex();
	
	if ( iInspect > 0 )
	{
		CBasePlayer@ pInspect = g_PlayerFuncs.FindPlayerByIndex( iInspect );
		if ( pInspect is null )
		{
			g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "[SCXPM] Player not found.\n" );
			return;
		}
	}
	
	MenuHandler@ M = MenuGetPlayer( pPlayer );
	M.InitMenu( pPlayer, SCXPMAchievementsInfo_CB );
	
	array< string > A = gameAchievements[ iAchievementID ].Split( '#' );
	
	string title = A[ tNAME ] + "\n\n";
	string reward = "\\o???"; // OTHER
	switch ( atoi( A[ tREWARD ] ) )
	{
		case NONE: reward = "\\dNone\\w"; break;
		case XP: reward = A[ tBOUNTY ] + " XP"; break;
		case MEDAL: reward = A[ tBOUNTY ] + " Medals"; break;
		case MULTIPLIER_2: reward = "2x Multiplier [" + A[ tBOUNTY ] + " minutes]"; break;
		case MULTIPLIER_3: reward = "3x Multiplier [" + A[ tBOUNTY ] + " minutes]"; break;
		case MULTIPLIER_4: reward = "4x Multiplier [" + A[ tBOUNTY ] + " minutes]"; break;
		case MODIFIER: reward = "XP Mod +" + A[ tBOUNTY ] + "%"; break;
		case GOLDEN_HAMMER: reward = A[ tBOUNTY ] + " Golden Hammer(s)"; break;
	}
	
	// objetive of hidden achievements are not shown to spectators, unless said spectator has it unlocked as well
	if ( iInspect == 0 || atoi( A[ tTYPE ] ) == HIDDEN && playerAchievements[ iPlayerIndex ][ iAchievementID ] != LOCKED || atoi( A[ tTYPE ] ) != HIDDEN )
		title += GetAchievementMission( iAchievementID );
	else
	{
		title += "\\cHIDDEN ACHIEVEMENT:\\w Objective not shown.";
		reward = "\\o???"; // override
	}
	
	title += "\n\nReward: \\y" + reward + "\\w";
	title += "\nStatus: ";
	if ( iInspect > 0 )
	{
		if ( playerAchievements[ iInspect ][ iAchievementID ] == HAMMERED )
			title += "\\oBroken\\w\n";
		else if ( playerAchievements[ iInspect ][ iAchievementID ] == LOCKED )
			title += "\\dNot yet unlocked\\w\n";
		else
			title += "\\yGot it!\\w\n";
	}
	else
	{
		if ( playerAchievements[ iPlayerIndex ][ iAchievementID ] == HAMMERED )
			title += "\\oBroken\\w\n";
		else if ( playerAchievements[ iPlayerIndex ][ iAchievementID ] == LOCKED )
			title += "\\dNot yet unlocked\\w\n";
		else
			title += "\\yGot it!\\w\n";
	}
	
	M.menu.SetTitle( title );
	
	if ( iInspect == 0 && playerAchievements[ iPlayerIndex ][ iAchievementID ] == UNCLAIMED )
		M.menu.AddItem( "Claim reward\n", any( string( iAchievementID ) ) );
	else if ( iInspect == 0 && playerAchievements[ iPlayerIndex ][ iAchievementID ] == LOCKED && hammers[ iPlayerIndex ] > 0 )
		M.menu.AddItem( "Unlock achievement\n", any( string( iAchievementID ) ) );
		
	M.menu.AddItem( "Return", any( string( iAchievementID + 1000 ) + "#" + string( iPage ) ) );
	
	M.OpenMenu( pPlayer, 0, 0 );
}

void SCXPMAchievementsInfo_CB( CTextMenu@ menu, CBasePlayer@ pPlayer, int page, const CTextMenuItem@ item )
{
	const int iPlayerIndex = pPlayer.entindex();
	if ( page == 10 ) return;
	
	string rawData;
	item.m_pUserData.retrieve( rawData );
	
	array< string > menuData = rawData.Split( '#' );
	
	int iAchievementID = atoi( menuData[ 0 ] );
	int iPage = menuData.length() == 2 ? atoi( menuData[ 1 ] ) : 0;
	
	if ( iAchievementID >= 1000 )
	{
		iAchievementID -= 1000;
		g_Scheduler.SetTimeout( "SCXPMAchievements", 0.000001f, @pPlayer, iPage, indexinspect[ iPlayerIndex ] );
		return;
	}
	
	// Claim or use hammer?
	if ( playerAchievements[ iPlayerIndex ][ iAchievementID ] == UNCLAIMED )
	{
		// Claim reward
		playerAchievements[ iPlayerIndex ][ iAchievementID ] = UNLOCKED;
		GiveAchievementReward( iPlayerIndex, iAchievementID );
	}
	else if ( playerAchievements[ iPlayerIndex ][ iAchievementID ] == LOCKED && hammers[ iPlayerIndex ] > 0 )
	{
		if ( IsBitSet( gameSettings, SIMULATED_LEVEL ) )
		{
			g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "[SCXPM] This action cannot be done on this map.\n" );
			return;
		}
		
		// Use hammer
		g_Scheduler.SetTimeout( "SCXPMAchievementsHammer", 0.000001f, @pPlayer, iAchievementID );
	}
}

void SCXPMAchievementsHammer( CBasePlayer@ pPlayer, const int iAchievementID )
{
	const int iPlayerIndex = pPlayer.entindex();
	
	MenuHandler@ M = MenuGetPlayer( pPlayer );
	
	M.InitMenu( pPlayer, SCXPMAchievementsHammer_CB );
	
	string title = "Unlock achievement\n";
	
	title += "You have " + hammers[ iPlayerIndex ] + " golden hammer(s)\n\n";
	
	array< string > A = gameAchievements[ iAchievementID ].Split( '#' );
	
	title += "\\rCareful!\\w Hammering through an achievement also\ntampers with its reward. There is \\ono\\w guarantee\nyou'll retrieve the same bounty. Or worse...\n\\r...you could get nothing!\\w\n\n";
	title += "Do you really, \\oREALLY\\w want to unlock\nthe achievement \\m" + A[ tNAME ] + "\\w by force?\n";
	title += "\\rThere's NO turning back after this!\\w\n";
	
	M.menu.SetTitle( title );
	
	M.menu.AddItem( "Hammer it!", any( iAchievementID ) );
	
	M.OpenMenu( pPlayer, 0, 0 );
}

void SCXPMAchievementsHammer_CB( CTextMenu@ menu, CBasePlayer@ pPlayer, int page, const CTextMenuItem@ item )
{
	const int iPlayerIndex = pPlayer.entindex();
	if ( page == 10 ) return;
	
	int iAchievementID;
	item.m_pUserData.retrieve( iAchievementID );
	
	if ( IsBitSet( gameSettings, NO_ACHIEVEMENTS ) || IsBitSet( gameSettings, SINGLE_ACHIEVEMENT ) && gameCfgParam != iAchievementID || IsBitSet( gameSettings, NO_SAVE ) )
	{
		g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "[SCXPM] You cannot unlock achievements on this map.\n" );
		return;
	}
	
	// Something already unlocked this achievement
	if ( playerAchievements[ iPlayerIndex ][ iAchievementID ] != LOCKED )
	{
		g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "[SCXPM] This achievement has already been unlocked.\n" );
		return;
	}
	
	// POW!
	playerAchievements[ iPlayerIndex ][ iAchievementID ] = HAMMERED;
	GiveAchievementReward( iPlayerIndex, iAchievementID, true );
	
	// Check for total unlocked achievements, give special reward if criteria is met
	int iNewUnlocks = GetAchievementClear( iPlayerIndex );
	switch( iNewUnlocks )
	{
		case 35: if ( !HasPermaIncrease( iPlayerIndex, "Just Cause" ) ) AddPermaIncrease( iPlayerIndex, 4, "Just Cause", "Award for completing 35 achievements." ); break;
		case 65: if ( !HasPermaIncrease( iPlayerIndex, "Bounty Hunter" ) ) AddPermaIncrease( iPlayerIndex, 7, "Bounty Hunter", "Award for completing 65 achievements." ); break;
		case 100: if ( !HasPermaIncrease( iPlayerIndex, "Maximum Dedication" ) ) AddPermaIncrease( iPlayerIndex, 10, "Maximum Dedication", "Award for completing 100 achievements." ); break;
		case 135: if ( !HasPermaIncrease( iPlayerIndex, "Journalist" ) ) AddPermaIncrease( iPlayerIndex, 14, "Journalist", "Award for completing 135 achievements." ); break;
		case 165: if ( !HasPermaIncrease( iPlayerIndex, "Map Burner" ) ) AddPermaIncrease( iPlayerIndex, 17, "Map Burner", "Award for completing 165 achievements." ); break;
		case 200: if ( !HasPermaIncrease( iPlayerIndex, "Obsessive Completionist" ) ) AddPermaIncrease( iPlayerIndex, 20, "Obsessive Completionist", "Award for completing 200 achievements." ); break;
	}
	
	// Get achievement name
	array< string > A = gameAchievements[ iAchievementID ].Split( '#' );
	A[ tNAME ].ToUppercase();
	
	// Notify achievement unlock to all players
	string NAME = pPlayer.pev.netname;
	string STEAMID = g_EngineFuncs.GetPlayerAuthId( pPlayer.edict() );
	
	g_PlayerFuncs.ClientPrintAll( HUD_PRINTTALK, "[SCXPM] " + NAME + " has earned the achievement " + A[ tNAME ] + " [GOLDEN HAMMER].\n" );
	g_Game.AlertMessage( at_logged, "[SCXPM] " + NAME + " (" + STEAMID + ") has earned the achievement " + A[ tNAME ] + " [GOLDEN HAMMER]\n" );
	SCXPM_Log( NAME + " (" + STEAMID + ") has earned the achievement " + A[ tNAME ] + " [GOLDEN HAMMER]\n" );
	
	// Put a center print to the player
	g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTCENTER, "Pow!" );
	
	// Subtract
	hammers[ iPlayerIndex ]--;
}

void SCXPMPermaIncrease( CBasePlayer@ pPlayer, const int iPage = 0, const int iPlayerInspect = 0 )
{
	const int iPlayerIndex = pPlayer.entindex();
	
	if ( iPlayerInspect > 0 )
	{
		CBasePlayer@ pOther = g_PlayerFuncs.FindPlayerByIndex( iPlayerInspect );
		if ( pOther is null )
		{
			g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "[SCXPM] Player not found.\n" );
			return;
		}
	}
	
	MenuHandler@ M = MenuGetPlayer( pPlayer );
	
	M.InitMenu( pPlayer, SCXPMPermaIncrease_CB );
	
	const int INDEX = iPlayerInspect > 0 ? iPlayerInspect : iPlayerIndex;
	string TITLE;
	
	TITLE = "XP Mods\n\nTOTAL:" + ( xpModifiers[ INDEX ] > 0 ? " +" : " " ) + xpModifiers[ INDEX ] + "% XP Gain\n\n";
	
	M.menu.SetTitle( TITLE );
	GetPermaIncrease( INDEX, M, false, "", 0, false ); // oh god
	
	if ( iPlayerInspect == 0 )
		indexinspect[ iPlayerIndex ] = 0;
	
	M.OpenMenu( pPlayer, 0, iPage );
}

void SCXPMPermaIncrease_CB( CTextMenu@ menu, CBasePlayer@ pPlayer, int page, const CTextMenuItem@ item )
{
	const int iPlayerIndex = pPlayer.entindex();
	if ( page == 10 ) return;
	
	string modName;
	item.m_pUserData.retrieve( modName );
	
	if ( modName == "empty" )
	{
		g_Scheduler.SetTimeout( "SCXPMPermaIncrease", 0.000001, @pPlayer, 0, indexinspect[ iPlayerIndex ] );
		return;
	}
	
	g_Scheduler.SetTimeout( "SCXPMPermaIncreaseInfo", 0.000001, @pPlayer, modName, indexinspect[ iPlayerIndex ] );
}

void SCXPMPermaIncreaseInfo( CBasePlayer@ pPlayer, const string modName, const int iPlayerInspect = 0 )
{
	const int iPlayerIndex = pPlayer.entindex();
	
	if ( iPlayerInspect > 0 )
	{
		CBasePlayer@ pOther = g_PlayerFuncs.FindPlayerByIndex( iPlayerInspect );
		if ( pOther is null )
		{
			g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "[SCXPM] Player not found.\n" );
			return;
		}
	}
	
	const int INDEX = iPlayerInspect > 0 ? iPlayerInspect : iPlayerIndex;
	
	MenuHandler@ M = MenuGetPlayer( pPlayer );
	
	M.InitMenu( pPlayer, SCXPMPermaIncreaseInfo_CB );
	GetPermaIncrease( INDEX, M, true, modName, 0, false );
	M.OpenMenu( pPlayer, 0, 0 );
}

void SCXPMPermaIncreaseInfo_CB( CTextMenu@ menu, CBasePlayer@ pPlayer, int page, const CTextMenuItem@ item )
{
	const int iPlayerIndex = pPlayer.entindex();
	if ( page == 10 ) return;
	
	const int INDEX = indexinspect[ iPlayerIndex ] > 0 ? indexinspect[ iPlayerIndex ] : iPlayerIndex;
	
	int iItem;
	item.m_pUserData.retrieve( iItem );
	
	// This is the most bastarized and hacky shit I've ever programmed. -Giegue
	int iEntries = 0;
	GetPermaIncrease( INDEX, null, false, "", iEntries, true );
	
	g_Scheduler.SetTimeout( "SCXPMPermaIncrease", 0.000001, @pPlayer, ( iEntries > 9 ? ( iItem / 7 ) : 0 ), INDEX );
}

void SCXPMHandicaps( CBasePlayer@ pPlayer, const int iPage = 0 )
{
	const int iPlayerIndex = pPlayer.entindex();
	
	int HANDICAP = playerHandicaps[ iPlayerIndex ];
	const int FORCEDHC = forcedHandicaps[ iPlayerIndex ];
	
	MenuHandler@ M = MenuGetPlayer( pPlayer );
	
	M.InitMenu( pPlayer, SCXPMHandicaps_CB );
	
	int percent = 0;
	if ( IsBitSet( HANDICAP, MEDICAL_PHOBIA ) ) percent += _XP_HANDICAP[ 0 ];
	if ( IsBitSet( HANDICAP, OBSOLETE_TECHNOLOGY ) ) percent += _XP_HANDICAP[ 1 ];
	if ( IsBitSet( HANDICAP, NITROGEN_BLOOD ) ) percent += _XP_HANDICAP[ 2 ];
	if ( IsBitSet( HANDICAP, KARMIC_RETRIBUTION ) ) percent += _XP_HANDICAP[ 3 ];
	if ( IsBitSet( HANDICAP, REALISM ) ) percent += _XP_HANDICAP[ 4 ];
	if ( IsBitSet( HANDICAP, BIG_EXPLOSION ) ) percent += _XP_HANDICAP[ 5 ];
	if ( IsBitSet( HANDICAP, LIMITED_EQUIPMENT ) ) percent += _XP_HANDICAP[ 6 ];
	if ( IsBitSet( HANDICAP, DEAD_WEIGHT ) ) percent += _XP_HANDICAP[ 7 ];
	if ( IsBitSet( HANDICAP, LACKING_HELP ) ) percent += _XP_HANDICAP[ 8 ];
	if ( IsBitSet( HANDICAP, DIRTY_MAG ) ) percent += _XP_HANDICAP[ 9 ];
	if ( IsBitSet( HANDICAP, LOST_BULLETS ) ) percent += _XP_HANDICAP[ 10 ];
	if ( IsBitSet( HANDICAP, WEAK_RESTART ) ) percent += _XP_HANDICAP[ 11 ];
	if ( IsBitSet( HANDICAP, DANGEROUS_WATERS ) ) percent += _XP_HANDICAP[ 12 ];
	if ( IsBitSet( HANDICAP, BLEEDING_VIEW ) ) percent += _XP_HANDICAP[ 13 ];
	if ( IsBitSet( HANDICAP, HEALTH_CRISIS ) ) percent += _XP_HANDICAP[ 14 ];
	
	string title = "Handicaps\n+" + percent + "% XP gain\n ";
	
	M.menu.SetTitle( title );
	
	// refresh handicap var, map might not allow it
	string COLOR = "\\g";
	if ( !AreHandicapsON() )
	{
		COLOR = "\\y";
		HANDICAP = savedHandicaps[ iPlayerIndex ] == -1 ? 0 : savedHandicaps[ iPlayerIndex ];
	}
	
	// forced takes priority over manually selected
	string hc1text = "Medical Phobia ";
	hc1text += "[ " + ( IsBitSet( FORCEDHC, MEDICAL_PHOBIA ) ? "\\rON" : IsBitSet( HANDICAP, MEDICAL_PHOBIA ) ? COLOR + "ON" : "\\dOFF" ) + "\\w ]\n";
	
	string hc2text = "Obsolete Technology ";
	hc2text += "[ " + ( IsBitSet( FORCEDHC, OBSOLETE_TECHNOLOGY ) ? "\\rON" : IsBitSet( HANDICAP, OBSOLETE_TECHNOLOGY ) ? COLOR +"ON" : "\\dOFF" ) + "\\w ]\n";
	
	string hc3text = "Nitrogen Blood ";
	hc3text += "[ " + ( IsBitSet( FORCEDHC, NITROGEN_BLOOD ) ? "\\rON" : IsBitSet( HANDICAP, NITROGEN_BLOOD ) ? COLOR + "ON" : "\\dOFF" ) + "\\w ]\n";
	
	string hc4text = "Karmic Retribution ";
	hc4text += "[ " + ( IsBitSet( FORCEDHC, KARMIC_RETRIBUTION ) ? "\\rON" : IsBitSet( HANDICAP, KARMIC_RETRIBUTION ) ? COLOR + "ON" : "\\dOFF" ) + "\\w ]\n";
	
	string hc5text = "Realism ";
	hc5text += "[ " + ( IsBitSet( FORCEDHC, REALISM ) ? "\\rON" : IsBitSet( HANDICAP, REALISM ) ? COLOR + "ON" : "\\dOFF" ) + "\\w ]\n";
	
	string hc6text = "Big Explosion ";
	hc6text += "[ " + ( IsBitSet( FORCEDHC, BIG_EXPLOSION ) ? "\\rON" : IsBitSet( HANDICAP, BIG_EXPLOSION ) ? COLOR + "ON" : "\\dOFF" ) + "\\w ]\n";
	
	string hc7text = "Limited Equipment ";
	hc7text += "[ " + ( IsBitSet( FORCEDHC, LIMITED_EQUIPMENT ) ? "\\rON" : IsBitSet( HANDICAP, LIMITED_EQUIPMENT ) ? COLOR + "ON" : "\\dOFF" ) + "\\w ]\n";
	
	string hc8text = "Dead Weight ";
	hc8text += "[ " + ( IsBitSet( FORCEDHC, DEAD_WEIGHT ) ? "\\rON" : IsBitSet( HANDICAP, DEAD_WEIGHT ) ? COLOR + "ON" : "\\dOFF" ) + "\\w ]\n";
	
	string hc9text = "Lacking Help ";
	hc9text += "[ " + ( IsBitSet( FORCEDHC, LACKING_HELP ) ? "\\rON" : IsBitSet( HANDICAP, LACKING_HELP ) ? COLOR + "ON" : "\\dOFF" ) + "\\w ]\n";
	
	string hc10text = "Dirty Mag ";
	hc10text += "[ " + ( IsBitSet( FORCEDHC, DIRTY_MAG ) ? "\\rON" : IsBitSet( HANDICAP, DIRTY_MAG ) ? COLOR + "ON" : "\\dOFF" ) + "\\w ]\n";
	
	string hc11text = "Lost Bullets ";
	hc11text += "[ " + ( IsBitSet( FORCEDHC, LOST_BULLETS ) ? "\\rON" : IsBitSet( HANDICAP, LOST_BULLETS ) ? COLOR + "ON" : "\\dOFF" ) + "\\w ]\n";
	
	string hc12text = "Weak Restart ";
	hc12text += "[ " + ( IsBitSet( FORCEDHC, WEAK_RESTART ) ? "\\rON" : IsBitSet( HANDICAP, WEAK_RESTART ) ? COLOR + "ON" : "\\dOFF" ) + "\\w ]\n";
	
	string hc13text = "Dangerous Waters ";
	hc13text += "[ " + ( IsBitSet( FORCEDHC, DANGEROUS_WATERS ) ? "\\rON" : IsBitSet( HANDICAP, DANGEROUS_WATERS ) ? COLOR + "ON" : "\\dOFF" ) + "\\w ]\n";
	
	string hc14text = "Bleeding View ";
	hc14text += "[ " + ( IsBitSet( FORCEDHC, BLEEDING_VIEW ) ? "\\rON" : IsBitSet( HANDICAP, BLEEDING_VIEW ) ? COLOR + "ON" : "\\dOFF" ) + "\\w ]\n";
	
	string hc15text = "Health Crisis ";
	hc15text += "[ " + ( IsBitSet( FORCEDHC, HEALTH_CRISIS ) ? "\\rON" : IsBitSet( HANDICAP, HEALTH_CRISIS ) ? COLOR + "ON" : "\\dOFF" ) + "\\w ]";
	
	string AUTOSAVE = "Remember selection? ";
	AUTOSAVE += "[ " + ( IsBitSet( playerBits[ iPlayerIndex ], MENU_SAVEHANDICAPS ) ? "\\gON" : "\\dOFF" ) + "\\w ]\n\n";
	
	M.menu.AddItem( AUTOSAVE, any( -1 ) );
	M.menu.AddItem( hc1text, any( MEDICAL_PHOBIA ) );
	M.menu.AddItem( hc2text, any( OBSOLETE_TECHNOLOGY ) );
	M.menu.AddItem( hc3text, any( NITROGEN_BLOOD ) );
	M.menu.AddItem( hc4text, any( KARMIC_RETRIBUTION ) );
	M.menu.AddItem( hc5text, any( REALISM ) );
	M.menu.AddItem( hc6text, any( BIG_EXPLOSION ) );
	M.menu.AddItem( AUTOSAVE, any( -2 ) );
	M.menu.AddItem( hc7text, any( LIMITED_EQUIPMENT ) );
	M.menu.AddItem( hc8text, any( DEAD_WEIGHT ) );
	M.menu.AddItem( hc9text, any( LACKING_HELP ) );
	M.menu.AddItem( hc10text, any( DIRTY_MAG ) );
	M.menu.AddItem( hc11text, any( LOST_BULLETS ) );
	M.menu.AddItem( hc12text, any( WEAK_RESTART ) );
	M.menu.AddItem( AUTOSAVE, any( -3 ) );
	M.menu.AddItem( hc13text, any( DANGEROUS_WATERS ) );
	M.menu.AddItem( hc14text, any( BLEEDING_VIEW ) );
	M.menu.AddItem( hc15text, any( HEALTH_CRISIS ) );
	
	M.OpenMenu( pPlayer, 0, iPage );
}

void SCXPMHandicaps_CB( CTextMenu@ menu, CBasePlayer@ pPlayer, int page, const CTextMenuItem@ item )
{
	const int iPlayerIndex = pPlayer.entindex();
	if ( page == 10 ) return;
	
	int handicapBits, PAGE;
	item.m_pUserData.retrieve( handicapBits );
	
	if ( handicapBits < 0 )
	{
		PAGE = abs( handicapBits ) - 1;
		
		// Toggle autoselect
		playerBits[ iPlayerIndex ] ^= MENU_SAVEHANDICAPS;
		
		g_Scheduler.SetTimeout( "SCXPMHandicaps", 0.000001, @pPlayer, PAGE );
		return;
	}
	
	if ( handicapBits <= BIG_EXPLOSION ) PAGE = 0;
	else if ( handicapBits <= WEAK_RESTART ) PAGE = 1;
	else PAGE = 2;
	
	// forced handicaps cannot be turned off
	if ( IsBitSet( forcedHandicaps[ iPlayerIndex ], handicapBits ) )
	{
		g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "[SCXPM] This handicap has been forced upon you. You cannot disable it!\n" );
		g_Scheduler.SetTimeout( "SCXPMHandicaps", 0.000001, @pPlayer, PAGE );
		return;
	}
	
	if ( AreHandicapsON() )
		playerHandicaps[ iPlayerIndex ] ^= handicapBits;
	else
	{
		if ( IsBitSet( playerBits[ iPlayerIndex ], MENU_SAVEHANDICAPS ) )
		{
			if ( savedHandicaps[ iPlayerIndex ] == -1 )
				savedHandicaps[ iPlayerIndex ] = 0;
			savedHandicaps[ iPlayerIndex ] ^= handicapBits;
		}
		else
		{
			g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "[SCXPM] Handicaps are disabled on this map.\n" );
			g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "[SCXPM] To enable them for the next map, use the \"Remember selection\" option.\n" );
		}
		
		g_Scheduler.SetTimeout( "SCXPMHandicaps", 0.000001, @pPlayer, PAGE );
		return;
	}
	
	// turned ON this handicap?
	if ( IsBitSet( playerHandicaps[ iPlayerIndex ], handicapBits ) )
	{
		switch ( handicapBits )
		{
			case REALISM: pPlayer.m_iHideHUD = HIDEHUD_FLASHLIGHT | HIDEHUD_HEALTH | HIDEHUD_SUITPOWER | HIDEHUD_CROSSHAIR | HIDEHUD_AMMO; break;
			case HEALTH_CRISIS:
			{
				if ( pPlayer.GetMaxAmmo( "health" ) > 0 )
				{
					pPlayer.SetMaxAmmo( "health", 50 + ( redcross[ iPlayerIndex ] * 10 ) );
					pPlayer.RemoveExcessAmmo( "health" );
				}
				break;
			}
			// other handicaps are handled in scxpm_updatehc() as needed
		}
	}
	// turned OFF this handicap?
	else
	{
		switch ( handicapBits )
		{
			case MEDICAL_PHOBIA: pPlayer.pev.max_health = maxhealth; break;
			case OBSOLETE_TECHNOLOGY: pPlayer.pev.armortype = maxarmor; break;
			case REALISM: pPlayer.m_iHideHUD = HIDEHUD_NONE; break;
			case BLEEDING_VIEW: g_PlayerFuncs.ConcussionEffect( pPlayer, 0.0, 0.0, 2.5 ); break;
			case HEALTH_CRISIS:
			{
				if ( pPlayer.GetMaxAmmo( "health" ) > 0 )
				{
					pPlayer.SetMaxAmmo( "health", 100 + ( redcross[ iPlayerIndex ] * 20 ) );
					pPlayer.RemoveExcessAmmo( "health" );
				}
				break;
			}
		}
	}
	
	lastHandicapEdit[ iPlayerIndex ] = g_Engine.time;
	g_Scheduler.SetTimeout( "SCXPMHandicaps", 0.000001, @pPlayer, PAGE );
}

void SCXPMLevelToMedal( CBasePlayer@ pPlayer )
{
	const int iPlayerIndex = pPlayer.entindex();
	
	const int LEVEL = playerlevel[ iPlayerIndex ];
	
	MenuHandler@ M = MenuGetPlayer( pPlayer );
	
	M.InitMenu( pPlayer, SCXPMLevelToMedal_CB );
	
	string title = "Reset Level\n\nExchange your level for free medals!\n\n\n";
	
	title += "   \\g+1\\w medal every \\y145\\w levels\n   \\g+1\\w extra medal at \\o270+\\w levels\n\n";
	
	M.menu.SetTitle( title );
	
	M.menu.AddItem( ( LEVEL < 145 ? "\\r" : "\\c" ) + "Reset!\\w" );
	
	M.OpenMenu( pPlayer, 0, 0 );
}

void SCXPMLevelToMedal_CB( CTextMenu@ menu, CBasePlayer@ pPlayer, int page, const CTextMenuItem@ item )
{
	const int iPlayerIndex = pPlayer.entindex();
	if ( page == 10 ) return;
	
	const int LEVEL = playerlevel[ iPlayerIndex ];
	const int MEDALS = medals[ iPlayerIndex ];
	
	if ( LEVEL < 145 )
	{
		g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "[SCXPM] Not enough levels.\n" );
		return;
	}
	
	if ( MEDALS >= 180 )
	{
		g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "[SCXPM] You already have every single medal. Can't reset anymore!\n" );
		return;
	}
	
	string NAME = pPlayer.pev.netname;
	string STEAMID = g_EngineFuncs.GetPlayerAuthId( pPlayer.edict() );
	
	// medals to award
	int BOUNTY = ( LEVEL / 145 ); if ( LEVEL >= 270 ) BOUNTY++;
	if ( MEDALS + BOUNTY >= 180 ) BOUNTY = 180 - MEDALS;
	
	medals[ iPlayerIndex ] += BOUNTY;
	
	// levels need to be recalculated
	playerlevel[ iPlayerIndex ] -= ( ( LEVEL / 145 ) * 145 );
	skillpoints[ iPlayerIndex ] = Math.clamp( 0, 700, playerlevel[ iPlayerIndex ] );
	xp[ iPlayerIndex ] = ( playerlevel[ iPlayerIndex ] != 0 ? scxpm_calc_xp( playerlevel[ iPlayerIndex ] ) : 0 );
	scxpm_calcneedxp( iPlayerIndex );
	
	// manually reset the player skills
	health[ iPlayerIndex ] = 0;
	armor[ iPlayerIndex ] = 0;
	rhealth[ iPlayerIndex ] = 0;
	rarmor[ iPlayerIndex ] = 0;
	rammo[ iPlayerIndex ] = 0;
	gravity[ iPlayerIndex ] = 0;
	speed[ iPlayerIndex ] = 0;
	dist[ iPlayerIndex ] = 0;
	dodge[ iPlayerIndex ] = 0;
	
	scxpm_calc_specialpoints( iPlayerIndex );
	
	g_SoundSystem.EmitSoundDyn( pPlayer.edict(), CHAN_STATIC, SND_MEDAL_GET, VOL_NORM, ATTN_NONE, SND_SKIP_ORIGIN_USE_ENT, PITCH_NORM, iPlayerIndex );
	
	g_PlayerFuncs.ClientPrintAll( HUD_PRINTTALK, "[SCXPM] " + NAME + " won " + BOUNTY + " medal(s) for resetting! (New total of " + medals[ iPlayerIndex ] + ").\n" );
	g_Game.AlertMessage( at_logged, "[SCXPM] " + NAME + " (" + STEAMID + ") won " + BOUNTY + " medals for resetting. (New total of " + medals[ iPlayerIndex ] + ").\n" );
	SCXPM_Log( NAME + " (" + STEAMID + ") won " + BOUNTY + " medals for resetting. (New total of " + medals[ iPlayerIndex ] + ").\n" );
	
	if ( medals[ iPlayerIndex ] >= 180 && !HasPermaIncrease( iPlayerIndex, "Infinite Reboot" ) )
		AddPermaIncrease( iPlayerIndex, 0, "Infinite Reboot", "Many would think that repeating every timeline\nover and over it's purposeless, and done only\nby maniacs.\n\nBut for this player, it's a day to day\nhabit of perseverance. A worthy achievement.\n\nAward for reaching 180 medals." );
	else if ( medals[ iPlayerIndex ] >= 42 && !HasPermaIncrease( iPlayerIndex, "The Answer" ) )
		AddPermaIncrease( iPlayerIndex, 36, "The Answer", "Everyone knows what this number is, but it is\nalso a distant memory from forgotten times.\n\nAward for reaching 42 medals." );
}

void SCXPMMedalToLevel( CBasePlayer@ pPlayer )
{
	const int iPlayerIndex = pPlayer.entindex();
	
	const int MEDALS = medals[ iPlayerIndex ];
	
	MenuHandler@ M = MenuGetPlayer( pPlayer );
	
	M.InitMenu( pPlayer, SCXPMMedalToLevel_CB );
	
	string title = "Reset Medals\n\nNeed a quick boost on your skills?\nUse this to exchange medals for XP\n\n\n";
	
	title += "   \\g+45,000 XP\\w every medal\n   \\g+30,000 bonus XP\\w for levels below \\r145\\w\n\n";
	
	M.menu.SetTitle( title );
	
	M.menu.AddItem( ( MEDALS > 0 ? "\\c" : "\\r" ) + "Reset!\\w" );
	
	M.OpenMenu( pPlayer, 0, 0 );
}

void SCXPMMedalToLevel_CB( CTextMenu@ menu, CBasePlayer@ pPlayer, int page, const CTextMenuItem@ item )
{
	const int iPlayerIndex = pPlayer.entindex();
	if ( page == 10 ) return;
	
	const int LEVEL = playerlevel[ iPlayerIndex ];
	const int MEDALS = medals[ iPlayerIndex ];
	
	if ( MEDALS <= 0 )
	{
		g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "[SCXPM] No medals to exchange.\n" );
		return;
	}
	
	if ( LEVEL >= 24760 )
	{
		g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "[SCXPM] You already have every single level. Can't reset anymore!\n" );
		return;
	}
	
	string NAME = pPlayer.pev.netname;
	string STEAMID = g_EngineFuncs.GetPlayerAuthId( pPlayer.edict() );
	
	// XP to award
	int BOUNTY = MEDALS * 45000;
	if ( LEVEL < 145 ) BOUNTY += 30000;
	
	// give XP and let game automatically recalculate it
	xp[ iPlayerIndex ] += BOUNTY;
	earnedxp[ iPlayerIndex ] += BOUNTY;
	
	// log
	g_PlayerFuncs.ClientPrintAll( HUD_PRINTTALK, "[SCXPM] " + NAME + " exchanged " + MEDALS + " medal(s) for XP. (New total of " + medals[ iPlayerIndex ] + ").\n" );
	g_Game.AlertMessage( at_logged, "[SCXPM] " + NAME + " (" + STEAMID + ") exchanged " + MEDALS + " medals for XP.\n" );
	SCXPM_Log( NAME + " (" + STEAMID + ") exchanged " + MEDALS + " medals for XP.\n" );
	
	medals[ iPlayerIndex ] = 0;
	SCXPMResetSpecial( pPlayer, true );
}

void SCXPMDailyRewards( CBasePlayer@ pPlayer, const int iDaily = 0 )
{
	if ( pPlayer is null || !pPlayer.IsConnected() )
		return;
	
	const int iPlayerIndex = pPlayer.entindex();
	
	// Update daily rewards now
	if ( iDaily > 0 ) dailyget[ iPlayerIndex ] = iDaily;
	
	string szCurrent, szNext;
	GetDailyReward( iPlayerIndex, dailyget[ iPlayerIndex ], true, szCurrent, szNext );
	
	MenuHandler@ M = MenuGetPlayer( pPlayer );
	
	M.InitMenu( pPlayer, SCXPMDailyRewards_CB );
	
	string title = "Daily Rewards\n\n";
	title += "Daily rewards get: " + dailyget[ iPlayerIndex ] + "\n\n";
	
	title += "Day " + dailyget[ iPlayerIndex ] + ": " + szCurrent + "\n";
	title += "Next reward: " + szNext + "\n\n";
	
	title += "Keep playing to increase rewards!\n";
	
	M.menu.SetTitle( title );
	
	if ( hammers[ iPlayerIndex ] > 0 )
		M.menu.AddItem( "Skip day\n", any( 1 ) );
	
	M.menu.AddItem( "Return", any( 0 ) );
	
	M.OpenMenu( pPlayer, 0, 0 );
}

void SCXPMDailyRewards_CB( CTextMenu@ menu, CBasePlayer@ pPlayer, int page, const CTextMenuItem@ item )
{
	const int iPlayerIndex = pPlayer.entindex();
	if ( page == 10 ) return;
	
	int bUseSkip;
	item.m_pUserData.retrieve( bUseSkip );
	
	if ( bUseSkip == 1 )
	{
		if ( IsBitSet( gameSettings, SIMULATED_LEVEL ) )
		{
			g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "[SCXPM] This action cannot be done on this map.\n" );
			return;
		}
		
		g_Scheduler.SetTimeout( "SCXPMDailySkip", 0.000001, @pPlayer );
		return;
	}
	
	g_Scheduler.SetTimeout( "SCXPMMenu", 0.000001, @pPlayer );
}

void SCXPMDailySkip( CBasePlayer@ pPlayer )
{
	const int iPlayerIndex = pPlayer.entindex();
	
	MenuHandler@ M = MenuGetPlayer( pPlayer );
	
	M.InitMenu( pPlayer, SCXPMDailySkip_CB );
	
	string title = "Skip day\n";
	
	title += "You have " + hammers[ iPlayerIndex ] + " golden hammer(s)\n\n";
	
	title += "You can skip \\y+1\w day and \\gGET\\w tomorrow's reward\n\\dOR...\\w\nYou can skip \\y+10\\w days and \\oFORFEIT\\w all rewards\n\n\\dChoose wisely...\\w\n\n";
	
	title += "\\rThere's NO turning back after this!\\w\n";
	
	M.menu.SetTitle( title );
	
	M.menu.AddItem( "Skip +1 day", any( 1 ) );
	M.menu.AddItem( "Skip +10 days", any( 2 ) );
	
	M.OpenMenu( pPlayer, 0, 0 );
}

void SCXPMDailySkip_CB( CTextMenu@ menu, CBasePlayer@ pPlayer, int page, const CTextMenuItem@ item )
{
	const int iPlayerIndex = pPlayer.entindex();
	if ( page == 10 ) return;
	
	// POW!
	g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTCENTER, "Pow!" );
	
	// Subtract
	hammers[ iPlayerIndex ]--;
	
	int selection;
	item.m_pUserData.retrieve( selection );
	
	switch ( selection )
	{
		case 1:
		{
			// Force the next daily to be retrieved now
			uDateTime dtCurrentTime( UnixTimestamp() - 1 );
			nextdaily[ iPlayerIndex ] = dtCurrentTime;
			break;
		}
		case 2:
		{
			// Skip +10 with no reward
			dailyget[ iPlayerIndex ] += 10;
			break;
		}
	}
	
	// Re-open the menu
	g_Scheduler.SetTimeout( "SCXPMDailyRewards", 0.000001, @pPlayer, ( selection == 1 ? ( dailyget[ iPlayerIndex ] + 1 ) : 0 ) );
}

void SCXPMHelpMenu( CBasePlayer@ pPlayer )
{
	const int iPlayerIndex = pPlayer.entindex();
	
	MenuHandler@ M = MenuGetPlayer( pPlayer );
	
	M.InitMenu( pPlayer, SCXPMHelpMenu_CB );
	M.menu.SetTitle( "Help and Info\n\n" );
	
	M.menu.AddItem( "How do \\yskills\\w work?\n", any( 1 ) );
	M.menu.AddItem( "How do \\yspecial skills\\w work?\n", any( 2 ) );
	M.menu.AddItem( "What are \\yhandicaps\\w?\n\n", any( 3 ) );
	M.menu.AddItem( "XP Gain\n\n", any( 4 ) );
	M.menu.AddItem( "About\n\n", any( 5 ) );
	M.menu.AddItem( "Return", any( 6 ) );
	
	M.OpenMenu( pPlayer, 0, 0 );
}

void SCXPMHelpMenu_CB( CTextMenu@ menu, CBasePlayer@ pPlayer, int page, const CTextMenuItem@ item )
{
	int index = pPlayer.entindex();
	if ( page == 10 ) return;
	
	int selection;
	item.m_pUserData.retrieve( selection );
	
	switch ( selection )
	{
		case 1:	g_Scheduler.SetTimeout( "SCXPMSkillInfo", 0.000001, @pPlayer ); break;
		case 2:	g_Scheduler.SetTimeout( "SCXPMSpecialInfo", 0.000001, @pPlayer ); break;
		case 3:	g_Scheduler.SetTimeout( "SCXPMHandicapsInfo", 0.000001, @pPlayer ); break;
		case 4:	g_Scheduler.SetTimeout( "SCXPMXPGain", 0.000001, @pPlayer ); break;
		case 5:	g_Scheduler.SetTimeout( "SCXPMVersion", 0.000001, @pPlayer ); break;
		case 6:	g_Scheduler.SetTimeout( "SCXPMMenu", 0.000001, @pPlayer ); break;
	}
}

void SCXPMSkillInfo( CBasePlayer@ pPlayer )
{
	const int iPlayerIndex = pPlayer.entindex();
	
	string szInfo = "1. Strength:\n   Starthealth + (Strengthlevel / 2)."; if ( IsBitSet( gameSettings, OVERPOWER ) ) szInfo += "\n   Also increases MaxHealth by (Strengthlevel / 2), up to 200.";
	szInfo += "\n\n2. Superior Armor:\n   Startarmor + (Armorlevel / 2)."; if ( IsBitSet( gameSettings, OVERPOWER ) ) szInfo += "\n   Also increases MaxArmor by (Armorlevel / 2), up to 200.";
	szInfo += "\n\n3. Regeneration:\n   One HP every + (158.0 - (Regenerationlevel / 3)) seconds\n   + Bonus chance every 0.5 seconds.";
	szInfo += "\n\n4. Nano Armor:\n   One AP every + (165.5 - (Nanoarmorlevel / 3)) seconds\n   + Bonus chance every 0.5 seconds.";
	szInfo += "\n\n5. Ammo Reincarnation:\n   One clip for current weapon and a random clip every (95.5 - (Ammolevel * 2)) seconds.";
	szInfo += "\n\n6. Anti-Gravity Device:\n   Lowers your gravity by (1.2)% per level. Hold Jump-Key!";
	szInfo += "\n\n7. Awareness:\n   Generic skill which enhances many other skills a bit.";
	szInfo += "\n\n8. Team Power:\n   Supports nearby teammates with HP and AP.";
	szInfo += "\n\n9. Block Attack:\n   Chance on fully blocking any attack of (Blocklevel / 3)%.";
	szInfo += "\n\n10. Medals:\n   Slighly enhances all other skills a bit.\n   Increases XP gain by (Medals * 3)%.\n   Can be used for special skills.";
	
	ShowMOTD( pPlayer, "Skills", szInfo );
}

void SCXPMSpecialInfo( CBasePlayer@ pPlayer )
{
	const int iPlayerIndex = pPlayer.entindex();
	
	string szInfo = "Special Skills are additional upgrades that you can use. These are only available with medals.\n1 medal : 1 specialpoint, up to 30. Extra specialpoints are awarded every 10 medals afterwards.";
	szInfo += "\n\n1. Starting Attack:\n   On revive/respawn, deal (20 * Attacklevel) damage\n   to all nearby enemies on a 360 unit radius.";
	szInfo += "\n\n2. Portable Dispencer:\n   Doubles all regenerated ammo.";
	szInfo += "\n\n3. Ubercharge:\n   Increases the maximum capacity of all basic skills.";
	szInfo += "\n\n4. Quick Heal:\n   Extra medkit ammo every (5.0 - (Quicklevel / 2.0)) seconds.";
	szInfo += "\n\n5. Demoman:\n   Chance on one clip of M16 Grenades of (8 + (Demolevel * 4))%.\n   (Does not stack with Portable Dispencer).";
	szInfo += "\n\n6. Practice Shot:\n   Chance on the next shot to not consume any ammo of (Practicelevel * 5)%.\n   (Only affects primary attacks, and does not work on all weapons).";
	szInfo += "\n\n7. BioElectric:\n   Increases Shock Rifle's maximum capacity by (10 * Bioelectriclevel).";
	szInfo += "\n\n8. Medical Emergency:\n   Allows long range healing with the Medkit.\n   (Use tertiary attack).";
	szInfo += "\n\n9. Red Cross:\n   Increases Medkit's maximum capacity by (20 * Redcrosslevel).";
	
	ShowMOTD( pPlayer, "Special Skills", szInfo );
}

void SCXPMHandicapsInfo( CBasePlayer@ pPlayer )
{
	const int iPlayerIndex = pPlayer.entindex();
	
	string szInfo = "Handicaps make your map gameplay harder.\nBut you will be rewared with greater XP gain, allowing you to level up faster.";
	
	szInfo += "\n\n1. Medical Phobia:\n   You cannot be healed, except via regeneration.\n   +" + _XP_HANDICAP[ 0 ] + "% XP gain.";
	szInfo += "\n\n2. Obsolete Technology:\n   You cannot repair your armor, except via nano armor.\n   +" + _XP_HANDICAP[ 1 ] + "% XP gain.";
	szInfo += "\n\n3. Nitrogen Blood:\n   You cannot be revived, you will always gib on death.\n   +" + _XP_HANDICAP[ 2 ] + "% XP gain.";
	szInfo += "\n\n4. Karmic Retribution:\n   All damages will leave you poisoned (falldamage excluded).\n   +" + _XP_HANDICAP[ 3 ] + "% XP gain.";
	szInfo += "\n\n5. Realism:\n   Hides the HEV Suit (HUD), making overall gameplay harder.\n   +" + _XP_HANDICAP[ 4 ] + "% XP gain.";
	szInfo += "\n\n6. Big Explosion:\n   Explosions will deal much more damage than usual.\n   +" + _XP_HANDICAP[ 5 ] + "% XP gain.";
	szInfo += "\n\n7. Limited Equipment:\n   Restricts your equipment to only one weapon.\n   +" + _XP_HANDICAP[ 6 ] + "% XP gain.";
	szInfo += "\n\n8. Dead Weight:\n   Increases your gravity, it's harder to jump.\n   +" + _XP_HANDICAP[ 7 ] + "% XP gain.";
	szInfo += "\n\n9. Lacking Help:\n   Partially disables the effects of Medals and Special Skills.\n   (Ubercharge and Red Cross are unaffected).\n   +" + _XP_HANDICAP[ 8 ] + "% XP gain.";
	szInfo += "\n\n10. Dirty Mag:\n   Any ammo left on the magazine will be lost on next reload.\n   +" + _XP_HANDICAP[ 9 ] + "% XP gain.";
	szInfo += "\n\n11. Lost Bullets:\n   Restricts your weapon's ammunition to only one clip.\n   +" + _XP_HANDICAP[ 10 ] + "% XP gain.";
	szInfo += "\n\n12. Weak Restart:\n   Reviving or respawning will force your status to 25 HP and 0 AP.\n   +" + _XP_HANDICAP[ 11 ] + "% XP gain.";
	szInfo += "\n\n13. Dangerous Waters:\n   Instant drowing when underwater.\n   +" + _XP_HANDICAP[ 12 ] + "% XP gain.";
	szInfo += "\n\n14. Bleeding View:\n   Adds a concussion effect that gets worse the lower your HP gets.\n   +" + _XP_HANDICAP[ 13 ] + "% XP gain.";
	szInfo += "\n\n15. Health Crisis:\n   Cuts your Medkit capacity to half.\n   +" + _XP_HANDICAP[ 14 ] + "% XP gain.";
	
	ShowMOTD( pPlayer, "Handicaps", szInfo );
}

void SCXPMXPGain( CBasePlayer@ pPlayer )
{
	const int iPlayerIndex = pPlayer.entindex();
	
	const double XPGAIN = scxpm_calc_xpgain( iPlayerIndex );
	
	if ( MAP_XPGAIN <= 0.0 || XPGAIN <= 0.0 )
	{
		g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "[SCXPM] XP gain is disabled on this map.\n" );
		return;
	}
	
	double points = ( XPGAIN / 20.0 ) * 100.0;
	
	int need = 1;
	if ( points < 0.03125 )
	{
		points = ( XPGAIN / 0.625 ) * 100.0;
		need = need * 32;
	}
	else if ( points < 0.0625 )
	{
		points = ( XPGAIN / 1.25 ) * 100.0;
		need = need * 16;
	}
	else if ( points < 0.125 )
	{
		points = ( XPGAIN / 2.5 ) * 100.0;
		need = need * 8;
	}
	else if ( points < 0.5 )
	{
		points = ( XPGAIN / 5.0 ) * 100.0;
		need = need * 4;
	}
	else if ( points < 1.0 )
	{
		points = ( XPGAIN / 10.0 ) * 100.0;
		need = need * 2;
	}
	
	g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "[SCXPM] Your XP gain on this map is: " + XPGAIN + "x (" + points + " XP every " + need + " score).\n" );
	
	if ( xpMultiplier[ iPlayerIndex ] <= 1 )
		return;
	
	int minutes = xpMultiplierTime[ iPlayerIndex ];
	int hours = minutes / 60;
	int days = hours / 24;
	
	minutes %= 60;
	hours %= 24;
	
	string szMinutes;
	if ( minutes < 10 ) szMinutes = "0" + minutes + "m";
	else szMinutes = string( minutes ) + "m";
	
	string szHours;
	if ( hours < 10 ) szHours = "0" + hours + "h";
	else szHours = string( hours ) + "h";
	
	string szDays;
	if ( days < 10 ) szDays = "0" + days + "d";
	else szDays = string( days ) + "d";
	
	g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "[SCXPM] Your " + xpMultiplier[ iPlayerIndex ] + "x multiplier expires on " + szDays + " " + szHours + " " + szMinutes + "\n" );
}

void SCXPMVersion( CBasePlayer@ pPlayer )
{
	const int iPlayerIndex = pPlayer.entindex();
	
	string szInfo = "Sven Co-op eXPerience Mod (SCXPM)";
	szInfo += "\n\nOriginally written by Silencer, Wrd and PythEch.";
	szInfo += "\nAngelScript port by Giegue.";
	
	szInfo += "\n\nVersion: " + version;
	szInfo += "\nLast update: " + lastupdate;
	
	szInfo += "\n\nThanks to:\n\nMaty\nSneaky EmA\nw00tguy\nSolokiller\nAMX Mod X Team\nTh3-822";
	
	szInfo += "\n\n\n---\n2009-2024 - Imperium Sven Co-op";
	szInfo += "\n2024-2026 - Rebel's Pub";
	
	ShowMOTD( pPlayer, "About", szInfo );
}

void SCXPMChampionWelcome( CBasePlayer@ pPlayer )
{
	if ( pPlayer is null || !pPlayer.IsConnected() )
		return;
	
	const int iPlayerIndex = pPlayer.entindex();
	
	MenuHandler@ M = MenuGetPlayer( pPlayer );
	M.InitMenu( pPlayer, DUMMY_CB ); // dummy callback because menus won't open if there are no items
	
	// How many players reached champion status?
	uint PLAYERS = g_ChampionVaultData.getKeys().length();
	
	// Store new champion
	const string STEAMID = g_EngineFuncs.GetPlayerAuthId( pPlayer.edict() );
	const string TIMESTAMP = string( UnixTimestamp() );
	g_ChampionVaultData[ STEAMID ] = TIMESTAMP;
	
	// Now, show a congratulatory message to the player
	string szTitle = "I SEE IT AND I DON'T BELIEVE IT!\n\n";
	
	szTitle += "You are the player number \\y#" + ( ++PLAYERS ) + "\\w that has managed to\n";
	szTitle += "survive the daunting task of achieving \\g100%\\w completion!\n";
	szTitle += "Now you are walking among the Elite, with no more\n";
	szTitle += "barriers stopping you. \\yWield the crown of Champion!\\w\n";
	szTitle += "\\mWith all of our love. \\cThank you for playing!\\w\n\n";
	
	szTitle += "Your first play ever was on: \\d" + GetDate( firstplay[ iPlayerIndex ] ) + "\\w\n";
	szTitle += "You reached Champion status on: \\y" + GetDate( uDateTime( UnixTimestamp() ) ) + "\\w\n\n";
	
	uTimeDifference tdTotalDays( uDateTime( UnixTimestamp() ), firstplay[ iPlayerIndex ] );
	szTitle += "That equals to: \\o" + tdTotalDays.GetDays() + "\\w days of gameplay.\n\n";
	
	szTitle += string( pPlayer.pev.netname ) + "\n";
	szTitle += STEAMID + "\n\n";
	
	M.menu.SetTitle( szTitle );
	M.menu.AddItem( "Yay!" );
	
	M.OpenMenu( pPlayer, 0, 0 );
}
void DUMMY_CB( CTextMenu@ menu, CBasePlayer@ pPlayer, int page, const CTextMenuItem@ item ) {}

/** SPECIAL SAY COMMANDS **/
void scxpm_do_gift( CBasePlayer@ pPlayer, CBasePlayer@ pTarget, const string TYPE, int AMOUNT )
{
	// Do now a copy of the name and steamid for logging
	const string sNAME = pPlayer.pev.netname;
	const string sSTEAMID = g_EngineFuncs.GetPlayerAuthId( pPlayer.edict() );
	const string dNAME = pTarget.pev.netname;
	const string dSTEAMID = g_EngineFuncs.GetPlayerAuthId( pTarget.edict() );
	
	const int iPlayerIndex = pPlayer.entindex();
	const int iTargetIndex = pTarget.entindex();
	
	if ( AMOUNT <= 0 ) AMOUNT = 1;
	
	if ( TYPE == "level" )
	{
		int iDelta = playerlevel[ iPlayerIndex ] - AMOUNT;
		if ( iDelta < 0 )
		{
			g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "[SCXPM] Not enough levels.\n" );
			return;
		}
		
		// First lower the user's levels
		playerlevel[ iPlayerIndex ] = iDelta;
		xp[ iPlayerIndex ] = scxpm_calc_xp( playerlevel[ iPlayerIndex ] );
		scxpm_calcneedxp( iPlayerIndex );
		if ( IsBitSet( gameSettings, SIMULATED_LEVEL ) || !HasPermaIncrease( iPlayerIndex, "Champion" ) )
			SCXPMResetBasic( pPlayer );
		
		// Now give to the target's level
		int iLambda = playerlevel[ iTargetIndex ] + AMOUNT;
		playerlevel[ iTargetIndex ] = iLambda;
		xp[ iTargetIndex ] = scxpm_calc_xp( playerlevel[ iTargetIndex ] );
		scxpm_calcneedxp( iTargetIndex );
		
		scxpm_calc_skillpoints( iPlayerIndex );
		
		g_SoundSystem.EmitSoundDyn( pTarget.edict(), CHAN_STATIC, SND_LEVEL_UP, VOL_NORM, ATTN_NONE, SND_SKIP_ORIGIN_USE_ENT, PITCH_NORM, iTargetIndex );
		g_PlayerFuncs.ClientPrint( pTarget, HUD_PRINTCENTER, "You got a gift from " + sNAME + "!\n+" + AMOUNT + "levels\n" );
		
		// Log time
		g_Game.AlertMessage( at_logged, "[SCXPM] " + sNAME + " (" + sSTEAMID + ") gifted " + AMOUNT + " levels to " + dNAME + " (" + dSTEAMID + ").\n" );
		SCXPM_Log( sNAME + " (" + sSTEAMID + ") gifted " + AMOUNT + " levels to " + dNAME + " (" + dSTEAMID + ").\n" );
		g_PlayerFuncs.ClientPrintAll( HUD_PRINTTALK, "[SCXPM] " + sNAME + " gifted " + AMOUNT + " levels to " + dNAME + ".\n" );
	}
	else if ( TYPE == "medal" )
	{
		int iDelta = medals[ iPlayerIndex ] - AMOUNT;
		if ( iDelta <= 0 )
		{
			g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "[SCXPM] Not enough medals.\n" );
			return;
		}
		
		// First lower the user's medals
		medals[ iPlayerIndex ] = iDelta;
		if ( IsBitSet( gameSettings, SIMULATED_LEVEL ) || !HasPermaIncrease( iPlayerIndex, "Champion" ) )
			SCXPMResetSpecial( pPlayer );
		
		// Now give to the target's medals
		int iLambda = medals[ iTargetIndex ] + AMOUNT;
		medals[ iTargetIndex ] = iLambda;
		scxpm_calc_specialpoints( iTargetIndex );
		
		g_SoundSystem.EmitSoundDyn( pTarget.edict(), CHAN_STATIC, SND_MEDAL_GET, VOL_NORM, ATTN_NONE, SND_SKIP_ORIGIN_USE_ENT, PITCH_NORM, iTargetIndex );
		g_PlayerFuncs.ClientPrint( pTarget, HUD_PRINTCENTER, "You got a gift from " + sNAME + "!\n+" + AMOUNT + "medals\n" );
		
		// Log time
		g_Game.AlertMessage( at_logged, "[SCXPM] " + sNAME + " (" + sSTEAMID + ") gifted " + AMOUNT + " medals to " + dNAME + " (" + dSTEAMID + ").\n" );
		SCXPM_Log( sNAME + " (" + sSTEAMID + ") gifted " + AMOUNT + " medals to " + dNAME + " (" + dSTEAMID + ").\n" );
		g_PlayerFuncs.ClientPrintAll( HUD_PRINTTALK, "[SCXPM] " + sNAME + " gifted " + AMOUNT + " medals to " + dNAME + ".\n" );
	}
	else if ( TYPE == "multiplier" )
	{
		if ( xpMultiplier[ iPlayerIndex ] <= 1 )
		{
			g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "[SCXPM] You have no multiplier to gift.\n" );
			return;
		}
		
		if ( xpMultiplier[ iTargetIndex ] > 1 && xpMultiplier[ iPlayerIndex ] != xpMultiplier[ iTargetIndex ] )
		{
			g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "[SCXPM] That player has a different multiplier than yours. You cannot gift it.\n" );
			return;
		}
		
		if ( AMOUNT > xpMultiplierTime[ iPlayerIndex ] )
		{
			g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "[SCXPM] Not enough multiplier time.\n" );
			return;
		}
		
		// Give first to target
		xpMultiplier[ iTargetIndex ] = xpMultiplier[ iPlayerIndex ];
		xpMultiplierTime[ iTargetIndex ] += AMOUNT; // No +1 here.
		
		g_PlayerFuncs.ClientPrint( pTarget, HUD_PRINTCENTER, "You got a gift from " + sNAME + "!\n" + xpMultiplier[ iTargetIndex ] + "x Multiplier [" + AMOUNT + "minutes]\n" );
		
		// Now subtract from player
		xpMultiplierTime[ iPlayerIndex ] -= AMOUNT;
		if ( xpMultiplierTime[ iPlayerIndex ] <= 0 )
		{
			xpMultiplier[ iPlayerIndex ] = 1;
			xpMultiplierTime[ iPlayerIndex ] = 0;
		}
		
		// Log time
		g_Game.AlertMessage( at_logged, "[SCXPM] " + sNAME + " (" + sSTEAMID + ") gifted " + AMOUNT + " minutes of " + xpMultiplier[ iTargetIndex ] + "x multiplier to " + dNAME + " (" + dSTEAMID + ").\n" );
		SCXPM_Log( sNAME + " (" + sSTEAMID + ") gifted " + AMOUNT + " minutes of " + xpMultiplier[ iTargetIndex ] + "x multiplier to " + dNAME + " (" + dSTEAMID + ").\n" );
		g_PlayerFuncs.ClientPrintAll( HUD_PRINTTALK, "[SCXPM] " + sNAME + " gifted " + AMOUNT + " minutes of " + xpMultiplier[ iTargetIndex ] + "x multiplier to " + dNAME + ".\n" );
	}
}

void SCXPMSpectate( CBasePlayer@ pPlayer )
{
	const int iPlayerIndex = pPlayer.entindex();
	
	// Admins can always spectate, no matter what
	AdminLevel_t admLevel = g_PlayerFuncs.AdminLevel( pPlayer );
	if ( admLevel == ADMIN_NO && ( IsBitSet( gameSettings, NO_SPECTATE ) || g_EngineFuncs.CVarGetFloat( "mp_observer_cyclic" ) == 1.0 ) )
	{
		g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "[SCXPM] The spectate command is disabled on this map.\n" );
		return;
	}
	
	if ( pPlayer.IsAlive() )
	{
		g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "[SCXPM] Can only spectate while dead.\n" );
		return;
	}
	
	if ( pPlayer.GetCustomKeyvalues().GetKeyvalue( "$i_scxpm_norespawn" ).GetInteger() == 1 )
	{
		g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "[SCXPM] You ran out of respawns. Cannot leave spectator mode.\n" );
		return;
	}
	
	spectator[ iPlayerIndex ] = !spectator[ iPlayerIndex ];
	
	if ( spectator[ iPlayerIndex ] )
	{
		pPlayer.m_flRespawnDelayTime = Math.FLOAT_MAX;
		pPlayer.GetObserver().StartObserver( pPlayer.pev.origin, pPlayer.pev.angles, !IsBitSet( pPlayer.pev.effects, EF_NODRAW ) );
		pPlayer.m_flRespawnDelayTime = Math.FLOAT_MAX;
		
		g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "[SCXPM] Write '/spectate' in chat again to respawn.\n" );
	}
	else if ( admLevel == ADMIN_NO )
	{
		// avoid CPlayerFuncs::RespawnPlayer unless ADMIN. If the spectator still has a corpse, RespawnPlayer() will keep the player inventory.
		pPlayer.m_flRespawnDelayTime = g_EngineFuncs.CVarGetFloat( "mp_respawndelay" );
		pPlayer.pev.nextthink = g_Engine.time;
	}
	else
		g_PlayerFuncs.RespawnPlayer( pPlayer, true, true );
}

void SCXPMResetHandicaps( CBasePlayer@ pPlayer, bool bSilent = false )
{
	const int iPlayerIndex = pPlayer.entindex();
	
	if ( AreHandicapsON() )
		playerHandicaps[ iPlayerIndex ] = 0;
	else
	{
		if ( savedHandicaps[ iPlayerIndex ] > 0 )
			savedHandicaps[ iPlayerIndex ] = 0;
	}
	
	// reset handicap effects
	pPlayer.pev.max_health = maxhealth;
	pPlayer.pev.armortype = maxarmor;
	pPlayer.m_iHideHUD = HIDEHUD_NONE;
	g_PlayerFuncs.ConcussionEffect( pPlayer, 0.0, 0.0, 2.5 );
	if ( pPlayer.GetMaxAmmo( "health" ) > 0 )
	{
		pPlayer.SetMaxAmmo( "health", 100 + ( redcross[ iPlayerIndex ] * 20 ) );
		pPlayer.RemoveExcessAmmo( "health" );
	}
	
	lastHandicapEdit[ iPlayerIndex ] = g_Engine.time;
	
	if ( bSilent )
		return;
	
	g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "[SCXPM] All handicaps were turned off.\n" );
	SCXPMHandicaps( pPlayer );
}

void SCXPMAutoSelectHC( CBasePlayer@ pPlayer )
{
	const int iPlayerIndex = pPlayer.entindex();
	
	int HANDICAP = int( g_Engine.found_secrets );
	if ( HANDICAP == 0 )
	{
		g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "[SCXPM] No achievement requires any handicap for this map.\n" );
		return;
	}
	
	if ( playerHandicaps[ iPlayerIndex ] > 0 )
		savedHandicaps[ iPlayerIndex ] = playerHandicaps[ iPlayerIndex ];
	
	playerHandicaps[ iPlayerIndex ] = HANDICAP;
	lastHandicapEdit[ iPlayerIndex ] = g_Engine.time;
	
	g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "[SCXPM] All required achievement handicaps were automatically enabled.\n" );
	SCXPMHandicaps( pPlayer );
}

/** ADMIN COMMANDS **/
CClientCommand _ADMIN_CMDHELP( "xp_help", " - Shows all available admin commands", @ADMIN_CMDHELP, ConCommandFlag::AdminOnly );
void ADMIN_CMDHELP( const CCommand@ pArgs )
{
	CBasePlayer@ pPlayer = g_ConCommandSystem.GetCurrentPlayer();
	
	g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTCONSOLE, "[SCXPM] Command list:\n\n" );
	g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTCONSOLE, ".xp_addxp <Name> <Amount> - Give XP to a player.\n" );
	g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTCONSOLE, ".xp_removexp <Name> <Amount> - Take XP away to a player.\n" );
	g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTCONSOLE, ".xp_setlvl <Name> <Value> - Sets a player's level.\n" );
	g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTCONSOLE, ".xp_addmedal <Name> <Amount> - Give medals to a player.\n" );
	g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTCONSOLE, ".xp_removemedal <Name> <Amount> - Take medals away from a player.\n" );
	g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTCONSOLE, ".xp_addhammer <Name> <Amount> - Give golden hammers to a player.\n" );
	g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTCONSOLE, ".xp_setmultiplier <Name> <Multiplier> <Duration> - Sets a player's XP multiplier.\n" );
	g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTCONSOLE, ".xp_givemodifier <Name> <Percent> <Title> <Description> - Give an XP Mod to a player.\n" );
	g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTCONSOLE, ".xp_setadata <Name> <Achievement ID> <Unlock> <Give Reward> - Locks or unlocks an achievement to a player.\n" );
	g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTCONSOLE, ".xp_force_handicap <Name> <Handicap> <Silent> - Forces a handicap to a player.\n" );
	g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTCONSOLE, ".xp_set_xpgain <Value> - OWNERS ONLY - Changes map's XP gain.\n\n" );
	g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTCONSOLE, ".xp_toggle_skills - OWNERS ONLY - Enables/Disables skills on this map.\n" );
	g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTCONSOLE, ".xp_toggle_overpower - OWNERS ONLY - Enables/Disables overpower on this map.\n" );
	g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTCONSOLE, ".xp_toggle_save - OWNERS ONLY - Enables/Disables player save on this map.\n" );
	g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTCONSOLE, ".xp_start_simulation <Level> - OWNERS ONLY - Enables simulation mode for the remainder of the map.\n\n" );
}

CClientCommand _ADMIN_ADDXP( "xp_addxp", "<Name> <Amount> - Give XP to a player.", @ADMIN_ADDXP, ConCommandFlag::AdminOnly );
void ADMIN_ADDXP( const CCommand@ pArgs )
{
	CBasePlayer@ pPlayer = g_ConCommandSystem.GetCurrentPlayer();
	
	if ( pArgs.ArgC() >= 3 )
	{
		const int TARGET = FindPlayer( pArgs[ 1 ] );
		if ( TARGET == 0 )
		{
			g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTCONSOLE, "[SCXPM] Player not found.\n" );
			return;
		}
		if ( TARGET == -1 )
		{
			g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTCONSOLE, "[SCXPM] Multiple players found. Be more specific.\n" );
			return;
		}
		CBasePlayer@ pTarget = g_PlayerFuncs.FindPlayerByIndex( TARGET );
		const int iTargetIndex = pTarget.entindex();
		
		int addxp = Math.clamp( 0, scxpm_calc_xp( 24760 ) + 1, atoi( pArgs[ 2 ] ) );
		
		// This is "ADD" xp. Don't allow negative (or zero) values
		if ( addxp <= 0 )
		{
			g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTCONSOLE, "[SCXPM] Amount must be greater than 0.\n" );
			return;
		}
		
		// Max LV
		if ( playerlevel[ iTargetIndex ] >= 24760 )
		{
			g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTCONSOLE, "[SCXPM] That player is on its maximum level and no more XP can be given.\n" );
			return;
		}
		
		// Keep clamping
		int overflow = addxp + xp[ iTargetIndex ];
		if ( overflow > scxpm_calc_xp( 24760 ) )
			addxp = scxpm_calc_xp( 24760 ) - xp[ iTargetIndex ];
		
		// Get now the target's and the admin's name and steamid
		string aname = pPlayer.pev.netname;
		string asteamid = g_EngineFuncs.GetPlayerAuthId( pPlayer.edict() );
		string tname = pTarget.pev.netname;
		string tsteamid = g_EngineFuncs.GetPlayerAuthId( pTarget.edict() );
		
		xp[ iTargetIndex ] += addxp;
		g_Game.AlertMessage( at_logged, "[SCXPM] " + aname + " (" + asteamid + ") gave to " + tname + " (" + tsteamid + ") " + AddCommas( addxp ) + " XP.\n" );
		SCXPM_Log( aname + " (" + asteamid + ") gave to " + tname + " (" + tsteamid + ") " + AddCommas( addxp ) + " XP.\n" );
		
		earnedxp[ iTargetIndex ] += addxp;
		
		SaveData( iTargetIndex );
		
		g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTCONSOLE, "[SCXPM] " + AddCommas( addxp ) + " XP given to player.\n" );
		g_PlayerFuncs.ClientPrintAll( HUD_PRINTTALK, "ADMIN " + aname + ": Give " + AddCommas( addxp ) + " XP to " + tname + ".\n" );
	}
	else if ( pArgs.ArgC() == 1 )
		g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTCONSOLE, "[SCXPM] Usage: .xp_addxp <Name> <Amount> - Give XP to a player.\n" );
	else
		g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTCONSOLE, "[SCXPM] Not enough arguments.\n" );
}

CClientCommand _ADMIN_REMOVEXP( "xp_removexp", "<Name> <Amount> - Take XP away to a player.", @ADMIN_REMOVEXP, ConCommandFlag::AdminOnly );
void ADMIN_REMOVEXP( const CCommand@ pArgs )
{
	CBasePlayer@ pPlayer = g_ConCommandSystem.GetCurrentPlayer();
	
	if ( pArgs.ArgC() >= 3 )
	{
		const int TARGET = FindPlayer( pArgs[ 1 ] );
		if ( TARGET == 0 )
		{
			g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTCONSOLE, "[SCXPM] Player not found.\n" );
			return;
		}
		if ( TARGET == -1 )
		{
			g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTCONSOLE, "[SCXPM] Multiple players found. Be more specific.\n" );
			return;
		}
		CBasePlayer@ pTarget = g_PlayerFuncs.FindPlayerByIndex( TARGET );
		const int iTargetIndex = pTarget.entindex();
		
		int removexp = Math.clamp( 0, Math.INT32_MAX, atoi( pArgs[ 2 ] ) );
		
		// This is "REMOVE" xp. Don't allow negative (or zero) values
		if ( removexp <= 0 )
		{
			g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTCONSOLE, "[SCXPM] Amount must be greater than 0.\n" );
			return;
		}
		
		// Get now the target's and the admin's name and steamid
		string aname = pPlayer.pev.netname;
		string asteamid = g_EngineFuncs.GetPlayerAuthId( pPlayer.edict() );
		string tname = pTarget.pev.netname;
		string tsteamid = g_EngineFuncs.GetPlayerAuthId( pTarget.edict() );
		
		xp[ iTargetIndex ] -= removexp;
		if ( xp[ iTargetIndex ] < 0 ) xp[ iTargetIndex ] = 0; // Don't overflow
		g_Game.AlertMessage( at_logged, "[SCXPM] " + aname + " (" + asteamid + ") took from " + tname + " (" + tsteamid + ") " + AddCommas( removexp ) + " XP.\n" );
		SCXPM_Log( aname + " (" + asteamid + ") took from " + tname + " (" + tsteamid + ") " + AddCommas( removexp ) + " XP.\n" );
		
		earnedxp[ iTargetIndex ] -= removexp;
		
		// Level needs to be recalculated
		playerlevel[ iTargetIndex ] = scxpm_calc_lvl( xp[ iTargetIndex ] );
		
		// Reset skills
		SCXPMResetBasic( pTarget, true );
		g_PlayerFuncs.ClientPrint( pTarget, HUD_PRINTTALK, "[SCXPM] Your skills has been reset.\n" );
		
		// Recalculate needed xp
		scxpm_calcneedxp( iTargetIndex );
		
		SaveData( iTargetIndex );
		
		g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTCONSOLE, "[SCXPM] Took away " + AddCommas( removexp ) + " XP from the player.\n" );
		g_PlayerFuncs.ClientPrintAll( HUD_PRINTTALK, "ADMIN " + aname + ": Take " + AddCommas( removexp ) + " XP away from " + tname + ".\n" );
	}
	else if ( pArgs.ArgC() == 1 )
		g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTCONSOLE, "[SCXPM] Usage: .xp_removexp <Name> <Amount> - Take XP away to a player.\n" );
	else
		g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTCONSOLE, "[SCXPM] Not enough arguments.\n" );
}

CClientCommand _ADMIN_SETLVL( "xp_setlvl", "<Name> <Value> - Sets a player's level.", @ADMIN_SETLVL, ConCommandFlag::AdminOnly );
void ADMIN_SETLVL( const CCommand@ pArgs )
{
	CBasePlayer@ pPlayer = g_ConCommandSystem.GetCurrentPlayer();
	
	if ( pArgs.ArgC() >= 3 )
	{
		const int TARGET = FindPlayer( pArgs[ 1 ] );
		if ( TARGET == 0 )
		{
			g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTCONSOLE, "[SCXPM] Player not found.\n" );
			return;
		}
		if ( TARGET == -1 )
		{
			g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTCONSOLE, "[SCXPM] Multiple players found. Be more specific.\n" );
			return;
		}
		CBasePlayer@ pTarget = g_PlayerFuncs.FindPlayerByIndex( TARGET );
		const int iTargetIndex = pTarget.entindex();
		
		int nowlvl = Math.clamp( 0, 24760, atoi( pArgs[ 2 ] ) ); // 24.760 is the absolute max level that can be reached since XP is a 32-bit variable.
		
		// Get now the target's and the admin's name and steamid
		string aname = pPlayer.pev.netname;
		string asteamid = g_EngineFuncs.GetPlayerAuthId( pPlayer.edict() );
		string tname = pTarget.pev.netname;
		string tsteamid = g_EngineFuncs.GetPlayerAuthId( pTarget.edict() );
		
		if ( nowlvl == playerlevel[ iTargetIndex ] )
		{
			g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTCONSOLE, "[SCXPM] " + tname + "'s level is already " + nowlvl + ".\n" );
			return;
		}
		else
		{
			if ( nowlvl == 0 )
				xp[ iTargetIndex ] = 0;
			else
			{
				int helpvar = nowlvl - 1;
				double m70b = double( helpvar ) * 70.0;
				double mselfm3dot2b = double( helpvar ) * double( helpvar ) * 3.5;
				xp[ iTargetIndex ] = round( m70b + mselfm3dot2b + 30.0 );
			}
		}
		
		if ( playerlevel[ iTargetIndex ] > nowlvl )
		{
			playerlevel[ iTargetIndex ] = nowlvl;
			g_PlayerFuncs.ClientPrint( pTarget, HUD_PRINTTALK, "[SCXPM] Your skills has been reset.\n" );
			g_SoundSystem.EmitSoundDyn( pTarget.edict(), CHAN_STATIC, SND_PENALTY, VOL_NORM, ATTN_NONE, SND_SKIP_ORIGIN_USE_ENT, PITCH_NORM, iTargetIndex );
			
			SCXPMResetBasic( pTarget, true );
		}
		else
		{
			playerlevel[ iTargetIndex ] = nowlvl;
			scxpm_calc_skillpoints( iTargetIndex );
			
			g_SoundSystem.EmitSoundDyn( pTarget.edict(), CHAN_STATIC, SND_LEVEL_UP, VOL_NORM, ATTN_NONE, SND_SKIP_ORIGIN_USE_ENT, PITCH_NORM, iTargetIndex );
			
			g_PlayerFuncs.ClientPrint( pTarget, HUD_PRINTTALK, "[SCXPM] Good job, " + tname + "! You reached Level " + AddCommas( nowlvl ) + "!\n" );
			
			// Do not open the menu if the player does not want to (or no points given)
			if ( skillpoints[ iTargetIndex ] >= 1 && !IsBitSet( playerBits[ iTargetIndex ], MENU_NOAUTOOPEN ) )
				SCXPMSkill( pTarget );
		}
		scxpm_calcneedxp( iTargetIndex );
		SaveData( iTargetIndex );
		
		g_Game.AlertMessage( at_logged, "[SCXPM] " + aname + " (" + asteamid + ") setted " + tname + " (" + tsteamid + ")'s level to " + AddCommas( nowlvl ) + ".\n" );
		SCXPM_Log( aname + " (" + asteamid + ") setted " + tname + " (" + tsteamid + ")'s level to " + AddCommas( nowlvl ) + ".\n" );
		
		g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTCONSOLE, "[SCXPM] Player's level set to " + AddCommas( nowlvl ) + ".\n" );
		g_PlayerFuncs.ClientPrintAll( HUD_PRINTTALK, "ADMIN " + aname + ": Set " + tname + "'s level to " + AddCommas( nowlvl ) + ".\n" );
	}
	else if ( pArgs.ArgC() == 1 )
		g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTCONSOLE, "[SCXPM] Usage: .xp_setlvl <Name> <Value> - Sets a player's level.\n" );
	else
		g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTCONSOLE, "[SCXPM] Not enough arguments.\n" );
}

CClientCommand _ADMIN_ADDMEDAL( "xp_addmedal", "<Name> <Amount> - Give medals to a player.", @ADMIN_ADDMEDAL, ConCommandFlag::AdminOnly );
void ADMIN_ADDMEDAL( const CCommand@ pArgs )
{
	CBasePlayer@ pPlayer = g_ConCommandSystem.GetCurrentPlayer();
	
	if ( pArgs.ArgC() >= 3 )
	{
		const int TARGET = FindPlayer( pArgs[ 1 ] );
		if ( TARGET == 0 )
		{
			g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTCONSOLE, "[SCXPM] Player not found.\n" );
			return;
		}
		if ( TARGET == -1 )
		{
			g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTCONSOLE, "[SCXPM] Multiple players found. Be more specific.\n" );
			return;
		}
		CBasePlayer@ pTarget = g_PlayerFuncs.FindPlayerByIndex( TARGET );
		const int iTargetIndex = pTarget.entindex();
		
		int amount = Math.clamp( 0, 180, atoi( pArgs[ 2 ] ) );
		
		// This is "ADD" medals. Don't allow negative (or zero) values
		if ( amount <= 0 )
		{
			g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTCONSOLE, "[SCXPM] Amount must be greater than 0.\n" );
			return;
		}
		
		if ( medals[ iTargetIndex ] >= 180 )
		{
			g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTCONSOLE, "[SCXPM] That player has all possible medals. No more can be given.\n" );
			return;
		}
		
		// Welp, and repeat...
		int overflow = amount + medals[ iTargetIndex ];
		if ( overflow > 180 )
			amount = 180 - medals[ iTargetIndex ];
		
		medals[ iTargetIndex ] += amount;
		scxpm_calc_specialpoints( iTargetIndex );
		
		// Get now the target's and the admin's name and steamid
		string aname = pPlayer.pev.netname;
		string asteamid = g_EngineFuncs.GetPlayerAuthId( pPlayer.edict() );
		string tname = pTarget.pev.netname;
		string tsteamid = g_EngineFuncs.GetPlayerAuthId( pTarget.edict() );
		
		g_Game.AlertMessage( at_logged, "[SCXPM] " + aname + " (" + asteamid + ") gave to " + tname + " (" + tsteamid + ") " + amount + " medal(s).\n" );
		SCXPM_Log( aname + " (" + asteamid + ") gave to " + tname + " (" + tsteamid + ") " + amount + " medal(s).\n" );
		
		g_SoundSystem.EmitSoundDyn( pTarget.edict(), CHAN_STATIC, SND_MEDAL_GET, VOL_NORM, ATTN_NONE, SND_SKIP_ORIGIN_USE_ENT, PITCH_NORM, iTargetIndex );
		SaveData( iTargetIndex );
		
		g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTCONSOLE, "[SCXPM] " + amount + " medal(s) given to the player.\n" );
		g_PlayerFuncs.ClientPrintAll( HUD_PRINTTALK, "ADMIN " + aname + ": Give " + amount + " medal(s) to " + tname + ".\n" );
	}
	else if ( pArgs.ArgC() == 1 )
		g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTCONSOLE, "[SCXPM] Usage: .xp_addmedal <Name> <Amount> - Give medals to a player.\n" );
	else
		g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTCONSOLE, "[SCXPM] Not enough arguments.\n" );
}

CClientCommand _ADMIN_REMOVEMEDAL( "xp_removemedal", "<Name> <Amount> - Take medals away from a player.", @ADMIN_REMOVEMEDAL, ConCommandFlag::AdminOnly );
void ADMIN_REMOVEMEDAL( const CCommand@ pArgs )
{
	CBasePlayer@ pPlayer = g_ConCommandSystem.GetCurrentPlayer();
	
	if ( pArgs.ArgC() >= 3 )
	{
		const int TARGET = FindPlayer( pArgs[ 1 ] );
		if ( TARGET == 0 )
		{
			g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTCONSOLE, "[SCXPM] Player not found.\n" );
			return;
		}
		if ( TARGET == -1 )
		{
			g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTCONSOLE, "[SCXPM] Multiple players found. Be more specific.\n" );
			return;
		}
		CBasePlayer@ pTarget = g_PlayerFuncs.FindPlayerByIndex( TARGET );
		const int iTargetIndex = pTarget.entindex();
		
		int amount = Math.clamp( 0, 180, atoi( pArgs[ 2 ] ) );
		
		// This is "REMOVE" medals. Don't allow negative (or zero) values
		if ( amount <= 0 )
		{
			g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTCONSOLE, "[SCXPM] Amount must be greater than 0.\n" );
			return;
		}
		
		if ( medals[ iTargetIndex ] <= 0 )
		{
			g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTCONSOLE, "[SCXPM] That player has no medals at all. Can't take away anymore.\n" );
			return;
		}
		
		if ( amount > medals[ iTargetIndex ] )
			amount = medals[ iTargetIndex ];
		
		medals[ iTargetIndex ] -= amount;
		SCXPMResetSpecial( pTarget, true );
		
		// Get now the target's and the admin's name and steamid
		string aname = pPlayer.pev.netname;
		string asteamid = g_EngineFuncs.GetPlayerAuthId( pPlayer.edict() );
		string tname = pTarget.pev.netname;
		string tsteamid = g_EngineFuncs.GetPlayerAuthId( pTarget.edict() );
		
		g_Game.AlertMessage( at_logged, "[SCXPM] " + aname + " (" + asteamid + ") took from " + tname + " (" + tsteamid + ") " + amount + " medal(s).\n" );
		SCXPM_Log( aname + " (" + asteamid + ") took from " + tname + " (" + tsteamid + ") " + amount + " medal(s).\n" );
		
		g_PlayerFuncs.ClientPrint( pTarget, HUD_PRINTTALK, "[SCXPM] Your special skills has been reset.\n" );
		g_SoundSystem.EmitSoundDyn( pTarget.edict(), CHAN_STATIC, SND_PENALTY, VOL_NORM, ATTN_NONE, SND_SKIP_ORIGIN_USE_ENT, PITCH_NORM, iTargetIndex );
		
		SaveData( iTargetIndex );
		
		g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTCONSOLE, "[SCXPM] Took away " + amount + " medal(s) from the player.\n" );
		g_PlayerFuncs.ClientPrintAll( HUD_PRINTTALK, "ADMIN " + aname + ": Take " + amount + " medal(s) away from " + tname + ".\n" );
	}
	else if ( pArgs.ArgC() == 1 )
		g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTCONSOLE, "[SCXPM] Usage: .xp_removemedal <Name> <Amount> - Take medals away from a player.\n" );
	else
		g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTCONSOLE, "[SCXPM] Not enough arguments.\n" );
}

CClientCommand _ADMIN_ADDHAMMER( "xp_addhammer", "<Name> <Amount> - Give golden hammers to a player.", @ADMIN_ADDHAMMER, ConCommandFlag::AdminOnly );
void ADMIN_ADDHAMMER( const CCommand@ pArgs )
{
	CBasePlayer@ pPlayer = g_ConCommandSystem.GetCurrentPlayer();
	
	if ( pArgs.ArgC() >= 3 )
	{
		const int TARGET = FindPlayer( pArgs[ 1 ] );
		if ( TARGET == 0 )
		{
			g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTCONSOLE, "[SCXPM] Player not found.\n" );
			return;
		}
		if ( TARGET == -1 )
		{
			g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTCONSOLE, "[SCXPM] Multiple players found. Be more specific.\n" );
			return;
		}
		CBasePlayer@ pTarget = g_PlayerFuncs.FindPlayerByIndex( TARGET );
		const int iTargetIndex = pTarget.entindex();
		
		int addhammer = Math.clamp( 0, 5, atoi( pArgs[ 2 ] ) );
		
		// Don't allow negative (or zero) values
		if ( addhammer <= 0 )
		{
			g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTCONSOLE, "[SCXPM] Amount must be greater than 0.\n" );
			return;
		}
		
		// Get now the target's and the admin's name and steamid
		string aname = pPlayer.pev.netname;
		string asteamid = g_EngineFuncs.GetPlayerAuthId( pPlayer.edict() );
		string tname = pTarget.pev.netname;
		string tsteamid = g_EngineFuncs.GetPlayerAuthId( pTarget.edict() );
		
		hammers[ iTargetIndex ] += addhammer;
		g_Game.AlertMessage( at_logged, "[SCXPM] " + aname + " (" + asteamid + ") gave to " + tname + " (" + tsteamid + ") " + addhammer + " golden hammer(s)\n" );
		SCXPM_Log( aname + " (" + asteamid + ") gave to " + tname + " (" + tsteamid + ") " + addhammer + " golden hammer(s)\n" );
		
		SaveData( iTargetIndex );
		
		g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTCONSOLE, "[SCXPM] " + addhammer + " golden hammer(s) given to player.\n" );
		g_PlayerFuncs.ClientPrintAll( HUD_PRINTTALK, "ADMIN " + aname + ": Give " + addhammer + " golden hammer(s) to " + tname + ".\n" );
	}
	else if ( pArgs.ArgC() == 1 )
		g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTCONSOLE, "[SCXPM] Usage: .xp_addhammer <Name> <Amount> - Give golden hammers to a player.\n" );
	else
		g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTCONSOLE, "[SCXPM] Not enough arguments.\n" );
}

CClientCommand _ADMIN_SETMULTIPLIER( "xp_setmultiplier", "<Name> <Multiplier> <Duration> - Sets a player's XP multiplier.", @ADMIN_SETMULTIPLIER, ConCommandFlag::AdminOnly );
void ADMIN_SETMULTIPLIER( const CCommand@ pArgs )
{
	CBasePlayer@ pPlayer = g_ConCommandSystem.GetCurrentPlayer();
	
	if ( pArgs.ArgC() >= 4 )
	{
		const int TARGET = FindPlayer( pArgs[ 1 ] );
		if ( TARGET == 0 )
		{
			g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTCONSOLE, "[SCXPM] Player not found.\n" );
			return;
		}
		if ( TARGET == -1 )
		{
			g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTCONSOLE, "[SCXPM] Multiple players found. Be more specific.\n" );
			return;
		}
		CBasePlayer@ pTarget = g_PlayerFuncs.FindPlayerByIndex( TARGET );
		const int iTargetIndex = pTarget.entindex();
		
		int MULTIPLIER = atoi( pArgs[ 2 ] );
		
		if ( MULTIPLIER < 1 || MULTIPLIER > 5 )
		{
			g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTCONSOLE, "[SCXPM] XP Multiplier must be between 1x (remove multiplier) and 5x multiplier.\n" );
			return;
		}
		
		// Get now the target's and the admin's name and steamid
		string aname = pPlayer.pev.netname;
		string asteamid = g_EngineFuncs.GetPlayerAuthId( pPlayer.edict() );
		string tname = pTarget.pev.netname;
		string tsteamid = g_EngineFuncs.GetPlayerAuthId( pTarget.edict() );
		
		if ( MULTIPLIER == 1 ) // Remove
		{
			xpMultiplier[ iTargetIndex ] = 1;
			xpMultiplierTime[ iTargetIndex ] = 0;
			
			g_Game.AlertMessage( at_logged, "[SCXPM] " + aname + " (" + asteamid + ") took from " + tname + " (" + tsteamid + ") " + "its multiplier.\n" );
			SCXPM_Log( aname + " (" + asteamid + ") took from " + tname + " (" + tsteamid + ") " + "its multiplier.\n" );
			
			g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTCONSOLE, "[SCXPM] Multiplier removed from player (set to 1x).\n" );
			g_PlayerFuncs.ClientPrintAll( HUD_PRINTTALK, "ADMIN " + aname + ": Set " + tname + "'s XP multiplier to 1x.\n" );
		}
		else // Set
		{
			string DURATION = pArgs[ 3 ].ToLowercase();
			if ( DURATION[ 0 ] == '0' )
			{
				g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTCONSOLE, "[SCXPM] Duration must be greater than 0.\n" );
				return;
			}
			else if ( !isdigit( DURATION[ 0 ] ) )
			{
				g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTCONSOLE, "[SCXPM] Invalid duration.\n" );
				return;
			}
			else if ( isdigit( DURATION[ DURATION.Length() - 1 ] ) )
			{
				g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTCONSOLE, "[SCXPM] Your duration of \"" + DURATION + "\" needs additional specification.\n\n" );
				g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTCONSOLE, "Use one of the following properties:\n\n" );
				g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTCONSOLE, DURATION + "m = " + DURATION + " minute(s)\n" );
				g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTCONSOLE, DURATION + "h = " + DURATION + " hour(s)\n" );
				g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTCONSOLE, DURATION + "d = " + DURATION + " day(s)\n\n" );
				return;
			}
			else if ( DURATION[ DURATION.Length() - 1 ] != 'm' && DURATION[ DURATION.Length() - 1 ] != 'h' && DURATION[ DURATION.Length() - 1 ] != 'd' )
			{
				g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTCONSOLE, "[SCXPM] Invalid duration property.\n\n" );
				g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTCONSOLE, "Use one of the following properties:\n\n" );
				g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTCONSOLE, "m = minute(s)\n" );
				g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTCONSOLE, "h = hour(s)\n" );
				g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTCONSOLE, "d = day(s)\n\n" );
				return;
			}
			else
			{
				int characters = 0;
				for ( uint i = 0; i < DURATION.Length(); i++ )
				{
					if ( isalpha( DURATION[ i ] ) )
						characters++;
				}
				
				if ( characters > 1 )
				{
					g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTCONSOLE, "[SCXPM] Only one property is allowed.\n" );
					return;
				}
				else
				{
					xpMultiplier[ iTargetIndex ] = MULTIPLIER;
					
					// Save original flag
					char flag = DURATION[ DURATION.Length() - 1 ];
					
					DURATION.Replace( string( flag ), '=' );
					array< string >@ fixer = DURATION.Split( '=' );
					fixer[ 0 ].Trim();
					
					if ( flag == 'm' )
					{
						// Minutes
						xpMultiplierTime[ iTargetIndex ] = atoi( fixer[ 0 ] ) + 1;
					}
					else if ( flag == 'h' )
					{
						// Hours
						xpMultiplierTime[ iTargetIndex ] = ( atoi( fixer[ 0 ] ) * 60 ) + 1;
					}
					else if ( flag == 'd' )
					{
						// Days
						xpMultiplierTime[ iTargetIndex ] = ( atoi( fixer[ 0 ] ) * 24 * 60 ) + 1;
					}
					
					g_Game.AlertMessage( at_logged, "[SCXPM] " + aname + " (" + asteamid + ") gave to " + tname + " (" + tsteamid + ") " + "a x" + MULTIPLIER + " multiplier [" + fixer[ 0 ] + string( flag ) + "].\n" );
					SCXPM_Log( aname + " (" + asteamid + ") gave to " + tname + " (" + tsteamid + ") " + "a x" + MULTIPLIER + " multiplier [" + fixer[ 0 ] + string( flag ) + "].\n" );
					
					g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTCONSOLE, "[SCXPM] Gave a " + MULTIPLIER + "x multiplier [" + fixer[ 0 ] + flag + "] to the player.\n" );
					g_PlayerFuncs.ClientPrintAll( HUD_PRINTTALK, "ADMIN " + aname + ": Set " + MULTIPLIER + "x multiplier to " + tname + ".\n" );
				}
			}
		}
		
		SaveData( iTargetIndex );
	}
	else if ( pArgs.ArgC() == 1 )
		g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTCONSOLE, "[SCXPM] Usage: .xp_setmultiplier <Name> <Multiplier> <Duration> - Sets a player's XP multiplier.\n" );
	else
		g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTCONSOLE, "[SCXPM] Not enough arguments.\n" );
}

CClientCommand _ADMIN_GIVEPERMA( "xp_givemodifier", "<Name> <Percent> <Title> <Description> - Give an XP Mod to a player.", @ADMIN_GIVEPERMA, ConCommandFlag::AdminOnly );
void ADMIN_GIVEPERMA( const CCommand@ pArgs )
{
	CBasePlayer@ pPlayer = g_ConCommandSystem.GetCurrentPlayer();
	
	if ( pArgs.ArgC() >= 5 )
	{
		const int TARGET = FindPlayer( pArgs[ 1 ] );
		if ( TARGET == 0 )
		{
			g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTCONSOLE, "[SCXPM] Player not found.\n" );
			return;
		}
		if ( TARGET == -1 )
		{
			g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTCONSOLE, "[SCXPM] Multiple players found. Be more specific.\n" );
			return;
		}
		CBasePlayer@ pTarget = g_PlayerFuncs.FindPlayerByIndex( TARGET );
		const int iTargetIndex = pTarget.entindex();
		
		int PERCENT = atoi( pArgs[ 2 ] );
		
		string szTitle = pArgs[ 3 ];
		string szDescription = pArgs[ 4 ];
		
		// Ensure we are not giving a duplicate XP Modifier
		if ( HasPermaIncrease( iTargetIndex, szTitle ) )
		{
			g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTCONSOLE, "[SCXPM] That player already has that XP Mod.\n" );
			return;
		}
		
		// Give it
		AddPermaIncrease( iTargetIndex, PERCENT, szTitle, szDescription );
		
		// Get now the target's and the admin's name and steamid
		string aname = pPlayer.pev.netname;
		string asteamid = g_EngineFuncs.GetPlayerAuthId( pPlayer.edict() );
		string tname = pTarget.pev.netname;
		string tsteamid = g_EngineFuncs.GetPlayerAuthId( pTarget.edict() );
		
		// Log messages
		if ( PERCENT != 0 )
		{
			g_Game.AlertMessage( at_logged, "[SCXPM] " + aname + " (" + asteamid + ") gave to " + tname + " (" + tsteamid + ") " + "an XP Mod of" + ( PERCENT > 0 ? " +" : " " ) + string( PERCENT ) + "%.\n" );
			SCXPM_Log( aname + " (" + asteamid + ") gave to " + tname + " (" + tsteamid + ") " + "an XP Mod of" + ( PERCENT > 0 ? " +" : " " ) + string( PERCENT ) + "%.\n" );
			
			g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTCONSOLE, "[SCXPM] Gave an XP Mod of" + ( PERCENT > 0 ? " +" : " " ) + string( PERCENT ) + "%% to the player.\n" );
			g_PlayerFuncs.ClientPrintAll( HUD_PRINTTALK, "ADMIN " + aname + ": Give XP Mod to " + tname + ".\n" );
		}
		else
		{
			g_Game.AlertMessage( at_logged, "[SCXPM] " + aname + " (" + asteamid + ") gave to " + tname + " (" + tsteamid + ") " + "an honorific mention.\n" );
			SCXPM_Log( aname + " (" + asteamid + ") gave to " + tname + " (" + tsteamid + ") " + "an honorific mention.\n" );
			
			g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTCONSOLE, "[SCXPM] Gave an honorific mention to the player.\n" );
			g_PlayerFuncs.ClientPrintAll( HUD_PRINTTALK, "ADMIN " + aname + ": Give honorific mention to " + tname + ".\n" );
		}
	}
	else if ( pArgs.ArgC() == 1 )
		g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTCONSOLE, "[SCXPM] Usage: .xp_givemodifier <Name> <Percent> <Title> <Description> - Give an XP Mod to a player.\n" );
	else
		g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTCONSOLE, "[SCXPM] Not enough arguments.\n" );
}

CClientCommand _ADMIN_SETADATA( "xp_setadata", "<Name> <Achievement ID> <Unlock> <Give Reward> - Locks or unlocks an achievement to a player.", @ADMIN_SETADATA, ConCommandFlag::AdminOnly );
void ADMIN_SETADATA( const CCommand@ pArgs )
{
	CBasePlayer@ pPlayer = g_ConCommandSystem.GetCurrentPlayer();
	
	if ( pArgs.ArgC() >= 3 )
	{
		const int TARGET = FindPlayer( pArgs[ 1 ] );
		if ( TARGET == 0 )
		{
			g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTCONSOLE, "[SCXPM] Player not found.\n" );
			return;
		}
		if ( TARGET == -1 )
		{
			g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTCONSOLE, "[SCXPM] Multiple players found. Be more specific.\n" );
			return;
		}
		CBasePlayer@ pTarget = g_PlayerFuncs.FindPlayerByIndex( TARGET );
		const int iTargetIndex = pTarget.entindex();
		
		int iAchievementID = atoi( pArgs[ 2 ] );
		if ( iAchievementID < 0 || iAchievementID > int( gameAchievements.length() - 1 ) )
		{
			g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTCONSOLE, "[SCXPM] Invalid achievement ID.\n" );
			return;
		}
		
		array< string > A = gameAchievements[ iAchievementID ].Split( '#' );
		
		if ( pArgs.ArgC() == 3 )
		{
			g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTCONSOLE, "[SCXPM] Selected achievement: " + A[ tNAME ] + ".\n" );
			
			if ( playerAchievements[ iTargetIndex ][ iAchievementID ] != LOCKED )
				g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTCONSOLE, "[SCXPM] Player ALREADY HAS the achievement.\n" );
			else
				g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTCONSOLE, "[SCXPM] Player DOES NOT have the achievement.\n" );
			
			return;
		}
		else if ( pArgs.ArgC() >= 5 )
		{
			int iUnlock = atoi( pArgs[ 3 ] );
			int iReward = atoi( pArgs[ 4 ] );
			
			if ( playerAchievements[ iTargetIndex ][ iAchievementID ] != LOCKED && iUnlock >= 1 )
			{
				g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTCONSOLE, "[SCXPM] That player ALREADY HAS the achievement.\n" );
				return;
			}
			else if ( playerAchievements[ iTargetIndex ][ iAchievementID ] == LOCKED && iUnlock <= 0 )
			{
				g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTCONSOLE, "[SCXPM] That player DOES NOT have the achievement.\n" );
				return;
			}
			
			// Get now the target's and the admin's name and steamid
			string aname = pPlayer.pev.netname;
			string asteamid = g_EngineFuncs.GetPlayerAuthId( pPlayer.edict() );
			string tname = pTarget.pev.netname;
			string tsteamid = g_EngineFuncs.GetPlayerAuthId( pTarget.edict() );
			
			// Lock or unlock?
			if ( iUnlock == 1 )
			{
				playerAchievements[ iTargetIndex ][ iAchievementID ] = UNLOCKED;
				
				// Give reward?
				if ( iReward == 1 )
					GiveAchievementReward( iTargetIndex, iAchievementID );
			}
			else
				playerAchievements[ iTargetIndex ][ iAchievementID ] = LOCKED;
			
			// Log messages
			g_Game.AlertMessage( at_logged, "[SCXPM] " + aname + " (" + asteamid + ") edited achievement data to " + tname + " (" + tsteamid + ") | " + A[ tNAME ] + " [" + ( iUnlock >= 1 ? "UNLOCK" : "LOCK" ) + "]" + "[" + ( iReward >= 1 ? "WITH REWARD" : "WITHOUT REWARD" ) + "].\n" );
			SCXPM_Log( aname + " (" + asteamid + ") edited achievement data to " + tname + " (" + tsteamid + ") | " + A[ tNAME ] + " [" + ( iUnlock >= 1 ? "UNLOCK" : "LOCK" ) + "]" + "[" + ( iReward >= 1 ? "WITH REWARD" : "WITHOUT REWARD" ) + "].\n" );
			
			g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTCONSOLE, "[SCXPM] The player's achievement data has been updated.\n" );
			
			if ( iUnlock == 1 ) g_PlayerFuncs.ClientPrintAll( HUD_PRINTTALK, "ADMIN " + aname + ": Unlock achievement " + A[ tNAME ] + " to " + tname + ".\n" );
			else g_PlayerFuncs.ClientPrintAll( HUD_PRINTTALK, "ADMIN " + aname + ": Lock achievement " + A[ tNAME ] + " to " + tname + ".\n" );
		}
		else
		{
			g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTCONSOLE, "[SCXPM] Please specify Unlock and Give Reward:\n" );
			g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTCONSOLE, "---\n" );
			g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTCONSOLE, "Unlock = 1 --> Unlock achievement.\n" );
			g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTCONSOLE, "Unlock = 0 --> Lock achievement.\n" );
			g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTCONSOLE, "---\n" );
			g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTCONSOLE, "Give Reward = 1 --> Give the achievement's reward to the player.\n" );
			g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTCONSOLE, "Give Reward = 0 --> Do NOT give the achievement's reward to the player.\n" );
		}
	}
	else if ( pArgs.ArgC() == 1 )
		g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTCONSOLE, "[SCXPM] Usage: .xp_setadata <Name> <Achievement ID> <Unlock> <Give Reward> - Locks or unlocks an achievement to a player.\n" );
	else
		g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTCONSOLE, "[SCXPM] Not enough arguments.\n" );
}

CClientCommand _ADMIN_FORCEHANDICAP( "xp_force_handicap", "<Name> <Handicap> <Silent> - Forces a handicap to a player.", @ADMIN_FORCEHANDICAP, ConCommandFlag::AdminOnly );
void ADMIN_FORCEHANDICAP( const CCommand@ pArgs )
{
	CBasePlayer@ pPlayer = g_ConCommandSystem.GetCurrentPlayer();
	
	if ( pArgs.ArgC() >= 4 )
	{
		const int TARGET = FindPlayer( pArgs[ 1 ] );
		if ( TARGET == 0 )
		{
			g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTCONSOLE, "[SCXPM] Player not found.\n" );
			return;
		}
		if ( TARGET == -1 )
		{
			g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTCONSOLE, "[SCXPM] Multiple players found. Be more specific.\n" );
			return;
		}
		CBasePlayer@ pTarget = g_PlayerFuncs.FindPlayerByIndex( TARGET );
		const int iTargetIndex = pTarget.entindex();
		
		int iHC = atoi( pArgs[ 2 ] );
		int silent = atoi( pArgs[ 3 ] );
		
		if ( iHC > 15 )
		{
			g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTCONSOLE, "[SCXPM] Invalid handicap.\n" );
			return;
		}
		
		// Get now the target's and the admin's name and steamid
		string aname = pPlayer.pev.netname;
		string asteamid = g_EngineFuncs.GetPlayerAuthId( pPlayer.edict() );
		string tname = pTarget.pev.netname;
		string tsteamid = g_EngineFuncs.GetPlayerAuthId( pTarget.edict() );
		
		if ( iHC <= 0 ) // Remove all handicaps
		{
			forcedHandicaps[ iTargetIndex ] = 0;
			
			g_Game.AlertMessage( at_logged, "[SCXPM] " + aname + " (" + asteamid + ") disabled all forced handicaps to " + tname + " (" + tsteamid + ") " + ".\n" );
			SCXPM_Log( aname + " (" + asteamid + ") disabled all forced handicaps to " + tname + " (" + tsteamid + ") " + ".\n" );
			g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTCONSOLE, "[SCXPM] All forced handicaps disabled.\n" );
			
			if ( silent == 0 )
				g_PlayerFuncs.ClientPrintAll( HUD_PRINTTALK, "ADMIN " + aname + ": Disable handicaps to " + tname + ".\n" );
		}
		else // Add
		{
			forcedHandicaps[ iTargetIndex ] |= ( 1 << ( iHC - 1 ) );
			string szHandicapName = GetHandicapName( iHC );
			
			g_Game.AlertMessage( at_logged, "[SCXPM] " + aname + " (" + asteamid + ") enabled handicap [" + szHandicapName + "] to " + tname + " (" + tsteamid + ") " + ".\n" );
			SCXPM_Log( aname + " (" + asteamid + ") enabled handicap [" + szHandicapName + "] to " + tname + " (" + tsteamid + ") " + ".\n" );
			g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTCONSOLE, "[SCXPM] Enabled handicap [" + szHandicapName + "].\n" );
			
			if ( silent == 0 )
				g_PlayerFuncs.ClientPrintAll( HUD_PRINTTALK, "ADMIN " + aname + ": Enable handicap [" + szHandicapName + "] on " + tname + ".\n" );
		}
	}
	else if ( pArgs.ArgC() == 1 )
		g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTCONSOLE, "[SCXPM] Usage: .xp_force_handicap <Name> <Handicap> <Silent> - Forces a handicap to a player.\n" );
	else
		g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTCONSOLE, "[SCXPM] Not enough arguments.\n" );
}

CClientCommand _ADMIN_MAPXPGAIN( "xp_set_xpgain", "<Value> - OWNERS ONLY - Changes map's XP gain.", @ADMIN_MAPXPGAIN, ConCommandFlag::AdminOnly );
void ADMIN_MAPXPGAIN( const CCommand@ pArgs )
{
	CBasePlayer@ pPlayer = g_ConCommandSystem.GetCurrentPlayer();
	
	AdminLevel_t alevel = g_PlayerFuncs.AdminLevel( pPlayer );
	if ( alevel != ADMIN_OWNER )
	{
		g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTCONSOLE, "[SCXPM] Access denied.\n" );
		return;
	}
	
	if ( pArgs.ArgC() >= 2 )
	{
		float flNewXPGain = atof( pArgs[ 1 ] );
		
		// No negative numbers
		if ( flNewXPGain < 0.00 )
		{
			g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTCONSOLE, "[SCXPM] New XP gain must be greater or equal than x0.00.\n" );
			return;
		}
		
		MAP_XPGAIN = flNewXPGain;
		
		// Get now the admin's name and steamid
		string aname = pPlayer.pev.netname;
		string asteamid = g_EngineFuncs.GetPlayerAuthId( pPlayer.edict() );
		
		// Log messages
		g_Game.AlertMessage( at_logged, "[SCXPM] " + aname + " (" + asteamid + ") changed the map's XP gain to x" + fl2Decimals( flNewXPGain ) + ".\n" );
		SCXPM_Log( aname + " (" + asteamid + ") changed the map's XP gain to x" + fl2Decimals( flNewXPGain ) + ".\n" );
		
		g_PlayerFuncs.ClientPrintAll( HUD_PRINTTALK, "ADMIN " + aname + ": Changed map's XP gain.\n" );
		g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTCONSOLE, "[SCXPM] New XP gain has been set.\n" );
	}
	else if ( pArgs.ArgC() == 1 )
	{
		g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTCONSOLE, "[SCXPM] Usage: .xp_set_xpgain <Value> - Changes map's XP gain.\n" );
		g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTCONSOLE, "[SCXPM] NOTE: This only changes the map's BASE XP GAIN. It does not affect player's individual XP gain.\n" );
		g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTCONSOLE, "[SCXPM] Map's XP gain is currently on x" + fl2Decimals( MAP_XPGAIN ) + ".\n" );
	}
}

CClientCommand _ADMIN_TOGGLESKILLS( "xp_toggle_skills", "- OWNERS ONLY - Enables/Disables skills on this map.", @ADMIN_TOGGLESKILLS, ConCommandFlag::AdminOnly );
void ADMIN_TOGGLESKILLS( const CCommand@ pArgs )
{
	CBasePlayer@ pPlayer = g_ConCommandSystem.GetCurrentPlayer();
	
	AdminLevel_t alevel = g_PlayerFuncs.AdminLevel( pPlayer );
	if ( alevel != ADMIN_OWNER )
	{
		g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTCONSOLE, "[SCXPM] Access denied.\n" );
		return;
	}
	
	// Toggle
	gameSettings ^= NO_SKILLS;
	
	// Get now the admin's name and steamid
	string aname = pPlayer.pev.netname;
	string asteamid = g_EngineFuncs.GetPlayerAuthId( pPlayer.edict() );
	
	// Log messages
	if ( IsBitSet( gameSettings, NO_SKILLS ) )
	{
		g_Game.AlertMessage( at_logged, "[SCXPM] " + aname + " (" + asteamid + ") disabled all skills.\n" );
		SCXPM_Log( aname + " (" + asteamid + ") disabled all skills.\n" );
		
		g_PlayerFuncs.ClientPrintAll( HUD_PRINTTALK, "ADMIN " + aname + ": Turn off all SCXPM skills.\n" );
		g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTCONSOLE, "[SCXPM] Skills disabled.\n" );
	}
	else
	{
		g_Game.AlertMessage( at_logged, "[SCXPM] " + aname + " (" + asteamid + ") enabled all skills.\n" );
		SCXPM_Log( aname + " (" + asteamid + ") enabled all skills.\n" );
		
		g_PlayerFuncs.ClientPrintAll( HUD_PRINTTALK, "ADMIN " + aname + ": Turn on all SCXPM skills.\n" );
		g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTCONSOLE, "[SCXPM] Skills enabled.\n" );
	}
}

CClientCommand _ADMIN_TOGGLEOVERPOWER( "xp_toggle_overpower", "- OWNERS ONLY - Enables/Disables overpower on this map.", @ADMIN_TOGGLEOVERPOWER, ConCommandFlag::AdminOnly );
void ADMIN_TOGGLEOVERPOWER( const CCommand@ pArgs )
{
	CBasePlayer@ pPlayer = g_ConCommandSystem.GetCurrentPlayer();
	
	AdminLevel_t alevel = g_PlayerFuncs.AdminLevel( pPlayer );
	if ( alevel != ADMIN_OWNER )
	{
		g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTCONSOLE, "[SCXPM] Access denied.\n" );
		return;
	}
	
	// Toggle
	gameSettings ^= OVERPOWER;
	
	// Get now the admin's name and steamid
	string aname = pPlayer.pev.netname;
	string asteamid = g_EngineFuncs.GetPlayerAuthId( pPlayer.edict() );
	
	// Log messages
	if ( IsBitSet( gameSettings, OVERPOWER ) )
	{
		g_Game.AlertMessage( at_logged, "[SCXPM] " + aname + " (" + asteamid + ") enabled overpower setting.\n" );
		SCXPM_Log( aname + " (" + asteamid + ") enabled overpower setting.\n" );
		
		g_PlayerFuncs.ClientPrintAll( HUD_PRINTTALK, "ADMIN " + aname + ": Enable overpowered skills.\n" );
		g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTCONSOLE, "[SCXPM] Overpower enabled.\n" );
	}
	else
	{
		g_Game.AlertMessage( at_logged, "[SCXPM] " + aname + " (" + asteamid + ") disabled overpower setting.\n" );
		SCXPM_Log( aname + " (" + asteamid + ") disabled overpower setting.\n" );
		
		g_PlayerFuncs.ClientPrintAll( HUD_PRINTTALK, "ADMIN " + aname + ": Disable overpowered skills.\n" );
		g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTCONSOLE, "[SCXPM] Overpower disabled.\n" );
	}
}

CClientCommand _ADMIN_TOGGLESAVE( "xp_toggle_save", "- OWNERS ONLY - Enables/Disables player save on this map.", @ADMIN_TOGGLESAVE, ConCommandFlag::AdminOnly );
void ADMIN_TOGGLESAVE( const CCommand@ pArgs )
{
	CBasePlayer@ pPlayer = g_ConCommandSystem.GetCurrentPlayer();
	
	AdminLevel_t alevel = g_PlayerFuncs.AdminLevel( pPlayer );
	if ( alevel != ADMIN_OWNER )
	{
		g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTCONSOLE, "[SCXPM] Access denied.\n" );
		return;
	}
	
	// Toggle
	gameSettings ^= NO_SAVE;
	
	// Get now the admin's name and steamid
	string aname = pPlayer.pev.netname;
	string asteamid = g_EngineFuncs.GetPlayerAuthId( pPlayer.edict() );
	
	// Log messages
	if ( IsBitSet( gameSettings, NO_SAVE ) )
	{
		g_Game.AlertMessage( at_logged, "[SCXPM] " + aname + " (" + asteamid + ") disabled data saving.\n" );
		SCXPM_Log( aname + " (" + asteamid + ") disabled data saving.\n" );
		
		g_PlayerFuncs.ClientPrintAll( HUD_PRINTTALK, "ADMIN " + aname + ": Turn off data saving.\n" );
		g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTCONSOLE, "[SCXPM] Player data is no longer saved.\n" );
	}
	else
	{
		g_Game.AlertMessage( at_logged, "[SCXPM] " + aname + " (" + asteamid + ") enabled data saving.\n" );
		SCXPM_Log( aname + " (" + asteamid + ") enabled data saving.\n" );
		
		g_PlayerFuncs.ClientPrintAll( HUD_PRINTTALK, "ADMIN " + aname + ": Turn on data saving.\n" );
		g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTCONSOLE, "[SCXPM] Player data will now be saved.\n" );
	}
}

CClientCommand _ADMIN_STARTSIMULATION( "xp_start_simulation", "<Level> - OWNERS ONLY - Enables simulation mode for the remainder of the map.", @ADMIN_STARTSIMULATION, ConCommandFlag::AdminOnly );
void ADMIN_STARTSIMULATION( const CCommand@ pArgs )
{
	CBasePlayer@ pPlayer = g_ConCommandSystem.GetCurrentPlayer();
	
	AdminLevel_t alevel = g_PlayerFuncs.AdminLevel( pPlayer );
	if ( alevel != ADMIN_OWNER )
	{
		g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTCONSOLE, "[SCXPM] Access denied.\n" );
		return;
	}
	
	if ( pArgs.ArgC() >= 2 )
	{
		if ( IsBitSet( gameSettings, SINGLE_ACHIEVEMENT ) || IsBitSet( gameSettings, LIMITED_RESPAWN ) )
		{
			g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTCONSOLE, "[SCXPM] Cannot enable simulation mode on this map.\n" );
			return;
		}
		
		if ( IsBitSet( gameSettings, SIMULATED_LEVEL ) )
		{
			g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTCONSOLE, "[SCXPM] Simulation mode is already active.\n" );
			return;
		}
		
		int level = atoi( pArgs[ 1 ] );
		
		// No negative numbers
		if ( level < 0 )
		{
			g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTCONSOLE, "[SCXPM] The level to simulate must be greater or equal than 0.\n" );
			return;
		}
		
		// Create simulated entity
		CBaseEntity@ pSimulation = g_EntityFuncs.Create( "scxpm_simulate_level", g_vecZero, g_vecZero, true );
		pSimulation.KeyValue( "level", string( level ) );
		g_EntityFuncs.DispatchSpawn( pSimulation.edict() );
		
		// Get now the admin's name and steamid
		string aname = pPlayer.pev.netname;
		string asteamid = g_EngineFuncs.GetPlayerAuthId( pPlayer.edict() );
		
		// Log messages
		g_Game.AlertMessage( at_logged, "[SCXPM] " + aname + " (" + asteamid + ") enabled simulation mode (Level " + level + ").\n" );
		SCXPM_Log( aname + " (" + asteamid + ") enabled simulation mode (Level " + level + ").\n" );
		
		g_PlayerFuncs.ClientPrintAll( HUD_PRINTTALK, "ADMIN " + aname + ": Enable simulation mode.\n" );
		g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTCONSOLE, "[SCXPM] Simulation mode activated.\n" );
	}
	else if ( pArgs.ArgC() == 1 )
	{
		g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTCONSOLE, "[SCXPM] Usage: .xp_start_simulation <Level> - OWNERS ONLY - Enables simulation mode for the remainder of the map.\n" );
		g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTCONSOLE, "[SCXPM] WARNING: Once enabled it cannot be turned off until map change.\n" );
	}
}

/** CORE FUNCTIONS **/
void scxpm_sdac()
{
	if ( IsBitSet( gameSettings, DISABLED ) )
		return;
	
	if ( onecount )
	{
		scxpm_showdata();
		scxpm_reexp();
	}
	onecount = !onecount;
	scxpm_regen();
	scxpm_updatehc();
}

void scxpm_showdata()
{
	if ( IsBitSet( gameSettings, HIDE_HUD ) )
		return;
	
	int hudCVar = int( g_EngineFuncs.CVarGetFloat( "scxpm_hud_channel" ) );
	
	HUDTextParams textParams;
	textParams.fadeinTime = 0.0;
	textParams.fadeoutTime = 0.0;
	textParams.holdTime = 255.0;
	textParams.fxTime = 1.0;
	textParams.channel = hudCVar == 0 ? 3 : hudCVar;
	
	for ( int iPlayerIndex = 1; iPlayerIndex <= g_Engine.maxClients; iPlayerIndex++ )
	{
		CBasePlayer@ pPlayer = g_PlayerFuncs.FindPlayerByIndex( iPlayerIndex );
		if ( pPlayer is null || !pPlayer.IsConnected() )
			continue;
		
		const int playerBITS = playerBits[ iPlayerIndex ];
		
		const int XP = xp[ iPlayerIndex ];
		const int LEVEL = playerlevel[ iPlayerIndex ];
		const int XP_REMAIN = ( neededxp[ iPlayerIndex ] - xp[ iPlayerIndex ] );
		const int XP_EARNED = earnedxp[ iPlayerIndex ];
		const int MEDALS = medals[ iPlayerIndex ];
		const int ACHIEVEMENTS = GetAchievementClear( iPlayerIndex );
		
		string hudtext;
		
		if ( IsBitSet( playerBITS, HUD_XP ) )
			hudtext += "XP: " + AddCommas( XP ) + "\n";
		
		if ( IsBitSet( playerBITS, HUD_LEVEL ) )
			hudtext += "Level: " + AddCommas( LEVEL ) + "\n";
		
		if ( IsBitSet( playerBITS, HUD_XPLEFT ) )
			hudtext += ( LEVEL == 24760 ? "---,---" : AddCommas( XP_REMAIN ) ) + " XP left for next level\n";
		
		if ( IsBitSet( gameSettings, DELAYED_XP ) )
		{
			if ( earnedxp[ iPlayerIndex ] >= 0.0 )
				hudtext += "You will gain " + AddCommas( XP_EARNED ) + " XP at mission end\n";
			else
				hudtext += "You will lose " + AddCommas( abs( XP_EARNED ) ) + " XP at mission end\n";
		}
		else if ( IsBitSet( playerBITS, HUD_XPEARN ) )
		{
			if ( earnedxp[ iPlayerIndex ] >= 0.0 )
				hudtext += "You won " + AddCommas( XP_EARNED ) + " XP on this map\n";
			else
				hudtext += "You lost " + AddCommas( abs( XP_EARNED ) ) + " XP on this map\n";
		}
		
		if ( IsBitSet( playerBITS, HUD_MEDALS ) )
			hudtext += "Medals: " + AddCommas( MEDALS ) + "\n";
		
		if ( IsBitSet( playerBITS, HUD_ACHIEVEMENTS ) )
			hudtext += "Achievements: " + ACHIEVEMENTS + " / " + gameNormalAchievements + "\n";
		
		if ( IsBitSet( playerBITS, HUD_SKILLS ) )
		{
			const int SKILLS = skillpoints[ iPlayerIndex ];
			const int SPECIALS = specialpoints[ iPlayerIndex ];
			hudtext += "\n";
			
			if ( SKILLS > 0 ) hudtext += "Skillpoints available: say '/selectskills' in chat\n";
			if ( SPECIALS > 0 ) hudtext += "Skillpoints available: say '/selectspecials' in chat\n";
		}
		
		// player does not want any HUD info to be shown, ignore
		if ( hudtext.Length() == 0 )
			continue;
		
		textParams.x = hudPosition[ iPlayerIndex ].x;
		textParams.y = hudPosition[ iPlayerIndex ].y;
		textParams.effect = hudEffect[ iPlayerIndex ];
		textParams.r1 = hudColor[ iPlayerIndex ].r;
		textParams.g1 = hudColor[ iPlayerIndex ].g;
		textParams.b1 = hudColor[ iPlayerIndex ].b;
		textParams.a1 = hudColor[ iPlayerIndex ].a;
		textParams.r2 = ~hudColor[ iPlayerIndex ].r;
		textParams.g2 = ~hudColor[ iPlayerIndex ].g;
		textParams.b2 = ~hudColor[ iPlayerIndex ].b;
		textParams.a2 = ~hudColor[ iPlayerIndex ].a;
		
		g_PlayerFuncs.HudMessage( pPlayer, textParams, hudtext );
	}
}

void scxpm_regen()
{
	if ( IsBitSet( gameSettings, NO_SKILLS ) )
		return;
	
	for ( int iPlayerIndex = 1; iPlayerIndex <= g_Engine.maxClients; iPlayerIndex++ )
	{
		CBasePlayer@ pPlayer = g_PlayerFuncs.FindPlayerByIndex( iPlayerIndex );
		if ( pPlayer is null || !pPlayer.IsConnected() )
			continue;
		
		if ( !pPlayer.IsAlive() )
			continue;
		
		// Gather skills
		float EXTRA_HEALTH = float( health[ iPlayerIndex ] );						// Strength
		float EXTRA_ARMOR = float( armor[ iPlayerIndex ] );							// Superior Armor
		int HEALTH_REGEN = rhealth[ iPlayerIndex ];									// Regeneration
		int ARMOR_REGEN = rarmor[ iPlayerIndex ];									// Nano Armor
		int AMMO_REGEN = rammo[ iPlayerIndex ];										// Ammo Reincarnation
		float AWARENESS = float( speed[ iPlayerIndex ] ) / 2.5;						// Awareness
		int TEAM_POWER = dist[ iPlayerIndex ];										// Team Power
		
		int MEDKIT_REGEN = fastheal[ iPlayerIndex ];								// Quick Heal
		int ARNADE_REGEN = demoman[ iPlayerIndex ];									// Demoman
		bool DISPENCER = IsBitSet( playerBits[ iPlayerIndex ], SKILL_DISPENCER );	// Portable Dispencer
		
		const float HEALTH = pPlayer.pev.health;
		const float ARMOR = pPlayer.pev.armorvalue;
		const float MEDALS = Math.clamp( 0.0, 30.0, float( medals[ iPlayerIndex ] ) );
		
		float HEALTH_WAIT = rhealthwait[ iPlayerIndex ];
		float ARMOR_WAIT = rarmorwait[ iPlayerIndex ];
		float AMMO_WAIT = rammowait[ iPlayerIndex ];
		
		float MEDKIT_WAIT = rmedkitwait[ iPlayerIndex ];
		
		// Ensure all health/armor regeneration is clamped to a maximum of 200.
		if ( HEALTH_REGEN > 0 )
		{
			const float MAX_REGEN = ( EXTRA_HEALTH / 2.0 ) + starthealth + AWARENESS + ( !HasHandicap( iPlayerIndex, LACKING_HELP ) ? MEDALS : 0.0 );
			const float RNG_REGEN = Math.RandomFloat( 0.0, 200.0 + ( float( HEALTH_REGEN ) / 2.0 ) + AWARENESS + ( !HasHandicap( iPlayerIndex, LACKING_HELP ) ? MEDALS : 0.0 ) );
			
			if ( HEALTH_WAIT <= 0.0 )
			{
				if ( HEALTH < Math.clamp( 0.0, 200.0, MAX_REGEN ) )
				{
					pPlayer.pev.health = HEALTH + 1.0;
					rhealthwait[ iPlayerIndex ] = 315.0 - ( float( HEALTH_REGEN ) / 1.5 );
				}
			}
			else
			{
				rhealthwait[ iPlayerIndex ]--;
				if ( HEALTH < Math.clamp( 0.0, 200.0, MAX_REGEN ) && RNG_REGEN > 215.0 )
					pPlayer.pev.health = HEALTH + 1.0;
			}
		}
		if ( ARMOR_REGEN > 0 )
		{
			const float MAX_REGEN = ( EXTRA_ARMOR / 2.0 ) + starthealth + AWARENESS + ( !HasHandicap( iPlayerIndex, LACKING_HELP ) ? MEDALS : 0.0 );
			const float RNG_REGEN = Math.RandomFloat( 0.0, 200.0 + ( float( ARMOR_REGEN ) / 2.0 ) + AWARENESS + ( !HasHandicap( iPlayerIndex, LACKING_HELP ) ? MEDALS : 0.0 ) );
			
			if ( ARMOR_WAIT <= 0.0 )
			{
				if ( ARMOR < Math.clamp( 0.0, 200.0, MAX_REGEN ) )
				{
					pPlayer.pev.armorvalue = ARMOR + 1.0;
					rarmorwait[ iPlayerIndex ] = 330.0 - ( float( ARMOR_REGEN ) / 1.5 );
				}
			}
			else
			{
				rarmorwait[ iPlayerIndex ]--;
				if ( ARMOR < Math.clamp( 0.0, 200.0, MAX_REGEN ) && RNG_REGEN > 230.0 )
					pPlayer.pev.armorvalue = ARMOR + 1.0;
			}
		}
		if ( AMMO_REGEN > 0 )
		{
			if ( AMMO_WAIT <= 0.0 )
			{
				CBasePlayerWeapon@ pWeapon = cast< CBasePlayerWeapon@ >( pPlayer.m_hActiveItem.GetEntity() );
				if ( pWeapon !is null )
				{
					// weapon ammo + random ammo
					scxpm_weaponammo( pPlayer, pWeapon );
					scxpm_randomammo( pPlayer );
					
					// repeat if Portable Dispencer is on
					if ( DISPENCER )
					{
						scxpm_weaponammo( pPlayer, pWeapon );
						scxpm_randomammo( pPlayer );
					}
					
					g_SoundSystem.EmitSoundDyn( pPlayer.edict(), CHAN_ITEM, SND_SKILL_RAMMO, VOL_NORM, ATTN_NONE, SND_SKIP_ORIGIN_USE_ENT, PITCH_NORM, pPlayer.entindex() );
				}
				else
				{
					if ( DISPENCER )
					{
						scxpm_randomammo( pPlayer );
						g_SoundSystem.EmitSoundDyn( pPlayer.edict(), CHAN_ITEM, SND_SKILL_RAMMO, VOL_NORM, ATTN_NONE, SND_SKIP_ORIGIN_USE_ENT, PITCH_NORM, pPlayer.entindex() );
					}
				}
				
				if ( ARNADE_REGEN > 0 && pPlayer.HasNamedPlayerItem( "weapon_m16" ) !is null )
				{
					const int LUCK = Math.RandomLong( 0, 25 + ARNADE_REGEN );
					if ( LUCK >= 23 )
					{
						pPlayer.GiveAmmo( 2, "ARgrenades", pPlayer.GetMaxAmmo( "ARgrenades" ) );
						g_SoundSystem.EmitSoundDyn( pPlayer.edict(), CHAN_WEAPON, SND_SKILL_DEMO, VOL_NORM, ATTN_NONE, SND_SKIP_ORIGIN_USE_ENT, PITCH_NORM, iPlayerIndex );
					}
				}
				
				const float SPEED_MOD = float( speed[ iPlayerIndex ] ) / 27.0;		// Awareness
				rammowait[ iPlayerIndex ] = 190.0 - ( 4.0 * float( AMMO_REGEN ) ) - SPEED_MOD;
			}
			else
				rammowait[ iPlayerIndex ]--;
		}
		
		// Medkit self-heal
		CBasePlayerWeapon@ pWeapon = cast< CBasePlayerWeapon@ >( pPlayer.m_hActiveItem.GetEntity() );
		if ( pWeapon !is null && pWeapon.m_iId == WEAPON_MEDKIT )
		{
			if ( HEALTH < 200.0 )
			{
				if ( HEALTH < starthealth )
				{
					const float RNG_REGEN = Math.RandomFloat( ( float( HEALTH_REGEN ) / 2.0 ), 800.0 - HEALTH );
					
					if ( RNG_REGEN > 299.0 )
						pPlayer.pev.health = HEALTH + 1.0;
				}
				else
				{
					const float MAX_REGEN = ( float( HEALTH_REGEN ) / 2.0 ) + starthealth + AWARENESS + ( !HasHandicap( iPlayerIndex, LACKING_HELP ) ? MEDALS : 0.0 );
					const float RNG_REGEN = Math.RandomFloat( 0.0, 1300.0 + ( float( HEALTH_REGEN ) / 2.0 ) );
					
					if ( HEALTH < MAX_REGEN && RNG_REGEN > 1200.0 )
						pPlayer.pev.health = HEALTH + 1.0;
				}
			}
		}
		
		if ( MEDKIT_REGEN > 0 && pPlayer.GetMaxAmmo( "health" ) > 0 )
		{
			if ( MEDKIT_WAIT <= 0.0 )
			{
				const int AMMO_MEDKIT = g_PlayerFuncs.GetAmmoIndex( "health" );
				
				pPlayer.m_rgAmmo( AMMO_MEDKIT, pPlayer.m_rgAmmo( AMMO_MEDKIT ) + 5 );
				pPlayer.RemoveExcessAmmo( AMMO_MEDKIT );
				
				rmedkitwait[ iPlayerIndex ] = 9.0 - float( MEDKIT_REGEN );
			}
			else
				rmedkitwait[ iPlayerIndex ]--;
		}
		
		if ( TEAM_POWER > 0 )
		{
			for ( int otherIndex = 1; otherIndex <= g_Engine.maxClients; otherIndex++ )
			{
				if ( iPlayerIndex == otherIndex )
					continue;
				
				CBasePlayer@ pOther = g_PlayerFuncs.FindPlayerByIndex( otherIndex );
				if ( pOther is null || !pOther.IsConnected() )
					continue;
				
				if ( !pPlayer.IsAlive() || !pOther.IsAlive() )
					continue;
				
				const float DISTANCE = ( pPlayer.pev.origin - pOther.pev.origin ).Length();
				
				if ( DISTANCE <= 512.0 )
				{
					const float NUMBER = float( g_PlayerFuncs.GetNumPlayers() ) * 50.0;
					const float otherPOWER = float( dist[ otherIndex ] );
					
					const float otherHEALTH = pOther.pev.health;
					const float otherARMOR = pOther.pev.armorvalue;
					
					float LUCK = Math.RandomFloat( 1651.0 - NUMBER, 4200.0 + float( TEAM_POWER ) + otherPOWER + AWARENESS );
					
					if ( LUCK > 4200.0 && otherHEALTH < 200.0 )
					{
						pOther.pev.health = otherHEALTH + 1.0;
						if ( otherHEALTH > starthealth + 100.0 + float( TEAM_POWER ) + AWARENESS + ( !HasHandicap( iPlayerIndex, LACKING_HELP ) ? MEDALS : 0.0 ) )
							pOther.pev.health = starthealth + 100.0 + float( TEAM_POWER ) + AWARENESS + ( !HasHandicap( iPlayerIndex, LACKING_HELP ) ? MEDALS : 0.0 );
					}
					
					// re-roll
					LUCK = Math.RandomFloat( 1651.0 - NUMBER, 4200.0 + float( TEAM_POWER ) + otherPOWER + AWARENESS );
					
					if ( LUCK > 4200.0 && otherARMOR < 200.0 )
					{
						pOther.pev.armorvalue = otherARMOR + 1.0;
						if ( otherARMOR > startarmor + 100.0 + float( TEAM_POWER ) + AWARENESS + ( !HasHandicap( iPlayerIndex, LACKING_HELP ) ? MEDALS : 0.0 ) )
							pOther.pev.armorvalue = startarmor + 100.0 + float( TEAM_POWER ) + AWARENESS + ( !HasHandicap( iPlayerIndex, LACKING_HELP ) ? MEDALS : 0.0 );
					}
				}
			}
		}
		
		// Block Attack has been moved to Player::TakeDamage hook
	}
}

void scxpm_updatehc()
{
	for ( int iPlayerIndex = 1; iPlayerIndex <= g_Engine.maxClients; iPlayerIndex++ )
	{
		CBasePlayer@ pPlayer = g_PlayerFuncs.FindPlayerByIndex( iPlayerIndex );
		if ( pPlayer is null || !pPlayer.IsConnected() )
			continue;
		
		if ( !pPlayer.IsAlive() )
			continue;
		
		if ( HasHandicap( iPlayerIndex, MEDICAL_PHOBIA ) ) pPlayer.pev.max_health = pPlayer.pev.health;
		if ( HasHandicap( iPlayerIndex, OBSOLETE_TECHNOLOGY ) ) pPlayer.pev.armortype = pPlayer.pev.armorvalue;
		
		if ( HasHandicap( iPlayerIndex, LIMITED_EQUIPMENT ) )
		{
			// pPlayer->m_rgpPlayerItems() is unreliable.
			// create a temporary `player_weaponstrip` entity instead
			CBasePlayerWeapon@ pWeapon = cast< CBasePlayerWeapon@ >( pPlayer.m_hActiveItem.GetEntity() );
			if ( pWeapon !is null )
			{
				// you are not a real weapon.
				const bool ALL = pWeapon.pev.classname == "v_action";
				
				CBaseEntity@ pStrip = g_EntityFuncs.Create( "player_weaponstrip", g_vecZero, g_vecZero, false );
				if ( !ALL )
				{
					pStrip.KeyValue( "weapons_list", pWeapon.pev.classname );
					pStrip.KeyValue( "weapons_list_mode", "1" );
				}
				pStrip.Use( pPlayer, pPlayer, USE_TOGGLE );
				g_EntityFuncs.Remove( pStrip );
			}
		}
		
		if ( HasHandicap( iPlayerIndex, DIRTY_MAG ) )
		{
			CBasePlayerWeapon@ pWeapon = cast< CBasePlayerWeapon@ >( pPlayer.m_hActiveItem.GetEntity() );
			if ( pWeapon !is null )
			{
				if ( pWeapon.m_fInReload )
				{
					if ( _DIRTY_WEAPONS.find( pWeapon.pev.classname ) >= 0 )
					{
						// ugly hack to fix two-step reloads (such as weapon_akimbouzi)
						if ( pWeapon.pev.vuser1.x == 0 )
						{
							pWeapon.m_iClip = 0;
							pWeapon.m_iClip2 = 0;
							pWeapon.pev.vuser1.x = 1;
						}
					}
					else
					{
						if ( pWeapon.m_iClip != -1 )
							pWeapon.m_iClip = 0;
					}
				}
				else
					pWeapon.pev.vuser1.x = 0;
			}
		}
		
		if ( HasHandicap( iPlayerIndex, LOST_BULLETS ) )
		{
			CBasePlayerWeapon@ pWeapon = cast< CBasePlayerWeapon@ >( pPlayer.m_hActiveItem.GetEntity() );
			if ( pWeapon !is null )
			{
				const int CURRENT_AMMO = pPlayer.m_rgAmmo( pWeapon.PrimaryAmmoIndex() );
				const int MAX_AMMO = pWeapon.iMaxClip();
				
				// Don't touch weapons that rely only on bpammo
				if ( MAX_AMMO > 0 && CURRENT_AMMO > MAX_AMMO )
					pPlayer.m_rgAmmo( pWeapon.PrimaryAmmoIndex(), MAX_AMMO );
				
			}
		}
		
		if ( HasHandicap( iPlayerIndex, BLEEDING_VIEW ) )
		{
			// Check health, concuss should be null when healthy, and worsen the lower the HP
			float flHealth = pPlayer.pev.health;
			if ( flHealth > 80.0 )
				g_PlayerFuncs.ConcussionEffect( pPlayer, 0.0, 0.0, 2.5 ); // All zero to remove
			else if ( flHealth > 60.0 )
				g_PlayerFuncs.ConcussionEffect( pPlayer, 10.0, 0.6, 2.5 );
			else if ( flHealth > 40.0 ) 
				g_PlayerFuncs.ConcussionEffect( pPlayer, 20.0, 0.7, 2.5 );
			else if ( flHealth > 20.0 )
				g_PlayerFuncs.ConcussionEffect( pPlayer, 30.0, 0.8, 2.5 );
			else
				g_PlayerFuncs.ConcussionEffect( pPlayer, 40.0, 0.9, 2.5 );
		}
	}
}

void scxpm_reexp()
{
	for ( int iPlayerIndex = 1; iPlayerIndex <= g_Engine.maxClients; iPlayerIndex++ )
	{
		CBasePlayer@ pPlayer = g_PlayerFuncs.FindPlayerByIndex( iPlayerIndex );
		if ( pPlayer is null || !pPlayer.IsConnected() )
			continue;
		
		// Gather any external XP
		AddExternal( iPlayerIndex );
		
		double exp = scxpm_calc_xpgain( iPlayerIndex );
		if ( exp > 0.0 )
		{
			if ( !IsBitSet( gameSettings, DELAYED_XP ) )
			{
				if ( playerlevel[ iPlayerIndex ] != 24760 )
				{
					double var = double( xp[ iPlayerIndex ] ) / 5.0 / exp + double( pPlayer.pev.frags ) - double( lastfrags[ iPlayerIndex ] );
					xp[ iPlayerIndex ] = round( var * 5.0 * exp );
				}
			}
			
			double earnvar = double( earnedxp[ iPlayerIndex ] ) / 5.0 / exp + double( pPlayer.pev.frags ) - double( lastfrags[ iPlayerIndex ] );
			earnedxp[ iPlayerIndex ] = round( earnvar * 5.0 * exp );
		}
		
		SaveData( iPlayerIndex );
		
		lastfrags[ iPlayerIndex ] = pPlayer.pev.frags;
		
		if ( xp[ iPlayerIndex ] >= neededxp[ iPlayerIndex ] )
		{
			const string NAME = pPlayer.pev.netname;
			const string STEAMID = g_EngineFuncs.GetPlayerAuthId( pPlayer.edict() );
			
			playerlevel[ iPlayerIndex ] = scxpm_calc_lvl( xp[ iPlayerIndex ] );
			scxpm_calc_skillpoints( iPlayerIndex );
			
			scxpm_calcneedxp( iPlayerIndex );
			
			g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "[SCXPM] Good job, " + NAME + "! You reached Level " + AddCommas( playerlevel[ iPlayerIndex ] ) + "!\n" );
			g_Game.AlertMessage( at_logged, "[SCXPM] " + NAME + " (" + STEAMID + ") reached level " + AddCommas( playerlevel[ iPlayerIndex ] ) + ".\n" );
			SCXPM_Log( NAME + " (" + STEAMID + ") reached level " + AddCommas( playerlevel[ iPlayerIndex ] ) + ".\n" );
			
			if ( !IsBitSet( gameSettings, SIMULATED_LEVEL ) )
			{
				if ( playerlevel[ iPlayerIndex ] >= 700 && medals[ iPlayerIndex ] >= 30 && !HasPermaIncrease( iPlayerIndex, "Champion" ) )
				{
					g_SoundSystem.EmitSoundDyn( pPlayer.edict(), CHAN_STREAM, SND_CHAMPION, VOL_NORM, ATTN_NONE, SND_SKIP_ORIGIN_USE_ENT, PITCH_NORM, iPlayerIndex );
					
					g_Game.AlertMessage( at_logged, "[SCXPM] " + NAME + " (" + STEAMID + ") was crowned Champion.\n" );
					SCXPM_Log( NAME + " (" + STEAMID + ") was crowned Champion.\n" );
					
					g_PlayerFuncs.ClientPrintAll( HUD_PRINTTALK, "[SCXPM] WE HAVE A NEW CHAMPION! Hail " + NAME + ", new welder of the crown!!\n" );
					
					AddPermaIncrease( iPlayerIndex, 0, "Champion", "This player managed to stand above all obstacles,\ntriumphing each small step towards completion.\n\nA determined player among the ranks of the Elite,\nwith no barrier stopping its ever expanding goals.\n\nTHE player, a Champion of our world.\n\nAward for 100% completion." );
					
					g_Scheduler.SetTimeout( "SCXPMChampionWelcome", 0.02, @pPlayer );
				}
				else if ( playerlevel[ iPlayerIndex ] >= 24760 && !HasPermaIncrease( iPlayerIndex, "Integer Overflow" ) )
					AddPermaIncrease( iPlayerIndex, 0, "Integer Overflow", "When something is infinite, it is tempting to\njust keep going, without any care at all.\n\nBut our world is still bent upon laws, and\ninfinite is subjetive. There is always a limit.\n\nBut this player broke what is objetive, and\nreached the inaccesible cardinal.\n\nAward for reaching maximum level." );
				else if ( playerlevel[ iPlayerIndex ] >= 3000 && !HasPermaIncrease( iPlayerIndex, "XP Devourer" ) )
					AddPermaIncrease( iPlayerIndex, 0, "XP Devourer", "To become a superior being, to devour all stars.\nTruly, a disciple of Marie Poppo.\n\nAn unwavering search, complete.\n\nAward for reaching level 3,000." );
				else if ( playerlevel[ iPlayerIndex ] >= 1800 && !HasPermaIncrease( iPlayerIndex, "Spark of Life" ) )
					AddPermaIncrease( iPlayerIndex, 24, "Spark of Life", "An ancient artifact used by\nheroes of forgotten times.\n\nAward for reaching level 1,800." );
				else if ( playerlevel[ iPlayerIndex ] >= 750 && !HasPermaIncrease( iPlayerIndex, "Determination V" ) )
					AddPermaIncrease( iPlayerIndex, 10, "Determination V", "Award for reaching level 750." );
				else if ( playerlevel[ iPlayerIndex ] >= 600 && !HasPermaIncrease( iPlayerIndex, "Determination IV" ) )
					AddPermaIncrease( iPlayerIndex, 8, "Determination IV", "Award for reaching level 600." );
				else if ( playerlevel[ iPlayerIndex ] >= 450 && !HasPermaIncrease( iPlayerIndex, "Determination III" ) )
					AddPermaIncrease( iPlayerIndex, 6, "Determination III", "Award for reaching level 450." );
				else if ( playerlevel[ iPlayerIndex ] >= 300 && !HasPermaIncrease( iPlayerIndex, "Determination II" ) )
					AddPermaIncrease( iPlayerIndex, 4, "Determination II", "Award for reaching level 300." );
				else if ( playerlevel[ iPlayerIndex ] >= 150 && !HasPermaIncrease( iPlayerIndex, "Determination I" ) )
					AddPermaIncrease( iPlayerIndex, 2, "Determination I", "Award for reaching level 150." );
			}
			
			g_SoundSystem.EmitSoundDyn( pPlayer.edict(), CHAN_STATIC, SND_LEVEL_UP, VOL_NORM, ATTN_NONE, SND_SKIP_ORIGIN_USE_ENT, PITCH_NORM, iPlayerIndex );
			
			// Do not open the menu if the player does not want to (or no points given)
			if ( skillpoints[ iPlayerIndex ] >= 1 && !IsBitSet( playerBits[ iPlayerIndex ], MENU_NOAUTOOPEN ) )
				SCXPMSkill( pPlayer );
		}
	}
}

void scxpm_multiplier_timer()
{
	// Do not consume a player's amplifier if no XP can be earned here
	if ( MAP_XPGAIN <= 0.0 )
		return;
	
	for ( int iPlayerIndex = 1; iPlayerIndex <= g_Engine.maxClients; iPlayerIndex++ )
	{
		CBasePlayer@ pPlayer = g_PlayerFuncs.FindPlayerByIndex( iPlayerIndex );
		if ( pPlayer is null || !pPlayer.IsConnected() )
			continue;
		
		xpMultiplierTime[ iPlayerIndex ]--;
		
		if ( xpMultiplierTime[ iPlayerIndex ] <= 0 )
		{
			xpMultiplier[ iPlayerIndex ] = 1;
			xpMultiplierTime[ iPlayerIndex ] = 0;
		}
	}
}

void scxpm_spectate_fix()
{
	for ( int iPlayerIndex = 1; iPlayerIndex <= g_Engine.maxClients; iPlayerIndex++ )
	{
		CBasePlayer@ pPlayer = g_PlayerFuncs.FindPlayerByIndex( iPlayerIndex );
		if ( pPlayer is null || !pPlayer.IsConnected() )
			continue;
			
		if ( spectator[ iPlayerIndex ] )
		{
			pPlayer.m_flRespawnDelayTime = Math.FLOAT_MAX;
			pPlayer.pev.nextthink = g_Engine.time + 1.0;
		}
	}
}

void scxpm_event_think()
{
	if ( IsBitSet( gameSettings, DISABLED ) || IsBitSet( gameSettings, NO_EVENT ) )
		return;
	
	uDateTime currentTime( UnixTimestamp() );
	const int hours = currentTime.GetHour();
	
	if ( hours >= 22 || hours >= 0 && hours < 4 ) // 22hs to 04hs (10 PM to 4 AM)
	{
		if ( !event_active )
		{
			if ( MAP_XPGAIN > 0.0 )
				MAP_XPGAIN = MAP_XPGAIN * HH_EXTRAPERCENT;
		}
		event_active = true;
		
		g_PlayerFuncs.ClientPrintAll( HUD_PRINTTALK, "[SCXPM] Happy Hours! Enjoy your stay with greater XP gain!\n" );
	}
	else if ( hours >= 8 && hours < 12 ) // 08hs to 12hs (8 AM to 12 PM)
	{
		if ( !event_active )
		{
			if ( MAP_XPGAIN > 0.0 )
				MAP_XPGAIN = MAP_XPGAIN * RT_EXTRAPERCENT;
		}
		event_active = true;
		
		g_PlayerFuncs.ClientPrintAll( HUD_PRINTTALK, "[SCXPM] Hello, \"Runaway\". You gain more XP while you avoid school time. Good luck!\n" );
	}
	else if ( hours >= 16 && hours < 20 ) // 16hs to 20hs (4 PM to 8 PM)
	{
		event_active = true;
		engage_mode = true;
		
		g_PlayerFuncs.ClientPrintAll( HUD_PRINTTALK, "[SCXPM] ENGAGE MODE! All achievements will now have their rewards doubled!\n" );
	}
}

void scxpm_weaponammo( CBasePlayer@ pPlayer, CBasePlayerWeapon@ pWeapon )
{
	/* determine if the weapon should renegerate ammo.
	** calculate how much, and which type of ammo to give. */
	
	// Weapon does not use ammo, stop.
	if ( pWeapon.PrimaryAmmoIndex() == -1 )
		return;
	
	const int CURRENT_AMMO = pPlayer.m_rgAmmo( pWeapon.PrimaryAmmoIndex() );
	const int MAX_AMMO = pPlayer.GetMaxAmmo( pWeapon.PrimaryAmmoIndex() );
	
	int CLIP_SIZE = pWeapon.iMaxClip();
	const string AMMO_NAME = pWeapon.pszAmmo1();
	
	if ( _REGEN_WEAPONS.find( pWeapon.pev.classname ) == -1 )
		return;
	
	// For weapons that rely purely on bpammo instead of clips
	if ( CLIP_SIZE == -1 )
		CLIP_SIZE = pWeapon.m_iDefaultAmmo;
	
	/* OVERRIDES */
	if ( pWeapon.m_iId == WEAPON_UZI && pPlayer.get_m_szAnimExtension() == "uzis" )
		CLIP_SIZE *= 2; // Akimbo Uzi
	else if ( pWeapon.m_iId == WEAPON_SPORELAUNCHER )
		CLIP_SIZE /= 2; // Spore Launcher
	else if ( pWeapon.m_iId == WEAPON_DISPLACER )
		CLIP_SIZE = 20; // Displacer
	
	if ( CURRENT_AMMO < MAX_AMMO )
		pPlayer.GiveAmmo( CLIP_SIZE, AMMO_NAME, MAX_AMMO );
}

void scxpm_randomammo( CBasePlayer@ pPlayer )
{
	int number = Math.RandomLong( 0, 8 );
	switch ( number )
	{
		// Default ammo
		case 0: { if ( pPlayer.GiveAmmo( 26, "9mm", pPlayer.GetMaxAmmo( "9mm" ) ) != -1 ) break; }
		case 1: { if ( pPlayer.GiveAmmo( 6, "357", pPlayer.GetMaxAmmo( "357" ) ) != -1 ) break; }
		case 2: { if ( pPlayer.GiveAmmo( 5, "bolts", pPlayer.GetMaxAmmo( "bolts" ) ) != -1 ) break; }
		case 3: { if ( pPlayer.GiveAmmo( 12, "buckshot", pPlayer.GetMaxAmmo( "buckshot" ) ) != -1 ) break; }
		case 4: { if ( pPlayer.GiveAmmo( 2, "rockets", pPlayer.GetMaxAmmo( "rockets" ) ) != -1 ) break; }
		case 5: { if ( pPlayer.GiveAmmo( 20, "uranium", pPlayer.GetMaxAmmo( "uranium" ) ) != -1 ) break; }
		case 6: { if ( pPlayer.GiveAmmo( 5, "m40a1", pPlayer.GetMaxAmmo( "m40a1" ) ) != -1 ) break; }
		case 7: { if ( pPlayer.GiveAmmo( 65, "556", pPlayer.GetMaxAmmo( "556" ) ) != -1 ) break; }
		case 8: { if ( pPlayer.GiveAmmo( 2, "sporeclip", pPlayer.GetMaxAmmo( "sporeclip" ) ) != -1 ) break; }
	}
}

void scxpm_spawndmg( const int iPlayerIndex )
{
	CBasePlayer@ pPlayer = g_PlayerFuncs.FindPlayerByIndex( iPlayerIndex );
	if ( pPlayer is null || !pPlayer.IsConnected() )
		return;
	
	if ( IsBitSet( gameSettings, NO_SKILLS ) )
		return;
	
	// Starting Attack
	const int ATTACK = spawndmg[ iPlayerIndex ];
	if ( ATTACK == 0 || HasHandicap( iPlayerIndex, LACKING_HELP ) )
		return;
	
	CBaseEntity@ pMonster = null;
	while( ( @pMonster = g_EntityFuncs.FindEntityInSphere( pMonster, pPlayer.pev.origin, 360.0, "*", "classname" ) ) !is null )
	{
		if ( !pMonster.IsMonster() )
			continue;
		
		// These aren't real monsters...
		string name = pMonster.pev.classname;
		if ( !name.StartsWith( "monster_" ) || name == "monster_generic" || name == "monster_furniture" )
			continue;
		
		// IsPlayerAlly() will cause false positives if monsters are spawned in.... bizzare ways.
		// Scan by IRelationship instead
		if ( !pMonster.IsAlive() || pPlayer.IRelationship( pMonster ) <= R_NO )
			continue;
		
		pMonster.TakeDamage( pPlayer.pev, pPlayer.pev, 20.0 * float( ATTACK ), DMG_ENERGYBEAM );
		
		Vector mOrigin = pMonster.pev.origin;
		NetworkMessage effect( MSG_BROADCAST, NetworkMessages::SVC_TEMPENTITY );
		effect.WriteByte( TE_IMPLOSION );
		effect.WriteCoord( mOrigin.x );
		effect.WriteCoord( mOrigin.y );
		effect.WriteCoord( mOrigin.z + 8.0 );
		effect.WriteByte( 47 + ATTACK ); // Radius
		effect.WriteByte( ATTACK * 10 ); // Count
		effect.WriteByte( 4 ); // Life
		effect.End();
	}
}

void gravityon( const int iPlayerIndex )
{
	CBasePlayer@ pPlayer = g_PlayerFuncs.FindPlayerByIndex( iPlayerIndex );
	if ( pPlayer is null || !pPlayer.IsConnected() )
		return;
	
	if ( !pPlayer.IsAlive() )
		return;
	
	const float BASE = !HasHandicap( iPlayerIndex, DEAD_WEIGHT ) ? 1.00 : 1.25;
	const float GRAVITY = float( gravity[ iPlayerIndex ] );
	
	float MEDALS = Math.clamp( 0.0, 30.0, float( medals[ iPlayerIndex ] ) );
	if ( HasHandicap( iPlayerIndex, LACKING_HELP ) )
		MEDALS = 0.0;
	
	pPlayer.pev.gravity = BASE - ( 0.012 * GRAVITY ) - ( 0.001 * MEDALS );
}

void gravityoff( const int iPlayerIndex )
{
	CBasePlayer@ pPlayer = g_PlayerFuncs.FindPlayerByIndex( iPlayerIndex );
	if ( pPlayer is null || !pPlayer.IsConnected() )
		return;
	
	if ( !pPlayer.IsAlive() )
		return;
	
	const float BASE = !HasHandicap( iPlayerIndex, DEAD_WEIGHT ) ? 1.00 : 1.25;
	
	pPlayer.pev.gravity = BASE;
}

void GetDailyReward( const int iPlayerIndex, int iDays, bool bYield, string& out szCurrent, string& out szNext )
{
	// Check range, priority
	uDateTime dtCurrentTime( UnixTimestamp() );
	int iCheck = CheckDaily( iPlayerIndex, dtCurrentTime, nextdaily[ iPlayerIndex ] );
	if ( iCheck == -1 )
	{
		iDays = 0;
		dailyget[ iPlayerIndex ] = 0;
		
		// Set next daily
		dtCurrentTime += ( 20 * 60 * 60 ); // ALMOST 1 day
		nextdaily[ iPlayerIndex ] = dtCurrentTime;
	}
	
	int iReward, iNext;
	
	// Current reward
	if ( iDays > 364 ) iReward = 9999;
	else if ( iDays > 120 ) iReward = 6500;
	else if ( iDays > 118 ) iReward = 6000;
	else if ( iDays > 111 ) iReward = 5550;
	else if ( iDays > 104 ) iReward = 5200;
	else if ( iDays > 97 ) iReward = 4850;
	else if ( iDays > 90 ) iReward = 4500;
	else if ( iDays > 88 ) iReward = 4400;
	else if ( iDays > 81 ) iReward = 4050;
	else if ( iDays > 74 ) iReward = 3700;
	else if ( iDays > 67 ) iReward = 3350;
	else if ( iDays > 60 ) iReward = 3000;
	else if ( iDays > 58 ) iReward = 2900;
	else if ( iDays > 51 ) iReward = 2550;
	else if ( iDays > 44 ) iReward = 2200;
	else if ( iDays > 37 ) iReward = 1850;
	else if ( iDays > 30 ) iReward = 1500;
	else iReward = 50 * iDays;
	
	/* XP MODS */
	if ( iDays >= 365 && !HasPermaIncrease( iPlayerIndex, "Eternal" ) )
		szCurrent = "Honorific Mention";
	else if ( iDays >= 120 && !HasPermaIncrease( iPlayerIndex, "Addict" ) || iDays >= 90 && !HasPermaIncrease( iPlayerIndex, "Fanatic" ) || iDays >= 60 && !HasPermaIncrease( iPlayerIndex, "Dedicated" ) || iDays >= 30 && !HasPermaIncrease( iPlayerIndex, "Installed" ) )
		szCurrent = "XP Mod +10%";
	/* GOLDEN HAMMERS */
	else if ( iDays > 0 && iDays % 56 == 0 )
		szCurrent = "Golden Hammer(s) +1";
	/* MEDALS */
	else if ( iDays > 0 && iDays % 42 == 0 )
		szCurrent = "Medals +1";
	/* XP MULTIPLIERS (after 252 days ) */
	else if ( iDays >= 252 && iDays % 28 == 0 )
		szCurrent = "4x Multiplier [60 minutes]";
	/* XP MULTIPLIERS (after 112 days ) */
	else if ( iDays >= 112 && iDays % 28 == 0 )
		szCurrent = "3x Multiplier [120 minutes]";
	/* XP MULTIPLIERS (after 28 days ) */
	else if ( iDays >= 28 && iDays % 28 == 0 )
		szCurrent = "2x Multiplier [180 minutes]";
	/* XP */
	else
		szCurrent = string( iReward ) + " XP";
	
	if ( bYield && iCheck == 1 )
	{
		// Next daily at...
		dtCurrentTime += ( 20 * 60 * 60 ); // ALMOST 1 day
		nextdaily[ iPlayerIndex ] = dtCurrentTime;
		
		// Yield current reward
		if ( iDays >= 365 && !HasPermaIncrease( iPlayerIndex, "Eternal" ) )
			AddPermaIncrease( iPlayerIndex, 0, "Eternal", "The existance of this player has become tied\nto this world. Ever expanding, until infinity.\n\nAward for reaching 365 daily rewards." );
		else if ( iDays >= 120 && !HasPermaIncrease( iPlayerIndex, "Addict" ) )
			AddPermaIncrease( iPlayerIndex, 10, "Addict", "Award for reaching 120 daily rewards." );
		else if ( iDays >= 90 && !HasPermaIncrease( iPlayerIndex, "Fanatic" ) )
			AddPermaIncrease( iPlayerIndex, 10, "Fanatic", "Award for reaching 90 daily rewards." );
		else if ( iDays >= 60 && !HasPermaIncrease( iPlayerIndex, "Dedicated" ) )
			AddPermaIncrease( iPlayerIndex, 10, "Dedicated", "Award for reaching 60 daily rewards." );
		else if ( iDays >= 30 && !HasPermaIncrease( iPlayerIndex, "Installed" ) )
			AddPermaIncrease( iPlayerIndex, 10, "Installed", "Award for reaching 30 daily rewards." );
		else
		{
			if ( iDays > 0 && iDays % 56 == 0 )
				hammers[ iPlayerIndex ]++;
			else if ( iDays > 0 && iDays % 42 == 0 )
			{
				medals[ iPlayerIndex ]++;
				if ( medals[ iPlayerIndex ] > 180 )
					medals[ iPlayerIndex ] = 180;
				scxpm_calc_specialpoints( iPlayerIndex );
				
				if ( medals[ iPlayerIndex ] >= 180 && !HasPermaIncrease( iPlayerIndex, "Infinite Reboot" ) )
					AddPermaIncrease( iPlayerIndex, 0, "Infinite Reboot", "Many would think that repeating every timeline\nover and over it's purposeless, and done only\nby maniacs.\n\nBut for this player, it's a day to day\nhabit of perseverance. A worthy achievement.\n\nAward for reaching 180 medals." );
				else if ( medals[ iPlayerIndex ] >= 42 && !HasPermaIncrease( iPlayerIndex, "The Answer" ) )
					AddPermaIncrease( iPlayerIndex, 36, "The Answer", "Everyone knows what this number is, but it is\nalso a distant memory from forgotten times.\n\nAward for reaching 42 medals." );
			}
			else if ( iDays >= 252 && iDays % 28 == 0 )
			{
				if ( xpMultiplier[ iPlayerIndex ] > 1 )
					CheckConvertAmp( iPlayerIndex, 4, 60 );
				else
				{
					xpMultiplier[ iPlayerIndex ] = 4;
					xpMultiplierTime[ iPlayerIndex ] = 60 + 1;
				}
			}
			else if ( iDays >= 112 && iDays % 28 == 0 )
			{
				if ( xpMultiplier[ iPlayerIndex ] > 1 )
					CheckConvertAmp( iPlayerIndex, 3, 120 );
				else
				{
					xpMultiplier[ iPlayerIndex ] = 3;
					xpMultiplierTime[ iPlayerIndex ] = 120 + 1;
				}
			}
			else if ( iDays >= 28 && iDays % 28 == 0 )
			{
				if ( xpMultiplier[ iPlayerIndex ] > 1 )
					CheckConvertAmp( iPlayerIndex, 2, 180 );
				else
				{
					xpMultiplier[ iPlayerIndex ] = 2;
					xpMultiplierTime[ iPlayerIndex ] = 180 + 1;
				}
			}
			else
			{
				xp[ iPlayerIndex ] += iReward;
				if ( !IsBitSet( gameSettings, DELAYED_XP ) ) earnedxp[ iPlayerIndex ] += iReward; // Prevent double XP exploitation on delayed XP maps
			}
		}
	}
	
	// Next reward
	iDays++;
	
	if ( iDays > 364 ) iNext = 9999;
	else if ( iDays > 120 ) iNext = 6500;
	else if ( iDays > 118 ) iNext = 6000;
	else if ( iDays > 111 ) iNext = 5550;
	else if ( iDays > 104 ) iNext = 5200;
	else if ( iDays > 97 ) iNext = 4850;
	else if ( iDays > 90 ) iNext = 4500;
	else if ( iDays > 88 ) iNext = 4400;
	else if ( iDays > 81 ) iNext = 4050;
	else if ( iDays > 74 ) iNext = 3700;
	else if ( iDays > 67 ) iNext = 3350;
	else if ( iDays > 60 ) iNext = 3000;
	else if ( iDays > 58 ) iNext = 2900;
	else if ( iDays > 51 ) iNext = 2550;
	else if ( iDays > 44 ) iNext = 2200;
	else if ( iDays > 37 ) iNext = 1850;
	else if ( iDays > 30 ) iNext = 1500;
	else iNext = 50 * iDays;
	
	/* XP MODS */
	if ( iDays >= 365 && !HasPermaIncrease( iPlayerIndex, "Eternal" ) )
		szNext = "Honorific Mention";
	else if ( iDays >= 120 && !HasPermaIncrease( iPlayerIndex, "Addict" ) || iDays >= 90 && !HasPermaIncrease( iPlayerIndex, "Fanatic" ) || iDays >= 60 && !HasPermaIncrease( iPlayerIndex, "Dedicated" ) || iDays >= 30 && !HasPermaIncrease( iPlayerIndex, "Installed" ) )
		szNext = "XP Mod +10%";
	/* GOLDEN HAMMERS */
	else if ( iDays > 0 && iDays % 56 == 0 )
		szNext = "Golden Hammer(s) +1";
	/* MEDALS */
	else if ( iDays > 0 && iDays % 42 == 0 )
		szNext = "Medals +1";
	/* XP MULTIPLIERS (after 252 days ) */
	else if ( iDays >= 252 && iDays % 28 == 0 )
		szNext = "4x Multiplier [60 minutes]";
	/* XP MULTIPLIERS (after 112 days ) */
	else if ( iDays >= 112 && iDays % 28 == 0 )
		szNext = "3x Multiplier [120 minutes]";
	/* XP MULTIPLIERS (after 28 days ) */
	else if ( iDays >= 28 && iDays % 28 == 0 )
		szNext = "2x Multiplier [180 minutes]";
	/* XP */
	else
		szNext = string( iNext ) + " XP";
}

void UnlockAchievement( CBasePlayer@ pPlayer, const int iAchievementID )
{
	// Achievements cannot be unlocked on this map, or saving is disabled
	if ( IsBitSet( gameSettings, NO_ACHIEVEMENTS ) || IsBitSet( gameSettings, NO_SAVE ) )
		return;
	
	// Only this achievement can be unlocked on this map
	if ( IsBitSet( gameSettings, SINGLE_ACHIEVEMENT ) && gameCfgParam != iAchievementID )
		return;
	
	const int iPlayerIndex = pPlayer.entindex();
	
	// Already unlocked? Stop.
	if ( playerAchievements[ iPlayerIndex ][ iAchievementID ] != LOCKED )
		return;
		
	// Unlock and give reward
	playerAchievements[ iPlayerIndex ][ iAchievementID ] = UNLOCKED;
	GiveAchievementReward( iPlayerIndex, iAchievementID );
	
	// Check for total unlocked achievements, give special reward if criteria is met
	int iNewUnlocks = GetAchievementClear( iPlayerIndex );
	switch( iNewUnlocks )
	{
		case 35: if ( !HasPermaIncrease( iPlayerIndex, "Just Cause" ) ) AddPermaIncrease( iPlayerIndex, 4, "Just Cause", "Award for completing 35 achievements." ); break;
		case 65: if ( !HasPermaIncrease( iPlayerIndex, "Bounty Hunter" ) ) AddPermaIncrease( iPlayerIndex, 7, "Bounty Hunter", "Award for completing 65 achievements." ); break;
		case 100: if ( !HasPermaIncrease( iPlayerIndex, "Maximum Dedication" ) ) AddPermaIncrease( iPlayerIndex, 10, "Maximum Dedication", "Award for completing 100 achievements." ); break;
		case 135: if ( !HasPermaIncrease( iPlayerIndex, "Journalist" ) ) AddPermaIncrease( iPlayerIndex, 14, "Journalist", "Award for completing 135 achievements." ); break;
		case 165: if ( !HasPermaIncrease( iPlayerIndex, "Map Burner" ) ) AddPermaIncrease( iPlayerIndex, 17, "Map Burner", "Award for completing 165 achievements." ); break;
		case 200: if ( !HasPermaIncrease( iPlayerIndex, "Obsessive Completionist" ) ) AddPermaIncrease( iPlayerIndex, 20, "Obsessive Completionist", "Award for completing 200 achievements." ); break;
	}
	
	// Get achievement name
	array< string > A = gameAchievements[ iAchievementID ].Split( '#' );
	A[ tNAME ].ToUppercase();
	
	// Notify achievement unlock to all players
	string NAME = pPlayer.pev.netname;
	string STEAMID = g_EngineFuncs.GetPlayerAuthId( pPlayer.edict() );
	
	g_PlayerFuncs.ClientPrintAll( HUD_PRINTTALK, "[SCXPM] " + NAME + " has earned the achievement " + A[ tNAME ] + ".\n" );
	g_Game.AlertMessage( at_logged, "[SCXPM] " + NAME + " (" + STEAMID + ") has earned the achievement " + A[ tNAME ] + "\n" );
	SCXPM_Log( NAME + " (" + STEAMID + ") has earned the achievement " + A[ tNAME ] + "\n" );
	
	// Put a sound (and a center print) to the player to let it know in case it cannot read the message
	g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTCENTER, "ACHIEVEMENT UNLOCKED!\n\n" + A[ tNAME ] + "\n" );
	g_SoundSystem.EmitSoundDyn( pPlayer.edict(), CHAN_STATIC, SND_ACHIEVEMENT_GET, VOL_NORM, ATTN_NONE, SND_SKIP_ORIGIN_USE_ENT, PITCH_NORM, iPlayerIndex );
}

void GiveAchievementReward( const int iPlayerIndex, const int iAchievementID, bool bHammered = false )
{
	CBasePlayer@ pPlayer = g_PlayerFuncs.FindPlayerByIndex( iPlayerIndex );
	if ( pPlayer is null || !pPlayer.IsConnected() )
		return;
	
	array< string > A = gameAchievements[ iAchievementID ].Split( '#' );
	if ( A[ tREWARD ] == NONE )
		return;
	
	switch ( atoi( A[ tREWARD ] ) )
	{
		case XP:
		{
			int BOUNTY = atoi( A[ tBOUNTY ] );
			if ( bHammered )
				BOUNTY = round( float( BOUNTY ) * Math.RandomFloat( 0.0, 1.0 ), round_floor );
			
			if ( BOUNTY == 0 )
				return;
			
			BOUNTY *= ( engage_mode ? 2 : 1 );
			
			xp[ iPlayerIndex ] += BOUNTY;
			earnedxp[ iPlayerIndex ] += BOUNTY;
			
			g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "[SCXPM] Congratulations! Your reward for clearing the achievement is " + BOUNTY + " XP!\n" );
			break;
		}
		case MEDAL:
		{
			int BOUNTY = atoi( A[ tBOUNTY ] );
			if ( bHammered )
			{
				int RNG = Math.RandomLong( 1, 100 );
				
				if ( RNG <= 25 )
					BOUNTY /= 4;
				else if ( RNG <= 50 )
					BOUNTY /= 2;
			}
			
			if ( BOUNTY == 0 )
				return;
			
			BOUNTY *= ( engage_mode ? 2 : 1 );
			
			medals[ iPlayerIndex ] += BOUNTY;
			scxpm_calc_specialpoints( iPlayerIndex );
			
			g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "[SCXPM] Congratulations! Your reward for clearing the achievement is " + BOUNTY + " Medal(s)!\n" );
			break;
		}
		case MULTIPLIER_2:
		case MULTIPLIER_3:
		case MULTIPLIER_4:
		{
			int realMULTIPLIER = atoi( A[ tREWARD ] ) - 1;
			int BOUNTY = atoi( A[ tBOUNTY ] );
			
			if ( bHammered )
			{
				int RNG = Math.RandomLong( 1, 100 );
				
				if ( RNG <= 25 )
					realMULTIPLIER -= 2;
				else if ( RNG <= 50 )
					realMULTIPLIER -= 1;
				
				BOUNTY = round( float( BOUNTY ) * Math.RandomFloat( 0.0, 1.0 ), round_floor );
			}
			
			if ( realMULTIPLIER <= 1 || BOUNTY == 0 )
				return;
			
			BOUNTY *= ( engage_mode ? 2 : 1 );
			
			// don't claim if the player already has a multiplier
			if ( xpMultiplier[ iPlayerIndex ] > 1 )
			{
				g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "[SCXPM] Cannot redeem this reward. You already have a multiplier.\n" );
				playerAchievements[ iPlayerIndex ][ iAchievementID ] = UNCLAIMED;
				return;
			}
			
			xpMultiplier[ iPlayerIndex ] = realMULTIPLIER;
			xpMultiplierTime[ iPlayerIndex ] = BOUNTY + 1;
			
			g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "[SCXPM] Congratulations! Your reward for clearing the achievement is " + realMULTIPLIER + "x Multiplier [" + BOUNTY + " minutes]!\n" );
			break;
		}
		case MODIFIER:
		{
			const array< string > mDATA = A[ tMODATA ].Split( '\t' );
			
			const string NAME = mDATA[ 0 ];
			const string DESCRIPTION = mDATA[ 1 ];
			if ( NAME.Length() == 0 )
			{
				g_Game.AlertMessage( at_logged, "[SCXPM] ERROR: Attempted to claim nameless XP MODIFIER achievement reward! Achievement is: " + A[ tNAME ] + "!\n" );
				playerAchievements[ iPlayerIndex ][ iAchievementID ] = UNCLAIMED;
				return;
			}
			
			// don't dupe the xp mod
			if ( HasPermaIncrease( iPlayerIndex, NAME ) )
				return;
			
			int BOUNTY = atoi( A[ tBOUNTY ] );
			
			if ( bHammered )
				BOUNTY = round( float( BOUNTY ) * Math.RandomFloat( 0.0, 1.0 ), round_floor );
			
			// never block the bounty of this type
			if ( BOUNTY < 1 ) BOUNTY = 1;
			
			BOUNTY *= ( engage_mode ? 2 : 1 );
			
			AddPermaIncrease( iPlayerIndex, BOUNTY, NAME, DESCRIPTION );
			
			g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "[SCXPM] Congratulations! Your reward for clearing the achievement is +" + BOUNTY + "% XP Mod!\n" );
			break;
		}
		case GOLDEN_HAMMER:
		{
			int BOUNTY = atoi( A[ tBOUNTY ] );
			
			if ( bHammered )
				BOUNTY /= 4; // always
			
			if ( BOUNTY == 0 )
				return;
			
			BOUNTY *= ( engage_mode ? 2 : 1 );
			
			hammers[ iPlayerIndex ] += BOUNTY;
			
			g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "[SCXPM] Congratulations! Your reward for clearing the achievement is +" + BOUNTY + " Golden Hammer(s)!\n" );
			break;
		}
		case OTHER:
		{
			// your custom reward goes here, iAchievementID is available
			break;
		}
	}
}

/** SAVE/LOAD **/
void SaveData( const int iPlayerIndex )
{
	// Saving disabled
	if ( IsBitSet( gameSettings, NO_SAVE ) )
		return;
	
	// Do not write into this vault unless it is absolutely safe to do so!
	if ( !loaddata[ iPlayerIndex ] )
		return;
	
	// Vaults must be initialized!
	if ( !bVaultsReady )
		return;
	
	// Don't care unless the player actually put a bit of effort here
	if ( playerlevel[ iPlayerIndex ] == 0 && medals[ iPlayerIndex ] == 0 )
		return;
	
	CBasePlayer@ pPlayer = g_PlayerFuncs.FindPlayerByIndex( iPlayerIndex );
	string szSteamID = g_EngineFuncs.GetPlayerAuthId( pPlayer.edict() );
	
	// No SteamID retrieved, abort!
	if ( szSteamID.Length() == 0 )
		return;
	
	string stuff;
	
	/* Main data */
	
	// Don't save simulated data
	if ( !IsBitSet( gameSettings, SIMULATED_LEVEL ) )
	{
		// Update data
		stuff = string( xp[ iPlayerIndex ] ) + "#" + medals[ iPlayerIndex ];
		stuff += "#" + health[ iPlayerIndex ] + "#" + armor[ iPlayerIndex ] + "#" + rhealth[ iPlayerIndex ] + "#" + rarmor[ iPlayerIndex ] + "#" + rammo[ iPlayerIndex ] + "#" + gravity[ iPlayerIndex ] + "#" + speed[ iPlayerIndex ] + "#" + dist[ iPlayerIndex ] + "#" + dodge[ iPlayerIndex ];
		stuff += "#" + spawndmg[ iPlayerIndex ] + "#" + ubercharge[ iPlayerIndex ] + "#" + fastheal[ iPlayerIndex ] + "#" + demoman[ iPlayerIndex ] + "#" + practiceshot[ iPlayerIndex ] + "#" + bioelectric[ iPlayerIndex ] + "#" + redcross[ iPlayerIndex ];
		stuff += "#" + xpMultiplier[ iPlayerIndex ] + "#" + xpMultiplierTime[ iPlayerIndex ];
		stuff += "#" + nextdaily[ iPlayerIndex ].GetUnixTimestamp() + "#" + dailyget[ iPlayerIndex ];
		stuff += "#" + ( savedHandicaps[ iPlayerIndex ] >= 0 ? savedHandicaps[ iPlayerIndex ] : playerHandicaps[ iPlayerIndex ] );
		stuff += "#" + hudColor[ iPlayerIndex ].r + "#" + hudColor[ iPlayerIndex ].g + "#" + hudColor[ iPlayerIndex ].b + "#" + hudColor[ iPlayerIndex ].a;
		stuff += "#" + hudPosition[ iPlayerIndex ].x + "#" + hudPosition[ iPlayerIndex ].y;
		stuff += "#" + hudEffect[ iPlayerIndex ];
		stuff += "#" + firstplay[ iPlayerIndex ].GetUnixTimestamp();
		stuff += "#" + hammers[ iPlayerIndex ];
		stuff += "#" + playerBits[ iPlayerIndex ];
		
		g_MainVaultData[ szSteamID ] = stuff;
	}
	
	/* Achievement data */
	// No achievements unlocked? End here
	if ( GetAchievementClear( iPlayerIndex ) == 0 )
		return;
	
	stuff = "";
	for ( uint uiAchievementID = 0; uiAchievementID < gameAchievements.length(); uiAchievementID++ )
	{
		stuff += string( playerAchievements[ iPlayerIndex ][ uiAchievementID ] );
	}
	
	g_AchievementVaultData[ szSteamID ] = stuff;
}

void LoadData( const int iPlayerIndex )
{
	// Prepare to go through the vaults
	CBasePlayer@ pPlayer = g_PlayerFuncs.FindPlayerByIndex( iPlayerIndex );
	string szSteamID = g_EngineFuncs.GetPlayerAuthId( pPlayer.edict() );
	
	// No SteamID retrieved, abort!
	if ( szSteamID.Length() == 0 )
		return;
	
	// Main data
	if ( g_MainVaultData.exists( szSteamID ) )
	{
		// Data exists, retrieve
		string pre_data = string( g_MainVaultData[ szSteamID ] );
		pre_data.Trim();
		array< string > data = pre_data.Split( '#' );
		
		for ( uint uiDataLength = 0; uiDataLength < data.length(); uiDataLength++ )
		{
			data[ uiDataLength ].Trim();
		}
		
		// Always load this first
		playerBits[ iPlayerIndex ] = atoi( data[ 32 ] );
		
		// If Simulation Mode is enabled, only load essential data
		if ( !IsBitSet( gameSettings, SIMULATED_LEVEL ) )
		{
			xp[ iPlayerIndex ] = atoi( data[ 0 ] );
			playerlevel[ iPlayerIndex ] = scxpm_calc_lvl( xp[ iPlayerIndex ] );
			scxpm_calcneedxp( iPlayerIndex );
			medals[ iPlayerIndex ] = atoi( data[ 1 ] );
			
			health[ iPlayerIndex ] = atoi( data[ 2 ] );
			armor[ iPlayerIndex ] = atoi( data[ 3 ] );
			rhealth[ iPlayerIndex ] = atoi( data[ 4 ] );
			rarmor[ iPlayerIndex ] = atoi( data[ 5 ] );
			rammo[ iPlayerIndex ] = atoi( data[ 6 ] );
			gravity[ iPlayerIndex ] = atoi( data[ 7 ] );
			speed[ iPlayerIndex ] = atoi( data[ 8 ] );
			dist[ iPlayerIndex ] = atoi( data[ 9 ] );
			dodge[ iPlayerIndex ] = atoi( data[ 10 ] );
			
			spawndmg[ iPlayerIndex ] = atoi( data[ 11 ] );
			ubercharge[ iPlayerIndex ] = atoi( data[ 12 ] );
			fastheal[ iPlayerIndex ] = atoi( data[ 13 ] );
			demoman[ iPlayerIndex ] = atoi( data[ 14 ] );
			practiceshot[ iPlayerIndex ] = atoi( data[ 15 ] );
			bioelectric[ iPlayerIndex ] = atoi( data[ 16 ] );
			redcross[ iPlayerIndex ] = atoi( data[ 17 ] );
			
			xpMultiplier[ iPlayerIndex ] = atoi( data[ 18 ] );
			xpMultiplierTime[ iPlayerIndex ] = atoi( data[ 19 ] );
			
			nextdaily[ iPlayerIndex ] = atoi( data[ 20 ] );
			dailyget[ iPlayerIndex ] = atoi( data[ 21 ] );
			
			playerHandicaps[ iPlayerIndex ] = atoi( data[ 22 ] );
			
			scxpm_multiplier_timer(); // Force check
			
			int iCheck = CheckDaily( iPlayerIndex, uDateTime( UnixTimestamp() ), nextdaily[ iPlayerIndex ] );
			if ( iCheck == 1 )
				g_Scheduler.SetTimeout( "SCXPMDailyRewards", 30.0, @pPlayer, ( dailyget[ iPlayerIndex ] + 1 ) );
			else if ( iCheck == -1 )
			{
				string dummy;
				GetDailyReward( iPlayerIndex, 0, false, dummy, dummy );
			}
			
			if ( !IsBitSet( playerBits[ iPlayerIndex ], MENU_SAVEHANDICAPS ) )
			{
				// handicaps not saved, just reset it
				playerHandicaps[ iPlayerIndex ] = 0;
			}
			else if ( !AreHandicapsON() )
			{
				// handicaps not allowed by the map, store it somewhere else
				savedHandicaps[ iPlayerIndex ] = playerHandicaps[ iPlayerIndex ];
				playerHandicaps[ iPlayerIndex ] = 0;
			}
		}
		
		hudColor[ iPlayerIndex ].r = atoui( data[ 23 ] );
		hudColor[ iPlayerIndex ].g = atoui( data[ 24 ] );
		hudColor[ iPlayerIndex ].b = atoui( data[ 25 ] );
		hudColor[ iPlayerIndex ].a = atoui( data[ 26 ] );
		
		hudPosition[ iPlayerIndex ].x = atof( data[ 27 ] );
		hudPosition[ iPlayerIndex ].y = atof( data[ 28 ] );
		
		hudEffect[ iPlayerIndex ] = atoi( data[ 29 ] );
		
		firstplay[ iPlayerIndex ] = atoi( data[ 30 ] );
		
		hammers[ iPlayerIndex ] = atoi( data[ 31 ] );
		
		GetAchievementData( iPlayerIndex );
		loaddata[ iPlayerIndex ] = true;
	}
	
	// Load permanent increases last
	GetPermaIncrease( iPlayerIndex );
	
	if ( !loaddata[ iPlayerIndex ] )
	{
		// No data found, assume new player
		LoadEmptySkills( iPlayerIndex );
		loaddata[ iPlayerIndex ] = true;
	}
	
	// Simulate the levels of the player
	if ( IsBitSet( gameSettings, SIMULATED_LEVEL ) )
	{
		xp[ iPlayerIndex ] = scxpm_calc_xp( gameCfgParam );
		playerlevel[ iPlayerIndex ] = gameCfgParam;
		scxpm_calcneedxp( iPlayerIndex );
		
		xpMultiplier[ iPlayerIndex ] = 1;
		
		playerBits[ iPlayerIndex ] &= ~SKILL_DISPENCER;
		playerBits[ iPlayerIndex ] &= ~SKILL_RANGEHEAL;
	}
	
	scxpm_calc_skillpoints( iPlayerIndex );
	scxpm_calc_specialpoints( iPlayerIndex );
}

void GetAchievementData( const int iPlayerIndex, MenuHandler@ M = null )
{
	// Prepare to go through the vaults
	CBasePlayer@ pPlayer = g_PlayerFuncs.FindPlayerByIndex( iPlayerIndex );
	string szSteamID = g_EngineFuncs.GetPlayerAuthId( pPlayer.edict() );
	
	// No SteamID retrieved, abort!
	if ( szSteamID.Length() == 0 )
		return;
	
	// Achievement data
	if ( g_AchievementVaultData.exists( szSteamID ) )
	{
		// Data exists
		string data = string( g_AchievementVaultData[ szSteamID ] );
		data.Trim();
		
		int iMenuID = 0;
		for ( uint uiAchievementID = 0; uiAchievementID < gameAchievements.length(); uiAchievementID++ ) // total achievements might be shorter than data stream
		{
			// Each character index is the ID
			// The numeric value of said character is the achievement status
			playerAchievements[ iPlayerIndex ][ uiAchievementID ] = atoi( data[ uiAchievementID ] );
			
			// If menu is opened, add item
			if ( M !is null )
			{
				array< string > A = gameAchievements[ uiAchievementID ].Split( '#' );
				
				// Legacy or Hidden achievements only appear on menu if unlocked
				if ( ( atoi( A[ tTYPE ] ) == HIDDEN || atoi( A[ tTYPE ] ) == LEGACY ) && playerAchievements[ iPlayerIndex ][ uiAchievementID ] == LOCKED )
					continue;
				
				string COLOR;
				switch ( playerAchievements[ iPlayerIndex ][ uiAchievementID ] )
				{
					case LOCKED: COLOR = "\\d"; break;
					case UNCLAIMED: COLOR = "\\g"; break;
					case HAMMERED: COLOR = "\\o"; break;
					case UNLOCKED:
					{
						if ( atoi( A[ tTYPE ] ) == HIDDEN )
							COLOR = "\\c";
						else if ( atoi( A[ tTYPE ] ) == LEGACY )
							COLOR = "\\r";
						else
							COLOR = "\\y";
						break;
					}
				}
				
				M.menu.AddItem( COLOR + A[ tNAME ] + "\\w\n", any( string( uiAchievementID ) + "#" + string( iMenuID ) ) );
				iMenuID++;
			}
		}
	}
	else
	{
		if ( M !is null )
		{
			// No data exists, initialize menu
			int iMenuID = 0;
			for ( uint uiAchievementID = 0; uiAchievementID < gameAchievements.length(); uiAchievementID++ )
			{
				array< string > A = gameAchievements[ uiAchievementID ].Split( '#' );
				
				// Legacy or Hidden achievements do not appear on menu
				if ( ( atoi( A[ tTYPE ] ) == HIDDEN || atoi( A[ tTYPE ] ) == LEGACY ) )
					continue;
				
				string COLOR = "\\d";
				
				M.menu.AddItem( COLOR + A[ tNAME ] + "\\w\n", any( string( uiAchievementID ) + "#" + string( iMenuID ) ) );
				iMenuID++;
			}
		}
	}
}

void GetPermaIncrease( const int iPlayerIndex, MenuHandler@ M = null, bool bShowDescription = false, const string szNameCheck = "", int& out iEntries = 0, bool bOnlyEntries = false )
{
	CBasePlayer@ pPlayer = g_PlayerFuncs.FindPlayerByIndex( iPlayerIndex );
	string szSteamID = g_EngineFuncs.GetPlayerAuthId( pPlayer.edict() );
	
	// No SteamID retrieved, abort!
	if ( szSteamID.Length() == 0 )
		return;
	
	bool bFound = false;
	
	if ( g_ModifiersVaultData.exists( szSteamID ) )
	{
		// Data exists, means we have at least ONE entry
		int iItem = -1; bFound = true;
		
		string pre_data = string( g_ModifiersVaultData[ szSteamID ] );
		pre_data.Trim();
		array< string > entry = pre_data.Split( '\x17' );
		
		for ( uint uiEntryLength = 0; uiEntryLength < entry.length(); uiEntryLength++ )
		{
			// Item IDs
			iItem++;
			iEntries++;
			
			if ( bOnlyEntries )
			{
				// Just counting entries only, ignore all else
				continue;
			}
			
			array< string > data = entry[ uiEntryLength ].Split( '#' );
			data[ 0 ].Trim(); // XP Increase
			
			if ( M is null ) // No menu handler, get and update XP Increase only
			{
				xpModifiers[ iPlayerIndex ] += atoi( data[ 0 ] );
				continue;
			}
			
			data[ 1 ].Trim(); // Name
			data[ 2 ].Trim(); // Description
			
			// Get the new lines correctly
			data[ 2 ].Replace( "\\n", '\n' );
			
			if ( bShowDescription ) // Show this config description?
			{
				// This is our item
				if ( szNameCheck == data[ 1 ] )
				{
					// Setup text
					string szTitle = data[ 1 ] + "\n\n\n" + data[ 2 ] + "\n"; // name + description
					
					int extraXP = atoi( data[ 0 ] );
					if ( extraXP > 0 ) szTitle += "\\g+" + extraXP + "% XP Gain\\w";
					else if ( extraXP < 0 ) szTitle += "\\r" + extraXP + "% XP Gain\\w";
					else szTitle += "\\cHonorific Mention\\w";
					
					// Build the menu
					M.menu.SetTitle( szTitle + "\n\n" );
					
					// Return button
					M.menu.AddItem( "Return", any( iItem ) );
					
					// End now
					break;
				}
			}
			else // Only show title
				M.menu.AddItem( data[ 1 ], any( data[ 1 ] ) );
		}
	}
	
	if ( !bFound && M !is null ) // No entries found
		M.menu.AddItem( "\d<empty>\w", any( "empty" ) );
}

void AddPermaIncrease( const int iPlayerIndex, const int iPercent, const string szTitle, string szDescription )
{
	CBasePlayer@ pPlayer = g_PlayerFuncs.FindPlayerByIndex( iPlayerIndex );
	string szSteamID = g_EngineFuncs.GetPlayerAuthId( pPlayer.edict() );
	
	// triple-check
	if ( HasPermaIncrease( iPlayerIndex, szTitle ) )
	{
		g_Game.AlertMessage( at_logged, "[SCXPM] WARNING: Attempted to add duplicate XP modifier \"" + szTitle + "\" to player " + pPlayer.pev.netname + ".\n" );
		return;
	}
	
	string stuff;
	szDescription.Replace( '\n', "\\n" );
	
	if ( g_ModifiersVaultData.exists( szSteamID ) )
	{
		stuff = string( g_ModifiersVaultData[ szSteamID ] );
		stuff += "\x17" + iPercent + "#" + szTitle + "#" + szDescription;
	}
	else
		stuff = string( iPercent ) + "#" + szTitle + "#" + szDescription;
	
	g_ModifiersVaultData[ szSteamID ] = stuff;
	
	// Reload perma-increases
	xpModifiers[ iPlayerIndex ] = 0;
	GetPermaIncrease( iPlayerIndex );
}

bool HasPermaIncrease( const int iPlayerIndex, const string szName )
{
	CBasePlayer@ pPlayer = g_PlayerFuncs.FindPlayerByIndex( iPlayerIndex );
	string szSteamID = g_EngineFuncs.GetPlayerAuthId( pPlayer.edict() );
	
	// No SteamID retrieved, abort!
	if ( szSteamID.Length() == 0 )
		return false;
	
	if ( g_ModifiersVaultData.exists( szSteamID ) )
	{
		string pre_data = string( g_ModifiersVaultData[ szSteamID ] );
		pre_data.Trim();
		array< string > entry = pre_data.Split( '\x17' );
		
		for ( uint uiEntryLength = 0; uiEntryLength < entry.length(); uiEntryLength++ )
		{
			array< string > data = entry[ uiEntryLength ].Split( '#' );
			
			data[ 1 ].Trim(); // Name
			
			if ( szName == data[ 1 ] )
				return true;
		}
	}
	
	return false;
}

void InitVaults()
{
	// Main data
	string szDataPath = PATH_MAIN + "main-vault.ini";
	File@ fData = g_FileSystem.OpenFile( szDataPath, OpenFile::READ );
	
	if ( fData !is null && fData.IsOpen() )
	{
		string szLine;
		while ( !fData.EOFReached() )
		{
			fData.ReadLine( szLine );
			if ( szLine.Length() > 0 )
			{
				array< string > data = szLine.Split( '\t' );
				if ( data.length() == 2 )
				{
					string steamid = data[ 0 ];
					string stuff = data[ 1 ];
					
					g_MainVaultData[ steamid ] = stuff;
				}
			}
		}
		
		fData.Close();
	}
	
	// Achievement data
	szDataPath = PATH_ACHIEVEMENT + "achievement-vault.ini";
	@fData = g_FileSystem.OpenFile( szDataPath, OpenFile::READ );
	
	if ( fData !is null && fData.IsOpen() )
	{
		string szLine;
		while ( !fData.EOFReached() )
		{
			fData.ReadLine( szLine );
			if ( szLine.Length() > 0 )
			{
				array< string > data = szLine.Split( '\t' );
				if ( data.length() == 2 )
				{
					string steamid = data[ 0 ];
					string stuff = data[ 1 ];
					
					g_AchievementVaultData[ steamid ] = stuff;
				}
			}
		}
		
		fData.Close();
	}
	
	// XP Modifiers (PermaIncrease) data
	szDataPath = PATH_PERMAINCREASE + "permaincrease-vault.ini";
	@fData = g_FileSystem.OpenFile( szDataPath, OpenFile::READ );
	
	if ( fData !is null && fData.IsOpen() )
	{
		string szLine;
		while ( !fData.EOFReached() )
		{
			fData.ReadLine( szLine );
			if ( szLine.Length() > 0 )
			{
				array< string > data = szLine.Split( '\t' );
				if ( data.length() == 2 )
				{
					string steamid = data[ 0 ];
					string stuff = data[ 1 ];
					
					g_ModifiersVaultData[ steamid ] = stuff;
				}
			}
		}
		
		fData.Close();
	}
	
	// Champion data
	szDataPath = "scripts/plugins/store/scxpm/champions.sys";
	@fData = g_FileSystem.OpenFile( szDataPath, OpenFile::READ );
	
	if ( fData !is null && fData.IsOpen() )
	{
		string szLine;
		while ( !fData.EOFReached() )
		{
			fData.ReadLine( szLine );
			if ( szLine.Length() > 0 )
			{
				array< string > data = szLine.Split( '\t' );
				if ( data.length() == 2 )
				{
					string steamid = data[ 0 ];
					string stuff = data[ 1 ];
					
					g_ChampionVaultData[ steamid ] = stuff;
				}
			}
		}
		
		fData.Close();
	}
	
	bVaultsReady = true;
}

void DumpVaults()
{
	// Vaults must be initialized!
	if ( !bVaultsReady )
		return;
	
	// Main data
	string szDataPath = PATH_MAIN + "main-vault.ini";
	
	File@ fData = g_FileSystem.OpenFile( szDataPath, OpenFile::WRITE );
	if ( fData !is null && fData.IsOpen() )
	{
		array< string > vaultData = g_MainVaultData.getKeys();
		for ( uint uiVaultIndex = 0; uiVaultIndex < vaultData.length(); uiVaultIndex++ )
		{
			fData.Write( "\n" + vaultData[ uiVaultIndex ] + "\t" + string( g_MainVaultData[ vaultData[ uiVaultIndex ] ] ) );
		}
		
		fData.Close();
	}
	else
		g_Game.AlertMessage( at_logged, "[SCXPM] WARNING: Couldn't open file \"" + szDataPath + "\" for writing!\n" );
	
	// Achievement data
	szDataPath = PATH_ACHIEVEMENT + "achievement-vault.ini";
	
	@fData = g_FileSystem.OpenFile( szDataPath, OpenFile::WRITE );
	if ( fData !is null && fData.IsOpen() )
	{
		array< string > vaultData = g_AchievementVaultData.getKeys();
		for ( uint uiVaultIndex = 0; uiVaultIndex < vaultData.length(); uiVaultIndex++ )
		{
			fData.Write( "\n" + vaultData[ uiVaultIndex ] + "\t" + string( g_AchievementVaultData[ vaultData[ uiVaultIndex ] ] ) );
		}
		
		fData.Close();
	}
	else
		g_Game.AlertMessage( at_logged, "[SCXPM] WARNING: Couldn't open file \"" + szDataPath + "\" for writing!\n" );
	
	// XP Modifiers data
	szDataPath = PATH_PERMAINCREASE + "permaincrease-vault.ini";
	
	@fData = g_FileSystem.OpenFile( szDataPath, OpenFile::WRITE );
	if ( fData !is null && fData.IsOpen() )
	{
		array< string > vaultData = g_ModifiersVaultData.getKeys();
		for ( uint uiVaultIndex = 0; uiVaultIndex < vaultData.length(); uiVaultIndex++ )
		{
			fData.Write( "\n" + vaultData[ uiVaultIndex ] + "\t" + string( g_ModifiersVaultData[ vaultData[ uiVaultIndex ] ] ) );
		}
		
		fData.Close();
	}
	else
		g_Game.AlertMessage( at_logged, "[SCXPM] WARNING: Couldn't open file \"" + szDataPath + "\" for writing!\n" );
	
	// Champion data
	szDataPath = "scripts/plugins/store/scxpm/champions.sys";
	
	@fData = g_FileSystem.OpenFile( szDataPath, OpenFile::WRITE );
	if ( fData !is null && fData.IsOpen() )
	{
		array< string > vaultData = g_ChampionVaultData.getKeys();
		for ( uint uiVaultIndex = 0; uiVaultIndex < vaultData.length(); uiVaultIndex++ )
		{
			fData.Write( "\n" + vaultData[ uiVaultIndex ] + "\t" + string( g_ChampionVaultData[ vaultData[ uiVaultIndex ] ] ) );
		}
		
		fData.Close();
	}
	else
		g_Game.AlertMessage( at_logged, "[SCXPM] WARNING: Couldn't open file \"" + szDataPath + "\" for writing!\n" );
}

/** AUXILIARY ENTITIES **/
class CFlyingMedkit : ScriptBaseEntity // Medkit Dart (scxpm_medkit_dart)
{
	void Spawn()
	{
		// Set healing power to player medkit skill CVar
		self.pev.dmg = g_EngineFuncs.CVarGetFloat( "sk_plr_HpMedic" );
		
		// Init
		self.pev.movetype = MOVETYPE_FLY;
		self.pev.solid = SOLID_BBOX;
		
		g_EntityFuncs.SetModel( self, "models/w_medkit.mdl" );
		
		g_EntityFuncs.SetOrigin( self, self.pev.origin );
		g_EntityFuncs.SetSize( self.pev, Vector( -2, -2, -2 ), Vector( 2, 2, 2 ) );
		
		SetTouch( TouchFunction( HitTouch ) );
		SetThink( ThinkFunction( DeleteThink ) );
		self.pev.nextthink = g_Engine.time + 10.0;
		
		// Move forward
		Math.MakeVectors( self.pev.angles );
		self.pev.velocity = g_Engine.v_forward * g_EngineFuncs.CVarGetFloat( "sv_maxvelocity" );
	}
	
	void DeleteThink()
	{
		// We didn't touch anything for a while, delete
		g_EntityFuncs.Remove( self );
	}
	
	void HitTouch( CBaseEntity@ pOther )
	{
		// Effect
		NetworkMessage msg( MSG_PVS, NetworkMessages::SVC_TEMPENTITY, self.pev.origin );
		msg.WriteByte( TE_EXPLOSION );
		msg.WriteCoord( self.pev.origin.x );
		msg.WriteCoord( self.pev.origin.y );
		msg.WriteCoord( self.pev.origin.z );
		msg.WriteShort( g_EngineFuncs.ModelIndex( "sprites/null.spr" ) );
		msg.WriteByte( 10 ); // scale * 10
		msg.WriteByte( 10 ); // framerate
		msg.WriteByte( ( TE_EXPLFLAG_NODLIGHTS | TE_EXPLFLAG_NOSOUND ) );
		msg.End();
		
		CBaseEntity@ pOwner = g_EntityFuncs.Instance( self.pev.owner );
		if ( pOwner is null )
		{
			// Dart with no owner!
			g_EntityFuncs.Remove( self );
			return;
		}
		
		if ( !pOther.IsAlive() || pOther.pev.health >= pOther.pev.max_health || pOther.IRelationship( pOwner ) != R_AL )
		{
			// Not possible to heal
			g_EntityFuncs.Remove( self );
			return;
		}
		
		float flScore = self.pev.dmg;
		if ( ( pOther.pev.health + self.pev.dmg ) > pOther.pev.max_health )
			flScore = pOther.pev.max_health - pOther.pev.health;
		
		pOther.TakeHealth( self.pev.dmg, DMG_MEDKITHEAL );
		g_SoundSystem.EmitSoundDyn( pOther.edict(), CHAN_BODY, "items/smallmedkit1.wav", VOL_NORM, ATTN_NORM, 0, PITCH_NORM );
		
		pOwner.pev.frags += flScore / 10.0;
		
		g_EntityFuncs.Remove( self );
	}
}

class CDelayedXP : ScriptBaseEntity // Delayed XP giver (scxpm_give_xp)
{
	bool KeyValue( const string& in szKey, const string& in szValue )
	{
		return BaseClass.KeyValue( szKey, szValue );
	}
	
	void Spawn()
	{
		// Self delete if we do not have a target or targetname
		if ( string( self.pev.targetname ).Length() < 1 || string( self.pev.target ).Length() < 1 )
			self.pev.flags |= FL_KILLME; // Kill on next frame instead of instantly.
	}
	
	void Use( CBaseEntity@ pActivator, CBaseEntity@ pCaller, USE_TYPE useType, float flValue )
	{
		// Give to...?
		if ( self.pev.target == "!all" )
		{
			// All players
			GiveDelayedXP( 0 );
			
			// Once only?
			if ( self.pev.SpawnFlagBitSet( 1 ) )
				self.pev.flags |= FL_KILLME;
		}
		else if ( self.pev.target == "!activator" )
		{
			// Activator only. But the activator MUST be a player!
			if ( pActivator.IsPlayer() )
			{
				// Okay, give
				GiveDelayedXP( pActivator.entindex() );
				
				// Once only?
				if ( self.pev.SpawnFlagBitSet( 1 ) )
					self.pev.flags |= FL_KILLME;
			}
		}
		else
		{
			// Search by targetname
			CBaseEntity@ ent = null;
			while( ( @ent = g_EntityFuncs.FindEntityByTargetname( ent, self.pev.target ) ) !is null )
			{
				// Players...
				if ( ent.IsPlayer() )
				{
					// Give
					GiveDelayedXP( ent.entindex() );
				}
			}
			
			// Found something?
			if ( ent !is null )
			{
				// At least 1 target was found, once only?
				if ( self.pev.SpawnFlagBitSet( 1 ) )
					self.pev.flags |= FL_KILLME;
			}
		}
	}
}

class CFFToggler : ScriptBaseEntity // Toggle the FF status (scxpm_toggle_ff)
{
	string szTriggerAfterToggle;
	string szTriggerAfterON;
	string szTriggerAfterOFF;
	
	bool KeyValue( const string& in szKey, const string& in szValue )
	{
		if ( szKey == "trigger_after_use" )
		{
			szTriggerAfterToggle = szValue;
			return true;
		}
		else if ( szKey == "trigger_after_on" )
		{
			szTriggerAfterON = szValue;
			return true;
		}
		else if ( szKey == "trigger_after_off" )
		{
			szTriggerAfterOFF = szValue;
			return true;
		}
		else
			return BaseClass.KeyValue( szKey, szValue );
	}
	
	void Spawn()
	{
		// Needs a targetname
		if ( string( self.pev.targetname ).Length() == 0 )
			g_EntityFuncs.Remove( self );
	}
	
	void Use( CBaseEntity@ pActivator, CBaseEntity@ pCaller, USE_TYPE useType, float flValue )
	{
		switch ( useType )
		{
			case USE_TOGGLE: gameSettings ^= ENABLE_FF; break;
			case USE_ON:
			{
				gameSettings |= ENABLE_FF;
				if ( szTriggerAfterON.Length() > 0 )
					g_EntityFuncs.FireTargets( szTriggerAfterON, pActivator, pCaller, USE_TOGGLE, 0.0, 0.0 );
				break;
			}
			case USE_OFF:
			{
				gameSettings &= ~ENABLE_FF;
				if ( szTriggerAfterOFF.Length() > 0 )
					g_EntityFuncs.FireTargets( szTriggerAfterOFF, pActivator, pCaller, USE_TOGGLE, 0.0, 0.0 );
				break;
			}
		}
		
		if ( szTriggerAfterToggle.Length() > 0 )
			g_EntityFuncs.FireTargets( szTriggerAfterToggle, pActivator, pCaller, USE_TOGGLE, 0.0, 0.0 );
		
		// Warn players?
		if ( self.pev.SpawnFlagBitSet( 2 ) )
		{
			if ( IsBitSet( gameSettings, ENABLE_FF ) )
				g_PlayerFuncs.ClientPrintAll( HUD_PRINTTALK, "[SCXPM] Mirror Friendly Fire was enabled by the map. Beware!\n" );
		}
		
		// Once only?
		if ( self.pev.SpawnFlagBitSet( 1 ) )
			g_EntityFuncs.Remove( self );
	}
}

class CSkillToggler : ScriptBaseEntity // Edit allowance of skills (scxpm_change_skills)
{
	string szTriggerAfter;
	int iSkillMode;
	
	bool KeyValue( const string& in szKey, const string& in szValue )
	{
		if ( szKey == "trigger_after_use" )
		{
			szTriggerAfter = szValue;
			return true;
		}
		else if ( szKey == "skill_mode" )
		{
			iSkillMode = atoi( szValue );
			return true;
		}
		else
			return BaseClass.KeyValue( szKey, szValue );
	}
	
	void Spawn()
	{
		// Needs a targetname
		if ( string( self.pev.targetname ).Length() == 0 )
			g_EntityFuncs.Remove( self );
	}
	
	void Use( CBaseEntity@ pActivator, CBaseEntity@ pCaller, USE_TYPE useType, float flValue )
	{
		// What to do?
		switch ( iSkillMode )
		{
			case 3: // No Skills + Allow Handicaps
			{
				gameSettings |= NO_SKILLS;
				gameSettings |= ALLOW_HANDICAPS;
				break;
			}
			case 2: // No Skills
			{
				gameSettings |= NO_SKILLS;
				gameSettings &= ~ALLOW_HANDICAPS;
				break;
			}
			case 1: // No Antigrav
			{
				gameSettings &= ~NO_SKILLS;
				gameSettings |= NO_ANTIGRAV;
				break;
			}
			default: // All skills
			{
				gameSettings &= ~NO_SKILLS;
				gameSettings &= ~NO_ANTIGRAV;
				break;
			}
		}
		
		if ( szTriggerAfter.Length() > 0 )
			g_EntityFuncs.FireTargets( szTriggerAfter, pActivator, pCaller, USE_TOGGLE, 0.0, 0.0 );
		
		// Warn players?
		if ( self.pev.SpawnFlagBitSet( 2 ) )
		{
			if ( IsBitSet( gameSettings, NO_SKILLS ) )
				g_PlayerFuncs.ClientPrintAll( HUD_PRINTTALK, "[SCXPM] The map has disabled all skills.\n" );
			else
				g_PlayerFuncs.ClientPrintAll( HUD_PRINTTALK, "[SCXPM] The map has enabled all skills.\n" );
				
			if ( IsBitSet( gameSettings, NO_ANTIGRAV ) )
				g_PlayerFuncs.ClientPrintAll( HUD_PRINTTALK, "[SCXPM] The \"Anti-Gravity Device\" skill has been disabled by the map.\n" );
		}
		
		// Once only?
		if ( self.pev.SpawnFlagBitSet( 1 ) )
			g_EntityFuncs.Remove( self );
	}
}

class CSparkHandler : ScriptBaseEntity // Spark of Lifes (scxpm_spark_handler)
{
	dictionary m_dSparks;
	
	void Spawn()
	{
		// Limited respawning must be active, otherwise bai.
		if ( !IsBitSet( gameSettings, LIMITED_RESPAWN ) )
			g_EntityFuncs.Remove( self );
	}
	
	void Use( CBaseEntity@ pActivator, CBaseEntity@ pCaller, USE_TYPE useType, float flValue )
	{
		if ( !pActivator.IsPlayer() )
			return;
			
		CBasePlayer@ pPlayer = cast< CBasePlayer@ >( pActivator );
		string szSteamID = g_EngineFuncs.GetPlayerAuthId( pPlayer.edict() );
		
		if ( m_dSparks.exists( szSteamID ) )
		{
			int LIVES = int( m_dSparks[ szSteamID ] );
			
			if ( useType != USE_OFF )
				LIVES--;
			
			if ( LIVES <= 0 )
			{
				if ( LIVES < 0 ) // not a typo
				{
					// Force-kill
					pPlayer.pev.nextthink = g_Engine.time + 0.1;
					pPlayer.pev.deadflag = DEAD_DYING;
					pPlayer.pev.movetype = MOVETYPE_TOSS;
					pPlayer.pev.solid = SOLID_NOT;
					pPlayer.GibMonster();
					pPlayer.pev.effects |= EF_NODRAW;
					
					// Custom death message
					g_PlayerFuncs.ClientPrintAll( HUD_PRINTNOTIFY, string( pPlayer.pev.netname ) + " ran out of Sparks of Life.\n" );
					g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "[SCXPM] You ran out of respawns.\n" );
				}
				
				// Disallow respawn from here on
				pPlayer.KeyValue( "$i_scxpm_norespawn", "1" );
			}
			
			if ( LIVES >= 0 ) g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "[SCXPM] " + LIVES + " respawn(s) remaining...\n" );
			m_dSparks[ szSteamID ] = LIVES;
		}
		else
		{
			// Insert into dictionary
			m_dSparks[ szSteamID ] = gameCfgParam;
			g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "[SCXPM] " + gameCfgParam + " respawn(s) remaining...\n" );
		}
	}
}
void HandleGameOver( EHandle hSpark )
{
	if ( !hSpark.IsValid() )
		return;
	
	CSparkHandler@ pSpark = cast< CSparkHandler@ >( CastToScriptClass( hSpark.GetEntity() ) );
	if ( pSpark is null )
		return;
	
	// Scan if no more players can respawn
	int iSpark = 0;
	array< string > ENTRIES = pSpark.m_dSparks.getKeys();
	for ( uint PLAYER = 0; PLAYER < ENTRIES.length(); PLAYER++ )
	{
		if ( int( pSpark.m_dSparks[ ENTRIES[ PLAYER ] ] ) > 0 )
			iSpark++;
	}
	
	// Scan if all players are dead
	int iAlive = 0;
	for ( int iPlayerIndex = 1; iPlayerIndex <= g_Engine.maxClients; iPlayerIndex++ )
	{
		CBasePlayer@ pOther = g_PlayerFuncs.FindPlayerByIndex( iPlayerIndex );
		if ( pOther is null || !pOther.IsConnected() )
			continue;
		
		if ( pOther.IsAlive() )
			iAlive++;
	}
	
	// No more players can respawn and everyone is dead?
	if ( iSpark == 0 && iAlive == 0 )
	{
		// If a handling entity exists, fire it. Otherwise just end the map.
		CBaseEntity@ pGameOverEnt = g_EntityFuncs.FindEntityByTargetname( null, "game_sparksout" );
		if ( pGameOverEnt !is null )
		{
			// Ensure this entity is fired only once
			if ( pGameOverEnt.pev.vuser1.x == 0 )
			{
				g_PlayerFuncs.ClientPrintAll( HUD_PRINTTALK, "No living players left.\n" );
				g_EntityFuncs.FireTargets( "game_sparksout", pSpark.self, pSpark.self, USE_TOGGLE, 0.0f, 0.0f );
				pGameOverEnt.pev.vuser1.x = 1;
			}
		}
		else
		{
			g_PlayerFuncs.ClientPrintAll( HUD_PRINTTALK, "No living players left. Ending the map in 10 seconds.\n" );
			
			CBaseEntity@ pEnd = g_EntityFuncs.Create( "game_end", g_vecZero, g_vecZero, false );
			pEnd.pev.targetname = "_game_end";
			
			g_EntityFuncs.FireTargets( "_game_end", null, null, USE_TOGGLE, 0.0f, 10.0f );
		}
	}
}

class CChangeXPGain : ScriptBaseEntity // Change current map XP gain (scxpm_change_xpgain)
{
	string szNewXPGain;
	
	bool KeyValue( const string& in szKey, const string& in szValue )
	{
		if ( szKey == "new_xpgain" )
		{
			szNewXPGain = szValue;
			return true;
		}
		else
			return BaseClass.KeyValue( szKey, szValue );
	}
	
	void Spawn()
	{
		// Needs a targetname
		if ( string( self.pev.targetname ).Length() == 0 )
			g_EntityFuncs.Remove( self );
	}
	
	void Use( CBaseEntity@ pActivator, CBaseEntity@ pCaller, USE_TYPE useType, float flValue )
	{
		float flNewXPGain = Math.clamp( 0.0, 10.0, atof( szNewXPGain ) );
		
		MAP_XPGAIN = flNewXPGain;
		
		// Refresh time-based events to include their respective XP increases
		if ( event_active )
		{
			event_active = false;
			scxpm_event_think();
		}
		
		// Once only?
		if ( self.pev.SpawnFlagBitSet( 1 ) )
			g_EntityFuncs.Remove( self );
	}
}

class CHideHUD : ScriptBaseEntity // Show/Hide the HUD (scxpm_hide_hud)
{
	int hudCVar;
	
	void Spawn()
	{
		hudCVar = int( g_EngineFuncs.CVarGetFloat( "scxpm_hud_channel" ) );
		if ( hudCVar == 0 )
			hudCVar = 3;
		
		if ( string( self.pev.targetname ).Length() == 0 )
		{
			gameSettings ^= HIDE_HUD;
			ClearHUD();
			g_EntityFuncs.Remove( self );
		}
	}
	
	void Use( CBaseEntity@ pActivator, CBaseEntity@ pCaller, USE_TYPE useType, float flValue )
	{
		switch ( useType )
		{
			case USE_OFF: gameSettings &= ~HIDE_HUD; break;
			case USE_ON: gameSettings |= HIDE_HUD; break;
			default: gameSettings ^= HIDE_HUD; break;
		}
	}
	
	void ClearHUD()
	{
		if ( IsBitSet( gameSettings, HIDE_HUD ) )
		{
			HUDTextParams blah;
			blah.channel = hudCVar;
			g_PlayerFuncs.HudMessageAll( blah, " " ); // just to empty the HUD
		}
	}
}

class CSimulateLevel : ScriptBaseEntity // Enable simulated level (scxpm_simulate_level)
{
	void Spawn()
	{
		// Simulated level cannot be turned on on these conditions
		if ( IsBitSet( gameSettings, SINGLE_ACHIEVEMENT ) || IsBitSet( gameSettings, LIMITED_RESPAWN ) )
		{
			g_EntityFuncs.Remove( self );
			return;
		}
		
		gameSettings |= LIMITED_RESPAWN;
		for ( int iPlayerIndex = 1; iPlayerIndex <= g_Engine.maxClients; iPlayerIndex++ )
		{
			CBasePlayer@ pPlayer = g_PlayerFuncs.FindPlayerByIndex( iPlayerIndex );
			if ( pPlayer !is null && pPlayer.IsConnected() )
			{
				pPlayer.pev.frags = 0;
				lastfrags[ iPlayerIndex ] = 0;
				earnedxp[ iPlayerIndex ] = 0;
				
				xp[ iPlayerIndex ] = scxpm_calc_xp( gameCfgParam );
				medals[ iPlayerIndex ] = 0;
				
				SCXPMResetBasic( pPlayer, true );
				SCXPMResetSpecial( pPlayer, true );
				
				playerlevel[ iPlayerIndex ] = gameCfgParam;
				scxpm_calcneedxp( iPlayerIndex );
				
				// Warn players?
				if ( self.pev.SpawnFlagBitSet( 1 ) )
					g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "[SCXPM] Your current level is being simulated. Your real level will be restored at map end.\n" );
			}
		}
		
		g_EntityFuncs.Remove( self );
	}
	
	bool KeyValue( const string& in szKey, const string& in szValue )
	{
		if ( szKey == "level" )
		{
			if ( !IsBitSet( gameSettings, SINGLE_ACHIEVEMENT ) && !IsBitSet( gameSettings, LIMITED_RESPAWN ) )
				gameCfgParam = atoi( szValue );
			
			return true;
		}
		else
			return BaseClass.KeyValue( szKey, szValue );
	}
}

class CHCEnforcer : ScriptBaseEntity // Forces a handicap (scxpm_force_handicap)
{
	void Spawn()
	{
		// Needs a targetname
		if ( string( self.pev.targetname ).Length() == 0 )
			g_EntityFuncs.Remove( self );
	}
	
	void Use( CBaseEntity@ pActivator, CBaseEntity@ pCaller, USE_TYPE useType, float flValue )
	{
		if ( !pActivator.IsPlayer() )
			return;
		
		const int iPlayerIndex = pActivator.entindex();
		const int handicapBits = self.pev.spawnflags;
		
		if ( useType == USE_OFF )
		{
			forcedHandicaps[ iPlayerIndex ] &= ~handicapBits;
			return;
		}
		
		forcedHandicaps[ iPlayerIndex ] |= handicapBits;
	}
}

// Global on purpose
void GiveDelayedXP( const int iPlayerIndex )
{
	if ( iPlayerIndex == 0 )
	{
		for ( int i = 1; i <= g_Engine.maxClients; i++ )
		{
			CBasePlayer@ pPlayer = g_PlayerFuncs.FindPlayerByIndex( i );
			
			if ( pPlayer !is null && pPlayer.IsConnected() )
			{
				xp[ i ] += earnedxp[ i ];
				earnedxp[ i ] = 0;
				pPlayer.pev.frags = 0;
				lastfrags[ i ] = 0;
			}
		}
	}
	else
	{
		CBasePlayer@ pPlayer = g_PlayerFuncs.FindPlayerByIndex( iPlayerIndex );
		
		if ( pPlayer !is null && pPlayer.IsConnected() )
		{
			xp[ iPlayerIndex ] += earnedxp[ iPlayerIndex ];
			earnedxp[ iPlayerIndex ] = 0;
			pPlayer.pev.frags = 0;
			lastfrags[ iPlayerIndex ] = 0;
		}
	}
}

/* UNIVERSAL DateTime */
// Made my own cuz the vanilla DateTime class is completely broken in Linux
class uDateTime
{
	private uint32 timestamp;
	private array< int > monthDays = { 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31 };
	
	private int year;
	private int month;
	private int day;
	private int hour;
	private int minutes;
	private int seconds;
	
	uint32 GetUnixTimestamp() { return timestamp; }
	
	int GetYear() { return year; }
	int GetMonth() { return month; }
	int GetDayOfMonth() { return day; }
	int GetHour() { return hour; }
	int GetMinutes() { return minutes; }
	int GetSeconds() { return seconds; }
	
	private void GetTime()
	{
		seconds = timestamp % 60;
		minutes = timestamp / 60;
		if ( !IS_LINUX_SERVER ) { minutes += int( 60 * U_TIMEZONE ); }
		hour = minutes / 60;
		day = hour / 24;
		
		minutes %= 60;
		hour %= 24;
		
		// reset timestamp dates
		year = 1970; month = 1;
		while ( day > 0 )
		{
			if ( ( year % 400 ) == 0 || ( year % 4 == 0 && year % 100 != 0 ) )
			{
				if ( day < 366 )
					break;
				day -= 366;
			}
			else
			{
				if ( day < 365 )
					break;
				day -= 365;
			}
			year++;
		}
		day++;
		
		int leap = ( ( year % 400 ) == 0 || ( year % 4 == 0 && year % 100 != 0 ) ) ? 1 : 0;
		int index = 0;
		while ( day > 0 )
		{
			int mDays = monthDays[ index ];
			if ( index == 1 && leap == 1 )
				mDays++;
			
			if ( ( day - mDays ) <= 0 )
				break;
			
			month++;
			day -= mDays;
			index++;
		}
		
		if ( day > 0 )
			month++;
		else
		{
			if ( month == 2 && leap == 1 )
				day = 29;
			else
				day = monthDays[ month - 1 ];
		}
		
		month--;
	}
	
	uDateTime& opAssign( time_t T )
	{
		timestamp = uint32( T );
		GetTime();
		return this;
	}
	
	uDateTime& opAddAssign( uint32 S )
	{
		timestamp += S;
		GetTime();
		return this;
	}
	
	uDateTime& opAdd( uint32 S )
	{
		timestamp += S;
		GetTime();
		return this;
	}
	
	uDateTime( time_t T )
	{
		timestamp = uint32( T );
		GetTime();
	}
	
	uDateTime()
	{
		timestamp = 0;
		day = 1;
		month = 1;
		year = 1970;
	}
}

/* UNIVERSAL TimeDifference */
// To go along uDateTime class
class uTimeDifference
{
	private int delta;
	
	private int year;
	private int day;
	private int hour;
	private int minutes;
	private int seconds;
	
	int GetTimeDifference() { return delta; }
	
	int GetYears() { return year; }
	int GetDays() { return day; }
	int GetHours() { return hour; }
	int GetMinutes() { return minutes; }
	int GetSeconds() { return seconds; }
	
	// If start is later than end, is negative.
	uTimeDifference( uDateTime& END, uDateTime& START )
	{
		delta = int( END.GetUnixTimestamp() - START.GetUnixTimestamp() );
		
		int time = seconds = int( abs( delta ) );
		
		// inaccurate, but faster than the previous iteration
		time /= 60;
		minutes = time;
		
		time /= 60;
		hour = time;
		
		time /= 24;
		day = time;
		
		time /= 365;
		year = time;
	}
}

/* Returns the day specified */
string GetDate( uDateTime@ dtTime )
{
	int year = dtTime.GetYear();
	int month = dtTime.GetMonth();
	int day = dtTime.GetDayOfMonth();
	
	string szMonth;
	switch( month )
	{
		case 1: szMonth = "January"; break;
		case 2: szMonth = "February"; break;
		case 3: szMonth = "March"; break;
		case 4: szMonth = "April"; break;
		case 5: szMonth = "May"; break;
		case 6: szMonth = "June"; break;
		case 7: szMonth = "July"; break;
		case 8: szMonth = "August"; break;
		case 9: szMonth = "September"; break;
		case 10: szMonth = "October"; break;
		case 11: szMonth = "November"; break;
		case 12: szMonth = "December"; break;
	}
	
	string szAppend;
	switch( day )
	{
		case 1:
		case 11:
		case 21:
		case 31: szAppend = "st"; break;
		case 2:
		case 22: szAppend = "nd"; break;
		case 3: szAppend = "rd"; break;
		default: szAppend = "th"; break;
	}
	
	return szMonth + " " + day + szAppend + ", " + year;
}

/* Gets the name of a handicap. */
string GetHandicapName( const int HANDICAP )
{
	string szReturn = "NULL";
	switch ( HANDICAP )
	{
		case MEDICAL_PHOBIA: szReturn = "Medical Phobia"; break;
		case OBSOLETE_TECHNOLOGY: szReturn = "Obsolete Technology"; break;
		case NITROGEN_BLOOD: szReturn = "Nitrogen Blood"; break;
		case KARMIC_RETRIBUTION: szReturn = "Karmic Retribution"; break;
		case REALISM: szReturn = "Realism"; break;
		case BIG_EXPLOSION: szReturn = "Big Explosion"; break;
		case LIMITED_EQUIPMENT: szReturn = "Limited Equipment"; break;
		case DEAD_WEIGHT: szReturn = "Dead Weight"; break;
		case LACKING_HELP: szReturn = "Lacking Help"; break;
		case DIRTY_MAG: szReturn = "Dirty Mag"; break;
		case LOST_BULLETS: szReturn = "Lost Bullets"; break;
		case WEAK_RESTART: szReturn = "Weak Restart"; break;
		case DANGEROUS_WATERS: szReturn = "Dangerous Waters"; break;
		case BLEEDING_VIEW: szReturn = "Bleeding View"; break;
		case HEALTH_CRISIS: szReturn = "Health Crisis"; break;
	}
	return szReturn;
}
