/*
	CLevels (Imperium Sven Co-op's SCXPM): Mystery Gift
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

#pragma semicolon 1

#include <amxmodx>
#include <bit>
#include <engine>
//#include <sqlx>

// Server ID
new pServerID;

// MySQL Support
new Handle:dbc;
new const sqlHost[] = "ip";
new const sqlUser[] = "user";
new const sqlPass[] = "pass";
new const sqlData[] = "dbname";

public plugin_init()
{
	register_plugin( "Mystery Gift", "1.1", "Giegue" );
	
	pServerID = create_cvar( "mg_server_id", "0", FCVAR_PROTECTED, "Mystery Gift Server ID. Use ^"0^" to disable searchs on this server.", true, 0.0, true, 4.0 );
	//SQL_SetAffinity( "mysql" );
	
	set_task( 1.0, "Check", _, _, _, "b" );
}
/*
public plugin_end()
{
	// Don't want the handle hanging around there
	if ( dbc )
		SQL_FreeHandle( dbc );
}
*/
public Check()
{
	for ( new index = 0; index < 33; index++ )
	{
		if ( is_user_connected( index ) )
		{
			static szNoise3[ 64 ], szQuery[ 16 ], szData[ 48 ];
			entity_get_string( index, EV_SZ_globalname, szNoise3, charsmax( szNoise3 ) );
			replace_string( szNoise3, charsmax( szNoise3 ), "#", " " );
			parse( szNoise3, szQuery, charsmax( szQuery ), szData, charsmax( szData ) );
			
			// Get query
			if ( equal( szQuery, "SEARCH" ) ) // Search and redeem if gift exists
				SearchGift( index, szData );
			else if ( equal( szQuery, "CHECK" ) ) // Only search if a gift exists
				CheckGift( index, szData );
			else if ( equal( szQuery, "CREATE" ) ) // Create a gift on the current server
				CreateGift( index, szData );
			
			entity_set_string( index, EV_SZ_globalname, "" );
			formatex( szQuery, charsmax( szQuery ), "" ); // static variables, flush them manually
			formatex( szData, charsmax( szData ), "" );
		}
	}
}

public SearchGift( index, szData[] )
{
	// If the search was cancelled, don't bother
	if ( entity_get_edict( index, EV_ENT_euser1 ) == 0 || entity_get_edict( index, EV_ENT_euser1 ) != index )
		return PLUGIN_HANDLED;
	
	// Search from...?
	if ( equal( szData, "SERVER" ) )
	{
		// Server search, use file instead
		new vaultkey[ 64 ], vaultdata[ 256 ];
		
		// First, check if there is a gift waiting
		new DateTime[ 12 ];
		get_time( "%d_%m", DateTime, charsmax( DateTime ) );
		format( vaultkey, charsmax( vaultkey ), "mg-%s", DateTime );
		
		if ( vaultdata_exists( vaultkey ) )
		{
			// There is a reward! Get it
			get_vaultdata( vaultkey, vaultdata, charsmax( vaultdata ) );
			replace_string( vaultdata, charsmax( vaultdata ), "#", " " );
			
			// Get what kind of reward is this
			new pType[ 8 ], pValue[ 16 ], pMessage[ 256 ];
			parse( vaultdata, pType, charsmax( pType ), pValue, charsmax( pValue ), pMessage, charsmax( pMessage ) );
			
			// Okay! Now check if we did NOT retrieve this gift before
			new szSteamID[ 32 ];
			get_user_authid( index, szSteamID, charsmax( szSteamID ) );
			format( vaultkey, charsmax( vaultkey ), "mg_%s-%s", szSteamID, DateTime );
			
			if ( vaultdata_exists( vaultkey ) )
			{
				// Already claimed this gift, bummer!
				DispatchKeyValue( index, "$i_mg_error", "2" );
				entity_set_edict( index, EV_ENT_euser1, 0 );
				return PLUGIN_HANDLED;
			}
			
			// Reward is server-based, we are on server...
			switch ( get_pcvar_num( pServerID ) )
			{
				case 0:
				{
					// Aaaahhh! No gifts can be given!
					DispatchKeyValue( index, "$i_mg_error", "3" );
					entity_set_edict( index, EV_ENT_euser1, 0 );
					return PLUGIN_HANDLED;
				}
				case 1:
				{
					// SCXPM Rewards
					if ( equal( pType, "EXP" ) )
					{
						// Normal EXP reward
						new pointer, szFile[ 128 ];
						replace_string( szSteamID, charsmax( szSteamID ), ":", "_" );
						format( szFile, charsmax( szFile ), "scripts/plugins/store/scxpm_event/EXP_%s.data", szSteamID );
						pointer = fopen( szFile, "w" );
						if ( pointer )
						{
							// Write to file
							remove_quotes( pValue );
							fputs( pointer, pValue );
							fclose( pointer );
							
							// Open MOTD window
							DispatchKeyValue( index, "$s_mg_message", pMessage );
							
							// Done! Now let's save the gift as claimed
							new szName[ 64 ];
							get_user_name( index, szName, charsmax( szName ) );
							set_vaultdata( vaultkey, szName );
							DispatchKeyValue( index, "$i_mg_error", "99" );
						}
						else
						{
							// Uh-oh...
							DispatchKeyValue( index, "$i_mg_error", "4" );
							entity_set_edict( index, EV_ENT_euser1, 0 );
							return PLUGIN_HANDLED;
						}
					}
					else if ( equal( pType, "MEDAL" ) )
					{
						// Medals!
						DispatchKeyValue( index, "$i_cp_medals", pValue );
						
						// Open MOTD window
						DispatchKeyValue( index, "$s_mg_message", pMessage );
						
						// Done! Now let's save the gift as claimed
						new szName[ 64 ];
						get_user_name( index, szName, charsmax( szName ) );
						set_vaultdata( vaultkey, szName );
						DispatchKeyValue( index, "$i_mg_error", "99" );
					}
					else if ( equal( pType, "SPARK" ) )
					{
						// Sparks of Life. Keep playing on Hard Mode!
						DispatchKeyValue( index, "$i_cp_spark", pValue );
						
						// Open MOTD window
						DispatchKeyValue( index, "$s_mg_message", pMessage );
						
						// Done! Now let's save the gift as claimed
						new szName[ 64 ];
						get_user_name( index, szName, charsmax( szName ) );
						set_vaultdata( vaultkey, szName );
						DispatchKeyValue( index, "$i_mg_error", "99" );
					}
					else if ( equal( pType, "CP" ) )
					{
						// Cosmetic Points
						DispatchKeyValue( index, "$i_cp_extra", pValue );
						
						// Open MOTD window
						DispatchKeyValue( index, "$s_mg_message", pMessage );
						
						// Done! Now let's save the gift as claimed
						new szName[ 64 ];
						get_user_name( index, szName, charsmax( szName ) );
						set_vaultdata( vaultkey, szName );
						DispatchKeyValue( index, "$i_mg_error", "99" );
					}
					else if ( equal( pType, "AMPLV", 5 ) )
					{
						// Experience Amplifier!
						if ( pType[ 5 ] )
						{
							if ( str_to_num( pType[ 5 ] ) <= 0 || str_to_num( pType[ 5 ] ) > 4 )
							{
								// Bad gift!
								DispatchKeyValue( index, "$i_mg_error", "4" );
								entity_set_edict( index, EV_ENT_euser1, 0 );
								return PLUGIN_HANDLED;
							}
							else
							{
								DispatchKeyValue( index, "$i_cp_expamp", pType[ 5 ] );
								DispatchKeyValue( index, "$i_cp_amptime", pValue );
								
								// Open MOTD window
								DispatchKeyValue( index, "$s_mg_message", pMessage );
								
								// Done! Now let's save the gift as claimed
								new szName[ 64 ];
								get_user_name( index, szName, charsmax( szName ) );
								set_vaultdata( vaultkey, szName );
								DispatchKeyValue( index, "$i_mg_error", "99" );
							}
						}
						else
						{
							// Bad gift!
							DispatchKeyValue( index, "$i_mg_error", "4" );
							entity_set_edict( index, EV_ENT_euser1, 0 );
							return PLUGIN_HANDLED;
						}
					}
					else
					{
						// Non-implemented gift type or invalid
						DispatchKeyValue( index, "$i_mg_error", "4" );
						entity_set_edict( index, EV_ENT_euser1, 0 );
						return PLUGIN_HANDLED;
					}
				}
			}
		}
		else
		{
			// No gift here!
			DispatchKeyValue( index, "$i_mg_error", "1" );
			entity_set_edict( index, EV_ENT_euser1, 0 );
			return PLUGIN_HANDLED;
		}
	}
	else if ( equal( szData, "REDEEM", 6 ) )
	{
		// Redeem code search, use SQL server
		// LOL NOT YET. Just hardcode some shit for the time being
		new vaultkey[ 64 ], dummy[ 64 ], codesearch[ 32 ];
		
		format( dummy, charsmax( dummy ), "%s", szData );
		replace_string( dummy, charsmax( dummy ), "|", " " );
		parse( dummy, dummy, charsmax( dummy ), codesearch, charsmax( codesearch ) );
		
		new szSteamID[ 32 ];
		get_user_authid( index, szSteamID, charsmax( szSteamID ) );
		
		if ( equal( codesearch, "SM101-TSBP0" ) || equal( codesearch, "AGFM0-IS2EA" ) )
		{
			// These are no longer valid
			DispatchKeyValue( index, "$i_mg_error", "6" );
			entity_set_edict( index, EV_ENT_euser1, 0 );
			return PLUGIN_HANDLED;
		}
		else
		{
			// No gift here!
			DispatchKeyValue( index, "$i_mg_error", "1" );
			entity_set_edict( index, EV_ENT_euser1, 0 );
			return PLUGIN_HANDLED;
		}
	}
	else if ( equal( szData, "PLAYER", 6 ) )
	{
		// Player search, use server
		new vaultkey[ 64 ], vaultdata[ 256 ], dummy[ 64 ], playersearch[ 32 ];
		
		format( dummy, charsmax( dummy ), "%s", szData );
		replace_string( dummy, charsmax( dummy ), "|", " " );
		parse( dummy, dummy, charsmax( dummy ), playersearch, charsmax( playersearch ) );
		
		// Check if there is a gift waiting
		new DateTime[ 12 ];
		get_time( "%d_%m", DateTime, charsmax( DateTime ) );
		format( vaultkey, charsmax( vaultkey ), "mg_%s-%s", DateTime, playersearch );
		
		if ( vaultdata_exists( vaultkey ) )
		{
			// There is a reward! Get it
			get_vaultdata( vaultkey, vaultdata, charsmax( vaultdata ) );
			replace_string( vaultdata, charsmax( vaultdata ), "#", " " );
			
			// Get what kind of reward is this
			new pType[ 8 ], pValue[ 16 ], pDestination[ 32 ], pMessage[ 256 ];
			parse( vaultdata, pType, charsmax( pType ), pValue, charsmax( pValue ), pDestination, charsmax( pDestination ), pMessage, charsmax( pMessage ) );
			
			// HOLD IT! This gift must belong to us...
			new szSteamID[ 32 ];
			get_user_authid( index, szSteamID, charsmax( szSteamID ) );
			if ( equal( szSteamID, pDestination ) || equal( pDestination, "ALL" ) )
			{
				// Okay! Now check if we did NOT retrieve this gift before
				format( vaultkey, charsmax( vaultkey ), "mg_%s-%s-%s", szSteamID, DateTime, playersearch );
				
				if ( vaultdata_exists( vaultkey ) )
				{
					// Already claimed this gift, bummer!
					DispatchKeyValue( index, "$i_mg_error", "2" );
					entity_set_edict( index, EV_ENT_euser1, 0 );
					return PLUGIN_HANDLED;
				}
				
				// Reward is server-based, we are on server...
				switch ( get_pcvar_num( pServerID ) )
				{
					case 0:
					{
						// Aaaahhh! No gifts can be given!
						DispatchKeyValue( index, "$i_mg_error", "3" );
						entity_set_edict( index, EV_ENT_euser1, 0 );
						return PLUGIN_HANDLED;
					}
					case 1:
					{
						// SCXPM Rewards
						if ( equal( pType, "EXP" ) )
						{
							// Normal EXP reward
							new pointer, szFile[ 128 ];
							replace_string( szSteamID, charsmax( szSteamID ), ":", "_" );
							format( szFile, charsmax( szFile ), "scripts/plugins/store/scxpm_event/EXP_%s.data", szSteamID );
							pointer = fopen( szFile, "w" );
							if ( pointer )
							{
								// Write to file
								remove_quotes( pValue );
								fputs( pointer, pValue );
								fclose( pointer );
								
								// Open MOTD window
								DispatchKeyValue( index, "$s_mg_message", pMessage );
								
								// Done! Now let's save the gift as claimed
								new szName[ 64 ];
								get_user_name( index, szName, charsmax( szName ) );
								set_vaultdata( vaultkey, szName );
								DispatchKeyValue( index, "$i_mg_error", "99" );
							}
							else
							{
								// Uh-oh...
								DispatchKeyValue( index, "$i_mg_error", "4" );
								entity_set_edict( index, EV_ENT_euser1, 0 );
								return PLUGIN_HANDLED;
							}
						}
						else if ( equal( pType, "MEDAL" ) )
						{
							// Medals!
							DispatchKeyValue( index, "$i_cp_medals", pValue );
							
							// Open MOTD window
							DispatchKeyValue( index, "$s_mg_message", pMessage );
							
							// Done! Now let's save the gift as claimed
							new szName[ 64 ];
							get_user_name( index, szName, charsmax( szName ) );
							set_vaultdata( vaultkey, szName );
							DispatchKeyValue( index, "$i_mg_error", "99" );
						}
						else if ( equal( pType, "SPARK" ) )
						{
							// Sparks of Life. Keep playing on Hard Mode!
							DispatchKeyValue( index, "$i_cp_spark", pValue );
							
							// Open MOTD window
							DispatchKeyValue( index, "$s_mg_message", pMessage );
							
							// Done! Now let's save the gift as claimed
							new szName[ 64 ];
							get_user_name( index, szName, charsmax( szName ) );
							set_vaultdata( vaultkey, szName );
							DispatchKeyValue( index, "$i_mg_error", "99" );
						}
						else if ( equal( pType, "CP" ) )
						{
							// Cosmetic Points
							DispatchKeyValue( index, "$i_cp_extra", pValue );
							
							// Open MOTD window
							DispatchKeyValue( index, "$s_mg_message", pMessage );
							
							// Done! Now let's save the gift as claimed
							new szName[ 64 ];
							get_user_name( index, szName, charsmax( szName ) );
							set_vaultdata( vaultkey, szName );
							DispatchKeyValue( index, "$i_mg_error", "99" );
						}
						else if ( equal( pType, "AMPLV", 5 ) )
						{
							// Experience Amplifier!
							if ( pType[ 5 ] )
							{
								if ( str_to_num( pType[ 5 ] ) <= 0 || str_to_num( pType[ 5 ] ) > 4 )
								{
									// Bad gift!
									DispatchKeyValue( index, "$i_mg_error", "4" );
									entity_set_edict( index, EV_ENT_euser1, 0 );
									return PLUGIN_HANDLED;
								}
								else
								{
									DispatchKeyValue( index, "$i_cp_expamp", pType[ 5 ] );
									DispatchKeyValue( index, "$i_cp_amptime", pValue );
									
									// Open MOTD window
									DispatchKeyValue( index, "$s_mg_message", pMessage );
									
									// Done! Now let's save the gift as claimed
									new szName[ 64 ];
									get_user_name( index, szName, charsmax( szName ) );
									set_vaultdata( vaultkey, szName );
									DispatchKeyValue( index, "$i_mg_error", "99" );
								}
							}
							else
							{
								// Bad gift!
								DispatchKeyValue( index, "$i_mg_error", "4" );
								entity_set_edict( index, EV_ENT_euser1, 0 );
								return PLUGIN_HANDLED;
							}
						}
						else
						{
							// Non-implemented gift type or invalid
							DispatchKeyValue( index, "$i_mg_error", "4" );
							entity_set_edict( index, EV_ENT_euser1, 0 );
							return PLUGIN_HANDLED;
						}
					}
				}
			}
			else
			{
				// This gift does not belong to us
				DispatchKeyValue( index, "$i_mg_error", "5" );
				entity_set_edict( index, EV_ENT_euser1, 0 );
				return PLUGIN_HANDLED;
			}
		}
		else
		{
			// No gift here!
			DispatchKeyValue( index, "$i_mg_error", "1" );
			entity_set_edict( index, EV_ENT_euser1, 0 );
			return PLUGIN_HANDLED;
		}
	}
	else
	{
		// Invalid search type!
		DispatchKeyValue( index, "$i_mg_error", "4" );
		entity_set_edict( index, EV_ENT_euser1, 0 );
		return PLUGIN_HANDLED;
	}
	
	return PLUGIN_HANDLED;
}

public CheckGift( index, szData[] )
{
	// If the search was cancelled, don't bother
	if ( entity_get_edict( index, EV_ENT_euser1 ) == 0 || entity_get_edict( index, EV_ENT_euser1 ) != index )
		return PLUGIN_HANDLED;
	
	// Parse the data
	new szSearch[ 8 ], szLocate[ 32 ];
	
	replace_string( szData, 64, "*", " " );
	parse( szData, szSearch, charsmax( szSearch ), szLocate, charsmax( szLocate ) );
	
	// Search from...?
	if ( equal( szSearch, "SERVER" ) )
	{
		// Server search, use file instead
		new vaultkey[ 64 ];
		
		// Check if a gift exists
		new DateTime[ 12 ];
		get_time( "%d_%m", DateTime, charsmax( DateTime ) );
		format( vaultkey, charsmax( vaultkey ), "mg_%s-%s", DateTime, szLocate );
		
		if ( vaultdata_exists( vaultkey ) )
		{
			// A gift exists
			DispatchKeyValue( index, "$i_mg_check", "1" );
			entity_set_edict( index, EV_ENT_euser1, 0 );
			return PLUGIN_HANDLED;
		}
		else
		{
			// No gift here
			DispatchKeyValue( index, "$i_mg_check", "-1" );
			entity_set_edict( index, EV_ENT_euser1, 0 );
			return PLUGIN_HANDLED;
		}
	}
	else
	{
		// Invalid search type!
		client_print( index, print_chat, "* Error inesperado en el servidor" );
		entity_set_edict( index, EV_ENT_euser1, 0 );
		return PLUGIN_HANDLED;
	}
}

public CreateGift( index, szData[] )
{
	// If the search was cancelled, don't bother
	if ( entity_get_edict( index, EV_ENT_euser1 ) == 0 || entity_get_edict( index, EV_ENT_euser1 ) != index )
		return PLUGIN_HANDLED;
	
	// Parse the data
	new szSteamID[ 32 ];
	replace_string( szData, 512, "|", " " );
	parse( szData, szSteamID, charsmax( szSteamID ) );
	
	// Gift creations are server only, use file
	new vaultkey[ 64 ];
	
	// Prevent a duplicate by checking if there is a gift already created
	new DateTime[ 12 ];
	get_time( "%d_%m", DateTime, charsmax( DateTime ) );
	format( vaultkey, charsmax( vaultkey ), "mg-%s-%s", DateTime, szSteamID );
	
	if ( vaultdata_exists( vaultkey ) )
	{
		// The gift already exists! This should not happen
		DispatchKeyValue( index, "$i_mg_creation", "-1" );
		entity_set_edict( index, EV_ENT_euser1, 0 );
		return PLUGIN_HANDLED;
	}
	else
	{
		// Okay! Create gift
		format( vaultkey, charsmax( vaultkey ), "mg_%s-%s", DateTime, szSteamID );
		
		new pointer, szFile[ 128 ];
		replace_string( szSteamID, charsmax( szSteamID ), ":", "_" );
		format( szFile, charsmax( szFile ), "scripts/plugins/store/scxpm_event/MG_%s.sys", szSteamID );
		pointer = fopen( szFile, "r" );
		if ( pointer )
		{
			// Read & Write
			new mgStuff[ 256 ];
			fgets( pointer, mgStuff, charsmax( mgStuff ) );
			remove_quotes( mgStuff );
			set_vaultdata( vaultkey, mgStuff );
			fclose( pointer );
			delete_file( szFile );
		}
		else
		{
			// ERROR ERROR ERROR!
			DispatchKeyValue( index, "$i_mg_creation", "-1" );
			entity_set_edict( index, EV_ENT_euser1, 0 );
			return PLUGIN_HANDLED;
		}
		
		// Done!
		DispatchKeyValue( index, "$i_mg_creation", "1" );
		entity_set_edict( index, EV_ENT_euser1, 0 );
		return PLUGIN_HANDLED;
	}
}
