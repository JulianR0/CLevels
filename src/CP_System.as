/*
	CLevels (Imperium Sven Co-op's SCXPM): Cosmetic System
	Copyright (C) 2019  Julian Rodriguez
	
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

const string PATH_DATA = "scripts/plugins/store/cp_data/";

// Color names
const array< string > _ColorNames =
{
	"aliceblue",
	"antiquewhite",
	"aqua",
	"aquamarine",
	"azure",
	"beige",
	"bisque",
	"black",
	"blue",
	"blueviolet",
	"brown",
	"burlywood",
	"cadetblue",
	"chartreuse",
	"chocolate",
	"coral",
	"cornflowerblue",
	"cornsilk",
	"crimson",
	"cyan",
	"darkblue",
	"darkcyan",
	"darkgolden",
	"darkgray",
	"darkgreen",
	"darkkhaki",
	"darkmagenta",
	"darkolive",
	"darkorange",
	"darkorchid",
	"darkred",
	"darksalmon",
	"darkseagreen",
	"darkslateblue",
	"darkslategray",
	"darkturquoise",
	"darkviolet",
	"deeppink",
	"deepskyblue",
	"dimgray",
	"firebrick",
	"forestgreen",
	"gold",
	"gray",
	"green",
	"greenyellow",
	"hotpink",
	"indianred",
	"indigo",
	"ivory",
	"khaki",
	"lavender",
	"lightblue",
	"lightcoral",
	"lightcyan",
	"lightgreen",
	"lightgray",
	"lightpink",
	"lightsalmon",
	"lightseagreen",
	"lightskyblue",
	"lightslategray",
	"lightsteelblue",
	"lightyellow",
	"lime",
	"limegreen",
	"magenta",
	"maroon",
	"mediumblue",
	"mediumorchid",
	"mediumpurple",
	"mediumseagreen",
	"mediumslateblue",
	"mediumturquoise",
	"midnightblue",
	"navy",
	"olive",
	"orange",
	"orangered",
	"orchid",
	"pink",
	"plum",
	"purple",
	"red",
	"rosybrown",
	"royalblue",
	"salmon",
	"scoobidoo",
	"seagreen",
	"sienna",
	"silver",
	"skyblue",
	"slateblue",
	"slategray",
	"snoz",
	"steelblue",
	"tan",
	"teal",
	"tomato",
	"turquoise",
	"violet",
	"wheat",
	"white",
	"yellow",
	"yellowgreen"
};

// Color RGB codes
const array< Vector > _ColorCodes =
{
	Vector( 240, 248, 255 ),
	Vector( 250, 235, 215 ),
	Vector( 000, 255, 255 ),
	Vector( 127, 255, 212 ),
	Vector( 240, 255, 255 ),
	Vector( 245, 245, 220 ),
	Vector( 255, 228, 196 ),
	Vector( 050, 050, 050 ),
	Vector( 010, 010, 250 ),
	Vector( 138, 043, 226 ),
	Vector( 139, 059, 019 ),
	Vector( 222, 184, 135 ),
	Vector( 095, 158, 160 ),
	Vector( 127, 255, 000 ),
	Vector( 210, 105, 030 ),
	Vector( 255, 127, 080 ),
	Vector( 100, 149, 237 ),
	Vector( 255, 248, 220 ),
	Vector( 220, 020, 060 ),
	Vector( 000, 255, 255 ),
	Vector( 024, 000, 076 ),
	Vector( 000, 139, 139 ),
	Vector( 184, 134, 011 ),
	Vector( 169, 169, 169 ),
	Vector( 000, 100, 000 ),
	Vector( 189, 184, 107 ),
	Vector( 139, 000, 139 ),
	Vector( 085, 107, 047 ),
	Vector( 255, 140, 000 ),
	Vector( 153, 050, 204 ),
	Vector( 139, 000, 000 ),
	Vector( 233, 150, 122 ),
	Vector( 143, 188, 143 ),
	Vector( 072, 061, 139 ),
	Vector( 047, 079, 079 ),
	Vector( 000, 206, 209 ),
	Vector( 148, 000, 211 ),
	Vector( 255, 020, 147 ),
	Vector( 000, 191, 255 ),
	Vector( 105, 105, 105 ),
	Vector( 178, 034, 034 ),
	Vector( 034, 139, 034 ),
	Vector( 218, 165, 032 ),
	Vector( 128, 128, 128 ),
	Vector( 010, 250, 010 ),
	Vector( 173, 255, 047 ),
	Vector( 255, 105, 180 ),
	Vector( 205, 092, 092 ),
	Vector( 075, 000, 130 ),
	Vector( 255, 255, 240 ),
	Vector( 240, 230, 140 ),
	Vector( 230, 230, 250 ),
	Vector( 173, 216, 230 ),
	Vector( 240, 128, 128 ),
	Vector( 224, 255, 255 ),
	Vector( 144, 238, 144 ),
	Vector( 211, 211, 211 ),
	Vector( 255, 182, 193 ),
	Vector( 255, 160, 122 ),
	Vector( 032, 178, 170 ),
	Vector( 135, 206, 250 ),
	Vector( 119, 136, 153 ),
	Vector( 176, 196, 222 ),
	Vector( 255, 255, 224 ),
	Vector( 010, 010, 250 ),
	Vector( 050, 205, 050 ),
	Vector( 255, 000, 255 ),
	Vector( 128, 000, 000 ),
	Vector( 000, 000, 205 ),
	Vector( 186, 085, 211 ),
	Vector( 147, 112, 216 ),
	Vector( 060, 179, 113 ),
	Vector( 125, 104, 238 ),
	Vector( 072, 209, 204 ),
	Vector( 025, 025, 112 ),
	Vector( 000, 000, 128 ),
	Vector( 128, 128, 000 ),
	Vector( 255, 148, 009 ),
	Vector( 255, 071, 000 ),
	Vector( 218, 112, 214 ),
	Vector( 255, 192, 203 ),
	Vector( 221, 160, 221 ),
	Vector( 128, 000, 128 ),
	Vector( 250, 010, 010 ),
	Vector( 188, 143, 143 ),
	Vector( 065, 105, 225 ),
	Vector( 250, 128, 114 ),
	Vector( 154, 130, 189 ),
	Vector( 046, 139, 087 ),
	Vector( 160, 082, 045 ),
	Vector( 192, 192, 192 ),
	Vector( 000, 000, 255 ),
	Vector( 106, 090, 205 ),
	Vector( 112, 128, 144 ),
	Vector( 255, 250, 250 ),
	Vector( 070, 130, 180 ),
	Vector( 210, 180, 140 ),
	Vector( 000, 255, 255 ),
	Vector( 255, 099, 071 ),
	Vector( 064, 224, 208 ),
	Vector( 238, 130, 238 ),
	Vector( 245, 222, 179 ),
	Vector( 250, 250, 250 ),
	Vector( 250, 250, 010 ),
	Vector( 154, 205, 050 )
};

const array< string > _TrailSprites =
{
	"sprites/laserbeam.spr", // A
	"sprites/xbeam1.spr", // B
	"sprites/xbeam3.spr", // C
	"sprites/xbeam5.spr", // D
	"sprites/zbeam1.spr", // E
	"sprites/zbeam2.spr", // F
	"sprites/zbeam3.spr", // G
	"sprites/zbeam4.spr", // H
	"sprites/zbeam5.spr", // I
	"sprites/zbeam6.spr", // J
	"sprites/xenobeam.spr", // K
	"sprites/kingpin_beam.spr", // L
	"sprites/glow02.spr", // M
	"sprites/interlace.spr", // N
	"sprites/select.spr", // O
	"sprites/shellchrome.spr", // P
	"sprites/vhe-iconsprites/light.spr", // Q
	"sprites/vhe-iconsprites/light_environment.spr", // R
	"sprites/vhe-iconsprites/light_spot.spr" // S
};

const array< string > _HatsNames =
{
	"afro",
	"angel2",
	"awesome",
	"barrel",
	"beerhat",
	"bucket",
	"cowboy",
	"crowbared",
	"devil2",
	"elf",
	"headphones",
	"hellokitty",
	"jackinbox",
	"jackolantern",
	"jamacahat2",
	"joker",
	"js",
	"lemonhead",
	"magic",
	"mau5",
	"pirate2",
	"popeye",
	"psycho",
	"rubikscube",
	"santahat2",
	"shoopdawhoop",
	"spongebob",
	"svencoop",
	"tv",
	"zippy"
};

// Main data
array< int > iCP( 33 );
array< bool > bShouldUpdate( 33 );
array< float > lastfrags( 33 );

// Glow data
array< array< bool >> bGlow( 33, array< bool > ( 6 ) );

array< int > iSelectedColors( 33 );
array< int > iChoosenColors( 33 );
array< int > iMaxColors( 33 );

array< array< Vector >> vecGlowColor( 33, array< Vector > ( 6 ) );
array< array< Vector >> vecGlowUpdate( 33, array< Vector > ( 6 ) );

array< bool > bHasCustomGlow( 33 );
array< int > iCustomProgress( 33 );
array< array< Vector >> vecCustomGlowColor( 33, array< Vector > ( 6 ) );
array< string > szCustomGlowName( 33 );
array< array< string >> szSelectedColor( 33, array< string > ( 6 ) );
array< string > szPrivateGlowMsg( 33 );
array< string > szPublicGlowMsg( 33 );

array< int > iGlowAlternate( 33 );

// Trail data
array< bool > bTrail( 33 );
array< int > iTrailSpriteIndex( _TrailSprites.length() );

array< Vector > vecTrailColor( 33 );
array< int > iTrailSprite( 33 );
array< uint8 > iTrailLong( 33 );
array< uint8 > iTrailSize( 33 );
array< Vector > vecTrailUpdate( 33 );
array< int > iTrailNewSprite( 33 );
array< uint8 > iTrailNewLong( 33 );
array< uint8 > iTrailNewSize( 33 );

array< bool > bTrailActive( 33 );

// Hat data
array< EHandle > hatEntity( 33 );
array< bool > hatGlow( 33 );
array< Vector > hatGlowColor( 33 );

// Misc data
array< bool > loaddata( 33 );

// Misc Data
array< int > bHasMGAccess( 33 );
array< int > iGiftType( 33 );
array< int > iGiftAmount( 33 );
array< string > szGiftDestination( 33 );
array< string > szGiftMessage( 33 );
array< int > iGiftCost( 33 );
array< bool> bIsChampion( 33 );

// Fireworks
array< int > iFireworks( 33 );
int sprSmoke;
int ls_dot;
int shockwave;
int sprFlare6;
int sprLightning;
int sprRflare;
int sprGflare;
int sprBflare;
int sprTflare;
int sprPflare;
int sprYflare;
int sprOflare;
int flare3;

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

void PluginInit()
{
	g_Module.ScriptInfo.SetAuthor( "Julian \"Giegue\" Rodriguez" );
	g_Module.ScriptInfo.SetContactInfo( "www.steamcommunity.com/id/ngiegue" );
	
	g_Hooks.RegisterHook( Hooks::Player::ClientSay, @ClientSay );
	g_Hooks.RegisterHook( Hooks::Player::ClientPutInServer, @ClientPutInServer );
	g_Hooks.RegisterHook( Hooks::Player::ClientDisconnect, @ClientDisconnect );
	
	g_Scheduler.SetInterval( "DoStuff", 1.0, g_Scheduler.REPEAT_INFINITE_TIMES );
}

void MapInit()
{
	for ( int i = 0; i < 33; i++ )
	{
		iCP[ i ] = 0;
		bShouldUpdate[ i ] = false;
		
		for ( int j = 0; j < 6; j++ )
		{
			bGlow[ i ][ j ] = false;
			vecGlowColor[ i ][ j ] = g_vecZero;
			vecGlowUpdate[ i ][ j ] = g_vecZero;
			vecCustomGlowColor[ i ][ j ] = g_vecZero;
			szSelectedColor[ i ][ j ] = "<ninguno>";
		}
		iGlowAlternate[ i ] = 1;
		iSelectedColors[ i ] = 1;
		iChoosenColors[ i ] = 0;
		iMaxColors[ i ] = 1;
		bHasCustomGlow[ i ] = false;
		szCustomGlowName[ i ] = "NULL";
		szPrivateGlowMsg[ i ] = "NULL";
		szPublicGlowMsg[ i ] = "NULL";
		iCustomProgress[ i ] = 0;
		
		bTrail[ i ] = false;
		vecTrailColor[ i ] = g_vecZero;
		iTrailSprite[ i ] = 0;
		iTrailLong[ i ] = 20;
		iTrailSize[ i ] = 8;
		vecTrailUpdate[ i ] = g_vecZero;
		iTrailNewSprite[ i ] = 0;
		iTrailNewLong[ i ] = 20;
		iTrailNewSize[ i ] = 8;
		bTrailActive[ i ] = false;
		
		hatEntity[ i ] = null;
		hatGlow[ i ] = false;
		hatGlowColor[ i ] = g_vecZero;
		
		bHasMGAccess[ i ] = 0;
		iGiftType[ i ] = 0;
		iGiftAmount[ i ] = 0;
		szGiftDestination[ i ] = "";
		szGiftMessage[ i ] = "";
		iGiftCost[ i ] = 0;
		bIsChampion[ i ] = false;
		
		loaddata[ i ] = false;
		
		lastfrags[ i ] = 0.0;
		
		iFireworks[ i ] = 0;
	}
	
	// Fireworks
	sprSmoke = g_Game.PrecacheModel( "sprites/smoke.spr" );
	ls_dot = g_Game.PrecacheModel( "sprites/laserdot.spr" );
	shockwave = g_Game.PrecacheModel( "sprites/shockwave.spr" );
	sprFlare6 = g_Game.PrecacheModel( "sprites/flare6.spr" );
	sprLightning = g_Game.PrecacheModel( "sprites/lgtning.spr" );
	sprBflare = g_Game.PrecacheModel( "sprites/fireworks/bflare.spr" );
	sprRflare = g_Game.PrecacheModel( "sprites/fireworks/rflare.spr" );
	sprGflare = g_Game.PrecacheModel( "sprites/fireworks/gflare.spr" );
	sprTflare = g_Game.PrecacheModel( "sprites/fireworks/tflare.spr" );
	sprOflare = g_Game.PrecacheModel( "sprites/fireworks/oflare.spr" );
	sprPflare = g_Game.PrecacheModel( "sprites/fireworks/pflare.spr" );
	sprYflare = g_Game.PrecacheModel( "sprites/fireworks/yflare.spr" );
	flare3 = g_Game.PrecacheModel( "sprites/flare3.spr" );
	
	g_Game.PrecacheModel( "models/rpgrocket.mdl" );
	g_Game.PrecacheModel( "models/w_rpgammo.mdl" );
	
	g_SoundSystem.PrecacheSound( "weapons/explode3.wav" );
	g_SoundSystem.PrecacheSound( "weapons/explode4.wav" );
	g_SoundSystem.PrecacheSound( "weapons/explode5.wav" );
	
	g_SoundSystem.PrecacheSound( "weapons/rocketfire1.wav" );
	g_SoundSystem.PrecacheSound( "weapons/mortarhit.wav" );
	g_SoundSystem.PrecacheSound( "ambience/thunder_clap.wav" );
	
	g_SoundSystem.PrecacheSound( "fireworks/rocket1.wav" );
	g_SoundSystem.PrecacheSound( "fireworks/weapondrop1.wav" );
	g_Game.PrecacheGeneric( "sound/fireworks/rocket1.wav" );
	g_Game.PrecacheGeneric( "sound/fireworks/weapondrop1.wav" );
	
	for ( uint i = 0; i < _TrailSprites.length(); i++ )
	{
		iTrailSpriteIndex[ i ] = g_Game.PrecacheModel( _TrailSprites[ i ] );
	}
	
	for ( uint i = 0; i < _HatsNames.length(); i++ )
	{
		string szModel = "models/hats/" + _HatsNames[ i ] + ".mdl";
		g_Game.PrecacheModel( szModel );
	}
}

HookReturnCode ClientPutInServer( CBasePlayer@ pPlayer )
{
	int index = pPlayer.entindex();
	
	iCP[ index ] = 0;
	bShouldUpdate[ index ] = false;
	lastfrags[ index ] = 0.0;
	
	for ( int i = 0; i < 6; i++ )
	{
		bGlow[ index ][ i ] = false;
		vecGlowColor[ index ][ i ] = g_vecZero;
		vecGlowUpdate[ index ][ i ] = g_vecZero;
		vecCustomGlowColor[ index ][ i ] = g_vecZero;
		szSelectedColor[ index ][ i ] = "<ninguno>";
	}
	iGlowAlternate[ index ] = 1;
	iSelectedColors[ index ] = 1;
	iChoosenColors[ index ] = 0;
	iMaxColors[ index ] = 1;
	bHasCustomGlow[ index ] = false;
	szCustomGlowName[ index ] = "NULL";
	szPrivateGlowMsg[ index ] = "NULL";
	szPublicGlowMsg[ index ] = "NULL";
	iCustomProgress[ index ] = 0;
	
	bTrail[ index ] = false;
	vecTrailColor[ index ] = g_vecZero;
	iTrailSprite[ index ] = 0;
	iTrailLong[ index ] = 20;
	iTrailSize[ index ] = 8;
	vecTrailUpdate[ index ] = g_vecZero;
	iTrailNewSprite[ index ] = 0;
	iTrailNewLong[ index ] = 20;
	iTrailNewSize[ index ] = 8;
	bTrailActive[ index ] = false;
	
	hatEntity[ index ] = null;
	hatGlow[ index ] = false;
	hatGlowColor[ index ] = g_vecZero;
	
	bHasMGAccess[ index ] = 0;
	iGiftType[ index ] = 0;
	iGiftAmount[ index ] = 0;
	szGiftDestination[ index ] = "";
	szGiftMessage[ index ] = "";
	iGiftCost[ index ] = 0;
	bIsChampion[ index ] = false;
	
	iFireworks[ index ] = 0;
	
	loaddata[ index ] = false;
	
	LoadCP( index );
	
	return HOOK_CONTINUE;
}

HookReturnCode ClientDisconnect( CBasePlayer@ pPlayer )
{
	int index = pPlayer.entindex();
	
	iCP[ index ] = 0;
	bShouldUpdate[ index ] = false;
	lastfrags[ index ] = 0.0;
	
	for ( int i = 0; i < 6; i++ )
	{
		bGlow[ index ][ i ] = false;
		vecGlowColor[ index ][ i ] = g_vecZero;
		vecGlowUpdate[ index ][ i ] = g_vecZero;
		vecCustomGlowColor[ index ][ i ] = g_vecZero;
		szSelectedColor[ index ][ i ] = "<ninguno>";
	}
	iGlowAlternate[ index ] = 1;
	iSelectedColors[ index ] = 1;
	iChoosenColors[ index ] = 0;
	iMaxColors[ index ] = 1;
	bHasCustomGlow[ index ] = false;
	szCustomGlowName[ index ] = "NULL";
	szPrivateGlowMsg[ index ] = "NULL";
	szPublicGlowMsg[ index ] = "NULL";
	iCustomProgress[ index ] = 0;
	
	bTrail[ index ] = false;
	vecTrailColor[ index ] = g_vecZero;
	iTrailSprite[ index ] = 0;
	iTrailLong[ index ] = 20;
	iTrailSize[ index ] = 8;
	vecTrailUpdate[ index ] = g_vecZero;
	iTrailNewSprite[ index ] = 0;
	iTrailNewLong[ index ] = 20;
	iTrailNewSize[ index ] = 8;
	bTrailActive[ index ] = false;
	
	hatEntity[ index ] = null;
	hatGlow[ index ] = false;
	hatGlowColor[ index ] = g_vecZero;
	
	bHasMGAccess[ index ] = 0;
	iGiftType[ index ] = 0;
	iGiftAmount[ index ] = 0;
	szGiftDestination[ index ] = "";
	szGiftMessage[ index ] = "";
	iGiftCost[ index ] = 0;
	bIsChampion[ index ] = false;
	
	iFireworks[ index ] = 0;
	
	loaddata[ index ] = false;
	
	return HOOK_CONTINUE;
}

void SaveCP( const int& in index )
{
	CBasePlayer@ pPlayer = g_PlayerFuncs.FindPlayerByIndex( index );
	
	if ( loaddata[ index ] )
	{
		string fullpath = "" + PATH_DATA + "CP_" + g_EngineFuncs.GetPlayerAuthId( pPlayer.edict() ) + ".data";
		fullpath.Replace( ':', '_' );
		File@ thefile = g_FileSystem.OpenFile( fullpath, OpenFile::WRITE );
		
		if ( thefile !is null && thefile.IsOpen() )
		{
			string stuff;
			
			stuff += "" + iCP[ index ] + "#" + iMaxColors[ index ] + "#" + ( bHasCustomGlow[ index ] ? "TRUE" : "FALSE" );
			stuff += "#" + int( vecCustomGlowColor[ index ][ 0 ].x ) + " " + int( vecCustomGlowColor[ index ][ 0 ].y ) + " " + int( vecCustomGlowColor[ index ][ 0 ].z );
			stuff += "#" + int( vecCustomGlowColor[ index ][ 1 ].x ) + " " + int( vecCustomGlowColor[ index ][ 1 ].y ) + " " + int( vecCustomGlowColor[ index ][ 1 ].z );
			stuff += "#" + int( vecCustomGlowColor[ index ][ 2 ].x ) + " " + int( vecCustomGlowColor[ index ][ 2 ].y ) + " " + int( vecCustomGlowColor[ index ][ 2 ].z );
			stuff += "#" + int( vecCustomGlowColor[ index ][ 3 ].x ) + " " + int( vecCustomGlowColor[ index ][ 3 ].y ) + " " + int( vecCustomGlowColor[ index ][ 3 ].z );
			stuff += "#" + int( vecCustomGlowColor[ index ][ 4 ].x ) + " " + int( vecCustomGlowColor[ index ][ 4 ].y ) + " " + int( vecCustomGlowColor[ index ][ 4 ].z );
			stuff += "#" + int( vecCustomGlowColor[ index ][ 5 ].x ) + " " + int( vecCustomGlowColor[ index ][ 5 ].y ) + " " + int( vecCustomGlowColor[ index ][ 5 ].z );
			stuff += "#" + szCustomGlowName[ index ] + "#" + szPrivateGlowMsg[ index ] + "#" + szPublicGlowMsg[ index ];
			stuff += "\n";
			
			thefile.Write( stuff );
			thefile.Close();
		}
	}
}

void LoadCP( const int& in index )
{
	CBasePlayer@ pPlayer = g_PlayerFuncs.FindPlayerByIndex( index );
	
	string fullpath = "" + PATH_DATA + "CP_" + g_EngineFuncs.GetPlayerAuthId( pPlayer.edict() ) + ".data";
	fullpath.Replace( ':', '_' );
	File@ thefile = g_FileSystem.OpenFile( fullpath, OpenFile::READ );
	
	if ( thefile !is null && thefile.IsOpen() )
	{
		string line;
		
		thefile.ReadLine( line );
		array< string >@ pre_data = line.Split( '#' );
		
		// File corrupted?
		if ( line[ 0 ] == ' ' ) // Empty whitespace
		{
			// Manual restore file to "new data"
			pre_data.resize( 12 );
			pre_data[ 0 ] = "0"; // iCP
			pre_data[ 1 ] = "1"; // iMaxColors
			pre_data[ 2 ] = "FALSE"; // bHasCustomGlow
			pre_data[ 3 ] = "0 0 0"; // vecCustomGlowColor[ 0 ]
			pre_data[ 4 ] = "0 0 0"; // vecCustomGlowColor[ 1 ]
			pre_data[ 5 ] = "0 0 0"; // vecCustomGlowColor[ 2 ]
			pre_data[ 6 ] = "0 0 0"; // vecCustomGlowColor[ 3 ]
			pre_data[ 7 ] = "0 0 0"; // vecCustomGlowColor[ 4 ]
			pre_data[ 8 ] = "0 0 0"; // vecCustomGlowColor[ 5 ]
			pre_data[ 9 ] = "NULL"; // szCustomGlowName
			pre_data[ 10 ] = "NULL"; // szPrivateGlowMsg
			pre_data[ 11 ] = "NULL"; // szPublicGlowMsg
		}
		else if ( pre_data.length() < 12 )
		{
			// Fix for older data
			pre_data.resize( 12 );
			pre_data[ 10 ] = "NULL";
			pre_data[ 11 ] = "NULL";
		}
		
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
		
		iCP[ index ] = atoi( pre_data[ 0 ] );
		iMaxColors[ index ] = atoi( pre_data[ 1 ] );
		if ( pre_data[ 2 ] == 'TRUE' ) bHasCustomGlow[ index ] = true;
		else bHasCustomGlow[ index ] = false;
		
		array< string >@ pre_vector1 = pre_data[ 3 ].Split( ' ' );
		vecCustomGlowColor[ index ][ 0 ].x = atoi( pre_vector1[ 0 ] );
		vecCustomGlowColor[ index ][ 0 ].y = atoi( pre_vector1[ 1 ] );
		vecCustomGlowColor[ index ][ 0 ].z = atoi( pre_vector1[ 2 ] );
		array< string >@ pre_vector2 = pre_data[ 4 ].Split( ' ' );
		vecCustomGlowColor[ index ][ 1 ].x = atoi( pre_vector2[ 0 ] );
		vecCustomGlowColor[ index ][ 1 ].y = atoi( pre_vector2[ 1 ] );
		vecCustomGlowColor[ index ][ 1 ].z = atoi( pre_vector2[ 2 ] );
		array< string >@ pre_vector3 = pre_data[ 5 ].Split( ' ' );
		vecCustomGlowColor[ index ][ 2 ].x = atoi( pre_vector3[ 0 ] );
		vecCustomGlowColor[ index ][ 2 ].y = atoi( pre_vector3[ 1 ] );
		vecCustomGlowColor[ index ][ 2 ].z = atoi( pre_vector3[ 2 ] );
		array< string >@ pre_vector4 = pre_data[ 6 ].Split( ' ' );
		vecCustomGlowColor[ index ][ 3 ].x = atoi( pre_vector4[ 0 ] );
		vecCustomGlowColor[ index ][ 3 ].y = atoi( pre_vector4[ 1 ] );
		vecCustomGlowColor[ index ][ 3 ].z = atoi( pre_vector4[ 2 ] );
		array< string >@ pre_vector5 = pre_data[ 7 ].Split( ' ' );
		vecCustomGlowColor[ index ][ 4 ].x = atoi( pre_vector5[ 0 ] );
		vecCustomGlowColor[ index ][ 4 ].y = atoi( pre_vector5[ 1 ] );
		vecCustomGlowColor[ index ][ 4 ].z = atoi( pre_vector5[ 2 ] );
		array< string >@ pre_vector6 = pre_data[ 8 ].Split( ' ' );
		vecCustomGlowColor[ index ][ 5 ].x = atoi( pre_vector6[ 0 ] );
		vecCustomGlowColor[ index ][ 5 ].y = atoi( pre_vector6[ 1 ] );
		vecCustomGlowColor[ index ][ 5 ].z = atoi( pre_vector6[ 2 ] );
		
		szCustomGlowName[ index ] = pre_data[ 9 ];
		szPrivateGlowMsg[ index ] = pre_data[ 10 ];
		szPublicGlowMsg[ index ] = pre_data[ 11 ];
		
		// This is a bastardized hack, but I don't want to create another keyvalue for it
		string mgpath = "" + "scripts/plugins/store/scxpm_data/" + "SCXPM_" + g_EngineFuncs.GetPlayerAuthId( pPlayer.edict() ) + ".data";
		mgpath.Replace( ':', '_' );
		File@ mgfile = g_FileSystem.OpenFile( mgpath, OpenFile::READ );
		
		if ( mgfile !is null && mgfile.IsOpen() )
		{
			string mgline;
			
			mgfile.ReadLine( mgline );
			array< string >@ pre_check = mgline.Split( '#' );
			if ( pre_check.length() >= 45 )
			{
				pre_check[ 44 ].Trim();
				bHasMGAccess[ index ] = atoi( pre_check[ 44 ] );
			}
			
			mgfile.Close();
		}
		
		// Champion check
		string szPath = "scripts/plugins/store/scxpm_post/champions.sys";
		File@ champfile = g_FileSystem.OpenFile( szPath, OpenFile::READ );
		
		string szCheck = g_EngineFuncs.GetPlayerAuthId( pPlayer.edict() );
		if ( champfile !is null && champfile.IsOpen() )
		{
			string szLine;
			while ( !champfile.EOFReached() )
			{
				champfile.ReadLine( szLine );
				if ( szLine == szCheck )
				{
					bIsChampion[ index ] = true;
					break;
				}
			}
			champfile.Close();
		}
		
		thefile.Close();
	}
	
	loaddata[ index ] = true;
}

CClientCommand ADMIN_ADDXP( "cp_addcp", "<Nombre> <Valor> - Dar PC a un jugador", @CPS_AddCP, ConCommandFlag::AdminOnly );
void CPS_AddCP( const CCommand@ pArgs )
{
	CBasePlayer@ pPlayer = g_ConCommandSystem.GetCurrentPlayer();
	
	if ( pArgs.ArgC() >= 3 )
	{
		bool bMultiple = false;
		CBasePlayer@ pTarget = FindPlayer( pArgs[ 1 ], bMultiple );
		
		if ( bMultiple )
			g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTCONSOLE, "* Multiples jugadores encontrados. Se mas especifico\n" );
		else if ( pTarget !is null )
		{
			int addxp = atoi( pArgs[ 2 ] );
			int index = pTarget.entindex();
			
			// Get now the target's and the admin's name and steamid
			string aname = pPlayer.pev.netname;
			string asteamid = g_EngineFuncs.GetPlayerAuthId( pPlayer.edict() );
			string tname = pTarget.pev.netname;
			string tsteamid = g_EngineFuncs.GetPlayerAuthId( pTarget.edict() );
			
			iCP[ index ] += addxp;
		}
		else
			g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTCONSOLE, "* ERROR: Jugador no encontrado\n" );
	}
	else if ( pArgs.ArgC() == 1 )
		g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTCONSOLE, "* Modo de uso: .cp_addcp <Nombre> <Valor> - Dar PC a un jugador\n" );
	else
		g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTCONSOLE, "* ERROR: Parametros insuficientes\n" );
}

void DoStuff()
{
	for ( int i = 1; i <= g_Engine.maxClients; i++ )
	{
		CBasePlayer@ pPlayer = g_PlayerFuncs.FindPlayerByIndex( i );
		
		if ( pPlayer !is null && pPlayer.IsConnected() )
		{
			// Update CP first
			float flCPGain = 1.000;
			if ( bIsChampion[ i ] ) flCPGain = 1.058;
			
			float flVar = float( iCP[ i ] ) / 5.0 / flCPGain + pPlayer.pev.frags - lastfrags[ i ];
			iCP[ i ] = floatround( flVar * 5.0 * flCPGain );
			
			// If we can have extra CP, add them
			CustomKeyvalues@ pKVD = pPlayer.GetCustomKeyvalues();
			CustomKeyvalue iExtraCP_pre( pKVD.GetKeyvalue( "$i_cp_extra" ) );
			int iExtraCP = iExtraCP_pre.GetInteger();
			
			if ( iExtraCP > 0 )
				iCP[ i ] += iExtraCP;
			
			pKVD.SetKeyvalue( "$i_cp_extra", 0 );
			
			SaveCP( i );
			lastfrags[ i ] = pPlayer.pev.frags;
			
			if ( bGlow[ i ][ 0 ] && iGlowAlternate[ i ] == 1 )
			{
				pPlayer.pev.renderfx = kRenderFxGlowShell;
				pPlayer.pev.renderamt = 3;
				pPlayer.pev.rendercolor = vecGlowColor[ i ][ 0 ];
				
				if ( bGlow[ i ][ 1 ] )
					iGlowAlternate[ i ] = 2;
				else
					iGlowAlternate[ i ] = 1;
			}
			else if ( bGlow[ i ][ 1 ] && iGlowAlternate[ i ] == 2 )
			{
				pPlayer.pev.renderfx = kRenderFxGlowShell;
				pPlayer.pev.renderamt = 3;
				pPlayer.pev.rendercolor = vecGlowColor[ i ][ 1 ];
				
				if ( bGlow[ i ][ 2 ] )
					iGlowAlternate[ i ] = 3;
				else
					iGlowAlternate[ i ] = 1;
			}
			else if ( bGlow[ i ][ 2 ] && iGlowAlternate[ i ] == 3 )
			{
				pPlayer.pev.renderfx = kRenderFxGlowShell;
				pPlayer.pev.renderamt = 3;
				pPlayer.pev.rendercolor = vecGlowColor[ i ][ 2 ];
				
				if ( bGlow[ i ][ 3 ] )
					iGlowAlternate[ i ] = 4;
				else
					iGlowAlternate[ i ] = 1;
			}
			else if ( bGlow[ i ][ 3 ] && iGlowAlternate[ i ] == 4 )
			{
				pPlayer.pev.renderfx = kRenderFxGlowShell;
				pPlayer.pev.renderamt = 3;
				pPlayer.pev.rendercolor = vecGlowColor[ i ][ 3 ];
				
				if ( bGlow[ i ][ 4 ] )
					iGlowAlternate[ i ] = 5;
				else
					iGlowAlternate[ i ] = 1;
			}
			else if ( bGlow[ i ][ 4 ] && iGlowAlternate[ i ] == 5 )
			{
				pPlayer.pev.renderfx = kRenderFxGlowShell;
				pPlayer.pev.renderamt = 3;
				pPlayer.pev.rendercolor = vecGlowColor[ i ][ 4 ];
				
				if ( bGlow[ i ][ 5 ] )
					iGlowAlternate[ i ] = 6;
				else
					iGlowAlternate[ i ] = 1;
			}
			else if ( bGlow[ i ][ 5 ] && iGlowAlternate[ i ] == 6 )
			{
				pPlayer.pev.renderfx = kRenderFxGlowShell;
				pPlayer.pev.renderamt = 3;
				pPlayer.pev.rendercolor = vecGlowColor[ i ][ 5 ];
				
				iGlowAlternate[ i ] = 1;
			}
			
			if ( bTrail[ i ] && !bTrailActive[ i ] && pPlayer.pev.velocity.Length() >= 2 )
			{
				bTrailActive[ i ] = true;
				if ( vecTrailColor[ i ] != g_vecZero )
				{
					uint8 r = int( vecTrailColor[ i ].x );
					uint8 g = int( vecTrailColor[ i ].y );
					uint8 b = int( vecTrailColor[ i ].z );
					
					NetworkMessage restarter( MSG_BROADCAST, NetworkMessages::SVC_TEMPENTITY );
					restarter.WriteByte( TE_KILLBEAM );
					restarter.WriteShort( pPlayer.entindex() );
					restarter.End();
					
					NetworkMessage message( MSG_BROADCAST, NetworkMessages::SVC_TEMPENTITY );
					message.WriteByte( TE_BEAMFOLLOW );
					message.WriteShort( pPlayer.entindex() );
					message.WriteShort( iTrailSpriteIndex[ iTrailSprite[ i ] ] );
					message.WriteByte( iTrailLong[ i ] );
					message.WriteByte( iTrailSize[ i ] );
					message.WriteByte( r );
					message.WriteByte( g );
					message.WriteByte( b );
					message.WriteByte( 200 );
					message.End();
				}
			}
			else if ( bTrailActive[ i ] && pPlayer.pev.velocity.Length() == 0 )
				bTrailActive[ i ] = false;
		}
	}
}

HookReturnCode ClientSay( SayParameters@ pParams )
{
	CBasePlayer@ pPlayer = pParams.GetPlayer();
	ClientSayType type = pParams.GetSayType();
	
	if ( type == CLIENTSAY_SAY )
	{
		string text = pParams.GetCommand();
		if ( text == '/cp' )
		{
			pParams.ShouldHide = true;
			CPMenu( pPlayer.entindex() );
			return HOOK_HANDLED;
		}
		else if ( text == '/hats' )
		{
			pParams.ShouldHide = true;
			CP_Hats( pPlayer.entindex() );
			return HOOK_HANDLED;
		}
		/*else if ( text == '/fireworks' )
		{
			pParams.ShouldHide = true;
			CP_Fireworks( pPlayer.entindex() );
			return HOOK_HANDLED;
		}*/
		else
		{
			// Check for commands with arguments
			const CCommand@ args = pParams.GetArguments();
			if ( args[ 0 ] == '/glow' )
			{
				GlowCommand( pParams );
				return HOOK_HANDLED;
			}
			else if ( args[ 0 ] == '/glowcolor' )
			{
				SetGlowColor( pParams );
				return HOOK_HANDLED;
			}
			else if ( args[ 0 ] == '/glowname' )
			{
				SetGlowName( pParams );
				return HOOK_HANDLED;
			}
			else if ( args[ 0 ] == '/glowprivate' )
			{
				SetGlowPrivate( pParams );
				return HOOK_HANDLED;
			}
			else if ( args[ 0 ] == '/glowpublic' )
			{
				SetGlowPublic( pParams );
				return HOOK_HANDLED;
			}
			else if ( args[ 0 ] == '/trail' )
			{
				TrailCommand( pParams );
				return HOOK_HANDLED;
			}
			else if ( args[ 0 ] == '/giftamount' )
			{
				MGSetAmount( pParams );
				return HOOK_HANDLED;
			}
			else if ( args[ 0 ] == '/giftplayer' )
			{
				MGSetPlayer( pParams );
				return HOOK_HANDLED;
			}
			else if ( args[ 0 ] == '/giftmessage' )
			{
				MGSetMessage( pParams );
				return HOOK_HANDLED;
			}
		}
	}
	
	return HOOK_CONTINUE;
}

void GlowCommand( SayParameters@ pParams )
{
	pParams.ShouldHide = true;
	
	CBasePlayer@ pPlayer = pParams.GetPlayer();
	int index = pPlayer.entindex();
	
	const CCommand@ args = pParams.GetArguments();
	
	if ( args.ArgC() > 1 )
	{
		if ( args[ 1 ].ToLowercase() == 'menu' ) // Open menu
		{
			g_Scheduler.SetTimeout( "CP_Glows", 0.01, index );
			return;
		}
		else if ( args[ 1 ].ToLowercase() == 'off' ) // Turn off glow
		{
			g_Scheduler.SetTimeout( "CP_Glows_Remove", 0.01, index );
			return;
		}
		
		// Check custom glow first
		if ( args[ 1 ].ToLowercase() == szCustomGlowName[ index ] && bHasCustomGlow[ index ] )
		{
			// Reset!
			for ( int i = 0; i < 6; i++ )
			{
				bGlow[ index ][ i ] = false;
				vecGlowColor[ index ][ i ] = g_vecZero;
			}
			
			// Cycle through all colors
			for ( int i = 0; i < 6; i++ )
			{
				if ( vecCustomGlowColor[ index ][ i ] == g_vecZero ) continue;
				
				bGlow[ index ][ i ] = true;
				vecGlowColor[ index ][ i ] = vecCustomGlowColor[ index ][ i ];
			}
			
			// Custom message check
			// Player has private message?
			if ( szPrivateGlowMsg[ index ] != 'NULL' )
			{
				// Replace "!s" modifiers with the player's name
				string szMessage = szPrivateGlowMsg[ index ];
				szMessage.Replace( '!s', pPlayer.pev.netname );
				
				// Print custom message
				g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "* " + szMessage + "\n" );
			}
			else
				g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "* Tu glow ahora es: " + szCustomGlowName[ index ] + "\n" ); // Print default message
			
			// Player has public message?
			if ( szPublicGlowMsg[ index ] != 'NULL' )
			{
				// Replace "!s" modifiers with the player's name
				string szMessage = szPublicGlowMsg[ index ];
				szMessage.Replace( '!s', pPlayer.pev.netname );
				
				// Iterate through all players
				for ( int i = 1; i <= g_Engine.maxClients; i++ )
				{
					CBasePlayer@ iPlayer = g_PlayerFuncs.FindPlayerByIndex( i );
					
					if ( iPlayer !is null && iPlayer.IsConnected() && iPlayer !is pPlayer ) // Don't print public message to self!
					{
						// Print custom message
						g_PlayerFuncs.ClientPrint( iPlayer, HUD_PRINTTALK, "* " + szMessage + "\n" );
					}
				}
			}
		}
		else // Normal glow
		{
			// Get arguments and cost
			int iArguments = args.ArgC() - 1; if ( iArguments > iMaxColors[ index ] ) iArguments = iMaxColors[ index ];
			int iCost = 330;
			switch ( iArguments )
			{
				case 1: iCost = 330; break;
				case 2: iCost = 540; break;
				case 3: iCost = 720; break;
				case 4: iCost = 840; break;
				case 5: iCost = 900; break;
				case 6: iCost = 930; break;
			}
			
			// Enough CP?
			if ( iCP[ index ] >= iCost )
			{
				// Reset!
				for ( int i = 0; i < 6; i++ )
				{
					bGlow[ index ][ i ] = false;
					vecGlowColor[ index ][ i ] = g_vecZero;
				}
				
				int iColor1 = -1;
				int iColor2 = -1;
				int iColor3 = -1;
				int iColor4 = -1;
				int iColor5 = -1;
				int iColor6 = -1;
				
				// Color 1
				iColor1 = _ColorNames.find( args[ 1 ].ToLowercase() ); // Find color
				if ( iColor1 >= 0 )
				{
					// Using a 2nd color?
					if ( iArguments >= 2 )
					{
						iColor2 = _ColorNames.find( args[ 2 ].ToLowercase() ); // Find color
						if ( iColor2 >= 0 )
						{
							// Using a 3rd color?
							if ( iArguments >= 3 )
							{
								iColor3 = _ColorNames.find( args[ 3 ].ToLowercase() ); // Find color
								if ( iColor3 >= 0 )
								{
									// Using a 4th color?
									if ( iArguments >= 4 )
									{
										iColor4 = _ColorNames.find( args[ 4 ].ToLowercase() ); // Find color
										if ( iColor4 >= 0 )
										{
											// Using a 5th color?
											if ( iArguments >= 5 )
											{
												iColor5 = _ColorNames.find( args[ 5 ].ToLowercase() ); // Find color
												if ( iColor5 >= 0 )
												{
													// Using a 6th color?
													if ( iArguments >= 6 )
													{
														iColor6 = _ColorNames.find( args[ 6 ].ToLowercase() ); // Find color
														if ( iColor6 >= 0 )
														{
															// Apply color
															bGlow[ index ][ 5 ] = true;
															vecGlowColor[ index ][ 5 ] = _ColorCodes[ iColor6 ];
														}
														else
														{
															g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "* Color desconocido: " + args[ 6 ].ToLowercase() + "\n" );
															return;
														}
													}
													
													// Apply color
													bGlow[ index ][ 4 ] = true;
													vecGlowColor[ index ][ 4 ] = _ColorCodes[ iColor5 ];
												}
												else
												{
													g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "* Color desconocido: " + args[ 5 ].ToLowercase() + "\n" );
													return;
												}
											}
											
											// Apply color
											bGlow[ index ][ 3 ] = true;
											vecGlowColor[ index ][ 3 ] = _ColorCodes[ iColor4 ];
										}
										else
										{
											g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "* Color desconocido: " + args[ 4 ].ToLowercase() + "\n" );
											return;
										}
									}
									
									// Apply color
									bGlow[ index ][ 2 ] = true;
									vecGlowColor[ index ][ 2 ] = _ColorCodes[ iColor3 ];
								}
								else
								{
									g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "* Color desconocido: " + args[ 3 ].ToLowercase() + "\n" );
									return;
								}
							}
							
							// Apply color
							bGlow[ index ][ 1 ] = true;
							vecGlowColor[ index ][ 1 ] = _ColorCodes[ iColor2 ];
						}
						else
						{
							g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "* Color desconocido: " + args[ 2 ].ToLowercase() + "\n" );
							return;
						}
					}
					
					// Apply color
					bGlow[ index ][ 0 ] = true;
					vecGlowColor[ index ][ 0 ] = _ColorCodes[ iColor1 ];
					
					iCP[ index ] -= iCost;
					
					string szColor1 = _ColorNames[ iColor1 ];
					string szColor2 = ""; if ( iArguments >= 2 ) szColor2 = _ColorNames[ iColor2 ];
					string szColor3 = ""; if ( iArguments >= 3 ) szColor3 = _ColorNames[ iColor3 ];
					string szColor4 = ""; if ( iArguments >= 4 ) szColor4 = _ColorNames[ iColor4 ];
					string szColor5 = ""; if ( iArguments >= 5 ) szColor5 = _ColorNames[ iColor5 ];
					string szColor6 = ""; if ( iArguments >= 6 ) szColor6 = _ColorNames[ iColor6 ];
					
					g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "* Tu glow ahora es: " + szColor1 + " " + szColor2 + " " + szColor3 + " " + szColor4 + " " + szColor5 + " " + szColor6 + "\n" );
				}
				else
					g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "* Color desconocido: " + args[ 1 ].ToLowercase() + "\n" );
			}
			else
				g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "* Insuficientes Puntos Cosmeticos para la cantidad de colores seleccionada (Necesitas: " + iCost + " PC)\n" );
		}
	}
	else
		g_Scheduler.SetTimeout( "CP_Glows", 0.01, index );
}

void TrailCommand( SayParameters@ pParams )
{
	pParams.ShouldHide = true;
	
	CBasePlayer@ pPlayer = pParams.GetPlayer();
	int index = pPlayer.entindex();
	
	const CCommand@ args = pParams.GetArguments();
	
	if ( args.ArgC() > 1 )
	{
		if ( args[ 1 ].ToLowercase() == 'menu' ) // Open menu
		{
			g_Scheduler.SetTimeout( "CP_Trails", 0.01, index );
			return;
		}
		else if ( args[ 1 ].ToLowercase() == 'off' ) // Turn off trail
		{
			g_Scheduler.SetTimeout( "CP_Trails_Remove", 0.01, index );
			return;
		}
		
		// Store arguments
		uint8 iType = 0;
		uint8 iLong = 20;
		uint8 iSize = 8;
		if ( ( args.ArgC() - 1 ) >= 2 )
		{
			// Type check
			if ( args[ 2 ].ToUppercase() == 'A' ) iType = 0;
			else if ( args[ 2 ].ToUppercase() == 'B' ) iType = 1;
			else if ( args[ 2 ].ToUppercase() == 'C' ) iType = 2;
			else if ( args[ 2 ].ToUppercase() == 'D' ) iType = 3;
			else if ( args[ 2 ].ToUppercase() == 'E' ) iType = 4;
			else if ( args[ 2 ].ToUppercase() == 'F' ) iType = 5;
			else if ( args[ 2 ].ToUppercase() == 'G' ) iType = 6;
			else if ( args[ 2 ].ToUppercase() == 'H' ) iType = 7;
			else if ( args[ 2 ].ToUppercase() == 'I' ) iType = 8;
			else if ( args[ 2 ].ToUppercase() == 'J' ) iType = 9;
			else if ( args[ 2 ].ToUppercase() == 'K' ) iType = 10;
			else if ( args[ 2 ].ToUppercase() == 'L' ) iType = 11;
			else if ( args[ 2 ].ToUppercase() == 'M' ) iType = 12;
			else if ( args[ 2 ].ToUppercase() == 'N' ) iType = 13;
			else if ( args[ 2 ].ToUppercase() == 'O' ) iType = 14;
			else if ( args[ 2 ].ToUppercase() == 'P' ) iType = 15;
			else if ( args[ 2 ].ToUppercase() == 'Q' ) iType = 16;
			else if ( args[ 2 ].ToUppercase() == 'R' ) iType = 17;
			else if ( args[ 2 ].ToUppercase() == 'S' ) iType = 18;
			else
			{
				g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "* Tipo de Trail fuera de rango o incorrecta\n" );
				g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "* Solo se permiten letras desde la \"A\" hasta la \"S\"\n" );
				return;
			}
		}
		if ( ( args.ArgC() - 1 ) >= 3 ) iLong = atoui( args[ 3 ] );
		if ( ( args.ArgC() - 1 ) >= 4 ) iSize = atoui( args[ 4 ] );
		
		// Long check
		if ( iLong > 50 || iLong < 10 )
		{
			g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "* Longitud del trail fuera de rango\n" );
			g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "* Solo se permiten numeros entre 10 y 50\n" );
			return;
		}
		
		// Size check
		if ( iSize > 20 || iLong < 4 )
		{
			g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "* Anchura del trail fuera de rango\n" );
			g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "* Solo se permiten numeros entre 4 y 20\n" );
			return;
		}
		
		// Check custom color first
		if ( args[ 1 ][ 3 ] == ' ' && args[ 1 ][ 7 ] == ' ' && isdigit( args[ 1 ][ 10 ] ) )
		{
			// Custom color, check if we have enough CP for it
			if ( iCP[ index ] >= 400 )
			{
				// Split first argument
				array< string >@ pre_color = args[ 1 ].Split( ' ' );
				
				// Copy-paste is bad!
				bool bError = false;
				int iNewR = 0;
				int iNewG = 0;
				int iNewB = 0;
				
				// Check if our arguments are valid by checking if they are numbers
				for ( uint i = 0; i < pre_color[ 0 ].Length(); i++ )
				{
					if ( !isdigit( pre_color[ 0 ][ i ] ) )
						bError = true;
				}
				for ( uint i = 0; i < pre_color[ 1 ].Length(); i++ )
				{
					if ( !isdigit( pre_color[ 1 ][ i ] ) )
						bError = true;
				}
				for ( uint i = 0; i < pre_color[ 2 ].Length(); i++ )
				{
					if ( !isdigit( pre_color[ 2 ][ i ] ) )
						bError = true;
				}
				
				// Lastly, check if our values are in the range
				iNewR = atoi( pre_color[ 0 ] );
				iNewG = atoi( pre_color[ 1 ] );
				iNewB = atoi( pre_color[ 2 ] );
				
				if ( iNewR < 0 ) bError = true;
				if ( iNewR > 255 ) bError = true;
				if ( iNewG < 0 ) bError = true;
				if ( iNewG > 255 ) bError = true;
				if ( iNewB < 0 ) bError = true;
				if ( iNewB > 255 ) bError = true;
				
				if ( !bError )
				{
					iCP[ index ] -= 400;
					
					// Alright, set trail
					bTrail[ index ] = true;
					vecTrailColor[ index ].x = iNewR;
					vecTrailColor[ index ].y = iNewG;
					vecTrailColor[ index ].z = iNewB;
					
					// Update trail settings?
					if ( bShouldUpdate[ index ] )
					{
						iTrailSprite[ index ] = iTrailNewSprite[ index ];
						iTrailLong[ index ] = iTrailNewLong[ index ];
						iTrailSize[ index ] = iTrailNewSize[ index ];
						
						bShouldUpdate[ index ] = false;
						g_Scheduler.SetTimeout( "CP_Trails", 0.01, index );
					}
					else
					{
						// Set from arguments, if they have
						iTrailSprite[ index ] = iType;
						iTrailLong[ index ] = iLong;
						iTrailSize[ index ] = iSize;
					}
					
					g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "* Trail de color: Personalizado (" + iNewR + " " + iNewG + " " + iNewB + ")\n" );
				}
				else
				{
					g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "* Parametros insuficientes o incorrectos\n" );
					g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "* Solo se permiten numeros entre 000 y 255\n" );
				}
			}
			else
			{
				g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "* Puntos Cosmeticos insuficientes (Necesitas: 50 PC)\n" );
				return;
			}
		}
		else // Normal trail
		{
			// Enough CP?
			if ( iCP[ index ] >= 350 )
			{
				int iColor = _ColorNames.find( args[ 1 ].ToLowercase() ); // Find color
				if ( iColor >= 0 )
				{
					// Apply color
					bTrail[ index ] = true;
					vecTrailColor[ index ] = _ColorCodes[ iColor ];
					
					iCP[ index ] -= 350;
					
					// Set trail arguments, if they have
					iTrailSprite[ index ] = iType;
					iTrailLong[ index ] = iLong;
					iTrailSize[ index ] = iSize;
					
					g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "* Trail de color: " + _ColorNames[ iColor ] + "\n" );
				}
				else
					g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "* Color desconocido: " + args[ 1 ].ToLowercase() + "\n" );
			}
			else
				g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "* Puntos Cosmeticos insuficientes (Necesitas: 350 PC)\n" );
		}
	}
	else
		g_Scheduler.SetTimeout( "CP_Trails", 0.01, index );
}

void CPMenu( const int& in index )
{
	CBasePlayer@ pPlayer = g_PlayerFuncs.FindPlayerByIndex( index );
	MenuHandler@ state = MenuGetPlayer( pPlayer );
	
	state.InitMenu( pPlayer, CPMenu_CB );
	state.menu.SetTitle( "Cosmetica\n\nTienes: " + AddCommas( iCP[ index ] ) + " PC\n\n" );
	
	state.menu.AddItem( "Glows\n", any( "item1" ) );
	state.menu.AddItem( "Trails\n", any( "item2" ) );
	state.menu.AddItem( "Hats\n", any( "item3" ) );
	//state.menu.AddItem( "Fireworks\n", any( "item4" ) );
	state.menu.AddItem( "Otros\n\n", any( "item5" ) );
	state.menu.AddItem( "Ayuda", any( "item6" ) );
	
	state.OpenMenu( pPlayer, 0, 0 );
}

void CPMenu_CB( CTextMenu@ menu, CBasePlayer@ pPlayer, int page, const CTextMenuItem@ item )
{
	int index = pPlayer.entindex();
	if ( page == 10 ) return;
	
	string selection;
	item.m_pUserData.retrieve( selection );
	if ( selection == 'item1' )
		g_Scheduler.SetTimeout( "CP_Glows", 0.01, index );
	else if ( selection == 'item2' )
		g_Scheduler.SetTimeout( "CP_Trails", 0.01, index );
	else if ( selection == 'item3' )
		g_Scheduler.SetTimeout( "CP_Hats", 0.01, index );
	else if ( selection == 'item4' )
		g_Scheduler.SetTimeout( "CP_Fireworks", 0.01, index );
	else if ( selection == 'item5' )
		g_Scheduler.SetTimeout( "CP_Other", 0.01, index );
	else if ( selection == 'item6' )
		g_Scheduler.SetTimeout( "CP_Help", 0.01, index );
}

void CP_Glows( const int& in index )
{
	CBasePlayer@ pPlayer = g_PlayerFuncs.FindPlayerByIndex( index );
	MenuHandler@ state = MenuGetPlayer( pPlayer );
	
	state.InitMenu( pPlayer, CP_Glows_CB );
	state.menu.SetTitle( "Glows\n\nTienes: " + AddCommas( iCP[ index ] ) + " PC\n\n" );
	
	state.menu.AddItem( "Predefinidos\n", any( "item1" ) );
	
	if ( bHasCustomGlow[ index ] )
		state.menu.AddItem( "Mi glow\n\n", any( "item2" ) );
	else
		state.menu.AddItem( "Comprar glow personalizado [ 25,000 PC ]\n\n", any( "item3" ) );
	
	state.menu.AddItem( "Quitar glow\n\n", any( "item4" ) );
	
	string szItem5 = "Cantidad de colores: " + iSelectedColors[ index ] + "\n";
	state.menu.AddItem( szItem5, any( "item5" ) );
	
	if ( iMaxColors[ index ] < 6 )
	{
		string szUpgradeCost = "";
		switch ( iMaxColors[ index ] )
		{
			case 1: szUpgradeCost = "[ 1,000 PC ]"; break;
			case 2: szUpgradeCost = "[ 2,500 PC ]"; break;
			case 3: szUpgradeCost = "[ 4,500 PC ]"; break;
			case 4: szUpgradeCost = "[ 7,000 PC ]"; break;
			case 5: szUpgradeCost = "[ 10,000 PC ]"; break;
		}
		string szItem6 = "Aumentar cantidad maxima " + szUpgradeCost;
		state.menu.AddItem( szItem6, any( "item6" ) );
	}
	
	state.OpenMenu( pPlayer, 0, 0 );
}

void CP_Glows_CB( CTextMenu@ menu, CBasePlayer@ pPlayer, int page, const CTextMenuItem@ item )
{
	int index = pPlayer.entindex();
	if ( page == 10 ) return;
	
	string selection;
	item.m_pUserData.retrieve( selection );
	if ( selection == 'item1' )
	{
		int iCost = 330;
		switch ( iSelectedColors[ index ] )
		{
			case 1: iCost = 300; break;
			case 2: iCost = 540; break;
			case 3: iCost = 720; break;
			case 4: iCost = 840; break;
			case 5: iCost = 900; break;
			case 6: iCost = 930; break;
		}
		
		if ( iCP[ index ] >= iCost )
		{
			iChoosenColors[ index ] = 0;
			if ( bGlow[ index ][ 0 ] ) bShouldUpdate[ index ] = true;
			
			g_Scheduler.SetTimeout( "CP_Glows_Default", 0.01, index );
		}
		else
		{
			g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "* Insuficientes Puntos Cosmeticos para la cantidad de colores seleccionada (Necesitas: " + iCost + " PC)\n" );
			g_Scheduler.SetTimeout( "CP_Glows", 0.01, index );
		}
	}
	else if ( selection == 'item2' )
	{
		if ( !bGlow[ index ][ 0 ] )
		{
			// Attempt to extract glow data
			
			// 1. Number of colors
			iSelectedColors[ index ] = 0;
			for ( int i = 0; i < 6; i++ )
			{
				if ( vecCustomGlowColor[ index ][ i ] != g_vecZero )
					iSelectedColors[ index ]++;
			}
			
			// 2. Color names
			for ( int i = 0; i < 6; i++ )
			{
				for ( uint j = 0; j < _ColorCodes.length(); j++ )
				{
					// Default
					if ( vecCustomGlowColor[ index ][ i ].x == _ColorCodes[ j ].x && vecCustomGlowColor[ index ][ i ].y == _ColorCodes[ j ].y && vecCustomGlowColor[ index ][ i ].z == _ColorCodes[ j ].z )
					{
						szSelectedColor[ index ][ i ] = _ColorNames[ j ];
						break;
					}
				}
				
				// Custom
				if ( szSelectedColor[ index ][ i ] == '<ninguno>' && vecCustomGlowColor[ index ][ i ] != g_vecZero )
					szSelectedColor[ index ][ i ] = "Personalizado (" + int( vecCustomGlowColor[ index ][ i ].x ) + " " + int( vecCustomGlowColor[ index ][ i ].y ) + " " + int( vecCustomGlowColor[ index ][ i ].z ) + ")";
			}
			
			g_Scheduler.SetTimeout( "CP_Glows_MyGlow", 0.01, index );
		}
		else
		{
			g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "* Quitate el glow antes de realizar cambios a tu glow personalizado\n" );
			g_Scheduler.SetTimeout( "CP_Glows", 0.01, index );
		}
	}
	else if ( selection == 'item3' )
	{
		if ( iCP[ index ] >= 25000 )
			g_Scheduler.SetTimeout( "CP_Glows_BuyCustom", 0.01, index );
		else
		{
			g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "* Puntos Cosmeticos insuficientes\n" );
			g_Scheduler.SetTimeout( "CP_Glows", 0.01, index );
		}
	}
	else if ( selection == 'item4' )
		g_Scheduler.SetTimeout( "CP_Glows_Remove", 0.01, index );
	else if ( selection == 'item5' )
	{
		iSelectedColors[ index ]++;
		if ( iSelectedColors[ index ] > iMaxColors[ index ] )
			iSelectedColors[ index ] = 1;
		
		g_Scheduler.SetTimeout( "CP_Glows", 0.01, index );
	}
	else if ( selection == 'item6' )
	{
		int iUpgradeCost = 13500;
		switch ( iMaxColors[ index ] )
		{
			case 1: iUpgradeCost = 1000; break;
			case 2: iUpgradeCost = 2500; break;
			case 3: iUpgradeCost = 4500; break;
			case 4: iUpgradeCost = 7000; break;
			case 5: iUpgradeCost = 10000; break;
		}
		
		if ( iCP[ index ] >= iUpgradeCost )
		{
			iCP[ index ] -= iUpgradeCost;
			iMaxColors[ index ]++;
			
			g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "* Aumentaste tu cantidad maxima de colores a " + iMaxColors[ index ] + "\n" );
		}
		else
			g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "* Puntos Cosmeticos insuficientes\n" );
		
		g_Scheduler.SetTimeout( "CP_Glows", 0.01, index );
	}
}

void CP_Glows_Default( const int& in index )
{
	CBasePlayer@ pPlayer = g_PlayerFuncs.FindPlayerByIndex( index );
	MenuHandler@ state = MenuGetPlayer( pPlayer );
	
	state.InitMenu( pPlayer, CP_Glows_Default_CB );
	
	string szCost = "Costo total: ";
	switch ( iSelectedColors[ index ] )
	{
		case 1: szCost += "300 PC"; break;
		case 2: szCost += "540 PC"; break;
		case 3: szCost += "720 PC"; break;
		case 4: szCost += "840 PC"; break;
		case 5: szCost += "900 PC"; break;
		case 6: szCost += "930 PC"; break;
	}
	string szTitle = "Predefinidos\n\nTienes: " + AddCommas( iCP[ index ] ) + " PC\n" + szCost + "\n\n";
	
	state.menu.SetTitle( szTitle );
	
	for( uint i = 0; i < _ColorNames.length(); i++ )
	{
		state.menu.AddItem( _ColorNames[ i ], any( string( i ) ) );
	}
	
	state.OpenMenu( pPlayer, 0, 0 );
}

void CP_Glows_Default_CB( CTextMenu@ menu, CBasePlayer@ pPlayer, int page, const CTextMenuItem@ item )
{
	int index = pPlayer.entindex();
	if ( page == 10 )
	{
		g_Scheduler.SetTimeout( "CP_Glows", 0.01, index );
		return;
	}
	
	string selection;
	item.m_pUserData.retrieve( selection );
	int iColor = atoi( selection );
	
	if ( !bShouldUpdate[ index ] )
		vecGlowColor[ index ][ iChoosenColors[ index ] ] = _ColorCodes[ iColor ];
	else
		vecGlowUpdate[ index ][ iChoosenColors[ index ] ] = _ColorCodes[ iColor ];
	
	iChoosenColors[ index ]++;
	g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "* Color " + iChoosenColors[ index ] + ": " + _ColorNames[ iColor ] + "\n" );
	
	if ( iChoosenColors[ index ] == iSelectedColors[ index ] )
	{
		bGlow[ index ][ 0 ] = false;
		bGlow[ index ][ 1 ] = false;
		bGlow[ index ][ 2 ] = false;
		bGlow[ index ][ 3 ] = false;
		bGlow[ index ][ 4 ] = false;
		bGlow[ index ][ 5 ] = false;
		
		for( int i = 0; i < iSelectedColors[ index ]; i++ )
		{
			switch ( iMaxColors[ index ] )
			{
				case 1: iCP[ index ] -= 300; break;
				case 2: iCP[ index ] -= 270; break;
				case 3: iCP[ index ] -= 240; break;
				case 4: iCP[ index ] -= 210; break;
				case 5: iCP[ index ] -= 180; break;
				case 6: iCP[ index ] -= 155; break;
			}
			bGlow[ index ][ i ] = true;
			
			if ( bShouldUpdate[ index ] )
				vecGlowColor[ index ][ i ] = vecGlowUpdate[ index ][ i ];
		}
		
		bShouldUpdate[ index ] = false;
	}
	else
		g_Scheduler.SetTimeout( "CP_Glows_Default", 0.01, index );
	
	return;
}

void CP_Glows_Remove( const int& in index )
{
	CBasePlayer@ pPlayer = g_PlayerFuncs.FindPlayerByIndex( index );
	
	for ( int i = 0; i < 6; i++ )
	{
		bGlow[ index ][ i ] = false;
		vecGlowColor[ index ][ i ] = g_vecZero;
	}
	iGlowAlternate[ index ] = 1;
	
	pPlayer.pev.renderfx = 0;
	pPlayer.pev.renderamt = 0;
	pPlayer.pev.rendercolor = g_vecZero;
	
	g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "* Te quitaste el glow\n" );
}

void CP_Glows_BuyCustom( const int& in index )
{
	CBasePlayer@ pPlayer = g_PlayerFuncs.FindPlayerByIndex( index );
	MenuHandler@ state = MenuGetPlayer( pPlayer );
	
	state.InitMenu( pPlayer, CP_Glows_BuyCustom_CB );
	state.menu.SetTitle( "Glow personalizado\n\n" );
	
	string szItem1 = "Cantidad de colores: " + iSelectedColors[ index ] + "\n\n";
	state.menu.AddItem( szItem1, any( "item1" ) );
	
	string szColor1 = "Color 1: " + szSelectedColor[ index ][ 0 ] + "\n";
	state.menu.AddItem( szColor1, any( "item2" ) );
	
	if ( iSelectedColors[ index ] >= 2 )
	{
		string szColor2 = "Color 2: " + szSelectedColor[ index ][ 1 ] + "\n";
		state.menu.AddItem( szColor2, any( "item3" ) );
	}
	if ( iSelectedColors[ index ] >= 3 )
	{
		string szColor3 = "Color 3: " + szSelectedColor[ index ][ 2 ] + "\n";
		state.menu.AddItem( szColor3, any( "item4" ) );
	}
	if ( iSelectedColors[ index ] >= 4 )
	{
		string szColor4 = "Color 4: " + szSelectedColor[ index ][ 3 ] + "\n";
		state.menu.AddItem( szColor4, any( "item5" ) );
	}
	if ( iSelectedColors[ index ] >= 5 )
	{
		string szColor5 = "Color 5: " + szSelectedColor[ index ][ 4 ] + "\n";
		state.menu.AddItem( szColor5, any( "item6" ) );
	}
	if ( iSelectedColors[ index ] >= 6 )
	{
		string szColor6 = "Color 6: " + szSelectedColor[ index ][ 5 ] + "\n";
		state.menu.AddItem( szColor6, any( "item7" ) );
	}
	
	string szGlowName = "Nombre del glow: " + szCustomGlowName[ index ] + "\n\n";
	state.menu.AddItem( szGlowName, any( "item8" ) );
	
	state.menu.AddItem( "Editar Mensaje Privado\n", any( "item9" ) );
	state.menu.AddItem( "Editar Mensaje Publico\n\n", any( "item10" ) );
	
	state.menu.AddItem( "Comprar!", any( "item11" ) );
	
	iCustomProgress[ index ] = 0;
	state.OpenMenu( pPlayer, 0, 0 );
}

void CP_Glows_BuyCustom_CB( CTextMenu@ menu, CBasePlayer@ pPlayer, int page, const CTextMenuItem@ item )
{
	int index = pPlayer.entindex();
	if ( page == 10 ) return;
	
	string selection;
	item.m_pUserData.retrieve( selection );
	if ( selection == 'item1' )
	{
		iSelectedColors[ index ]++;
		if ( iSelectedColors[ index ] > iMaxColors[ index ] )
			iSelectedColors[ index ] = 1;
		
		g_Scheduler.SetTimeout( "CP_Glows_BuyCustom", 0.01, index );
	}
	else if ( selection == 'item2' )
	{
		iCustomProgress[ index ] = 1;
		g_Scheduler.SetTimeout( "CP_Glows_Custom_Edit", 0.01, index );
	}
	else if ( selection == 'item3' )
	{
		iCustomProgress[ index ] = 2;
		g_Scheduler.SetTimeout( "CP_Glows_Custom_Edit", 0.01, index );
	}
	else if ( selection == 'item4' )
	{
		iCustomProgress[ index ] = 3;
		g_Scheduler.SetTimeout( "CP_Glows_Custom_Edit", 0.01, index );
	}
	else if ( selection == 'item5' )
	{
		iCustomProgress[ index ] = 4;
		g_Scheduler.SetTimeout( "CP_Glows_Custom_Edit", 0.01, index );
	}
	else if ( selection == 'item6' )
	{
		iCustomProgress[ index ] = 5;
		g_Scheduler.SetTimeout( "CP_Glows_Custom_Edit", 0.01, index );
	}
	else if ( selection == 'item7' )
	{
		iCustomProgress[ index ] = 6;
		g_Scheduler.SetTimeout( "CP_Glows_Custom_Edit", 0.01, index );
	}
	else if ( selection == 'item8' )
	{
		iCustomProgress[ index ] = 7;
		g_Scheduler.SetTimeout( "CP_Glows_Custom_SetName", 0.01, index );
	}
	else if ( selection == 'item9' )
	{
		iCustomProgress[ index ] = 8;
		g_Scheduler.SetTimeout( "CP_Glows_Custom_SetPrivate", 0.01, index );
	}
	else if ( selection == 'item10' )
	{
		iCustomProgress[ index ] = 9;
		g_Scheduler.SetTimeout( "CP_Glows_Custom_SetPublic", 0.01, index );
	}
	else if ( selection == 'item11' )
	{
		if ( iCP[ index ] >= 25000 )
		{
			string szCheck = szCustomGlowName[ index ];
			szCheck.ToLowercase();
			
			if ( szCheck == 'null' )
			{
				g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "* El nombre del glow no puede ser \"NULL\"\n" );
				g_Scheduler.SetTimeout( "CP_Glows_BuyCustom", 0.01, index );
			}
			else
			{
				for( int i = 0; i < iSelectedColors[ index ]; i++ )
				{
					if ( szSelectedColor[ index ][ i ] == '<ninguno>' )
					{
						g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "* Aun quedan colores por elegir\n" );
						g_Scheduler.SetTimeout( "CP_Glows_BuyCustom", 0.01, index );
						return;
					}
				}
				
				iCP[ index ] -= 25000;
				bHasCustomGlow[ index ] = true;
				
				g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "* Compraste tu propio glow personalizado\n" );
				g_Scheduler.SetTimeout( "CP_Glows", 0.01, index );
			}
		}
		else
		{
			g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "* Puntos Cosmeticos insuficientes\n" );
			g_Scheduler.SetTimeout( "CP_Glows", 0.01, index );
		}
	}
}

void CP_Glows_Custom_Edit( const int& in index )
{
	CBasePlayer@ pPlayer = g_PlayerFuncs.FindPlayerByIndex( index );
	MenuHandler@ state = MenuGetPlayer( pPlayer );
	
	state.InitMenu( pPlayer, CP_Glows_Custom_Edit_CB );
	
	string szTitle = "Elige color\n\nPuedes usar el comando\n/glowcolor <RRR> <GGG> <BBB>\npara definir tu propio color\n\nDonde R, G y B es el color escrito\nen Codigo RGB\n\n";
	
	state.menu.SetTitle( szTitle );
	
	for( uint i = 0; i < _ColorNames.length(); i++ )
	{
		state.menu.AddItem( _ColorNames[ i ], any( string( i ) ) );
	}
	
	state.OpenMenu( pPlayer, 0, 0 );
}

void SetGlowColor( SayParameters@ pParams )
{
	pParams.ShouldHide = true;
	
	CBasePlayer@ pPlayer = pParams.GetPlayer();
	int index = pPlayer.entindex();
	
	if ( iCustomProgress[ index ] >= 1 && iCustomProgress[ index ] <= 6 )
	{
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
				szSelectedColor[ index ][ iCustomProgress[ index ] - 1 ] = "Personalizado (" + iNewR + " " + iNewG + " " + iNewB + ")";
				switch ( iCustomProgress[ index ] )
				{
					case 1:
					{
						vecCustomGlowColor[ index ][ 0 ].x = iNewR;
						vecCustomGlowColor[ index ][ 0 ].y = iNewG;
						vecCustomGlowColor[ index ][ 0 ].z = iNewB;
						break;
					}
					case 2:
					{
						vecCustomGlowColor[ index ][ 1 ].x = iNewR;
						vecCustomGlowColor[ index ][ 1 ].y = iNewG;
						vecCustomGlowColor[ index ][ 1 ].z = iNewB;
						break;
					}
					case 3:
					{
						vecCustomGlowColor[ index ][ 2 ].x = iNewR;
						vecCustomGlowColor[ index ][ 2 ].y = iNewG;
						vecCustomGlowColor[ index ][ 2 ].z = iNewB;
						break;
					}
					case 4:
					{
						vecCustomGlowColor[ index ][ 3 ].x = iNewR;
						vecCustomGlowColor[ index ][ 3 ].y = iNewG;
						vecCustomGlowColor[ index ][ 3 ].z = iNewB;
						break;
					}
					case 5:
					{
						vecCustomGlowColor[ index ][ 4 ].x = iNewR;
						vecCustomGlowColor[ index ][ 4 ].y = iNewG;
						vecCustomGlowColor[ index ][ 4 ].z = iNewB;
						break;
					}
					case 6:
					{
						vecCustomGlowColor[ index ][ 5 ].x = iNewR;
						vecCustomGlowColor[ index ][ 5 ].y = iNewG;
						vecCustomGlowColor[ index ][ 5 ].z = iNewB;
						break;
					}
				}
				
				g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "* Color " + iCustomProgress[ index ] + ": " + szSelectedColor[ index ][ iCustomProgress[ index ] - 1 ] + "\n" );
				
				if ( !bHasCustomGlow[ index ] )
					g_Scheduler.SetTimeout( "CP_Glows_BuyCustom", 0.01, index );
				else
					g_Scheduler.SetTimeout( "CP_Glows_MyGlow", 0.01, index );
			}
			else
			{
				g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "* Parametros insuficientes o incorrectos\n" );
				g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "* Solo se permiten numeros entre 000 y 255\n" );
			}
		}
	}
}

void CP_Glows_Custom_Edit_CB( CTextMenu@ menu, CBasePlayer@ pPlayer, int page, const CTextMenuItem@ item )
{
	int index = pPlayer.entindex();
	if ( page == 10 )
	{
		if ( !bHasCustomGlow[ index ] )
			g_Scheduler.SetTimeout( "CP_Glows_BuyCustom", 0.01, index );
		else
			g_Scheduler.SetTimeout( "CP_Glows_MyGlow", 0.01, index );
		return;
	}
	
	string selection;
	item.m_pUserData.retrieve( selection );
	int iColor = atoi( selection );
	
	vecCustomGlowColor[ index ][ iCustomProgress[ index ] - 1 ] = _ColorCodes[ iColor ];
	szSelectedColor[ index ][ iCustomProgress[ index ] - 1 ] = _ColorNames[ iColor ];
	g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "* Color " + iCustomProgress[ index ] + ": " + _ColorNames[ iColor ] + "\n" );
	
	if ( !bHasCustomGlow[ index ] )
		g_Scheduler.SetTimeout( "CP_Glows_BuyCustom", 0.01, index );
	else
		g_Scheduler.SetTimeout( "CP_Glows_MyGlow", 0.01, index );
}

void CP_Glows_Custom_SetName( const int& in index )
{
	CBasePlayer@ pPlayer = g_PlayerFuncs.FindPlayerByIndex( index );
	MenuHandler@ state = MenuGetPlayer( pPlayer );
	
	state.InitMenu( pPlayer, CP_Glows_Custom_SetName_CB );
	
	string szTitle;
	if ( !bHasCustomGlow[ index ] )
		szTitle = "Nombre del glow\n\nDale un nombre a tu glow\npara poder activarlo desde\nel comando de say\n\nSi no estas satisfecho con tu\nnombre, podras cambiarlo\ndespues de la compra\n\nUsa el comando:\n/glowname <nombre del glow>\n";
	else
		szTitle = "Nombre del glow\n\nDale un nombre a tu glow\npara poder activarlo desde\nel comando de say\n\nEl renombre de glow tiene\nun costo de 10,000 PC\n\nUsa el comando:\n/glowname <nombre del glow>\n";
	
	state.menu.SetTitle( szTitle );
	
	state.menu.AddItem( "Cancelar", any( "item1" ) );
	
	state.OpenMenu( pPlayer, 0, 0 );
}

void SetGlowName( SayParameters@ pParams )
{
	pParams.ShouldHide = true;
	
	CBasePlayer@ pPlayer = pParams.GetPlayer();
	int index = pPlayer.entindex();
	
	if ( iCustomProgress[ index ] == 7 )
	{
		const CCommand@ args = pParams.GetArguments();
		
		if ( args.ArgC() > 1 )
		{
			if ( args[ 1 ].ToLowercase() == 'null' )
				g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "* El nombre del glow no puede ser \"NULL\"\n" );
			else
			{
				if ( args[ 1 ].Length() > 16 )
					g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "* El nombre del glow es demasiado largo\n" );
				else
				{
					if ( !bHasCustomGlow[ index ] )
					{
						szCustomGlowName[ index ] = args[ 1 ].ToLowercase();
						g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "* Nombre ajustado\n" );
						g_Scheduler.SetTimeout( "CP_Glows_BuyCustom", 0.01, index );
					}
					else
					{
						if ( iCP[ index ] >= 10000 )
						{
							iCP[ index ] -= 10000;
							
							szCustomGlowName[ index ] = args[ 1 ].ToLowercase();
							g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "* Nombre ajustado\n" );
							g_Scheduler.SetTimeout( "CP_Glows_MyGlow", 0.01, index );
						}
						else
							g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "* Puntos Cosmeticos insuficientes\n" );
					}
				}
			}
		}
	}
}

void CP_Glows_Custom_SetName_CB( CTextMenu@ menu, CBasePlayer@ pPlayer, int page, const CTextMenuItem@ item )
{
	int index = pPlayer.entindex();
	if ( page == 10 )
		return;
	
	if ( !bHasCustomGlow[ index ] )
		g_Scheduler.SetTimeout( "CP_Glows_BuyCustom", 0.01, index );
	else
		g_Scheduler.SetTimeout( "CP_Glows_MyGlow", 0.01, index );
}

void CP_Glows_Custom_SetPrivate( const int& in index )
{
	CBasePlayer@ pPlayer = g_PlayerFuncs.FindPlayerByIndex( index );
	MenuHandler@ state = MenuGetPlayer( pPlayer );
	
	state.InitMenu( pPlayer, CP_Glows_Custom_SetName_CB ); // Not a typo, same callback as to prevent duplicates
	
	string szTitle = "Editar Mensaje Privado\n\nEl Mensaje Privado es un mensaje que\nsolo tu veras al cuando actives tu glow\n\nPara incluir tu nombre en el mensaje, usa \"!s\"\nPara desactivar esta caracteristica, usa \"NULL\"\n\nUsa el comando:\n/glowprivate <mensaje>\n\nIMPORTANTE: Escribe tu mensaje entre comillas!\n";
	
	state.menu.SetTitle( szTitle );
	
	state.menu.AddItem( "Cancelar", any( "item1" ) );
	
	state.OpenMenu( pPlayer, 0, 0 );
}

void SetGlowPrivate( SayParameters@ pParams )
{
	pParams.ShouldHide = true;
	
	CBasePlayer@ pPlayer = pParams.GetPlayer();
	int index = pPlayer.entindex();
	
	if ( iCustomProgress[ index ] == 8 )
	{
		const CCommand@ args = pParams.GetArguments();
		
		if ( args.ArgC() > 1 )
		{
			// Keep a copy, otherwise everything is lowercase!
			string szMessage = args[ 1 ];
			
			if ( args[ 1 ].ToLowercase() == 'null' )
			{
				szPrivateGlowMsg[ index ] = "NULL";
				g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "* Mensaje Privado desactivado\n" );
				
				if ( !bHasCustomGlow[ index ] )
					g_Scheduler.SetTimeout( "CP_Glows_BuyCustom", 0.01, index );
				else
					g_Scheduler.SetTimeout( "CP_Glows_MyGlow", 0.01, index );
			}
			else
			{
				if ( szMessage.Length() > 64 )
					g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "* El mensaje escrito es demasiado largo\n" );
				else
				{
					// !!! SANITIZE THE MESSAGE !!!
					szMessage.Replace( '%', '%%' );
					
					szPrivateGlowMsg[ index ] = szMessage;
					g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "* Mensaje Privado ajustado\n" );
					
					if ( !bHasCustomGlow[ index ] )
						g_Scheduler.SetTimeout( "CP_Glows_BuyCustom", 0.01, index );
					else
						g_Scheduler.SetTimeout( "CP_Glows_MyGlow", 0.01, index );
				}
			}
		}
	}
}

void CP_Glows_Custom_SetPublic( const int& in index )
{
	CBasePlayer@ pPlayer = g_PlayerFuncs.FindPlayerByIndex( index );
	MenuHandler@ state = MenuGetPlayer( pPlayer );
	
	state.InitMenu( pPlayer, CP_Glows_Custom_SetName_CB ); // Not a typo, same callback as to prevent duplicates
	
	string szTitle = "Editar Mensaje Publico\n\nEl Mensaje Publico es un mensaje que veran\nlos demas jugadores cuando actives tu glow\n\nPara incluir tu nombre en el mensaje, usa \"!s\"\nPara desactivar esta caracteristica, usa \"NULL\"\n\nUsa el comando:\n/glowpublic <mensaje>\n\nIMPORTANTE: Escribe tu mensaje entre comillas!\n";
	
	state.menu.SetTitle( szTitle );
	
	state.menu.AddItem( "Cancelar", any( "item1" ) );
	
	state.OpenMenu( pPlayer, 0, 0 );
}

void SetGlowPublic( SayParameters@ pParams )
{
	pParams.ShouldHide = true;
	
	CBasePlayer@ pPlayer = pParams.GetPlayer();
	int index = pPlayer.entindex();
	
	if ( iCustomProgress[ index ] == 9 )
	{
		const CCommand@ args = pParams.GetArguments();
		
		if ( args.ArgC() > 1 )
		{
			// Keep a copy, otherwise everything is lowercase!
			string szMessage = args[ 1 ];
			
			if ( args[ 1 ].ToLowercase() == 'null' )
			{
				szPublicGlowMsg[ index ] = "NULL";
				g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "* Mensaje Publico desactivado\n" );
				
				if ( !bHasCustomGlow[ index ] )
					g_Scheduler.SetTimeout( "CP_Glows_BuyCustom", 0.01, index );
				else
					g_Scheduler.SetTimeout( "CP_Glows_MyGlow", 0.01, index );
			}
			else
			{
				if ( szMessage.Length() > 64 )
					g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "* El mensaje escrito es demasiado largo\n" );
				else
				{
					// !!! SANITIZE THE MESSAGE !!!
					szMessage.Replace( '%', '%%' );
					
					szPublicGlowMsg[ index ] = szMessage;
					g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "* Mensaje Publico ajustado\n" );
					
					if ( !bHasCustomGlow[ index ] )
						g_Scheduler.SetTimeout( "CP_Glows_BuyCustom", 0.01, index );
					else
						g_Scheduler.SetTimeout( "CP_Glows_MyGlow", 0.01, index );
				}
			}
		}
	}
}

void CP_Glows_MyGlow( const int& in index )
{
	CBasePlayer@ pPlayer = g_PlayerFuncs.FindPlayerByIndex( index );
	MenuHandler@ state = MenuGetPlayer( pPlayer );
	
	state.InitMenu( pPlayer, CP_Glows_MyGlow_CB );
	
	string szTitle = "Mi glow (" + szCustomGlowName[ index ] + ")\n\nActivar con el comando:\n/glow " + szCustomGlowName[ index ] + "\n\n";
	state.menu.SetTitle( szTitle );
	
	string szItem1 = "Cantidad de colores: " + iSelectedColors[ index ] + "\n\n";
	state.menu.AddItem( szItem1, any( "item1" ) );
	
	string szColor1 = "Color 1: " + szSelectedColor[ index ][ 0 ] + "\n";
	state.menu.AddItem( szColor1, any( "item2" ) );
	
	if ( iSelectedColors[ index ] >= 2 )
	{
		string szColor2 = "Color 2: " + szSelectedColor[ index ][ 1 ] + "\n";
		state.menu.AddItem( szColor2, any( "item3" ) );
	}
	if ( iSelectedColors[ index ] >= 3 )
	{
		string szColor3 = "Color 3: " + szSelectedColor[ index ][ 2 ] + "\n";
		state.menu.AddItem( szColor3, any( "item4" ) );
	}
	if ( iSelectedColors[ index ] >= 4 )
	{
		string szColor4 = "Color 4: " + szSelectedColor[ index ][ 3 ] + "\n";
		state.menu.AddItem( szColor4, any( "item5" ) );
	}
	if ( iSelectedColors[ index ] >= 5 )
	{
		string szColor5 = "Color 5: " + szSelectedColor[ index ][ 4 ] + "\n";
		state.menu.AddItem( szColor5, any( "item6" ) );
	}
	if ( iSelectedColors[ index ] >= 6 )
	{
		string szColor6 = "Color 6: " + szSelectedColor[ index ][ 5 ] + "\n";
		state.menu.AddItem( szColor6, any( "item7" ) );
	}
	
	string szGlowName = "Nombre del glow: " + szCustomGlowName[ index ] + "\n\n";
	state.menu.AddItem( szGlowName, any( "item8" ) );
	
	state.menu.AddItem( "Editar Mensaje Privado\n", any( "item9" ) );
	state.menu.AddItem( "Editar Mensaje Publico\n\n", any( "item10" ) );
	
	iCustomProgress[ index ] = 0;
	state.OpenMenu( pPlayer, 0, 0 );
}

void CP_Glows_MyGlow_CB( CTextMenu@ menu, CBasePlayer@ pPlayer, int page, const CTextMenuItem@ item )
{
	int index = pPlayer.entindex();
	if ( page == 10 ) return;
	
	if ( bGlow[ index ][ 0 ] )
	{
		g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "* Quitate el glow antes de realizar cambios a tu glow personalizado\n" );
		return;
	}
	
	string selection;
	item.m_pUserData.retrieve( selection );
	if ( selection == 'item1' )
	{
		iSelectedColors[ index ]++;
		if ( iSelectedColors[ index ] > iMaxColors[ index ] )
		{
			iSelectedColors[ index ] = 1;
			
			vecCustomGlowColor[ index ][ 1 ] = g_vecZero;
			vecCustomGlowColor[ index ][ 2 ] = g_vecZero;
			vecCustomGlowColor[ index ][ 3 ] = g_vecZero;
			vecCustomGlowColor[ index ][ 4 ] = g_vecZero;
			vecCustomGlowColor[ index ][ 5 ] = g_vecZero;
			
			szSelectedColor[ index ][ 1 ] = "<ninguno>";
			szSelectedColor[ index ][ 2 ] = "<ninguno>";
			szSelectedColor[ index ][ 3 ] = "<ninguno>";
			szSelectedColor[ index ][ 4 ] = "<ninguno>";
			szSelectedColor[ index ][ 5 ] = "<ninguno>";
		}
		
		g_Scheduler.SetTimeout( "CP_Glows_MyGlow", 0.01, index );
	}
	else if ( selection == 'item2' )
	{
		iCustomProgress[ index ] = 1;
		g_Scheduler.SetTimeout( "CP_Glows_Custom_Edit", 0.01, index );
	}
	else if ( selection == 'item3' )
	{
		iCustomProgress[ index ] = 2;
		g_Scheduler.SetTimeout( "CP_Glows_Custom_Edit", 0.01, index );
	}
	else if ( selection == 'item4' )
	{
		iCustomProgress[ index ] = 3;
		g_Scheduler.SetTimeout( "CP_Glows_Custom_Edit", 0.01, index );
	}
	else if ( selection == 'item5' )
	{
		iCustomProgress[ index ] = 4;
		g_Scheduler.SetTimeout( "CP_Glows_Custom_Edit", 0.01, index );
	}
	else if ( selection == 'item6' )
	{
		iCustomProgress[ index ] = 5;
		g_Scheduler.SetTimeout( "CP_Glows_Custom_Edit", 0.01, index );
	}
	else if ( selection == 'item7' )
	{
		iCustomProgress[ index ] = 6;
		g_Scheduler.SetTimeout( "CP_Glows_Custom_Edit", 0.01, index );
	}
	else if ( selection == 'item8' )
	{
		iCustomProgress[ index ] = 7;
		g_Scheduler.SetTimeout( "CP_Glows_Custom_SetName", 0.01, index );
	}
	else if ( selection == 'item9' )
	{
		iCustomProgress[ index ] = 8;
		g_Scheduler.SetTimeout( "CP_Glows_Custom_SetPrivate", 0.01, index );
	}
	else if ( selection == 'item10' )
	{
		iCustomProgress[ index ] = 9;
		g_Scheduler.SetTimeout( "CP_Glows_Custom_SetPublic", 0.01, index );
	}
}

void CP_Trails( const int& in index )
{
	CBasePlayer@ pPlayer = g_PlayerFuncs.FindPlayerByIndex( index );
	MenuHandler@ state = MenuGetPlayer( pPlayer );
	
	state.InitMenu( pPlayer, CP_Trails_CB );
	state.menu.SetTitle( "Trails\n\nTienes: " + AddCommas( iCP[ index ] ) + " PC\n\n" );
	
	state.menu.AddItem( "Usar color predefinido\n", any( "item1" ) );
	state.menu.AddItem( "Usar color personalizado\n\n", any( "item2" ) );
	
	state.menu.AddItem( "Quitar trail\n\n", any( "item3" ) );
	
	string szItem4 = "Longitud del trail: ";
	switch ( ( !bTrail[ index ] ? iTrailLong[ index ] : iTrailNewLong[ index ] ) )
	{
		case 10: szItem4 += "Pequenia\n"; break;
		case 20: szItem4 += "Mediana\n"; break;
		case 30: szItem4 += "Grande\n"; break;
		case 40: szItem4 += "Muy grande\n"; break;
		case 50: szItem4 += "Excesiva\n"; break;
	}
	state.menu.AddItem( szItem4, any( "item4" ) );
	
	string szItem5 = "Anchura del trail: ";
	switch ( ( !bTrail[ index ] ? iTrailSize[ index ] : iTrailNewSize[ index ] ) )
	{
		case 4: szItem5 += "Pequenia\n"; break;
		case 8: szItem5 += "Mediana\n"; break;
		case 12: szItem5 += "Grande\n"; break;
		case 16: szItem5 += "Muy grande\n"; break;
		case 20: szItem5 += "Excesiva\n"; break;
	}
	state.menu.AddItem( szItem5, any( "item5" ) );
	
	string szItem6 = "Trail de Tipo ";
	switch ( ( !bTrail[ index ] ? iTrailSprite[ index ] : iTrailNewSprite[ index ] ) )
	{
		case 0: szItem6 += "A"; break;
		case 1: szItem6 += "B"; break;
		case 2: szItem6 += "C"; break;
		case 3: szItem6 += "D"; break;
		case 4: szItem6 += "E"; break;
		case 5: szItem6 += "F"; break;
		case 6: szItem6 += "G"; break;
		case 7: szItem6 += "H"; break;
		case 8: szItem6 += "I"; break;
		case 9: szItem6 += "J"; break;
		case 10: szItem6 += "K"; break;
		case 11: szItem6 += "L"; break;
		case 12: szItem6 += "M"; break;
		case 13: szItem6 += "N"; break;
		case 14: szItem6 += "O"; break;
		case 15: szItem6 += "P"; break;
		case 16: szItem6 += "Q"; break;
		case 17: szItem6 += "R"; break;
		case 18: szItem6 += "S"; break;
	}
	state.menu.AddItem( szItem6, any( "item6" ) );
	
	state.OpenMenu( pPlayer, 0, 0 );
}

void CP_Trails_CB( CTextMenu@ menu, CBasePlayer@ pPlayer, int page, const CTextMenuItem@ item )
{
	int index = pPlayer.entindex();
	if ( page == 10 ) return;
	
	string selection;
	item.m_pUserData.retrieve( selection );
	if ( selection == 'item1' )
	{
		if ( iCP[ index ] >= 350 )
		{
			if ( bTrail[ index ] ) bShouldUpdate[ index ] = true;
			g_Scheduler.SetTimeout( "CP_Trails_Default", 0.01, index );
		}
		else
		{
			g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "* Puntos Cosmeticos insuficientes (Necesitas: 350 PC)\n" );
			g_Scheduler.SetTimeout( "CP_Trails", 0.01, index );
		}
	}
	else if ( selection == 'item2' )
	{
		if ( iCP[ index ] >= 400 )
		{
			if ( bTrail[ index ] ) bShouldUpdate[ index ] = true;
			g_Scheduler.SetTimeout( "CP_Trails_Custom", 0.01, index );
		}
		else
		{
			g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "* Puntos Cosmeticos insuficientes (Necesitas: 400 PC)\n" );
			g_Scheduler.SetTimeout( "CP_Trails", 0.01, index );
		}
	}
	else if ( selection == 'item3' )
		g_Scheduler.SetTimeout( "CP_Trails_Remove", 0.01, index );
	else if ( selection == 'item4' )
	{
		if ( !bTrail[ index ] )
		{
			iTrailLong[ index ] += 10;
			if ( iTrailLong[ index ] > 50 )
				iTrailLong[ index ] = 10;
		}
		else
		{
			iTrailNewLong[ index ] += 10;
			if ( iTrailNewLong[ index ] > 50 )
				iTrailNewLong[ index ] = 10;
		}
		
		g_Scheduler.SetTimeout( "CP_Trails", 0.01, index );
	}
	else if ( selection == 'item5' )
	{
		if ( !bTrail[ index ] )
		{
			iTrailSize[ index ] += 4;
			if ( iTrailSize[ index ] > 20 )
				iTrailSize[ index ] = 4;
		}
		else
		{
			iTrailNewSize[ index ] += 4;
			if ( iTrailNewSize[ index ] > 20 )
				iTrailNewSize[ index ] = 4;
		}
		
		g_Scheduler.SetTimeout( "CP_Trails", 0.01, index );
	}
	else if ( selection == 'item6' )
	{
		if ( !bTrail[ index ] )
		{
			iTrailSprite[ index ]++;
			if ( iTrailSprite[ index ] > 18 )
				iTrailSprite[ index ] = 0;
		}
		else
		{
			iTrailNewSprite[ index ]++;
			if ( iTrailNewSprite[ index ] > 18 )
				iTrailNewSprite[ index ] = 0;
		}
		
		g_Scheduler.SetTimeout( "CP_Trails", 0.01, index );
	}
}


void CP_Trails_Default( const int& in index )
{
	CBasePlayer@ pPlayer = g_PlayerFuncs.FindPlayerByIndex( index );
	MenuHandler@ state = MenuGetPlayer( pPlayer );
	
	state.InitMenu( pPlayer, CP_Trails_Default_CB );
	
	string szTitle = "Predefinidos\n\nTienes: " + AddCommas( iCP[ index ] ) + " PC\nCosto: 350 PC\n\n";
	
	state.menu.SetTitle( szTitle );
	
	for( uint i = 0; i < _ColorNames.length(); i++ )
	{
		state.menu.AddItem( _ColorNames[ i ], any( string( i ) ) );
	}
	
	state.OpenMenu( pPlayer, 0, 0 );
}

void CP_Trails_Default_CB( CTextMenu@ menu, CBasePlayer@ pPlayer, int page, const CTextMenuItem@ item )
{
	int index = pPlayer.entindex();
	if ( page == 10 )
	{
		g_Scheduler.SetTimeout( "CP_Trails", 0.01, index );
		return;
	}
	
	string selection;
	item.m_pUserData.retrieve( selection );
	int iColor = atoi( selection );
	
	if ( !bShouldUpdate[ index ] )
		vecTrailColor[ index ] = _ColorCodes[ iColor ];
	else
		vecTrailUpdate[ index ] = _ColorCodes[ iColor ];
	
	g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "* Color del trail: " + _ColorNames[ iColor ] + "\n" );
	
	bTrail[ index ] = true;
	iCP[ index ] -= 350;
	
	if ( bShouldUpdate[ index ] )
	{
		vecTrailColor[ index ] = vecTrailUpdate[ index ];
		iTrailSprite[ index ] = iTrailNewSprite[ index ];
		iTrailLong[ index ] = iTrailNewLong[ index ];
		iTrailSize[ index ] = iTrailNewSize[ index ];
	}
	
	bShouldUpdate[ index ] = false;
	
	return;
}

void CP_Trails_Custom( const int& in index )
{
	CBasePlayer@ pPlayer = g_PlayerFuncs.FindPlayerByIndex( index );
	MenuHandler@ state = MenuGetPlayer( pPlayer );
	
	state.InitMenu( pPlayer, CP_Trails_Custom_CB );
	
	string szTitle = "Personalizado\n\nTienes: " + AddCommas( iCP[ index ] ) + " PC\nCosto: 400 PC\n\nUsa el comando\n/trail \"<RRR> <GGG> <BBB>\"\npara definir tu propio color\n\nDonde R, G y B es el color escrito\nen Codigo RGB\n\n(Las comillas deben estar presentes)\n";
	
	state.menu.SetTitle( szTitle );
	
	state.menu.AddItem( "Cancelar", any( "item1" ) );
	
	state.OpenMenu( pPlayer, 0, 0 );
}

void CP_Trails_Custom_CB( CTextMenu@ menu, CBasePlayer@ pPlayer, int page, const CTextMenuItem@ item )
{
	int index = pPlayer.entindex();
	if ( page == 10 ) return;
	
	bShouldUpdate[ index ] = false;
	g_Scheduler.SetTimeout( "CP_Trails", 0.01, index );
	return;
}

void CP_Trails_Remove( const int& in index )
{
	CBasePlayer@ pPlayer = g_PlayerFuncs.FindPlayerByIndex( index );
	
	bTrail[ index ] = false;
	vecTrailColor[ index ] = g_vecZero;
	
	g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "* Te quitaste el trail\n" );
}
	
void CP_Hats( const int& in index )
{
	CBasePlayer@ pPlayer = g_PlayerFuncs.FindPlayerByIndex( index );
	MenuHandler@ state = MenuGetPlayer( pPlayer );
	
	state.InitMenu( pPlayer, CP_Hats_CB );
	state.menu.SetTitle( "Hats\n\nTienes: " + AddCommas( iCP[ index ] ) + " PC\n\n" );
	
	state.menu.AddItem( "Elegir hat\n", any( "item1" ) );
	state.menu.AddItem( "Quitar hat\n\n", any( "item2" ) );
	
	string szItem3 = "Hat Glow? ";
	if ( hatGlow[ index ] )
		szItem3 += "[ SI ]\n";
	else
		szItem3 += "[ NO ]";
	state.menu.AddItem( szItem3, any( "item3" ) );
	
	if ( hatGlow[ index ] )
		state.menu.AddItem( "Color del glow", any( "item4" ) );
	
	state.OpenMenu( pPlayer, 0, 0 );
}

void CP_Hats_CB( CTextMenu@ menu, CBasePlayer@ pPlayer, int page, const CTextMenuItem@ item )
{
	int index = pPlayer.entindex();
	if ( page == 10 ) return;
	
	string selection;
	item.m_pUserData.retrieve( selection );
	if ( selection == 'item1' )
	{
		if ( iCP[ index ] >= 290 )
			g_Scheduler.SetTimeout( "CP_Hats_Select", 0.01, index );
		else
			g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "* Puntos Cosmeticos insuficientes (Necesitas: 290 PC)\n" );
	}
	else if ( selection == 'item2' )
		g_Scheduler.SetTimeout( "CP_Hats_Remove", 0.01, index );
	else if ( selection == 'item3' )
	{
		if ( !hatGlow[ index ] )
			hatGlow[ index ] = true;
		else
			hatGlow[ index ] = false;
		
		g_Scheduler.SetTimeout( "CP_Hats", 0.01, index );
	}
	else if ( selection == 'item4' )
		g_Scheduler.SetTimeout( "CP_Hats_Color", 0.01, index );
}

void CP_Hats_Select( const int& in index )
{
	CBasePlayer@ pPlayer = g_PlayerFuncs.FindPlayerByIndex( index );
	MenuHandler@ state = MenuGetPlayer( pPlayer );
	
	state.InitMenu( pPlayer, CP_Hats_Select_CB );
	
	string szTitle = "Elegir hat\n\nTienes: " + AddCommas( iCP[ index ] ) + " PC\nCosto: 290 PC\n\n";
	
	state.menu.SetTitle( szTitle );
	
	for( uint i = 0; i < _HatsNames.length(); i++ )
	{
		state.menu.AddItem( _HatsNames[ i ], any( string( i ) ) );
	}
	
	state.OpenMenu( pPlayer, 0, 0 );
}

void CP_Hats_Select_CB( CTextMenu@ menu, CBasePlayer@ pPlayer, int page, const CTextMenuItem@ item )
{
	int index = pPlayer.entindex();
	if ( page == 10 )
	{
		g_Scheduler.SetTimeout( "CP_Hats", 0.01, index );
		return;
	}
	
	string selection;
	item.m_pUserData.retrieve( selection );
	int iHat = atoi( selection );
	
	if ( hatGlow[ index ] && hatGlowColor[ index ] == g_vecZero )
	{
		g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "* Debes elegir un color para el glow de tu hat\n" );
		g_Scheduler.SetTimeout( "CP_Hats", 0.01, index );
		return;
	}
	
	if ( hatEntity[ index ].GetEntity() is null )
	{
		// Creation (first time)
		CBaseEntity@ pEntity = g_EntityFuncs.Create( "info_target", g_vecZero, g_vecZero, false );
		pEntity.pev.movetype = MOVETYPE_FOLLOW;
		@pEntity.pev.aiment = pPlayer.edict();
		
		// Model
		string szModel = "models/hats/" + _HatsNames[ iHat ] + ".mdl";
		g_EntityFuncs.SetModel( pEntity, szModel );
		
		// Rendering
		if ( hatGlow[ index ] )
		{
			pEntity.pev.renderfx = kRenderFxGlowShell;
			pEntity.pev.renderamt = 3;
			pEntity.pev.rendercolor = hatGlowColor[ index ];
		}
		else
		{
			pEntity.pev.renderfx = kRenderFxNone;
			pEntity.pev.renderamt = 0;
			pEntity.pev.rendercolor = g_vecZero;
		}
		
		hatEntity[ index ] = pEntity;
	}
	else
	{
		CBaseEntity@ pEntity = hatEntity[ index ].GetEntity();
		
		// Model
		string szModel = "models/hats/" + _HatsNames[ iHat ] + ".mdl";
		g_EntityFuncs.SetModel( pEntity, szModel );
		
		// Rendering
		if ( hatGlow[ index ] )
		{
			pEntity.pev.renderfx = kRenderFxGlowShell;
			pEntity.pev.renderamt = 3;
			pEntity.pev.rendercolor = hatGlowColor[ index ];
		}
		else
		{
			pEntity.pev.renderfx = kRenderFxNone;
			pEntity.pev.renderamt = 0;
			pEntity.pev.rendercolor = g_vecZero;
		}
		
		pEntity.pev.effects &= ~EF_NODRAW;
	}
	
	g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "* Hat \"" + _HatsNames[ iHat ] + "\" elegido\n" );
	
	iCP[ index ] -= 290;
	return;
}

void CP_Hats_Remove( const int& in index )
{
	CBasePlayer@ pPlayer = g_PlayerFuncs.FindPlayerByIndex( index );
	if ( hatEntity[ index ].GetEntity() !is null )
	{
		CBaseEntity@ pEntity = hatEntity[ index ].GetEntity();
		pEntity.pev.renderfx = kRenderFxNone;
		pEntity.pev.renderamt = 0;
		pEntity.pev.rendercolor = g_vecZero;
		pEntity.pev.effects |= EF_NODRAW;
	}
	g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "* Te quitaste el hat\n" );
}

void CP_Hats_Color( const int& in index )
{
	CBasePlayer@ pPlayer = g_PlayerFuncs.FindPlayerByIndex( index );
	MenuHandler@ state = MenuGetPlayer( pPlayer );
	
	state.InitMenu( pPlayer, CP_Hats_Color_CB );
	
	string szTitle = "Color del glow\n\n";
	
	state.menu.SetTitle( szTitle );
	
	for( uint i = 0; i < _ColorNames.length(); i++ )
	{
		state.menu.AddItem( _ColorNames[ i ], any( string( i ) ) );
	}
	
	state.OpenMenu( pPlayer, 0, 0 );
}

void CP_Hats_Color_CB( CTextMenu@ menu, CBasePlayer@ pPlayer, int page, const CTextMenuItem@ item )
{
	int index = pPlayer.entindex();
	if ( page == 10 )
	{
		g_Scheduler.SetTimeout( "CP_Hats", 0.01, index );
		return;
	}
	
	string selection;
	item.m_pUserData.retrieve( selection );
	int iColor = atoi( selection );
	
	hatGlowColor[ index ] = _ColorCodes[ iColor ];
	
	g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "* Color del glow: " + _ColorNames[ iColor ] + ". Ahora puedes elegir un hat\n" );
	
	g_Scheduler.SetTimeout( "CP_Hats", 0.01, index );
	
	return;
}

void CP_Other( const int& in index )
{
	CBasePlayer@ pPlayer = g_PlayerFuncs.FindPlayerByIndex( index );
	MenuHandler@ state = MenuGetPlayer( pPlayer );
	
	state.InitMenu( pPlayer, CP_Other_CB );
	state.menu.SetTitle( "Otros\n\nTienes: " + AddCommas( iCP[ index ] ) + " PC\n\nADVERTENCIA: Al comprar un Amplificador se\nsobreescribira cualquier amplificador existente\n\nTodos los Amplificadores tienen\nuna duracion de 1 hora\n\n" );
	
	state.menu.AddItem( "Suministro Auxiliar [ 30,000 PC ]\n\n", any( "item1" ) );
	state.menu.AddItem( "Amplificador Nivel 1 (EXP x2) [ 50,000 PC ]\n", any( "item2" ) );
	state.menu.AddItem( "Amplificador Nivel 2 (EXP x3) [ 120,000 PC ]\n", any( "item3" ) );
	state.menu.AddItem( "Amplificador Nivel 3 (EXP x4) [ 280,000 PC ]\n\n", any( "item4" ) );
	if ( bHasMGAccess[ index ] == 1 ) state.menu.AddItem( "Regalo [ ?,???,??? PC ]\n", any( "item5" ) );
	
	state.OpenMenu( pPlayer, 0, 0 );
}

void CP_Other_CB( CTextMenu@ menu, CBasePlayer@ pPlayer, int page, const CTextMenuItem@ item )
{
	int index = pPlayer.entindex();
	if ( page == 10 ) return;
	
	CustomKeyvalues@ pCustom = pPlayer.GetCustomKeyvalues();
	
	string selection;
	item.m_pUserData.retrieve( selection );
	if ( selection == 'item1' )
	{
		if ( iCP[ index ] >= 30000 )
		{
			iCP[ index ] -= 30000;
			g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "* Compraste un Suministro Auxiliar\n" );
			
			pCustom.SetKeyvalue( "$i_cp_spark", 1 );
			
			g_Scheduler.SetTimeout( "CP_Other", 1.25, index );
		}
		else
		{
			g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "* Puntos Cosmeticos insuficientes\n" );
			g_Scheduler.SetTimeout( "CP_Other", 0.01, index );
		}
	}
	else if ( selection == 'item2' )
	{
		if ( iCP[ index ] >= 50000 )
		{
			iCP[ index ] -= 50000;
			g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "* Compraste Amplificador Nivel 1 (EXP x2)\n" );
			
			pCustom.SetKeyvalue( "$i_cp_expamp", 1 );
			
			g_Scheduler.SetTimeout( "CP_Other", 0.01, index );
		}
		else
		{
			g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "* Puntos Cosmeticos insuficientes\n" );
			g_Scheduler.SetTimeout( "CP_Other", 0.01, index );
		}
	}
	else if ( selection == 'item3' )
	{
		if ( iCP[ index ] >= 120000 )
		{
			iCP[ index ] -= 120000;
			g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "* Compraste Amplificador Nivel 2 (EXP x3)\n" );
			
			pCustom.SetKeyvalue( "$i_cp_expamp", 2 );
			
			g_Scheduler.SetTimeout( "CP_Other", 0.01, index );
		}
		else
		{
			g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "* Puntos Cosmeticos insuficientes\n" );
			g_Scheduler.SetTimeout( "CP_Other", 0.01, index );
		}
	}
	else if ( selection == 'item4' )
	{
		if ( iCP[ index ] >= 280000 )
		{
			iCP[ index ] -= 280000;
			g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "* Compraste Amplificador Nivel 3 (EXP x4)\n" );
			
			pCustom.SetKeyvalue( "$i_cp_expamp", 3 );
			
			g_Scheduler.SetTimeout( "CP_Other", 0.01, index );
		}
		else
		{
			g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "* Puntos Cosmeticos insuficientes\n" );
			g_Scheduler.SetTimeout( "CP_Other", 0.01, index );
		}
	}
	else if ( selection == 'item5' )
	{
		// Check gift
		pPlayer.pev.globalname = "CHECK#SERVER*" + g_EngineFuncs.GetPlayerAuthId( pPlayer.edict() );
		@pPlayer.pev.euser1 = pPlayer.edict();
		
		g_Scheduler.SetTimeout( "MysteryGift_CheckGift", 0.1, index );
	}
}

void CP_Help( const int& in index )
{
	CBasePlayer@ pPlayer = g_PlayerFuncs.FindPlayerByIndex( index );
	
	string szMessage = "Que son los PCs?\n\n";
	
	szMessage += "Los PCs (Puntos Cosmeticos) son la moneda que te permite comprar glows, trails, hats y mas. ";
	szMessage += "Junta PCs y usalo en la cosmetica que quieras, y decora tu personaje a gusto y semejanza\n\n";
	
	szMessage += "Como consigo PCs?\n\n";
	
	szMessage += "Adquieres PCs de la misma manera que juntas EXP para subir de nivel. Solo mata enemigos, y tus PCs iran aumentando gradualmente.\n\n";
	
	szMessage += "Debo usar siempre el menu de cosmetica?\n\n";
	
	szMessage += "Para nada, el menu es un agregado por si necesitas de una interfaz grafica para elegir tu cosmetica. ";
	szMessage += "Si lo deseas, puedes activar la cosmetica con los siguientes comandos de say:\n\n";
	
	szMessage += "/glow <color/es en ingles>\n   Multiples colores separados por un espacio\n   ";
	szMessage += "Para acceder rapidamente al menu de glows, usa el comando /glow menu\n\n";
	
	szMessage += "/trail <color en ingles> [tipo] [longitud] [anchura]\n   Los parametros escritos en [] son opcionales\n   ";
	szMessage += "Para acceder rapidamente al menu de trails, usa el comando /trail menu\n\n";
	
	szMessage += "Para acceder rapidamente al menu de hats, usa el comando /hats\n\n";
	
	ShowMOTD( pPlayer, "Cosmetica", szMessage );
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

void MysteryGift_CheckGift( const int& in index )
{
	CBasePlayer@ pPlayer = g_PlayerFuncs.FindPlayerByIndex( index );
	
	CustomKeyvalues@ pCustom = pPlayer.GetCustomKeyvalues();
	if ( bHasMGAccess[ index ] == 1 )
	{
		// MG Check handlers
		CustomKeyvalue iMGCheck_pre( pCustom.GetKeyvalue( "$i_mg_check" ) );
		int iMGCheck = iMGCheck_pre.GetInteger();
		if ( iMGCheck != 0 )
		{
			switch ( iMGCheck )
			{
				case -1:
				{
					MysteryGift_CreateGift( index );
					pCustom.SetKeyvalue( "$i_mg_check", 0 );
					return;
				}
				case 1:
				{
					g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "* Solo puedes crear 1 regalo por dia\n" );
					pCustom.SetKeyvalue( "$i_mg_check", 0 );
					return;
				}
			}
		}
		
		g_Scheduler.SetTimeout( "MysteryGift_CheckGift", 0.1, index );
	}
}

void MysteryGift_CreateGift( const int& in index )
{
	CBasePlayer@ pPlayer = g_PlayerFuncs.FindPlayerByIndex( index );
	MenuHandler@ state = MenuGetPlayer( pPlayer );
	
	// Calculate gift cost now
	MysteryGift_CalculateCost( index );
	
	state.InitMenu( pPlayer, MysteryGift_CreateGift_CB );
	state.menu.SetTitle( "Crear regalo\n\nTienes: " + AddCommas( iCP[ index ] ) + " PC\nCosto del regalo: " + AddCommas( iGiftCost[ index ] ) + " PC\n" );
	
	string szItem1 = "Tipo de regalo: ";
	switch ( iGiftType[ index ] )
	{
		case 0: szItem1 += "<elige>"; break;
		case 1: szItem1 += "EXP"; break;
		case 2: szItem1 += "Puntos Cosmeticos"; break;
		case 3: szItem1 += "Suministros Auxiliares"; break;
		case 4: szItem1 += "Medallas"; break;
		case 5: szItem1 += "Amplificador Nivel 1 (EXP x2)"; break;
		case 6: szItem1 += "Amplificador Nivel 2 (EXP x3)"; break;
		case 7: szItem1 += "Amplificador Nivel 3 (EXP x4)"; break;
		case 8: szItem1 += "Amplificador Nivel 4 (EXP x5)"; break;
	}
	szItem1 += "\n   - Que quieres regalar?\n\n";
	state.menu.AddItem( szItem1, any( "item1" ) );
	
	string szItem2 = "Cantidad: " + iGiftAmount[ index ] + " ";
	switch ( iGiftType[ index ] )
	{
		case 1: szItem2 += "EXP"; break;
		case 2: szItem2 += "PC"; break;
		case 3: szItem2 += "Suministro(s)"; break;
		case 4: szItem2 += "Medalla(s)"; break;
		case 5: szItem2 += "Minutos"; break;
		case 6: szItem2 += "Minutos"; break;
		case 7: szItem2 += "Minutos"; break;
		case 8: szItem2 += "Minutos"; break;
	}
	szItem2 += "\n   - Cuanto quieres otorgar?\n\n";
	state.menu.AddItem( szItem2, any( "item2" ) );
	
	string szItem3 = "Para: ";
	if ( szGiftDestination[ index ].Length() > 0 ) szItem3 += szGiftDestination[ index ];
	else szItem3 += "<elige>";
	szItem3 += "\n   - Este regalo es para quien?\n\n";
	state.menu.AddItem( szItem3, any( "item3" ) );
	
	string szItem4 = "Mensaje de regalo";
	szItem4 += "\n   - Enviar un mensaje con el regalo?\n\n";
	state.menu.AddItem( szItem4, any( "item4" ) );
	
	state.menu.AddItem( "Crear!", any( "item5" ) );
	
	iCustomProgress[ index ] = 0;
	state.OpenMenu( pPlayer, 0, 0 );
}

void MysteryGift_CreateGift_CB( CTextMenu@ menu, CBasePlayer@ pPlayer, int page, const CTextMenuItem@ item )
{
	int index = pPlayer.entindex();
	if ( page == 10 ) return;
	
	CustomKeyvalues@ pCustom = pPlayer.GetCustomKeyvalues();
	
	string selection;
	item.m_pUserData.retrieve( selection );
	if ( selection == 'item1' )
	{
		iGiftType[ index ]++;
		if ( iGiftType[ index ] > ( bIsChampion[ index ] ? 8 : 7 ) )
			iGiftType[ index ] = 1;
		
		g_Scheduler.SetTimeout( "MysteryGift_CreateGift", 0.01, index );
	}
	else if ( selection == 'item2' )
	{
		iCustomProgress[ index ] = 1;
		g_Scheduler.SetTimeout( "MysteryGift_SetAmount", 0.01, index );
	}
	else if ( selection == 'item3' )
	{
		iCustomProgress[ index ] = 2;
		g_Scheduler.SetTimeout( "MysteryGift_SetPlayer", 0.01, index );
	}
	else if ( selection == 'item4' )
	{
		iCustomProgress[ index ] = 3;
		g_Scheduler.SetTimeout( "MysteryGift_SetMessage", 0.01, index );
	}
	else if ( selection == 'item5' )
	{
		if ( iGiftType[ index ] == 0 || iGiftAmount[ index ] == 0 || szGiftDestination[ index ].Length() == 0 )
		{
			g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "* No puedes crear un regalo vacio\n" );
			g_Scheduler.SetTimeout( "MysteryGift_CreateGift", 0.01, index );
		}
		else
		{
			if ( iGiftCost[ index ] < 0 )
				g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "* BAD GIFT\n" );
			else if ( iCP[ index ] >= iGiftCost[ index ] )
			{
				g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "* Creando regalo, por favor no te desconectes del servidor\n" );
				
				// Prepare for creation
				string szType = "BADGIFT";
				switch ( iGiftType[ index ] )
				{
					case 1: szType = "EXP"; break;
					case 2: szType = "CP"; break;
					case 3: szType = "SPARK"; break;
					case 4: szType = "MEDAL"; break;
					case 5: szType = "AMPLV1"; break;
					case 6: szType = "AMPLV2"; break;
					case 7: szType = "AMPLV3"; break;
				}
				
				if ( iGiftCost[ index ] >= 9000000 && szType != 'BADGIFT' )
					g_Game.AlertMessage( at_logged, "[SERVER] El jugador " + pPlayer.pev.netname + " ha gastado 9,000,000 PC en un Regalo!\n" );
				
				string szAmount = string( iGiftAmount[ index ] );
				
				string szDestination = "NONE";
				if ( szGiftDestination[ index ] == "Todos los jugadores" ) szDestination = "ALL";
				else szDestination = szGiftDestination[ index ];
				
				string szMessage = "";
				switch ( iGiftType[ index ] )
				{
					case 1: szMessage = string( AddCommas( iGiftAmount[ index ] ) ) + "-EXP$"; break;
					case 2: szMessage = string( AddCommas( iGiftAmount[ index ] ) ) + "-Puntos-Cosmeticos$"; break;
					case 3: szMessage = string( AddCommas( iGiftAmount[ index ] ) ) + "-Suministros-Auxiliares$"; break;
					case 4: szMessage = string( AddCommas( iGiftAmount[ index ] ) ) + "-Medallas$"; break;
					case 5: szMessage = "Amplificador-Nivel-1$"; break;
					case 6: szMessage = "Amplificador-Nivel-2$"; break;
					case 7: szMessage = "Amplificador-Nivel-3$"; break;
					case 8: szMessage = "Amplificador-Nivel-4$"; break;
				}
				if ( szGiftMessage[ index ].Length() > 0 ) szMessage += szGiftMessage[ index ];
				else szMessage += "Que-lo-disfrutes!!n!n---" + pPlayer.pev.netname;
				szMessage.Replace( ' ', '-' );
				
				// PEVs cannot have more than 64 characters. That breaks our gifts! Create a file and call AMXX to use it
				string charfix = "" + "scripts/plugins/store/scxpm_event/" + "MG_" + g_EngineFuncs.GetPlayerAuthId( pPlayer.edict() ) + ".sys";
				charfix.Replace( ':', '_' );
				File@ mgfix = g_FileSystem.OpenFile( charfix, OpenFile::WRITE );
				
				if ( mgfix !is null && mgfix.IsOpen() )
				{
					string stuff;
					
					stuff += "" + szType + "#" + szAmount + "#" + szDestination + "#" + szMessage;
					
					mgfix.Write( stuff );
					mgfix.Close();
				}
				else
				{
					g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "* Error inesperado en el servidor\n" );
					return;
				}
				
				string szCommand = "CREATE#" + g_EngineFuncs.GetPlayerAuthId( pPlayer.edict() );
				
				pPlayer.pev.globalname = szCommand;
				@pPlayer.pev.euser1 = pPlayer.edict();
				
				g_Scheduler.SetTimeout( "MysteryGift_CheckCreation", 0.01, index );
			}
			else
			{
				g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "* Puntos Cosmeticos insuficientes\n" );
				g_Scheduler.SetTimeout( "MysteryGift_CreateGift", 0.01, index );
			}
		}
	}
}

void MysteryGift_SetAmount( const int& in index )
{
	CBasePlayer@ pPlayer = g_PlayerFuncs.FindPlayerByIndex( index );
	MenuHandler@ state = MenuGetPlayer( pPlayer );
	
	state.InitMenu( pPlayer, MysteryGift_SetDummy_CB );
	state.menu.SetTitle( "Cantidad\n\nUsa el comando /giftamount <valor>\npara establecer cuanto otorgar\n" );
	
	state.menu.AddItem( "Cancelar", any( "item1" ) );
	state.OpenMenu( pPlayer, 0, 0 );
}

void MysteryGift_SetPlayer( const int& in index )
{
	CBasePlayer@ pPlayer = g_PlayerFuncs.FindPlayerByIndex( index );
	MenuHandler@ state = MenuGetPlayer( pPlayer );
	
	state.InitMenu( pPlayer, MysteryGift_SetDummy_CB );
	state.menu.SetTitle( "Para?\n\nUsa el comando /giftplayer <jugador>\npara elegir al jugador\n\nSi el jugador no se encuentra\nconectado debes escribir su SteamID\n\nPara dar este regalo a todos\nlos jugadores, escribe \"GIVEALL\"\n" );
	
	state.menu.AddItem( "Cancelar", any( "item1" ) );
	state.OpenMenu( pPlayer, 0, 0 );
}

void MysteryGift_SetMessage( const int& in index )
{
	CBasePlayer@ pPlayer = g_PlayerFuncs.FindPlayerByIndex( index );
	MenuHandler@ state = MenuGetPlayer( pPlayer );
	
	state.InitMenu( pPlayer, MysteryGift_SetDummy_CB );
	state.menu.SetTitle( "Mensaje\n\nUsa el comando /giftmessage <mensaje>\npara adjuntar un mensaje personalizado al regalo\n\nTu nombre sera automaticamente\nagregado al final del mensaje\n\nNo se pueden usar los simbolos \" $ -\n\nPara borrar el mensaje, escribe \"NULL\"\nUsa \"!n\" para ir a la siguiente linea\n" );
	
	state.menu.AddItem( "Cancelar", any( "item1" ) );
	state.OpenMenu( pPlayer, 0, 0 );
}

void MysteryGift_SetDummy_CB( CTextMenu@ menu, CBasePlayer@ pPlayer, int page, const CTextMenuItem@ item )
{
	int index = pPlayer.entindex();
	if ( page == 10 ) return;
	
	CustomKeyvalues@ pCustom = pPlayer.GetCustomKeyvalues();
	
	string selection;
	item.m_pUserData.retrieve( selection );
	if ( selection == 'item1' )
		g_Scheduler.SetTimeout( "MysteryGift_CreateGift", 0.01, index );
}

void MGSetAmount( SayParameters@ pParams )
{
	pParams.ShouldHide = true;
	
	CBasePlayer@ pPlayer = pParams.GetPlayer();
	int index = pPlayer.entindex();
	
	if ( iCustomProgress[ index ] == 1 && bHasMGAccess[ index ] == 1 )
	{
		const CCommand@ args = pParams.GetArguments();
		
		if ( args.ArgC() > 1 )
		{
			int iAmount = atoi( args[ 1 ] );
			if ( iAmount > 0 )
			{
				switch ( iGiftType[ index ] )
				{
					case 1: // EXP
					{
						if ( iGiftAmount[ index ] > 1000000 )
						{
							iGiftAmount[ index ] = 1000000;
							break;
						}
					}
					case 2: // CP
					{
						if ( iGiftAmount[ index ] > 5000000 )
						{
							iGiftAmount[ index ] = 5000000;
							break;
						}
					}
					case 3: // Sparks of Life
					{
						if ( iGiftAmount[ index ] > 75 )
						{
							iGiftAmount[ index ] = 75;
							break;
						}
					}
					case 4: // Medals
					{
						if ( iGiftAmount[ index ] > 40 )
						{
							iGiftAmount[ index ] = 40;
							break;
						}
					}
					case 5: // EXP x2
					{
						if ( iGiftAmount[ index ] > 21600 )
						{
							iGiftAmount[ index ] = 21600;
							break;
						}
					}
					case 6: // EXP x3
					{
						if ( iGiftAmount[ index ] > 21600 )
						{
							iGiftAmount[ index ] = 21600;
							break;
						}
					}
					case 7: // EXP x4
					{
						if ( iGiftAmount[ index ] > 21600 )
						{
							iGiftAmount[ index ] = 21600;
							break;
						}
					}
					case 8: // EXP x5
					{
						if ( iGiftAmount[ index ] > 21600 )
						{
							iGiftAmount[ index ] = 21600;
							break;
						}
					}
				}
				
				iGiftAmount[ index ] = iAmount;
				g_Scheduler.SetTimeout( "MysteryGift_CreateGift", 0.01, index );
			}
			else
				g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "* La cantidad debe ser mayor a 0\n" );
		}
	}
}

void MGSetPlayer( SayParameters@ pParams )
{
	pParams.ShouldHide = true;
	
	CBasePlayer@ pPlayer = pParams.GetPlayer();
	int index = pPlayer.entindex();
	
	if ( iCustomProgress[ index ] == 2 && bHasMGAccess[ index ] == 1 )
	{
		const CCommand@ args = pParams.GetArguments();
		
		if ( args.ArgC() > 1 )
		{
			string PlayerID = g_EngineFuncs.GetPlayerAuthId( pPlayer.edict() );
			
			bool bMultiple = false;
			CBasePlayer@ pTarget = FindPlayer( args[ 1 ], bMultiple );
			
			if ( bMultiple )
				g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "* Multiples jugadores encontrados. Se mas especifico\n" );
			else if ( pTarget !is null )
			{
				if ( pTarget is pPlayer )
					g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "* No puedes crear un regalo para ti mismo\n" );
				else
				{
					string TargetID = g_EngineFuncs.GetPlayerAuthId( pTarget.edict() );
					if ( PlayerID == TargetID )
						g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "* No puedes crear un regalo para ti mismo\n" );
					else
					{
						szGiftDestination[ index ] = TargetID;
						g_Scheduler.SetTimeout( "MysteryGift_CreateGift", 0.01, index );
					}
				}
			}
			else
			{
				string TargetID = args[ 1 ];
				if ( TargetID.StartsWith( "STEAM_", String::CaseInsensitive ) )
				{
					TargetID.ToUppercase();
					
					if ( PlayerID == TargetID )
						g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "* No puedes crear un regalo para ti mismo\n" );
					else
					{
						szGiftDestination[ index ] = TargetID;
						g_Scheduler.SetTimeout( "MysteryGift_CreateGift", 0.01, index );
					}
				}
				else if ( TargetID == "GIVEALL" )
				{
					szGiftDestination[ index ] = "Todos los jugadores";
					g_Scheduler.SetTimeout( "MysteryGift_CreateGift", 0.01, index );
				}
				else
					g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "* Jugador no encontrado. Intenta nuevamente o escribe por SteamID\n" );
			}
		}
	}
}

void MGSetMessage( SayParameters@ pParams )
{
	pParams.ShouldHide = true;
	
	CBasePlayer@ pPlayer = pParams.GetPlayer();
	int index = pPlayer.entindex();
	
	if ( iCustomProgress[ index ] == 3 && bHasMGAccess[ index ] == 1 )
	{
		const CCommand@ args = pParams.GetArguments();
		
		if ( args.ArgC() > 1 )
		{
			string szMessage = "";
			for ( int i = 1; i < args.ArgC(); i++ )
			{
				szMessage += args[ i ] + " ";
			}
			
			// Check if message is valid
			uint uiCharacters = szMessage.Length();
			uint iCheck = 0;
			
			for ( uint i = 0; i < uiCharacters; i++ )
			{
				if ( szMessage[ i ] == '"' || szMessage[ i ] == '$' || szMessage[ i ] == '-' )
				{
					g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "* El mensaje no es valido\n" );
					return;
				}
			}
			
			if ( szMessage == 'NULL ' )
			{
				szGiftMessage[ index ] = "";
				g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "* El regalo ya no usara mensaje personalizado\n" );
				g_Scheduler.SetTimeout( "MysteryGift_CreateGift", 0.01, index );
				return;
			}
			
			if ( szMessage.Length() > 160 )
				g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "* El mensaje es demasiado largo\n" );
			else // All OK
			{
				// Append the player's name to the message
				szMessage += "!n!n---" + pPlayer.pev.netname;
				
				string szCopyMessage = szMessage;
				szCopyMessage.Replace( '!n', '\n' );
				
				szGiftMessage[ index ] = szMessage;
				g_Scheduler.SetTimeout( "MysteryGift_CreateGift", 0.01, index );
				
				// Let player preview the message
				ShowMOTD( pPlayer, "Vista previa del mensaje", szCopyMessage );
			}
		}
	}
}

void MysteryGift_CalculateCost( const int& in index )
{
	iGiftCost[ index ] = 0;
	
	switch ( iGiftType[ index ] )
	{
		case 1: iGiftCost[ index ] += ( iGiftAmount[ index ] * 4 ); break;
		case 2: iGiftCost[ index ] += iGiftAmount[ index ]; break;
		case 3: iGiftCost[ index ] += ( iGiftAmount[ index ] * 27000 ); break;
		case 4: iGiftCost[ index ] += ( iGiftAmount[ index ] * 389500 ); break;
		case 5: iGiftCost[ index ] += ( iGiftAmount[ index ] * 798 ); break;
		case 6: iGiftCost[ index ] += ( iGiftAmount[ index ] * 1496 ); break;
		case 7: iGiftCost[ index ] += ( iGiftAmount[ index ] * 3994 ); break;
		case 8: iGiftCost[ index ] += ( iGiftAmount[ index ] * 5791 ); break;
	}
	
	if ( szGiftDestination[ index ] == "Todos los jugadores" ) iGiftCost[ index ] *= 9;
}

void MysteryGift_CheckCreation( const int& in index )
{
	CBasePlayer@ pPlayer = g_PlayerFuncs.FindPlayerByIndex( index );
	
	CustomKeyvalues@ pCustom = pPlayer.GetCustomKeyvalues();
	if ( bHasMGAccess[ index ] == 1 )
	{
		// MG Check handlers
		CustomKeyvalue iMGCreated_pre( pCustom.GetKeyvalue( "$i_mg_creation" ) );
		int iMGCreated = iMGCreated_pre.GetInteger();
		if ( iMGCreated != 0 )
		{
			switch ( iMGCreated )
			{
				case -1:
				{
					g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "* Error inesperado en el servidor\n" );
					pCustom.SetKeyvalue( "$i_mg_creation", 0 );
					return;
				}
				case 1:
				{
					iCP[ index ] -= iGiftCost[ index ];
					g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "* Tu regalo ha sido creado. Recuerda informar que lo reclame desde Mystery Gift!\n" );
					pCustom.SetKeyvalue( "$i_mg_creation", 0 );
					return;
				}
			}
		}
		
		g_Scheduler.SetTimeout( "MysteryGift_CheckCreation", 0.1, index );
	}
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
		szOutput = "????????????";
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

/* Helper function to find a player by name without being "exact" */
CBasePlayer@ FindPlayer( const string& in szName, bool& out bMultiple = false )
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

void CP_Fireworks( const int& in index )
{
	CBasePlayer@ pPlayer = g_PlayerFuncs.FindPlayerByIndex( index );
	MenuHandler@ state = MenuGetPlayer( pPlayer );
	
	state.InitMenu( pPlayer, CP_Fireworks_CB );
	state.menu.SetTitle( "Fireworks\n\nTienes " + AddCommas( iCP[ index ] ) + " PC\n\n" + iFireworks[ index ] + " de 3 misiles usados\n\n" );
	
	any item1;
	any item2;
	any item3;
	any item4;
	
	item1.store( "item1" );
	item2.store( "item2" );
	item3.store( "item3" );
	item4.store( "item4" );
	
	state.menu.AddItem( "Misil normal [ 50 PC ]\n", item1 );
	state.menu.AddItem( "Misil guiado por mira [ 75 PC ]\n", item2 );
	state.menu.AddItem( "Misil guiado por camara [ 100 PC ]\n\n", item3 );
	state.menu.AddItem( "Disparar misiles\n", item4 );
	
	state.OpenMenu( pPlayer, 0, 0 );
}

void CP_Fireworks_CB( CTextMenu@ menu, CBasePlayer@ pPlayer, int page, const CTextMenuItem@ item )
{
	int index = pPlayer.entindex();
	if ( page == 10 ) return;
	
	string selection;
	item.m_pUserData.retrieve( selection );
	if ( selection == 'item1' )
	{
		if ( iFireworks[ index ] < 3 )
		{
			if ( iCP[ index ] >= 50 )
			{
				iCP[ index ] -= 50;
				fireworks_spawn( index, "firework_normal", "abcdefsz" );
			}
			else
				g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "* Puntos Cosmeticos insuficientes\n" );
		}
		else
			g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "* Ya no puedes crear mas misiles\n" );
		
		g_Scheduler.SetTimeout( "CP_Fireworks", 0.01, index );
	}
	else if ( selection == 'item2' )
	{
		if ( iFireworks[ index ] < 3 )
		{
			if ( iCP[ index ] >= 75 )
			{
				iCP[ index ] -= 75;
				fireworks_spawn( index, "firework_rc", "abcdefsz" );
			}
			else
				g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "* Puntos Cosmeticos insuficientes\n" );
		}
		else
			g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "* Ya no puedes crear mas misiles\n" );
		
		g_Scheduler.SetTimeout( "CP_Fireworks", 0.01, index );
	}
	else if ( selection == 'item3' )
	{
		if ( iFireworks[ index ] < 3 )
		{
			if ( iCP[ index ] >= 100 )
			{
				iCP[ index ] -= 100;
				fireworks_spawn( index, "firework_rv", "abcdefsz" );
			}
			else
				g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "* Puntos Cosmeticos insuficientes\n" );
		}
		else
			g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "* Ya no puedes crear mas misiles\n" );
		
		g_Scheduler.SetTimeout( "CP_Fireworks", 0.01, index );
	}
	else if ( selection == 'item4' )
	{
		shoot_firework( index );
		
		g_Scheduler.SetTimeout( "CP_Fireworks", 0.01, index );
	}
}

void fireworks_spawn( const int& in index, const string& in type, const string& in effects )
{
	CBasePlayer@ pPlayer = g_PlayerFuncs.FindPlayerByIndex( index );
	
	Vector vecOrigin;
	Vector vecAngles;
	
	vecAngles.x = 90.0;
	vecAngles.y = Math.RandomFloat( 0.0, 360.0 );
	vecAngles.z = 0.0;
	
	vecOrigin = pPlayer.pev.origin;
	
	Vector vecMins = Vector( -4.0, -4.0, -1.0 );
	Vector vecMaxs = Vector( 4.0, 4.0, 12.0 );
	
	CBaseEntity@ pEnt = g_EntityFuncs.Create( "info_target", g_vecZero, g_vecZero, false );
	
	g_EntityFuncs.SetOrigin( pEnt, vecOrigin );
	g_EntityFuncs.SetSize( pEnt.pev, vecMins, vecMaxs );
	g_EntityFuncs.SetModel( pEnt, "models/rpgrocket.mdl" );
	
	pEnt.pev.target = effects;
	pEnt.pev.targetname = type;
	pEnt.pev.angles = vecAngles;
	@pEnt.pev.owner = pPlayer.edict();
	pEnt.pev.solid = SOLID_SLIDEBOX;
	pEnt.pev.movetype = MOVETYPE_TOSS;
	
	int r = Math.RandomLong( 0, 255 );
	int g = Math.RandomLong( 0, 255 );
	int b = Math.RandomLong( 0, 255 );
	
	pEnt.pev.renderfx = kRenderFxGlowShell;
	pEnt.pev.rendermode = kRenderNormal;
	pEnt.pev.rendercolor = Vector( r, g, b );
	
	pEnt.pev.iuser2 = r;
	pEnt.pev.iuser3 = g;
	pEnt.pev.iuser4 = b;
	
	g_SoundSystem.EmitSoundDyn( pEnt.edict(), CHAN_WEAPON, "fireworks/weapondrop1.wav", VOL_NORM, ATTN_NONE, 0, PITCH_NORM );
	
	iFireworks[ index ]++;
}

void shoot_firework( const int& in index )
{
	fireworks_shoot( index );
}

void fireworks_shoot( const int& in index )
{
	CBasePlayer@ pPlayer = g_PlayerFuncs.FindPlayerByIndex( index );
	
	CBaseEntity@ pEntity = null;
	while( ( @pEntity = g_EntityFuncs.FindEntityByClassname( pEntity, "info_target" ) ) !is null )
	{
		if ( pEntity.pev.owner is pPlayer.edict() )
		{
			pEntity.pev.effects = EF_LIGHT;
			
			g_SoundSystem.EmitSoundDyn( pEntity.edict(), CHAN_WEAPON, "weapons/rocketfire1.wav", VOL_NORM, ATTN_NONE, 0, PITCH_NORM );
			g_SoundSystem.EmitSoundDyn( pEntity.edict(), CHAN_VOICE, "fireworks/rocket1.wav", VOL_NORM, ATTN_NONE, 0, PITCH_NORM );
			
			uint8 r = pEntity.pev.iuser2;
			uint8 g = pEntity.pev.iuser3;
			uint8 b = pEntity.pev.iuser4;
			
			pEntity.pev.movetype = MOVETYPE_FLY;
			
			NetworkMessage effect( MSG_BROADCAST, NetworkMessages::SVC_TEMPENTITY );
			effect.WriteByte( TE_BEAMFOLLOW );
			effect.WriteShort( pEntity.entindex() );
			effect.WriteShort( sprSmoke );
			effect.WriteByte( 45 );
			effect.WriteByte( 4 );
			effect.WriteByte( r );
			effect.WriteByte( g );
			effect.WriteByte( b );
			effect.WriteByte( 255 );
			effect.End();
			
			Vector vecVelocity;
			vecVelocity.z = Math.RandomFloat( 400.0, 1000.0 );
			pEntity.pev.velocity = vecVelocity;
			
			g_Scheduler.SetTimeout( "fireworks_think", 0.1, pEntity.entindex() );
		}
	}
}

void detonate_fireworks( const int& in index, const string& in szClass )
{
	CBasePlayer@ pPlayer = g_PlayerFuncs.FindPlayerByIndex( index );
	
	CBaseEntity@ pEntity = null;
	while( ( @pEntity = g_EntityFuncs.FindEntityByClassname( pEntity, "info_target" ) ) !is null )
	{
		if ( pEntity.pev.owner is pPlayer.edict() )
		{
			if ( pEntity.pev.targetname == szClass )
			{
				explode( pEntity.entindex() );
				g_EngineFuncs.SetView( pPlayer.edict(), pPlayer.edict() );
				g_EntityFuncs.Remove( pEntity );
			}
		}
	}
}

// Think and Touch
void fireworks_think( const int& in index )
{
	CBaseEntity@ pEntity = g_EntityFuncs.Instance( index );
	if ( pEntity !is null )
	{
		CBaseEntity@ pOwner = g_EntityFuncs.Instance( pEntity.pev.owner );
		if ( pOwner is null )
			g_EntityFuncs.Remove( pEntity );
		else
		{
			if ( pEntity.pev.targetname == "firework_normal" )
			{
				Vector vecVelocity = pEntity.pev.velocity;
				
				vecVelocity.x += Math.RandomFloat( -100.0, 100.0 );
				vecVelocity.y += Math.RandomFloat( -100.0, 100.0 );
				vecVelocity.z += Math.RandomFloat( 10.0, 200.0 );
				
				pEntity.pev.velocity = vecVelocity;
				g_Scheduler.SetTimeout( "fireworks_think", 0.1, index );
			}
			else if ( pEntity.pev.targetname == "firework_rc" )
			{
				Vector vecOrigin = pEntity.pev.origin;
				
				g_EngineFuncs.MakeVectors( pOwner.pev.v_angle );
				Vector vecSrc = cast< CBasePlayer@ >( pOwner ).GetGunPosition();
				Vector vecAiming = g_Engine.v_forward;
				
				TraceResult trEnd;
				g_Utility.TraceLine( vecSrc, vecSrc + vecAiming * 8192, dont_ignore_monsters, pOwner.edict(), trEnd );
				
				Vector vecResult = trEnd.vecEndPos;
				
				NetworkMessage effect( MSG_BROADCAST, NetworkMessages::SVC_TEMPENTITY );
				effect.WriteByte( TE_SPRITE );
				effect.WriteCoord( vecResult.x );
				effect.WriteCoord( vecResult.y );
				effect.WriteCoord( vecResult.z );
				effect.WriteShort( ls_dot );
				effect.WriteByte( 10 );
				effect.WriteByte( 255 );
				effect.End();
				
				Vector vecUOrigin = g_vecZero;
				vecUOrigin.x = vecOrigin.x;
				vecUOrigin.y = vecOrigin.y;
				vecUOrigin.z = vecOrigin.z;
				
				Vector vecVelocity = g_vecZero;
				vecVelocity.x = vecResult.x - vecUOrigin.x;
				vecVelocity.y = vecResult.y - vecUOrigin.y;
				vecVelocity.z = vecResult.z - vecUOrigin.z;
				
				float length = sqrt( vecVelocity.x * vecVelocity.x + vecVelocity.y * vecVelocity.y + vecVelocity.z * vecVelocity.z );
				vecVelocity.x = vecVelocity.x * 1000 / length;
				vecVelocity.y = vecVelocity.y * 1000 / length;
				vecVelocity.z = vecVelocity.z * 1000 / length;
				
				pEntity.pev.velocity = vecVelocity;
				
				g_Scheduler.SetTimeout( "fireworks_think", 0.1, index );
			}
			else if ( pEntity.pev.targetname == "firework_rv" )
			{
				g_EngineFuncs.SetView( pOwner.edict(), pEntity.edict() );
				
				Vector vecVelocity = g_vecZero;
				
				g_EngineFuncs.MakeVectors( pOwner.pev.v_angle );
				vecVelocity = g_Engine.v_forward * 750;
				pEntity.pev.velocity = vecVelocity;
				
				Vector vecAngles = pOwner.pev.v_angle;
				pEntity.pev.angles = vecAngles;
				
				g_Scheduler.SetTimeout( "fireworks_think", 0.01, index );
			}
			
			// Check touch
			TraceResult tr;
			g_Utility.TraceHull( pOwner.pev.origin, pEntity.pev.origin, dont_ignore_monsters, head_hull, pOwner.edict(), tr );
			if ( tr.flFraction < 1.0 )
			{
				fireworks_touch( index );
			}
		}
	}
}

void fireworks_touch( const int& in index )
{
	CBaseEntity@ pEntity = g_EntityFuncs.Instance( index );
	if ( pEntity !is null )
	{
		Vector vecOrigin = pEntity.pev.origin;
		
		uint8 r = pEntity.pev.iuser2;
		uint8 g = pEntity.pev.iuser3;
		uint8 b = pEntity.pev.iuser4;
		
		if ( pEntity.pev.targetname == "firework_normal" )
		{
			explode( index );
			g_EntityFuncs.Remove( pEntity );
		}
		else if ( pEntity.pev.targetname == "firework_rc" )
		{
			edict_t@ pOwner = pEntity.pev.owner;
			g_EngineFuncs.SetView( pOwner, pOwner );
			
			explode( index );
			g_EntityFuncs.Remove( pEntity );
		}
		else if ( pEntity.pev.targetname == "firework_rv" )
		{
			edict_t@ pOwner = pEntity.pev.owner;
			g_EngineFuncs.SetView( pOwner, pOwner );
			
			explode( index );
			g_EntityFuncs.Remove( pEntity );
		}
		
		touch_effect( vecOrigin, r, g, b );
	}
}

void touch_effect( const Vector& in vecOrigin, const uint8& in r, const uint8& in g, const uint8& in b )
{
	// blast circles
	Vector effectOrigin = vecOrigin;
	
	NetworkMessage effect1( MSG_PAS, NetworkMessages::SVC_TEMPENTITY, effectOrigin );
	effect1.WriteByte( TE_BEAMCYLINDER );
	effect1.WriteCoord( effectOrigin.x );
	effect1.WriteCoord( effectOrigin.y );
	effect1.WriteCoord( effectOrigin.z + 16 );
	effect1.WriteCoord( effectOrigin.x );
	effect1.WriteCoord( effectOrigin.y );
	effect1.WriteCoord( effectOrigin.z + 16 + 348 ); // reach damage radius over .3 seconds
	effect1.WriteShort( shockwave );
	effect1.WriteByte( 0 ); // startframe
	effect1.WriteByte( 0 ); // framerate
	effect1.WriteByte( 3 ); // life
	effect1.WriteByte( 30 ); // width
	effect1.WriteByte( 0 ); // noise
	effect1.WriteByte( r );
	effect1.WriteByte( g );
	effect1.WriteByte( b );
	effect1.WriteByte( 255 ); // brightness
	effect1.WriteByte( 0 ); // speed
	effect1.End();
	
	NetworkMessage effect2( MSG_PAS, NetworkMessages::SVC_TEMPENTITY, effectOrigin );
	effect2.WriteByte( TE_BEAMCYLINDER );
	effect2.WriteCoord( effectOrigin.x );
	effect2.WriteCoord( effectOrigin.y );
	effect2.WriteCoord( effectOrigin.z + 16 );
	effect2.WriteCoord( effectOrigin.x );
	effect2.WriteCoord( effectOrigin.y );
	effect2.WriteCoord( effectOrigin.z + 16 + ( 384 / 2 ) ); // reach damage radius over .3 seconds
	effect2.WriteShort( shockwave );
	effect2.WriteByte( 0 ); // startframe
	effect2.WriteByte( 0 ); // framerate
	effect2.WriteByte( 3 ); // life
	effect2.WriteByte( 30 ); // width
	effect2.WriteByte( 0 ); // noise
	effect2.WriteByte( 256 - r );
	effect2.WriteByte( 256 - g );
	effect2.WriteByte( 256 - b );
	effect2.WriteByte( 255 ); // brightness
	effect2.WriteByte( 0 ); // speed
	effect2.End();
}

// Explode Function
void explode( const int& in index )
{
	CBaseEntity@ pEntity = g_EntityFuncs.Instance( index );
	if ( pEntity !is null )
	{
		Vector vecOrigin = pEntity.pev.origin;
		
		CBaseEntity@ pOwner = g_EntityFuncs.Instance( pEntity.pev.owner );
		iFireworks[ pOwner.entindex() ]--;
		
		uint8 r = pEntity.pev.iuser2;
		uint8 g = pEntity.pev.iuser3;
		uint8 b = pEntity.pev.iuser4;
		
		// WELCOME TO NETWORKMESSAGE HELL
		NetworkMessage effect1( MSG_BROADCAST, NetworkMessages::SVC_TEMPENTITY );
		effect1.WriteByte( TE_BEAMDISK );
		effect1.WriteCoord( vecOrigin.x ); // center position
		effect1.WriteCoord( vecOrigin.y );
		effect1.WriteCoord( vecOrigin.z );
		effect1.WriteCoord( 0 );
		effect1.WriteCoord( 0 );
		effect1.WriteCoord( 100 ); // axis and radius
		switch( Math.RandomLong( 0, 1 ) ) // sprite index
		{
			case 0: effect1.WriteShort( sprFlare6 ); break;
			case 1: effect1.WriteShort( sprLightning ); break;
		}
		effect1.WriteByte( 0 ); // starting frame
		effect1.WriteByte( 0 ); // frame rate in 0.1's
		effect1.WriteByte( 50 ); // life in 0.1's
		effect1.WriteByte( 0 ); // line width in 0.1's
		effect1.WriteByte( 150 ); // noise amplitude in 0.1's
		effect1.WriteByte( r ); // color
		effect1.WriteByte( g );
		effect1.WriteByte( b );
		effect1.WriteByte( 255 ); // brightness
		effect1.WriteByte( 0 ); // scroll speed in 0.1's
		effect1.End();
		
		NetworkMessage effect2( MSG_BROADCAST, NetworkMessages::SVC_TEMPENTITY );
		effect2.WriteByte( TE_SPRITETRAIL );
		effect2.WriteCoord( vecOrigin.x ); // start
		effect2.WriteCoord( vecOrigin.y );
		effect2.WriteCoord( vecOrigin.z - 20 );
		effect2.WriteCoord( vecOrigin.x ); // end
		effect2.WriteCoord( vecOrigin.y );
		effect2.WriteCoord( vecOrigin.z + 20 );
		if ( ( r > 128 ) && ( g < 127 ) && ( b < 127 ) ) effect2.WriteShort( sprRflare );
		else if ( ( r < 127 ) && ( g > 128 ) && ( b < 127 ) ) effect2.WriteShort( sprGflare );
		else if ( ( r < 127 ) && ( g < 127 ) && ( b > 128 ) ) effect2.WriteShort( sprBflare );
		else if ( ( r < 127 ) && ( g > 128 ) && ( b > 128 ) ) effect2.WriteShort( sprTflare );
		else if ( ( r > 128 ) && ( g < 127 ) && ( b < 200 ) && ( b > 100 ) ) effect2.WriteShort( sprPflare );
		else if ( ( r > 128 ) && ( g > 128 ) && ( b < 127 ) ) effect2.WriteShort( sprYflare );
		else if ( ( r > 128 ) && ( g > 100 ) && ( g < 200 ) && ( b < 127 ) )effect2.WriteShort( sprOflare );
		else effect2.WriteShort( sprBflare );
		effect2.WriteByte( 1 ); // count
		effect2.WriteByte( 2 ); // life in 0.1's
		effect2.WriteByte( 5 ); // scale in 0.1's
		effect2.WriteByte( Math.RandomLong( 40, 100 ) ); // velocity along vector in 10's
		effect2.WriteByte( 40 ); // randomness of velocity in 10's
		effect2.End();
		
		NetworkMessage effect3( MSG_BROADCAST, NetworkMessages::SVC_TEMPENTITY );
		effect3.WriteByte( TE_SPRITETRAIL );
		effect3.WriteCoord( vecOrigin.x ); // start
		effect3.WriteCoord( vecOrigin.y );
		effect3.WriteCoord( vecOrigin.z );
		effect3.WriteCoord( vecOrigin.x ); // end
		effect3.WriteCoord( vecOrigin.y );
		effect3.WriteCoord( vecOrigin.z - 80 );
		switch( Math.RandomLong( 0, 3 ) ) // sprite index
		{
			case 0: effect3.WriteShort( flare3 ); break;
			case 1: effect3.WriteShort( sprBflare ); break;
			case 2: effect3.WriteShort( sprFlare6 ); break;
			case 3: effect3.WriteShort( sprRflare ); break;
		}
		effect3.WriteByte( 50 ); // count
		effect3.WriteByte( Math.RandomLong( 1, 3 ) ); // life in 0.1's
		effect3.WriteByte( 10 ); // scale in 0.1's
		effect3.WriteByte( Math.RandomLong( 30, 70 ) ); // velocity along vector in 10's
		effect3.WriteByte( 40 ); // randomness of velocity in 10's
		effect3.End();
		
		NetworkMessage effect4( MSG_BROADCAST, NetworkMessages::SVC_TEMPENTITY );
		effect4.WriteByte( TE_BEAMPOINTS );
		effect4.WriteCoord( vecOrigin.x ); // start
		effect4.WriteCoord( vecOrigin.y );
		effect4.WriteCoord( vecOrigin.z - 50);
		effect4.WriteCoord( vecOrigin.x ); // end
		effect4.WriteCoord( vecOrigin.y );
		effect4.WriteCoord( vecOrigin.z - 2000 );
		effect4.WriteShort( sprLightning );
		effect4.WriteByte( 1 ); // framestart 
		effect4.WriteByte( 5 ); // framerate 
		effect4.WriteByte( 3 ); // life 
		effect4.WriteByte( 150 ); // width 
		effect4.WriteByte( 30 ); // noise 
		effect4.WriteByte( 200 ); // r, g, b 
		effect4.WriteByte( 200 ); // r, g, b 
		effect4.WriteByte( 200 ); // r, g, b 
		effect4.WriteByte( 200 ); // brightness 
		effect4.WriteByte( 100 ); // speed 
		effect4.End();
		
		NetworkMessage effect5( MSG_PVS, NetworkMessages::SVC_TEMPENTITY );
		effect5.WriteByte( TE_SPARKS );
		effect5.WriteCoord( vecOrigin.x ); // location
		effect5.WriteCoord( vecOrigin.y );
		effect5.WriteCoord( vecOrigin.z - 1000 );
		effect5.End();
		
		NetworkMessage effect6( MSG_BROADCAST, NetworkMessages::SVC_TEMPENTITY );
		effect6.WriteByte( TE_DLIGHT );
		effect6.WriteCoord( vecOrigin.x ); // location
		effect6.WriteCoord( vecOrigin.y );
		effect6.WriteCoord( vecOrigin.z );
		effect6.WriteByte( 60 ); // radius in 10's
		effect6.WriteByte( r ); // color
		effect6.WriteByte( g );
		effect6.WriteByte( b );
		effect6.WriteByte( 100 ); // life in 10's
		effect6.WriteByte( 15 ); // decay rate in 10's
		effect6.End();
		
		NetworkMessage effect7( MSG_BROADCAST, NetworkMessages::SVC_TEMPENTITY );
		effect7.WriteByte( TE_LARGEFUNNEL );
		effect7.WriteCoord( vecOrigin.x ); // location
		effect7.WriteCoord( vecOrigin.y );
		effect7.WriteCoord( vecOrigin.z - 64 );
		effect7.WriteShort( sprFlare6 );
		effect7.WriteShort( 1 );
		effect7.End();
		
		NetworkMessage effect8( MSG_BROADCAST, NetworkMessages::SVC_TEMPENTITY );
		effect8.WriteByte( TE_BEAMDISK );
		effect8.WriteCoord( vecOrigin.x ); // center position
		effect8.WriteCoord( vecOrigin.y );
		effect8.WriteCoord( vecOrigin.z );
		effect8.WriteCoord( vecOrigin.x ); // axis and radius
		effect8.WriteCoord( vecOrigin.y );
		effect8.WriteCoord( vecOrigin.z + Math.RandomLong( 250, 750 ) );
		switch( Math.RandomLong( 0, 1 ) )
		{
			case 0: effect8.WriteShort( sprFlare6 ); break;
			case 1: effect8.WriteShort( sprLightning ); break;
		}
		effect8.WriteByte( 0 ); // starting frame
		effect8.WriteByte( 0 ); // frame rate in 0.1's
		effect8.WriteByte( 25 ); // life in 0.1's
		effect8.WriteByte( 150 ); // line width in 0.1's
		effect8.WriteByte( 0 ); // noise amplitude in 0.01's
		effect8.WriteByte( r ); // color
		effect8.WriteByte( g );
		effect8.WriteByte( b );
		effect8.WriteByte( 255 ); // brightness
		effect8.WriteByte( 0 ); // scroll speed in 0.1's
		effect8.End();
		// HELL's END
		
		g_SoundSystem.EmitSoundDyn( pEntity.edict(), CHAN_VOICE, "weapons/mortarhit.wav", VOL_NORM, ATTN_NONE, 0, PITCH_NORM );
	}
}
