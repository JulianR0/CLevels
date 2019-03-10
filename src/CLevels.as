/*
	CLevels (Imperium Sven Co-op's SCXPM): Main Script
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

const string version = "v2.37";
const string lastupdate = "22 de Febrero de 2019";

const string PATH_MAIN_DATA = "scripts/plugins/store/scxpm_data/";
const string PATH_PERMAINCREASE_DATA = "scripts/plugins/store/scxpm_permaincrease/";
const string PATH_ACHIEVEMENT_DATA = "scripts/plugins/store/scxpm_achievement/";
const string PATH_EVENT_DATA = "scripts/plugins/store/scxpm_event/";
const string PATH_POST_DATA = "scripts/plugins/store/scxpm_post/";
const string PATH_BACKUP_DATA = "scripts/plugins/store/scxpm_backup/";
const string PATH_LOGS = "scripts/plugins/store/scxpm_logs/";
const string PATH_MAPS = "scripts/plugins/";

const int HUD_EXP = 1;
const int HUD_EXPLEFT = 2;
const int HUD_EXPEARN = 4;
const int HUD_LEVEL = 8;
const int HUD_CLASS = 16;
const int HUD_MEDALS = 32;
const int HKEY_NOTICED = 64;
const int SS_DISPENCER = 128;
const int DR_MAXGET = 256;
const int SS_RANGEHEAL = 512;

const float EASY_BASEXP = 1.00;
const float NORMAL_BASEXP = 0.55;
const float HARD_BASEXP = 0.35;
const float EVENT_EXTRAPERCENT = 100.00;
float MAP_XPGAIN = 1.00;

const array< string > ranks =
{
	"Jugador Nuevo",
	"Principiante",
	"Vagabundo",
	"Recluta",
	"Rebelde",
	"Resistencia",
	"Estudiante",
	"Cientifico Armado",
	"Guardia de Seguridad",
	"Boina Verde",
	"General",
	"Apasionante de las armas",
	"Cazador de Alienigenas",
	"Gordon Freeman",
	"Bio-Arma de Black Mesa",
	"Quimera experimental",
	"Robot Destructor",
	"Estratega",
	"M.I.A. Solokiller",
	"Purificador",
	"Gonome Hunter",
	"Cabo Shephard",
	"Comando Negro",
	"Division X",
	"Conquistador",
	"Miembro Honorable",
	"Dios de Guerra",
	"Suicida",
	"Terapeuta",
	"Protector",
	"Xeniano",
	"Cazarrecompensas",
	"Agente",
	"G-Man",
	"Profesional",
	"Asesino",
	"Jugador de Elite",
	"Jumper",
	"Coronel Sanders",
	"Veterano",
	"Perfeccionista",
	"El 42",
	"Orden Spiral",
	"Orden Crimson",
	"Guardian de Cradle",
	"Payaso Explosivo",
	"Hibrido de Raza-X",
	"Cronista",
	"Burlador de la Muerte",
	"Anarquista",
	"As de los mapas",
	"Enlazador multiversal",
	"Fortificador Artificial",
	"Transformador de Mundos",
	"Legado de la Creacion",
	"Leggendaria",
	"Defensor Ancestral",
	"Sven Viking",
	"El Elegido",
	"Maestro Imperial",
	"Gran Maestro Imperial",
	"Campeon Imperial",
	"EL CONIO DE TU MADRE"
};

const array< string > szAchievementNames =
{
	"Esperando la carroza",
	"Tu cara no me asusta",
	"Apunta mejor!",
	"Los 5 minutos son 5",
	"Es todo lo que tienes?",
	"Duke Nukem",
	"Seria una lastima",
	"Una batalla dificil",
	"La asistencia es inutil",
	"Chubby de bronce",
	"Chubby de plata",
	"Mis armas alcanzan",
	"Chubby de oro",
	"Un Chubby sin secretos",
	"Vaya punto debil",
	"Primero muerto!",
	"Segundo mueres!",
	"Fast Gausser",
	"Trepando todo el dia",
	"Hecho en Quake",
	"Ser devorado aburre",
	"Un empleado mas",
	"Graficos HD y 3D",
	"Cuadrangular!",
	"Svenmessa",
	"Nunca? Siempre",
	"Que sea un empate",
	"Sniper a la matrix",
	"Si fuese asi de facil",
	"Quien necesita balas?",
	"Nagoya",
	"Cara vs Cara",
	"Alien Uncontroller",
	"Electricista Infernal",
	"Licenciatura en Gonomes",
	"No quiero mas problemas",
	"Soy Leyenda",
	"Me importa",
	"Avioneta de Papel",
	"Escuadron Express",
	"Buscate otra victima!",
	"Delicioso!",
	"CazaFantasmas",
	"No Lifer? Mentira",
	"No sin mi headcrab!",
	"Un intento de pelicula",
	"Pelicula de clase B",
	"Proteccion Perfecta",
	"Una buena pelicula",
	"ninjas pls",
	"Has oido hablar de los Yakuza?",
	"Miembro de la S.A.C.",
	"Tareas de rutina",
	"Zombiely Fire",
	"Apache? Yo no vi nada",
	"S.A.C. Elite",
	"Alto voltaje",
	"Desafiando a la muerte",
	"Yo tambien puedo ayudar!",
	"Estoy expuesto",
	"INMORTAL",
	"Expert Gausser",
	"Sniper? Eso se come?",
	"Error 404",
	"Detras de la puerta",
	"Estado de Shock",
	"Saltos de fe",
	"Hace frio ahi afuera",
	"Domando al agresivo",
	"Deja de bugearte carajo!",
	"Ni el infierno puede detenerme!",
	"Oscuridad! Mi viejo amigo",
	"Respetando los clasicos",
	"El mas minimo detalle",
	"Perdi 20 minutos en esto?",
	"Plataforma 2.5D",
	"La bodega injusta",
	"Sobre mi cadaver!",
	"LAS MALDITAS TEXTURAS!",
	"Aprobado por Ema",
	"Zero elevado a la Cero",
	"Crisis Existencial",
	"Strike-Counter",
	"A cuerda",
	"JOHN CENA",
	"Fuga de Escondidas",
	"esTORpeado",
	"Carnada Explosiva",
	"Algo de sentido",
	"Seamos puntuales",
	"Humano o Alien?",
	"Destruccion de determinacion",
	"Team Fortress",
	"Mi caballo es asombroso",
	"Primera linea",
	"Descolapsar",
	"Perdiendo el tiempo",
	"Creo que lo rompi",
	"Sayonara",
	"Anti-Creacionista",
	"Trampas para tarados",
	"Curando el apocalipsis",
	"No a la Inflacion",
	"Asesinos de segunda",
	"Cazador 3.0",
	"Baile Interplanetario",
	"Persistencia oculta",
	"Terrible equipo",
	"Carameloraro",
	"Guerra Infernal",
	"Feliz navidad",
	"Grande de la Vieja Escuela",
	"Sinfonia HalfQuake",
	"Francotirador",
	"Ofensiva Defensiva",
	"Precision Quadratica",
	"Distorcion Quadratica",
	"Dado vuelta",
	"Defensa Impenetable",
	"Sobreviviente del mas alla",
	"Saltos bipolares",
	"Pajaro sin alas",
	"Escaleras del diablo",
	"Laberinto neutral",
	"Memoria fotografica",
	"Desesperacion",
	"Tome un cafe (o dos, o tres)",
	"Base 420",
	"El fin de Andrea",
	"Half-Mario sin Mario",
	"Kamikaze Planet",
	"Cerveza a la Meme",
	"Anno Domini",
	"Y asi comienza",
	"Trabajo Insoportable",
	"Menos tedioso, vale?",
	"Tumba de la INmuerte",
	"ESTOY AL PEDO, OKAY?!",
	"Fuera de Servicio",
	"accidente de dross numero GTA 5.16",
	"Me tire por la ventana...",
	"Yoshi's Island",
	"Fashionable Mecha",
	"Cuerpo de Guerra",
	"Banio Privado",
	"Asalto Asaltado",
	"quadrazid",
	"Svencraft",
	"Vacio del terror",
	"Baile del cuadradro",
	"La nueva fortaleza",
	"Playa falsa",
	"Violacion de Copyright",
	"RUSHER CAPITALISTA",
	"Caja de la victoria",
	"NeoDiferencias",
	"Obligado a Discriminar",
	"Ah? Tenia que morir?",
	"hhhhhhhhhhhhhhh",
	"Canto Mortal",
	"ME DUELE EL TECLADO",
	"Memorias del pasado",
	"Limpieza Infantil",
	"Examen Complementario",
	"Luz Privatizada",
	"Ticket de Pelicula",
	"Escuadron Suicida",
	"Cuidado con Sandra",
	"Busqueda Implacable"
};

array< int > xp( 33 );
array< int > xp_e( 33 );
array< int > xp_h( 33 );
array< int > neededxp( 33 );
array< int > earnedxp( 33 );
array< int > playerlevel( 33 );
array< int > rank( 33 );
array< int > skillpoints( 33 );
array< int > specialpoints( 33 );
array< int > medals( 33 );
array< int > medals_h( 33 );
array< int > sparks( 33 );
array< int > mode( 33 );
array< int > hkey( 33 );
array< int > bWasDead( 33 );
array< int > bData( 33 );
array< int > expamp( 33 );
array< DateTime > expamptime( 33 );
array< DateTime > firstplay( 33 );
array< DateTime > nextdaily( 33 );
array< int > dailyget( 33 );
array< float > permaincrease( 33 );
array< array< bool >> aData( 33, array< bool > ( szAchievementNames.length() ) );
array< array< bool >> aClaim( 33, array< bool > ( szAchievementNames.length() ) );
array< int > bHasMGAccess( 33 );
array< bool > bCorruptData( 33 );

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
array< int > freefall( 33 );
array< int > demoman( 33 );
array< int > practiceshot( 33 );
array< int > bioelectric( 33 );
array< int > redcross( 33 );
array< bool > be_once( 33 );

array< int > xp_p( 33 );
array< int > medals_p( 33 );
array< int > sparks_p( 33 );
array< int > startlevel_p( 33 );
array< int > maxlevel_p( 33 );
array< int > startmedals_p( 33 );
array< int > maxmedals_p( 33 );
array< float > xpgain_p( 33 );
array< int > health_max_p( 33 );
array< int > armor_max_p( 33 );
array< int > rhealth_max_p( 33 );
array< int > rarmor_max_p( 33 );
array< int > rammo_max_p( 33 );
array< int > gravity_max_p( 33 );
array< int > speed_max_p( 33 );
array< int > dist_max_p( 33 );
array< int > dodge_max_p( 33 );
array< int > spawndmg_max_p( 33 );
array< int > ubercharge_max_p( 33 );
array< int > freefall_max_p( 33 );
array< int > demoman_max_p( 33 );
array< int > practiceshot_max_p( 33 );
array< int > bioelectric_max_p( 33 );
array< int > redcross_max_p( 33 );

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
array< bool > poisoned( 33 );

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
float starthealth = 100.0;
float startarmor = 100.0;
array< int > skillIncrement( 33 );
array< float > lastfrags( 33 );
array< int > lastDeadflag( 33 );
array< bool > loaddata( 33 );
array< bool > bChangeHard( 33 );
array< int > iIndexInspect( 33 );
array< bool > bIsSpectating( 33 );
array< bool > bSparkReward( 33 );

bool gDisabled;
bool gNoEvent;
bool gHardIgnore;
bool gNoAchievements;
bool gSingleAchievement;
int iAAllowed;
bool gNoSkills;
bool gDelayedXP;
bool gNoSpectate;
bool onecount;
bool event_active;
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
	g_Hooks.RegisterHook( Hooks::Player::PlayerTakeDamage, @PlayerTakeDamage ); // Miscellaneous utilities: Special Skills & Hard Mode
	g_Hooks.RegisterHook( Hooks::Weapon::WeaponPrimaryAttack, @WeaponPrimaryAttack ); // Practice Shot special skill
	g_Hooks.RegisterHook( Hooks::Weapon::WeaponTertiaryAttack, @WeaponTertiaryAttack ); // Medical Emergency special skill
	
	g_Scheduler.SetInterval( "scxpm_sdac", 0.5, g_Scheduler.REPEAT_INFINITE_TIMES );
	g_Scheduler.SetInterval( "scxpm_amptask", 60.0, g_Scheduler.REPEAT_INFINITE_TIMES );
	g_Scheduler.SetInterval( "scxpm_checkevent", 200.0, g_Scheduler.REPEAT_INFINITE_TIMES );
	g_Scheduler.SetInterval( "spectate_fix", 0.1, g_Scheduler.REPEAT_INFINITE_TIMES );
}

void MapInit()
{
	// Precache now all SCXPM sounds
	g_Game.PrecacheGeneric( "sound/ecsc/scxpm/levelup.ogg" ); // These needs to be downloaded first
	g_Game.PrecacheGeneric( "sound/ecsc/scxpm/medalget.ogg" );
	g_Game.PrecacheGeneric( "sound/ecsc/scxpm/hardunlock.ogg" );
	g_SoundSystem.PrecacheSound( "ecsc/scxpm/levelup.ogg" ); // Level up
	g_SoundSystem.PrecacheSound( "ecsc/scxpm/medalget.ogg" ); // Medal get
	g_SoundSystem.PrecacheSound( "ecsc/scxpm/hardunlock.ogg" ); // Hard mode activated for the first time
	g_SoundSystem.PrecacheSound( "items/gunpickup2.wav" ); // Spark "buy" sound
	g_SoundSystem.PrecacheSound( "adamr/blipblipblip.wav" ); // Sound notice for player in case of "Level down" and "Medal lost"
	g_SoundSystem.PrecacheSound( "ambience/goal_1.wav" ); // 100% mode clear
	
	// Register (and precache) now all auxiliary entities
	g_Game.PrecacheModel( "sprites/null.spr" );
	g_Game.PrecacheModel( "models/w_medkit.mdl" );
	g_CustomEntityFuncs.RegisterCustomEntity( "CFlyingMedkit", "scxpm_medkit_dart" );
	g_CustomEntityFuncs.RegisterCustomEntity( "CDelayedXP", "scxpm_give_xp" );
	
	gDisabled = false;
	gNoEvent = false;
	gHardIgnore = false;
	gNoAchievements = false;
	gSingleAchievement = false;
	iAAllowed = 0;
	gNoSkills = false;
	gDelayedXP = false;
	gNoSpectate = false;
	onecount = false;
	can_edit_handicaps = true;
	bSaveOldSkills = false;
	event_active = false;
	for ( int i = 0; i < 33; i++ )
	{
		earnedxp[ i ] = 0.0;
		permaincrease[ i ] = 0.0;
		bWasDead[ i ] = 0;
		loaddata[ i ] = false;
		be_once[ i ] = false;
		poisoned[ i ] = false;
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
		bChangeHard[ i ] = false;
		iIndexInspect[ i ] = 0;
		bHasMGAccess[ i ] = 0;
		bIsSpectating[ i ] = false;
		bSparkReward[ i ] = false;
		bCorruptData[ i ] = false;
		
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
	
	string fullpath = "" + PATH_MAPS + "scxpm_mapsettings.ini";
	File@ thefile = g_FileSystem.OpenFile( fullpath, OpenFile::READ );
	if ( thefile !is null && thefile.IsOpen() )
	{
		string mapname = string( g_Engine.mapname );
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
					break;
				}
				else
				{
					for ( uint i = 0; i < pre_mode.length(); i++ )
					{
						if ( pre_mode[ i ] == 'NO_EVENT' )
							gNoEvent = true;
						else if ( pre_mode[ i ] == 'HARD_IGNORE' )
							gHardIgnore = true;
						else if ( pre_mode[ i ] == 'NO_ACHIEVEMENTS' )
							gNoAchievements = true;
						else if ( pre_mode[ i ] == 'SINGLE_ACHIEVEMENT' )
							gSingleAchievement = true;
						else if ( pre_mode[ i ] == 'NO_SKILLS' )
							gNoSkills = true;
						else if ( pre_mode[ i ] == 'DELAYED_XP' )
							gDelayedXP = true;
						else if ( pre_mode[ i ] == 'NO_SPECTATE' )
							gNoSpectate = true;
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
	xp_e[ index ] = 0.0;
	xp_h[ index ] = 0.0;
	neededxp[ index ] = 0.0;
	earnedxp[ index ] = 0.0;
	playerlevel[ index ] = 0;
	skillpoints[ index ] = 0;
	medals[ index ] = 0;
	medals_h[ index ] = 0;
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
	freefall[ index ] = 0;
	demoman[ index ] = 0;
	practiceshot[ index ] = 0;
	bioelectric[ index ] = 0;
	redcross[ index ] = 0;
	be_once[ index ] = false;
	hkey[ index ] = 0;
	sparks[ index ] = 0;
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
	poisoned[ index ] = false;
	rarmorwait[ index ] = 0.0;
	rhealthwait[ index ] = 0.0;
	rammowait[ index ] = 0.0;
	rank[ index ] = 0;
	mode[ index ] = 0;
	bWasDead[ index ] = 0;
	iIndexInspect[ index ] = 0;
	bHasMGAccess[ index ] = 0;
	bCorruptData[ index ] = false;
	bIsSpectating[ index ] = false;
	bSparkReward[ index ] = false;
	xp_p[ index ] = 0;
	medals_p[ index ] = 0;
	sparks_p[ index ] = 0;
	startlevel_p[ index ] = 0;
	maxlevel_p[ index ] = 0;
	startmedals_p[ index ] = 0;
	maxmedals_p[ index ] = 0;
	xpgain_p[ index ] = 0.0;
	health_max_p[ index ] = 0;
	armor_max_p[ index ] = 0;
	rhealth_max_p[ index ] = 0;
	rarmor_max_p[ index ] = 0;
	rammo_max_p[ index ] = 0;
	gravity_max_p[ index ] = 0;
	speed_max_p[ index ] = 0;
	dist_max_p[ index ] = 0;
	dodge_max_p[ index ] = 0;
	spawndmg_max_p[ index ] = 0;
	ubercharge_max_p[ index ] = 0;
	freefall_max_p[ index ] = 0;
	demoman_max_p[ index ] = 0;
	practiceshot_max_p[ index ] = 0;
	bioelectric_max_p[ index ] = 0;
	redcross_max_p[ index ] = 0;
	
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
		else if ( text == '/resetmedals' )
		{
			scxpm_medaltolvl( pPlayer.entindex() );
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
		else if ( text == '/mode' )
		{
			scxpm_mode( pPlayer.entindex() );
			return HOOK_HANDLED;
		}
		else if ( text == '/supplies' )
		{
			scxpm_buysparks( pPlayer.entindex() );
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
		else if ( text == '/events' )
		{
			scxpm_events( pPlayer.entindex() );
			return HOOK_HANDLED;
		}
		else if ( text == '/data' )
		{
			scxpm_datamanager( pPlayer.entindex() );
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
			if ( args[ 0 ] == '/hard' )
			{
				HardUnlock( pParams );
				return HOOK_HANDLED;
			}
			else if ( args[ 0 ] == '/hudcolor' )
			{
				scxpm_set_hudcustom( pParams );
				return HOOK_HANDLED;
			}
			else if ( args[ 0 ] == '/inspect' )
			{
				scxpm_inspect_main( pParams );
				return HOOK_HANDLED;
			}
			else if ( args[ 0 ] == '/mystery' )
			{
				MysteryGift_CheckUnlock( pParams );
				return HOOK_HANDLED;
			}
			else
				pParams.ShouldHide = false;
		}
	}
	
	return HOOK_CONTINUE;
}

void HardUnlock( SayParameters@ pParams )
{
	pParams.ShouldHide = true;
	
	CBasePlayer@ pPlayer = pParams.GetPlayer();
	int index = pPlayer.entindex();
	
	if ( hkey[ index ] == 0 )
		return;
	
	const CCommand@ args = pParams.GetArguments();
	
	if ( args.ArgC() > 0 )
	{
		if ( args[ 1 ] == string( hkey[ index ] ) )
		{
			mode[ index ] = 3;
			hkey[ index ] = 0;
			
			g_SoundSystem.EmitSoundDyn( pPlayer.edict(), CHAN_STATIC, "ecsc/scxpm/hardunlock.ogg", VOL_NORM, ATTN_NONE, SND_SKIP_ORIGIN_USE_ENT, PITCH_NORM, index );
			g_PlayerFuncs.ClientPrintAll( HUD_PRINTTALK, "[SCXPM] " + pPlayer.pev.netname + " ha activado el Modo Dificil!\n" );
			g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTCENTER, "MODO DIFICIL ACTIVADO\n" );
			
			uint16 f_duration;
			uint16 f_hold;
			uint16 f_fadetype;
			uint8 r;
			uint8 g;
			uint8 b;
			uint8 a;
			
			f_duration = 2048;
			f_hold = 4096;
			f_fadetype = 0;
			r = 250;
			g = 10;
			b = 10;
			a = 250;
			
			NetworkMessage fade( MSG_ONE_UNRELIABLE, NetworkMessages::ScreenFade, pPlayer.edict() );
			fade.WriteShort( f_duration ); // Duration
			fade.WriteShort( f_hold ); // Hold
			fade.WriteShort( f_fadetype ); // Fade Type
			fade.WriteByte( r ); // R
			fade.WriteByte( g ); // G
			fade.WriteByte( b ); // B
			fade.WriteByte( a ); // Alpha
			fade.End();
			
			uint16 s_amplitude;
			uint16 s_duration;
			uint16 s_frequency;
			
			s_amplitude = 20480;
			s_duration = 18432;
			s_frequency = 40960;
			
			NetworkMessage shake( MSG_ONE_UNRELIABLE, NetworkMessages::ScreenShake, pPlayer.edict() );
			shake.WriteShort( s_amplitude ); // Amplitude
			shake.WriteShort( s_duration ); // Duration
			shake.WriteShort( s_frequency ); // Frequency
			shake.End();
			
			playerlevel[ index ] = scxpm_calc_lvl( xp_h[ index ] );
			scxpm_calcneedxp( index );
			scxpm_getrank( index );
			earnedxp[ index ] = 0.0;
			g_Scheduler.SetTimeout( "scxpm_mreset", 0.75, index );
			pPlayer.pev.flags &= ~FL_GODMODE;
			pPlayer.TakeDamage( pPlayer.pev, pPlayer.pev, 10000.0, DMG_GENERIC );
			pPlayer.pev.frags = pPlayer.pev.frags + 1.0;
			
			g_Scheduler.SetTimeout( "scxpm_hard_welcome", 1.00, index );
		}
	}
}

void MysteryGift_CheckUnlock( SayParameters@ pParams )
{
	pParams.ShouldHide = true;
	
	CBasePlayer@ pPlayer = pParams.GetPlayer();
	int index = pPlayer.entindex();
	
	CustomKeyvalues@ pKVD = pPlayer.GetCustomKeyvalues();
	
	CustomKeyvalue iMGUnlock_pre( pKVD.GetKeyvalue( "$i_mg_can_unlock" ) );
	CustomKeyvalue iMGLetters_pre( pKVD.GetKeyvalue( "$i_mg_letters" ) );
	
	int iMGUnlock = iMGUnlock_pre.GetInteger();
	int iMGLetters = iMGLetters_pre.GetInteger();
	
	const CCommand@ args = pParams.GetArguments();
	if ( args.ArgC() == 5 )
	{
		string szCheck1 = args[ 1 ].ToUppercase();
		string szCheck2 = args[ 2 ].ToUppercase();
		string szCheck3 = args[ 3 ].ToUppercase();
		string szCheck4 = args[ 4 ].ToUppercase();
		
		if ( szCheck1 == 'CONEXION' && szCheck2 == 'ISC' && szCheck3 == 'TODOS' && szCheck4 == 'FELICES' )
		{
			if ( bHasMGAccess[ index ] == 0 )
			{
				if ( iMGLetters >= 2 )
				{
					if ( iMGUnlock == 1 )
					{
						g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "[SCXPM] Ah? Parece que tienes algo entre manos\n" );
						g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "[SCXPM] Cual es la ultima palabra para completar el misterio?\n" );
						g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "[SCXPM] Pistas para ayudarte: Que esperas desbloquear con el comando? | Cuatro letras, empieza con \"G\"\n" );
						
						pKVD.SetKeyvalue( "$i_mg_can_unlock", 2 );
					}
				}
				else
				{
					g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "[SCXPM] Saber la frase de antemano no te ayudara, amigo!\n" );
					g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "[SCXPM] Completa el puzzle secreto para desbloquear esto\n" );
				}
			}
			else
				g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "[SCXPM] No hay necesidad! Ya tienes tu Mystery Gift\n" );
		}
	}
	else if ( args.ArgC() == 3 )
	{
		if ( bHasMGAccess[ index ] == 1 )
		{
			string szCheck1 = args[ 1 ].ToUppercase();
			string szCheck2 = args[ 2 ].ToUppercase();
			
			if ( szCheck1 == 'REDEEM' )
				g_Scheduler.SetTimeout( "MysteryGift_Search", 0.01, index, "SEARCH#REDEEM|" + szCheck2 );
			else if ( szCheck1 == 'PLAYER' )
			{
				bool bDummy = false; // !!! Something is overflowing the buffer, causing bMultiple to be forced to TRUE !!! This dummy here is to let that garbage data to go somewhere else
				bool bMultiple = false;
				CBasePlayer@ pTarget = SCXPM_FindPlayer( szCheck2, bMultiple );
				
				if ( bMultiple )
					g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "[SCXPM] Multiples jugadores encontrados. Se mas especifico\n" );
				else if ( pTarget !is null )
				{
					if ( pTarget is pPlayer )
						g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "[SCXPM] Redimir un regalo hecho por ti mismo? No me hagas reir!\n" );
					else
						g_Scheduler.SetTimeout( "MysteryGift_Search", 0.01, index, "SEARCH#PLAYER|" + g_EngineFuncs.GetPlayerAuthId( pTarget.edict() ) );
				}
				else
					g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "[SCXPM] Imposible redimir regalo: El jugador no esta conectado o no existe\n" );
			}
		}
	}
	else if ( args.ArgC() == 2 )
	{
		string szCheck1 = args[ 1 ].ToUppercase();
		
		if ( szCheck1 == 'GIFT' )
		{
			if ( iMGUnlock == 2 )
			{
				bHasMGAccess[ index ] = 1;
				MysteryGift_Main( index );
				MysteryGift_Welcome( index );
				
				g_PlayerFuncs.ClientPrintAll( HUD_PRINTTALK, "[SCXPM] " + pPlayer.pev.netname + " ha desbloqueado el Mystery Gift!\n" );
				pKVD.SetKeyvalue( "$i_mg_can_unlock", 0 );
			}
		}
	}
	else if ( args.ArgC() == 1 )
	{
		if ( bHasMGAccess[ index ] == 1 )
			MysteryGift_Main( index );
	}
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
			g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "[SCXPM] Multiples jugadores encontrados. Se mas especifico\n" );
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
			
			title += "Nivel alcanzado\n";
			title += " - Modo Facil: " + scxpm_calc_lvl( xp_e[ target_index ] ) + " / 640" + ( mode[ target_index ] == 1 ? " <--\n" : "\n" );
			title += " - Modo Normal: " + scxpm_calc_lvl( xp[ target_index ] ) + " / 565" + ( mode[ target_index ] == 2 ? " <--\n" : "\n" );;
			title += " - Modo Dificil: " + AddCommas( scxpm_calc_lvl( xp_h[ target_index ] ) ) + " / 1,800" + ( mode[ target_index ] == 3 ? " <--\n\n" : "\n\n" );
			
			title += "Medallas adquiridas\n";
			title += " - Modo Normal: " + medals[ target_index ] + " / 42" + ( mode[ target_index ] == 2 ? " <--\n" : "\n" );
			title += " - Modo Dificil: " + medals_h[ target_index ] + " / 42" + ( mode[ target_index ] == 3 ? " <--\n\n" : "\n\n" );
			
			title += "Logros: " + GetAchievementClear( target_index ) + " de " + ( int( szAchievementNames.length() ) - 4 ) + " completados\n";
			title += "Modificadores de EXP:" + ( permaincrease[ target_index ] > 0.0 ? " +" : " " ) + int( permaincrease[ target_index ] ) + "%\n\n";
			
			title += "Empezo a jugar el dia\n";
			title += GetSpanishDate( firstplay[ target_index ] ) + "\n\n";
			title += "Dias consecutivos de juego: " + dailyget[ target_index ] + "\n";
			
			state.menu.SetTitle( title );
			state.menu.AddItem( "Ver Logros", any( "item1" ) );
			state.menu.AddItem( "Ver Modificadores de EXP\n", any( "item2" ) );
			state.menu.AddItem( "Mi personaje", any( "item3" ) );
			
			state.OpenMenu( pPlayer, 0, 0 );
		}
		else
			g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "[SCXPM] Jugador no encontrado\n" );
	}
	else
	{
		g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "[SCXPM] Modo de uso: /inspect <Jugador>\n" );
		g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "[SCXPM] Muestra informacion adicional sobre el jugador especificado\n" );
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
		g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "[SCXPM] Ese comando esta desactivado en este mapa\n" );
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
			
			g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "[SCXPM] Escribe /spectate nuevamente para hacer respawn\n" );
		}
		else
		{
			bIsSpectating[ index ] = false;
			pPlayer.m_flRespawnDelayTime = 0.0;
		}
	}
}

void spectate_fix()
{
	for ( int i = 1; i <= g_Engine.maxClients; i++ )
	{
		CBasePlayer@ pPlayer = g_PlayerFuncs.FindPlayerByIndex( i );
		
		if ( pPlayer !is null && pPlayer.IsConnected() )
		{
			{
				if ( bIsSpectating[ i ] )
					pPlayer.m_flRespawnDelayTime = Math.FLOAT_MAX;
			}
		}
	}
}

void scxpm_checkevent()
{
	if ( gNoEvent || gDisabled )
		return;
	
	DateTime thetime( UnixTimestamp() );
	int hours = thetime.GetHour();
	
	if ( hours >= 0 && hours < 6 && g_PlayerFuncs.GetNumPlayers() >= 4 )
	{
		if ( !event_active )
		{
			event_active = true;
			MAP_XPGAIN = MAP_XPGAIN * ( 100.0 + EVENT_EXTRAPERCENT ) / 100.0;
		}
		g_PlayerFuncs.ClientPrintAll( HUD_PRINTTALK, "[SCXPM] Happy Hours! Disfruta tu instancia con mayor ganancia de EXP!\n" );
	}
	else
	{
		if ( event_active )
		{
			event_active = false;
			MAP_XPGAIN = MAP_XPGAIN * ( 100.0 - EVENT_EXTRAPERCENT ) / 100.0;
		}
	}
}

CClientCommand ADMIN_CMDHELP( "xp_help", " - Muestra esta ayuda sobre como usar los comandos", @scxpm_acmdhelp, ConCommandFlag::AdminOnly );
void scxpm_acmdhelp( const CCommand@ pArgs )
{
	CBasePlayer@ pPlayer = g_ConCommandSystem.GetCurrentPlayer();
	
	g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTCONSOLE, "[SCXPM] Lista de comandos:\n\n" );
	g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTCONSOLE, ".xp_addxp <Nombre> <Valor> - Dar EXP a un jugador\n" );
	g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTCONSOLE, ".xp_removexp <Nombre> <Valor> - Quitar EXP a un jugador\n" );
	g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTCONSOLE, ".xp_setlvl <Nombre> <Valor> - Ajusta el nivel de un jugador\n" );
	g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTCONSOLE, ".xp_addmedal <Nombre> <Valor> - Dar medallas a un jugador\n" );
	g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTCONSOLE, ".xp_removemedal <Nombre> <Valor> - Quitar medallas a un jugador\n" );
	g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTCONSOLE, ".xp_setaux <Nombre> <Valor> - Ajusta los Suministros Auxiliares de un jugador\n" );
	g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTCONSOLE, ".xp_giveamp <Nombre> <Nivel> <Duracion> - Aumenta la ganancia de EXP a un jugador\n" );
	g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTCONSOLE, ".xp_givepi <Nombre> <Modificador> <Titulo> <Descripcion> - Dar un Modificador de EXP a un jugador\n" );
	g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTCONSOLE, ".xp_setadata <Nombre> <ID> <Estado> <Recompensa> - Ajusta el estado de un logro a un jugador\n" );
	g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTCONSOLE, ".xp_set_xpgain <Valor> - SOLO DIRECTIVOS - Cambia la Ganancia de EXP del mapa\n\n" );
}

CClientCommand ADMIN_ADDXP( "xp_addxp", "<Nombre> <Valor> - Dar EXP a un jugador", @scxpm_addxp, ConCommandFlag::AdminOnly );
void scxpm_addxp( const CCommand@ pArgs )
{
	CBasePlayer@ pPlayer = g_ConCommandSystem.GetCurrentPlayer();
	
	if ( pArgs.ArgC() >= 3 )
	{
		bool bMultiple = false;
		CBasePlayer@ pTarget = SCXPM_FindPlayer( pArgs[ 1 ], bMultiple );
		
		if ( bMultiple )
			g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTCONSOLE, "[SCXPM] Multiples jugadores encontrados. Se mas especifico\n" );
		else if ( pTarget !is null )
		{
			int addxp = atoi( pArgs[ 2 ] );
			int index = pTarget.entindex();
			
			// This is "ADD" xp. Don't allow negative (or zero) values
			if ( addxp <= 0 )
			{
				g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTCONSOLE, "[SCXPM] ERROR: El valor debe ser mayor a 0\n" );
				return;
			}
			
			// Max LV
			if ( playerlevel[ index ] == 640 && mode[ index ] == 1 || playerlevel[ index ] == 565 && mode[ index ] == 2 || playerlevel[ index ] == 1800 && mode[ index ] == 3 || playerlevel[ index ] == maxlevel_p[ index ] && mode[ index ] == 4 )
			{
				g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTCONSOLE, "[SCXPM] El jugador se encuentra en su maximo nivel y no se puede otorgarle mas EXP\n" );
				return;
			}
			
			if ( mode[ index ] == 1 )
			{
				if ( addxp + xp_e[ index ] > scxpm_calc_xp( 640 ) )
					addxp = scxpm_calc_xp( 640 ) - xp_e[ index ];
			}
			else if ( mode[ index ] == 2 )
			{
				if ( addxp + xp[ index ] > scxpm_calc_xp( 565 ) )
					addxp = scxpm_calc_xp( 565 ) - xp[ index ];
			}
			else if ( mode[ index ] == 3 )
			{
				if ( addxp + xp_h[ index ] > scxpm_calc_xp( 1800 ) )
					addxp = scxpm_calc_xp( 1800 ) - xp_h[ index ];
			}
			else if ( mode[ index ] == 4 )
			{
				if ( addxp + xp_p[ index ] > scxpm_calc_xp( maxlevel_p[ index ] ) )
					addxp = scxpm_calc_xp( maxlevel_p[ index ] ) - xp_p[ index ];
			}
			
			// Get now the target's and the admin's name and steamid
			string aname = pPlayer.pev.netname;
			string asteamid = g_EngineFuncs.GetPlayerAuthId( pPlayer.edict() );
			string tname = pTarget.pev.netname;
			string tsteamid = g_EngineFuncs.GetPlayerAuthId( pTarget.edict() );
			
			if ( mode[ index ] == 1 )
			{
				xp_e[ index ] += addxp;
				g_Game.AlertMessage( at_logged, "[SCXPM] " + aname + " (" + asteamid + ") le dio a " + tname + " (" + tsteamid + ") " + AddCommas( addxp ) + " EXP [Modo Facil]\n" );
				SCXPM_Log( "" + aname + " (" + asteamid + ") le dio a " + tname + " (" + tsteamid + ") " + AddCommas( addxp ) + " EXP [Modo Facil]\n" );
			}
			else if ( mode[ index ] == 2 )
			{
				xp[ index ] += addxp;
				g_Game.AlertMessage( at_logged, "[SCXPM] " + aname + " (" + asteamid + ") le dio a " + tname + " (" + tsteamid + ") " + AddCommas( addxp ) + " EXP [Modo Normal]\n" );
				SCXPM_Log( "" + aname + " (" + asteamid + ") le dio a " + tname + " (" + tsteamid + ") " + AddCommas( addxp ) + " EXP [Modo Normal]\n" );
			}
			else if ( mode[ index ] == 3 )
			{
				xp_h[ index ] += addxp;
				g_Game.AlertMessage( at_logged, "[SCXPM] " + aname + " (" + asteamid + ") le dio a " + tname + " (" + tsteamid + ") " + AddCommas( addxp ) + " EXP [Modo Dificil]\n" );
				SCXPM_Log( "" + aname + " (" + asteamid + ") le dio a " + tname + " (" + tsteamid + ") " + AddCommas( addxp ) + " EXP [Modo Dificil]\n" );
			}
			else if ( mode[ index ] == 4 )
			{
				xp_p[ index ] += addxp;
				g_Game.AlertMessage( at_logged, "[SCXPM] " + aname + " (" + asteamid + ") le dio a " + tname + " (" + tsteamid + ") " + AddCommas( addxp ) + " EXP [Modo Sandbox]\n" );
				SCXPM_Log( "" + aname + " (" + asteamid + ") le dio a " + tname + " (" + tsteamid + ") " + AddCommas( addxp ) + " EXP [Modo Sandbox]\n" );
			}
			earnedxp[ index ] += addxp;
			
			scxpm_savedata( index );
			
			g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTCONSOLE, "[SCXPM] " + AddCommas( addxp ) + " EXP otorgado(s) al jugador\n" );
			g_PlayerFuncs.ClientPrintAll( HUD_PRINTTALK, "ADMIN " + aname + ": Dar " + AddCommas( addxp ) + " EXP a " + tname + "\n" );
		}
		else
			g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTCONSOLE, "[SCXPM] ERROR: Jugador no encontrado\n" );
	}
	else if ( pArgs.ArgC() == 1 )
		g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTCONSOLE, "[SCXPM] Modo de uso: .xp_addxp <Nombre> <Valor> - Dar EXP a un jugador\n" );
	else
		g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTCONSOLE, "[SCXPM] ERROR: Parametros insuficientes\n" );
}

CClientCommand ADMIN_REMOVEXP( "xp_removexp", "<Nombre> <Valor> - Quitar EXP a un jugador", @scxpm_removexp, ConCommandFlag::AdminOnly );
void scxpm_removexp( const CCommand@ pArgs )
{
	CBasePlayer@ pPlayer = g_ConCommandSystem.GetCurrentPlayer();
	
	if ( pArgs.ArgC() >= 3 )
	{
		bool bMultiple = false;
		CBasePlayer@ pTarget = SCXPM_FindPlayer( pArgs[ 1 ], bMultiple );
		
		if ( bMultiple )
			g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTCONSOLE, "[SCXPM] Multiples jugadores encontrados. Se mas especifico\n" );
		else if ( pTarget !is null )
		{
			int removexp = atoi( pArgs[ 2 ] );
			int index = pTarget.entindex();
			
			// This is "REMOVE" xp. Don't allow negative (or zero) values
			if ( removexp <= 0 )
			{
				g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTCONSOLE, "[SCXPM] ERROR: El valor debe ser mayor a 0\n" );
				return;
			}
			
			// Get now the target's and the admin's name and steamid
			string aname = pPlayer.pev.netname;
			string asteamid = g_EngineFuncs.GetPlayerAuthId( pPlayer.edict() );
			string tname = pTarget.pev.netname;
			string tsteamid = g_EngineFuncs.GetPlayerAuthId( pTarget.edict() );
			
			if ( mode[ index ] == 1 )
			{
				xp_e[ index ] -= removexp;
				g_Game.AlertMessage( at_logged, "[SCXPM] " + aname + " (" + asteamid + ") le quito a " + tname + " (" + tsteamid + ") " + AddCommas( removexp ) + " EXP [Modo Facil]\n" );
				SCXPM_Log( "" + aname + " (" + asteamid + ") le quito a " + tname + " (" + tsteamid + ") " + AddCommas( removexp ) + " EXP [Modo Facil]\n" );
			}
			else if ( mode[ index ] == 2 )
			{
				xp[ index ] -= removexp;
				g_Game.AlertMessage( at_logged, "[SCXPM] " + aname + " (" + asteamid + ") le quito a " + tname + " (" + tsteamid + ") " + AddCommas( removexp ) + " EXP [Modo Normal]\n" );
				SCXPM_Log( "" + aname + " (" + asteamid + ") le quito a " + tname + " (" + tsteamid + ") " + AddCommas( removexp ) + " EXP [Modo Normal]\n" );
			}
			else if ( mode[ index ] == 3 )
			{
				xp_h[ index ] -= removexp;
				g_Game.AlertMessage( at_logged, "[SCXPM] " + aname + " (" + asteamid + ") le quito a " + tname + " (" + tsteamid + ") " + AddCommas( removexp ) + " EXP [Modo Dificil]\n" );
				SCXPM_Log( "" + aname + " (" + asteamid + ") le quito a " + tname + " (" + tsteamid + ") " + AddCommas( removexp ) + " EXP [Modo Dificil]\n" );
			}
			else if ( mode[ index ] == 4 )
			{
				xp_p[ index ] -= removexp;
				g_Game.AlertMessage( at_logged, "[SCXPM] " + aname + " (" + asteamid + ") le quito a " + tname + " (" + tsteamid + ") " + AddCommas( removexp ) + " EXP [Modo Sandbox]\n" );
				SCXPM_Log( "" + aname + " (" + asteamid + ") le quito a " + tname + " (" + tsteamid + ") " + AddCommas( removexp ) + " EXP [Modo Sandbox]\n" );
			}
			earnedxp[ index ] -= removexp;
			
			// Level needs to be recalculated
			if ( mode[ index ] == 1 )
				playerlevel[ index ] = scxpm_calc_lvl( xp_e[ index ] );
			else if ( mode[ index ] == 2 )
				playerlevel[ index ] = scxpm_calc_lvl( xp[ index ] );
			else if ( mode[ index ] == 3 )
				playerlevel[ index ] = scxpm_calc_lvl( xp_h[ index ] );
			else if ( mode[ index ] == 4 )
				playerlevel[ index ] = scxpm_calc_lvl( xp_p[ index ] );
			
			// Reset skills
			scxpm_breset( index, true );
			g_PlayerFuncs.ClientPrint( pTarget, HUD_PRINTTALK, "[SCXPM] Tus habilidades se han reiniciado. Recuerda volverlas a elegir!\n" );
			
			// Recalculate needed xp
			scxpm_calcneedxp( index );
			scxpm_getrank( index );
			
			scxpm_savedata( index );
			
			g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTCONSOLE, "[SCXPM] " + AddCommas( removexp ) + " EXP removido(s) al jugador\n" );
			g_PlayerFuncs.ClientPrintAll( HUD_PRINTTALK, "ADMIN " + aname + ": Quitar " + AddCommas( removexp ) + " EXP a " + tname + "\n" );
		}
		else
			g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTCONSOLE, "[SCXPM] ERROR: Jugador no encontrado\n" );
	}
	else if ( pArgs.ArgC() == 1 )
		g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTCONSOLE, "[SCXPM] Modo de uso: .xp_removexp <Nombre> <Valor> - Quitar EXP a un jugador\n" );
	else
		g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTCONSOLE, "[SCXPM] ERROR: Parametros insuficientes\n" );
}

CClientCommand ADMIN_SETLVL( "xp_setlvl", "<Nombre> <Valor> - Ajusta el nivel de un jugador", @scxpm_setlvl, ConCommandFlag::AdminOnly );
void scxpm_setlvl( const CCommand@ pArgs )
{
	CBasePlayer@ pPlayer = g_ConCommandSystem.GetCurrentPlayer();
	
	if ( pArgs.ArgC() >= 3 )
	{
		bool bMultiple = false;
		CBasePlayer@ pTarget = SCXPM_FindPlayer( pArgs[ 1 ], bMultiple );
		
		if ( bMultiple )
			g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTCONSOLE, "[SCXPM] Multiples jugadores encontrados. Se mas especifico\n" );
		else if ( pTarget !is null )
		{
			int nowlvl = atoi( pArgs[ 2 ] );
			int index = pTarget.entindex();
			
			if ( nowlvl < 0 )
				nowlvl = 0;
			
			if ( nowlvl > 640 && mode[ index ] == 1 )
				nowlvl = 640;
			if ( nowlvl > 565 && mode[ index ] == 2 )
				nowlvl = 565;
			if ( nowlvl > 1800 && mode[ index ] == 3 )
				nowlvl = 1800;
			if ( nowlvl > maxlevel_p[ index ] && mode[ index ] == 4 )
				nowlvl = maxlevel_p[ index ];
			
			// Get now the target's and the admin's name and steamid
			string aname = pPlayer.pev.netname;
			string asteamid = g_EngineFuncs.GetPlayerAuthId( pPlayer.edict() );
			string tname = pTarget.pev.netname;
			string tsteamid = g_EngineFuncs.GetPlayerAuthId( pTarget.edict() );
			
			if ( nowlvl == playerlevel[ index ] )
			{
				g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTCONSOLE, "[SCXPM] El nivel de " + tname + " ya es " + nowlvl + "\n" );
				return;
			}
			else
			{
				if ( nowlvl == 640 && mode[ index ] == 1 )
					xp_e[ index ] = 1473884;
				else if ( nowlvl == 565 && mode[ index ] == 2 )
					xp[ index ] = 1152847;
				else if ( nowlvl == 1800 && mode[ index ] == 3 )
					xp_h[ index ] = 11453365;
				else if ( nowlvl == maxlevel_p[ index ] && mode[ index ] == 4 )
					xp_p[ index ] = scxpm_calc_xp( maxlevel_p[ index ] ) + 1;
				else
				{
					if ( nowlvl == 0 )
					{
						if ( mode[ index ] == 1 )
							xp_e[ index ] = 0;
						else if ( mode[ index ] == 2 )
							xp[ index ] = 0;
						else if ( mode[ index ] == 3 )
							xp_h[ index ] = 0;
						else if ( mode[ index ] == 4 )
							xp_p[ index ] = 0;
					}
					else
					{
						int helpvar = nowlvl - 1;
						float m70b = float( helpvar ) * 70.0;
						float mselfm3dot2b = float( helpvar ) * float( helpvar ) * 3.5;
						if ( mode[ index ] == 1 )
							xp_e[ index ] = floatround( m70b + mselfm3dot2b + 30.0 );
						else if ( mode[ index ] == 2 )
							xp[ index ] = floatround( m70b + mselfm3dot2b + 30.0 );
						else if ( mode[ index ] == 3 )
							xp_h[ index ] = floatround( m70b + mselfm3dot2b + 30.0 );
						else if ( mode[ index ] == 4 )
							xp_p[ index ] = floatround( m70b + mselfm3dot2b + 30.0 );
					}
				}
			}
			
			if ( playerlevel[ index ] > nowlvl )
			{
				playerlevel[ index ] = nowlvl;
				if ( nowlvl > 0 )
					g_PlayerFuncs.ClientPrint( pTarget, HUD_PRINTTALK, "[SCXPM] Tu nivel ha sido disminuido y tus habilidades reiniciadas!\n" );
				else
					g_PlayerFuncs.ClientPrint( pTarget, HUD_PRINTTALK, "[SCXPM] Tus niveles han sido eliminados por completo!\n" );
				
				g_SoundSystem.EmitSoundDyn( pTarget.edict(), CHAN_STATIC, "adamr/blipblipblip.wav", VOL_NORM, ATTN_NONE, SND_SKIP_ORIGIN_USE_ENT, PITCH_NORM, index );
				
				scxpm_getrank( index );
				scxpm_breset( index, true );
			}
			else
			{
				skillpoints[ index ] = skillpoints[ index ] + nowlvl - playerlevel[ index ];
				playerlevel[ index ] = nowlvl;
				
				g_SoundSystem.EmitSoundDyn( pTarget.edict(), CHAN_STATIC, "ecsc/scxpm/levelup.ogg", VOL_NORM, ATTN_NONE, SND_SKIP_ORIGIN_USE_ENT, PITCH_NORM, index );
				
				g_PlayerFuncs.ClientPrint( pTarget, HUD_PRINTTALK, "[SCXPM] Tu nivel ha sido aumentado!\n" );
				SCXPMSkill( index );
				scxpm_getrank( index );
			}
			scxpm_calcneedxp( index );
			scxpm_savedata( index );
			
			if ( mode[ index ] == 1 )
			{
				g_Game.AlertMessage( at_logged, "[SCXPM] " + aname + " (" + asteamid + ") ajusto el nivel de " + tname + " (" + tsteamid + ") a " + AddCommas( nowlvl ) + " [Modo Facil]\n" );
				SCXPM_Log( "" + aname + " (" + asteamid + ") ajusto el nivel de " + tname + " (" + tsteamid + ") a " + AddCommas( nowlvl ) + " [Modo Facil]\n" );
			}
			else if ( mode[ index ] == 2 )
			{
				g_Game.AlertMessage( at_logged, "[SCXPM] " + aname + " (" + asteamid + ") ajusto el nivel de " + tname + " (" + tsteamid + ") a " + AddCommas( nowlvl ) + " [Modo Normal]\n" );
				SCXPM_Log( "" + aname + " (" + asteamid + ") ajusto el nivel de " + tname + " (" + tsteamid + ") a " + AddCommas( nowlvl ) + " [Modo Normal]\n" );
			}
			else if ( mode[ index ] == 3 )
			{
				g_Game.AlertMessage( at_logged, "[SCXPM] " + aname + " (" + asteamid + ") ajusto el nivel de " + tname + " (" + tsteamid + ") a " + AddCommas( nowlvl ) + " [Modo Dificil]\n" );
				SCXPM_Log( "" + aname + " (" + asteamid + ") ajusto el nivel de " + tname + " (" + tsteamid + ") a " + AddCommas( nowlvl ) + " [Modo Dificil]\n" );
			}
			else if ( mode[ index ] == 4 )
			{
				g_Game.AlertMessage( at_logged, "[SCXPM] " + aname + " (" + asteamid + ") ajusto el nivel de " + tname + " (" + tsteamid + ") a " + AddCommas( nowlvl ) + " [Modo Sandbox]\n" );
				SCXPM_Log( "" + aname + " (" + asteamid + ") ajusto el nivel de " + tname + " (" + tsteamid + ") a " + AddCommas( nowlvl ) + " [Modo Sandbox]\n" );
			}
			
			g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTCONSOLE, "[SCXPM] Nivel del jugador ajustado a " + AddCommas( nowlvl ) + "\n" );
			g_PlayerFuncs.ClientPrintAll( HUD_PRINTTALK, "ADMIN " + aname + ": Ajustar nivel de " + tname + " a " + AddCommas( nowlvl ) + "\n" );
		}
		else
			g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTCONSOLE, "[SCXPM] ERROR: Jugador no encontrado\n" );
	}
	else if ( pArgs.ArgC() == 1 )
		g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTCONSOLE, "[SCXPM] Modo de uso: .xp_setlvl <Nombre> <Valor> - Ajusta el nivel de un jugador\n" );
	else
		g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTCONSOLE, "[SCXPM] ERROR: Parametros insuficientes\n" );
}

CClientCommand ADMIN_ADDMEDAL( "xp_addmedal", "<Nombre> <Valor> - Dar medallas a un jugador", @scxpm_addmedal, ConCommandFlag::AdminOnly );
void scxpm_addmedal( const CCommand@ pArgs )
{
	CBasePlayer@ pPlayer = g_ConCommandSystem.GetCurrentPlayer();
	
	if ( pArgs.ArgC() >= 3 )
	{
		bool bMultiple = false;
		CBasePlayer@ pTarget = SCXPM_FindPlayer( pArgs[ 1 ], bMultiple );
		
		if ( bMultiple )
			g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTCONSOLE, "[SCXPM] Multiples jugadores encontrados. Se mas especifico\n" );
		else if ( pTarget !is null )
		{
			int amount = atoi( pArgs[ 2 ] );
			int index = pTarget.entindex();
			
			// This is "ADD" medals. Don't allow negative (or zero) values
			if ( amount <= 0 )
			{
				g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTCONSOLE, "[SCXPM] ERROR: El valor debe ser mayor a 0\n" );
				return;
			}
			
			// Easy mode or Max medals
			if ( mode[ index ] == 1 )
			{
				g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTCONSOLE, "[SCXPM] El jugador esta jugando en Modo Facil y no se le pueden otorgar medallas\n" );
				return;
			}
			else if ( medals[ index ] == 42 && mode[ index ] == 2 || medals_h[ index ] == 42 && mode[ index ] == 3 )
			{
				g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTCONSOLE, "[SCXPM] El jugador ya dispone de todas las medallas y no se le puede otorgarle mas\n" );
				return;
			}
			else if ( mode[ index ] == 4 && maxmedals_p[ index ] == 0 )
			{
				g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTCONSOLE, "[SCXPM] El jugador esta jugando en Modo Sandbox y en su partida no se le pueden otorgar medallas\n" );
				return;
			}
			else if ( medals_p[ index ] == maxmedals_p[ index ] && mode[ index ] == 4 )
			{
				g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTCONSOLE, "[SCXPM] El jugador ya dispone de todas las medallas y no se le puede otorgarle mas\n" );
				return;
			}
			
			if ( mode[ index ] == 2 )
			{
				if ( amount + medals[ index ] > 42 )
					amount = 42 - medals[ index ];
				
				medals[ index ] += amount;
			}
			else if ( mode[ index ] == 3 )
			{
				if ( amount + medals_h[ index ] > 42 )
					amount = 42 - medals_h[ index ];
				
				medals_h[ index ] += amount;
			}
			else if ( mode[ index ] == 4 )
			{
				if ( amount + medals_p[ index ] > maxmedals_p[ index ] )
					amount = maxmedals_p[ index ] - medals_p[ index ];
				
				medals_p[ index ] += amount;
			}
			
			// Get now the target's and the admin's name and steamid
			string aname = pPlayer.pev.netname;
			string asteamid = g_EngineFuncs.GetPlayerAuthId( pPlayer.edict() );
			string tname = pTarget.pev.netname;
			string tsteamid = g_EngineFuncs.GetPlayerAuthId( pTarget.edict() );
			
			if ( mode[ index ] == 2 )
			{
				g_Game.AlertMessage( at_logged, "[SCXPM] " + aname + " (" + asteamid + ") le dio a " + tname + " (" + tsteamid + ") " + amount + " medalla(s) [Modo Normal]\n" );
				SCXPM_Log( "" + aname + " (" + asteamid + ") le dio a " + tname + " (" + tsteamid + ") " + amount + " medalla(s) [Modo Normal]\n" );
			}
			else if ( mode[ index ] == 3 )
			{
				g_Game.AlertMessage( at_logged, "[SCXPM] " + aname + " (" + asteamid + ") le dio a " + tname + " (" + tsteamid + ") " + amount + " medalla(s) [Modo Dificil]\n" );
				SCXPM_Log( "" + aname + " (" + asteamid + ") le dio a " + tname + " (" + tsteamid + ") " + amount + " medalla(s) [Modo Dificil]\n" );
			}
			else if ( mode[ index ] == 4 )
			{
				g_Game.AlertMessage( at_logged, "[SCXPM] " + aname + " (" + asteamid + ") le dio a " + tname + " (" + tsteamid + ") " + amount + " medalla(s) [Modo Sandbox]\n" );
				SCXPM_Log( "" + aname + " (" + asteamid + ") le dio a " + tname + " (" + tsteamid + ") " + amount + " medalla(s) [Modo Sandbox]\n" );
			}
			
			g_SoundSystem.EmitSoundDyn( pTarget.edict(), CHAN_STATIC, "ecsc/scxpm/medalget.ogg", VOL_NORM, ATTN_NONE, SND_SKIP_ORIGIN_USE_ENT, PITCH_NORM, index );
			scxpm_savedata( index );
			
			g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTCONSOLE, "[SCXPM] " + amount + " medalla(s) otorgada(s) al jugador\n" );
			g_PlayerFuncs.ClientPrintAll( HUD_PRINTTALK, "ADMIN " + aname + ": Dar " + amount + " medalla(s) a " + tname + "\n" );
		}
		else
			g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTCONSOLE, "[SCXPM] ERROR: Jugador no encontrado\n" );
	}
	else if ( pArgs.ArgC() == 1 )
		g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTCONSOLE, "[SCXPM] Modo de uso: .xp_addmedal <Nombre> <Valor> - Dar medallas a un jugador\n" );
	else
		g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTCONSOLE, "[SCXPM] ERROR: Parametros insuficientes\n" );
}

CClientCommand ADMIN_REMOVEMEDAL( "xp_removemedal", "<Nombre> <Valor> - Quitar medallas a un jugador", @scxpm_removemedal, ConCommandFlag::AdminOnly );
void scxpm_removemedal( const CCommand@ pArgs )
{
	CBasePlayer@ pPlayer = g_ConCommandSystem.GetCurrentPlayer();
	
	if ( pArgs.ArgC() >= 3 )
	{
		bool bMultiple = false;
		CBasePlayer@ pTarget = SCXPM_FindPlayer( pArgs[ 1 ], bMultiple );
		
		if ( bMultiple )
			g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTCONSOLE, "[SCXPM] Multiples jugadores encontrados. Se mas especifico\n" );
		else if ( pTarget !is null )
		{
			int amount = atoi( pArgs[ 2 ] );
			int index = pTarget.entindex();
			
			// This is "REMOVE" medals. Don't allow negative (or zero) values
			if ( amount <= 0 )
			{
				g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTCONSOLE, "[SCXPM] ERROR: El valor debe ser mayor a 0\n" );
				return;
			}
			
			// Easy mode or Min medals
			if ( mode[ index ] == 1 )
			{
				g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTCONSOLE, "[SCXPM] El jugador esta jugando en Modo Facil y no se le pueden remover medallas\n" );
				return;
			}
			else if ( medals[ index ] == 0 && mode[ index ] == 2 || medals_h[ index ] == 0 && mode[ index ] == 3 )
			{
				g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTCONSOLE, "[SCXPM] El jugador ya no dispone de medallas algunas y no se le puede removerle mas\n" );
				return;
			}
			else if ( mode[ index ] == 4 && maxmedals_p[ index ] == 0 )
			{
				g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTCONSOLE, "[SCXPM] El jugador esta jugando en Modo Sandbox y en su partida no se le pueden remover medallas\n" );
				return;
			}
			else if ( medals_p[ index ] == 0 && mode[ index ] == 4 )
			{
				g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTCONSOLE, "[SCXPM] El jugador ya no dispone de medallas algunas y no se le puede removerle mas\n" );
				return;
			}
			
			if ( mode[ index ] == 2 )
			{
				if ( amount > medals[ index ] )
					amount = medals[ index ];
				
				medals[ index ] -= amount;
			}
			else if ( mode[ index ] == 3 )
			{
				if ( amount > medals_h[ index ] )
					amount = medals_h[ index ];
				
				medals_h[ index ] -= amount;
			}
			else if ( mode[ index ] == 4 )
			{
				if ( amount > medals_p[ index ] )
					amount = medals_p[ index ];
				
				medals_p[ index ] -= amount;
			}
			
			// Get now the target's and the admin's name and steamid
			string aname = pPlayer.pev.netname;
			string asteamid = g_EngineFuncs.GetPlayerAuthId( pPlayer.edict() );
			string tname = pTarget.pev.netname;
			string tsteamid = g_EngineFuncs.GetPlayerAuthId( pTarget.edict() );
			
			if ( mode[ index ] == 2 )
			{
				g_Game.AlertMessage( at_logged, "[SCXPM] " + aname + " (" + asteamid + ") le quito a " + tname + " (" + tsteamid + ") " + amount + " medalla(s) [Modo Normal]\n" );
				SCXPM_Log( "" + aname + " (" + asteamid + ") le quito a " + tname + " (" + tsteamid + ") " + amount + " medalla(s) [Modo Normal]\n" );
			}
			else if ( mode[ index ] == 3 )
			{
				g_Game.AlertMessage( at_logged, "[SCXPM] " + aname + " (" + asteamid + ") le quito a " + tname + " (" + tsteamid + ") " + amount + " medalla(s) [Modo Dificil]\n" );
				SCXPM_Log( "" + aname + " (" + asteamid + ") le quito a " + tname + " (" + tsteamid + ") " + amount + " medalla(s) [Modo Dificil]\n" );
			}
			else if ( mode[ index ] == 4 )
			{
				g_Game.AlertMessage( at_logged, "[SCXPM] " + aname + " (" + asteamid + ") le quito a " + tname + " (" + tsteamid + ") " + amount + " medalla(s) [Modo Sandbox]\n" );
				SCXPM_Log( "" + aname + " (" + asteamid + ") le quito a " + tname + " (" + tsteamid + ") " + amount + " medalla(s) [Modo Sandbox]\n" );
			}
			
			g_SoundSystem.EmitSoundDyn( pTarget.edict(), CHAN_STATIC, "adamr/blipblipblip.wav", VOL_NORM, ATTN_NONE, SND_SKIP_ORIGIN_USE_ENT, PITCH_NORM, index );
			scxpm_savedata( index );
			
			g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTCONSOLE, "[SCXPM] " + amount + " medalla(s) removida(s) al jugador\n" );
			g_PlayerFuncs.ClientPrintAll( HUD_PRINTTALK, "ADMIN " + aname + ": Quitar " + amount + " medalla(s) a " + tname + "\n" );
		}
		else
			g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTCONSOLE, "[SCXPM] ERROR: Jugador no encontrado\n" );
	}
	else if ( pArgs.ArgC() == 1 )
		g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTCONSOLE, "[SCXPM] Modo de uso: .xp_removemedal <Nombre> <Valor> - Quitar medallas a un jugador\n" );
	else
		g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTCONSOLE, "[SCXPM] ERROR: Parametros insuficientes\n" );
}

CClientCommand ADMIN_SETSPARK( "xp_setaux", "<Nombre> <Valor> - Ajusta los Suministros Auxiliares de un jugador", @scxpm_setspark, ConCommandFlag::AdminOnly );
void scxpm_setspark( const CCommand@ pArgs )
{
	CBasePlayer@ pPlayer = g_ConCommandSystem.GetCurrentPlayer();
	
	if ( pArgs.ArgC() >= 2 )
	{
		bool bMultiple = false;
		CBasePlayer@ pTarget = SCXPM_FindPlayer( pArgs[ 1 ], bMultiple );
		
		if ( bMultiple )
			g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTCONSOLE, "[SCXPM] Multiples jugadores encontrados. Se mas especifico\n" );
		else if ( pTarget !is null )
		{
			int index = pTarget.entindex();
			
			if ( pArgs.ArgC() == 2 )
			{
				if ( mode[ index ] == 4 )
					g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTCONSOLE, "[SCXPM] El jugador " + pTarget.pev.netname + " tiene " + sparks_p[ index ] + " suministro(s) auxiliar(es)\n" );
				else
					g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTCONSOLE, "[SCXPM] El jugador " + pTarget.pev.netname + " tiene " + sparks[ index ] + " suministro(s) auxiliar(es)\n" );
				return;
			}
			
			int set = atoi( pArgs[ 2 ] );
			
			// This is "SET" sparks. Don't allow negative values
			if ( set <= 0 )
			{
				g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTCONSOLE, "[SCXPM] ERROR: El valor debe ser mayor a 0\n" );
				return;
			}
			else if ( set > 100 )
			{
				// If you/a player needs more than 100 sparks, then he is/you are insane...
				g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTCONSOLE, "[SCXPM] Requerir mas de 100 Suministros Auxiliares es claro signo de demencia\n" );
				return;
			}
			
			if ( mode[ index ] == 4 )
				sparks_p[ index ] = set + 1;
			else
				sparks[ index ] = set + 1;
			
			g_SoundSystem.EmitSoundDyn( pTarget.edict(), CHAN_STREAM, "items/gunpickup2.wav", VOL_NORM, ATTN_NONE, SND_SKIP_ORIGIN_USE_ENT, PITCH_NORM, index );
			
			// Get now the target's and the admin's name and steamid
			string aname = pPlayer.pev.netname;
			string asteamid = g_EngineFuncs.GetPlayerAuthId( pPlayer.edict() );
			string tname = pTarget.pev.netname;
			string tsteamid = g_EngineFuncs.GetPlayerAuthId( pTarget.edict() );
			
			g_Game.AlertMessage( at_logged, "[SCXPM] " + aname + " (" + asteamid + ") ajusto los suministros auxiliares de " + tname + " (" + tsteamid + ") " + "a " + set + "\n" );
			SCXPM_Log( "" + aname + " (" + asteamid + ") ajusto los suministros auxiliares de " + tname + " (" + tsteamid + ") " + "a " + set + "\n" );
			
			scxpm_savedata( index );
			
			g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTCONSOLE, "[SCXPM] Suministros Auxiliares del jugador ajustados a " + set + "\n" );
			g_PlayerFuncs.ClientPrintAll( HUD_PRINTTALK, "ADMIN " + aname + ": Ajustar Suministros Auxiliares de " + tname + "\n" );
		}
		else
			g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTCONSOLE, "[SCXPM] ERROR: Jugador no encontrado\n" );
	}
	else
		g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTCONSOLE, "[SCXPM] Modo de uso: .xp_setaux <Nombre> <Valor> - Ajusta los Suministros Auxiliares de un jugador\n" );
}

CClientCommand ADMIN_XPAMPLIFIER( "xp_giveamp", "<Nombre> <Nivel> <Duracion> - Aumenta la ganancia de EXP a un jugador", @scxpm_expamp, ConCommandFlag::AdminOnly );
void scxpm_expamp( const CCommand@ pArgs )
{
	CBasePlayer@ pPlayer = g_ConCommandSystem.GetCurrentPlayer();
	
	if ( pArgs.ArgC() >= 4 )
	{
		bool bMultiple = false;
		CBasePlayer@ pTarget = SCXPM_FindPlayer( pArgs[ 1 ], bMultiple );
		
		if ( bMultiple )
			g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTCONSOLE, "[SCXPM] Multiples jugadores encontrados. Se mas especifico\n" );
		else if ( pTarget !is null )
		{
			int level = atoi( pArgs[ 2 ] );
			int index = pTarget.entindex();
			
			if ( level < 0 || level >= 5 )
			{
				g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTCONSOLE, "[SCXPM] ERROR: El nivel debe encontrarse entre 0 y 4\n" );
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
				
				g_Game.AlertMessage( at_logged, "[SCXPM] " + aname + " (" + asteamid + ") le quito a " + tname + " (" + tsteamid + ") " + "su amplificador de EXP\n" );
				SCXPM_Log( "" + aname + " (" + asteamid + ") le quito a " + tname + " (" + tsteamid + ") " + "su amplificador de EXP\n" );
				
				g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTCONSOLE, "[SCXPM] Amplificador de EXP eliminado del jugador\n" );
				g_PlayerFuncs.ClientPrintAll( HUD_PRINTTALK, "ADMIN " + aname + ": Quitar Amplificador de EXP a " + tname + "\n" );
			}
			else // Add
			{
				string duration = pArgs[ 3 ];
				if ( duration[ 0 ] == '0' )
				{
					g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTCONSOLE, "[SCXPM] ERROR: La duracion debe ser mayor a 0\n" );
					return;
				}
				else if ( !isdigit( duration[ 0 ] ) )
				{
					g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTCONSOLE, "[SCXPM] ERROR: La duracion es invalida\n" );
					return;
				}
				else if ( isdigit( duration[ duration.Length() - 1 ] ) )
				{
					g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTCONSOLE, "[SCXPM] La duracion de \"" + duration + "\" necesita mas especificacion.\n\n" );
					g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTCONSOLE, "Usa uno de las siguientes propiedades:\n\n" );
					g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTCONSOLE, "" + duration + "m = " + duration + " minuto(s)\n" );
					g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTCONSOLE, "" + duration + "h = " + duration + " hora(s)\n" );
					g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTCONSOLE, "" + duration + "d = " + duration + " dia(s)\n\n" );
					g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTCONSOLE, "Las propiedades deben escribirse en letra minuscula\n\n" );
					return;
				}
				else if ( duration[ duration.Length() - 1 ] != 'm' && duration[ duration.Length() - 1 ] != 'h' && duration[ duration.Length() - 1 ] != 'd' )
				{
					g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTCONSOLE, "[SCXPM] Propiedad de duracion invalida.\n\n" );
					g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTCONSOLE, "Usa uno de las siguientes propiedades:\n\n" );
					g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTCONSOLE, "m = minuto(s)\n" );
					g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTCONSOLE, "h = hora(s)\n" );
					g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTCONSOLE, "d = dia(s)\n\n" );
					g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTCONSOLE, "Las propiedades deben escribirse en letra minuscula\n\n" );
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
						g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTCONSOLE, "[SCXPM] ERROR: Multiples propiedades detectadas\n" );
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
						
						g_Game.AlertMessage( at_logged, "[SCXPM] " + aname + " (" + asteamid + ") le dio a " + tname + " (" + tsteamid + ") " + "amplificador de EXP de nivel " + level + " [" + fixer[ 0 ] + string( flag ) + "]\n" );
						SCXPM_Log( "" + aname + " (" + asteamid + ") le dio a " + tname + " (" + tsteamid + ") " + "amplificador de EXP de nivel " + level + " [" + fixer[ 0 ] + string( flag ) + "]\n" );
						
						scxpm_savedata( index );
						
						g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTCONSOLE, "[SCXPM] Otorgado al jugador un Amplificador de EXP de nivel " + level + " [" + fixer[ 0 ] + flag + "]\n" );
						g_PlayerFuncs.ClientPrintAll( HUD_PRINTTALK, "ADMIN " + aname + ": Dar Amplificador de EXP de Nivel " + level + " a " + tname + "\n" );
					}
				}
			}
		}
		else
			g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTCONSOLE, "[SCXPM] ERROR: Jugador no encontrado\n" );
	}
	else if ( pArgs.ArgC() == 1 )
		g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTCONSOLE, "[SCXPM] Modo de uso: .xp_giveamp <Nombre> <Nivel> <Duracion> - Aumenta la ganancia de EXP a un jugador\n" );
	else
		g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTCONSOLE, "[SCXPM] ERROR: Parametros insuficientes\n" );
}

CClientCommand ADMIN_GIVEPERMA( "xp_givepi", "<Nombre> <Modificador> <Titulo> <Descripcion> - Dar un Modificador de EXP a un jugador", @scxpm_giveperma, ConCommandFlag::AdminOnly );
void scxpm_giveperma( const CCommand@ pArgs )
{
	CBasePlayer@ pPlayer = g_ConCommandSystem.GetCurrentPlayer();
	
	if ( pArgs.ArgC() >= 5 )
	{
		bool bMultiple = false;
		CBasePlayer@ pTarget = SCXPM_FindPlayer( pArgs[ 1 ], bMultiple );
		
		if ( bMultiple )
			g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTCONSOLE, "[SCXPM] Multiples jugadores encontrados. Se mas especifico\n" );
		else if ( pTarget !is null )
		{
			int increase = atoi( pArgs[ 2 ] );
			int index = pTarget.entindex();
			
			if ( increase == 0 )
			{
				g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTCONSOLE, "[SCXPM] ERROR: El modificador no puede ser del 0%%\n" );
				return;
			}
			
			// Get now the target's and the admin's name and steamid
			string aname = pPlayer.pev.netname;
			string asteamid = g_EngineFuncs.GetPlayerAuthId( pPlayer.edict() );
			string tname = pTarget.pev.netname;
			string tsteamid = g_EngineFuncs.GetPlayerAuthId( pTarget.edict() );
			
			string szTitle = pArgs[ 3 ];
			string szDescription = pArgs[ 4 ];
			
			// Formulate the string
			string szData = "" + string( increase ) + ".0" + "#" + szTitle + "#" + szDescription + "!n!n" + ( increase > 0 ? "+" : "" ) + string( increase ) + "% Ganancia de EXP!n" + "\n";
			
			// Give the perma increase
			AddPermaIncrease( index, szData );
			
			// Log messages
			g_Game.AlertMessage( at_logged, "[SCXPM] " + aname + " (" + asteamid + ") le dio a " + tname + " (" + tsteamid + ") " + "modificador de EXP de" + ( increase > 0 ? " +" : " " ) + string( increase ) + "%\n" );
			SCXPM_Log( "" + aname + " (" + asteamid + ") le dio a " + tname + " (" + tsteamid + ") " + "modificador de EXP de" + ( increase > 0 ? " +" : " " ) + string( increase ) + "%\n" );
			
			g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTCONSOLE, "[SCXPM] Otorgado al jugador un Modificador de EXP de" + ( increase > 0 ? " +" : " " ) + string( increase ) + "%%\n" );
			g_PlayerFuncs.ClientPrintAll( HUD_PRINTTALK, "ADMIN " + aname + ": Dar Modificador de EXP a " + tname + "\n" );
		}
		else
			g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTCONSOLE, "[SCXPM] ERROR: Jugador no encontrado\n" );
	}
	else if ( pArgs.ArgC() == 1 )
		g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTCONSOLE, "[SCXPM] Modo de uso: .xp_givepi <Nombre> <Modificador> <Titulo> <Descripcion> - Dar un Modificador de EXP a un jugador\n" );
	else
		g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTCONSOLE, "[SCXPM] ERROR: Parametros insuficientes\n" );
}

CClientCommand ADMIN_SETADATA( "xp_setadata", "<Nombre> <ID> <Estado> <Recompensa> - Ajusta el estado de un logro a un jugador", @scxpm_setadata, ConCommandFlag::AdminOnly );
void scxpm_setadata( const CCommand@ pArgs )
{
	CBasePlayer@ pPlayer = g_ConCommandSystem.GetCurrentPlayer();
	
	if ( pArgs.ArgC() >= 3 )
	{
		bool bMultiple = false;
		CBasePlayer@ pTarget = SCXPM_FindPlayer( pArgs[ 1 ], bMultiple );
		
		if ( bMultiple )
			g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTCONSOLE, "[SCXPM] Multiples jugadores encontrados. Se mas especifico\n" );
		else if ( pTarget !is null )
		{
			int iID = atoi( pArgs[ 2 ] );
			int index = pTarget.entindex();
			
			if ( iID < 0 || iID > int( szAchievementNames.length() ) )
			{
				g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTCONSOLE, "[SCXPM] ERROR: ID de logro invalida\n" );
				return;
			}
			
			if ( pArgs.ArgC() == 3 )
			{
				g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTCONSOLE, "[SCXPM] ID de logro seleccionada: " + szAchievementNames[ iID ] + "\n" );
				
				if ( aData[ index ][ iID ] )
					g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTCONSOLE, "[SCXPM] Este jugador YA TIENE el logro\n" );
				else
					g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTCONSOLE, "[SCXPM] Este jugador NO TIENE el logro\n" );
				
				return;
			}
			else if ( pArgs.ArgC() >= 5 )
			{
				int iUnlock = atoi( pArgs[ 3 ] );
				int iReward = atoi( pArgs[ 4 ] );
				
				if ( iUnlock < 0 || iUnlock > 1 )
				{
					g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTCONSOLE, "[SCXPM] ERROR: Estado de logro invalida\n" );
					return;
				}
				
				if ( iReward < 0 || iReward > 1 )
				{
					g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTCONSOLE, "[SCXPM] ERROR: Recompensa de logro invalida\n" );
					return;
				}
				
				if ( aData[ index ][ iID ] && iUnlock == 1 )
				{
					g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTCONSOLE, "[SCXPM] Este jugador YA TIENE el logro\n" );
					return;
				}
				else if ( !aData[ index ][ iID ] && iUnlock == 0 )
				{
					g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTCONSOLE, "[SCXPM] Este jugador NO TIENE el logro\n" );
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
					aData[ index ][ iID ] = true;
					
					// Give reward?
					if ( iReward == 1 ) GiveAchievementReward( index, iID );
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
				g_Game.AlertMessage( at_logged, "[SCXPM] " + aname + " (" + asteamid + ") ajusto datos de logro a " + tname + " (" + tsteamid + ") | " + szFixedName + " [" + ( iUnlock == 1 ? "DAR" : "QUITAR" ) + "]" + "[" + ( iReward == 1 ? "CON RECOMPENSA" : "SIN RECOMPENSA" ) + "]\n" );
				SCXPM_Log( "" + aname + " (" + asteamid + ") ajusto datos de logro a " + tname + " (" + tsteamid + ") | " + szFixedName + " [" + ( iUnlock == 1 ? "DAR" : "QUITAR" ) + "]" + "[" + ( iReward == 1 ? "CON RECOMPENSA" : "SIN RECOMPENSA" ) + "]\n" );
				
				scxpm_saveachievement( index );
				
				g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTCONSOLE, "[SCXPM] Ajustado datos de logro al jugador\n" );
				
				if ( iUnlock == 1 ) g_PlayerFuncs.ClientPrintAll( HUD_PRINTTALK, "ADMIN " + aname + ": Desbloquear logro " + szFixedName + " a " + tname + "\n" );
				else g_PlayerFuncs.ClientPrintAll( HUD_PRINTTALK, "ADMIN " + aname + ": Bloquear logro " + szFixedName + " a " + tname + "\n" );
			}
			else
			{
				g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTCONSOLE, "[SCXPM] Debes especificar Estado y Recompensa\n" );
				g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTCONSOLE, "---\n" );
				g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTCONSOLE, "Estado = 1 --> Desbloquear logro\n" );
				g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTCONSOLE, "Estado = 0 --> Bloquear logro\n" );
				g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTCONSOLE, "---\n" );
				g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTCONSOLE, "Recompensa = 1 --> Otorgar la recompensa del logro al jugador\n" );
				g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTCONSOLE, "Recompensa = 0 --> No otorgar la recompensa del logro al jugador\n" );
				
				return;
			}
		}
		else
			g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTCONSOLE, "[SCXPM] ERROR: Jugador no encontrado\n" );
	}
	else if ( pArgs.ArgC() == 1 )
		g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTCONSOLE, "[SCXPM] Modo de uso: .xp_setadata <Nombre> <ID> <Estado> <Recompensa> - Ajusta el estado de un logro a un jugador\n" );
	else
		g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTCONSOLE, "[SCXPM] ERROR: Parametros insuficientes\n" );
}

CClientCommand ADMIN_MAPXPGAIN( "xp_set_xpgain", "<Valor> - SOLO DIRECTIVOS - Cambia la Ganancia de EXP del mapa", @scxpm_mapxpgain, ConCommandFlag::AdminOnly );
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
				g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTCONSOLE, "[SCXPM] ERROR: La Ganancia de EXP debe ser mayor o igual a x0.00\n" );
				return;
			}
		
			// Prevent division by zero caused by the discard of long floats ( 6+ digits )
			if ( flNewXPGain == 0.00 ) flNewXPGain = 0.00001;
			
			MAP_XPGAIN = flNewXPGain;
			
			// Get now the admin's name and steamid
			string aname = pPlayer.pev.netname;
			string asteamid = g_EngineFuncs.GetPlayerAuthId( pPlayer.edict() );
			
			// Log messages
			g_Game.AlertMessage( at_logged, "[SCXPM] " + aname + " (" + asteamid + ") cambio la Ganancia de EXP del mapa a x" + fl2Decimals( flNewXPGain ) + "\n" );
			SCXPM_Log( "" + aname + " (" + asteamid + ") cambio la Ganancia de EXP del mapa a x" + fl2Decimals( flNewXPGain ) + "\n" );
			
			g_PlayerFuncs.ClientPrintAll( HUD_PRINTTALK, "ADMIN " + aname + ": Modificado la Ganancia de EXP del mapa\n" );
			g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTCONSOLE, "[SCXPM] Se ajusto la Ganancia de EXP del mapa\n" );
		}
		else if ( pArgs.ArgC() == 1 )
		{
			g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTCONSOLE, "[SCXPM] Modo de uso: .xp_set_xpgain <Valor> - Cambia la Ganancia de EXP del mapa\n" );
			g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTCONSOLE, "[SCXPM] IMPORTANTE: Esto solo cambia la Ganancia de EXP BASE del map. No afecta las Ganancias de EXP individuales por jugador\n" );
			g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTCONSOLE, "[SCXPM] La Ganancia de EXP del map esta actualmente en x" + fl2Decimals( MAP_XPGAIN ) + "\n" );
		}
	}
	else
		g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTCONSOLE, "[SCXPM] ERROR: Acceso denegado\n" );
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
	float exp;
	
	if ( mode[ index ] == 1 ) exp = EASY_BASEXP;
	if ( mode[ index ] == 2 ) exp = NORMAL_BASEXP;
	if ( mode[ index ] == 3 ) exp = HARD_BASEXP;
	if ( mode[ index ] == 4 ) exp = xpgain_p[ index ];
	
	exp = exp * ( MAP_XPGAIN * ( expamp[ index ] + 1 ) );
	
	float hTotal = 0.0;
	if ( handicap1[ index ] ) hTotal += 10.00;
	if ( handicap2[ index ] ) hTotal += 4.00;
	if ( handicap3[ index ] ) hTotal += 8.00;
	if ( handicap4[ index ] ) hTotal += 4.00;
	if ( handicap5[ index ] ) hTotal += 6.00;
	if ( handicap6[ index ] ) hTotal += 12.00;
	if ( handicap7[ index ] )
	{
		if ( mode[ index ] == 3 || mode[ index ] == 4 && sparks_p[ index ] >= 0 )
			hTotal += 8.00;
		else
			hTotal += 4.00;
	}
	if ( handicap8[ index ] ) hTotal += 12.00;
	if ( handicap9[ index ] ) hTotal += 4.00;
	if ( handicap10[ index ] ) hTotal += 4.00;
	if ( handicap11[ index ] ) hTotal += 6.00;
	if ( handicap12[ index ] ) hTotal += 4.00;
	if ( handicap13[ index ] ) hTotal += 10.00;
	
	if ( mode[ index ] != 4 )
		hTotal += permaincrease[ index ];
	
	// Increase XPGain based on medals
	if ( mode[ index ] == 2 )
		hTotal += 1.00 * medals[ index ];
	else if ( mode[ index ] == 3 )
		hTotal += 2.00 * medals_h[ index ];
	else if ( mode[ index ] == 4 )
		hTotal += 3.00 * medals_p[ index ];
	
	exp = exp * ( 100.0 + hTotal ) / 100.0;
	
	// Prevent division by zero caused by the discard of long floats ( 6+ digits )
	if ( exp <= 0.00 ) exp = 0.00001;
	
	return exp;
}

void scxpm_getrank( const int& in index )
{
	int rid;
	int pl = playerlevel[ index ];
	
	// 100% completition check
	if ( scxpm_calc_lvl( xp_e[ index ] ) == 640 && scxpm_calc_lvl( xp[ index ] ) == 565 && medals[ index ] == 42 && scxpm_calc_lvl( xp_h[ index ] ) == 1800 && medals_h[ index ] == 42 )
	{
		rid = 61;
	}
	else // Normal checking
	{
		if ( pl == 1800 )
		{
			rid = 60;
		}
		else if ( pl >= 1770 && pl <= 1799 )
		{
			rid = 59;
		}
		else if ( pl >= 1711 && pl <= 1769 )
		{
			rid = 58;
		}
		else if ( pl >= 1653 && pl <= 1710 )
		{
			rid = 57;
		}
		else if ( pl >= 1596 && pl <= 1652 )
		{
			rid = 56;
		}
		else if ( pl >= 1540 && pl <= 1595 )
		{
			rid = 55;
		}
		else if ( pl >= 1485 && pl <= 1539 )
		{
			rid = 54;
		}
		else if ( pl >= 1431 && pl <= 1484 )
		{
			rid = 53;
		}
		else if ( pl >= 1378 && pl <= 1430 )
		{
			rid = 52;
		}
		else if ( pl >= 1326 && pl <= 1377 )
		{
			rid = 51;
		}
		else if ( pl >= 1275 && pl <= 1325 )
		{
			rid = 50;
		}
		else if ( pl >= 1225 && pl <= 1274 )
		{
			rid = 49;
		}
		else if ( pl >= 1176 && pl <= 1224 )
		{
			rid = 48;
		}
		else if ( pl >= 1128 && pl <= 1175 )
		{
			rid = 47;
		}
		else if ( pl >= 1081 && pl <= 1127 )
		{
			rid = 46;
		}
		else if ( pl >= 1035 && pl <= 1080 )
		{
			rid = 45;
		}
		else if ( pl >= 990 && pl <= 1034 )
		{
			rid = 44;
		}
		else if ( pl >= 946 && pl <= 989 )
		{
			rid = 43;
		}
		else if ( pl >= 903 && pl <= 945 )
		{
			rid = 42;
		}
		else if ( pl >= 861 && pl <= 902 )
		{
			rid = 41;
		}
		else if ( pl >= 820 && pl <= 860 )
		{
			rid = 40;
		}
		else if ( pl >= 780 && pl <= 819 )
		{
			rid = 39;
		}
		else if ( pl >= 741 && pl <= 779 )
		{
			rid = 38;
		}
		else if ( pl >= 703 && pl <= 740 )
		{
			rid = 37;
		}
		else if ( pl >= 666 && pl <= 702 )
		{
			rid = 36;
		}
		else if ( pl >= 630 && pl <= 665 )
		{
			switch( mode[ index ] )
			{
				case 1:
					rid = 12; break;
				case 2:
					rid = 24; break;
				case 3:
					rid = 35; break;
			}
		}
		else if ( pl >= 595 && pl <= 629 )
		{
			switch( mode[ index ] )
			{
				case 1:
					rid = 12; break;
				case 2:
					rid = 23; break;
				case 3:
					rid = 34; break;
			}
		}
		else if ( pl >= 561 && pl <= 594 )
		{
			switch( mode[ index ] )
			{
				case 1:
					rid = 11; break;
				case 2:
					rid = 22; break;
				case 3:
					rid = 33; break;
			}
		}
		else if (pl >= 528 && pl <= 560 )
		{
			switch( mode[ index ] )
			{
				case 1:
					rid = 11; break;
				case 2:
					rid = 22; break;
				case 3:
					rid = 32; break;
			}
		}
		else if ( pl >= 496 && pl <= 527 )
		{
			switch( mode[ index ] )
			{
				case 1:
					rid = 11; break;
				case 2:
					rid = 21; break;
				case 3:
					rid = 31; break;
			}
		}
		else if ( pl >= 465 && pl <= 495 )
		{
			switch( mode[ index ] )
			{
				case 1:
					rid = 10; break;
				case 2:
					rid = 20; break;
				case 3:
					rid = 30; break;
			}
		}
		else if ( pl >= 435 && pl <= 464 )
		{
			switch( mode[ index ] )
			{
				case 1:
					rid = 10; break;
				case 2:
					rid = 20; break;
				case 3:
					rid = 29; break;
			}
		}
		else if ( pl >= 406 && pl <= 434 )
		{
			switch( mode[ index ] )
			{
				case 1:
					rid = 10; break;
				case 2:
					rid = 19; break;
				case 3:
					rid = 28; break;
			}
		}
		else if ( pl >= 378 && pl <= 405 )
		{
			switch( mode[ index ] )
			{
				case 1:
					rid = 9; break;
				case 2:
					rid = 18; break;
				case 3:
					rid = 27; break;
			}
		}
		else if ( pl >= 351 && pl <= 377 )
		{
			switch( mode[ index ] )
			{
				case 1:
					rid = 9; break;
				case 2:
					rid = 18; break;
				case 3:
					rid = 26; break;
			}
		}
		else if ( pl >= 325 && pl <= 350 )
		{
			switch( mode[ index ] )
			{
				case 1:
					rid = 9; break;
				case 2:
					rid = 17; break;
				case 3:
					rid = 25; break;
			}
		}
		else if ( pl >= 300 && pl <= 324 )
		{
			switch( mode[ index ] )
			{
				case 1:
					rid = 8; break;
				case 2:
					rid = 16; break;
				case 3:
					rid = 24; break;
			}
		}
		else if ( pl >= 276 && pl <= 299 )
		{
			switch( mode[ index ] )
			{
				case 1:
					rid = 8; break;
				case 2:
					rid = 16; break;
				case 3:
					rid = 23; break;
			}
		}
		else if ( pl >= 253 && pl <= 275 )
		{
			switch( mode[ index ] )
			{
				case 1:
					rid = 8; break;
				case 2:
					rid = 15; break;
				case 3:
					rid = 22; break;
			}
		}
		else if ( pl >= 231 && pl <= 252 )
		{
			switch( mode[ index ] )
			{
				case 1:
					rid = 7; break;
				case 2:
					rid = 14; break;
				case 3:
					rid = 21; break;
			}
		}
		else if ( pl >= 210 && pl <= 230 )
		{
			switch( mode[ index ] )
			{
				case 1:
					rid = 7; break;
				case 2:
					rid = 14; break;
				case 3:
					rid = 20; break;
			}
		}
		else if ( pl >= 190 && pl <= 209 )
		{
			switch( mode[ index ] )
			{
				case 1:
					rid = 7; break;
				case 2:
					rid = 13; break;
				case 3:
					rid = 19; break;
			}
		}
		else if ( pl >= 171 && pl <= 189 )
		{
			switch( mode[ index ] )
			{
				case 1:
					rid = 6; break;
				case 2:
					rid = 12; break;
				case 3:
					rid = 18; break;
			}
		}
		else if ( pl >= 153 && pl <= 170 )
		{
			switch( mode[ index ] )
			{
				case 1:
					rid = 6; break;
				case 2:
					rid = 12; break;
				case 3:
					rid = 17; break;
			}
		}
		else if ( pl >= 136 && pl <= 152 )
		{
			switch( mode[ index ] )
			{
				case 1:
					rid = 6; break;
				case 2:
					rid = 11; break;
				case 3:
					rid = 16; break;
			}
		}
		else if ( pl >= 120 && pl <= 135 )
		{
			switch( mode[ index ] )
			{
				case 1:
					rid = 5; break;
				case 2:
					rid = 10; break;
				case 3:
					rid = 15; break;
			}
		}
		else if ( pl >= 105 && pl <= 119 )
		{
			switch( mode[ index ] )
			{
				case 1:
					rid = 5; break;
				case 2:
					rid = 10; break;
				case 3:
					rid = 14; break;
			}
		}
		else if ( pl >= 91 && pl <= 104 )
		{
			switch( mode[ index ] )
			{
				case 1:
					rid = 5; break;
				case 2:
					rid = 9; break;
				case 3:
					rid = 13; break;
			}
		}
		else if ( pl >= 78 && pl <= 90 )
		{
			switch( mode[ index ] )
			{
				case 1:
					rid = 4; break;
				case 2:
					rid = 8; break;
				case 3:
					rid = 12; break;
			}
		}
		else if ( pl >= 66 && pl <= 77 )
		{
			switch( mode[ index ] )
			{
				case 1:
					rid = 4; break;
				case 2:
					rid = 8; break;
				case 3:
					rid = 11; break;
			}
		}
		else if ( pl >= 55 && pl <= 65 )
		{
			switch( mode[ index ] )
			{
				case 1:
					rid = 4; break;
				case 2:
					rid = 7; break;
				case 3:
					rid = 10; break;
			}
		}
		else if ( pl >= 45 && pl <= 54 )
		{
			switch( mode[ index ] )
			{
				case 1:
					rid = 3; break;
				case 2:
					rid = 6; break;
				case 3:
					rid = 9; break;
			}
		}
		else if ( pl >= 36 && pl <= 44 )
		{
			switch( mode[ index ] )
			{
				case 1:
					rid = 3; break;
				case 2:
					rid = 6; break;
				case 3:
					rid = 8; break;
			}
		}
		else if ( pl >= 28 && pl <= 35 )
		{
			switch( mode[ index ] )
			{
				case 1:
					rid = 3; break;
				case 2:
					rid = 5; break;
				case 3:
					rid = 7; break;
			}
		}
		else if ( pl >= 21 && pl <= 27 )
		{
			switch( mode[ index ] )
			{
				case 1:
					rid = 2; break;
				case 2:
					rid = 4; break;
				case 3:
					rid = 6; break;
			}
		}
		else if ( pl >= 15 && pl <= 20 )
		{
			switch( mode[ index ] )
			{
				case 1:
					rid = 2; break;
				case 2:
					rid = 4; break;
				case 3:
					rid = 5; break;
			}
		}
		else if ( pl >= 10 && pl <= 14 )
		{
			switch( mode[ index ] )
			{
				case 1:
					rid = 2; break;
				case 2:
					rid = 3; break;
				case 3:
					rid = 4; break;
			}
		}
		else if ( pl >= 6 && pl <= 9 )
		{
			switch( mode[ index ] )
			{
				case 1:
					rid = 1; break;
				case 2:
					rid = 2; break;
				case 3:
					rid = 3; break;
			}
		}
		else if ( pl >= 3 && pl <= 5 )
		{
			switch( mode[ index ] )
			{
				case 1:
					rid = 1; break;
				case 2:
					rid = 2; break;
				case 3:
					rid = 2; break;
			}
		}
		else if ( pl >= 1 && pl <= 2 )
		{
			switch( mode[ index ] )
			{
				case 1:
					rid = 1; break;
				case 2:
					rid = 1; break;
				case 3:
					rid = 1; break;
			}
		}
		else
		{
			if ( pl > 640 && mode[ index ] == 1 || pl > 565 && mode[ index ] == 2 || pl > 1800 && mode[ index ] == 3 )
				rid = 62;
			else
				rid = 0;
		}
	}
	
	rank[ index ] = rid;
}

void scxpm_mode( const int& in index )
{
	CBasePlayer@ pPlayer = g_PlayerFuncs.FindPlayerByIndex( index );
	MenuHandler@ state = MenuGetPlayer( pPlayer );
	
	state.InitMenu( pPlayer, scxpm_mode_cb );
	
	string szTitle = "Seleccion de Modalidad\n\nTus habilidades se reiniciaran\nal cambiar de modalidad\n";
	if ( mode[ index ] == 3 && !pPlayer.IsAlive() && !gHardIgnore || mode[ index ] == 4 && sparks_p[ index ] >= 0 && !pPlayer.IsAlive() && !gHardIgnore )
		szTitle += "\nADVERTENCIA: Estas muerto.\nPerderas un Suministro Auxiliar\nsi cambias de modalidad ahora!\n";
	if ( gDelayedXP )
		szTitle += "\nADVERTENCIA: Perderas toda\nla EXP que hayas adquirido\nsi cambias de modalidad ahora!\n";
	state.menu.SetTitle( szTitle );
	
	float e_progress = float( scxpm_calc_lvl( xp_e[ index ] ) ) * 100.0 / 640.0;
	float n_progress = float( scxpm_calc_lvl( xp[ index ] ) ) * 50.0 / 565.0 + float( medals[ index ] ) * 50.0 / 42.0;
	float h_progress = float( scxpm_calc_lvl( xp_h[ index ] ) ) * 50.0 / 1800.0 + float( medals_h[ index ] ) * 50.0 / 42.0;
	
	string easytext = "Modo Facil [ " + fl2Decimals( e_progress ) + "% ]\n";
	string normaltext = "Modo Normal [ " + fl2Decimals( n_progress ) + "% ]\n";
	string hardtext = "Modo Dificil [ " + fl2Decimals( h_progress ) + "% ]\n\n";
	
	state.menu.AddItem( easytext, any( "item1" ) );
	state.menu.AddItem( normaltext, any( "item2" ) );
	state.menu.AddItem( hardtext, any( "item3" ) );
	
	if ( IsChampion( pPlayer ) )
	{
		string sandtext = "Modo Sandbox [ Nivel " + AddCommas( scxpm_calc_lvl( xp_p[ index ] ) );
		if ( maxmedals_p[ index ] > 0 )
			sandtext += " | " + medals_p[ index ] + " Medallas";
		sandtext += " ]\n\n";
		
		state.menu.AddItem( sandtext, any( "item4" ) );
	}
	
	state.OpenMenu( pPlayer, 0, 0 );
}

void scxpm_mode_cb( CTextMenu@ menu, CBasePlayer@ pPlayer, int page, const CTextMenuItem@ item )
{
	int index = pPlayer.entindex();
	if ( page == 10 ) return;
	
	string selection;
	item.m_pUserData.retrieve( selection );
	if ( selection == 'item1' )
	{
		if ( mode[ index ] == 1 )
			g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "[SCXPM] Ya estas en Modo Facil\n" );
		else
		{
			g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "[SCXPM] Cambiaste tu modalidad a Modo Facil. Recuerda volver a elegir tus habilidades\n" );
			if ( pPlayer.pev.deadflag != DEAD_NO && mode[ index ] == 3 && sparks[ index ] > 0 && !gHardIgnore || pPlayer.pev.deadflag != DEAD_NO && mode[ index ] == 4 && sparks_p[ index ] >= 0 && !gHardIgnore )
				sparks[ index ]--;
			mode[ index ] = 1;
			playerlevel[ index ] = scxpm_calc_lvl( xp_e[ index ] );
			scxpm_calcneedxp( index );
			scxpm_getrank( index );
			earnedxp[ index ] = 0;
			g_Scheduler.SetTimeout( "scxpm_mreset", 0.75, index );
			
			if ( pPlayer.pev.deadflag == DEAD_NO )
			{
				// Manual force-kill
				pPlayer.pev.solid = SOLID_NOT;
				pPlayer.GibMonster();
				pPlayer.pev.effects |= EF_NODRAW;
				pPlayer.pev.health = 0;
				pPlayer.pev.deadflag = DEAD_DEAD;
			}
			
			// Custom death message, let people know his cause of death
			string szDeathMsg = "" + pPlayer.pev.netname + " switched to Easy Mode.\n";
			
			NetworkMessage deathmsg( MSG_ALL, NetworkMessages::TextMsg );
			deathmsg.WriteByte( 1 );
			deathmsg.WriteString( szDeathMsg );
			deathmsg.End();
			
			// If the player was spectating, turn off the respawn delay
			if ( bIsSpectating[ index ] )
			{
				bIsSpectating[ index ] = false;
				pPlayer.m_flRespawnDelayTime = 0.0;
			}
		}
	}
	else if ( selection == 'item2' )
	{
		if ( mode[ index ] == 2 )
			g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "[SCXPM] Ya estas en Modo Normal\n" );
		else
		{
			g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "[SCXPM] Cambiaste tu modalidad a Modo Normal. Recuerda volver a elegir tus habilidades\n" );
			if ( pPlayer.pev.deadflag != DEAD_NO && mode[ index ] == 3 && sparks[ index ] > 0 && !gHardIgnore || pPlayer.pev.deadflag != DEAD_NO && mode[ index ] == 4 && sparks_p[ index ] >= 0 && !gHardIgnore )
				sparks[ index ]--;
			mode[ index ] = 2;
			playerlevel[ index ] = scxpm_calc_lvl( xp[ index ] );
			scxpm_calcneedxp( index );
			scxpm_getrank( index );
			earnedxp[ index ] = 0;
			g_Scheduler.SetTimeout( "scxpm_mreset", 0.75, index );
			
			if ( pPlayer.pev.deadflag == DEAD_NO )
			{
				// Manual force-kill
				pPlayer.pev.solid = SOLID_NOT;
				pPlayer.GibMonster();
				pPlayer.pev.effects |= EF_NODRAW;
				pPlayer.pev.health = 0;
				pPlayer.pev.deadflag = DEAD_DEAD;
			}
			
			// Custom death message, let people know his cause of death
			string szDeathMsg = "" + pPlayer.pev.netname + " switched to Normal Mode.\n";
			
			NetworkMessage deathmsg( MSG_ALL, NetworkMessages::TextMsg );
			deathmsg.WriteByte( 1 );
			deathmsg.WriteString( szDeathMsg );
			deathmsg.End();
			
			// If the player was spectating, turn off the respawn delay
			if ( bIsSpectating[ index ] )
			{
				bIsSpectating[ index ] = false;
				pPlayer.m_flRespawnDelayTime = 0.0;
			}
		}
	}
	else if ( selection == 'item3' )
	{
		if ( mode[ index ] == 3 )
			g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "[SCXPM] Ya estas en Modo Dificil\n" );
		else if ( hkey[ index ] == 0 )
		{
			g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "[SCXPM] Cambiaste tu modalidad a Modo Dificil. Recuerda volver a elegir tus habilidades\n" );
			mode[ index ] = 3;
			playerlevel[ index ] = scxpm_calc_lvl( xp_h[ index ] );
			scxpm_calcneedxp( index );
			scxpm_getrank( index );
			earnedxp[ index ] = 0;
			g_Scheduler.SetTimeout( "scxpm_mreset", 0.75, index );
			
			if ( pPlayer.pev.deadflag == DEAD_NO )
			{
				// Manual force-kill
				pPlayer.pev.solid = SOLID_NOT;
				pPlayer.GibMonster();
				pPlayer.pev.effects |= EF_NODRAW;
				pPlayer.pev.health = 0;
				pPlayer.pev.deadflag = DEAD_DEAD;
			}
			
			// Custom death message, let people know his cause of death
			string szDeathMsg = "" + pPlayer.pev.netname + " switched to Hard Mode.\n";
			
			NetworkMessage deathmsg( MSG_ALL, NetworkMessages::TextMsg );
			deathmsg.WriteByte( 1 );
			deathmsg.WriteString( szDeathMsg );
			deathmsg.End();
			
			// Set this bit. We do not want abuse
			bChangeHard[ index ] = true;
		}
		else
			g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "[SCXPM] Este modo esta bloqueado. Escribe /hard seguido del codigo para desbloquearlo\n" );
	}
	else if ( selection == 'item4' )
		g_Scheduler.SetTimeout( "Champion_SandboxMenu", 0.01, index );
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
	
	skillpoints[ index ] = playerlevel[ index ];
	
	if ( ( bData[ index ] & SS_DISPENCER ) != 0 )
		bData[ index ] &= ~SS_DISPENCER;
	if ( ( bData[ index ] & SS_RANGEHEAL ) != 0 )
		bData[ index ] &= ~SS_RANGEHEAL;
	
	spawndmg[ index ] = 0;
	ubercharge[ index ] = 0;
	freefall[ index ] = 0;
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
}

void scxpm_hard_welcome( const int& in index )
{
	CBasePlayer@ pPlayer = g_PlayerFuncs.FindPlayerByIndex( index );
	
	sparks[ index ]++;
	g_PlayerFuncs.RespawnPlayer( pPlayer, false, true );
	
	g_Scheduler.SetTimeout( "scxpm_hard_welcome_fix", 0.05, index );
}

void scxpm_hard_welcome_fix( const int& in index )
{
	CBasePlayer@ pPlayer = g_PlayerFuncs.FindPlayerByIndex( index );
	MenuHandler@ state = MenuGetPlayer( pPlayer );
	state.InitMenu( pPlayer, scxpm_hard_welcome_cb );
	state.menu.SetTitle( "Hola, soy el creador de este SCXPM\n\nVeo que has activado el Modo Dificil\n\n\nHay algunas cosas que debes tener\n\nen cuenta a partir de ahora...\n\n\n" );
	
	state.menu.AddItem( "Guiame, por favor\n", any( "item1" ) );
	state.menu.AddItem( "Estare bien, gracias", any( "item2" ) );
	state.OpenMenu( pPlayer, 0, 0 );
}

void scxpm_hard_welcome_cb( CTextMenu@ menu, CBasePlayer@ pPlayer, int page, const CTextMenuItem@ item )
{
	int index = pPlayer.entindex();
	if ( page == 10 )
	{
		g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "[SCXPM] Buena suerte...\n" );
		return;
	}
	
	string selection;
	item.m_pUserData.retrieve( selection );
	if ( selection == 'item1' )
		scxpm_hard_tutorial( index );
	else if ( selection == 'item2' )
		g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "[SCXPM] Buena suerte...\n" );
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
}

void scxpm_block_handicaps()
{
	can_edit_handicaps = false;
	bSaveOldSkills = true;
}

void scxpm_handicaps( const int& in index, const int& in iPage = 0 )
{
	CBasePlayer@ pPlayer = g_PlayerFuncs.FindPlayerByIndex( index );
	
	if ( mode[ index ] == 1 )
	{
		g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "[SCXPM] No puedes usar esto en Modo Facil\n" );
		return;
	}
	
	if ( gNoSkills )
	{
		g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "[SCXPM] No puedes usar Desventajas en mapas con Habilidades desactivadas\n" );
		return;
	}
	
	MenuHandler@ state = MenuGetPlayer( pPlayer );
	
	state.InitMenu( pPlayer, scxpm_handicaps_cb );
	
	int percent = 0;
	if ( handicap1[ index ] ) percent += 10;
	if ( handicap2[ index ] ) percent += 4;
	if ( handicap3[ index ] ) percent += 8;
	if ( handicap4[ index ] ) percent += 4;
	if ( handicap5[ index ] ) percent += 6;
	if ( handicap6[ index ] ) percent += 12;
	if ( handicap7[ index ] )
	{
		if ( mode[ index ] == 3 || mode[ index ] == 4 && sparks_p[ index ] >= 0 )
			percent += 8;
		else
			percent += 4;
	}
	if ( handicap8[ index ] ) percent += 12;
	if ( handicap9[ index ] ) percent += 4;
	if ( handicap10[ index ] ) percent += 4;
	if ( handicap11[ index ] ) percent += 6;
	if ( handicap12[ index ] ) percent += 4;
	if ( handicap13[ index ] ) percent += 10;
	
	string title = "Desventajas\n\n\n" + "+" + percent + "% Ganancia de EXP\n\n";
	
	state.menu.SetTitle( title );
	
	string hc1text = "Sin Impulsos ";
	if ( handicap1[ index ] )
		hc1text += "[ SI ]\n";
	else
		hc1text += "[ NO ]\n";
	
	string hc2text = "Regeneracion en OFF ";
	if ( handicap2[ index ] )
		hc2text += "[ SI ]\n";
	else
		hc2text += "[ NO ]\n";
	
	string hc3text = "Equipo ausente ";
	if ( handicap3[ index ] )
		hc3text += "[ SI ]\n";
	else
		hc3text += "[ NO ]\n";
	
	string hc4text = "Atraccion de Ataques ";
	if ( handicap4[ index ] )
		hc4text += "[ SI ]\n";
	else
		hc4text += "[ NO ]\n";
	
	string hc5text = "Fobia Medicinal ";
	if ( handicap5[ index ] )
		hc5text += "[ SI ]\n";
	else
		hc5text += "[ NO ]\n";
	
	string hc6text = "Tecnologia Obsoleta ";
	if ( handicap6[ index ] )
		hc6text += "[ SI ]\n";
	else
		hc6text += "[ NO ]\n";
	
	string hc7text = "Nitrogeno en Sangre ";
	if ( handicap7[ index ] )
		hc7text += "[ SI ]\n";
	else
		hc7text += "[ NO ]\n";
	
	string hc8text = "Retribucion Karmica ";
	if ( handicap8[ index ] )
		hc8text += "[ SI ]\n";
	else
		hc8text += "[ NO ]\n";
	
	string hc9text = "Realismo ";
	if ( handicap9[ index ] )
		hc9text += "[ SI ]\n";
	else
		hc9text += "[ NO ]\n";
	
	string hc10text = "Explosion Fuerte ";
	if ( handicap10[ index ] )
		hc10text += "[ SI ]\n";
	else
		hc10text += "[ NO ]\n";
	
	string hc11text = "Equipamiento Limitado ";
	if ( handicap11[ index ] )
		hc11text += "[ SI ]\n";
	else
		hc11text += "[ NO ]\n";
	
	string hc12text = "Peso Muerto ";
	if ( handicap12[ index ] )
		hc12text += "[ SI ]\n";
	else
		hc12text += "[ NO ]\n";
	
	string hc13text = "Escaso Auxilio ";
	if ( handicap13[ index ] )
		hc13text += "[ SI ]\n";
	else
		hc13text += "[ NO ]\n";
	
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
	
	state.OpenMenu( pPlayer, 0, iPage );
}

void scxpm_handicaps_cb( CTextMenu@ menu, CBasePlayer@ pPlayer, int page, const CTextMenuItem@ item )
{
	int index = pPlayer.entindex();
	if ( page == 10 ) return;
	
	if ( !can_edit_handicaps )
	{
		g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "[SCXPM] Solo puedes ajustar tus desventajas al principio de cada mapa\n" );
		g_Scheduler.SetTimeout( "scxpm_handicaps", 0.01, index, 0 );
		return;
	}
	
	CustomKeyvalues@ pHandicaps = pPlayer.GetCustomKeyvalues();
	
	string selection;
	item.m_pUserData.retrieve( selection );
	if ( selection == 'item1' )
	{
		if ( !handicap1[ index ] )
		{
			handicap1[ index ] = true;
			pHandicaps.SetKeyvalue( "$i_handicap01", 1 );
		}
		else
		{
			handicap1[ index ] = false;
			pHandicaps.SetKeyvalue( "$i_handicap01", 0 );
		}
		g_Scheduler.SetTimeout( "scxpm_handicaps", 0.01, index, 0 );
	}
	else if ( selection == 'item2' )
	{
		if ( !handicap2[ index ] )
		{
			handicap2[ index ] = true;
			pHandicaps.SetKeyvalue( "$i_handicap02", 1 );
		}
		else
		{
			handicap2[ index ] = false;
			pHandicaps.SetKeyvalue( "$i_handicap02", 0 );
		}
		g_Scheduler.SetTimeout( "scxpm_handicaps", 0.01, index, 0 );
	}
	else if ( selection == 'item3' )
	{
		if ( !handicap3[ index ] )
		{
			handicap3[ index ] = true;
			pHandicaps.SetKeyvalue( "$i_handicap03", 1 );
		}
		else
		{
			handicap3[ index ] = false;
			pHandicaps.SetKeyvalue( "$i_handicap03", 0 );
		}
		g_Scheduler.SetTimeout( "scxpm_handicaps", 0.01, index, 0 );
	}
	else if ( selection == 'item4' )
	{
		if ( !handicap4[ index ] )
		{
			handicap4[ index ] = true;
			pHandicaps.SetKeyvalue( "$i_handicap04", 1 );
			pPlayer.pev.flags &= ~FL_GODMODE; // Force turn-off godmode, prevents exploitation
		}
		else
		{
			handicap4[ index ] = false;
			pHandicaps.SetKeyvalue( "$i_handicap04", 0 );
		}
		g_Scheduler.SetTimeout( "scxpm_handicaps", 0.01, index, 0 );
	}
	else if ( selection == 'item5' )
	{
		if ( !handicap5[ index ] )
		{
			handicap5[ index ] = true;
			pHandicaps.SetKeyvalue( "$i_handicap05", 1 );
		}
		else
		{
			handicap5[ index ] = false;
			pHandicaps.SetKeyvalue( "$i_handicap05", 0 );
		}
		g_Scheduler.SetTimeout( "scxpm_handicaps", 0.01, index, 0 );
	}
	else if ( selection == 'item6' )
	{
		if ( !handicap6[ index ] )
		{
			handicap6[ index ] = true;
			pHandicaps.SetKeyvalue( "$i_handicap06", 1 );
		}
		else
		{
			handicap6[ index ] = false;
			pHandicaps.SetKeyvalue( "$i_handicap06", 0 );
		}
		g_Scheduler.SetTimeout( "scxpm_handicaps", 0.01, index, 0 );
	}
	else if ( selection == 'item7' )
	{
		if ( !handicap7[ index ] )
		{
			handicap7[ index ] = true;
			pHandicaps.SetKeyvalue( "$i_handicap07", 1 );
		}
		else
		{
			handicap7[ index ] = false;
			pHandicaps.SetKeyvalue( "$i_handicap07", 0 );
		}
		g_Scheduler.SetTimeout( "scxpm_handicaps", 0.01, index, 0 );
	}
	else if ( selection == 'item8' )
	{
		if ( !handicap8[ index ] )
		{
			handicap8[ index ] = true;
			pHandicaps.SetKeyvalue( "$i_handicap08", 1 );
		}
		else
		{
			handicap8[ index ] = false;
			pHandicaps.SetKeyvalue( "$i_handicap08", 0 );
		}
		g_Scheduler.SetTimeout( "scxpm_handicaps", 0.01, index, 1 );
	}
	else if ( selection == 'item9' )
	{
		if ( !handicap9[ index ] )
		{
			NetworkMessage hc9( MSG_ONE_UNRELIABLE, NetworkMessages::HideHUD, pPlayer.edict() );
			hc9.WriteByte( 11 );
			hc9.End();
			
			handicap9[ index ] = true;
			pHandicaps.SetKeyvalue( "$i_handicap09", 1 );
		}
		else
		{
			NetworkMessage hc9( MSG_ONE_UNRELIABLE, NetworkMessages::HideHUD, pPlayer.edict() );
			hc9.WriteByte( 0 );
			hc9.End();
			
			handicap9[ index ] = false;
			pHandicaps.SetKeyvalue( "$i_handicap09", 0 );
		}
		g_Scheduler.SetTimeout( "scxpm_handicaps", 0.01, index, 1 );
	}
	else if ( selection == 'item10' )
	{
		if ( !handicap10[ index ] )
		{
			handicap10[ index ] = true;
			pHandicaps.SetKeyvalue( "$i_handicap10", 1 );
		}
		else
		{
			handicap10[ index ] = false;
			pHandicaps.SetKeyvalue( "$i_handicap10", 0 );
		}
		g_Scheduler.SetTimeout( "scxpm_handicaps", 0.01, index, 1 );
	}
	else if ( selection == 'item11' )
	{
		if ( !handicap11[ index ] )
		{
			handicap11[ index ] = true;
			pHandicaps.SetKeyvalue( "$i_handicap11", 1 );
		}
		else
		{
			handicap11[ index ] = false;
			pHandicaps.SetKeyvalue( "$i_handicap11", 0 );
		}
		g_Scheduler.SetTimeout( "scxpm_handicaps", 0.01, index, 1 );
	}
	else if ( selection == 'item12' )
	{
		if ( !handicap12[ index ] )
		{
			handicap12[ index ] = true;
			pHandicaps.SetKeyvalue( "$i_handicap12", 1 );
		}
		else
		{
			handicap12[ index ] = false;
			pHandicaps.SetKeyvalue( "$i_handicap12", 0 );
		}
		g_Scheduler.SetTimeout( "scxpm_handicaps", 0.01, index, 1 );
	}
	else if ( selection == 'item13' )
	{
		if ( !handicap13[ index ] )
		{
			handicap13[ index ] = true;
			pHandicaps.SetKeyvalue( "$i_handicap13", 1 );
		}
		else
		{
			handicap13[ index ] = false;
			pHandicaps.SetKeyvalue( "$i_handicap13", 0 );
		}
		g_Scheduler.SetTimeout( "scxpm_handicaps", 0.01, index, 1 );
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
			
			if ( playerlevel[ i ] >= 640 && mode[ i ] == 1 )
				xp_e[ i ] = 1473884;
			else if ( playerlevel[ i ] >= 565 && mode[ i ] == 2 )
				xp[ i ] = 1152847;
			else if ( playerlevel[ i ] >= 1800 && mode[ i ] == 3 )
				xp_h[ i ] = 11453365;
			else if ( playerlevel[ i ] >= maxlevel_p[ i ] && mode[ i ] == 4 && maxlevel_p[ i ] != -1 )
				xp_p[ i ] = scxpm_calc_xp( maxlevel_p[ i ] ) + 1;
			else
			{
				switch( mode[ i ] )
				{
					case 1:
					{
						float exp = scxpm_calc_xpgain( i );
						
						// Only add XP directly if it ain't delayed
						if ( !gDelayedXP )
						{
							float easyvar = float( xp_e[ i ] ) / 5.0 / ( exp * ( expamp[ i ] + 1 ) ) + pPlayer.pev.frags - lastfrags[ i ];
							xp_e[ i ] = floatround( easyvar * 5.0 * ( exp * ( expamp[ i ] + 1 ) ) );
						}
						
						float earnvar1 = float( earnedxp[ i ] ) / 5.0 / ( exp * ( expamp[ i ] + 1 ) ) + pPlayer.pev.frags - lastfrags[ i ];
						earnedxp[ i ] = floatround( earnvar1 * 5.0 * ( exp * ( expamp[ i ] + 1 ) ) );
						break;
					}
					case 2:
					{
						float exp = scxpm_calc_xpgain( i );
						
						if ( !gDelayedXP )
						{
							float normalvar = float( xp[ i ] ) / 5.0 / ( exp * ( expamp[ i ] + 1 ) ) + pPlayer.pev.frags - lastfrags[ i ];
							xp[ i ] = floatround( normalvar * 5.0 * ( exp * ( expamp[ i ] + 1 ) ) );
						}
						
						float earnvar2 = float( earnedxp[ i ] ) / 5.0 / ( exp * ( expamp[ i ] + 1 ) ) + pPlayer.pev.frags - lastfrags[ i ];
						earnedxp[ i ] = floatround( earnvar2 * 5.0 * ( exp * ( expamp[ i ] + 1 ) ) );
						break;
					}
					case 3:
					{
						float exp = scxpm_calc_xpgain( i );
						
						if ( !gDelayedXP )
						{
							float hardvar = float( xp_h[ i ] ) / 5.0 / ( exp * ( expamp[ i ] + 1 ) ) + pPlayer.pev.frags - lastfrags[ i ];
							xp_h[ i ] = floatround( hardvar * 5.0 * ( exp * ( expamp[ i ] + 1 ) ) );
						}
						
						float earnvar2 = float( earnedxp[ i ] ) / 5.0 / ( exp * ( expamp[ i ] + 1 ) ) + pPlayer.pev.frags - lastfrags[ i ];
						earnedxp[ i ] = floatround( earnvar2 * 5.0 * ( exp * ( expamp[ i ] + 1 ) ) );
						break;
					}
					case 4:
					{
						float exp = scxpm_calc_xpgain( i );
						
						if ( !gDelayedXP )
						{
							float sandvar = float( xp_p[ i ] ) / 5.0 / ( exp * ( expamp[ i ] + 1 ) ) + pPlayer.pev.frags - lastfrags[ i ];
							xp_p[ i ] = floatround( sandvar * 5.0 * ( exp * ( expamp[ i ] + 1 ) ) );
						}
						
						float earnvar2 = float( earnedxp[ i ] ) / 5.0 / ( exp * ( expamp[ i ] + 1 ) ) + pPlayer.pev.frags - lastfrags[ i ];
						earnedxp[ i ] = floatround( earnvar2 * 5.0 * ( exp * ( expamp[ i ] + 1 ) ) );
						break;
					}
				}
			}
			
			scxpm_savedata( i );
			scxpm_saveachievement( i );
			scxpm_checkachievement( i );
			lastfrags[ i ] = pPlayer.pev.frags;
			
			switch( mode[ i ] )
			{
				case 1:
				{
					if ( xp_e[ i ] > neededxp[ i ] && playerlevel[ i ] < 640 )
					{
						int playerlevelOld = playerlevel[ i ];
						playerlevel[ i ] = scxpm_calc_lvl( xp_e[ i ] );
						
						skillpoints[ i ] += playerlevel[ i ] - playerlevelOld;
						
						if ( skillpoints[ i ] >= playerlevel[ i ] + 1 )
							skillpoints[ i ]--;
						
						scxpm_calcneedxp( i );
						
						string name = pPlayer.pev.netname;
						string steamid = g_EngineFuncs.GetPlayerAuthId( pPlayer.edict() );
						if ( playerlevel[ i ] == 640 )
						{
							g_PlayerFuncs.ClientPrintAll( HUD_PRINTTALK, "[SCXPM] " + name + " acaba de completar el Modo Facil al 100%%!\n" );
							g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTCENTER, "Modo Facil completado!\n" );
							
							g_SoundSystem.EmitSoundDyn( pPlayer.edict(), CHAN_STREAM, "ambience/goal_1.wav", VOL_NORM, ATTN_NONE, SND_SKIP_ORIGIN_USE_ENT, PITCH_NORM, i );
							
							g_Game.AlertMessage( at_logged, "[SCXPM] " + name + " (" + steamid + ") completo el Modo Facil al 100%%\n" );
							SCXPM_Log( "" + name + " (" + steamid + ") completo el Modo Facil al 100%%\n" );
							
							// Completition reward
							AddPermaIncrease( i, "30.0#Imperial de Bronce#Modo Facil completado al 100%!n!n+30% Ganancia de EXP!n\n" );
							
							// Check if ALL modes are cleared
							if ( scxpm_calc_lvl( xp_e[ i ] ) == 640 && scxpm_calc_lvl( xp[ i ] ) == 565 && medals[ i ] == 42 && scxpm_calc_lvl( xp_h[ i ] ) == 1800 && medals_h[ i ] == 42 )
							{
								// Blow me down...
								g_PlayerFuncs.ClientPrintAll( HUD_PRINTTALK, "[SCXPM] TENEMOS UN NUEVO CAMPEON! Salve " + name + ", nuevo Campeon Imperial!!!!\n" );
								g_PlayerFuncs.ClientPrintAll( HUD_PRINTTALK, "[SCXPM] TODAS LAS MODALIDADES COMPLETADAS AL 100%%!!!!\n" );
								
								g_Game.AlertMessage( at_logged, "[SCXPM] " + name + " (" + steamid + ") se ha coronado Campeon Imperial\n" );
								SCXPM_Log( "" + name + " (" + steamid + ") se ha coronado Campeon Imperial\n" );
								
								// Just so the line is not that long
								string szMessage = "";
								szMessage += "Este jugador ha logrado atravesar todos los";
								szMessage += "!ndesafios y reiteradas frustraciones con";
								szMessage += "!ncada una de las modalidades!n!n";
								szMessage += "Paciencia en la Modalidad Facil!n";
								szMessage += "Conocimiento en la Modalidad Normal!n";
								szMessage += "Destreza en la Modalidad Dificil!n";
								szMessage += "!nPero sobre todo, determinacion en la";
								szMessage += " tarea!ndefinitiva de completar tres";
								szMessage += " veces cada nivel!ny medalla del sistema";
								szMessage += "!n!nUn jugador, cuya meta de progreso es";
								szMessage += " ilimitada!nUn jugador, que no se rinde";
								szMessage += " ante ninguna tarea!n!nEL jugador, un";
								szMessage += " campeon de nuestro Imperium";
								
								AddPermaIncrease( i, "0.0#Campeon#" + szMessage + "!n!nMENCION HONORIFICA!n\n" );
								
								// SCXPMSkill( i ) will override the welcome menu if called instanly, call it with a delay
								g_Scheduler.SetTimeout( "scxpm_champion_welcome", 0.02, i );
							}
						}
						else
						{
							g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "[SCXPM] Bien hecho " + name + "! Subiste al nivel " + AddCommas( playerlevel[ i ] ) + "!\n" );
							g_Game.AlertMessage( at_logged, "[SCXPM] " + name + " (" + steamid + ") alcanzo el nivel " + AddCommas( playerlevel[ i ] ) + " [Modo Facil]\n" );
							SCXPM_Log( "" + name + " (" + steamid + ") alcanzo el nivel " + AddCommas( playerlevel[ i ] ) + " [Modo Facil]\n" );
							
							float e_progress = float( scxpm_calc_lvl( xp_e[ i ] ) ) * 100.0 / 640.0;
							float n_progress = float( scxpm_calc_lvl( xp[ i ] ) ) * 50.0 / 565.0 + float( medals[ i ] ) * 50.0 / 42.0;
							
							if ( e_progress >= 10.00 && n_progress >= 5.00 && !( ( bData[ i ] & HKEY_NOTICED ) != 0 ) )
							{
								g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "[SCXPM] Psst! Oye! Te dire esto solo una vez, asi que presta atencion!\n" );
								g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "[SCXPM] Tu codigo para activar el Modo Dificil es: " + hkey[ i ] + "\n" );
								bData[ i ] |= HKEY_NOTICED;
							}
							
							// Level goal rewards
							if ( playerlevel[ i ] == 320 && !HasPermaIncrease( i, "Determinacion I" ) )
								AddPermaIncrease( i, "10.0#Determinacion I#Alcanzado el Nivel 320 en Modo Facil!n!n+10% Ganancia de EXP!n\n" );
						}
						
						g_SoundSystem.EmitSoundDyn( pPlayer.edict(), CHAN_STATIC, "ecsc/scxpm/levelup.ogg", VOL_NORM, ATTN_NONE, SND_SKIP_ORIGIN_USE_ENT, PITCH_NORM, i );
						
						scxpm_getrank( i );
						SCXPMSkill( i );
					}
					break;
				}
				case 2:
				{
					if ( xp[ i ] > neededxp[ i ] && playerlevel[ i ] < 565 )
					{
						int playerlevelOld = playerlevel[ i ];
						playerlevel[ i ] = scxpm_calc_lvl( xp[ i ] );
						
						skillpoints[ i ] += playerlevel[ i ] - playerlevelOld;
						
						if ( skillpoints[ i ] >= playerlevel[ i ] + 1 )
							skillpoints[ i ]--;
						
						scxpm_calcneedxp( i );
						
						string name = pPlayer.pev.netname;
						string steamid = g_EngineFuncs.GetPlayerAuthId( pPlayer.edict() );
						if ( playerlevel[ i ] == 565 && medals[ i ] == 42 )
						{
							g_PlayerFuncs.ClientPrintAll( HUD_PRINTTALK, "[SCXPM] " + name + " acaba de completar el Modo Normal al 100%%!!\n" );
							g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTCENTER, "Modo Normal completado!!\n" );
							
							g_SoundSystem.EmitSoundDyn( pPlayer.edict(), CHAN_STREAM, "ambience/goal_1.wav", VOL_NORM, ATTN_NONE, SND_SKIP_ORIGIN_USE_ENT, PITCH_NORM, i );
							
							g_Game.AlertMessage( at_logged, "[SCXPM] " + name + " (" + steamid + ") completo el Modo Normal al 100%%\n" );
							SCXPM_Log( "" + name + " (" + steamid + ") completo el Modo Normal al 100%%\n" );
							
							// Completition reward
							AddPermaIncrease( i, "60.0#Imperial de Plata#Modo Normal completado al 100%!n!n+60% Ganancia de EXP!n\n" );
							
							// Ctrl+C
							if ( scxpm_calc_lvl( xp_e[ i ] ) == 640 && scxpm_calc_lvl( xp[ i ] ) == 565 && medals[ i ] == 42 && scxpm_calc_lvl( xp_h[ i ] ) == 1800 && medals_h[ i ] == 42 )
							{
								g_PlayerFuncs.ClientPrintAll( HUD_PRINTTALK, "[SCXPM] TENEMOS UN NUEVO CAMPEON! Salve " + name + ", nuevo Campeon Imperial!!!!\n" );
								g_PlayerFuncs.ClientPrintAll( HUD_PRINTTALK, "[SCXPM] TODAS LAS MODALIDADES COMPLETADAS AL 100%%!!!!\n" );
								
								g_Game.AlertMessage( at_logged, "[SCXPM] " + name + " (" + steamid + ") se ha coronado Campeon Imperial\n" );
								SCXPM_Log( "" + name + " (" + steamid + ") se ha coronado Campeon Imperial\n" );
								
								string szMessage = "";
								szMessage += "Este jugador ha logrado atravesar todos los";
								szMessage += "!ndesafios y reiteradas frustraciones con";
								szMessage += "!ncada una de las modalidades!n!n";
								szMessage += "Paciencia en la Modalidad Facil!n";
								szMessage += "Conocimiento en la Modalidad Normal!n";
								szMessage += "Destreza en la Modalidad Dificil!n";
								szMessage += "!nPero sobre todo, determinacion en la";
								szMessage += " tarea!ndefinitiva de completar tres";
								szMessage += " veces cada nivel!ny medalla del sistema";
								szMessage += "!n!nUn jugador, cuya meta de progreso es";
								szMessage += " ilimitada!nUn jugador, que no se rinde";
								szMessage += " ante ninguna tarea!n!nEL jugador, un";
								szMessage += " campeon de nuestro Imperium";
								
								AddPermaIncrease( i, "0.0#Campeon#" + szMessage + "!n!nMENCION HONORIFICA!n\n" );
								
								g_Scheduler.SetTimeout( "scxpm_champion_welcome", 0.02, i );
							}
						}
						else
						{
							g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "[SCXPM] Bien hecho " + name + "! Subiste al nivel " + AddCommas( playerlevel[ i ] ) + "!\n" );
							g_Game.AlertMessage( at_logged, "[SCXPM] " + name + " (" + steamid + ") alcanzo el nivel " + AddCommas( playerlevel[ i ] ) + " [Modo Normal]\n" );
							SCXPM_Log( "" + name + " (" + steamid + ") alcanzo el nivel " + AddCommas( playerlevel[ i ] ) + " [Modo Normal]\n" );
							
							float e_progress = float( scxpm_calc_lvl( xp_e[ i ] ) ) * 100.0 / 640.0;
							float n_progress = float( scxpm_calc_lvl( xp[ i ] ) ) * 50.0 / 565.0 + float( medals[ i ] ) * 50.0 / 42.0;
							
							if ( e_progress >= 10.00 && n_progress >= 5.00 && !( ( bData[ i ] & HKEY_NOTICED ) != 0 ) )
							{
								g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "[SCXPM] Psst! Oye! Te dire esto solo una vez, asi que presta atencion!\n" );
								g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "[SCXPM] Tu codigo para activar el Modo Dificil es: " + hkey[ i ] + "\n" );
								bData[ i ] |= HKEY_NOTICED;
							}
							
							// Level goal rewards
							if ( playerlevel[ i ] == 185 && !HasPermaIncrease( i, "Determinacion II" ) )
								AddPermaIncrease( i, "20.0#Determinacion II#Alcanzado el Nivel 185 en Modo Normal!n!n+20% Ganancia de EXP!n\n" );
							else if ( playerlevel[ i ] == 370 && !HasPermaIncrease( i, "Determinacion III" ) )
								AddPermaIncrease( i, "30.0#Determinacion III#Alcanzado el Nivel 370 en Modo Normal!n!n+30% Ganancia de EXP!n\n" );
						}
						
						g_SoundSystem.EmitSoundDyn( pPlayer.edict(), CHAN_STATIC, "ecsc/scxpm/levelup.ogg", VOL_NORM, ATTN_NONE, SND_SKIP_ORIGIN_USE_ENT, PITCH_NORM, i );
						
						scxpm_getrank( i );
						SCXPMSkill( i );
					}
					break;
				}
				case 3:
				{
					if ( xp_h[ i ] > neededxp[ i ] && playerlevel[ i ] < 1800 )
					{
						int playerlevelOld = playerlevel[ i ];
						playerlevel[ i ] = scxpm_calc_lvl( xp_h[ i ] );
						
						skillpoints[ i ] += playerlevel[ i ] - playerlevelOld;
						
						if ( skillpoints[ i ] >= playerlevel[ i ] + 1 )
							skillpoints[ i ]--;
						
						scxpm_calcneedxp( i );
						
						string name = pPlayer.pev.netname;
						string steamid = g_EngineFuncs.GetPlayerAuthId( pPlayer.edict() );
						if ( playerlevel[ i ] == 1800 && medals_h[ i ] == 42 )
						{
							g_PlayerFuncs.ClientPrintAll( HUD_PRINTTALK, "[SCXPM] " + name + " acaba de completar el Modo Dificil al 100%%!!!\n" );
							g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTCENTER, "Modo Dificil completado!!!\n" );
							
							g_SoundSystem.EmitSoundDyn( pPlayer.edict(), CHAN_STREAM, "ambience/goal_1.wav", VOL_NORM, ATTN_NONE, SND_SKIP_ORIGIN_USE_ENT, PITCH_NORM, i );
							
							g_Game.AlertMessage( at_logged, "[SCXPM] " + name + " (" + steamid + ") completo el Modo Dificil al 100%%\n" );
							SCXPM_Log( "" + name + " (" + steamid + ") completo el Modo Dificil al 100%%\n" );
							
							// Completition reward
							AddPermaIncrease( i, "90.0#Imperial de Oro#Modo Dificil completado al 100%!n!n+90% Ganancia de EXP!n\n" );
							
							// Ctrl+V
							if ( scxpm_calc_lvl( xp_e[ i ] ) == 640 && scxpm_calc_lvl( xp[ i ] ) == 565 && medals[ i ] == 42 && scxpm_calc_lvl( xp_h[ i ] ) == 1800 && medals_h[ i ] == 42 )
							{
								g_PlayerFuncs.ClientPrintAll( HUD_PRINTTALK, "[SCXPM] TENEMOS UN NUEVO CAMPEON! Salve " + name + ", nuevo Campeon Imperial!!!!\n" );
								g_PlayerFuncs.ClientPrintAll( HUD_PRINTTALK, "[SCXPM] TODAS LAS MODALIDADES COMPLETADAS AL 100%%!!!!\n" );
								
								g_Game.AlertMessage( at_logged, "[SCXPM] " + name + " (" + steamid + ") se ha coronado Campeon Imperial\n" );
								SCXPM_Log( "" + name + " (" + steamid + ") se ha coronado Campeon Imperial\n" );
								
								string szMessage = "";
								szMessage += "Este jugador ha logrado atravesar todos los";
								szMessage += "!ndesafios y reiteradas frustraciones con";
								szMessage += "!ncada una de las modalidades!n!n";
								szMessage += "Paciencia en la Modalidad Facil!n";
								szMessage += "Conocimiento en la Modalidad Normal!n";
								szMessage += "Destreza en la Modalidad Dificil!n";
								szMessage += "!nPero sobre todo, determinacion en la";
								szMessage += " tarea!ndefinitiva de completar tres";
								szMessage += " veces cada nivel!ny medalla del sistema";
								szMessage += "!n!nUn jugador, cuya meta de progreso es";
								szMessage += " ilimitada!nUn jugador, que no se rinde";
								szMessage += " ante ninguna tarea!n!nEL jugador, un";
								szMessage += " campeon de nuestro Imperium";
								
								AddPermaIncrease( i, "0.0#Campeon#" + szMessage + "!n!nMENCION HONORIFICA!n\n" );
								
								g_Scheduler.SetTimeout( "scxpm_champion_welcome", 0.02, i );
							}
						}
						else
						{
							g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "[SCXPM] Bien hecho " + name + "! Subiste al nivel " + AddCommas( playerlevel[ i ] ) + "!\n" );
							g_Game.AlertMessage( at_logged, "[SCXPM] " + name + " (" + steamid + ") alcanzo el nivel " + AddCommas( playerlevel[ i ] ) + " [Modo Dificil]\n" );
							SCXPM_Log( "" + name + " (" + steamid + ") alcanzo el nivel " + AddCommas( playerlevel[ i ] ) + " [Modo Dificil]\n" );
							
							int spark_luck = Math.RandomLong( 1, 100 );
							int extra_luck1 = 0;
							int extra_luck2 = 0;
							
							if ( scxpm_calc_lvl( xp_e[ i ] ) == 640 ) extra_luck1 = 5;
							if ( scxpm_calc_lvl( xp[ i ] ) == 565 ) extra_luck2 = 5;
							
							int need_luck = ( 5 + extra_luck1 + extra_luck2 ) * ( playerlevel[ i ] - playerlevelOld );
							if ( need_luck > 100 ) need_luck = 100;
							
							if ( spark_luck <= need_luck && sparks[ i ] < 100 ) // Clamp the Sparks of Life
							{
								sparks[ i ]++;
								g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "[SCXPM] Excelente trabajo hasta ahora! Has adquirido un Suministro Auxiliar\n" );
								g_SoundSystem.EmitSoundDyn( pPlayer.edict(), CHAN_STREAM, "items/gunpickup2.wav", VOL_NORM, ATTN_NONE, SND_SKIP_ORIGIN_USE_ENT, PITCH_NORM, i );
							}
							else if ( spark_luck <= need_luck && sparks[ i ] >= 100 )
							{
								// Don't loop forever!
								if ( !bSparkReward[ i ] )
								{
									g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "[SCXPM] Eres increible! Por alcanzar la maxima cantidad de Suministros Auxiliares has adquirido una bonificacion de EXP!\n" );
									g_SoundSystem.EmitSoundDyn( pPlayer.edict(), CHAN_STREAM, "items/gunpickup2.wav", VOL_NORM, ATTN_NONE, SND_SKIP_ORIGIN_USE_ENT, PITCH_NORM, i );
									
									xp_h[ i ] += 18000;
									earnedxp[ i ] += 18000;
									
									bSparkReward[ i ] = true;
								}
								else
									bSparkReward[ i ] = false;
							}
							
							// Level goal rewards
							if ( playerlevel[ i ] == 360 && !HasPermaIncrease( i, "Determinacion IV" ) )
								AddPermaIncrease( i, "40.0#Determinacion IV#Alcanzado el Nivel 360 en Modo Dificil!n!n+40% Ganancia de EXP!n\n" );
							else if ( playerlevel[ i ] == 720 && !HasPermaIncrease( i, "Determinacion V" ) )
								AddPermaIncrease( i, "50.0#Determinacion V#Alcanzado el Nivel 720 en Modo Dificil!n!n+50% Ganancia de EXP!n\n" );
							else if ( playerlevel[ i ] == 1080 && !HasPermaIncrease( i, "Determinacion VI" ) )
								AddPermaIncrease( i, "60.0#Determinacion VI#Alcanzado el Nivel 1,080 en Modo Dificil!n!n+60% Ganancia de EXP!n\n" );
							else if ( playerlevel[ i ] == 1440 && !HasPermaIncrease( i, "Determinacion VII" ) )
								AddPermaIncrease( i, "70.0#Determinacion VII#Alcanzado el Nivel 1,440 en Modo Dificil!n!n+70% Ganancia de EXP!n\n" );
						}
						
						g_SoundSystem.EmitSoundDyn( pPlayer.edict(), CHAN_STATIC, "ecsc/scxpm/levelup.ogg", VOL_NORM, ATTN_NONE, SND_SKIP_ORIGIN_USE_ENT, PITCH_NORM, i );
						
						scxpm_getrank( i );
						SCXPMSkill( i );
					}
					break;
				}
				case 4:
				{
					if ( xp_p[ i ] > neededxp[ i ] && playerlevel[ i ] < maxlevel_p[ i ] )
					{
						int playerlevelOld = playerlevel[ i ];
						playerlevel[ i ] = scxpm_calc_lvl( xp_p[ i ] );
						
						skillpoints[ i ] += playerlevel[ i ] - playerlevelOld;
						
						if ( skillpoints[ i ] >= playerlevel[ i ] + 1 )
							skillpoints[ i ]--;
						
						scxpm_calcneedxp( i );
						
						string name = pPlayer.pev.netname;
						string steamid = g_EngineFuncs.GetPlayerAuthId( pPlayer.edict() );
						if ( playerlevel[ i ] == maxlevel_p[ i ] && medals_p[ i ] == maxmedals_p[ i ] )
						{
							g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "[SCXPM] Excelente! Has completado tu partida del Modo Sandbox al 100%%!!\n" );
							g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTCENTER, "Partida Sandbox completada!!\n" );
							
							g_SoundSystem.EmitSoundDyn( pPlayer.edict(), CHAN_STREAM, "ambience/goal_1.wav", VOL_NORM, ATTN_NONE, SND_SKIP_ORIGIN_USE_ENT, PITCH_NORM, i );
						}
						else
						{
							g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "[SCXPM] Bien hecho " + name + "! Subiste al nivel " + AddCommas( playerlevel[ i ] ) + "!\n" );
							
							// Sparks of Life are active?
							if ( sparks_p[ i ] >= 0 )
							{
								int spark_luck = Math.RandomLong( 1, 100 );
								int need_luck = 8 * ( playerlevel[ i ] - playerlevelOld );
								if ( need_luck > 100 ) need_luck = 100;
								
								if ( spark_luck <= need_luck ) // Don't clamp on Sandbox
								{
									sparks_p[ i ]++;
									g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "[SCXPM] Excelente trabajo hasta ahora! Has adquirido un Suministro Auxiliar\n" );
									g_SoundSystem.EmitSoundDyn( pPlayer.edict(), CHAN_STREAM, "items/gunpickup2.wav", VOL_NORM, ATTN_NONE, SND_SKIP_ORIGIN_USE_ENT, PITCH_NORM, i );
								}
							}
						}
						
						g_SoundSystem.EmitSoundDyn( pPlayer.edict(), CHAN_STATIC, "ecsc/scxpm/levelup.ogg", VOL_NORM, ATTN_NONE, SND_SKIP_ORIGIN_USE_ENT, PITCH_NORM, i );
						
						SCXPMSkill( i );
					}
					break;
				}
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
		
		// Check for total unlcoked achievements, give special reward if criteria is met
		int iNewUnlocks = GetAchievementClear( index );
		switch( iNewUnlocks )
		{
			case 35: AddPermaIncrease( index, "10.0#Casualidad#35 logros completados!n!n+10% Ganancia de EXP!n\n" ); break;
			case 65: AddPermaIncrease( index, "10.0#Cazarrecompensas#65 logros completados!n!n+10% Ganancia de EXP!n\n" ); break;
			case 100: AddPermaIncrease( index, "10.0#Maxima dedicacion#100 logros completados!n!n+10% Ganancia de EXP!n\n" ); break;
			case 135: AddPermaIncrease( index, "10.0#Historiador#135 logros completados!n!n+10% Ganancia de EXP!n\n" ); break;
			case 165: AddPermaIncrease( index, "10.0#Quema mapas#165 logros completados!n!n+10% Ganancia de EXP!n\n" ); break;
			case 200: AddPermaIncrease( index, "10.0#Obsesion completista#200 logros completados!n!n+10% Ganancia de EXP!n\n" ); break;
		}
		
		// Get achievement name on a different string so ToUppercase() does not overwrite the array (it's const btw)
		string szFixedName = szAchievementNames[ iUnlock ];
		szFixedName.ToUppercase();
		
		g_PlayerFuncs.ClientPrintAll( HUD_PRINTTALK, "[SCXPM] " + name + " ha adquirido el logro " + szFixedName + "\n" );
		g_Game.AlertMessage( at_logged, "[SCXPM] " + name + " (" + steamid + ") ha adquirido el logro " + szFixedName + "\n" );
		SCXPM_Log( "" + name + " (" + steamid + ") ha adquirido el logro " + szFixedName + "\n" );
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

void scxpm_xpgain( const int& in index )
{
	CBasePlayer@ pPlayer = g_PlayerFuncs.FindPlayerByIndex( index );
	
	float exp = scxpm_calc_xpgain( index );
	
	if ( MAP_XPGAIN == 0.00001 || exp == 0.00001 )
		g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "[SCXPM] La Ganancia de EXP en este mapa esta deshabilitada\n" );
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
			g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "[SCXPM] Ganancia de EXP en este mapa: x" + exp + " (" + points + " EXP cada 1 punto)\n" );
		else
			g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "[SCXPM] Ganancia de EXP en este mapa: x" + exp + " (" + points + " EXP cada " + need + " puntos)\n" );
		
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
			else szMinutes = "" + minutes + "m";
			
			string szHours;
			if ( hours < 10 ) szHours = "0" + hours + "h";
			else szHours = "" + hours + "h";
			
			string szDays;
			if ( days < 10 ) szDays = "0" + days + "d";
			else szDays = "" + days + "d";
			
			g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "[SCXPM] Tu Amplificador de EXP de Nivel " + expamp[ index ] + " expira en " + szDays + " " + szHours + " " + szMinutes + "\n" );
		}
	}
}

void scxpm_buysparks( const int& in index )
{
	CBasePlayer@ pPlayer = g_PlayerFuncs.FindPlayerByIndex( index );
	
	if ( hkey[ index ] > 0 )
	{
		g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "[SCXPM] Primero debes activar el Modo Dificil\n" );
		return;
	}
	
	if ( mode[ index ] == 4 )
	{
		g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "[SCXPM] No disponible en Modo Sandbox\n" );
		return;
	}
	
	MenuHandler@ state = MenuGetPlayer( pPlayer );
	
	state.InitMenu( pPlayer, scxpm_buysparks_cb );
	
	state.menu.SetTitle( "Suministros Auxiliares\n\nComprar usando niveles del:\n\n" );
	
	state.menu.AddItem( "Modo Facil [ 36 Niveles ]\n", any( "item1" ) );
	state.menu.AddItem( "Modo Normal [ 18 Niveles ]\n", any( "item2" ) );
	state.menu.AddItem( "Modo Dificil [ 9 Niveles ]\n", any( "item3" ) );
	
	state.OpenMenu( pPlayer, 0, 0 );
}

void scxpm_buysparks_cb( CTextMenu@ menu, CBasePlayer@ pPlayer, int page, const CTextMenuItem@ item )
{
	int index = pPlayer.entindex();
	if ( page == 10 ) return;
	
	string selection;
	item.m_pUserData.retrieve( selection );
	if ( selection == 'item1' )
	{
		if ( scxpm_calc_lvl( xp_e[ index ] ) == 640 )
			g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "[SCXPM] El Modo Facil esta completado al 100%% y ya no puede ser usado en la compra de Suministros Auxiliares\n" );
		else if ( sparks[ index ] >= 100 )
			g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "[SCXPM] Requerir mas de 100 Suministros Auxiliares es claro signo de demencia\n" );
		else if ( scxpm_calc_lvl( xp_e[ index ] ) >= 36 )
		{
			int level = scxpm_calc_lvl( xp_e[ index ] );
			level -= 36;
			xp_e[ index ] = scxpm_calc_xp( level );
			
			if ( mode[ index ] == 1 )
			{
				g_Scheduler.SetTimeout( "scxpm_breset", 0.75, index, true );
				playerlevel[ index ] = scxpm_calc_lvl( xp_e[ index ] );
				scxpm_calcneedxp( index );
				scxpm_getrank( index );
				g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "[SCXPM] Tus habilidades se han reiniciado. Recuerda volverlas a elegir!\n" );
			}
			
			if ( sparks[ index ] <= 0 )
				sparks[ index ] = 2;
			else
				sparks[ index ]++;
			
			g_SoundSystem.EmitSoundDyn( pPlayer.edict(), CHAN_STATIC, "items/gunpickup2.wav", VOL_NORM, ATTN_NONE, SND_SKIP_ORIGIN_USE_ENT, PITCH_NORM, index );
			g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "[SCXPM] Compraste un Suministro Auxiliar!\n" );
		}
		else
			g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "[SCXPM] No tienes suficientes niveles en Modo Facil\n" );
		
		g_Scheduler.SetTimeout( "scxpm_buysparks", 0.01, index );
	}
	else if ( selection == 'item2' )
	{
		if ( scxpm_calc_lvl( xp[ index ] ) == 565 && medals[ index ] == 42 )
			g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "[SCXPM] El Modo Normal esta completado al 100%% y ya no puede ser usado en la compra de Suministros Auxiliares\n" );
		else if ( sparks[ index ] >= 100 )
			g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "[SCXPM] Requerir mas de 100 Suministros Auxiliares es claro signo de demencia\n" );
		else if ( scxpm_calc_lvl( xp[ index ] ) >= 18 )
		{
			int level = scxpm_calc_lvl( xp[ index ] );
			level -= 18;
			xp[ index ] = scxpm_calc_xp( level );
			
			if ( mode[ index ] == 2 )
			{
				g_Scheduler.SetTimeout( "scxpm_breset", 0.75, index, true );
				playerlevel[ index ] = scxpm_calc_lvl( xp[ index ] );
				scxpm_calcneedxp( index );
				scxpm_getrank( index );
				g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "[SCXPM] Tus habilidades se han reiniciado. Recuerda volverlas a elegir!\n" );
			}
			
			if ( sparks[ index ] <= 0 )
				sparks[ index ] = 2;
			else
				sparks[ index ]++;
			
			g_SoundSystem.EmitSoundDyn( pPlayer.edict(), CHAN_STATIC, "items/gunpickup2.wav", VOL_NORM, ATTN_NONE, SND_SKIP_ORIGIN_USE_ENT, PITCH_NORM, index );
			g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "[SCXPM] Compraste un Suministro Auxiliar!\n" );
		}
		else
			g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "[SCXPM] No tienes suficientes niveles en Modo Normal\n" );
		
		g_Scheduler.SetTimeout( "scxpm_buysparks", 0.01, index );
	}
	else if ( selection == 'item3' )
	{
		if ( scxpm_calc_lvl( xp_h[ index ] ) == 1800 && medals_h[ index ] == 42 )
			g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "[SCXPM] El Modo Dificil esta completado al 100%% y ya no puede ser usado en la compra de Suministros Auxiliares\n" );
		else if ( sparks[ index ] >= 100 )
			g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "[SCXPM] Requerir mas de 100 Suministros Auxiliares es claro signo de demencia\n" );
		else if ( scxpm_calc_lvl( xp_h[ index ] ) >= 9 )
		{
			int level = scxpm_calc_lvl( xp_h[ index ] );
			level -= 9;
			xp_h[ index ] = scxpm_calc_xp( level );
			
			if ( mode[ index ] == 3 )
			{
				g_Scheduler.SetTimeout( "scxpm_breset", 0.75, index, true );
				playerlevel[ index ] = scxpm_calc_lvl( xp_h[ index ] );
				scxpm_calcneedxp( index );
				scxpm_getrank( index );
				g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "[SCXPM] Tus habilidades se han reiniciado. Recuerda volverlas a elegir!\n" );
			}
			
			if ( sparks[ index ] <= 0 )
				sparks[ index ] = 2;
			else
				sparks[ index ]++;
			
			g_SoundSystem.EmitSoundDyn( pPlayer.edict(), CHAN_STATIC, "items/gunpickup2.wav", VOL_NORM, ATTN_NONE, SND_SKIP_ORIGIN_USE_ENT, PITCH_NORM, index );
			g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "[SCXPM] Compraste un Suministro Auxiliar!\n" );
		}
		else
			g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "[SCXPM] No tienes suficientes niveles en Modo Dificil\n" );
		
		g_Scheduler.SetTimeout( "scxpm_buysparks", 0.01, index );
	}
}

void scxpm_hudmain( const int& in index )
{
	CBasePlayer@ pPlayer = g_PlayerFuncs.FindPlayerByIndex( index );
	MenuHandler@ state = MenuGetPlayer( pPlayer );
	
	state.InitMenu( pPlayer, scxpm_hudmain_cb );
	state.menu.SetTitle( "Modificar HUD\n\n" );
	
	string opaquetext = "HUD Opaco? ";
	if ( hud_alpha[ index ] == 250 )
		opaquetext += "[ SI ]\n";
	else
		opaquetext += "[ NO ]\n";
	
	state.menu.AddItem( "Color Principal\n", any( "item1" ) );
	state.menu.AddItem( "Posicion\n", any( "item2" ) );
	state.menu.AddItem( "Efecto\n", any( "item3" ) );
	state.menu.AddItem( opaquetext, any( "item4" ) );
	state.menu.AddItem( "Color de Efecto\n", any( "item5" ) );
	state.menu.AddItem( "Velocidad de Efecto\n", any( "item6" ) );
	state.menu.AddItem( "Visual\n", any( "item7" ) );
	
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
	state.menu.SetTitle( "Color Principal\n\n" );
	
	state.menu.AddItem( "Predeterminado\n\n", any( "item1" ) );
	state.menu.AddItem( "Blanco\n", any( "item2" ) );
	state.menu.AddItem( "Rojo\n", any( "item3" ) );
	state.menu.AddItem( "Verde\n", any( "item4" ) );
	state.menu.AddItem( "Azul\n", any( "item5" ) );
	state.menu.AddItem( "Amarillo\n", any( "item6" ) );
	state.menu.AddItem( "Rosa\n", any( "item7" ) );
	state.menu.AddItem( "Cian\n\n", any( "item8" ) );
	state.menu.AddItem( "Personalizado\n", any( "item9" ) );
	
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
	
	string szTitle = "Personalizado\n\n";
	szTitle += "Puedes escribir un comando especial\n";
	szTitle += "para utilizar cualquier color que tu\n";
	szTitle += "desees. Para esto, usa el comando:\n\n";
	szTitle += "/hudcolor <RRR> <GGG> <BBB>\n\n";
	szTitle += "Donde R, G y B es el color escrito\n";
	szTitle += "en Codigo RGB. Por ejemplo, para\n";
	szTitle += "obtener un color Naranja, escribes:\n\n";
	szTitle += "/hudcolor 255 128 000\n";
	
	state.menu.SetTitle( szTitle );
	state.menu.AddItem( "Volver", any( "item1" ) );
	
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
			
			g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "[SCXPM] Color ajustado\n" );
		}
		else
		{
			g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "[SCXPM] Parametros insuficientes o incorrectos\n" );
			g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "[SCXPM] Modo de uso: /hudcolor <RRR> <GGG> <BBB>. Donde R, G y B es un color escrito en Codigo RGB\n" );
			g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "[SCXPM] Solo se permiten numeros entre 000 y 255\n" );
		}
	}
	else
	{
		g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "[SCXPM] Modo de uso: /hudcolor <RRR> <GGG> <BBB>. Donde R, G y B es un color escrito en Codigo RGB\n" );
		g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "[SCXPM] Cambia el color del HUD al color especificado en el comando\n" );
	}
}

void scxpm_hudposition( const int& in index )
{
	CBasePlayer@ pPlayer = g_PlayerFuncs.FindPlayerByIndex( index );
	MenuHandler@ state = MenuGetPlayer( pPlayer );
	
	state.InitMenu( pPlayer, scxpm_hudposition_cb );
	state.menu.SetTitle( "Posicion\n\n" );
	
	state.menu.AddItem( "Predeterminado\n\n", any( "item1" ) );
	state.menu.AddItem( "Mover arriba\n", any( "item2" ) );
	state.menu.AddItem( "Mover abajo\n", any( "item3" ) );
	state.menu.AddItem( "Mover a la izquierda\n", any( "item4" ) );
	state.menu.AddItem( "Mover a la derecha\n", any( "item5" ) );
	
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
		hud_pos_x[ index ] = 0.5;
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
	state.menu.SetTitle( "Efecto\n\n" );
	
	state.menu.AddItem( "Ninguno\n", any( "item1" ) );
	state.menu.AddItem( "Titileo\n", any( "item2" ) );
	state.menu.AddItem( "Escaner\n", any( "item3" ) );
	
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
	state.menu.SetTitle( "Color de Efecto\n\n" );
	
	state.menu.AddItem( "Blanco\n", any( "item1" ) );
	state.menu.AddItem( "Rojo\n", any( "item2" ) );
	state.menu.AddItem( "Verde\n", any( "item3" ) );
	state.menu.AddItem( "Azul\n", any( "item4" ) );
	state.menu.AddItem( "Amarillo\n", any( "item5" ) );
	state.menu.AddItem( "Rosa\n", any( "item6" ) );
	state.menu.AddItem( "Cian\n", any( "item7" ) );
	
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
	state.menu.SetTitle( "Velocidad de Efecto\n\nSolo funciona en el efecto Escaner\n\n" );
	
	state.menu.AddItem( "Muy Lenta\n", any( "item1" ) );
	state.menu.AddItem( "Lenta\n", any( "item2" ) );
	state.menu.AddItem( "Media\n", any( "item3" ) );
	state.menu.AddItem( "Rapida\n", any( "item4" ) );
	state.menu.AddItem( "Muy Rapida\n", any( "item5" ) );
	
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
	state.menu.SetTitle( "Visual\n\n" );
	
	string view1;
	if ( ( bData[ index ] & HUD_EXP ) != 0 )
		view1 += "Mostrar EXP? [ SI ]\n";
	else
		view1 += "Mostrar EXP? [ NO ]\n";
	
	string view2;
	if ( ( bData[ index ] & HUD_EXPLEFT ) != 0 )
		view2 += "Mostrar EXP restante? [ SI ]\n";
	else
		view2 += "Mostrar EXP restante? [ NO ]\n";
	
	string view3;
	if ( ( bData[ index ] & HUD_EXPEARN ) != 0 )
		view3 += "Mostrar EXP adquirida? [ SI ]\n";
	else
		view3 += "Mostrar EXP adquirida? [ NO ]\n";
	
	string view4;
	if ( ( bData[ index ] & HUD_LEVEL ) != 0 )
		view4 += "Mostrar nivel? [ SI ]\n";
	else
		view4 += "Mostrar nivel? [ NO ]\n";
	
	string view5;
	if ( ( bData[ index ] & HUD_CLASS ) != 0 )
		view5 += "Mostrar clase? [ SI ]\n";
	else
		view5 += "Mostrar clase? [ NO ]\n";
	
	string view6;
	if ( ( bData[ index ] & HUD_MEDALS ) != 0 )
		view6 += "Mostrar medallas? [ SI ]\n";
	else
		view6 += "Mostrar medallas? [ NO ]\n";
	
	state.menu.AddItem( view1, any( "item1" ) );
	state.menu.AddItem( view2, any( "item2" ) );
	state.menu.AddItem( view3, any( "item3" ) );
	state.menu.AddItem( view4, any( "item4" ) );
	state.menu.AddItem( view5, any( "item5" ) );
	state.menu.AddItem( view6, any( "item6" ) );
	
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
}

void scxpm_showdata()
{
	for ( int i = 1; i <= g_Engine.maxClients; i++ )
	{
		CBasePlayer@ pPlayer = g_PlayerFuncs.FindPlayerByIndex( i );
		
		if ( pPlayer !is null && pPlayer.IsConnected() )
		{
			string hudtext;
			
			if ( playerlevel[ i ] >= 640 && mode[ i ] == 1 )
			{
				if ( ( bData[ i ] & HUD_LEVEL ) != 0 )
					hudtext += "Nivel: " + AddCommas( playerlevel[ i ] ) + "\n";
				
				if ( ( bData[ i ] & HUD_CLASS ) != 0 )
					hudtext += "Clase: " + ranks[ rank[ i ] ] + "\n";
			}
			else if ( playerlevel[ i ] >= 565 && mode[ i ] == 2 || playerlevel[ i ] >= 1800 && mode[ i ] == 3 )
			{
				if ( ( bData[ i ] & HUD_LEVEL ) != 0 )
					hudtext += "Nivel: " + AddCommas( playerlevel[ i ] ) + "\n";
				
				if ( ( bData[ i ] & HUD_CLASS ) != 0 )
					hudtext += "Clase: " + ranks[ rank[ i ] ] + "\n";
				
				if ( ( bData[ i ] & HUD_MEDALS ) != 0 )
					hudtext += "Medallas: " + medals[ i ] + "\n";
			}
			else if ( playerlevel[ i ] >= maxlevel_p[ i ] && mode[ i ] == 4 )
			{
				if ( ( bData[ i ] & HUD_LEVEL ) != 0 )
					hudtext += "Nivel: " + AddCommas( playerlevel[ i ] ) + "\n";
				
				if ( maxmedals_p[ i ] > 0 )
				{
					if ( ( bData[ i ] & HUD_MEDALS ) != 0 )
						hudtext += "Medallas: " + medals_p[ i ] + "\n";
				}
			}
			else
			{
				switch( mode[ i ] )
				{
					case 1:
					{
						if ( ( bData[ i ] & HUD_EXP ) != 0 )
							hudtext += "EXP: " + AddCommas( xp_e[ i ] ) + "\n";
						
						if ( ( bData[ i ] & HUD_EXPLEFT ) != 0 )
							hudtext += "Te faltan " + AddCommas( neededxp[ i ] - xp_e[ i ] ) + " EXP para subir de nivel\n";
						break;
					}
					case 2:
					{
						if ( ( bData[ i ] & HUD_EXP ) != 0 )
							hudtext += "EXP: " + AddCommas( xp[ i ] ) + "\n";
						
						if ( ( bData[ i ] & HUD_EXPLEFT ) != 0 )
							hudtext += "Te faltan " + AddCommas( neededxp[ i ] - xp[ i ] ) + " EXP para subir de nivel\n";
						break;
					}
					case 3:
					{
						if ( ( bData[ i ] & HUD_EXP ) != 0 )
							hudtext += "EXP: " + AddCommas( xp_h[ i ] ) + "\n";
						
						if ( ( bData[ i ] & HUD_EXPLEFT ) != 0 )
							hudtext += "Te faltan " + AddCommas( neededxp[ i ] - xp_h[ i ] ) + " EXP para subir de nivel\n";
						break;
					}
					case 4:
					{
						if ( ( bData[ i ] & HUD_EXP ) != 0 )
							hudtext += "EXP: " + AddCommas( xp_p[ i ] ) + "\n";
						
						if ( ( bData[ i ] & HUD_EXPLEFT ) != 0 )
							hudtext += "Te faltan " + AddCommas( neededxp[ i ] - xp_p[ i ] ) + " EXP para subir de nivel\n";
						break;
					}
				}
				
				if ( gDelayedXP )
				{
					if ( earnedxp[ i ] >= 0 )
						hudtext += "Ganaras " + AddCommas( earnedxp[ i ] ) + " EXP si completas la mision\n";
					else
						hudtext += "Perderas " + AddCommas( int( abs( earnedxp[ i ] ) ) ) + " EXP al terminar la mision\n";
				}
				else if ( ( bData[ i ] & HUD_EXPEARN ) != 0 )
				{
					if ( earnedxp[ i ] >= 0 )
						hudtext += "Ganaste " + AddCommas( earnedxp[ i ] ) + " EXP en este mapa\n";
					else
						hudtext += "Perdiste " + AddCommas( int( abs( earnedxp[ i ] ) ) ) + " EXP en este mapa\n";
				}
				
				if ( ( bData[ i ] & HUD_LEVEL ) != 0 )
					hudtext += "Nivel: " + AddCommas( playerlevel[ i ] ) + "\n";
				
				if ( mode[ i ] != 4 )
				{
					if ( ( bData[ i ] & HUD_CLASS ) != 0 )
						hudtext += "Clase: " + ranks[ rank[ i ] ] + "\n";
				}
				
				if ( ( bData[ i ] & HUD_MEDALS ) != 0 )
				{
					if ( mode[ i ] == 2 )
						hudtext += "Medallas: " + medals[ i ] + "\n";
					else if ( mode[ i ] == 3 )
						hudtext += "Medallas: " + medals_h[ i ] + "\n";
					else if ( mode[ i ] == 4 && maxmedals_p[ i ] > 0 )
						hudtext += "Medallas: " + medals_p[ i ] + "\n";
				}
			}
			
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
			
			// Override the text if the player's data is corrupted
			if ( bCorruptData[ i ] )
			{
				textParams.x = 0.8;
				textParams.y = 0.2;
				textParams.r1 = 150;
				textParams.g1 = 50;
				textParams.b1 = 255;
				textParams.a1 = 250;
				
				hudtext = "***DATOS CORRUPTOS***\nEl archivo de guardado fue daniado y ya no\npuedes continuar progresando tu personaje\n\nContactate con el Staff para mas informacion";
			}
			
			g_PlayerFuncs.HudMessage( pPlayer, textParams, hudtext );
		}
	}
}

void scxpm_lvltomedal( const int& in index )
{
	CBasePlayer@ pPlayer = g_PlayerFuncs.FindPlayerByIndex( index );
	
	if ( mode[ index ] == 1 )
	{
		g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "[SCXPM] No puedes usar esto en Modo Facil\n" );
		return;
	}
	
	if ( mode[ index ] == 4 && maxmedals_p[ index ] == 0 )
	{
		g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "[SCXPM] La partida actual del Modo Sandbox no permite el uso de esta herramienta\n" );
		return;
	}
	
	MenuHandler@ state = MenuGetPlayer( pPlayer );
	
	state.InitMenu( pPlayer, scxpm_lvltomedal_cb );
	
	string title = "Resetear Nivel\n\n\nResetea tu nivel y\n\ngana medallas gratis!\n\n\n";
	switch( mode[ index ] )
	{
		case 2:
		{
			title += "   - 145 Niveles = 1 medalla\n\n   - 270 Niveles = 3 medallas\n\n   - 395 Niveles = 5 medallas\n\n   - 520 Niveles = 7 medallas\n\n";
			break;
		}
		case 3:
		{
			title += "   - 270 Niveles = 1 medalla\n\n   - 395 Niveles = 3 medallas\n\n   - 520 Niveles = 5 medallas\n\n   - 645 Niveles = 7 medallas\n\n";
			break;
		}
		case 4:
		{
			title += "   - 208 Niveles = 1 medalla\n\n   - 333 Niveles = 3 medallas\n\n   - 458 Niveles = 5 medallas\n\n   - 583 Niveles = 7 medallas\n\n";
			break;
		}
	}
	state.menu.SetTitle( title );
	
	state.menu.AddItem( "Resetear!\n", any( "item1" ) );
	
	state.OpenMenu( pPlayer, 0, 0 );
}

void scxpm_lvltomedal_cb( CTextMenu@ menu, CBasePlayer@ pPlayer, int page, const CTextMenuItem@ item )
{
	int index = pPlayer.entindex();
	if ( page == 10 ) return;
	
	if ( playerlevel[ index ] >= 145 && mode[ index ] == 2 || playerlevel[ index ] >= 270 && mode[ index ] == 3 || playerlevel[ index ] >= 208 && mode[ index ] == 4 )
	{
		if ( medals[ index ] < 42 && mode[ index ] == 2 || medals_h[ index ] < 42 && mode[ index ] == 3 || medals_p[ index ] < maxmedals_p[ index ] && mode[ index ] == 4 )
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
			
			switch( mode[ index ] )
			{
				case 2:
				{
					if ( playerlevel[ index ] >= 520 )
					{
						medals[ index ] += 7;
						if ( medals[ index ] > 42 )
							medals[ index ] = 42;
						
						g_SoundSystem.EmitSoundDyn( pPlayer.edict(), CHAN_STATIC, "ecsc/scxpm/medalget.ogg", VOL_NORM, ATTN_NONE, SND_SKIP_ORIGIN_USE_ENT, PITCH_NORM, index );
						
						string name = pPlayer.pev.netname;
						string steamid = g_EngineFuncs.GetPlayerAuthId( pPlayer.edict() );
						
						g_PlayerFuncs.ClientPrintAll( HUD_PRINTTALK, "[SCXPM] " + name + " gano 7 medallas por resetear! (Ahora tiene " + medals[ index ] + ")\n" );
						g_Game.AlertMessage( at_logged, "[SCXPM] " + name + " (" + steamid + ") gano 7 medallas por resetear. (Ahora tiene " + medals[ index ] + ") [Modo Normal]\n" );
						SCXPM_Log( "" + name + " (" + steamid + ") gano 7 medallas por resetear. (Ahora tiene " + medals[ index ] + ") [Modo Normal]\n" );
						
						playerlevel[ index ] -= 520;
						skillpoints[ index ] = playerlevel[ index ];
						
						if ( playerlevel[ index ] != 0 )
							xp[ index ] = scxpm_calc_xp( playerlevel[ index ] );
						else
							xp[ index ] = 0;
					}
					else if ( playerlevel[ index ] >= 395 )
					{
						medals[ index ] += 5;
						if ( medals[ index ] > 42 )
							medals[ index ] = 42;
						
						g_SoundSystem.EmitSoundDyn( pPlayer.edict(), CHAN_STATIC, "ecsc/scxpm/medalget.ogg", VOL_NORM, ATTN_NONE, SND_SKIP_ORIGIN_USE_ENT, PITCH_NORM, index );
						
						string name = pPlayer.pev.netname;
						string steamid = g_EngineFuncs.GetPlayerAuthId( pPlayer.edict() );
						
						g_PlayerFuncs.ClientPrintAll( HUD_PRINTTALK, "[SCXPM] " + name + " gano 5 medallas por resetear! (Ahora tiene " + medals[ index ] + ")\n" );
						g_Game.AlertMessage( at_logged, "[SCXPM] " + name + " (" + steamid + ") gano 5 medallas por resetear. (Ahora tiene " + medals[ index ] + ") [Modo Normal]\n" );
						SCXPM_Log( "" + name + " (" + steamid + ") gano 5 medallas por resetear. (Ahora tiene " + medals[ index ] + ") [Modo Normal]\n" );
						
						playerlevel[ index ] -= 395;
						skillpoints[ index ] = playerlevel[ index ];
						
						if ( playerlevel[ index ] != 0 )
							xp[ index ] = scxpm_calc_xp( playerlevel[ index ] );
						else
							xp[ index ] = 0;
					}
					else if ( playerlevel[ index ] >= 270 )
					{
						medals[ index ] += 3;
						if ( medals[ index ] > 42 )
							medals[ index ] = 42;
						
						g_SoundSystem.EmitSoundDyn( pPlayer.edict(), CHAN_STATIC, "ecsc/scxpm/medalget.ogg", VOL_NORM, ATTN_NONE, SND_SKIP_ORIGIN_USE_ENT, PITCH_NORM, index );
						
						string name = pPlayer.pev.netname;
						string steamid = g_EngineFuncs.GetPlayerAuthId( pPlayer.edict() );
						
						g_PlayerFuncs.ClientPrintAll( HUD_PRINTTALK, "[SCXPM] " + name + " gano 3 medallas por resetear! (Ahora tiene " + medals[ index ] + ")\n" );
						g_Game.AlertMessage( at_logged, "[SCXPM] " + name + " (" + steamid + ") gano 3 medallas por resetear. (Ahora tiene " + medals[ index ] + ") [Modo Normal]\n" );
						SCXPM_Log( "" + name + " (" + steamid + ") gano 3 medallas por resetear. (Ahora tiene " + medals[ index ] + ") [Modo Normal]\n" );
						
						playerlevel[ index ] -= 270;
						skillpoints[ index ] = playerlevel[ index ];
						
						if ( playerlevel[ index ] != 0 )
							xp[ index ] = scxpm_calc_xp( playerlevel[ index ] );
						else
							xp[ index ] = 0;
					}
					else if ( playerlevel[ index ] >= 145 )
					{
						medals[ index ]++;
						if ( medals[ index ] > 42 )
							medals[ index ] = 42;
						
						g_SoundSystem.EmitSoundDyn( pPlayer.edict(), CHAN_STATIC, "ecsc/scxpm/medalget.ogg", VOL_NORM, ATTN_NONE, SND_SKIP_ORIGIN_USE_ENT, PITCH_NORM, index );
						
						string name = pPlayer.pev.netname;
						string steamid = g_EngineFuncs.GetPlayerAuthId( pPlayer.edict() );
						
						g_PlayerFuncs.ClientPrintAll( HUD_PRINTTALK, "[SCXPM] " + name + " gano 1 medalla por resetear! (Ahora tiene " + medals[ index ] + ")\n" );
						g_Game.AlertMessage( at_logged, "[SCXPM] " + name + " (" + steamid + ") gano 1 medalla por resetear. (Ahora tiene " + medals[ index ] + ") [Modo Normal]\n" );
						SCXPM_Log( "" + name + " (" + steamid + ") gano 1 medalla por resetear. (Ahora tiene " + medals[ index ] + ") [Modo Normal]\n" );
						
						playerlevel[ index ] -= 145;
						skillpoints[ index ] = playerlevel[ index ];
						
						if ( playerlevel[ index ] != 0 )
							xp[ index ] = scxpm_calc_xp( playerlevel[ index ] );
						else
							xp[ index ] = 0;
					}
					break;
				}
				case 3:
				{
					if ( playerlevel[ index ] >= 645 )
					{
						medals_h[ index ] += 7;
						if ( medals_h[ index ] > 42 )
							medals_h[ index ] = 42;
						
						g_SoundSystem.EmitSoundDyn( pPlayer.edict(), CHAN_STATIC, "ecsc/scxpm/medalget.ogg", VOL_NORM, ATTN_NONE, SND_SKIP_ORIGIN_USE_ENT, PITCH_NORM, index );
						
						string name = pPlayer.pev.netname;
						string steamid = g_EngineFuncs.GetPlayerAuthId( pPlayer.edict() );
						
						g_PlayerFuncs.ClientPrintAll( HUD_PRINTTALK, "[SCXPM] " + name + " gano 7 medallas por resetear! (Ahora tiene " + medals_h[ index ] + ")\n" );
						g_Game.AlertMessage( at_logged, "[SCXPM] " + name + " (" + steamid + ") gano 7 medallas por resetear. (Ahora tiene " + medals_h[ index ] + ") [Modo Dificil]\n" );
						SCXPM_Log( "" + name + " (" + steamid + ") gano 7 medallas por resetear. (Ahora tiene " + medals_h[ index ] + ") [Modo Dificil]\n" );
						
						playerlevel[ index ] -= 645;
						skillpoints[ index ] = playerlevel[ index ];
						
						if ( playerlevel[ index ] != 0 )
							xp_h[ index ] = scxpm_calc_xp( playerlevel[ index ] );
						else
							xp_h[ index ] = 0;
					}
					else if ( playerlevel[ index ] >= 520 )
					{
						medals_h[ index ] += 5;
						if ( medals_h[ index ] > 42 )
							medals_h[ index ] = 42;
						
						g_SoundSystem.EmitSoundDyn( pPlayer.edict(), CHAN_STATIC, "ecsc/scxpm/medalget.ogg", VOL_NORM, ATTN_NONE, SND_SKIP_ORIGIN_USE_ENT, PITCH_NORM, index );
						
						string name = pPlayer.pev.netname;
						string steamid = g_EngineFuncs.GetPlayerAuthId( pPlayer.edict() );
						
						g_PlayerFuncs.ClientPrintAll( HUD_PRINTTALK, "[SCXPM] " + name + " gano 5 medallas por resetear! (Ahora tiene " + medals_h[ index ] + ")\n" );
						g_Game.AlertMessage( at_logged, "[SCXPM] " + name + " (" + steamid + ") gano 5 medallas por resetear. (Ahora tiene " + medals_h[ index ] + ") [Modo Dificil]\n" );
						SCXPM_Log( "" + name + " (" + steamid + ") gano 5 medallas por resetear. (Ahora tiene " + medals_h[ index ] + ") [Modo Dificil]\n" );
						
						playerlevel[ index ] -= 520;
						skillpoints[ index ] = playerlevel[ index ];
						
						if ( playerlevel[ index ] != 0 )
							xp_h[ index ] = scxpm_calc_xp( playerlevel[ index ] );
						else
							xp_h[ index ] = 0;
					}
					else if ( playerlevel[ index ] >= 395 )
					{
						medals_h[ index ] += 3;
						if ( medals_h[ index ] > 42 )
							medals_h[ index ] = 42;
						
						g_SoundSystem.EmitSoundDyn( pPlayer.edict(), CHAN_STATIC, "ecsc/scxpm/medalget.ogg", VOL_NORM, ATTN_NONE, SND_SKIP_ORIGIN_USE_ENT, PITCH_NORM, index );
						
						string name = pPlayer.pev.netname;
						string steamid = g_EngineFuncs.GetPlayerAuthId( pPlayer.edict() );
						
						g_PlayerFuncs.ClientPrintAll( HUD_PRINTTALK, "[SCXPM] " + name + " gano 3 medallas por resetear! (Ahora tiene " + medals_h[ index ] + ")\n" );
						g_Game.AlertMessage( at_logged, "[SCXPM] " + name + " (" + steamid + ") gano 3 medallas por resetear. (Ahora tiene " + medals_h[ index ] + ") [Modo Dificil]\n" );
						SCXPM_Log( "" + name + " (" + steamid + ") gano 3 medallas por resetear. (Ahora tiene " + medals_h[ index ] + ") [Modo Dificil]\n" );
						
						playerlevel[ index ] -= 395;
						skillpoints[ index ] = playerlevel[ index ];
						
						if ( playerlevel[ index ] != 0 )
							xp_h[ index ] = scxpm_calc_xp( playerlevel[ index ] );
						else
							xp_h[ index ] = 0;
					}
					else if ( playerlevel[ index ] >= 270 )
					{
						medals_h[ index ]++;
						if ( medals_h[ index ] > 42 )
							medals_h[ index ] = 42;
						
						g_SoundSystem.EmitSoundDyn( pPlayer.edict(), CHAN_STATIC, "ecsc/scxpm/medalget.ogg", VOL_NORM, ATTN_NONE, SND_SKIP_ORIGIN_USE_ENT, PITCH_NORM, index );
						
						string name = pPlayer.pev.netname;
						string steamid = g_EngineFuncs.GetPlayerAuthId( pPlayer.edict() );
						
						g_PlayerFuncs.ClientPrintAll( HUD_PRINTTALK, "[SCXPM] " + name + " gano 1 medalla por resetear! (Ahora tiene " + medals_h[ index ] + ")\n" );
						g_Game.AlertMessage( at_logged, "[SCXPM] " + name + " (" + steamid + ") gano 1 medalla por resetear. (Ahora tiene " + medals_h[ index ] + ") [Modo Dificil]\n" );
						SCXPM_Log( "" + name + " (" + steamid + ") gano 1 medalla por resetear. (Ahora tiene " + medals_h[ index ] + ") [Modo Dificil]\n" );
						
						playerlevel[ index ] -= 270;
						skillpoints[ index ] = playerlevel[ index ];
						
						if ( playerlevel[ index ] != 0 )
							xp_h[ index ] = scxpm_calc_xp( playerlevel[ index ] );
						else
							xp_h[ index ] = 0;
					}
					break;
				}
				case 4:
				{
					if ( playerlevel[ index ] >= 583 )
					{
						medals_p[ index ] += 7;
						if ( medals_p[ index ] > maxmedals_p[ index ] )
							medals_p[ index ] = maxmedals_p[ index ];
						
						g_SoundSystem.EmitSoundDyn( pPlayer.edict(), CHAN_STATIC, "ecsc/scxpm/medalget.ogg", VOL_NORM, ATTN_NONE, SND_SKIP_ORIGIN_USE_ENT, PITCH_NORM, index );
						
						string name = pPlayer.pev.netname;
						string steamid = g_EngineFuncs.GetPlayerAuthId( pPlayer.edict() );
						
						g_PlayerFuncs.ClientPrintAll( HUD_PRINTTALK, "[SCXPM] " + name + " gano 7 medallas por resetear! (Ahora tiene " + medals_p[ index ] + ")\n" );
						
						playerlevel[ index ] -= 583;
						skillpoints[ index ] = playerlevel[ index ];
						
						if ( playerlevel[ index ] != 0 )
							xp_p[ index ] = scxpm_calc_xp( playerlevel[ index ] );
						else
							xp_p[ index ] = 0;
					}
					else if ( playerlevel[ index ] >= 458 )
					{
						medals_p[ index ] += 5;
						if ( medals_p[ index ] > maxmedals_p[ index ] )
							medals_p[ index ] = maxmedals_p[ index ];
						
						g_SoundSystem.EmitSoundDyn( pPlayer.edict(), CHAN_STATIC, "ecsc/scxpm/medalget.ogg", VOL_NORM, ATTN_NONE, SND_SKIP_ORIGIN_USE_ENT, PITCH_NORM, index );
						
						string name = pPlayer.pev.netname;
						string steamid = g_EngineFuncs.GetPlayerAuthId( pPlayer.edict() );
						
						g_PlayerFuncs.ClientPrintAll( HUD_PRINTTALK, "[SCXPM] " + name + " gano 5 medallas por resetear! (Ahora tiene " + medals_p[ index ] + ")\n" );
						
						playerlevel[ index ] -= 458;
						skillpoints[ index ] = playerlevel[ index ];
						
						if ( playerlevel[ index ] != 0 )
							xp_p[ index ] = scxpm_calc_xp( playerlevel[ index ] );
						else
							xp_p[ index ] = 0;
					}
					else if ( playerlevel[ index ] >= 333 )
					{
						medals_p[ index ] += 3;
						if ( medals_p[ index ] > maxmedals_p[ index ] )
							medals_p[ index ] = maxmedals_p[ index ];
						
						g_SoundSystem.EmitSoundDyn( pPlayer.edict(), CHAN_STATIC, "ecsc/scxpm/medalget.ogg", VOL_NORM, ATTN_NONE, SND_SKIP_ORIGIN_USE_ENT, PITCH_NORM, index );
						
						string name = pPlayer.pev.netname;
						string steamid = g_EngineFuncs.GetPlayerAuthId( pPlayer.edict() );
						
						g_PlayerFuncs.ClientPrintAll( HUD_PRINTTALK, "[SCXPM] " + name + " gano 3 medallas por resetear! (Ahora tiene " + medals_p[ index ] + ")\n" );
						
						playerlevel[ index ] -= 333;
						skillpoints[ index ] = playerlevel[ index ];
						
						if ( playerlevel[ index ] != 0 )
							xp_p[ index ] = scxpm_calc_xp( playerlevel[ index ] );
						else
							xp_p[ index ] = 0;
					}
					else if ( playerlevel[ index ] >= 208 )
					{
						medals_p[ index ]++;
						if ( medals_p[ index ] > maxmedals_p[ index ] )
							medals_p[ index ] = maxmedals_p[ index ];
						
						g_SoundSystem.EmitSoundDyn( pPlayer.edict(), CHAN_STATIC, "ecsc/scxpm/medalget.ogg", VOL_NORM, ATTN_NONE, SND_SKIP_ORIGIN_USE_ENT, PITCH_NORM, index );
						
						string name = pPlayer.pev.netname;
						string steamid = g_EngineFuncs.GetPlayerAuthId( pPlayer.edict() );
						
						g_PlayerFuncs.ClientPrintAll( HUD_PRINTTALK, "[SCXPM] " + name + " gano 1 medalla por resetear! (Ahora tiene " + medals_p[ index ] + ")\n" );
						
						playerlevel[ index ] -= 208;
						skillpoints[ index ] = playerlevel[ index ];
						
						if ( playerlevel[ index ] != 0 )
							xp_p[ index ] = scxpm_calc_xp( playerlevel[ index ] );
						else
							xp_p[ index ] = 0;
					}
					break;
				}
			}
			scxpm_calcneedxp( index );
			scxpm_getrank( index );
		}
		else
			g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "[SCXPM] Ya no puedes resetear mas. Tienes todas las medallas!\n" );
	}
	else
		g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "[SCXPM] No cumples con el requisito minimo\n" );
}

void scxpm_medaltolvl( const int& in index )
{
	CBasePlayer@ pPlayer = g_PlayerFuncs.FindPlayerByIndex( index );
	
	if ( mode[ index ] == 1 )
	{
		g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "[SCXPM] No puedes usar esto en Modo Facil\n" );
		return;
	}
	
	if ( mode[ index ] == 4 && maxmedals_p[ index ] == 0 )
	{
		g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "[SCXPM] La partida actual del Modo Sandbox no permite el uso de esta herramienta\n" );
		return;
	}
	
	MenuHandler@ state = MenuGetPlayer( pPlayer );
	
	state.InitMenu( pPlayer, scxpm_medaltolvl_cb );
	
	string title = "Resetear Medallas\n\n\nInsatisfecho con tus medallas?\n\nEste conversor te ayudara\n\n\n";
	switch( mode[ index ] )
	{
		case 2:
		{
			title += "   - 1 medalla = 50,000 EXP\n\n   - 3 medallas = 100,000 EXP\n\n   - 5 medallas = 175,000 EXP\n\n   - 7 medallas = 275,000 EXP\n\n";
			break;
		}
		case 3:
		{
			title += "   - 3 medallas = 100,000 EXP\n\n   - 5 medallas = 175,000 EXP\n\n   - 7 medallas = 275,000 EXP\n\n   - 9 medallas = 425,000 EXP\n\n";
			break;
		}
		case 4:
		{
			title += "   - 2 medallas = 75,000 EXP\n\n   - 4 medallas = 137,500 EXP\n\n   - 6 medallas = 225,000 EXP\n\n   - 8 medallas = 350,000 EXP\n\n";
			break;
		}
	}
	state.menu.SetTitle( title );
	
	state.menu.AddItem( "Resetear!\n", any( "item1" ) );
	
	state.OpenMenu( pPlayer, 0, 0 );
}

void scxpm_medaltolvl_cb( CTextMenu@ menu, CBasePlayer@ pPlayer, int page, const CTextMenuItem@ item )
{
	int index = pPlayer.entindex();
	if ( page == 10 ) return;
	
	if ( medals[ index ] >= 1 && mode[ index ] == 2 || medals_h[ index ] >= 3 && mode[ index ] == 3 || medals_p[ index ] >= 2 && mode[ index ] == 4 )
	{
		if ( playerlevel[ index ] < 565 && mode[ index ] == 2 || playerlevel[ index ] < 1800 && mode[ index ] == 3 || playerlevel[ index ] < maxlevel_p[ index ] && mode[ index ] == 4 )
		{
			if ( ( bData[ index ] & SS_DISPENCER ) != 0 )
				bData[ index ] &= ~SS_DISPENCER;
			if ( ( bData[ index ] & SS_RANGEHEAL ) != 0 )
				bData[ index ] &= ~SS_RANGEHEAL;
			
			spawndmg[ index ] = 0;
			ubercharge[ index ] = 0;
			freefall[ index ] = 0;
			demoman[ index ] = 0;
			practiceshot[ index ] = 0;
			bioelectric[ index ] = 0;
			redcross[ index ] = 0;
			
			switch( mode[ index ] )
			{
				case 2:
				{
					if ( medals[ index ] >= 7 )
					{
						medals[ index ] -= 7;
						
						g_SoundSystem.EmitSoundDyn( pPlayer.edict(), CHAN_STATIC, "ecsc/scxpm/levelup.ogg", VOL_NORM, ATTN_NONE, SND_SKIP_ORIGIN_USE_ENT, PITCH_NORM, index );
						
						string name = pPlayer.pev.netname;
						string steamid = g_EngineFuncs.GetPlayerAuthId( pPlayer.edict() );
						
						g_PlayerFuncs.ClientPrintAll( HUD_PRINTTALK, "[SCXPM] " + name + " reseteo 7 medallas por niveles! (Ahora tiene " + medals[ index ] + ")\n" );
						g_Game.AlertMessage( at_logged, "[SCXPM] " + name + " (" + steamid + ") reseteo 7 medallas por niveles. (Ahora tiene " + medals[ index ] + ") [Modo Normal]\n" );
						SCXPM_Log( "" + name + " (" + steamid + ") reseteo 7 medallas por niveles. (Ahora tiene " + medals[ index ] + ") [Modo Normal]\n" );
						
						xp[ index ] += 275000;
					}
					else if ( medals[ index ] >= 5 )
					{
						medals[ index ] -= 5;
						
						g_SoundSystem.EmitSoundDyn( pPlayer.edict(), CHAN_STATIC, "ecsc/scxpm/levelup.ogg", VOL_NORM, ATTN_NONE, SND_SKIP_ORIGIN_USE_ENT, PITCH_NORM, index );
						
						string name = pPlayer.pev.netname;
						string steamid = g_EngineFuncs.GetPlayerAuthId( pPlayer.edict() );
						
						g_PlayerFuncs.ClientPrintAll( HUD_PRINTTALK, "[SCXPM] " + name + " reseteo 5 medallas por niveles! (Ahora tiene " + medals[ index ] + ")\n" );
						g_Game.AlertMessage( at_logged, "[SCXPM] " + name + " (" + steamid + ") reseteo 5 medallas por niveles. (Ahora tiene " + medals[ index ] + ") [Modo Normal]\n" );
						SCXPM_Log( "" + name + " (" + steamid + ") reseteo 5 medallas por niveles. (Ahora tiene " + medals[ index ] + ") [Modo Normal]\n" );
						
						xp[ index ] += 175000;
					}
					else if ( medals[ index ] >= 3 )
					{
						medals[ index ] -= 3;
						
						g_SoundSystem.EmitSoundDyn( pPlayer.edict(), CHAN_STATIC, "ecsc/scxpm/levelup.ogg", VOL_NORM, ATTN_NONE, SND_SKIP_ORIGIN_USE_ENT, PITCH_NORM, index );
						
						string name = pPlayer.pev.netname;
						string steamid = g_EngineFuncs.GetPlayerAuthId( pPlayer.edict() );
						
						g_PlayerFuncs.ClientPrintAll( HUD_PRINTTALK, "[SCXPM] " + name + " reseteo 3 medallas por niveles! (Ahora tiene " + medals[ index ] + ")\n" );
						g_Game.AlertMessage( at_logged, "[SCXPM] " + name + " (" + steamid + ") reseteo 3 medallas por niveles. (Ahora tiene " + medals[ index ] + ") [Modo Normal]\n" );
						SCXPM_Log( "" + name + " (" + steamid + ") reseteo 3 medallas por niveles. (Ahora tiene " + medals[ index ] + ") [Modo Normal]\n" );
						
						xp[ index ] += 100000;
					}
					else if ( medals[ index ] >= 1 )
					{
						medals[ index ]--;
						
						g_SoundSystem.EmitSoundDyn( pPlayer.edict(), CHAN_STATIC, "ecsc/scxpm/levelup.ogg", VOL_NORM, ATTN_NONE, SND_SKIP_ORIGIN_USE_ENT, PITCH_NORM, index );
						
						string name = pPlayer.pev.netname;
						string steamid = g_EngineFuncs.GetPlayerAuthId( pPlayer.edict() );
						
						g_PlayerFuncs.ClientPrintAll( HUD_PRINTTALK, "[SCXPM] " + name + " reseteo 1 medalla por niveles! (Ahora tiene " + medals[ index ] + ")\n" );
						g_Game.AlertMessage( at_logged, "[SCXPM] " + name + " (" + steamid + ") reseteo 1 medalla por niveles. (Ahora tiene " + medals[ index ] + ") [Modo Normal]\n" );
						SCXPM_Log( "" + name + " (" + steamid + ") reseteo 1 medalla por niveles. (Ahora tiene " + medals[ index ] + ") [Modo Normal]\n" );
						
						xp[ index ] += 50000;
					}
					break;
				}
				case 3:
				{
					if ( medals_h[ index ] >= 9 )
					{
						medals_h[ index ] -= 9;
						
						g_SoundSystem.EmitSoundDyn( pPlayer.edict(), CHAN_STATIC, "ecsc/scxpm/levelup.ogg", VOL_NORM, ATTN_NONE, SND_SKIP_ORIGIN_USE_ENT, PITCH_NORM, index );
						
						string name = pPlayer.pev.netname;
						string steamid = g_EngineFuncs.GetPlayerAuthId( pPlayer.edict() );
						
						g_PlayerFuncs.ClientPrintAll( HUD_PRINTTALK, "[SCXPM] " + name + " reseteo 9 medallas por niveles! (Ahora tiene " + medals_h[ index ] + ")\n" );
						g_Game.AlertMessage( at_logged, "[SCXPM] " + name + " (" + steamid + ") reseteo 9 medallas por niveles. (Ahora tiene " + medals_h[ index ] + ") [Modo Dificil]\n" );
						SCXPM_Log( "" + name + " (" + steamid + ") reseteo 9 medallas por niveles. (Ahora tiene " + medals_h[ index ] + ") [Modo Dificil]\n" );
						
						xp_h[ index ] += 425000;
					}
					else if ( medals_h[ index ] >= 7 )
					{
						medals_h[ index ] -= 7;
						
						g_SoundSystem.EmitSoundDyn( pPlayer.edict(), CHAN_STATIC, "ecsc/scxpm/levelup.ogg", VOL_NORM, ATTN_NONE, SND_SKIP_ORIGIN_USE_ENT, PITCH_NORM, index );
						
						string name = pPlayer.pev.netname;
						string steamid = g_EngineFuncs.GetPlayerAuthId( pPlayer.edict() );
						
						g_PlayerFuncs.ClientPrintAll( HUD_PRINTTALK, "[SCXPM] " + name + " reseteo 7 medallas por niveles! (Ahora tiene " + medals_h[ index ] + ")\n" );
						g_Game.AlertMessage( at_logged, "[SCXPM] " + name + " (" + steamid + ") reseteo 7 medallas por niveles. (Ahora tiene " + medals_h[ index ] + ") [Modo Dificil]\n" );
						SCXPM_Log( "" + name + " (" + steamid + ") reseteo 7 medallas por niveles. (Ahora tiene " + medals_h[ index ] + ") [Modo Dificil]\n" );
						
						xp_h[ index ] += 275000;
					}
					else if ( medals_h[ index ] >= 5 )
					{
						medals_h[ index ] -= 5;
						
						g_SoundSystem.EmitSoundDyn( pPlayer.edict(), CHAN_STATIC, "ecsc/scxpm/levelup.ogg", VOL_NORM, ATTN_NONE, SND_SKIP_ORIGIN_USE_ENT, PITCH_NORM, index );
						
						string name = pPlayer.pev.netname;
						string steamid = g_EngineFuncs.GetPlayerAuthId( pPlayer.edict() );
						
						g_PlayerFuncs.ClientPrintAll( HUD_PRINTTALK, "[SCXPM] " + name + " reseteo 5 medallas por niveles! (Ahora tiene " + medals_h[ index ] + ")\n" );
						g_Game.AlertMessage( at_logged, "[SCXPM] " + name + " (" + steamid + ") reseteo 5 medallas por niveles. (Ahora tiene " + medals_h[ index ] + ") [Modo Dificil]\n" );
						SCXPM_Log( "" + name + " (" + steamid + ") reseteo 5 medallas por niveles. (Ahora tiene " + medals_h[ index ] + ") [Modo Dificil]\n" );
						
						xp_h[ index ] += 175000;
					}
					else if ( medals_h[ index ] >= 3 )
					{
						medals_h[ index ] -= 3;
						
						string name = pPlayer.pev.netname;
						string steamid = g_EngineFuncs.GetPlayerAuthId( pPlayer.edict() );
						
						g_PlayerFuncs.ClientPrintAll( HUD_PRINTTALK, "[SCXPM] " + name + " reseteo 3 medallas por niveles! (Ahora tiene " + medals_h[ index ] + ")\n" );
						g_Game.AlertMessage( at_logged, "[SCXPM] " + name + " (" + steamid + ") reseteo 3 medallas por niveles. (Ahora tiene " + medals_h[ index ] + ") [Modo Dificil]\n" );
						SCXPM_Log( "" + name + " (" + steamid + ") reseteo 3 medallas por niveles. (Ahora tiene " + medals_h[ index ] + ") [Modo Dificil]\n" );
						
						xp_h[ index ] += 100000;
					}
					break;
				}
				case 4:
				{
					if ( medals_p[ index ] >= 8 )
					{
						medals_p[ index ] -= 8;
						
						g_SoundSystem.EmitSoundDyn( pPlayer.edict(), CHAN_STATIC, "ecsc/scxpm/levelup.ogg", VOL_NORM, ATTN_NONE, SND_SKIP_ORIGIN_USE_ENT, PITCH_NORM, index );
						
						string name = pPlayer.pev.netname;
						string steamid = g_EngineFuncs.GetPlayerAuthId( pPlayer.edict() );
						
						g_PlayerFuncs.ClientPrintAll( HUD_PRINTTALK, "[SCXPM] " + name + " reseteo 8 medallas por niveles! (Ahora tiene " + medals_p[ index ] + ")\n" );
						
						xp_p[ index ] += 350000;
					}
					else if ( medals_p[ index ] >= 6 )
					{
						medals_p[ index ] -= 6;
						
						g_SoundSystem.EmitSoundDyn( pPlayer.edict(), CHAN_STATIC, "ecsc/scxpm/levelup.ogg", VOL_NORM, ATTN_NONE, SND_SKIP_ORIGIN_USE_ENT, PITCH_NORM, index );
						
						string name = pPlayer.pev.netname;
						string steamid = g_EngineFuncs.GetPlayerAuthId( pPlayer.edict() );
						
						g_PlayerFuncs.ClientPrintAll( HUD_PRINTTALK, "[SCXPM] " + name + " reseteo 6 medallas por niveles! (Ahora tiene " + medals_p[ index ] + ")\n" );
						
						xp_p[ index ] += 225000;
					}
					else if ( medals_p[ index ] >= 4 )
					{
						medals_p[ index ] -= 4;
						
						g_SoundSystem.EmitSoundDyn( pPlayer.edict(), CHAN_STATIC, "ecsc/scxpm/levelup.ogg", VOL_NORM, ATTN_NONE, SND_SKIP_ORIGIN_USE_ENT, PITCH_NORM, index );
						
						string name = pPlayer.pev.netname;
						string steamid = g_EngineFuncs.GetPlayerAuthId( pPlayer.edict() );
						
						g_PlayerFuncs.ClientPrintAll( HUD_PRINTTALK, "[SCXPM] " + name + " reseteo 4 medallas por niveles! (Ahora tiene " + medals_p[ index ] + ")\n" );
						
						xp_p[ index ] += 137500;
					}
					else if ( medals_p[ index ] >= 2 )
					{
						medals_p[ index ] -= 2;
						
						g_SoundSystem.EmitSoundDyn( pPlayer.edict(), CHAN_STATIC, "ecsc/scxpm/levelup.ogg", VOL_NORM, ATTN_NONE, SND_SKIP_ORIGIN_USE_ENT, PITCH_NORM, index );
						
						string name = pPlayer.pev.netname;
						string steamid = g_EngineFuncs.GetPlayerAuthId( pPlayer.edict() );
						
						g_PlayerFuncs.ClientPrintAll( HUD_PRINTTALK, "[SCXPM] " + name + " reseteo 2 medallas por niveles! (Ahora tiene " + medals_p[ index ] + ")\n" );
						
						xp_p[ index ] += 75000;
					}
					break;
				}
			}
			
		}
		else
			g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "[SCXPM] Ya no puedes resetear mas. Tienes todos los niveles!\n" );
	}
	else
		g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "[SCXPM] No cumples con el requisito minimo\n" );
}

void scxpm_poisonoff( const int& in index )
{
	CBasePlayer@ pPlayer = g_PlayerFuncs.FindPlayerByIndex( index );
	if ( pPlayer !is null && pPlayer.IsConnected() )
		@pPlayer.pev.dmg_inflictor = null;
	
	poisoned[ index ] = false;
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
			// Moved here rather than prethink so it doesn't waste too much stuff
			if ( handicap9[ i ] )
			{
				NetworkMessage hc9( MSG_ONE_UNRELIABLE, NetworkMessages::HideHUD, pPlayer.edict() );
				hc9.WriteByte( 11 );
				hc9.End();
			}
			
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
				// Medicinal Phobia and Obsolete Tecnology handicaps
				if ( handicap5[ i ] ) pPlayer.pev.max_health = pPlayer.pev.health;
				if ( handicap6[ i ] ) pPlayer.pev.armortype = pPlayer.pev.armorvalue;
				
				// Karmic Retribution handicap
				if ( handicap8[ i ] )
				{
					if ( !FNullEnt( pPlayer.pev.dmg_inflictor ) && !poisoned[ i ] ) // Should exclude worldspawn (falldamage)
					{
						poisoned[ i ] = true;
						pPlayer.TakeDamage( pPlayer.pev, pPlayer.pev, 0.1, DMG_POISON );
						g_Scheduler.SetTimeout( "scxpm_poisonoff", 12.3, i );
					}
				}
				
				// A Player::CurWeapon message hook would make this more efficient instead of checking every 0.5 seconds
				// BioElectric special skill
				CBasePlayerItem@ pShockCheck = cast< CBasePlayerItem@ >( pPlayer.m_hActiveItem.GetEntity() );
				if ( pShockCheck !is null )
				{
					CBasePlayerWeapon@ pWeapon = pShockCheck.GetWeaponPtr();
					if ( pWeapon.m_iId == WEAPON_SHOCKRIFLE )
					{
						if ( !be_once[ i ] && !handicap13[ i ] )
						{
							pPlayer.m_rgAmmo( AMMO_ROACH, 100 + ( bioelectric[ i ] * 10 * ( mode[ i ] == 3 ? 2 : 1 ) ) );
							be_once[ i ] = true;
						}
					}
					else
						be_once[ i ] = false;
				}
				else
					be_once[ i ] = false;
				
				// Limited equipment handicap
				if ( handicap11[ i ] )
				{
					CBasePlayerItem@ pCurrentItem = cast< CBasePlayerItem@ >( pPlayer.m_hActiveItem.GetEntity() );
					if ( pCurrentItem !is null )
					{
						CBasePlayerWeapon@ pCurrentWeapon = pCurrentItem.GetWeaponPtr();
						
						for( uint j = 0; j < MAX_ITEM_TYPES; j++ )
						{
							CBasePlayerItem@ pCheckItem = pPlayer.m_rgpPlayerItems( j );
							if ( pCheckItem !is null )
							{
								CBasePlayerWeapon@ pCheckWeapon = pCheckItem.GetWeaponPtr();
								
								// Remove ALL weapons but the one he's handing now
								if ( pCheckWeapon.m_iId != pCurrentWeapon.m_iId )
									pPlayer.RemovePlayerItem( pCheckItem );
							}
						}
					}
				}
				
				float halfspeed;
				if ( mode[ i ] == 4 )
					halfspeed = float( speed[ i ] ) / 3.0;
				else if ( mode[ i ] == 3 )
					halfspeed = float( speed[ i ] ) / 4.0;
				else
					halfspeed = float( speed[ i ] ) / 2.0;
				
				if ( rhealth[ i ] > 0 && !handicap2[ i ] )
				{
					if ( rhealthwait[ i ] <= 0.0 )
					{
						switch( mode[ i ] )
						{
							case 1:
							{
								if ( pPlayer.pev.health < ( float( health[ i ] ) + starthealth + halfspeed ) )
								{
									pPlayer.pev.health = pPlayer.pev.health + 1.0;
									rhealthwait[ i ] = 300.0 - float( rhealth[ i ] );
								}
								break;
							}
							case 2:
							{
								if ( pPlayer.pev.health < ( ( !handicap1[ i ] ? float( health[ i ] ) : 0.0 ) + starthealth + ( handicap13[ i ] ? 0.0 : ( float( medals[ i ] ) / 2.0 ) ) + halfspeed ) )
								{
									pPlayer.pev.health = pPlayer.pev.health + 1.0;
									rhealthwait[ i ] = 300.0 - float( rhealth[ i ] );
								}
								break;
							}
							case 3:
							{
								if ( pPlayer.pev.health < ( ( !handicap1[ i ] ? ( float( health[ i ] ) / 6.0 ) : 0.0 ) + starthealth + ( handicap13[ i ] ? 0.0 : float( medals_h[ i ] ) ) + halfspeed ) )
								{
									pPlayer.pev.health = pPlayer.pev.health + 1.0;
									rhealthwait[ i ] = 315.0 - ( float( rhealth[ i ] ) / 3.0 );
								}
								break;
							}
							case 4:
							{
								if ( pPlayer.pev.health < ( ( !handicap1[ i ] ? ( float( health[ i ] ) / 3.0 ) : 0.0 ) + starthealth + ( handicap13[ i ] ? 0.0 : ( float( medals_p[ i ] ) / 1.5 ) ) + halfspeed ) )
								{
									pPlayer.pev.health = pPlayer.pev.health + 1.0;
									rhealthwait[ i ] = 300.0 - ( float( rhealth[ i ] ) / 1.5 );
								}
								break;
							}
						}
					}
					else
					{
						rhealthwait[ i ]--;
						switch( mode[ i ] )
						{
							case 1:
							{
								if ( pPlayer.pev.health < ( float( health[ i ] ) + starthealth + halfspeed ) && Math.RandomFloat( 0.0, 200.0 + float( rhealth[ i ] ) + halfspeed ) > 200.0 )
									pPlayer.pev.health = pPlayer.pev.health + 1.0;
								break;
							}
							case 2:
							{
								if ( pPlayer.pev.health < ( ( !handicap1[ i ] ? float( health[ i ] ) : 0.0 ) + starthealth + ( handicap13[ i ] ? 0.0 : ( float( medals[ i ] ) / 2.0 ) ) + halfspeed ) && Math.RandomFloat( 0.0, 200.0 + float( rhealth[ i ] ) + ( handicap13[ i ] ? 0.0 : ( float( medals[ i ] ) / 2.0 ) ) + halfspeed ) > 200.0 )
									pPlayer.pev.health = pPlayer.pev.health + 1.0;
								break;
							}
							case 3:
							{
								if ( pPlayer.pev.health < ( ( !handicap1[ i ] ? ( float( health[ i ] ) / 6.0 ) : 0.0 ) + starthealth + ( handicap13[ i ] ? 0.0 : float( medals_h[ i ] ) ) + halfspeed ) && Math.RandomFloat( 0.0, 200.0 + ( float( rhealth[ i ] ) / 6.0 ) + ( handicap13[ i ] ? 0.0 : float( medals_h[ i ] ) ) + halfspeed ) > 200.0 )
									pPlayer.pev.health = pPlayer.pev.health + 1.0;
								break;
							}
							case 4:
							{
								if ( pPlayer.pev.health < ( ( !handicap1[ i ] ? ( float( health[ i ] ) / 3.0 ) : 0.0 ) + starthealth + ( handicap13[ i ] ? 0.0 : ( float( medals_p[ i ] ) / 1.5 ) ) + halfspeed ) && Math.RandomFloat( 0.0, 200.0 + ( float( rhealth[ i ] ) / 3.0 ) + ( handicap13[ i ] ? 0.0 : ( float( medals_p[ i ] ) / 1.5 ) ) + halfspeed ) > 200.0 )
									pPlayer.pev.health = pPlayer.pev.health + 1.0;
								break;
							}
						}
					}
				}
				if ( rarmor[ i ] > 0 && !handicap2[ i ] )
				{
					if ( rarmorwait[ i ] <= 0.0 )
					{
						switch( mode[ i ] )
						{
							case 1:
							{
								if ( pPlayer.pev.armorvalue < ( float( armor[ i ] ) + startarmor + halfspeed ) )
								{
									pPlayer.pev.armorvalue = pPlayer.pev.armorvalue + 1.0;
									rarmorwait[ i ] = 315.0 - float( rarmor[ i ] );
								}
								break;
							}
							case 2:
							{
								if ( pPlayer.pev.armorvalue < ( ( !handicap1[ i ] ? float( armor[ i ] ) : 0.0 ) + startarmor + ( handicap13[ i ] ? 0.0 : ( float( medals[ i ] ) / 2.0 ) ) + halfspeed ) )
								{
									pPlayer.pev.armorvalue = pPlayer.pev.armorvalue + 1.0;
									rarmorwait[ i ] = 315.0 - float( rarmor[ i ] );
								}
								break;
							}
							case 3:
							{
								if ( pPlayer.pev.armorvalue < ( ( !handicap1[ i ] ? ( float( armor[ i ] ) / 6.0 ) : 0.0 ) + startarmor + ( handicap13[ i ] ? 0.0 : float( medals_h[ i ] ) ) + halfspeed ) )
								{
									pPlayer.pev.armorvalue = pPlayer.pev.armorvalue + 1.0;
									rarmorwait[ i ] = 330.0 - ( float( rarmor[ i ] ) / 3.0 );
								}
								break;
							}
							case 4:
							{
								if ( pPlayer.pev.armorvalue < ( ( !handicap1[ i ] ? ( float( armor[ i ] ) / 3.0 ) : 0.0 ) + startarmor + ( handicap13[ i ] ? 0.0 : ( float( medals_p[ i ] ) / 1.5 ) ) + halfspeed ) )
								{
									pPlayer.pev.armorvalue = pPlayer.pev.armorvalue + 1.0;
									rarmorwait[ i ] = 315.0 - ( float( rarmor[ i ] ) / 1.5 );
								}
								break;
							}
						}
					}
					else
					{
						rarmorwait[ i ]--;
						switch( mode[ i ] )
						{
							case 1:
							{
								if ( pPlayer.pev.armorvalue < ( float( armor[ i ] ) + startarmor + halfspeed ) && Math.RandomFloat( 0.0, 200.0 + float( rarmor[ i ] ) + halfspeed ) > 200.0 )
									pPlayer.pev.armorvalue = pPlayer.pev.armorvalue + 1.0;
								break;
							}
							case 2:
							{
								if ( pPlayer.pev.armorvalue < ( ( !handicap1[ i ] ? float( armor[ i ] ) : 0.0 ) + startarmor + ( handicap13[ i ] ? 0.0 : ( float( medals[ i ] ) / 2.0 ) ) + halfspeed ) && Math.RandomFloat( 0.0, 200.0 + float( rarmor[ i ] ) + ( handicap13[ i ] ? 0.0 : ( float( medals[ i ] ) / 2.0 ) ) + halfspeed ) > 200.0 )
									pPlayer.pev.armorvalue = pPlayer.pev.armorvalue + 1.0;
								break;
							}
							case 3:
							{
								if ( pPlayer.pev.armorvalue < ( ( !handicap1[ i ] ? ( float( armor[ i ] ) / 6.0 ) : 0.0 ) + startarmor + ( handicap13[ i ] ? 0.0 : float( medals_h[ i ] ) ) + halfspeed ) && Math.RandomFloat( 0.0, 200.0 + ( float( rarmor[ i ] ) / 6.0 ) + ( handicap13[ i ] ? 0.0 : float( medals_h[ i ] ) ) + halfspeed ) > 200.0 )
									pPlayer.pev.armorvalue = pPlayer.pev.armorvalue + 1.0;
								break;
							}
							case 4:
							{
								if ( pPlayer.pev.armorvalue < ( ( !handicap1[ i ] ? ( float( armor[ i ] ) / 3.0 ) : 0.0 ) + startarmor + ( handicap13[ i ] ? 0.0 : ( float( medals_p[ i ] ) / 1.5 ) ) + halfspeed ) && Math.RandomFloat( 0.0, 200.0 + ( float( rarmor[ i ] ) / 3.0 ) + ( handicap13[ i ] ? 0.0 : ( float( medals_p[ i ] ) / 1.5 ) ) + halfspeed ) > 200.0 )
									pPlayer.pev.armorvalue = pPlayer.pev.armorvalue + 1.0;
								break;
							}
						}
					}
				}
				if ( rammo[ i ] > 0 && !handicap2[ i ] )
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
								if ( ( bData[ i ] & SS_DISPENCER ) != 0 && !handicap13[ i ] )
								{
									if ( pAmmo <= 216 )
										GiveItem( pPlayer, "ammo_9mmclip" );
								}
								
								if ( pAmmo < 250 )
									GiveItem( pPlayer, "ammo_9mmclip" );
								else
									scxpm_randomammo( i );
							}
							else if ( pWeapon.m_iId == WEAPON_PYTHON )
							{
								int pAmmo = pPlayer.m_rgAmmo( AMMO_357 );
								if ( ( bData[ i ] & SS_DISPENCER ) != 0 && !handicap13[ i ] )
								{
									if ( pAmmo <= 24 )
										GiveItem( pPlayer, "ammo_357" );
								}
								
								if ( pAmmo < 36 )
									GiveItem( pPlayer, "ammo_357" );
								else
									scxpm_randomammo( i );
							}
							else if ( pWeapon.m_iId == WEAPON_MP5 )
							{
								int pAmmo = pPlayer.m_rgAmmo( AMMO_9MM );
								if ( ( bData[ i ] & SS_DISPENCER ) != 0 && !handicap13[ i ] )
								{
									if ( pAmmo <= 190 )
										GiveItem( pPlayer, "ammo_9mmAR" );
								}
								
								if ( pAmmo < 250 )
									GiveItem( pPlayer, "ammo_9mmAR" );
								else
									scxpm_randomammo( i );
							}
							else if ( pWeapon.m_iId == WEAPON_CROSSBOW )
							{
								int pAmmo = pPlayer.m_rgAmmo( AMMO_CROSSBOW );
								if ( ( bData[ i ] & SS_DISPENCER ) != 0 && !handicap13[ i ] )
								{
									if ( pAmmo <= 40 )
										GiveItem( pPlayer, "ammo_crossbow" );
								}
								
								if ( pAmmo < 50 )
									GiveItem( pPlayer, "ammo_crossbow" );
								else
									scxpm_randomammo( i );
							}
							else if ( pWeapon.m_iId == WEAPON_SHOTGUN )
							{
								int pAmmo = pPlayer.m_rgAmmo( AMMO_SHOTGUN );
								if ( ( bData[ i ] & SS_DISPENCER ) != 0 && !handicap13[ i ] )
								{
									if ( pAmmo <= 101 )
										GiveItem( pPlayer, "ammo_buckshot" );
								}
								
								if ( pAmmo < 125 )
									GiveItem( pPlayer, "ammo_buckshot" );
								else
									scxpm_randomammo( i );
							}
							else if ( pWeapon.m_iId == WEAPON_RPG )
							{
								int pAmmo = pPlayer.m_rgAmmo( AMMO_RPG );
								if ( ( bData[ i ] & SS_DISPENCER ) != 0 && !handicap13[ i ] )
								{
									if ( pAmmo <= 1 )
										GiveItem( pPlayer, "ammo_rpgclip" );
								}
								
								if ( pAmmo < 5 )
									GiveItem( pPlayer, "ammo_rpgclip" );
								else
									scxpm_randomammo( i );
							}
							else if ( pWeapon.m_iId == WEAPON_GAUSS )
							{
								int pAmmo = pPlayer.m_rgAmmo( AMMO_GAUSS );
								if ( ( bData[ i ] & SS_DISPENCER ) != 0 && !handicap13[ i ] )
								{
									if ( pAmmo <= 60 )
										GiveItem( pPlayer, "ammo_gaussclip" );
								}
								
								if ( pAmmo < 100 )
									GiveItem( pPlayer, "ammo_gaussclip" );
								else
									scxpm_randomammo( i );
							}
							else if ( pWeapon.m_iId == WEAPON_UZI )
							{
								int pAmmo = pPlayer.m_rgAmmo( AMMO_9MM );
								if ( pPlayer.get_m_szAnimExtension() == 'uzis' ) // Akimbo Uzis
								{
									if ( ( bData[ i ] & SS_DISPENCER ) != 0 && !handicap13[ i ] )
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
									else
										scxpm_randomammo( i );
								}
								else // Single Uzi
								{
									if ( ( bData[ i ] & SS_DISPENCER ) != 0 && !handicap13[ i ] )
									{
										if ( pAmmo <= 186 )
											GiveItem( pPlayer, "ammo_uziclip" );
									}
									
									if ( pAmmo < 250 )
										GiveItem( pPlayer, "ammo_uziclip" );
									else
										scxpm_randomammo( i );
								}
							}
							else if ( pWeapon.m_iId == WEAPON_SNIPERRIFLE )
							{
								int pAmmo = pPlayer.m_rgAmmo( AMMO_SNIPER );
								if ( ( bData[ i ] & SS_DISPENCER ) != 0 && !handicap13[ i ] )
								{
									if ( pAmmo <= 5 )
										GiveItem( pPlayer, "ammo_762" );
								}
								
								if ( pAmmo < 15 )
									GiveItem( pPlayer, "ammo_762" );
								else
									scxpm_randomammo( i );
							}
							else if ( pWeapon.m_iId == WEAPON_M249 )
							{
								int pAmmo = pPlayer.m_rgAmmo( AMMO_SAW );
								if ( ( bData[ i ] & SS_DISPENCER ) != 0 && !handicap13[ i ] )
								{
									if ( pAmmo <= 400 )
										GiveItem( pPlayer, "ammo_556" );
								}
								
								if ( pAmmo < 600 )
									GiveItem( pPlayer, "ammo_556" );
								else
									scxpm_randomammo( i );
							}
							else if ( pWeapon.m_iId == WEAPON_M16 )
							{
								int pAmmo1 = pPlayer.m_rgAmmo( AMMO_SAW );
								int pAmmo2 = pPlayer.m_rgAmmo( AMMO_M16GRENADE );
								if ( ( bData[ i ] & SS_DISPENCER ) != 0 && !handicap13[ i ] )
								{
									if ( pAmmo1 <= 540 )
										GiveItem( pPlayer, "ammo_556clip" );
								}
								
								if ( pAmmo1 < 600 )
									GiveItem( pPlayer, "ammo_556clip" );
								else
									scxpm_randomammo( i );
								
								if ( demoman[ i ] > 0 && mode[ i ] != 1 && !handicap13[ i ] )
								{
									int dluck = Math.RandomLong( 0, 25 );
									if ( dluck >= 25 - demoman[ i ] - ( mode[ i ] == 3 ? 4 : 0 ) )
									{
										if ( pAmmo2 < 10 )
											GiveItem( pPlayer, "ammo_ARgrenades" );
									}
								}
							}
							else if ( pWeapon.m_iId == WEAPON_SPORELAUNCHER )
							{
								int pAmmo = pPlayer.m_rgAmmo( AMMO_SPORE );
								if ( ( bData[ i ] & SS_DISPENCER ) != 0 && !handicap13[ i ] )
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
								else
									scxpm_randomammo( i );
							}
							else if ( pWeapon.m_iId == WEAPON_DESERT_EAGLE )
							{
								int pAmmo = pPlayer.m_rgAmmo( AMMO_357 );
								if ( ( bData[ i ] & SS_DISPENCER ) != 0 && !handicap13[ i ] )
								{
									if ( pAmmo <= 24 )
										GiveItem( pPlayer, "ammo_357" );
								}
								
								if ( pAmmo < 36 )
									GiveItem( pPlayer, "ammo_357" );
								else
									scxpm_randomammo( i );
							}
							else if ( pWeapon.m_iId == WEAPON_DISPLACER )
							{
								int pAmmo = pPlayer.m_rgAmmo( AMMO_GAUSS );
								if ( ( bData[ i ] & SS_DISPENCER ) != 0 && !handicap13[ i ] )
								{
									if ( pAmmo <= 60 )
										GiveItem( pPlayer, "ammo_gaussclip" );
								}
								
								if ( pAmmo < 80 )
									GiveItem( pPlayer, "ammo_gaussclip" );
								else
									scxpm_randomammo( i );
							}
							else
							{
								if ( ( bData[ i ] & SS_DISPENCER ) != 0 && !handicap13[ i ] )
									scxpm_randomammo( i );
								
								scxpm_randomammo( i );
							}
						}
						else
							scxpm_randomammo( i );
						
						float speed_dt;
						if ( mode[ i ] == 4 )
						{
							speed_dt = float( speed[ i ] ) / 27.0;
							rammowait[ i ] = 184.0 - ( 5.0 * float( rammo[ i ] ) ) - speed_dt;
						}
						else if ( mode[ i ] == 3 )
						{
							speed_dt = float( speed[ i ] ) / 36.0;
							rammowait[ i ] = 189.0 - ( 5.0 * float( rammo[ i ] ) ) - speed_dt;
						}
						else
						{
							speed_dt = float( speed[ i ] ) / 18.0;
							rammowait[ i ] = 179.0 - ( 5.0 * float( rammo[ i ] ) ) - speed_dt;
						}
					}
					else
						rammowait[ i ]--;
				}
				
				CBasePlayerItem@ pItem = cast< CBasePlayerItem@ >( pPlayer.m_hActiveItem.GetEntity() );
				if ( pItem !is null )
				{
					CBasePlayerWeapon@ pWeapon = pItem.GetWeaponPtr();
					
					if ( pWeapon.m_iId == WEAPON_MEDKIT )
					{
						if ( pPlayer.pev.health < starthealth && mode[ i ] < 3 )
						{
							if ( Math.RandomFloat( float( rhealth[ i ] ), 800.0 - pPlayer.pev.health ) > 299.0 )
								pPlayer.pev.health = pPlayer.pev.health + 1.0;
						}
						else if ( !handicap2[ i ] )
						{
							if ( pPlayer.pev.health < ( ( !handicap1[ i ] ? 0.0 : float( rhealth[ i ] ) ) + starthealth + ( mode[ i ] == 2 ? ( handicap13[ i ] ? 0.0 : ( float( medals[ i ] ) / 2.0 ) ) : 0.0 ) + halfspeed ) && Math.RandomFloat( 0.0, 1300.0 + float( rhealth[ i ] ) ) > 1200.0 && mode[ i ] < 3 )
								pPlayer.pev.health = pPlayer.pev.health + 1.0;
						}
					}
				}
				
				if ( dist[ i ] > 0 && !handicap3[ i ] )
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
								if ( pPlayer.pev.deadflag == DEAD_NO && pPlayer2.pev.deadflag == DEAD_NO && !handicap3[ i ] && !handicap3[ j ] )
								{
									Vector origin1 = pPlayer.pev.origin;
									Vector origin2 = pPlayer2.pev.origin;
									Vector distance = origin1 - origin2;
									if ( distance.Length() <= 512.0 )
									{
										float number = float( g_PlayerFuncs.GetNumPlayers() ) * 50.0;
										float luck = Math.RandomFloat( 1651.0 - number, 4200.0 + float( dist[ i ] ) + float( dist[ j ] ) + halfspeed );
										
										if ( luck > 4200.0 )
										{
											switch( mode[ i ] )
											{
												case 1:
												{
													if ( pPlayer2.pev.health < 300.0 )
													{
														pPlayer2.pev.health = pPlayer2.pev.health + 1.0;
														if ( pPlayer2.pev.health > starthealth + 100.0 + dist[ i ] + halfspeed )
															pPlayer2.pev.health = starthealth + 100.0 + dist[ i ] + halfspeed;
													}
													break;
												}
												case 2:
												{
													if ( pPlayer2.pev.health < 250.0 )
													{
														pPlayer2.pev.health = pPlayer2.pev.health + 1.0;
														if ( pPlayer2.pev.health > starthealth + 100.0 + dist[ i ] + ( handicap13[ i ] ? 0.0 : ( float( medals[ i ] ) / 2.0 ) ) + halfspeed )
															pPlayer2.pev.health = starthealth + 100.0 + dist[ i ] + ( handicap13[ i ] ? 0.0 : ( float( medals[ i ] ) / 2.0 ) ) + halfspeed;
													}
													break;
												}
												case 3:
												{
													if ( pPlayer2.pev.health < 200.0 )
													{
														pPlayer2.pev.health = pPlayer2.pev.health + 1.0;
														if ( pPlayer2.pev.health > starthealth + 100.0 + dist[ i ] + ( handicap13[ i ] ? 0.0 : float( medals_h[ i ] ) ) + halfspeed )
															pPlayer2.pev.health = starthealth + 100.0 + dist[ i ] + ( handicap13[ i ] ? 0.0 : float( medals_h[ i ] ) ) + halfspeed;
													}
													break;
												}
												case 4:
												{
													if ( pPlayer2.pev.health < 999.0 )
													{
														pPlayer2.pev.health = pPlayer2.pev.health + 1.0;
														if ( pPlayer2.pev.health > starthealth + 100.0 + dist[ i ] + ( handicap13[ i ] ? 0.0 : ( float( medals_p[ i ] ) / 1.5 ) ) + halfspeed )
															pPlayer2.pev.health = starthealth + 100.0 + dist[ i ] + ( handicap13[ i ] ? 0.0 : ( float( medals_p[ i ] ) / 1.5 ) ) + halfspeed;
													}
													break;
												}
											}
										}
										luck = Math.RandomFloat( 1651.0 - number, 4200.0 + float( dist[ i ] ) + float( dist[ j ] ) + halfspeed );
										if ( luck > 4200.0 )
										{
											switch( mode[ i ] )
											{
												case 1:
												{
													if ( pPlayer2.pev.armorvalue < 300.0 )
													{
														pPlayer2.pev.armorvalue = pPlayer2.pev.armorvalue + 1.0;
														if ( pPlayer2.pev.armorvalue > startarmor + 100.0 + dist[ i ] + halfspeed )
															pPlayer2.pev.armorvalue = startarmor + 100.0 + dist[ i ] + halfspeed;
													}
													break;
												}
												case 2:
												{
													if ( pPlayer2.pev.armorvalue < 250.0 )
													{
														pPlayer2.pev.armorvalue = pPlayer2.pev.armorvalue + 1.0;
														if ( pPlayer2.pev.armorvalue > startarmor + 100.0 + dist[ i ] + ( handicap13[ i ] ? 0.0 : ( float( medals[ i ] ) / 2.0 ) ) + halfspeed )
															pPlayer2.pev.armorvalue = startarmor + 100.0 + dist[ i ] + ( handicap13[ i ] ? 0.0 : ( float( medals[ i ] ) / 2.0 ) ) + halfspeed;
													}
													break;
												}
												case 3:
												{
													if ( pPlayer2.pev.armorvalue < 200.0 )
													{
														pPlayer2.pev.armorvalue = pPlayer2.pev.armorvalue + 1.0;
														if ( pPlayer2.pev.armorvalue > startarmor + 100.0 + dist[ i ] + ( handicap13[ i ] ? 0.0 : float( medals_h[ i ] ) ) + halfspeed )
															pPlayer2.pev.armorvalue = startarmor + 100.0 + dist[ i ] + ( handicap13[ i ] ? 0.0 : float( medals_h[ i ] ) ) + halfspeed;
													}
													break;
												}
												case 4:
												{
													if ( pPlayer2.pev.armorvalue < 999.0 )
													{
														pPlayer2.pev.armorvalue = pPlayer2.pev.armorvalue + 1.0;
														if ( pPlayer2.pev.armorvalue > startarmor + 100.0 + dist[ i ] + ( handicap13[ i ] ? 0.0 : ( float( medals_p[ i ] ) / 1.5 ) ) + halfspeed )
															pPlayer2.pev.armorvalue = startarmor + 100.0 + dist[ i ] + ( handicap13[ i ] ? 0.0 : ( float( medals_p[ i ] ) / 1.5 ) ) + halfspeed;
													}
													break;
												}
											}
										}
									}
								}
							}
						}
					}
				}
				if ( dodge[ i ] > 0 && !handicap4[ i ] )
				{
					float piecespeed;
					if ( mode[ i ] == 4 )
						piecespeed = float( speed[ i ] ) / 10.5;
					else if ( mode[ i ] == 3 )
						piecespeed = float( speed[ i ] ) / 14.0;
					else
						piecespeed = float( speed[ i ] ) / 7.0;
					
					float luck;
					float totaldodge;
					float extradodge;
					
					totaldodge = ( mode[ i ] <= 2 ? float( dodge[ i ] ) : ( float( dodge[ i ] ) / 1.2 ) );
					
					if ( !handicap13[ i ] )
					{
						if ( mode[ i ] == 2 )
							extradodge = float( medals[ i ] ) / 2.0;
						else if ( mode[ i ] == 3 )
							extradodge = float( medals_h[ i ] );
						else if ( mode[ i ] == 4 )
							extradodge = float( medals_p[ i ] ) / 1.5;
					}
					else
						extradodge = 0.0;
					
					luck = Math.RandomFloat( 0.0, 185.0 + totaldodge + extradodge + piecespeed );
					
					// No hook to Player::TakeDamage yet... Block Attack could be built better...
					if ( luck > 185.0 )
						pPlayer.pev.flags |= FL_GODMODE;
					else
						pPlayer.pev.flags &= ~FL_GODMODE;
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
	if ( handicap7[ index ] )
	{
		pPlayer.pev.solid = SOLID_NOT;
		pPlayer.GibMonster();
		pPlayer.pev.effects |= EF_NODRAW;
	}
	
	if ( mode[ index ] == 3 || mode[ index ] == 4 && sparks_p[ index ] >= 0 )
	{
		// Save that I died. But only if Hard Ignore is OFF!
		if ( !gHardIgnore ) bWasDead[ index ] = 1;
		
		// Maps with 0 respawn delay could easily fuck up someone's spark, forcefully add a small delay
		pPlayer.m_flRespawnDelayTime = 1.0;
		if ( !gNoSpectate )
			g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "[SCXPM] Escribe /spectate para observar a otros jugadores mientras esperas\n" );
		
		// If Hard Ignore is on, notify the player that it will not be punished for respawning
		if ( gHardIgnore )
			g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "[SCXPM] Los Suministros Auxiliares no estan activos en este mapa. Puedes respawnear libremente si asi lo deseas\n" );
	}
	
	return HOOK_CONTINUE;
}

// Assuming this is POST hook, otherwise hud WILL get bugged
HookReturnCode WeaponPrimaryAttack( CBasePlayer@ pPlayer, CBasePlayerWeapon@ pWeapon )
{
	// Don't
	if ( gNoSkills )
		return HOOK_CONTINUE;
	
	int index = pPlayer.entindex();
	if ( practiceshot[ index ] > 0 && !handicap13[ index ] )
	{
		// Don't care if the player is underwater, even if the weapon can fire
		if ( pPlayer.pev.waterlevel != WATERLEVEL_HEAD )
		{
			// Only care if using one of the following weapons
			int iID = pWeapon.m_iId;
			if ( iID == WEAPON_GLOCK || iID == WEAPON_PYTHON || iID == WEAPON_MP5 || iID == WEAPON_CROSSBOW || iID == WEAPON_SHOTGUN || iID == WEAPON_SNIPERRIFLE || iID == WEAPON_M249 || iID == WEAPON_DESERT_EAGLE )
			{
				// Don't let the function run if we have no ammo on our clip (prevents infinite ammo exploitation)
				if ( pWeapon.m_iClip > 0 )
				{
					if ( Math.RandomLong( 1, 100 ) > 100 - ( practiceshot[ index ] * ( mode[ index ] == 3 ? 6 : 5 ) ) )
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
	if ( ( bData[ index ] & SS_RANGEHEAL ) != 0 && !handicap13[ index ] )
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
		if ( mode[ index ] == 3 )
		{
			if ( pPlayer.pev.health == 50.0 || playerlevel[ index ] == 1800 && medals_h[ index ] == 42 || lastDeadflag[ index ] == 123 && bWasDead[ index ] == 0 && sparks[ index ] > 0 )
			{
				// Reset dead flags
				bWasDead[ index ] = 0;
				bIsSpectating[ index ] = false;
			}
			else if ( ( sparks[ index ] - 1 ) < 0 && !gHardIgnore ) // Don't substract sparks if map setting is ignoring it
			{
				sparks[ index ] = 0;
				pPlayer.pev.flags &= ~FL_GODMODE;
				
				// Manual force-kill
				pPlayer.pev.solid = SOLID_NOT;
				pPlayer.GibMonster();
				pPlayer.pev.effects |= EF_NODRAW;
				pPlayer.pev.health = 0;
				pPlayer.pev.deadflag = DEAD_DEAD;
				
				// Custom death message, again
				string szDeathMsg = "" + pPlayer.pev.netname + " ran out of Sparks of Life.\n";
				
				NetworkMessage deathmsg( MSG_ALL, NetworkMessages::TextMsg );
				deathmsg.WriteByte( 1 );
				deathmsg.WriteString( szDeathMsg );
				deathmsg.End();
				
				g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "[SCXPM] Sin suministros! No puedes seguir jugando en Modo Dificil\n" );
				g_Scheduler.SetTimeout( "scxpm_mode", 0.05, index );
			}
			else
			{
				if ( !bChangeHard[ index ] && !gHardIgnore ) // Same here
				{
					sparks[ index ]--;
					// If the player was dead on a previous map, message will not show. So do that again on a later time
					if ( lastDeadflag[ index ] == 123 && bWasDead[ index ] == 1 )
						g_Scheduler.SetTimeout( "scxpm_late_sparks", 6.25, index );
				}
				bChangeHard[ index ] = false;
				bWasDead[ index ] = 0;
				
				g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "[SCXPM] Te quedan " + sparks[ index ] + " Suministro(s) Auxiliar(es)\n" );
			}
		}
		else if ( mode[ index ] == 4 && sparks_p[ index ] >= 0 )
		{
			if ( pPlayer.pev.health == 50.0 || playerlevel[ index ] == maxlevel_p[ index ] && medals_p[ index ] == maxmedals_p[ index ] || lastDeadflag[ index ] == 123 && bWasDead[ index ] == 0 && sparks_p[ index ] > 0 )
			{
				// Reset dead flags
				bWasDead[ index ] = 0;
				bIsSpectating[ index ] = false;
			}
			else if ( ( sparks_p[ index ] - 1 ) < 0 && !gHardIgnore ) // Don't substract sparks if map setting is ignoring it
			{
				sparks_p[ index ] = 0;
				maxlevel_p[ index ] = -1;
				pPlayer.pev.flags &= ~FL_GODMODE;
				
				// Manual force-kill
				pPlayer.pev.solid = SOLID_NOT;
				pPlayer.GibMonster();
				pPlayer.pev.effects |= EF_NODRAW;
				pPlayer.pev.health = 0;
				pPlayer.pev.deadflag = DEAD_DEAD;
				
				// Custom death message, again
				string szDeathMsg = "" + pPlayer.pev.netname + "'s game is over...\n";
				
				NetworkMessage deathmsg( MSG_ALL, NetworkMessages::TextMsg );
				deathmsg.WriteByte( 1 );
				deathmsg.WriteString( szDeathMsg );
				deathmsg.End();
				
				g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTCENTER, "GAME OVER\n" );
				g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "[SCXPM] Oh no! Se te acabaron los Suministros Auxiliares, es el fin de la partida en tu Modo Sandbox!\n" );
				g_Scheduler.SetTimeout( "scxpm_mode", 0.05, index );
			}
			else
			{
				if ( !bChangeHard[ index ] && !gHardIgnore ) // Same here
				{
					sparks_p[ index ]--;
					// If the player was dead on a previous map, message will not show. So do that again on a later time
					if ( lastDeadflag[ index ] == 123 && bWasDead[ index ] == 1 )
						g_Scheduler.SetTimeout( "scxpm_late_sparks", 6.25, index );
				}
				bChangeHard[ index ] = false;
				bWasDead[ index ] = 0;
				
				g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "[SCXPM] Te quedan " + sparks_p[ index ] + " Suministro(s) Auxiliar(es)\n" );
			}
		}
		
		// End here if skills are disabled
		if ( gNoSkills )
			return;
		
		starthealth = pPlayer.pev.health;
		startarmor = pPlayer.pev.armorvalue;
		
		switch( mode[ index ] )
		{
			case 1:
			{
				pPlayer.pev.health = float( health[ index ] ) + starthealth;
				pPlayer.pev.armorvalue = float( armor[ index ] ) + startarmor;
				
				// Don't allow health/armor to become too high
				if ( pPlayer.pev.health > 250 )
				{
					pPlayer.pev.health = 250;
					starthealth = 100;
				}
				if ( pPlayer.pev.armorvalue > 250 )
				{
					pPlayer.pev.armorvalue = 250;
					startarmor = 100;
				}
				break;
			}
			case 2:
			{
				if ( !handicap1[ index ] )
				{
					pPlayer.pev.health = float( health[ index ] ) + starthealth + ( handicap13[ index ] ? 0.0 : ( float( medals[ index ] ) / 2.0 ) );
					pPlayer.pev.armorvalue = float( armor[ index ] ) + startarmor + ( handicap13[ index ] ? 0.0 : ( float( medals[ index ] ) / 2.0 ) );
					
					// Don't allow health/armor to become too high
					if ( pPlayer.pev.health > 225 )
					{
						pPlayer.pev.health = 225;
						starthealth = 100;
					}
					if ( pPlayer.pev.armorvalue > 225 )
					{
						pPlayer.pev.armorvalue = 225;
						startarmor = 100;
					}
				}
				break;
			}
			case 3:
			{
				if ( !handicap1[ index ] )
				{
					pPlayer.pev.health = ( float( health[ index ] ) / 6.0 ) + starthealth + ( handicap13[ index ] ? 0.0 : float( medals_h[ index ] ) );
					pPlayer.pev.armorvalue = ( float( armor[ index ] ) / 6.0 ) + startarmor + ( handicap13[ index ] ? 0.0 : float( medals_h[ index ] ) );
					
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
				}
				break;
			}
			case 4:
			{
				if ( !handicap1[ index ] )
				{
					pPlayer.pev.health = ( float( health[ index ] ) / 3.0 ) + starthealth + ( handicap13[ index ] ? 0.0 : ( float( medals_p[ index ] ) / 1.5 ) );
					pPlayer.pev.armorvalue = ( float( armor[ index ] ) / 3.0 ) + startarmor + ( handicap13[ index ] ? 0.0 : ( float( medals_p[ index ] ) / 1.5 ) );
				}
				break;
			}
		}
		
		if ( spawndmg[ index ] > 0 && !handicap13[ index ] )
		{
			CBaseEntity@ ent = null;
			while( ( @ent = g_EntityFuncs.FindEntityInSphere( ent, pPlayer.pev.origin, 384.0, "*", "classname" ) ) !is null )
			{
				string cname = ent.pev.classname;
				if ( cname[ 0 ] == 'm' && cname[ 1 ] == 'o' && cname[ 2 ] == 'n' && cname[ 3 ] == 's' && cname[ 4 ] == 't' && cname[ 5 ] == 'e' && cname[ 6 ] == 'r' && cname[ 7 ] == '_' && cname != 'monster_generic' )
				{
					if ( !ent.IsPlayerAlly() && ent.IsAlive() )
					{
						ent.TakeDamage( pPlayer.pev, pPlayer.pev, ( mode[ index ] == 3 ? 30.0 : 15.0 ) * float( spawndmg[ index ] ), DMG_ENERGYBEAM );
						
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
		pPlayer.SetMaxAmmo( AMMO_MEDKIT, 100 + ( redcross[ index ] * 10 * ( mode[ index ] == 3 ? 2 : 1 ) ) );
		if ( pPlayer.m_rgAmmo( AMMO_MEDKIT ) > pPlayer.GetMaxAmmo( AMMO_MEDKIT ) ) pPlayer.RemoveExcessAmmo( AMMO_MEDKIT );
	}
}
void scxpm_late_sparks( const int& in index )
{
	CBasePlayer@ pPlayer = g_PlayerFuncs.FindPlayerByIndex( index );
	if ( pPlayer !is null && pPlayer.IsConnected() )
		g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "[SCXPM] Te quedan " + ( mode[ index ] == 3 ? sparks[ index ] : sparks_p[ index ] ) + " Suministro(s) Auxiliar(es)\n" );
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
	
	// No skills
	if ( gNoSkills )
		return HOOK_CONTINUE;
	
	if ( !handicap1[ index ] )
	{
		if ( ( pPlayer.pev.button & IN_JUMP ) != 0 )
			gravityon( index );
		else
		{
			if ( ( pPlayer.pev.oldbuttons & IN_JUMP ) != 0 )
				gravityoff( index );
		}
	}
	
	return HOOK_CONTINUE;
}

HookReturnCode PlayerTakeDamage( DamageInfo@ diData )
{
	// STOP BEING FUCKING STUPID, DEVS!
	//
	// CBasePlayer@ pPlayer = cast< CBasePlayer@ >( diData.pVictim );
	// Can't implicitly convert from 'const CBaseEntity@' to 'CBaseEntity@&
	
	entvars_t@ pFuckDevs = @diData.pVictim.pev;
	CBasePlayer@ pPlayer = cast< CBasePlayer@ >( g_EntityFuncs.Instance( pFuckDevs ) );
	
	int index = pPlayer.entindex();
	
	// Free Fall special skill
	if ( freefall[ index ] > 0 && !gNoSkills ) // Skills must be active
	{
		// Handicap NOT enabled
		if ( !handicap13[ index ] )
		{
			// Falldamage?
			if ( diData.pAttacker.entindex() == 0 )
			{
				// Get and reduce damage
				float flNewDamage = diData.flDamage;
				flNewDamage = flNewDamage * ( 100.0 - ( float( freefall[ index ] ) * 5.0 ) ) / 100.0;
				diData.flDamage = flNewDamage;
			}
		}
	}
	
	// Big Explosion handicap
	if ( handicap10[ index ] )
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
	
	// Playing on Hard Mode, or Sandbox Mode and Sparks of Life are active?
	if ( mode[ index ] == 3 || mode[ index ] == 4 && sparks_p[ index ] >= 0 )
	{
		// Handicap NOT enabled
		if ( !handicap7[ index ] )
		{
			// Unless player is taking the risk with the handicap, never allow the player to be gibbed!
			int iDamageType = diData.bitsDamageType;
			iDamageType |= DMG_NEVERGIB;
			iDamageType &= ~DMG_ALWAYSGIB;
			diData.bitsDamageType = iDamageType;
		}
	}
	
	return HOOK_CONTINUE;
}

void gravityon( const int& in index )
{
	CBasePlayer@ pPlayer = g_PlayerFuncs.FindPlayerByIndex( index );
	
	if ( pPlayer !is null && pPlayer.IsConnected() )
	{
		if ( pPlayer.pev.deadflag == DEAD_NO )
		{
			switch( mode[ index ] )
			{
				case 1:
					pPlayer.pev.gravity = ( handicap12[ index ] ? 1.25 : 1.00 ) - ( 0.015 * float( gravity[ index ] ) ); break;
				case 2:
					pPlayer.pev.gravity = ( handicap12[ index ] ? 1.25 : 1.00 ) - ( 0.015 * float( gravity[ index ] ) ) - ( 0.001 * ( handicap13[ index ] ? 0.0 : ( float( medals[ index ] ) / 2.0 ) ) ); break;
				case 3:
					pPlayer.pev.gravity = ( handicap12[ index ] ? 1.25 : 1.00 ) - ( 0.008 * float( gravity[ index ] ) ) - ( 0.002 * ( handicap13[ index ] ? 0.0 : float( medals_h[ index ] ) ) ); break;
				case 4:
					pPlayer.pev.gravity = ( handicap12[ index ] ? 1.25 : 1.00 ) - ( 0.012 * float( gravity[ index ] ) ) - ( 0.001 * ( handicap13[ index ] ? 0.0 : ( float( medals_p[ index ] ) / 1.5 ) ) ); break;
			}
		}
	}
}

void gravityoff( const int& in index )
{
	CBasePlayer@ pPlayer = g_PlayerFuncs.FindPlayerByIndex( index );
	
	if ( pPlayer !is null && pPlayer.IsConnected() )
	{
		if ( pPlayer.pev.deadflag == DEAD_NO )
			pPlayer.pev.gravity = ( handicap12[ index ] ? 1.25 : 1.00 );
	}
}

void scxpm_breset( const int& in index, bool silent = false )
{
	CBasePlayer@ pPlayer = g_PlayerFuncs.FindPlayerByIndex( index );
	
	// No skills
	if ( gNoSkills )
	{
		g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "[SCXPM] El uso de las habilidades esta desactivado en este mapa\n" );
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
	
	skillpoints[ index ] = playerlevel[ index ];
	
	switch( mode[ index ] )
	{
		case 1:
		{
			if ( pPlayer.pev.health > starthealth )
				pPlayer.pev.health = starthealth;
			
			if ( pPlayer.pev.armorvalue > startarmor )
				pPlayer.pev.armorvalue = startarmor;
			break;
		}
		case 2:
		{
			if ( pPlayer.pev.health > starthealth + ( handicap13[ index ] ? 0.0 : ( float( medals[ index ] ) / 2.0 ) ) )
				pPlayer.pev.health = starthealth + ( handicap13[ index ] ? 0.0 : ( float( medals[ index ] ) / 2.0 ) );
			
			if ( pPlayer.pev.armorvalue > startarmor + ( handicap13[ index ] ? 0.0 : ( float( medals[ index ] ) / 2.0 ) ) )
				pPlayer.pev.armorvalue = startarmor + ( handicap13[ index ] ? 0.0 : ( float( medals[ index ] ) / 2.0 ) );
			break;
		}
		case 3:
		{
			if ( pPlayer.pev.health > starthealth + ( handicap13[ index ] ? 0.0 : float( medals_h[ index ] ) ) )
				pPlayer.pev.health = starthealth + ( handicap13[ index ] ? 0.0 : float( medals_h[ index ] ) );
			
			if ( pPlayer.pev.armorvalue > startarmor + ( handicap13[ index ] ? 0.0 : float( medals_h[ index ] ) ) )
				pPlayer.pev.armorvalue = startarmor + ( handicap13[ index ] ? 0.0 : float( medals_h[ index ] ) );
			break;
		}
		case 4:
		{
			if ( pPlayer.pev.health > starthealth + ( handicap13[ index ] ? 0.0 : ( float( medals_p[ index ] ) / 1.5 ) ) )
				pPlayer.pev.health = starthealth + ( handicap13[ index ] ? 0.0 : ( float( medals_p[ index ] ) / 1.5 ) );
			
			if ( pPlayer.pev.armorvalue > startarmor + ( handicap13[ index ] ? 0.0 : ( float( medals_p[ index ] ) / 1.5 ) ) )
				pPlayer.pev.armorvalue = startarmor + ( handicap13[ index ] ? 0.0 : ( float( medals_p[ index ] ) / 1.5 ) );
			break;
		}
	}
	
	pPlayer.pev.gravity = 1.0;
	pPlayer.pev.flags &= ~FL_GODMODE; // Force turn-off godmode, prevents exploitation
	
	if ( !silent )
	{
		if ( skillpoints[ index ] > 0 )
		{
			g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "[SCXPM] Reiniciaste todas tus habilidades\n" );
			g_Scheduler.SetTimeout( "SCXPMSkill", 0.01, index );
		}
		else
			g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "[SCXPM] No tienes habilidades\n" );
	}
}

void scxpm_sreset( const int& in index )
{
	CBasePlayer@ pPlayer = g_PlayerFuncs.FindPlayerByIndex( index );
	
	if ( mode[ index ] == 1 )
	{
		g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "[SCXPM] No puedes usar esto en Modo Facil\n" );
		return;
	}
	
	// No skills
	if ( gNoSkills )
	{
		g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "[SCXPM] El uso de las habilidades esta desactivado en este mapa\n" );
		return;
	}
	
	if ( ( bData[ index ] & SS_DISPENCER ) != 0 )
		bData[ index ] &= ~SS_DISPENCER;
	
	if ( ( bData[ index ] & SS_RANGEHEAL ) != 0 )
		bData[ index ] &= ~SS_RANGEHEAL;
	
	spawndmg[ index ] = 0;
	ubercharge[ index ] = 0;
	freefall[ index ] = 0;
	demoman[ index ] = 0;
	practiceshot[ index ] = 0;
	bioelectric[ index ] = 0;
	redcross[ index ] = 0;
	pPlayer.SetMaxAmmo( AMMO_MEDKIT, 100 );
	if ( pPlayer.m_rgAmmo( AMMO_MEDKIT ) > pPlayer.GetMaxAmmo( AMMO_MEDKIT ) ) pPlayer.RemoveExcessAmmo( AMMO_MEDKIT ); // Prevent overflow
	
	switch( mode[ index ] )
	{
		case 2:
		{
			specialpoints[ index ] = medals[ index ];
			break;
		}
		case 3:
		{
			specialpoints[ index ] = medals_h[ index ];
			break;
		}
	}
	
	if ( specialpoints[ index ] > 0 )
	{
		g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "[SCXPM] Reiniciaste todas tus habilidades especiales\n" );
		g_Scheduler.SetTimeout( "SCXPMSpecials", 0.01, index );
	}
	else
		g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "[SCXPM] No tienes habilidades especiales\n" );
}

void SCXPMSkill( const int& in index )
{
	// No skills
	if ( gNoSkills )
	{
		CBasePlayer@ pPlayer = g_PlayerFuncs.FindPlayerByIndex( index );
		g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "[SCXPM] El uso de las habilidades esta desactivado en este mapa\n" );
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
	state.menu.SetTitle( "Aumentar tus habilidades de a...\n\n" );
	
	state.menu.AddItem( "...1 punto\n", any( "item1" ) );
	state.menu.AddItem( "...5 puntos\n", any( "item2" ) );
	state.menu.AddItem( "...10 puntos\n", any( "item3" ) );
	state.menu.AddItem( "...25 puntos\n", any( "item4" ) );
	
	if ( skillpoints[ index ] >= 50 )
		state.menu.AddItem( "...50 puntos\n", any( "item5" ) );
	
	if ( skillpoints[ index ] >= 100 )
		state.menu.AddItem( "...100 puntos", any( "item6" ) );
	
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
	
	string titletext = "Habilidades\n\n";
	titletext += "Puntos disponibles: " + skillpoints[ index ] + "\n\n";
	
	string skill1text = "Vida Inicial [ " + health[ index ] + " ]\n";
	string skill2text = "Armor Inicial [ " + armor[ index ] + " ]\n";
	string skill3text = "Regeneracion de Vida [ " + rhealth[ index ] + " ]\n";
	string skill4text = "Regeneracion de Armor [ " + rarmor[ index ] + " ]\n";
	string skill5text = "Regeneracion de Balas [ " + rammo[ index ] + " ]\n";
	string skill6text = "Anti-Gravedad [ " + gravity[ index ] + " ]\n";
	string skill7text = "Conocimiento [ " + speed[ index ] + " ]\n";
	string skill8text = "Poder de Equipo [ " + dist[ index ] + " ]\n";
	string skill9text = "Bloqueo de Ataques [ " + dodge[ index ] + " ]";
	
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
			if ( health[ index ] < 100 && mode[ index ] == 1 )
			{
				if ( skillIncrement[ index ] + health[ index ] >= 100 )
					skillIncrement[ index ] = 100 - health[ index ];
				
				skillpoints[ index ] -= skillIncrement[ index ];
				health[ index ] += skillIncrement[ index ];
				
				pSkills.SetKeyvalue( "$i_health", health[ index ] );
			}
			else if ( health[ index ] < 75 + ( ubercharge[ index ] * 4 ) && mode[ index ] == 2 )
			{
				if ( skillIncrement[ index ] + health[ index ] >= 75 + ( ubercharge[ index ] * 4 ) )
					skillIncrement[ index ] = 75 + ( ubercharge[ index ] * 4 ) - health[ index ];
				
				skillpoints[ index ] -= skillIncrement[ index ];
				health[ index ] += skillIncrement[ index ];
				
				pSkills.SetKeyvalue( "$i_health", health[ index ] );
			}
			else if ( health[ index ] < 430 + ( ubercharge[ index ] * 4 ) && mode[ index ] == 3 )
			{
				if ( skillIncrement[ index ] + health[ index ] >= 430 + ( ubercharge[ index ] * 4 ) )
					skillIncrement[ index ] = 430 + ( ubercharge[ index ] * 4 ) - health[ index ];
				
				skillpoints[ index ] -= skillIncrement[ index ];
				health[ index ] += skillIncrement[ index ];
				
				pSkills.SetKeyvalue( "$i_health", health[ index ] );
			}
			else if ( health[ index ] < health_max_p[ index ] + ( ubercharge[ index ] * 4 ) && mode[ index ] == 4 )
			{
				if ( skillIncrement[ index ] + health[ index ] >= health_max_p[ index ] + ( ubercharge[ index ] * 4 ) )
					skillIncrement[ index ] = health_max_p[ index ] + ( ubercharge[ index ] * 4 ) - health[ index ];
				
				skillpoints[ index ] -= skillIncrement[ index ];
				health[ index ] += skillIncrement[ index ];
				
				pSkills.SetKeyvalue( "$i_health", health[ index ] );
			}
			else
				g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "[SCXPM] Ya tienes esto al maximo! Elige otra cosa!\n" );
			
			g_Scheduler.SetTimeout( "SCXPMSkill", 0.01, index );
		}
		else
			g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "[SCXPM] Necesitas al menos 1 punto para mejorar Vida Inicial\n" );
	}
	else if ( selection == 'item2' )
	{
		if ( skillpoints[ index ] > 0 )
		{
			if ( armor[ index ] < 100 && mode[ index ] == 1 )
			{
				if ( skillIncrement[ index ] + armor[ index ] >= 100 )
					skillIncrement[ index ] = 100 - armor[ index ];
				
				skillpoints[ index ] -= skillIncrement[ index ];
				armor[ index ] += skillIncrement[ index ];
				
				pSkills.SetKeyvalue( "$i_armor", armor[ index ] );
			}
			else if ( armor[ index ] < 75 + ( ubercharge[ index ] * 4 ) && mode[ index ] == 2 )
			{
				if ( skillIncrement[ index ] + armor[ index ] >= 75 + ( ubercharge[ index ] * 4 ) )
					skillIncrement[ index ] = 75 + ( ubercharge[ index ] * 4 ) - armor[ index ];
				
				skillpoints[ index ] -= skillIncrement[ index ];
				armor[ index ] += skillIncrement[ index ];
				
				pSkills.SetKeyvalue( "$i_armor", armor[ index ] );
			}
			else if ( armor[ index ] < 430 + ( ubercharge[ index ] * 4 ) && mode[ index ] == 3 )
			{
				if ( skillIncrement[ index ] + armor[ index ] >= 430 + ( ubercharge[ index ] * 4 ) )
					skillIncrement[ index ] = 430 + ( ubercharge[ index ] * 4 ) - armor[ index ];
				
				skillpoints[ index ] -= skillIncrement[ index ];
				armor[ index ] += skillIncrement[ index ];
				
				pSkills.SetKeyvalue( "$i_armor", armor[ index ] );
			}
			else if ( armor[ index ] < armor_max_p[ index ] + ( ubercharge[ index ] * 4 ) && mode[ index ] == 4 )
			{
				if ( skillIncrement[ index ] + armor[ index ] >= armor_max_p[ index ] + ( ubercharge[ index ] * 4 ) )
					skillIncrement[ index ] = armor_max_p[ index ] + ( ubercharge[ index ] * 4 ) - armor[ index ];
				
				skillpoints[ index ] -= skillIncrement[ index ];
				armor[ index ] += skillIncrement[ index ];
				
				pSkills.SetKeyvalue( "$i_armor", armor[ index ] );
			}
			else
				g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "[SCXPM] Ya tienes esto al maximo! Elige otra cosa!\n" );
			
			g_Scheduler.SetTimeout( "SCXPMSkill", 0.01, index );
		}
		else
			g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "[SCXPM] Necesitas al menos 1 punto para mejorar Armor Inicial\n" );
	}
	else if ( selection == 'item3' )
	{
		if ( skillpoints[ index ] > 0 )
		{
			if ( rhealth[ index ] < 90 && mode[ index ] == 1 )
			{
				if ( skillIncrement[ index ] + rhealth[ index ] >= 90 )
					skillIncrement[ index ] = 90 - rhealth[ index ];
				
				skillpoints[ index ] -= skillIncrement[ index ];
				rhealth[ index ] += skillIncrement[ index ];
				
				pSkills.SetKeyvalue( "$i_rhealth", rhealth[ index ] );
			}
			else if ( rhealth[ index ] < 70 + ( ubercharge[ index ] * 3 ) && mode[ index ] == 2 )
			{
				if ( skillIncrement[ index ] + rhealth[ index ] >= 70 + ( ubercharge[ index ] * 3 ) )
					skillIncrement[ index ] = 70 + ( ubercharge[ index ] * 3 ) - rhealth[ index ];
				
				skillpoints[ index ] -= skillIncrement[ index ];
				rhealth[ index ] += skillIncrement[ index ];
				
				pSkills.SetKeyvalue( "$i_rhealth", rhealth[ index ] );
			}
			else if ( rhealth[ index ] < 285 + ( ubercharge[ index ] * 3 ) && mode[ index ] == 3 )
			{
				if ( skillIncrement[ index ] + rhealth[ index ] >= 285 + ( ubercharge[ index ] * 3 ) )
					skillIncrement[ index ] = 285 + ( ubercharge[ index ] * 3 ) - rhealth[ index ];
				
				skillpoints[ index ] -= skillIncrement[ index ];
				rhealth[ index ] += skillIncrement[ index ];
				
				pSkills.SetKeyvalue( "$i_rhealth", rhealth[ index ] );
			}
			else if ( rhealth[ index ] < rhealth_max_p[ index ] + ( ubercharge[ index ] * 3 ) && mode[ index ] == 4 )
			{
				if ( skillIncrement[ index ] + rhealth[ index ] >= rhealth_max_p[ index ] + ( ubercharge[ index ] * 3 ) )
					skillIncrement[ index ] = rhealth_max_p[ index ] + ( ubercharge[ index ] * 3 ) - rhealth[ index ];
				
				skillpoints[ index ] -= skillIncrement[ index ];
				rhealth[ index ] += skillIncrement[ index ];
				
				pSkills.SetKeyvalue( "$i_rhealth", rhealth[ index ] );
			}
			else
				g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "[SCXPM] Ya tienes esto al maximo! Elige otra cosa!\n" );
			
			g_Scheduler.SetTimeout( "SCXPMSkill", 0.01, index );
		}
		else
			g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "[SCXPM] Necesitas al menos 1 punto para mejorar Regeneracion de Vida\n" );
	}
	else if ( selection == 'item4' )
	{
		if ( skillpoints[ index ] > 0 )
		{
			if ( rarmor[ index ] < 90 && mode[ index ] == 1 )
			{
				if ( skillIncrement[ index ] + rarmor[ index ] >= 90 )
					skillIncrement[ index ] = 90 - rarmor[ index ];
				
				skillpoints[ index ] -= skillIncrement[ index ];
				rarmor[ index ] += skillIncrement[ index ];
				
				pSkills.SetKeyvalue( "$i_rarmor", rarmor[ index ] );
			}
			else if ( rarmor[ index ] < 70 + ( ubercharge[ index ] * 3 ) && mode[ index ] == 2 )
			{
				if ( skillIncrement[ index ] + rarmor[ index ] >= 70 + ( ubercharge[ index ] * 3 ) )
					skillIncrement[ index ] = 70 + ( ubercharge[ index ] * 3 ) - rarmor[ index ];
				
				skillpoints[ index ] -= skillIncrement[ index ];
				rarmor[ index ] += skillIncrement[ index ];
				
				pSkills.SetKeyvalue( "$i_rarmor", rarmor[ index ] );
			}
			else if ( rarmor[ index ] < 285 + ( ubercharge[ index ] * 3 ) && mode[ index ] == 3 )
			{
				if ( skillIncrement[ index ] + rarmor[ index ] >= 285 + ( ubercharge[ index ] * 3 ) )
					skillIncrement[ index ] = 285 + ( ubercharge[ index ] * 3 ) - rarmor[ index ];
				
				skillpoints[ index ] -= skillIncrement[ index ];
				rarmor[ index ] += skillIncrement[ index ];
				
				pSkills.SetKeyvalue( "$i_rarmor", rarmor[ index ] );
			}
			else if ( rarmor[ index ] < rarmor_max_p[ index ] + ( ubercharge[ index ] * 3 ) && mode[ index ] == 4 )
			{
				if ( skillIncrement[ index ] + rarmor[ index ] >= rarmor_max_p[ index ] + ( ubercharge[ index ] * 3 ) )
					skillIncrement[ index ] = rarmor_max_p[ index ] + ( ubercharge[ index ] * 3 ) - rarmor[ index ];
				
				skillpoints[ index ] -= skillIncrement[ index ];
				rarmor[ index ] += skillIncrement[ index ];
				
				pSkills.SetKeyvalue( "$i_rarmor", rarmor[ index ] );
			}
			else
				g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "[SCXPM] Ya tienes esto al maximo! Elige otra cosa!\n" );
			
			g_Scheduler.SetTimeout( "SCXPMSkill", 0.01, index );
		}
		else
			g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "[SCXPM] Necesitas al menos 1 punto para mejorar Regeneracion de Armor\n" );
	}
	else if ( selection == 'item5' )
	{
		if ( skillpoints[ index ] > 0 )
		{
			if ( rammo[ index ] < 25 && mode[ index ] == 1 )
			{
				if ( skillIncrement[ index ] + rammo[ index ] >= 25 )
					skillIncrement[ index ] = 25 - rammo[ index ];
				
				skillpoints[ index ] -= skillIncrement[ index ];
				rammo[ index ] += skillIncrement[ index ];
				
				pSkills.SetKeyvalue( "$i_rammo", rammo[ index ] );
			}
			else if ( rammo[ index ] < 15 + ubercharge[ index ] && mode[ index ] == 2 )
			{
				if ( skillIncrement[ index ] + rammo[ index ] >= 15 + ubercharge[ index ] )
					skillIncrement[ index ] = 15 + ubercharge[ index ] - rammo[ index ];
				
				skillpoints[ index ] -= skillIncrement[ index ];
				rammo[ index ] += skillIncrement[ index ];
				
				pSkills.SetKeyvalue( "$i_rammo", rammo[ index ] );
			}
			else if ( rammo[ index ] < 25 + ubercharge[ index ] && mode[ index ] == 3 )
			{
				if ( skillIncrement[ index ] + rammo[ index ] >= 25 + ubercharge[ index ] )
					skillIncrement[ index ] = 25 + ubercharge[ index ] - rammo[ index ];
				
				skillpoints[ index ] -= skillIncrement[ index ];
				rammo[ index ] += skillIncrement[ index ];
				
				pSkills.SetKeyvalue( "$i_rammo", rammo[ index ] );
			}
			else if ( rammo[ index ] < rammo_max_p[ index ] + ubercharge[ index ] && mode[ index ] == 4 )
			{
				if ( skillIncrement[ index ] + rammo[ index ] >= rammo_max_p[ index ] + ubercharge[ index ] )
					skillIncrement[ index ] = rammo_max_p[ index ] + ubercharge[ index ] - rammo[ index ];
				
				skillpoints[ index ] -= skillIncrement[ index ];
				rammo[ index ] += skillIncrement[ index ];
				
				pSkills.SetKeyvalue( "$i_rammo", rammo[ index ] );
			}
			else
				g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "[SCXPM] Ya tienes esto al maximo! Elige otra cosa!\n" );
			
			g_Scheduler.SetTimeout( "SCXPMSkill", 0.01, index );
		}
		else
			g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "[SCXPM] Necesitas al menos 1 punto para mejorar Regeneracion de Balas\n" );
	}
	else if ( selection == 'item6' )
	{
		if ( skillpoints[ index ] > 0 )
		{
			if ( gravity[ index ] < 30 && mode[ index ] == 1 )
			{
				if ( skillIncrement[ index ] + gravity[ index ] >= 30 )
					skillIncrement[ index ] = 30 - gravity[ index ];
				
				skillpoints[ index ] -= skillIncrement[ index ];
				gravity[ index ] += skillIncrement[ index ];
				
				pSkills.SetKeyvalue( "$i_gravity", gravity[ index ] );
			}
			else if ( gravity[ index ] < 20 + ( ubercharge[ index ] * 2 ) && mode[ index ] == 2 )
			{
				if ( skillIncrement[ index ] + gravity[ index ] >= 20 + ( ubercharge[ index ] * 2 ) )
					skillIncrement[ index ] = 20 + ( ubercharge[ index ] * 2 ) - gravity[ index ];
				
				skillpoints[ index ] -= skillIncrement[ index ];
				gravity[ index ] += skillIncrement[ index ];
				
				pSkills.SetKeyvalue( "$i_gravity", gravity[ index ] );
			}
			else if ( gravity[ index ] < 30 + ( ubercharge[ index ] * 2 ) && mode[ index ] == 3 )
			{
				if ( skillIncrement[ index ] + gravity[ index ] >= 30 + ( ubercharge[ index ] * 2 ) )
					skillIncrement[ index ] = 30 + ( ubercharge[ index ] * 2 ) - gravity[ index ];
				
				skillpoints[ index ] -= skillIncrement[ index ];
				gravity[ index ] += skillIncrement[ index ];
				
				pSkills.SetKeyvalue( "$i_gravity", gravity[ index ] );
			}
			else if ( gravity[ index ] < gravity_max_p[ index ] + ( ubercharge[ index ] * 2 ) && mode[ index ] == 4 )
			{
				if ( skillIncrement[ index ] + gravity[ index ] >= gravity_max_p[ index ] + ( ubercharge[ index ] * 2 ) )
					skillIncrement[ index ] = gravity_max_p[ index ] + ( ubercharge[ index ] * 2 ) - gravity[ index ];
				
				skillpoints[ index ] -= skillIncrement[ index ];
				gravity[ index ] += skillIncrement[ index ];
				
				pSkills.SetKeyvalue( "$i_gravity", gravity[ index ] );
			}
			else
				g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "[SCXPM] Ya tienes esto al maximo! Elige otra cosa!\n" );
			
			g_Scheduler.SetTimeout( "SCXPMSkill", 0.01, index );
		}
		else
			g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "[SCXPM] Necesitas al menos 1 punto para mejorar Anti-Gravedad\n" );
	}
	else if ( selection == 'item7' )
	{
		if ( skillpoints[ index ] > 0 )
		{
			if ( speed[ index ] < 80 && mode[ index ] == 1 )
			{
				if ( skillIncrement[ index ] + speed[ index ] >= 80 )
					skillIncrement[ index ] = 80 - speed[ index ];
				
				skillpoints[ index ] -= skillIncrement[ index ];
				speed[ index ] += skillIncrement[ index ];
				
				pSkills.SetKeyvalue( "$i_speed", speed[ index ] );
			}
			else if ( speed[ index ] < 40 + ( ubercharge[ index ] * 4 ) && mode[ index ] == 2 )
			{
				if ( skillIncrement[ index ] + speed[ index ] >= 40 + ( ubercharge[ index ] * 4 ) )
					skillIncrement[ index ] = 40 + ( ubercharge[ index ] * 4 ) - speed[ index ];
				
				skillpoints[ index ] -= skillIncrement[ index ];
				speed[ index ] += skillIncrement[ index ];
				
				pSkills.SetKeyvalue( "$i_speed", speed[ index ] );
			}
			else if ( speed[ index ] < 60 + ( ubercharge[ index ] * 4) && mode[ index ] == 3 )
			{
				if ( skillIncrement[ index ] + speed[ index ] >= 60 + ( ubercharge[ index ] * 4 ) )
					skillIncrement[ index ] = 60 + ( ubercharge[ index ] * 4 ) - speed[ index ];
				
				skillpoints[ index ] -= skillIncrement[ index ];
				speed[ index ] += skillIncrement[ index ];
				
				pSkills.SetKeyvalue( "$i_speed", speed[ index ] );
			}
			else if ( speed[ index ] < speed_max_p[ index ] + ( ubercharge[ index ] * 4) && mode[ index ] == 4 )
			{
				if ( skillIncrement[ index ] + speed[ index ] >= speed_max_p[ index ] + ( ubercharge[ index ] * 4 ) )
					skillIncrement[ index ] = speed_max_p[ index ] + ( ubercharge[ index ] * 4 ) - speed[ index ];
				
				skillpoints[ index ] -= skillIncrement[ index ];
				speed[ index ] += skillIncrement[ index ];
				
				pSkills.SetKeyvalue( "$i_speed", speed[ index ] );
			}
			else
				g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "[SCXPM] Ya tienes esto al maximo! Elige otra cosa!\n" );
			
			g_Scheduler.SetTimeout( "SCXPMSkill", 0.01, index );
		}
		else
			g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "[SCXPM] Necesitas al menos 1 punto para mejorar Conocimiento\n" );
	}
	else if ( selection == 'item8' )
	{
		if ( skillpoints[ index ] > 0 )
		{
			if ( dist[ index ] < 60 && mode[ index ] == 1 )
			{
				if ( skillIncrement[ index ] + dist[ index ] >= 60 )
					skillIncrement[ index ] = 60 - dist[ index ];
				
				skillpoints[ index ] -= skillIncrement[ index ];
				dist[ index ] += skillIncrement[ index ];
				
				pSkills.SetKeyvalue( "$i_dist", dist[ index ] );
			}
			else if ( dist[ index ] < 30 + ( ubercharge[ index ] * 3 ) && mode[ index ] == 2 )
			{
				if ( skillIncrement[ index ] + dist[ index ] >= 30 + ( ubercharge[ index ] * 3 ) )
					skillIncrement[ index ] = 30 + ( ubercharge[ index ] * 3 ) - dist[ index ];
				
				skillpoints[ index ] -= skillIncrement[ index ];
				dist[ index ] += skillIncrement[ index ];
				
				pSkills.SetKeyvalue( "$i_dist", dist[ index ] );
			}
			else if ( dist[ index ] < 45 + ( ubercharge[ index ] * 3 ) && mode[ index ] == 3 )
			{
				if ( skillIncrement[ index ] + dist[ index ] >= 45 + ( ubercharge[ index ] * 3 ) )
					skillIncrement[ index ] = 45 + ( ubercharge[ index ] * 3 ) - dist[ index ];
				
				skillpoints[ index ] -= skillIncrement[ index ];
				dist[ index ] += skillIncrement[ index ];
				
				pSkills.SetKeyvalue( "$i_dist", dist[ index ] );
			}
			else if ( dist[ index ] < dist_max_p[ index ] + ( ubercharge[ index ] * 3 ) && mode[ index ] == 4 )
			{
				if ( skillIncrement[ index ] + dist[ index ] >= dist_max_p[ index ] + ( ubercharge[ index ] * 3 ) )
					skillIncrement[ index ] = dist_max_p[ index ] + ( ubercharge[ index ] * 3 ) - dist[ index ];
				
				skillpoints[ index ] -= skillIncrement[ index ];
				dist[ index ] += skillIncrement[ index ];
				
				pSkills.SetKeyvalue( "$i_dist", dist[ index ] );
			}
			else
				g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "[SCXPM] Ya tienes esto al maximo! Elige otra cosa!\n" );
			
			g_Scheduler.SetTimeout( "SCXPMSkill", 0.01, index );
		}
		else
			g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "[SCXPM] Necesitas al menos 1 punto para mejorar Poder de Equipo\n" );
	}
	else if ( selection == 'item9' )
	{
		if ( skillpoints[ index ] > 0 )
		{
			if ( dodge[ index ] < 65 && mode[ index ] == 1 )
			{
				if ( skillIncrement[ index ] + dodge[ index ] >= 65 )
					skillIncrement[ index ] = 65 - dodge[ index ];
				
				skillpoints[ index ] -= skillIncrement[ index ];
				dodge[ index ] += skillIncrement[ index ];
				
				pSkills.SetKeyvalue( "$i_dodge", dodge[ index ] );
			}
			else if ( dodge[ index ] < 45 + ubercharge[ index ] && mode[ index ] == 2 )
			{
				if ( skillIncrement[ index ] + dodge[ index ] >= 45 + ubercharge[ index ] )
					skillIncrement[ index ] = 45 + ubercharge[ index ] - dodge[ index ];
				
				skillpoints[ index ] -= skillIncrement[ index ];
				dodge[ index ] += skillIncrement[ index ];
				
				pSkills.SetKeyvalue( "$i_dodge", dodge[ index ] );
			}
			else if ( dodge[ index ] < 85 + ubercharge[ index ] && mode[ index ] == 3 )
			{
				if ( skillIncrement[ index ] + dodge[ index ] >= 85 + ubercharge[ index ] )
					skillIncrement[ index ] = 85 + ubercharge[ index ] - dodge[ index ];
				
				skillpoints[ index ] -= skillIncrement[ index ];
				dodge[ index ] += skillIncrement[ index ];
				
				pSkills.SetKeyvalue( "$i_dodge", dodge[ index ] );
			}
			else if ( dodge[ index ] < dodge_max_p[ index ] + ubercharge[ index ] && mode[ index ] == 4 )
			{
				if ( skillIncrement[ index ] + dodge[ index ] >= dodge_max_p[ index ] + ubercharge[ index ] )
					skillIncrement[ index ] = dodge_max_p[ index ] + ubercharge[ index ] - dodge[ index ];
				
				skillpoints[ index ] -= skillIncrement[ index ];
				dodge[ index ] += skillIncrement[ index ];
				
				pSkills.SetKeyvalue( "$i_dodge", dodge[ index ] );
			}
			else
				g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "[SCXPM] Ya tienes esto al maximo! Elige otra cosa!\n" );
			
			g_Scheduler.SetTimeout( "SCXPMSkill", 0.01, index );
		}
		else
			g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "[SCXPM] Necesitas al menos 1 punto para mejorar Bloqueo de Ataques\n" );
	}
}

void SCXPMSpecials( const int& in index )
{
	CBasePlayer@ pPlayer = g_PlayerFuncs.FindPlayerByIndex( index );
	
	if ( mode[ index ] == 1 )
	{
		g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "[SCXPM] No puedes usar esto en Modo Facil\n" );
		return;
	}
	
	if ( mode[ index ] == 4 && maxmedals_p[ index ] == 0 )
	{
		g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "[SCXPM] La partida actual del Modo Sandbox no permite el uso de esta herramienta\n" );
		return;
	}
	
	// No skills
	if ( gNoSkills )
	{
		g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "[SCXPM] El uso de las habilidades esta desactivado en este mapa\n" );
		return;
	}
	
	switch( mode[ index ] )
	{
		case 2:
		{
			specialpoints[ index ] = medals[ index ];
			break;
		}
		case 3:
		{
			specialpoints[ index ] = medals_h[ index ];
			break;
		}
		case 4:
		{
			specialpoints[ index ] = medals_p[ index ];
			break;
		}
	}
	
	// For some reason it ADDs rather than subtracting... Let's do this manually.
	specialpoints[ index ] -= spawndmg[ index ];
	specialpoints[ index ] -= ubercharge[ index ];
	specialpoints[ index ] -= freefall[ index ];
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
	
	string titletext = "Habilidades Especiales\n\n";
	titletext += "Puntos disponibles: " + specialpoints[ index ] + "\n\n";
	
	string skill2text = "Dispensador Portatil ";
	if ( ( bData[ index ] & SS_DISPENCER ) != 0 )
		skill2text += "[ SI ]\n";
	else
		skill2text += "[ NO ]\n";
	
	string skill8text = "Emergencia Medicinal ";
	if ( ( bData[ index ] & SS_RANGEHEAL ) != 0 )
		skill8text += "[ SI ]\n";
	else
		skill8text += "[ NO ]\n";
	
	string skill1text = "Golpe Inicial [ " + spawndmg[ index ] + " ]\n";
	string skill3text = "Sobrecarga [ " + ubercharge[ index ] + " ]\n";
	string skill4text = "Caida Libre [ " + freefall[ index ] + " ]\n";
	string skill5text = "Demoledor [ " + demoman[ index ] + " ]\n";
	string skill6text = "Tiro de Practica [ " + practiceshot[ index ] + " ]\n";
	string skill7text = "BioElectricista [ " + bioelectric[ index ] + " ]\n";
	string skill9text = "Cruz Roja [ " + redcross[ index ] + " ]\n";
	
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
			if ( spawndmg[ index ] < 10 && mode[ index ] != 4 || spawndmg[ index ] < spawndmg_max_p[ index ] && mode[ index ] == 4 )
				spawndmg[ index ]++;
			else
				g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "[SCXPM] Ya tienes esto al maximo! Elige otra cosa!\n" );
			
			g_Scheduler.SetTimeout( "SCXPMSpecials", 0.01, index );
		}
		else
			g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "[SCXPM] Necesitas al menos 1 punto para mejorar Golpe Inicial\n" );
	}
	else if ( selection == 'item2' )
	{
		if ( specialpoints[ index ] > 0 )
		{
			if ( !( ( bData[ index ] & SS_DISPENCER ) != 0 ) )
				bData[ index ] |= SS_DISPENCER;
			else
				g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "[SCXPM] Ya activaste esto! Elige otra cosa!\n" );
			
			g_Scheduler.SetTimeout( "SCXPMSpecials", 0.01, index );
		}
		else
			g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "[SCXPM] Necesitas al menos 1 punto para activar el Dispensador Portatil\n" );
	}
	else if ( selection == 'item3' )
	{
		if ( specialpoints[ index ] > 0 )
		{
			if ( ubercharge[ index ] < 10 && mode[ index ] != 4 || ubercharge[ index ] < ubercharge_max_p[ index ] && mode[ index ] == 4 )
				ubercharge[ index ]++;
			else
				g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "[SCXPM] Ya tienes esto al maximo! Elige otra cosa!\n" );
			
			g_Scheduler.SetTimeout( "SCXPMSpecials", 0.01, index );
		}
		else
			g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "[SCXPM] Necesitas al menos 1 punto para mejorar Sobrecarga\n" );
	}
	else if ( selection == 'item4' )
	{
		if ( specialpoints[ index ] > 0 )
		{
			if ( freefall[ index ] < 10 && mode[ index ] != 4 || freefall[ index ] < freefall_max_p[ index ] && mode[ index ] == 4 )
				freefall[ index ]++;
			else
				g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "[SCXPM] Ya tienes esto al maximo! Elige otra cosa!\n" );
			
			g_Scheduler.SetTimeout( "SCXPMSpecials", 0.01, index );
		}
		else
			g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "[SCXPM] Necesitas al menos 1 punto para mejorar Caida Libre\n" );
	}
	else if ( selection == 'item5' )
	{
		if ( specialpoints[ index ] > 0 )
		{
			if ( demoman[ index ] < 5 && mode[ index ] != 4 || demoman[ index ] < demoman_max_p[ index ] && mode[ index ] == 4 )
				demoman[ index ]++;
			else
				g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "[SCXPM] Ya tienes esto al maximo! Elige otra cosa!\n" );
			
			g_Scheduler.SetTimeout( "SCXPMSpecials", 0.01, index );
		}
		else
			g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "[SCXPM] Necesitas al menos 1 punto para mejorar Demoledor\n" );
	}
	else if ( selection == 'item6' )
	{
		if ( specialpoints[ index ] > 0 )
		{
			if ( practiceshot[ index ] < 5 && mode[ index ] != 4 || practiceshot[ index ] < practiceshot_max_p[ index ] && mode[ index ] == 4 )
				practiceshot[ index ]++;
			else
				g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "[SCXPM] Ya tienes esto al maximo! Elige otra cosa!\n" );
			
			g_Scheduler.SetTimeout( "SCXPMSpecials", 0.01, index );
		}
		else
			g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "[SCXPM] Necesitas al menos 1 punto para mejorar Tiro de Practica\n" );
	}
	else if ( selection == 'item7' )
	{
		if ( specialpoints[ index ] > 0 )
		{
			if ( bioelectric[ index ] < 10 && mode[ index ] != 4 || bioelectric[ index ] < bioelectric_max_p[ index ] && mode[ index ] == 4 )
				bioelectric[ index ]++;
			else
				g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "[SCXPM] Ya tienes esto al maximo! Elige otra cosa!\n" );
			
			g_Scheduler.SetTimeout( "SCXPMSpecials", 0.01, index );
		}
		else
			g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "[SCXPM] Necesitas al menos 1 punto para mejorar BioElectricista\n" );
	}
	else if ( selection == 'item8' )
	{
		if ( specialpoints[ index ] > 0 )
		{
			if ( !( ( bData[ index ] & SS_RANGEHEAL ) != 0 ) )
				bData[ index ] |= SS_RANGEHEAL;
			else
				g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "[SCXPM] Ya activaste esto! Elige otra cosa!\n" );
			
			g_Scheduler.SetTimeout( "SCXPMSpecials", 0.01, index );
		}
		else
			g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "[SCXPM] Necesitas al menos 1 punto para activar la Emergencia Medicinal\n" );
	}
	else if ( selection == 'item9' )
	{
		if ( specialpoints[ index ] > 0 )
		{
			if ( redcross[ index ] < 5 && mode[ index ] != 4 || redcross[ index ] < redcross_max_p[ index ] && mode[ index ] == 4 )
			{
				redcross[ index ]++;
				
				// Manual update of Red Cross
				pPlayer.SetMaxAmmo( AMMO_MEDKIT, 100 + ( redcross[ index ] * 10 * ( mode[ index ] == 3 ? 2 : 1 ) ) );
			}
			else
				g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "[SCXPM] Ya tienes esto al maximo! Elige otra cosa!\n" );
			
			g_Scheduler.SetTimeout( "SCXPMSpecials", 0.01, index );
		}
		else
			g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "[SCXPM] Necesitas al menos 1 punto para mejorar Cruz Roja\n" );
	}
}

void scxpm_others( const int& in index )
{
	CBasePlayer@ pPlayer = g_PlayerFuncs.FindPlayerByIndex( index );
	
	// Could rewrite this with the new ShowMOTD code, but not now. I'm lazy :P
	NetworkMessage title( MSG_ONE_UNRELIABLE, NetworkMessages::ServerName, pPlayer.edict() );
	title.WriteString( "Datos de los jugadores" );
	title.End();
	
	NetworkMessage head1( MSG_ONE_UNRELIABLE, NetworkMessages::MOTD, pPlayer.edict() );
	head1.WriteByte( 0 );
	head1.WriteString( "Jugador*           Nivel   Medallas      " );
	head1.End();
	
	NetworkMessage head2( MSG_ONE_UNRELIABLE, NetworkMessages::MOTD, pPlayer.edict() );
	head2.WriteByte( 0 );
	head2.WriteString( "Modalidad\n\n" );
	head2.End();
	
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
			
			switch( mode[ i ] )
			{
				case 1:
				{
					NetworkMessage mmsg1( MSG_ONE_UNRELIABLE, NetworkMessages::MOTD, pPlayer.edict() );
					mmsg1.WriteByte( 0 );
					mmsg1.WriteString( name );
					mmsg1.End();
					
					NetworkMessage mmsg2( MSG_ONE_UNRELIABLE, NetworkMessages::MOTD, pPlayer.edict() );
					mmsg2.WriteByte( 0 );
					mmsg2.WriteString( spaces );
					mmsg2.End();
					
					data = "" + playerlevel[ i ] + "      -         Facil\n";
					
					NetworkMessage mmsg3( MSG_ONE_UNRELIABLE, NetworkMessages::MOTD, pPlayer.edict() );
					mmsg3.WriteByte( 0 );
					mmsg3.WriteString( data );
					mmsg3.End();
					
					break;
				}
				case 2:
				{
					NetworkMessage mmsg1( MSG_ONE_UNRELIABLE, NetworkMessages::MOTD, pPlayer.edict() );
					mmsg1.WriteByte( 0 );
					mmsg1.WriteString( name );
					mmsg1.End();
					
					NetworkMessage mmsg2( MSG_ONE_UNRELIABLE, NetworkMessages::MOTD, pPlayer.edict() );
					mmsg2.WriteByte( 0 );
					mmsg2.WriteString( spaces );
					mmsg2.End();
					
					data = "" + playerlevel[ i ] + "      " + medals[ i ] + "         Normal\n";
					
					NetworkMessage mmsg3( MSG_ONE_UNRELIABLE, NetworkMessages::MOTD, pPlayer.edict() );
					mmsg3.WriteByte( 0 );
					mmsg3.WriteString( data );
					mmsg3.End();
					
					break;
				}
				case 3:
				{
					NetworkMessage mmsg1( MSG_ONE_UNRELIABLE, NetworkMessages::MOTD, pPlayer.edict() );
					mmsg1.WriteByte( 0 );
					mmsg1.WriteString( name );
					mmsg1.End();
					
					NetworkMessage mmsg2( MSG_ONE_UNRELIABLE, NetworkMessages::MOTD, pPlayer.edict() );
					mmsg2.WriteByte( 0 );
					mmsg2.WriteString( spaces );
					mmsg2.End();
					
					data = "" + playerlevel[ i ] + "      " + medals_h[ i ] + "         Dificil\n";
					
					NetworkMessage mmsg3( MSG_ONE_UNRELIABLE, NetworkMessages::MOTD, pPlayer.edict() );
					mmsg3.WriteByte( 0 );
					mmsg3.WriteString( data );
					mmsg3.End();
					
					break;
				}
				case 4:
				{
					NetworkMessage mmsg1( MSG_ONE_UNRELIABLE, NetworkMessages::MOTD, pPlayer.edict() );
					mmsg1.WriteByte( 0 );
					mmsg1.WriteString( name );
					mmsg1.End();
					
					NetworkMessage mmsg2( MSG_ONE_UNRELIABLE, NetworkMessages::MOTD, pPlayer.edict() );
					mmsg2.WriteByte( 0 );
					mmsg2.WriteString( spaces );
					mmsg2.End();
					
					data = "" + playerlevel[ i ] + "      " + medals_p[ i ] + "         Sandbox\n";
					
					NetworkMessage mmsg3( MSG_ONE_UNRELIABLE, NetworkMessages::MOTD, pPlayer.edict() );
					mmsg3.WriteByte( 0 );
					mmsg3.WriteString( data );
					mmsg3.End();
					
					break;
				}
			}
		}
	}
	
	NetworkMessage note1( MSG_ONE_UNRELIABLE, NetworkMessages::MOTD, pPlayer.edict() );
	note1.WriteByte( 0 );
	note1.WriteString( "\n* Los nombres muy largos son recortados" );
	note1.End();
	
	NetworkMessage note2_1( MSG_ONE_UNRELIABLE, NetworkMessages::MOTD, pPlayer.edict() );
	note2_1.WriteByte( 0 );
	note2_1.WriteString( "\n** Puedes ver mas informacion sobre un " );
	note2_1.End();
	NetworkMessage note2_2( MSG_ONE_UNRELIABLE, NetworkMessages::MOTD, pPlayer.edict() );
	note2_2.WriteByte( 0 );
	note2_2.WriteString( "jugador usando el comando " );
	note2_2.End();
	NetworkMessage note2_3( MSG_ONE_UNRELIABLE, NetworkMessages::MOTD, pPlayer.edict() );
	note2_3.WriteByte( 0 );
	note2_3.WriteString( "/inspect <Jugador>" );
	note2_3.End();
	
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
	
	string szInfo = "1. Vida Inicial:\n   Aumenta la vida inicial al respawnear";
	szInfo += "\n\n2. Armor Inicial:\n   Aumenta la armadura inicial al respawnear";
	szInfo += "\n\n3. Regeneracion de Vida:\n   Mas tienes, mas rapido recuperas vida";
	szInfo += "\n\n4. Regeneracion de Armadura:\n   Mas tienes, mas rapido recuperas armadura";
	szInfo += "\n\n5. Regeneracion de Balas:\n   Mas tienes, mas rapido recuperas balas\n   Regenera segun el arma que tengas en mano\n   De no ser posible, regenera balas al azar";
	szInfo += "\n\n6. Anti-Gravedad:\n   Disminuye la gravedad. Manten pulsada la tecla de salto";
	szInfo += "\n\n7. Conocimiento:\n   Aumenta ligeramente todas las habilidades";
	szInfo += "\n\n8. Poder de Equipo:\n   Otorga vida y armadura a jugadores cercanos";
	szInfo += "\n\n9. Bloqueo de Ataques:\n   Probabilidad de bloquear danios";
	szInfo += "\n\n10. Medallas:\n   Aumentan ligeramente todas las habilidades\n   Aumentan ligeramente la Ganancia de EXP\n   Pueden ser usadas para habilidades especiales";
	
	ShowMOTD( pPlayer, "Habilidades", szInfo );
}

void scxpm_version( const int& in index )
{
	CBasePlayer@ pPlayer = g_PlayerFuncs.FindPlayerByIndex( index );
	
	string szInfo = "Sven Co-op eXPerience Mod (SCXPM)";
	szInfo += "\n\nVersion original por Silencer, Wrd y PythEch";
	szInfo += "\nEditado por Julian \"Giegue\" Rodriguez";
	
	szInfo += "\n\nVersion: " + version;
	szInfo += "\nUltima actualizacion: " + lastupdate;
	
	szInfo += "\n\nAgradecimientos a:\n\nAngel\nMaty\nw00tguy\nSolokiller\nfgsfds\nAMX Mod X Team\nTh3822";
	
	szInfo += "\n\n\n---\n2009-2018 - Imperium Sven Co-op";
	
	ShowMOTD( pPlayer, "Acerca del SCXPM", szInfo );
	
	/*
	NetworkMessage info4_1( MSG_ONE_UNRELIABLE, NetworkMessages::MOTD, pPlayer.edict() );
	info4_1.WriteByte( 0 );
	info4_1.WriteString( "\n\n\nEn memoria a: " );
	info4_1.End();
	NetworkMessage info4_2( MSG_ONE_UNRELIABLE, NetworkMessages::MOTD, pPlayer.edict() );
	info4_2.WriteByte( 0 );
	info4_2.WriteString( "\n\nImperium Sven Co-op (2009-2014 | 2017-2018)" );
	info4_2.End();
	NetworkMessage info4_3( MSG_ONE_UNRELIABLE, NetworkMessages::MOTD, pPlayer.edict() );
	info4_3.WriteByte( 0 );
	info4_3.WriteString( "\nClan-Master (2015)" );
	info4_3.End();
	NetworkMessage info4_4( MSG_ONE_UNRELIABLE, NetworkMessages::MOTD, pPlayer.edict() );
	info4_4.WriteByte( 0 );
	info4_4.WriteString( "\nEl cubo SC (2016-2017)" );
	info4_4.End();
	*/
}

void scxpm_sinfo( const int& in index )
{
	CBasePlayer@ pPlayer = g_PlayerFuncs.FindPlayerByIndex( index );
	
	string szInfo = "Las habilidades especiales son mejoras adicionales que puedes usar. Estas son unicamente disponibles mediante medallas\n\n1 medalla = 1 punto";
	szInfo += "\n\n1. Golpe Inicial:\n   Lastima a enemigos cercanos al respawnear";
	szInfo += "\n\n2. Dispensador Portatil:\n   Duplica la cantidad de balas regeneradas";
	szInfo += "\n\n3. Sobrecarga:\n   Aumenta la capacidad maxima de las habilidades comunes";
	szInfo += "\n\n4. Caida Libre:\n   Disminuye el danio por caida";
	szInfo += "\n\n5. Demoledor:\n   Probabilidad de regenerar granadas de M16\n   (No combina con Dispensador Portatil)\n   (Requiere una M16 en mano)";
	szInfo += "\n\n6. Tiro de Practica:\n   Probabilidad que el proximo disparo no gaste balas\n   (No toma efecto con algunas armas ni con ataques secundarios)";
	szInfo += "\n\n7. BioElectricista:\n   Aumenta la capacidad de la Shock Roach";
	szInfo += "\n\n8. Emergencia Medicinal:\n   Permite la curacion a distancia con el Medkit\n   (Usar ataque terciario)";
	szInfo += "\n\n9. Cruz Roja:\n   Aumenta la capacidad del Medkit";
	
	ShowMOTD( pPlayer, "Habilidades Especiales", szInfo );
}

void scxpm_hcinfo( const int& in index )
{
	CBasePlayer@ pPlayer = g_PlayerFuncs.FindPlayerByIndex( index );
	
	string szInfo = "Las desventajas son desafios adicionales que haran tus misiones mas dificiles, pero son recompensadas con una Ganancia de EXP aumentada. ";
	szInfo += "Para evitar su abuso, solo puedes modificarlas al principio de cada mapa";
	
	szInfo += "\n\n1. Sin Impulsos:\n   Desactiva los efectos de Vida Inicial, Armor Inicial y Anti-Gravedad\n   +10% Ganancia de EXP";
	szInfo += "\n\n2. Regeneracion en OFF:\n   Desactiva todas las regeneraciones\n   +4% Ganancia de EXP";
	szInfo += "\n\n3. Equipo ausente:\n   Desactiva los efectos del Poder de Equipo\n   +8% Ganancia de EXP";
	szInfo += "\n\n4. Atraccion de Ataques:\n   Desactiva los efectos del Bloqueo de Ataques\n   +4% Ganancia de EXP";
	szInfo += "\n\n5. Fobia Medicinal:\n   No puedes ser curado, excepto por regeneracion\n   +6% Ganancia de EXP";
	szInfo += "\n\n6. Tecnologia Obsoleta:\n   No puedes usar armadura, excepto por regeneracion\n   +12% Ganancia de EXP";
	szInfo += "\n\n7. Nitrogeno en Sangre:\n   Al morir, explotas en tripas\n   " + ( mode[ index ] == 3 ? "+8%" : "+4%" ) + " Ganancia de EXP";
	szInfo += "\n\n8. Retribucion Karmica:\n   Todos los danios te dejan envenenado, excepto danio por caida\n   +12% Ganancia de EXP";
	szInfo += "\n\n9. Realismo:\n   Oculta y desactiva el HEV Suit (HUD)\n   +4% Ganancia de EXP";
	szInfo += "\n\n10. Explosion Fuerte:\n   Las explosiones lastiman mas de lo normal\n   +6% Ganancia de EXP";
	szInfo += "\n\n11. Equipamiento Limitado:\n   Limita tu equipamiento a una sola arma\n   +6% Ganancia de EXP";
	szInfo += "\n\n12. Peso Muerto:\n   Aumenta la gravedad, hace mas dificil saltar\n   +4% Ganancia de EXP";
	szInfo += "\n\n13. Escaso Auxilio:\n   Desactiva los efectos de las Medallas y Habilidades Especiales\n   (Sobrecarga y Cruz Roja no son afectadas)\n   +10% Ganancia de EXP";
	
	ShowMOTD( pPlayer, "Desventajas", szInfo );
}

void scxpm_hard_tutorial( const int& in index )
{
	CBasePlayer@ pPlayer = g_PlayerFuncs.FindPlayerByIndex( index );
	
	string szInfo = "LA MUERTE ES LA FINAL.\n\n";
	szInfo += "Bueno, no exactamente. Esta vez, respawnear tiene un costo muy alto. Antes, podias revivir sin inconvenientes. Ahora, ya no es posible.";
	szInfo += "\n\nA partir de ahora, tienes un limite, que se llaman <Suministros Auxiliares>. Mientras dispongas de estos suministros, podras ";
	szInfo += "respawnear en caso de emergencia. Pero una vez agotadas, se acabo todo. GAME OVER.";
	szInfo += "\n\nSin estos suministros, no podras jugar en Modo Dificil, asi que ten mucho cuidado de tu propia vida! Morir y esperar al proximo ";
	szInfo += "mapa es tambien considerado un respawn. Pierdes una vida! Esta modalidad esta diseniada para ponerte al limite, sin experiencia deberas depender ";
	szInfo += "de la cooperacion de los demas jugadores. Y no tienes ninguna garantia de que estos te ayuden!";
	szInfo += "\n\nPero no temas, esta modalidad no es infernal, existen metodos de adquirir suministros extra: Puedes conseguirlos de manera aleatoria ";
	szInfo += "subiendo de nivel, completar logros, o en el ultimo de los casos, comprandolas. Te advierto que su precio de compra no es barata!";
	szInfo += "Subir de nivel tampoco es una tarea sencila! Debes estar armado con paciencia para poder atravesar la tarea de adquirir los niveles.";
	szInfo += "\n\nFinalmente, hagas lo que hagas, no juegues sin cuidado. Todas las habilidades en esta modalidad tienen mucha menor potencia, ";
	szInfo += "puedes juntar centenas de niveles y aun serias debil! En resumen: La estrategia, la supervivencia y la paciencia son claves para el exito.";
	szInfo += "\n\nMuy pocos han logrado completar esta modalidad, y mucho menos aquellos que han podido atravesar los primeros niveles. Crees estar a la altura?";
	szInfo += "\n\nTe deseo la mejor de las suertes.\n\n   -Giegue";
	
	ShowMOTD( pPlayer, "Modo Dificil", szInfo );
}

void scxpm_helpme( const int& in index )
{
	CBasePlayer@ pPlayer = g_PlayerFuncs.FindPlayerByIndex( index );
	
	string szInfo = "/selectskills\n   Abre el menu de habilidades";
	szInfo += "\n\n/resetskills\n   Reinicia tus habilidades para volverlas a elegir";
	szInfo += "\n\n/playerskills\n   Muestra datos de las otras personas presentes en el servidor";
	szInfo += "\n\n/skillsinfo\n   Muestra que hace cada habilidad";
	szInfo += "\n\n/scxpminfo\n   Muestra datos acerca del SCXPM";
	szInfo += "\n\n/xpgain\n   Muestra la Ganancia de EXP en el mapa actual";
	szInfo += "\n\n/resetlevels\n   Reinicia niveles para adquirir medallas";
	szInfo += "\n\n/resetmedals\n   Reinicia medallas para adquirir niveles";
	szInfo += "\n\n/selectspecials\n   Abre el menu de habilidades especiales";
	szInfo += "\n\n/resetspecials\n   Reinicia tus habilidades especiales para volverlas a elegir";
	szInfo += "\n\n/specialsinfo\n   Muestra que hace cada habilidad especial";
	szInfo += "\n\n/hudsettings\n   Cambia la apariencia del HUD";
	szInfo += "\n\n/mode\n   Cambia tu modo de juego";
	szInfo += "\n\n/supplies\n   Compra de Suministros Auxiliares con niveles";
	szInfo += "\n\n/handicaps\n   Haz mas dificil tu mision para subir mas rapido de nivel";
	szInfo += "\n\n/handicapsinfo\n   Muestra informacion sobre las Desventajas";
	szInfo += "\n\n/character\n   Muestra un resumen de tu carrera actual";
	szInfo += "\n\n/achievements\n   Abre el menu de logros";
	szInfo += "\n\n/events\n   Muestra los eventos actualmente activos";
	szInfo += "\n\n/mystery\n   " + ( bHasMGAccess[ index ] == 0 ? "???" : "Abre el sistema de regalos" );
	szInfo += "\n\n/menu\n   Todos los comandos aqui mencionados, resumidos en un menu para usar";
	
	ShowMOTD( pPlayer, "Lista de Comandos", szInfo );
}

void scxpm_menu( const int& in index )
{
	CBasePlayer@ pPlayer = g_PlayerFuncs.FindPlayerByIndex( index );
	MenuHandler@ state = MenuGetPlayer( pPlayer );
	
	state.InitMenu( pPlayer, scxpm_menu_cb );
	state.menu.SetTitle( "Menu Principal\n" );
	
	// Page 1
	state.menu.AddItem( "Habilidades\n", any( "item1" ) );
	state.menu.AddItem( "Habilidades Especiales\n\n", any( "item2" ) );
	state.menu.AddItem( "Reiniciar Habilidades\n", any( "item3" ) );
	state.menu.AddItem( "Reiniciar Habilidades Especiales\n\n", any( "item4" ) );
	state.menu.AddItem( "Modificar HUD\n\n", any( "item5" ) );
	state.menu.AddItem( "Datos de los jugadores\n", any( "item6" ) );
	state.menu.AddItem( "Mi personaje", any( "item7" ) );
	
	// Page 2
	state.menu.AddItem( "Logros\n", any( "item8" ) );
	state.menu.AddItem( "Modificadores de EXP\n\n", any( "item9" ) );
	state.menu.AddItem( "Resetear Nivel\n", any( "item10" ) );
	state.menu.AddItem( "Resetear Medallas\n\n", any( "item11" ) );
	state.menu.AddItem( "Seleccion de Modalidad\n", any( "item12" ) );
	state.menu.AddItem( "Suministros Auxiliares\n\n", any( "item13" ) );
	state.menu.AddItem( "Desventajas\n\n", any( "item14" ) );
	
	// Page 3
	state.menu.AddItem( "Recompensas Diarias\n", any( "item15" ) );
	state.menu.AddItem( "Eventos\n\n", any( "item16" ) );
	state.menu.AddItem( "Ayuda e Informacion", any( "item17" ) );
	
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
		g_Scheduler.SetTimeout( "scxpm_lvltomedal", 0.01, index );
	else if ( selection == 'item11' )
		g_Scheduler.SetTimeout( "scxpm_medaltolvl", 0.01, index );
	else if ( selection == 'item12' )
		g_Scheduler.SetTimeout( "scxpm_mode", 0.01, index );
	else if ( selection == 'item13' )
		g_Scheduler.SetTimeout( "scxpm_buysparks", 0.01, index );
	else if ( selection == 'item14' )
		g_Scheduler.SetTimeout( "scxpm_handicaps", 0.01, index, 0 );
	else if ( selection == 'item15' ) // Page 3
		g_Scheduler.SetTimeout( "scxpm_dailyrewards", 0.01, index, 0 );
	else if ( selection == 'item16' )
		g_Scheduler.SetTimeout( "scxpm_events", 0.01, index );
	else if ( selection == 'item17' )
		g_Scheduler.SetTimeout( "scxpm_helpmenu", 0.01, index );
}

void scxpm_mydata( const int& in index )
{
	CBasePlayer@ pPlayer = g_PlayerFuncs.FindPlayerByIndex( index );
	MenuHandler@ state = MenuGetPlayer( pPlayer );
	
	state.InitMenu( pPlayer, scxpm_mydata_cb );
	
	string title = "Mi personaje\n\n";
	title += g_EngineFuncs.GetPlayerAuthId( pPlayer.edict() ) + "\n\n\n";
	
	title += "Nivel alcanzado\n";
	title += " - Modo Facil: " + scxpm_calc_lvl( xp_e[ index ] ) + " / 640" + ( mode[ index ] == 1 ? " <--\n" : "\n" );
	title += " - Modo Normal: " + scxpm_calc_lvl( xp[ index ] ) + " / 565" + ( mode[ index ] == 2 ? " <--\n" : "\n" );
	title += " - Modo Dificil: " + AddCommas( scxpm_calc_lvl( xp_h[ index ] ) ) + " / 1,800" + ( mode[ index ] == 3 ? " <--\n\n" : "\n\n" );
	
	title += "Medallas adquiridas\n";
	title += " - Modo Normal: " + medals[ index ] + " / 42" + ( mode[ index ] == 2 ? " <--\n" : "\n" );
	title += " - Modo Dificil: " + medals_h[ index ] + " / 42" + ( mode[ index ] == 3 ? " <--\n\n" : "\n\n" );
	
	title += "Logros: "	+ GetAchievementClear( index ) + " de " + ( int( szAchievementNames.length() ) - 4 ) + " completados\n";
	title += "Modificadores de EXP:" + ( permaincrease[ index ] > 0.0 ? " +" : " " ) + int( permaincrease[ index ] ) + "%\n\n";
	
	title += "Empezaste a jugar el dia\n";
	title += GetSpanishDate( firstplay[ index ] ) + "\n\n";
	title += "Dias consecutivos de juego: " + dailyget[ index ] + "\n";
	
	state.menu.SetTitle( title );
	state.menu.AddItem( "Ver Logros", any( "item1" ) );
	state.menu.AddItem( "Ver Modificadores de EXP\n", any( "item2" ) );
	state.menu.AddItem( "Volver al Menu Principal", any( "item3" ) );
	
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
			g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "[SCXPM] Jugador no encontrado\n" );
			return;
		}
	}
	
	MenuHandler@ state = MenuGetPlayer( pPlayer );
	
	state.InitMenu( pPlayer, scxpm_permaincrease_cb );
	string title;
	
	if ( iInspect > 0 )
	{
		title = "Modificadores de EXP\n\nTOTAL:" + ( permaincrease[ iInspect ] > 0.0 ? " +" : " " ) + int( permaincrease[ iInspect ] ) + "% Ganancia de EXP\n\n";
		state.menu.SetTitle( title );
	
		GetPermaIncrease( iInspect, state );
	}
	else
	{
		iIndexInspect[ index ] = 0;
		
		title = "Modificadores de EXP\n\nTOTAL:" + ( permaincrease[ index ] > 0.0 ? " +" : " " ) + int( permaincrease[ index ] ) + "% Ganancia de EXP\n\n";
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
			g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "[SCXPM] Jugador no encontrado\n" );
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
	
	string title = "Recompensas Diarias\n\n";
	title += "Dias consecutivos de juego: " + dailyget[ index ] + "\n\n\n";
	
	title += "Dia " + dailyget[ index ] + ": " + szCurrent + "\n";
	title += "Siguiente recompensa: " + szNext + "\n\n";
	
	title += "Juega mas seguido para\naumentar las recompensas!\n\n";
	
	state.menu.SetTitle( title );
	state.menu.AddItem( "Volver al Menu Principal", any( "item1" ) );
	
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

void scxpm_events( const int& in index )
{
	CBasePlayer@ pPlayer = g_PlayerFuncs.FindPlayerByIndex( index );
	MenuHandler@ state = MenuGetPlayer( pPlayer );
	
	state.InitMenu( pPlayer, scxpm_events_cb );
	
	string title = "Eventos\n\n";
	state.menu.SetTitle( title );
	
	GetEventData( index, 0, state );
	
	state.OpenMenu( pPlayer, 0, 0 );
}

void scxpm_events_cb( CTextMenu@ menu, CBasePlayer@ pPlayer, int page, const CTextMenuItem@ item )
{
	int index = pPlayer.entindex();
	if ( page == 10 ) return;
	
	string selection;
	item.m_pUserData.retrieve( selection );
	
	if ( selection != 'DUMMY' ) GetEventData( index, atoi( selection ), null );
	g_Scheduler.SetTimeout( "scxpm_events", 0.01, index );
}

void scxpm_achievements( const int& in index, int& in iPage = 0, int& in iInspect = 0 )
{
	CBasePlayer@ pPlayer = g_PlayerFuncs.FindPlayerByIndex( index );
	
	if ( iInspect > 0 )
	{
		CBasePlayer@ pInspect = g_PlayerFuncs.FindPlayerByIndex( iInspect );
		if ( pInspect is null )
		{
			g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "[SCXPM] Jugador no encontrado\n" );
			return;
		}
	}
	
	MenuHandler@ state = MenuGetPlayer( pPlayer );
	
	state.InitMenu( pPlayer, scxpm_achievements_cb );
	
	string title = "Logros\n\n[P] = Pendiente\n[A] = Adquirido\n\n";
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
			g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "[SCXPM] Jugador no encontrado\n" );
			return;
		}
	}
	
	MenuHandler@ state = MenuGetPlayer( pPlayer );
	
	state.InitMenu( pPlayer, scxpm_achievement_info_cb );
	
	string title = szAchievementNames[ iAchievementID ] + "\n\n\n";
	
	title += GetAchievementMission( iAchievementID );
	
	title += "\n\nEstado: ";
	if ( iInspect > 0 )
	{
		if ( aData[ iInspect ][ iAchievementID ] ) title += "Adquirido\n";
		else title += "Pendiente\n";
	}
	else
	{
		if ( aData[ index ][ iAchievementID ] ) title += "Adquirido\n";
		else title += "Pendiente\n";
	}
	
	state.menu.SetTitle( title );
	
	if ( iInspect == 0 && !aClaim[ index ][ iAchievementID ] && aData[ index ][ iAchievementID ] )
		state.menu.AddItem( "Redimir recompensa\n", any( string( iAchievementID ) ) );
	
	// LEGACY ACHIEVEMENTS: Que sea un empate (26) | Sayonara (98) | Asesinos de Segunda (103) | Feliz navidad (110)
	if ( iAchievementID == 26 || iAchievementID == 98 || iAchievementID == 103 || iAchievementID == 110 )
		iAchievementID = 161;
	else if ( iAchievementID > 110 ) // Fix offset
		iAchievementID -= 4;
	else if ( iAchievementID > 103 )
		iAchievementID -= 3;
	else if ( iAchievementID > 98 )
		iAchievementID -= 2;
	else if ( iAchievementID > 26 )
		iAchievementID -= 1;
	
	if ( iAchievementID > 160 )
		state.menu.AddItem( "Volver", any( "item24" ) );
	else if ( iAchievementID > 153 )
		state.menu.AddItem( "Volver", any( "item23" ) );
	else if ( iAchievementID > 146 )
		state.menu.AddItem( "Volver", any( "item22" ) );
	else if ( iAchievementID > 139 )
		state.menu.AddItem( "Volver", any( "item21" ) );
	else if ( iAchievementID > 132 )
		state.menu.AddItem( "Volver", any( "item20" ) );
	else if ( iAchievementID > 125 )
		state.menu.AddItem( "Volver", any( "item19" ) );
	else if ( iAchievementID > 118 )
		state.menu.AddItem( "Volver", any( "item18" ) );
	else if ( iAchievementID > 111 )
		state.menu.AddItem( "Volver", any( "item17" ) );
	else if ( iAchievementID > 104 )
		state.menu.AddItem( "Volver", any( "item16" ) );
	else if ( iAchievementID > 97 )
		state.menu.AddItem( "Volver", any( "item15" ) );
	else if ( iAchievementID > 90 )
		state.menu.AddItem( "Volver", any( "item14" ) );
	else if ( iAchievementID > 83 )
		state.menu.AddItem( "Volver", any( "item13" ) );
	else if ( iAchievementID > 76 )
		state.menu.AddItem( "Volver", any( "item12" ) );
	else if ( iAchievementID > 69 )
		state.menu.AddItem( "Volver", any( "item11" ) );
	else if ( iAchievementID > 62 )
		state.menu.AddItem( "Volver", any( "item10" ) );
	else if ( iAchievementID > 55 )
		state.menu.AddItem( "Volver", any( "item9" ) );
	else if ( iAchievementID > 48 )
		state.menu.AddItem( "Volver", any( "item8" ) );
	else if ( iAchievementID > 41 )
		state.menu.AddItem( "Volver", any( "item7" ) );
	else if ( iAchievementID > 34 )
		state.menu.AddItem( "Volver", any( "item6" ) );
	else if ( iAchievementID > 27 )
		state.menu.AddItem( "Volver", any( "item5" ) );
	else if ( iAchievementID > 20 )
		state.menu.AddItem( "Volver", any( "item4" ) );
	else if ( iAchievementID > 13 )
		state.menu.AddItem( "Volver", any( "item3" ) );
	else if ( iAchievementID > 6 )
		state.menu.AddItem( "Volver", any( "item2" ) );
	else
		state.menu.AddItem( "Volver", any( "item1" ) );
	
	state.OpenMenu( pPlayer, 0, 0 );
}

void scxpm_achievement_info_cb( CTextMenu@ menu, CBasePlayer@ pPlayer, int page, const CTextMenuItem@ item )
{
	int index = pPlayer.entindex();
	if ( page == 10 ) return;
	
	string selection;
	item.m_pUserData.retrieve( selection );
	
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
	state.menu.SetTitle( "Ayuda e Informacion\n\n" );
	
	state.menu.AddItem( "Lista de Comandos\n\n", any( "item1" ) );
	state.menu.AddItem( "Que hacen las habilidades?\n", any( "item2" ) );
	state.menu.AddItem( "...Y las especiales?\n", any( "item3" ) );
	state.menu.AddItem( "...Y las desventajas?\n\n", any( "item4" ) );
	state.menu.AddItem( "Ganancia de EXP\n\n", any( "item5" ) );
	state.menu.AddItem( "Acerca del SCXPM\n\n", any( "item6" ) );
	if ( IsChampion( pPlayer ) ) state.menu.AddItem( "Historia del SCXPM\n\n", any( "item7" ) );
	state.menu.AddItem( "Volver al Menu Principal", any( "item8" ) );
	
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
	else if ( selection == 'item7' )
		g_Scheduler.SetTimeout( "Champion_XPHistory", 0.01, index );
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
	
	// Cap the days
	if ( iDays > 30 ) iDays = 30;
	int iHelper1 = 55 * iDays;
	
	int iHelper2 = 55 * ( iDays + 1 );
	if ( iHelper2 > 1650 ) iHelper2 = 1650;
	
	// Set strings
	if ( iDays == 30 && !( ( bData[ index ] & DR_MAXGET ) != 0 ) )
		szCurrent = "Modificador de EXP +10%";
	else
		szCurrent = "" + iHelper1 + " EXP";
	
	// Check max 30-day reward
	if ( ( iDays + 1 ) == 30 && !( ( bData[ index ] & DR_MAXGET ) != 0 ) )
		szNext = "Modificador de EXP +10%";
	else
		szNext = "" + iHelper2 + " EXP";
	
	if ( bUpdate && iCheck == 1 )
	{
		// Set next daily
		TimeDifference tdNextTime( 20 * 60 * 60 ); // ALMOST 1 day
		dtCurrentTime += tdNextTime;
		nextdaily[ index ] = dtCurrentTime;
		
		// Give reward
		if ( iDays == 30 && !( ( bData[ index ] & DR_MAXGET ) != 0 ) ) // Reached 30 days?
		{
			// Mark reward as given
			bData[ index ] |= DR_MAXGET;
			
			AddPermaIncrease( index, "10.0#Miembro Instalado#Alcanzado 30 dias consecutivos de juego!n!n+10% Ganancia de EXP!n\n" );
		}
		else
		{
			switch( mode[ index ] )
			{
				case 1: xp_e[ index ] += iHelper1; break;
				case 2: xp[ index ] += iHelper1; break;
				case 3: xp_h[ index ] += iHelper1; break;
				case 4: xp_p[ index ] += iHelper1; break;
			}
			if ( !gDelayedXP ) earnedxp[ index ] += iHelper1; // Prevent double XP exploitation on delayed XP maps
		}
	}
}

void scxpm_savedata( const int& in index )
{
	CBasePlayer@ pPlayer = g_PlayerFuncs.FindPlayerByIndex( index );
	
	if ( loaddata[ index ] )
	{
		string fullpath = "" + PATH_MAIN_DATA + "SCXPM_" + g_EngineFuncs.GetPlayerAuthId( pPlayer.edict() ) + ".data";
		fullpath.Replace( ':', '_' );
		File@ thefile = g_FileSystem.OpenFile( fullpath, OpenFile::WRITE );
		
		if ( thefile !is null && thefile.IsOpen() )
		{
			string stuff;
			
			stuff += "" + xp[ index ] + "#" + xp_e[ index ] + "#" + xp_h[ index ];
			stuff += "#" + playerlevel[ index ] + "#" + skillpoints[ index ];
			stuff += "#" + medals[ index ] + "#" + medals_h[ index ];
			stuff += "#" + health[ index ] + "#" + armor[ index ] + "#" + rhealth[ index ] + "#" + rarmor[ index ] + "#" + rammo[ index ] + "#" + gravity[ index ] + "#" + speed[ index ] + "#" + dist[ index ] + "#" + dodge[ index ];
			stuff += "#" + spawndmg[ index ] + "#" + ubercharge[ index ] + "#" + freefall[ index ] + "#" + demoman[ index ] + "#" + practiceshot[ index ] + "#" + bioelectric[ index ];
			stuff += "#" + bData[ index ] + "#" + hud_red1[ index ] + "#" + hud_green1[ index ] + "#" + hud_blue1[ index ] + "#" + hud_red2[ index ] + "#" + hud_green2[ index ] + "#" + hud_blue2[ index ] + "#" + hud_alpha[ index ];
			stuff += "#" + hud_pos_x[ index ] + "#" + hud_pos_y[ index ] + "#" + hud_effect[ index ] + "#" + hud_ef_fadein[ index ] + "#" + hud_ef_scantime[ index ];
			stuff += "#" + mode[ index ] + "#" + hkey[ index ] + "#" + sparks[ index ] + "#" + expamp[ index ];
			stuff += "#" + expamptime[ index ].ToUnixTimestamp() + "#" + firstplay[ index ].ToUnixTimestamp() + "#" + nextdaily[ index ].ToUnixTimestamp() + "#" + dailyget[ index ];
			stuff += "#" + bWasDead[ index ] + "#" + bHasMGAccess[ index ] + "#" + redcross[ index ] + "\n";
			
			thefile.Write( stuff );
			thefile.Close();
			
			if ( IsChampion( pPlayer ) )
				Champion_SaveSandboxData( index );
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
	
	string fullpath = "" + PATH_MAIN_DATA + "SCXPM_" + g_EngineFuncs.GetPlayerAuthId( pPlayer.edict() ) + ".data";
	fullpath.Replace( ':', '_' );
	File@ thefile = g_FileSystem.OpenFile( fullpath, OpenFile::READ );
	
	if ( thefile !is null && thefile.IsOpen() )
	{
		string line;
		
		thefile.ReadLine( line );
		line.Replace( '#', ' ' );
		array< string >@ pre_data = line.Split( ' ' );
		
		// Fix for older data
		if ( pre_data.length() < 43 )
		{
			pre_data.resize( 43 );
			pre_data[ 40 ] = string( UnixTimestamp() );
			pre_data[ 42 ] = "0";
			
			DateTime dtFix = DateTime( UnixTimestamp() ) + TimeDifference( 20 * 60 * 60 );
			pre_data[ 41 ] = string( dtFix.ToUnixTimestamp() );
		}
		if ( pre_data.length() < 44 )
		{
			pre_data.resize( 44 );
			pre_data[ 43 ] = "0";
		}
		if ( pre_data.length() < 45 )
		{
			pre_data.resize( 45 );
			pre_data[ 44 ] = "0";
		}
		if ( pre_data.length() < 46 )
		{
			pre_data.resize( 46 );
			pre_data[ 45 ] = "0";
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
		pre_data[ 39 ].Trim();
		pre_data[ 40 ].Trim();
		pre_data[ 41 ].Trim();
		pre_data[ 42 ].Trim();
		pre_data[ 43 ].Trim();
		pre_data[ 44 ].Trim();
		pre_data[ 45 ].Trim();
		
		xp[ index ] = atoi( pre_data[ 0 ] );
		xp_e[ index ] = atoi( pre_data[ 1 ] );
		xp_h[ index ] = atoi( pre_data[ 2 ] );
		playerlevel[ index ] = atoi( pre_data[ 3 ] );
		scxpm_calcneedxp( index );
		skillpoints[ index ] = atoi( pre_data[ 4 ] );
		medals[ index ] = atoi( pre_data[ 5 ] );
		medals_h[ index ] = atoi( pre_data[ 6 ] );
		health[ index ] = atoi( pre_data[ 7 ] );
		armor[ index ] = atoi( pre_data[ 8 ] );
		rhealth[ index ] = atoi( pre_data[ 9 ] );
		rarmor[ index ] = atoi( pre_data[ 10 ] );
		rammo[ index ] = atoi( pre_data[ 11 ] );
		gravity[ index ] = atoi( pre_data[ 12 ] );
		speed[ index ] = atoi( pre_data[ 13 ] );
		dist[ index ] = atoi( pre_data[ 14 ] );
		dodge[ index ] = atoi( pre_data[ 15 ] );
		spawndmg[ index ] = atoi( pre_data[ 16 ] );
		ubercharge[ index ] = atoi( pre_data[ 17 ] );
		freefall[ index ] = atoi( pre_data[ 18 ] );
		demoman[ index ] = atoi( pre_data[ 19 ] );
		practiceshot[ index ] = atoi( pre_data[ 20 ] );
		bioelectric[ index ] = atoi( pre_data[ 21 ] );
		bData[ index ] = atoi( pre_data[ 22 ] );
		hud_red1[ index ] = atoi( pre_data[ 23 ] );
		hud_green1[ index ] = atoi( pre_data[ 24 ] );
		hud_blue1[ index ] = atoi( pre_data[ 25 ] );
		hud_red2[ index ] = atoi( pre_data[ 26 ] );
		hud_green2[ index ] = atoi( pre_data[ 27 ] );
		hud_blue2[ index ] = atoi( pre_data[ 28 ] );
		hud_alpha[ index ] = atoi( pre_data[ 29 ] );
		hud_pos_x[ index ] = atof( pre_data[ 30 ] );
		hud_pos_y[ index ] = atof( pre_data[ 31 ] );
		hud_effect[ index ] = atoi( pre_data[ 32 ] );
		hud_ef_fadein[ index ] = atof( pre_data[ 33 ] );
		hud_ef_scantime[ index ] = atof( pre_data[ 34 ] );
		mode[ index ] = atoi( pre_data[ 35 ] );
		hkey[ index ] = atoi( pre_data[ 36 ] );
		sparks[ index ] = atoi( pre_data[ 37 ] );
		expamp[ index ] = atoi( pre_data[ 38 ] );
		expamptime[ index ].SetUnixTimestamp( atoi( pre_data[ 39 ] ) );
		firstplay[ index ].SetUnixTimestamp( atoi( pre_data[ 40 ] ) );
		nextdaily[ index ].SetUnixTimestamp( atoi( pre_data[ 41 ] ) );
		dailyget[ index ] = atoi( pre_data[ 42 ] );
		bWasDead[ index ] = atoi( pre_data[ 43 ] );
		bHasMGAccess[ index ] = atoi( pre_data[ 44 ] );
		redcross[ index ] = atoi( pre_data[ 45 ] );
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
		
		thefile.Close();
		
		// File integrity check
		if ( mode[ index ] == 0 )
			bCorruptData[ index ] = true;
		
		if ( IsChampion( pPlayer ) )
			Champion_LoadSandboxData( index );
		else
		{
			xp_p[ index ] = 0;
			medals_p[ index ] = 0;
			sparks_p[ index ] = -1;
			startlevel_p[ index ] = 0;
			maxlevel_p[ index ] = -1;
			startmedals_p[ index ] = 0;
			maxmedals_p[ index ] = 0;
			xpgain_p[ index ] = 0.0;
			health_max_p[ index ] = 0;
			armor_max_p[ index ] = 0;
			rhealth_max_p[ index ] = 0;
			rarmor_max_p[ index ] = 0;
			rammo_max_p[ index ] = 0;
			gravity_max_p[ index ] = 0;
			speed_max_p[ index ] = 0;
			dist_max_p[ index ] = 0;
			dodge_max_p[ index ] = 0;
			spawndmg_max_p[ index ] = 0;
			ubercharge_max_p[ index ] = 0;
			freefall_max_p[ index ] = 0;
			demoman_max_p[ index ] = 0;
			practiceshot_max_p[ index ] = 0;
			bioelectric_max_p[ index ] = 0;
			redcross_max_p[ index ] = 0;
		}
	}
	else
		LoadEmptySkills( index );
	
	GetPermaIncrease( index );
	loaddata[ index ] = true;
}

void AddEventEXP( const int& in index )
{
	CBasePlayer@ pPlayer = g_PlayerFuncs.FindPlayerByIndex( index );
	
	string szPath = PATH_EVENT_DATA + "EXP_" + g_EngineFuncs.GetPlayerAuthId( pPlayer.edict() ) + ".data";
	szPath.Replace( ':', '_' );
	File@ thefile = g_FileSystem.OpenFile( szPath, OpenFile::READ );
	
	if ( thefile !is null && thefile.IsOpen() )
	{
		string szEXP;
		thefile.ReadLine( szEXP );
		
		int pre_iEXP = atoi( szEXP );
		
		if ( mode[ index ] == 1 ) xp_e[ index ] += pre_iEXP;
		else if ( mode[ index ] == 2 ) xp[ index ] += pre_iEXP;
		else if ( mode[ index ] == 3 ) xp_h[ index ] += pre_iEXP;
		else if ( mode[ index ] == 4 ) xp_p[ index ] += pre_iEXP;
		
		if ( !gDelayedXP ) earnedxp[ index ] += pre_iEXP; // Prevent double XP exploitation on delayed XP maps
		
		thefile.Close();
		
		DeleteEventEXP( szPath );
	}
	
	// Use this space for other stuff
	CustomKeyvalues@ pCustom = pPlayer.GetCustomKeyvalues();
	CustomKeyvalue iAddSpark_pre( pCustom.GetKeyvalue( "$i_cp_spark" ) );
	int iAddSpark = iAddSpark_pre.GetInteger();
	if ( iAddSpark >= 1 )
	{
		if ( mode[ index ] != 4 )
		{
			if ( sparks[ index ] <= 0 )
				sparks[ index ] = 1 + iAddSpark;
			else
				sparks[ index ] += iAddSpark;
			
			if ( sparks[ index ] > 100 && mode[ index ] != 4 )
			{
				bSparkReward[ index ] = true;
				
				int iSpareSparks = sparks[ index ] - 100;
				sparks[ index ] = 100;
				int iExtraXP = iSpareSparks * 18000;
				
				g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "[SCXPM] No puedes llevar mas de 100 Suministros Auxiliares. En su lugar se han convertido en " + AddCommas( iExtraXP ) + " EXP\n" );
				xp_h[ index ] += iExtraXP;
				if ( mode[ index ] == 3 ) earnedxp[ index ] += iExtraXP;
			}
		}
		else if ( sparks_p[ index ] >= 0 && mode[ index ] == 4 )
		{
			bSparkReward[ index ] = true;
			
			sparks_p[ index ] += iAddSpark;
			
			if ( sparks_p[ index ] > 100 )
			{
				int iSpareSparks = sparks_p[ index ] - 100;
				sparks_p[ index ] = 100;
				int iExtraXP = iSpareSparks * 18000;
				
				g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "[SCXPM] No puedes llevar mas de 100 Suministros Auxiliares. En su lugar se han convertido en " + AddCommas( iExtraXP ) + " EXP\n" );
				xp_p[ index ] += iExtraXP;
				earnedxp[ index ] += iExtraXP;
			}
		}
		
		pCustom.SetKeyvalue( "$i_cp_spark", 0 );
	}
	
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
		
		expamp[ index ] = iAddAmplifier;
		expamptime[ index ] = realduration;
		
		pCustom.SetKeyvalue( "$i_cp_expamp", 0 );
		pCustom.SetKeyvalue( "$i_cp_amptime", 0 );
	}
	
	CustomKeyvalue iAddMedals_pre( pCustom.GetKeyvalue( "$i_cp_medals" ) );
	int iAddMedals = iAddMedals_pre.GetInteger();
	if ( iAddMedals >= 1 )
	{
		switch ( mode[ index ] )
		{
			case 1:
			{
				// Cannot give medals on Easy Mode. So instead move them to Normal Mode if possible. If cannot, Hard Mode. If STILL not possible, then don't care.
				if ( medals[ index ] < 42 )
				{
					if ( medals[ index ] + iAddMedals > 42 )
						medals[ index ] = 42;
					else
						medals[ index ] += iAddMedals;
				}
				else if ( medals_h[ index ] < 42 )
				{
					if ( medals_h[ index ] + iAddMedals > 42 )
						medals_h[ index ] = 42;
					else
						medals_h[ index ] += iAddMedals;
				}
				break;
			}
			case 2:
			{
				// Attempt to give medals, if not possible send them to Hard Mode. If STILL not possible, then don't care.
				if ( medals[ index ] < 42 )
				{
					if ( medals[ index ] + iAddMedals > 42 )
						medals[ index ] = 42;
					else
						medals[ index ] += iAddMedals;
				}
				else if ( medals_h[ index ] < 42 )
				{
					if ( medals_h[ index ] + iAddMedals > 42 )
						medals_h[ index ] = 42;
					else
						medals_h[ index ] += iAddMedals;
				}
				break;
			}
			case 3:
			{
				// Attempt to give medals, if not possible send them to Normal Mode. If STILL not possible, then don't care.
				if ( medals_h[ index ] < 42 )
				{
					if ( medals_h[ index ] + iAddMedals > 42 )
						medals_h[ index ] = 42;
					else
						medals_h[ index ] += iAddMedals;
				}
				else if ( medals[ index ] < 42 )
				{
					if ( medals[ index ] + iAddMedals > 42 )
						medals[ index ] = 42;
					else
						medals[ index ] += iAddMedals;
				}
				break;
			}
			case 4:
			{
				// Attempt to give medals, if not possible then don't care.
				if ( medals_p[ index ] < maxmedals_p[ index ] )
				{
					if ( medals_p[ index ] + iAddMedals > maxmedals_p[ index ] )
						medals_p[ index ] = maxmedals_p[ index ];
					else
						medals_p[ index ] += iAddMedals;
				}
				break;
			}
		}
		
		pCustom.SetKeyvalue( "$i_cp_medals", 0 );
	}
	
	if ( bHasMGAccess[ index ] == 1 )
	{
		// MG Error handlers
		CustomKeyvalue iMGError_pre( pCustom.GetKeyvalue( "$i_mg_error" ) );
		int iMGError = iMGError_pre.GetInteger();
		if ( iMGError > 0 )
		{
			MenuHandler@ state = MenuGetPlayer( pPlayer );
			state.InitMenu( pPlayer, MysteryGift_Cancel_CB );
			
			switch ( iMGError )
			{
				case 1: state.menu.SetTitle( "Que mala suerte!\n\nNo hay ningun regalo aqui\n" ); break;
				case 2: state.menu.SetTitle( "Crei que me olvide\n\nYa has redimido este regalo\n" ); break;
				case 3: state.menu.SetTitle( "Estoy muy lejos de casa\n\nNo puedes redimir regalos en este momento\n" ); break;
				case 4: state.menu.SetTitle( "Esto no deberia pasar!\n\nError inesperado en el servidor\n" ); break;
				case 5: state.menu.SetTitle( "No soy metiche\n\nEste regalo no te pertenece\n" ); break;
				case 6: state.menu.SetTitle( "He llegado tarde\n\nEste regalo ya ha sido redimido\n" ); break;
				case 99: state.menu.SetTitle( "Listo!\n\nRegalo recibido satisfactoriamente\n" ); break; // Not an error message
			}
			
			state.menu.AddItem( "Regresar", any( "item1" ) );
			
			state.OpenMenu( pPlayer, 0, 0 );
			pCustom.SetKeyvalue( "$i_mg_error", 0 );
		}
		
		CustomKeyvalue szMGMessage_pre( pCustom.GetKeyvalue( "$s_mg_message" ) );
		string szMGMessage = szMGMessage_pre.GetString();
		if ( szMGMessage.Length() > 0 )
		{
			// Gift message
			szMGMessage.Replace( '-', ' ' );
			array< string >@ pre_data = szMGMessage.Split( '$' );
			string szFullMessage = "";
			
			for ( uint i = 1; i < pre_data.length(); i++ )
			{
				pre_data[ i ].Replace( '!n', '\n' );
				szFullMessage += pre_data[ i ];
			}
			
			ShowMOTD( pPlayer, pre_data[ 0 ], szFullMessage );
			
			// Really? You crash?
			//pCustom.SetKeyvalue( "$s_mg_message", "" );
			pPlayer.KeyValue( "$s_mg_message", "" );
		}
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
	xp_e[ index ] = 0.0;
	xp_h[ index ] = 0.0;
	neededxp[ index ] = 0.0;
	earnedxp[ index ] = 0.0;
	playerlevel[ index ] = 0;
	scxpm_calcneedxp( index );
	scxpm_getrank( index );
	skillpoints[ index ] = 0;
	medals[ index ] = 0;
	medals_h[ index ] = 0;
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
	freefall[ index ] = 0;
	demoman[ index ] = 0;
	practiceshot[ index ] = 0;
	bioelectric[ index ] = 0;
	mode[ index ] = 2;
	hkey[ index ] = Math.RandomLong( 1000, 9999 );
	sparks[ index ] = 10;
	bData[ index ] = 59;
	hud_red1[ index ] = 50;
	hud_green1[ index ] = 135;
	hud_blue1[ index ] = 180;
	hud_red2[ index ] = 250;
	hud_green2[ index ] = 250;
	hud_blue2[ index ] = 250;
	hud_alpha[ index ] = 0;
	hud_pos_x[ index ] = 0.5;
	hud_pos_y[ index ] = 0.04;
	hud_effect[ index ] = 0;
	hud_ef_fadein[ index ] = 0.0;
	hud_ef_scantime[ index ] = 0.0;
	expamp[ index ] = 0;
	expamptime[ index ] = 0;
	firstplay[ index ] = UnixTimestamp();
	nextdaily[ index ] = DateTime( UnixTimestamp() ) + TimeDifference( 20 * 60 * 60 );
	dailyget[ index ] = 0;
	bWasDead[ index ] = 0;
	bHasMGAccess[ index ] = 0;
	
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
	
	xp_p[ index ] = 0;
	medals_p[ index ] = 0;
	sparks_p[ index ] = -1;
	startlevel_p[ index ] = 0;
	maxlevel_p[ index ] = -1;
	startmedals_p[ index ] = 0;
	maxmedals_p[ index ] = 0;
	xpgain_p[ index ] = 0.0;
	health_max_p[ index ] = 0;
	armor_max_p[ index ] = 0;
	rhealth_max_p[ index ] = 0;
	rarmor_max_p[ index ] = 0;
	rammo_max_p[ index ] = 0;
	gravity_max_p[ index ] = 0;
	speed_max_p[ index ] = 0;
	dist_max_p[ index ] = 0;
	dodge_max_p[ index ] = 0;
	spawndmg_max_p[ index ] = 0;
	ubercharge_max_p[ index ] = 0;
	freefall_max_p[ index ] = 0;
	demoman_max_p[ index ] = 0;
	practiceshot_max_p[ index ] = 0;
	bioelectric_max_p[ index ] = 0;
	redcross_max_p[ index ] = 0;
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
							state.menu.AddItem( "Volver", any( string( iItem ) ) ); // Return button
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
			state.menu.AddItem( "<vacio>", any( "empty" ) );
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
		int iLegacyAchievements = -1;
		array< int > iLegacyID( 4 );
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
					// Only add these legacy achievements if the player already unlocked it before
					if ( atoi( pre_data[ 0 ] ) == 26 || atoi( pre_data[ 0 ] ) == 98 || atoi( pre_data[ 0 ] ) == 103 || atoi( pre_data[ 0 ] ) == 110 )
					{
						// Que sea un empate (26) | Sayonara (98) | Asesinos de Segunda (103) | Feliz navidad (110)
						if ( pre_data[ 1 ] == 'TRUE' )
						{
							// Do not add them to the menu just yet. Save their data and wait for file to finish
							iLegacyAchievements++;
							iLegacyID[ iLegacyAchievements ] = atoi( pre_data[ 0 ] );
						}
					}
					else
					{
						if ( pre_data[ 1 ] == 'TRUE' )
							state.menu.AddItem( "[A] " + szAchievementNames[ atoi( pre_data[ 0 ] ) ] + "\n", any( pre_data[ 0 ] ) );
						else
							state.menu.AddItem( "[P] " + szAchievementNames[ atoi( pre_data[ 0 ] ) ] + "\n", any( pre_data[ 0 ] ) );
					}
				}
			}
		}
		
		thefile.Close();
		
		// Add any legacy achievement to the end of the list, if any
		if ( state !is null )
		{
			for ( int iLoop = 0; iLoop <= iLegacyAchievements; iLoop++ )
			{
				state.menu.AddItem( "[A] " + szAchievementNames[ iLegacyID[ iLoop ] ] + "\n", any( string( iLegacyID[ iLoop ] ) ) );
			}
		}
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

// Get events
void GetEventData( const int& in index, int& in iID = 0, MenuHandler@ state = null )
{
	bool bFound = false;
	CBasePlayer@ pPlayer = g_PlayerFuncs.FindPlayerByIndex( index );
	
	for ( int i = 1; i <= 9; i++ )
	{
		string szPath = PATH_EVENT_DATA + "EVENT_" + string( i ) + ".txt";
		File@ thefile = g_FileSystem.OpenFile( szPath, OpenFile::READ );
		
		if ( thefile !is null && thefile.IsOpen() )
		{
			string szLine;
			while( !thefile.EOFReached() )
			{
				thefile.ReadLine( szLine );
				if ( szLine.Length() == 0 )
					continue;
				
				// Use ';' character as title
				if ( szLine[ 0 ] == ';' )
				{
					// Only show title if menu is active
					if ( state !is null )
					{
						szLine.Trim( ';' );
						state.menu.AddItem( szLine + "\n", any( string( i ) ) );
						
						// End here
						bFound = true;
						continue;
					}
				}
				
				// Show motd info
				if ( state is null && iID == i )
				{
					if ( szLine[ 0 ] == ';' ) // Title
					{
						szLine.Trim( ';' );
						
						NetworkMessage title( MSG_ONE_UNRELIABLE, NetworkMessages::ServerName, pPlayer.edict() );
						title.WriteString( szLine );
						title.End();
					}
					else // Text
					{
						szLine.Replace( '!n', '\n' ); // New lines, needed or things will cut out short
						
						NetworkMessage text( MSG_ONE_UNRELIABLE, NetworkMessages::MOTD, pPlayer.edict() );
						text.WriteByte( 0 );
						text.WriteString( szLine );
						text.End();
					}
				}
				
			}
			
			// End
			if ( state is null && iID == i )
			{
				NetworkMessage end( MSG_ONE_UNRELIABLE, NetworkMessages::MOTD, pPlayer.edict() );
				end.WriteByte( 1 );
				end.WriteString( "\n\n" );
				end.End();
				
				NetworkMessage restore( MSG_ONE_UNRELIABLE, NetworkMessages::ServerName, pPlayer.edict() );
				restore.WriteString( g_EngineFuncs.CVarGetString( "hostname" ) );
				restore.End();
				
				thefile.Close();
				break;
			}
		}
	}
	
	// No entries found?
	if ( !bFound && state !is null )
		state.menu.AddItem( "<no hay eventos activos en este momento>\n", any( "DUMMY" ) );
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
					stuff += "" + string( i ) + "#TRUE#" + ( aClaim[ index ][ i ] ? "1" : "0" ) + "\n";
				else
				{
					if ( pCustom.HasKeyvalue( "$i_sys_a_" + string( i ) ) )
					{
						CustomKeyvalue iProgress_pre( pCustom.GetKeyvalue( "$i_sys_a_" + string( i ) ) );
						int iProgress = iProgress_pre.GetInteger();
						stuff += "" + string( i ) + "#FALSE#" + string( iProgress ) + "\n";
					}
					else
						stuff += "" + string( i ) + "#FALSE#0\n";
				}
			}
			
			thefile.Write( stuff );
			thefile.Close();
		}
	}
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
	string original = "" + value;
	
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
	string number = "" + pre_convert[ 0 ];
	
	// Now, build the full string
	string convert = "" + number + "." + decimals;
	
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
	
	string fullpath = "" + PATH_LOGS + "LOG_" + year + "-" + szMonths + "-" + szDays + ".log";
	File@ thefile = g_FileSystem.OpenFile( fullpath, OpenFile::APPEND );
	
	if ( thefile !is null && thefile.IsOpen() )
	{
		thefile.Write( "" + szHours + ":" + szMinutes + ":" + szSeconds + " - " + szMessage );
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
	
	uint iMap = szMap.Length();
	
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

/* Returns the day specified, in spanish language */
string GetSpanishDate( DateTime& in dtTime )
{
	int year = dtTime.GetYear();
	int month = dtTime.GetMonth();
	int day = dtTime.GetDayOfMonth();
	
	string szMonth;
	switch( month )
	{
		case 1: szMonth = "Enero"; break;
		case 2: szMonth = "Febrero"; break;
		case 3: szMonth = "Marzo"; break;
		case 4: szMonth = "Abril"; break;
		case 5: szMonth = "Mayo"; break;
		case 6: szMonth = "Junio"; break;
		case 7: szMonth = "Julio"; break;
		case 8: szMonth = "Agosto"; break;
		case 9: szMonth = "Septiembre"; break;
		case 10: szMonth = "Octubre"; break;
		case 11: szMonth = "Noviembre"; break;
		case 12: szMonth = "Diciembre"; break;
	}
	
	return "" + day + " de " + szMonth + " de " + year;
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
		case 0: // Esperando la carroza
			szReturn = "Activa los botones del mapa\nassaultmesa2 sin activar la trampa de acido\ny sin ayuda de la Anti-Gravedad"; break;
		case 1: // Tu cara no me asusta
			szReturn = "Completa el mapa sc_face sin morir"; break;
		case 2: // Apunta mejor!
			szReturn = "Evade un misil de un RPG Grunt\nsin ser lastimado"; break;
		case 3: // Los 5 minutos son 5
			szReturn = "Completa la mision del mapa 5minutes_b1"; break;
		case 4: // Es todo lo que tienes?
			szReturn = "Desactiva los lasers del mapa\nauspices sin que estas te maten"; break;
		case 5: // Duke Nukem
			szReturn = "Mata a una Gargantua usando\nsolamente tus pies"; break;
		case 6: // Seria una lastima
			szReturn = "Escapa del mapa abandoned con la\nbomba activada antes que esta detone"; break;
		case 7: // Una batalla dificil
			szReturn = "Completa el mapa sc_frostfire_beta1\nsin morir"; break;
		case 8: // La asistencia es inutil
			szReturn = "Alcanza 125 puntos en un mapa con\ntodas las desventajas activadas"; break;
		case 9: // Chubby de bronce
			szReturn = "Completa el mapa toadsnatch\nen dificultad Normal"; break;
		case 10: // Chubby de plata
			szReturn = "Completa el mapa toadsnatch\nen dificultad Hard"; break;
		case 11: // Mis armas alcanzan
			szReturn = "Destruye a un Apache usando solo\narmas de la categoria 3"; break;
		case 12: // Chubby de oro
			szReturn = "Completa el mapa toadsnatch\nen dificultad Extreme"; break;
		case 13: // Un Chubby sin secretos
			szReturn = "Desbloquea todas las armas\ndel mapa toadsnatch"; break;
		case 14: // Vaya punto debil
			szReturn = "Mata un Kingpin sin que\neste active su escudo"; break;
		case 15: // Primero muerto!
			szReturn = "Completa el mapa quarter\nen dificultad Hard"; break;
		case 16: // Segundo mueres!
			szReturn = "Completa el mapa quarter\nen dificultad Hard sin que\nse destruya algun punto"; break;
		case 17: // Fast Gausser
			szReturn = "Completa el mapa gausslabbeta2\nen menos de 3 minutos"; break;
		case 18: // Trepando todo el dia
			szReturn = "Completa el mapa sc_persia sin morir\ny sin ayuda de la Anti-Gravedad"; break;
		case 19: // Hecho en Quake
			szReturn = "Completa el mapa it_has_leaks\ncon las siguientes condiciones:\n\n> Sin morir\n> Con la desventaja [Regeneracion en OFF]\n> Con la desventaja [Equipamiento Limitado]"; break;
		case 20: // Ser devorado aburre
			szReturn = "Sobrevive 30 o mas segundos a\nlos ataques de una Barnacle"; break;
		case 21: // Un empleado mas
			szReturn = "Completa el mapa mommamesa\nen cualquier dificultad"; break;
		case 22: // Graficos HD y 3D
			szReturn = "Escapa de la secuencia de\nautodestruccion en el mapa mommamesa"; break;
		case 23: // Cuadrangular!
			szReturn = "Mata a una Stukabat arrogandole una\ncrowbar a una distancia considerable"; break;
		case 24: // Svenmessa
			szReturn = "Adquiere el final <Best> en el mapa\nmommamesa en dificultad Nightmare"; break;
		case 25: // Nunca? Siempre
			szReturn = "Completa el mapa never sin morir"; break;
		case 26: // Que sea un empate
			szReturn = "Mata a un Human Grunt al mismo\ntiempo que este te mate\n\nLOGRO LEGADO: Ya no es adquirible"; break;
		case 27: // Sniper a la matrix
			szReturn = "Completa el mapa gash\ncon menos de 3 muertes"; break;
		case 28: // Si fuese asi de facil
			szReturn = "Rescata a todos los\ncientificos del mapa hostage"; break;
		case 29: // Quien necesita balas?
			szReturn = "Mata a una Gargantua usando\nHornet o Shock Rifle"; break;
		case 30: // Nagoya
			szReturn = "Destruye las 5 cajas secretas\ndel mapa ub_nagoya_v2"; break;
		case 31: // Cara vs Cara
			szReturn = "Hazle frente al jefe del\nmapa ub_iseki2 sin morir"; break;
		case 32: // Alien Uncontroller
			szReturn = "Mata a un Alien Controller usando\nuna Tripmine\n\nNOTA: Dispararle a la Tripmine\n          hara invalido el logro"; break;
		case 33: // Electricista Infernal
			szReturn = "Completa el mapa deadsimpleneo2\nen la modalidad Overload"; break;
		case 34: // Licenciatura en Gonomes
			szReturn = "Completa el mapa deadsimpleneo2\nen la modalidad Gonome Hunter"; break;
		case 35: // No quiero mas problemas
			szReturn = "Atraviesa los lasers del mapa\nBlackMesaEPF y desactivalos a mano"; break;
		case 36: // Soy Leyenda
			szReturn = "Completa el primer nivel de la serie\nsc_dark_seekers_final sin morir"; break;
		case 37: // Me importa
			szReturn = "Desbloquea todas las armas\ndel mapa ub_megaman2"; break;
		case 38: // Avioneta de Papel
			szReturn = "Completa el mapa dc_inflight sin que el\nspawnpoint reciba mas de 925 HP de danio"; break;
		case 39: // Escuadron Express
			szReturn = "Completa el mapa sandstone\nen menos de 9 minutos"; break;
		case 40: // Buscate otra victima!
			szReturn = "Escapa de la secuencia de\nautodestruccion en el mapa sc_trollworld"; break;
		case 41: // Delicioso!
			szReturn = "Has que una Barnacle se devore una Snark"; break;
		case 42: // CazaFantasmas
			szReturn = "Completa el mapa ghost_buster"; break;
		case 43: // No Lifer? Mentira
			szReturn = "Adquiere 160 puntos en el mapa\njumpers en menos de 60 minutos"; break;
		case 44: // No sin mi headcrab!
			szReturn = "Arrastra a un Headcrab hasta\nel final de un mapa"; break;
		case 45: // Un intento de pelicula
			szReturn = "Completa el mapa deluge_beta_v3\nen dificultad Normal con menos\nde 7 muertes"; break;
		case 46: // Pelicula de clase B
			szReturn = "Completa el mapa deluge_beta_v3\nen dificultad Hard con menos\nde 4 muertes"; break;
		case 47: // Proteccion Perfecta
			szReturn = "Completa el mapa sciguard2 sin\nque muera algun cientifico"; break;
		case 48: // Una buena pelicula
			szReturn = "Completa el mapa deluge_beta_v3\nen dificultad Ultra Violence sin morir"; break;
		case 49: // ninjas pls
			szReturn = "Completa el mapa nm_uspninjas sin morir"; break;
		case 50: // Has oido hablar de los Yakuza?
			szReturn = "Mata 5 veces a un mismo Alien Slave"; break;
		case 51: // Miembro de la S.A.C.
			szReturn = "Completa el mapa fortified1\nen cualquier dificultad"; break;
		case 52: // Tareas de rutina
			szReturn = "Completa el mapa fortified1\nen dificultad Normal"; break;
		case 53: // Zombiely Fire
			szReturn = "Has que un Zombie mate a otro Zombie\n\nNOTA: Los Gonomes son excluidos\n          de este logro"; break;
		case 54: // Apache? Yo no vi nada
			szReturn = "Completa el mapa fortified1\nen dificultad Hard"; break;
		case 55: // S.A.C. Elite
			szReturn = "Completa el mapa fortified1\nen dificultad Ultra Hard"; break;
		case 56: // Alto voltaje
			szReturn = "Mata a un Robo Grunt usando\narmas cuerpo a cuerpo"; break;
		case 57: // Desafiando a la muerte
			szReturn = "Completa el mapa fortified1\nen cualquier dificultad con\nla modalidad Survival activada"; break;
		case 58: // Yo tambien puedo ayudar!
			szReturn = "En el mapa fortified1, abandona tu\npuesto de comandante para asistir\na los jugadores en el campo de batalla\ny ayudalos a ganar la mision"; break;
		case 59: // Estoy expuesto
			szReturn = "Completa el mapa exposedB1 sin morir"; break;
		case 60: // INMORTAL
			szReturn = "Completa el mapa fortified1\nen dificultad Ultra Hard con\nla modalidad Survival activada"; break;
		case 61: // Expert Gausser
			szReturn = "Completa el puzzle secreto del mapa\nkeen_birthday_part1_beta"; break;
		case 62: // Sniper? Eso se come?
			szReturn = "Mata a 10 Male Assassin que usen\nSniper con una Ballesta a una\ndistancia considerable"; break;
		case 63: // Error 404
			szReturn = "Completa el mapa sc_phantasmish_beta\ncon menos de 2 muertes"; break;
		case 64: // Detras de la puerta
			szReturn = "Encuentra la habitacion secreta\ndel mapa skylined"; break;
		case 65: // Estado de Shock
			szReturn = "Mata a 10 Shock Troopers usando\nla explosion de la Shock Rifle"; break;
		case 66: // Saltos de fe
			szReturn = "Completa los 6 puzzles del\nmapa 6doors sin morir"; break;
		case 67: // Hace frio ahi afuera
			szReturn = "Completa el mapa coldburn_beta\ncon las siguientes condiciones:\n\n> Sin morir\n> Sin el uso de habilidades"; break;
		case 68: // Domando al agresivo
			szReturn = "Mata a un Gonome usando\narmas cuerpo a cuerpo sin\nque este te lastime"; break;
		case 69: // Deja de bugearte carajo!
			szReturn = "Completa el mapa gordonsci2\nsin que Gordon Freeman muera"; break;
		case 70: // Ni el infierno puede detenerme!
			szReturn = "Completa el mapa canyondoom4"; break;
		case 71: // Oscuridad! Mi viejo amigo
			szReturn = "Completa el mapa sc_defmap_v3\nsin reparar el generador\ny sin que el Wave Generator\nreciba mas de 1,000 HP de danio"; break;
		case 72: // Respetando los clasicos
			szReturn = "Completa el mapa io_v1\ncon las siguientes condiciones:\n\n> Sin morir\n> Sin el uso de habilidades\n> Con la desventaja [Equipo ausente]"; break;
		case 73: // El mas minimo detalle
			szReturn = "Encuentra el nivel secreto\nde la serie projectg"; break;
		case 74: // Perdi 20 minutos en esto?
			szReturn = "En el mapa desertcircle, mata\nal King usando el mortero"; break;
		case 75: // Plataforma 2.5D
			szReturn = "Completa el puzzle secreto\nde la serie svencoop"; break;
		case 76: // La bodega injusta
			szReturn = "Completa el mapa thewinery sin morir"; break;
		case 77: // Sobre mi cadaver!
			szReturn = "Completa el mapa def_hakase"; break;
		case 78: // LAS MALDITAS TEXTURAS!
			szReturn = "Completa el mapa sc_downunder sin morir"; break;
		case 79: // Aprobado por Ema
			szReturn = "Completa el mapa tox_silo sin morir"; break;
		case 80: // Zero elevado a la Cero
			szReturn = "Completa el mapa zero\ncon las siguientes condiciones:\n\n> Sin morir\n> Con la desventaja [Atraccion de Ataques]\n> Con la desventaja [Fobia Medicinal]"; break;
		case 81: // Crisis Existencial
			szReturn = "Completa el mapa canyondoom4 sin morir\n\nNOTA: Este logro solo aplica dentro\n          del tiempo limite de 15 minutos"; break;
		case 82: // Strike-Counter
			szReturn = "Completa el mapa cs_galleon-f\ncon las siguientes condiciones:\n\n> Sin morir\n> Sin el uso de habilidades\n> Con la desventaja [Realismo]"; break;
		case 83: // A cuerda
			szReturn = "Completa el mapa clockwork\ncon las siguientes condiciones:\n\n> Sin morir\n> Sin el uso de [Poder de Equipo]"; break;
		case 84: // JOHN CENA
			szReturn = "Mata al primer jefe de la\nserie ub_megaman sin morir"; break;
		case 85: // Fuga de Escondidas
			szReturn = "Encuentra todos los secretos\ndel mapa it_has_leaks"; break;
		case 86: // esTORpeado
			szReturn = "Mata a un Tor con una Pipe Wrench"; break;
		case 87: // Carnada Explosiva
			szReturn = "Has que una Barnacle se devore\nuna Shock Roach a punto de explotar"; break;
		case 88: // Algo de sentido
			szReturn = "Atraviesa el puzzle de las tripmines\ndel mapa pointless_b2 sin reiniciarlos"; break;
		case 89: // Seamos puntuales
			szReturn = "Mata al jefe del mapa syowa_japan\nen menos de 5 minutos"; break;
		case 90: // Humano o Alien?
			szReturn = "Completa el mapa sc_trapped2\ncon las siguientes condiciones:\n\n> Sin el uso de habilidades\n> Con la desventaja [Retribucion Karmica]"; break;
		case 91: // Destruccion de determinacion
			szReturn = "Mata a todos los enemigos\ndel mapa dreamstairs_v3"; break;
		case 92: // Team Fortress
			szReturn = "Completa el mapa sc_fortress sin\ndestruir ningun spawn enemigo\n\nNOTA: Se exceptuan aquellos necesarios\n          para progresar en el mapa\n\nNOTA: Destruir el tanque esta permitido"; break;
		case 93: // Mi caballo es asombroso
			szReturn = "Monta a un Voltigore y sobrevive\npor 30 o mas segundos"; break;
		case 94: // Primera linea
			szReturn = "Completa el mapa sc_frontline sin morir"; break;
		case 95: // Descolapsar
			szReturn = "Completa el mapa sc_doc sin morir"; break;
		case 96: // Perdiendo el tiempo
			szReturn = "Completa el mapa sc_psyko\nsin el uso de habilidades"; break;
		case 97: // Creo que lo rompi
			szReturn = "En el mapa sc_another, mata al barney\nantes que active las torretas"; break;
		case 98: // Sayonara
			szReturn = "Tira por la ventana al enemigo final\nen el mapa ascii_art o ascii_art2\n\nLOGRO LEGADO: Ya no es adquirible"; break;
		case 99: // Anti-Creacionista
			szReturn = "Completa el mapa wolf3dlvl1\ncon las siguientes condiciones:\n\n> Sin morir\n> Sin el uso de habilidades\n> Con la desventaja [Equipo ausente]\n> Con la desventaja [Explosion Fuerte]\n> Matar a todos los enemigos"; break;
		case 100: // Trampas para tarados
			szReturn = "Completa el mapa breakout_extended sin morir"; break;
		case 101: // Curando el apocalipsis
			szReturn = "Adquiere el medkit secreto del mapa\nzombie_nights_v7 sin morir"; break;
		case 102: // No a la Inflacion
			szReturn = "Encuentra todos los Picard Coins\ndel mapa kh3"; break;
		case 103: // Asesinos de segunda
			szReturn = "Escapa de la secuencia de\nautodestruccion en el mapa infested2\nsin matar a ninguna Female Assassin\n\nLOGRO LEGADO: Ya no es adquirible"; break;
		case 104: // Cazador 3.0
			szReturn = "Mata 15 gargantuas en el mapa garghnt3"; break;
		case 105: // Baile Interplanetario
			szReturn = "Completa el mapa arc-novus-4\ncon las siguientes condiciones:\n\n> Menos de 4 muertes\n> Sin el uso de [Armor Inicial]\n> Con la desventaja [Atraccion de Ataques]"; break;
		case 106: // Persistencia oculta
			szReturn = "Encuentra y completa los 3 puzzles\nsecretos del mapa adams_puzzles_beta2"; break;
		case 107: // Terrible equipo
			szReturn = "Completa el mapa bossbattle\nsin desperdiciar ninguna vida"; break;
		case 108: // Carameloraro
			szReturn = "Encuentra todos los caramelos\ndel mapa evilmansion"; break;
		case 109: // Guerra Infernal
			szReturn = "Completa el mapa sc_spacewar\ncon menos de 2 muertes"; break;
		case 110: // Feliz navidad
			szReturn = "En el mapa sc_santasrevenge_b6\nmata a al menos 1 Female Assassin\nusando los misiles\n\nLOGRO LEGADO: Ya no es adquirible"; break;
		case 111: // Grande de la Vieja Escuela
			szReturn = "En cualquier mapa dmc_\nmata a un jugador que este en el aire\ncon un impacto directo de la\nRocket Launcher o Grenade Launcher"; break;
		case 112: // Sinfonia HalfQuake
			szReturn = "Completa el mapa bw sin morir"; break;
		case 113: // Francotirador
			szReturn = "En cualquier mapa aim_ig_\nmata a 2 o mas jugadores al mismo tiempo\nusando la InstaGib Gauss"; break;
		case 114: // Ofensiva Defensiva
			szReturn = "Completa el mapa factions sin que la\nbase reciba mas de 1,000 HP de danio"; break;
		case 115: // Precision Quadratica
			szReturn = "Obten mas de 80,000 puntos en el mapa quad_f"; break;
		case 116: // Distorcion Quadratica
			szReturn = "Obten mas de 40,000 puntos en el mapa ra_quad"; break;
		case 117: // Dado vuelta
			szReturn = "Completa el mapa turretfortress en\nla modalidad Reverse en dificultad Hard"; break;
		case 118: // Defensa Impenetable
			szReturn = "Completa el mapa turretfortress en\nla modalidad Original en dificultad Hard"; break;
		case 119: // Sobreviviente del mas alla
			szReturn = "Completa el mapa sc_robination_revised\nsin morir"; break;
		case 120: // Saltos bipolares
			szReturn = "Completa el mapa hl_trick\n\nNOTA: Se permite el uso de CheckPoints.\n          Sin embargo este logro no\n          otorgara recompensa alguna\n          si estas son usadas"; break;
		case 121: // Pajaro sin alas
			szReturn = "Completa el mapa d_trick1\n\nNOTA: Se permite el uso de CheckPoints.\n          Sin embargo este logro no\n          otorgara recompensa alguna\n          si estas son usadas"; break;
		case 122: // Escaleras del diablo
			szReturn = "Completa el mapa hc2b3a\n\nNOTA: Se permite el uso de CheckPoints.\n          Sin embargo este logro no\n          otorgara recompensa alguna\n          si estas son usadas"; break;
		case 123: // Laberinto neutral
			szReturn = "Mata a todos los Pit Drones y\nBaby Gargantuas en el laberinto\ndel mapa sc_mazing"; break;
		case 124: // Memoria fotografica
			szReturn = "Introduce el codigo y abre la puerta del\nmapa ub_megaman3 en menos de 2 minutos"; break;
		case 125: // Desesperacion
			szReturn = "Dispara a un mismo Alien Grunt con 6 armas\ndiferentes en menos de 15 segundos"; break;
		case 126: // Tome un cafe (o dos, o tres)
			szReturn = "Completa el mapa between_elvis_lg"; break;
		case 127: // Base 420
			szReturn = "Completa el mapa cassault1\ncon las siguientes condiciones:\n\n> Sin morir\n> Con la desventaja [Realismo]"; break;
		case 128: // El fin de Andrea
			szReturn = "Completa el mapa tox_xen5\ncon las siguientes condiciones:\n\n> Sin morir\n> Sin el uso de habilidades\n> Con la desventaja [Retribucion Karmica]\n> En menos de 90 minutos"; break;
		case 129: // Half-Mario sin Mario
			szReturn = "Mata a todos los enemigos del mapa\nsc_marioland teniendo menos de 3 muertes"; break;
		case 130: // Kamikaze Planet
			szReturn = "Completa el mapa hplanet en menos de\n20 minutos con todas las\nDesventajas activadas"; break;
		case 131: // Cerveza a la Meme
			szReturn = "Completa el mapa croodcoop sin morir"; break;
		case 132: // Anno Domini
			szReturn = "Completa el mapa sc_titans\nsin el uso de habilidades"; break;
		case 133: // Y asi comienza
			szReturn = "En el mapa bm_sts, mejora todos\ntus cristales a Techlevel 5"; break;
		case 134: // Trabajo Insoportable
			szReturn = "Completa el mapa polar_rescue en dificultad Hard"; break;
		case 135: // Menos tedioso, vale?
			szReturn = "Completa la serie sc_tetris en menos de 75 minutos"; break;
		case 136: // Tumba de la INmuerte
			szReturn = "Completa la serie sc_tombofdeath_v12\ncon menos de 2 muertes por nivel"; break;
		case 137: // ESTOY AL PEDO, OKAY?!
			szReturn = "Completa el mapa beatthis"; break;
		case 138: // Fuera de Servicio
			szReturn = "Mata a 400 enemigos en el mapa stadium4"; break;
		case 139: // accidente de dross numero GTA 5.16
			szReturn = "En el mapa fun_big_city2, mata a un\njugador que este montando una motocicleta.\nRobalo, y atropella a otro jugador con esta"; break;
		case 140: // Me tire por la ventana...
			szReturn = "...Y lo unico que encontre fue un pelotero!\n\nPISTA: skylined"; break;
		case 141: // Yoshi's Island
			szReturn = "Encuentra todas las Freaky Flowers\nde la serie sectore"; break;
		case 142: // Fashionable Mecha
			szReturn = "En el mapa tunnel, mata a 3 o mas\nZombies al mismo tiempo utilizando la\nauto-destruccion del RoboGrunt aliado"; break;
		case 143: // Cuerpo de Guerra
			szReturn = "Completa el mapa alamo1\ncon las siguientes condiciones:\n\n> Sin morir\n> Con la desventaja [Explosion Fuerte]"; break;
		case 144: // Banio Privado
			szReturn = "Consigue mas de 100 puntos en el\nmapa lmsbath en menos de 10 rondas"; break;
		case 145: // Asalto Asaltado
			szReturn = "Completa la serie assaultmesa2 sin morir"; break;
		case 146: // quadrazid
			szReturn = "Completa el mapa sc_mazing en menos de 21 minutos"; break;
		case 147: // Svencraft
			szReturn = "Alcanza el cielo en el mapa build"; break;
		case 148: // Vacio del terror
			szReturn = "Completa el mapa thevoid"; break;
		case 149: // Baile del cuadradro
			szReturn = "Completa el mapa square_run"; break;
		case 150: // La nueva fortaleza
			szReturn = "Completa el mapa rc_towerdefense\nen cualquier dificultad"; break;
		case 151: // Playa falsa
			szReturn = "Completa el mapa beachxp_isc\ncon menos de 8 muertes"; break;
		case 152: // Violacion de Copyright
			szReturn = "Completa el mapa dccoop1\ncon menos de 20 muertes\n\nNOTA: Debes atravesar los lasers del\n          final del mapa para calificar"; break;
		case 153: // RUSHER CAPITALISTA
			szReturn = "Completa el mapa tox_slug1\ncon las siguientes condiciones:\n\n> En menos de 20 minutos\n> Con la desventaja [Escaso Auxilio]"; break;
		case 154: // Caja de la victoria
			szReturn = "Completa el mapa rc_towerdefense\nen dificultad Ultra Hard o superior"; break;
		case 155: // NeoDiferencias
			szReturn = "Completa el mapa deadsimpleneo2\nen la modalidad Protection"; break;
		case 156: // Obligado a Discriminar
			szReturn = "Completa el minijuego del mapa toonrun3\nsin matar a ningun Scientist"; break;
		case 157: // Ah? Tenia que morir?
			szReturn = "Sobrevive la explosion final del mapa extension"; break;
		case 158: // hhhhhhhhhhhhhhh
			szReturn = "Completa la serie warzone sin morir"; break;
		case 159: // Canto Mortal
			szReturn = "Completa el mapa disco_boss\ncon menos de 3 muertes"; break;
		case 160: // ME DUELE EL TECLADO
			szReturn = "Completa el mapa the-climb3\n\nNOTA: Hasta 150 CheckPoints son permitidos.\n          Pasado este numero el logro\n          no otorgara recompensa alguna"; break;
		case 161: // Memorias del pasado
			szReturn = "Encuentra el nivel secreto de la serie Quake 1"; break;
		case 162: // Limpieza Infantil
			szReturn = "Mata a 10 o mas Baby Headcrabs\ncon la explosion de la ballesta"; break;
		case 163: // Examen Complementario
			szReturn = "Completa el mapa trials_v1"; break;
		case 164: // Luz Privatizada
			szReturn = "En el mapa thdm5, mata a 5 jugadores\ncon la Tesla Gun sin morir en el intento"; break;
		case 165: // Ticket de Pelicula
			szReturn = "Completa el mapa suspension en dificultad Medium o superior"; break;
		case 166: // Escuadron Suicida
			szReturn = "Completa el mapa suspension en dificultad Insane"; break;
		case 167: // Cuidado con Sandra
			szReturn = "Mata a 666 Male Assassins"; break;
		case 168: // Busqueda Implacable
			szReturn = "En el evento Camara de Escondidas, busca y mata\na todos los monstruos, inclusive los secretos"; break;
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
			case 2: // Apunta mejor!
			{
				g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTCENTER, "Recompensa de logro adquirida!\n\nSuministro Auxiliar [x1]\n" );
				g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "[SCXPM] Enhorabuena! Por completar el logro has recibido \"Suministro Auxiliar\" [x1] como recompensa\n" );
				
				if ( mode[ index ] != 4 )
				{
					if ( sparks[ index ] <= 0 )
						sparks[ index ] = 2;
					else
					{
						if ( sparks[ index ] < 100 )
							sparks[ index ]++;
						else
						{
							bSparkReward[ index ] = true;
							g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "[SCXPM] No puedes llevar mas de 100 Suministros Auxiliares. En su lugar se han convertido en 18,000 EXP\n" );
							xp_h[ index ] += 18000;
							if ( mode[ index ] == 3 ) earnedxp[ index ] += 18000;
						}
					}
				}
				else
				{
					if ( sparks_p[ index ] >= 0 )
					{
						if ( sparks_p[ index ] == 0 )
							sparks_p[ index ] = 2;
						else
						{
							if ( sparks_p[ index ] < 100 )
								sparks_p[ index ]++;
							else
							{
								bSparkReward[ index ] = true;
								g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "[SCXPM] No puedes llevar mas de 100 Suministros Auxiliares. En su lugar se han convertido en 18,000 EXP\n" );
								xp_p[ index ] += 18000;
								earnedxp[ index ] += 18000;
							}
						}
					}
				}
				
				break;
			}
			case 5: // Duke Nukem
			{
				g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTCENTER, "Recompensa de logro adquirida!\n\n1,000 EXP\n" );
				g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "[SCXPM] Enhorabuena! Por completar el logro has recibido \"1,000 EXP\" como recompensa\n" );
				
				if ( mode[ index ] == 1 ) xp_e[ index ] += 1000;
				else if ( mode[ index ] == 2 ) xp[ index ] += 1000;
				else if ( mode[ index ] == 3 ) xp_h[ index ] += 1000;
				else if ( mode[ index ] == 4 ) xp_p[ index ] += 1000;
				earnedxp[ index ] += 1000;
				
				break;
			}
			case 7: // Una batalla dificil
			{
				g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTCENTER, "Recompensa de logro adquirida!\n\n5,555 EXP\n" );
				g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "[SCXPM] Enhorabuena! Por completar el logro has recibido \"5,555 EXP\" como recompensa\n" );
				
				if ( mode[ index ] == 1 ) xp_e[ index ] += 5555;
				else if ( mode[ index ] == 2 ) xp[ index ] += 5555;
				else if ( mode[ index ] == 3 ) xp_h[ index ] += 5555;
				else if ( mode[ index ] == 4 ) xp_p[ index ] += 5555;
				earnedxp[ index ] += 5555;
				
				break;
			}
			case 8: // La asistencia es inutil
			{
				g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTCENTER, "Recompensa de logro adquirida!\n\n1,250 EXP\n" );
				g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "[SCXPM] Enhorabuena! Por completar el logro has recibido \"1,250 EXP\" como recompensa\n" );
				
				if ( mode[ index ] == 1 ) xp_e[ index ] += 1250;
				else if ( mode[ index ] == 2 ) xp[ index ] += 1250;
				else if ( mode[ index ] == 3 ) xp_h[ index ] += 1250;
				else if ( mode[ index ] == 4 ) xp_p[ index ] += 1250;
				earnedxp[ index ] += 1250;
				
				break;
			}
			case 12: // Chubby de oro
			{
				g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTCENTER, "Recompensa de logro adquirida!\n\nEXP x2 (2 horas)\n" );
				g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "[SCXPM] Enhorabuena! Por completar el logro has recibido \"EXP x2\" [2 horas] como recompensa\n" );
				
				DateTime realduration( UnixTimestamp() );
				TimeDifference extra( 120 * 60 );
				realduration += extra;
				
				expamp[ index ] = 1;
				expamptime[ index ] = realduration;
				
				break;
			}
			case 14: // Vaya punto debil
			{
				g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTCENTER, "Recompensa de logro adquirida!\n\n3,000 EXP\n" );
				g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "[SCXPM] Enhorabuena! Por completar el logro has recibido \"3,000 EXP\" como recompensa\n" );
				
				if ( mode[ index ] == 1 ) xp_e[ index ] += 3000;
				else if ( mode[ index ] == 2 ) xp[ index ] += 3000;
				else if ( mode[ index ] == 3 ) xp_h[ index ] += 3000;
				else if ( mode[ index ] == 4 ) xp_p[ index ] += 3000;
				earnedxp[ index ] += 3000;
				
				break;
			}
			case 16: // Segundo mueres!
			{
				g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTCENTER, "Recompensa de logro adquirida!\n\n2,000 EXP\n" );
				g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "[SCXPM] Enhorabuena! Por completar el logro has recibido \"2,000 EXP\" como recompensa\n" );
				
				if ( mode[ index ] == 1 ) xp_e[ index ] += 2000;
				else if ( mode[ index ] == 2 ) xp[ index ] += 2000;
				else if ( mode[ index ] == 3 ) xp_h[ index ] += 2000;
				else if ( mode[ index ] == 4 ) xp_p[ index ] += 2000;
				earnedxp[ index ] += 2000;
				
				break;
			}
			case 19: // Hecho en Quake
			{
				g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTCENTER, "Recompensa de logro adquirida!\n\nEXP x2 (1 hora)\n" );
				g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "[SCXPM] Enhorabuena! Por completar el logro has recibido \"EXP x2\" [1 hora] como recompensa\n" );
				
				DateTime realduration( UnixTimestamp() );
				TimeDifference extra( 60 * 60 );
				realduration += extra;
				
				expamp[ index ] = 1;
				expamptime[ index ] = realduration;
				
				break;
			}
			case 23: // Cuadrangular!
			{
				g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTCENTER, "Recompensa de logro adquirida!\n\n2,000 EXP\n" );
				g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "[SCXPM] Enhorabuena! Por completar el logro has recibido \"2,000 EXP\" como recompensa\n" );
				
				if ( mode[ index ] == 1 ) xp_e[ index ] += 2000;
				else if ( mode[ index ] == 2 ) xp[ index ] += 2000;
				else if ( mode[ index ] == 3 ) xp_h[ index ] += 2000;
				else if ( mode[ index ] == 4 ) xp_p[ index ] += 2000;
				earnedxp[ index ] += 2000;
				
				break;
			}
			case 32: // Alien Uncontroller
			{
				g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTCENTER, "Recompensa de logro adquirida!\n\n2,000 EXP\n" );
				g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "[SCXPM] Enhorabuena! Por completar el logro has recibido \"2,000 EXP\" como recompensa\n" );
				
				if ( mode[ index ] == 1 ) xp_e[ index ] += 2000;
				else if ( mode[ index ] == 2 ) xp[ index ] += 2000;
				else if ( mode[ index ] == 3 ) xp_h[ index ] += 2000;
				else if ( mode[ index ] == 4 ) xp_p[ index ] += 2000;
				earnedxp[ index ] += 2000;
				
				break;
			}
			case 34: // Licenciatura en Gonomes
			{
				g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTCENTER, "Recompensa de logro adquirida!\n\nEXP x2 (1 hora)\n" );
				g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "[SCXPM] Enhorabuena! Por completar el logro has recibido \"EXP x2\" [1 hora] como recompensa\n" );
				
				DateTime realduration( UnixTimestamp() );
				TimeDifference extra( 60 * 60 );
				realduration += extra;
				
				expamp[ index ] = 1;
				expamptime[ index ] = realduration;
				
				break;
			}
			case 40: // Buscate otra victima!
			{
				g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTCENTER, "Recompensa de logro adquirida!\n\n1,337 EXP\n" );
				g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "[SCXPM] Enhorabuena! Por completar el logro has recibido \"1,337 EXP\" como recompensa\n" );
				
				if ( mode[ index ] == 1 ) xp_e[ index ] += 1337;
				else if ( mode[ index ] == 2 ) xp[ index ] += 1337;
				else if ( mode[ index ] == 3 ) xp_h[ index ] += 1337;
				else if ( mode[ index ] == 4 ) xp_p[ index ] += 1337;
				earnedxp[ index ] += 1337;
				
				break;
			}
			case 43: // No Lifer? Mentira
			{
				g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTCENTER, "Recompensa de logro adquirida!\n\n1 Medalla\n" );
				g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "[SCXPM] Enhorabuena! Por completar el logro has recibido \"1 Medalla\" como recompensa\n" );
				
				if ( mode[ index ] == 1 )
				{
					// Send them to other mode if possible
					if ( medals[ index ] < 42 )
					{
						medals[ index ]++;
						g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "[SCXPM] Tu recompensa ha sido enviada al Modo Normal\n" );
					}
					else if ( medals_h[ index ] < 42 )
					{
						medals_h[ index ]++;
						g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "[SCXPM] Tu recompensa ha sido enviada al Modo Dificil\n" );
					}
					break;
				}
				else if ( mode[ index ] == 2 )
				{
					if ( medals[ index ] < 42 )
						medals[ index ]++;
				}
				else if ( mode[ index ] == 3 )
				{
					if ( medals_h[ index ] < 42 )
						medals_h[ index ]++;
				}
				else if ( mode[ index ] == 4 )
				{
					if ( medals_p[ index ] < maxmedals_p[ index ] )
						medals_p[ index ]++;
				}
				
				break;
			}
			case 44: // No sin mi headcrab!
			{
				g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTCENTER, "Recompensa de logro adquirida!\n\nEXP x3 (1 hora)\n" );
				g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "[SCXPM] Enhorabuena! Por completar el logro has recibido \"EXP x3\" [1 hora] como recompensa\n" );
				
				DateTime realduration( UnixTimestamp() );
				TimeDifference extra( 60 * 60 );
				realduration += extra;
				
				expamp[ index ] = 2;
				expamptime[ index ] = realduration;
				
				break;
			}
			case 47: // Proteccion Perfecta
			{
				g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTCENTER, "Recompensa de logro adquirida!\n\n5,000 EXP\n" );
				g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "[SCXPM] Enhorabuena! Por completar el logro has recibido \"5,000 EXP\" como recompensa\n" );
				
				if ( mode[ index ] == 1 ) xp_e[ index ] += 5000;
				else if ( mode[ index ] == 2 ) xp[ index ] += 5000;
				else if ( mode[ index ] == 3 ) xp_h[ index ] += 5000;
				else if ( mode[ index ] == 4 ) xp_p[ index ] += 5000;
				earnedxp[ index ] += 5000;
				
				break;
			}
			case 48: // Una buena pelicula
			{
				g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTCENTER, "Recompensa de logro adquirida!\n\nSuministro Auxiliar [x1]\n" );
				g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "[SCXPM] Enhorabuena! Por completar el logro has recibido \"Suministro Auxiliar\" [x1] como recompensa\n" );
				
				if ( mode[ index ] != 4 )
				{
					if ( sparks[ index ] <= 0 )
						sparks[ index ] = 2;
					else
					{
						if ( sparks[ index ] < 100 )
							sparks[ index ]++;
						else
						{
							bSparkReward[ index ] = true;
							g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "[SCXPM] No puedes llevar mas de 100 Suministros Auxiliares. En su lugar se han convertido en 18,000 EXP\n" );
							xp_h[ index ] += 18000;
							if ( mode[ index ] == 3 ) earnedxp[ index ] += 18000;
						}
					}
				}
				else
				{
					if ( sparks_p[ index ] >= 0 )
					{
						if ( sparks_p[ index ] == 0 )
							sparks_p[ index ] = 2;
						else
						{
							if ( sparks_p[ index ] < 100 )
								sparks_p[ index ]++;
							else
							{
								bSparkReward[ index ] = true;
								g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "[SCXPM] No puedes llevar mas de 100 Suministros Auxiliares. En su lugar se han convertido en 18,000 EXP\n" );
								xp_p[ index ] += 18000;
								earnedxp[ index ] += 18000;
							}
						}
					}
				}
				
				break;
			}
			case 55: // S.A.C. Elite
			{
				g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTCENTER, "Recompensa de logro adquirida!\n\n5,000 EXP\n" );
				g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "[SCXPM] Enhorabuena! Por completar el logro has recibido \"5,000 EXP\" como recompensa\n" );
				
				if ( mode[ index ] == 1 ) xp_e[ index ] += 5000;
				else if ( mode[ index ] == 2 ) xp[ index ] += 5000;
				else if ( mode[ index ] == 3 ) xp_h[ index ] += 5000;
				else if ( mode[ index ] == 4 ) xp_p[ index ] += 5000;
				earnedxp[ index ] += 5000;
				
				break;
			}
			case 57: // Desafiando a la muerte
			{
				g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTCENTER, "Recompensa de logro adquirida!\n\nSuministro Auxiliar [x1]\n" );
				g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "[SCXPM] Enhorabuena! Por completar el logro has recibido \"Suministro Auxiliar\" [x1] como recompensa\n" );
				
				if ( mode[ index ] != 4 )
				{
					if ( sparks[ index ] <= 0 )
						sparks[ index ] = 2;
					else
					{
						if ( sparks[ index ] < 100 )
							sparks[ index ]++;
						else
						{
							bSparkReward[ index ] = true;
							g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "[SCXPM] No puedes llevar mas de 100 Suministros Auxiliares. En su lugar se han convertido en 18,000 EXP\n" );
							xp_h[ index ] += 18000;
							if ( mode[ index ] == 3 ) earnedxp[ index ] += 18000;
						}
					}
				}
				else
				{
					if ( sparks_p[ index ] >= 0 )
					{
						if ( sparks_p[ index ] == 0 )
							sparks_p[ index ] = 2;
						else
						{
							if ( sparks_p[ index ] < 100 )
								sparks_p[ index ]++;
							else
							{
								bSparkReward[ index ] = true;
								g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "[SCXPM] No puedes llevar mas de 100 Suministros Auxiliares. En su lugar se han convertido en 18,000 EXP\n" );
								xp_p[ index ] += 18000;
								earnedxp[ index ] += 18000;
							}
						}
					}
				}
				
				break;
			}
			case 60: // INMORTAL
			{
				g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTCENTER, "Recompensa de logro adquirida!\n\nModificador de EXP [+15%]\n" );
				g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "[SCXPM] Enhorabuena! Por completar el logro has recibido \"Modificador de EXP\" [+15%] como recompensa\n" );
				
				AddPermaIncrease( index, "15.0#Fortificador Extremo#Logro <INMORTAL> adquirido!n!n+15% Ganancia de EXP!n\n" );
				
				break;
			}
			case 63: // Error 404
			{
				g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTCENTER, "Recompensa de logro adquirida!\n\nSuministro Auxiliar [x1]\n" );
				g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "[SCXPM] Enhorabuena! Por completar el logro has recibido \"Suministro Auxiliar\" [x1] como recompensa\n" );
				
				if ( mode[ index ] != 4 )
				{
					if ( sparks[ index ] <= 0 )
						sparks[ index ] = 2;
					else
					{
						if ( sparks[ index ] < 100 )
							sparks[ index ]++;
						else
						{
							bSparkReward[ index ] = true;
							g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "[SCXPM] No puedes llevar mas de 100 Suministros Auxiliares. En su lugar se han convertido en 18,000 EXP\n" );
							xp_h[ index ] += 18000;
							if ( mode[ index ] == 3 ) earnedxp[ index ] += 18000;
						}
					}
				}
				else
				{
					if ( sparks_p[ index ] >= 0 )
					{
						if ( sparks_p[ index ] == 0 )
							sparks_p[ index ] = 2;
						else
						{
							if ( sparks_p[ index ] < 100 )
								sparks_p[ index ]++;
							else
							{
								bSparkReward[ index ] = true;
								g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "[SCXPM] No puedes llevar mas de 100 Suministros Auxiliares. En su lugar se han convertido en 18,000 EXP\n" );
								xp_p[ index ] += 18000;
								earnedxp[ index ] += 18000;
							}
						}
					}
				}
				
				break;
			}
			case 70: // Ni el infierno puede detenerme!
			{
				g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTCENTER, "Recompensa de logro adquirida!\n\n8,000 EXP\n" );
				g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "[SCXPM] Enhorabuena! Por completar el logro has recibido \"8,000 EXP\" como recompensa\n" );
				
				if ( mode[ index ] == 1 ) xp_e[ index ] += 8000;
				else if ( mode[ index ] == 2 ) xp[ index ] += 8000;
				else if ( mode[ index ] == 3 ) xp_h[ index ] += 8000;
				else if ( mode[ index ] == 4 ) xp_p[ index ] += 8000;
				earnedxp[ index ] += 8000;
				
				break;
			}
			case 72: // Respetando los clasicos
			{
				g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTCENTER, "Recompensa de logro adquirida!\n\nEXP x2 (1 hora)\n" );
				g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "[SCXPM] Enhorabuena! Por completar el logro has recibido \"EXP x2\" [1 hora] como recompensa\n" );
				
				DateTime realduration( UnixTimestamp() );
				TimeDifference extra( 60 * 60 );
				realduration += extra;
				
				expamp[ index ] = 1;
				expamptime[ index ] = realduration;
				
				break;
			}
			case 74: // Perdi 20 minutos en esto?
			{
				g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTCENTER, "Recompensa de logro adquirida!\n\nEXP x3 (1 hora)\n" );
				g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "[SCXPM] Enhorabuena! Por completar el logro has recibido \"EXP x3\" [1 hora] como recompensa\n" );
				
				DateTime realduration( UnixTimestamp() );
				TimeDifference extra( 60 * 60 );
				realduration += extra;
				
				expamp[ index ] = 2;
				expamptime[ index ] = realduration;
				
				break;
			}
			case 76: // La bodega injusta
			{
				g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTCENTER, "Recompensa de logro adquirida!\n\n3,000 EXP\n" );
				g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "[SCXPM] Enhorabuena! Por completar el logro has recibido \"3,000 EXP\" como recompensa\n" );
				
				if ( mode[ index ] == 1 ) xp_e[ index ] += 3000;
				else if ( mode[ index ] == 2 ) xp[ index ] += 3000;
				else if ( mode[ index ] == 3 ) xp_h[ index ] += 3000;
				else if ( mode[ index ] == 4 ) xp_p[ index ] += 3000;
				earnedxp[ index ] += 3000;
				
				break;
			}
			case 77: // Sobre mi cadaver!
			{
				g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTCENTER, "Recompensa de logro adquirida!\n\nSuministro Auxiliar [x4]\n" );
				g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "[SCXPM] Enhorabuena! Por completar el logro has recibido \"Suministro Auxiliar\" [x4] como recompensa\n" );
				
				if ( mode[ index ] != 4 )
				{
					if ( sparks[ index ] <= 0 )
						sparks[ index ] = 5;
					else
					{
						sparks[ index ] += 4;
						if ( sparks[ index ] > 100 )
						{
							bSparkReward[ index ] = true;
							
							int iSpareSparks = sparks[ index ] - 100;
							sparks[ index ] = 100;
							int iExtraXP = iSpareSparks * 18000;
							
							g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "[SCXPM] No puedes llevar mas de 100 Suministros Auxiliares. En su lugar se han convertido en " + AddCommas( iExtraXP ) + " EXP\n" );
							xp_h[ index ] += iExtraXP;
							if ( mode[ index ] == 3 ) earnedxp[ index ] += iExtraXP;
						}
					}
				}
				else
				{
					if ( sparks_p[ index ] >= 0 )
					{
						if ( sparks_p[ index ] == 0 )
							sparks[ index ] = 5;
						else
						{
							sparks_p[ index ] += 4;
							if ( sparks_p[ index ] > 100 )
							{
								bSparkReward[ index ] = true;
								
								int iSpareSparks = sparks_p[ index ] - 100;
								sparks_p[ index ] = 100;
								int iExtraXP = iSpareSparks * 18000;
								
								g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "[SCXPM] No puedes llevar mas de 100 Suministros Auxiliares. En su lugar se han convertido en " + AddCommas( iExtraXP ) + " EXP\n" );
								xp_p[ index ] += iExtraXP;
								earnedxp[ index ] += iExtraXP;
							}
						}
					}
				}
				
				break;
			}
			case 79: // Aprobado por Ema
			{
				g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTCENTER, "Recompensa de logro adquirida!\n\n1,234 EXP\n" );
				g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "[SCXPM] Enhorabuena! Por completar el logro has recibido \"1,234 EXP\" como recompensa\n" );
				
				if ( mode[ index ] == 1 ) xp_e[ index ] += 1234;
				else if ( mode[ index ] == 2 ) xp[ index ] += 1234;
				else if ( mode[ index ] == 3 ) xp_h[ index ] += 1234;
				else if ( mode[ index ] == 4 ) xp_p[ index ] += 1234;
				earnedxp[ index ] += 1234;
				
				break;
			}
			case 80: // Zero elevado a la Cero
			{
				g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTCENTER, "Recompensa de logro adquirida!\n\n1,500 EXP\n" );
				g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "[SCXPM] Enhorabuena! Por completar el logro has recibido \"1,500 EXP\" como recompensa\n" );
				
				if ( mode[ index ] == 1 ) xp_e[ index ] += 1500;
				else if ( mode[ index ] == 2 ) xp[ index ] += 1500;
				else if ( mode[ index ] == 3 ) xp_h[ index ] += 1500;
				else if ( mode[ index ] == 4 ) xp_p[ index ] += 1500;
				earnedxp[ index ] += 1500;
				
				break;
			}
			case 81: // Crisis Existencial
			{
				g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTCENTER, "Recompensa de logro adquirida!\n\n1 Medalla\n" );
				g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "[SCXPM] Enhorabuena! Por completar el logro has recibido \"1 Medalla\" como recompensa\n" );
				
				if ( mode[ index ] == 1 )
				{
					// Send them to other mode if possible
					if ( medals[ index ] < 42 )
					{
						medals[ index ]++;
						g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "[SCXPM] Tu recompensa ha sido enviada al Modo Normal\n" );
					}
					else if ( medals_h[ index ] < 42 )
					{
						medals_h[ index ]++;
						g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "[SCXPM] Tu recompensa ha sido enviada al Modo Dificil\n" );
					}
					break;
				}
				else if ( mode[ index ] == 2 )
				{
					if ( medals[ index ] < 42 )
						medals[ index ]++;
				}
				else if ( mode[ index ] == 3 )
				{
					if ( medals_h[ index ] < 42 )
						medals_h[ index ]++;
				}
				else if ( mode[ index ] == 4 )
				{
					if ( medals_p[ index ] < maxmedals_p[ index ] )
						medals_p[ index ]++;
				}
				
				break;
			}
			case 82: // Strike-Counter
			{
				g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTCENTER, "Recompensa de logro adquirida!\n\nSuministro Auxiliar [x1]\n" );
				g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "[SCXPM] Enhorabuena! Por completar el logro has recibido \"Suministro Auxiliar\" [x1] como recompensa\n" );
				
				if ( mode[ index ] != 4 )
				{
					if ( sparks[ index ] <= 0 )
						sparks[ index ] = 2;
					else
					{
						if ( sparks[ index ] < 100 )
							sparks[ index ]++;
						else
						{
							bSparkReward[ index ] = true;
							g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "[SCXPM] No puedes llevar mas de 100 Suministros Auxiliares. En su lugar se han convertido en 18,000 EXP\n" );
							xp_h[ index ] += 18000;
							if ( mode[ index ] == 3 ) earnedxp[ index ] += 18000;
						}
					}
				}
				else
				{
					if ( sparks_p[ index ] >= 0 )
					{
						if ( sparks_p[ index ] == 0 )
							sparks_p[ index ] = 2;
						else
						{
							if ( sparks_p[ index ] < 100 )
								sparks_p[ index ]++;
							else
							{
								bSparkReward[ index ] = true;
								g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "[SCXPM] No puedes llevar mas de 100 Suministros Auxiliares. En su lugar se han convertido en 18,000 EXP\n" );
								xp_p[ index ] += 18000;
								earnedxp[ index ] += 18000;
							}
						}
					}
				}
				
				break;
			}
			case 83: // A cuerda
			{
				g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTCENTER, "Recompensa de logro adquirida!\n\n1,000 EXP\n" );
				g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "[SCXPM] Enhorabuena! Por completar el logro has recibido \"1,000 EXP\" como recompensa\n" );
				
				if ( mode[ index ] == 1 ) xp_e[ index ] += 1000;
				else if ( mode[ index ] == 2 ) xp[ index ] += 1000;
				else if ( mode[ index ] == 3 ) xp_h[ index ] += 1000;
				else if ( mode[ index ] == 4 ) xp_p[ index ] += 1000;
				earnedxp[ index ] += 1000;
				
				break;
			}
			case 84: // JOHN CENA
			{
				g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTCENTER, "Recompensa de logro adquirida!\n\nEXP x3 (1 hora)\n" );
				g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "[SCXPM] Enhorabuena! Por completar el logro has recibido \"EXP x3\" [1 hora] como recompensa\n" );
				
				DateTime realduration( UnixTimestamp() );
				TimeDifference extra( 60 * 60 );
				realduration += extra;
				
				expamp[ index ] = 2;
				expamptime[ index ] = realduration;
				
				break;
			}
			case 90: // Humano o Alien?
			{
				g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTCENTER, "Recompensa de logro adquirida!\n\nSuministro Auxiliar [x1]\n" );
				g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "[SCXPM] Enhorabuena! Por completar el logro has recibido \"Suministro Auxiliar\" [x1] como recompensa\n" );
				
				if ( mode[ index ] != 4 )
				{
					if ( sparks[ index ] <= 0 )
						sparks[ index ] = 2;
					else
					{
						if ( sparks[ index ] < 100 )
							sparks[ index ]++;
						else
						{
							bSparkReward[ index ] = true;
							g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "[SCXPM] No puedes llevar mas de 100 Suministros Auxiliares. En su lugar se han convertido en 18,000 EXP\n" );
							xp_h[ index ] += 18000;
							if ( mode[ index ] == 3 ) earnedxp[ index ] += 18000;
						}
					}
				}
				else
				{
					if ( sparks_p[ index ] >= 0 )
					{
						if ( sparks_p[ index ] == 0 )
							sparks_p[ index ] = 2;
						else
						{
							if ( sparks_p[ index ] < 100 )
								sparks_p[ index ]++;
							else
							{
								bSparkReward[ index ] = true;
								g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "[SCXPM] No puedes llevar mas de 100 Suministros Auxiliares. En su lugar se han convertido en 18,000 EXP\n" );
								xp_p[ index ] += 18000;
								earnedxp[ index ] += 18000;
							}
						}
					}
				}
				
				break;
			}
			case 91: // Destruccion de determinacion
			{
				g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTCENTER, "Recompensa de logro adquirida!\n\nEXP x2 (1 hora)\n" );
				g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "[SCXPM] Enhorabuena! Por completar el logro has recibido \"EXP x2\" [1 hora] como recompensa\n" );
				
				DateTime realduration( UnixTimestamp() );
				TimeDifference extra( 60 * 60 );
				realduration += extra;
				
				expamp[ index ] = 1;
				expamptime[ index ] = realduration;
				
				break;
			}
			case 92: // Team Fortress
			{
				g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTCENTER, "Recompensa de logro adquirida!\n\n3,500 EXP\n" );
				g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "[SCXPM] Enhorabuena! Por completar el logro has recibido \"3,500 EXP\" como recompensa\n" );
				
				if ( mode[ index ] == 1 ) xp_e[ index ] += 3500;
				else if ( mode[ index ] == 2 ) xp[ index ] += 3500;
				else if ( mode[ index ] == 3 ) xp_h[ index ] += 3500;
				else if ( mode[ index ] == 4 ) xp_p[ index ] += 3500;
				earnedxp[ index ] += 3500;
				
				break;
			}
			case 96: // Perdiendo el tiempo
			{
				g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTCENTER, "Recompensa de logro adquirida!\n\n2,000 EXP\n" );
				g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "[SCXPM] Enhorabuena! Por completar el logro has recibido \"2,000 EXP\" como recompensa\n" );
				
				if ( mode[ index ] == 1 ) xp_e[ index ] += 2000;
				else if ( mode[ index ] == 2 ) xp[ index ] += 2000;
				else if ( mode[ index ] == 3 ) xp_h[ index ] += 2000;
				else if ( mode[ index ] == 4 ) xp_p[ index ] += 2000;
				earnedxp[ index ] += 2000;
				
				break;
			}
			case 97: // Creo que lo rompi
			{
				g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTCENTER, "Recompensa de logro adquirida!\n\n2,750 EXP\n" );
				g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "[SCXPM] Enhorabuena! Por completar el logro has recibido \"2,750 EXP\" como recompensa\n" );
				
				if ( mode[ index ] == 1 ) xp_e[ index ] += 2750;
				else if ( mode[ index ] == 2 ) xp[ index ] += 2750;
				else if ( mode[ index ] == 3 ) xp_h[ index ] += 2750;
				else if ( mode[ index ] == 4 ) xp_p[ index ] += 2750;
				earnedxp[ index ] += 2750;
				
				break;
			}
			case 99: // Anti-Creacionista
			{
				g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTCENTER, "Recompensa de logro adquirida!\n\n1 Medalla\n" );
				g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "[SCXPM] Enhorabuena! Por completar el logro has recibido \"1 Medalla\" como recompensa\n" );
				
				if ( mode[ index ] == 1 )
				{
					// Send them to other mode if possible
					if ( medals[ index ] < 42 )
					{
						medals[ index ]++;
						g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "[SCXPM] Tu recompensa ha sido enviada al Modo Normal\n" );
					}
					else if ( medals_h[ index ] < 42 )
					{
						medals_h[ index ]++;
						g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "[SCXPM] Tu recompensa ha sido enviada al Modo Dificil\n" );
					}
					break;
				}
				else if ( mode[ index ] == 2 )
				{
					if ( medals[ index ] < 42 )
						medals[ index ]++;
				}
				else if ( mode[ index ] == 3 )
				{
					if ( medals_h[ index ] < 42 )
						medals_h[ index ]++;
				}
				else if ( mode[ index ] == 4 )
				{
					if ( medals_p[ index ] < maxmedals_p[ index ] )
						medals_p[ index ]++;
				}
				
				break;
			}
			case 101: // Curando el apocalipsis
			{
				g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTCENTER, "Recompensa de logro adquirida!\n\nSuministro Auxiliar [x1]\n" );
				g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "[SCXPM] Enhorabuena! Por completar el logro has recibido \"Suministro Auxiliar\" [x1] como recompensa\n" );
				
				if ( mode[ index ] != 4 )
				{
					if ( sparks[ index ] <= 0 )
						sparks[ index ] = 2;
					else
					{
						if ( sparks[ index ] < 100 )
							sparks[ index ]++;
						else
						{
							bSparkReward[ index ] = true;
							g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "[SCXPM] No puedes llevar mas de 100 Suministros Auxiliares. En su lugar se han convertido en 18,000 EXP\n" );
							xp_h[ index ] += 18000;
							if ( mode[ index ] == 3 ) earnedxp[ index ] += 18000;
						}
					}
				}
				else
				{
					if ( sparks_p[ index ] >= 0 )
					{
						if ( sparks_p[ index ] == 0 )
							sparks_p[ index ] = 2;
						else
						{
							if ( sparks_p[ index ] < 100 )
								sparks_p[ index ]++;
							else
							{
								bSparkReward[ index ] = true;
								g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "[SCXPM] No puedes llevar mas de 100 Suministros Auxiliares. En su lugar se han convertido en 18,000 EXP\n" );
								xp_p[ index ] += 18000;
								earnedxp[ index ] += 18000;
							}
						}
					}
				}
				
				break;
			}
			case 102: // No a la Inflacion
			{
				g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTCENTER, "Recompensa de logro adquirida!\n\nEXP x4 (1 hora)\n" );
				g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "[SCXPM] Enhorabuena! Por completar el logro has recibido \"EXP x4\" [1 hora] como recompensa\n" );
				
				DateTime realduration( UnixTimestamp() );
				TimeDifference extra( 60 * 60 );
				realduration += extra;
				
				expamp[ index ] = 3;
				expamptime[ index ] = realduration;
				
				break;
			}
			case 108: // Carameloraro
			{
				g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTCENTER, "Recompensa de logro adquirida!\n\n5,000 EXP\n" );
				g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "[SCXPM] Enhorabuena! Por completar el logro has recibido \"5,000 EXP\" como recompensa\n" );
				
				if ( mode[ index ] == 1 ) xp_e[ index ] += 5000;
				else if ( mode[ index ] == 2 ) xp[ index ] += 5000;
				else if ( mode[ index ] == 3 ) xp_h[ index ] += 5000;
				else if ( mode[ index ] == 4 ) xp_p[ index ] += 5000;
				earnedxp[ index ] += 5000;
				
				break;
			}
			case 112: // Sinfonia HalfQuake
			{
				g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTCENTER, "Recompensa de logro adquirida!\n\nSuministro Auxiliar [x2]\n" );
				g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "[SCXPM] Enhorabuena! Por completar el logro has recibido \"Suministro Auxiliar\" [x2] como recompensa\n" );
				
				if ( mode[ index ] != 4 )
				{
					if ( sparks[ index ] <= 0 )
						sparks[ index ] = 3;
					else
					{
						sparks[ index ] += 2;
						if ( sparks[ index ] > 100 )
						{
							bSparkReward[ index ] = true;
							
							int iSpareSparks = sparks[ index ] - 100;
							sparks[ index ] = 100;
							int iExtraXP = iSpareSparks * 18000;
							
							g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "[SCXPM] No puedes llevar mas de 100 Suministros Auxiliares. En su lugar se han convertido en " + AddCommas( iExtraXP ) + " EXP\n" );
							xp_h[ index ] += iExtraXP;
							if ( mode[ index ] == 3 ) earnedxp[ index ] += iExtraXP;
						}
					}
				}
				else
				{
					if ( sparks_p[ index ] >= 0 )
					{
						if ( sparks_p[ index ] == 0 )
							sparks[ index ] = 3;
						else
						{
							sparks_p[ index ] += 2;
							if ( sparks_p[ index ] > 100 )
							{
								bSparkReward[ index ] = true;
								
								int iSpareSparks = sparks_p[ index ] - 100;
								sparks_p[ index ] = 100;
								int iExtraXP = iSpareSparks * 18000;
								
								g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "[SCXPM] No puedes llevar mas de 100 Suministros Auxiliares. En su lugar se han convertido en " + AddCommas( iExtraXP ) + " EXP\n" );
								xp_p[ index ] += iExtraXP;
								earnedxp[ index ] += iExtraXP;
							}
						}
					}
				}
				
				break;
			}
			case 113: // Francotirador
			{
				g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTCENTER, "Recompensa de logro adquirida!\n\n1 Medalla\n" );
				g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "[SCXPM] Enhorabuena! Por completar el logro has recibido \"1 Medalla\" como recompensa\n" );
				
				if ( mode[ index ] == 1 )
				{
					// Send them to other mode if possible
					if ( medals[ index ] < 42 )
					{
						medals[ index ]++;
						g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "[SCXPM] Tu recompensa ha sido enviada al Modo Normal\n" );
					}
					else if ( medals_h[ index ] < 42 )
					{
						medals_h[ index ]++;
						g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "[SCXPM] Tu recompensa ha sido enviada al Modo Dificil\n" );
					}
					break;
				}
				else if ( mode[ index ] == 2 )
				{
					if ( medals[ index ] < 42 )
						medals[ index ]++;
				}
				else if ( mode[ index ] == 3 )
				{
					if ( medals_h[ index ] < 42 )
						medals_h[ index ]++;
				}
				else if ( mode[ index ] == 4 )
				{
					if ( medals_p[ index ] < maxmedals_p[ index ] )
						medals_p[ index ]++;
				}
				
				break;
			}
			case 115: // Precision Quadratica
			{
				g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTCENTER, "Recompensa de logro adquirida!\n\n4,444 EXP\n" );
				g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "[SCXPM] Enhorabuena! Por completar el logro has recibido \"4,444 EXP\" como recompensa\n" );
				
				if ( mode[ index ] == 1 ) xp_e[ index ] += 4444;
				else if ( mode[ index ] == 2 ) xp[ index ] += 4444;
				else if ( mode[ index ] == 3 ) xp_h[ index ] += 4444;
				else if ( mode[ index ] == 4 ) xp_p[ index ] += 4444;
				earnedxp[ index ] += 4444;
				
				break;
			}
			case 116: // Distorcion Quadratica
			{
				g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTCENTER, "Recompensa de logro adquirida!\n\n4,444 EXP\n" );
				g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "[SCXPM] Enhorabuena! Por completar el logro has recibido \"4,444 EXP\" como recompensa\n" );
				
				if ( mode[ index ] == 1 ) xp_e[ index ] += 4444;
				else if ( mode[ index ] == 2 ) xp[ index ] += 4444;
				else if ( mode[ index ] == 3 ) xp_h[ index ] += 4444;
				else if ( mode[ index ] == 4 ) xp_p[ index ] += 4444;
				earnedxp[ index ] += 4444;
				
				break;
			}
			case 117: // Dado vuelta
			{
				g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTCENTER, "Recompensa de logro adquirida!\n\n3,000 EXP\n" );
				g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "[SCXPM] Enhorabuena! Por completar el logro has recibido \"3,000 EXP\" como recompensa\n" );
				
				if ( mode[ index ] == 1 ) xp_e[ index ] += 3000;
				else if ( mode[ index ] == 2 ) xp[ index ] += 3000;
				else if ( mode[ index ] == 3 ) xp_h[ index ] += 3000;
				else if ( mode[ index ] == 4 ) xp_p[ index ] += 3000;
				earnedxp[ index ] += 3000;
				
				break;
			}
			case 118: // Defensa Impenetable
			{
				g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTCENTER, "Recompensa de logro adquirida!\n\n6,000 EXP\n" );
				g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "[SCXPM] Enhorabuena! Por completar el logro has recibido \"6,000 EXP\" como recompensa\n" );
				
				if ( mode[ index ] == 1 ) xp_e[ index ] += 6000;
				else if ( mode[ index ] == 2 ) xp[ index ] += 6000;
				else if ( mode[ index ] == 3 ) xp_h[ index ] += 6000;
				else if ( mode[ index ] == 4 ) xp_p[ index ] += 6000;
				earnedxp[ index ] += 6000;
				
				break;
			}
			case 120: // Saltos bipolares
			{
				CustomKeyvalues@ pKVD = pPlayer.GetCustomKeyvalues();
				CustomKeyvalue iUsedCP_pre( pKVD.GetKeyvalue( "$i_used_cp" ) );
				CustomKeyvalue iMapClear_pre( pKVD.GetKeyvalue( "$i_kz_clear" ) );
				int iMapClear = iMapClear_pre.GetInteger();
				int iUsedCP = iUsedCP_pre.GetInteger();
				if ( iUsedCP == 0 && iMapClear == 1 ) // Only give reward if this condition is met
				{
					g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTCENTER, "Recompensa de logro adquirida!\n\n30,000 EXP\n" );
					g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "[SCXPM] Enhorabuena! Por completar el logro has recibido \"30,000 EXP\" como recompensa\n" );
					
					if ( mode[ index ] == 1 ) xp_e[ index ] += 30000;
					else if ( mode[ index ] == 2 ) xp[ index ] += 30000;
					else if ( mode[ index ] == 3 ) xp_h[ index ] += 30000;
					else if ( mode[ index ] == 4 ) xp_p[ index ] += 30000;
					earnedxp[ index ] += 30000;
					
					break;
				}
				else
				{
					// Player must met condition criteria to reedem this reward
					g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "[SCXPM] Para redimir esta recompensa debes completar el mapa sin el uso de CheckPoints\n" );
					
					return; // Don't set aclaim
				}
			}	
			case 121: // Pajaro sin alas
			{
				CustomKeyvalues@ pKVD = pPlayer.GetCustomKeyvalues();
				CustomKeyvalue iUsedCP_pre( pKVD.GetKeyvalue( "$i_used_cp" ) );
				CustomKeyvalue iMapClear_pre( pKVD.GetKeyvalue( "$i_kz_clear" ) );
				int iMapClear = iMapClear_pre.GetInteger();
				int iUsedCP = iUsedCP_pre.GetInteger();
				if ( iUsedCP == 0 && iMapClear == 1 ) // Only give reward if this condition is met
				{
					g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTCENTER, "Recompensa de logro adquirida!\n\n80,000 Puntos Cosmeticos\n" );
					g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "[SCXPM] Enhorabuena! Por completar el logro has recibido \"80,000 Puntos Cosmeticos\" como recompensa\n" );
					
					pKVD.SetKeyvalue( "$i_cp_extra", 80000 );
					
					break;
				}
				else
				{
					// Player must met condition criteria to reedem this reward
					g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "[SCXPM] Para redimir esta recompensa debes completar el mapa sin el uso de CheckPoints\n" );
					
					return; // Don't set aclaim
				}
			}	
			case 122: // Escaleras del diablo
			{
				CustomKeyvalues@ pKVD = pPlayer.GetCustomKeyvalues();
				CustomKeyvalue iUsedCP_pre( pKVD.GetKeyvalue( "$i_used_cp" ) );
				CustomKeyvalue iMapClear_pre( pKVD.GetKeyvalue( "$i_kz_clear" ) );
				int iMapClear = iMapClear_pre.GetInteger();
				int iUsedCP = iUsedCP_pre.GetInteger();
				if ( iUsedCP == 0 && iMapClear == 1 ) // Only give reward if this condition is met
				{
					g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTCENTER, "Recompensa de logro adquirida!\n\nEXP x5 (30 horas) EXP\n" );
					g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "[SCXPM] Enhorabuena! Por completar el logro has recibido \"EXP x5\" [30 horas] como recompensa\n" );
					
					DateTime realduration( UnixTimestamp() );
					TimeDifference extra( 60 * 1800 );
					realduration += extra;
					
					expamp[ index ] = 4;
					expamptime[ index ] = realduration;
					
					break;
				}
				else
				{
					// Player must met condition criteria to reedem this reward
					g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "[SCXPM] Para redimir esta recompensa debes completar el mapa sin el uso de CheckPoints\n" );
					
					return; // Don't set aclaim
				}
			}
			case 124: // Memoria fotografica
			{
				g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTCENTER, "Recompensa de logro adquirida!\n\nSuministro Auxiliar [x3]\n" );
				g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "[SCXPM] Enhorabuena! Por completar el logro has recibido \"Suministro Auxiliar\" [x3] como recompensa\n" );
				
				if ( mode[ index ] != 4 )
				{
					if ( sparks[ index ] <= 0 )
						sparks[ index ] = 4;
					else
					{
						sparks[ index ] += 3;
						if ( sparks[ index ] > 100 )
						{
							bSparkReward[ index ] = true;
							
							int iSpareSparks = sparks[ index ] - 100;
							sparks[ index ] = 100;
							int iExtraXP = iSpareSparks * 18000;
							
							g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "[SCXPM] No puedes llevar mas de 100 Suministros Auxiliares. En su lugar se han convertido en " + AddCommas( iExtraXP ) + " EXP\n" );
							xp_h[ index ] += iExtraXP;
							if ( mode[ index ] == 3 ) earnedxp[ index ] += iExtraXP;
						}
					}
				}
				else
				{
					if ( sparks_p[ index ] >= 0 )
					{
						if ( sparks_p[ index ] == 0 )
							sparks[ index ] = 4;
						else
						{
							sparks_p[ index ] += 3;
							if ( sparks_p[ index ] > 100 )
							{
								bSparkReward[ index ] = true;
								
								int iSpareSparks = sparks_p[ index ] - 100;
								sparks_p[ index ] = 100;
								int iExtraXP = iSpareSparks * 18000;
								
								g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "[SCXPM] No puedes llevar mas de 100 Suministros Auxiliares. En su lugar se han convertido en " + AddCommas( iExtraXP ) + " EXP\n" );
								xp_p[ index ] += iExtraXP;
								earnedxp[ index ] += iExtraXP;
							}
						}
					}
				}
				
				break;
			}
			case 128: // El fin de Andrea
			{
				g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTCENTER, "Recompensa de logro adquirida!\n\nModificador de EXP [+15%]\n" );
				g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "[SCXPM] Enhorabuena! Por completar el logro has recibido \"Modificador de EXP\" [+15%] como recompensa\n" );
				
				AddPermaIncrease( index, "15.0#Escuadron de la Jalea#Logro <El fin de Andrea> adquirido!n!n+15% Ganancia de EXP!n\n" );
				
				break;
			}
			case 130: // Kamikaze Planet
			{
				g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTCENTER, "Recompensa de logro adquirida!\n\nEXP x2 (3 horas)\n" );
				g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "[SCXPM] Enhorabuena! Por completar el logro has recibido \"EXP x2\" [3 horas] como recompensa\n" );
				
				DateTime realduration( UnixTimestamp() );
				TimeDifference extra( 60 * 180 );
				realduration += extra;
				
				expamp[ index ] = 1;
				expamptime[ index ] = realduration;
				
				break;
			}
			case 131: // Cerveza a la Meme
			{
				g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTCENTER, "Recompensa de logro adquirida!\n\n44,444 Puntos Cosmeticos\n" );
				g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "[SCXPM] Enhorabuena! Por completar el logro has recibido \"44,444 Puntos Cosmeticos\" como recompensa\n" );
				
				CustomKeyvalues@ pCustom = pPlayer.GetCustomKeyvalues();
				pCustom.SetKeyvalue( "$i_cp_extra", 44444 );
				
				break;
			}
			case 134: // Trabajo Insoportable
			{
				g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTCENTER, "Recompensa de logro adquirida!\n\n1 Medalla\n" );
				g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "[SCXPM] Enhorabuena! Por completar el logro has recibido \"1 Medalla\" como recompensa\n" );
				
				if ( mode[ index ] == 1 )
				{
					// Send them to other mode if possible
					if ( medals[ index ] < 42 )
					{
						medals[ index ]++;
						g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "[SCXPM] Tu recompensa ha sido enviada al Modo Normal\n" );
					}
					else if ( medals_h[ index ] < 42 )
					{
						medals_h[ index ]++;
						g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "[SCXPM] Tu recompensa ha sido enviada al Modo Dificil\n" );
					}
					break;
				}
				else if ( mode[ index ] == 2 )
				{
					if ( medals[ index ] < 42 )
						medals[ index ]++;
				}
				else if ( mode[ index ] == 3 )
				{
					if ( medals_h[ index ] < 42 )
						medals_h[ index ]++;
				}
				else if ( mode[ index ] == 4 )
				{
					if ( medals_p[ index ] < maxmedals_p[ index ] )
						medals_p[ index ]++;
				}
				
				break;
			}
			case 135: // Menos tedioso, vale?
			{
				g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTCENTER, "Recompensa de logro adquirida!\n\nEXP x3 (1 hora)\n" );
				g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "[SCXPM] Enhorabuena! Por completar el logro has recibido \"EXP x3\" [1 hora] como recompensa\n" );
				
				DateTime realduration( UnixTimestamp() );
				TimeDifference extra( 60 * 60 );
				realduration += extra;
				
				expamp[ index ] = 2;
				expamptime[ index ] = realduration;
				
				break;
			}
			case 139: // accidente de dross numero GTA 5.16
			{
				g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTCENTER, "Recompensa de logro adquirida!\n\n1 Medalla\n" );
				g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "[SCXPM] Enhorabuena! Por completar el logro has recibido \"1 Medalla\" como recompensa\n" );
				
				if ( mode[ index ] == 1 )
				{
					// Send them to other mode if possible
					if ( medals[ index ] < 42 )
					{
						medals[ index ]++;
						g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "[SCXPM] Tu recompensa ha sido enviada al Modo Normal\n" );
					}
					else if ( medals_h[ index ] < 42 )
					{
						medals_h[ index ]++;
						g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "[SCXPM] Tu recompensa ha sido enviada al Modo Dificil\n" );
					}
					break;
				}
				else if ( mode[ index ] == 2 )
				{
					if ( medals[ index ] < 42 )
						medals[ index ]++;
				}
				else if ( mode[ index ] == 3 )
				{
					if ( medals_h[ index ] < 42 )
						medals_h[ index ]++;
				}
				else if ( mode[ index ] == 4 )
				{
					if ( medals_p[ index ] < maxmedals_p[ index ] )
						medals_p[ index ]++;
				}
				
				break;
			}
			case 142: // Fashionable Mecha
			{
				g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTCENTER, "Recompensa de logro adquirida!\n\n4,444 Puntos Cosmeticos\n" );
				g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "[SCXPM] Enhorabuena! Por completar el logro has recibido \"4,444 Puntos Cosmeticos\" como recompensa\n" );
				
				CustomKeyvalues@ pCustom = pPlayer.GetCustomKeyvalues();
				pCustom.SetKeyvalue( "$i_cp_extra", 4444 );
				
				break;
			}
			case 144: // Banio Privado
			{
				g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTCENTER, "Recompensa de logro adquirida!\n\nSuministro Auxiliar [x1]\n" );
				g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "[SCXPM] Enhorabuena! Por completar el logro has recibido \"Suministro Auxiliar\" [x1] como recompensa\n" );
				
				if ( mode[ index ] != 4 )
				{
					if ( sparks[ index ] <= 0 )
						sparks[ index ] = 2;
					else
					{
						if ( sparks[ index ] < 100 )
							sparks[ index ]++;
						else
						{
							bSparkReward[ index ] = true;
							g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "[SCXPM] No puedes llevar mas de 100 Suministros Auxiliares. En su lugar se han convertido en 18,000 EXP\n" );
							xp_h[ index ] += 18000;
							if ( mode[ index ] == 3 ) earnedxp[ index ] += 18000;
						}
					}
				}
				else
				{
					if ( sparks_p[ index ] >= 0 )
					{
						if ( sparks_p[ index ] == 0 )
							sparks_p[ index ] = 2;
						else
						{
							if ( sparks_p[ index ] < 100 )
								sparks_p[ index ]++;
							else
							{
								bSparkReward[ index ] = true;
								g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "[SCXPM] No puedes llevar mas de 100 Suministros Auxiliares. En su lugar se han convertido en 18,000 EXP\n" );
								xp_p[ index ] += 18000;
								earnedxp[ index ] += 18000;
							}
						}
					}
				}
				
				break;
			}
			case 152: // Violacion de Copyright
			{
				g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTCENTER, "Recompensa de logro adquirida!\n\n10,000 EXP\n" );
				g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "[SCXPM] Enhorabuena! Por completar el logro has recibido \"10,000 EXP\" como recompensa\n" );
				
				if ( mode[ index ] == 1 ) xp_e[ index ] += 10000;
				else if ( mode[ index ] == 2 ) xp[ index ] += 10000;
				else if ( mode[ index ] == 3 ) xp_h[ index ] += 10000;
				earnedxp[ index ] += 10000;
				
				break;
			}
			case 154: // Caja de la victoria
			{
				g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTCENTER, "Recompensa de logro adquirida!\n\n1 Medalla\n" );
				g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "[SCXPM] Enhorabuena! Por completar el logro has recibido \"1 Medalla\" como recompensa\n" );
				
				if ( mode[ index ] == 1 )
				{
					// Send them to other mode if possible
					if ( medals[ index ] < 42 )
					{
						medals[ index ]++;
						g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "[SCXPM] Tu recompensa ha sido enviada al Modo Normal\n" );
					}
					else if ( medals_h[ index ] < 42 )
					{
						medals_h[ index ]++;
						g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "[SCXPM] Tu recompensa ha sido enviada al Modo Dificil\n" );
					}
					break;
				}
				else if ( mode[ index ] == 2 )
				{
					if ( medals[ index ] < 42 )
						medals[ index ]++;
				}
				else if ( mode[ index ] == 3 )
				{
					if ( medals_h[ index ] < 42 )
						medals_h[ index ]++;
				}
				else if ( mode[ index ] == 4 )
				{
					if ( medals_p[ index ] < maxmedals_p[ index ] )
						medals_p[ index ]++;
				}
				
				break;
			}
			case 156: // Obligado a Discriminar
			{
				g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTCENTER, "Recompensa de logro adquirida!\n\n30,000 Puntos Cosmeticos\n" );
				g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "[SCXPM] Enhorabuena! Por completar el logro has recibido \"30,000 Puntos Cosmeticos\" como recompensa\n" );
				
				CustomKeyvalues@ pCustom = pPlayer.GetCustomKeyvalues();
				pCustom.SetKeyvalue( "$i_cp_extra", 30000 );
				
				break;
			}
			case 158: // hhhhhhhhhhhhhhh
			{
				g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTCENTER, "Recompensa de logro adquirida!\n\n20,000 EXP\n" );
				g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "[SCXPM] Enhorabuena! Por completar el logro has recibido \"20,000 EXP\" como recompensa\n" );
				
				if ( mode[ index ] == 1 ) xp_e[ index ] += 20000;
				else if ( mode[ index ] == 2 ) xp[ index ] += 20000;
				else if ( mode[ index ] == 3 ) xp_h[ index ] += 20000;
				else if ( mode[ index ] == 4 ) xp_p[ index ] += 20000;
				earnedxp[ index ] += 20000;
				
				break;
			}
			case 160: // ME DUELE EL TECLADO
			{
				CustomKeyvalues@ pKVD = pPlayer.GetCustomKeyvalues();
				CustomKeyvalue iUsedCP_pre( pKVD.GetKeyvalue( "$i_kz_cp" ) );
				CustomKeyvalue iMapClear_pre( pKVD.GetKeyvalue( "$i_kz_clear" ) );
				int iMapClear = iMapClear_pre.GetInteger();
				int iUsedCP = iUsedCP_pre.GetInteger();
				if ( iUsedCP <= 150 && iMapClear == 1 ) // Only give reward if this condition is met
				{
					g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTCENTER, "Recompensa de logro adquirida!\n\n300,000 Puntos Cosmeticos\n" );
					g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "[SCXPM] Enhorabuena! Por completar el logro has recibido \"300,000 Puntos Cosmeticos\" como recompensa\n" );
					
					pKVD.SetKeyvalue( "$i_cp_extra", 300000 );
					
					break;
				}
				else
				{
					// Player must met condition criteria to reedem this reward
					g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "[SCXPM] Para redimir esta recompensa debes completar el mapa con 150 o menos CheckPoints\n" );
					
					return; // Don't set aclaim
				}
			}
			case 163: // Examen Complementario
			{
				g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTCENTER, "Recompensa de logro adquirida!\n\n4,444 EXP\n" );
				g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "[SCXPM] Enhorabuena! Por completar el logro has recibido \"4,444 EXP\" como recompensa\n" );
				
				if ( mode[ index ] == 1 ) xp_e[ index ] += 4444;
				else if ( mode[ index ] == 2 ) xp[ index ] += 4444;
				else if ( mode[ index ] == 3 ) xp_h[ index ] += 4444;
				else if ( mode[ index ] == 4 ) xp_p[ index ] += 4444;
				earnedxp[ index ] += 4444;
				
				break;
			}
			case 166: // Escuadron Suicida
			{
				g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTCENTER, "Recompensa de logro adquirida!\n\nSuministro Auxiliar [x4]\n" );
				g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "[SCXPM] Enhorabuena! Por completar el logro has recibido \"Suministro Auxiliar\" [x4] como recompensa\n" );
				
				if ( mode[ index ] != 4 )
				{
					if ( sparks[ index ] <= 0 )
						sparks[ index ] = 5;
					else
					{
						sparks[ index ] += 4;
						if ( sparks[ index ] > 100 )
						{
							bSparkReward[ index ] = true;
							
							int iSpareSparks = sparks[ index ] - 100;
							sparks[ index ] = 100;
							int iExtraXP = iSpareSparks * 18000;
							
							g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "[SCXPM] No puedes llevar mas de 100 Suministros Auxiliares. En su lugar se han convertido en " + AddCommas( iExtraXP ) + " EXP\n" );
							xp_h[ index ] += iExtraXP;
							if ( mode[ index ] == 3 ) earnedxp[ index ] += iExtraXP;
						}
					}
				}
				else
				{
					if ( sparks_p[ index ] >= 0 )
					{
						if ( sparks_p[ index ] == 0 )
							sparks[ index ] = 5;
						else
						{
							sparks_p[ index ] += 4;
							if ( sparks_p[ index ] > 100 )
							{
								bSparkReward[ index ] = true;
								
								int iSpareSparks = sparks_p[ index ] - 100;
								sparks_p[ index ] = 100;
								int iExtraXP = iSpareSparks * 18000;
								
								g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "[SCXPM] No puedes llevar mas de 100 Suministros Auxiliares. En su lugar se han convertido en " + AddCommas( iExtraXP ) + " EXP\n" );
								xp_p[ index ] += iExtraXP;
								earnedxp[ index ] += iExtraXP;
							}
						}
					}
				}
				
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

/* Post-Game (Champion Mode) stuff */
void scxpm_champion_welcome( const int& in index )
{
	CBasePlayer@ pPlayer = g_PlayerFuncs.FindPlayerByIndex( index );
	MenuHandler@ state = MenuGetPlayer( pPlayer );
	
	state.InitMenu( pPlayer, scxpm_champion_welcome_cb );
	
	// Gather here how many players reached champion status
	string szPath = PATH_POST_DATA + "champions.sys";
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
		thefile.Write( "" + g_EngineFuncs.GetPlayerAuthId( pPlayer.edict() ) + "\n" );
		thefile.Close();
	}
	
	// Now, congratulatory message to the player
	string szTitle = "LO VEO Y NO LO CREO!\n\n";
	
	szTitle += "Eres el jugador #" + ( ++iPlayers ) + " que ha logrado la hazania\n";
	szTitle += "de completar todas las modalidades y coronarse\n";
	szTitle += "Campeon Imperial!\n\n";
	
	szTitle += "Seguramente, tu logro es digno de una recompensa\n";
	szTitle += "Acabe de desbloquear funciones ocultas a tu personaje\n\n";
	
	szTitle += "Intenta ahora completar logros pendientes, o bien\n";
	szTitle += "utiliza la nueva funcion y crea TU nueva aventura!\n\n";
	
	szTitle += "Empezaste a jugar el dia: " + GetSpanishDate( firstplay[ index ] ) + "\n";
	szTitle += "Llegaste a Campeon el dia: " + GetSpanishDate( DateTime( UnixTimestamp() ) ) + "\n";
	
	TimeDifference tdTotalDays( DateTime( UnixTimestamp() ), firstplay[ index ] );
	szTitle += "Eso equivale a: " + tdTotalDays.GetDays() + " dias de juego\n\n";
	
	szTitle += "" + pPlayer.pev.netname + "\n";
	szTitle += "" + g_EngineFuncs.GetPlayerAuthId( pPlayer.edict() ) + "\n\n";
	
	state.menu.SetTitle( szTitle );
	state.menu.AddItem( "Yay!", any( "item1" ) );
	
	state.OpenMenu( pPlayer, 0, 0 );
}

void scxpm_champion_welcome_cb( CTextMenu@ menu, CBasePlayer@ pPlayer, int page, const CTextMenuItem@ item )
{
	// Dummy Callback
}

bool IsChampion( CBasePlayer@ pPlayer )
{
	string szPath = PATH_POST_DATA + "champions.sys";
	File@ thefile = g_FileSystem.OpenFile( szPath, OpenFile::READ );
	
	string szCheck = g_EngineFuncs.GetPlayerAuthId( pPlayer.edict() );
	bool bIsChampion = false;
	if ( thefile !is null && thefile.IsOpen() )
	{
		string szLine;
		while ( !thefile.EOFReached() )
		{
			thefile.ReadLine( szLine );
			if ( szLine == szCheck )
			{
				bIsChampion = true;
				break;
			}
		}
		thefile.Close();
	}
	
	return bIsChampion;
}

// CHAMPION MODE - My SCXPM story through the years...
void Champion_XPHistory( const int& in index )
{
	CBasePlayer@ pPlayer = g_PlayerFuncs.FindPlayerByIndex( index );
	MenuHandler@ state = MenuGetPlayer( pPlayer );
	
	state.InitMenu( pPlayer, Champion_XPHistory_CB );
	
	string szTitle = "Ahhh, mi proyecto de SCXPM...\n\nHa sido todo una carrera. Y un trabajo\nque hoy en dia aun sigo haciendo.\n\n";
	szTitle += "Admitire que este es mi unico proyecto que\naun no se he tirado a la basura, heh.\n\n";
	szTitle += "Voy a contarte la historia de este proyecto.\nDesde sus surgimientos, hasta lo que llego\na ser hoy en dia. Interesado?\n\n";
	
	state.menu.SetTitle( szTitle );
	
	state.menu.AddItem( "Origenes\n", any( "item1" ) );
	state.menu.AddItem( "Diferencias\n", any( "item2" ) );
	state.menu.AddItem( "Primeras actualizaciones", any( "item3" ) );
	
	state.OpenMenu( pPlayer, 0, 0 );
}

void Champion_XPHistory_CB( CTextMenu@ menu, CBasePlayer@ pPlayer, int page, const CTextMenuItem@ item )
{
	int index = pPlayer.entindex();
	if ( page == 10 ) return;
	
	string selection;
	item.m_pUserData.retrieve( selection );
	
	if ( selection == 'item1' )
		g_Scheduler.SetTimeout( "Champion_XPHistory_Chapter01", 0.01, index );
	else if ( selection == 'item2' )
		g_Scheduler.SetTimeout( "Champion_XPHistory_Chapter02", 0.01, index );
	else if ( selection == 'item3' )
		g_Scheduler.SetTimeout( "Champion_XPHistory_Chapter03", 0.01, index );
		
	g_Scheduler.SetTimeout( "Champion_XPHistory", 0.01, index );
}

void Champion_XPHistory_Chapter01( const int& in index )
{
	CBasePlayer@ pPlayer = g_PlayerFuncs.FindPlayerByIndex( index );
	
	string szInfo = "Mi SCXPM ha hecho su primer debut en el Imperium Sven Co-op de comienzos de 2012, en esa epoca Sven Co-op estaba en su version 4.6. ";
	szInfo += "Han cambiado muchas cosas desde entonces, tanto el proyecto de los niveles como el juego si a lo largo de sus actualizaciones.";
	
	szInfo += "\n\nEmpeze a jugar Sven Co-op (y comenzar en esta comunidad) en el 2010, en esa epoca Sven Co-op estaba en su version 4.5. El SCXPM de aquel ";
	szInfo += "entonces era tu clasico sistema de 1,800 niveles: Facil de subir de nivel y la clasica traduccion al castellano que aparece siempre por ahi. ";
	szInfo += "Podria dar enfasis en facilidad de subir de nivel, pero eso era en aquella epoca, hoy en dia la mayoria de servidores SCXPM tienen una facilidad ";
	szInfo += "demasiado absurda que te permite alcanzar el nivel maximo en solamente unos meses. Mientras que en nuestra epoca, yo he estado 1 anio entero y ";
	szInfo += "mi nivel mas alto que he llegado a obtener eran de unos 500 y tanto.";
	
	szInfo += "\n\nSurge el anio 2012. Cuando el servidor fue actualizado a su version 4.6, uno de los directivos de la epoca ha decidido temporalmente eliminar ";
	szInfo += "el SCXPM, hasta que su version personalizada del sistema de niveles este finalizada para su uso. Paralelamente, yo tambien estaba trabajando en ";
	szInfo += "mi version personalizada del SCXPM. Veran, el sistema clasico estaba desbalanceado: Tenia habilidades demasiado fuertes, no tenian limite alguno, ";
	szInfo += "y tenia defectos que los jugadores abusaban para beneficio propio. Todo esto provoco que muchos mapas terminaran arruinandose.";
	
	szInfo += "\n\nInspirandome en varios jugadores y administradores que compartian esta misma vista, empeze mi trabajo. Pero, por cosa del destino, el directivo ";
	szInfo += "ha terminado su version del SCXPM en el mismo dia que yo he finalizado el mio. Yo era un mero Administrador en su momento, los Directivos estaban ";
	szInfo += "por arriba de mi rango. Entre en desesperacion y frustracion, creyendo que mi trabajo fue realizado en vano. Yo, junto con otro directivo, Maiten, ";
	szInfo += "echamos un vistazo rapido al SCXPM del primer directivo.";
	
	szInfo += "\n\nNo nos gusto a simple vista.";
	
	szInfo += "\n\nVale, ambos compartiamos la misma idea de hacer los niveles mas dificiles, pero esto fue una exageracion: La brecha de experiencia necesaria ";
	szInfo += "para subir de nivel no tenia nombre. (Imagina necesitar 10,000+ EXP para subir de nivel, siendo nivel 500) Puntos de vista diferentes hicieron ";
	szInfo += "que la primera impresion de este SCXPM sea desfavorable. En adicion a eso, las medallas fueron eliminadas, y los nombres de las habilidades ";
	szInfo += "fueron renombradas. Saber que hacia cada habilidad era accesible, pero jugadores que no sepan de la existencia del comando de ayuda estarian ";
	szInfo += "completamente confundidos al no saber que habilidad representa cada nombre.";
	
	szInfo += "\n\nEl desacuerdo de Maiten sobre este SCXPM hizo que al menos, me diera la oportunidad de examinar mi version del SCXPM, dandome esperanzas. ";
	szInfo += "Cuando instalo mi version personalizada, tubo una opinion completamente diferente. Al estar bastante cercano a un SCXPM clasico, no confundiria ";
	szInfo += "a los jugadores, y una vez que explique las diferencias, Maiten aprobo mi version del SCXPM y lo ha instalado definitivamente en el servidor.";
	
	szInfo += "\n\nAhi, surgio el origen.";
	
	ShowMOTD( pPlayer, "Capitulo 1: Origenes", szInfo );
}

void Champion_XPHistory_Chapter02( const int& in index )
{
	CBasePlayer@ pPlayer = g_PlayerFuncs.FindPlayerByIndex( index );
	
	string szInfo = "La primera version de mi SCXPM no tenia nada del otro mundo, seguia siendo un SCXPM clasico. Las diferencias que permitieron su aprobacion ";
	szInfo += "fueron meros sutiles cambios. Exactamente que tenia de diferente mi SCXPM comparado con su version clasica?";
	
	szInfo += "\n\nTodo estaba cortado a la mitad, y literalmente eso era todo mi SCXPM de aquella epoca xD!";
	
	szInfo += "\n\nSi, todo a la mitad. El nivel maximo era 900, la capacidad maxima de todas las habilidades fueron cortadas a la mitad, y hasta la Ganancia de ";
	szInfo += "EXP fue cortado a la mitad. Eso solo era la primera version de mi SCXPM. Habia otras diferencias sutiles como la eliminacion de la regeneracion de ";
	szInfo += "baterias (Si, literalmente regenerabas armadura de golpe) con la Shock Roach, o bien que regenere balas al azar con la Minigun y otras armas. Ah! ";
	szInfo += "Recuerdo que las medallas en su momento carecian de uso, y lo modifique para que uno comienze con 0, en lugar de 3 como hacen casi todos. ";
	szInfo += "Mi memoria ya no funciona a partir de este punto por lo que cualquier otro cambio que estaba presente en aquel entonces ya se ha perdido en el tiempo.";
	
	szInfo += "\n\nUno podria decir que aun con estos cambios seguiria desbalanceado (Lo estaba). Pero, al menos, ya no importaba. Cuando se instalo mi SCXPM ";
	szInfo += "todos los jugadores (nosotros inclusive) regresaron a Nivel 0. Y durante bastante tiempo todo estubo suficientemente balanceado: La baja Ganancia ";
	szInfo += "de EXP impidia que los jugadores se volvieran muy fuertes en un corto plazo de tiempo, y la reduccion de las habilidades a la mitad logro eliminar ";
	szInfo += "el problema de los mapas perdiendo su chiste.";
	
	szInfo += "\n\nDe todas maneras, en aquellas epocas los jugadores eran muy diferentes a como son ahora. La necesidad de editar masivamente el servidor ";
	szInfo += "no era necesario, y todos apuntabamos a lo \"simple\". Me encantaria delirar en como era ISC en el pasado pero si lo hago, estas ventanas MOTD ";
	szInfo += "se volverian demasiado grandes y el texto se terminaria cortando prematuramente. Bah! Limitaciones del motor GoldSrc en 2018...";
	
	ShowMOTD( pPlayer, "Capitulo 2: Diferencias", szInfo );
}

void Champion_XPHistory_Chapter03( const int& in index )
{
	CBasePlayer@ pPlayer = g_PlayerFuncs.FindPlayerByIndex( index );
	
	string szInfo = "La primera actualizacion del SCXPM surgio en el mapa The Arena, otro de mis proyectos (Yay! Self-Inserts!). Y ocurrio por ";
	szInfo += "un imprevisto la cual no habia pensado: La regeneracion de granadas de M16. Al darme cuenta, elimine de inmediato esa ";
	szInfo += "caracteristica, ya que el mapa no usa granadas y romperia el balance del mapa. Tambien me hizo pensar en cuantos mapas ";
	szInfo += "tendrian su funcionamiento afectado por estos explosivos, o bien que estos se vuelvan demasiado faciles. Eso fomento su ";
	szInfo += "eliminacion. La regeneracion de granadas M16 eventualmente revivio en el futuro bajo la habilidad especial que tu conoces hoy ";
	szInfo += "en dia como \"Demoledor\"";
	
	szInfo += "\n\nSin embargo, aquello que he dicho fue el unico cambio que hice, y lo llame actualizacion. GG!";
	
	szInfo += "Era solo un novato! Y esto lo puedo enfatizar en la segunda actualizacion, el cual he hecho bastante copypaste sin entender que diantres ";
	szInfo += "era lo que estaba haciendo. Hasta que me puse a trabajar por cuenta propia y hacerlo andar. EEENNN FFFIIINNN... La segunda actualizacion ";
	szInfo += "surgio por......... por......... Mierda, ya no me acuerdo.";
	
	ShowMOTD( pPlayer, "Capitulo 3: Primeras actualizaciones", szInfo );
}

// CHAMPION MODE - Custom Game Mode
void Champion_SandboxMenu( const int& in index )
{
	CBasePlayer@ pPlayer = g_PlayerFuncs.FindPlayerByIndex( index );
	MenuHandler@ state = MenuGetPlayer( pPlayer );
	
	state.InitMenu( pPlayer, Champion_SandboxMenu_CB );
	
	string szTitle = "Modo Sandbox\n\nNivel " + AddCommas( scxpm_calc_lvl( xp_p[ index ] ) ) + "\n";	
	if ( maxmedals_p[ index ] > 0 ) szTitle += "" + medals_p[ index ] + " Medallas\n";
	
	state.menu.SetTitle( szTitle );
	
	if ( xp_p[ index ] > 0 )
		state.menu.AddItem( "Continuar\n", any( "item1" ) );
	
	state.menu.AddItem( "Nueva partida\n", any( "item2" ) );
	
	if ( xp_p[ index ] > 0 )
		state.menu.AddItem( "Informacion de la partida actual\n", any( "item3" ) );
	
	state.OpenMenu( pPlayer, 0, 0 );
}

void Champion_SandboxMenu_CB( CTextMenu@ menu, CBasePlayer@ pPlayer, int page, const CTextMenuItem@ item )
{
	int index = pPlayer.entindex();
	if ( page == 10 ) return;
	
	string selection;
	item.m_pUserData.retrieve( selection );
	
	if ( selection == 'item1' )
	{
		if ( mode[ index ] == 4 )
			g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "[SCXPM] Ya estas en Modo Sandbox\n" );
		else
		{
			if ( maxlevel_p[ index ] != -1 )
			{
				g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "[SCXPM] Cambiaste tu modalidad a Modo Sandbox. Recuerda volver a elegir tus habilidades\n" );
				mode[ index ] = 4;
				playerlevel[ index ] = scxpm_calc_lvl( xp_p[ index ] );
				scxpm_calcneedxp( index );
				earnedxp[ index ] = 0;
				g_Scheduler.SetTimeout( "scxpm_mreset", 0.75, index );
				
				if ( pPlayer.pev.deadflag == DEAD_NO )
				{
					// Manual force-kill
					pPlayer.pev.solid = SOLID_NOT;
					pPlayer.GibMonster();
					pPlayer.pev.effects |= EF_NODRAW;
					pPlayer.pev.health = 0;
					pPlayer.pev.deadflag = DEAD_DEAD;
				}
				
				// Custom death message, let people know his cause of death
				string szDeathMsg = "" + pPlayer.pev.netname + " switched to Sandbox Mode.\n";
				
				NetworkMessage deathmsg( MSG_ALL, NetworkMessages::TextMsg );
				deathmsg.WriteByte( 1 );
				deathmsg.WriteString( szDeathMsg );
				deathmsg.End();
				
				// Set this bit. We do not want abuse
				bChangeHard[ index ] = true;
				
				// If the player was spectating, turn off the respawn delay
				if ( bIsSpectating[ index ] )
				{
					bIsSpectating[ index ] = false;
					pPlayer.m_flRespawnDelayTime = 0.0;
				}
			}
			else
			{
				g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "[SCXPM] Has perdido la partida y ya no puedes continuar\n" );
				g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "[SCXPM] No tienes otra opcion mas que borrar tu partida y empezar una nueva\n" );
				g_Scheduler.SetTimeout( "Champion_SandboxMenu", 0.01, index );
			}
		}
	}
	else if ( selection == 'item2' )
	{
		if ( mode[ index ] == 4 || xp_p[ index ] > 0 )
			g_Scheduler.SetTimeout( "Champion_SandboxConfirmReset", 0.01, index );
		else
			g_Scheduler.SetTimeout( "Champion_SandboxNewGame_Init", 0.01, index );
	}
	else if ( selection == 'item3' )
	{
		Champion_SandboxShowCurrent( index );
		g_Scheduler.SetTimeout( "Champion_SandboxMenu", 0.01, index );
	}
}

void Champion_SandboxConfirmReset( const int& in index )
{
	CBasePlayer@ pPlayer = g_PlayerFuncs.FindPlayerByIndex( index );
	MenuHandler@ state = MenuGetPlayer( pPlayer );
	
	state.InitMenu( pPlayer, Champion_SandboxConfirmReset_CB );
	
	string szTitle = "Estas seguro que deseas borrar tus datos\ndel Modo Sandbox y empezar una nueva partida?\n\n";	
	szTitle += "Seras regresado al Modo Normal mientras\nconfiguras los ajustes de la nueva partida\n\n";
	
	state.menu.SetTitle( szTitle );
	
	state.menu.AddItem( "Si\n", any( "item1" ) );
	state.menu.AddItem( "No\n", any( "item2" ) );
	
	state.OpenMenu( pPlayer, 0, 0 );
}

void Champion_SandboxConfirmReset_CB( CTextMenu@ menu, CBasePlayer@ pPlayer, int page, const CTextMenuItem@ item )
{
	int index = pPlayer.entindex();
	if ( page == 10 ) return;
	
	string selection;
	item.m_pUserData.retrieve( selection );
	
	if ( selection == 'item1' )
	{
		mode[ index ] = 2;
		playerlevel[ index ] = scxpm_calc_lvl( xp[ index ] );
		scxpm_calcneedxp( index );
		scxpm_getrank( index );
		earnedxp[ index ] = 0;
		g_Scheduler.SetTimeout( "scxpm_mreset", 0.75, index );
		
		if ( pPlayer.pev.deadflag == DEAD_NO )
		{
			// Manual force-kill
			pPlayer.pev.solid = SOLID_NOT;
			pPlayer.GibMonster();
			pPlayer.pev.effects |= EF_NODRAW;
			pPlayer.pev.health = 0;
			pPlayer.pev.deadflag = DEAD_DEAD;
		}
		
		// Custom death message, let people know his cause of death
		string szDeathMsg = "" + pPlayer.pev.netname + " switched to Normal Mode.\n";
		
		NetworkMessage deathmsg( MSG_ALL, NetworkMessages::TextMsg );
		deathmsg.WriteByte( 1 );
		deathmsg.WriteString( szDeathMsg );
		deathmsg.End();
		
		// If the player was spectating, turn off the respawn delay
		if ( bIsSpectating[ index ] )
		{
			bIsSpectating[ index ] = false;
			pPlayer.m_flRespawnDelayTime = 0.0;
		}
		
		g_Scheduler.SetTimeout( "Champion_SandboxNewGame_Init", 0.01, index );
	}
	else if ( selection == 'item2' )
		g_Scheduler.SetTimeout( "Champion_SandboxMenu", 0.01, index );
}

void Champion_SandboxNewGame_Init( const int& in index )
{
	CBasePlayer@ pPlayer = g_PlayerFuncs.FindPlayerByIndex( index );
	
	xp_p[ index ] = 0;
	medals_p[ index ] = 0;
	sparks_p[ index ] = -1;
	startlevel_p[ index ] = 0;
	maxlevel_p[ index ] = -1;
	startmedals_p[ index ] = 0;
	maxmedals_p[ index ] = 0;
	xpgain_p[ index ] = 0.0;
	health_max_p[ index ] = 0;
	armor_max_p[ index ] = 0;
	rhealth_max_p[ index ] = 0;
	rarmor_max_p[ index ] = 0;
	rammo_max_p[ index ] = 0;
	gravity_max_p[ index ] = 0;
	speed_max_p[ index ] = 0;
	dist_max_p[ index ] = 0;
	dodge_max_p[ index ] = 0;
	spawndmg_max_p[ index ] = 0;
	ubercharge_max_p[ index ] = 0;
	freefall_max_p[ index ] = 0;
	demoman_max_p[ index ] = 0;
	practiceshot_max_p[ index ] = 0;
	bioelectric_max_p[ index ] = 0;
	redcross_max_p[ index ] = 0;
	
	g_Scheduler.SetTimeout( "Champion_SandboxNewGame", 0.01, index );
}

void Champion_SandboxNewGame( const int& in index )
{
	CBasePlayer@ pPlayer = g_PlayerFuncs.FindPlayerByIndex( index );
	MenuHandler@ state = MenuGetPlayer( pPlayer );
	
	state.InitMenu( pPlayer, Champion_SandboxNewGame_CB );
	
	string szTitle = "Nueva partida\nElegir configuracion predeterminada\n\n";
	state.menu.SetTitle( szTitle );
	
	state.menu.AddItem( "Minimalista", any( "item1" ) );
	state.menu.AddItem( "Survival", any( "item2" ) );
	state.menu.AddItem( "Blitz", any( "item3" ) );
	state.menu.AddItem( "Ultrapoder", any( "item4" ) );
	state.menu.AddItem( "Especial\n", any( "item5" ) );
	state.menu.AddItem( "Personalizar partida\n", any( "item6" ) );
	
	state.OpenMenu( pPlayer, 0, 0 );
}

void Champion_SandboxNewGame_CB( CTextMenu@ menu, CBasePlayer@ pPlayer, int page, const CTextMenuItem@ item )
{
	int index = pPlayer.entindex();
	if ( page == 10 ) return;
	
	string selection;
	item.m_pUserData.retrieve( selection );
	
	if ( selection == 'item1' )
	{
		Champion_SandboxInfo_Minimal( index );
		
		startlevel_p[ index ] = 0;
		maxlevel_p[ index ] = 100;
		
		startmedals_p[ index ] = 0;
		maxmedals_p[ index ] = 0;
		
		sparks_p[ index ] = -1;
		
		xpgain_p[ index ] = 0.15;
		
		health_max_p[ index ] = 20;
		armor_max_p[ index ] = 15;
		rhealth_max_p[ index ] = 15;
		rarmor_max_p[ index ] = 15;
		rammo_max_p[ index ] = 10;
		gravity_max_p[ index ] = 5;
		speed_max_p[ index ] = 10;
		dist_max_p[ index ] = 10;
		dodge_max_p[ index ] = 0;
		
		spawndmg_max_p[ index ] = 0;
		ubercharge_max_p[ index ] = 0;
		freefall_max_p[ index ] = 0;
		demoman_max_p[ index ] = 0;
		practiceshot_max_p[ index ] = 0;
		bioelectric_max_p[ index ] = 0;
		redcross_max_p[ index ] = 0;
		
		g_Scheduler.SetTimeout( "Champion_SandboxNewGame_Confirm", 0.01, index );
	}
	else if ( selection == 'item2' )
	{
		Champion_SandboxInfo_Survival( index );
		
		startlevel_p[ index ] = 0;
		maxlevel_p[ index ] = 208;
		
		startmedals_p[ index ] = 0;
		maxmedals_p[ index ] = 7;
		
		sparks_p[ index ] = 3;
		
		xpgain_p[ index ] = 0.75;
		
		health_max_p[ index ] = 100;
		armor_max_p[ index ] = 25;
		rhealth_max_p[ index ] = 10;
		rarmor_max_p[ index ] = 5;
		rammo_max_p[ index ] = 15;
		gravity_max_p[ index ] = 10;
		speed_max_p[ index ] = 15;
		dist_max_p[ index ] = 20;
		dodge_max_p[ index ] = 8;
		
		spawndmg_max_p[ index ] = 7;
		ubercharge_max_p[ index ] = 7;
		freefall_max_p[ index ] = 7;
		demoman_max_p[ index ] = 7;
		practiceshot_max_p[ index ] = 7;
		bioelectric_max_p[ index ] = 7;
		redcross_max_p[ index ] = 7;
		
		g_Scheduler.SetTimeout( "Champion_SandboxNewGame_Confirm", 0.01, index );
	}
	else if ( selection == 'item3' )
	{
		Champion_SandboxInfo_Blitz( index );
		
		startlevel_p[ index ] = 0;
		maxlevel_p[ index ] = 600;
		
		startmedals_p[ index ] = 0;
		maxmedals_p[ index ] = 42;
		
		sparks_p[ index ] = -1;
		
		xpgain_p[ index ] = 5.00;
		
		health_max_p[ index ] = 130;
		armor_max_p[ index ] = 130;
		rhealth_max_p[ index ] = 100;
		rarmor_max_p[ index ] = 100;
		rammo_max_p[ index ] = 20;
		gravity_max_p[ index ] = 20;
		speed_max_p[ index ] = 50;
		dist_max_p[ index ] = 30;
		dodge_max_p[ index ] = 20;
		
		spawndmg_max_p[ index ] = 40;
		ubercharge_max_p[ index ] = 0;
		freefall_max_p[ index ] = 10;
		demoman_max_p[ index ] = 10;
		practiceshot_max_p[ index ] = 10;
		bioelectric_max_p[ index ] = 0;
		redcross_max_p[ index ] = 0;
		
		g_Scheduler.SetTimeout( "Champion_SandboxNewGame_Confirm", 0.01, index );
	}
	else if ( selection == 'item4' )
	{
		Champion_SandboxInfo_Ultrapower( index );
		
		startlevel_p[ index ] = 0;
		maxlevel_p[ index ] = 999;
		
		startmedals_p[ index ] = 0;
		maxmedals_p[ index ] = 99;
		
		sparks_p[ index ] = -1;
		
		xpgain_p[ index ] = 1.00;
		
		health_max_p[ index ] = 999;
		armor_max_p[ index ] = 999;
		rhealth_max_p[ index ] = 999;
		rarmor_max_p[ index ] = 999;
		rammo_max_p[ index ] = 99;
		gravity_max_p[ index ] = 99;
		speed_max_p[ index ] = 99;
		dist_max_p[ index ] = 99;
		dodge_max_p[ index ] = 99;
		
		spawndmg_max_p[ index ] = 99;
		ubercharge_max_p[ index ] = 0;
		freefall_max_p[ index ] = 99;
		demoman_max_p[ index ] = 99;
		practiceshot_max_p[ index ] = 99;
		bioelectric_max_p[ index ] = 99;
		redcross_max_p[ index ] = 99;
		
		g_Scheduler.SetTimeout( "Champion_SandboxNewGame_Confirm", 0.01, index );
	}
	else if ( selection == 'item5' )
	{
		Champion_SandboxInfo_Special( index );
		
		startlevel_p[ index ] = 0;
		maxlevel_p[ index ] = 583;
		
		startmedals_p[ index ] = 0;
		maxmedals_p[ index ] = 62;
		
		sparks_p[ index ] = -1;
		
		xpgain_p[ index ] = 2.00;
		
		health_max_p[ index ] = 0;
		armor_max_p[ index ] = 0;
		rhealth_max_p[ index ] = 0;
		rarmor_max_p[ index ] = 0;
		rammo_max_p[ index ] = 1;
		gravity_max_p[ index ] = 0;
		speed_max_p[ index ] = 0;
		dist_max_p[ index ] = 0;
		dodge_max_p[ index ] = 0;
		
		spawndmg_max_p[ index ] = 10;
		ubercharge_max_p[ index ] = 0;
		freefall_max_p[ index ] = 10;
		demoman_max_p[ index ] = 10;
		practiceshot_max_p[ index ] = 10;
		bioelectric_max_p[ index ] = 10;
		redcross_max_p[ index ] = 10;
		
		g_Scheduler.SetTimeout( "Champion_SandboxNewGame_Confirm", 0.01, index );
	}
	else if ( selection == 'item6' )
	{
		g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTCENTER, "Funcion aun no implementada\n" );
		g_Scheduler.SetTimeout( "Champion_SandboxNewGame", 0.01, index );
	}
}

void Champion_SandboxInfo_Minimal( const int& in index )
{
	CBasePlayer@ pPlayer = g_PlayerFuncs.FindPlayerByIndex( index );
	
	string szInfo = "Esta configuracion ajusta los aspectos del SCXPM al minimo, ideal si no deseas que las habilidades cambien la dificultad de los mapas\n\n";
	
	szInfo += "- Nivel Inicial: 0\n";
	szInfo += "- Nivel Maximo: 100\n\n";
	
	szInfo += "- Medallas DESACTIVADAS\n\n";
	
	szInfo += "- Ganancia de EXP: x0.15\n\n";
	
	szInfo += "- Suministros Auxiliares INACTIVOS\n\n";
	
	szInfo += "MAXIMO DE HABILIDADES:\n\n";
	
	szInfo += "- Vida Inicial: 20\n";
	szInfo += "- Armor Inicial: 15\n";
	szInfo += "- Regeneracion de Vida: 15\n";
	szInfo += "- Regeneracion de Armor: 15\n";
	szInfo += "- Regeneracion de Balas: 10\n";
	szInfo += "- Anti-Gravedad: 5\n";
	szInfo += "- Conocimiento: 10\n";
	szInfo += "- Poder de Equipo: 10\n";
	szInfo += "- Bloqueo de Ataques: 0\n\n";
	
	szInfo += " ";
	ShowMOTD( pPlayer, "Configuracion Minimalista", szInfo );
}

void Champion_SandboxInfo_Survival( const int& in index )
{
	CBasePlayer@ pPlayer = g_PlayerFuncs.FindPlayerByIndex( index );
	
	string szInfo = "Esta configuracion es un escenario <what-if>. Si este servidor con SCXPM tubiese Survival activado en todo momento, este se veria asi...\n\n";
	
	szInfo += "- Nivel Inicial: 0\n";
	szInfo += "- Nivel Maximo: 208\n\n";
	
	szInfo += "- Medallas Iniciales: 0\n";
	szInfo += "- Medallas Maximas: 7\n\n";
	
	szInfo += "- Ganancia de EXP: x0.75\n\n";
	
	szInfo += "- Suministros Auxiliares ACTIVOS\n\n";
	
	szInfo += "MAXIMO DE HABILIDADES:\n\n";
	
	szInfo += "- Vida Inicial: 100\n";
	szInfo += "- Armor Inicial: 25\n";
	szInfo += "- Regeneracion de Vida: 10\n";
	szInfo += "- Regeneracion de Armor: 5\n";
	szInfo += "- Regeneracion de Balas: 15\n";
	szInfo += "- Anti-Gravedad: 10\n";
	szInfo += "- Conocimiento: 15\n";
	szInfo += "- Poder de Equipo: 20\n";
	szInfo += "- Bloqueo de Ataques: 8\n\n";
	
	szInfo += "- Golpe Inicial: 7\n";
	szInfo += "- Sobrecarga: 7\n";
	szInfo += "- Caida Libre: 7\n";
	szInfo += "- Demoledor: 7\n";
	szInfo += "- Tiro de Practica: 7\n";
	szInfo += "- BioElectricista: 7\n";
	szInfo += "- Cruz Roja: 7\n\n";
	
	szInfo += " ";
	ShowMOTD( pPlayer, "Configuracion Survival", szInfo );
}

void Champion_SandboxInfo_Blitz( const int& in index )
{
	CBasePlayer@ pPlayer = g_PlayerFuncs.FindPlayerByIndex( index );
	
	string szInfo = "SCXPM ultrarapido para subir de nivel a mansalva. Si es ese tu estilo, claro\n\n";
	
	szInfo += "- Nivel Inicial: 0\n";
	szInfo += "- Nivel Maximo: 600\n\n";
	
	szInfo += "- Medallas Iniciales: 0\n";
	szInfo += "- Medallas Maximas: 42\n\n";
	
	szInfo += "- Ganancia de EXP: x5.00\n\n";
	
	szInfo += "- Suministros Auxiliares INACTIVOS\n\n";
	
	szInfo += "MAXIMO DE HABILIDADES:\n\n";
	
	szInfo += "- Vida Inicial: 130\n";
	szInfo += "- Armor Inicial: 130\n";
	szInfo += "- Regeneracion de Vida: 100\n";
	szInfo += "- Regeneracion de Armor: 100\n";
	szInfo += "- Regeneracion de Balas: 20\n";
	szInfo += "- Anti-Gravedad: 20\n";
	szInfo += "- Conocimiento: 50\n";
	szInfo += "- Poder de Equipo: 30\n";
	szInfo += "- Bloqueo de Ataques: 20\n\n";
	
	szInfo += "- Golpe Inicial: 40\n";
	szInfo += "- Sobrecarga: 0\n";
	szInfo += "- Caida Libre: 10\n";
	szInfo += "- Demoledor: 10\n";
	szInfo += "- Tiro de Practica: 10\n";
	szInfo += "- BioElectricista: 0\n";
	szInfo += "- Cruz Roja: 0\n\n";
	
	szInfo += " ";
	ShowMOTD( pPlayer, "Configuracion Blitz", szInfo );
}

void Champion_SandboxInfo_Ultrapower( const int& in index )
{
	CBasePlayer@ pPlayer = g_PlayerFuncs.FindPlayerByIndex( index );
	
	string szInfo = "Configuracion que elimina todo limite a las habilidades del SCXPM. Que ocurre si vas mas alla de lo que el SCXPM puede aguantar...?\n\n";
	
	szInfo += "- Nivel Inicial: 0\n";
	szInfo += "- Nivel Maximo: 999\n\n";
	
	szInfo += "- Medallas Iniciales: 0\n";
	szInfo += "- Medallas Maximas: 99\n\n";
	
	szInfo += "- Ganancia de EXP: x1.00\n\n";
	
	szInfo += "- Suministros Auxiliares INACTIVOS\n\n";
	
	szInfo += "MAXIMO DE HABILIDADES:\n\n";
	
	szInfo += "- Vida Inicial: 999\n";
	szInfo += "- Armor Inicial: 999\n";
	szInfo += "- Regeneracion de Vida: 999\n";
	szInfo += "- Regeneracion de Armor: 999\n";
	szInfo += "- Regeneracion de Balas: 99\n";
	szInfo += "- Anti-Gravedad: 99\n";
	szInfo += "- Conocimiento: 99\n";
	szInfo += "- Poder de Equipo: 99\n";
	szInfo += "- Bloqueo de Ataques: 99\n\n";
	
	szInfo += "- Golpe Inicial: 99\n";
	szInfo += "- Sobrecarga: 0\n";
	szInfo += "- Caida Libre: 99\n";
	szInfo += "- Demoledor: 99\n";
	szInfo += "- Tiro de Practica: 99\n";
	szInfo += "- BioElectricista: 99\n";
	szInfo += "- Cruz Roja: 99\n\n";
	
	szInfo += " ";
	ShowMOTD( pPlayer, "Configuracion Ultrapoder", szInfo );
}

void Champion_SandboxInfo_Special( const int& in index )
{
	CBasePlayer@ pPlayer = g_PlayerFuncs.FindPlayerByIndex( index );
	
	string szInfo = "Una configuracion donde solamente las Medallas y las Habilidades Especiales toman prioridad\n\n";
	
	szInfo += "- Nivel Inicial: 0\n";
	szInfo += "- Nivel Maximo: 583\n\n";
	
	szInfo += "- Medallas Iniciales: 0\n";
	szInfo += "- Medallas Maximas: 62\n\n";
	
	szInfo += "- Ganancia de EXP: x2.00\n\n";
	
	szInfo += "- Suministros Auxiliares INACTIVOS\n\n";
	
	szInfo += "MAXIMO DE HABILIDADES:\n\n";
	
	szInfo += "- Vida Inicial: 0\n";
	szInfo += "- Armor Inicial: 0\n";
	szInfo += "- Regeneracion de Vida: 0\n";
	szInfo += "- Regeneracion de Armor: 0\n";
	szInfo += "- Regeneracion de Balas: 1\n";
	szInfo += "- Anti-Gravedad: 0\n";
	szInfo += "- Conocimiento: 0\n";
	szInfo += "- Poder de Equipo: 0\n";
	szInfo += "- Bloqueo de Ataques: 0\n\n";
	
	szInfo += "- Golpe Inicial: 10\n";
	szInfo += "- Sobrecarga: 0\n";
	szInfo += "- Caida Libre: 10\n";
	szInfo += "- Demoledor: 10\n";
	szInfo += "- Tiro de Practica: 10\n";
	szInfo += "- BioElectricista: 10\n";
	szInfo += "- Cruz Roja: 10\n\n";
	
	szInfo += " ";
	ShowMOTD( pPlayer, "Configuracion Especial", szInfo );
}

void Champion_SandboxNewGame_Confirm( const int& in index )
{
	CBasePlayer@ pPlayer = g_PlayerFuncs.FindPlayerByIndex( index );
	MenuHandler@ state = MenuGetPlayer( pPlayer );
	
	state.InitMenu( pPlayer, Champion_SandboxNewGame_Confirm_CB );
	
	string szTitle = "Comenzar una nueva partida del Modo Sandbox\ncon las configuraciones actuales?\n\n";	
	
	state.menu.SetTitle( szTitle );
	
	state.menu.AddItem( "Si\n", any( "item1" ) );
	state.menu.AddItem( "No\n", any( "item2" ) );
	
	state.OpenMenu( pPlayer, 0, 0 );
}

void Champion_SandboxNewGame_Confirm_CB( CTextMenu@ menu, CBasePlayer@ pPlayer, int page, const CTextMenuItem@ item )
{
	int index = pPlayer.entindex();
	if ( page == 10 ) return;
	
	string selection;
	item.m_pUserData.retrieve( selection );
	
	if ( selection == 'item1' )
	{
		g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "[SCXPM] Cambiaste tu modalidad a Modo Sandbox. Recuerda volver a elegir tus habilidades\n" );
		mode[ index ] = 4;
		playerlevel[ index ] = scxpm_calc_lvl( xp_p[ index ] );
		scxpm_calcneedxp( index );
		earnedxp[ index ] = 0;
		g_Scheduler.SetTimeout( "scxpm_mreset", 0.75, index );
		
		if ( pPlayer.pev.deadflag == DEAD_NO )
		{
			// Manual force-kill
			pPlayer.pev.solid = SOLID_NOT;
			pPlayer.GibMonster();
			pPlayer.pev.effects |= EF_NODRAW;
			pPlayer.pev.health = 0;
			pPlayer.pev.deadflag = DEAD_DEAD;
		}
		
		// Custom death message, let people know his cause of death
		string szDeathMsg = "" + pPlayer.pev.netname + " switched to Sandbox Mode.\n";
		
		NetworkMessage deathmsg( MSG_ALL, NetworkMessages::TextMsg );
		deathmsg.WriteByte( 1 );
		deathmsg.WriteString( szDeathMsg );
		deathmsg.End();
		
		// Set this bit. We do not want abuse
		bChangeHard[ index ] = true;
		
		// If the player was spectating, turn off the respawn delay
		if ( bIsSpectating[ index ] )
		{
			bIsSpectating[ index ] = false;
			pPlayer.m_flRespawnDelayTime = 0.0;
		}
	}
	else if ( selection == 'item2' )
		g_Scheduler.SetTimeout( "Champion_SandboxMenu", 0.01, index );
}

void Champion_SandboxShowCurrent( const int& in index )
{
	CBasePlayer@ pPlayer = g_PlayerFuncs.FindPlayerByIndex( index );
	
	string szInfo = "La partida actual del Modo Sandbox esta configurado con los siguientes ajustes:\n\n";
	
	szInfo += "- Nivel Inicial: " + startlevel_p[ index ] + "\n";
	szInfo += "- Nivel Maximo: " + maxlevel_p[ index ] + "\n\n";
	
	if ( maxmedals_p[ index ] > 0 )
	{
		szInfo += "- Medallas Iniciales: " + startmedals_p[ index ] + "\n";
		szInfo += "- Medallas Maximas: " + maxmedals_p[ index ] + "\n\n";
	}
	else
		szInfo += "- Medallas DESACTIVADAS\n\n";
	
	szInfo += "- Ganancia de EXP: x" + fl2Decimals( xpgain_p[ index ] ) + "\n\n";
	
	if ( sparks_p[ index ] >= 0 )
		szInfo += "- Suministros Auxiliares ACTIVOS\n\n";
	else
		szInfo += "- Suministros Auxiliares INACTIVOS\n\n";
	
	szInfo += "MAXIMO DE HABILIDADES:\n\n";
	
	szInfo += "- Vida Inicial: " + health_max_p[ index ] + "\n";
	szInfo += "- Armor Inicial: " + armor_max_p[ index ] + "\n";
	szInfo += "- Regeneracion de Vida: " + rhealth_max_p[ index ] + "\n";
	szInfo += "- Regeneracion de Armor: " + rarmor_max_p[ index ] + "\n";
	szInfo += "- Regeneracion de Balas: " + rammo_max_p[ index ] + "\n";
	szInfo += "- Anti-Gravedad: " + gravity_max_p[ index ] + "\n";
	szInfo += "- Conocimiento: " + speed_max_p[ index ] + "\n";
	szInfo += "- Poder de Equipo: " + dist_max_p[ index ] + "\n";
	szInfo += "- Bloqueo de Ataques: " + dodge_max_p[ index ] + "\n\n";
	
	if ( maxmedals_p[ index ] > 0 )
	{
		szInfo += "- Golpe Inicial: " + spawndmg_max_p[ index ] + "\n";
		szInfo += "- Sobrecarga: " + ubercharge_max_p[ index ] + "\n";
		szInfo += "- Caida Libre: " + freefall_max_p[ index ] + "\n";
		szInfo += "- Demoledor: " + demoman_max_p[ index ] + "\n";
		szInfo += "- Tiro de Practica: " + practiceshot_max_p[ index ] + "\n";
		szInfo += "- BioElectricista: " + bioelectric_max_p[ index ] + "\n";
		szInfo += "- Cruz Roja: " + redcross_max_p[ index ] + "\n\n";
	}
	
	szInfo += " ";
	ShowMOTD( pPlayer, "Configuracion del Sandbox", szInfo );
}

// CHAMPION MODE - Save/Load
void Champion_SaveSandboxData( const int& in index )
{
	CBasePlayer@ pPlayer = g_PlayerFuncs.FindPlayerByIndex( index );
	
	if ( loaddata[ index ] )
	{
		string fullpath = "" + PATH_POST_DATA + "S_" + g_EngineFuncs.GetPlayerAuthId( pPlayer.edict() ) + ".data";
		fullpath.Replace( ':', '_' );
		File@ thefile = g_FileSystem.OpenFile( fullpath, OpenFile::WRITE );
		
		if ( thefile !is null && thefile.IsOpen() )
		{
			string stuff;
			
			stuff += "" + xp_p[ index ] + "#" + medals_p[ index ] + "#" + sparks_p[ index ];
			stuff += "#" + health_max_p[ index ] + "#" + armor_max_p[ index ] + "#" + rhealth_max_p[ index ] + "#" + rarmor_max_p[ index ] + "#" + rammo_max_p[ index ] + "#" + gravity_max_p[ index ] + "#" + speed_max_p[ index ] + "#" + dist_max_p[ index ] + "#" + dodge_max_p[ index ];
			stuff += "#" + spawndmg_max_p[ index ] + "#" + ubercharge_max_p[ index ] + "#" + freefall_max_p[ index ] + "#" + demoman_max_p[ index ] + "#" + practiceshot_max_p[ index ] + "#" + bioelectric_max_p[ index ];
			stuff += "#" + startlevel_p[ index ] + "#" + startmedals_p[ index ];
			stuff += "#" + maxlevel_p[ index ] + "#" + maxmedals_p[ index ] + "#" + xpgain_p[ index ] + "\n";
			
			thefile.Write( stuff );
			thefile.Close();
		}
	}
}
void Champion_LoadSandboxData( const int& in index )
{
	CBasePlayer@ pPlayer = g_PlayerFuncs.FindPlayerByIndex( index );
	
	string fullpath = "" + PATH_POST_DATA + "S_" + g_EngineFuncs.GetPlayerAuthId( pPlayer.edict() ) + ".data";
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
		
		xp_p[ index ] = atoi( pre_data[ 0 ] );
		medals_p[ index ] = atoi( pre_data[ 1 ] );
		sparks_p[ index ] = atoi( pre_data[ 2 ] );
		
		health_max_p[ index ] = atoi( pre_data[ 3 ] );
		armor_max_p[ index ] = atoi( pre_data[ 4 ] );
		rhealth_max_p[ index ] = atoi( pre_data[ 5 ] );
		rarmor_max_p[ index ] = atoi( pre_data[ 6 ] );
		rammo_max_p[ index ] = atoi( pre_data[ 7 ] );
		gravity_max_p[ index ] = atoi( pre_data[ 8 ] );
		speed_max_p[ index ] = atoi( pre_data[ 9 ] );
		dist_max_p[ index ] = atoi( pre_data[ 10 ] );
		dodge_max_p[ index ] = atoi( pre_data[ 11 ] );
		
		spawndmg_max_p[ index ] = atoi( pre_data[ 12 ] );
		ubercharge_max_p[ index ] = atoi( pre_data[ 13 ] );
		freefall_max_p[ index ] = atoi( pre_data[ 14 ] );
		demoman_max_p[ index ] = atoi( pre_data[ 15 ] );
		practiceshot_max_p[ index ] = atoi( pre_data[ 16 ] );
		bioelectric_max_p[ index ] = atoi( pre_data[ 17 ] );
		
		startlevel_p[ index ] = atoi( pre_data[ 18 ] );
		startmedals_p[ index ] = atoi( pre_data[ 19 ] );
		
		maxlevel_p[ index ] = atoi( pre_data[ 20 ] );
		maxmedals_p[ index ] = atoi( pre_data[ 21 ] );
		
		xpgain_p[ index ] = atof( pre_data[ 22 ] );
		
		thefile.Close();
	}
}

// Data Manager (A stupid backup system)
void scxpm_datamanager( const int& in index )
{
	CBasePlayer@ pPlayer = g_PlayerFuncs.FindPlayerByIndex( index );
	MenuHandler@ state = MenuGetPlayer( pPlayer );
	
	state.InitMenu( pPlayer, scxpm_datamanager_cb );
	
	string title = "Administrador de Datos\n\n";
	title += "AVISO IMPORTANTE:\nEl Staff de ImperiumSC no se hace responsable\npor el uso indebido de esta herramienta!\n\n";
	title += "La ultima copia de seguridad fue realizada el dia: \n";
	
	// Gather last update day
	string fullpath = "" + PATH_BACKUP_DATA + "DM_" + g_EngineFuncs.GetPlayerAuthId( pPlayer.edict() ) + ".bak";
	fullpath.Replace( ':', '_' );
	File@ thefile = g_FileSystem.OpenFile( fullpath, OpenFile::READ );
	
	if ( thefile !is null && thefile.IsOpen() )
	{
		string line;
		int iLine = 1;
		
		// Go straight to the end of file, where the timestamp is located
		while( !thefile.EOFReached() )
		{
			thefile.ReadLine( line );
			if ( iLine == 172 )
			{
				// It's here!
				break;
			}
			else
				iLine++;
		}
		
		// Get the timestamp
		DateTime dtBackupTime;
		dtBackupTime.SetUnixTimestamp( atoi( line ) );
		
		// Set it to title
		title += GetSpanishDate( dtBackupTime );
		
		thefile.Close();
	}
	else
		title += "<nunca>";
	
	title += "\n\n";
	
	state.menu.SetTitle( title );
	state.menu.AddItem( "Actualizar copia de seguridad\n", any( "item1" ) );
	state.menu.AddItem( "Restaurar copia de seguridad\n", any( "item2" ) );
	state.menu.AddItem( "Reestablecer datos a fabrica", any( "item3" ) );
	
	state.OpenMenu( pPlayer, 0, 0 );
}

void scxpm_datamanager_cb( CTextMenu@ menu, CBasePlayer@ pPlayer, int page, const CTextMenuItem@ item )
{
	int index = pPlayer.entindex();
	if ( page == 10 ) return;
	
	string aname = pPlayer.pev.netname;
	string asteamid = g_EngineFuncs.GetPlayerAuthId( pPlayer.edict() );
	
	string selection;
	item.m_pUserData.retrieve( selection );
	if ( selection == 'item1' )
	{
		// Because I'm positive this shit will happen
		bool bDummy = false;
		bool bSuccess = DATA_SaveBackup( index );
		if ( bSuccess )
		{
			g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "[SCXPM] La copia de seguridad fue actualizada con exito\n" );
			g_Game.AlertMessage( at_logged, "[SCXPM] " + aname + " (" + asteamid + ") creo/actualizo su copia de seguridad\n" );
			SCXPM_Log( "" + aname + " (" + asteamid + ") creo/actualizo su copia de seguridad\n" );
		}
		else
			g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "[SCXPM] Error inesperado en el servidor\n" );
		
		g_Scheduler.SetTimeout( "scxpm_datamanager", 0.01, index );
	}
	else if ( selection == 'item2' )
	{
		bool bDummy = false;
		bool bSuccess = DATA_LoadBackup( index );
		if ( bSuccess )
		{
			g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "[SCXPM] El archivo ya sido satisfactoriamente restaurado a la ultima copia de seguridad\n" );
			g_Game.AlertMessage( at_logged, "[SCXPM] " + aname + " (" + asteamid + ") restauro sus datos a su ultima copia de seguridad\n" );
			SCXPM_Log( "" + aname + " (" + asteamid + ") restauro sus datos a su ultima copia de seguridad\n" );
		}
		else
			g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "[SCXPM] Error inesperado en el servidor\n" );
		
		g_Scheduler.SetTimeout( "scxpm_datamanager", 0.01, index );
	}
	else if ( selection == 'item3' )
	{
		LoadEmptySkills( index );
		
		g_PlayerFuncs.ClientPrint( pPlayer, HUD_PRINTTALK, "[SCXPM] Los archivos principales fueron reestablecidos a fabrica\n" );
		g_Game.AlertMessage( at_logged, "[SCXPM] " + aname + " (" + asteamid + ") reestablecio sus datos principales a fabrica\n" );
		SCXPM_Log( "" + aname + " (" + asteamid + ") reestablecio sus datos principales a fabrica\n" );
		
		g_Scheduler.SetTimeout( "scxpm_datamanager", 0.01, index );
	}
}

bool DATA_SaveBackup( const int& in index )
{
	CBasePlayer@ pPlayer = g_PlayerFuncs.FindPlayerByIndex( index );
	
	if ( loaddata[ index ] )
	{
		string fullpath = "" + PATH_BACKUP_DATA + "DM_" + g_EngineFuncs.GetPlayerAuthId( pPlayer.edict() ) + ".bak";
		fullpath.Replace( ':', '_' );
		File@ thefile = g_FileSystem.OpenFile( fullpath, OpenFile::WRITE );
		
		if ( thefile !is null && thefile.IsOpen() )
		{
			string stuff;
			
			// Main data
			stuff += "" + xp[ index ] + "#" + xp_e[ index ] + "#" + xp_h[ index ];
			stuff += "#" + playerlevel[ index ] + "#" + skillpoints[ index ];
			stuff += "#" + medals[ index ] + "#" + medals_h[ index ];
			stuff += "#" + health[ index ] + "#" + armor[ index ] + "#" + rhealth[ index ] + "#" + rarmor[ index ] + "#" + rammo[ index ] + "#" + gravity[ index ] + "#" + speed[ index ] + "#" + dist[ index ] + "#" + dodge[ index ];
			stuff += "#" + spawndmg[ index ] + "#" + ubercharge[ index ] + "#" + freefall[ index ] + "#" + demoman[ index ] + "#" + practiceshot[ index ] + "#" + bioelectric[ index ];
			stuff += "#" + bData[ index ] + "#" + hud_red1[ index ] + "#" + hud_green1[ index ] + "#" + hud_blue1[ index ] + "#" + hud_red2[ index ] + "#" + hud_green2[ index ] + "#" + hud_blue2[ index ] + "#" + hud_alpha[ index ];
			stuff += "#" + hud_pos_x[ index ] + "#" + hud_pos_y[ index ] + "#" + hud_effect[ index ] + "#" + hud_ef_fadein[ index ] + "#" + hud_ef_scantime[ index ];
			stuff += "#" + mode[ index ] + "#" + hkey[ index ] + "#" + sparks[ index ] + "#" + expamp[ index ];
			stuff += "#" + expamptime[ index ].ToUnixTimestamp() + "#" + firstplay[ index ].ToUnixTimestamp() + "#" + nextdaily[ index ].ToUnixTimestamp() + "#" + dailyget[ index ];
			stuff += "#" + bWasDead[ index ] + "#" + bHasMGAccess[ index ] + "#" + redcross[ index ] + "\n";
			
			// Champion data
			if ( IsChampion( pPlayer ) )
			{
				stuff += "" + xp_p[ index ] + "#" + medals_p[ index ] + "#" + sparks_p[ index ];
				stuff += "#" + health_max_p[ index ] + "#" + armor_max_p[ index ] + "#" + rhealth_max_p[ index ] + "#" + rarmor_max_p[ index ] + "#" + rammo_max_p[ index ] + "#" + gravity_max_p[ index ] + "#" + speed_max_p[ index ] + "#" + dist_max_p[ index ] + "#" + dodge_max_p[ index ];
				stuff += "#" + spawndmg_max_p[ index ] + "#" + ubercharge_max_p[ index ] + "#" + freefall_max_p[ index ] + "#" + demoman_max_p[ index ] + "#" + practiceshot_max_p[ index ] + "#" + bioelectric_max_p[ index ];
				stuff += "#" + startlevel_p[ index ] + "#" + startmedals_p[ index ];
				stuff += "#" + maxlevel_p[ index ] + "#" + maxmedals_p[ index ] + "#" + xpgain_p[ index ] + "\n";
			}
			else
				stuff += "NOT_CHAMPION\n";
			
			// Achievement data
			CustomKeyvalues@ pCustom = pPlayer.GetCustomKeyvalues();
			for ( uint i = 0; i < szAchievementNames.length(); i++ )
			{
				if ( aData[ index ][ i ] )
					stuff += "" + string( i ) + "#TRUE#" + ( aClaim[ index ][ i ] ? "1" : "0" ) + "\n";
				else
				{
					if ( pCustom.HasKeyvalue( "$i_sys_a_" + string( i ) ) )
					{
						CustomKeyvalue iProgress_pre( pCustom.GetKeyvalue( "$i_sys_a_" + string( i ) ) );
						int iProgress = iProgress_pre.GetInteger();
						stuff += "" + string( i ) + "#FALSE#" + string( iProgress ) + "\n";
					}
					else
						stuff += "" + string( i ) + "#FALSE#0\n";
				}
			}
			
			// DateTime when this backup file was last updated
			stuff += "" + string( UnixTimestamp() ) + "\n";
			
			// Do the backup
			thefile.Write( stuff );
			thefile.Close();
			return true;
		}
	}
	
	return false;
}

bool DATA_LoadBackup( const int& in index )
{
	CBasePlayer@ pPlayer = g_PlayerFuncs.FindPlayerByIndex( index );
	
	if ( loaddata[ index ] )
	{
		string fullpath = "" + PATH_BACKUP_DATA + "DM_" + g_EngineFuncs.GetPlayerAuthId( pPlayer.edict() ) + ".bak";
		fullpath.Replace( ':', '_' );
		File@ thefile = g_FileSystem.OpenFile( fullpath, OpenFile::READ );
		
		if ( thefile !is null && thefile.IsOpen() )
		{
			string line;
			
			// Main
			thefile.ReadLine( line );
			line.Replace( '#', ' ' );
			array< string >@ pre_data1 = line.Split( ' ' );
			
			pre_data1[ 0 ].Trim();
			pre_data1[ 1 ].Trim();
			pre_data1[ 2 ].Trim();
			pre_data1[ 3 ].Trim();
			pre_data1[ 4 ].Trim();
			pre_data1[ 5 ].Trim();
			pre_data1[ 6 ].Trim();
			pre_data1[ 7 ].Trim();
			pre_data1[ 8 ].Trim();
			pre_data1[ 9 ].Trim();
			pre_data1[ 10 ].Trim();
			pre_data1[ 11 ].Trim();
			pre_data1[ 12 ].Trim();
			pre_data1[ 13 ].Trim();
			pre_data1[ 14 ].Trim();
			pre_data1[ 15 ].Trim();
			pre_data1[ 16 ].Trim();
			pre_data1[ 17 ].Trim();
			pre_data1[ 18 ].Trim();
			pre_data1[ 19 ].Trim();
			pre_data1[ 20 ].Trim();
			pre_data1[ 21 ].Trim();
			pre_data1[ 22 ].Trim();
			pre_data1[ 23 ].Trim();
			pre_data1[ 24 ].Trim();
			pre_data1[ 25 ].Trim();
			pre_data1[ 26 ].Trim();
			pre_data1[ 27 ].Trim();
			pre_data1[ 28 ].Trim();
			pre_data1[ 29 ].Trim();
			pre_data1[ 30 ].Trim();
			pre_data1[ 31 ].Trim();
			pre_data1[ 32 ].Trim();
			pre_data1[ 33 ].Trim();
			pre_data1[ 34 ].Trim();
			pre_data1[ 35 ].Trim();
			pre_data1[ 36 ].Trim();
			pre_data1[ 37 ].Trim();
			pre_data1[ 38 ].Trim();
			pre_data1[ 39 ].Trim();
			pre_data1[ 40 ].Trim();
			pre_data1[ 41 ].Trim();
			pre_data1[ 42 ].Trim();
			pre_data1[ 43 ].Trim();
			pre_data1[ 44 ].Trim();
			pre_data1[ 45 ].Trim();
			
			xp[ index ] = atoi( pre_data1[ 0 ] );
			xp_e[ index ] = atoi( pre_data1[ 1 ] );
			xp_h[ index ] = atoi( pre_data1[ 2 ] );
			playerlevel[ index ] = atoi( pre_data1[ 3 ] );
			scxpm_calcneedxp( index );
			skillpoints[ index ] = atoi( pre_data1[ 4 ] );
			medals[ index ] = atoi( pre_data1[ 5 ] );
			medals_h[ index ] = atoi( pre_data1[ 6 ] );
			health[ index ] = atoi( pre_data1[ 7 ] );
			armor[ index ] = atoi( pre_data1[ 8 ] );
			rhealth[ index ] = atoi( pre_data1[ 9 ] );
			rarmor[ index ] = atoi( pre_data1[ 10 ] );
			rammo[ index ] = atoi( pre_data1[ 11 ] );
			gravity[ index ] = atoi( pre_data1[ 12 ] );
			speed[ index ] = atoi( pre_data1[ 13 ] );
			dist[ index ] = atoi( pre_data1[ 14 ] );
			dodge[ index ] = atoi( pre_data1[ 15 ] );
			spawndmg[ index ] = atoi( pre_data1[ 16 ] );
			ubercharge[ index ] = atoi( pre_data1[ 17 ] );
			freefall[ index ] = atoi( pre_data1[ 18 ] );
			demoman[ index ] = atoi( pre_data1[ 19 ] );
			practiceshot[ index ] = atoi( pre_data1[ 20 ] );
			bioelectric[ index ] = atoi( pre_data1[ 21 ] );
			bData[ index ] = atoi( pre_data1[ 22 ] );
			hud_red1[ index ] = atoi( pre_data1[ 23 ] );
			hud_green1[ index ] = atoi( pre_data1[ 24 ] );
			hud_blue1[ index ] = atoi( pre_data1[ 25 ] );
			hud_red2[ index ] = atoi( pre_data1[ 26 ] );
			hud_green2[ index ] = atoi( pre_data1[ 27 ] );
			hud_blue2[ index ] = atoi( pre_data1[ 28 ] );
			hud_alpha[ index ] = atoi( pre_data1[ 29 ] );
			hud_pos_x[ index ] = atof( pre_data1[ 30 ] );
			hud_pos_y[ index ] = atof( pre_data1[ 31 ] );
			hud_effect[ index ] = atoi( pre_data1[ 32 ] );
			hud_ef_fadein[ index ] = atof( pre_data1[ 33 ] );
			hud_ef_scantime[ index ] = atof( pre_data1[ 34 ] );
			mode[ index ] = atoi( pre_data1[ 35 ] );
			hkey[ index ] = atoi( pre_data1[ 36 ] );
			sparks[ index ] = atoi( pre_data1[ 37 ] );
			expamp[ index ] = atoi( pre_data1[ 38 ] );
			expamptime[ index ].SetUnixTimestamp( atoi( pre_data1[ 39 ] ) );
			firstplay[ index ].SetUnixTimestamp( atoi( pre_data1[ 40 ] ) );
			nextdaily[ index ].SetUnixTimestamp( atoi( pre_data1[ 41 ] ) );
			dailyget[ index ] = atoi( pre_data1[ 42 ] );
			bWasDead[ index ] = atoi( pre_data1[ 43 ] );
			bHasMGAccess[ index ] = atoi( pre_data1[ 44 ] );
			redcross[ index ] = atoi( pre_data1[ 45 ] );
			scxpm_amptask();
			scxpm_getrank( index );
			
			// Champion
			thefile.ReadLine( line );
			if ( IsChampion( pPlayer ) )
			{
				line.Replace( '#', ' ' );
				array< string >@ pre_data2 = line.Split( ' ' );
				
				pre_data2[ 0 ].Trim();
				pre_data2[ 1 ].Trim();
				pre_data2[ 2 ].Trim();
				pre_data2[ 3 ].Trim();
				pre_data2[ 4 ].Trim();
				pre_data2[ 5 ].Trim();
				pre_data2[ 6 ].Trim();
				pre_data2[ 7 ].Trim();
				pre_data2[ 8 ].Trim();
				pre_data2[ 9 ].Trim();
				pre_data2[ 10 ].Trim();
				pre_data2[ 11 ].Trim();
				pre_data2[ 12 ].Trim();
				pre_data2[ 13 ].Trim();
				pre_data2[ 14 ].Trim();
				pre_data2[ 15 ].Trim();
				pre_data2[ 16 ].Trim();
				pre_data2[ 17 ].Trim();
				pre_data2[ 18 ].Trim();
				pre_data2[ 19 ].Trim();
				pre_data2[ 20 ].Trim();
				pre_data2[ 21 ].Trim();
				pre_data2[ 22 ].Trim();
				
				xp_p[ index ] = atoi( pre_data2[ 0 ] );
				medals_p[ index ] = atoi( pre_data2[ 1 ] );
				sparks_p[ index ] = atoi( pre_data2[ 2 ] );
				
				health_max_p[ index ] = atoi( pre_data2[ 3 ] );
				armor_max_p[ index ] = atoi( pre_data2[ 4 ] );
				rhealth_max_p[ index ] = atoi( pre_data2[ 5 ] );
				rarmor_max_p[ index ] = atoi( pre_data2[ 6 ] );
				rammo_max_p[ index ] = atoi( pre_data2[ 7 ] );
				gravity_max_p[ index ] = atoi( pre_data2[ 8 ] );
				speed_max_p[ index ] = atoi( pre_data2[ 9 ] );
				dist_max_p[ index ] = atoi( pre_data2[ 10 ] );
				dodge_max_p[ index ] = atoi( pre_data2[ 11 ] );
				
				spawndmg_max_p[ index ] = atoi( pre_data2[ 12 ] );
				ubercharge_max_p[ index ] = atoi( pre_data2[ 13 ] );
				freefall_max_p[ index ] = atoi( pre_data2[ 14 ] );
				demoman_max_p[ index ] = atoi( pre_data2[ 15 ] );
				practiceshot_max_p[ index ] = atoi( pre_data2[ 16 ] );
				bioelectric_max_p[ index ] = atoi( pre_data2[ 17 ] );
				
				startlevel_p[ index ] = atoi( pre_data2[ 18 ] );
				startmedals_p[ index ] = atoi( pre_data2[ 19 ] );
				
				maxlevel_p[ index ] = atoi( pre_data2[ 20 ] );
				maxmedals_p[ index ] = atoi( pre_data2[ 21 ] );
				
				xpgain_p[ index ] = atof( pre_data2[ 22 ] );
			}
			
			// Achievements
			while( !thefile.EOFReached() )
			{
				// Get all configs
				thefile.ReadLine( line );
				if ( line.Length() > 0 )
				{
					array< string >@ pre_data3 = line.Split( '#' );
					if ( pre_data3.length() == 3 )
					{
						pre_data3[ 0 ].Trim(); // Achievement ID
						pre_data3[ 1 ].Trim(); // Unlock status
						pre_data3[ 2 ].Trim(); // Progress / Claim status
						
						// Get data
						// If achievement is unlocked, just hold said data and check claim status
						if ( pre_data3[ 1 ] == 'TRUE' )
						{
							aData[ index ][ atoi( pre_data3[ 0 ] ) ] = true;
							aClaim[ index ][ atoi( pre_data3[ 0 ] ) ] = ( pre_data3[ 2 ] == '1' ? true : false );
						}
						else
						{
							// Not unlocked, retrieve progress data and let handler take care of rest
							CustomKeyvalues@ pCustom = pPlayer.GetCustomKeyvalues();
							pCustom.SetKeyvalue( "$i_sys_a_" + pre_data3[ 0 ], atoi( pre_data3[ 2 ] ) );
						}
					}
				}
			}
			
			thefile.Close();
			return true;
		}
	}
	
	return false;
}

/* Mystery Gift stuff */
void MysteryGift_Welcome( const int& in index )
{
	CBasePlayer@ pPlayer = g_PlayerFuncs.FindPlayerByIndex( index );
	
	string szInfo = "Vaya! No esperaba que lograras resolver el puzzle secreto. Hoy es tu dia de suerte! Pues si, bienvenido a Mystery Gift (Regalo Misterioso)!";
	szInfo += "\n\nPero que es Mystery Gift? Bueno, no es algo que uno pueda describir facilmente, si bien son regalos que puedes dar y recibir, ";
	szInfo += "su utilidad va mucho mas alla de un mero sistema de recompensas.";
	szInfo += "\n\nMystery Gift no solamente puede darte las recompensas clasicas de EXP y demas. Tambien puede proveerte acceso a mapas/misiones exclusivas, ";
	szInfo += "e inclusive caracteristicas unicas que no creias que fueran posibles en este servidor.";
	szInfo += "\n\nBien, ahora que ya explique que es todo esto, te explicare los 3 diferentes tipos de regalos.";
	
	szInfo += "\n\n1. Recibir desde servidor\n\nEsta opcion busca algun regalo en el servidor que te encuentres. Estos regalos son unicos: ";
	szInfo += "Cada servidor provee un regalo diferente, y solamente pueden ser usados en dicho servidor. Estate atento a las noticias del servidor, ";
	szInfo += "los regalos de este tipo se anuncian desde ahi!";
	
	szInfo += "\n\n2. Recibir desde codigo\n\nEsta opcion puede usarse en cualquier lugar independientemente del servidor que te encuentres. ";
	szInfo += "Sin embargo, hay un detalle importante a destacar: Un mismo codigo puede proveer diferentes regalos segun el servidor que te encuentres. ";
	szInfo += "Puedes encontrar codigos resolviendo misiones, mapas y puzzles secretos esparcidos por todo el servidor. Tarea ardua, pero vale la pena!";
	
	szInfo += "\n\n3. Recibir desde jugador\n\nEsta opcion te permite a ti u otro jugador dar cualquier regalo a propio gusto utilizando los Puntos Cosmeticos. ";
	szInfo += "Solo ten en cuenta lo siguiente: Regalos creados por un jugador, solamente pueden ser redimidos en el mismo servidor que fueron creados. ";
	szInfo += "Asi que adelante, a repartir regalos!";
	
	szInfo += "\n\nFinalmente, una aclaracion: Todos los regalos, sin importar el tipo, solo pueden ser redimidos una sola vez.";
	szInfo += "\n\nAhora si! Esperamos que disfrutes de esta nueva caracteristica\n\n   -Staff ImperiumSC";
	
	ShowMOTD( pPlayer, "Mystery Gift", szInfo );
}

void MysteryGift_Main( const int& in index )
{
	CBasePlayer@ pPlayer = g_PlayerFuncs.FindPlayerByIndex( index );
	MenuHandler@ state = MenuGetPlayer( pPlayer );
	
	state.InitMenu( pPlayer, MysteryGift_Main_CB );
	state.menu.SetTitle( "Bienvenido a Mystery Gift!\n\n" );
	
	state.menu.AddItem( "Recibir desde servidor\n", any( "item1" ) );
	state.menu.AddItem( "Recibir desde codigo\n", any( "item2" ) );
	state.menu.AddItem( "Recibir desde jugador", any( "item3" ) );
	
	state.OpenMenu( pPlayer, 0, 0 );
}

void MysteryGift_Main_CB( CTextMenu@ menu, CBasePlayer@ pPlayer, int page, const CTextMenuItem@ item )
{
	int index = pPlayer.entindex();
	if ( page == 10 ) return;
	
	string selection;
	item.m_pUserData.retrieve( selection );
	
	if ( selection == 'item1' )
		g_Scheduler.SetTimeout( "MysteryGift_Search", 0.01, index, "SEARCH#SERVER" );
	else if ( selection == 'item2' )
		g_Scheduler.SetTimeout( "MysteryGift_CodeHelp", 0.01, index );
	else if ( selection == 'item3' )
		g_Scheduler.SetTimeout( "MysteryGift_PlayerHelp", 0.01, index );
}

void MysteryGift_CodeHelp( const int& in index )
{
	CBasePlayer@ pPlayer = g_PlayerFuncs.FindPlayerByIndex( index );
	MenuHandler@ state = MenuGetPlayer( pPlayer );
	
	state.InitMenu( pPlayer, MysteryGift_Cancel_CB );
	state.menu.SetTitle( "Recibir desde codigo\n\nIntroduce el codigo para\nredimir su recompensa\n\nUsa el comando /mystery redeem <codigo>\n" );
	
	state.menu.AddItem( "Cancelar", any( "item1" ) );
	
	state.OpenMenu( pPlayer, 0, 0 );
}

void MysteryGift_PlayerHelp( const int& in index )
{
	CBasePlayer@ pPlayer = g_PlayerFuncs.FindPlayerByIndex( index );
	MenuHandler@ state = MenuGetPlayer( pPlayer );
	
	state.InitMenu( pPlayer, MysteryGift_Cancel_CB );
	state.menu.SetTitle( "Recibir desde jugador\n\nSi un jugador tiene un\nregalo para ti, introduce\nsu nombre para redimirla\n\nUsa el comando /mystery player <jugador>\n" );
	
	state.menu.AddItem( "Cancelar", any( "item1" ) );
	
	state.OpenMenu( pPlayer, 0, 0 );
}

void MysteryGift_Cancel_CB( CTextMenu@ menu, CBasePlayer@ pPlayer, int page, const CTextMenuItem@ item )
{
	int index = pPlayer.entindex();
	
	// Input cancel now
	pPlayer.pev.globalname = "";
	@pPlayer.pev.euser1 = null;
	
	if ( page == 10 ) return;
	
	string selection;
	item.m_pUserData.retrieve( selection );
	
	if ( selection == 'item1' )
		g_Scheduler.SetTimeout( "MysteryGift_Main", 0.01, index );
}

void MysteryGift_Search( const int& in index, const string& in szSearch )
{
	CBasePlayer@ pPlayer = g_PlayerFuncs.FindPlayerByIndex( index );
	
	pPlayer.pev.globalname = szSearch;
	@pPlayer.pev.euser1 = pPlayer.edict();
	
	MenuHandler@ state = MenuGetPlayer( pPlayer );
	
	state.InitMenu( pPlayer, MysteryGift_Cancel_CB );
	state.menu.SetTitle( "Buscando algun regalo...\n\nNo te desconectes del servidor\n" );
	
	state.menu.AddItem( "Cancelar", any( "item1" ) );
	
	state.OpenMenu( pPlayer, 0, 0 );
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
			pMedkit.KeyValue( "-spawnflags", "1024" );
			pMedkit.pev.targetname = "soy_un_ytph_de_dross";
			
			g_EntityFuncs.FireTargets( "soy_un_ytph_de_dross", null, null, USE_TOGGLE, 0.0, 0.0 );
			
			// Save the medkit
			@self.pev.euser2 = pMedkit.edict();
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
				switch ( mode[ i ] )
				{
					case 1: xp_e[ i ] += earnedxp[ i ]; break;
					case 2: xp[ i ] += earnedxp[ i ]; break;
					case 3: xp_h[ i ] += earnedxp[ i ]; break;
					case 4: xp_p[ i ] += earnedxp[ i ]; break;
				}
				earnedxp[ i ] = 0;
				
				// Cosmetic Points helper
				CustomKeyvalues@ pCustom = pPlayer.GetCustomKeyvalues();
				pCustom.SetKeyvalue( "$i_cp_extra", int( pPlayer.pev.frags * 5.00 ) );
				
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
			switch ( mode[ index ] )
			{
				case 1: xp_e[ index ] += earnedxp[ index ]; break;
				case 2: xp[ index ] += earnedxp[ index ]; break;
				case 3: xp_h[ index ] += earnedxp[ index ]; break;
				case 4: xp_p[ index ] += earnedxp[ index ]; break;
			}
			earnedxp[ index ] = 0;
			
			// Cosmetic Points helper
			CustomKeyvalues@ pCustom = pPlayer.GetCustomKeyvalues();
			pCustom.SetKeyvalue( "$i_cp_extra", int( pPlayer.pev.frags * 5.00 ) );
			
			// RESET RESET
			pPlayer.pev.frags = 0;
			lastfrags[ index ] = 0;
		}
	}
}
