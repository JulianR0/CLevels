/*
	Imperium Sven Co-op's SCXPM: Main Script
	Copyright (C) 2019-2021  Julian Rodriguez
	
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

const string version = "v3.14";
const string lastupdate = "December 29th, 2020";

const string PATH_MAIN_DATA = "scripts/plugins/store/scxpm/data/";
const string PATH_PERMAINCREASE_DATA = "scripts/plugins/store/scxpm/permaincrease/";
const string PATH_ACHIEVEMENT_DATA = "scripts/plugins/store/scxpm/achievement/";
const string PATH_EVENT_DATA = "scripts/plugins/store/scxpm/event/";
const string PATH_LOGS = "scripts/plugins/store/scxpm/logs/";
const string PATH_MAPS = "scripts/plugins/";

const int HUD_EXP = 1;
const int HUD_EXPLEFT = 2;
const int HUD_EXPEARN = 4;
const int HUD_LEVEL = 8;
const int HUD_CLASS = 16;
const int HUD_MEDALS = 32;
const int SS_DISPENCER = 64;
const int SS_RANGEHEAL = 128;
const int HUD_ACHIEVEMENTS = 256;
const int HC_AUTOSELECT = 512;

const float HH_EXTRAPERCENT = 2.00; // Happy Hour
const float RT_EXTRAPERCENT = 1.50; // Runaway Time

const float XP_DISABLED = 0.000001;
const float SCXPM_BASEXP = 0.25;
float MAP_XPGAIN = 1.00;

const array< string > ranks =
{
	"Beginner",
	"Hobo",
	"Recruit",
	"Rebel",
	"Resistance",
	"Student",
	"Armed Scientist",
	"Security Guard",
	"Green beret",
	"General",
	"Weapons enthusiast",
	"Alien Hunter",
	"Gordon Freeman",
	"Black Mesa Bio-Weapon",
	"Experimental Chimera",
	"Robot of Destruction",
	"Strategist",
	"M.I.A.",
	"Purifier",
	"Gonome Hunter",
	"Corporal Shephard",
	"Black Op",
	"X-Division",
	"Conqueror",
	"Honorable Member",
	"God of War",
	"Kamikaze",
	"Therapee",
	"Protector",
	"Xenian",
	"Bounty Hunter",
	"Agent",
	"G-Man",
	"Professional",
	"Assassin",
	"Elite Player",
	"Jumper",
	"Colonel Sanders",
	"Veteran",
	"Perfectionist",
	"The 42",
	"Cradle's Guardian",
	"Explorer of Sky",
	"Dark Dragon",
	"Explosive Clown",
	"Race-X Hybrid",
	"Chronicler",
	"Death Cheater",
	"Anarchist",
	"Jack of all trades",
	"Universal linker",
	"Multiversal linker",
	"The Architect",
	"Legacy of Creation",
	"Leggendaria",
	"Ancient Defender",
	"Sven Viking",
	"The One",
	"Master",
	"Grand Master",
	"Champion",
	"Marie Poppo"
};

const array< string > szAchievementNames =
{
	"It would be a shame",
	"Who needs assistance?",
	"Bronce Chumtoad",
	"Silver Chumtoad",
	"Gold Chumtoad",
	"A secretless chumtoad",
	"Over MY dead body!",
	"Over YOUR dead body!",
	"Climbing all day",
	"Just another worker",
	"HD Graphics with 3D Support",
	"Svenmessa",
	"Electrician from Hell",
	"Gonome Degree",
	"NeoDifference",
	"No more fighting",
	"Express Squadron",
	"No Lifer? Lies!",
	"Routine tasks",
	"Apache? Where?",
	"S.A.C. Elite",
	"Cheating Death",
	"I can help, too!",
	"IMMORTAL",
	"2.5D Platformer",
	"My horse is amazing",
	"Decollapse",
	"Wasting time",
	"Upside down",
	"Unbeatable Defense",
	"A survivor from beyond",
	"Neutral Labyrinth",
	"Not so tedious, okay?",
	"quadrazid",
	"Forced to Discriminate",
	"Movie Ticket",
	"Suicide Squad",
	"Complete Infiltration",
	"Pure Atheism",
	"Return to sender"
};

array< int > xp( 33 );
array< int > neededxp( 33 );
array< int > earnedxp( 33 );
array< int > playerlevel( 33 );
array< int > rank( 33 );
array< int > skillpoints( 33 );
array< int > specialpoints( 33 );
array< int > medals( 33 );
array< int > bData( 33 );
array< int > expamp( 33 );
array< DateTime > expamptime( 33 );
array< DateTime > firstplay( 33 );
array< DateTime > nextdaily( 33 );
array< int > dailyget( 33 );
array< float > permaincrease( 33 );
array< array< bool >> aData( 33, array< bool > ( szAchievementNames.length() ) );
array< array< bool >> aClaim( 33, array< bool > ( szAchievementNames.length() ) );

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

array< bool > be_once( 33 );

array< bool > handicap1( 33 );
array< bool > handicap2( 33 );
array< bool > handicap3( 33 );
array< bool > handicap4( 33 );
array< bool > handicap5( 33 );
array< bool > handicap6( 33 );
array< bool > handicap7( 33 );
array< bool > handicap8( 33 );
array< bool > handicap9( 33 );
array< bool > handicap10( 33 );
array< bool > handicap11( 33 );
array< bool > handicap12( 33 );
array< bool > handicap13( 33 );
array< bool > handicap14( 33 );
array< int > bHandicaps( 33 );

array< int > hud_red1( 33 );
array< int > hud_green1( 33 );
array< int > hud_blue1( 33 );
array< int > hud_red2( 33 );
array< int > hud_green2( 33 );
array< int > hud_blue2( 33 );
array< int > hud_alpha( 33 );
array< float > hud_pos_x( 33 );
array< float > hud_pos_y( 33 );
array< int > hud_effect( 33 );
array< float > hud_ef_fadein( 33 );
array< float > hud_ef_scantime( 33 );

array< float > rhealthwait( 33 );
array< float > rarmorwait( 33 );
array< float > rammowait( 33 );
array< float > flNextHPRegen( 33 );
float starthealth = 100.0;
float startarmor = 100.0;
array< int > skillIncrement( 33 );
array< float > lastfrags( 33 );
array< int > lastDeadflag( 33 );
array< bool > loaddata( 33 );
array< int > iIndexInspect( 33 );
array< bool > bIsSpectating( 33 );

bool gDisabled;
bool gNoAchievements;
bool gSingleAchievement;
int iAAllowed;
bool gNoSkills;
bool gDelayedXP;
bool gNoSpectate;
bool gAllowHandicaps;
bool gAllowPVPScore;
bool onecount;
bool event_active;
bool engage_mode;
bool can_edit_handicaps = true;
bool bSaveOldSkills;

int AMMO_MEDKIT;
int AMMO_9MM;
int AMMO_357;
int AMMO_SHOTGUN;
int AMMO_CROSSBOW;
int AMMO_SAW;
int AMMO_M16GRENADE;
int AMMO_RPG;
int AMMO_GAUSS;
int AMMO_SNIPER;
int AMMO_SPORE;
int AMMO_ROACH;

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

void PluginInit()
{
	g_Module.ScriptInfo.SetAuthor( "Julian \"Giegue\" Rodriguez" );
	g_Module.ScriptInfo.SetContactInfo( "www.steamcommunity.com/id/ngiegue" );
	
	g_Hooks.RegisterHook( Hooks::Player::ClientSay, @ClientSay );
	g_Hooks.RegisterHook( Hooks::Player::ClientPutInServer, @ClientPutInServer );
	g_Hooks.RegisterHook( Hooks::Player::ClientDisconnect, @ClientDisconnect );
	g_Hooks.RegisterHook( Hooks::Player::PlayerPreThink, @PlayerPreThink );
	g_Hooks.RegisterHook( Hooks::Player::PlayerKilled, @PlayerKilled ); // Nitrogen Blood handicap
	g_Hooks.RegisterHook( Hooks::Player::PlayerTakeDamage, @PlayerTakeDamage ); // Block Attack skill and many handicaps go here
	g_Hooks.RegisterHook( Hooks::Weapon::WeaponPrimaryAttack, @WeaponPrimaryAttack ); // Practice Shot special skill
	g_Hooks.RegisterHook( Hooks::Weapon::WeaponTertiaryAttack, @WeaponTertiaryAttack ); // Medical Emergency special skill
	g_Hooks.RegisterHook( Hooks::PickupObject::Collected, @WeaponPickUp ); // Instant reload glitch fix
	
	g_Scheduler.SetInterval( "scxpm_sdac", 0.5, g_Scheduler.REPEAT_INFINITE_TIMES );
	g_Scheduler.SetInterval( "scxpm_amptask", 60.0, g_Scheduler.REPEAT_INFINITE_TIMES );
	g_Scheduler.SetInterval( "scxpm_checkevent", 200.0, g_Scheduler.REPEAT_INFINITE_TIMES );
	g_Scheduler.SetInterval( "spectate_fix", 0.1, g_Scheduler.REPEAT_INFINITE_TIMES );
}

void MapInit()
{
	// Precache now all SCXPM sounds
	g_Game.PrecacheGeneric( "sound/isc/scxpm/levelup.ogg" ); // These needs to be downloaded first
	g_Game.PrecacheGeneric( "sound/isc/scxpm/medalget.ogg" );
	g_Game.PrecacheGeneric( "sound/isc/scxpm/achievement.ogg" );
	g_SoundSystem.PrecacheSound( "isc/scxpm/levelup.ogg" ); // Level up
	g_SoundSystem.PrecacheSound( "isc/scxpm/medalget.ogg" ); // Medal get
	g_SoundSystem.PrecacheSound( "isc/scxpm/achievement.ogg" ); // Achievement unlocked
	g_SoundSystem.PrecacheSound( "adamr/blipblipblip.wav" ); // Sound notice for player in case of "Level down" and "Medal lost"
	g_SoundSystem.PrecacheSound( "ambience/goal_1.wav" ); // 100% clear
	
	// Register (and precache) now all auxiliary entities
	g_Game.PrecacheModel( "sprites/null.spr" );
	g_Game.PrecacheModel( "models/w_medkit.mdl" );
	g_CustomEntityFuncs.RegisterCustomEntity( "CFlyingMedkit", "scxpm_medkit_dart" );
	g_CustomEntityFuncs.RegisterCustomEntity( "CDelayedXP", "scxpm_give_xp" );
	
	gDisabled = false;
	gNoAchievements = false;
	gSingleAchievement = false;
	iAAllowed = 0;
	gNoSkills = false;
	gDelayedXP = false;
	gNoSpectate = false;
	gAllowHandicaps = false;
	gAllowPVPScore = false;
	onecount = false;
	can_edit_handicaps = true;
	bSaveOldSkills = false;
	event_active = false;
	engage_mode = false;
	for ( int i = 0; i < 33; i++ )
	{
		flNextHPRegen[ i ] = 0.0;
		earnedxp[ i ] = 0.0;
		permaincrease[ i ] = 0.0;
		loaddata[ i ] = false;
		be_once[ i ] = false;
		handicap1[ i ] = false;
		handicap2[ i ] = false;
		handicap3[ i ] = false;
		handicap4[ i ] = false;
		handicap5[ i ] = false;
		handicap6[ i ] = false;
		handicap7[ i ] = false;
		handicap8[ i ] = false;
		handicap9[ i ] = false;
		handicap10[ i ] = false;
		handicap11[ i ] = false;
		handicap12[ i ] = false;
		handicap13[ i ] = false;
		handicap14[ i ] = false;
		bHandicaps[ i ] = 0;
		iIndexInspect[ i ] = 0;
		bIsSpectating[ i ] = false;
		
		for ( uint j = 0; j < szAchievementNames.length(); j++ )
		{
			aData[ i ][ j ] = false;
			aClaim[ i ][ j ] = false;
		}
	}
	
	array< string >@ states = pmenu_state.getKeys();
	for ( uint i = 0; i < states.length(); i++ )
	{
		MenuHandler@ state = cast< MenuHandler@ >( pmenu_state[ states[ i ] ] );
		if ( state.menu !is null )
			@state.menu = null;
	}
	
	MAP_XPGAIN = 1.00;
	
	// Update logs
	string mapname = string( g_Engine.mapname );
	SCXPM_Log( "-------- Mapchange to " + mapname + " --------\n" );
	
	string fullpath = PATH_MAPS + "scxpm_mapsettings.ini";
	File@ thefile = g_FileSystem.OpenFile( fullpath, OpenFile::READ );
	if ( thefile !is null && thefile.IsOpen() )
	{
		string line;
		
		while ( !thefile.EOFReached() )
		{
			thefile.ReadLine( line );
			if ( line.Length() == 0 || line[ 0 ] == ';' )
				continue;
			
			array< string >@ pre_setting = line.Split( ' ' );
			pre_setting[ 0 ].Trim();
			pre_setting[ 1 ].Trim();
			
			if ( SCXPM_FindMap( pre_setting[ 0 ], mapname ) ) // Map found
			{
				array< string >@ pre_mode = pre_setting[ 1 ].Split( '|' );
				if ( pre_mode[ 0 ] == 'DISABLED' )
				{
					gDisabled = true;
					SCXPM_Log( "-------- SCXPM DISABLED FOR MAP: " + mapname + " --------\n" );
					break;
				}
				else
				{
					for ( uint i = 0; i < pre_mode.length(); i++ )
					{
						if ( pre_mode[ i ] == 'NO_ACHIEVEMENTS' )
							gNoAchievements = true;
						else if ( pre_mode[ i ] == 'SINGLE_ACHIEVEMENT' )
							gSingleAchievement = true;
						else if ( pre_mode[ i ] == 'NO_SKILLS' )
							gNoSkills = true;
						else if ( pre_mode[ i ] == 'DELAYED_XP' )
							gDelayedXP = true;
						else if ( pre_mode[ i ] == 'NO_SPECTATE' )
							gNoSpectate = true;
						else if ( pre_mode[ i ] == 'ALLOW_HANDICAPS' )
							gAllowHandicaps = true;
						else if ( pre_mode[ i ] == 'ALLOW_PVP_SCORE' )
							gAllowPVPScore = true;
					}
				}
				
				pre_setting[ 2 ].Trim();
				MAP_XPGAIN = atof( pre_setting[ 2 ] );
				if ( MAP_XPGAIN <= 0.00 ) MAP_XPGAIN = 0.00001;
				
				if ( gSingleAchievement )
				{
					pre_setting[ 3 ].Trim();
					iAAllowed = atoi( pre_setting[ 3 ] );
				}
				
				break;
			}
		}
	}
	
	g_Scheduler.SetTimeout( "scxpm_block_handicaps", 70.0 );
}

void MapActivate()
{
	// Refresh standard weapon ammo indexes
	AMMO_MEDKIT = g_PlayerFuncs.GetAmmoIndex( "health" );
	AMMO_9MM = g_PlayerFuncs.GetAmmoIndex( "9mm" );
	AMMO_357 = g_PlayerFuncs.GetAmmoIndex( "357" );
	AMMO_SHOTGUN = g_PlayerFuncs.GetAmmoIndex( "buckshot" );
	AMMO_CROSSBOW = g_PlayerFuncs.GetAmmoIndex( "bolts" );
	AMMO_SAW = g_PlayerFuncs.GetAmmoIndex( "556" );
	AMMO_M16GRENADE = g_PlayerFuncs.GetAmmoIndex( "ARgrenades" );
	AMMO_RPG = g_PlayerFuncs.GetAmmoIndex( "rockets" );
	AMMO_GAUSS = g_PlayerFuncs.GetAmmoIndex( "uranium" );
	AMMO_SNIPER = g_PlayerFuncs.GetAmmoIndex( "m40a1" );
	AMMO_SPORE = g_PlayerFuncs.GetAmmoIndex( "sporeclip" );
	AMMO_ROACH = g_PlayerFuncs.GetAmmoIndex( "shock charges" );
	
	// Check time based events
	scxpm_checkevent();
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

HookReturnCode ClientPutInServer( CBasePlayer@ pPlayer )
{
	if ( gDisabled )
		return HOOK_CONTINUE;
	
	int index = pPlayer.entindex();
	
	lastfrags[ index ] = 0.0;
	lastDeadflag[ index ] = 123;
	loaddata[ index ] = false;
	
	scxpm_loaddata( index );
	
	return HOOK_CONTINUE;
}

HookReturnCode ClientDisconnect( CBasePlayer@ pPlayer )
{
	if ( gDisabled )
		return HOOK_CONTINUE;
	
	int index = pPlayer.entindex();
	
	xp[ index ] = 0.0;
	neededxp[ index ] = 0.0;
	earnedxp[ index ] = 0.0;
	playerlevel[ index ] = 0;
	skillpoints[ index ] = 0;
	medals[ index ] = 0;
	health[ index ] = 0;
	armor[ index ] = 0;
	rhealth[ index ] = 0;
	rarmor[ index ] = 0;
	rammo[ index ] = 0;
	gravity[ index ] = 0;
	speed[ index ] = 0;
	dist[ index ] = 0;
	dodge[ index ] = 0;
	expamp[ index ] = 0;
	expamptime[ index ] = 0;
	nextdaily[ index ] = 0;
	dailyget[ index ] = 0;
	permaincrease[ index ] = 0.0;
	spawndmg[ index ] = 0;
	ubercharge[ index ] = 0;
	fastheal[ index ] = 0;
	demoman[ index ] = 0;
	practiceshot[ index ] = 0;
	bioelectric[ index ] = 0;
	redcross[ index ] = 0;
	be_once[ index ] = false;
	handicap1[ index ] = false;
	handicap2[ index ] = false;
	handicap3[ index ] = false;
	handicap4[ index ] = false;
	handicap5[ index ] = false;
	handicap6[ index ] = false;
	handicap7[ index ] = false;
	handicap8[ index ] = false;
	handicap9[ index ] = false;
	handicap10[ index ] = false;
	handicap11[ index ] = false;
	handicap12[ index ] = false;
	handicap13[ index ] = false;
	handicap14[ index ] = false;
	bHandicaps[ index ] = 0;
	rarmorwait[ index ] = 0.0;
	rhealthwait[ index ] = 0.0;
	rammowait[ index ] = 0.0;
	flNextHPRegen[ index ] = 0.0;
	rank[ index ] = 0;
	iIndexInspect[ index ] = 0;
	bIsSpectating[ index ] = false;
	
	for ( uint i = 0; i < szAchievementNames.length(); i++ )
	{
		aData[ index ][ i ] = false;
		aClaim[ index ][ i ] = false;
	}
	
	loaddata[ index ] = false;
	
	return HOOK_CONTINUE;
}

HookReturnCode ClientSay( SayParameters@ pParams )
{
	if ( gDisabled )
		return HOOK_CONTINUE;
	
	ClientSayType type = pParams.GetSayType();
	if ( type == CLIENTSAY_SAY )
	{
		CBasePlayer@ pPlayer = pParams.GetPlayer();
		string text = pParams.GetCommand();
		pParams.ShouldHide = true;
		text.ToLowercase();
		
		if ( text == '/selectskills' )
		{
			SCXPMSkill( pPlayer.entindex() );
			return HOOK_HANDLED;
		}
		else if ( text == '/resetskills' )
		{
			scxpm_breset( pPlayer.entindex() );
			return HOOK_HANDLED;
		}
		else if ( text == '/selectspecials' )
		{
			SCXPMSpecials( pPlayer.entindex() );
			return HOOK_HANDLED;
		}
		else if ( text == '/resetspecials' )
		{
			scxpm_sreset( pPlayer.entindex() );
			return HOOK_HANDLED;
		}
		else if ( text == '/resetlevels' )
		{
			scxpm_lvltomedal( pPlayer.entindex() );
			return HOOK_HANDLED;
		}
		else if ( text == '/handicaps' )
		{
			scxpm_handicaps( pPlayer.entindex() );
			return HOOK_HANDLED;
		}
		else if ( text == '/hudsettings' )
		{
			scxpm_hudmain( pPlayer.entindex() );
			return HOOK_HANDLED;
		}
		else if ( text == '/playerskills' )
		{
			scxpm_others( pPlayer.entindex() );
			return HOOK_HANDLED;
		}
		else if ( text == '/skillsinfo' )
		{
			scxpm_info( pPlayer.entindex() );
			return HOOK_HANDLED;
		}
		else if ( text == '/scxpminfo' )
		{
			scxpm_version( pPlayer.entindex() );
			return HOOK_HANDLED;
		}
		else if ( text == '/xpgain' )
		{
			scxpm_xpgain( pPlayer.entindex() );
			return HOOK_HANDLED;
		}
		else if ( text == '/specialsinfo' )
		{
			scxpm_sinfo( pPlayer.entindex() );
			return HOOK_HANDLED;
		}
		else if ( text == '/handicapsinfo' )
		{
			scxpm_hcinfo( pPlayer.entindex() );
			return HOOK_HANDLED;
		}
		else if ( text == '/character' )
		{
			scxpm_mydata( pPlayer.entindex() );
			return HOOK_HANDLED;
		}
		else if ( text == '/achievements' )
		{
			scxpm_achievements( pPlayer.entindex() );
			return HOOK_HANDLED;
		}
		else if ( text == '/menu' )
		{
			scxpm_menu( pPlayer.entindex() );
			return HOOK_HANDLED;
		}
		else if ( text == '/help' )
		{
			scxpm_helpme( pPlayer.entindex() );
			return HOOK_HANDLED;
		}
		else if ( text == '/spectate' )
		{
			scxpm_spectate( pPlayer.entindex() );
			return HOOK_HANDLED;
		}
		else
		{
			// Check for commands with arguments
			const CCommand@ args = pParams.GetArguments();
			if ( args[ 0 ] == '/hudcolor' )
			{
				scxpm_set_hudcustom( pParams );
				return HOOK_HANDLED;
			}
			else if ( args[ 0 ] == '/inspect' )
			{
				scxpm_inspect_main( pParams );
				return HOOK_HANDLED;
			}
			else
				pParams.ShouldHide = false;
		}
	}
	
	return HOOK_CONTINUE;
}

void scxpm_inspect_main( SayParameters@ pParams )
{
	pParams.ShouldHide = true;
	
	CBasePlayer@ pPlayer = pParams.GetPlayer();
	int index = pPlayer.entindex();
	
	const CCommand@ args = pParams.GetArguments();
	
	if ( args.ArgC() > 1 )
	{
		bool bMultiple = false;
		CBasePlayer@ pTarget = SCXPM_FindPlayer( args[ 1 ], bMultiple );
		
		if ( bMultiple )
			g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "[SCXPM] Multiple players found. Be more specific.\n" );
		else if ( pTarget !is null )
		{
			if ( pTarget is pPlayer )
			{
				g_Scheduler.SetTimeout( "scxpm_mydata", 0.01, index );
				return;
			}
			
			MenuHandler@ state = MenuGetPlayer( pPlayer );
			state.InitMenu( pPlayer, scxpm_inspect_main_cb );
			
			int target_index = pTarget.entindex();
			iIndexInspect[ index ] = target_index;
			
			string title = string( pTarget.pev.netname ) + "\n\n";
			title += g_EngineFuncs.GetPlayerAuthId( pTarget.edict() ) + "\n\n\n";
			
			title += "Level: " + AddCommas( scxpm_calc_lvl( xp[ target_index ] ) ) + "\n";
			title += "Medals: " + AddCommas( medals[ target_index ] ) + "\n\n";
			
			title += "Achievements: " + GetAchievementClear( target_index ) + " of " + int( szAchievementNames.length() ) + " unlocked\n";
			title += "XP Mods:" + ( permaincrease[ target_index ] > 0.0 ? " +" : " " ) + int( permaincrease[ target_index ] ) + "%\n\n";
			
			title += "First play ever was on\n";
			title += GetFormatDate( firstplay[ target_index ] ) + "\n\n";
			title += "Daily rewards get: " + dailyget[ target_index ] + "\n";
			
			state.menu.SetTitle( title );
			state.menu.AddItem( "View player's Achievements", any( "item1" ) );
			state.menu.AddItem( "View player's XP Mods\n", any( "item2" ) );
			state.menu.AddItem( "My character", any( "item3" ) );
			
			state.OpenMenu( pPlayer, 0, 0 );
		}
		else
			g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "[SCXPM] Player not found.\n" );
	}
	else
	{
		g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "[SCXPM] Usage: /inspect <Player>\n" );
		g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "[SCXPM] Shows detailed information of a player.\n" );
	}
}

void scxpm_inspect_main_cb( CTextMenu@ menu, CBasePlayer@ pPlayer, int page, const CTextMenuItem@ item )
{
	int index = pPlayer.entindex();
	if ( page == 10 ) return;
	
	string selection;
	item.m_pUserData.retrieve( selection );
	
	if ( selection == 'item1' )
		g_Scheduler.SetTimeout( "scxpm_achievements", 0.01, index, 0, iIndexInspect[ index ] );
	else if ( selection == 'item2' )
		g_Scheduler.SetTimeout( "scxpm_permaincrease", 0.01, index, 0, iIndexInspect[ index ] );
	else if ( selection == 'item3' )
		g_Scheduler.SetTimeout( "scxpm_mydata", 0.01, index );
}

void scxpm_spectate( const int& in index )
{
	CBasePlayer@ pPlayer = g_PlayerFuncs.FindPlayerByIndex( index );
	
	if ( gNoSpectate )
	{
		g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "[SCXPM] The spectate command is disabled on this map.\n" );
		return;
	}
	
	if ( !pPlayer.IsAlive() )
	{
		if ( !bIsSpectating[ index ] )
		{
			bIsSpectating[ index ] = true;
			pPlayer.m_flRespawnDelayTime = Math.FLOAT_MAX;
			if ( ( pPlayer.pev.effects & EF_NODRAW ) != 0 )
				pPlayer.GetObserver().StartObserver( pPlayer.pev.origin, pPlayer.pev.angles, false );
			else
				pPlayer.GetObserver().StartObserver( pPlayer.pev.origin, pPlayer.pev.angles, true );
			pPlayer.m_flRespawnDelayTime = Math.FLOAT_MAX;
			
			g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "[SCXPM] Write /spectate in chat again to respawn.\n" );
		}
		else
		{
			bIsSpectating[ index ] = false;
			g_PlayerFuncs.RespawnPlayer( pPlayer, true, true );
		}
	}
	else
		g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "[SCXPM] Can only spectate while dead.\n" );
}

void spectate_fix()
{
	for ( int i = 1; i <= g_Engine.maxClients; i++ )
	{
		CBasePlayer@ pPlayer = g_PlayerFuncs.FindPlayerByIndex( i );
		
		if ( pPlayer !is null && pPlayer.IsConnected() )
		{
			if ( bIsSpectating[ i ] )
				pPlayer.m_flRespawnDelayTime = Math.FLOAT_MAX;
		}
	}
}

void scxpm_checkevent()
{
	if ( gDisabled )
		return;
	
	DateTime thetime( UnixTimestamp() );
	int hours = thetime.GetHour();
	
	if ( hours >= 22 || hours >= 0 && hours < 4 ) // 22hs to 04hs (10 PM to 4 AM)
	{
		if ( !event_active )
		{
			event_active = true;
			MAP_XPGAIN = MAP_XPGAIN * HH_EXTRAPERCENT;
		}
		g_PlayerFuncs.ClientPrintAll( HUD_PRINTTALK, "[SCXPM] Happy Hours! Enjoy your stay with greater XP gain!\n" ); // CRINGE TEXTS ARE CRINGE
	}
	else if ( hours >= 4 && hours < 6 ) // 04hs to 06hs (4 AM to 6 AM)
	{
		// Discourage XP whorers from gaining easy levels on a possibly empty server
		if ( !event_active )
		{
			event_active = true; // In here to allow a server owner to override this setting with the xp_set_xpgain command
			MAP_XPGAIN = MAP_XPGAIN / 2.0;
		}
	}
	else if ( hours >= 8 && hours < 12 ) // 08hs to 12hs (8 AM to 12 PM)
	{
		if ( !event_active )
		{
			event_active = true;
			MAP_XPGAIN = MAP_XPGAIN * RT_EXTRAPERCENT;
		}
		g_PlayerFuncs.ClientPrintAll( HUD_PRINTTALK, "[SCXPM] Hello, \"Runaway\". You gain more XP while you avoid school time. Good luck!\n" );
	}
	else if ( hours >= 16 && hours < 18 ) // 16hs to 18hs (4 PM to 6 PM)
	{
		if ( !event_active )
		{
			event_active = true;
			engage_mode = true;
		}
		g_PlayerFuncs.ClientPrintAll( HUD_PRINTTALK, "[SCXPM] ENGAGE MODE! All achievements will now have their rewards doubled!\n" );
	}
}

CClientCommand ADMIN_CMDHELP( "xp_help", " - Shows all available admin commands.", @scxpm_acmdhelp, ConCommandFlag::AdminOnly );
void scxpm_acmdhelp( const CCommand@ pArgs )
{
	CBasePlayer@ pPlayer = g_ConCommandSystem.GetCurrentPlayer();
	
	g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTCONSOLE, "[SCXPM] Command list:\n\n" );
	g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTCONSOLE, ".xp_addxp <Name> <Amount> - Give XP to a player.\n" );
	g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTCONSOLE, ".xp_removexp <Name> <Amount> - Take XP away to a player.\n" );
	g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTCONSOLE, ".xp_setlvl <Name> <Value> - Sets a player's level.\n" );
	g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTCONSOLE, ".xp_addmedal <Name> <Amount> - Give medals to a player.\n" );
	g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTCONSOLE, ".xp_removemedal <Name> <Amount> - Take medals away from a player.\n" );
	g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTCONSOLE, ".xp_giveamp <Name> <Level> <Duration> - Increases a player's XP gain.\n" );
	g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTCONSOLE, ".xp_givepi <Name> <Value> <Title> <Description> - Give an XP Mod to a player.\n" );
	g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTCONSOLE, ".xp_setadata <Name> <Achievement ID> <Unlock> <Give Reward> - Locks or unlocks an achievement to a player.\n" );
	g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTCONSOLE, ".xp_set_xpgain <Value> - OWNERS ONLY - Changes map's XP gain.\n\n" );
}

CClientCommand ADMIN_ADDXP( "xp_addxp", "<Name> <Amount> - Give XP to a player.", @scxpm_addxp, ConCommandFlag::AdminOnly );
void scxpm_addxp( const CCommand@ pArgs )
{
	CBasePlayer@ pPlayer = g_ConCommandSystem.GetCurrentPlayer();
	
	if ( pArgs.ArgC() >= 3 )
	{
		bool bMultiple = false;
		CBasePlayer@ pTarget = SCXPM_FindPlayer( pArgs[ 1 ], bMultiple );
		
		if ( bMultiple )
			g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTCONSOLE, "[SCXPM] Multiple players found. Be more specific.\n" );
		else if ( pTarget !is null )
		{
			int addxp = Math.clamp( 0, scxpm_calc_xp( 3000 ) + 1, atoi( pArgs[ 2 ] ) );
			int index = pTarget.entindex();
			
			// This is "ADD" xp. Don't allow negative (or zero) values
			if ( addxp <= 0 )
			{
				g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTCONSOLE, "[SCXPM] Amount must be greater than 0.\n" );
				return;
			}
			
			// Max LV
			if ( playerlevel[ index ] >= 3000 )
			{
				g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTCONSOLE, "[SCXPM] That player is on it's maximum level and no more XP can be given.\n" );
				return;
			}
			
			// Keep clamping
			int overflow = addxp + xp[ index ];
			if ( overflow > scxpm_calc_xp( 3000 ) )
				addxp = scxpm_calc_xp( 3000 ) - xp[ index ];
			
			// Get now the target's and the admin's name and steamid
			string aname = pPlayer.pev.netname;
			string asteamid = g_EngineFuncs.GetPlayerAuthId( pPlayer.edict() );
			string tname = pTarget.pev.netname;
			string tsteamid = g_EngineFuncs.GetPlayerAuthId( pTarget.edict() );
			
			xp[ index ] += addxp;
			g_Game.AlertMessage( at_logged, "[SCXPM] " + aname + " (" + asteamid + ") gave to " + tname + " (" + tsteamid + ") " + AddCommas( addxp ) + " XP\n" );
			SCXPM_Log( aname + " (" + asteamid + ") gave to " + tname + " (" + tsteamid + ") " + AddCommas( addxp ) + " XP\n" );
			
			earnedxp[ index ] += addxp;
			
			scxpm_savedata( index );
			
			g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTCONSOLE, "[SCXPM] " + AddCommas( addxp ) + " XP given to player.\n" );
			g_PlayerFuncs.ClientPrintAll( HUD_PRINTTALK, "ADMIN " + aname + ": Give " + AddCommas( addxp ) + " XP to " + tname + ".\n" );
		}
		else
			g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTCONSOLE, "[SCXPM] Player not found.\n" );
	}
	else if ( pArgs.ArgC() == 1 )
		g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTCONSOLE, "[SCXPM] Usage: .xp_addxp <Name> <Amount> - Give XP to a player.\n" );
	else
		g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTCONSOLE, "[SCXPM] Not enough parameters.\n" );
}

CClientCommand ADMIN_REMOVEXP( "xp_removexp", "<Name> <Amount> - Take XP away to a player.", @scxpm_removexp, ConCommandFlag::AdminOnly );
void scxpm_removexp( const CCommand@ pArgs )
{
	CBasePlayer@ pPlayer = g_ConCommandSystem.GetCurrentPlayer();
	
	if ( pArgs.ArgC() >= 3 )
	{
		bool bMultiple = false;
		CBasePlayer@ pTarget = SCXPM_FindPlayer( pArgs[ 1 ], bMultiple );
		
		if ( bMultiple )
			g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTCONSOLE, "[SCXPM] Multiple players found. Be more specific.\n" );
		else if ( pTarget !is null )
		{
			int removexp = Math.clamp( 0, Math.INT32_MAX, atoi( pArgs[ 2 ] ) );
			int index = pTarget.entindex();
			
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
			
			xp[ index ] -= removexp;
			if ( xp[ index ] < 0 ) xp[ index ] = 0; // Don't overflow
			g_Game.AlertMessage( at_logged, "[SCXPM] " + aname + " (" + asteamid + ") took from " + tname + " (" + tsteamid + ") " + AddCommas( removexp ) + " XP\n" );
			SCXPM_Log( aname + " (" + asteamid + ") took from " + tname + " (" + tsteamid + ") " + AddCommas( removexp ) + " XP\n" );
			
			earnedxp[ index ] -= removexp;
			
			// Level needs to be recalculated
			playerlevel[ index ] = scxpm_calc_lvl( xp[ index ] );
			
			// Reset skills
			scxpm_breset( index, true );
			g_PlayerFuncs.ClientPrint( pTarget, HUD_PRINTTALK, "[SCXPM] Your skills has been reset. Remember to select them again!\n" );
			
			// Recalculate needed xp
			scxpm_calcneedxp( index );
			scxpm_getrank( index );
			
			scxpm_savedata( index );
			
			g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTCONSOLE, "[SCXPM] Took away " + AddCommas( removexp ) + " XP from the player.\n" );
			g_PlayerFuncs.ClientPrintAll( HUD_PRINTTALK, "ADMIN " + aname + ": Take " + AddCommas( removexp ) + " XP away from " + tname + ".\n" );
		}
		else
			g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTCONSOLE, "[SCXPM] Player not found.\n" );
	}
	else if ( pArgs.ArgC() == 1 )
		g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTCONSOLE, "[SCXPM] Usage: .xp_removexp <Name> <Amount> - Take XP away to a player.\n" );
	else
		g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTCONSOLE, "[SCXPM] Not enough parameters.\n" );
}

CClientCommand ADMIN_SETLVL( "xp_setlvl", "<Name> <Value> - Sets a player's level.", @scxpm_setlvl, ConCommandFlag::AdminOnly );
void scxpm_setlvl( const CCommand@ pArgs )
{
	CBasePlayer@ pPlayer = g_ConCommandSystem.GetCurrentPlayer();
	
	if ( pArgs.ArgC() >= 3 )
	{
		bool bMultiple = false;
		CBasePlayer@ pTarget = SCXPM_FindPlayer( pArgs[ 1 ], bMultiple );
		
		if ( bMultiple )
			g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTCONSOLE, "[SCXPM] Multiple players found. Be more specific.\n" );
		else if ( pTarget !is null )
		{
			int nowlvl = Math.clamp( 0, 3000, atoi( pArgs[ 2 ] ) ); // 3.000 is the absolute max level that can be reached, going further glitches the XP calculations
			int index = pTarget.entindex();
			
			// Get now the target's and the admin's name and steamid
			string aname = pPlayer.pev.netname;
			string asteamid = g_EngineFuncs.GetPlayerAuthId( pPlayer.edict() );
			string tname = pTarget.pev.netname;
			string tsteamid = g_EngineFuncs.GetPlayerAuthId( pTarget.edict() );
			
			if ( nowlvl == playerlevel[ index ] )
			{
				g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTCONSOLE, "[SCXPM] " + tname + "'s level is already " + nowlvl + ".\n" );
				return;
			}
			else
			{
				if ( nowlvl == 0 )
					xp[ index ] = 0;
				else
				{
					int helpvar = nowlvl - 1;
					float m70b = float( helpvar ) * 70.0;
					float mselfm3dot2b = float( helpvar ) * float( helpvar ) * 3.5;
					xp[ index ] = floatround( m70b + mselfm3dot2b + 30.0 );
				}
			}
			
			if ( playerlevel[ index ] > nowlvl )
			{
				playerlevel[ index ] = nowlvl;
				g_PlayerFuncs.ClientPrint( pTarget, HUD_PRINTTALK, "[SCXPM] Your level was lowered and your skills has been reset!\n" );
				g_SoundSystem.EmitSoundDyn( pTarget.edict(), CHAN_STATIC, "adamr/blipblipblip.wav", VOL_NORM, ATTN_NONE, SND_SKIP_ORIGIN_USE_ENT, PITCH_NORM, index );
				
				scxpm_getrank( index );
				scxpm_breset( index, true );
			}
			else
			{
				skillpoints[ index ] = Math.clamp( 0, 700, skillpoints[ index ] + nowlvl - playerlevel[ index ] );
				playerlevel[ index ] = nowlvl;
				
				g_SoundSystem.EmitSoundDyn( pTarget.edict(), CHAN_STATIC, "isc/scxpm/levelup.ogg", VOL_NORM, ATTN_NONE, SND_SKIP_ORIGIN_USE_ENT, PITCH_NORM, index );
				
				g_PlayerFuncs.ClientPrint( pTarget, HUD_PRINTTALK, "[SCXPM] Your level was raised!\n" );
				SCXPMSkill( index );
				scxpm_getrank( index );
			}
			scxpm_calcneedxp( index );
			scxpm_savedata( index );
			
			g_Game.AlertMessage( at_logged, "[SCXPM] " + aname + " (" + asteamid + ") setted " + tname + " (" + tsteamid + ")'s level to " + AddCommas( nowlvl ) + ".\n" );
			SCXPM_Log( aname + " (" + asteamid + ") setted " + tname + " (" + tsteamid + ")'s level to " + AddCommas( nowlvl ) + ".\n" );
			
			g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTCONSOLE, "[SCXPM] Player's level set to " + AddCommas( nowlvl ) + ".\n" );
			g_PlayerFuncs.ClientPrintAll( HUD_PRINTTALK, "ADMIN " + aname + ": Set " + tname + "'s level to " + AddCommas( nowlvl ) + ".\n" );
		}
		else
			g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTCONSOLE, "[SCXPM] Player not found.\n" );
	}
	else if ( pArgs.ArgC() == 1 )
		g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTCONSOLE, "[SCXPM] Usage: .xp_setlvl <Name> <Value> - Sets a player's level.\n" );
	else
		g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTCONSOLE, "[SCXPM] Not enough parameters.\n" );
}

CClientCommand ADMIN_ADDMEDAL( "xp_addmedal", "<Name> <Amount> - Give medals to a player.", @scxpm_addmedal, ConCommandFlag::AdminOnly );
void scxpm_addmedal( const CCommand@ pArgs )
{
	CBasePlayer@ pPlayer = g_ConCommandSystem.GetCurrentPlayer();
	
	if ( pArgs.ArgC() >= 3 )
	{
		bool bMultiple = false;
		CBasePlayer@ pTarget = SCXPM_FindPlayer( pArgs[ 1 ], bMultiple );
		
		if ( bMultiple )
			g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTCONSOLE, "[SCXPM] Multiple players found. Be more specific.\n" );
		else if ( pTarget !is null )
		{
			int amount = Math.clamp( 0, 9999, atoi( pArgs[ 2 ] ) );
			int index = pTarget.entindex();
			
			// This is "ADD" medals. Don't allow negative (or zero) values
			if ( amount <= 0 )
			{
				g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTCONSOLE, "[SCXPM] Amount must be greater than 0.\n" );
				return;
			}
			
			if ( medals[ index ] >= 9999 )
			{
				g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTCONSOLE, "[SCXPM] That player has all possible medals. No more can be given.\n" );
				return;
			}
			
			// Welp, and repeat...
			int overflow = amount + medals[ index ];
			if ( overflow > 9999 )
				amount = 9999 - medals[ index ];
			
			medals[ index ] += amount;
			
			// Get now the target's and the admin's name and steamid
			string aname = pPlayer.pev.netname;
			string asteamid = g_EngineFuncs.GetPlayerAuthId( pPlayer.edict() );
			string tname = pTarget.pev.netname;
			string tsteamid = g_EngineFuncs.GetPlayerAuthId( pTarget.edict() );
			
			g_Game.AlertMessage( at_logged, "[SCXPM] " + aname + " (" + asteamid + ") gave to " + tname + " (" + tsteamid + ") " + amount + " medal(s)\n" );
			SCXPM_Log( aname + " (" + asteamid + ") gave to " + tname + " (" + tsteamid + ") " + amount + " medal(s)\n" );
			
			g_SoundSystem.EmitSoundDyn( pTarget.edict(), CHAN_STATIC, "isc/scxpm/medalget.ogg", VOL_NORM, ATTN_NONE, SND_SKIP_ORIGIN_USE_ENT, PITCH_NORM, index );
			scxpm_savedata( index );
			
			g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTCONSOLE, "[SCXPM] " + amount + " medal(s) given to the player.\n" );
			g_PlayerFuncs.ClientPrintAll( HUD_PRINTTALK, "ADMIN " + aname + ": Give " + amount + " medal(s) to " + tname + ".\n" );
		}
		else
			g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTCONSOLE, "[SCXPM] Player not found.\n" );
	}
	else if ( pArgs.ArgC() == 1 )
		g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTCONSOLE, "[SCXPM] Usage: .xp_addmedal <Name> <Amount> - Give medals to a player.\n" );
	else
		g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTCONSOLE, "[SCXPM] Not enough parameters.\n" );
}

CClientCommand ADMIN_REMOVEMEDAL( "xp_removemedal", "<Name> <Amount> - Take medals away from a player.", @scxpm_removemedal, ConCommandFlag::AdminOnly );
void scxpm_removemedal( const CCommand@ pArgs )
{
	CBasePlayer@ pPlayer = g_ConCommandSystem.GetCurrentPlayer();
	
	if ( pArgs.ArgC() >= 3 )
	{
		bool bMultiple = false;
		CBasePlayer@ pTarget = SCXPM_FindPlayer( pArgs[ 1 ], bMultiple );
		
		if ( bMultiple )
			g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTCONSOLE, "[SCXPM] Multiple players found. Be more specific.\n" );
		else if ( pTarget !is null )
		{
			int amount = Math.clamp( 0, 9999, atoi( pArgs[ 2 ] ) );
			int index = pTarget.entindex();
			
			// This is "REMOVE" medals. Don't allow negative (or zero) values
			if ( amount <= 0 )
			{
				g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTCONSOLE, "[SCXPM] Amount must be greater than 0.\n" );
				return;
			}
			
			if ( medals[ index ] <= 0 )
			{
				g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTCONSOLE, "[SCXPM] That player has no medals at all. Can't take away anymore.\n" );
				return;
			}
			
			if ( amount > medals[ index ] )
				amount = medals[ index ];
			
			medals[ index ] -= amount;
			
			// Get now the target's and the admin's name and steamid
			string aname = pPlayer.pev.netname;
			string asteamid = g_EngineFuncs.GetPlayerAuthId( pPlayer.edict() );
			string tname = pTarget.pev.netname;
			string tsteamid = g_EngineFuncs.GetPlayerAuthId( pTarget.edict() );
			
			g_Game.AlertMessage( at_logged, "[SCXPM] " + aname + " (" + asteamid + ") took from " + tname + " (" + tsteamid + ") " + amount + " medal(s)\n" );
			SCXPM_Log( aname + " (" + asteamid + ") took from " + tname + " (" + tsteamid + ") " + amount + " medal(s)\n" );
			
			g_SoundSystem.EmitSoundDyn( pTarget.edict(), CHAN_STATIC, "adamr/blipblipblip.wav", VOL_NORM, ATTN_NONE, SND_SKIP_ORIGIN_USE_ENT, PITCH_NORM, index );
			scxpm_savedata( index );
			
			g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTCONSOLE, "[SCXPM] Took away " + amount + " medal(s) from the player.\n" );
			g_PlayerFuncs.ClientPrintAll( HUD_PRINTTALK, "ADMIN " + aname + ": Take " + amount + " medal(s) away from " + tname + ".\n" );
		}
		else
			g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTCONSOLE, "[SCXPM] Player not found.\n" );
	}
	else if ( pArgs.ArgC() == 1 )
		g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTCONSOLE, "[SCXPM] Usage: .xp_removemedal <Name> <Amount> - Take medals away from a player.\n" );
	else
		g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTCONSOLE, "[SCXPM] Not enough parameters.\n" );
}

CClientCommand ADMIN_XPAMPLIFIER( "xp_giveamp", "<Name> <Level> <Duration> - Increases a player's XP gain.", @scxpm_expamp, ConCommandFlag::AdminOnly );
void scxpm_expamp( const CCommand@ pArgs )
{
	CBasePlayer@ pPlayer = g_ConCommandSystem.GetCurrentPlayer();
	
	if ( pArgs.ArgC() >= 4 )
	{
		bool bMultiple = false;
		CBasePlayer@ pTarget = SCXPM_FindPlayer( pArgs[ 1 ], bMultiple );
		
		if ( bMultiple )
			g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTCONSOLE, "[SCXPM] Multiple players found. Be more specific.\n" );
		else if ( pTarget !is null )
		{
			int level = atoi( pArgs[ 2 ] );
			int index = pTarget.entindex();
			
			if ( level < 0 || level >= 5 )
			{
				g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTCONSOLE, "[SCXPM] Amplifier level must be between 0 (remove multiplier) and 4 (x5 multiplier).\n" );
				return;
			}
			
			// Get now the target's and the admin's name and steamid
			string aname = pPlayer.pev.netname;
			string asteamid = g_EngineFuncs.GetPlayerAuthId( pPlayer.edict() );
			string tname = pTarget.pev.netname;
			string tsteamid = g_EngineFuncs.GetPlayerAuthId( pTarget.edict() );
			
			if ( level == 0 ) // Remove
			{
				expamp[ index ] = 0;
				expamptime[ index ] = 0;
				
				scxpm_savedata( index );
				
				g_Game.AlertMessage( at_logged, "[SCXPM] " + aname + " (" + asteamid + ") took from " + tname + " (" + tsteamid + ") " + "its multiplier.\n" );
				SCXPM_Log( aname + " (" + asteamid + ") took from " + tname + " (" + tsteamid + ") " + "its multiplier.\n" );
				
				g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTCONSOLE, "[SCXPM] Multiplier removed from player.\n" );
				g_PlayerFuncs.ClientPrintAll( HUD_PRINTTALK, "ADMIN " + aname + ": Take " + tname + "'s multiplier away.\n" );
			}
			else // Add
			{
				string duration = pArgs[ 3 ];
				if ( duration[ 0 ] == '0' )
				{
					g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTCONSOLE, "[SCXPM] Duration must be greater than 0.\n" );
					return;
				}
				else if ( !isdigit( duration[ 0 ] ) )
				{
					g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTCONSOLE, "[SCXPM] Invalid duration.\n" );
					return;
				}
				else if ( isdigit( duration[ duration.Length() - 1 ] ) )
				{
					g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTCONSOLE, "[SCXPM] Your duration of \"" + duration + "\" needs additional specification.\n\n" );
					g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTCONSOLE, "Use one of the following properties:\n\n" );
					g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTCONSOLE, duration + "m = " + duration + " minute(s)\n" );
					g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTCONSOLE, duration + "h = " + duration + " hour(s)\n" );
					g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTCONSOLE, duration + "d = " + duration + " day(s)\n\n" );
					g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTCONSOLE, "Properties must be written on lowercase.\n\n" );
					return;
				}
				else if ( duration[ duration.Length() - 1 ] != 'm' && duration[ duration.Length() - 1 ] != 'h' && duration[ duration.Length() - 1 ] != 'd' )
				{
					g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTCONSOLE, "[SCXPM] Invalid duration property.\n\n" );
					g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTCONSOLE, "Use one of the following properties:\n\n" );
					g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTCONSOLE, "m = minute(s)\n" );
					g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTCONSOLE, "h = hour(s)\n" );
					g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTCONSOLE, "d = day(s)\n\n" );
					g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTCONSOLE, "Properties must be written on lowercase.\n\n" );
					return;
				}
				else
				{
					int characters = 0;
					for ( uint i = 0; i < duration.Length(); i++ )
					{
						if ( isalpha( duration[ i ] ) )
							characters++;
					}
					
					if ( characters > 1 )
					{
						g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTCONSOLE, "[SCXPM] Only one property is allowed.\n" );
						return;
					}
					else
					{
						expamp[ index ] = level;
						
						// Save original flag
						char flag = duration[ duration.Length() - 1 ];
						
						duration.Replace( string( flag ), '=' );
						array< string >@ fixer = duration.Split( '=' );
						fixer[ 0 ].Trim();
						
						DateTime realduration( UnixTimestamp() );
						if ( flag == 'm' )
						{
							TimeDifference extra( atoi( fixer[ 0 ] ) * 60 );
							realduration += extra;
							expamptime[ index ] = realduration;
						}
						else if ( flag == 'h' )
						{
							TimeDifference extra( atoi( fixer[ 0 ] ) * 60 * 60 );
							realduration += extra;
							expamptime[ index ] = realduration;
						}
						else if ( flag == 'd' )
						{
							TimeDifference extra( atoi( fixer[ 0 ] ) * 24 * 60 * 60 );
							realduration += extra;
							expamptime[ index ] = realduration;
						}
						
						g_Game.AlertMessage( at_logged, "[SCXPM] " + aname + " (" + asteamid + ") gave to " + tname + " (" + tsteamid + ") " + "a x" + ( level + 1 ) + " multiplier [" + fixer[ 0 ] + string( flag ) + "].\n" );
						SCXPM_Log( aname + " (" + asteamid + ") gave to " + tname + " (" + tsteamid + ") " + "a x" + ( level + 1 ) + " multiplier [" + fixer[ 0 ] + string( flag ) + "].\n" );
						
						scxpm_savedata( index );
						
						g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTCONSOLE, "[SCXPM] Gave a x" + ( level + 1 ) + " multiplier [" + fixer[ 0 ] + flag + "] to the player.\n" );
						g_PlayerFuncs.ClientPrintAll( HUD_PRINTTALK, "ADMIN " + aname + ": Give x" + ( level + 1 ) + " multiplier to " + tname + ".\n" );
					}
				}
			}
		}
		else
			g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTCONSOLE, "[SCXPM] Player not found.\n" );
	}
	else if ( pArgs.ArgC() == 1 )
		g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTCONSOLE, "[SCXPM] Usage: .xp_giveamp <Name> <Level> <Duration> - Increases a player's XP gain.\n" );
	else
		g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTCONSOLE, "[SCXPM] Not enough parameters.\n" );
}

CClientCommand ADMIN_GIVEPERMA( "xp_givepi", "<Name> <Value> <Title> <Description> - Give an XP Mod to a player.", @scxpm_giveperma, ConCommandFlag::AdminOnly );
void scxpm_giveperma( const CCommand@ pArgs )
{
	CBasePlayer@ pPlayer = g_ConCommandSystem.GetCurrentPlayer();
	
	if ( pArgs.ArgC() >= 5 )
	{
		bool bMultiple = false;
		CBasePlayer@ pTarget = SCXPM_FindPlayer( pArgs[ 1 ], bMultiple );
		
		if ( bMultiple )
			g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTCONSOLE, "[SCXPM] Multiple players found. Be more specific.\n" );
		else if ( pTarget !is null )
		{
			int increase = atoi( pArgs[ 2 ] );
			int index = pTarget.entindex();
			
			if ( increase == 0 )
			{
				g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTCONSOLE, "[SCXPM] Value must be non-zero.\n" );
				return;
			}
			
			string szTitle = pArgs[ 3 ];
			string szDescription = pArgs[ 4 ];
			
			// Ensure we are not giving a duplicate permaincrease
			if ( HasPermaIncrease( index, szTitle ) )
			{
				g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTCONSOLE, "[SCXPM] The player already has that XP Mod.\n" );
				return;
			}
			
			// Formulate the string
			string szData = string( increase ) + ".0" + "#" + szTitle + "#" + szDescription + "!n!n" + ( increase > 0 ? "+" : "" ) + string( increase ) + "% Ganancia de EXP!n" + "\n";
			
			// Give the perma increase
			AddPermaIncrease( index, szData );
			
			// Get now the target's and the admin's name and steamid
			string aname = pPlayer.pev.netname;
			string asteamid = g_EngineFuncs.GetPlayerAuthId( pPlayer.edict() );
			string tname = pTarget.pev.netname;
			string tsteamid = g_EngineFuncs.GetPlayerAuthId( pTarget.edict() );
			
			// Log messages
			g_Game.AlertMessage( at_logged, "[SCXPM] " + aname + " (" + asteamid + ") gave to " + tname + " (" + tsteamid + ") " + "an XP Mod of" + ( increase > 0 ? " +" : " " ) + string( increase ) + "%.\n" );
			SCXPM_Log( aname + " (" + asteamid + ") gave to " + tname + " (" + tsteamid + ") " + "an XP Mod of" + ( increase > 0 ? " +" : " " ) + string( increase ) + "%.\n" );
			
			g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTCONSOLE, "[SCXPM] Gave an XP Mod of" + ( increase > 0 ? " +" : " " ) + string( increase ) + "%% to the player.\n" );
			g_PlayerFuncs.ClientPrintAll( HUD_PRINTTALK, "ADMIN " + aname + ": Give XP Mod to " + tname + ".\n" );
		}
		else
			g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTCONSOLE, "[SCXPM] Player not found.\n" );
	}
	else if ( pArgs.ArgC() == 1 )
		g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTCONSOLE, "[SCXPM] Modo de uso: .xp_givepi <Name> <Value> <Title> <Description> - Give an XP Mod to a player.\n" );
	else
		g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTCONSOLE, "[SCXPM] Not enough parameters.\n" );
}

CClientCommand ADMIN_SETADATA( "xp_setadata", "<Name> <Achievement ID> <Unlock> <Give Reward> - Locks or unlocks an achievement to a player.", @scxpm_setadata, ConCommandFlag::AdminOnly );
void scxpm_setadata( const CCommand@ pArgs )
{
	CBasePlayer@ pPlayer = g_ConCommandSystem.GetCurrentPlayer();
	
	if ( pArgs.ArgC() >= 3 )
	{
		bool bMultiple = false;
		CBasePlayer@ pTarget = SCXPM_FindPlayer( pArgs[ 1 ], bMultiple );
		
		if ( bMultiple )
			g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTCONSOLE, "[SCXPM] Multiple players found. Be more specific.\n" );
		else if ( pTarget !is null )
		{
			int iID = atoi( pArgs[ 2 ] );
			int index = pTarget.entindex();
			
			if ( iID < 0 || iID > int( szAchievementNames.length() ) )
			{
				g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTCONSOLE, "[SCXPM] Invalid achievement ID.\n" );
				return;
			}
			
			if ( pArgs.ArgC() == 3 )
			{
				g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTCONSOLE, "[SCXPM] Selected achievement: " + szAchievementNames[ iID ] + ".\n" );
				
				if ( aData[ index ][ iID ] )
					g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTCONSOLE, "[SCXPM] Player ALREADY HAS the achievement.\n" );
				else
					g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTCONSOLE, "[SCXPM] Player DOES NOT have the achievement.\n" );
				
				return;
			}
			else if ( pArgs.ArgC() >= 5 )
			{
				int iUnlock = atoi( pArgs[ 3 ] );
				int iReward = atoi( pArgs[ 4 ] );
				
				if ( aData[ index ][ iID ] && iUnlock >= 1 )
				{
					g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTCONSOLE, "[SCXPM] That player ALREADY HAS the achievement.\n" );
					return;
				}
				else if ( !aData[ index ][ iID ] && iUnlock <= 0 )
				{
					g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTCONSOLE, "[SCXPM] That player DOES NOT have the acheivement.\n" );
					return;
				}
				
				// Get now the target's and the admin's name and steamid
				string aname = pPlayer.pev.netname;
				string asteamid = g_EngineFuncs.GetPlayerAuthId( pPlayer.edict() );
				string tname = pTarget.pev.netname;
				string tsteamid = g_EngineFuncs.GetPlayerAuthId( pTarget.edict() );
				
				// Lock or unlock?
				if ( iUnlock >= 1 )
				{
					aData[ index ][ iID ] = true;
					
					// Give reward?
					if ( iReward >= 1 ) GiveAchievementReward( index, iID );
					else aClaim[ index ][ iID ] = true;
				}
				else
				{
					aData[ index ][ iID ] = false;
					aClaim[ index ][ iID ] = false;
				}
				
				// Get achievement name on a different string so ToUppercase() does not overwrite the array (it's const btw)
				string szFixedName = szAchievementNames[ iID ];
				szFixedName.ToUppercase();
				
				// Log messages
				g_Game.AlertMessage( at_logged, "[SCXPM] " + aname + " (" + asteamid + ") edited achievement data to " + tname + " (" + tsteamid + ") | " + szFixedName + " [" + ( iUnlock >= 1 ? "UNLOCK" : "LOCK" ) + "]" + "[" + ( iReward >= 1 ? "WITH REWARD" : "WITHOUT REWARD" ) + "].\n" );
				SCXPM_Log( aname + " (" + asteamid + ") edited achievement data to " + tname + " (" + tsteamid + ") | " + szFixedName + " [" + ( iUnlock >= 1 ? "UNLOCK" : "LOCK" ) + "]" + "[" + ( iReward >= 1 ? "WITH REWARD" : "WITHOUT REWARD" ) + "].\n" );
				
				scxpm_saveachievement( index );
				
				g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTCONSOLE, "[SCXPM] Player's achievement data updated\n" );
				
				if ( iUnlock == 1 ) g_PlayerFuncs.ClientPrintAll( HUD_PRINTTALK, "ADMIN " + aname + ": Unlock achievement " + szFixedName + " to " + tname + ".\n" );
				else g_PlayerFuncs.ClientPrintAll( HUD_PRINTTALK, "ADMIN " + aname + ": Lock achievement " + szFixedName + " to " + tname + ".\n" );
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
				
				return;
			}
		}
		else
			g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTCONSOLE, "[SCXPM] Player not found.\n" );
	}
	else if ( pArgs.ArgC() == 1 )
		g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTCONSOLE, "[SCXPM] Usage: .xp_setadata <Name> <Achievement ID> <Unlock> <Give Reward> - Locks or unlocks an achievement to a player.\n" );
	else
		g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTCONSOLE, "[SCXPM] Not enough parameters.\n" );
}

CClientCommand ADMIN_MAPXPGAIN( "xp_set_xpgain", "<Value> - OWNERS ONLY - Changes map's XP gain.", @scxpm_mapxpgain, ConCommandFlag::AdminOnly );
void scxpm_mapxpgain( const CCommand@ pArgs )
{
	CBasePlayer@ pPlayer = g_ConCommandSystem.GetCurrentPlayer();
	
	AdminLevel_t alevel = g_PlayerFuncs.AdminLevel( pPlayer );
	if ( alevel == ADMIN_OWNER )
	{
		if ( pArgs.ArgC() >= 2 )
		{
			float flNewXPGain = atof( pArgs[ 1 ] );
			
			// No negative numbers
			if ( flNewXPGain < 0.00 )
			{
				g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTCONSOLE, "[SCXPM] New XP gain must be greater or equal than x0.00.\n" );
				return;
			}
		
			// Prevent division by zero caused by the discard of long floats ( 6+ digits )
			if ( flNewXPGain == 0.00 ) flNewXPGain = XP_DISABLED;
			
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
	else
		g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTCONSOLE, "[SCXPM] Access denied.\n" );
}

void scxpm_calcneedxp( const int& in index )
{
	float m70 = float( playerlevel[ index ] ) * 70.0;
	float mselfm3dot2 = float( playerlevel[ index ] ) * float( playerlevel[ index ] ) * 3.5;
	neededxp[ index ] = floatround( m70 + mselfm3dot2 + 30.0 );
}

int scxpm_calc_lvl( const int& in xp )
{
	return floatround( -10.0 + sqrt( 100.0 - ( 60.0 / 7.0 - ( ( float( xp ) + 1.0 ) / 3.5 ) ) ), floatround_ceil );
}

int scxpm_calc_xp( int& in level )
{
	level--;
	return floatround( ( float( level ) * 70.0 ) + ( float( level ) * float( level ) * 3.5 ) + 30.0 );
}

float scxpm_calc_xpgain( const int& in index )
{
	float exp = SCXPM_BASEXP;
	
	exp = exp * ( MAP_XPGAIN * ( expamp[ index ] + 1 ) );
	
	float hTotal = 0.0;
	if ( handicap1[ index ] ) hTotal += 15.00;
	if ( handicap2[ index ] ) hTotal += 18.00;
	if ( handicap3[ index ] ) hTotal += 9.00;
	if ( handicap4[ index ] ) hTotal += 12.00;
	if ( handicap5[ index ] ) hTotal += 15.00;
	if ( handicap6[ index ] ) hTotal += 12.00;
	if ( handicap7[ index ] ) hTotal += 12.00;
	if ( handicap8[ index ] ) hTotal += 9.00;
	if ( handicap9[ index ] ) hTotal += 15.00;
	if ( handicap10[ index ] ) hTotal += 18.00;
	if ( handicap11[ index ] ) hTotal += 12.00;
	if ( handicap12[ index ] ) hTotal += 21.00;
	if ( handicap13[ index ] ) hTotal += 9.00;
	if ( handicap14[ index ] ) hTotal += 12.00;
	
	hTotal += permaincrease[ index ];
	
	// Increase XPGain based on medals
	hTotal += 3.00 * Math.clamp( 0, 30, medals[ index ] );
	
	exp = exp * ( 100.0 + hTotal ) / 100.0;
	
	// Prevent division by zero caused by the discard of long floats ( 6+ digits )
	if ( exp <= 0.00 ) exp = XP_DISABLED;
	
	return exp;
}

void scxpm_getrank( const int& in index )
{
	int rid;
	int pl = playerlevel[ index ];
	
	/* The "if-else if" nest of hell */
	
	// Max level
	if ( pl >= 3000 )
	{
		rid = 61;
	}
	// All levels/medals get
	else if ( pl >= 700 && medals[ index ] >= 30 )
	{
		rid = 60;
	}
	// Normal classes
	else
	{
		if ( pl >= 689 ) rid = 59;
		else if ( pl >= 674 ) rid = 58;
		else if ( pl >= 659 ) rid = 57;
		else if ( pl >= 644 ) rid = 56;
		else if ( pl >= 629 ) rid = 55;
		else if ( pl >= 614 ) rid = 54;
		else if ( pl >= 599 ) rid = 53;
		else if ( pl >= 584 ) rid = 52;
		else if ( pl >= 569 ) rid = 51;
		else if ( pl >= 554 ) rid = 50;
		else if ( pl >= 539 ) rid = 49;
		else if ( pl >= 524 ) rid = 48;
		else if ( pl >= 509 ) rid = 47;
		else if ( pl >= 494 ) rid = 46;
		else if ( pl >= 479 ) rid = 45;
		else if ( pl >= 464 ) rid = 44;
		else if ( pl >= 449 ) rid = 43;
		else if ( pl >= 434 ) rid = 42;
		else if ( pl >= 419 ) rid = 41;
		else if ( pl >= 404 ) rid = 40;
		else if ( pl >= 389 ) rid = 39;
		else if ( pl >= 374 ) rid = 38;
		else if ( pl >= 359 ) rid = 37;
		else if ( pl >= 334 ) rid = 36;
		else if ( pl >= 329 ) rid = 35;
		else if ( pl >= 314 ) rid = 34;
		else if ( pl >= 299 ) rid = 33;
		else if ( pl >= 284 ) rid = 32;
		else if ( pl >= 269 ) rid = 31;
		else if ( pl >= 254 ) rid = 30;
		else if ( pl >= 239 ) rid = 29;
		else if ( pl >= 224 ) rid = 28;
		else if ( pl >= 209 ) rid = 27;
		else if ( pl >= 195 ) rid = 26;
		else if ( pl >= 181 ) rid = 25;
		else if ( pl >= 168 ) rid = 24;
		else if ( pl >= 155 ) rid = 23;
		else if ( pl >= 143 ) rid = 22;
		else if ( pl >= 131 ) rid = 21;
		else if ( pl >= 120 ) rid = 20;
		else if ( pl >= 109 ) rid = 19;
		else if ( pl >= 99 ) rid = 18;
		else if ( pl >= 89 ) rid = 17;
		else if ( pl >= 80 ) rid = 16;
		else if ( pl >= 71 ) rid = 15;
		else if ( pl >= 63 ) rid = 14;
		else if ( pl >= 55 ) rid = 13;
		else if ( pl >= 48 ) rid = 12;
		else if ( pl >= 41 ) rid = 11;
		else if ( pl >= 35 ) rid = 10;
		else if ( pl >= 29 ) rid = 9;
		else if ( pl >= 24 ) rid = 8;
		else if ( pl >= 19 ) rid = 7;
		else if ( pl >= 15 ) rid = 6;
		else if ( pl >= 11 ) rid = 5;
		else if ( pl >= 8 ) rid = 4;
		else if ( pl >= 5 ) rid = 3;
		else if ( pl >= 3 ) rid = 2;
		else if ( pl >= 1 ) rid = 1;
		else rid = 0;
	}
	
	rank[ index ] = rid;
}

void scxpm_mreset( const int& in index )
{
	health[ index ] = 0;
	armor[ index ] = 0;
	rhealth[ index ] = 0;
	rarmor[ index ] = 0;
	rammo[ index ] = 0;
	gravity[ index ] = 0;
	speed[ index ] = 0;
	dist[ index ] = 0;
	dodge[ index ] = 0;
	
	skillpoints[ index ] = Math.clamp( 0, 700, playerlevel[ index ] );
	
	if ( ( bData[ index ] & SS_DISPENCER ) != 0 )
		bData[ index ] &= ~SS_DISPENCER;
	if ( ( bData[ index ] & SS_RANGEHEAL ) != 0 )
		bData[ index ] &= ~SS_RANGEHEAL;
	
	spawndmg[ index ] = 0;
	ubercharge[ index ] = 0;
	fastheal[ index ] = 0;
	demoman[ index ] = 0;
	practiceshot[ index ] = 0;
	bioelectric[ index ] = 0;
	redcross[ index ] = 0;
	
	handicap1[ index ] = false;
	handicap2[ index ] = false;
	handicap3[ index ] = false;
	handicap4[ index ] = false;
	handicap5[ index ] = false;
	handicap6[ index ] = false;
	handicap7[ index ] = false;
	handicap8[ index ] = false;
	handicap9[ index ] = false;
	handicap10[ index ] = false;
	handicap11[ index ] = false;
	handicap12[ index ] = false;
	handicap13[ index ] = false;
	handicap14[ index ] = false;
}

void scxpm_sdac()
{
	if ( gDisabled )
		return;
	
	if ( !onecount )
		onecount = true;
	else
	{
		scxpm_showdata();
		scxpm_reexp();
		onecount = false;
	}
	scxpm_regen();
	scxpm_updatehc();
	
	// Scan dropped weapons and check if it's clips are empty
	// Ugh, I hate doing unefficient and unoptimized stuff.
	CBaseEntity@ pEntity = null;
	while ( ( @pEntity = g_EntityFuncs.FindEntityByClassname( pEntity, "weapon_*" ) ) !is null )
	{
		CBasePlayerWeapon@ pWeapon = cast< CBasePlayerWeapon@ >( pEntity );
		if ( pWeapon !is null )
		{
			CBaseEntity@ pOwner = g_EntityFuncs.Instance( pWeapon.pev.owner );
			if ( pOwner !is null )
			{
				// Owner must be a player! Otherwise weapons that appear mid-map from squadmakers will be affected
				if ( pOwner.IsPlayer() )
				{
					// Mark the weapon if it's empty
					if ( pWeapon.m_iClip == 0 )
						pWeapon.KeyValue( "$i_clip_empty", "1" );
				}
			}
		}
	}
}

HookReturnCode WeaponPickUp( CBaseEntity@ pItem, CBaseEntity@ pPlayer )
{
	CustomKeyvalues@ pKeyValue = pItem.GetCustomKeyvalues();
	CustomKeyvalue iEmpty_pre( pKeyValue.GetKeyvalue( "$i_clip_empty" ) );
	int iEmpty = iEmpty_pre.GetInteger();
	if ( iEmpty == 1 )
	{
		// Keep the weapon empty!
		CBasePlayerWeapon@ pWeapon = cast< CBasePlayerWeapon@ >( pItem );
		if ( pWeapon !is null )
		{
			// BUG - This cannot fix the dual uzis!
			pWeapon.m_iClip = 0;
		}
	}
	
	return HOOK_CONTINUE;
}

void scxpm_block_handicaps()
{
	can_edit_handicaps = false;
	bSaveOldSkills = true;
}

void scxpm_handicaps( const int& in index, const int& in iPage = 0 )
{
	CBasePlayer@ pPlayer = g_PlayerFuncs.FindPlayerByIndex( index );
	
	if ( gNoSkills && !gAllowHandicaps )
	{
		g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "[SCXPM] Handicaps are disabled on this map.\n" );
		return;
	}
	
	MenuHandler@ state = MenuGetPlayer( pPlayer );
	
	state.InitMenu( pPlayer, scxpm_handicaps_cb );
	
	int percent = 0;
	if ( handicap1[ index ] ) percent += 15;
	if ( handicap2[ index ] ) percent += 18;
	if ( handicap3[ index ] ) percent += 9;
	if ( handicap4[ index ] ) percent += 12;
	if ( handicap5[ index ] ) percent += 15;
	if ( handicap6[ index ] ) percent += 12;
	if ( handicap7[ index ] ) percent += 12;
	if ( handicap8[ index ] ) percent += 9;
	if ( handicap9[ index ] ) percent += 15;
	if ( handicap10[ index ] ) percent += 18;
	if ( handicap11[ index ] ) percent += 12;
	if ( handicap12[ index ] ) percent += 21;
	if ( handicap13[ index ] ) percent += 9;
	if ( handicap14[ index ] ) percent += 12;
	
	string title = "Handicaps\n\n\n" + "+" + percent + "% XP gain";
	
	state.menu.SetTitle( title );
	
	string autosave = "Remember selection? ";
	if ( ( bData[ index ] & HC_AUTOSELECT ) != 0 )
		autosave += "[ YES ]\n\n";
	else
		autosave += "[ NO ]\n\n";
	
	string hc1text = "Medical Phobia ";
	if ( handicap1[ index ] )
		hc1text += "[ YES ]\n";
	else
		hc1text += "[ NO ]\n";
	
	string hc2text = "Obsolete Technology ";
	if ( handicap2[ index ] )
		hc2text += "[ YES ]\n";
	else
		hc2text += "[ NO ]\n";
	
	string hc3text = "Nitrogen Blood ";
	if ( handicap3[ index ] )
		hc3text += "[ YES ]\n";
	else
		hc3text += "[ NO ]\n";
	
	string hc4text = "Karmic Retribution ";
	if ( handicap4[ index ] )
		hc4text += "[ YES ]\n";
	else
		hc4text += "[ NO ]\n";
	
	string hc5text = "Realism ";
	if ( handicap5[ index ] )
		hc5text += "[ YES ]\n";
	else
		hc5text += "[ NO ]\n";
	
	string hc6text = "Big Explosion ";
	if ( handicap6[ index ] )
		hc6text += "[ YES ]\n";
	else
		hc6text += "[ NO ]\n";
	
	string hc7text = "Limited Equipment ";
	if ( handicap7[ index ] )
		hc7text += "[ YES ]\n";
	else
		hc7text += "[ NO ]\n";
	
	string hc8text = "Dead Weight ";
	if ( handicap8[ index ] )
		hc8text += "[ YES ]\n";
	else
		hc8text += "[ NO ]\n";
	
	string hc9text = "Lacking Help ";
	if ( handicap9[ index ] )
		hc9text += "[ YES ]\n";
	else
		hc9text += "[ NO ]\n";
	
	string hc10text = "Friendly Fire ";
	if ( handicap10[ index ] )
		hc10text += "[ YES ]\n";
	else
		hc10text += "[ NO ]\n";
	
	string hc11text = "Lost Bullets ";
	if ( handicap11[ index ] )
		hc11text += "[ YES ]\n";
	else
		hc11text += "[ NO ]\n";
	
	string hc12text = "Weak Restart ";
	if ( handicap12[ index ] )
		hc12text += "[ YES ]\n";
	else
		hc12text += "[ NO ]\n";
	
	string hc13text = "Dangerous Waters ";
	if ( handicap13[ index ] )
		hc13text += "[ YES ]\n";
	else
		hc13text += "[ NO ]\n";
	
	string hc14text = "Bleeding View ";
	if ( handicap14[ index ] )
		hc14text += "[ YES ]\n";
	else
		hc14text += "[ NO ]\n";
	
	state.menu.AddItem( autosave, any( "item0" ) );
	state.menu.AddItem( hc1text, any( "item1" ) );
	state.menu.AddItem( hc2text, any( "item2" ) );
	state.menu.AddItem( hc3text, any( "item3" ) );
	state.menu.AddItem( hc4text, any( "item4" ) );
	state.menu.AddItem( hc5text, any( "item5" ) );
	state.menu.AddItem( hc6text, any( "item6" ) );
	state.menu.AddItem( hc7text, any( "item7" ) );
	state.menu.AddItem( hc8text, any( "item8" ) );
	state.menu.AddItem( hc9text, any( "item9" ) );
	state.menu.AddItem( hc10text, any( "item10" ) );
	state.menu.AddItem( hc11text, any( "item11" ) );
	state.menu.AddItem( hc12text, any( "item12" ) );
	state.menu.AddItem( hc13text, any( "item13" ) );
	state.menu.AddItem( hc14text, any( "item14" ) );
	
	state.OpenMenu( pPlayer, 0, iPage );
}

void scxpm_handicaps_cb( CTextMenu@ menu, CBasePlayer@ pPlayer, int page, const CTextMenuItem@ item )
{
	int index = pPlayer.entindex();
	if ( page == 10 ) return;
	
	CustomKeyvalues@ pHandicaps = pPlayer.GetCustomKeyvalues();
	
	string selection;
	item.m_pUserData.retrieve( selection );
	if ( selection == 'item0' )
	{
		// Toggle autoselect
		bData[ index ] ^= HC_AUTOSELECT;
		g_Scheduler.SetTimeout( "scxpm_handicaps", 0.01, index, 0 );
	}
	else if ( selection == 'item1' )
	{
		if ( !handicap1[ index ] )
		{
			if ( !can_edit_handicaps )
			{
				// Err... repeating this text x14 times...?
				g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "[SCXPM] Handicaps can only be enabled at map start.\n" );
				g_Scheduler.SetTimeout( "scxpm_handicaps", 0.01, index, 0 );
				return;
			}
			
			bHandicaps[ index ] += 1;
			handicap1[ index ] = true;
			pHandicaps.SetKeyvalue( "$i_handicap01", 1 );
		}
		else
		{
			bHandicaps[ index ] -= 1;
			handicap1[ index ] = false;
			pHandicaps.SetKeyvalue( "$i_handicap01", 0 );
		}
		g_Scheduler.SetTimeout( "scxpm_handicaps", 0.01, index, 0 );
	}
	else if ( selection == 'item2' )
	{
		if ( !handicap2[ index ] )
		{
			if ( !can_edit_handicaps )
			{
				g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "[SCXPM] Handicaps can only be enabled at map start.\n" );
				g_Scheduler.SetTimeout( "scxpm_handicaps", 0.01, index, 0 );
				return;
			}
			
			bHandicaps[ index ] += 2;
			handicap2[ index ] = true;
			pHandicaps.SetKeyvalue( "$i_handicap02", 1 );
		}
		else
		{
			bHandicaps[ index ] -= 2;
			handicap2[ index ] = false;
			pHandicaps.SetKeyvalue( "$i_handicap02", 0 );
		}
		g_Scheduler.SetTimeout( "scxpm_handicaps", 0.01, index, 0 );
	}
	else if ( selection == 'item3' )
	{
		if ( !handicap3[ index ] )
		{
			if ( !can_edit_handicaps )
			{
				g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "[SCXPM] Handicaps can only be enabled at map start.\n" );
				g_Scheduler.SetTimeout( "scxpm_handicaps", 0.01, index, 0 );
				return;
			}
			
			bHandicaps[ index ] += 4;
			handicap3[ index ] = true;
			pHandicaps.SetKeyvalue( "$i_handicap03", 1 );
		}
		else
		{
			bHandicaps[ index ] -= 4;
			handicap3[ index ] = false;
			pHandicaps.SetKeyvalue( "$i_handicap03", 0 );
		}
		g_Scheduler.SetTimeout( "scxpm_handicaps", 0.01, index, 0 );
	}
	else if ( selection == 'item4' )
	{
		if ( !handicap4[ index ] )
		{
			if ( !can_edit_handicaps )
			{
				g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "[SCXPM] Handicaps can only be enabled at map start.\n" );
				g_Scheduler.SetTimeout( "scxpm_handicaps", 0.01, index, 0 );
				return;
			}
			
			bHandicaps[ index ] += 8;
			handicap4[ index ] = true;
			pHandicaps.SetKeyvalue( "$i_handicap04", 1 );
		}
		else
		{
			bHandicaps[ index ] -= 8;
			handicap4[ index ] = false;
			pHandicaps.SetKeyvalue( "$i_handicap04", 0 );
		}
		g_Scheduler.SetTimeout( "scxpm_handicaps", 0.01, index, 0 );
	}
	else if ( selection == 'item5' )
	{
		if ( !handicap5[ index ] )
		{
			if ( !can_edit_handicaps )
			{
				g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "[SCXPM] Handicaps can only be enabled at map start.\n" );
				g_Scheduler.SetTimeout( "scxpm_handicaps", 0.01, index, 0 );
				return;
			}
			
			bHandicaps[ index ] += 16;
			handicap5[ index ] = true;
			pHandicaps.SetKeyvalue( "$i_handicap05", 1 );
		}
		else
		{
			bHandicaps[ index ] -= 16;
			handicap5[ index ] = false;
			pHandicaps.SetKeyvalue( "$i_handicap05", 0 );
		}
		g_Scheduler.SetTimeout( "scxpm_handicaps", 0.01, index, 0 );
	}
	else if ( selection == 'item6' )
	{
		if ( !handicap6[ index ] )
		{
			if ( !can_edit_handicaps )
			{
				g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "[SCXPM] Handicaps can only be enabled at map start.\n" );
				g_Scheduler.SetTimeout( "scxpm_handicaps", 0.01, index, 0 );
				return;
			}
			
			bHandicaps[ index ] += 32;
			handicap6[ index ] = true;
			pHandicaps.SetKeyvalue( "$i_handicap06", 1 );
		}
		else
		{
			bHandicaps[ index ] -= 32;
			handicap6[ index ] = false;
			pHandicaps.SetKeyvalue( "$i_handicap06", 0 );
		}
		g_Scheduler.SetTimeout( "scxpm_handicaps", 0.01, index, 0 );
	}
	else if ( selection == 'item7' )
	{
		if ( !handicap7[ index ] )
		{
			if ( !can_edit_handicaps )
			{
				g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "[SCXPM] Handicaps can only be enabled at map start.\n" );
				g_Scheduler.SetTimeout( "scxpm_handicaps", 0.01, index, 1 );
				return;
			}
			
			bHandicaps[ index ] += 64;
			handicap7[ index ] = true;
			pHandicaps.SetKeyvalue( "$i_handicap07", 1 );
		}
		else
		{
			bHandicaps[ index ] -= 64;
			handicap7[ index ] = false;
			pHandicaps.SetKeyvalue( "$i_handicap07", 0 );
		}
		g_Scheduler.SetTimeout( "scxpm_handicaps", 0.01, index, 1 );
	}
	else if ( selection == 'item8' )
	{
		if ( !handicap8[ index ] )
		{
			if ( !can_edit_handicaps )
			{
				g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "[SCXPM] Handicaps can only be enabled at map start.\n" );
				g_Scheduler.SetTimeout( "scxpm_handicaps", 0.01, index, 1 );
				return;
			}
			
			bHandicaps[ index ] += 128;
			handicap8[ index ] = true;
			pHandicaps.SetKeyvalue( "$i_handicap08", 1 );
		}
		else
		{
			bHandicaps[ index ] -= 128;
			handicap8[ index ] = false;
			pHandicaps.SetKeyvalue( "$i_handicap08", 0 );
		}
		g_Scheduler.SetTimeout( "scxpm_handicaps", 0.01, index, 1 );
	}
	else if ( selection == 'item9' )
	{
		if ( !handicap9[ index ] )
		{
			if ( !can_edit_handicaps )
			{
				g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "[SCXPM] Handicaps can only be enabled at map start.\n" );
				g_Scheduler.SetTimeout( "scxpm_handicaps", 0.01, index, 1 );
				return;
			}
			
			bHandicaps[ index ] += 256;
			handicap9[ index ] = true;
			pHandicaps.SetKeyvalue( "$i_handicap09", 1 );
		}
		else
		{
			bHandicaps[ index ] -= 256;
			handicap9[ index ] = false;
			pHandicaps.SetKeyvalue( "$i_handicap09", 0 );
		}
		g_Scheduler.SetTimeout( "scxpm_handicaps", 0.01, index, 1 );
	}
	else if ( selection == 'item10' )
	{
		if ( !handicap10[ index ] )
		{
			if ( !can_edit_handicaps )
			{
				g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "[SCXPM] Handicaps can only be enabled at map start.\n" );
				g_Scheduler.SetTimeout( "scxpm_handicaps", 0.01, index, 1 );
				return;
			}
			
			bHandicaps[ index ] += 512;
			handicap10[ index ] = true;
			pHandicaps.SetKeyvalue( "$i_handicap10", 1 );
		}
		else
		{
			bHandicaps[ index ] -= 512;
			handicap10[ index ] = false;
			pHandicaps.SetKeyvalue( "$i_handicap10", 0 );
		}
		g_Scheduler.SetTimeout( "scxpm_handicaps", 0.01, index, 1 );
	}
	else if ( selection == 'item11' )
	{
		if ( !handicap11[ index ] )
		{
			if ( !can_edit_handicaps )
			{
				g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "[SCXPM] Handicaps can only be enabled at map start.\n" );
				g_Scheduler.SetTimeout( "scxpm_handicaps", 0.01, index, 1 );
				return;
			}
			
			bHandicaps[ index ] += 1024;
			handicap11[ index ] = true;
			pHandicaps.SetKeyvalue( "$i_handicap11", 1 );
		}
		else
		{
			bHandicaps[ index ] -= 1024;
			handicap11[ index ] = false;
			pHandicaps.SetKeyvalue( "$i_handicap11", 0 );
			
			// Restore ammo capacity
			pPlayer.SetMaxAmmo( AMMO_9MM, 250 );
			pPlayer.SetMaxAmmo( AMMO_357, 36 );
			pPlayer.SetMaxAmmo( AMMO_SHOTGUN, 125 );
			pPlayer.SetMaxAmmo( AMMO_CROSSBOW, 50 );
			pPlayer.SetMaxAmmo( AMMO_SAW, 600 );
			pPlayer.SetMaxAmmo( AMMO_M16GRENADE, 10 );
			pPlayer.SetMaxAmmo( AMMO_RPG, 5 );
			pPlayer.SetMaxAmmo( AMMO_GAUSS, 100 );
			pPlayer.SetMaxAmmo( AMMO_SNIPER, 15 );
			pPlayer.SetMaxAmmo( AMMO_SPORE, 30 );
		}
		g_Scheduler.SetTimeout( "scxpm_handicaps", 0.01, index, 1 );
	}
	else if ( selection == 'item12' )
	{
		if ( !handicap12[ index ] )
		{
			if ( !can_edit_handicaps )
			{
				g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "[SCXPM] Handicaps can only be enabled at map start.\n" );
				g_Scheduler.SetTimeout( "scxpm_handicaps", 0.01, index, 1 );
				return;
			}
			
			bHandicaps[ index ] += 2048;
			handicap12[ index ] = true;
			pHandicaps.SetKeyvalue( "$i_handicap12", 1 );
		}
		else
		{
			bHandicaps[ index ] -= 2048;
			handicap12[ index ] = false;
			pHandicaps.SetKeyvalue( "$i_handicap12", 0 );
		}
		g_Scheduler.SetTimeout( "scxpm_handicaps", 0.01, index, 1 );
	}
	else if ( selection == 'item13' )
	{
		if ( !handicap13[ index ] )
		{
			if ( !can_edit_handicaps )
			{
				g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "[SCXPM] Handicaps can only be enabled at map start.\n" );
				g_Scheduler.SetTimeout( "scxpm_handicaps", 0.01, index, 1 );
				return;
			}
			
			bHandicaps[ index ] += 4096;
			handicap13[ index ] = true;
			pHandicaps.SetKeyvalue( "$i_handicap13", 1 );
		}
		else
		{
			bHandicaps[ index ] -= 4096;
			handicap13[ index ] = false;
			pHandicaps.SetKeyvalue( "$i_handicap13", 0 );
		}
		g_Scheduler.SetTimeout( "scxpm_handicaps", 0.01, index, 1 );
	}
	else if ( selection == 'item14' )
	{
		if ( !handicap14[ index ] )
		{
			if ( !can_edit_handicaps )
			{
				g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "[SCXPM] Handicaps can only be enabled at map start.\n" );
				g_Scheduler.SetTimeout( "scxpm_handicaps", 0.01, index, 2 );
				return;
			}
			
			bHandicaps[ index ] += 8192;
			handicap14[ index ] = true;
			pHandicaps.SetKeyvalue( "$i_handicap14", 1 );
		}
		else
		{
			g_PlayerFuncs.ConcussionEffect( pPlayer, 0.0, 0.0, 0.0 ); // Turn off
			bHandicaps[ index ] -= 8192;
			handicap14[ index ] = false;
			pHandicaps.SetKeyvalue( "$i_handicap14", 0 );
		}
		g_Scheduler.SetTimeout( "scxpm_handicaps", 0.01, index, 2 );
	}
}

void scxpm_reexp()
{
	for ( int i = 1; i <= g_Engine.maxClients; i++ )
	{
		CBasePlayer@ pPlayer = g_PlayerFuncs.FindPlayerByIndex( i );
		
		if ( pPlayer !is null && pPlayer.IsConnected() )
		{
			// Gather any event XP
			AddEventEXP( i );
			
			float exp = scxpm_calc_xpgain( i );
			
			if ( !gDelayedXP )
			{
				// Stop caring if max was reached
				if ( playerlevel[ i ] != 3000 )
				{
					float normalvar = float( xp[ i ] ) / 5.0 / ( exp * ( expamp[ i ] + 1 ) ) + pPlayer.pev.frags - lastfrags[ i ];
					xp[ i ] = floatround( normalvar * 5.0 * ( exp * ( expamp[ i ] + 1 ) ) );
				}
			}
			
			float earnvar = float( earnedxp[ i ] ) / 5.0 / ( exp * ( expamp[ i ] + 1 ) ) + pPlayer.pev.frags - lastfrags[ i ];
			earnedxp[ i ] = floatround( earnvar * 5.0 * ( exp * ( expamp[ i ] + 1 ) ) );
			
			scxpm_savedata( i );
			scxpm_saveachievement( i );
			scxpm_checkachievement( i );
			lastfrags[ i ] = pPlayer.pev.frags;
			
			if ( xp[ i ] > neededxp[ i ] )
			{
				int playerlevelOld = playerlevel[ i ];
				int playerlevelNew = scxpm_calc_lvl( xp[ i ] );
				playerlevel[ i ] = scxpm_calc_lvl( xp[ i ] );
				
				// No more skillpoints should be given beyond this level
				if ( playerlevelNew > 700 ) playerlevelNew = 700;
				
				skillpoints[ i ] += Math.clamp( 0, 700, playerlevelNew - playerlevelOld );
				
				if ( skillpoints[ i ] >= playerlevelNew + 1 )
					skillpoints[ i ]--;
				
				scxpm_calcneedxp( i );
				
				string name = pPlayer.pev.netname;
				string steamid = g_EngineFuncs.GetPlayerAuthId( pPlayer.edict() );
				if ( playerlevel[ i ] >= 700 && medals[ i ] >= 30 && !HasPermaIncrease( i, "Champion" ) )
				{
					g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTCENTER, "Congratulations, champion!\n" );
					
					g_SoundSystem.EmitSoundDyn( pPlayer.edict(), CHAN_STREAM, "ambience/goal_1.wav", VOL_NORM, ATTN_NONE, SND_SKIP_ORIGIN_USE_ENT, PITCH_NORM, i );
					
					g_Game.AlertMessage( at_logged, "[SCXPM] " + name + " (" + steamid + ") was crowned Champion.\n" );
					SCXPM_Log( name + " (" + steamid + ") was crowned Champion.\n" );
					
					g_PlayerFuncs.ClientPrintAll( HUD_PRINTTALK, "[SCXPM] WE HAVE A NEW CHAMPION! Hail " + name + ", a new welder of the crown!!\n" );
					
					string szMessage = "";
					szMessage += "This played managed to overcome all obstacles,";
					szMessage += "!nchallenges, and frustrations since the very";
					szMessage += "!nstart of its carrer.!n!n";
					szMessage += "But above all, determination in the ultimate";
					szMessage += "!ntask of completing and accumulating every";
					szMessage += "!nsingle level and medal of the system.!n!n";
					szMessage += "A player, whose goals are always expanding.";
					szMessage += "!nA player, that doesn't let any barriers stop it.";
					szMessage += "!n!nTHE player, a champion of our world.";
					
					AddPermaIncrease( i, "0.0#Champion#" + szMessage + "!n!nHONORIFIC MENTION!n\n" );
					
					g_Scheduler.SetTimeout( "scxpm_champion_welcome", 0.02, i );
				}
				else
				{
					g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "[SCXPM] Good job, " + name + "! You reached level " + AddCommas( playerlevel[ i ] ) + "!\n" );
					g_Game.AlertMessage( at_logged, "[SCXPM] " + name + " (" + steamid + ") reached level " + AddCommas( playerlevel[ i ] ) + ".\n" );
					SCXPM_Log( name + " (" + steamid + ") reached level " + AddCommas( playerlevel[ i ] ) + ".\n" );
					
					// Level goal rewards
					if ( playerlevel[ i ] >= 3000 && !HasPermaIncrease( i, "XP Devourer" ) )
					{
						string szMessage = "";
						szMessage += "This player has remained in the unwavering";
						szMessage += "!nand never ending search of becoming a";
						szMessage += "!nsuperior being. And has succeeded.!n!n";
						szMessage += "Hail Poppo.";
						
						AddPermaIncrease( i, "0.0#XP Devourer#" + szMessage + "!n!nHONORIFIC MENTION!n\n" );
					}
					else if ( playerlevel[ i ] >= 700 && !HasPermaIncrease( i, "Determination V" ) )
						AddPermaIncrease( i, "7.0#Determination V#Reached level 700!n!n+7% XP gain!n\n" );
					else if ( playerlevel[ i ] >= 600 && !HasPermaIncrease( i, "Determination IV" ) )
						AddPermaIncrease( i, "10.0#Determination IV#Reached level 600!n!n+10% XP gain!n\n" );
					else if ( playerlevel[ i ] >= 450 && !HasPermaIncrease( i, "Determination III" ) )
						AddPermaIncrease( i, "10.0#Determination III#Reached level 450!n!n+10% XP gain!n\n" );
					else if ( playerlevel[ i ] >= 300 && !HasPermaIncrease( i, "Determination II" ) )
						AddPermaIncrease( i, "10.0#Determination II#Reached level 300!n!n+10% XP gain!n\n" );
					else if ( playerlevel[ i ] >= 150 && !HasPermaIncrease( i, "Determination I" ) )
						AddPermaIncrease( i, "10.0#Determination I#Reached level 150!n!n+10% XP gain!n\n" );
				}
				
				g_SoundSystem.EmitSoundDyn( pPlayer.edict(), CHAN_STATIC, "isc/scxpm/levelup.ogg", VOL_NORM, ATTN_NONE, SND_SKIP_ORIGIN_USE_ENT, PITCH_NORM, i );
				
				scxpm_getrank( i );
				
				if ( skillpoints[ i ] >= 1 )
					SCXPMSkill( i );
			}
		}
	}
}

void scxpm_checkachievement( const int& in index )
{
	// Achievements cannot be unlocked on this map
	if ( gNoAchievements )
		return;
	
	CBasePlayer@ pPlayer = g_PlayerFuncs.FindPlayerByIndex( index );
	string name = pPlayer.pev.netname;
	string steamid = g_EngineFuncs.GetPlayerAuthId( pPlayer.edict() );
	
	CustomKeyvalues@ pKeyValue = pPlayer.GetCustomKeyvalues();
	CustomKeyvalue iUnlock_pre( pKeyValue.GetKeyvalue( "$i_a_unlock" ) );
	int iUnlock = ( iUnlock_pre.GetInteger() ) - 1; // Achievement IDs are zero indexed, but the keyvalue storing who to unlock is not
	
	// No achievement to unlock
	if ( iUnlock == -1 )
		return;
	
	// We can only unlock THIS specific achievement on this map
	if ( gSingleAchievement && iUnlock != iAAllowed )
		return;
	
	// Only unlock if the player does NOT have the achievement
	if ( !aData[ index ][ iUnlock ] )
	{
		// Unlock!
		aData[ index ][ iUnlock ] = true;
		GiveAchievementReward( index, iUnlock );
		
		// Check for total unlocked achievements, give special reward if criteria is met
		int iNewUnlocks = GetAchievementClear( index );
		switch( iNewUnlocks )
		{
			case 35: if ( !HasPermaIncrease( index, "Just Cause" ) ) AddPermaIncrease( index, "15.0#Just Cause#35 achievements unlocked!n!n+15% XP gain!n\n" ); break;
			case 65: if ( !HasPermaIncrease( index, "Bounty Hunter" ) ) AddPermaIncrease( index, "15.0#Bounty Hunter#65 achievements unlocked!n!n+15% XP gain!n\n" ); break;
			case 100: if ( !HasPermaIncrease( index, "Maximum Dedication" ) ) AddPermaIncrease( index, "15.0#Maximum Dedication#100 achievements unlocked!n!n+15% XP gain!n\n" ); break;
			case 135: if ( !HasPermaIncrease( index, "Journalist" ) ) AddPermaIncrease( index, "15.0#Journalist#135 achievements unlocked!n!n+15% XP gain!n\n" ); break;
			case 165: if ( !HasPermaIncrease( index, "Map Burner" ) ) AddPermaIncrease( index, "15.0#Map Burner#165 achievements unlocked!n!n+15% XP gain!n\n" ); break;
			case 200: if ( !HasPermaIncrease( index, "Obsessive Completionist" ) ) AddPermaIncrease( index, "15.0#Obsessive Completionist#200 achievements unlocked!n!n+15% XP gain!n\n" ); break;
		}
		
		// Get achievement name on a different string so ToUppercase() does not overwrite the array (it's const btw)
		string szFixedName = szAchievementNames[ iUnlock ];
		szFixedName.ToUppercase();
		
		// Notify achievement unlock to all players
		g_PlayerFuncs.ClientPrintAll( HUD_PRINTTALK, "[SCXPM] " + name + " has earned the achievement " + szFixedName + ".\n" );
		g_Game.AlertMessage( at_logged, "[SCXPM] " + name + " (" + steamid + ") has earned the achievement " + szFixedName + ".\n" );
		SCXPM_Log( name + " (" + steamid + ") has earned the achievement " + szFixedName + ".\n" );
		
		// Put a sound (and a center print) to the player to let it know in case it cannot read the message
		g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTCENTER, "Achievement Unlocked!\n\n" + szFixedName + "\n" );
		g_SoundSystem.EmitSoundDyn( pPlayer.edict(), CHAN_STATIC, "isc/scxpm/achievement.ogg", VOL_NORM, ATTN_NONE, SND_SKIP_ORIGIN_USE_ENT, PITCH_NORM, index );
	}
	
	// ALWAYS RESET TO ZERO
	pKeyValue.SetKeyvalue( "$i_a_unlock", 0 );
}

void scxpm_amptask()
{
	for ( int i = 1; i <= g_Engine.maxClients; i++ )
	{
		CBasePlayer@ pPlayer = g_PlayerFuncs.FindPlayerByIndex( i );
		
		if ( pPlayer !is null && pPlayer.IsConnected() )
		{
			DateTime currenttime( UnixTimestamp() );
			DateTime expiretime( expamptime[ i ] );
			TimeDifference check( expiretime, currenttime );
			
			if ( !check.IsPositive() )
			{
				expamp[ i ] = 0;
				expamptime[ i ] = 0;
			}
		}
	}
}

// Performs conversion of multiplier/time for a player that already has an amplifier
void CheckConvertAmp( const int& in index, int& in iNewLevel, int& in iNewTime )
{
	CBasePlayer@ pPlayer = g_PlayerFuncs.FindPlayerByIndex( index );
	
	// New level to give is equal to player's level. Extend time 1:1
	if ( iNewLevel == expamp[ index ] )
	{
		// Get duration of current multiplier
		DateTime currenttime( UnixTimestamp() );
		DateTime expiretime( expamptime[ index ] );
		TimeDifference duration( expiretime, currenttime );
		
		// Calculate new duration
		TimeDifference newtime( iNewTime * 60 );
		
		// Add it to current
		expiretime += newtime;
		TimeDifference newduration( expiretime, currenttime );
		
		// Set new time
		expamptime[ index ] = expiretime;
		
		// Notify player
		g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "[SCXPM] Your multiplier's longevity was extended by " + iNewTime + " minutes.\n" );
	}
	// New level to give is lower than player's level. Extend half the time
	else if ( iNewLevel < expamp[ index ] )
	{
		// Calculate level differente
		int iDiff = expamp[ index ] - iNewLevel;
		
		// If level is WAY lower than it should be, decrease player's multiplier level by 1
		if ( iDiff > 1 )
			expamp[ index ]--;
		
		// Calculate new durations
		DateTime currenttime( UnixTimestamp() );
		DateTime expiretime( expamptime[ index ] );
		TimeDifference duration( expiretime, currenttime );
		
		// Calculate new duration. Do not halven the time if level is going to be lowered
		TimeDifference newtime( ( iNewTime / ( iDiff > 1 ? 1 : 2 ) ) * 60 );
		
		// Add it to current
		expiretime += newtime;
		TimeDifference newduration( expiretime, currenttime );
		
		// Set new time
		expamptime[ index ] = expiretime;
		
		// Notify player
		g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "[SCXPM] Your multiplier was lowered to x" + expamp[ index ] + ".\n" );
		g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "[SCXPM] Your multiplier's longevity was extended by " + ( iNewTime / ( iDiff > 1 ? 1 : 2 ) ) + " minutes.\n" );
	}
	// New level to give is greater than player's level. Extend double the time
	else if ( iNewLevel > expamp[ index ] )
	{
		// Calculate level differente
		int iDiff = iNewLevel - expamp[ index ];
		
		// If level is WAY higher than it should be, increase player's multiplier level by 1
		if ( iDiff > 1 )
			expamp[ index ]++;
		
		// Calculate new durations
		DateTime currenttime( UnixTimestamp() );
		DateTime expiretime( expamptime[ index ] );
		TimeDifference duration( expiretime, currenttime );
		
		// Calculate new duration. Do not double the time if level is going to be increased
		TimeDifference newtime( ( iNewTime * ( iDiff > 1 ? 1 : 2 ) ) * 60 );
		
		// Add it to current
		expiretime += newtime;
		TimeDifference newduration( expiretime, currenttime );
		
		// Set new time
		expamptime[ index ] = expiretime;
		
		// Notify player
		g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "[SCXPM] Your multiplier was raised to x" + expamp[ index ] + ".\n" );
		g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "[SCXPM] Your multiplier's longevity was extended by " + ( iNewTime * ( iDiff > 1 ? 1 : 2 ) ) + " minutes.\n" );
	}
}

void scxpm_xpgain( const int& in index )
{
	CBasePlayer@ pPlayer = g_PlayerFuncs.FindPlayerByIndex( index );
	
	float exp = scxpm_calc_xpgain( index );
	
	if ( MAP_XPGAIN == XP_DISABLED || exp == XP_DISABLED )
		g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "[SCXPM] XP gain is disabled on this map.\n" );
	else
	{
		float points = ( exp / 20.0 ) * 100.0;
		
		int need = 1;
		if ( points < 0.03125 )
		{
			points = ( exp / 0.625 ) * 100.0;
			need = need * 32;
		}
		else if ( points < 0.0625 )
		{
			points = ( exp / 1.25 ) * 100.0;
			need = need * 16;
		}
		else if ( points < 0.125 )
		{
			points = ( exp / 2.5 ) * 100.0;
			need = need * 8;
		}
		else if ( points < 0.5 )
		{
			points = ( exp / 5.0 ) * 100.0;
			need = need * 4;
		}
		else if ( points < 1.0 )
		{
			points = ( exp / 10.0 ) * 100.0;
			need = need * 2;
		}
		
		if ( need == 1 )
			g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "[SCXPM] Your XP gain on this map is: x" + exp + " (" + points + " XP every 1 point).\n" );
		else
			g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "[SCXPM] Your XP gain on this map is: x" + exp + " (" + points + " XP every " + need + " points).\n" );
		
		if ( expamp[ index ] > 0 )
		{
			DateTime currenttime( UnixTimestamp() );
			DateTime expiretime( expamptime[ index ] );
			TimeDifference duration( expiretime, currenttime );
			
			int minutes = duration.GetMinutes();
			int hours = 0;
			int days = 0;
			
			while ( minutes >= 60 )
			{
				hours++;
				minutes -= 60;
			}
			while ( hours >= 24 )
			{
				days++;
				hours -= 24;
			}
			
			string szMinutes;
			if ( minutes < 10 ) szMinutes = "0" + minutes + "m";
			else szMinutes = string( minutes ) + "m";
			
			string szHours;
			if ( hours < 10 ) szHours = "0" + hours + "h";
			else szHours = string( hours ) + "h";
			
			string szDays;
			if ( days < 10 ) szDays = "0" + days + "d";
			else szDays = string( days ) + "d";
			
			g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "[SCXPM] Your x" + ( expamp[ index ] + 1 ) + " multiplier expires on " + szDays + " " + szHours + " " + szMinutes + ".\n" );
		}
	}
}

void scxpm_hudmain( const int& in index )
{
	CBasePlayer@ pPlayer = g_PlayerFuncs.FindPlayerByIndex( index );
	MenuHandler@ state = MenuGetPlayer( pPlayer );
	
	state.InitMenu( pPlayer, scxpm_hudmain_cb );
	state.menu.SetTitle( "Customize HUD\n\n" );
	
	string opaquetext = "Opaque HUD? ";
	if ( hud_alpha[ index ] == 250 )
		opaquetext += "[ YES ]\n";
	else
		opaquetext += "[ NO ]\n";
	
	state.menu.AddItem( "Main Color\n", any( "item1" ) );
	state.menu.AddItem( "Position\n", any( "item2" ) );
	state.menu.AddItem( "Effect\n", any( "item3" ) );
	state.menu.AddItem( opaquetext, any( "item4" ) );
	state.menu.AddItem( "Effect Color\n", any( "item5" ) );
	state.menu.AddItem( "Effect Speed\n", any( "item6" ) );
	state.menu.AddItem( "Show/Hide Visuals\n", any( "item7" ) );
	
	state.OpenMenu( pPlayer, 0, 0 );
}

void scxpm_hudmain_cb( CTextMenu@ menu, CBasePlayer@ pPlayer, int page, const CTextMenuItem@ item )
{
	int index = pPlayer.entindex();
	if ( page == 10 ) return;
	
	string selection;
	item.m_pUserData.retrieve( selection );
	if ( selection == 'item1' )
		g_Scheduler.SetTimeout( "scxpm_hudcolor1", 0.01, index );
	else if ( selection == 'item2' )
		g_Scheduler.SetTimeout( "scxpm_hudposition", 0.01, index );
	else if ( selection == 'item3' )
		g_Scheduler.SetTimeout( "scxpm_hudeffect", 0.01, index );
	else if ( selection == 'item4' )
	{
		hud_alpha[ index ] ^= 250;
		g_Scheduler.SetTimeout( "scxpm_hudmain", 0.01, index );
	}
	else if ( selection == 'item5' )
		g_Scheduler.SetTimeout( "scxpm_hudcolor2", 0.01, index );
	else if ( selection == 'item6' )
		g_Scheduler.SetTimeout( "scxpm_hudspeed", 0.01, index );
	else if ( selection == 'item7' )
		g_Scheduler.SetTimeout( "scxpm_hudview", 0.01, index );
}

void scxpm_hudcolor1( const int& in index )
{
	CBasePlayer@ pPlayer = g_PlayerFuncs.FindPlayerByIndex( index );
	MenuHandler@ state = MenuGetPlayer( pPlayer );
	
	state.InitMenu( pPlayer, scxpm_hudcolor1_cb );
	state.menu.SetTitle( "Main Color\n\n" );
	
	state.menu.AddItem( "Default\n\n", any( "item1" ) );
	state.menu.AddItem( "White\n", any( "item2" ) );
	state.menu.AddItem( "Red\n", any( "item3" ) );
	state.menu.AddItem( "Green\n", any( "item4" ) );
	state.menu.AddItem( "Blue\n", any( "item5" ) );
	state.menu.AddItem( "Yellow\n", any( "item6" ) );
	state.menu.AddItem( "Magenta\n", any( "item7" ) );
	state.menu.AddItem( "Cyan\n\n", any( "item8" ) );
	state.menu.AddItem( "Custom\n", any( "item9" ) );
	
	state.OpenMenu( pPlayer, 0, 0 );
}

void scxpm_hudcolor1_cb( CTextMenu@ menu, CBasePlayer@ pPlayer, int page, const CTextMenuItem@ item )
{
	int index = pPlayer.entindex();
	if ( page == 10 )
	{
		g_Scheduler.SetTimeout( "scxpm_hudmain", 0.01, index );
		return;
	}
	
	string selection;
	item.m_pUserData.retrieve( selection );
	if ( selection == 'item1' )
	{
		hud_red1[ index ] = 50;
		hud_green1[ index ] = 135;
		hud_blue1[ index ] = 180;
		g_Scheduler.SetTimeout( "scxpm_hudcolor1", 0.01, index );
	}
	else if ( selection == 'item2' )
	{
		hud_red1[ index ] = 250;
		hud_green1[ index ] = 250;
		hud_blue1[ index ] = 250;
		g_Scheduler.SetTimeout( "scxpm_hudcolor1", 0.01, index );
	}
	else if ( selection == 'item3' )
	{
		hud_red1[ index ] = 250;
		hud_green1[ index ] = 10;
		hud_blue1[ index ] = 10;
		g_Scheduler.SetTimeout( "scxpm_hudcolor1", 0.01, index );
	}
	else if ( selection == 'item4' )
	{
		hud_red1[ index ] = 10;
		hud_green1[ index ] = 250;
		hud_blue1[ index ] = 10;
		g_Scheduler.SetTimeout( "scxpm_hudcolor1", 0.01, index );
	}
	else if ( selection == 'item5' )
	{
		hud_red1[ index ] = 10;
		hud_green1[ index ] = 10;
		hud_blue1[ index ] = 250;
		g_Scheduler.SetTimeout( "scxpm_hudcolor1", 0.01, index );
	}
	else if ( selection == 'item6' )
	{
		hud_red1[ index ] = 250;
		hud_green1[ index ] = 250;
		hud_blue1[ index ] = 10;
		g_Scheduler.SetTimeout( "scxpm_hudcolor1", 0.01, index );
	}
	else if ( selection == 'item7' )
	{
		hud_red1[ index ] = 250;
		hud_green1[ index ] = 10;
		hud_blue1[ index ] = 250;
		g_Scheduler.SetTimeout( "scxpm_hudcolor1", 0.01, index );
	}
	else if ( selection == 'item8' )
	{
		hud_red1[ index ] = 10;
		hud_green1[ index ] = 250;
		hud_blue1[ index ] = 250;
		g_Scheduler.SetTimeout( "scxpm_hudcolor1", 0.01, index );
	}
	else if ( selection == 'item9' )
		g_Scheduler.SetTimeout( "scxpm_hudcolor_custom", 0.01, index );
}

void scxpm_hudcolor_custom( const int& in index )
{
	CBasePlayer@ pPlayer = g_PlayerFuncs.FindPlayerByIndex( index );
	MenuHandler@ state = MenuGetPlayer( pPlayer );
	
	state.InitMenu( pPlayer, scxpm_hudcolor_custom_cb );
	
	string szTitle = "Custom\n\n";
	szTitle += "To use a custom HUD color, use command:\n\n";
	szTitle += "/hudcolor <RRR> <GGG> <BBB>\n\n";
	szTitle += "Where R, G and B is the color written in RGB Code.\n";
	szTitle += "Example for an orange colored HUD:\n\n";
	szTitle += "/hudcolor 255 128 000\n";
	
	state.menu.SetTitle( szTitle );
	state.menu.AddItem( "Return", any( "item1" ) );
	
	state.OpenMenu( pPlayer, 0, 0 );
}

void scxpm_hudcolor_custom_cb( CTextMenu@ menu, CBasePlayer@ pPlayer, int page, const CTextMenuItem@ item )
{
	int index = pPlayer.entindex();
	if ( page == 10 )
	{
		g_Scheduler.SetTimeout( "scxpm_hudmain", 0.01, index );
		return;
	}
	
	string selection;
	item.m_pUserData.retrieve( selection );
	if ( selection == 'item1' )
		g_Scheduler.SetTimeout( "scxpm_hudcolor1", 0.01, index );
}

void scxpm_set_hudcustom( SayParameters@ pParams )
{
	pParams.ShouldHide = true;
	
	CBasePlayer@ pPlayer = pParams.GetPlayer();
	int index = pPlayer.entindex();
	
	const CCommand@ args = pParams.GetArguments();
	
	if ( args.ArgC() > 1 )
	{
		bool bError = false;
		int iNewR = 0;
		int iNewG = 0;
		int iNewB = 0;
		
		if ( args.ArgC() >= 3 ) // 4th parameter and beyond are ignored
		{
			// First, check that we have 3 arguments
			if ( args[ 1 ].Length() == 0 || args[ 2 ].Length() == 0 || args[ 3 ].Length() == 0 )
				bError = true;
			else // Next, check if our arguments are valid by checking if they are numbers
			{
				for ( uint i = 0; i < args[ 1 ].Length(); i++ )
				{
					if ( !isdigit( args[ 1 ][ i ] ) )
						bError = true;
				}
				for ( uint i = 0; i < args[ 2 ].Length(); i++ )
				{
					if ( !isdigit( args[ 2 ][ i ] ) )
						bError = true;
				}
				for ( uint i = 0; i < args[ 3 ].Length(); i++ )
				{
					if ( !isdigit( args[ 3 ][ i ] ) )
						bError = true;
				}
			}
			
			// Lastly, check if our values are in the range
			iNewR = atoi( args[ 1 ] );
			iNewG = atoi( args[ 2 ] );
			iNewB = atoi( args[ 3 ] );
			
			if ( iNewR < 0 ) bError = true;
			if ( iNewR > 255 ) bError = true;
			if ( iNewG < 0 ) bError = true;
			if ( iNewG > 255 ) bError = true;
			if ( iNewB < 0 ) bError = true;
			if ( iNewB > 255 ) bError = true;
		}
		else
			bError = true;
		
		if ( !bError )
		{
			hud_red1[ index ] = iNewR;
			hud_green1[ index ] = iNewG;
			hud_blue1[ index ] = iNewB;
			
			g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "[SCXPM] New HUD color set.\n" );
		}
		else
		{
			g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "[SCXPM] Insufficient or incorrect parameters.\n" );
			g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "[SCXPM] Usage: /hudcolor <RRR> <GGG> <BBB>. Where R, G and B is a color written in RGB Code.\n" );
			g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "[SCXPM] Only numbers between 000 and 255 are allowed.\n" );
		}
	}
	else
	{
		g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "[SCXPM] Usage: /hudcolor <RRR> <GGG> <BBB>. Where R, G and B is a color written in RGB Code.\n" );
		g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "[SCXPM] Changes HUD's main color.\n" );
	}
}

void scxpm_hudposition( const int& in index )
{
	CBasePlayer@ pPlayer = g_PlayerFuncs.FindPlayerByIndex( index );
	MenuHandler@ state = MenuGetPlayer( pPlayer );
	
	state.InitMenu( pPlayer, scxpm_hudposition_cb );
	state.menu.SetTitle( "Position\n\n" );
	
	state.menu.AddItem( "Default\n\n", any( "item1" ) );
	state.menu.AddItem( "Move up\n", any( "item2" ) );
	state.menu.AddItem( "Move down\n", any( "item3" ) );
	state.menu.AddItem( "Move left\n", any( "item4" ) );
	state.menu.AddItem( "Move right\n", any( "item5" ) );
	
	state.OpenMenu( pPlayer, 0, 0 );
}

void scxpm_hudposition_cb( CTextMenu@ menu, CBasePlayer@ pPlayer, int page, const CTextMenuItem@ item )
{
	int index = pPlayer.entindex();
	if ( page == 10 )
	{
		g_Scheduler.SetTimeout( "scxpm_hudmain", 0.01, index );
		return;
	}
	
	string selection;
	item.m_pUserData.retrieve( selection );
	if ( selection == 'item1' )
	{
		hud_pos_x[ index ] = 0.6;
		hud_pos_y[ index ] = 0.04;
		g_Scheduler.SetTimeout( "scxpm_hudposition", 0.01, index );
	}
	else if ( selection == 'item2' )
	{
		hud_pos_y[ index ] -= 0.01;
		g_Scheduler.SetTimeout( "scxpm_hudposition", 0.01, index );
	}
	else if ( selection == 'item3' )
	{
		hud_pos_y[ index ] += 0.01;
		g_Scheduler.SetTimeout( "scxpm_hudposition", 0.01, index );
	}
	else if ( selection == 'item4' )
	{
		hud_pos_x[ index ] -= 0.01;
		g_Scheduler.SetTimeout( "scxpm_hudposition", 0.01, index );
	}
	else if ( selection == 'item5' )
	{
		hud_pos_x[ index ] += 0.01;
		g_Scheduler.SetTimeout( "scxpm_hudposition", 0.01, index );
	}
}

void scxpm_hudeffect( const int& in index )
{
	CBasePlayer@ pPlayer = g_PlayerFuncs.FindPlayerByIndex( index );
	MenuHandler@ state = MenuGetPlayer( pPlayer );
	
	state.InitMenu( pPlayer, scxpm_hudeffect_cb );
	state.menu.SetTitle( "Effect\n\n" );
	
	state.menu.AddItem( "None\n", any( "item1" ) );
	state.menu.AddItem( "Credits\n", any( "item2" ) );
	state.menu.AddItem( "Scan Out\n", any( "item3" ) );
	
	state.OpenMenu( pPlayer, 0, 0 );
}

void scxpm_hudeffect_cb( CTextMenu@ menu, CBasePlayer@ pPlayer, int page, const CTextMenuItem@ item )
{
	int index = pPlayer.entindex();
	if ( page == 10 )
	{
		g_Scheduler.SetTimeout( "scxpm_hudmain", 0.01, index );
		return;
	}
	
	string selection;
	item.m_pUserData.retrieve( selection );
	if ( selection == 'item1' )
	{
		hud_effect[ index ] = 0;
		hud_ef_fadein[ index ] = 0.0;
		g_Scheduler.SetTimeout( "scxpm_hudeffect", 0.01, index );
	}
	else if ( selection == 'item2' )
	{
		hud_effect[ index ] = 1;
		hud_ef_fadein[ index ] = 0.0;
		g_Scheduler.SetTimeout( "scxpm_hudeffect", 0.01, index );
	}
	else if ( selection == 'item3' )
	{
		if ( hud_effect[ index ] != 2 )
		{
			hud_ef_fadein[ index ] = 0.009;
			hud_ef_scantime[ index ] = 0.057;
		}
		hud_effect[ index ] = 2;
		g_Scheduler.SetTimeout( "scxpm_hudeffect", 0.01, index );
	}
}

void scxpm_hudcolor2( const int& in index )
{
	CBasePlayer@ pPlayer = g_PlayerFuncs.FindPlayerByIndex( index );
	MenuHandler@ state = MenuGetPlayer( pPlayer );
	
	state.InitMenu( pPlayer, scxpm_hudcolor2_cb );
	state.menu.SetTitle( "Effect Color\n\n" );
	
	state.menu.AddItem( "White\n", any( "item1" ) );
	state.menu.AddItem( "Red\n", any( "item2" ) );
	state.menu.AddItem( "Green\n", any( "item3" ) );
	state.menu.AddItem( "Blue\n", any( "item4" ) );
	state.menu.AddItem( "Yellow\n", any( "item5" ) );
	state.menu.AddItem( "Magenta\n", any( "item6" ) );
	state.menu.AddItem( "Cyan\n", any( "item7" ) );
	
	state.OpenMenu( pPlayer, 0, 0 );
}

void scxpm_hudcolor2_cb( CTextMenu@ menu, CBasePlayer@ pPlayer, int page, const CTextMenuItem@ item )
{
	int index = pPlayer.entindex();
	if ( page == 10 )
	{
		g_Scheduler.SetTimeout( "scxpm_hudmain", 0.01, index );
		return;
	}
	
	string selection;
	item.m_pUserData.retrieve( selection );
	if ( selection == 'item1' )
	{
		hud_red2[ index ] = 250;
		hud_green2[ index ] = 250;
		hud_blue2[ index ] = 250;
		g_Scheduler.SetTimeout( "scxpm_hudcolor2", 0.01, index );
	}
	else if ( selection == 'item2' )
	{
		hud_red2[ index ] = 250;
		hud_green2[ index ] = 10;
		hud_blue2[ index ] = 10;
		g_Scheduler.SetTimeout( "scxpm_hudcolor2", 0.01, index );
	}
	else if ( selection == 'item3' )
	{
		hud_red2[ index ] = 10;
		hud_green2[ index ] = 250;
		hud_blue2[ index ] = 10;
		g_Scheduler.SetTimeout( "scxpm_hudcolor2", 0.01, index );
	}
	else if ( selection == 'item4' )
	{
		hud_red2[ index ] = 10;
		hud_green2[ index ] = 10;
		hud_blue2[ index ] = 250;
		g_Scheduler.SetTimeout( "scxpm_hudcolor2", 0.01, index );
	}
	else if ( selection == 'item5' )
	{
		hud_red2[ index ] = 250;
		hud_green2[ index ] = 250;
		hud_blue2[ index ] = 10;
		g_Scheduler.SetTimeout( "scxpm_hudcolor2", 0.01, index );
	}
	else if ( selection == 'item6' )
	{
		hud_red2[ index ] = 250;
		hud_green2[ index ] = 10;
		hud_blue2[ index ] = 250;
		g_Scheduler.SetTimeout( "scxpm_hudcolor2", 0.01, index );
	}
	else if ( selection == 'item7' )
	{
		hud_red2[ index ] = 10;
		hud_green2[ index ] = 250;
		hud_blue2[ index ] = 250;
		g_Scheduler.SetTimeout( "scxpm_hudcolor2", 0.01, index );
	}
}

void scxpm_hudspeed( const int& in index )
{
	CBasePlayer@ pPlayer = g_PlayerFuncs.FindPlayerByIndex( index );
	MenuHandler@ state = MenuGetPlayer( pPlayer );
	
	state.InitMenu( pPlayer, scxpm_hudspeed_cb );
	state.menu.SetTitle( "Effect Speed\n\nThis only affects Scan Out effect\n\n" );
	
	state.menu.AddItem( "Very Slow\n", any( "item1" ) );
	state.menu.AddItem( "Slow\n", any( "item2" ) );
	state.menu.AddItem( "Medium\n", any( "item3" ) );
	state.menu.AddItem( "Fast\n", any( "item4" ) );
	state.menu.AddItem( "Very Fast\n", any( "item5" ) );
	
	state.OpenMenu( pPlayer, 0, 0 );
}

void scxpm_hudspeed_cb( CTextMenu@ menu, CBasePlayer@ pPlayer, int page, const CTextMenuItem@ item )
{
	int index = pPlayer.entindex();
	if ( page == 10 )
	{
		g_Scheduler.SetTimeout( "scxpm_hudmain", 0.01, index );
		return;
	}
	
	string selection;
	item.m_pUserData.retrieve( selection );
	if ( selection == 'item1' )
	{
		hud_ef_fadein[ index ] = 0.015;
		hud_ef_scantime[ index ] = 0.019;
		g_Scheduler.SetTimeout( "scxpm_hudspeed", 0.01, index );
	}
	else if ( selection == 'item2' )
	{
		hud_ef_fadein[ index ] = 0.012;
		hud_ef_scantime[ index ] = 0.038;
		g_Scheduler.SetTimeout( "scxpm_hudspeed", 0.01, index );
	}
	else if ( selection == 'item3' )
	{
		hud_ef_fadein[ index ] = 0.009;
		hud_ef_scantime[ index ] = 0.057;
		g_Scheduler.SetTimeout( "scxpm_hudspeed", 0.01, index );
	}
	else if ( selection == 'item4' )
	{
		hud_ef_fadein[ index ] = 0.007;
		hud_ef_scantime[ index ] = 0.075;
		g_Scheduler.SetTimeout( "scxpm_hudspeed", 0.01, index );
	}
	else if ( selection == 'item5' )
	{
		hud_ef_fadein[ index ] = 0.004;
		hud_ef_scantime[ index ] = 0.096;
		g_Scheduler.SetTimeout( "scxpm_hudspeed", 0.01, index );
	}
}

void scxpm_hudview( const int& in index )
{
	CBasePlayer@ pPlayer = g_PlayerFuncs.FindPlayerByIndex( index );
	MenuHandler@ state = MenuGetPlayer( pPlayer );
	
	state.InitMenu( pPlayer, scxpm_hudview_cb );
	state.menu.SetTitle( "Show/Hide Visuals\n\n" );
	
	string view1;
	if ( ( bData[ index ] & HUD_EXP ) != 0 )
		view1 += "Show XP? [ YES ]\n";
	else
		view1 += "Show XP? [ NO ]\n";
	
	string view2;
	if ( ( bData[ index ] & HUD_EXPLEFT ) != 0 )
		view2 += "Show remaining XP? [ YES ]\n";
	else
		view2 += "Show remaining XP? [ NO ]\n";
	
	string view3;
	if ( ( bData[ index ] & HUD_EXPEARN ) != 0 )
		view3 += "Show earned XP? [ YES ]\n";
	else
		view3 += "Show earned XP? [ NO ]\n";
	
	string view4;
	if ( ( bData[ index ] & HUD_LEVEL ) != 0 )
		view4 += "Show level? [ YES ]\n";
	else
		view4 += "Show level? [ NO ]\n";
	
	string view5;
	if ( ( bData[ index ] & HUD_CLASS ) != 0 )
		view5 += "Show class? [ YES ]\n";
	else
		view5 += "Show class? [ NO ]\n";
	
	string view6;
	if ( ( bData[ index ] & HUD_MEDALS ) != 0 )
		view6 += "Show medals? [ YES ]\n";
	else
		view6 += "Show medals? [ NO ]\n";
	
	string view7;
	if ( ( bData[ index ] & HUD_ACHIEVEMENTS ) != 0 )
		view7 += "Show unlocked achievements? [ YES ]\n";
	else
		view7 += "Show unlocked achievements? [ NO ]\n";
	
	state.menu.AddItem( view1, any( "item1" ) );
	state.menu.AddItem( view2, any( "item2" ) );
	state.menu.AddItem( view3, any( "item3" ) );
	state.menu.AddItem( view4, any( "item4" ) );
	state.menu.AddItem( view5, any( "item5" ) );
	state.menu.AddItem( view6, any( "item6" ) );
	state.menu.AddItem( view7, any( "item7" ) );
	
	state.OpenMenu( pPlayer, 0, 0 );
}

void scxpm_hudview_cb( CTextMenu@ menu, CBasePlayer@ pPlayer, int page, const CTextMenuItem@ item )
{
	int index = pPlayer.entindex();
	if ( page == 10 )
	{
		g_Scheduler.SetTimeout( "scxpm_hudmain", 0.01, index );
		return;
	}
	
	string selection;
	item.m_pUserData.retrieve( selection );
	if ( selection == 'item1' )
	{
		bData[ index ] ^= HUD_EXP;
		g_Scheduler.SetTimeout( "scxpm_hudview", 0.01, index );
	}
	else if ( selection == 'item2' )
	{
		bData[ index ] ^= HUD_EXPLEFT;
		g_Scheduler.SetTimeout( "scxpm_hudview", 0.01, index );
	}
	else if ( selection == 'item3' )
	{
		bData[ index ] ^= HUD_EXPEARN;
		g_Scheduler.SetTimeout( "scxpm_hudview", 0.01, index );
	}
	else if ( selection == 'item4' )
	{
		bData[ index ] ^= HUD_LEVEL;
		g_Scheduler.SetTimeout( "scxpm_hudview", 0.01, index );
	}
	else if ( selection == 'item5' )
	{
		bData[ index ] ^= HUD_CLASS;
		g_Scheduler.SetTimeout( "scxpm_hudview", 0.01, index );
	}
	else if ( selection == 'item6' )
	{
		bData[ index ] ^= HUD_MEDALS;
		g_Scheduler.SetTimeout( "scxpm_hudview", 0.01, index );
	}
	else if ( selection == 'item7' )
	{
		bData[ index ] ^= HUD_ACHIEVEMENTS;
		g_Scheduler.SetTimeout( "scxpm_hudview", 0.01, index );
	}
}

void scxpm_showdata()
{
	for ( int i = 1; i <= g_Engine.maxClients; i++ )
	{
		CBasePlayer@ pPlayer = g_PlayerFuncs.FindPlayerByIndex( i );
		
		if ( pPlayer !is null && pPlayer.IsConnected() )
		{
			string hudtext;
			
			if ( ( bData[ i ] & HUD_EXP ) != 0 )
				hudtext += "XP: " + AddCommas( xp[ i ] ) + "\n";
			
			if ( ( bData[ i ] & HUD_EXPLEFT ) != 0 )
			{
				if ( playerlevel[ i ] >= 3000 )
					hudtext += "--,--- XP left for next level\n";
				else
					hudtext += AddCommas( neededxp[ i ] - xp[ i ] ) + " XP left for next level\n";
			}
			
			if ( gDelayedXP )
			{
				if ( earnedxp[ i ] >= 0 )
					hudtext += "You will gain " + AddCommas( earnedxp[ i ] ) + " XP at mission end\n";
				else
					hudtext += "You will lose " + AddCommas( int( abs( earnedxp[ i ] ) ) ) + " XP at mission end\n";
			}
			else if ( ( bData[ i ] & HUD_EXPEARN ) != 0 )
			{
				if ( earnedxp[ i ] >= 0 )
					hudtext += "You won " + AddCommas( earnedxp[ i ] ) + " XP on this map\n";
				else
					hudtext += "You lost " + AddCommas( int( abs( earnedxp[ i ] ) ) ) + " XP on this map\n";
			}
			
			if ( ( bData[ i ] & HUD_LEVEL ) != 0 )
				hudtext += "Level: " + AddCommas( playerlevel[ i ] ) + "\n";
			
			if ( ( bData[ i ] & HUD_CLASS ) != 0 )
				hudtext += "Class: " + ranks[ rank[ i ] ] + "\n";
			
			if ( ( bData[ i ] & HUD_MEDALS ) != 0 )
				hudtext += "Medals: " + AddCommas( medals[ i ] ) + "\n";
			
			if ( ( bData[ i ] & HUD_ACHIEVEMENTS ) != 0 )
				hudtext += "Achievements: " + GetAchievementClear( i ) + " / " + int( szAchievementNames.length() ) + "\n";
			
			HUDTextParams textParams;
			textParams.x = hud_pos_x[ i ];
			textParams.y = hud_pos_y[ i ];
			textParams.effect = hud_effect[ i ];
			textParams.r1 = hud_red1[ i ];
			textParams.g1 = hud_green1[ i ];
			textParams.b1 = hud_blue1[ i ];
			textParams.a1 = hud_alpha[ i ];
			textParams.r2 = hud_red2[ i ];
			textParams.g2 = hud_green2[ i ];
			textParams.b2 = hud_blue2[ i ];
			textParams.a2 = hud_alpha[ i ];
			textParams.fadeinTime = hud_ef_fadein[ i ];
			textParams.fadeoutTime = 0.0;
			textParams.holdTime = 255.0;
			textParams.fxTime = hud_ef_scantime[ i ];
			textParams.channel = 1;
			
			g_PlayerFuncs.HudMessage( pPlayer, textParams, hudtext );
		}
	}
}

void scxpm_lvltomedal( const int& in index )
{
	CBasePlayer@ pPlayer = g_PlayerFuncs.FindPlayerByIndex( index );
	
	MenuHandler@ state = MenuGetPlayer( pPlayer );
	
	state.InitMenu( pPlayer, scxpm_lvltomedal_cb );
	
	string title = "Reset Level\n\n\nExchange your level for free medals!\n\n\n";
	
	title += "   - 145 Levels = 1 medal\n   - 270 Levels = 3 medals\n   - 395 Levels = 5 medals\n   - 520 Levels = 7 medals\n   - 645 Levels = 9 medals\n";
	
	state.menu.SetTitle( title );
	
	state.menu.AddItem( "Reset!\n", any( "item1" ) );
	
	state.OpenMenu( pPlayer, 0, 0 );
}

void scxpm_lvltomedal_cb( CTextMenu@ menu, CBasePlayer@ pPlayer, int page, const CTextMenuItem@ item )
{
	int index = pPlayer.entindex();
	if ( page == 10 ) return;
	
	if ( playerlevel[ index ] >= 145 )
	{
		if ( medals[ index ] < 9999 )
		{
			health[ index ] = 0;
			armor[ index ] = 0;
			rhealth[ index ] = 0;
			rarmor[ index ] = 0;
			rammo[ index ] = 0;
			gravity[ index ] = 0;
			speed[ index ] = 0;
			dist[ index ] = 0;
			dodge[ index ] = 0;
			skillpoints[ index ] = 0;
			
			if ( playerlevel[ index ] >= 645 )
			{
				medals[ index ] += 9;
				if ( medals[ index ] > 9999 )
					medals[ index ] = 9999;
				
				g_SoundSystem.EmitSoundDyn( pPlayer.edict(), CHAN_STATIC, "isc/scxpm/medalget.ogg", VOL_NORM, ATTN_NONE, SND_SKIP_ORIGIN_USE_ENT, PITCH_NORM, index );
				
				string name = pPlayer.pev.netname;
				string steamid = g_EngineFuncs.GetPlayerAuthId( pPlayer.edict() );
				
				g_PlayerFuncs.ClientPrintAll( HUD_PRINTTALK, "[SCXPM] " + name + " won 9 medals for resetting! (New total of " + medals[ index ] + ").\n" );
				g_Game.AlertMessage( at_logged, "[SCXPM] " + name + " (" + steamid + ") won 9 medals for resetting. (New total of " + medals[ index ] + ").\n" );
				SCXPM_Log( name + " (" + steamid + ") won 9 medals for resetting. (New total of " + medals[ index ] + ").\n" );
				
				playerlevel[ index ] -= 645;
				skillpoints[ index ] = Math.clamp( 0, 700, playerlevel[ index ] );
				
				if ( playerlevel[ index ] != 0 )
					xp[ index ] = scxpm_calc_xp( playerlevel[ index ] );
				else
					xp[ index ] = 0;
			}
			else if ( playerlevel[ index ] >= 520 )
			{
				medals[ index ] += 7;
				if ( medals[ index ] > 9999 )
					medals[ index ] = 9999;
				
				g_SoundSystem.EmitSoundDyn( pPlayer.edict(), CHAN_STATIC, "isc/scxpm/medalget.ogg", VOL_NORM, ATTN_NONE, SND_SKIP_ORIGIN_USE_ENT, PITCH_NORM, index );
				
				string name = pPlayer.pev.netname;
				string steamid = g_EngineFuncs.GetPlayerAuthId( pPlayer.edict() );
				
				g_PlayerFuncs.ClientPrintAll( HUD_PRINTTALK, "[SCXPM] " + name + " won 7 medals for resetting! (New total of " + medals[ index ] + ").\n" );
				g_Game.AlertMessage( at_logged, "[SCXPM] " + name + " (" + steamid + ") won 7 medals for resetting. (New total of " + medals[ index ] + ").\n" );
				SCXPM_Log( name + " (" + steamid + ") won 7 medals for resetting. (New total of " + medals[ index ] + ").\n" );
				
				playerlevel[ index ] -= 520;
				skillpoints[ index ] = Math.clamp( 0, 700, playerlevel[ index ] );
				
				if ( playerlevel[ index ] != 0 )
					xp[ index ] = scxpm_calc_xp( playerlevel[ index ] );
				else
					xp[ index ] = 0;
			}
			else if ( playerlevel[ index ] >= 395 )
			{
				medals[ index ] += 5;
				if ( medals[ index ] > 9999 )
					medals[ index ] = 9999;
				
				g_SoundSystem.EmitSoundDyn( pPlayer.edict(), CHAN_STATIC, "isc/scxpm/medalget.ogg", VOL_NORM, ATTN_NONE, SND_SKIP_ORIGIN_USE_ENT, PITCH_NORM, index );
				
				string name = pPlayer.pev.netname;
				string steamid = g_EngineFuncs.GetPlayerAuthId( pPlayer.edict() );
				
				g_PlayerFuncs.ClientPrintAll( HUD_PRINTTALK, "[SCXPM] " + name + " won 5 medals for resetting! (New total of " + medals[ index ] + ").\n" );
				g_Game.AlertMessage( at_logged, "[SCXPM] " + name + " (" + steamid + ") won 5 medals for resetting. (New total of " + medals[ index ] + ").\n" );
				SCXPM_Log( name + " (" + steamid + ") won 5 medals for resetting. (New total of " + medals[ index ] + ").\n" );
				
				playerlevel[ index ] -= 395;
				skillpoints[ index ] = Math.clamp( 0, 700, playerlevel[ index ] );
				
				if ( playerlevel[ index ] != 0 )
					xp[ index ] = scxpm_calc_xp( playerlevel[ index ] );
				else
					xp[ index ] = 0;
			}
			else if ( playerlevel[ index ] >= 270 )
			{
				medals[ index ] += 3;
				if ( medals[ index ] > 9999 )
					medals[ index ] = 9999;
				
				g_SoundSystem.EmitSoundDyn( pPlayer.edict(), CHAN_STATIC, "isc/scxpm/medalget.ogg", VOL_NORM, ATTN_NONE, SND_SKIP_ORIGIN_USE_ENT, PITCH_NORM, index );
				
				string name = pPlayer.pev.netname;
				string steamid = g_EngineFuncs.GetPlayerAuthId( pPlayer.edict() );
				
				g_PlayerFuncs.ClientPrintAll( HUD_PRINTTALK, "[SCXPM] " + name + " won 3 medals for resetting! (New total of " + medals[ index ] + ").\n" );
				g_Game.AlertMessage( at_logged, "[SCXPM] " + name + " (" + steamid + ") won 3 medals for resetting. (New total of " + medals[ index ] + ").\n" );
				SCXPM_Log( name + " (" + steamid + ") won 3 medals for resetting. (New total of " + medals[ index ] + ").\n" );
				
				playerlevel[ index ] -= 270;
				skillpoints[ index ] = Math.clamp( 0, 700, playerlevel[ index ] );
				
				if ( playerlevel[ index ] != 0 )
					xp[ index ] = scxpm_calc_xp( playerlevel[ index ] );
				else
					xp[ index ] = 0;
			}
			else if ( playerlevel[ index ] >= 145 )
			{
				medals[ index ]++; // We don't need to worry about an overflow here
				
				g_SoundSystem.EmitSoundDyn( pPlayer.edict(), CHAN_STATIC, "isc/scxpm/medalget.ogg", VOL_NORM, ATTN_NONE, SND_SKIP_ORIGIN_USE_ENT, PITCH_NORM, index );
				
				string name = pPlayer.pev.netname;
				string steamid = g_EngineFuncs.GetPlayerAuthId( pPlayer.edict() );
				
				g_PlayerFuncs.ClientPrintAll( HUD_PRINTTALK, "[SCXPM] " + name + " won 1 medal for resetting! (New total of " + medals[ index ] + ").\n" );
				g_Game.AlertMessage( at_logged, "[SCXPM] " + name + " (" + steamid + ") won 1 medal for resetting. (New total of " + medals[ index ] + ").\n" );
				SCXPM_Log( name + " (" + steamid + ") won 1 medal for resetting. (New total of " + medals[ index ] + ").\n" );
				
				playerlevel[ index ] -= 145;
				skillpoints[ index ] = Math.clamp( 0, 700, playerlevel[ index ] );
				
				if ( playerlevel[ index ] != 0 )
					xp[ index ] = scxpm_calc_xp( playerlevel[ index ] );
				else
					xp[ index ] = 0;
			}
			
			scxpm_calcneedxp( index );
			scxpm_getrank( index );
		}
		else
			g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "[SCXPM] You already have every single medal. Can't reset anymore!\n" );
	}
	else
		g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "[SCXPM] Not enough levels.\n" );
}

void scxpm_regen()
{
	// Skills are disabled on this map
	if ( gNoSkills )
		return;
	
	for ( int i = 1; i <= g_Engine.maxClients; i++ )
	{
		CBasePlayer@ pPlayer = g_PlayerFuncs.FindPlayerByIndex( i );
		
		if ( pPlayer !is null && pPlayer.IsConnected() )
		{
			// Update skills vars
			CustomKeyvalues@ pSkills = pPlayer.GetCustomKeyvalues();
			pSkills.SetKeyvalue( "$i_health", health[ i ] );
			pSkills.SetKeyvalue( "$i_armor", armor[ i ] );
			pSkills.SetKeyvalue( "$i_rhealth", rhealth[ i ] );
			pSkills.SetKeyvalue( "$i_rarmor", rarmor[ i ] );
			pSkills.SetKeyvalue( "$i_rammo", rammo[ i ] );
			pSkills.SetKeyvalue( "$i_gravity", gravity[ i ] );
			pSkills.SetKeyvalue( "$i_speed", speed[ i ] );
			pSkills.SetKeyvalue( "$i_dist", dist[ i ] );
			pSkills.SetKeyvalue( "$i_dodge", dodge[ i ] );
			
			if ( pPlayer.pev.deadflag == DEAD_NO )
			{
				// A Player::CurWeapon message hook would make this more efficient instead of checking every 0.5 seconds
				// BioElectric special skill
				CBasePlayerItem@ pShockCheck = cast< CBasePlayerItem@ >( pPlayer.m_hActiveItem.GetEntity() );
				if ( pShockCheck !is null )
				{
					CBasePlayerWeapon@ pWeapon = pShockCheck.GetWeaponPtr();
					if ( pWeapon.m_iId == WEAPON_SHOCKRIFLE )
					{
						if ( !be_once[ i ] && !handicap9[ i ] )
						{
							pPlayer.m_rgAmmo( AMMO_ROACH, 100 + ( bioelectric[ i ] * 10 ) );
							be_once[ i ] = true;
						}
					}
					else
						be_once[ i ] = false;
				}
				else
					be_once[ i ] = false;
				
				// Quick Heal special skill
				// Adapted from SurvivalDX
				if ( fastheal[ i ] > 0 )
				{
					// Don't run if medkit cannot be recharged
					if ( g_Engine.time > flNextHPRegen[ i ] && pPlayer.GetMaxAmmo( AMMO_MEDKIT ) > 0 )
					{
						// Add the extra ammo
						pPlayer.m_rgAmmo( AMMO_MEDKIT, pPlayer.m_rgAmmo( AMMO_MEDKIT ) + 5 );
						
						// Clamp it to max
						pPlayer.RemoveExcessAmmo( AMMO_MEDKIT );
						
						// Calculate next regen time
						float flTime = 6.0 - ( float( fastheal[ i ] ) / 3.5 );
						flNextHPRegen[ i ] = g_Engine.time + flTime;
					}
				}
				
				float halfspeed = float( speed[ i ] ) / 2.5; // not really "halfspeed"
				
				// Clamp all health/armor regeneration to a maximum of 200.
				if ( rhealth[ i ] > 0 )
				{
					if ( rhealthwait[ i ] <= 0.0 )
					{
						// handicap9 = Lacking Help handicap
						if ( pPlayer.pev.health < Math.clamp( 0.0, 200.0, ( float( health[ i ] ) / 2.0 ) + starthealth + ( handicap9[ i ] ? 0.0 : Math.clamp( 0.0, 30.0, float( medals[ i ] ) ) ) + halfspeed ) )
						{
							pPlayer.pev.health = pPlayer.pev.health + 1.0;
							rhealthwait[ i ] = 315.0 - ( float( rhealth[ i ] ) / 1.5 );
						}
					}
					else
					{
						rhealthwait[ i ]--;
						if ( pPlayer.pev.health < Math.clamp( 0.0, 200.0, ( float( health[ i ] ) / 2.0 ) + starthealth + ( handicap9[ i ] ? 0.0 : Math.clamp( 0.0, 30.0, float( medals[ i ] ) ) ) + halfspeed ) && Math.RandomFloat( 0.0, 200.0 + ( float( rhealth[ i ] ) / 2.0 ) + ( handicap9[ i ] ? 0.0 : Math.clamp( 0.0, 30.0, float( medals[ i ] ) ) ) + halfspeed ) > 215.0 )
							pPlayer.pev.health = pPlayer.pev.health + 1.0;
					}
				}
				if ( rarmor[ i ] > 0 )
				{
					if ( rarmorwait[ i ] <= 0.0 )
					{
						if ( pPlayer.pev.armorvalue < Math.clamp( 0.0, 200.0, ( float( armor[ i ] ) / 2.0 ) + startarmor + ( handicap9[ i ] ? 0.0 : Math.clamp( 0.0, 30.0, float( medals[ i ] ) ) ) + halfspeed ) )
						{
							pPlayer.pev.armorvalue = pPlayer.pev.armorvalue + 1.0;
							rarmorwait[ i ] = 330.0 - ( float( rarmor[ i ] ) / 1.5 );
						}
					}
					else
					{
						rarmorwait[ i ]--;
						if ( pPlayer.pev.armorvalue < Math.clamp( 0.0, 200.0, ( float( armor[ i ] ) / 2.0 ) + startarmor + ( handicap9[ i ] ? 0.0 : Math.clamp( 0.0, 30.0, float( medals[ i ] ) ) ) + halfspeed ) && Math.RandomFloat( 0.0, 200.0 + ( float( rarmor[ i ] ) / 2.0 ) + ( handicap9[ i ] ? 0.0 : Math.clamp( 0.0, 30.0, float( medals[ i ] ) ) ) + halfspeed ) > 230.0 )
							pPlayer.pev.armorvalue = pPlayer.pev.armorvalue + 1.0;
					}
				}
				if ( rammo[ i ] > 0 ) // ammo regeneration
				{
					if ( rammowait[ i ] <= 0.0 )
					{
						CBasePlayerItem@ pItem = cast< CBasePlayerItem@ >( pPlayer.m_hActiveItem.GetEntity() );
						
						if ( pItem !is null )
						{
							CBasePlayerWeapon@ pWeapon = pItem.GetWeaponPtr();
							
							if ( pWeapon.m_iId == WEAPON_GLOCK )
							{
								int pAmmo = pPlayer.m_rgAmmo( AMMO_9MM );
								if ( ( bData[ i ] & SS_DISPENCER ) != 0 )
								{
									if ( pAmmo <= 216 )
										GiveItem( pPlayer, "ammo_9mmclip" );
								}
								
								if ( pAmmo < 250 )
									GiveItem( pPlayer, "ammo_9mmclip" );
							}
							else if ( pWeapon.m_iId == WEAPON_PYTHON )
							{
								int pAmmo = pPlayer.m_rgAmmo( AMMO_357 );
								if ( ( bData[ i ] & SS_DISPENCER ) != 0 )
								{
									if ( pAmmo <= 24 )
										GiveItem( pPlayer, "ammo_357" );
								}
								
								if ( pAmmo < 36 )
									GiveItem( pPlayer, "ammo_357" );
							}
							else if ( pWeapon.m_iId == WEAPON_MP5 )
							{
								int pAmmo = pPlayer.m_rgAmmo( AMMO_9MM );
								if ( ( bData[ i ] & SS_DISPENCER ) != 0 )
								{
									if ( pAmmo <= 190 )
										GiveItem( pPlayer, "ammo_9mmAR" );
								}
								
								if ( pAmmo < 250 )
									GiveItem( pPlayer, "ammo_9mmAR" );
							}
							else if ( pWeapon.m_iId == WEAPON_CROSSBOW )
							{
								int pAmmo = pPlayer.m_rgAmmo( AMMO_CROSSBOW );
								if ( ( bData[ i ] & SS_DISPENCER ) != 0 )
								{
									if ( pAmmo <= 40 )
										GiveItem( pPlayer, "ammo_crossbow" );
								}
								
								if ( pAmmo < 50 )
									GiveItem( pPlayer, "ammo_crossbow" );
							}
							else if ( pWeapon.m_iId == WEAPON_SHOTGUN )
							{
								int pAmmo = pPlayer.m_rgAmmo( AMMO_SHOTGUN );
								if ( ( bData[ i ] & SS_DISPENCER ) != 0 )
								{
									if ( pAmmo <= 101 )
										GiveItem( pPlayer, "ammo_buckshot" );
								}
								
								if ( pAmmo < 125 )
									GiveItem( pPlayer, "ammo_buckshot" );
							}
							else if ( pWeapon.m_iId == WEAPON_RPG )
							{
								int pAmmo = pPlayer.m_rgAmmo( AMMO_RPG );
								if ( ( bData[ i ] & SS_DISPENCER ) != 0 )
								{
									if ( pAmmo <= 1 )
										GiveItem( pPlayer, "ammo_rpgclip" );
								}
								
								if ( pAmmo < 5 )
									GiveItem( pPlayer, "ammo_rpgclip" );
							}
							else if ( pWeapon.m_iId == WEAPON_GAUSS )
							{
								int pAmmo = pPlayer.m_rgAmmo( AMMO_GAUSS );
								if ( ( bData[ i ] & SS_DISPENCER ) != 0 )
								{
									if ( pAmmo <= 60 )
										GiveItem( pPlayer, "ammo_gaussclip" );
								}
								
								if ( pAmmo < 100 )
									GiveItem( pPlayer, "ammo_gaussclip" );
							}
							else if ( pWeapon.m_iId == WEAPON_UZI )
							{
								int pAmmo = pPlayer.m_rgAmmo( AMMO_9MM );
								if ( pPlayer.get_m_szAnimExtension() == 'uzis' ) // Akimbo Uzis
								{
									if ( ( bData[ i ] & SS_DISPENCER ) != 0 )
									{
										if ( pAmmo <= 122 )
											GiveItem( pPlayer, "ammo_uziclip" );
										if ( pAmmo <= 154 )
											GiveItem( pPlayer, "ammo_uziclip" );
									}
									
									if ( pAmmo < 218 )
										GiveItem( pPlayer, "ammo_uziclip" );
									if ( pAmmo < 250 )
										GiveItem( pPlayer, "ammo_uziclip" );
								}
								else // Single Uzi
								{
									if ( ( bData[ i ] & SS_DISPENCER ) != 0 )
									{
										if ( pAmmo <= 186 )
											GiveItem( pPlayer, "ammo_uziclip" );
									}
									
									if ( pAmmo < 250 )
										GiveItem( pPlayer, "ammo_uziclip" );
								}
							}
							else if ( pWeapon.m_iId == WEAPON_SNIPERRIFLE )
							{
								int pAmmo = pPlayer.m_rgAmmo( AMMO_SNIPER );
								if ( ( bData[ i ] & SS_DISPENCER ) != 0 )
								{
									if ( pAmmo <= 5 )
										GiveItem( pPlayer, "ammo_762" );
								}
								
								if ( pAmmo < 15 )
									GiveItem( pPlayer, "ammo_762" );
							}
							else if ( pWeapon.m_iId == WEAPON_M249 )
							{
								int pAmmo = pPlayer.m_rgAmmo( AMMO_SAW );
								if ( ( bData[ i ] & SS_DISPENCER ) != 0 )
								{
									if ( pAmmo <= 400 )
										GiveItem( pPlayer, "ammo_556" );
								}
								
								if ( pAmmo < 600 )
									GiveItem( pPlayer, "ammo_556" );
							}
							else if ( pWeapon.m_iId == WEAPON_M16 )
							{
								int pAmmo1 = pPlayer.m_rgAmmo( AMMO_SAW );
								int pAmmo2 = pPlayer.m_rgAmmo( AMMO_M16GRENADE );
								if ( ( bData[ i ] & SS_DISPENCER ) != 0 )
								{
									if ( pAmmo1 <= 540 )
										GiveItem( pPlayer, "ammo_556clip" );
								}
								
								if ( pAmmo1 < 600 )
									GiveItem( pPlayer, "ammo_556clip" );
								
								if ( demoman[ i ] > 0 )
								{
									int dluck = Math.RandomLong( 1, 100 );
									if ( dluck > 92 - demoman[ i ] )
									{
										if ( pAmmo2 < 10 )
											GiveItem( pPlayer, "ammo_ARgrenades" );
									}
								}
							}
							else if ( pWeapon.m_iId == WEAPON_SPORELAUNCHER )
							{
								int pAmmo = pPlayer.m_rgAmmo( AMMO_SPORE );
								if ( ( bData[ i ] & SS_DISPENCER ) != 0 )
								{
									if ( pAmmo <= 27 )
									{
										GiveItem( pPlayer, "ammo_sporeclip" );
										GiveItem( pPlayer, "ammo_sporeclip" );
									}
								}
								
								if ( pAmmo < 29 )
									GiveItem( pPlayer, "ammo_sporeclip" );
								if ( pAmmo < 30 )
									GiveItem( pPlayer, "ammo_sporeclip" );
							}
							else if ( pWeapon.m_iId == WEAPON_DESERT_EAGLE )
							{
								int pAmmo = pPlayer.m_rgAmmo( AMMO_357 );
								if ( ( bData[ i ] & SS_DISPENCER ) != 0 )
								{
									if ( pAmmo <= 24 )
										GiveItem( pPlayer, "ammo_357" );
								}
								
								if ( pAmmo < 36 )
									GiveItem( pPlayer, "ammo_357" );
							}
							else if ( pWeapon.m_iId == WEAPON_DISPLACER )
							{
								int pAmmo = pPlayer.m_rgAmmo( AMMO_GAUSS );
								if ( ( bData[ i ] & SS_DISPENCER ) != 0 )
								{
									if ( pAmmo <= 60 )
										GiveItem( pPlayer, "ammo_gaussclip" );
								}
								
								if ( pAmmo < 80 )
									GiveItem( pPlayer, "ammo_gaussclip" );
							}
							
							// Always give random ammo afterwards
							if ( ( bData[ i ] & SS_DISPENCER ) != 0 )
								scxpm_randomammo( i );
							
							scxpm_randomammo( i );
						}
						else
						{
							if ( ( bData[ i ] & SS_DISPENCER ) != 0 )
								scxpm_randomammo( i );
							
							scxpm_randomammo( i );
						}
						
						float speed_dt = float( speed[ i ] ) / 27.0; // 3.04
						rammowait[ i ] = 190.0 - ( 4.0 * float( rammo[ i ] ) ) - speed_dt;
					}
					else
						rammowait[ i ]--;
				}
				
				// medkit self-healing
				CBasePlayerItem@ pItem = cast< CBasePlayerItem@ >( pPlayer.m_hActiveItem.GetEntity() );
				if ( pItem !is null )
				{
					CBasePlayerWeapon@ pWeapon = pItem.GetWeaponPtr();
					
					if ( pWeapon.m_iId == WEAPON_MEDKIT )
					{
						if ( pPlayer.pev.health < 200 )
						{
							if ( pPlayer.pev.health < starthealth )
							{
								if ( Math.RandomFloat( ( float( rhealth[ i ] ) / 2.0 ), 800.0 - pPlayer.pev.health ) > 299.0 )
									pPlayer.pev.health = pPlayer.pev.health + 1.0;
							}
							else
							{
								if ( pPlayer.pev.health < ( float( rhealth[ i ] ) / 2.0 ) + starthealth + ( handicap9[ i ] ? 0.0 : Math.clamp( 0.0, 30.0, float( medals[ i ] ) ) ) + halfspeed && Math.RandomFloat( 0.0, 1300.0 + ( float( rhealth[ i ] ) / 2.0 ) ) > 1200.0 )
									pPlayer.pev.health = pPlayer.pev.health + 1.0;
							}
						}
					}
				}
				
				if ( dist[ i ] > 0 ) // team power
				{
					for ( int j = 1; j <= g_Engine.maxClients; j++ )
					{
						if ( i == j )
						{
							// Dummy
						}
						else
						{
							CBasePlayer@ pPlayer2 = g_PlayerFuncs.FindPlayerByIndex( j );
							
							if ( pPlayer2 !is null && pPlayer2.IsConnected() )
							{
								if ( pPlayer.pev.deadflag == DEAD_NO && pPlayer2.pev.deadflag == DEAD_NO )
								{
									Vector origin1 = pPlayer.pev.origin;
									Vector origin2 = pPlayer2.pev.origin;
									Vector distance = origin1 - origin2;
									if ( distance.Length() <= 512.0 )
									{
										float number = float( g_PlayerFuncs.GetNumPlayers() ) * 50.0;
										float luck = Math.RandomFloat( 1651.0 - number, 4200.0 + float( dist[ i ] ) + float( dist[ j ] ) + halfspeed );
										
										if ( luck > 4200.0 && pPlayer2.pev.health < 200.0 )
										{
											pPlayer2.pev.health = pPlayer2.pev.health + 1.0;
											if ( pPlayer2.pev.health > starthealth + 100.0 + dist[ i ] + ( handicap9[ i ] ? 0.0 : Math.clamp( 0.0, 30.0, float( medals[ i ] ) ) ) + halfspeed )
												pPlayer2.pev.health = starthealth + 100.0 + dist[ i ] + ( handicap9[ i ] ? 0.0 : Math.clamp( 0.0, 30.0, float( medals[ i ] ) ) ) + halfspeed;
										}
										luck = Math.RandomFloat( 1651.0 - number, 4200.0 + float( dist[ i ] ) + float( dist[ j ] ) + halfspeed );
										if ( luck > 4200.0 && pPlayer2.pev.armorvalue < 200.0 )
										{
											pPlayer2.pev.armorvalue = pPlayer2.pev.armorvalue + 1.0;
											if ( pPlayer2.pev.armorvalue > startarmor + 100.0 + dist[ i ] + ( handicap9[ i ] ? 0.0 : Math.clamp( 0.0, 30.0, float( medals[ i ] ) ) ) + halfspeed )
												pPlayer2.pev.armorvalue = startarmor + 100.0 + dist[ i ] + ( handicap9[ i ] ? 0.0 : Math.clamp( 0.0, 30.0, float( medals[ i ] ) ) ) + halfspeed;
										}
									}
								}
							}
						}
					}
				}
				
				// Block Attack has been moved to Player::TakeDamage hook
			}
		}
	}
}

void scxpm_updatehc()
{
	// Update handicaps
	for ( int i = 1; i <= g_Engine.maxClients; i++ )
	{
		CBasePlayer@ pPlayer = g_PlayerFuncs.FindPlayerByIndex( i );
		
		if ( pPlayer !is null && pPlayer.IsConnected() )
		{
			// Moved here rather than prethink so it is not that unefficient
			if ( handicap5[ i ] )
			{
				NetworkMessage hc5( MSG_ONE_UNRELIABLE, NetworkMessages::HideHUD, pPlayer.edict() );
				hc5.WriteByte( 11 );
				hc5.End();
			}
			
			if ( pPlayer.pev.deadflag == DEAD_NO )
			{
				// Medical Phobia and Obsolete Technology handicaps
				if ( handicap1[ i ] ) pPlayer.pev.max_health = pPlayer.pev.health;
				if ( handicap2[ i ] ) pPlayer.pev.armortype = pPlayer.pev.armorvalue;
				
				// Lost Bullets handicap
				if ( handicap11[ i ] )
				{
					pPlayer.SetMaxAmmo( AMMO_9MM, 32 ); // Use uzi as reference
					pPlayer.SetMaxAmmo( AMMO_357, 7 ); // Use desert eagle as reference
					pPlayer.SetMaxAmmo( AMMO_SHOTGUN, 8 );
					pPlayer.SetMaxAmmo( AMMO_CROSSBOW, 5 );
					pPlayer.SetMaxAmmo( AMMO_SAW, 30 ); // Minigun will be screwed, using saw as reference will give the m16 way too much ammo
					pPlayer.SetMaxAmmo( AMMO_M16GRENADE, 1 );
					pPlayer.SetMaxAmmo( AMMO_RPG, 1 );
					pPlayer.SetMaxAmmo( AMMO_GAUSS, 20 ); // clips yield 20 ammo, so use that value
					pPlayer.SetMaxAmmo( AMMO_SNIPER, 5 );
					pPlayer.SetMaxAmmo( AMMO_SPORE, 8 );
					pPlayer.RemoveAllExcessAmmo();
				}
				
				// Bleeding View handicap
				if ( handicap14[ i ] )
				{
					// Check health, concuss should be null when healthy, and worsen the lower the HP
					float flHealth = pPlayer.pev.health;
					if ( flHealth > 60.0 )
						g_PlayerFuncs.ConcussionEffect( pPlayer, 0.0, 0.0, 0.0 ); // All zero to remove
					else if ( flHealth > 40.0 ) 
						g_PlayerFuncs.ConcussionEffect( pPlayer, 35.0, 0.7, 0.7 );
					else if ( flHealth > 20.0 )
						g_PlayerFuncs.ConcussionEffect( pPlayer, 40.0, 0.75, 0.75 ); 
					else
						g_PlayerFuncs.ConcussionEffect( pPlayer, 45.0, 0.9, 0.9 );
				}
				
				// Limited equipment handicap
				if ( handicap7[ i ] )
				{
					CBasePlayerItem@ pCurrentItem = cast< CBasePlayerItem@ >( pPlayer.m_hActiveItem.GetEntity() );
					if ( pCurrentItem !is null )
					{
						CBasePlayerWeapon@ pCurrentWeapon = pCurrentItem.GetWeaponPtr();
						
						for ( uint j = 0; j < MAX_ITEM_TYPES; j++ )
						{
							CBasePlayerItem@ pCheckItem = pPlayer.m_rgpPlayerItems( j );
							if ( pCheckItem !is null )
							{
								CBasePlayerWeapon@ pCheckWeapon = pCheckItem.GetWeaponPtr();
								
								// Remove ALL weapons but the one he's handling now
								if ( pCheckWeapon.m_iId != pCurrentWeapon.m_iId )
									pPlayer.RemovePlayerItem( pCheckItem );
							}
						}
					}
				}
			}
		}
	}
}

HookReturnCode PlayerKilled( CBasePlayer@ pPlayer, CBaseEntity@ pAttacker, int iGib )
{
	if ( gDisabled )
		return HOOK_CONTINUE;
	
	int index = pPlayer.entindex();
	if ( handicap3[ index ] ) // Nitrogen Blood
	{
		pPlayer.pev.solid = SOLID_NOT; // I do no longer remember why I put this in here. -Giegue
		pPlayer.GibMonster();
		pPlayer.pev.effects |= EF_NODRAW;
	}
	
	// Disallow players from gaining score (and so, XP) caused by friendly fire handicap
	if ( pAttacker.IsPlayer() && pAttacker !is pPlayer ) // ignore suicide
	{
		// If this is a PvP map, allow the score
		if ( !gAllowPVPScore )
		{
			// Not a PvP map. Remove the score!
			pAttacker.pev.frags -= 1.0;
		}
	}
	
	return HOOK_CONTINUE;
}

// Assuming this is POST hook, otherwise hud WILL get bugged
HookReturnCode WeaponPrimaryAttack( CBasePlayer@ pPlayer, CBasePlayerWeapon@ pWeapon )
{
	// Don't
	if ( gDisabled || gNoSkills )
		return HOOK_CONTINUE;
	
	int index = pPlayer.entindex();
	if ( practiceshot[ index ] > 0 && !handicap9[ index ] )
	{
		// Don't care if the player is underwater, even if the weapon can fire
		if ( pPlayer.pev.waterlevel != WATERLEVEL_HEAD )
		{
			// Only care if using one of the following weapons
			int iID = pWeapon.m_iId;
			if ( iID == WEAPON_GLOCK || iID == WEAPON_PYTHON || iID == WEAPON_MP5 || iID == WEAPON_CROSSBOW || iID == WEAPON_SHOTGUN || iID == WEAPON_SNIPERRIFLE || iID == WEAPON_M249 || iID == WEAPON_DESERT_EAGLE || iID == WEAPON_M16 )
			{
				// Don't let the function run if we have no ammo on our clip (prevents infinite ammo exploitation)
				if ( pWeapon.m_iClip > 0 )
				{
					if ( Math.RandomLong( 1, 100 ) > 100 - ( practiceshot[ index ] * 5 ) )
						pWeapon.m_iClip++;
				}
			}
		}
	}
	
	return HOOK_CONTINUE;
}

// Medkit special skill
HookReturnCode WeaponTertiaryAttack( CBasePlayer@ pPlayer, CBasePlayerWeapon@ pWeapon )
{
	// Don't
	if ( gDisabled || gNoSkills )
		return HOOK_CONTINUE;
	
	int index = pPlayer.entindex();
	if ( ( bData[ index ] & SS_RANGEHEAL ) != 0 && !handicap9[ index ] )
	{
		// Medkit only
		if ( pWeapon.m_iId == WEAPON_MEDKIT )
		{
			// Don't spam
			if ( g_Engine.time > pWeapon.m_flNextTertiaryAttack )
			{
				int iAmmo = int( g_EngineFuncs.CVarGetFloat( "sk_plr_HpMedic" ) );
				
				// Enough ammo for this?
				if ( pPlayer.m_rgAmmo( AMMO_MEDKIT ) >= iAmmo )
				{
					// Get aiment
					g_EngineFuncs.MakeVectors( pPlayer.pev.v_angle );
					
					// Create medkit
					CBaseEntity@ pMedkit = g_EntityFuncs.Create( "scxpm_medkit_dart", pPlayer.pev.origin + g_Engine.v_forward * 16, pPlayer.pev.angles, true, pPlayer.edict() );
					pMedkit.KeyValue( "forward_vector", g_Engine.v_forward.ToString() );
					g_EntityFuncs.DispatchSpawn( pMedkit.edict() );
					
					// Decrement ammo
					pPlayer.m_rgAmmo( AMMO_MEDKIT, pPlayer.m_rgAmmo( AMMO_MEDKIT ) - iAmmo );
				}
				
				// Wait 'till this time
				pWeapon.m_flNextTertiaryAttack = g_Engine.time + 0.5;
			}
		}
	}
	
	return HOOK_CONTINUE;
}

void scxpm_randomammo( const int& in index )
{
	CBasePlayer@ pPlayer = g_PlayerFuncs.FindPlayerByIndex( index );
	
	int number = Math.RandomLong( 0, 11 );
	
	if ( number == 0 )
	{
		int pAmmo = pPlayer.m_rgAmmo( AMMO_9MM );
		
		if ( pAmmo < 250 )
			GiveItem( pPlayer, "ammo_9mmclip" );
		else
			number = 1;
	}
	if ( number == 1 )
	{
		int pAmmo = pPlayer.m_rgAmmo( AMMO_357 );
		
		if ( pAmmo < 36 )
			GiveItem( pPlayer, "ammo_357" );
		else
			number = 2;
	}
	if ( number == 2 )
	{
		int pAmmo = pPlayer.m_rgAmmo( AMMO_9MM );
		
		if ( pAmmo < 250 )
			GiveItem( pPlayer, "ammo_9mmAR" );
		else
			number = 3;
	}
	if ( number == 3 )
	{
		int pAmmo = pPlayer.m_rgAmmo( AMMO_CROSSBOW );
		
		if ( pAmmo < 50 )
			GiveItem( pPlayer, "ammo_crossbow" );
		else
			number = 4;
	}
	if ( number == 4 )
	{
		int pAmmo = pPlayer.m_rgAmmo( AMMO_SHOTGUN );
		
		if ( pAmmo < 125 )
			GiveItem( pPlayer, "ammo_buckshot" );
		else
			number = 5;
	}
	if ( number == 5 )
	{
		int pAmmo = pPlayer.m_rgAmmo( AMMO_RPG );
		
		if ( pAmmo < 5 )
			GiveItem( pPlayer, "ammo_rpgclip" );
		else
			number = 6;
	}
	if ( number == 6 )
	{
		int pAmmo = pPlayer.m_rgAmmo( AMMO_GAUSS );
		
		if ( pAmmo < 100 )
			GiveItem( pPlayer, "ammo_gaussclip" );
		else
			number = 7;
	}
	if ( number == 7 )
	{
		int pAmmo = pPlayer.m_rgAmmo( AMMO_9MM );
		
		if ( pAmmo < 250 )
			GiveItem( pPlayer, "ammo_uziclip" );
		else
			number = 8;
	}
	if ( number == 8 )
	{
		int pAmmo = pPlayer.m_rgAmmo( AMMO_SNIPER );
		
		if ( pAmmo < 15 )
			GiveItem( pPlayer, "ammo_762" );
		else
			number = 9;
	}
	if ( number == 9 )
	{
		int pAmmo = pPlayer.m_rgAmmo( AMMO_SAW );
		
		if ( pAmmo < 600 )
			GiveItem( pPlayer, "ammo_556" );
		else
			number = 10;
	}
	if ( number == 10 )
	{
		int pAmmo = pPlayer.m_rgAmmo( AMMO_SAW );
		
		if ( pAmmo < 600 )
			GiveItem( pPlayer, "ammo_556clip" );
		else
			number = 11;
	}
	if ( number == 11 )
	{
		int pAmmo = pPlayer.m_rgAmmo( AMMO_SPORE );
		
		if ( pAmmo < 29 )
			GiveItem( pPlayer, "ammo_sporeclip" );
		if ( pAmmo < 30 )
			GiveItem( pPlayer, "ammo_sporeclip" );
	}
}

void scxpm_client_spawn( const int& in index )
{
	CBasePlayer@ pPlayer = g_PlayerFuncs.FindPlayerByIndex( index );
	if ( pPlayer !is null && pPlayer.IsConnected() )
	{
		// Weak Restart handicap
		if ( handicap12[ index ] )
		{
			pPlayer.pev.health = 25;
			pPlayer.pev.armorvalue = 0;
		}
		
		// Skills disabled, don't continue
		if ( gNoSkills )
			return;
		
		starthealth = pPlayer.pev.health;
		startarmor = pPlayer.pev.armorvalue;
		
		// handicap9 = Lacking Help handicap
		pPlayer.pev.health = ( float( health[ index ] ) / 2.0 ) + starthealth + ( handicap9[ index ] ? 0.0 : Math.clamp( 0.0, 30.0, float( medals[ index ] ) ) );
		pPlayer.pev.armorvalue = ( float( armor[ index ] ) / 2.0 ) + startarmor + ( handicap9[ index ] ? 0.0 : Math.clamp( 0.0, 30.0, float( medals[ index ] ) ) );
		
		// Don't allow health/armor to become too high
		if ( pPlayer.pev.health > 200 )
		{
			pPlayer.pev.health = 200;
			starthealth = 100;
		}
		if ( pPlayer.pev.armorvalue > 200 )
		{
			pPlayer.pev.armorvalue = 200;
			startarmor = 100;
		}
		
		// Starting Attack
		if ( spawndmg[ index ] > 0 && !handicap9[ index ] )
		{
			CBaseEntity@ ent = null;
			while( ( @ent = g_EntityFuncs.FindEntityInSphere( ent, pPlayer.pev.origin, 360.0, "*", "classname" ) ) !is null )
			{
				string cname = ent.pev.classname;
				if ( cname.StartsWith( "monster_" ) && cname != "monster_generic" && cname != "monster_furniture" )
				{
					if ( !ent.IsPlayerAlly() && ent.IsAlive() )
					{
						ent.TakeDamage( pPlayer.pev, pPlayer.pev, 20.0 * float( spawndmg[ index ] ), DMG_ENERGYBEAM );
						
						Vector mOrigin = ent.pev.origin;
						NetworkMessage effect( MSG_BROADCAST, NetworkMessages::SVC_TEMPENTITY );
						effect.WriteByte( TE_IMPLOSION );
						effect.WriteCoord( mOrigin.x );
						effect.WriteCoord( mOrigin.y );
						effect.WriteCoord( mOrigin.z + 8.0 );
						effect.WriteByte( 47 + spawndmg[ index ] ); // Radius
						effect.WriteByte( spawndmg[ index ] * 10 ); // Count
						effect.WriteByte( 4 ); // Life
						effect.End();
					}
				}
			}
		}
		
		// Reset Red Cross ammo data on spawn/respawn
		// Only if medkit can be recharged!
		if ( pPlayer.GetMaxAmmo( AMMO_MEDKIT ) > 0 )
		{
			pPlayer.SetMaxAmmo( AMMO_MEDKIT, 100 + ( redcross[ index ] * 15 ) );
			if ( pPlayer.m_rgAmmo( AMMO_MEDKIT ) > pPlayer.GetMaxAmmo( AMMO_MEDKIT ) ) pPlayer.RemoveExcessAmmo( AMMO_MEDKIT );
		}
	}
}

HookReturnCode PlayerPreThink( CBasePlayer@ pPlayer, uint& out dummy )
{
	if ( gDisabled )
		return HOOK_CONTINUE;
	
	int index = pPlayer.entindex();
	
	int deadflag = pPlayer.pev.deadflag;
	if ( deadflag == 0 && lastDeadflag[ index ] > 0 )
		scxpm_client_spawn( index );
	lastDeadflag[ index ] = deadflag;
	
	// Dangerous Waters handicap
	if ( handicap13[ index ] )
	{
		// Must be underwater
		if ( pPlayer.pev.waterlevel == WATERLEVEL_HEAD )
		{
			// Instant drowning!
			pPlayer.pev.air_finished = 0.0;
		}
	}
	
	// No skills
	if ( gNoSkills )
		return HOOK_CONTINUE;
	
	// Anti-Gravity skill
	if ( ( pPlayer.pev.button & IN_JUMP ) != 0 )
		gravityon( index );
	else
	{
		if ( ( pPlayer.pev.oldbuttons & IN_JUMP ) != 0 )
			gravityoff( index );
	}
	
	return HOOK_CONTINUE;
}

HookReturnCode PlayerTakeDamage( DamageInfo@ diData )
{
	// GODDAMNIT!
	//
	// CBasePlayer@ pPlayer = cast< CBasePlayer@ >( diData.pVictim );
	// Can't implicitly convert from 'const CBaseEntity@' to 'CBaseEntity@&
	//
	// Just... WHY?!
	
	entvars_t@ pStupidThing = @diData.pVictim.pev;
	CBasePlayer@ pPlayer = cast< CBasePlayer@ >( g_EntityFuncs.Instance( pStupidThing ) );
	
	int index = pPlayer.entindex();
	
	// Karmic Retribution handicap
	if ( handicap4[ index ] )
	{
		if ( !FNullEnt( pPlayer.pev.dmg_inflictor ) ) // Should exclude worldspawn (falldamage)
		{
			// Do not continuously poison the player if it is not taking any damage
			if ( diData.pAttacker.entindex() != 0 && diData.pInflictor.entindex() != index )
			{
				// Set all damage to poison
				diData.bitsDamageType |= DMG_POISON;
			}
		}
	}
	
	// Big Explosion handicap
	if ( handicap6[ index ] )
	{
		// Check damagetype. Only affect if these...
		int iDamageType = diData.bitsDamageType;
		if ( ( iDamageType & DMG_BLAST ) != 0 || ( iDamageType & DMG_MORTAR ) != 0 )
		{
			// Get and increase damage
			float flNewDamage = diData.flDamage;
			flNewDamage = flNewDamage * 175.0 / 100.0;
			diData.flDamage = flNewDamage;
		}
	}
	
	// Friendly Fire handicap
	if ( handicap10[ index ] )
	{
		// Another player trying to hurt this person?
		if ( diData.pAttacker.Classify() == CLASS_PLAYER )
		{
			// Ignore self-damage, as this would let the player use explosives to kill other players!
			if ( diData.pAttacker.entindex() != index )
			{
				// Since this is a PRE hook, we change the classify to allow the damage
				// Then after a very short while, reverse the change (POST)
				pPlayer.KeyValue( "classify", "-1" );
				g_Scheduler.SetTimeout( "PlayerTakeDamage_Post", 0.000001, index );
			}
		}
	}
	
	// Don't run any further...
	if ( gNoSkills )
		return HOOK_CONTINUE;
	
	// Block Attack
	if ( dodge[ index ] > 0 )
	{
		float piecespeed = float( speed[ index ] ) / 9.0;
		
		float luck;
		float totaldodge;
		float extradodge;
		
		totaldodge = float( dodge[ index ] );
		
		if ( !handicap9[ index ] ) // Lacking Help handicap
			extradodge = Math.clamp( 0.0, 30.0, float( medals[ index ] ) );
		else
			extradodge = 0.0;
		
		luck = Math.RandomFloat( 0.0, 185.0 + totaldodge + extradodge + piecespeed );
		
		if ( luck > 185.0 )
		{
			// Don't fully block the TakeDamage call, we still want the player to know where the damage is coming from
			diData.flDamage = 0.1; // Should be enough
		}
	}
	
	return HOOK_CONTINUE;
}
void PlayerTakeDamage_Post( const int& in index )
{
	CBasePlayer@ pPlayer = g_PlayerFuncs.FindPlayerByIndex( index );
	if ( pPlayer !is null && pPlayer.IsConnected() )
	{
		pPlayer.KeyValue( "classify", "2" ); // 2 = CLASS_PLAYER
	}
}

void gravityon( const int& in index )
{
	CBasePlayer@ pPlayer = g_PlayerFuncs.FindPlayerByIndex( index );
	
	if ( pPlayer !is null && pPlayer.IsConnected() )
	{
		if ( pPlayer.pev.deadflag == DEAD_NO )
		{
			// handicap8 = Dead Weight handicap | handicap9 = Missing Help handicap
			pPlayer.pev.gravity = ( handicap8[ index ] ? 1.25 : 1.00 ) - ( 0.012 * float( gravity[ index ] ) ) - ( 0.001 * ( handicap9[ index ] ? 0.0 : Math.clamp( 0.0, 30.0, float( medals[ index ] ) ) ) );
		}
	}
}

void gravityoff( const int& in index )
{
	CBasePlayer@ pPlayer = g_PlayerFuncs.FindPlayerByIndex( index );
	
	if ( pPlayer !is null && pPlayer.IsConnected() )
	{
		if ( pPlayer.pev.deadflag == DEAD_NO )
			pPlayer.pev.gravity = ( handicap8[ index ] ? 1.25 : 1.00 );
	}
}

void scxpm_breset( const int& in index, bool silent = false )
{
	CBasePlayer@ pPlayer = g_PlayerFuncs.FindPlayerByIndex( index );
	
	// No skills
	if ( gNoSkills )
	{
		g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "[SCXPM] Skills are disabled on this map.\n" );
		return;
	}
	
	CustomKeyvalues@ pSkills = pPlayer.GetCustomKeyvalues();
	
	if ( bSaveOldSkills )
	{
		CustomKeyvalue old_health_pre( pSkills.GetKeyvalue( "$i_old_health" ) );
		CustomKeyvalue old_armor_pre( pSkills.GetKeyvalue( "$i_old_armor" ) );
		CustomKeyvalue old_rhealth_pre( pSkills.GetKeyvalue( "$i_old_rhealth" ) );
		CustomKeyvalue old_rarmor_pre( pSkills.GetKeyvalue( "$i_old_rarmor" ) );
		CustomKeyvalue old_rammo_pre( pSkills.GetKeyvalue( "$i_old_rammo" ) );
		CustomKeyvalue old_gravity_pre( pSkills.GetKeyvalue( "$i_old_gravity" ) );
		CustomKeyvalue old_speed_pre( pSkills.GetKeyvalue( "$i_old_speed" ) );
		CustomKeyvalue old_dist_pre( pSkills.GetKeyvalue( "$i_old_dist" ) );
		CustomKeyvalue old_dodge_pre( pSkills.GetKeyvalue( "$i_old_dodge" ) );
		
		int old_health = old_health_pre.GetInteger();
		int old_armor = old_armor_pre.GetInteger();
		int old_rhealth = old_rhealth_pre.GetInteger();
		int old_rarmor = old_rarmor_pre.GetInteger();
		int old_rammo = old_rammo_pre.GetInteger();
		int old_gravity = old_gravity_pre.GetInteger();
		int old_speed = old_speed_pre.GetInteger();
		int old_dist = old_dist_pre.GetInteger();
		int old_dodge = old_dodge_pre.GetInteger();
		
		pSkills.SetKeyvalue( "$i_old_health", ( old_health + health[ index ] ) );
		pSkills.SetKeyvalue( "$i_old_armor", ( old_armor + armor[ index ] ) );
		pSkills.SetKeyvalue( "$i_old_rhealth", ( old_rhealth + rhealth[ index ] ) );
		pSkills.SetKeyvalue( "$i_old_rarmor", ( old_rarmor + rarmor[ index ] ) );
		pSkills.SetKeyvalue( "$i_old_rammo", ( old_rammo + rammo[ index ] ) );
		pSkills.SetKeyvalue( "$i_old_gravity", ( old_gravity + gravity[ index ] ) );
		pSkills.SetKeyvalue( "$i_old_speed", ( old_speed + speed[ index ] ) );
		pSkills.SetKeyvalue( "$i_old_dist", ( old_dist + dist[ index ] ) );
		pSkills.SetKeyvalue( "$i_old_dodge", ( old_dodge + dodge[ index ] ) );
	}
	
	health[ index ] = 0;
	armor[ index ] = 0;
	rhealth[ index ] = 0;
	rarmor[ index ] = 0;
	rammo[ index ] = 0;
	gravity[ index ] = 0;
	speed[ index ] = 0;
	dist[ index ] = 0;
	dodge[ index ] = 0;
	
	pSkills.SetKeyvalue( "$i_health", 0 );
	pSkills.SetKeyvalue( "$i_armor", 0 );
	pSkills.SetKeyvalue( "$i_rhealth", 0 );
	pSkills.SetKeyvalue( "$i_rarmor", 0 );
	pSkills.SetKeyvalue( "$i_rammo", 0 );
	pSkills.SetKeyvalue( "$i_gravity", 0 );
	pSkills.SetKeyvalue( "$i_speed", 0 );
	pSkills.SetKeyvalue( "$i_dist", 0 );
	pSkills.SetKeyvalue( "$i_dodge", 0 );
	
	skillpoints[ index ] = Math.clamp( 0, 700, playerlevel[ index ] );
	
	if ( pPlayer.pev.health > starthealth + ( handicap9[ index ] ? 0.0 : Math.clamp( 0.0, 30.0, float( medals[ index ] ) ) ) )
		pPlayer.pev.health = starthealth + ( handicap9[ index ] ? 0.0 : Math.clamp( 0.0, 30.0, float( medals[ index ] ) ) );
	
	if ( pPlayer.pev.armorvalue > startarmor + ( handicap9[ index ] ? 0.0 : Math.clamp( 0.0, 30.0, float( medals[ index ] ) ) ) )
		pPlayer.pev.armorvalue = startarmor + ( handicap9[ index ] ? 0.0 : Math.clamp( 0.0, 30.0, float( medals[ index ] ) ) );
	
	pPlayer.pev.gravity = 1.0;
	
	if ( !silent )
	{
		if ( skillpoints[ index ] > 0 )
		{
			g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "[SCXPM] Your skills has been reset.\n" );
			g_Scheduler.SetTimeout( "SCXPMSkill", 0.01, index );
		}
		else
			g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "[SCXPM] No skills to reset.\n" );
	}
}

void scxpm_sreset( const int& in index )
{
	CBasePlayer@ pPlayer = g_PlayerFuncs.FindPlayerByIndex( index );
	
	// No skills
	if ( gNoSkills )
	{
		g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "[SCXPM] Skills are disabled on this map.\n" );
		return;
	}
	
	if ( ( bData[ index ] & SS_DISPENCER ) != 0 )
		bData[ index ] &= ~SS_DISPENCER;
	
	if ( ( bData[ index ] & SS_RANGEHEAL ) != 0 )
		bData[ index ] &= ~SS_RANGEHEAL;
	
	spawndmg[ index ] = 0;
	ubercharge[ index ] = 0;
	fastheal[ index ] = 0;
	demoman[ index ] = 0;
	practiceshot[ index ] = 0;
	bioelectric[ index ] = 0;
	redcross[ index ] = 0;
	pPlayer.SetMaxAmmo( AMMO_MEDKIT, 100 );
	if ( pPlayer.m_rgAmmo( AMMO_MEDKIT ) > pPlayer.GetMaxAmmo( AMMO_MEDKIT ) ) pPlayer.RemoveExcessAmmo( AMMO_MEDKIT ); // Prevent overflow
	
	specialpoints[ index ] = Math.clamp( 0, 30, medals[ index ] );
	
	if ( specialpoints[ index ] > 0 )
	{
		g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "[SCXPM] Your special skills has been reset.\n" );
		g_Scheduler.SetTimeout( "SCXPMSpecials", 0.01, index );
	}
	else
		g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "[SCXPM] No special skills to reset.\n" );
}

void SCXPMSkill( const int& in index )
{
	// No skills
	if ( gNoSkills )
	{
		CBasePlayer@ pPlayer = g_PlayerFuncs.FindPlayerByIndex( index );
		g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "[SCXPM] Skills are disabled on this map.\n" );
		return;
	}
	
	skillIncrement[ index ] = 1;
	if ( skillpoints[ index ] > 24 )
		SCXPMIncrementMenu( index );
	else
		SCXPMSkillMenu( index );
}

void SCXPMIncrementMenu( const int& in index )
{
	CBasePlayer@ pPlayer = g_PlayerFuncs.FindPlayerByIndex( index );
	MenuHandler@ state = MenuGetPlayer( pPlayer );
	
	state.InitMenu( pPlayer, SCXPMIncrementChoice );
	state.menu.SetTitle( "How many Skillpoints to use?\n\n" );
	
	state.menu.AddItem( "1 Skillpoint\n", any( "item1" ) );
	state.menu.AddItem( "5 Skillpoints\n", any( "item2" ) );
	state.menu.AddItem( "10 Skillpoints\n", any( "item3" ) );
	state.menu.AddItem( "25 Skillpoints\n", any( "item4" ) );
	
	if ( skillpoints[ index ] >= 50 )
		state.menu.AddItem( "50 Skillpoints\n", any( "item5" ) );
	
	if ( skillpoints[ index ] >= 100 )
		state.menu.AddItem( "100 Skillpoints", any( "item6" ) );
	
	state.OpenMenu( pPlayer, 0, 0 );
}

void SCXPMIncrementChoice( CTextMenu@ menu, CBasePlayer@ pPlayer, int page, const CTextMenuItem@ item )
{
	int index = pPlayer.entindex();
	if ( page == 10 ) return;
	
	string selection;
	item.m_pUserData.retrieve( selection );
	if ( selection == 'item1' )
		skillIncrement[ index ] = 1;
	if ( selection == 'item2' )
		skillIncrement[ index ] = 5;
	if ( selection == 'item3' )
		skillIncrement[ index ] = 10;
	if ( selection == 'item4' )
		skillIncrement[ index ] = 25;
	if ( selection == 'item5' )
		skillIncrement[ index ] = 50;
	if ( selection == 'item6' )
		skillIncrement[ index ] = 100;
	
	g_Scheduler.SetTimeout( "SCXPMSkillMenu", 0.01, index );
}

void SCXPMSkillMenu( const int& in index )
{
	CBasePlayer@ pPlayer = g_PlayerFuncs.FindPlayerByIndex( index );
	MenuHandler@ state = MenuGetPlayer( pPlayer );
	
	state.InitMenu( pPlayer, SCXPMSkillChoice );
	
	string titletext = "Skills\n\n";
	titletext += "Available Skillpoints: " + skillpoints[ index ] + "\n\n";
	
	string skill1text = "Strength [ " + health[ index ] + " ]\n";
	string skill2text = "Superior Armor [ " + armor[ index ] + " ]\n";
	string skill3text = "Regeneration [ " + rhealth[ index ] + " ]\n";
	string skill4text = "Nano Armor [ " + rarmor[ index ] + " ]\n";
	string skill5text = "Ammo Reincarnation [ " + rammo[ index ] + " ]\n";
	string skill6text = "Anti-Gravity Device [ " + gravity[ index ] + " ]\n";
	string skill7text = "Awareness [ " + speed[ index ] + " ]\n";
	string skill8text = "Team Power [ " + dist[ index ] + " ]\n";
	string skill9text = "Block Attack [ " + dodge[ index ] + " ]";
	
	state.menu.SetTitle( titletext );
	
	state.menu.AddItem( skill1text, any( "item1" ) );
	state.menu.AddItem( skill2text, any( "item2" ) );
	state.menu.AddItem( skill3text, any( "item3" ) );
	state.menu.AddItem( skill4text, any( "item4" ) );
	state.menu.AddItem( skill5text, any( "item5" ) );
	state.menu.AddItem( skill6text, any( "item6" ) );
	state.menu.AddItem( skill7text, any( "item7" ) );
	state.menu.AddItem( skill8text, any( "item8" ) );
	state.menu.AddItem( skill9text, any( "item9" ) );
	
	state.OpenMenu( pPlayer, 0, 0 );
}

void SCXPMSkillChoice( CTextMenu@ menu, CBasePlayer@ pPlayer, int page, const CTextMenuItem@ item )
{
	int index = pPlayer.entindex();
	if ( page == 10 ) return;
	
	CustomKeyvalues@ pSkills = pPlayer.GetCustomKeyvalues();
	
	string selection;
	item.m_pUserData.retrieve( selection );
	if ( selection == 'item1' )
	{
		if ( skillpoints[ index ] > 0 )
		{
			if ( health[ index ] < 88 + ( ubercharge[ index ] * 4 ) )
			{
				if ( skillIncrement[ index ] + health[ index ] >= 88 + ( ubercharge[ index ] * 4 ) )
					skillIncrement[ index ] = 88 + ( ubercharge[ index ] * 4 ) - health[ index ];
				
				skillpoints[ index ] -= skillIncrement[ index ];
				health[ index ] += skillIncrement[ index ];
				
				pSkills.SetKeyvalue( "$i_health", health[ index ] );
			}
			else
				g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "[SCXPM] This skill is maxed out!\n" );
			
			g_Scheduler.SetTimeout( "SCXPMSkill", 0.01, index );
		}
		else
			g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "[SCXPM] You need at least 1 Skillpoint to enhance your Strength.\n" );
	}
	else if ( selection == 'item2' )
	{
		if ( skillpoints[ index ] > 0 )
		{
			if ( armor[ index ] < 88 + ( ubercharge[ index ] * 4 ) )
			{
				if ( skillIncrement[ index ] + armor[ index ] >= 88 + ( ubercharge[ index ] * 4 ) )
					skillIncrement[ index ] = 88 + ( ubercharge[ index ] * 4 ) - armor[ index ];
				
				skillpoints[ index ] -= skillIncrement[ index ];
				armor[ index ] += skillIncrement[ index ];
				
				pSkills.SetKeyvalue( "$i_armor", armor[ index ] );
			}
			else
				g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "[SCXPM] This skill is maxed out!\n" );
			
			g_Scheduler.SetTimeout( "SCXPMSkill", 0.01, index );
		}
		else
			g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "[SCXPM] You need at least 1 Skillpoint to enhance your Superior Armor.\n" );
	}
	else if ( selection == 'item3' )
	{
		if ( skillpoints[ index ] > 0 )
		{
			if ( rhealth[ index ] < 70 + ( ubercharge[ index ] * 3 ) )
			{
				if ( skillIncrement[ index ] + rhealth[ index ] >= 70 + ( ubercharge[ index ] * 3 ) )
					skillIncrement[ index ] = 70 + ( ubercharge[ index ] * 3 ) - rhealth[ index ];
				
				skillpoints[ index ] -= skillIncrement[ index ];
				rhealth[ index ] += skillIncrement[ index ];
				
				pSkills.SetKeyvalue( "$i_rhealth", rhealth[ index ] );
			}
			else
				g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "[SCXPM] This skill is maxed out!\n" );
			
			g_Scheduler.SetTimeout( "SCXPMSkill", 0.01, index );
		}
		else
			g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "[SCXPM] You need at least 1 Skillpoint to enhance your Regeneration.\n" );
	}
	else if ( selection == 'item4' )
	{
		if ( skillpoints[ index ] > 0 )
		{
			if ( rarmor[ index ] < 70 + ( ubercharge[ index ] * 3 ) )
			{
				if ( skillIncrement[ index ] + rarmor[ index ] >= 70 + ( ubercharge[ index ] * 3 ) )
					skillIncrement[ index ] = 70 + ( ubercharge[ index ] * 3 ) - rarmor[ index ];
				
				skillpoints[ index ] -= skillIncrement[ index ];
				rarmor[ index ] += skillIncrement[ index ];
				
				pSkills.SetKeyvalue( "$i_rarmor", rarmor[ index ] );
			}
			else
				g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "[SCXPM] This skill is maxed out!\n" );
			
			g_Scheduler.SetTimeout( "SCXPMSkill", 0.01, index );
		}
		else
			g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "[SCXPM] You need at least 1 Skillpoint to enhance your Nano Armor.\n" );
	}
	else if ( selection == 'item5' )
	{
		if ( skillpoints[ index ] > 0 )
		{
			if ( rammo[ index ] < 15 + ubercharge[ index ] )
			{
				if ( skillIncrement[ index ] + rammo[ index ] >= 15 + ubercharge[ index ] )
					skillIncrement[ index ] = 15 + ubercharge[ index ] - rammo[ index ];
				
				skillpoints[ index ] -= skillIncrement[ index ];
				rammo[ index ] += skillIncrement[ index ];
				
				pSkills.SetKeyvalue( "$i_rammo", rammo[ index ] );
			}
			else
				g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "[SCXPM] This skill is maxed out!\n" );
			
			g_Scheduler.SetTimeout( "SCXPMSkill", 0.01, index );
		}
		else
			g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "[SCXPM] You need at least 1 Skillpoint to enhance your Ammo Reincarnation.\n" );
	}
	else if ( selection == 'item6' )
	{
		if ( skillpoints[ index ] > 0 )
		{
			if ( gravity[ index ] < 19 + ( ubercharge[ index ] * 2 ) )
			{
				if ( skillIncrement[ index ] + gravity[ index ] >= 19 + ( ubercharge[ index ] * 2 ) )
					skillIncrement[ index ] = 19 + ( ubercharge[ index ] * 2 ) - gravity[ index ];
				
				skillpoints[ index ] -= skillIncrement[ index ];
				gravity[ index ] += skillIncrement[ index ];
				
				pSkills.SetKeyvalue( "$i_gravity", gravity[ index ] );
			}
			else
				g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "[SCXPM] This skill is maxed out!\n" );
			
			g_Scheduler.SetTimeout( "SCXPMSkill", 0.01, index );
		}
		else
			g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "[SCXPM] You need at least 1 Skillpoint to enhance your Anti-Gravity Device.\n" );
	}
	else if ( selection == 'item7' )
	{
		if ( skillpoints[ index ] > 0 )
		{
			if ( speed[ index ] < 50 + ( ubercharge[ index ] * 4 ) )
			{
				if ( skillIncrement[ index ] + speed[ index ] >= 50 + ( ubercharge[ index ] * 4 ) )
					skillIncrement[ index ] = 50 + ( ubercharge[ index ] * 4 ) - speed[ index ];
				
				skillpoints[ index ] -= skillIncrement[ index ];
				speed[ index ] += skillIncrement[ index ];
				
				pSkills.SetKeyvalue( "$i_speed", speed[ index ] );
			}
			else
				g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "[SCXPM] This skill is maxed out!\n" );
			
			g_Scheduler.SetTimeout( "SCXPMSkill", 0.01, index );
		}
		else
			g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "[SCXPM] You need at least 1 Skillpoint to enhance your Awareness.\n" );
	}
	else if ( selection == 'item8' )
	{
		if ( skillpoints[ index ] > 0 )
		{
			if ( dist[ index ] < 30 + ( ubercharge[ index ] * 3 ) )
			{
				if ( skillIncrement[ index ] + dist[ index ] >= 30 + ( ubercharge[ index ] * 3 ) )
					skillIncrement[ index ] = 30 + ( ubercharge[ index ] * 3 ) - dist[ index ];
				
				skillpoints[ index ] -= skillIncrement[ index ];
				dist[ index ] += skillIncrement[ index ];
				
				pSkills.SetKeyvalue( "$i_dist", dist[ index ] );
			}
			else
				g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "[SCXPM] This skill is maxed out!\n" );
			
			g_Scheduler.SetTimeout( "SCXPMSkill", 0.01, index );
		}
		else
			g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "[SCXPM] You need at least 1 Skillpoint to enhance your Team Power.\n" );
	}
	else if ( selection == 'item9' )
	{
		if ( skillpoints[ index ] > 0 )
		{
			if ( dodge[ index ] < 45 + ubercharge[ index ] )
			{
				if ( skillIncrement[ index ] + dodge[ index ] >= 45 + ubercharge[ index ] )
					skillIncrement[ index ] = 45 + ubercharge[ index ] - dodge[ index ];
				
				skillpoints[ index ] -= skillIncrement[ index ];
				dodge[ index ] += skillIncrement[ index ];
				
				pSkills.SetKeyvalue( "$i_dodge", dodge[ index ] );
			}
			else
				g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "[SCXPM] This skill is maxed out!\n" );
			
			g_Scheduler.SetTimeout( "SCXPMSkill", 0.01, index );
		}
		else
			g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "[SCXPM] You need at least 1 Skillpoint to enhance your Block Attack.\n" );
	}
}

void SCXPMSpecials( const int& in index )
{
	CBasePlayer@ pPlayer = g_PlayerFuncs.FindPlayerByIndex( index );
	
	// No skills
	if ( gNoSkills )
	{
		g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "[SCXPM] Skills are disabled on this map.\n" );
		return;
	}
	
	specialpoints[ index ] = Math.clamp( 0, 30, medals[ index ] );
	
	// For some reason it ADDs rather than subtracting... Let's do this manually.
	specialpoints[ index ] -= spawndmg[ index ];
	specialpoints[ index ] -= ubercharge[ index ];
	specialpoints[ index ] -= fastheal[ index ];
	specialpoints[ index ] -= demoman[ index ];
	specialpoints[ index ] -= practiceshot[ index ];
	specialpoints[ index ] -= bioelectric[ index ];
	specialpoints[ index ] -= redcross[ index ];
	
	if ( ( bData[ index ] & SS_DISPENCER ) != 0 )
		specialpoints[ index ]--;
	if ( ( bData[ index ] & SS_RANGEHEAL ) != 0 )
		specialpoints[ index ]--;
	
	SCXPMSpecialMenu( index );
}

void SCXPMSpecialMenu( const int& in index )
{
	CBasePlayer@ pPlayer = g_PlayerFuncs.FindPlayerByIndex( index );
	MenuHandler@ state = MenuGetPlayer( pPlayer );
	
	state.InitMenu( pPlayer, SCXPMSpecialChoice );
	
	string titletext = "Special Skills\n\n";
	titletext += "Available Specialpoints: " + specialpoints[ index ] + "\n\n";
	
	string skill2text = "Portable Dispencer ";
	if ( ( bData[ index ] & SS_DISPENCER ) != 0 )
		skill2text += "[ YES ]\n";
	else
		skill2text += "[ NO ]\n";
	
	string skill8text = "Medical Emergency ";
	if ( ( bData[ index ] & SS_RANGEHEAL ) != 0 )
		skill8text += "[ YES ]\n";
	else
		skill8text += "[ NO ]\n";
	
	string skill1text = "Starting Attack [ " + spawndmg[ index ] + " ]\n";
	string skill3text = "Ubercharge [ " + ubercharge[ index ] + " ]\n";
	string skill4text = "Quick Heal [ " + fastheal[ index ] + " ]\n";
	string skill5text = "Demoman [ " + demoman[ index ] + " ]\n";
	string skill6text = "Practice Shot [ " + practiceshot[ index ] + " ]\n";
	string skill7text = "BioElectric [ " + bioelectric[ index ] + " ]\n";
	string skill9text = "Red Cross [ " + redcross[ index ] + " ]\n";
	
	state.menu.SetTitle( titletext );
	
	state.menu.AddItem( skill1text, any( "item1" ) );
	state.menu.AddItem( skill2text, any( "item2" ) );
	state.menu.AddItem( skill3text, any( "item3" ) );
	state.menu.AddItem( skill4text, any( "item4" ) );
	state.menu.AddItem( skill5text, any( "item5" ) );
	state.menu.AddItem( skill6text, any( "item6" ) );
	state.menu.AddItem( skill7text, any( "item7" ) );
	state.menu.AddItem( skill8text, any( "item8" ) );
	state.menu.AddItem( skill9text, any( "item9" ) );
	
	state.OpenMenu( pPlayer, 0, 0 );
}

void SCXPMSpecialChoice( CTextMenu@ menu, CBasePlayer@ pPlayer, int page, const CTextMenuItem@ item )
{
	int index = pPlayer.entindex();
	if ( page == 10 ) return;
	
	string selection;
	item.m_pUserData.retrieve( selection );
	if ( selection == 'item1' )
	{
		if ( specialpoints[ index ] > 0 )
		{
			if ( spawndmg[ index ] < 9 )
				spawndmg[ index ]++;
			else
				g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "[SCXPM] This skill is maxed out!\n" );
			
			g_Scheduler.SetTimeout( "SCXPMSpecials", 0.01, index );
		}
		else
			g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "[SCXPM] You need at least 1 Skillpoint to enhance your Starting Attack.\n" );
	}
	else if ( selection == 'item2' )
	{
		if ( specialpoints[ index ] > 0 )
		{
			if ( !( ( bData[ index ] & SS_DISPENCER ) != 0 ) )
				bData[ index ] |= SS_DISPENCER;
			else
				g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "[SCXPM] This skill is already activated!\n" );
			
			g_Scheduler.SetTimeout( "SCXPMSpecials", 0.01, index );
		}
		else
			g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "[SCXPM] You need at least 1 Skillpoint to activate your Portable Dispencer.\n" );
	}
	else if ( selection == 'item3' )
	{
		if ( specialpoints[ index ] > 0 )
		{
			if ( ubercharge[ index ] < 9 )
				ubercharge[ index ]++;
			else
				g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "[SCXPM] This skill is maxed out!\n" );
			
			g_Scheduler.SetTimeout( "SCXPMSpecials", 0.01, index );
		}
		else
			g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "[SCXPM] You need at least 1 Skillpoint to enhance your Ubercharge.\n" );
	}
	else if ( selection == 'item4' )
	{
		if ( specialpoints[ index ] > 0 )
		{
			if ( fastheal[ index ] < 5 )
				fastheal[ index ]++;
			else
				g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "[SCXPM] This skill is maxed out!\n" );
			
			g_Scheduler.SetTimeout( "SCXPMSpecials", 0.01, index );
		}
		else
			g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "[SCXPM] You need at least 1 Skillpoint to enhance your Quick Heal.\n" );
	}
	else if ( selection == 'item5' )
	{
		if ( specialpoints[ index ] > 0 )
		{
			if ( demoman[ index ] < 5 )
				demoman[ index ]++;
			else
				g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "[SCXPM] This skill is maxed out!\n" );
			
			g_Scheduler.SetTimeout( "SCXPMSpecials", 0.01, index );
		}
		else
			g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "[SCXPM] You need at least 1 Skillpoint to enhance your Demoman.\n" );
	}
	else if ( selection == 'item6' )
	{
		if ( specialpoints[ index ] > 0 )
		{
			if ( practiceshot[ index ] < 5 )
				practiceshot[ index ]++;
			else
				g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "[SCXPM] This skill is maxed out!\n" );
			
			g_Scheduler.SetTimeout( "SCXPMSpecials", 0.01, index );
		}
		else
			g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "[SCXPM] You need at least 1 Skillpoint to enhance your Practice Shot.\n" );
	}
	else if ( selection == 'item7' )
	{
		if ( specialpoints[ index ] > 0 )
		{
			if ( bioelectric[ index ] < 5 )
				bioelectric[ index ]++;
			else
				g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "[SCXPM] This skill is maxed out!\n" );
			
			g_Scheduler.SetTimeout( "SCXPMSpecials", 0.01, index );
		}
		else
			g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "[SCXPM] You need at least 1 Skillpoint to enhance your BioElectric.\n" );
	}
	else if ( selection == 'item8' )
	{
		if ( specialpoints[ index ] > 0 )
		{
			if ( !( ( bData[ index ] & SS_RANGEHEAL ) != 0 ) )
				bData[ index ] |= SS_RANGEHEAL;
			else
				g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "[SCXPM] This skill is already activated!\n" );
			
			g_Scheduler.SetTimeout( "SCXPMSpecials", 0.01, index );
		}
		else
			g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "[SCXPM] You need at least 1 Skillpoint to activate your Medical Emergency.\n" );
	}
	else if ( selection == 'item9' )
	{
		if ( specialpoints[ index ] > 0 )
		{
			if ( redcross[ index ] < 5 )
			{
				redcross[ index ]++;
				
				// Manual update of Red Cross
				pPlayer.SetMaxAmmo( AMMO_MEDKIT, 100 + ( redcross[ index ] * 15 ) );
			}
			else
				g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "[SCXPM] This skill is maxed out!\n" );
			
			g_Scheduler.SetTimeout( "SCXPMSpecials", 0.01, index );
		}
		else
			g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "[SCXPM] You need at least 1 Skillpoint to enhance your Red Cross.\n" );
	}
}

void scxpm_others( const int& in index )
{
	CBasePlayer@ pPlayer = g_PlayerFuncs.FindPlayerByIndex( index );
	
	// Could rewrite this with the new ShowMOTD code, but I'm lazy :P
	NetworkMessage title( MSG_ONE_UNRELIABLE, NetworkMessages::ServerName, pPlayer.edict() );
	title.WriteString( "Player's Data" );
	title.End();
	
	NetworkMessage head1( MSG_ONE_UNRELIABLE, NetworkMessages::MOTD, pPlayer.edict() );
	head1.WriteByte( 0 );
	head1.WriteString( "Player*           Level   Medals\n\n" );
	head1.End();
	
	string data;
	
	for ( int i = 1; i <= g_Engine.maxClients; i++ )
	{
		CBasePlayer@ iPlayer = g_PlayerFuncs.FindPlayerByIndex( i );
		
		if ( iPlayer !is null && iPlayer.IsConnected() )
		{
			string name = iPlayer.pev.netname;
			if ( name.Length() > 16 )
			{
				// Restrict names to 16 characters
				name.Truncate( 16 );
			}
			
			int toadd = 20 - name.Length();
			string spaces = "               ";
			spaces.Resize( toadd );
			
			NetworkMessage mmsg1( MSG_ONE_UNRELIABLE, NetworkMessages::MOTD, pPlayer.edict() );
			mmsg1.WriteByte( 0 );
			mmsg1.WriteString( name );
			mmsg1.End();
			
			NetworkMessage mmsg2( MSG_ONE_UNRELIABLE, NetworkMessages::MOTD, pPlayer.edict() );
			mmsg2.WriteByte( 0 );
			mmsg2.WriteString( spaces );
			mmsg2.End();
			
			data = string( playerlevel[ i ] ) + "      " + medals[ i ] + "\n";
			
			NetworkMessage mmsg3( MSG_ONE_UNRELIABLE, NetworkMessages::MOTD, pPlayer.edict() );
			mmsg3.WriteByte( 0 );
			mmsg3.WriteString( data );
			mmsg3.End();
		}
	}
	
	NetworkMessage note1( MSG_ONE_UNRELIABLE, NetworkMessages::MOTD, pPlayer.edict() );
	note1.WriteByte( 0 );
	note1.WriteString( "\n* Long names are truncated." );
	note1.End();
	
	NetworkMessage note2_1( MSG_ONE_UNRELIABLE, NetworkMessages::MOTD, pPlayer.edict() );
	note2_1.WriteByte( 0 );
	note2_1.WriteString( "\n** To see more detailed player info, " );
	note2_1.End();
	NetworkMessage note2_2( MSG_ONE_UNRELIABLE, NetworkMessages::MOTD, pPlayer.edict() );
	note2_2.WriteByte( 0 );
	note2_2.WriteString( "use chat command: /inspect <Player>." );
	note2_2.End();
	
	NetworkMessage mend( MSG_ONE_UNRELIABLE, NetworkMessages::MOTD, pPlayer.edict() );
	mend.WriteByte( 1 );
	mend.WriteString( "\n" );
	mend.End();
	
	NetworkMessage restore( MSG_ONE_UNRELIABLE, NetworkMessages::ServerName, pPlayer.edict() );
	restore.WriteString( g_EngineFuncs.CVarGetString( "hostname" ) );
	restore.End();
}

void scxpm_info( const int& in index )
{
	CBasePlayer@ pPlayer = g_PlayerFuncs.FindPlayerByIndex( index );
	
	string szInfo = "1. Strength:\n   Starthealth + (Strengthlevel / 2).";
	szInfo += "\n\n2. Superior Armor:\n   Startarmor + (Armorlevel / 2).";
	szInfo += "\n\n3. Regeneration:\n   One HP every (158.0 - (Regenerationlevel / 3)) seconds\n   + Bonus chance every 0.5 seconds.";
	szInfo += "\n\n4. Nano Armor:\n   One AP every (165.5 - (Nanoarmorlevel / 3)) seconds\n   + Bonus chance every 0.5 seconds.";
	szInfo += "\n\n5. Ammo Reincarnation:\n   One clip for current weapon and a random clip every (95.5 - (Ammolevel * 2)) seconds.";
	szInfo += "\n\n6. Anti-Gravity Device:\n   Lowers your gravity by (1.2)% per level. Hold Jump-Key!";
	szInfo += "\n\n7. Awareness:\n   Generic skill which enhances many other skills a bit.";
	szInfo += "\n\n8. Poder de Equipo:\n   Supports nearby teammates with HP and AP.";
	szInfo += "\n\n9. Block Attack:\n   Chance on fully blocking any attack of (Blocklevel / 3)%.";
	szInfo += "\n\n10. Medals:\n   Slighly enhances all other skills a bit.\n   Increases XP gain by (Medals * 3)%.\n   Can be used for special skills.";
	
	ShowMOTD( pPlayer, "Skills Information", szInfo );
}

void scxpm_version( const int& in index )
{
	CBasePlayer@ pPlayer = g_PlayerFuncs.FindPlayerByIndex( index );
	
	string szInfo = "Sven Co-op eXPerience Mod (SCXPM)";
	szInfo += "\n\nOriginally written by Silencer, Wrd and PythEch.";
	szInfo += "\nAngelScript port by Julian \"Giegue\" Rodriguez.";
	
	szInfo += "\n\nVersion: " + version;
	szInfo += "\nLast update: " + lastupdate;
	
	szInfo += "\n\nThanks to:\n\nAngel\nMaty\nSneaky EmA\nw00tguy\nSolokiller\nfgsfds\nAMX Mod X Team\n";
	
	szInfo += "\n\n\n---\n2009-2021 - Imperium Sven Co-op";
	
	ShowMOTD( pPlayer, "About", szInfo );
}

void scxpm_sinfo( const int& in index )
{
	CBasePlayer@ pPlayer = g_PlayerFuncs.FindPlayerByIndex( index );
	
	string szInfo = "Special Skills are additional upgrades that you can use. These are only available with medals.\n\n1 medal = 1 specialpoint.";
	szInfo += "\n\n1. Starting Attack:\n   On revive/respawn, deal (20 * Attacklevel) damage\n   to all nearby enemies on a 360 unit radius.";
	szInfo += "\n\n2. Portable Dispencer:\n   Doubles all regenerated ammo.";
	szInfo += "\n\n3. Ubercharge:\n   Increases the maximum capacity of all basic skills.";
	szInfo += "\n\n4. Quick Heal:\n   Extra medkit ammo every (6.0 - (Quicklevel / 3.5)) seconds.";
	szInfo += "\n\n5. Demoman:\n   Chance on one clip of M16 Grenades of (8 + (Demolevel * 4))%.\n   (Does not stack with Portable Dispencer).\n   (You must have a M16 deployed for this to work).";
	szInfo += "\n\n6. Practice Shot:\n   Chance on the next shot to not consume any ammo of (Practicelevel * 5)%.\n   (Only affects primary attacks, and does not work on all weapons).";
	szInfo += "\n\n7. BioElectric:\n   Increases Shock Rifle's maximum capacity by (10 * Bioelectriclevel).";
	szInfo += "\n\n8. Medical Emergency:\n   Allows long range healing with the Medkit.\n   (Use tertiary attack).";
	szInfo += "\n\n9. Red Cross:\n   Increases Medkit's maximum capacity by (15 * Redcrosslevel).";
	
	ShowMOTD( pPlayer, "Special Skills Information", szInfo );
}

void scxpm_hcinfo( const int& in index )
{
	CBasePlayer@ pPlayer = g_PlayerFuncs.FindPlayerByIndex( index );
	
	string szInfo = "Handicaps make your map gameplay harder. But you will be rewared with greater XP gain, allowing you to level up faster. ";
	szInfo += "Do note, however, that you can only activate handicaps at map start.";
	
	szInfo += "\n\n1. Medical Phobia:\n   You cannot be healed, except via regeneration.\n   +15% XP gain.";
	szInfo += "\n\n2. Obsolete Technology:\n   You cannot repair your armor, except via nano armor.\n   +18% XP gain.";
	szInfo += "\n\n3. Nitrogen Blood:\n   You cannot be revived, you will always gib on death.\n   +9% XP gain.";
	szInfo += "\n\n4. Karmic Retribution:\n   All damages will leave you poisoned (falldamage excluded).\n   +12% XP gain.";
	szInfo += "\n\n5. Realism:\n   Hides the HEV Suit (HUD), making overall gameplay harder.\n   +15% XP gain.";
	szInfo += "\n\n6. Big Explosion:\n   Explosions will deal much more damage than usual.\n   +12% XP gain.";
	szInfo += "\n\n7. Limited Equipment:\n   Restricts your equipment to only one weapon.\n   +12% XP gain.";
	szInfo += "\n\n8. Dead Weight:\n   Increases your gravity, it's harder to jump.\n   +9% XP gain.";
	szInfo += "\n\n9. Lacking Help:\n   Partially disables the effects of Medals and Special Skills.\n   (Ubercharge and Red Cross are unaffected).\n   +15% XP gain.";
	szInfo += "\n\n10. Friendly Fire:\n   Attacks done by other players will hurt you.\n   +18% XP gain.";
	szInfo += "\n\n11. Lost Bullets:\n   Restricts your weapon's ammunition to only one clip.\n   +12% XP gain.";
	szInfo += "\n\n12. Weak Restart:\n   Reviving or respawning will force your status to 25 HP and 0 AP.\n   +21% XP gain.";
	szInfo += "\n\n13. Dangerous Waters:\n   Instant drowing when underwater.\n   +9% XP gain.";
	szInfo += "\n\n14. Bleeding View:\n   Adds a concussion effect that gets worse the lower your HP gets.\n   +12% XP gain.";
	
	ShowMOTD( pPlayer, "Handicaps Information", szInfo );
}

void scxpm_helpme( const int& in index )
{
	CBasePlayer@ pPlayer = g_PlayerFuncs.FindPlayerByIndex( index );
	
	string szInfo = "/selectskills\n   Opens the skill menu.";
	szInfo += "\n\n/resetskills\n   Resets your skills so you can rechoose them.";
	szInfo += "\n\n/playerskills\n   Prints other players stats.";
	szInfo += "\n\n/skillsinfo\n   Prints information about all skills.";
	szInfo += "\n\n/scxpminfo\n   Prints information about the SCXPM plugin.";
	szInfo += "\n\n/xpgain\n   Shows your XP gain on the current map.";
	szInfo += "\n\n/resetlevels\n   Allows you to exchange levels for medals.";
	szInfo += "\n\n/selectspecials\n   Opens the special skills menu.";
	szInfo += "\n\n/resetspecials\n   Resets your special skills so you can rechoose them.";
	szInfo += "\n\n/specialsinfo\n   Prints information about all special skills.";
	szInfo += "\n\n/hudsettings\n   Let's you customize HUD appearance.";
	szInfo += "\n\n/handicaps\n   Handicap yourself for extra XP gain.";
	szInfo += "\n\n/handicapsinfo\n   Prints information about all handicaps.";
	szInfo += "\n\n/character\n   Shows a brief resume of your player data.";
	szInfo += "\n\n/achievements\n   Opens the achievement menu.";
	szInfo += "\n\n/menu\n   All commands previously mentioned, on an easy to use menu.";
	
	ShowMOTD( pPlayer, "Command List", szInfo );
}

void scxpm_menu( const int& in index )
{
	CBasePlayer@ pPlayer = g_PlayerFuncs.FindPlayerByIndex( index );
	MenuHandler@ state = MenuGetPlayer( pPlayer );
	
	state.InitMenu( pPlayer, scxpm_menu_cb );
	state.menu.SetTitle( "Main Menu\n" );
	
	// Page 1
	state.menu.AddItem( "Skills\n", any( "item1" ) );
	state.menu.AddItem( "Special Skills\n\n", any( "item2" ) );
	state.menu.AddItem( "Reset Skills\n", any( "item3" ) );
	state.menu.AddItem( "Reset Special Skills\n\n", any( "item4" ) );
	state.menu.AddItem( "Customize HUD\n\n", any( "item5" ) );
	state.menu.AddItem( "Player's Data\n", any( "item6" ) );
	state.menu.AddItem( "My character", any( "item7" ) );
	
	// Page 2
	state.menu.AddItem( "Achievements\n", any( "item8" ) );
	state.menu.AddItem( "XP Mods\n", any( "item9" ) );
	state.menu.AddItem( "Handicaps\n\n", any( "item10" ) );
	state.menu.AddItem( "Reset Level\n\n", any( "item11" ) );
	state.menu.AddItem( "Daily Rewards\n\n", any( "item12" ) );
	state.menu.AddItem( "Help and Info", any( "item13" ) );
	
	state.OpenMenu( pPlayer, 0, 0 );
}

void scxpm_menu_cb( CTextMenu@ menu, CBasePlayer@ pPlayer, int page, const CTextMenuItem@ item )
{
	int index = pPlayer.entindex();
	if ( page == 10 ) return;
	
	string selection;
	item.m_pUserData.retrieve( selection );
	if ( selection == 'item1' ) // Page 1
		g_Scheduler.SetTimeout( "SCXPMSkill", 0.01, index );
	else if ( selection == 'item2' )
		g_Scheduler.SetTimeout( "SCXPMSpecials", 0.01, index );
	else if ( selection == 'item3' )
		g_Scheduler.SetTimeout( "scxpm_breset", 0.01, index, false );
	else if ( selection == 'item4' )
		g_Scheduler.SetTimeout( "scxpm_sreset", 0.01, index );
	else if ( selection == 'item5' )
		g_Scheduler.SetTimeout( "scxpm_hudmain", 0.01, index );
	else if ( selection == 'item6' )
		g_Scheduler.SetTimeout( "scxpm_others", 0.01, index );
	else if ( selection == 'item7' )
		g_Scheduler.SetTimeout( "scxpm_mydata", 0.01, index );
	else if ( selection == 'item8' ) // Page 2
		g_Scheduler.SetTimeout( "scxpm_achievements", 0.01, index, 0, 0 );
	else if ( selection == 'item9' )
		g_Scheduler.SetTimeout( "scxpm_permaincrease", 0.01, index, 0, 0 );
	else if ( selection == 'item10' )
		g_Scheduler.SetTimeout( "scxpm_handicaps", 0.01, index, 0 );
	else if ( selection == 'item11' )
		g_Scheduler.SetTimeout( "scxpm_lvltomedal", 0.01, index );
	else if ( selection == 'item12' )
		g_Scheduler.SetTimeout( "scxpm_dailyrewards", 0.01, index, 0 );
	else if ( selection == 'item13' )
		g_Scheduler.SetTimeout( "scxpm_helpmenu", 0.01, index );
}

void scxpm_mydata( const int& in index )
{
	CBasePlayer@ pPlayer = g_PlayerFuncs.FindPlayerByIndex( index );
	MenuHandler@ state = MenuGetPlayer( pPlayer );
	
	state.InitMenu( pPlayer, scxpm_mydata_cb );
	
	string title = "My character\n\n";
	title += g_EngineFuncs.GetPlayerAuthId( pPlayer.edict() ) + "\n\n\n";
	
	title += "Level: " + AddCommas( scxpm_calc_lvl( xp[ index ] ) ) + "\n";
	title += "Medals: " + AddCommas( medals[ index ] ) + "\n\n";
	
	title += "Achievements: " + GetAchievementClear( index ) + " of " + int( szAchievementNames.length() ) + " unlocked\n";
	title += "XP Mods:" + ( permaincrease[ index ] > 0.0 ? " +" : " " ) + int( permaincrease[ index ] ) + "%\n\n";
	
	title += "Your first play ever was on\n";
	title += GetFormatDate( firstplay[ index ] ) + "\n\n";
	title += "Daily rewards get: " + dailyget[ index ] + "\n";
	
	state.menu.SetTitle( title );
	state.menu.AddItem( "View Achievements", any( "item1" ) );
	state.menu.AddItem( "View XP Mods\n", any( "item2" ) );
	state.menu.AddItem( "Return to Main Menu", any( "item3" ) );
	
	state.OpenMenu( pPlayer, 0, 0 );
}

void scxpm_mydata_cb( CTextMenu@ menu, CBasePlayer@ pPlayer, int page, const CTextMenuItem@ item )
{
	int index = pPlayer.entindex();
	if ( page == 10 ) return;
	
	string selection;
	item.m_pUserData.retrieve( selection );
	
	if ( selection == 'item1' )
		g_Scheduler.SetTimeout( "scxpm_achievements", 0.01, index, 0, 0 );
	else if ( selection == 'item2' )
		g_Scheduler.SetTimeout( "scxpm_permaincrease", 0.01, index, 0, 0 );
	else if ( selection == 'item3' )
		g_Scheduler.SetTimeout( "scxpm_menu", 0.01, index );
}

void scxpm_permaincrease( const int& in index, int& in iPage = 0, int& in iInspect = 0 )
{
	CBasePlayer@ pPlayer = g_PlayerFuncs.FindPlayerByIndex( index );
	
	if ( iInspect > 0 )
	{
		CBasePlayer@ pInspect = g_PlayerFuncs.FindPlayerByIndex( iInspect );
		if ( pInspect is null )
		{
			g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "[SCXPM] Player not found.\n" );
			return;
		}
	}
	
	MenuHandler@ state = MenuGetPlayer( pPlayer );
	
	state.InitMenu( pPlayer, scxpm_permaincrease_cb );
	string title;
	
	if ( iInspect > 0 )
	{
		title = "XP Mods\n\nTOTAL:" + ( permaincrease[ iInspect ] > 0.0 ? " +" : " " ) + int( permaincrease[ iInspect ] ) + "% XP gain\n\n";
		state.menu.SetTitle( title );
	
		GetPermaIncrease( iInspect, state );
	}
	else
	{
		iIndexInspect[ index ] = 0;
		
		title = "XP Mods\n\nTOTAL:" + ( permaincrease[ index ] > 0.0 ? " +" : " " ) + int( permaincrease[ index ] ) + "% XP gain\n\n";
		state.menu.SetTitle( title );
	
		GetPermaIncrease( index, state );
	}
	
	state.OpenMenu( pPlayer, 0, iPage );
}

void scxpm_permaincrease_cb( CTextMenu@ menu, CBasePlayer@ pPlayer, int page, const CTextMenuItem@ item )
{
	int index = pPlayer.entindex();
	if ( page == 10 ) return;
	
	string selection;
	item.m_pUserData.retrieve( selection );
	
	if ( selection == 'empty' )
		g_Scheduler.SetTimeout( "scxpm_permaincrease", 0.01, index, 0, iIndexInspect[ index ] );
	else
		g_Scheduler.SetTimeout( "scxpm_pi_showinfo", 0.01, index, selection, iIndexInspect[ index ] );
}

void scxpm_pi_showinfo( const int& in index, const string& in szItem, int& in iInspect = 0 )
{
	CBasePlayer@ pPlayer = g_PlayerFuncs.FindPlayerByIndex( index );
	
	if ( iInspect > 0 )
	{
		CBasePlayer@ pInspect = g_PlayerFuncs.FindPlayerByIndex( iInspect );
		if ( pInspect is null )
		{
			g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "[SCXPM] Player not found.\n" );
			return;
		}
	}
	
	MenuHandler@ state = MenuGetPlayer( pPlayer );
	
	state.InitMenu( pPlayer, scxpm_pi_showinfo_cb );
	
	if ( iInspect > 0 )
		GetPermaIncrease( iInspect, state, true, szItem );
	else
		GetPermaIncrease( index, state, true, szItem );
	
	state.OpenMenu( pPlayer, 0, 0 );
}

void scxpm_pi_showinfo_cb( CTextMenu@ menu, CBasePlayer@ pPlayer, int page, const CTextMenuItem@ item )
{
	int index = pPlayer.entindex();
	if ( page == 10 ) return;
	
	string selection;
	item.m_pUserData.retrieve( selection );
	
	// This is the most bastarized and hacky shit I've ever programmed. -Giegue
	int iEntries = 0;
	if ( iIndexInspect[ index ] > 0 )
		GetPermaIncrease( iIndexInspect[ index ], null, false, "", iEntries, true );
	else
		GetPermaIncrease( index, null, false, "", iEntries, true );
	
	if ( iEntries > 9 ) // Multi-paged
	{
		// Support for up to 3 pages, extend if needed
		int iItem = atoi( selection );
		if ( iItem > 13 )
			g_Scheduler.SetTimeout( "scxpm_permaincrease", 0.01, index, 2, iIndexInspect[ index ] );
		else if ( iItem > 6 )
			g_Scheduler.SetTimeout( "scxpm_permaincrease", 0.01, index, 1, iIndexInspect[ index ] );
		else
			g_Scheduler.SetTimeout( "scxpm_permaincrease", 0.01, index, 0, iIndexInspect[ index ] );
	}
	else // Single page
		g_Scheduler.SetTimeout( "scxpm_permaincrease", 0.01, index, 0, iIndexInspect[ index ] );
}

void scxpm_dailyrewards( const int& in index, int& in iDaily = 0 )
{
	// Abuse prevention, get the player now
	CBasePlayer@ pPlayer = g_PlayerFuncs.FindPlayerByIndex( index );
	if ( pPlayer is null ) return;
	
	// Update daily rewards now
	if ( iDaily > 0 ) dailyget[ index ] = iDaily;
	
	string szCurrent;
	string szNext;
	DailyReward( index, dailyget[ index ], true, szCurrent, szNext );
	
	MenuHandler@ state = MenuGetPlayer( pPlayer );
	
	state.InitMenu( pPlayer, scxpm_dailyrewards_cb );
	
	string title = "Daily Rewards\n\n";
	title += "Daily rewards get: " + dailyget[ index ] + "\n\n\n";
	
	title += "Day " + dailyget[ index ] + ": " + szCurrent + "\n";
	title += "Next reward: " + szNext + "\n\n";
	
	title += "Keep playing to increase rewards!\n\n";
	
	state.menu.SetTitle( title );
	state.menu.AddItem( "Return to Main Menu", any( "item1" ) );
	
	state.OpenMenu( pPlayer, 0, 0 );
}

void scxpm_dailyrewards_cb( CTextMenu@ menu, CBasePlayer@ pPlayer, int page, const CTextMenuItem@ item )
{
	int index = pPlayer.entindex();
	if ( page == 10 ) return;
	
	string selection;
	item.m_pUserData.retrieve( selection );
	if ( selection == 'item1' )
		g_Scheduler.SetTimeout( "scxpm_menu", 0.01, index );
}

void scxpm_achievements( const int& in index, int& in iPage = 0, int& in iInspect = 0 )
{
	CBasePlayer@ pPlayer = g_PlayerFuncs.FindPlayerByIndex( index );
	
	if ( iInspect > 0 )
	{
		CBasePlayer@ pInspect = g_PlayerFuncs.FindPlayerByIndex( iInspect );
		if ( pInspect is null )
		{
			g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "[SCXPM] Player not found.\n" );
			return;
		}
	}
	
	MenuHandler@ state = MenuGetPlayer( pPlayer );
	
	state.InitMenu( pPlayer, scxpm_achievements_cb );
	
	string title = "Achievements\n\n[-] = Locked\n[U] = Unlocked\n\n";
	state.menu.SetTitle( title );
	
	if ( iInspect > 0 )
		GetAchievementData( iInspect, state );
	else
	{
		iIndexInspect[ index ] = 0;
		GetAchievementData( index, state );
	}
	
	state.OpenMenu( pPlayer, 0, iPage );
}

void scxpm_achievements_cb( CTextMenu@ menu, CBasePlayer@ pPlayer, int page, const CTextMenuItem@ item )
{
	int index = pPlayer.entindex();
	if ( page == 10 ) return;
	
	string selection;
	item.m_pUserData.retrieve( selection );
	
	g_Scheduler.SetTimeout( "scxpm_achievement_info", 0.01, index, atoi( selection ), iIndexInspect[ index ] );
}

void scxpm_achievement_info( const int& in index, int& in iAchievementID, int& in iInspect = 0 )
{
	CBasePlayer@ pPlayer = g_PlayerFuncs.FindPlayerByIndex( index );
	
	if ( iInspect > 0 )
	{
		CBasePlayer@ pInspect = g_PlayerFuncs.FindPlayerByIndex( iInspect );
		if ( pInspect is null )
		{
			g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "[SCXPM] Player not found.\n" );
			return;
		}
	}
	
	MenuHandler@ state = MenuGetPlayer( pPlayer );
	
	state.InitMenu( pPlayer, scxpm_achievement_info_cb );
	
	string title = szAchievementNames[ iAchievementID ] + "\n\n\n";
	
	title += GetAchievementMission( iAchievementID );
	
	title += "\n\nStatus: ";
	if ( iInspect > 0 )
	{
		if ( aData[ iInspect ][ iAchievementID ] ) title += "Got it!\n";
		else title += "Not yet unlocked\n";
	}
	else
	{
		if ( aData[ index ][ iAchievementID ] ) title += "Got it!\n";
		else title += "Not yet unlocked\n";
	}
	
	state.menu.SetTitle( title );
	
	if ( iInspect == 0 && !aClaim[ index ][ iAchievementID ] && aData[ index ][ iAchievementID ] )
		state.menu.AddItem( "Redeem reward\n", any( string( iAchievementID ) ) );
	
	// WHY I DID THIS STUPID SHIT AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
	if ( iAchievementID > 160 )
		state.menu.AddItem( "Return", any( "item24" ) );
	else if ( iAchievementID > 153 )
		state.menu.AddItem( "Return", any( "item23" ) );
	else if ( iAchievementID > 146 )
		state.menu.AddItem( "Return", any( "item22" ) );
	else if ( iAchievementID > 139 )
		state.menu.AddItem( "Return", any( "item21" ) );
	else if ( iAchievementID > 132 )
		state.menu.AddItem( "Return", any( "item20" ) );
	else if ( iAchievementID > 125 )
		state.menu.AddItem( "Return", any( "item19" ) );
	else if ( iAchievementID > 118 )
		state.menu.AddItem( "Return", any( "item18" ) );
	else if ( iAchievementID > 111 )
		state.menu.AddItem( "Return", any( "item17" ) );
	else if ( iAchievementID > 104 )
		state.menu.AddItem( "Return", any( "item16" ) );
	else if ( iAchievementID > 97 )
		state.menu.AddItem( "Return", any( "item15" ) );
	else if ( iAchievementID > 90 )
		state.menu.AddItem( "Return", any( "item14" ) );
	else if ( iAchievementID > 83 )
		state.menu.AddItem( "Return", any( "item13" ) );
	else if ( iAchievementID > 76 )
		state.menu.AddItem( "Return", any( "item12" ) );
	else if ( iAchievementID > 69 )
		state.menu.AddItem( "Return", any( "item11" ) );
	else if ( iAchievementID > 62 )
		state.menu.AddItem( "Return", any( "item10" ) );
	else if ( iAchievementID > 55 )
		state.menu.AddItem( "Return", any( "item9" ) );
	else if ( iAchievementID > 48 )
		state.menu.AddItem( "Return", any( "item8" ) );
	else if ( iAchievementID > 41 )
		state.menu.AddItem( "Return", any( "item7" ) );
	else if ( iAchievementID > 34 )
		state.menu.AddItem( "Return", any( "item6" ) );
	else if ( iAchievementID > 27 )
		state.menu.AddItem( "Return", any( "item5" ) );
	else if ( iAchievementID > 20 )
		state.menu.AddItem( "Return", any( "item4" ) );
	else if ( iAchievementID > 13 )
		state.menu.AddItem( "Return", any( "item3" ) );
	else if ( iAchievementID > 6 )
		state.menu.AddItem( "Return", any( "item2" ) );
	else
		state.menu.AddItem( "Return", any( "item1" ) );
	
	state.OpenMenu( pPlayer, 0, 0 );
}

void scxpm_achievement_info_cb( CTextMenu@ menu, CBasePlayer@ pPlayer, int page, const CTextMenuItem@ item )
{
	int index = pPlayer.entindex();
	if ( page == 10 ) return;
	
	string selection;
	item.m_pUserData.retrieve( selection );
	
	// *sad copypasting noises*
	if ( selection == 'item1' )
		g_Scheduler.SetTimeout( "scxpm_achievements", 0.01, index, 0, iIndexInspect[ index ] );
	else if ( selection == 'item2' )
		g_Scheduler.SetTimeout( "scxpm_achievements", 0.01, index, 1, iIndexInspect[ index ] );
	else if ( selection == 'item3' )
		g_Scheduler.SetTimeout( "scxpm_achievements", 0.01, index, 2, iIndexInspect[ index ] );
	else if ( selection == 'item4' )
		g_Scheduler.SetTimeout( "scxpm_achievements", 0.01, index, 3, iIndexInspect[ index ] );
	else if ( selection == 'item5' )
		g_Scheduler.SetTimeout( "scxpm_achievements", 0.01, index, 4, iIndexInspect[ index ] );
	else if ( selection == 'item6' )
		g_Scheduler.SetTimeout( "scxpm_achievements", 0.01, index, 5, iIndexInspect[ index ] );
	else if ( selection == 'item7' )
		g_Scheduler.SetTimeout( "scxpm_achievements", 0.01, index, 6, iIndexInspect[ index ] );
	else if ( selection == 'item8' )
		g_Scheduler.SetTimeout( "scxpm_achievements", 0.01, index, 7, iIndexInspect[ index ] );
	else if ( selection == 'item9' )
		g_Scheduler.SetTimeout( "scxpm_achievements", 0.01, index, 8, iIndexInspect[ index ] );
	else if ( selection == 'item10' )
		g_Scheduler.SetTimeout( "scxpm_achievements", 0.01, index, 9, iIndexInspect[ index ] );
	else if ( selection == 'item11' )
		g_Scheduler.SetTimeout( "scxpm_achievements", 0.01, index, 10, iIndexInspect[ index ] );
	else if ( selection == 'item12' )
		g_Scheduler.SetTimeout( "scxpm_achievements", 0.01, index, 11, iIndexInspect[ index ] );
	else if ( selection == 'item13' )
		g_Scheduler.SetTimeout( "scxpm_achievements", 0.01, index, 12, iIndexInspect[ index ] );
	else if ( selection == 'item14' )
		g_Scheduler.SetTimeout( "scxpm_achievements", 0.01, index, 13, iIndexInspect[ index ] );
	else if ( selection == 'item15' )
		g_Scheduler.SetTimeout( "scxpm_achievements", 0.01, index, 14, iIndexInspect[ index ] );
	else if ( selection == 'item16' )
		g_Scheduler.SetTimeout( "scxpm_achievements", 0.01, index, 15, iIndexInspect[ index ] );
	else if ( selection == 'item17' )
		g_Scheduler.SetTimeout( "scxpm_achievements", 0.01, index, 16, iIndexInspect[ index ] );
	else if ( selection == 'item18' )
		g_Scheduler.SetTimeout( "scxpm_achievements", 0.01, index, 17, iIndexInspect[ index ] );
	else if ( selection == 'item19' )
		g_Scheduler.SetTimeout( "scxpm_achievements", 0.01, index, 18, iIndexInspect[ index ] );
	else if ( selection == 'item20' )
		g_Scheduler.SetTimeout( "scxpm_achievements", 0.01, index, 19, iIndexInspect[ index ] );
	else if ( selection == 'item21' )
		g_Scheduler.SetTimeout( "scxpm_achievements", 0.01, index, 20, iIndexInspect[ index ] );
	else if ( selection == 'item22' )
		g_Scheduler.SetTimeout( "scxpm_achievements", 0.01, index, 21, iIndexInspect[ index ] );
	else if ( selection == 'item23' )
		g_Scheduler.SetTimeout( "scxpm_achievements", 0.01, index, 22, iIndexInspect[ index ] );
	else if ( selection == 'item24' )
		g_Scheduler.SetTimeout( "scxpm_achievements", 0.01, index, 23, iIndexInspect[ index ] );
	else
	{
		// Claim reward
		GiveAchievementReward( index, atoi( selection ) );
	}
}

void scxpm_helpmenu( const int& in index )
{
	CBasePlayer@ pPlayer = g_PlayerFuncs.FindPlayerByIndex( index );
	MenuHandler@ state = MenuGetPlayer( pPlayer );
	
	state.InitMenu( pPlayer, scxpm_helpmenu_cb );
	state.menu.SetTitle( "Help and Info\n\n" );
	
	state.menu.AddItem( "Command List\n\n", any( "item1" ) );
	state.menu.AddItem( "How do skills work?\n", any( "item2" ) );
	state.menu.AddItem( "What about the special ones?\n", any( "item3" ) );
	state.menu.AddItem( "What are handicaps?\n\n", any( "item4" ) );
	state.menu.AddItem( "XP gain\n\n", any( "item5" ) );
	state.menu.AddItem( "About\n\n", any( "item6" ) );
	state.menu.AddItem( "Return to Main Menu", any( "item8" ) );
	
	state.OpenMenu( pPlayer, 0, 0 );
}

void scxpm_helpmenu_cb( CTextMenu@ menu, CBasePlayer@ pPlayer, int page, const CTextMenuItem@ item )
{
	int index = pPlayer.entindex();
	if ( page == 10 ) return;
	
	string selection;
	item.m_pUserData.retrieve( selection );
	if ( selection == 'item1' )
		g_Scheduler.SetTimeout( "scxpm_helpme", 0.01, index );
	else if ( selection == 'item2' )
		g_Scheduler.SetTimeout( "scxpm_info", 0.01, index );
	else if ( selection == 'item3' )
		g_Scheduler.SetTimeout( "scxpm_sinfo", 0.01, index );
	else if ( selection == 'item4' )
		g_Scheduler.SetTimeout( "scxpm_hcinfo", 0.01, index );
	else if ( selection == 'item5' )
		g_Scheduler.SetTimeout( "scxpm_xpgain", 0.01, index );
	else if ( selection == 'item6' )
		g_Scheduler.SetTimeout( "scxpm_version", 0.01, index );
	else if ( selection == 'item8' )
		g_Scheduler.SetTimeout( "scxpm_menu", 0.01, index );
}

// Handles daily rewards
void DailyReward( const int& in index, int& in iDays, bool bUpdate, string& out szCurrent, string& out szNext )
{
	// Check range, priority
	DateTime dtCurrentTime( UnixTimestamp() );
	int iCheck = CheckDaily( index, dtCurrentTime, nextdaily[ index ] );
	if ( iCheck == -1 )
	{
		iDays = 0;
		dailyget[ index ] = 0;
		
		// Set next daily
		TimeDifference tdNextTime( 20 * 60 * 60 ); // ALMOST 1 day
		dtCurrentTime += tdNextTime;
		nextdaily[ index ] = dtCurrentTime;
	}
	
	int iReward; // = 50 * iDays;
	int iNext; // = 50 * ( iDays + 1 );
	
	// After 30 days, XP increases become greater but slower
	// XP Rewards don't get any higher after 4 consecutive months
	if ( iDays > 120 ) iReward = 6000;
	else if ( iDays > 118 ) iReward = 5550;
	else if ( iDays > 111 ) iReward = 5200;
	else if ( iDays > 104 ) iReward = 4850;
	else if ( iDays > 97 ) iReward = 4500;
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
	
	// Repeat for the next incoming daily
	if ( ( iDays + 1 ) > 120 ) iNext = 6000;
	else if ( ( iDays + 1 ) > 118 ) iNext = 5550;
	else if ( ( iDays + 1 ) > 111 ) iNext = 5200;
	else if ( ( iDays + 1 ) > 104 ) iNext = 4850;
	else if ( ( iDays + 1 ) > 97 ) iNext = 4500;
	else if ( ( iDays + 1 ) > 90 ) iNext = 4500;
	else if ( ( iDays + 1 ) > 88 ) iNext = 4400;
	else if ( ( iDays + 1 ) > 81 ) iNext = 4050;
	else if ( ( iDays + 1 ) > 74 ) iNext = 3700;
	else if ( ( iDays + 1 ) > 67 ) iNext = 3350;
	else if ( ( iDays + 1 ) > 60 ) iNext = 3000;
	else if ( ( iDays + 1 ) > 58 ) iNext = 2900;
	else if ( ( iDays + 1 ) > 51 ) iNext = 2550;
	else if ( ( iDays + 1 ) > 44 ) iNext = 2200;
	else if ( ( iDays + 1 ) > 37 ) iNext = 1850;
	else if ( ( iDays + 1 ) > 30 ) iNext = 1500;
	else iNext = 50 * ( iDays + 1 );
	
	// Set strings for current reward
	if ( iDays >= 365 && !HasPermaIncrease( index, "Eternal" ) ) // I'm going to get drunk if someone gets this... -Giegue
		szCurrent = "Honorific Mention";
	else if ( iDays >= 120 && !HasPermaIncrease( index, "Addict" ) || iDays >= 90 && !HasPermaIncrease( index, "Fanatic" ) || iDays >= 60 && !HasPermaIncrease( index, "Dedicated" ) || iDays >= 30 && !HasPermaIncrease( index, "Installed" ) )
		szCurrent = "XP Mod +10%";
	else
		szCurrent = string( iReward ) + " EXP";
	
	// Set string for next reward
	if ( ( iDays + 1 ) >= 365 && !HasPermaIncrease( index, "Eternal" ) )
		szNext = "Honorific Mention";
	else if ( ( iDays + 1 ) >= 120 && !HasPermaIncrease( index, "Addict" ) || ( iDays + 1 ) >= 90 && !HasPermaIncrease( index, "Fanatic" ) || ( iDays + 1 ) >= 60 && !HasPermaIncrease( index, "Dedicated" ) || ( iDays + 1 ) >= 30 && !HasPermaIncrease( index, "Installed" ) )
		szNext = "XP Mod +10%";
	else
		szNext = string( iNext ) + " EXP";
	
	if ( bUpdate && iCheck == 1 )
	{
		// Set next daily
		TimeDifference tdNextTime( 20 * 60 * 60 ); // ALMOST 1 day
		dtCurrentTime += tdNextTime;
		nextdaily[ index ] = dtCurrentTime;
		
		// Give rewards
		if ( iDays >= 365 && !HasPermaIncrease( index, "Eternal" ) ) // No sane person will get this but DON'T UNDERESTIMATE THE INTERNET.
		{
			string szMessage = "";
			szMessage += "This being has made it very clear that it's";
			szMessage += "!nexistance is tied to this world and will";
			szMessage += "!nkeep expanding 'till infinity.!n!n";
			szMessage += "Reached 365 continuous daily rewards";
			
			AddPermaIncrease( index, "0.0#Eternal#" + szMessage + "!n!nHONORIFIC MENTION!n\n" );
		}
		else if ( iDays >= 120 && !HasPermaIncrease( index, "Addict" ) )
			AddPermaIncrease( index, "10.0#Addict#Reached 120 continuous daily rewards!n!n+10% XP gain!n\n" );
		else if ( iDays >= 90 && !HasPermaIncrease( index, "Fanatic" ) )
			AddPermaIncrease( index, "10.0#Fanatic#Reached 90 continuous daily rewards!n!n+10% XP gain!n\n" );
		else if ( iDays >= 60 && !HasPermaIncrease( index, "Dedicated" ) )
			AddPermaIncrease( index, "10.0#Dedicated#Reached 60 continuous daily rewards!n!n+10% XP gain!n\n" );
		else if ( iDays >= 30 && !HasPermaIncrease( index, "Installed" ) ) // Month goals
			AddPermaIncrease( index, "10.0#Installed#Reached 30 continuous daily rewards!n!n+10% XP gain!n\n" );
		else
		{
			xp[ index ] += iReward;
			
			if ( !gDelayedXP ) earnedxp[ index ] += iReward; // Prevent double XP exploitation on delayed XP maps
		}
	}
}

void scxpm_savedata( const int& in index )
{
	CBasePlayer@ pPlayer = g_PlayerFuncs.FindPlayerByIndex( index );
	
	if ( loaddata[ index ] )
	{
		string fullpath = PATH_MAIN_DATA + "SCXPM_" + g_EngineFuncs.GetPlayerAuthId( pPlayer.edict() ) + ".dat";
		fullpath.Replace( ':', '_' );
		File@ thefile = g_FileSystem.OpenFile( fullpath, OpenFile::WRITE );
		
		if ( thefile !is null && thefile.IsOpen() )
		{
			string stuff;
			
			stuff += string( xp[ index ] ) + "#" + playerlevel[ index ];
			stuff += "#" + skillpoints[ index ] + "#" + medals[ index ];
			stuff += "#" + health[ index ] + "#" + armor[ index ] + "#" + rhealth[ index ] + "#" + rarmor[ index ] + "#" + rammo[ index ] + "#" + gravity[ index ] + "#" + speed[ index ] + "#" + dist[ index ] + "#" + dodge[ index ];
			stuff += "#" + spawndmg[ index ] + "#" + ubercharge[ index ] + "#" + fastheal[ index ] + "#" + demoman[ index ] + "#" + practiceshot[ index ] + "#" + bioelectric[ index ] + "#" + redcross[ index ];
			stuff += "#" + bData[ index ];
			stuff += "#" + hud_red1[ index ] + "#" + hud_green1[ index ] + "#" + hud_blue1[ index ] + "#" + hud_red2[ index ] + "#" + hud_green2[ index ] + "#" + hud_blue2[ index ] + "#" + hud_alpha[ index ];
			stuff += "#" + hud_pos_x[ index ] + "#" + hud_pos_y[ index ] + "#" + hud_effect[ index ] + "#" + hud_ef_fadein[ index ] + "#" + hud_ef_scantime[ index ];
			stuff += "#" + expamp[ index ] + "#" + expamptime[ index ].ToUnixTimestamp();
			stuff += "#" + firstplay[ index ].ToUnixTimestamp() + "#" + nextdaily[ index ].ToUnixTimestamp() + "#" + dailyget[ index ];
			stuff += "#" + bHandicaps[ index ] + "\n";
			
			thefile.Write( stuff );
			thefile.Close();
		}
		else
		{
			// Shutdown server!
			g_Game.AlertMessage( at_logged, "FATAL ERROR (shutting down): PATH_MAIN_DATA is NULL!\n" );
			g_EngineFuncs.ServerCommand( "quit\n" );
		}
	}
}

void scxpm_loaddata( const int& in index )
{
	CBasePlayer@ pPlayer = g_PlayerFuncs.FindPlayerByIndex( index );
	
	string fullpath = PATH_MAIN_DATA + "SCXPM_" + g_EngineFuncs.GetPlayerAuthId( pPlayer.edict() ) + ".dat";
	fullpath.Replace( ':', '_' );
	File@ thefile = g_FileSystem.OpenFile( fullpath, OpenFile::READ );
	
	if ( thefile !is null && thefile.IsOpen() )
	{
		string line;
		
		thefile.ReadLine( line );
		line.Replace( '#', ' ' );
		array< string >@ pre_data = line.Split( ' ' );
		
		pre_data[ 0 ].Trim();
		pre_data[ 1 ].Trim();
		pre_data[ 2 ].Trim();
		pre_data[ 3 ].Trim();
		pre_data[ 4 ].Trim();
		pre_data[ 5 ].Trim();
		pre_data[ 6 ].Trim();
		pre_data[ 7 ].Trim();
		pre_data[ 8 ].Trim();
		pre_data[ 9 ].Trim();
		pre_data[ 10 ].Trim();
		pre_data[ 11 ].Trim();
		pre_data[ 12 ].Trim();
		pre_data[ 13 ].Trim();
		pre_data[ 14 ].Trim();
		pre_data[ 15 ].Trim();
		pre_data[ 16 ].Trim();
		pre_data[ 17 ].Trim();
		pre_data[ 18 ].Trim();
		pre_data[ 19 ].Trim();
		pre_data[ 20 ].Trim();
		pre_data[ 21 ].Trim();
		pre_data[ 22 ].Trim();
		pre_data[ 23 ].Trim();
		pre_data[ 24 ].Trim();
		pre_data[ 25 ].Trim();
		pre_data[ 26 ].Trim();
		pre_data[ 27 ].Trim();
		pre_data[ 28 ].Trim();
		pre_data[ 29 ].Trim();
		pre_data[ 30 ].Trim();
		pre_data[ 31 ].Trim();
		pre_data[ 32 ].Trim();
		pre_data[ 33 ].Trim();
		pre_data[ 34 ].Trim();
		pre_data[ 35 ].Trim();
		pre_data[ 36 ].Trim();
		pre_data[ 37 ].Trim();
		pre_data[ 38 ].Trim();
		
		xp[ index ] = atoi( pre_data[ 0 ] );
		playerlevel[ index ] = atoi( pre_data[ 1 ] );
		scxpm_calcneedxp( index );
		skillpoints[ index ] = atoi( pre_data[ 2 ] );
		medals[ index ] = atoi( pre_data[ 3 ] );
		health[ index ] = atoi( pre_data[ 4 ] );
		armor[ index ] = atoi( pre_data[ 5 ] );
		rhealth[ index ] = atoi( pre_data[ 6 ] );
		rarmor[ index ] = atoi( pre_data[ 7 ] );
		rammo[ index ] = atoi( pre_data[ 8 ] );
		gravity[ index ] = atoi( pre_data[ 9 ] );
		speed[ index ] = atoi( pre_data[ 10 ] );
		dist[ index ] = atoi( pre_data[ 11 ] );
		dodge[ index ] = atoi( pre_data[ 12 ] );
		spawndmg[ index ] = atoi( pre_data[ 13 ] );
		ubercharge[ index ] = atoi( pre_data[ 14 ] );
		fastheal[ index ] = atoi( pre_data[ 15 ] );
		demoman[ index ] = atoi( pre_data[ 16 ] );
		practiceshot[ index ] = atoi( pre_data[ 17 ] );
		bioelectric[ index ] = atoi( pre_data[ 18 ] );
		redcross[ index ] = atoi( pre_data[ 19 ] );
		bData[ index ] = atoi( pre_data[ 20 ] );
		hud_red1[ index ] = atoi( pre_data[ 21 ] );
		hud_green1[ index ] = atoi( pre_data[ 22 ] );
		hud_blue1[ index ] = atoi( pre_data[ 23 ] );
		hud_red2[ index ] = atoi( pre_data[ 24 ] );
		hud_green2[ index ] = atoi( pre_data[ 25 ] );
		hud_blue2[ index ] = atoi( pre_data[ 26 ] );
		hud_alpha[ index ] = atoi( pre_data[ 27 ] );
		hud_pos_x[ index ] = atof( pre_data[ 28 ] );
		hud_pos_y[ index ] = atof( pre_data[ 29 ] );
		hud_effect[ index ] = atoi( pre_data[ 30 ] );
		hud_ef_fadein[ index ] = atof( pre_data[ 31 ] );
		hud_ef_scantime[ index ] = atof( pre_data[ 32 ] );
		expamp[ index ] = atoi( pre_data[ 33 ] );
		expamptime[ index ].SetUnixTimestamp( atoi( pre_data[ 34 ] ) );
		firstplay[ index ].SetUnixTimestamp( atoi( pre_data[ 35 ] ) );
		nextdaily[ index ].SetUnixTimestamp( atoi( pre_data[ 36 ] ) );
		dailyget[ index ] = atoi( pre_data[ 37 ] );
		bHandicaps[ index ] = atoi( pre_data[ 38 ] );
		
		scxpm_amptask(); // Force check
		GetAchievementData( index );
		
		int iCheck = CheckDaily( index, DateTime( UnixTimestamp() ), nextdaily[ index ] );
		if ( iCheck == 1 )
			g_Scheduler.SetTimeout( "scxpm_dailyrewards", 30.0, index, ( dailyget[ index ] + 1 ) );
		else if ( iCheck == -1 )
		{
			string dummy;
			DailyReward( index, 0, false, dummy, dummy );
		}
		
		scxpm_getrank( index );
		
		// Check if handicaps are allowed on this map
		if ( !gNoSkills || gAllowHandicaps )
		{
			// Enabled. Autoselection turned on?
			if ( ( bData[ index ] & HC_AUTOSELECT ) != 0 )
			{
				// On, reactivate the handicaps
				CustomKeyvalues@ pHandicaps = pPlayer.GetCustomKeyvalues();
				
				if ( ( bHandicaps[ index ] & 1 ) != 0 ) 
				{
					handicap1[ index ] = true;
					pHandicaps.SetKeyvalue( "$i_handicap01", 1 );
				}
				if ( ( bHandicaps[ index ] & 2 ) != 0 ) 
				{
					handicap2[ index ] = true;
					pHandicaps.SetKeyvalue( "$i_handicap02", 1 );
				}
				if ( ( bHandicaps[ index ] & 4 ) != 0 ) 
				{
					handicap3[ index ] = true;
					pHandicaps.SetKeyvalue( "$i_handicap03", 1 );
				}
				if ( ( bHandicaps[ index ] & 8 ) != 0 ) 
				{
					handicap4[ index ] = true;
					pHandicaps.SetKeyvalue( "$i_handicap04", 1 );
				}
				if ( ( bHandicaps[ index ] & 16 ) != 0 ) 
				{
					handicap5[ index ] = true;
					pHandicaps.SetKeyvalue( "$i_handicap05", 1 );
				}
				if ( ( bHandicaps[ index ] & 32 ) != 0 ) 
				{
					handicap6[ index ] = true;
					pHandicaps.SetKeyvalue( "$i_handicap06", 1 );
				}
				if ( ( bHandicaps[ index ] & 64 ) != 0 ) 
				{
					handicap7[ index ] = true;
					pHandicaps.SetKeyvalue( "$i_handicap07", 1 );
				}
				if ( ( bHandicaps[ index ] & 128 ) != 0 ) 
				{
					handicap8[ index ] = true;
					pHandicaps.SetKeyvalue( "$i_handicap08", 1 );
				}
				if ( ( bHandicaps[ index ] & 256 ) != 0 ) 
				{
					handicap9[ index ] = true;
					pHandicaps.SetKeyvalue( "$i_handicap09", 1 );
				}
				if ( ( bHandicaps[ index ] & 512 ) != 0 ) 
				{
					handicap10[ index ] = true;
					pHandicaps.SetKeyvalue( "$i_handicap10", 1 );
				}
				if ( ( bHandicaps[ index ] & 1024 ) != 0 ) 
				{
					handicap11[ index ] = true;
					pHandicaps.SetKeyvalue( "$i_handicap11", 1 );
				}
				if ( ( bHandicaps[ index ] & 2048 ) != 0 ) 
				{
					handicap12[ index ] = true;
					pHandicaps.SetKeyvalue( "$i_handicap12", 1 );
				}
				if ( ( bHandicaps[ index ] & 4096 ) != 0 ) 
				{
					handicap13[ index ] = true;
					pHandicaps.SetKeyvalue( "$i_handicap13", 1 );
				}
				if ( ( bHandicaps[ index ] & 8192 ) != 0 ) 
				{
					handicap14[ index ] = true;
					pHandicaps.SetKeyvalue( "$i_handicap14", 1 );
				}
			}
			else
			{
				// Disabled, reset the handicap data
				bHandicaps[ index ] = 0;
			}
		}
		
		thefile.Close();
	}
	
	GetPermaIncrease( index );
	loaddata[ index ] = true;
}

void AddEventEXP( const int& in index )
{
	CBasePlayer@ pPlayer = g_PlayerFuncs.FindPlayerByIndex( index );
	
	string szPath = PATH_EVENT_DATA + "EXP_" + g_EngineFuncs.GetPlayerAuthId( pPlayer.edict() ) + ".evt";
	szPath.Replace( ':', '_' );
	File@ thefile = g_FileSystem.OpenFile( szPath, OpenFile::READ );
	
	if ( thefile !is null && thefile.IsOpen() )
	{
		string szEXP;
		thefile.ReadLine( szEXP );
		
		int pre_iEXP = atoi( szEXP );
		
		xp[ index ] += pre_iEXP;
		
		if ( !gDelayedXP ) earnedxp[ index ] += pre_iEXP; // Prevent double XP exploitation on delayed XP maps
		
		thefile.Close();
		
		DeleteEventEXP( szPath );
	}
	
	// Use this space for other stuff
	CustomKeyvalues@ pCustom = pPlayer.GetCustomKeyvalues();
	CustomKeyvalue iAddAmplifier_pre( pCustom.GetKeyvalue( "$i_cp_expamp" ) );
	int iAddAmplifier = iAddAmplifier_pre.GetInteger();
	if ( iAddAmplifier >= 1 )
	{
		CustomKeyvalue iAMPTime_pre( pCustom.GetKeyvalue( "$i_cp_amptime" ) );
		int iAMPTime = 60;
		if ( iAMPTime_pre.GetInteger() > 0 ) iAMPTime = iAMPTime_pre.GetInteger();
		
		DateTime realduration( UnixTimestamp() );
		TimeDifference extra( iAMPTime * 60 );
		realduration += extra;
		
		if ( expamp[ index ] > 0 )
			CheckConvertAmp( index, iAddAmplifier, iAMPTime );
		else
		{
			expamp[ index ] = iAddAmplifier;
			expamptime[ index ] = realduration;
		}
		
		pCustom.SetKeyvalue( "$i_cp_expamp", 0 );
		pCustom.SetKeyvalue( "$i_cp_amptime", 0 );
	}
	
	CustomKeyvalue iAddMedals_pre( pCustom.GetKeyvalue( "$i_cp_medals" ) );
	int iAddMedals = iAddMedals_pre.GetInteger();
	if ( iAddMedals >= 1 )
	{
		medals[ index ] += iAddMedals;
		if ( medals[ index ] > 9999 )
			medals[ index ] = 9999;
		
		pCustom.SetKeyvalue( "$i_cp_medals", 0 );
	}
	
	CustomKeyvalue szAddPermaIncrease_pre( pCustom.GetKeyvalue( "$s_cp_permaincrease" ) );
	string szAddPermaIncrease = szAddPermaIncrease_pre.GetString();
	if ( szAddPermaIncrease.Length() > 0 )
	{
		CustomKeyvalue szPermaData_pre( pCustom.GetKeyvalue( "$s_cp_permastring" ) );
		string szPermaData = szPermaData_pre.GetString();
		if ( szPermaData.Length() > 0 )
		{
			CustomKeyvalue iPermaValue_pre( pCustom.GetKeyvalue( "$i_cp_permavalue" ) );
			int iPermaValue = iPermaValue_pre.GetInteger();
			
			if ( !HasPermaIncrease( index, szAddPermaIncrease ) )
				AddPermaIncrease( index, string( iPermaValue ) + ".0#" + szAddPermaIncrease + "#" + szPermaData + "!n!n+" + string( iPermaValue ) + "% Ganancia de EXP!n\n" );
		}
		
		pPlayer.KeyValue( "$s_cp_permaincrease", "" );
		pPlayer.KeyValue( "$s_cp_permastring", "" );
		pCustom.SetKeyvalue( "$i_cp_permavalue", 0 );
	}
}

void DeleteEventEXP( const string& in szPath )
{
	File@ thefile = g_FileSystem.OpenFile( szPath, OpenFile::WRITE );
	
	if ( thefile !is null && thefile.IsOpen() )
	{
		thefile.Remove();
		thefile.Close();
	}
}

void LoadEmptySkills( const int& in index )
{
	lastfrags[ index ] = 0.0;
	xp[ index ] = 0.0;
	neededxp[ index ] = 0.0;
	earnedxp[ index ] = 0.0;
	playerlevel[ index ] = 0;
	scxpm_calcneedxp( index );
	scxpm_getrank( index );
	skillpoints[ index ] = 0;
	medals[ index ] = 0;
	health[ index ] = 0;
	armor[ index ] = 0;
	rhealth[ index ] = 0;
	rarmor[ index ] = 0;
	rammo[ index ] = 0;
	gravity[ index ] = 0;
	speed[ index ] = 0;
	dist[ index ] = 0;
	dodge[ index ] = 0;
	spawndmg[ index ] = 0;
	ubercharge[ index ] = 0;
	fastheal[ index ] = 0;
	demoman[ index ] = 0;
	practiceshot[ index ] = 0;
	bioelectric[ index ] = 0;
	bData[ index ] = HUD_EXP + HUD_EXPLEFT + HUD_LEVEL + HUD_CLASS + HUD_MEDALS; // (59) Err...
	hud_red1[ index ] = 50;
	hud_green1[ index ] = 135;
	hud_blue1[ index ] = 180;
	hud_red2[ index ] = 250;
	hud_green2[ index ] = 250;
	hud_blue2[ index ] = 250;
	hud_alpha[ index ] = 0;
	hud_pos_x[ index ] = 0.6;
	hud_pos_y[ index ] = 0.04;
	hud_effect[ index ] = 0;
	hud_ef_fadein[ index ] = 0.0;
	hud_ef_scantime[ index ] = 0.0;
	expamp[ index ] = 0;
	expamptime[ index ] = 0;
	firstplay[ index ] = UnixTimestamp();
	nextdaily[ index ] = DateTime( UnixTimestamp() ) + TimeDifference( 20 * 60 * 60 );
	dailyget[ index ] = 0;
	
	for( uint i = 0; i < szAchievementNames.length(); i++ )
	{
		aData[ index ][ i ] = false;
		aClaim[ index ][ i ] = false;
	}
	
	handicap1[ index ] = false;
	handicap2[ index ] = false;
	handicap3[ index ] = false;
	handicap4[ index ] = false;
	handicap5[ index ] = false;
	handicap6[ index ] = false;
	handicap7[ index ] = false;
	handicap8[ index ] = false;
	handicap9[ index ] = false;
	handicap10[ index ] = false;
	handicap11[ index ] = false;
	handicap12[ index ] = false;
	handicap13[ index ] = false;
	handicap14[ index ] = false;
	bHandicaps[ index ] = 0;
}

// Permament XP increase
void GetPermaIncrease( const int& in index, MenuHandler@ state = null, bool bShowDescription = false, const string& in szNameCheck = "", int& out iEntries = 0, bool bOnlyEntries = false )
{
	CBasePlayer@ pPlayer = g_PlayerFuncs.FindPlayerByIndex( index );
	
	string szPath = PATH_PERMAINCREASE_DATA + "PI_" + g_EngineFuncs.GetPlayerAuthId( pPlayer.edict() ) + ".cfg";
	szPath.Replace( ':', '_' );
	File@ thefile = g_FileSystem.OpenFile( szPath, OpenFile::READ );
	
	bool bFound = false;
	if ( thefile !is null && thefile.IsOpen() )
	{
		string szLine;
		int iItem = -1;
		while( !thefile.EOFReached() )
		{
			// Get all configs
			thefile.ReadLine( szLine );
			if ( szLine.Length() > 0 )
			{
				// We have at least ONE entry on the file
				bFound = true;
				
				// Item IDs
				iItem++;
				iEntries++;
				
				if ( bOnlyEntries )
				{
					// Just counting entries only, ignore all else
					continue;
				}
				
				array< string >@ pre_data = szLine.Split( '#' );
				pre_data[ 0 ].Trim(); // XP Increase
				pre_data[ 1 ].Trim(); // Name
				pre_data[ 2 ].Trim(); // Description
				
				// Replace our characters with new lines
				pre_data[ 2 ].Replace( '!n', '\n' );
				
				if ( state is null ) // No menu handler, get and update XP Increase only
					permaincrease[ index ] += atof( pre_data[ 0 ] );
				else
				{
					if ( bShowDescription ) // Show this config description?
					{
						// Check that our item is really the one we want to show
						if ( szNameCheck == pre_data[ 1 ] )
						{
							state.menu.SetTitle( pre_data[ 1 ] + "\n\n\n" + pre_data[ 2 ] + "\n\n" ); // Title
							state.menu.AddItem( "Return", any( string( iItem ) ) ); // Return button
							break; // End here, we don't want any other unnecesary work on the while loop
						}
					}
					else // Only show title
						state.menu.AddItem( pre_data[ 1 ], any( pre_data[ 1 ] ) );
				}
			}
		}
		
		thefile.Close();
	}
	
	if ( !bFound ) // No entries found
	{
		if ( state !is null )
			state.menu.AddItem( "<empty>", any( "empty" ) );
	}
}

// Get achievement data
void GetAchievementData( const int& in index, MenuHandler@ state = null )
{
	CBasePlayer@ pPlayer = g_PlayerFuncs.FindPlayerByIndex( index );
	
	string szPath = PATH_ACHIEVEMENT_DATA + "A_" + g_EngineFuncs.GetPlayerAuthId( pPlayer.edict() ) + ".ini";
	szPath.Replace( ':', '_' );
	File@ thefile = g_FileSystem.OpenFile( szPath, OpenFile::READ );
	
	if ( thefile !is null && thefile.IsOpen() )
	{
		string szLine;
		while( !thefile.EOFReached() )
		{
			// Get all configs
			thefile.ReadLine( szLine );
			if ( szLine.Length() > 0 )
			{
				array< string >@ pre_data = szLine.Split( '#' );
				pre_data[ 0 ].Trim(); // Achievement ID
				pre_data[ 1 ].Trim(); // Unlock status
				pre_data[ 2 ].Trim(); // Progress / Claim status
				
				// Get data
				// If achievement is unlocked, just hold said data and check claim status
				if ( pre_data[ 1 ] == 'TRUE' )
				{
					aData[ index ][ atoi( pre_data[ 0 ] ) ] = true;
					aClaim[ index ][ atoi( pre_data[ 0 ] ) ] = ( pre_data[ 2 ] == '1' ? true : false );
				}
				else
				{
					// Not unlocked, retrieve progress data and let handler take care of rest
					CustomKeyvalues@ pCustom = pPlayer.GetCustomKeyvalues();
					pCustom.SetKeyvalue( "$i_sys_a_" + pre_data[ 0 ], atoi( pre_data[ 2 ] ) );
				}
				
				// If menu is opened, add item
				if ( state !is null )
				{
					if ( pre_data[ 1 ] == 'TRUE' )
						state.menu.AddItem( "[U] " + szAchievementNames[ atoi( pre_data[ 0 ] ) ] + "\n", any( pre_data[ 0 ] ) );
					else
						state.menu.AddItem( "[-] " + szAchievementNames[ atoi( pre_data[ 0 ] ) ] + "\n", any( pre_data[ 0 ] ) );
				}
			}
		}
		
		thefile.Close();
	}
	else
	{
		// No achievement data
		for ( uint i = 0; i < szAchievementNames.length(); i++ )
		{
			// Force-reset all data to zero
			aData[ index ][ i ] = false;
			aClaim[ index ][ i ] = false;
		}
	}
}

// Save achievement data
void scxpm_saveachievement( const int& in index )
{
	CBasePlayer@ pPlayer = g_PlayerFuncs.FindPlayerByIndex( index );
	
	if ( loaddata[ index ] )
	{
		string szPath = PATH_ACHIEVEMENT_DATA + "A_" + g_EngineFuncs.GetPlayerAuthId( pPlayer.edict() ) + ".ini";
		szPath.Replace( ':', '_' );
		File@ thefile = g_FileSystem.OpenFile( szPath, OpenFile::WRITE );
		
		if ( thefile !is null && thefile.IsOpen() )
		{
			string stuff;
			
			CustomKeyvalues@ pCustom = pPlayer.GetCustomKeyvalues();
			
			for ( uint i = 0; i < szAchievementNames.length(); i++ )
			{
				if ( aData[ index ][ i ] )
					stuff += string( i ) + "#TRUE#" + ( aClaim[ index ][ i ] ? "1" : "0" ) + "\n";
				else
				{
					if ( pCustom.HasKeyvalue( "$i_sys_a_" + string( i ) ) )
					{
						CustomKeyvalue iProgress_pre( pCustom.GetKeyvalue( "$i_sys_a_" + string( i ) ) );
						int iProgress = iProgress_pre.GetInteger();
						stuff += string( i ) + "#FALSE#" + string( iProgress ) + "\n";
					}
					else
						stuff += string( i ) + "#FALSE#0\n";
				}
			}
			
			thefile.Write( stuff );
			thefile.Close();
		}
	}
}

/* Just a congratulatory message */
void scxpm_champion_welcome( const int& in index )
{
	CBasePlayer@ pPlayer = g_PlayerFuncs.FindPlayerByIndex( index );
	MenuHandler@ state = MenuGetPlayer( pPlayer );
	
	state.InitMenu( pPlayer, scxpm_champion_welcome_cb );
	
	// Gather here how many players reached champion status
	string szPath = "scripts/plugins/store/scxpm/champions.sys";
	File@ thefile = g_FileSystem.OpenFile( szPath, OpenFile::READ );
	
	int iPlayers = 0;
	if ( thefile !is null && thefile.IsOpen() )
	{
		string szLine;
		while ( !thefile.EOFReached() )
		{
			thefile.ReadLine( szLine );
			
			// Don't care about the content, just check if there is a valid entry
			if ( szLine.Length() > 8 && szLine != 'STEAM_ID_PENDING' )
				iPlayers++;
		}
		thefile.Close();
	}
	@thefile = g_FileSystem.OpenFile( szPath, OpenFile::APPEND );
	if ( thefile !is null && thefile.IsOpen() )
	{
		// Now that we know how many got them. Add our new champion to the list
		thefile.Write( g_EngineFuncs.GetPlayerAuthId( pPlayer.edict() ) + "\n" );
		thefile.Close();
	}
	
	// Now, congratulatory message to the player
	string szTitle = "I SEE IT AND I DON'T BELIEVE IT!\n\n";
	
	szTitle += "You are the player number #" + ( ++iPlayers ) + " that has managed to\n";
	szTitle += "survive the dauting task of getting all levels and medals\n";
	szTitle += "and crown yourself Champion!\n\n";
	
	szTitle += "Try now to complete pending achievements,\n";
	szTitle += "don't let the adventure end here!\n\n";
	
	szTitle += "From the most, deepest reaches of our hearts:\n";
	szTitle += "Thanks for playing!\n\n";
	
	szTitle += "Your first play ever was on: " + GetFormatDate( firstplay[ index ] ) + "\n";
	szTitle += "You reached Champion status on: " + GetFormatDate( DateTime( UnixTimestamp() ) ) + "\n";
	
	TimeDifference tdTotalDays( DateTime( UnixTimestamp() ), firstplay[ index ] );
	szTitle += "That equals to: " + tdTotalDays.GetDays() + " days of gameplay.\n\n";
	
	szTitle += string( pPlayer.pev.netname ) + "\n";
	szTitle += g_EngineFuncs.GetPlayerAuthId( pPlayer.edict() ) + "\n\n";
	
	state.menu.SetTitle( szTitle );
	state.menu.AddItem( "Yay!", any( "item1" ) );
	
	state.OpenMenu( pPlayer, 0, 0 );
}

void scxpm_champion_welcome_cb( CTextMenu@ menu, CBasePlayer@ pPlayer, int page, const CTextMenuItem@ item )
{
	// Dummy Callback
}

// STOCKS
// ---------
/* Round a float into a integer value */ 
/* Different methods of rounding are shown below*/
enum floatround_method
{
	floatround_round = 0,
	floatround_floor,
	floatround_ceil,
	floatround_tozero
};

int floatround( float& in value, int& in method = floatround_round )
{
	float fA = value;
	
	switch ( method )
	{
		case 1: /* [floatround_floor] round downwards (truncate) */
		{
			fA = Math.Floor( fA );
			break;
		}
		case 2: /* [floatround_ceil] round upwards */
		{
			fA = Math.Ceil( fA );
			break;
		}
		case 3: /* [floatround_tozero] round towards zero */
		{
			if ( fA >= 0.0 )
				fA = Math.Floor( fA );
			else
				fA = Math.Ceil( fA );
			break;
		}
		default: /* [floatround_round] standard, round to nearest */
		{
			fA = Math.Floor( fA + 0.5 );
			break;
		}
	}
	
	return int( fA );
}

/* Converts a float value to a string, with a maximum of 2 decimals */
string fl2Decimals( const float& in value )
{
	// Convert float to string
	string original = string( value );
	
	// Split string using decimal point
	array< string >@ pre_convert = original.Split( '.' );
	
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
	string convert = number + "." + decimals;
	
	return convert;
}

/* Add commas to integers */
string AddCommas( int& in iNum )
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

/* Customized logs */
void SCXPM_Log( const string& in szMessage )
{
	DateTime thetime( UnixTimestamp() );
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
	
	string fullpath = PATH_LOGS + "LOG_" + year + "-" + szMonths + "-" + szDays + ".log";
	File@ thefile = g_FileSystem.OpenFile( fullpath, OpenFile::APPEND );
	
	if ( thefile !is null && thefile.IsOpen() )
	{
		thefile.Write( szHours + ":" + szMinutes + ":" + szSeconds + " - " + szMessage );
		thefile.Close();
	}
}

/* Helper function to find a player by name without being "exact" */
CBasePlayer@ SCXPM_FindPlayer( const string& in szName, bool& out bMultiple = false )
{
	CBasePlayer@ pTarget = null;
	int iTargets = 0;
	
	for ( int i = 1; i <= g_Engine.maxClients; i++ )
	{
		CBasePlayer@ iPlayer = g_PlayerFuncs.FindPlayerByIndex( i );
		
		if ( iPlayer !is null && iPlayer.IsConnected() )
		{
			string szCheck = iPlayer.pev.netname;
			uint iCheck = szCheck.Find( szName, 0, String::CaseInsensitive );
			if ( iCheck == 0 )
			{
				iTargets++;
				@pTarget = iPlayer;
			}
		}
	}
	
	if ( iTargets == 1 )
		return pTarget;
	else if ( iTargets >= 2 )
		bMultiple = true;
	
	return null;
}

/* Helper function to locate a map, without duplicate risk from string.Find() */
bool SCXPM_FindMap( string& in szSearch, string& in szMap )
{
	szSearch.ToLowercase();
	szMap.ToLowercase();
	
	uint iSearch = szSearch.Length();
	uint iMap = szMap.Length();
	
	// Assume this is not our map if lengths do not match
	if ( iSearch != iMap )
		return false;
	
	uint iCheck = 0;
	
	for ( uint i = 0; i < iMap; i++ )
	{
		if ( string( szSearch[ i ] ) == string( szMap[ i ] ) )
			iCheck++;
	}
	
	if ( iCheck == iMap )
		return true;
	
	return false;
}

/* AngelScript port of AMXX function fm_give_item (fakemeta_util.inc) */
int GiveItem( CBasePlayer@ pPlayer, const string& in szItem )
{
	if ( pPlayer is null )
		return 0;
	
	if ( !szItem.StartsWith( "weapon_" ) && !szItem.StartsWith( "ammo_" ) && !szItem.StartsWith( "item_" ) )
		return 0;
	
	CBaseEntity@ pEntity = g_EntityFuncs.Create( szItem, g_vecZero, g_vecZero, true );
	if ( pEntity is null )
		return 0;
	
	Vector vecOrigin;
	vecOrigin = pPlayer.pev.origin;
	g_EntityFuncs.SetOrigin( pEntity, vecOrigin );
	pEntity.pev.spawnflags |= SF_NORESPAWN;
	g_EntityFuncs.DispatchSpawn( pEntity.edict() );
	
	int iSolid = pEntity.pev.solid;
	pEntity.Touch( pPlayer );
	if ( pEntity.pev.solid != iSolid )
		return pEntity.entindex();
	
	g_EntityFuncs.Remove( pEntity );
	
	return -1;
}

/* Shows a MOTD message to the player */
void ShowMOTD( CBasePlayer@ pPlayer, const string& in szTitle, const string& in szMessage )
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

/* Returns the day specified */
string GetFormatDate( DateTime& in dtTime )
{
	// While you can use DateTime's ToString() for this, I made my own function
	// so you can translate the strings to your own language, if you prefer.
	
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
		// Surely, there is a better way...
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

/* Check whenever time is in daily range */
int CheckDaily( const int& in index, DateTime& in dtCurrentTime, DateTime& in dtCheck )
{
	TimeDifference tdCheck( dtCheck, dtCurrentTime );
	if ( tdCheck.GetTimeDifference() < 0.0 ) // Negative means current time is greater than last daily reward get.
	{
		TimeDifference tdExpiration( 24 * 60 * 60 ); // 1 day
		TimeDifference tdLostCheck( ( dtCheck + tdExpiration ), dtCurrentTime );
		if ( tdLostCheck.GetTimeDifference() < 0.0 )
		{
			// Too lost in time
			return -1;
		}
		
		return 1;
	}
	
	return 0;
}

/* Add a new perma-increase to the player */
void AddPermaIncrease( const int& in index, const string& in szData )
{
	// Write to file
	CBasePlayer@ pPlayer = g_PlayerFuncs.FindPlayerByIndex( index );
	string szPath = PATH_PERMAINCREASE_DATA + "PI_" + g_EngineFuncs.GetPlayerAuthId( pPlayer.edict() ) + ".cfg";
	szPath.Replace( ':', '_' );
	File@ thefile = g_FileSystem.OpenFile( szPath, OpenFile::APPEND );
	
	if ( thefile !is null && thefile.IsOpen() )
	{
		thefile.Write( szData );
		thefile.Close();
		
		// Reload perma-increases
		permaincrease[ index ] = 0.0;
		GetPermaIncrease( index );
	}
}

/* Checks if a player has "this" perma-increase */
bool HasPermaIncrease( const int& in index, const string& in szNameCheck )
{
	CBasePlayer@ pPlayer = g_PlayerFuncs.FindPlayerByIndex( index );
	
	string szPath = PATH_PERMAINCREASE_DATA + "PI_" + g_EngineFuncs.GetPlayerAuthId( pPlayer.edict() ) + ".cfg";
	szPath.Replace( ':', '_' );
	File@ thefile = g_FileSystem.OpenFile( szPath, OpenFile::READ );
	
	bool bFound = false;
	if ( thefile !is null && thefile.IsOpen() )
	{
		string szLine;
		while( !thefile.EOFReached() )
		{
			// Get all configs
			thefile.ReadLine( szLine );
			if ( szLine.Length() > 0 )
			{
				array< string >@ pre_data = szLine.Split( '#' );
				pre_data[ 1 ].Trim(); // Name
				
				if ( pre_data[ 1 ] == szNameCheck )
				{
					bFound = true; // The player has this Permanent Increase
					break;
				}
			}
		}
		
		thefile.Close();
	}
	
	return bFound;
}

/* Shows the objetive of an achievement */
string GetAchievementMission( const int& in iAchievementID )
{
	string szReturn;
	switch( iAchievementID )
	{
		case 0: // It would be a shame
			szReturn = "On map abandoned, let the bomb get activated, then\nescape from the facility before it explodes"; break;
		case 1: // Who needs assistance?
			szReturn = "Reach 70 score on any map with all handicaps enabled"; break;
		case 2: // Bronce Chumtoad
			szReturn = "Clear map toadsnatch on Normal difficulty or higher"; break;
		case 3: // Silver Chumtoad
			szReturn = "Clear map toadsnatch on Hard difficulty or higher"; break;
		case 4: // Gold Chumtoad
			szReturn = "Clear map toadsnatch on Extreme difficulty"; break;
		case 5: // A secretless chumtoad
			szReturn = "On toadsnatch, unlock all weapons"; break;
		case 6: // Over MY dead body!
			szReturn = "Clear map quarter on Hard difficulty"; break;
		case 7: // Over YOUR dead body!
			szReturn = "Clear map quarter on Hard difficulty\nwithout letting ANY spawnpoint be destroyed"; break;
		case 8: // Climbing all day
			szReturn = "Clear map sc_persia without deaths and\nwithout using the Anti-Gravity Device skill"; break;
		case 9: // Just another worker
			szReturn = "Clear map mommamesa on any difficulty"; break;
		case 10: // HD Graphics with 3D Support
			szReturn = "On mommamesa, escape from the self destruction sequence"; break;
		case 11: // Svenmessa
			szReturn = "On mommamesa, clear all map objetives on Nightmare difficulty"; break;
		case 12: // Electrician from Hell
			szReturn = "Clear map deadsimpleneo2 on Overload gamemode"; break;
		case 13: // Gonome Degree
			szReturn = "Clear map deadsimpleneo2 on Gonome Hunter gamemode"; break;
		case 14: // NeoDifference
			szReturn = "Clear map deadsimpleneo2 on Protection gamemode"; break;
		case 15: // No more fighting
			szReturn = "On BlackMesaEPF, get across the red lasers and reset the fuse"; break;
		case 16: // Express Squadron
			szReturn = "Clear map sandstone under 9 minutes"; break;
		case 17: // No Lifer? Lies!
			szReturn = "On jumpers, reach 160 score (Rank 1) under 60 minutes"; break;
		case 18: // Routine tasks
			szReturn = "Clear map fortified1 on Normal difficulty or higher"; break;
		case 19: // Apache? Where?
			szReturn = "Clear map fortified1 on Hard difficulty or higher"; break;
		case 20: // S.A.C. Elite
			szReturn = "Clear map fortified1 on Ultra Hard difficulty"; break;
		case 21: // Cheating Death
			szReturn = "Clear map fortified1 on any difficulty with Survival Mode"; break;
		case 22: // I can help, too!
			szReturn = "On map fortified1, resign as commander to assist players\nin the battlefield and help them win the mission."; break;
		case 23: // IMMORTAL
			szReturn = "Clear map fortified1 on Ultra Hard difficulty with Survival Mode"; break;
		case 24: // 2.5D Platformer
			szReturn = "Clear svencoop2's secret puzzle"; break;
		case 25: // My horse is amazing
			szReturn = "Mount a Voltigore and survive for 20 or more seconds"; break;
		case 26: // Decollapse
			szReturn = "Clear map sc_doc without deaths"; break;
		case 27: // Wasting time
			szReturn = "Clear map sc_psyko without using skills"; break;
		case 28: // Upside down
			szReturn = "Clear map turretfortress on Reverse gamemode in Hard difficulty"; break;
		case 29: // Unbeatable Defense
			szReturn = "Clear map turretfortress on Original gamemode in Hard difficulty"; break;
		case 30: // A survivor from beyond
			szReturn = "Clear map sc_robination_revised without deaths"; break;
		case 31: // Neutral Labyrinth
			szReturn = "On sc_mazing, kill all labyrinth hunters and gargantuas"; break;
		case 32: // Not so tedious, okay?
			szReturn = "Clear the entire sc_tetris series under 75 minutes"; break;
		case 33: // quadrazid
			szReturn = "Clear map sc_mazing under 21 minutes"; break;
		case 34: // Forced to Discriminate
			szReturn = "Clear toonrun3's minigame without killing any scientist"; break;
		case 35: // Movie Ticket
			szReturn = "Clear map suspension on Medium difficulty or higher"; break;
		case 36: // Suicide Squad
			szReturn = "Clear map suspension on Insane difficulty"; break;
		case 37: // Complete Infiltration
			szReturn = "On map turretfortress, clear 6 secondary objetives (Reverse)"; break;
		case 38: // Pure Atheism
			szReturn = "Clear map judgement on its maximum difficulty\n(Hard difficulty and increased respawn time)"; break;
		case 39: // Return to sender
			szReturn = "On map infested, destroy the Osprey Helicopter\nand then return to the starting truck"; break;
		default:
			szReturn = "ERR_UNKNOWN_ACHIEVEMENT"; break;
	}
	
	return szReturn;
}

/* Give an achievement reward (if it has) */
void GiveAchievementReward( const int& in index, const int& in iAchievementID )
{
	CBasePlayer@ pPlayer = g_PlayerFuncs.FindPlayerByIndex( index );
	if ( pPlayer !is null )
	{
		switch ( iAchievementID )
		{
			case 0: // It would be a shame
			{
				g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "[SCXPM] Congratulations! Your reward for clearing the achievement is " + ( engage_mode ? "\"3,000 XP\"" : "\"1,500 XP\"" ) + "!\n" );
				
				xp[ index ] += ( engage_mode ? 3000 : 1500 );
				earnedxp[ index ] += ( engage_mode ? 3000 : 1500 );
				
				break;
			}
			case 4: // Gold Chumtoad
			{
				g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "[SCXPM] Congratulations! Your reward for clearing the achievement is \"x2 XP gain\" [" + ( engage_mode ? "4 hours" : "2 hours" ) + "]!\n" );
				
				DateTime realduration( UnixTimestamp() );
				TimeDifference extra( ( engage_mode ? 240 : 120 ) * 60 );
				realduration += extra;
				
				if ( expamp[ index ] > 0 )
					CheckConvertAmp( index, 1, ( engage_mode ? 240 : 120 ) );
				else
				{
					expamp[ index ] = 1;
					expamptime[ index ] = realduration;
				}
				
				break;
			}
			case 7: // Over YOUR dead body!
			{
				g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "[SCXPM] Congratulations! Your reward for clearing the achievement is " + ( engage_mode ? "\"8,000 XP\"" : "\"4,000 XP\"" ) + "!\n" );
				
				xp[ index ] += ( engage_mode ? 8000 : 4000 );
				earnedxp[ index ] += ( engage_mode ? 8000 : 4000 );
				
				break;
			}
			case 13: // Gonome Degree
			{
				g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "[SCXPM] Congratulations! Your reward for clearing the achievement is \"x2 XP gain\" [" + ( engage_mode ? "2 hours" : "1 hour" ) + "]!\n" );
				
				DateTime realduration( UnixTimestamp() );
				TimeDifference extra( ( engage_mode ? 120 : 60 ) * 60 );
				realduration += extra;
				
				if ( expamp[ index ] > 0 )
					CheckConvertAmp( index, 1, ( engage_mode ? 120 : 60 ) );
				else
				{
					expamp[ index ] = 1;
					expamptime[ index ] = realduration;
				}
				
				break;
			}
			case 17: // No Lifer? Lies!
			{
				g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "[SCXPM] Congratulations! Your reward for clearing the achievement is " + ( engage_mode ? "\"2 Medals\"" : "\"1 Medal\"" ) + "!\n" );
				
				medals[ index ] += ( engage_mode ? 2 : 1 );
				
				break;
			}
			case 20: // S.A.C. Elite
			{
				g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "[SCXPM] Congratulations! Your reward for clearing the achievement is " + ( engage_mode ? "\"16,000 XP\"" : "\"8,000 XP\"" ) + "!\n" );
				
				xp[ index ] += ( engage_mode ? 16000 : 8000 );
				earnedxp[ index ] += ( engage_mode ? 16000 : 8000 );
				
				break;
			}
			case 21: // Cheating Death
			{
				g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "[SCXPM] Congratulations! Your reward for clearing the achievement is " + ( engage_mode ? "\"18,000 XP\"" : "\"9,000 XP\"" ) + "!\n" );
				
				xp[ index ] += ( engage_mode ? 18000 : 9000 );
				earnedxp[ index ] += ( engage_mode ? 18000 : 9000 );
				
				break;
			}
			case 23: // IMMORTAL
			{
				// Do not duplicate!
				if ( !HasPermaIncrease( index, "Extreme Fortifier" ) )
				{
					g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "[SCXPM] Congratulations! Your reward for clearing the achievement is \"XP Mod\" [" + ( engage_mode ? "+40%" : "+20%" ) + "]!\n" );
				
					if ( engage_mode )
						AddPermaIncrease( index, "40.0#Extreme Fortifier#Achievement <IMMORTAL> unlocked!n!n+40% XP gain!n\n" );
					else
						AddPermaIncrease( index, "20.0#Extreme Fortifier#Achievement <IMMORTAL> unlocked!n!n+20% XP gain!n\n" );
				}
				
				break;
			}
			case 27: // Wasting time
			{
				g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "[SCXPM] Congratulations! Your reward for clearing the achievement is " + ( engage_mode ? "\"4,000 XP\"" : "\"2,000 XP\"" ) + "!\n" );
				
				xp[ index ] += ( engage_mode ? 4000 : 2000 );
				earnedxp[ index ] += ( engage_mode ? 4000 : 2000 );
				
				break;
			}
			case 28: // Upside down
			{
				g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "[SCXPM] Congratulations! Your reward for clearing the achievement is " + ( engage_mode ? "\"6,000 XP\"" : "\"3,000 XP\"" ) + "!\n" );
				
				xp[ index ] += ( engage_mode ? 6000 : 3000 );
				earnedxp[ index ] += ( engage_mode ? 6000 : 3000 );
				
				break;
			}
			case 29: // Unbeatable Defense
			{
				g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "[SCXPM] Congratulations! Your reward for clearing the achievement is " + ( engage_mode ? "\"12,000 XP\"" : "\"6,000 XP\"" ) + "!\n" );
				
				xp[ index ] += ( engage_mode ? 12000 : 6000 );
				earnedxp[ index ] += ( engage_mode ? 12000 : 6000 );
				
				break;
			}
			case 32: // Not so tedious, okay?
			{
				g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "[SCXPM] Congratulations! Your reward for clearing the achievement is \"x3 XP gain\" [" + ( engage_mode ? "2 hours" : "1 hour" ) + "]!\n" );
				
				DateTime realduration( UnixTimestamp() );
				TimeDifference extra( ( engage_mode ? 120 : 60 ) * 60 );
				realduration += extra;
				
				if ( expamp[ index ] > 0 )
					CheckConvertAmp( index, 2, ( engage_mode ? 120 : 60 ) );
				else
				{
					expamp[ index ] = 2;
					expamptime[ index ] = realduration;
				}
				
				break;
			}
			case 34: // Forced to Discriminate
			{
				g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "[SCXPM] Congratulations! Your reward for clearing the achievement is " + ( engage_mode ? "\"15,000 XP\"" : "\"7,500 XP\"" ) + "!\n" );
				
				xp[ index ] += ( engage_mode ? 15000 : 7500 );
				earnedxp[ index ] += ( engage_mode ? 15000 : 7500 );
				
				break;
			}
			case 36: // Suicide Squad
			{
				g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "[SCXPM] Congratulations! Your reward for clearing the achievement is " + ( engage_mode ? "\"72,000 XP\"" : "\"36,000 XP\"" ) + "!\n" );
				
				xp[ index ] += ( engage_mode ? 72000 : 36000 );
				earnedxp[ index ] += ( engage_mode ? 72000 : 36000 );
				
				break;
			}
		}
		
		aClaim[ index ][ iAchievementID ] = true;
	}
}

/* Returns how many achievements the player has unlocked */
int GetAchievementClear( const int& in index )
{
	int iClear = 0;
	
	CBasePlayer@ pPlayer = g_PlayerFuncs.FindPlayerByIndex( index );
	if ( pPlayer !is null )
	{
		for ( uint i = 0; i < szAchievementNames.length(); i++ )
		{
			if ( aData[ index ][ i ] )
				iClear++;
		}
	}
	
	return iClear;
}

/* AUXILIARY ENTITIES */
class CFlyingMedkit : ScriptBaseEntity // Medkit Dart (scxpm_medkit_dart)
{
	int iHealing;
	Vector pForward;
	
	bool KeyValue( const string& in szKey, const string& in szValue )
	{
		if ( szKey == "forward_vector" )
		{
			// Vector.ToString() format is XX.XXXXX, YY.YYYYY, ZZ.ZZZZZ. Remove the commas.
			string szTemp = szValue;
			szTemp.Replace( ',', '' ); // Should work...
			
			g_Utility.StringToVector( pForward, szTemp );
			return true;
		}
		else
			return BaseClass.KeyValue( szKey, szValue );
	}
	
	void Spawn()
	{
		// Set healing power to player medkit skill CVar
		iHealing = int( g_EngineFuncs.CVarGetFloat( "sk_plr_HpMedic" ) );
		
		// Init
		self.pev.movetype = MOVETYPE_FLY;
		self.pev.solid = SOLID_BBOX;
		
		g_EntityFuncs.SetModel( self, "models/w_medkit.mdl" );
		
		g_EntityFuncs.SetOrigin( self, self.pev.origin );
		g_EntityFuncs.SetSize( self.pev, Vector( -1, -1, -1 ), Vector( 1, 1, 1 ) );
		
		SetTouch( TouchFunction( HitTouch ) );
		SetThink( ThinkFunction( DeleteThink ) );
		self.pev.nextthink = g_Engine.time + 10.0;
		
		// Move forward
		self.pev.velocity = pForward * 4096;
	}
	
	void DeleteThink()
	{
		// We didn't touch anything for a while, delete
		g_EntityFuncs.Remove( self );
	}
	
	void HitTouch( CBaseEntity@ pOther )
	{
		if ( pOther.IsPlayer() && pOther.pev.health < pOther.pev.max_health )
		{
			// Create medkit
			CBaseEntity@ pMedkit = g_EntityFuncs.Create( "trigger_createentity", pOther.pev.origin, g_vecZero, false );
			pMedkit.KeyValue( "m_iszCrtEntChildClass", "item_healthkit" );
			pMedkit.KeyValue( "-health", string( iHealing ) );
			pMedkit.KeyValue( "-movetype", "5" );
			pMedkit.KeyValue( "-spawnflags", "1024" );
			pMedkit.pev.targetname = "i_am_a_ytp";
			
			g_EntityFuncs.FireTargets( "i_am_a_ytp", null, null, USE_TOGGLE, 0.0, 0.0 );
			
			// Save the medkit
			@self.pev.euser2 = pMedkit.edict();
		}
		else if ( pOther.IsMonster() )
		{
			CBaseMonster@ pMonster = cast< CBaseMonster@ >( pOther );
			if ( pMonster.IsAlive() && pMonster.IsPlayerAlly() && pMonster.pev.health < pMonster.pev.max_health )
			{
				pMonster.TakeHealth( float( iHealing ), DMG_MEDKITHEAL );
				g_SoundSystem.EmitSoundDyn( pMonster.edict(), CHAN_BODY, "items/smallmedkit1.wav", VOL_NORM, ATTN_NONE, 0, PITCH_NORM );
			}
		}
		
		// Effect and delete as soon as we touch something
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
		
		HitThink();
	}
	
	void HitThink()
	{
		// Delete the createentity we made
		CBaseEntity@ pMedkit = g_EntityFuncs.Instance( self.pev.euser2 );
		if ( pMedkit !is null )
			g_EntityFuncs.Remove( pMedkit );
		
		// Done here, free zee edicts
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

// Global on purpose
void GiveDelayedXP( const int& in index )
{
	if ( index == 0 )
	{
		for ( int i = 1; i <= g_Engine.maxClients; i++ )
		{
			CBasePlayer@ pPlayer = g_PlayerFuncs.FindPlayerByIndex( i );
			
			if ( pPlayer !is null && pPlayer.IsConnected() )
			{
				xp[ i ] += earnedxp[ i ];
				earnedxp[ i ] = 0;
				
				// RESET RESET
				pPlayer.pev.frags = 0;
				lastfrags[ i ] = 0;
			}
		}
	}
	else
	{
		CBasePlayer@ pPlayer = g_PlayerFuncs.FindPlayerByIndex( index );
		
		if ( pPlayer !is null && pPlayer.IsConnected() )
		{
			xp[ index ] += earnedxp[ index ];
			earnedxp[ index ] = 0;
			
			// RESET RESET
			pPlayer.pev.frags = 0;
			lastfrags[ index ] = 0;
		}
	}
}
