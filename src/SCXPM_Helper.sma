/*
	Giegue's SCXPM: Auxiliary Scripts
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

#pragma semicolon 1

#include <amxmodx>
#include <engine>
#include <fakemeta>

// CBasePlayer --> m_iDeaths
new const _linux_PLAYER_DEATHS 			= 708;		 // (TODO: This offset is old! Update it)
new const _win32_PLAYER_DEATHS 			= 714;

new OFFSET_PLAYER_DEATHS;

new hudCVar;

public plugin_precache()
{
	register_forward( FM_KeyValue, "check_entities" );
}

public plugin_init()
{
	register_plugin( "SCXPM Helper", "1.3", "Giegue" );
	
	OFFSET_PLAYER_DEATHS = is_linux_server() ? _linux_PLAYER_DEATHS : _win32_PLAYER_DEATHS;
	
	hudCVar = register_cvar( "scxpm_hud_channel", "3" );
	set_task( 0.5, "GetHUDCVar" );
	
	// "stuck_kill" death exploit fix
	register_clcmd( "stuck_kill", "addDeath" );
}

public check_entities( entid, kvd_handle )
{
	if ( is_valid_ent( entid ) )
	{
		static classname[ 33 ], keyname[ 33 ], value[ 33 ];
		get_kvd( kvd_handle, KV_ClassName, classname, charsmax( classname ) );
		
		// Delete all XP-abusive entities
		if ( equali( classname, "monster_cockroach" ) )
		{
			remove_entity( entid );
			return FMRES_SUPERCEDE;
		}
		else if ( equali( classname, "monster_rat" ) )
		{
			remove_entity( entid );
			return FMRES_SUPERCEDE;
		}
		else if ( equali( classname, "monster_leech" ) )
		{
			remove_entity( entid );
			return FMRES_SUPERCEDE;
		}
		else if ( equali( classname, "game_score" ) )
		{
			remove_entity( entid );
			return FMRES_SUPERCEDE;
		}
		else if ( equali( classname, "squadmaker" ) || equali( classname, "monstermaker" ) || equali( classname, "env_xenmaker" ) ) // Check if any of those monsters are on a squad/monster maker
		{
			get_kvd( kvd_handle, KV_KeyName, keyname, charsmax( keyname ) );
			if ( equali( keyname, "monstertype" ) )
			{
				get_kvd( kvd_handle, KV_Value, value, charsmax( value ) );
				if ( equali( value, "monster_cockroach" ) )
				{
					remove_entity( entid );
					return FMRES_IGNORED;
				}
				else if ( equali( value, "monster_rat" ) )
				{
					remove_entity( entid );
					return FMRES_IGNORED;
				}
				else if ( equali( value, "monster_leech" ) )
				{
					remove_entity( entid );
					return FMRES_IGNORED;
				}
			}
		}
		else if ( equali( classname, "trigger_setcvar" ) )
		{
			get_kvd( kvd_handle, KV_KeyName, keyname, charsmax( keyname ) );
			if ( equali( keyname, "m_iszCVarToChange" ) )
			{
				get_kvd( kvd_handle, KV_Value, value, charsmax( value ) );
				if ( equali( value, "sk_player_", 10 ) )
				{
					// If you have tweaked the SCXPM to allow insane amounts of health and armor (600+)
					// then you should allow mappers to use their "anti xpmod" to adjust their difficulty as compensation
					
					// If, however, the SCXPM has been nerfed enough to only let a small boost of health and armor (no more than 200)
					// Then you have two choices:
					
					// a) You can let the below lines UNcommented to remove the difficulty adjustment
					// b) Ripent the map and lower the increased damage (From x3 damage to x1.5, for example)
					
					// You may also consider adding this map to scxpm_mapsettings.ini and use a NO_SKILL setting
					// to disable SCXPM boosts (and still let players level up), or DISABLED to fully turn the xp mod off.
					
					// -Giegue
					remove_entity( entid );
					return FMRES_IGNORED;
				}
			}
		}
	}
	
	return FMRES_IGNORED;
}

public GetHUDCVar()
{
	set_pcvar_num( hudCVar, 3 );
	
	new szMapname[ 33 ], szPath[ 65 ];
	get_mapname( szMapname, charsmax( szMapname ) );
	formatex( szPath, charsmax( szPath ), "maps/%s.cfg", szMapname );
	
	new pPointer = fopen( szPath, "r", true );
	if ( pPointer )
	{
		new szLine[ 128 ], szCvar[ 33 ], szValue[ 3 ];
		while ( fgets( pPointer, szLine, charsmax( szLine ) ) )
		{
			parse( szLine, szCvar, charsmax( szCvar ), szValue, charsmax( szValue ) );
			if ( equal( szCvar, "scxpm_hud_channel" ) )
			{
				set_pcvar_num( hudCVar, str_to_num( szValue ) );
				break;
			}
		}
		fclose( pPointer );
	}
	
	hook_cvar_change( hudCVar, "doRefreshHUD" );
}

public doRefreshHUD( pCV, old_value, new_value )
{
	set_hudmessage( 0, 0, 0, 0.0, 0.0, 0, 0.0, 0.0, 0.0, 0.0, old_value, 0, { 0, 0, 0, 0 } );
	show_hudmessage( 0, " " );
}

/*** EXTRA FIXES ***/
public addDeath( player )
{
	if ( !is_user_connected( player ) )
		return PLUGIN_HANDLED;
	
	if ( is_user_alive( player ) )
		set_task( 0.1, "addDeathPost", player );
	
	return PLUGIN_CONTINUE;
}
public addDeathPost( player )
{
	if ( !is_user_connected( player ) )
		return PLUGIN_HANDLED;
	
	if ( !is_user_alive( player ) )
	{
		new name[ 33 ];
		get_user_name( player, name, charsmax( name ) );
		set_pdata_int( player, OFFSET_PLAYER_DEATHS, get_pdata_int( player, OFFSET_PLAYER_DEATHS ) + 1 );
		
		client_print( 0, print_notify, "%s committed suicide.", name );
	}
	
	return PLUGIN_HANDLED;
}
