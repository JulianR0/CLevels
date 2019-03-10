/*
	CLevels (Imperium Sven Co-op's SCXPM): Achievements Handler
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

string szMap;

void PluginInit()
{
	g_Module.ScriptInfo.SetAuthor( "Julian \"Giegue\" Rodriguez" );
	g_Module.ScriptInfo.SetContactInfo( "www.steamcommunity.com/id/ngiegue" );
	
	// General achievements
	g_Scheduler.SetInterval( "a08_check", 0.20, g_Scheduler.REPEAT_INFINITE_TIMES );
	g_Scheduler.SetInterval( "a14_a53_a74_helper", 0.20, g_Scheduler.REPEAT_INFINITE_TIMES );
	g_Scheduler.SetInterval( "a44_check", 0.20, g_Scheduler.REPEAT_INFINITE_TIMES );
	g_Scheduler.SetInterval( "a62_a65_a167_check", 0.20, g_Scheduler.REPEAT_INFINITE_TIMES );
	g_Scheduler.SetInterval( "a93_check", 0.20, g_Scheduler.REPEAT_INFINITE_TIMES );
	
	// Helper for AMXX
	g_Scheduler.SetInterval( "rexp_helper", 0.20, g_Scheduler.REPEAT_INFINITE_TIMES );
}

void rexp_helper()
{
	CBaseEntity@ pEntity = null;
	while( ( @pEntity = g_EntityFuncs.FindEntityByClassname( pEntity, "monster_sentry" ) ) !is null )
	{
		// Is this monster player ally?
		if ( pEntity.IsPlayerAlly() )
			pEntity.pev.iuser4 = 1;
		else
			pEntity.pev.iuser4 = 0;
	}
	@pEntity = null;
	while( ( @pEntity = g_EntityFuncs.FindEntityByClassname( pEntity, "monster_miniturret" ) ) !is null )
	{
		// Is this monster player ally?
		if ( pEntity.IsPlayerAlly() )
			pEntity.pev.iuser4 = 1;
		else
			pEntity.pev.iuser4 = 0;
	}
	@pEntity = null;
	while( ( @pEntity = g_EntityFuncs.FindEntityByClassname( pEntity, "monster_turret" ) ) !is null )
	{
		// Is this monster player ally?
		if ( pEntity.IsPlayerAlly() )
			pEntity.pev.iuser4 = 1;
		else
			pEntity.pev.iuser4 = 0;
	}
	@pEntity = null;
	while( ( @pEntity = g_EntityFuncs.FindEntityByClassname( pEntity, "monster_robogrunt" ) ) !is null )
	{
		// Is this monster player ally?
		if ( pEntity.IsPlayerAlly() )
			pEntity.pev.iuser4 = 1;
		else
			pEntity.pev.iuser4 = 0;
	}
}

void a08_check()
{
	for ( int i = 1; i <= g_Engine.maxClients; i++ )
	{
		CBasePlayer@ pPlayer = g_PlayerFuncs.FindPlayerByIndex( i );
		
		if ( pPlayer !is null && pPlayer.IsConnected() )
		{
			// Check if the player has ALL handicaps activated
			CustomKeyvalues@ pCheck3 = pPlayer.GetCustomKeyvalues();
			
			CustomKeyvalue iHandicap01_pre( pCheck3.GetKeyvalue( "$i_handicap01" ) );
			CustomKeyvalue iHandicap02_pre( pCheck3.GetKeyvalue( "$i_handicap02" ) );
			CustomKeyvalue iHandicap03_pre( pCheck3.GetKeyvalue( "$i_handicap03" ) );
			CustomKeyvalue iHandicap04_pre( pCheck3.GetKeyvalue( "$i_handicap04" ) );
			CustomKeyvalue iHandicap05_pre( pCheck3.GetKeyvalue( "$i_handicap05" ) );
			CustomKeyvalue iHandicap06_pre( pCheck3.GetKeyvalue( "$i_handicap06" ) );
			CustomKeyvalue iHandicap07_pre( pCheck3.GetKeyvalue( "$i_handicap07" ) );
			CustomKeyvalue iHandicap08_pre( pCheck3.GetKeyvalue( "$i_handicap08" ) );
			CustomKeyvalue iHandicap09_pre( pCheck3.GetKeyvalue( "$i_handicap09" ) );
			CustomKeyvalue iHandicap10_pre( pCheck3.GetKeyvalue( "$i_handicap10" ) );
			CustomKeyvalue iHandicap11_pre( pCheck3.GetKeyvalue( "$i_handicap11" ) );
			CustomKeyvalue iHandicap12_pre( pCheck3.GetKeyvalue( "$i_handicap12" ) );
			CustomKeyvalue iHandicap13_pre( pCheck3.GetKeyvalue( "$i_handicap13" ) );
			
			int iHandicap01 = iHandicap01_pre.GetInteger();
			int iHandicap02 = iHandicap02_pre.GetInteger();
			int iHandicap03 = iHandicap03_pre.GetInteger();
			int iHandicap04 = iHandicap04_pre.GetInteger();
			int iHandicap05 = iHandicap05_pre.GetInteger();
			int iHandicap06 = iHandicap06_pre.GetInteger();
			int iHandicap07 = iHandicap07_pre.GetInteger();
			int iHandicap08 = iHandicap08_pre.GetInteger();
			int iHandicap09 = iHandicap09_pre.GetInteger();
			int iHandicap10 = iHandicap10_pre.GetInteger();
			int iHandicap11 = iHandicap11_pre.GetInteger();
			int iHandicap12 = iHandicap11_pre.GetInteger();
			int iHandicap13 = iHandicap11_pre.GetInteger();
			
			if ( iHandicap01 == 1 && iHandicap02 == 1 && iHandicap03 == 1 && iHandicap04 == 1 && iHandicap05 == 1 && iHandicap06 == 1 && iHandicap07 == 1 && iHandicap08 == 1 && iHandicap09 == 1 && iHandicap10 == 1 && iHandicap11 == 1 && iHandicap12 == 1 && iHandicap13 == 1 )
			{
				// To prevent abuse, player must have at least this much score
				if ( pPlayer.pev.frags >= 125.0 ) // This is just a generic score, as it may vary according to map
				{
					// Get!
					
					// On a later time, another achievement might need saving
					g_Scheduler.SetTimeout( "a08_unlock", 2.5, pPlayer.entindex() );
				}
			}
		}
	}
}

void a08_unlock( const int& in index )
{
	CBasePlayer@ pPlayer = g_PlayerFuncs.FindPlayerByIndex( index );
	if ( pPlayer !is null )
	{
		CustomKeyvalues@ pUnlock = pPlayer.GetCustomKeyvalues();
		pUnlock.SetKeyvalue( "$i_a_unlock", 9 );
	}
}

void a14_a53_a74_helper()
{
	// Locate kingpins (Achievement #14)
	CBaseEntity@ pEntity = null;
	while( ( @pEntity = g_EntityFuncs.FindEntityByClassname( pEntity, "monster_kingpin" ) ) !is null )
	{
		CBaseMonster@ pMonster = cast< CBaseMonster@ >( pEntity );
		
		// Get the current enemy and set it into PEV field so it can be gathered from cross-scripting
		if ( pMonster.m_hEnemy.GetEntity() !is null )
			@pMonster.pev.euser2 = ( pMonster.m_hEnemy.GetEntity() ).edict();
		else
			@pMonster.pev.euser2 = null;
	}
	
	// Repeat for other needed monsters (Achievement #53)
	@pEntity = null;
	while( ( @pEntity = g_EntityFuncs.FindEntityByClassname( pEntity, "monster_zombie" ) ) !is null )
	{
		CBaseMonster@ pMonster = cast< CBaseMonster@ >( pEntity );
		
		if ( pMonster.m_hEnemy.GetEntity() !is null )
			@pMonster.pev.euser2 = ( pMonster.m_hEnemy.GetEntity() ).edict();
		else
			@pMonster.pev.euser2 = null;
	}
	@pEntity = null;
	while( ( @pEntity = g_EntityFuncs.FindEntityByClassname( pEntity, "monster_zombie_barney" ) ) !is null )
	{
		CBaseMonster@ pMonster = cast< CBaseMonster@ >( pEntity );
		
		if ( pMonster.m_hEnemy.GetEntity() !is null )
			@pMonster.pev.euser2 = ( pMonster.m_hEnemy.GetEntity() ).edict();
		else
			@pMonster.pev.euser2 = null;
	}
	@pEntity = null;
	while( ( @pEntity = g_EntityFuncs.FindEntityByClassname( pEntity, "monster_zombie_soldier" ) ) !is null )
	{
		CBaseMonster@ pMonster = cast< CBaseMonster@ >( pEntity );
		
		if ( pMonster.m_hEnemy.GetEntity() !is null )
			@pMonster.pev.euser2 = ( pMonster.m_hEnemy.GetEntity() ).edict();
		else
			@pMonster.pev.euser2 = null;
	}
	
	// Achievement #74
	@pEntity = null;
	while( ( @pEntity = g_EntityFuncs.FindEntityByClassname( pEntity, "grenade" ) ) !is null )
	{
		pEntity.pev.netname = pEntity.pev.model;
	}
}

void a44_check()
{
	// Locate changelevel entity
	CBaseEntity@ pEntity = g_EntityFuncs.FindEntityByClassname( null, "trigger_changelevel" );
	
	// Only care for first entry (might cause either false positive or never unlocking)
	if ( pEntity !is null )
	{
		// Achievement already given?
		if ( pEntity.pev.iuser4 == 1 )
			return;
		
		// !!! NOT USE ONLY !!!
		if ( ( pEntity.pev.spawnflags & 2 ) != 0 )
			return;
		
		// Get the "center" of this brush entity
		Vector vecOrigin1;
		get_brush_entity_origin( pEntity, vecOrigin1 );
		
		// Check for nearby players
		for ( int i = 1; i <= g_Engine.maxClients; i++ )
		{
			CBasePlayer@ pPlayer = g_PlayerFuncs.FindPlayerByIndex( i );
			if ( pPlayer !is null && pPlayer.IsConnected() )
			{
				Vector vecOrigin2 = pPlayer.pev.origin;
				
				// Is the player near the end of a map?
				// We use a considerably high distance because the new achievement data
				// might be not saved on time before the actual changelevel occurs
				if ( ( vecOrigin1 - vecOrigin2 ).Length() <= 250.0 )
				{
					// Check for ANY headcrab near players
					CBaseEntity@ pHeadcrab = null;
					while( ( @pHeadcrab = g_EntityFuncs.FindEntityByClassname( pHeadcrab, "monster_headcrab" ) ) !is null )
					{
						// Is this headcrab near players?
						Vector vecOrigin3 = pHeadcrab.pev.origin;
						
						if ( ( vecOrigin2 - vecOrigin3 ).Length() <= 300.0 ) // Use higher distance as changelevel entity
						{
							// Yes, unlock for all nearby players
							CustomKeyvalues@ pUnlock = pPlayer.GetCustomKeyvalues();
							pUnlock.SetKeyvalue( "$i_a_unlock", 45 );
							
							// Declare achievement as given
							pEntity.pev.iuser4 = 1;
						}
					}
				}
			}
		}
	}
}

void a62_a65_a167_check()
{
	for ( int i = 1; i <= g_Engine.maxClients; i++ )
	{
		CBasePlayer@ pPlayer = g_PlayerFuncs.FindPlayerByIndex( i );
		
		if ( pPlayer !is null && pPlayer.IsConnected() )
		{
			CustomKeyvalues@ pCheck = pPlayer.GetCustomKeyvalues();
			
			// Get progress
			CustomKeyvalue iProgress01_pre( pCheck.GetKeyvalue( "$i_sys_a_62" ) );
			CustomKeyvalue iProgress02_pre( pCheck.GetKeyvalue( "$i_sys_a_65" ) );
			CustomKeyvalue iProgress03_pre( pCheck.GetKeyvalue( "$i_sys_a_167" ) );
			
			int iProgress1 = iProgress01_pre.GetInteger();
			int iProgress2 = iProgress02_pre.GetInteger();
			int iProgress3 = iProgress03_pre.GetInteger();
			iProgress1 += int( pPlayer.pev.vuser1.x );
			iProgress2 += int( pPlayer.pev.vuser1.y );
			iProgress3 += int( pPlayer.pev.vuser1.z );
			
			// Achievement #62
			if ( iProgress1 >= 10 )
			{
				// Get!
				pCheck.SetKeyvalue( "$i_a_unlock", 63 );
				
				// Reset, avoid looping
				pCheck.SetKeyvalue( "$i_sys_a_62", 0 );
			}
			else
			{
				// Store progress
				pCheck.SetKeyvalue( "$i_sys_a_62", iProgress1 );
			}
			
			// Achievement #65
			if ( iProgress2 >= 10 )
			{
				// Get!
				pCheck.SetKeyvalue( "$i_a_unlock", 66 );
				
				// Reset, avoid looping
				pCheck.SetKeyvalue( "$i_sys_a_65", 0 );
			}
			else
			{
				// Store progress
				pCheck.SetKeyvalue( "$i_sys_a_65", iProgress2 );
			}
			
			// Achievement #167
			if ( iProgress3 >= 666 )
			{
				// Get!
				pCheck.SetKeyvalue( "$i_a_unlock", 168 );
				
				// Reset, avoid looping
				pCheck.SetKeyvalue( "$i_sys_a_167", 0 );
			}
			else
			{
				// Store progress
				pCheck.SetKeyvalue( "$i_sys_a_167", iProgress3 );
			}
			
			pPlayer.pev.vuser1.x = 0.0;
			pPlayer.pev.vuser1.y = 0.0;
			pPlayer.pev.vuser1.z = 0.0;
		}
	}
}

void a93_check()
{
	for ( int i = 1; i <= g_Engine.maxClients; i++ )
	{
		CBasePlayer@ pPlayer = g_PlayerFuncs.FindPlayerByIndex( i );
		
		if ( pPlayer !is null && pPlayer.IsConnected() )
		{
			CustomKeyvalues@ pCheck = pPlayer.GetCustomKeyvalues();
			CustomKeyvalue flHoldTime_pre( pCheck.GetKeyvalue( "$f_a_holdtime" ) );
			
			if ( flHoldTime_pre.Exists() )
			{
				// Check if we are on a voltigore
				CBaseEntity@ pHolder = g_EntityFuncs.Instance( pPlayer.pev.groundentity );
				if ( pHolder !is null )
				{
					// Standing on voltigore?
					if ( pHolder.pev.classname == 'monster_alien_voltigore' )
					{
						// Alive?
						if ( pPlayer.IsAlive() )
						{
							// This is the same voltigore we are standing on?
							if ( pPlayer.pev.euser4 is pPlayer.pev.groundentity )
							{
								// Update hold time
								pCheck.SetKeyvalue( "$f_a_holdtime", g_Engine.time );
								
								// Enough time?
								CustomKeyvalue flGoalTime_pre( pCheck.GetKeyvalue( "$f_a_goaltime" ) );
								float flHoldTime = flHoldTime_pre.GetFloat();
								float flGoalTime = flGoalTime_pre.GetFloat();
								
								if ( flHoldTime >= flGoalTime )
								{
									// Look at my horse, my horse is amazing!
									pCheck.SetKeyvalue( "$i_a_unlock", 94 );
									
									// Reset...
									pCheck.SetKeyvalue( "$f_a_holdtime", g_Engine.time );
									pCheck.SetKeyvalue( "$f_a_goaltime", g_Engine.time + 30.0 );
								}
							}
							else
							{
								@pPlayer.pev.euser4 = pPlayer.pev.groundentity;
								
								pCheck.SetKeyvalue( "$f_a_holdtime", g_Engine.time );
								pCheck.SetKeyvalue( "$f_a_goaltime", g_Engine.time + 30.0 );
							}
						}
						else
						{
							pCheck.SetKeyvalue( "$f_a_holdtime", 0.0 );
							pCheck.SetKeyvalue( "$f_a_goaltime", g_Engine.time + 30.0 );
						}
					}
					else
					{
						pCheck.SetKeyvalue( "$f_a_holdtime", 0.0 );
						pCheck.SetKeyvalue( "$f_a_goaltime", g_Engine.time + 30.0 );
					}
				}
				else
				{
					pCheck.SetKeyvalue( "$f_a_holdtime", 0.0 );
					pCheck.SetKeyvalue( "$f_a_goaltime", g_Engine.time + 30.0 );
				}
			}
			else
			{
				// Initialize if doesn't exist
				pCheck.SetKeyvalue( "$f_a_holdtime", 0.0 );
				pCheck.SetKeyvalue( "$f_a_goaltime", g_Engine.time + 30.0 );
			}
			
			// Get progress
			CustomKeyvalue iProgress01_pre( pCheck.GetKeyvalue( "$i_sys_a_62" ) );
			CustomKeyvalue iProgress02_pre( pCheck.GetKeyvalue( "$i_sys_a_65" ) );
			
			int iProgress1 = iProgress01_pre.GetInteger();
			int iProgress2 = iProgress02_pre.GetInteger();
			iProgress1 += int( pPlayer.pev.vuser1.x );
			iProgress2 += int( pPlayer.pev.vuser1.y );
			
			// Achievement #62
			if ( iProgress1 >= 10 )
			{
				// Get!
				pCheck.SetKeyvalue( "$i_a_unlock", 63 );
				
				// Reset, avoid looping
				pCheck.SetKeyvalue( "$i_sys_a_62", 0 );
			}
			else
			{
				// Store progress
				pCheck.SetKeyvalue( "$i_sys_a_62", iProgress1 );
			}
			
			// Achievement #65
			if ( iProgress2 >= 10 )
			{
				// Get!
				pCheck.SetKeyvalue( "$i_a_unlock", 66 );
				
				// Reset, avoid looping
				pCheck.SetKeyvalue( "$i_sys_a_65", 0 );
			}
			else
			{
				// Store progress
				pCheck.SetKeyvalue( "$i_sys_a_65", iProgress2 );
			}
			
			pPlayer.pev.vuser1.x = 0.0;
			pPlayer.pev.vuser1.y = 0.0;
		}
	}
}

void MapActivate()
{
	// Map-specific achievements
	szMap = g_Engine.mapname;
	CBaseEntity@ pEntity = null;
	
	if ( szMap == 'assaultmesa2' )
	{
		@pEntity = g_EntityFuncs.Create( "info_target", g_vecZero, g_vecZero, false );
		pEntity.pev.targetname = "sys_adata";
		
		@pEntity = g_EntityFuncs.Create( "trigger_changevalue", g_vecZero, g_vecZero, false );
		pEntity.pev.targetname = "sentry_mm";
		pEntity.pev.target = "sys_adata";
		pEntity.KeyValue( "m_iszValueName", "$i_fail" );
		pEntity.KeyValue( "m_iszNewValue", "1" );
		pEntity.KeyValue( "m_iszValueType", "0" );
		
		@pEntity = g_EntityFuncs.Create( "trigger_changevalue", g_vecZero, g_vecZero, false );
		pEntity.pev.targetname = "tunnelgate_multi";
		pEntity.pev.target = "!activator";
		pEntity.KeyValue( "m_iszValueName", "$i_test" );
		pEntity.KeyValue( "m_iszNewValue", "1" );
		pEntity.KeyValue( "m_iszValueType", "0" );
		
		@pEntity = g_EntityFuncs.Create( "trigger_relay", g_vecZero, g_vecZero, false );
		pEntity.pev.targetname = "tunnel_gate_random";
		pEntity.pev.spawnflags = 1;
		pEntity.KeyValue( "killtarget", "tunnelgate_multi" );
		
		g_Scheduler.SetTimeout( "assaultmesa2_check", 0.1 );
		
		// Second achievement check
		g_Scheduler.SetTimeout( "assaultmesa2_d_check", 1.0 );
	}
	else if ( szMap == 'assaultmesa2-2' )
	{
		@pEntity = g_EntityFuncs.Create( "trigger_changevalue", g_vecZero, g_vecZero, false );
		pEntity.pev.targetname = "end_mm";
		pEntity.pev.target = "sys_adata";
		pEntity.KeyValue( "m_iszValueName", "$i_test" );
		pEntity.KeyValue( "m_iszNewValue", "1" );
		pEntity.KeyValue( "m_iszValueType", "0" );
		
		g_Scheduler.SetTimeout( "assaultmesa2_2_check", 0.1 );
	}
	else if ( szMap == 'sc_face' )
	{
		@pEntity = g_EntityFuncs.Create( "info_target", g_vecZero, g_vecZero, false );
		pEntity.pev.targetname = "sys_adata";
		
		@pEntity = g_EntityFuncs.Create( "trigger_changevalue", g_vecZero, g_vecZero, false );
		pEntity.pev.targetname = "end_msg";
		pEntity.pev.target = "sys_adata";
		pEntity.KeyValue( "m_iszValueName", "$i_test" );
		pEntity.KeyValue( "m_iszNewValue", "1" );
		pEntity.KeyValue( "m_iszValueType", "0" );
		
		g_Scheduler.SetTimeout( "sc_face_check", 0.1 );
	}
	else if ( szMap == '5minutes_b1' )
	{
		@pEntity = g_EntityFuncs.Create( "info_target", g_vecZero, g_vecZero, false );
		pEntity.pev.targetname = "sys_adata";
		
		@pEntity = g_EntityFuncs.Create( "trigger_changevalue", g_vecZero, g_vecZero, false );
		pEntity.pev.targetname = "text_zenbu";
		pEntity.pev.target = "sys_adata";
		pEntity.KeyValue( "m_iszValueName", "$i_test" );
		pEntity.KeyValue( "m_iszNewValue", "1" );
		pEntity.KeyValue( "m_iszValueType", "0" );
		
		g_Scheduler.SetTimeout( "F_5minutes_b1_check", 0.1 );
	}
	else if ( szMap == 'auspices' )
	{
		@pEntity = g_EntityFuncs.Create( "info_target", g_vecZero, g_vecZero, false );
		pEntity.pev.targetname = "sys_adata";
		
		@pEntity = g_EntityFuncs.Create( "trigger_changevalue", g_vecZero, g_vecZero, false );
		pEntity.pev.targetname = "finalass";
		pEntity.pev.target = "sys_adata";
		pEntity.KeyValue( "m_iszValueName", "noise" );
		pEntity.KeyValue( "m_iszNewValue", "ACTIVE" );
		pEntity.KeyValue( "m_iszValueType", "0" );
		
		@pEntity = g_EntityFuncs.Create( "trigger_changevalue", g_vecZero, g_vecZero, false );
		pEntity.pev.targetname = "multifinal12";
		pEntity.pev.target = "sys_adata";
		pEntity.KeyValue( "m_iszValueName", "noise" );
		pEntity.KeyValue( "m_iszNewValue", "FINISHED" );
		pEntity.KeyValue( "m_iszValueType", "0" );
		
		@pEntity = g_EntityFuncs.Create( "trigger_changevalue", g_vecZero, g_vecZero, false );
		pEntity.pev.targetname = "multifinal12";
		pEntity.pev.target = "sys_adata";
		pEntity.KeyValue( "m_iszValueName", "$i_test" );
		pEntity.KeyValue( "m_iszNewValue", "1" );
		pEntity.KeyValue( "m_iszValueType", "0" );
		
		g_Scheduler.SetTimeout( "auspices_check", 0.1 );
	}
	else if ( szMap == 'abandoned' )
	{
		@pEntity = g_EntityFuncs.Create( "info_target", g_vecZero, g_vecZero, false );
		pEntity.pev.targetname = "sys_adata";
		
		@pEntity = g_EntityFuncs.Create( "trigger_changevalue", g_vecZero, g_vecZero, false );
		pEntity.pev.targetname = "kaboom";
		pEntity.pev.target = "sys_adata";
		pEntity.KeyValue( "m_iszValueName", "$i_active" );
		pEntity.KeyValue( "m_iszNewValue", "1" );
		pEntity.KeyValue( "m_iszValueType", "0" );
		
		@pEntity = g_EntityFuncs.Create( "trigger_changevalue", g_vecZero, g_vecZero, false );
		pEntity.pev.targetname = "altendmessage1";
		pEntity.pev.target = "sys_adata";
		pEntity.KeyValue( "m_iszValueName", "$i_fail" );
		pEntity.KeyValue( "m_iszNewValue", "1" );
		pEntity.KeyValue( "m_iszValueType", "0" );
		
		@pEntity = g_EntityFuncs.Create( "trigger_changevalue", g_vecZero, g_vecZero, false );
		pEntity.pev.targetname = "end";
		pEntity.pev.target = "sys_adata";
		pEntity.KeyValue( "m_iszValueName", "$i_test" );
		pEntity.KeyValue( "m_iszNewValue", "1" );
		pEntity.KeyValue( "m_iszValueType", "0" );
		
		g_Scheduler.SetTimeout( "abandoned_check", 0.1 );
	}
	else if ( szMap == 'sc_frostfire_beta1' )
	{
		@pEntity = g_EntityFuncs.Create( "info_target", g_vecZero, g_vecZero, false );
		pEntity.pev.targetname = "sys_adata";
		
		@pEntity = g_EntityFuncs.Create( "trigger_changevalue", g_vecZero, g_vecZero, false );
		pEntity.pev.targetname = "boss1death1";
		pEntity.pev.target = "sys_adata";
		pEntity.KeyValue( "m_iszValueName", "$i_test" );
		pEntity.KeyValue( "m_iszNewValue", "1" );
		pEntity.KeyValue( "m_iszValueType", "0" );
		
		g_Scheduler.SetTimeout( "sc_frostfire_beta1_check", 0.1 );
	}
	else if ( szMap == 'toadsnatch' )
	{
		@pEntity = g_EntityFuncs.Create( "info_target", g_vecZero, g_vecZero, false );
		pEntity.pev.targetname = "sys_adata";
		
		@pEntity = g_EntityFuncs.Create( "trigger_changevalue", g_vecZero, g_vecZero, false );
		pEntity.pev.targetname = "normal_selected";
		pEntity.pev.target = "sys_adata";
		pEntity.KeyValue( "m_iszValueName", "$i_difficulty" );
		pEntity.KeyValue( "m_iszNewValue", "1" );
		pEntity.KeyValue( "m_iszValueType", "0" );
		
		@pEntity = g_EntityFuncs.Create( "trigger_changevalue", g_vecZero, g_vecZero, false );
		pEntity.pev.targetname = "hard_selected";
		pEntity.pev.target = "sys_adata";
		pEntity.KeyValue( "m_iszValueName", "$i_difficulty" );
		pEntity.KeyValue( "m_iszNewValue", "2" );
		pEntity.KeyValue( "m_iszValueType", "0" );
		
		@pEntity = g_EntityFuncs.Create( "trigger_changevalue", g_vecZero, g_vecZero, false );
		pEntity.pev.targetname = "extreme_selected";
		pEntity.pev.target = "sys_adata";
		pEntity.KeyValue( "m_iszValueName", "$i_difficulty" );
		pEntity.KeyValue( "m_iszNewValue", "3" );
		pEntity.KeyValue( "m_iszValueType", "0" );
		
		@pEntity = g_EntityFuncs.Create( "trigger_changevalue", g_vecZero, g_vecZero, false );
		pEntity.pev.targetname = "spawnshotgun";
		pEntity.pev.target = "!activator";
		pEntity.KeyValue( "m_iszValueName", "$i_weapons_found" );
		pEntity.KeyValue( "m_iszNewValue", "1" );
		pEntity.KeyValue( "m_iszValueType", "1" );
		
		@pEntity = g_EntityFuncs.Create( "trigger_changevalue", g_vecZero, g_vecZero, false );
		pEntity.pev.targetname = "spawnm16";
		pEntity.pev.target = "!activator";
		pEntity.KeyValue( "m_iszValueName", "$i_weapons_found" );
		pEntity.KeyValue( "m_iszNewValue", "1" );
		pEntity.KeyValue( "m_iszValueType", "1" );
		
		@pEntity = g_EntityFuncs.Create( "trigger_changevalue", g_vecZero, g_vecZero, false );
		pEntity.pev.targetname = "spawnspore";
		pEntity.pev.target = "!activator";
		pEntity.KeyValue( "m_iszValueName", "$i_weapons_found" );
		pEntity.KeyValue( "m_iszNewValue", "1" );
		pEntity.KeyValue( "m_iszValueType", "1" );
		
		@pEntity = g_EntityFuncs.Create( "trigger_changevalue", g_vecZero, g_vecZero, false );
		pEntity.pev.targetname = "spawnhornet";
		pEntity.pev.target = "!activator";
		pEntity.KeyValue( "m_iszValueName", "$i_weapons_found" );
		pEntity.KeyValue( "m_iszNewValue", "1" );
		pEntity.KeyValue( "m_iszValueType", "1" );
		
		@pEntity = g_EntityFuncs.Create( "trigger_changevalue", g_vecZero, g_vecZero, false );
		pEntity.pev.targetname = "spawncrossbow";
		pEntity.pev.target = "!activator";
		pEntity.KeyValue( "m_iszValueName", "$i_weapons_found" );
		pEntity.KeyValue( "m_iszNewValue", "1" );
		pEntity.KeyValue( "m_iszValueType", "1" );
		
		@pEntity = g_EntityFuncs.Create( "trigger_changevalue", g_vecZero, g_vecZero, false );
		pEntity.pev.targetname = "spawngauss";
		pEntity.pev.target = "!activator";
		pEntity.KeyValue( "m_iszValueName", "$i_weapons_found" );
		pEntity.KeyValue( "m_iszNewValue", "1" );
		pEntity.KeyValue( "m_iszValueType", "1" );
		
		@pEntity = g_EntityFuncs.Create( "trigger_changevalue", g_vecZero, g_vecZero, false );
		pEntity.pev.targetname = "spawnsniper";
		pEntity.pev.target = "!activator";
		pEntity.KeyValue( "m_iszValueName", "$i_weapons_found" );
		pEntity.KeyValue( "m_iszNewValue", "1" );
		pEntity.KeyValue( "m_iszValueType", "1" );
		
		@pEntity = g_EntityFuncs.Create( "trigger_changevalue", g_vecZero, g_vecZero, false );
		pEntity.pev.targetname = "spawnrevolver";
		pEntity.pev.target = "!activator";
		pEntity.KeyValue( "m_iszValueName", "$i_weapons_found" );
		pEntity.KeyValue( "m_iszNewValue", "1" );
		pEntity.KeyValue( "m_iszValueType", "1" );
		
		@pEntity = g_EntityFuncs.Create( "trigger_changevalue", g_vecZero, g_vecZero, false );
		pEntity.pev.targetname = "spawnrpg";
		pEntity.pev.target = "!activator";
		pEntity.KeyValue( "m_iszValueName", "$i_weapons_found" );
		pEntity.KeyValue( "m_iszNewValue", "1" );
		pEntity.KeyValue( "m_iszValueType", "1" );
		
		@pEntity = g_EntityFuncs.Create( "trigger_changevalue", g_vecZero, g_vecZero, false );
		pEntity.pev.targetname = "spawnsaw";
		pEntity.pev.target = "!activator";
		pEntity.KeyValue( "m_iszValueName", "$i_weapons_found" );
		pEntity.KeyValue( "m_iszNewValue", "1" );
		pEntity.KeyValue( "m_iszValueType", "1" );
		
		@pEntity = g_EntityFuncs.Create( "trigger_changevalue", g_vecZero, g_vecZero, false );
		pEntity.pev.targetname = "spawnuzi";
		pEntity.pev.target = "!activator";
		pEntity.KeyValue( "m_iszValueName", "$i_weapons_found" );
		pEntity.KeyValue( "m_iszNewValue", "1" );
		pEntity.KeyValue( "m_iszValueType", "1" );
		
		@pEntity = g_EntityFuncs.Create( "trigger_changevalue", g_vecZero, g_vecZero, false );
		pEntity.pev.targetname = "mapwon";
		pEntity.pev.target = "sys_adata";
		pEntity.KeyValue( "m_iszValueName", "$i_test" );
		pEntity.KeyValue( "m_iszNewValue", "1" );
		pEntity.KeyValue( "m_iszValueType", "0" );
		
		g_Scheduler.SetTimeout( "toadsnatch_check", 0.1 );
	}
	else if ( szMap == 'gausslabbeta2' )
	{
		// Find the intro teleport and allow trigger
		@pEntity = g_EntityFuncs.FindEntityByTargetname( null, "firstarea" );
		pEntity.pev.spawnflags = 32;
		pEntity.pev.target = "sys_timer";
		
		@pEntity = g_EntityFuncs.Create( "trigger_changevalue", g_vecZero, g_vecZero, false );
		pEntity.pev.targetname = "sys_timer";
		pEntity.pev.target = "!activator";
		pEntity.KeyValue( "m_iszValueName", "$i_active" );
		pEntity.KeyValue( "m_iszNewValue", "1" );
		pEntity.KeyValue( "m_iszValueType", "0" );
		
		// Ending teleport
		@pEntity = g_EntityFuncs.FindEntityByTargetname( null, "zoomzoomzoom111" );
		pEntity.pev.spawnflags = 32;
		pEntity.pev.target = "sys_finish";
		
		@pEntity = g_EntityFuncs.Create( "trigger_changevalue", g_vecZero, g_vecZero, false );
		pEntity.pev.targetname = "sys_finish";
		pEntity.pev.target = "!activator";
		pEntity.KeyValue( "m_iszValueName", "$i_finish" );
		pEntity.KeyValue( "m_iszNewValue", "1" );
		pEntity.KeyValue( "m_iszValueType", "0" );
		
		g_Scheduler.SetTimeout( "gausslabbeta2_check", 0.1 );
	}
	else if ( szMap == 'quarter' )
	{
		@pEntity = g_EntityFuncs.Create( "info_target", g_vecZero, g_vecZero, false );
		pEntity.pev.targetname = "sys_adata";
		
		@pEntity = g_EntityFuncs.Create( "trigger_changevalue", g_vecZero, g_vecZero, false );
		pEntity.pev.targetname = "difficulty_hard";
		pEntity.pev.target = "sys_adata";
		pEntity.KeyValue( "m_iszValueName", "$i_active" );
		pEntity.KeyValue( "m_iszNewValue", "1" );
		pEntity.KeyValue( "m_iszValueType", "0" );
		
		@pEntity = g_EntityFuncs.Create( "trigger_changevalue", g_vecZero, g_vecZero, false );
		pEntity.pev.targetname = "area4_lose";
		pEntity.pev.target = "sys_adata";
		pEntity.KeyValue( "m_iszValueName", "$i_fail" );
		pEntity.KeyValue( "m_iszNewValue", "1" );
		pEntity.KeyValue( "m_iszValueType", "0" );
		
		@pEntity = g_EntityFuncs.Create( "trigger_changevalue", g_vecZero, g_vecZero, false );
		pEntity.pev.targetname = "win";
		pEntity.pev.target = "sys_adata";
		pEntity.KeyValue( "m_iszValueName", "$i_test" );
		pEntity.KeyValue( "m_iszNewValue", "1" );
		pEntity.KeyValue( "m_iszValueType", "0" );
		
		g_Scheduler.SetTimeout( "quarter_check", 0.1 );
	}
	else if ( szMap == 'sc_persia' )
	{
		@pEntity = g_EntityFuncs.Create( "info_target", g_vecZero, g_vecZero, false );
		pEntity.pev.targetname = "sys_adata";
		
		@pEntity = g_EntityFuncs.Create( "trigger_changevalue", g_vecZero, g_vecZero, false );
		pEntity.pev.targetname = "texte_final";
		pEntity.pev.target = "sys_adata";
		pEntity.KeyValue( "m_iszValueName", "$i_test" );
		pEntity.KeyValue( "m_iszNewValue", "1" );
		pEntity.KeyValue( "m_iszValueType", "0" );
		
		g_Scheduler.SetTimeout( "sc_persia_check", 0.1 );
	}
	else if ( szMap == 'it_has_leaks' )
	{
		@pEntity = g_EntityFuncs.Create( "info_target", g_vecZero, g_vecZero, false );
		pEntity.pev.targetname = "sys_adata";
		
		@pEntity = g_EntityFuncs.Create( "trigger_changevalue", g_vecZero, g_vecZero, false );
		pEntity.pev.targetname = "it_end_text";
		pEntity.pev.target = "sys_adata";
		pEntity.KeyValue( "m_iszValueName", "$i_test" );
		pEntity.KeyValue( "m_iszNewValue", "1" );
		pEntity.KeyValue( "m_iszValueType", "0" );
		
		@pEntity = g_EntityFuncs.Create( "trigger_changevalue", g_vecZero, g_vecZero, false );
		pEntity.pev.targetname = "it_secret_disc_1";
		pEntity.pev.target = "sys_adata";
		pEntity.KeyValue( "m_iszValueName", "$i_secrets" );
		pEntity.KeyValue( "m_iszNewValue", "1" );
		pEntity.KeyValue( "m_iszValueType", "1" );
		
		@pEntity = g_EntityFuncs.Create( "trigger_changevalue", g_vecZero, g_vecZero, false );
		pEntity.pev.targetname = "it_secret_disc_2";
		pEntity.pev.target = "sys_adata";
		pEntity.KeyValue( "m_iszValueName", "$i_secrets" );
		pEntity.KeyValue( "m_iszNewValue", "1" );
		pEntity.KeyValue( "m_iszValueType", "1" );
		
		@pEntity = g_EntityFuncs.Create( "trigger_changevalue", g_vecZero, g_vecZero, false );
		pEntity.pev.targetname = "it_secret_disc_3";
		pEntity.pev.target = "sys_adata";
		pEntity.KeyValue( "m_iszValueName", "$i_secrets" );
		pEntity.KeyValue( "m_iszNewValue", "1" );
		pEntity.KeyValue( "m_iszValueType", "1" );
		
		@pEntity = g_EntityFuncs.Create( "trigger_changevalue", g_vecZero, g_vecZero, false );
		pEntity.pev.targetname = "it_secret_disc_4";
		pEntity.pev.target = "sys_adata";
		pEntity.KeyValue( "m_iszValueName", "$i_secrets" );
		pEntity.KeyValue( "m_iszNewValue", "1" );
		pEntity.KeyValue( "m_iszValueType", "1" );
		
		@pEntity = g_EntityFuncs.Create( "trigger_changevalue", g_vecZero, g_vecZero, false );
		pEntity.pev.targetname = "it_secret_disc_6";
		pEntity.pev.target = "sys_adata";
		pEntity.KeyValue( "m_iszValueName", "$i_secrets" );
		pEntity.KeyValue( "m_iszNewValue", "1" );
		pEntity.KeyValue( "m_iszValueType", "1" );
		
		@pEntity = g_EntityFuncs.Create( "trigger_changevalue", g_vecZero, g_vecZero, false );
		pEntity.pev.targetname = "it_secret_disc_7";
		pEntity.pev.target = "sys_adata";
		pEntity.KeyValue( "m_iszValueName", "$i_secrets" );
		pEntity.KeyValue( "m_iszNewValue", "1" );
		pEntity.KeyValue( "m_iszValueType", "1" );
		
		@pEntity = g_EntityFuncs.Create( "trigger_changevalue", g_vecZero, g_vecZero, false );
		pEntity.pev.targetname = "it_secret_disc_8";
		pEntity.pev.target = "sys_adata";
		pEntity.KeyValue( "m_iszValueName", "$i_secrets" );
		pEntity.KeyValue( "m_iszNewValue", "1" );
		pEntity.KeyValue( "m_iszValueType", "1" );
		
		@pEntity = g_EntityFuncs.Create( "trigger_changevalue", g_vecZero, g_vecZero, false );
		pEntity.pev.targetname = "it_secret_disc_9";
		pEntity.pev.target = "sys_adata";
		pEntity.KeyValue( "m_iszValueName", "$i_secrets" );
		pEntity.KeyValue( "m_iszNewValue", "1" );
		pEntity.KeyValue( "m_iszValueType", "1" );
		
		@pEntity = g_EntityFuncs.Create( "trigger_changevalue", g_vecZero, g_vecZero, false );
		pEntity.pev.targetname = "it_secret_disc_10";
		pEntity.pev.target = "sys_adata";
		pEntity.KeyValue( "m_iszValueName", "$i_secrets" );
		pEntity.KeyValue( "m_iszNewValue", "1" );
		pEntity.KeyValue( "m_iszValueType", "1" );
		
		@pEntity = g_EntityFuncs.Create( "trigger_changevalue", g_vecZero, g_vecZero, false );
		pEntity.pev.targetname = "it_secret_disc_11";
		pEntity.pev.target = "sys_adata";
		pEntity.KeyValue( "m_iszValueName", "$i_secrets" );
		pEntity.KeyValue( "m_iszNewValue", "1" );
		pEntity.KeyValue( "m_iszValueType", "1" );
		
		@pEntity = g_EntityFuncs.Create( "trigger_changevalue", g_vecZero, g_vecZero, false );
		pEntity.pev.targetname = "it_secret_disc_12";
		pEntity.pev.target = "sys_adata";
		pEntity.KeyValue( "m_iszValueName", "$i_secrets" );
		pEntity.KeyValue( "m_iszNewValue", "1" );
		pEntity.KeyValue( "m_iszValueType", "1" );
		
		@pEntity = g_EntityFuncs.Create( "trigger_changevalue", g_vecZero, g_vecZero, false );
		pEntity.pev.targetname = "it_secret_disc_13";
		pEntity.pev.target = "sys_adata";
		pEntity.KeyValue( "m_iszValueName", "$i_secrets" );
		pEntity.KeyValue( "m_iszNewValue", "1" );
		pEntity.KeyValue( "m_iszValueType", "1" );
		
		g_Scheduler.SetTimeout( "it_has_leaks_check", 0.1 );
	}
	else if ( szMap == 'mommamesa' )
	{
		@pEntity = g_EntityFuncs.Create( "info_target", g_vecZero, g_vecZero, false );
		pEntity.pev.targetname = "sys_adata";
		
		@pEntity = g_EntityFuncs.Create( "trigger_changevalue", g_vecZero, g_vecZero, false );
		pEntity.pev.targetname = "setdifficulty_nightmare";
		pEntity.pev.target = "sys_adata";
		pEntity.KeyValue( "m_iszValueName", "$i_difficulty" );
		pEntity.KeyValue( "m_iszNewValue", "1" );
		pEntity.KeyValue( "m_iszValueType", "0" );
		
		@pEntity = g_EntityFuncs.Create( "trigger_changevalue", g_vecZero, g_vecZero, false );
		pEntity.pev.targetname = "mm_ending";
		pEntity.pev.target = "sys_adata";
		pEntity.KeyValue( "m_iszValueName", "$i_best" );
		pEntity.KeyValue( "m_iszNewValue", "1" );
		pEntity.KeyValue( "m_iszValueType", "0" );
		
		@pEntity = g_EntityFuncs.Create( "trigger_changevalue", g_vecZero, g_vecZero, false );
		pEntity.pev.targetname = "mm_ending";
		pEntity.pev.target = "sys_adata";
		pEntity.KeyValue( "m_iszValueName", "$i_test" );
		pEntity.KeyValue( "m_iszNewValue", "1" );
		pEntity.KeyValue( "m_iszValueType", "0" );
		
		@pEntity = g_EntityFuncs.Create( "trigger_changevalue", g_vecZero, g_vecZero, false );
		pEntity.pev.targetname = "win_freezer_mm";
		pEntity.pev.target = "sys_adata";
		pEntity.KeyValue( "m_iszValueName", "$i_test" );
		pEntity.KeyValue( "m_iszNewValue", "1" );
		pEntity.KeyValue( "m_iszValueType", "0" );
		
		@pEntity = g_EntityFuncs.Create( "trigger_changevalue", g_vecZero, g_vecZero, false );
		pEntity.pev.targetname = "pizzacam_mm";
		pEntity.pev.target = "sys_adata";
		pEntity.KeyValue( "m_iszValueName", "$i_test" );
		pEntity.KeyValue( "m_iszNewValue", "1" );
		pEntity.KeyValue( "m_iszValueType", "0" );
		
		@pEntity = g_EntityFuncs.Create( "trigger_changevalue", g_vecZero, g_vecZero, false );
		pEntity.pev.targetname = "endgood_escapeseqmm";
		pEntity.pev.target = "!activator";
		pEntity.KeyValue( "m_iszValueName", "$i_escape" );
		pEntity.KeyValue( "m_iszNewValue", "1" );
		pEntity.KeyValue( "m_iszValueType", "0" );
		
		g_Scheduler.SetTimeout( "mommamesa_check", 0.1 );
	}
	else if ( szMap == 'never' )
	{
		@pEntity = g_EntityFuncs.Create( "info_target", g_vecZero, g_vecZero, false );
		pEntity.pev.targetname = "sys_adata";
		
		@pEntity = g_EntityFuncs.Create( "trigger_changevalue", g_vecZero, g_vecZero, false );
		pEntity.pev.targetname = "therealend_text1";
		pEntity.pev.target = "sys_adata";
		pEntity.KeyValue( "m_iszValueName", "$i_test" );
		pEntity.KeyValue( "m_iszNewValue", "1" );
		pEntity.KeyValue( "m_iszValueType", "0" );
		
		g_Scheduler.SetTimeout( "never_check", 0.1 );
	}
	else if ( szMap == 'gash' )
	{
		@pEntity = g_EntityFuncs.Create( "info_target", g_vecZero, g_vecZero, false );
		pEntity.pev.targetname = "sys_adata";
		
		@pEntity = g_EntityFuncs.Create( "trigger_changevalue", g_vecZero, g_vecZero, false );
		pEntity.pev.targetname = "endmm";
		pEntity.pev.target = "sys_adata";
		pEntity.KeyValue( "m_iszValueName", "$i_test" );
		pEntity.KeyValue( "m_iszNewValue", "1" );
		pEntity.KeyValue( "m_iszValueType", "0" );
		
		g_Scheduler.SetTimeout( "gash_check", 0.1 );
	}
	else if ( szMap == 'hostage' )
	{
		@pEntity = g_EntityFuncs.Create( "info_target", g_vecZero, g_vecZero, false );
		pEntity.pev.targetname = "sys_adata";
		
		@pEntity = g_EntityFuncs.Create( "trigger_changevalue", g_vecZero, g_vecZero, false );
		pEntity.pev.targetname = "alivetext";
		pEntity.pev.target = "sys_adata";
		pEntity.KeyValue( "m_iszValueName", "$i_test" );
		pEntity.KeyValue( "m_iszNewValue", "1" );
		pEntity.KeyValue( "m_iszValueType", "0" );
		
		g_Scheduler.SetTimeout( "hostage_check", 0.1 );
	}
	else if ( szMap == 'ub_nagoya_v2' )
	{
		// No info_target entity on this map since it relies only on !activator boxes
		
		@pEntity = g_EntityFuncs.Create( "multi_manager", g_vecZero, g_vecZero, false );
		pEntity.pev.targetname = "btn_seq00";
		pEntity.KeyValue( "fixer_boxes", "0" );
		
		@pEntity = g_EntityFuncs.Create( "trigger_changevalue", g_vecZero, g_vecZero, false );
		pEntity.pev.targetname = "fixer_boxes";
		pEntity.pev.target = "!activator";
		pEntity.KeyValue( "m_iszValueName", "$i_boxes" );
		pEntity.KeyValue( "m_iszNewValue", "1" );
		pEntity.KeyValue( "m_iszValueType", "1" );
		
		g_Scheduler.SetTimeout( "ub_nagoya_v2_check", 0.1 );
	}
	else if ( szMap == 'ub_iseki2' )
	{
		@pEntity = g_EntityFuncs.Create( "info_target", g_vecZero, g_vecZero, false );
		pEntity.pev.targetname = "sys_adata";
		
		@pEntity = g_EntityFuncs.Create( "trigger_changevalue", g_vecZero, g_vecZero, false );
		pEntity.pev.targetname = "txt_lboss";
		pEntity.pev.target = "sys_adata";
		pEntity.KeyValue( "m_iszValueName", "noise" );
		pEntity.KeyValue( "m_iszNewValue", "ACTIVE" );
		pEntity.KeyValue( "m_iszValueType", "0" );
		
		@pEntity = g_EntityFuncs.Create( "trigger_changevalue", g_vecZero, g_vecZero, false );
		pEntity.pev.targetname = "mm_last";
		pEntity.pev.target = "sys_adata";
		pEntity.KeyValue( "m_iszValueName", "$i_test" );
		pEntity.KeyValue( "m_iszNewValue", "1" );
		pEntity.KeyValue( "m_iszValueType", "0" );
		
		g_Scheduler.SetTimeout( "ub_iseki2_check", 0.1 );
	}
	else if ( szMap == 'deadsimpleneo2' )
	{
		@pEntity = g_EntityFuncs.Create( "info_target", g_vecZero, g_vecZero, false );
		pEntity.pev.targetname = "sys_adata";
		
		@pEntity = g_EntityFuncs.Create( "trigger_changevalue", g_vecZero, g_vecZero, false );
		pEntity.pev.targetname = "objective2t";
		pEntity.pev.target = "sys_adata";
		pEntity.KeyValue( "m_iszValueName", "$i_mode" );
		pEntity.KeyValue( "m_iszNewValue", "1" );
		pEntity.KeyValue( "m_iszValueType", "0" );
		
		@pEntity = g_EntityFuncs.Create( "trigger_changevalue", g_vecZero, g_vecZero, false );
		pEntity.pev.targetname = "objective4t";
		pEntity.pev.target = "sys_adata";
		pEntity.KeyValue( "m_iszValueName", "$i_mode" );
		pEntity.KeyValue( "m_iszNewValue", "2" );
		pEntity.KeyValue( "m_iszValueType", "0" );
		
		@pEntity = g_EntityFuncs.Create( "trigger_changevalue", g_vecZero, g_vecZero, false );
		pEntity.pev.targetname = "objective3t";
		pEntity.pev.target = "sys_adata";
		pEntity.KeyValue( "m_iszValueName", "$i_mode" );
		pEntity.KeyValue( "m_iszNewValue", "3" );
		pEntity.KeyValue( "m_iszValueType", "0" );
		
		@pEntity = g_EntityFuncs.Create( "trigger_changevalue", g_vecZero, g_vecZero, false );
		pEntity.pev.targetname = "endrelay";
		pEntity.pev.target = "sys_adata";
		pEntity.KeyValue( "m_iszValueName", "$i_test" );
		pEntity.KeyValue( "m_iszNewValue", "1" );
		pEntity.KeyValue( "m_iszValueType", "0" );
		
		g_Scheduler.SetTimeout( "deadsimpleneo2_check", 0.1 );
	}
	else if ( szMap == 'BlackMesaEPF' ) // FUCKING CAPS
	{
		// No info_target entity, only checking button
		
		@pEntity = g_EntityFuncs.Create( "trigger_changevalue", g_vecZero, g_vecZero, false );
		pEntity.pev.targetname = "miss4_pushbutton_mm";
		pEntity.pev.target = "!activator";
		pEntity.KeyValue( "m_iszValueName", "$i_pass" );
		pEntity.KeyValue( "m_iszNewValue", "1" );
		pEntity.KeyValue( "m_iszValueType", "0" );
		
		g_Scheduler.SetTimeout( "BlackMesaEPF_check", 0.1 );
	}
	else if ( szMap == 'sc_dark_seekers_final' )
	{
		// copy-paste a44
		g_Scheduler.SetTimeout( "sc_dark_seekers_final_check", 0.1 );
	}
	else if ( szMap == 'ub_megaman2' )
	{
		@pEntity = g_EntityFuncs.Create( "info_target", g_vecZero, g_vecZero, false );
		pEntity.pev.targetname = "sys_adata";
		
		@pEntity = g_EntityFuncs.Create( "trigger_changevalue", g_vecZero, g_vecZero, false );
		pEntity.pev.targetname = "roll_bns1";
		pEntity.pev.target = "sys_adata";
		pEntity.KeyValue( "m_iszValueName", "$i_weapons" );
		pEntity.KeyValue( "m_iszNewValue", "1" );
		pEntity.KeyValue( "m_iszValueType", "1" );
		
		@pEntity = g_EntityFuncs.Create( "trigger_changevalue", g_vecZero, g_vecZero, false );
		pEntity.pev.targetname = "roll_bns2";
		pEntity.pev.target = "sys_adata";
		pEntity.KeyValue( "m_iszValueName", "$i_weapons" );
		pEntity.KeyValue( "m_iszNewValue", "1" );
		pEntity.KeyValue( "m_iszValueType", "1" );
		
		@pEntity = g_EntityFuncs.Create( "trigger_changevalue", g_vecZero, g_vecZero, false );
		pEntity.pev.targetname = "roll_bns3";
		pEntity.pev.target = "sys_adata";
		pEntity.KeyValue( "m_iszValueName", "$i_weapons" );
		pEntity.KeyValue( "m_iszNewValue", "1" );
		pEntity.KeyValue( "m_iszValueType", "1" );
		
		g_Scheduler.SetTimeout( "ub_megaman2_check", 0.1 );
	}
	else if ( szMap == 'dc_inflight' )
	{
		@pEntity = g_EntityFuncs.Create( "info_target", g_vecZero, g_vecZero, false );
		pEntity.pev.targetname = "sys_adata";
		
		@pEntity = g_EntityFuncs.Create( "trigger_changevalue", g_vecZero, g_vecZero, false );
		pEntity.pev.targetname = "8min";
		pEntity.pev.target = "sys_adata";
		pEntity.KeyValue( "m_iszValueName", "$i_test" );
		pEntity.KeyValue( "m_iszNewValue", "1" );
		pEntity.KeyValue( "m_iszValueType", "0" );
		
		g_Scheduler.SetTimeout( "dc_inflight_check", 0.1 );
	}
	else if ( szMap == 'sandstone' )
	{
		@pEntity = g_EntityFuncs.Create( "info_target", g_vecZero, g_vecZero, false );
		pEntity.pev.targetname = "sys_adata";
		
		@pEntity = g_EntityFuncs.Create( "trigger_changevalue", g_vecZero, g_vecZero, false );
		pEntity.pev.targetname = "outro_mm";
		pEntity.pev.target = "sys_adata";
		pEntity.KeyValue( "m_iszValueName", "$i_test" );
		pEntity.KeyValue( "m_iszNewValue", "1" );
		pEntity.KeyValue( "m_iszValueType", "0" );
		
		g_Scheduler.SetTimeout( "sandstone_check", 0.1 );
	}
	else if ( szMap == 'sc_trollworld' )
	{
		@pEntity = g_EntityFuncs.Create( "info_target", g_vecZero, g_vecZero, false );
		pEntity.pev.targetname = "sys_adata";
		
		@pEntity = g_EntityFuncs.Create( "trigger_changevalue", g_vecZero, g_vecZero, false );
		pEntity.pev.targetname = "Endmissionwin";
		pEntity.pev.target = "!activator";
		pEntity.KeyValue( "m_iszValueName", "$i_escape" );
		pEntity.KeyValue( "m_iszNewValue", "1" );
		pEntity.KeyValue( "m_iszValueType", "0" );
		
		@pEntity = g_EntityFuncs.Create( "trigger_changevalue", g_vecZero, g_vecZero, false );
		pEntity.pev.targetname = "endgame_mm";
		pEntity.pev.target = "sys_adata";
		pEntity.KeyValue( "m_iszValueName", "$i_test" );
		pEntity.KeyValue( "m_iszNewValue", "1" );
		pEntity.KeyValue( "m_iszValueType", "0" );
		
		g_Scheduler.SetTimeout( "sc_trollworld_check", 0.1 );
	}
	else if ( szMap == 'ghost_buster' )
	{
		@pEntity = g_EntityFuncs.Create( "info_target", g_vecZero, g_vecZero, false );
		pEntity.pev.targetname = "sys_adata";
		
		@pEntity = g_EntityFuncs.Create( "trigger_changevalue", g_vecZero, g_vecZero, false );
		pEntity.pev.targetname = "endtxt1";
		pEntity.pev.target = "sys_adata";
		pEntity.KeyValue( "m_iszValueName", "$i_test" );
		pEntity.KeyValue( "m_iszNewValue", "1" );
		pEntity.KeyValue( "m_iszValueType", "0" );
		
		g_Scheduler.SetTimeout( "ghost_buster_check", 0.1 );
	}
	else if ( szMap == 'jumpers' )
	{
		@pEntity = g_EntityFuncs.Create( "info_target", g_vecZero, g_vecZero, false );
		pEntity.pev.targetname = "sys_adata";
		
		@pEntity = g_EntityFuncs.Create( "trigger_changevalue", g_vecZero, g_vecZero, false );
		pEntity.pev.targetname = "begin_game";
		pEntity.pev.target = "sys_adata";
		pEntity.KeyValue( "m_iszValueName", "$i_active" );
		pEntity.KeyValue( "m_iszNewValue", "1" );
		pEntity.KeyValue( "m_iszValueType", "0" );
		
		g_Scheduler.SetTimeout( "jumpers_check", 0.1 );
	}
	else if ( szMap == 'deluge_beta_v3' )
	{
		@pEntity = g_EntityFuncs.Create( "info_target", g_vecZero, g_vecZero, false );
		pEntity.pev.targetname = "sys_adata";
		
		@pEntity = g_EntityFuncs.Create( "trigger_changevalue", g_vecZero, g_vecZero, false );
		pEntity.pev.targetname = "normalmode";
		pEntity.pev.target = "sys_adata";
		pEntity.KeyValue( "m_iszValueName", "$i_difficulty" );
		pEntity.KeyValue( "m_iszNewValue", "1" );
		pEntity.KeyValue( "m_iszValueType", "0" );
		
		@pEntity = g_EntityFuncs.Create( "trigger_changevalue", g_vecZero, g_vecZero, false );
		pEntity.pev.targetname = "hardmode";
		pEntity.pev.target = "sys_adata";
		pEntity.KeyValue( "m_iszValueName", "$i_difficulty" );
		pEntity.KeyValue( "m_iszNewValue", "2" );
		pEntity.KeyValue( "m_iszValueType", "0" );
		
		@pEntity = g_EntityFuncs.Create( "trigger_changevalue", g_vecZero, g_vecZero, false );
		pEntity.pev.targetname = "uvmode";
		pEntity.pev.target = "sys_adata";
		pEntity.KeyValue( "m_iszValueName", "$i_difficulty" );
		pEntity.KeyValue( "m_iszNewValue", "3" );
		pEntity.KeyValue( "m_iszValueType", "0" );
		
		@pEntity = g_EntityFuncs.Create( "trigger_changevalue", g_vecZero, g_vecZero, false );
		pEntity.pev.targetname = "map_end";
		pEntity.pev.target = "sys_adata";
		pEntity.KeyValue( "m_iszValueName", "$i_test" );
		pEntity.KeyValue( "m_iszNewValue", "1" );
		pEntity.KeyValue( "m_iszValueType", "0" );
		
		@pEntity = g_EntityFuncs.Create( "trigger_changevalue", g_vecZero, g_vecZero, false );
		pEntity.pev.targetname = "map_end_hard";
		pEntity.pev.target = "sys_adata";
		pEntity.KeyValue( "m_iszValueName", "$i_test" );
		pEntity.KeyValue( "m_iszNewValue", "1" );
		pEntity.KeyValue( "m_iszValueType", "0" );
		
		@pEntity = g_EntityFuncs.Create( "trigger_changevalue", g_vecZero, g_vecZero, false );
		pEntity.pev.targetname = "map_end_uv";
		pEntity.pev.target = "sys_adata";
		pEntity.KeyValue( "m_iszValueName", "$i_test" );
		pEntity.KeyValue( "m_iszNewValue", "1" );
		pEntity.KeyValue( "m_iszValueType", "0" );
		
		g_Scheduler.SetTimeout( "deluge_beta_v3_check", 0.1 );
	}
	else if ( szMap == 'sciguard2' )
	{
		@pEntity = g_EntityFuncs.Create( "info_target", g_vecZero, g_vecZero, false );
		pEntity.pev.targetname = "sys_adata";
		
		@pEntity = g_EntityFuncs.Create( "trigger_changevalue", g_vecZero, g_vecZero, false );
		pEntity.pev.targetname = "win";
		pEntity.pev.target = "sys_adata";
		pEntity.KeyValue( "m_iszValueName", "$i_test" );
		pEntity.KeyValue( "m_iszNewValue", "1" );
		pEntity.KeyValue( "m_iszValueType", "0" );
		
		@pEntity = g_EntityFuncs.Create( "trigger_changevalue", g_vecZero, g_vecZero, false );
		pEntity.pev.targetname = "scidiesnd";
		pEntity.pev.target = "sys_adata";
		pEntity.KeyValue( "m_iszValueName", "$i_fail" );
		pEntity.KeyValue( "m_iszNewValue", "1" );
		pEntity.KeyValue( "m_iszValueType", "0" );
		
		g_Scheduler.SetTimeout( "sciguard2_check", 0.1 );
	}
	else if ( szMap == 'nm_uspninjas' )
	{
		@pEntity = g_EntityFuncs.Create( "info_target", g_vecZero, g_vecZero, false );
		pEntity.pev.targetname = "sys_adata";
		
		@pEntity = g_EntityFuncs.Create( "trigger_changevalue", g_vecZero, g_vecZero, false );
		pEntity.pev.targetname = "the_end";
		pEntity.pev.target = "sys_adata";
		pEntity.KeyValue( "m_iszValueName", "$i_test" );
		pEntity.KeyValue( "m_iszNewValue", "1" );
		pEntity.KeyValue( "m_iszValueType", "0" );
		
		g_Scheduler.SetTimeout( "nm_uspninjas_check", 0.1 );
	}
	else if ( szMap == 'fortified1' )
	{
		@pEntity = g_EntityFuncs.Create( "info_target", g_vecZero, g_vecZero, false );
		pEntity.pev.targetname = "sys_adata";
		
		@pEntity = g_EntityFuncs.Create( "trigger_changevalue", g_vecZero, g_vecZero, false );
		pEntity.pev.targetname = "normal_selected";
		pEntity.pev.target = "sys_adata";
		pEntity.KeyValue( "m_iszValueName", "$i_difficulty" );
		pEntity.KeyValue( "m_iszNewValue", "1" );
		pEntity.KeyValue( "m_iszValueType", "0" );
		
		@pEntity = g_EntityFuncs.Create( "trigger_changevalue", g_vecZero, g_vecZero, false );
		pEntity.pev.targetname = "hard_selected";
		pEntity.pev.target = "sys_adata";
		pEntity.KeyValue( "m_iszValueName", "$i_difficulty" );
		pEntity.KeyValue( "m_iszNewValue", "2" );
		pEntity.KeyValue( "m_iszValueType", "0" );
		
		@pEntity = g_EntityFuncs.Create( "trigger_changevalue", g_vecZero, g_vecZero, false );
		pEntity.pev.targetname = "ultra_selected";
		pEntity.pev.target = "sys_adata";
		pEntity.KeyValue( "m_iszValueName", "$i_difficulty" );
		pEntity.KeyValue( "m_iszNewValue", "3" );
		pEntity.KeyValue( "m_iszValueType", "0" );
		
		@pEntity = g_EntityFuncs.Create( "trigger_changevalue", g_vecZero, g_vecZero, false );
		pEntity.pev.targetname = "legend_selected";
		pEntity.pev.target = "sys_adata";
		pEntity.KeyValue( "m_iszValueName", "$i_survival" );
		pEntity.KeyValue( "m_iszNewValue", "1" );
		pEntity.KeyValue( "m_iszValueType", "0" );
		
		@pEntity = g_EntityFuncs.Create( "trigger_createentity", g_vecZero, g_vecZero, false );
		pEntity.pev.targetname = "timer_started";
		pEntity.KeyValue( "m_iszCrtEntChildClass", "trigger_changevalue" );
		pEntity.KeyValue( "m_iszCrtEntChildName", "resign_manager" );
		pEntity.KeyValue( "-target", "!activator" );
		pEntity.KeyValue( "-m_iszValueName", "$i_left" );
		pEntity.KeyValue( "-m_iszNewValue", "1" );
		pEntity.KeyValue( "-m_iszValueType", "0" );
		
		@pEntity = g_EntityFuncs.Create( "trigger_changevalue", g_vecZero, g_vecZero, false );
		pEntity.pev.targetname = "gocreditsgo_win";
		pEntity.pev.target = "sys_adata";
		pEntity.KeyValue( "m_iszValueName", "$i_test" );
		pEntity.KeyValue( "m_iszNewValue", "1" );
		pEntity.KeyValue( "m_iszValueType", "0" );
		
		g_Scheduler.SetTimeout( "fortified1_check", 0.1 );
	}
	else if ( szMap == 'exposedB1' ) // CAPS again...
	{
		@pEntity = g_EntityFuncs.Create( "info_target", g_vecZero, g_vecZero, false );
		pEntity.pev.targetname = "sys_adata";
		
		@pEntity = g_EntityFuncs.Create( "trigger_changevalue", g_vecZero, g_vecZero, false );
		pEntity.pev.targetname = "endgamemm";
		pEntity.pev.target = "sys_adata";
		pEntity.KeyValue( "m_iszValueName", "$i_test" );
		pEntity.KeyValue( "m_iszNewValue", "1" );
		pEntity.KeyValue( "m_iszValueType", "0" );
		
		g_Scheduler.SetTimeout( "exposedB1_check", 0.1 );
	}
	else if ( szMap == 'keen_birthday_part1_beta' )
	{
		// !activator check only
		
		@pEntity = g_EntityFuncs.Create( "trigger_changevalue", g_vecZero, g_vecZero, false );
		pEntity.pev.targetname = "gausswin";
		pEntity.pev.target = "!activator";
		pEntity.KeyValue( "m_iszValueName", "$i_clear" );
		pEntity.KeyValue( "m_iszNewValue", "1" );
		pEntity.KeyValue( "m_iszValueType", "0" );
		
		g_Scheduler.SetTimeout( "keen_birthday_part1_beta_check", 0.1 );
	}
	else if ( szMap == 'sc_phantasmish_beta' )
	{
		@pEntity = g_EntityFuncs.Create( "info_target", g_vecZero, g_vecZero, false );
		pEntity.pev.targetname = "sys_adata";
		
		@pEntity = g_EntityFuncs.Create( "trigger_changevalue", g_vecZero, g_vecZero, false );
		pEntity.pev.targetname = "boss_dead";
		pEntity.pev.target = "sys_adata";
		pEntity.KeyValue( "m_iszValueName", "$i_test" );
		pEntity.KeyValue( "m_iszNewValue", "1" );
		pEntity.KeyValue( "m_iszValueType", "0" );
		
		g_Scheduler.SetTimeout( "sc_phantasmish_beta_check", 0.1 );
	}
	else if ( szMap == 'skylined' )
	{
		@pEntity = g_EntityFuncs.Create( "info_target", Vector( 558.0, 160.0, 172.0 ), g_vecZero, false );
		pEntity.pev.targetname = "sys_adata";
		
		// distance check only
		
		// we need ANOTHER achievement...
		@pEntity = g_EntityFuncs.Create( "sporegrenade", Vector( 312.0, 540.0, -3000.0 ), g_vecZero, false );
		pEntity.pev.scale = 3.0;
		pEntity.pev.targetname = "the_spore";
		
		g_Scheduler.SetTimeout( "skylined_check", 0.1 );
	}
	else if ( szMap == '6doors' )
	{
		@pEntity = g_EntityFuncs.Create( "info_target", g_vecZero, g_vecZero, false );
		pEntity.pev.targetname = "sys_adata";
		
		@pEntity = g_EntityFuncs.Create( "trigger_changevalue", g_vecZero, g_vecZero, false );
		pEntity.pev.targetname = "puzz1_source";
		pEntity.pev.target = "!activator";
		pEntity.KeyValue( "m_iszValueName", "$i_puzzle1" );
		pEntity.KeyValue( "m_iszNewValue", "1" );
		pEntity.KeyValue( "m_iszValueType", "0" );
		
		@pEntity = g_EntityFuncs.Create( "trigger_changevalue", g_vecZero, g_vecZero, false );
		pEntity.pev.targetname = "puzz2_source";
		pEntity.pev.target = "!activator";
		pEntity.KeyValue( "m_iszValueName", "$i_puzzle2" );
		pEntity.KeyValue( "m_iszNewValue", "1" );
		pEntity.KeyValue( "m_iszValueType", "0" );
		
		@pEntity = g_EntityFuncs.Create( "trigger_changevalue", g_vecZero, g_vecZero, false );
		pEntity.pev.targetname = "puzz3_source";
		pEntity.pev.target = "!activator";
		pEntity.KeyValue( "m_iszValueName", "$i_puzzle3" );
		pEntity.KeyValue( "m_iszNewValue", "1" );
		pEntity.KeyValue( "m_iszValueType", "0" );
		
		@pEntity = g_EntityFuncs.Create( "trigger_changevalue", g_vecZero, g_vecZero, false );
		pEntity.pev.targetname = "puzz4_source";
		pEntity.pev.target = "!activator";
		pEntity.KeyValue( "m_iszValueName", "$i_puzzle4" );
		pEntity.KeyValue( "m_iszNewValue", "1" );
		pEntity.KeyValue( "m_iszValueType", "0" );
		
		@pEntity = g_EntityFuncs.Create( "trigger_changevalue", g_vecZero, g_vecZero, false );
		pEntity.pev.targetname = "puzz5_source";
		pEntity.pev.target = "!activator";
		pEntity.KeyValue( "m_iszValueName", "$i_puzzle5" );
		pEntity.KeyValue( "m_iszNewValue", "1" );
		pEntity.KeyValue( "m_iszValueType", "0" );
		
		@pEntity = g_EntityFuncs.Create( "trigger_changevalue", g_vecZero, g_vecZero, false );
		pEntity.pev.targetname = "puzz6_source";
		pEntity.pev.target = "!activator";
		pEntity.KeyValue( "m_iszValueName", "$i_puzzle6" );
		pEntity.KeyValue( "m_iszNewValue", "1" );
		pEntity.KeyValue( "m_iszValueType", "0" );
		
		@pEntity = g_EntityFuncs.Create( "trigger_changevalue", g_vecZero, g_vecZero, false );
		pEntity.pev.targetname = "bossdoor_mm";
		pEntity.pev.target = "sys_adata";
		pEntity.KeyValue( "m_iszValueName", "$i_test" );
		pEntity.KeyValue( "m_iszNewValue", "1" );
		pEntity.KeyValue( "m_iszValueType", "0" );
		
		g_Scheduler.SetTimeout( "F_6doors_check", 0.1 );
	}
	else if ( szMap == 'coldburn_beta' )
	{
		@pEntity = g_EntityFuncs.Create( "info_target", g_vecZero, g_vecZero, false );
		pEntity.pev.targetname = "sys_adata";
		
		@pEntity = g_EntityFuncs.Create( "trigger_changevalue", g_vecZero, g_vecZero, false );
		pEntity.pev.targetname = "escape";
		pEntity.pev.target = "sys_adata";
		pEntity.KeyValue( "m_iszValueName", "$i_test" );
		pEntity.KeyValue( "m_iszNewValue", "1" );
		pEntity.KeyValue( "m_iszValueType", "0" );
		
		g_Scheduler.SetTimeout( "coldburn_beta_check", 0.1 );
	}
	else if ( szMap == 'gordonsci2' )
	{
		@pEntity = g_EntityFuncs.Create( "info_target", g_vecZero, g_vecZero, false );
		pEntity.pev.targetname = "sys_adata";
		
		@pEntity = g_EntityFuncs.Create( "trigger_changevalue", g_vecZero, g_vecZero, false );
		pEntity.pev.targetname = "openforgdondoor";
		pEntity.pev.target = "sys_adata";
		pEntity.KeyValue( "m_iszValueName", "$i_test" );
		pEntity.KeyValue( "m_iszNewValue", "1" );
		pEntity.KeyValue( "m_iszValueType", "0" );
		
		@pEntity = g_EntityFuncs.Create( "trigger_changevalue", g_vecZero, g_vecZero, false );
		pEntity.pev.targetname = "gordonhasdiedomg";
		pEntity.pev.target = "sys_adata";
		pEntity.KeyValue( "m_iszValueName", "$i_fail" );
		pEntity.KeyValue( "m_iszNewValue", "1" );
		pEntity.KeyValue( "m_iszValueType", "0" );
		
		g_Scheduler.SetTimeout( "gordonsci2_check", 0.1 );
	}
	else if ( szMap == 'canyondoom4' )
	{
		@pEntity = g_EntityFuncs.Create( "info_target", g_vecZero, g_vecZero, false );
		pEntity.pev.targetname = "sys_adata";
		
		@pEntity = g_EntityFuncs.Create( "trigger_changevalue", g_vecZero, g_vecZero, false );
		pEntity.pev.targetname = "winmusic";
		pEntity.pev.target = "sys_adata";
		pEntity.KeyValue( "m_iszValueName", "$i_test" );
		pEntity.KeyValue( "m_iszNewValue", "1" );
		pEntity.KeyValue( "m_iszValueType", "0" );
		
		@pEntity = g_EntityFuncs.Create( "trigger_changevalue", g_vecZero, g_vecZero, false );
		pEntity.pev.targetname = "lose";
		pEntity.pev.target = "sys_adata";
		pEntity.KeyValue( "m_iszValueName", "$i_fail" );
		pEntity.KeyValue( "m_iszNewValue", "1" );
		pEntity.KeyValue( "m_iszValueType", "0" );
		
		g_Scheduler.SetTimeout( "canyondoom4_check", 0.1 );
	}
	else if ( szMap == 'sc_defmap_v3' )
	{
		@pEntity = g_EntityFuncs.Create( "info_target", g_vecZero, g_vecZero, false );
		pEntity.pev.targetname = "sys_adata";
		
		@pEntity = g_EntityFuncs.Create( "trigger_changevalue", g_vecZero, g_vecZero, false );
		pEntity.pev.targetname = "genfailmsg";
		pEntity.pev.target = "sys_adata";
		pEntity.KeyValue( "m_iszValueName", "$i_norepair" );
		pEntity.KeyValue( "m_iszNewValue", "1" );
		pEntity.KeyValue( "m_iszValueType", "0" );
		
		@pEntity = g_EntityFuncs.Create( "trigger_changevalue", g_vecZero, g_vecZero, false );
		pEntity.pev.targetname = "genrepmsg";
		pEntity.pev.target = "sys_adata";
		pEntity.KeyValue( "m_iszValueName", "$i_norepair" );
		pEntity.KeyValue( "m_iszNewValue", "0" );
		pEntity.KeyValue( "m_iszValueType", "0" );
		
		@pEntity = g_EntityFuncs.Create( "trigger_changevalue", g_vecZero, g_vecZero, false );
		pEntity.pev.targetname = "wmsg1";
		pEntity.pev.target = "sys_adata";
		pEntity.KeyValue( "m_iszValueName", "$i_test" );
		pEntity.KeyValue( "m_iszNewValue", "1" );
		pEntity.KeyValue( "m_iszValueType", "0" );
		
		g_Scheduler.SetTimeout( "sc_defmap_v3_check", 0.1 );
	}
	else if ( szMap == 'io_v1' )
	{
		@pEntity = g_EntityFuncs.Create( "info_target", g_vecZero, g_vecZero, false );
		pEntity.pev.targetname = "sys_adata";
		
		@pEntity = g_EntityFuncs.Create( "trigger_changevalue", g_vecZero, g_vecZero, false );
		pEntity.pev.targetname = "end_cam1";
		pEntity.pev.target = "sys_adata";
		pEntity.KeyValue( "m_iszValueName", "$i_test" );
		pEntity.KeyValue( "m_iszNewValue", "1" );
		pEntity.KeyValue( "m_iszValueType", "0" );
		
		g_Scheduler.SetTimeout( "io_v1_check", 0.1 );
	}
	else if ( szMap == 'projectg7' )
	{
		// !activator only check
		
		@pEntity = g_EntityFuncs.Create( "trigger_changevalue", g_vecZero, g_vecZero, false );
		pEntity.pev.targetname = "scrt_swtch1_mm";
		pEntity.pev.target = "!activator";
		pEntity.KeyValue( "m_iszValueName", "$i_buttons" );
		pEntity.KeyValue( "m_iszNewValue", "1" );
		pEntity.KeyValue( "m_iszValueType", "1" );
		
		@pEntity = g_EntityFuncs.Create( "trigger_changevalue", g_vecZero, g_vecZero, false );
		pEntity.pev.targetname = "scrt_swtch2_mm";
		pEntity.pev.target = "!activator";
		pEntity.KeyValue( "m_iszValueName", "$i_buttons" );
		pEntity.KeyValue( "m_iszNewValue", "1" );
		pEntity.KeyValue( "m_iszValueType", "1" );
		
		@pEntity = g_EntityFuncs.Create( "trigger_changevalue", g_vecZero, g_vecZero, false );
		pEntity.pev.targetname = "scrt_swtch3_mm";
		pEntity.pev.target = "!activator";
		pEntity.KeyValue( "m_iszValueName", "$i_buttons" );
		pEntity.KeyValue( "m_iszNewValue", "1" );
		pEntity.KeyValue( "m_iszValueType", "1" );
		
		@pEntity = g_EntityFuncs.Create( "trigger_changevalue", g_vecZero, g_vecZero, false );
		pEntity.pev.targetname = "pg7_scrtmp_mm";
		pEntity.pev.target = "!activator";
		pEntity.KeyValue( "m_iszValueName", "$i_test" );
		pEntity.KeyValue( "m_iszNewValue", "1" );
		pEntity.KeyValue( "m_iszValueType", "0" );
		
		g_Scheduler.SetTimeout( "projectg7_check", 0.1 );
	}
	else if ( szMap == 'svencoop2' )
	{
		@pEntity = g_EntityFuncs.Create( "info_target", g_vecZero, g_vecZero, false );
		pEntity.pev.targetname = "sys_adata";
		
		@pEntity = g_EntityFuncs.Create( "trigger_changevalue", g_vecZero, g_vecZero, false );
		pEntity.pev.targetname = "grugam_secret";
		pEntity.pev.target = "!activator";
		pEntity.KeyValue( "m_iszValueName", "$i_secret" );
		pEntity.KeyValue( "m_iszNewValue", "1" );
		pEntity.KeyValue( "m_iszValueType", "0" );
		
		@pEntity = g_EntityFuncs.Create( "trigger_changevalue", g_vecZero, g_vecZero, false );
		pEntity.pev.targetname = "grugam_left";
		pEntity.pev.target = "!activator";
		pEntity.KeyValue( "m_iszValueName", "$i_buttons" );
		pEntity.KeyValue( "m_iszNewValue", "1" );
		pEntity.KeyValue( "m_iszValueType", "1" );
		
		@pEntity = g_EntityFuncs.Create( "trigger_changevalue", g_vecZero, g_vecZero, false );
		pEntity.pev.targetname = "grugam_right";
		pEntity.pev.target = "!activator";
		pEntity.KeyValue( "m_iszValueName", "$i_buttons" );
		pEntity.KeyValue( "m_iszNewValue", "1" );
		pEntity.KeyValue( "m_iszValueType", "1" );
		
		@pEntity = g_EntityFuncs.Create( "trigger_changevalue", g_vecZero, g_vecZero, false );
		pEntity.pev.targetname = "grugam_win";
		pEntity.pev.target = "sys_adata";
		pEntity.KeyValue( "m_iszValueName", "$i_test" );
		pEntity.KeyValue( "m_iszNewValue", "1" );
		pEntity.KeyValue( "m_iszValueType", "0" );
		
		g_Scheduler.SetTimeout( "svencoop2_check", 0.1 );
	}
	else if ( szMap == 'thewinery' )
	{
		@pEntity = g_EntityFuncs.Create( "info_target", g_vecZero, g_vecZero, false );
		pEntity.pev.targetname = "sys_adata";
		
		@pEntity = g_EntityFuncs.Create( "trigger_changevalue", g_vecZero, g_vecZero, false );
		pEntity.pev.targetname = "endgameTR";
		pEntity.pev.target = "sys_adata";
		pEntity.KeyValue( "m_iszValueName", "$i_test" );
		pEntity.KeyValue( "m_iszNewValue", "1" );
		pEntity.KeyValue( "m_iszValueType", "0" );
		
		g_Scheduler.SetTimeout( "thewinery_check", 0.1 );
	}
	else if ( szMap == 'def_hakase' )
	{
		@pEntity = g_EntityFuncs.Create( "info_target", g_vecZero, g_vecZero, false );
		pEntity.pev.targetname = "sys_adata";
		
		@pEntity = g_EntityFuncs.Create( "trigger_changevalue", g_vecZero, g_vecZero, false );
		pEntity.pev.targetname = "endmgr";
		pEntity.pev.target = "sys_adata";
		pEntity.KeyValue( "m_iszValueName", "$i_test" );
		pEntity.KeyValue( "m_iszNewValue", "1" );
		pEntity.KeyValue( "m_iszValueType", "0" );
		
		g_Scheduler.SetTimeout( "def_hakase_check", 0.1 );
	}
	else if ( szMap == 'sc_downunder' )
	{
		@pEntity = g_EntityFuncs.Create( "info_target", g_vecZero, g_vecZero, false );
		pEntity.pev.targetname = "sys_adata";
		
		@pEntity = g_EntityFuncs.Create( "trigger_changevalue", g_vecZero, g_vecZero, false );
		pEntity.pev.targetname = "schleuse1";
		pEntity.pev.target = "sys_adata";
		pEntity.KeyValue( "m_iszValueName", "$i_test" );
		pEntity.KeyValue( "m_iszNewValue", "1" );
		pEntity.KeyValue( "m_iszValueType", "0" );
		
		g_Scheduler.SetTimeout( "sc_downunder_check", 0.1 );
	}
	else if ( szMap == 'tox_silo' )
	{
		@pEntity = g_EntityFuncs.Create( "info_target", g_vecZero, g_vecZero, false );
		pEntity.pev.targetname = "sys_adata";
		
		@pEntity = g_EntityFuncs.Create( "trigger_changevalue", g_vecZero, g_vecZero, false );
		pEntity.pev.targetname = "end00mm";
		pEntity.pev.target = "sys_adata";
		pEntity.KeyValue( "m_iszValueName", "$i_test" );
		pEntity.KeyValue( "m_iszNewValue", "1" );
		pEntity.KeyValue( "m_iszValueType", "0" );
		
		g_Scheduler.SetTimeout( "tox_silo_check", 0.1 );
	}
	else if ( szMap == 'zero' )
	{
		@pEntity = g_EntityFuncs.Create( "info_target", g_vecZero, g_vecZero, false );
		pEntity.pev.targetname = "sys_adata";
		
		@pEntity = g_EntityFuncs.Create( "trigger_changevalue", g_vecZero, g_vecZero, false );
		pEntity.pev.targetname = "saving";
		pEntity.pev.target = "sys_adata";
		pEntity.KeyValue( "m_iszValueName", "$i_test" );
		pEntity.KeyValue( "m_iszNewValue", "1" );
		pEntity.KeyValue( "m_iszValueType", "0" );
		
		g_Scheduler.SetTimeout( "zero_check", 0.1 );
	}
	else if ( szMap == 'cs_galleon-f' )
	{
		@pEntity = g_EntityFuncs.Create( "info_target", g_vecZero, g_vecZero, false );
		pEntity.pev.targetname = "sys_adata";
		
		@pEntity = g_EntityFuncs.Create( "trigger_changevalue", g_vecZero, g_vecZero, false );
		pEntity.pev.targetname = "texto_1"; // Ending happens at the same time than game_end, that won't do
		pEntity.pev.target = "sys_adata";
		pEntity.KeyValue( "m_iszValueName", "$i_test" );
		pEntity.KeyValue( "m_iszNewValue", "1" );
		pEntity.KeyValue( "m_iszValueType", "0" );
		
		g_Scheduler.SetTimeout( "cs_galleon_f_check", 0.1 );
	}
	else if ( szMap == 'clockwork' )
	{
		@pEntity = g_EntityFuncs.Create( "info_target", g_vecZero, g_vecZero, false );
		pEntity.pev.targetname = "sys_adata";
		
		@pEntity = g_EntityFuncs.Create( "trigger_changevalue", g_vecZero, g_vecZero, false );
		pEntity.pev.targetname = "finaldoor";
		pEntity.pev.target = "sys_adata";
		pEntity.KeyValue( "m_iszValueName", "$i_test" );
		pEntity.KeyValue( "m_iszNewValue", "1" );
		pEntity.KeyValue( "m_iszValueType", "0" );
		
		g_Scheduler.SetTimeout( "clockwork_check", 0.1 );
	}
	else if ( szMap == 'ub_megaman' )
	{
		@pEntity = g_EntityFuncs.Create( "info_target", g_vecZero, g_vecZero, false );
		pEntity.pev.targetname = "sys_adata";
		
		@pEntity = g_EntityFuncs.Create( "trigger_changevalue", g_vecZero, g_vecZero, false );
		pEntity.pev.targetname = "mon_mon7";
		pEntity.pev.target = "sys_adata";
		pEntity.KeyValue( "m_iszValueName", "noise" );
		pEntity.KeyValue( "m_iszNewValue", "ACTIVE" );
		pEntity.KeyValue( "m_iszValueType", "0" );
		
		@pEntity = g_EntityFuncs.Create( "trigger_changevalue", g_vecZero, g_vecZero, false );
		pEntity.pev.targetname = "rly_mm_bossclea";
		pEntity.pev.target = "sys_adata";
		pEntity.KeyValue( "m_iszValueName", "noise" );
		pEntity.KeyValue( "m_iszNewValue", "FINISH" );
		pEntity.KeyValue( "m_iszValueType", "0" );
		
		@pEntity = g_EntityFuncs.Create( "trigger_changevalue", g_vecZero, g_vecZero, false );
		pEntity.pev.targetname = "rly_mm_bossclea";
		pEntity.pev.target = "sys_adata";
		pEntity.KeyValue( "m_iszValueName", "$i_test" );
		pEntity.KeyValue( "m_iszNewValue", "1" );
		pEntity.KeyValue( "m_iszValueType", "0" );
		
		g_Scheduler.SetTimeout( "ub_megaman_check", 0.1 );
	}
	else if ( szMap == 'pointless_b2' )
	{
		@pEntity = g_EntityFuncs.Create( "info_target", g_vecZero, g_vecZero, false );
		pEntity.pev.targetname = "sys_adata";
		
		@pEntity = g_EntityFuncs.Create( "trigger_changevalue", g_vecZero, g_vecZero, false );
		pEntity.pev.targetname = "msg02n";
		pEntity.pev.target = "!activator";
		pEntity.KeyValue( "m_iszValueName", "$i_test" );
		pEntity.KeyValue( "m_iszNewValue", "1" );
		pEntity.KeyValue( "m_iszValueType", "0" );
		
		@pEntity = g_EntityFuncs.Create( "trigger_changevalue", g_vecZero, g_vecZero, false );
		pEntity.pev.targetname = "reset01m";
		pEntity.pev.target = "sys_adata";
		pEntity.KeyValue( "m_iszValueName", "$i_fail" );
		pEntity.KeyValue( "m_iszNewValue", "1" );
		pEntity.KeyValue( "m_iszValueType", "0" );
		
		g_Scheduler.SetTimeout( "pointless_b2_check", 0.1 );
	}
	else if ( szMap == 'syowa_japan' )
	{
		@pEntity = g_EntityFuncs.Create( "info_target", g_vecZero, g_vecZero, false );
		pEntity.pev.targetname = "sys_adata";
		
		@pEntity = g_EntityFuncs.Create( "trigger_changevalue", g_vecZero, g_vecZero, false );
		pEntity.pev.targetname = "seisinnokabe";
		pEntity.pev.target = "sys_adata";
		pEntity.KeyValue( "m_iszValueName", "$i_active" );
		pEntity.KeyValue( "m_iszNewValue", "1" );
		pEntity.KeyValue( "m_iszValueType", "0" );
		
		@pEntity = g_EntityFuncs.Create( "trigger_changevalue", g_vecZero, g_vecZero, false );
		pEntity.pev.targetname = "syouri";
		pEntity.pev.target = "sys_adata";
		pEntity.KeyValue( "m_iszValueName", "$i_test" );
		pEntity.KeyValue( "m_iszNewValue", "1" );
		pEntity.KeyValue( "m_iszValueType", "0" );
		
		g_Scheduler.SetTimeout( "syowa_japan_check", 0.1 );
	}
	else if ( szMap == 'sc_trapped2' )
	{
		@pEntity = g_EntityFuncs.Create( "info_target", g_vecZero, g_vecZero, false );
		pEntity.pev.targetname = "sys_adata";
		
		@pEntity = g_EntityFuncs.Create( "trigger_changevalue", g_vecZero, g_vecZero, false );
		pEntity.pev.targetname = "bylem";
		pEntity.pev.target = "sys_adata";
		pEntity.KeyValue( "m_iszValueName", "$i_test" );
		pEntity.KeyValue( "m_iszNewValue", "1" );
		pEntity.KeyValue( "m_iszValueType", "0" );
		
		g_Scheduler.SetTimeout( "sc_trapped2_check", 0.1 );
	}
	else if ( szMap == 'dreamstairs_v3' )
	{
		@pEntity = g_EntityFuncs.Create( "info_target", g_vecZero, g_vecZero, false );
		pEntity.pev.targetname = "sys_adata";
		
		@pEntity = g_EntityFuncs.Create( "trigger_changevalue", g_vecZero, g_vecZero, false );
		pEntity.pev.targetname = "glass";
		pEntity.pev.target = "sys_adata";
		pEntity.KeyValue( "m_iszValueName", "$i_test" );
		pEntity.KeyValue( "m_iszNewValue", "1" );
		pEntity.KeyValue( "m_iszValueType", "0" );
		
		g_Scheduler.SetTimeout( "dreamstairs_v3_check", 0.1 );
	}
	else if ( szMap == 'sc_fortress' )
	{
		@pEntity = g_EntityFuncs.Create( "info_target", g_vecZero, g_vecZero, false );
		pEntity.pev.targetname = "sys_adata";
		
		@pEntity = g_EntityFuncs.Create( "trigger_changevalue", g_vecZero, g_vecZero, false );
		pEntity.pev.targetname = "tankmgr1";
		pEntity.pev.target = "sys_adata";
		pEntity.KeyValue( "m_iszValueName", "$i_fail" );
		pEntity.KeyValue( "m_iszNewValue", "1" );
		pEntity.KeyValue( "m_iszValueType", "0" );
		
		@pEntity = g_EntityFuncs.Create( "trigger_changevalue", g_vecZero, g_vecZero, false );
		pEntity.pev.targetname = "tankyard2mgr";
		pEntity.pev.target = "sys_adata";
		pEntity.KeyValue( "m_iszValueName", "$i_fail" );
		pEntity.KeyValue( "m_iszNewValue", "1" );
		pEntity.KeyValue( "m_iszValueType", "0" );
		
		@pEntity = g_EntityFuncs.Create( "trigger_changevalue", g_vecZero, g_vecZero, false );
		pEntity.pev.targetname = "entspnmm1";
		pEntity.pev.target = "sys_adata";
		pEntity.KeyValue( "m_iszValueName", "$i_fail" );
		pEntity.KeyValue( "m_iszNewValue", "1" );
		pEntity.KeyValue( "m_iszValueType", "0" );
		
		@pEntity = g_EntityFuncs.Create( "trigger_changevalue", g_vecZero, g_vecZero, false );
		pEntity.pev.targetname = "entspnmm2";
		pEntity.pev.target = "sys_adata";
		pEntity.KeyValue( "m_iszValueName", "$i_fail" );
		pEntity.KeyValue( "m_iszNewValue", "1" );
		pEntity.KeyValue( "m_iszValueType", "0" );
		
		@pEntity = g_EntityFuncs.Create( "trigger_changevalue", g_vecZero, g_vecZero, false );
		pEntity.pev.targetname = "lastmgr";
		pEntity.pev.target = "sys_adata";
		pEntity.KeyValue( "m_iszValueName", "$i_test" );
		pEntity.KeyValue( "m_iszNewValue", "1" );
		pEntity.KeyValue( "m_iszValueType", "0" );
		
		g_Scheduler.SetTimeout( "sc_fortress_check", 0.1 );
	}
	else if ( szMap == 'sc_frontline' )
	{
		@pEntity = g_EntityFuncs.Create( "info_target", g_vecZero, g_vecZero, false );
		pEntity.pev.targetname = "sys_adata";
		
		@pEntity = g_EntityFuncs.Create( "trigger_changevalue", g_vecZero, g_vecZero, false );
		pEntity.pev.targetname = "end";
		pEntity.pev.target = "sys_adata";
		pEntity.KeyValue( "m_iszValueName", "$i_test" );
		pEntity.KeyValue( "m_iszNewValue", "1" );
		pEntity.KeyValue( "m_iszValueType", "0" );
		
		g_Scheduler.SetTimeout( "sc_frontline_check", 0.1 );
	}
	else if ( szMap == 'sc_doc' )
	{
		@pEntity = g_EntityFuncs.Create( "info_target", g_vecZero, g_vecZero, false );
		pEntity.pev.targetname = "sys_adata";
		
		@pEntity = g_EntityFuncs.Create( "trigger_changevalue", g_vecZero, g_vecZero, false );
		pEntity.pev.targetname = "mapchangeset";
		pEntity.pev.target = "sys_adata";
		pEntity.KeyValue( "m_iszValueName", "$i_test" );
		pEntity.KeyValue( "m_iszNewValue", "1" );
		pEntity.KeyValue( "m_iszValueType", "0" );
		
		g_Scheduler.SetTimeout( "sc_doc_check", 0.1 );
	}
	else if ( szMap == 'sc_psyko' )
	{
		@pEntity = g_EntityFuncs.Create( "info_target", g_vecZero, g_vecZero, false );
		pEntity.pev.targetname = "sys_adata";
		
		@pEntity = g_EntityFuncs.Create( "trigger_changevalue", g_vecZero, g_vecZero, false );
		pEntity.pev.targetname = "mm_video";
		pEntity.pev.target = "sys_adata";
		pEntity.KeyValue( "m_iszValueName", "$i_test" );
		pEntity.KeyValue( "m_iszNewValue", "1" );
		pEntity.KeyValue( "m_iszValueType", "0" );
		
		g_Scheduler.SetTimeout( "sc_psyko_check", 0.1 );
	}
	else if ( szMap == 'sc_another' )
	{
		@pEntity = g_EntityFuncs.Create( "info_target", g_vecZero, g_vecZero, false );
		pEntity.pev.targetname = "sys_adata";
		
		@pEntity = g_EntityFuncs.Create( "trigger_changevalue", g_vecZero, g_vecZero, false );
		pEntity.pev.targetname = "tn_turrets_active";
		pEntity.pev.target = "sys_adata";
		pEntity.KeyValue( "m_iszValueName", "noise" );
		pEntity.KeyValue( "m_iszNewValue", "FAIL" );
		pEntity.KeyValue( "m_iszValueType", "0" );
		
		// AMXX does the check, not us
	}
	else if ( szMap == 'wolf3dlvl1' )
	{
		@pEntity = g_EntityFuncs.Create( "info_target", g_vecZero, g_vecZero, false );
		pEntity.pev.targetname = "sys_adata";
		
		// Test flag is manually set on the map itself, just run check
		
		g_Scheduler.SetTimeout( "wolf3dlvl1_check", 0.1 );
	}
	else if ( szMap == 'breakout_extended' )
	{
		@pEntity = g_EntityFuncs.Create( "info_target", g_vecZero, g_vecZero, false );
		pEntity.pev.targetname = "sys_adata";
		
		@pEntity = g_EntityFuncs.Create( "trigger_changevalue", g_vecZero, g_vecZero, false );
		pEntity.pev.targetname = "end_mes";
		pEntity.pev.target = "sys_adata";
		pEntity.KeyValue( "m_iszValueName", "$i_test" );
		pEntity.KeyValue( "m_iszNewValue", "1" );
		pEntity.KeyValue( "m_iszValueType", "0" );
		
		g_Scheduler.SetTimeout( "breakout_extended_check", 0.1 );
	}
	else if ( szMap == 'zombie_nights_v7' )
	{
		// check only
		
		g_Scheduler.SetTimeout( "zombie_nights_v7_check", 0.1 );
	}
	else if ( szMap == 'kh3' )
	{
		@pEntity = g_EntityFuncs.Create( "info_target", g_vecZero, g_vecZero, false );
		pEntity.pev.targetname = "sys_adata";
		
		@pEntity = g_EntityFuncs.Create( "trigger_changevalue", g_vecZero, g_vecZero, false );
		pEntity.pev.targetname = "picardcoin_gold1";
		pEntity.pev.target = "sys_adata";
		pEntity.KeyValue( "m_iszValueName", "$i_coins" );
		pEntity.KeyValue( "m_iszNewValue", "1" );
		pEntity.KeyValue( "m_iszValueType", "1" );
		
		@pEntity = g_EntityFuncs.Create( "trigger_changevalue", g_vecZero, g_vecZero, false );
		pEntity.pev.targetname = "picard1";
		pEntity.pev.target = "sys_adata";
		pEntity.KeyValue( "m_iszValueName", "$i_coins" );
		pEntity.KeyValue( "m_iszNewValue", "1" );
		pEntity.KeyValue( "m_iszValueType", "1" );
		
		@pEntity = g_EntityFuncs.Create( "trigger_changevalue", g_vecZero, g_vecZero, false );
		pEntity.pev.targetname = "picard2";
		pEntity.pev.target = "sys_adata";
		pEntity.KeyValue( "m_iszValueName", "$i_coins" );
		pEntity.KeyValue( "m_iszNewValue", "1" );
		pEntity.KeyValue( "m_iszValueType", "1" );
		
		@pEntity = g_EntityFuncs.Create( "trigger_changevalue", g_vecZero, g_vecZero, false );
		pEntity.pev.targetname = "picard3";
		pEntity.pev.target = "sys_adata";
		pEntity.KeyValue( "m_iszValueName", "$i_coins" );
		pEntity.KeyValue( "m_iszNewValue", "1" );
		pEntity.KeyValue( "m_iszValueType", "1" );
		
		@pEntity = g_EntityFuncs.Create( "trigger_changevalue", g_vecZero, g_vecZero, false );
		pEntity.pev.targetname = "picard4";
		pEntity.pev.target = "sys_adata";
		pEntity.KeyValue( "m_iszValueName", "$i_coins" );
		pEntity.KeyValue( "m_iszNewValue", "1" );
		pEntity.KeyValue( "m_iszValueType", "1" );
		
		@pEntity = g_EntityFuncs.Create( "trigger_changevalue", g_vecZero, g_vecZero, false );
		pEntity.pev.targetname = "picard5";
		pEntity.pev.target = "sys_adata";
		pEntity.KeyValue( "m_iszValueName", "$i_coins" );
		pEntity.KeyValue( "m_iszNewValue", "1" );
		pEntity.KeyValue( "m_iszValueType", "1" );
		
		@pEntity = g_EntityFuncs.Create( "trigger_changevalue", g_vecZero, g_vecZero, false );
		pEntity.pev.targetname = "picard6";
		pEntity.pev.target = "sys_adata";
		pEntity.KeyValue( "m_iszValueName", "$i_coins" );
		pEntity.KeyValue( "m_iszNewValue", "1" );
		pEntity.KeyValue( "m_iszValueType", "1" );
		
		@pEntity = g_EntityFuncs.Create( "trigger_changevalue", g_vecZero, g_vecZero, false );
		pEntity.pev.targetname = "picard7";
		pEntity.pev.target = "sys_adata";
		pEntity.KeyValue( "m_iszValueName", "$i_coins" );
		pEntity.KeyValue( "m_iszNewValue", "1" );
		pEntity.KeyValue( "m_iszValueType", "1" );
		
		@pEntity = g_EntityFuncs.Create( "trigger_changevalue", g_vecZero, g_vecZero, false );
		pEntity.pev.targetname = "picard8";
		pEntity.pev.target = "sys_adata";
		pEntity.KeyValue( "m_iszValueName", "$i_coins" );
		pEntity.KeyValue( "m_iszNewValue", "1" );
		pEntity.KeyValue( "m_iszValueType", "1" );
		
		@pEntity = g_EntityFuncs.Create( "trigger_changevalue", g_vecZero, g_vecZero, false );
		pEntity.pev.targetname = "picard9";
		pEntity.pev.target = "sys_adata";
		pEntity.KeyValue( "m_iszValueName", "$i_coins" );
		pEntity.KeyValue( "m_iszNewValue", "1" );
		pEntity.KeyValue( "m_iszValueType", "1" );
		
		@pEntity = g_EntityFuncs.Create( "trigger_changevalue", g_vecZero, g_vecZero, false );
		pEntity.pev.targetname = "picard10";
		pEntity.pev.target = "sys_adata";
		pEntity.KeyValue( "m_iszValueName", "$i_coins" );
		pEntity.KeyValue( "m_iszNewValue", "1" );
		pEntity.KeyValue( "m_iszValueType", "1" );
		
		@pEntity = g_EntityFuncs.Create( "trigger_changevalue", g_vecZero, g_vecZero, false );
		pEntity.pev.targetname = "picard11";
		pEntity.pev.target = "sys_adata";
		pEntity.KeyValue( "m_iszValueName", "$i_coins" );
		pEntity.KeyValue( "m_iszNewValue", "1" );
		pEntity.KeyValue( "m_iszValueType", "1" );
		
		@pEntity = g_EntityFuncs.Create( "trigger_changevalue", g_vecZero, g_vecZero, false );
		pEntity.pev.targetname = "picard12";
		pEntity.pev.target = "sys_adata";
		pEntity.KeyValue( "m_iszValueName", "$i_coins" );
		pEntity.KeyValue( "m_iszNewValue", "1" );
		pEntity.KeyValue( "m_iszValueType", "1" );
		
		g_Scheduler.SetTimeout( "kh3_check", 0.1 );
	}
	else if ( szMap == 'infested2' )
	{
		@pEntity = g_EntityFuncs.Create( "info_target", g_vecZero, g_vecZero, false );
		pEntity.pev.targetname = "sys_adata";
		
		@pEntity = g_EntityFuncs.Create( "trigger_changevalue", g_vecZero, g_vecZero, false );
		pEntity.pev.targetname = "explosion";
		pEntity.pev.target = "sys_adata";
		pEntity.KeyValue( "m_iszValueName", "$i_test" );
		pEntity.KeyValue( "m_iszNewValue", "1" );
		pEntity.KeyValue( "m_iszValueType", "0" );
		
		g_Scheduler.SetTimeout( "infested2_check", 0.1 );
	}
	else if ( szMap == 'garghnt3' )
	{
		@pEntity = g_EntityFuncs.Create( "info_target", g_vecZero, g_vecZero, false );
		pEntity.pev.targetname = "sys_adata";
		
		// AMXX does the stuff, we just check
		
		g_Scheduler.SetTimeout( "garghnt3_check", 0.1 );
	}
	else if ( szMap == 'arc-novus-4' )
	{
		@pEntity = g_EntityFuncs.Create( "info_target", g_vecZero, g_vecZero, false );
		pEntity.pev.targetname = "sys_adata";
		
		@pEntity = g_EntityFuncs.Create( "trigger_changevalue", g_vecZero, g_vecZero, false );
		pEntity.pev.targetname = "ignition";
		pEntity.pev.target = "sys_adata";
		pEntity.KeyValue( "m_iszValueName", "$i_test" );
		pEntity.KeyValue( "m_iszNewValue", "1" );
		pEntity.KeyValue( "m_iszValueType", "0" );
		
		g_Scheduler.SetTimeout( "arc_novus_4_check", 0.1 );
	}
	else if ( szMap == 'adams_puzzles_beta2' )
	{
		@pEntity = g_EntityFuncs.Create( "info_target", Vector( 2994, 3004, 150 ), g_vecZero, false );
		pEntity.pev.targetname = "sys_adata";
		
		@pEntity = g_EntityFuncs.Create( "trigger_changevalue", g_vecZero, g_vecZero, false );
		pEntity.pev.targetname = "darkmaze_out_msg";
		pEntity.pev.target = "!activator";
		pEntity.KeyValue( "m_iszValueName", "$i_puzzles" );
		pEntity.KeyValue( "m_iszNewValue", "1" );
		pEntity.KeyValue( "m_iszValueType", "1" );
		
		@pEntity = g_EntityFuncs.Create( "trigger_changevalue", g_vecZero, g_vecZero, false );
		pEntity.pev.targetname = "trippy3_in_msg";
		pEntity.pev.target = "!activator";
		pEntity.KeyValue( "m_iszValueName", "$i_puzzles" );
		pEntity.KeyValue( "m_iszNewValue", "1" );
		pEntity.KeyValue( "m_iszValueType", "1" );
		
		// 3rd puzzle is from distance
		
		g_Scheduler.SetTimeout( "adams_puzzles_beta2_check", 0.1 );
	}
	else if ( szMap == 'bossbattle' )
	{
		@pEntity = g_EntityFuncs.Create( "info_target", g_vecZero, g_vecZero, false );
		pEntity.pev.targetname = "sys_adata";
		
		@pEntity = g_EntityFuncs.Create( "trigger_changevalue", g_vecZero, g_vecZero, false );
		pEntity.pev.targetname = "game_playerdie";
		pEntity.pev.target = "sys_adata";
		pEntity.KeyValue( "m_iszValueName", "$i_fail" );
		pEntity.KeyValue( "m_iszNewValue", "1" );
		pEntity.KeyValue( "m_iszValueType", "0" );
		
		@pEntity = g_EntityFuncs.Create( "trigger_changevalue", g_vecZero, g_vecZero, false );
		pEntity.pev.targetname = "bossded_mm";
		pEntity.pev.target = "sys_adata";
		pEntity.KeyValue( "m_iszValueName", "$i_test" );
		pEntity.KeyValue( "m_iszNewValue", "1" );
		pEntity.KeyValue( "m_iszValueType", "0" );
		
		g_Scheduler.SetTimeout( "bossbattle_check", 0.1 );
	}
	else if ( szMap == 'evilmansion' )
	{
		@pEntity = g_EntityFuncs.Create( "info_target", g_vecZero, g_vecZero, false );
		pEntity.pev.targetname = "sys_adata";
		
		// WHY SO MANY OF THEM AAAAAAAAAAAAAAAAAAAAAAAAAAAAA
		@pEntity = g_EntityFuncs.Create( "trigger_changevalue", g_vecZero, g_vecZero, false );
		pEntity.pev.targetname = "red_candy_1_relay";
		pEntity.pev.target = "sys_adata";
		pEntity.KeyValue( "m_iszValueName", "$i_candy" );
		pEntity.KeyValue( "m_iszNewValue", "1" );
		pEntity.KeyValue( "m_iszValueType", "1" );
		@pEntity = g_EntityFuncs.Create( "trigger_changevalue", g_vecZero, g_vecZero, false );
		pEntity.pev.targetname = "blue_candy_1_relay";
		pEntity.pev.target = "sys_adata";
		pEntity.KeyValue( "m_iszValueName", "$i_candy" );
		pEntity.KeyValue( "m_iszNewValue", "1" );
		pEntity.KeyValue( "m_iszValueType", "1" );
		@pEntity = g_EntityFuncs.Create( "trigger_changevalue", g_vecZero, g_vecZero, false );
		pEntity.pev.targetname = "green_candy_1_relay";
		pEntity.pev.target = "sys_adata";
		pEntity.KeyValue( "m_iszValueName", "$i_candy" );
		pEntity.KeyValue( "m_iszNewValue", "1" );
		pEntity.KeyValue( "m_iszValueType", "1" );
		@pEntity = g_EntityFuncs.Create( "trigger_changevalue", g_vecZero, g_vecZero, false );
		pEntity.pev.targetname = "yellow_candy_1_relay";
		pEntity.pev.target = "sys_adata";
		pEntity.KeyValue( "m_iszValueName", "$i_candy" );
		pEntity.KeyValue( "m_iszNewValue", "1" );
		pEntity.KeyValue( "m_iszValueType", "1" );
		
		@pEntity = g_EntityFuncs.Create( "trigger_changevalue", g_vecZero, g_vecZero, false );
		pEntity.pev.targetname = "red_candy_2_relay";
		pEntity.pev.target = "sys_adata";
		pEntity.KeyValue( "m_iszValueName", "$i_candy" );
		pEntity.KeyValue( "m_iszNewValue", "1" );
		pEntity.KeyValue( "m_iszValueType", "1" );
		@pEntity = g_EntityFuncs.Create( "trigger_changevalue", g_vecZero, g_vecZero, false );
		pEntity.pev.targetname = "blue_candy_2_relay";
		pEntity.pev.target = "sys_adata";
		pEntity.KeyValue( "m_iszValueName", "$i_candy" );
		pEntity.KeyValue( "m_iszNewValue", "1" );
		pEntity.KeyValue( "m_iszValueType", "1" );
		@pEntity = g_EntityFuncs.Create( "trigger_changevalue", g_vecZero, g_vecZero, false );
		pEntity.pev.targetname = "green_candy_2_relay";
		pEntity.pev.target = "sys_adata";
		pEntity.KeyValue( "m_iszValueName", "$i_candy" );
		pEntity.KeyValue( "m_iszNewValue", "1" );
		pEntity.KeyValue( "m_iszValueType", "1" );
		@pEntity = g_EntityFuncs.Create( "trigger_changevalue", g_vecZero, g_vecZero, false );
		pEntity.pev.targetname = "yellow_candy_2_relay";
		pEntity.pev.target = "sys_adata";
		pEntity.KeyValue( "m_iszValueName", "$i_candy" );
		pEntity.KeyValue( "m_iszNewValue", "1" );
		pEntity.KeyValue( "m_iszValueType", "1" );
		
		@pEntity = g_EntityFuncs.Create( "trigger_changevalue", g_vecZero, g_vecZero, false );
		pEntity.pev.targetname = "red_candy_3_relay";
		pEntity.pev.target = "sys_adata";
		pEntity.KeyValue( "m_iszValueName", "$i_candy" );
		pEntity.KeyValue( "m_iszNewValue", "1" );
		pEntity.KeyValue( "m_iszValueType", "1" );
		@pEntity = g_EntityFuncs.Create( "trigger_changevalue", g_vecZero, g_vecZero, false );
		pEntity.pev.targetname = "blue_candy_3_relay";
		pEntity.pev.target = "sys_adata";
		pEntity.KeyValue( "m_iszValueName", "$i_candy" );
		pEntity.KeyValue( "m_iszNewValue", "1" );
		pEntity.KeyValue( "m_iszValueType", "1" );
		@pEntity = g_EntityFuncs.Create( "trigger_changevalue", g_vecZero, g_vecZero, false );
		pEntity.pev.targetname = "green_candy_3_relay";
		pEntity.pev.target = "sys_adata";
		pEntity.KeyValue( "m_iszValueName", "$i_candy" );
		pEntity.KeyValue( "m_iszNewValue", "1" );
		pEntity.KeyValue( "m_iszValueType", "1" );
		@pEntity = g_EntityFuncs.Create( "trigger_changevalue", g_vecZero, g_vecZero, false );
		pEntity.pev.targetname = "yellow_candy_3_relay";
		pEntity.pev.target = "sys_adata";
		pEntity.KeyValue( "m_iszValueName", "$i_candy" );
		pEntity.KeyValue( "m_iszNewValue", "1" );
		pEntity.KeyValue( "m_iszValueType", "1" );
		
		@pEntity = g_EntityFuncs.Create( "trigger_changevalue", g_vecZero, g_vecZero, false );
		pEntity.pev.targetname = "red_candy_4_relay";
		pEntity.pev.target = "sys_adata";
		pEntity.KeyValue( "m_iszValueName", "$i_candy" );
		pEntity.KeyValue( "m_iszNewValue", "1" );
		pEntity.KeyValue( "m_iszValueType", "1" );
		@pEntity = g_EntityFuncs.Create( "trigger_changevalue", g_vecZero, g_vecZero, false );
		pEntity.pev.targetname = "blue_candy_4_relay";
		pEntity.pev.target = "sys_adata";
		pEntity.KeyValue( "m_iszValueName", "$i_candy" );
		pEntity.KeyValue( "m_iszNewValue", "1" );
		pEntity.KeyValue( "m_iszValueType", "1" );
		@pEntity = g_EntityFuncs.Create( "trigger_changevalue", g_vecZero, g_vecZero, false );
		pEntity.pev.targetname = "green_candy_4_relay";
		pEntity.pev.target = "sys_adata";
		pEntity.KeyValue( "m_iszValueName", "$i_candy" );
		pEntity.KeyValue( "m_iszNewValue", "1" );
		pEntity.KeyValue( "m_iszValueType", "1" );
		@pEntity = g_EntityFuncs.Create( "trigger_changevalue", g_vecZero, g_vecZero, false );
		pEntity.pev.targetname = "yellow_candy_4_relay";
		pEntity.pev.target = "sys_adata";
		pEntity.KeyValue( "m_iszValueName", "$i_candy" );
		pEntity.KeyValue( "m_iszNewValue", "1" );
		pEntity.KeyValue( "m_iszValueType", "1" );
		
		@pEntity = g_EntityFuncs.Create( "trigger_changevalue", g_vecZero, g_vecZero, false );
		pEntity.pev.targetname = "red_candy_5_relay";
		pEntity.pev.target = "sys_adata";
		pEntity.KeyValue( "m_iszValueName", "$i_candy" );
		pEntity.KeyValue( "m_iszNewValue", "1" );
		pEntity.KeyValue( "m_iszValueType", "1" );
		@pEntity = g_EntityFuncs.Create( "trigger_changevalue", g_vecZero, g_vecZero, false );
		pEntity.pev.targetname = "blue_candy_5_relay";
		pEntity.pev.target = "sys_adata";
		pEntity.KeyValue( "m_iszValueName", "$i_candy" );
		pEntity.KeyValue( "m_iszNewValue", "1" );
		pEntity.KeyValue( "m_iszValueType", "1" );
		@pEntity = g_EntityFuncs.Create( "trigger_changevalue", g_vecZero, g_vecZero, false );
		pEntity.pev.targetname = "green_candy_5_relay";
		pEntity.pev.target = "sys_adata";
		pEntity.KeyValue( "m_iszValueName", "$i_candy" );
		pEntity.KeyValue( "m_iszNewValue", "1" );
		pEntity.KeyValue( "m_iszValueType", "1" );
		@pEntity = g_EntityFuncs.Create( "trigger_changevalue", g_vecZero, g_vecZero, false );
		pEntity.pev.targetname = "yellow_candy_5_relay";
		pEntity.pev.target = "sys_adata";
		pEntity.KeyValue( "m_iszValueName", "$i_candy" );
		pEntity.KeyValue( "m_iszNewValue", "1" );
		pEntity.KeyValue( "m_iszValueType", "1" );
		
		@pEntity = g_EntityFuncs.Create( "trigger_changevalue", g_vecZero, g_vecZero, false );
		pEntity.pev.targetname = "red_candy_6_relay";
		pEntity.pev.target = "sys_adata";
		pEntity.KeyValue( "m_iszValueName", "$i_candy" );
		pEntity.KeyValue( "m_iszNewValue", "1" );
		pEntity.KeyValue( "m_iszValueType", "1" );
		@pEntity = g_EntityFuncs.Create( "trigger_changevalue", g_vecZero, g_vecZero, false );
		pEntity.pev.targetname = "blue_candy_6_relay";
		pEntity.pev.target = "sys_adata";
		pEntity.KeyValue( "m_iszValueName", "$i_candy" );
		pEntity.KeyValue( "m_iszNewValue", "1" );
		pEntity.KeyValue( "m_iszValueType", "1" );
		@pEntity = g_EntityFuncs.Create( "trigger_changevalue", g_vecZero, g_vecZero, false );
		pEntity.pev.targetname = "green_candy_6_relay";
		pEntity.pev.target = "sys_adata";
		pEntity.KeyValue( "m_iszValueName", "$i_candy" );
		pEntity.KeyValue( "m_iszNewValue", "1" );
		pEntity.KeyValue( "m_iszValueType", "1" );
		@pEntity = g_EntityFuncs.Create( "trigger_changevalue", g_vecZero, g_vecZero, false );
		pEntity.pev.targetname = "yellow_candy_6_relay";
		pEntity.pev.target = "sys_adata";
		pEntity.KeyValue( "m_iszValueName", "$i_candy" );
		pEntity.KeyValue( "m_iszNewValue", "1" );
		pEntity.KeyValue( "m_iszValueType", "1" );
		
		@pEntity = g_EntityFuncs.Create( "trigger_changevalue", g_vecZero, g_vecZero, false );
		pEntity.pev.targetname = "red_candy_7_relay";
		pEntity.pev.target = "sys_adata";
		pEntity.KeyValue( "m_iszValueName", "$i_candy" );
		pEntity.KeyValue( "m_iszNewValue", "1" );
		pEntity.KeyValue( "m_iszValueType", "1" );
		@pEntity = g_EntityFuncs.Create( "trigger_changevalue", g_vecZero, g_vecZero, false );
		pEntity.pev.targetname = "blue_candy_7_relay";
		pEntity.pev.target = "sys_adata";
		pEntity.KeyValue( "m_iszValueName", "$i_candy" );
		pEntity.KeyValue( "m_iszNewValue", "1" );
		pEntity.KeyValue( "m_iszValueType", "1" );
		@pEntity = g_EntityFuncs.Create( "trigger_changevalue", g_vecZero, g_vecZero, false );
		pEntity.pev.targetname = "green_candy_7_relay";
		pEntity.pev.target = "sys_adata";
		pEntity.KeyValue( "m_iszValueName", "$i_candy" );
		pEntity.KeyValue( "m_iszNewValue", "1" );
		pEntity.KeyValue( "m_iszValueType", "1" );
		@pEntity = g_EntityFuncs.Create( "trigger_changevalue", g_vecZero, g_vecZero, false );
		pEntity.pev.targetname = "yellow_candy_7_relay";
		pEntity.pev.target = "sys_adata";
		pEntity.KeyValue( "m_iszValueName", "$i_candy" );
		pEntity.KeyValue( "m_iszNewValue", "1" );
		pEntity.KeyValue( "m_iszValueType", "1" );
		
		@pEntity = g_EntityFuncs.Create( "trigger_changevalue", g_vecZero, g_vecZero, false );
		pEntity.pev.targetname = "red_candy_8_relay";
		pEntity.pev.target = "sys_adata";
		pEntity.KeyValue( "m_iszValueName", "$i_candy" );
		pEntity.KeyValue( "m_iszNewValue", "1" );
		pEntity.KeyValue( "m_iszValueType", "1" );
		@pEntity = g_EntityFuncs.Create( "trigger_changevalue", g_vecZero, g_vecZero, false );
		pEntity.pev.targetname = "blue_candy_8_relay";
		pEntity.pev.target = "sys_adata";
		pEntity.KeyValue( "m_iszValueName", "$i_candy" );
		pEntity.KeyValue( "m_iszNewValue", "1" );
		pEntity.KeyValue( "m_iszValueType", "1" );
		@pEntity = g_EntityFuncs.Create( "trigger_changevalue", g_vecZero, g_vecZero, false );
		pEntity.pev.targetname = "green_candy_8_relay";
		pEntity.pev.target = "sys_adata";
		pEntity.KeyValue( "m_iszValueName", "$i_candy" );
		pEntity.KeyValue( "m_iszNewValue", "1" );
		pEntity.KeyValue( "m_iszValueType", "1" );
		@pEntity = g_EntityFuncs.Create( "trigger_changevalue", g_vecZero, g_vecZero, false );
		pEntity.pev.targetname = "yellow_candy_8_relay";
		pEntity.pev.target = "sys_adata";
		pEntity.KeyValue( "m_iszValueName", "$i_candy" );
		pEntity.KeyValue( "m_iszNewValue", "1" );
		pEntity.KeyValue( "m_iszValueType", "1" );
		
		@pEntity = g_EntityFuncs.Create( "trigger_changevalue", g_vecZero, g_vecZero, false );
		pEntity.pev.targetname = "red_candy_9_relay";
		pEntity.pev.target = "sys_adata";
		pEntity.KeyValue( "m_iszValueName", "$i_candy" );
		pEntity.KeyValue( "m_iszNewValue", "1" );
		pEntity.KeyValue( "m_iszValueType", "1" );
		@pEntity = g_EntityFuncs.Create( "trigger_changevalue", g_vecZero, g_vecZero, false );
		pEntity.pev.targetname = "blue_candy_9_relay";
		pEntity.pev.target = "sys_adata";
		pEntity.KeyValue( "m_iszValueName", "$i_candy" );
		pEntity.KeyValue( "m_iszNewValue", "1" );
		pEntity.KeyValue( "m_iszValueType", "1" );
		@pEntity = g_EntityFuncs.Create( "trigger_changevalue", g_vecZero, g_vecZero, false );
		pEntity.pev.targetname = "green_candy_9_relay";
		pEntity.pev.target = "sys_adata";
		pEntity.KeyValue( "m_iszValueName", "$i_candy" );
		pEntity.KeyValue( "m_iszNewValue", "1" );
		pEntity.KeyValue( "m_iszValueType", "1" );
		@pEntity = g_EntityFuncs.Create( "trigger_changevalue", g_vecZero, g_vecZero, false );
		pEntity.pev.targetname = "yellow_candy_9_relay";
		pEntity.pev.target = "sys_adata";
		pEntity.KeyValue( "m_iszValueName", "$i_candy" );
		pEntity.KeyValue( "m_iszNewValue", "1" );
		pEntity.KeyValue( "m_iszValueType", "1" );
		
		@pEntity = g_EntityFuncs.Create( "trigger_changevalue", g_vecZero, g_vecZero, false );
		pEntity.pev.targetname = "red_candy_10_relay";
		pEntity.pev.target = "sys_adata";
		pEntity.KeyValue( "m_iszValueName", "$i_candy" );
		pEntity.KeyValue( "m_iszNewValue", "1" );
		pEntity.KeyValue( "m_iszValueType", "1" );
		@pEntity = g_EntityFuncs.Create( "trigger_changevalue", g_vecZero, g_vecZero, false );
		pEntity.pev.targetname = "blue_candy_10_relay";
		pEntity.pev.target = "sys_adata";
		pEntity.KeyValue( "m_iszValueName", "$i_candy" );
		pEntity.KeyValue( "m_iszNewValue", "1" );
		pEntity.KeyValue( "m_iszValueType", "1" );
		@pEntity = g_EntityFuncs.Create( "trigger_changevalue", g_vecZero, g_vecZero, false );
		pEntity.pev.targetname = "green_candy_10_relay";
		pEntity.pev.target = "sys_adata";
		pEntity.KeyValue( "m_iszValueName", "$i_candy" );
		pEntity.KeyValue( "m_iszNewValue", "1" );
		pEntity.KeyValue( "m_iszValueType", "1" );
		@pEntity = g_EntityFuncs.Create( "trigger_changevalue", g_vecZero, g_vecZero, false );
		pEntity.pev.targetname = "yellow_candy_10_relay";
		pEntity.pev.target = "sys_adata";
		pEntity.KeyValue( "m_iszValueName", "$i_candy" );
		pEntity.KeyValue( "m_iszNewValue", "1" );
		pEntity.KeyValue( "m_iszValueType", "1" );
		
		@pEntity = g_EntityFuncs.Create( "trigger_changevalue", g_vecZero, g_vecZero, false );
		pEntity.pev.targetname = "red_candy_11_relay";
		pEntity.pev.target = "sys_adata";
		pEntity.KeyValue( "m_iszValueName", "$i_candy" );
		pEntity.KeyValue( "m_iszNewValue", "1" );
		pEntity.KeyValue( "m_iszValueType", "1" );
		@pEntity = g_EntityFuncs.Create( "trigger_changevalue", g_vecZero, g_vecZero, false );
		pEntity.pev.targetname = "blue_candy_11_relay";
		pEntity.pev.target = "sys_adata";
		pEntity.KeyValue( "m_iszValueName", "$i_candy" );
		pEntity.KeyValue( "m_iszNewValue", "1" );
		pEntity.KeyValue( "m_iszValueType", "1" );
		@pEntity = g_EntityFuncs.Create( "trigger_changevalue", g_vecZero, g_vecZero, false );
		pEntity.pev.targetname = "green_candy_11_relay";
		pEntity.pev.target = "sys_adata";
		pEntity.KeyValue( "m_iszValueName", "$i_candy" );
		pEntity.KeyValue( "m_iszNewValue", "1" );
		pEntity.KeyValue( "m_iszValueType", "1" );
		@pEntity = g_EntityFuncs.Create( "trigger_changevalue", g_vecZero, g_vecZero, false );
		pEntity.pev.targetname = "yellow_candy_11_relay";
		pEntity.pev.target = "sys_adata";
		pEntity.KeyValue( "m_iszValueName", "$i_candy" );
		pEntity.KeyValue( "m_iszNewValue", "1" );
		pEntity.KeyValue( "m_iszValueType", "1" );
		
		@pEntity = g_EntityFuncs.Create( "trigger_changevalue", g_vecZero, g_vecZero, false );
		pEntity.pev.targetname = "red_candy_12_relay";
		pEntity.pev.target = "sys_adata";
		pEntity.KeyValue( "m_iszValueName", "$i_candy" );
		pEntity.KeyValue( "m_iszNewValue", "1" );
		pEntity.KeyValue( "m_iszValueType", "1" );
		@pEntity = g_EntityFuncs.Create( "trigger_changevalue", g_vecZero, g_vecZero, false );
		pEntity.pev.targetname = "blue_candy_12_relay";
		pEntity.pev.target = "sys_adata";
		pEntity.KeyValue( "m_iszValueName", "$i_candy" );
		pEntity.KeyValue( "m_iszNewValue", "1" );
		pEntity.KeyValue( "m_iszValueType", "1" );
		@pEntity = g_EntityFuncs.Create( "trigger_changevalue", g_vecZero, g_vecZero, false );
		pEntity.pev.targetname = "green_candy_12_relay";
		pEntity.pev.target = "sys_adata";
		pEntity.KeyValue( "m_iszValueName", "$i_candy" );
		pEntity.KeyValue( "m_iszNewValue", "1" );
		pEntity.KeyValue( "m_iszValueType", "1" );
		@pEntity = g_EntityFuncs.Create( "trigger_changevalue", g_vecZero, g_vecZero, false );
		pEntity.pev.targetname = "yellow_candy_12_relay";
		pEntity.pev.target = "sys_adata";
		pEntity.KeyValue( "m_iszValueName", "$i_candy" );
		pEntity.KeyValue( "m_iszNewValue", "1" );
		pEntity.KeyValue( "m_iszValueType", "1" );
		
		@pEntity = g_EntityFuncs.Create( "trigger_changevalue", g_vecZero, g_vecZero, false );
		pEntity.pev.targetname = "gamend_mm";
		pEntity.pev.target = "sys_adata";
		pEntity.KeyValue( "m_iszValueName", "$i_test" );
		pEntity.KeyValue( "m_iszNewValue", "1" );
		pEntity.KeyValue( "m_iszValueType", "0" );
		
		g_Scheduler.SetTimeout( "evilmansion_check", 0.1 );
	}
	else if ( szMap == 'sc_spacewar' )
	{
		@pEntity = g_EntityFuncs.Create( "info_target", g_vecZero, g_vecZero, false );
		pEntity.pev.targetname = "sys_adata";
		
		@pEntity = g_EntityFuncs.Create( "trigger_changevalue", g_vecZero, g_vecZero, false );
		pEntity.pev.targetname = "rele";
		pEntity.pev.target = "sys_adata";
		pEntity.KeyValue( "m_iszValueName", "$i_test" );
		pEntity.KeyValue( "m_iszNewValue", "1" );
		pEntity.KeyValue( "m_iszValueType", "0" );
		
		g_Scheduler.SetTimeout( "sc_spacewar_check", 0.1 );
	}
	else if ( szMap == 'bw' )
	{
		@pEntity = g_EntityFuncs.Create( "info_target", g_vecZero, g_vecZero, false );
		pEntity.pev.targetname = "sys_adata";
		
		@pEntity = g_EntityFuncs.Create( "trigger_changevalue", g_vecZero, g_vecZero, false );
		pEntity.pev.targetname = "bossdown_mm";
		pEntity.pev.target = "sys_adata";
		pEntity.KeyValue( "m_iszValueName", "$i_test" );
		pEntity.KeyValue( "m_iszNewValue", "1" );
		pEntity.KeyValue( "m_iszValueType", "0" );
		
		g_Scheduler.SetTimeout( "bw_check", 0.1 );
	}
	else if ( szMap == 'factions' )
	{
		@pEntity = g_EntityFuncs.Create( "info_target", g_vecZero, g_vecZero, false );
		pEntity.pev.targetname = "sys_adata";
		
		@pEntity = g_EntityFuncs.Create( "trigger_changevalue", g_vecZero, g_vecZero, false );
		pEntity.pev.targetname = "finalwintext";
		pEntity.pev.target = "sys_adata";
		pEntity.KeyValue( "m_iszValueName", "$i_test" );
		pEntity.KeyValue( "m_iszNewValue", "1" );
		pEntity.KeyValue( "m_iszValueType", "0" );
		
		g_Scheduler.SetTimeout( "factions_check", 0.1 );
	}
	else if ( szMap == 'quad_f' )
	{
		@pEntity = g_EntityFuncs.Create( "info_target", g_vecZero, g_vecZero, false );
		pEntity.pev.targetname = "sys_adata";
		
		@pEntity = g_EntityFuncs.Create( "trigger_changevalue", g_vecZero, g_vecZero, false );
		pEntity.pev.targetname = "txt_temp";
		pEntity.pev.target = "sys_adata";
		pEntity.KeyValue( "m_iszValueName", "$i_test" );
		pEntity.KeyValue( "m_iszNewValue", "1" );
		pEntity.KeyValue( "m_iszValueType", "0" );
		
		g_Scheduler.SetTimeout( "quad_f_check", 0.1 );
	}
	else if ( szMap == 'ra_quad' )
	{
		@pEntity = g_EntityFuncs.Create( "info_target", g_vecZero, g_vecZero, false );
		pEntity.pev.targetname = "sys_adata";
		
		@pEntity = g_EntityFuncs.Create( "trigger_changevalue", g_vecZero, g_vecZero, false );
		pEntity.pev.targetname = "txt_temp";
		pEntity.pev.target = "sys_adata";
		pEntity.KeyValue( "m_iszValueName", "$i_test" );
		pEntity.KeyValue( "m_iszNewValue", "1" );
		pEntity.KeyValue( "m_iszValueType", "0" );
		
		g_Scheduler.SetTimeout( "ra_quad_check", 0.1 );
	}
	else if ( szMap == 'turretfortress' )
	{
		@pEntity = g_EntityFuncs.Create( "info_target", g_vecZero, g_vecZero, false );
		pEntity.pev.targetname = "sys_adata";
		
		@pEntity = g_EntityFuncs.Create( "trigger_changevalue", g_vecZero, g_vecZero, false );
		pEntity.pev.targetname = "hard_selected";
		pEntity.pev.target = "sys_adata";
		pEntity.KeyValue( "m_iszValueName", "$i_difficulty" );
		pEntity.KeyValue( "m_iszNewValue", "1" );
		pEntity.KeyValue( "m_iszValueType", "0" );
		
		@pEntity = g_EntityFuncs.Create( "trigger_changevalue", g_vecZero, g_vecZero, false );
		pEntity.pev.targetname = "reverse_win_text";
		pEntity.pev.target = "sys_adata";
		pEntity.KeyValue( "m_iszValueName", "$i_test" );
		pEntity.KeyValue( "m_iszNewValue", "1" );
		pEntity.KeyValue( "m_iszValueType", "0" );
		
		g_Scheduler.SetTimeout( "turretfortress_check", 0.1 );
	}
	else if ( szMap == 'tf_original' )
	{
		@pEntity = g_EntityFuncs.Create( "info_target", g_vecZero, g_vecZero, false );
		pEntity.pev.targetname = "sys_adata";
		
		@pEntity = g_EntityFuncs.Create( "trigger_changevalue", g_vecZero, g_vecZero, false );
		pEntity.pev.targetname = "hard_selected";
		pEntity.pev.target = "sys_adata";
		pEntity.KeyValue( "m_iszValueName", "$i_difficulty" );
		pEntity.KeyValue( "m_iszNewValue", "1" );
		pEntity.KeyValue( "m_iszValueType", "0" );
		
		@pEntity = g_EntityFuncs.Create( "trigger_changevalue", g_vecZero, g_vecZero, false );
		pEntity.pev.targetname = "kfcdeeeeead";
		pEntity.pev.target = "sys_adata";
		pEntity.KeyValue( "m_iszValueName", "$i_test" );
		pEntity.KeyValue( "m_iszNewValue", "1" );
		pEntity.KeyValue( "m_iszValueType", "0" );
		
		g_Scheduler.SetTimeout( "tf_original_check", 0.1 );
	}
	else if ( szMap == 'sc_robination_revised' )
	{
		@pEntity = g_EntityFuncs.Create( "info_target", g_vecZero, g_vecZero, false );
		pEntity.pev.targetname = "sys_adata";
		
		@pEntity = g_EntityFuncs.Create( "trigger_changevalue", g_vecZero, g_vecZero, false );
		pEntity.pev.targetname = "mm_last_final";
		pEntity.pev.target = "sys_adata";
		pEntity.KeyValue( "m_iszValueName", "$i_test" );
		pEntity.KeyValue( "m_iszNewValue", "1" );
		pEntity.KeyValue( "m_iszValueType", "0" );
		
		g_Scheduler.SetTimeout( "sc_robination_revised_check", 0.1 );
	}
	else if ( szMap == 'hl_trick' )
	{
		@pEntity = g_EntityFuncs.Create( "info_target", Vector( 2432, 1326, 324 ), g_vecZero, false );
		pEntity.pev.targetname = "sys_adata";
		
		// distance check only
		
		g_Scheduler.SetTimeout( "hl_trick_check", 0.1 );
	}
	else if ( szMap == 'd_trick1' )
	{
		@pEntity = g_EntityFuncs.Create( "info_target", Vector( -322, 1500, -524 ), g_vecZero, false );
		pEntity.pev.targetname = "sys_adata";
		
		// distance check only
		
		g_Scheduler.SetTimeout( "d_trick1_check", 0.1 );
	}
	else if ( szMap == 'hc2b3a' )
	{
		@pEntity = g_EntityFuncs.Create( "info_target", Vector( 89, 99, 3769 ), g_vecZero, false );
		pEntity.pev.targetname = "sys_adata";
		
		// distance check only
		
		g_Scheduler.SetTimeout( "hc2b3a_check", 0.1 );
	}
	else if ( szMap == 'sc_mazing' )
	{
		@pEntity = g_EntityFuncs.Create( "info_target", g_vecZero, g_vecZero, false );
		pEntity.pev.targetname = "sys_adata";
		
		// achievement #123
		@pEntity = g_EntityFuncs.Create( "trigger_changevalue", g_vecZero, g_vecZero, false );
		pEntity.pev.targetname = "lab_hunter_dies";
		pEntity.pev.target = "sys_adata";
		pEntity.KeyValue( "m_iszValueName", "$i_kills" );
		pEntity.KeyValue( "m_iszNewValue", "1" );
		pEntity.KeyValue( "m_iszValueType", "1" );
		
		@pEntity = g_EntityFuncs.Create( "trigger_changevalue", g_vecZero, g_vecZero, false );
		pEntity.pev.targetname = "lab_garg_dies";
		pEntity.pev.target = "sys_adata";
		pEntity.KeyValue( "m_iszValueName", "$i_kills" );
		pEntity.KeyValue( "m_iszNewValue", "1" );
		pEntity.KeyValue( "m_iszValueType", "1" );
		
		// achievement #146
		@pEntity = g_EntityFuncs.Create( "trigger_changevalue", g_vecZero, g_vecZero, false );
		pEntity.pev.targetname = "boss1end_mm";
		pEntity.pev.target = "sys_adata";
		pEntity.KeyValue( "m_iszValueName", "$i_test" );
		pEntity.KeyValue( "m_iszNewValue", "1" );
		pEntity.KeyValue( "m_iszValueType", "0" );
		
		g_Scheduler.SetTimeout( "sc_mazing_check", 0.1 );
	}
	else if ( szMap == 'ub_megaman3' )
	{
		@pEntity = g_EntityFuncs.Create( "info_target", g_vecZero, g_vecZero, false );
		pEntity.pev.targetname = "sys_adata";
		
		@pEntity = g_EntityFuncs.Create( "trigger_changevalue", g_vecZero, g_vecZero, false );
		pEntity.pev.targetname = "txt_password";
		pEntity.pev.target = "sys_adata";
		pEntity.KeyValue( "m_iszValueName", "$i_active" );
		pEntity.KeyValue( "m_iszNewValue", "1" );
		pEntity.KeyValue( "m_iszValueType", "0" );
		
		@pEntity = g_EntityFuncs.Create( "trigger_changevalue", g_vecZero, g_vecZero, false );
		pEntity.pev.targetname = "mm_door_boss3b";
		pEntity.pev.target = "sys_adata";
		pEntity.KeyValue( "m_iszValueName", "$i_test" );
		pEntity.KeyValue( "m_iszNewValue", "1" );
		pEntity.KeyValue( "m_iszValueType", "0" );
		
		g_Scheduler.SetTimeout( "ub_megaman3_check", 0.1 );
	}
	else if ( szMap == 'between_elvis_lg' )
	{
		@pEntity = g_EntityFuncs.Create( "info_target", g_vecZero, g_vecZero, false );
		pEntity.pev.targetname = "sys_adata";
		
		@pEntity = g_EntityFuncs.Create( "trigger_changevalue", g_vecZero, g_vecZero, false );
		pEntity.pev.targetname = "endseq1txt";
		pEntity.pev.target = "sys_adata";
		pEntity.KeyValue( "m_iszValueName", "$i_test" );
		pEntity.KeyValue( "m_iszNewValue", "1" );
		pEntity.KeyValue( "m_iszValueType", "0" );
		
		@pEntity = g_EntityFuncs.Create( "trigger_changevalue", g_vecZero, g_vecZero, false );
		pEntity.pev.targetname = "endseq2txt";
		pEntity.pev.target = "sys_adata";
		pEntity.KeyValue( "m_iszValueName", "$i_test" );
		pEntity.KeyValue( "m_iszNewValue", "1" );
		pEntity.KeyValue( "m_iszValueType", "0" );
		
		g_Scheduler.SetTimeout( "between_elvis_lg_check", 0.1 );
	}
	else if ( szMap == 'cassault1' )
	{
		@pEntity = g_EntityFuncs.Create( "info_target", g_vecZero, g_vecZero, false );
		pEntity.pev.targetname = "sys_adata";
		
		@pEntity = g_EntityFuncs.Create( "trigger_changevalue", g_vecZero, g_vecZero, false );
		pEntity.pev.targetname = "endgruntje";
		pEntity.pev.target = "sys_adata";
		pEntity.KeyValue( "m_iszValueName", "$i_test" );
		pEntity.KeyValue( "m_iszNewValue", "1" );
		pEntity.KeyValue( "m_iszValueType", "0" );
		
		g_Scheduler.SetTimeout( "cassault1_check", 0.1 );
	}
	else if ( szMap == 'tox_xen5' )
	{
		@pEntity = g_EntityFuncs.Create( "info_target", g_vecZero, g_vecZero, false );
		pEntity.pev.targetname = "sys_adata";
		
		@pEntity = g_EntityFuncs.Create( "trigger_changevalue", g_vecZero, g_vecZero, false );
		pEntity.pev.targetname = "finalgargkilled";
		pEntity.pev.target = "sys_adata";
		pEntity.KeyValue( "m_iszValueName", "$i_test" );
		pEntity.KeyValue( "m_iszNewValue", "1" );
		pEntity.KeyValue( "m_iszValueType", "0" );
		
		g_Scheduler.SetTimeout( "tox_xen5_check", 0.1 );
	}
	else if ( szMap == 'sc_marioland' )
	{
		@pEntity = g_EntityFuncs.Create( "info_target", g_vecZero, g_vecZero, false );
		pEntity.pev.targetname = "sys_adata";
		
		@pEntity = g_EntityFuncs.Create( "trigger_changevalue", g_vecZero, g_vecZero, false );
		pEntity.pev.targetname = "deathman";
		pEntity.pev.target = "sys_adata";
		pEntity.KeyValue( "m_iszValueName", "$i_test" );
		pEntity.KeyValue( "m_iszNewValue", "1" );
		pEntity.KeyValue( "m_iszValueType", "0" );
		
		g_Scheduler.SetTimeout( "sc_marioland_check", 0.1 );
	}
	else if ( szMap == 'hplanet' )
	{
		@pEntity = g_EntityFuncs.Create( "info_target", g_vecZero, g_vecZero, false );
		pEntity.pev.targetname = "sys_adata";
		
		@pEntity = g_EntityFuncs.Create( "trigger_changevalue", g_vecZero, g_vecZero, false );
		pEntity.pev.targetname = "objective8";
		pEntity.pev.target = "sys_adata";
		pEntity.KeyValue( "m_iszValueName", "$i_test" );
		pEntity.KeyValue( "m_iszNewValue", "1" );
		pEntity.KeyValue( "m_iszValueType", "0" );
		
		g_Scheduler.SetTimeout( "hplanet_check", 0.1 );
	}
	else if ( szMap == 'bm_sts' )
	{
		@pEntity = g_EntityFuncs.Create( "info_target", g_vecZero, g_vecZero, false );
		pEntity.pev.targetname = "sys_adata";
		
		@pEntity = g_EntityFuncs.Create( "trigger_changevalue", g_vecZero, g_vecZero, false );
		pEntity.pev.targetname = "box_creator_tier_5";
		pEntity.pev.target = "sys_adata";
		pEntity.KeyValue( "m_iszValueName", "$i_red_level5" );
		pEntity.KeyValue( "m_iszNewValue", "1" );
		pEntity.KeyValue( "m_iszValueType", "1" );
		
		@pEntity = g_EntityFuncs.Create( "trigger_changevalue", g_vecZero, g_vecZero, false );
		pEntity.pev.targetname = "box_creator_tier_5b";
		pEntity.pev.target = "sys_adata";
		pEntity.KeyValue( "m_iszValueName", "$i_blue_level5" );
		pEntity.KeyValue( "m_iszNewValue", "1" );
		pEntity.KeyValue( "m_iszValueType", "1" );
		
		@pEntity = g_EntityFuncs.Create( "trigger_changevalue", g_vecZero, g_vecZero, false );
		pEntity.pev.targetname = "box_creator_tier_5g";
		pEntity.pev.target = "sys_adata";
		pEntity.KeyValue( "m_iszValueName", "$i_green_level5" );
		pEntity.KeyValue( "m_iszNewValue", "1" );
		pEntity.KeyValue( "m_iszValueType", "1" );
		
		@pEntity = g_EntityFuncs.Create( "trigger_changevalue", g_vecZero, g_vecZero, false );
		pEntity.pev.targetname = "box_creator_tier_5y";
		pEntity.pev.target = "sys_adata";
		pEntity.KeyValue( "m_iszValueName", "$i_yellow_level5" );
		pEntity.KeyValue( "m_iszNewValue", "1" );
		pEntity.KeyValue( "m_iszValueType", "1" );
		
		g_Scheduler.SetTimeout( "bm_sts_check", 0.1 );
	}
	else if ( szMap == 'croodcoop' )
	{
		@pEntity = g_EntityFuncs.Create( "info_target", g_vecZero, g_vecZero, false );
		pEntity.pev.targetname = "sys_adata";
		
		@pEntity = g_EntityFuncs.Create( "trigger_changevalue", g_vecZero, g_vecZero, false );
		pEntity.pev.targetname = "end_txt";
		pEntity.pev.target = "sys_adata";
		pEntity.KeyValue( "m_iszValueName", "$i_test" );
		pEntity.KeyValue( "m_iszNewValue", "1" );
		pEntity.KeyValue( "m_iszValueType", "0" );
		
		g_Scheduler.SetTimeout( "croodcoop_check", 0.1 );
	}
	else if ( szMap == 'sc_titans' )
	{
		@pEntity = g_EntityFuncs.Create( "info_target", g_vecZero, g_vecZero, false );
		pEntity.pev.targetname = "sys_adata";
		
		@pEntity = g_EntityFuncs.Create( "trigger_changevalue", g_vecZero, g_vecZero, false );
		pEntity.pev.targetname = "e_manager";
		pEntity.pev.target = "sys_adata";
		pEntity.KeyValue( "m_iszValueName", "$i_test" );
		pEntity.KeyValue( "m_iszNewValue", "1" );
		pEntity.KeyValue( "m_iszValueType", "0" );
		
		g_Scheduler.SetTimeout( "sc_titans_check", 0.1 );
	}
	else if ( szMap == 'sc_tetris1' )
	{
		@pEntity = g_EntityFuncs.Create( "info_target", g_vecZero, g_vecZero, false );
		pEntity.pev.targetname = "sys_adata";
		
		@pEntity = g_EntityFuncs.Create( "trigger_changevalue", g_vecZero, g_vecZero, false );
		pEntity.pev.targetname = "spawn1doop";
		pEntity.pev.target = "sys_adata";
		pEntity.KeyValue( "m_iszValueName", "$i_run" );
		pEntity.KeyValue( "m_iszNewValue", "1" );
		pEntity.KeyValue( "m_iszValueType", "0" );
		
		g_Scheduler.SetTimeout( "sc_tetris1_check", 0.1 );
	}
	else if ( szMap == 'sc_tetris2' || szMap == 'sc_tetris3' || szMap == 'sc_tetris4' || szMap == 'sc_tetris5' )
	{
		// Just get player list
		g_Scheduler.SetTimeout( "sc_tetris2_5_check", 65.1 );
	}
	else if ( szMap == 'sc_tetris6' )
	{
		@pEntity = g_EntityFuncs.Create( "info_target", g_vecZero, g_vecZero, false );
		pEntity.pev.targetname = "sys_adata";
		
		@pEntity = g_EntityFuncs.Create( "trigger_changevalue", g_vecZero, g_vecZero, false );
		pEntity.pev.targetname = "boss1end1mm";
		pEntity.pev.target = "sys_adata";
		pEntity.KeyValue( "m_iszValueName", "$i_test" );
		pEntity.KeyValue( "m_iszNewValue", "1" );
		pEntity.KeyValue( "m_iszValueType", "0" );
		
		g_Scheduler.SetTimeout( "sc_tetris6_check", 0.1 );
	}
	else if ( szMap == 'sc_tombofdeath_v12-1' || szMap == 'sc_tombofdeath_v12-2' || szMap == 'sc_tombofdeath_v12-3' || szMap == 'sc_tombofdeath_v12-4' || szMap == 'sc_tombofdeath_v12-5' || szMap == 'sc_tombofdeath_v12-6' )
	{
		@pEntity = g_EntityFuncs.Create( "info_target", g_vecZero, g_vecZero, false );
		pEntity.pev.targetname = "sys_adata";
		
		// Just check
		g_Scheduler.SetTimeout( "sc_tombofdeath_v12_1_6_check", 1.0 );
		
		if ( szMap == 'sc_tombofdeath_v12-6' )
		{
			@pEntity = g_EntityFuncs.Create( "trigger_changevalue", g_vecZero, g_vecZero, false );
			pEntity.pev.targetname = "end";
			pEntity.pev.target = "sys_adata";
			pEntity.KeyValue( "m_iszValueName", "$i_test" );
			pEntity.KeyValue( "m_iszNewValue", "1" );
			pEntity.KeyValue( "m_iszValueType", "0" );
			
			g_Scheduler.SetTimeout( "sc_tombofdeath_v12_6_check", 0.1 );
		}
	}
	else if ( szMap == 'polar_rescue' )
	{
		@pEntity = g_EntityFuncs.Create( "info_target", g_vecZero, g_vecZero, false );
		pEntity.pev.targetname = "sys_adata";
		
		@pEntity = g_EntityFuncs.Create( "trigger_changevalue", g_vecZero, g_vecZero, false );
		pEntity.pev.targetname = "startmap_hard_mm";
		pEntity.pev.target = "sys_adata";
		pEntity.KeyValue( "m_iszValueName", "$i_difficulty" );
		pEntity.KeyValue( "m_iszNewValue", "1" );
		pEntity.KeyValue( "m_iszValueType", "0" );
		
		@pEntity = g_EntityFuncs.Create( "trigger_changevalue", g_vecZero, g_vecZero, false );
		pEntity.pev.targetname = "mission_complete_mm";
		pEntity.pev.target = "sys_adata";
		pEntity.KeyValue( "m_iszValueName", "$i_test" );
		pEntity.KeyValue( "m_iszNewValue", "1" );
		pEntity.KeyValue( "m_iszValueType", "0" );
		
		g_Scheduler.SetTimeout( "polar_rescue_check", 0.1 );
	}
	else if ( szMap == 'beatthis' )
	{
		@pEntity = g_EntityFuncs.Create( "info_target", g_vecZero, g_vecZero, false );
		pEntity.pev.targetname = "sys_adata";
		
		@pEntity = g_EntityFuncs.Create( "trigger_changevalue", g_vecZero, g_vecZero, false );
		pEntity.pev.targetname = "end_mm";
		pEntity.pev.target = "sys_adata";
		pEntity.KeyValue( "m_iszValueName", "$i_test" );
		pEntity.KeyValue( "m_iszNewValue", "1" );
		pEntity.KeyValue( "m_iszValueType", "0" );
		
		g_Scheduler.SetTimeout( "beatthis_check", 0.1 );
	}
	else if ( szMap == 'stadium4' )
	{
		@pEntity = g_EntityFuncs.Create( "info_target", g_vecZero, g_vecZero, false );
		pEntity.pev.targetname = "sys_adata";
		
		// kills are done in map itself, just check
		
		g_Scheduler.SetTimeout( "stadium4_check", 0.1 );
	}
	else if ( szMap == 'sectore_3' )
	{
		@pEntity = g_EntityFuncs.Create( "info_target", g_vecZero, g_vecZero, false );
		pEntity.pev.targetname = "sys_adata";
		
		@pEntity = g_EntityFuncs.Create( "trigger_changevalue", g_vecZero, g_vecZero, false );
		pEntity.pev.targetname = "allflowers_msg";
		pEntity.pev.target = "sys_adata";
		pEntity.KeyValue( "m_iszValueName", "$i_test" );
		pEntity.KeyValue( "m_iszNewValue", "1" );
		pEntity.KeyValue( "m_iszValueType", "0" );
		
		g_Scheduler.SetTimeout( "sectore_3_check", 0.1 );
	}
	else if ( szMap == 'alamo1' )
	{
		@pEntity = g_EntityFuncs.Create( "info_target", g_vecZero, g_vecZero, false );
		pEntity.pev.targetname = "sys_adata";
		
		@pEntity = g_EntityFuncs.Create( "trigger_changevalue", g_vecZero, g_vecZero, false );
		pEntity.pev.targetname = "cc1";
		pEntity.pev.target = "sys_adata";
		pEntity.KeyValue( "m_iszValueName", "$i_test" );
		pEntity.KeyValue( "m_iszNewValue", "1" );
		pEntity.KeyValue( "m_iszValueType", "0" );
		
		g_Scheduler.SetTimeout( "alamo1_check", 0.1 );
	}
	else if ( szMap == 'lmsbath' )
	{
		@pEntity = g_EntityFuncs.Create( "info_target", g_vecZero, g_vecZero, false );
		pEntity.pev.targetname = "sys_adata";
		
		@pEntity = g_EntityFuncs.Create( "trigger_changevalue", g_vecZero, g_vecZero, false );
		pEntity.pev.targetname = "gameovertext";
		pEntity.pev.target = "sys_adata";
		pEntity.KeyValue( "m_iszValueName", "$i_rounds" );
		pEntity.KeyValue( "m_iszNewValue", "1" );
		pEntity.KeyValue( "m_iszValueType", "1" );
		
		g_Scheduler.SetTimeout( "lmsbath_check", 0.1 );
	}
	else if ( szMap == 'build' )
	{
		// simple Z check
		
		g_Scheduler.SetTimeout( "build_check", 1.1 );
	}
	else if ( szMap == 'thevoid' )
	{
		// manual check only, system is done on map itself
		
		g_Scheduler.SetTimeout( "thevoid_check", 0.1 );
	}
	// square_run sets a_unlock on map itself
	else if ( szMap == 'rc_towerdefense' )
	{
		@pEntity = g_EntityFuncs.Create( "info_target", g_vecZero, g_vecZero, false );
		pEntity.pev.targetname = "sys_adata";
		
		@pEntity = g_EntityFuncs.Create( "trigger_changevalue", g_vecZero, g_vecZero, false );
		pEntity.pev.targetname = "game_won";
		pEntity.pev.target = "sys_adata";
		pEntity.KeyValue( "m_iszValueName", "$i_test" );
		pEntity.KeyValue( "m_iszNewValue", "1" );
		pEntity.KeyValue( "m_iszValueType", "0" );
		
		@pEntity = g_EntityFuncs.Create( "trigger_changevalue", g_vecZero, g_vecZero, false );
		pEntity.pev.targetname = "credits";
		pEntity.pev.target = "sys_adata";
		pEntity.KeyValue( "m_iszValueName", "$i_start" );
		pEntity.KeyValue( "m_iszNewValue", "1" );
		pEntity.KeyValue( "m_iszValueType", "0" );
		
		@pEntity = g_EntityFuncs.Create( "trigger_changevalue", g_vecZero, g_vecZero, false );
		pEntity.pev.targetname = "easy3";
		pEntity.pev.target = "sys_adata";
		pEntity.KeyValue( "m_iszValueName", "$i_difficulty" );
		pEntity.KeyValue( "m_iszNewValue", "1" );
		pEntity.KeyValue( "m_iszValueType", "0" );
		
		@pEntity = g_EntityFuncs.Create( "trigger_changevalue", g_vecZero, g_vecZero, false );
		pEntity.pev.targetname = "normal3";
		pEntity.pev.target = "sys_adata";
		pEntity.KeyValue( "m_iszValueName", "$i_difficulty" );
		pEntity.KeyValue( "m_iszNewValue", "2" );
		pEntity.KeyValue( "m_iszValueType", "0" );
		
		@pEntity = g_EntityFuncs.Create( "trigger_changevalue", g_vecZero, g_vecZero, false );
		pEntity.pev.targetname = "hard3";
		pEntity.pev.target = "sys_adata";
		pEntity.KeyValue( "m_iszValueName", "$i_difficulty" );
		pEntity.KeyValue( "m_iszNewValue", "3" );
		pEntity.KeyValue( "m_iszValueType", "0" );
		
		@pEntity = g_EntityFuncs.Create( "trigger_changevalue", g_vecZero, g_vecZero, false );
		pEntity.pev.targetname = "ultrahard3";
		pEntity.pev.target = "sys_adata";
		pEntity.KeyValue( "m_iszValueName", "$i_difficulty" );
		pEntity.KeyValue( "m_iszNewValue", "4" );
		pEntity.KeyValue( "m_iszValueType", "0" );
		
		@pEntity = g_EntityFuncs.Create( "trigger_changevalue", g_vecZero, g_vecZero, false );
		pEntity.pev.targetname = "impossible3";
		pEntity.pev.target = "sys_adata";
		pEntity.KeyValue( "m_iszValueName", "$i_difficulty" );
		pEntity.KeyValue( "m_iszNewValue", "5" );
		pEntity.KeyValue( "m_iszValueType", "0" );
		
		g_Scheduler.SetTimeout( "rc_towerdefense_check", 0.1 );
	}
	else if ( szMap == 'beachxp_isc' )
	{
		@pEntity = g_EntityFuncs.Create( "info_target", g_vecZero, g_vecZero, false );
		pEntity.pev.targetname = "sys_adata";
		
		@pEntity = g_EntityFuncs.Create( "trigger_changevalue", g_vecZero, g_vecZero, false );
		pEntity.pev.targetname = "txt_exit2";
		pEntity.pev.target = "sys_adata";
		pEntity.KeyValue( "m_iszValueName", "$i_test" );
		pEntity.KeyValue( "m_iszNewValue", "1" );
		pEntity.KeyValue( "m_iszValueType", "0" );
		
		g_Scheduler.SetTimeout( "beachxp_isc_check", 0.1 );
	}
	else if ( szMap == 'dccoop1' )
	{
		@pEntity = g_EntityFuncs.Create( "info_target", Vector( -640, -1560, -90 ), g_vecZero, false );
		pEntity.pev.targetname = "sys_adata";
		
		// distance check only
		
		g_Scheduler.SetTimeout( "dccoop1_check", 0.1 );
	}
	else if ( szMap == 'tox_slug1' )
	{
		@pEntity = g_EntityFuncs.Create( "info_target", g_vecZero, g_vecZero, false );
		pEntity.pev.targetname = "sys_adata";
		
		@pEntity = g_EntityFuncs.Create( "trigger_changevalue", g_vecZero, g_vecZero, false );
		pEntity.pev.targetname = "the_end_relayer";
		pEntity.pev.target = "sys_adata";
		pEntity.KeyValue( "m_iszValueName", "$i_test" );
		pEntity.KeyValue( "m_iszNewValue", "1" );
		pEntity.KeyValue( "m_iszValueType", "0" );
		
		g_Scheduler.SetTimeout( "tox_slug1_check", 0.1 );
	}
	else if ( szMap == 'toonrun3' )
	{
		@pEntity = g_EntityFuncs.Create( "info_target", g_vecZero, g_vecZero, false );
		pEntity.pev.targetname = "sys_adata";
		
		@pEntity = g_EntityFuncs.Create( "trigger_changevalue", g_vecZero, g_vecZero, false );
		pEntity.pev.targetname = "mm_goal_reached";
		pEntity.pev.target = "sys_adata";
		pEntity.KeyValue( "m_iszValueName", "$i_test" );
		pEntity.KeyValue( "m_iszNewValue", "1" );
		pEntity.KeyValue( "m_iszValueType", "0" );
		
		@pEntity = g_EntityFuncs.Create( "trigger_changevalue", g_vecZero, g_vecZero, false );
		pEntity.pev.targetname = "whack_fail";
		pEntity.pev.target = "sys_adata";
		pEntity.KeyValue( "m_iszValueName", "$i_fail" );
		pEntity.KeyValue( "m_iszNewValue", "1" );
		pEntity.KeyValue( "m_iszValueType", "0" );
		
		g_Scheduler.SetTimeout( "toonrun3_check", 0.1 );
	}
	else if ( szMap == 'extension' )
	{
		@pEntity = g_EntityFuncs.Create( "info_target", g_vecZero, g_vecZero, false );
		pEntity.pev.targetname = "sys_adata";
		
		@pEntity = g_EntityFuncs.Create( "trigger_changevalue", g_vecZero, g_vecZero, false );
		pEntity.pev.targetname = "traindiemm";
		pEntity.pev.target = "sys_adata";
		pEntity.KeyValue( "m_iszValueName", "$i_test" );
		pEntity.KeyValue( "m_iszNewValue", "1" );
		pEntity.KeyValue( "m_iszValueType", "0" );
		
		g_Scheduler.SetTimeout( "extension_check", 0.1 );
	}
	else if ( szMap == 'warzone01' || szMap == 'warzone02' || szMap == 'warzone03' || szMap == 'warzone04' || szMap == 'warzone05' || szMap == 'warzone06' || szMap == 'warzone07' || szMap == 'warzone08' || szMap == 'warzone09' || szMap == 'warzone10' || szMap == 'warzone11' || szMap == 'warzone12' || szMap == 'warzone13' || szMap == 'warzone14' || szMap == 'warzone15' )
	{
		@pEntity = g_EntityFuncs.Create( "info_target", g_vecZero, g_vecZero, false );
		pEntity.pev.targetname = "sys_adata";
		
		// Just check
		g_Scheduler.SetTimeout( "warzone_1_15_check", 1.0 );
		
		if ( szMap == 'warzone15' )
		{
			@pEntity = g_EntityFuncs.Create( "trigger_changevalue", g_vecZero, g_vecZero, false );
			pEntity.pev.targetname = "end_t1__2";
			pEntity.pev.target = "sys_adata";
			pEntity.KeyValue( "m_iszValueName", "$i_test" );
			pEntity.KeyValue( "m_iszNewValue", "1" );
			pEntity.KeyValue( "m_iszValueType", "0" );
			
			g_Scheduler.SetTimeout( "warzone_15_check", 0.1 );
		}
	}
	else if ( szMap == 'disco_boss' )
	{
		@pEntity = g_EntityFuncs.Create( "info_target", g_vecZero, g_vecZero, false );
		pEntity.pev.targetname = "sys_adata";
		
		// map's .as file is edited to trigger this
		@pEntity = g_EntityFuncs.Create( "trigger_changevalue", g_vecZero, g_vecZero, false );
		pEntity.pev.targetname = "achievement_check";
		pEntity.pev.target = "sys_adata";
		pEntity.KeyValue( "m_iszValueName", "$i_test" );
		pEntity.KeyValue( "m_iszNewValue", "1" );
		pEntity.KeyValue( "m_iszValueType", "0" );
		
		g_Scheduler.SetTimeout( "disco_boss_check", 0.1 );
	}
	else if ( szMap == 'the-climb3' )
	{
		@pEntity = g_EntityFuncs.Create( "info_target", Vector( -1334, -208, 3320 ), g_vecZero, false );
		pEntity.pev.targetname = "sys_adata";
		
		// distance check only
		
		// helper
		@pEntity = g_EntityFuncs.Create( "weapon_crossbow", Vector( -1334, -208, 3320 ), g_vecZero, false );
		
		g_Scheduler.SetTimeout( "the_climb3_check", 0.1 );
	}
	else if ( szMap == 'q1_e1m4' )
	{
		@pEntity = g_EntityFuncs.Create( "info_target", Vector( 1244, 1352, 840 ), g_vecZero, false );
		pEntity.pev.targetname = "sys_adata";
		
		// distance check only
		
		g_Scheduler.SetTimeout( "q1_e1m4_check", 0.1 );
	}
	else if ( szMap == 'trials_v1' )
	{
		@pEntity = g_EntityFuncs.Create( "info_target", g_vecZero, g_vecZero, false );
		pEntity.pev.targetname = "sys_adata";
		
		@pEntity = g_EntityFuncs.Create( "trigger_changevalue", g_vecZero, g_vecZero, false );
		pEntity.pev.targetname = "door9";
		pEntity.pev.target = "sys_adata";
		pEntity.KeyValue( "m_iszValueName", "$i_test" );
		pEntity.KeyValue( "m_iszNewValue", "1" );
		pEntity.KeyValue( "m_iszValueType", "0" );
		
		g_Scheduler.SetTimeout( "trials_v1_check", 0.1 );
	}
	else if ( szMap == 'suspension' )
	{
		@pEntity = g_EntityFuncs.Create( "info_target", g_vecZero, g_vecZero, false );
		pEntity.pev.targetname = "sys_adata";
		
		@pEntity = g_EntityFuncs.Create( "trigger_changevalue", g_vecZero, g_vecZero, false );
		pEntity.pev.targetname = "win_blue_text";
		pEntity.pev.target = "sys_adata";
		pEntity.KeyValue( "m_iszValueName", "$i_difficulty" );
		pEntity.KeyValue( "m_iszNewValue", "1" );
		pEntity.KeyValue( "m_iszValueType", "0" );
		
		@pEntity = g_EntityFuncs.Create( "trigger_changevalue", g_vecZero, g_vecZero, false );
		pEntity.pev.targetname = "win_yellow_text";
		pEntity.pev.target = "sys_adata";
		pEntity.KeyValue( "m_iszValueName", "$i_difficulty" );
		pEntity.KeyValue( "m_iszNewValue", "2" );
		pEntity.KeyValue( "m_iszValueType", "0" );
		
		@pEntity = g_EntityFuncs.Create( "trigger_changevalue", g_vecZero, g_vecZero, false );
		pEntity.pev.targetname = "win_white_text";
		pEntity.pev.target = "sys_adata";
		pEntity.KeyValue( "m_iszValueName", "$i_difficulty" );
		pEntity.KeyValue( "m_iszNewValue", "3" );
		pEntity.KeyValue( "m_iszValueType", "0" );
		
		@pEntity = g_EntityFuncs.Create( "trigger_changevalue", g_vecZero, g_vecZero, false );
		pEntity.pev.targetname = "final_win";
		pEntity.pev.target = "sys_adata";
		pEntity.KeyValue( "m_iszValueName", "$i_test" );
		pEntity.KeyValue( "m_iszNewValue", "1" );
		pEntity.KeyValue( "m_iszValueType", "0" );
		
		g_Scheduler.SetTimeout( "suspension_check", 0.1 );
	}
}

void assaultmesa2_check()
{
	if ( szMap != 'assaultmesa2' )
		return;
	
	CBaseEntity@ pCheck1_1 = g_EntityFuncs.FindEntityByTargetname( null, "sys_adata" );
	if ( pCheck1_1 is null )
		return;
	
	CustomKeyvalues@ pCheck1_2 = pCheck1_1.GetCustomKeyvalues();
	CustomKeyvalue iFail_pre( pCheck1_2.GetKeyvalue( "$i_fail" ) );
	int iFail = iFail_pre.GetInteger();
	if ( iFail == 1 )
		return;
	
	CBaseEntity@ pCheck2_1 = g_EntityFuncs.FindEntityByTargetname( null, "tunnelgate_multi" );
	if ( pCheck2_1 is null )
		return;
	
	for ( int i = 1; i <= g_Engine.maxClients; i++ )
	{
		CBasePlayer@ pPlayer = g_PlayerFuncs.FindPlayerByIndex( i );
		
		if ( pPlayer !is null && pPlayer.IsConnected() )
		{
			// Check whenever the player pressed the button
			CustomKeyvalues@ pCheck3_1 = pPlayer.GetCustomKeyvalues();
			CustomKeyvalue iCheck1_pre( pCheck3_1.GetKeyvalue( "$i_test" ) );
			int iCheck1 = iCheck1_pre.GetInteger();
			if ( iCheck1 == 1 )
			{
				// Now check if the player has antigravity
				CustomKeyvalue iCheck2_pre( pCheck3_1.GetKeyvalue( "$i_gravity" ) );
				int iCheck2 = iCheck2_pre.GetInteger();
				if ( iCheck2 == 0 )
				{
					// Lastly, check that the player didn't cheat by resetting them
					CustomKeyvalue iCheck3_pre( pCheck3_1.GetKeyvalue( "$i_old_gravity" ) );
					int iCheck3 = iCheck3_pre.GetInteger();
					if ( iCheck3 == 0 )
					{
						// Achievement get!
						pCheck3_1.SetKeyvalue( "$i_a_unlock", 1 );
					}
				}
			}
		}
	}
	
	g_Scheduler.SetTimeout( "assaultmesa2_check", 0.1 );
}

void assaultmesa2_d_check()
{
	if ( szMap != 'assaultmesa2' && szMap != 'assaultmesa2-2' )
		return;
	
	// Update death info
	string szPath = "scripts/plugins/temp/" + szMap + ".lst";
	File@ thefile = g_FileSystem.OpenFile( szPath, OpenFile::WRITE );
	
	if ( thefile !is null && thefile.IsOpen() )
	{
		for ( int i = 1; i <= g_Engine.maxClients; i++ )
		{
			CBasePlayer@ pPlayer = g_PlayerFuncs.FindPlayerByIndex( i );
			
			if ( pPlayer !is null && pPlayer.IsConnected() )
			{
				CBaseEntity@ pCheck1_1 = g_EntityFuncs.FindEntityByTargetname( null, "sys_adata" );
				if ( pCheck1_1 is null )
				{
					// Try again
					g_Scheduler.SetTimeout( "assaultmesa2_d_check", 1.0 );
					return;
				}
				
				CustomKeyvalues@ pCheck1_2 = pCheck1_1.GetCustomKeyvalues();
				string szPlayer = g_EngineFuncs.GetPlayerAuthId( pPlayer.edict() );
				szPlayer.Replace( ':', '_' );
				CustomKeyvalue iPlayerFail( pCheck1_2.GetKeyvalue( "$i_" + szPlayer ) );
				
				// Don't cheat: Don't reset the status if already failed
				if ( !iPlayerFail.Exists() )
				{
					// No deaths?
					if ( pPlayer.m_iDeaths == 0 )
						thefile.Write( "" + g_EngineFuncs.GetPlayerAuthId( pPlayer.edict() ) + "#PASS\n" );
					else
					{
						thefile.Write( "" + g_EngineFuncs.GetPlayerAuthId( pPlayer.edict() ) + "#FAIL\n" );
						pCheck1_2.SetKeyvalue( "$i_" + szPlayer, 1 );
					}
				}
				else
					thefile.Write( "" + g_EngineFuncs.GetPlayerAuthId( pPlayer.edict() ) + "#FAIL\n" );
			}
		}
		
		thefile.Close();
	}
	
	g_Scheduler.SetTimeout( "assaultmesa2_d_check", 1.0 );
}

void assaultmesa2_2_check()
{
	if ( szMap != 'assaultmesa2-2' )
		return;
	
	CBaseEntity@ pCheck1_1 = g_EntityFuncs.FindEntityByTargetname( null, "sys_adata" );
	if ( pCheck1_1 is null )
		return;
	
	CustomKeyvalues@ pCheck1_2 = pCheck1_1.GetCustomKeyvalues();
	CustomKeyvalue iCheck_pre( pCheck1_2.GetKeyvalue( "$i_test" ) );
	int iCheck = iCheck_pre.GetInteger();
	if ( iCheck == 1 )
	{
		for ( int i = 1; i <= g_Engine.maxClients; i++ )
		{
			int iTimes = 0;
			CBasePlayer@ pPlayer = g_PlayerFuncs.FindPlayerByIndex( i );
			
			if ( pPlayer !is null && pPlayer.IsConnected() )
			{
				// Check if the player passed previous levels
				// First level does not use postfix (2-1). Have to use this 2 times
				string szPath = "scripts/plugins/temp/assaultmesa2.lst";
				File@ altfile = g_FileSystem.OpenFile( szPath, OpenFile::READ );
				if ( altfile !is null && altfile.IsOpen() )
				{
					string szPlayer;
					while ( !altfile.EOFReached() )
					{
						altfile.ReadLine( szPlayer );
						szPlayer.Replace( '#', ' ' );
						array< string >@ pre_data = szPlayer.Split( ' ' );
						if ( pre_data[ 0 ] == g_EngineFuncs.GetPlayerAuthId( pPlayer.edict() ) )
						{
							if ( pre_data[ 1 ] == 'PASS' )
							{
								iTimes++;
								break;
							}
						}
					}
					altfile.Close();
				}
				szPath = "scripts/plugins/temp/assaultmesa2-2.lst";
				@altfile = g_FileSystem.OpenFile( szPath, OpenFile::READ );
				if ( altfile !is null && altfile.IsOpen() )
				{
					string szPlayer;
					while ( !altfile.EOFReached() )
					{
						altfile.ReadLine( szPlayer );
						szPlayer.Replace( '#', ' ' );
						array< string >@ pre_data = szPlayer.Split( ' ' );
						if ( pre_data[ 0 ] == g_EngineFuncs.GetPlayerAuthId( pPlayer.edict() ) )
						{
							if ( pre_data[ 1 ] == 'PASS' )
							{
								iTimes++;
								break;
							}
						}
					}
					altfile.Close();
				}
				
				if ( iTimes == 2 )
				{
					// EVIL SCORE REQUIREMENT
					if ( pPlayer.pev.frags >= 100.0 ) // This is 20% of SECOND map's max score
					{
						// Get!
						CustomKeyvalues@ pUnlock = pPlayer.GetCustomKeyvalues();
						pUnlock.SetKeyvalue( "$i_a_unlock", 146 );
					}
				}
			}
		}
		
		return;
	}
	
	g_Scheduler.SetTimeout( "assaultmesa2_2_check", 0.1 );
}

void sc_face_check()
{
	if ( szMap != 'sc_face' )
		return;
	
	CBaseEntity@ pCheck1_1 = g_EntityFuncs.FindEntityByTargetname( null, "sys_adata" );
	if ( pCheck1_1 is null )
		return;
	
	CustomKeyvalues@ pCheck1_2 = pCheck1_1.GetCustomKeyvalues();
	CustomKeyvalue iCheck_pre( pCheck1_2.GetKeyvalue( "$i_test" ) );
	int iCheck = iCheck_pre.GetInteger();
	if ( iCheck == 1 )
	{
		for ( int i = 1; i <= g_Engine.maxClients; i++ )
		{
			CBasePlayer@ pPlayer = g_PlayerFuncs.FindPlayerByIndex( i );
			
			if ( pPlayer !is null && pPlayer.IsConnected() )
			{
				// Check whenever the player has no deaths
				if ( pPlayer.m_iDeaths == 0 )
				{
					// To prevent abuse, player must have at least this much score
					if ( pPlayer.pev.frags >= 80.0 ) // This is 20% of map's max score
					{
						// Get!
						CustomKeyvalues@ pUnlock = pPlayer.GetCustomKeyvalues();
						pUnlock.SetKeyvalue( "$i_a_unlock", 2 );
					}
				}
			}
		}
		
		return;
	}
	
	g_Scheduler.SetTimeout( "sc_face_check", 0.1 );
}

void F_5minutes_b1_check()
{
	if ( szMap != '5minutes_b1' )
		return;
	
	CBaseEntity@ pCheck1_1 = g_EntityFuncs.FindEntityByTargetname( null, "sys_adata" );
	if ( pCheck1_1 is null )
		return;
	
	CustomKeyvalues@ pCheck1_2 = pCheck1_1.GetCustomKeyvalues();
	CustomKeyvalue iCheck_pre( pCheck1_2.GetKeyvalue( "$i_test" ) );
	int iCheck = iCheck_pre.GetInteger();
	if ( iCheck == 1 )
	{
		for ( int i = 1; i <= g_Engine.maxClients; i++ )
		{
			CBasePlayer@ pPlayer = g_PlayerFuncs.FindPlayerByIndex( i );
			
			if ( pPlayer !is null && pPlayer.IsConnected() )
			{
				// To prevent abuse, player must have at least this much score
				if ( pPlayer.pev.frags >= 10.0 ) // This is 10% of map's max score
				{
					// Get!
					CustomKeyvalues@ pUnlock = pPlayer.GetCustomKeyvalues();
					pUnlock.SetKeyvalue( "$i_a_unlock", 4 );
				}
			}
		}
		
		return;
	}
	
	g_Scheduler.SetTimeout( "F_5minutes_b1_check", 0.1 );
}

void auspices_check()
{
	if ( szMap != 'auspices' )
		return;
	
	CBaseEntity@ pCheck1_1 = g_EntityFuncs.FindEntityByTargetname( null, "sys_adata" );
	if ( pCheck1_1 is null )
		return;
	
	CustomKeyvalues@ pCheck1_2 = pCheck1_1.GetCustomKeyvalues();
	CustomKeyvalue iCheck1_pre( pCheck1_2.GetKeyvalue( "$i_test" ) );
	int iCheck1 = iCheck1_pre.GetInteger();
	if ( iCheck1 == 1 )
	{
		for ( int i = 1; i <= g_Engine.maxClients; i++ )
		{
			CBasePlayer@ pPlayer = g_PlayerFuncs.FindPlayerByIndex( i );
			
			if ( pPlayer !is null && pPlayer.IsConnected() )
			{
				CustomKeyvalues@ pCheck2_1 = pPlayer.GetCustomKeyvalues();
				CustomKeyvalue iCheck2_pre( pCheck2_1.GetKeyvalue( "$i_fail" ) );
				int iCheck2 = iCheck2_pre.GetInteger();
				
				// Check whenever the player has NOT been killed BY the lasers
				if ( iCheck2 == 0 )
				{
					// To prevent abuse, player must have at least this much score
					if ( pPlayer.pev.frags >= 80.0 ) // This is 20% of map's max score
					{
						// Get!
						pCheck2_1.SetKeyvalue( "$i_a_unlock", 5 );
					}
				}
			}
		}
		
		return;
	}
	
	g_Scheduler.SetTimeout( "auspices_check", 0.1 );
}

void abandoned_check()
{
	if ( szMap != 'abandoned' )
		return;
	
	CBaseEntity@ pCheck1_1 = g_EntityFuncs.FindEntityByTargetname( null, "sys_adata" );
	if ( pCheck1_1 is null )
		return;
	
	CustomKeyvalues@ pCheck1_2 = pCheck1_1.GetCustomKeyvalues();
	CustomKeyvalue iCheck1_pre( pCheck1_2.GetKeyvalue( "$i_active" ) );
	int iCheck1 = iCheck1_pre.GetInteger();
	if ( iCheck1 == 1 )
	{
		// Reached map end?
		CustomKeyvalue iCheck2_pre( pCheck1_2.GetKeyvalue( "$i_test" ) );
		int iCheck2 = iCheck2_pre.GetInteger();
		if ( iCheck2 == 1 )
		{
			CustomKeyvalue iCheck3_pre( pCheck1_2.GetKeyvalue( "$i_fail" ) );
			int iCheck3 = iCheck3_pre.GetInteger();
			
			// Check whenever bomb did not detonate
			if ( iCheck3 == 0 )	
			{
				for ( int i = 1; i <= g_Engine.maxClients; i++ )
				{
					CBasePlayer@ pPlayer = g_PlayerFuncs.FindPlayerByIndex( i );
					if ( pPlayer !is null && pPlayer.IsConnected() )
					{
						// To prevent abuse, player must have at least this much score
						if ( pPlayer.pev.frags >= 120.0 ) // This is 20% of map's max score
						{
							// Get!
							CustomKeyvalues@ pUnlock = pPlayer.GetCustomKeyvalues();
							pUnlock.SetKeyvalue( "$i_a_unlock", 7 );
						}
					}
				}
				
				return;
			}
		}
	}
	
	g_Scheduler.SetTimeout( "abandoned_check", 0.1 );
}

void sc_frostfire_beta1_check()
{
	if ( szMap != 'sc_frostfire_beta1' )
		return;
	
	CBaseEntity@ pCheck1_1 = g_EntityFuncs.FindEntityByTargetname( null, "sys_adata" );
	if ( pCheck1_1 is null )
		return;
	
	CustomKeyvalues@ pCheck1_2 = pCheck1_1.GetCustomKeyvalues();
	CustomKeyvalue iCheck_pre( pCheck1_2.GetKeyvalue( "$i_test" ) );
	int iCheck = iCheck_pre.GetInteger();
	if ( iCheck == 1 )
	{
		for ( int i = 1; i <= g_Engine.maxClients; i++ )
		{
			CBasePlayer@ pPlayer = g_PlayerFuncs.FindPlayerByIndex( i );
			
			if ( pPlayer !is null && pPlayer.IsConnected() )
			{
				// Check whenever the player has no deaths
				if ( pPlayer.m_iDeaths == 0 )
				{
					// To prevent abuse, player must have at least this much score
					if ( pPlayer.pev.frags >= 80.0 ) // This is 20% of map's max score
					{
						// Get!
						CustomKeyvalues@ pUnlock = pPlayer.GetCustomKeyvalues();
						pUnlock.SetKeyvalue( "$i_a_unlock", 8 );
					}
				}
			}
		}
		
		return;
	}
	
	g_Scheduler.SetTimeout( "sc_frostfire_beta1_check", 0.1 );
}

void toadsnatch_check()
{
	if ( szMap != 'toadsnatch' )
		return;
	
	CBaseEntity@ pCheck1_1 = g_EntityFuncs.FindEntityByTargetname( null, "sys_adata" );
	if ( pCheck1_1 is null )
		return;
	
	// Weapon check
	for ( int i = 1; i <= g_Engine.maxClients; i++ )
	{
		CBasePlayer@ pPlayer = g_PlayerFuncs.FindPlayerByIndex( i );
		
		if ( pPlayer !is null && pPlayer.IsConnected() )
		{
			CustomKeyvalues@ pUnlock = pPlayer.GetCustomKeyvalues();
			CustomKeyvalue iWeapons_pre( pUnlock.GetKeyvalue( "$i_weapons_found" ) );
			int iWeapons = iWeapons_pre.GetInteger();
			if ( iWeapons == 11 )
			{
				// Get!
				pUnlock.SetKeyvalue( "$i_a_unlock", 14 );
				
				// Stop looping, could screw up other achievements
				pUnlock.SetKeyvalue( "$i_weapons_found", 0 );
			}
		}
	}
	
	CustomKeyvalues@ pCheck1_2 = pCheck1_1.GetCustomKeyvalues();
	CustomKeyvalue iCheck_pre( pCheck1_2.GetKeyvalue( "$i_test" ) );
	int iCheck = iCheck_pre.GetInteger();
	if ( iCheck == 1 )
	{
		for ( int i = 1; i <= g_Engine.maxClients; i++ )
		{
			CBasePlayer@ pPlayer = g_PlayerFuncs.FindPlayerByIndex( i );
			
			if ( pPlayer !is null && pPlayer.IsConnected() )
			{
				// Get map difficulty
				CustomKeyvalue iDifficulty_pre( pCheck1_2.GetKeyvalue( "$i_difficulty" ) );
				int iDifficulty = iDifficulty_pre.GetInteger();
				switch ( iDifficulty )
				{
					case 1:
					{
						if ( pPlayer.pev.frags >= 145.0 ) // This is 4% of map's max score
						{
							// Get!
							CustomKeyvalues@ pUnlock = pPlayer.GetCustomKeyvalues();
							pUnlock.SetKeyvalue( "$i_a_unlock", 10 );
						}
						break;
					}
					case 2:
					{
						if ( pPlayer.pev.frags >= 295.0 ) // This is 8% of map's max score
						{
							// Get!
							CustomKeyvalues@ pUnlock = pPlayer.GetCustomKeyvalues();
							pUnlock.SetKeyvalue( "$i_a_unlock", 11 );
						}
						break;
					}
					case 3:
					{
						if ( pPlayer.pev.frags >= 445.0 ) // This is 12% of map's max score
						{
							// Get!
							CustomKeyvalues@ pUnlock = pPlayer.GetCustomKeyvalues();
							pUnlock.SetKeyvalue( "$i_a_unlock", 13 );
						}
						break;
					}
				}
			}
		}
		
		return;
	}
	
	g_Scheduler.SetTimeout( "toadsnatch_check", 0.1 );
}

void gausslabbeta2_check()
{
	if ( szMap != 'gausslabbeta2' )
		return;
	
	// Loop through all players
	for ( int i = 1; i <= g_Engine.maxClients; i++ )
	{
		CBasePlayer@ pPlayer = g_PlayerFuncs.FindPlayerByIndex( i );
		
		if ( pPlayer !is null && pPlayer.IsConnected() )
		{
			CustomKeyvalues@ pCheck = pPlayer.GetCustomKeyvalues();
			
			CustomKeyvalue iStart_pre( pCheck.GetKeyvalue( "$i_active" ) );
			CustomKeyvalue iFinish_pre( pCheck.GetKeyvalue( "$i_finish" ) );
			int iStart = iStart_pre.GetInteger();
			int iFinish = iFinish_pre.GetInteger();
			
			// Timer is active? (Started map)
			if ( iStart == 1 )
			{
				// Finished the map?
				if ( iFinish == 1 )
				{
					// Within time limit?
					if ( pPlayer.pev.iuser4 <= 1800 ) // Ticks are every 0.1 sec
					{
						// To prevent abuse, player must have at least this much score
						if ( pPlayer.pev.frags >= 2.0 ) // GENERIC LIMITER LULZ
						{
							// Get!
							CustomKeyvalues@ pUnlock = pPlayer.GetCustomKeyvalues();
							pUnlock.SetKeyvalue( "$i_a_unlock", 18 );
						}
					}
				}
				else // Not yet
					pPlayer.pev.iuser4 = pPlayer.pev.iuser4 + 1; // Increase elapsed time
			}
		}
	}
	
	g_Scheduler.SetTimeout( "gausslabbeta2_check", 0.1 );
}

void quarter_check()
{
	if ( szMap != 'quarter' )
		return;
	
	CBaseEntity@ pCheck1_1 = g_EntityFuncs.FindEntityByTargetname( null, "sys_adata" );
	if ( pCheck1_1 is null )
		return;
	
	CustomKeyvalues@ pCheck1_2 = pCheck1_1.GetCustomKeyvalues();
	CustomKeyvalue iCheck1_pre( pCheck1_2.GetKeyvalue( "$i_active" ) );
	int iCheck1 = iCheck1_pre.GetInteger();
	if ( iCheck1 == 1 )
	{
		// Reached map end?
		CustomKeyvalue iCheck2_pre( pCheck1_2.GetKeyvalue( "$i_test" ) );
		int iCheck2 = iCheck2_pre.GetInteger();
		if ( iCheck2 == 1 )
		{
			CustomKeyvalue iCheck3_pre( pCheck1_2.GetKeyvalue( "$i_fail" ) );
			int iCheck3 = iCheck3_pre.GetInteger();
			
			// Perfect run?
			if ( iCheck3 == 0 )	
			{
				for ( int i = 1; i <= g_Engine.maxClients; i++ )
				{
					CBasePlayer@ pPlayer = g_PlayerFuncs.FindPlayerByIndex( i );
					if ( pPlayer !is null && pPlayer.IsConnected() )
					{
						// To prevent abuse, player must have at least this much score
						if ( pPlayer.pev.frags >= 120.0 ) // This is 20% of map's max score
						{
							// Get!
							
							// HOLD IT! Two achievements are being given at the same time
							// and the system does NOT support that! Wait for our first
							// achievement to be given first and THEN add this one
							g_Scheduler.SetTimeout( "a16_unlock", 1.50, pPlayer.entindex() );
						}
					}
				}
			}
			
			for ( int i = 1; i <= g_Engine.maxClients; i++ )
			{
				CBasePlayer@ pPlayer = g_PlayerFuncs.FindPlayerByIndex( i );
				if ( pPlayer !is null && pPlayer.IsConnected() )
				{
					// To prevent abuse, player must have at least this much score
					if ( pPlayer.pev.frags >= 120.0 ) // This is 20% of map's max score
					{
						// Get!
						CustomKeyvalues@ pUnlock = pPlayer.GetCustomKeyvalues();
						pUnlock.SetKeyvalue( "$i_a_unlock", 16 );
					}
				}
			}
			
			return;
		}
	}
	
	g_Scheduler.SetTimeout( "quarter_check", 0.1 );
}
void a16_unlock( const int& in index )
{
	CBasePlayer@ pPlayer = g_PlayerFuncs.FindPlayerByIndex( index );
	if ( pPlayer !is null && pPlayer.IsConnected() )
	{
		CustomKeyvalues@ pUnlock = pPlayer.GetCustomKeyvalues();
		pUnlock.SetKeyvalue( "$i_a_unlock", 17 );
	}
}

void sc_persia_check()
{
	if ( szMap != 'sc_persia' )
		return;
	
	CBaseEntity@ pCheck1_1 = g_EntityFuncs.FindEntityByTargetname( null, "sys_adata" );
	if ( pCheck1_1 is null )
		return;
	
	CustomKeyvalues@ pCheck1_2 = pCheck1_1.GetCustomKeyvalues();
	CustomKeyvalue iCheck_pre( pCheck1_2.GetKeyvalue( "$i_test" ) );
	int iCheck = iCheck_pre.GetInteger();
	if ( iCheck == 1 )
	{
		for ( int i = 1; i <= g_Engine.maxClients; i++ )
		{
			CBasePlayer@ pPlayer = g_PlayerFuncs.FindPlayerByIndex( i );
			
			if ( pPlayer !is null && pPlayer.IsConnected() )
			{
				// Check whenever the player has no deaths
				if ( pPlayer.m_iDeaths == 0 )
				{
					CustomKeyvalues@ pCheck2_1 = pPlayer.GetCustomKeyvalues();
					
					// Antigravity check
					CustomKeyvalue iCheck2_pre( pCheck2_1.GetKeyvalue( "$i_gravity" ) );
					int iCheck2 = iCheck2_pre.GetInteger();
					if ( iCheck2 == 0 )
					{
						// No cheating
						CustomKeyvalue iCheck3_pre( pCheck2_1.GetKeyvalue( "$i_old_gravity" ) );
						int iCheck3 = iCheck3_pre.GetInteger();
						if ( iCheck3 == 0 )
						{
							// To prevent abuse, player must have at least this much score
							if ( pPlayer.pev.frags >= 60.0 ) // This is 20% of map's max score
							{
								// Get!
								pCheck2_1.SetKeyvalue( "$i_a_unlock", 19 );
							}
						}
					}
				}
			}
		}
		
		return;
	}
	
	g_Scheduler.SetTimeout( "sc_persia_check", 0.1 );
}

void it_has_leaks_check()
{
	if ( szMap != 'it_has_leaks' )
		return;
	
	CBaseEntity@ pCheck1_1 = g_EntityFuncs.FindEntityByTargetname( null, "sys_adata" );
	if ( pCheck1_1 is null )
		return;
	
	CustomKeyvalues@ pCheck1_2 = pCheck1_1.GetCustomKeyvalues();
	
	// Alternate check, secrets found
	CustomKeyvalue iSecrets_pre( pCheck1_2.GetKeyvalue( "$i_secrets" ) );
	int iSecrets = iSecrets_pre.GetInteger();
	if ( iSecrets == 12 )
	{
		for ( int i = 1; i <= g_Engine.maxClients; i++ )
		{
			CBasePlayer@ pPlayer = g_PlayerFuncs.FindPlayerByIndex( i );
			
			if ( pPlayer !is null && pPlayer.IsConnected() )
			{
				// To prevent abuse, player must have at least this much score
				if ( pPlayer.pev.frags >= 60.0 ) // This is 10% of map's max score
				{
					// Get!
					CustomKeyvalues@ pUnlock = pPlayer.GetCustomKeyvalues();
					pUnlock.SetKeyvalue( "$i_a_unlock", 86 );
				}
			}
		}
		
		// Don't loop
		pCheck1_2.SetKeyvalue( "$i_secrets", 0 );
	}
	
	CustomKeyvalue iCheck_pre( pCheck1_2.GetKeyvalue( "$i_test" ) );
	int iCheck = iCheck_pre.GetInteger();
	if ( iCheck == 1 )
	{
		for ( int i = 1; i <= g_Engine.maxClients; i++ )
		{
			CBasePlayer@ pPlayer = g_PlayerFuncs.FindPlayerByIndex( i );
			
			if ( pPlayer !is null && pPlayer.IsConnected() )
			{
				// Check whenever the player has no deaths
				if ( pPlayer.m_iDeaths == 0 )
				{
					CustomKeyvalues@ pCheck2_1 = pPlayer.GetCustomKeyvalues();
					
					// Check if the player has the following handicaps activated
					CustomKeyvalue iHandicap02_pre( pCheck2_1.GetKeyvalue( "$i_handicap02" ) );
					CustomKeyvalue iHandicap11_pre( pCheck2_1.GetKeyvalue( "$i_handicap11" ) );
					
					int iHandicap02 = iHandicap02_pre.GetInteger();
					int iHandicap11 = iHandicap11_pre.GetInteger();
					if ( iHandicap02 == 1 && iHandicap11 == 1 )
					{
						// To prevent abuse, player must have at least this much score
						if ( pPlayer.pev.frags >= 120.0 ) // This is 20% of map's max score
						{
							// Get!
							pCheck2_1.SetKeyvalue( "$i_a_unlock", 20 );
						}
					}
				}
			}
		}
		
		return;
	}
	
	g_Scheduler.SetTimeout( "it_has_leaks_check", 0.1 );
}

void mommamesa_check()
{
	if ( szMap != 'mommamesa' )
		return;
	
	CBaseEntity@ pCheck1_1 = g_EntityFuncs.FindEntityByTargetname( null, "sys_adata" );
	if ( pCheck1_1 is null )
		return;
	
	CustomKeyvalues@ pCheck1_2 = pCheck1_1.GetCustomKeyvalues();
	CustomKeyvalue iCheck_pre( pCheck1_2.GetKeyvalue( "$i_test" ) );
	int iCheck = iCheck_pre.GetInteger();
	if ( iCheck == 1 )
	{
		for ( int i = 1; i <= g_Engine.maxClients; i++ )
		{
			CBasePlayer@ pPlayer = g_PlayerFuncs.FindPlayerByIndex( i );
			
			if ( pPlayer !is null && pPlayer.IsConnected() )
			{
				CustomKeyvalues@ pCheck = pPlayer.GetCustomKeyvalues();
				
				// Get map difficulty
				CustomKeyvalue iDifficulty_pre( pCheck1_2.GetKeyvalue( "$i_difficulty" ) );
				int iDifficulty = iDifficulty_pre.GetInteger();
				if ( iDifficulty == 1 ) // Nightmare difficulty?
				{
					CustomKeyvalue iBest_pre( pCheck1_2.GetKeyvalue( "$i_best" ) );
					int iBest = iBest_pre.GetInteger();
					if ( iBest == 1 ) // Best Ending get?
					{
						// To prevent abuse, player must have at least this much score
						if ( pPlayer.pev.frags >= 215.0 ) // This is 24% of map's max score
						{
							// Get!
							
							// Another achievement is being given, wait
							g_Scheduler.SetTimeout( "a24_unlock", 1.50, pPlayer.entindex() );
						}
					}
				}
				
				// Any other difficulty
				// To prevent abuse, player must have at least this much score
				if ( pPlayer.pev.frags >= 180.0 ) // This is 20% of map's max score
				{
					// Get!
					pCheck.SetKeyvalue( "$i_a_unlock", 22 );
				}
				
				// Player escaed the self-destruct sequence?
				CustomKeyvalue iEscaped_pre( pCheck.GetKeyvalue( "$i_escape" ) );
				int iEscaped = iEscaped_pre.GetInteger();
				if ( iEscaped == 1 )
				{
					// To prevent abuse, player must have at least this much score, YES I'M THAT EVIL ON THIS ONE
					if ( pPlayer.pev.frags >= 90.0 ) // This is 10% of map's max score
					{
						// Get!
						
						// Another achievement is being given, wait
						g_Scheduler.SetTimeout( "a22_unlock", 1.50, pPlayer.entindex() );
					}
					
				}
			}
		}
		
		return;
	}
	
	g_Scheduler.SetTimeout( "mommamesa_check", 0.1 );
}
void a22_unlock( const int& in index )
{
	CBasePlayer@ pPlayer = g_PlayerFuncs.FindPlayerByIndex( index );
	if ( pPlayer !is null )
	{
		CustomKeyvalues@ pUnlock = pPlayer.GetCustomKeyvalues();
		pUnlock.SetKeyvalue( "$i_a_unlock", 23 );
	}
}
void a24_unlock( const int& in index )
{
	CBasePlayer@ pPlayer = g_PlayerFuncs.FindPlayerByIndex( index );
	if ( pPlayer !is null )
	{
		CustomKeyvalues@ pUnlock = pPlayer.GetCustomKeyvalues();
		pUnlock.SetKeyvalue( "$i_a_unlock", 25 );
	}
}

void never_check()
{
	if ( szMap != 'never' )
		return;
	
	CBaseEntity@ pCheck1_1 = g_EntityFuncs.FindEntityByTargetname( null, "sys_adata" );
	if ( pCheck1_1 is null )
		return;
	
	CustomKeyvalues@ pCheck1_2 = pCheck1_1.GetCustomKeyvalues();
	CustomKeyvalue iCheck_pre( pCheck1_2.GetKeyvalue( "$i_test" ) );
	int iCheck = iCheck_pre.GetInteger();
	if ( iCheck == 1 )
	{
		for ( int i = 1; i <= g_Engine.maxClients; i++ )
		{
			CBasePlayer@ pPlayer = g_PlayerFuncs.FindPlayerByIndex( i );
			
			if ( pPlayer !is null && pPlayer.IsConnected() )
			{
				// Check whenever the player has no deaths
				if ( pPlayer.m_iDeaths == 0 )
				{
					// To prevent abuse, player must have at least this much score
					if ( pPlayer.pev.frags >= 80.0 ) // This is 20% of map's max score
					{
						// Get!
						CustomKeyvalues@ pUnlock = pPlayer.GetCustomKeyvalues();
						pUnlock.SetKeyvalue( "$i_a_unlock", 26 );
					}
				}
			}
		}
		
		return;
	}
	
	g_Scheduler.SetTimeout( "never_check", 0.1 );
}

void gash_check()
{
	if ( szMap != 'gash' )
		return;
	
	CBaseEntity@ pCheck1_1 = g_EntityFuncs.FindEntityByTargetname( null, "sys_adata" );
	if ( pCheck1_1 is null )
		return;
	
	CustomKeyvalues@ pCheck1_2 = pCheck1_1.GetCustomKeyvalues();
	CustomKeyvalue iCheck_pre( pCheck1_2.GetKeyvalue( "$i_test" ) );
	int iCheck = iCheck_pre.GetInteger();
	if ( iCheck == 1 )
	{
		for ( int i = 1; i <= g_Engine.maxClients; i++ )
		{
			CBasePlayer@ pPlayer = g_PlayerFuncs.FindPlayerByIndex( i );
			
			if ( pPlayer !is null && pPlayer.IsConnected() )
			{
				// Check whenever the player has less than this many deaths
				if ( pPlayer.m_iDeaths < 3 )
				{
					// To prevent abuse, player must have at least this much score
					if ( pPlayer.pev.frags >= 45.0 ) // This is 15% of map's max score
					{
						// Get!
						CustomKeyvalues@ pUnlock = pPlayer.GetCustomKeyvalues();
						pUnlock.SetKeyvalue( "$i_a_unlock", 28 );
					}
				}
			}
		}
		
		return;
	}
	
	g_Scheduler.SetTimeout( "gash_check", 0.1 );
}

void hostage_check()
{
	if ( szMap != 'hostage' )
		return;
	
	CBaseEntity@ pCheck1_1 = g_EntityFuncs.FindEntityByTargetname( null, "sys_adata" );
	if ( pCheck1_1 is null )
		return;
	
	CustomKeyvalues@ pCheck1_2 = pCheck1_1.GetCustomKeyvalues();
	CustomKeyvalue iCheck_pre( pCheck1_2.GetKeyvalue( "$i_test" ) );
	int iCheck = iCheck_pre.GetInteger();
	if ( iCheck == 1 )
	{
		for ( int i = 1; i <= g_Engine.maxClients; i++ )
		{
			CBasePlayer@ pPlayer = g_PlayerFuncs.FindPlayerByIndex( i );
			
			if ( pPlayer !is null && pPlayer.IsConnected() )
			{
				// To prevent abuse, player must have at least this much score
				if ( pPlayer.pev.frags >= 60.0 ) // This is 20% of map's max score
				{
					// Get!
					CustomKeyvalues@ pUnlock = pPlayer.GetCustomKeyvalues();
					pUnlock.SetKeyvalue( "$i_a_unlock", 29 );
				}
			}
		}
		
		return;
	}
	
	g_Scheduler.SetTimeout( "hostage_check", 0.1 );
}

void ub_nagoya_v2_check()
{
	if ( szMap != 'ub_nagoya_v2' )
		return;
	
	for ( int i = 1; i <= g_Engine.maxClients; i++ )
	{
		CBasePlayer@ pPlayer = g_PlayerFuncs.FindPlayerByIndex( i );
		
		if ( pPlayer !is null && pPlayer.IsConnected() )
		{
			// Check whenever the player has destroyed all 5 secret boxes
			CustomKeyvalues@ pCheck = pPlayer.GetCustomKeyvalues();
			CustomKeyvalue iBoxes_pre( pCheck.GetKeyvalue( "$i_boxes" ) );
			int iBoxes = iBoxes_pre.GetInteger();
			if ( iBoxes == 5 )
			{
				// Get!
				pCheck.SetKeyvalue( "$i_a_unlock", 31 );
				
				// Reset to prevent looping
				pCheck.SetKeyvalue( "$i_boxes", 0 );
			}
		}
	}
	
	g_Scheduler.SetTimeout( "ub_nagoya_v2_check", 0.1 );
}

void ub_iseki2_check()
{
	if ( szMap != 'ub_iseki2' )
		return;
	
	CBaseEntity@ pCheck1_1 = g_EntityFuncs.FindEntityByTargetname( null, "sys_adata" );
	if ( pCheck1_1 is null )
		return;
	
	CustomKeyvalues@ pCheck1_2 = pCheck1_1.GetCustomKeyvalues();
	CustomKeyvalue iCheck1_pre( pCheck1_2.GetKeyvalue( "$i_test" ) );
	int iCheck1 = iCheck1_pre.GetInteger();
	if ( iCheck1 == 1 )
	{
		for ( int i = 1; i <= g_Engine.maxClients; i++ )
		{
			CBasePlayer@ pPlayer = g_PlayerFuncs.FindPlayerByIndex( i );
			
			if ( pPlayer !is null && pPlayer.IsConnected() )
			{
				CustomKeyvalues@ pCheck2_1 = pPlayer.GetCustomKeyvalues();
				CustomKeyvalue iCheck2_pre( pCheck2_1.GetKeyvalue( "$i_fail" ) );
				int iCheck2 = iCheck2_pre.GetInteger();
				
				// Check whenever the player has NOT been killed by the boss or it's enemies
				if ( iCheck2 == 0 )
				{
					// To prevent abuse, player must have at least this much score
					if ( pPlayer.pev.frags >= 50.0 ) // This is 25% of SECOND map's max score
					{
						// Get!
						pCheck2_1.SetKeyvalue( "$i_a_unlock", 32 );
					}
				}
			}
		}
		
		return;
	}
	
	g_Scheduler.SetTimeout( "ub_iseki2_check", 0.1 );
}

void deadsimpleneo2_check()
{
	if ( szMap != 'deadsimpleneo2' )
		return;
	
	CBaseEntity@ pCheck1_1 = g_EntityFuncs.FindEntityByTargetname( null, "sys_adata" );
	if ( pCheck1_1 is null )
		return;
	
	CustomKeyvalues@ pCheck1_2 = pCheck1_1.GetCustomKeyvalues();
	CustomKeyvalue iCheck_pre( pCheck1_2.GetKeyvalue( "$i_test" ) );
	int iCheck = iCheck_pre.GetInteger();
	if ( iCheck == 1 )
	{
		for ( int i = 1; i <= g_Engine.maxClients; i++ )
		{
			CBasePlayer@ pPlayer = g_PlayerFuncs.FindPlayerByIndex( i );
			
			if ( pPlayer !is null && pPlayer.IsConnected() )
			{
				CustomKeyvalue iMode_pre( pCheck1_2.GetKeyvalue( "$i_mode" ) );
				int iMode = iMode_pre.GetInteger();
				if ( iMode == 1 ) // Overload gamemode?
				{
					// To prevent abuse, player must have at least this much score
					if ( pPlayer.pev.frags >= 195.0 ) // This is 15% of map's max score
					{
						// Get!
						CustomKeyvalues@ pUnlock = pPlayer.GetCustomKeyvalues();
						pUnlock.SetKeyvalue( "$i_a_unlock", 34 );
					}
				}
				else if ( iMode == 2 ) // Gonome Hunter gamemode?
				{
					// To prevent abuse, player must have at least this much score
					if ( pPlayer.pev.frags >= 325.0 ) // This is 25% of map's max score
					{
						// Get!
						CustomKeyvalues@ pUnlock = pPlayer.GetCustomKeyvalues();
						pUnlock.SetKeyvalue( "$i_a_unlock", 35 );
					}
				}
				else if ( iMode == 3 ) // Protection gamemode?
				{
					// To prevent abuse, player must have at least this much score
					if ( pPlayer.pev.frags >= 195.0 ) // This is 15% of map's max score
					{
						// Get!
						CustomKeyvalues@ pUnlock = pPlayer.GetCustomKeyvalues();
						pUnlock.SetKeyvalue( "$i_a_unlock", 156 );
					}
				}
			}
		}
		
		return;
	}
	
	g_Scheduler.SetTimeout( "deadsimpleneo2_check", 0.1 );
}

void BlackMesaEPF_check()
{
	if ( szMap != 'BlackMesaEPF' )
		return;
	
	for ( int i = 1; i <= g_Engine.maxClients; i++ )
	{
		CBasePlayer@ pPlayer = g_PlayerFuncs.FindPlayerByIndex( i );
		
		if ( pPlayer !is null && pPlayer.IsConnected() )
		{
			// Check whenever the player has gone through the lasers
			CustomKeyvalues@ pCheck = pPlayer.GetCustomKeyvalues();
			CustomKeyvalue iPass_pre( pCheck.GetKeyvalue( "$i_pass" ) );
			int iPass = iPass_pre.GetInteger();
			if ( iPass == 1 )
			{
				// Get!
				pCheck.SetKeyvalue( "$i_a_unlock", 36 );
				
				// Reset to prevent looping
				pCheck.SetKeyvalue( "$i_pass", 0 );
			}
		}
	}
	
	g_Scheduler.SetTimeout( "BlackMesaEPF_check", 0.1 );
}

void sc_dark_seekers_final_check()
{
	if ( szMap != 'sc_dark_seekers_final' )
		return;
	
	// Locate changelevel entity
	CBaseEntity@ pEntity = g_EntityFuncs.FindEntityByClassname( null, "trigger_changelevel" );
	
	if ( pEntity !is null )
	{
		// Achievement already given?
		if ( pEntity.pev.iuser4 >= 15 )
			return;
		
		// Get the "center" of this brush entity
		Vector vecOrigin1;
		get_brush_entity_origin( pEntity, vecOrigin1 );
		
		// Check for nearby players
		for ( int i = 1; i <= g_Engine.maxClients; i++ )
		{
			CBasePlayer@ pPlayer = g_PlayerFuncs.FindPlayerByIndex( i );
			if ( pPlayer !is null && pPlayer.IsConnected() )
			{
				Vector vecOrigin2 = pPlayer.pev.origin;
				
				// Achievement not yet given?
				if ( pEntity.pev.iuser4 == 0 )
				{
					// Check for the first player near map end
					// We use a considerably high distance because the new achievement data
					// might be not saved on time before the actual changelevel occurs
					if ( ( vecOrigin1 - vecOrigin2 ).Length() <= 256.0 )
					{
						// Check whenever the player has no deaths
						if ( pPlayer.m_iDeaths == 0 )
						{
							// To prevent abuse, player must have at least this much score
							if ( pPlayer.pev.frags >= 140.0 ) // This is 20% of FIRST map's max score
							{
								// Get!
								CustomKeyvalues@ pUnlock = pPlayer.GetCustomKeyvalues();
								pUnlock.SetKeyvalue( "$i_a_unlock", 37 );
								
								// Declare achievement as given
								pEntity.pev.iuser4 = 1;
							}
						}
					}
				}
				else // Achievement is declared as given
				{
					// Ignore distance of other players and unlock if criteria is met
					
					// Check whenever the player has no deaths
					if ( pPlayer.m_iDeaths == 0 )
					{
						// To prevent abuse, player must have at least this much score
						if ( pPlayer.pev.frags >= 155.0 ) // This is 22% of FIRST map's max score, slighly increased score as the player might be anywhere
						{
							// Get!
							CustomKeyvalues@ pUnlock = pPlayer.GetCustomKeyvalues();
							pUnlock.SetKeyvalue( "$i_a_unlock", 37 );
						}
					}
					
					// Iterate a maximum of 15 times
					pEntity.pev.iuser4 = pEntity.pev.iuser4 + 1;
				}
			}
		}
	}
	
	g_Scheduler.SetTimeout( "sc_dark_seekers_final_check", 0.1 );
}

void ub_megaman2_check()
{
	if ( szMap != 'ub_megaman2' )
		return;
	
	CBaseEntity@ pCheck1_1 = g_EntityFuncs.FindEntityByTargetname( null, "sys_adata" );
	if ( pCheck1_1 is null )
		return;
	
	CustomKeyvalues@ pCheck1_2 = pCheck1_1.GetCustomKeyvalues();
	CustomKeyvalue iCheck_pre( pCheck1_2.GetKeyvalue( "$i_weapons" ) );
	int iCheck = iCheck_pre.GetInteger();
	if ( iCheck == 3 ) // All weapons get?
	{
		for ( int i = 1; i <= g_Engine.maxClients; i++ )
		{
			CBasePlayer@ pPlayer = g_PlayerFuncs.FindPlayerByIndex( i );
			
			if ( pPlayer !is null && pPlayer.IsConnected() )
			{
				// To prevent abuse, player must have at least this much score
				if ( pPlayer.pev.frags >= 45.0 ) // This is 10% of SECOND map's max score
				{
					// Get!
					CustomKeyvalues@ pUnlock = pPlayer.GetCustomKeyvalues();
					pUnlock.SetKeyvalue( "$i_a_unlock", 38 );
				}
			}
		}
		
		// Reset, no looping
		pCheck1_2.SetKeyvalue( "$i_weapons", 0 );
		
		return;
	}
	
	g_Scheduler.SetTimeout( "ub_megaman2_check", 0.1 );
}

void dc_inflight_check()
{
	if ( szMap != 'dc_inflight' )
		return;
	
	CBaseEntity@ pCheck1_1 = g_EntityFuncs.FindEntityByTargetname( null, "sys_adata" );
	if ( pCheck1_1 is null )
		return;
	
	CustomKeyvalues@ pCheck1_2 = pCheck1_1.GetCustomKeyvalues();
	CustomKeyvalue iCheck_pre( pCheck1_2.GetKeyvalue( "$i_test" ) );
	int iCheck = iCheck_pre.GetInteger();
	if ( iCheck == 1 )
	{
		CustomKeyvalue iFail_pre( pCheck1_2.GetKeyvalue( "$i_fail" ) );
		int iFail = iFail_pre.GetInteger();
		if ( iFail == 0 ) // Still under 800 HP damage limit?
		{
			for ( int i = 1; i <= g_Engine.maxClients; i++ )
			{
				CBasePlayer@ pPlayer = g_PlayerFuncs.FindPlayerByIndex( i );
				
				if ( pPlayer !is null && pPlayer.IsConnected() )
				{
					// To prevent abuse, player must have at least this much score
					if ( pPlayer.pev.frags >= 125.0 ) // This is 10% of map's max score
					{
						// Get!
						CustomKeyvalues@ pUnlock = pPlayer.GetCustomKeyvalues();
						pUnlock.SetKeyvalue( "$i_a_unlock", 39 );
					}
				}
			}
		}
		
		return;
	}
	
	g_Scheduler.SetTimeout( "dc_inflight_check", 0.1 );
}

void sandstone_check()
{
	if ( szMap != 'sandstone' )
		return;
	
	CBaseEntity@ pCheck1_1 = g_EntityFuncs.FindEntityByTargetname( null, "sys_adata" );
	if ( pCheck1_1 is null )
		return;
	
	// 60 second tolerance before timer starts
	if ( pCheck1_1.pev.iuser4 >= 600 )
	{
		// Timer started, finished in less than 9 minutes?
		if ( pCheck1_1.pev.iuser3 <= 5400 )
		{
			CustomKeyvalues@ pCheck1_2 = pCheck1_1.GetCustomKeyvalues();
			CustomKeyvalue iCheck_pre( pCheck1_2.GetKeyvalue( "$i_test" ) );
			int iCheck = iCheck_pre.GetInteger();
			if ( iCheck == 1 )
			{
				for ( int i = 1; i <= g_Engine.maxClients; i++ )
				{
					CBasePlayer@ pPlayer = g_PlayerFuncs.FindPlayerByIndex( i );
					
					if ( pPlayer !is null && pPlayer.IsConnected() )
					{
						// To prevent abuse, player must have at least this much score
						if ( pPlayer.pev.frags >= 50.0 ) // This is 10% of map's max score
						{
							// Get!
							CustomKeyvalues@ pUnlock = pPlayer.GetCustomKeyvalues();
							pUnlock.SetKeyvalue( "$i_a_unlock", 40 );
						}
					}
				}
				
				return;
			}
		}
		
		pCheck1_1.pev.iuser3 = pCheck1_1.pev.iuser3 + 1;
	}
	else
		pCheck1_1.pev.iuser4 = pCheck1_1.pev.iuser4 + 1;
	
	g_Scheduler.SetTimeout( "sandstone_check", 0.1 );
}

void sc_trollworld_check()
{
	if ( szMap != 'sc_trollworld' )
		return;
	
	CBaseEntity@ pCheck1_1 = g_EntityFuncs.FindEntityByTargetname( null, "sys_adata" );
	if ( pCheck1_1 is null )
		return;
	
	CustomKeyvalues@ pCheck1_2 = pCheck1_1.GetCustomKeyvalues();
	CustomKeyvalue iCheck_pre( pCheck1_2.GetKeyvalue( "$i_test" ) );
	int iCheck = iCheck_pre.GetInteger();
	if ( iCheck == 1 )
	{
		for ( int i = 1; i <= g_Engine.maxClients; i++ )
		{
			CBasePlayer@ pPlayer = g_PlayerFuncs.FindPlayerByIndex( i );
			
			if ( pPlayer !is null && pPlayer.IsConnected() )
			{
				// Check whenever the player has escaped
				CustomKeyvalues@ pCheck = pPlayer.GetCustomKeyvalues();
				CustomKeyvalue iEscaped_pre( pCheck.GetKeyvalue( "$i_escape" ) );
				int iEscaped = iEscaped_pre.GetInteger();
				if ( iEscaped == 1 )
				{
					// To prevent abuse, player must have at least this much score
					if ( pPlayer.pev.frags >= 125.0 ) // This is 25% of map's max score (I do not think the XPGain of 90% is appropiate)
					{
						// Get!
						pCheck.SetKeyvalue( "$i_a_unlock", 41 );
						
						// Reset to prevent looping
						pCheck.SetKeyvalue( "$i_escape", 0 );
					}
				}
			}
		}
		
		return;
	}
	
	g_Scheduler.SetTimeout( "sc_trollworld_check", 0.1 );
}

void ghost_buster_check()
{
	if ( szMap != 'ghost_buster' )
		return;
	
	CBaseEntity@ pCheck1_1 = g_EntityFuncs.FindEntityByTargetname( null, "sys_adata" );
	if ( pCheck1_1 is null )
		return;
	
	CustomKeyvalues@ pCheck1_2 = pCheck1_1.GetCustomKeyvalues();
	CustomKeyvalue iCheck_pre( pCheck1_2.GetKeyvalue( "$i_test" ) );
	int iCheck = iCheck_pre.GetInteger();
	if ( iCheck == 1 )
	{
		for ( int i = 1; i <= g_Engine.maxClients; i++ )
		{
			CBasePlayer@ pPlayer = g_PlayerFuncs.FindPlayerByIndex( i );
			
			if ( pPlayer !is null && pPlayer.IsConnected() )
			{
				// To prevent abuse, player must have at least this much score
				if ( pPlayer.pev.frags >= 8.0 ) // This is 4% of map's max score
				{
					// Get!
					CustomKeyvalues@ pUnlock = pPlayer.GetCustomKeyvalues();
					pUnlock.SetKeyvalue( "$i_a_unlock", 43 );
				}
			}
		}
		
		return;
	}
	
	g_Scheduler.SetTimeout( "ghost_buster_check", 0.1 );
}

void jumpers_check()
{
	if ( szMap != 'jumpers' )
		return;
	
	CBaseEntity@ pCheck1_1 = g_EntityFuncs.FindEntityByTargetname( null, "sys_adata" );
	if ( pCheck1_1 is null )
		return;
	
	CustomKeyvalues@ pCheck1_2 = pCheck1_1.GetCustomKeyvalues();
	CustomKeyvalue iCheck_pre( pCheck1_2.GetKeyvalue( "$i_active" ) );
	int iCheck = iCheck_pre.GetInteger();
	if ( iCheck == 1 )
	{
		// Timer started, 60 minutes has yet to lapse?
		if ( pCheck1_1.pev.iuser3 <= 36000 )
		{
			// Jumper only
			CBaseEntity@ pPlayer = g_EntityFuncs.FindEntityByTargetname( null, "jumper" );
			if ( pPlayer is null )
				return;
			
			CBaseEntity@ pScore = g_EntityFuncs.FindEntityByTargetname( null, "capcounter" );
			if ( pScore is null )
				return;
			
			if ( pScore.pev.frags >= 160 )
			{
				// Get!
				CustomKeyvalues@ pUnlock = pPlayer.GetCustomKeyvalues();
				pUnlock.SetKeyvalue( "$i_a_unlock", 44 );
				
				return;
			}
		}
		
		pCheck1_1.pev.iuser3 = pCheck1_1.pev.iuser3 + 1;
	}
	
	g_Scheduler.SetTimeout( "jumpers_check", 0.1 );
}

void deluge_beta_v3_check()
{
	if ( szMap != 'deluge_beta_v3' )
		return;
	
	CBaseEntity@ pCheck1_1 = g_EntityFuncs.FindEntityByTargetname( null, "sys_adata" );
	if ( pCheck1_1 is null )
		return;
	
	CustomKeyvalues@ pCheck1_2 = pCheck1_1.GetCustomKeyvalues();
	CustomKeyvalue iCheck_pre( pCheck1_2.GetKeyvalue( "$i_test" ) );
	int iCheck = iCheck_pre.GetInteger();
	if ( iCheck == 1 )
	{
		for ( int i = 1; i <= g_Engine.maxClients; i++ )
		{
			CBasePlayer@ pPlayer = g_PlayerFuncs.FindPlayerByIndex( i );
			
			if ( pPlayer !is null && pPlayer.IsConnected() )
			{
				// Get map difficulty
				CustomKeyvalue iDifficulty_pre( pCheck1_2.GetKeyvalue( "$i_difficulty" ) );
				int iDifficulty = iDifficulty_pre.GetInteger();
				switch ( iDifficulty )
				{
					case 1:
					{
						if ( pPlayer.m_iDeaths < 7 ) // Deaths
						{
							if ( pPlayer.pev.frags >= 50.0 ) // This is 10% of map's max score
							{
								// Get!
								CustomKeyvalues@ pUnlock = pPlayer.GetCustomKeyvalues();
								pUnlock.SetKeyvalue( "$i_a_unlock", 46 );
							}
						}
						break;
					}
					case 2:
					{
						if ( pPlayer.m_iDeaths < 4 ) // Deaths
						{
							if ( pPlayer.pev.frags >= 75.0 ) // This is 15% of map's max score
							{
								// Get!
								CustomKeyvalues@ pUnlock = pPlayer.GetCustomKeyvalues();
								pUnlock.SetKeyvalue( "$i_a_unlock", 47 );
							}
						}
						break;
					}
					case 3:
					{
						if ( pPlayer.m_iDeaths == 0 ) // Deaths
						{
							if ( pPlayer.pev.frags >= 100.0 ) // This is 20% of map's max score
							{
								// Get!
								CustomKeyvalues@ pUnlock = pPlayer.GetCustomKeyvalues();
								pUnlock.SetKeyvalue( "$i_a_unlock", 49 );
							}
						}
						break;
					}
				}
			}
		}
		
		return;
	}
	
	g_Scheduler.SetTimeout( "deluge_beta_v3_check", 0.1 );
}

void sciguard2_check()
{
	if ( szMap != 'sciguard2' )
		return;
	
	CBaseEntity@ pCheck1_1 = g_EntityFuncs.FindEntityByTargetname( null, "sys_adata" );
	if ( pCheck1_1 is null )
		return;
	
	CustomKeyvalues@ pCheck1_2 = pCheck1_1.GetCustomKeyvalues();
	CustomKeyvalue iCheck1_pre( pCheck1_2.GetKeyvalue( "$i_test" ) );
	int iCheck1 = iCheck1_pre.GetInteger();
	if ( iCheck1 == 1 )
	{
		// No scientist deaths
		CustomKeyvalue iCheck2_pre( pCheck1_2.GetKeyvalue( "$i_fail" ) );
		int iCheck2 = iCheck2_pre.GetInteger();
		if ( iCheck2 == 0 )
		{
			for ( int i = 1; i <= g_Engine.maxClients; i++ )
			{
				CBasePlayer@ pPlayer = g_PlayerFuncs.FindPlayerByIndex( i );
				
				if ( pPlayer !is null && pPlayer.IsConnected() )
				{
					// To prevent abuse, player must have at least this much score
					if ( pPlayer.pev.frags >= 140.0 ) // This is 10% of map's max score
					{
						// Get!
						CustomKeyvalues@ pUnlock = pPlayer.GetCustomKeyvalues();
						pUnlock.SetKeyvalue( "$i_a_unlock", 48 );
					}
				}
			}
		}
		
		return;
	}
	
	g_Scheduler.SetTimeout( "sciguard2_check", 0.1 );
}

void nm_uspninjas_check()
{
	if ( szMap != 'nm_uspninjas' )
		return;
	
	CBaseEntity@ pCheck1_1 = g_EntityFuncs.FindEntityByTargetname( null, "sys_adata" );
	if ( pCheck1_1 is null )
		return;
	
	CustomKeyvalues@ pCheck1_2 = pCheck1_1.GetCustomKeyvalues();
	CustomKeyvalue iCheck_pre( pCheck1_2.GetKeyvalue( "$i_test" ) );
	int iCheck = iCheck_pre.GetInteger();
	if ( iCheck == 1 )
	{
		for ( int i = 1; i <= g_Engine.maxClients; i++ )
		{
			CBasePlayer@ pPlayer = g_PlayerFuncs.FindPlayerByIndex( i );
			
			if ( pPlayer !is null && pPlayer.IsConnected() )
			{
				// Check whenever the player has no deaths
				if ( pPlayer.m_iDeaths == 0 )
				{
					// To prevent abuse, player must have at least this much score
					if ( pPlayer.pev.frags >= 100.0 ) // This is 20% of map's max score
					{
						// Get!
						CustomKeyvalues@ pUnlock = pPlayer.GetCustomKeyvalues();
						pUnlock.SetKeyvalue( "$i_a_unlock", 50 );
					}
				}
			}
		}
		
		return;
	}
	
	g_Scheduler.SetTimeout( "nm_uspninjas_check", 0.1 );
}

void fortified1_check()
{
	if ( szMap != 'fortified1' )
		return;
	
	CBaseEntity@ pCheck1_1 = g_EntityFuncs.FindEntityByTargetname( null, "sys_adata" );
	if ( pCheck1_1 is null )
		return;
	
	CustomKeyvalues@ pCheck1_2 = pCheck1_1.GetCustomKeyvalues();
	CustomKeyvalue iCheck_pre( pCheck1_2.GetKeyvalue( "$i_test" ) );
	int iCheck = iCheck_pre.GetInteger();
	if ( iCheck == 1 )
	{
		for ( int i = 1; i <= g_Engine.maxClients; i++ )
		{
			CBasePlayer@ pPlayer = g_PlayerFuncs.FindPlayerByIndex( i );
			
			if ( pPlayer !is null && pPlayer.IsConnected() )
			{
				CustomKeyvalues@ pUnlock = pPlayer.GetCustomKeyvalues();
				
				// Survival mode activated?
				CustomKeyvalue iSurvival_pre( pCheck1_2.GetKeyvalue( "$i_survival" ) );
				int iSurvival = iSurvival_pre.GetInteger();
				if ( iSurvival == 1 )
				{
					// Ultra Hard difficulty selected?
					CustomKeyvalue iDifficulty_pre( pCheck1_2.GetKeyvalue( "$i_difficulty" ) );
					int iDifficulty = iDifficulty_pre.GetInteger();
					if ( iDifficulty == 3 )
					{
						// To prevent abuse, player must have at least this much score
						if ( pPlayer.pev.frags >= 260.0 ) // This is 20% of map's max score
						{
							// Get!
							
							// x7 achievements? Okay, handle very carefully the delays
							g_Scheduler.SetTimeout( "a60_unlock", 1.5, pPlayer.entindex() );
						}
					}
					
					// Any difficulty clear
					if ( pPlayer.pev.frags >= 130.0 ) // This is 10% of map's max score
					{
						// Get!
						pUnlock.SetKeyvalue( "$i_a_unlock", 58 );
					}
				}
				else // Classic mode
				{
					// Difficulty clear
					
					// Get map difficulty
					CustomKeyvalue iDifficulty_pre( pCheck1_2.GetKeyvalue( "$i_difficulty" ) );
					int iDifficulty = iDifficulty_pre.GetInteger();
					switch ( iDifficulty )
					{
						case 1:
						{
							if ( pPlayer.pev.frags >= 130.0 ) // This is 10% of map's max score
							{
								// Get!
								g_Scheduler.SetTimeout( "a52_unlock", 1.5, pPlayer.entindex() );
							}
							break;
						}
						case 2:
						{
							if ( pPlayer.pev.frags >= 195.0 ) // This is 15% of map's max score
							{
								// Get!
								g_Scheduler.SetTimeout( "a54_unlock", 1.5, pPlayer.entindex() );
							}
							break;
						}
						case 3:
						{
							if ( pPlayer.pev.frags >= 260.0 ) // This is 20% of map's max score
							{
								// Get!
								g_Scheduler.SetTimeout( "a55_unlock", 1.5, pPlayer.entindex() );
							}
							break;
						}
					}
					
					// Any difficulty clear
					if ( pPlayer.pev.frags >= 65.0 ) // This is 5% of map's max score
					{
						// Get!
						pUnlock.SetKeyvalue( "$i_a_unlock", 52 );
					}
				}
				
				// Helper commander?
				CustomKeyvalue iLeft_pre( pUnlock.GetKeyvalue( "$i_left" ) );
				int iLeft = iLeft_pre.GetInteger();
				if ( iLeft == 1 )
				{
					// The commander must also did it's effort fighting, and a little tip bonus as well
					if ( pPlayer.pev.frags >= 285.0 ) // This is 22% of map's max score
					{
						// Get!
						g_Scheduler.SetTimeout( "a58_unlock", 2.5, pPlayer.entindex() );
					}
				}
			}
		}
		
		return;
	}
	
	g_Scheduler.SetTimeout( "fortified1_check", 0.1 );
}
void a52_unlock( const int& in index )
{
	CBasePlayer@ pPlayer = g_PlayerFuncs.FindPlayerByIndex( index );
	if ( pPlayer !is null )
	{
		CustomKeyvalues@ pUnlock = pPlayer.GetCustomKeyvalues();
		pUnlock.SetKeyvalue( "$i_a_unlock", 53 );
	}
}
void a54_unlock( const int& in index )
{
	CBasePlayer@ pPlayer = g_PlayerFuncs.FindPlayerByIndex( index );
	if ( pPlayer !is null )
	{
		CustomKeyvalues@ pUnlock = pPlayer.GetCustomKeyvalues();
		pUnlock.SetKeyvalue( "$i_a_unlock", 55 );
	}
}
void a55_unlock( const int& in index )
{
	CBasePlayer@ pPlayer = g_PlayerFuncs.FindPlayerByIndex( index );
	if ( pPlayer !is null )
	{
		CustomKeyvalues@ pUnlock = pPlayer.GetCustomKeyvalues();
		pUnlock.SetKeyvalue( "$i_a_unlock", 56 );
	}
}
void a58_unlock( const int& in index )
{
	CBasePlayer@ pPlayer = g_PlayerFuncs.FindPlayerByIndex( index );
	if ( pPlayer !is null )
	{
		CustomKeyvalues@ pUnlock = pPlayer.GetCustomKeyvalues();
		pUnlock.SetKeyvalue( "$i_a_unlock", 59 );
	}
}
void a60_unlock( const int& in index )
{
	CBasePlayer@ pPlayer = g_PlayerFuncs.FindPlayerByIndex( index );
	if ( pPlayer !is null )
	{
		CustomKeyvalues@ pUnlock = pPlayer.GetCustomKeyvalues();
		pUnlock.SetKeyvalue( "$i_a_unlock", 61 );
	}
}

void exposedB1_check()
{
	if ( szMap != 'exposedB1' )
		return;
	
	CBaseEntity@ pCheck1_1 = g_EntityFuncs.FindEntityByTargetname( null, "sys_adata" );
	if ( pCheck1_1 is null )
		return;
	
	CustomKeyvalues@ pCheck1_2 = pCheck1_1.GetCustomKeyvalues();
	CustomKeyvalue iCheck_pre( pCheck1_2.GetKeyvalue( "$i_test" ) );
	int iCheck = iCheck_pre.GetInteger();
	if ( iCheck == 1 )
	{
		for ( int i = 1; i <= g_Engine.maxClients; i++ )
		{
			CBasePlayer@ pPlayer = g_PlayerFuncs.FindPlayerByIndex( i );
			
			if ( pPlayer !is null && pPlayer.IsConnected() )
			{
				// Check whenever the player has no deaths
				if ( pPlayer.m_iDeaths == 0 )
				{
					// To prevent abuse, player must have at least this much score
					if ( pPlayer.pev.frags >= 80.0 ) // This is 20% of map's max score
					{
						// Get!
						CustomKeyvalues@ pUnlock = pPlayer.GetCustomKeyvalues();
						pUnlock.SetKeyvalue( "$i_a_unlock", 60 );
					}
				}
			}
		}
		
		return;
	}
	
	g_Scheduler.SetTimeout( "exposedB1_check", 0.1 );
}

void keen_birthday_part1_beta_check()
{
	if ( szMap != 'keen_birthday_part1_beta' )
		return;
	
	for ( int i = 1; i <= g_Engine.maxClients; i++ )
	{
		CBasePlayer@ pPlayer = g_PlayerFuncs.FindPlayerByIndex( i );
		
		if ( pPlayer !is null && pPlayer.IsConnected() )
		{
			// Check whenever the player has cleared the puzzle
			CustomKeyvalues@ pCheck = pPlayer.GetCustomKeyvalues();
			CustomKeyvalue iPass_pre( pCheck.GetKeyvalue( "$i_clear" ) );
			int iPass = iPass_pre.GetInteger();
			if ( iPass == 1 )
			{
				// Get!
				pCheck.SetKeyvalue( "$i_a_unlock", 62 );
				
				// Reset to prevent looping
				pCheck.SetKeyvalue( "$i_clear", 0 );
			}
		}
	}
	
	g_Scheduler.SetTimeout( "keen_birthday_part1_beta_check", 0.1 );
}

void sc_phantasmish_beta_check()
{
	if ( szMap != 'sc_phantasmish_beta' )
		return;
	
	CBaseEntity@ pCheck1_1 = g_EntityFuncs.FindEntityByTargetname( null, "sys_adata" );
	if ( pCheck1_1 is null )
		return;
	
	CustomKeyvalues@ pCheck1_2 = pCheck1_1.GetCustomKeyvalues();
	CustomKeyvalue iCheck_pre( pCheck1_2.GetKeyvalue( "$i_test" ) );
	int iCheck = iCheck_pre.GetInteger();
	if ( iCheck == 1 )
	{
		for ( int i = 1; i <= g_Engine.maxClients; i++ )
		{
			CBasePlayer@ pPlayer = g_PlayerFuncs.FindPlayerByIndex( i );
			
			if ( pPlayer !is null && pPlayer.IsConnected() )
			{
				// Check whenever the player less than this many deaths
				if ( pPlayer.m_iDeaths < 2 )
				{
					// To prevent abuse, player must have at least this much score
					if ( pPlayer.pev.frags >= 100.0 ) // This is 20% of map's max score
					{
						// Get!
						CustomKeyvalues@ pUnlock = pPlayer.GetCustomKeyvalues();
						pUnlock.SetKeyvalue( "$i_a_unlock", 64 );
					}
				}
			}
		}
		
		return;
	}
	
	g_Scheduler.SetTimeout( "sc_phantasmish_beta_check", 0.1 );
}

void skylined_check()
{
	if ( szMap != 'skylined' )
		return;
	
	CBaseEntity@ pCheck1_1 = g_EntityFuncs.FindEntityByTargetname( null, "sys_adata" );
	if ( pCheck1_1 is null )
		return;
	
	// This is definetively going to interfere with other achievements, but I'm taking the risk and leaving it as-is
	for ( int i = 1; i <= g_Engine.maxClients; i++ )
	{
		CBasePlayer@ pPlayer = g_PlayerFuncs.FindPlayerByIndex( i );
		
		if ( pPlayer !is null && pPlayer.IsConnected() )
		{
			Vector vecOrigin1 = pPlayer.pev.origin;
			Vector vecOrigin2 = pCheck1_1.pev.origin;
			
			// Prevent /spectate exploit
			if ( pPlayer.IsAlive() )
			{
				// Are we in our secret?
				if ( ( vecOrigin1 - vecOrigin2 ).Length() <= 80.0 )
				{
					// Get!
					CustomKeyvalues@ pUnlock = pPlayer.GetCustomKeyvalues();
					pUnlock.SetKeyvalue( "$i_a_unlock", 65 );
				}
				
				// Secret 2
				CBaseEntity@ pSpore = g_EntityFuncs.FindEntityByTargetname( null, "the_spore" );
				vecOrigin2 = pSpore.pev.origin;
				if ( ( vecOrigin1 - vecOrigin2 ).Length() <= 32.0 )
				{
					// Get!
					CustomKeyvalues@ pUnlock = pPlayer.GetCustomKeyvalues();
					pUnlock.SetKeyvalue( "$i_a_unlock", 141 );
				}
			}
		}
	}
	
	g_Scheduler.SetTimeout( "skylined_check", 0.1 );
}

void F_6doors_check()
{
	if ( szMap != '6doors' )
		return;
	
	CBaseEntity@ pCheck1_1 = g_EntityFuncs.FindEntityByTargetname( null, "sys_adata" );
	if ( pCheck1_1 is null )
		return;
	
	CustomKeyvalues@ pCheck1_2 = pCheck1_1.GetCustomKeyvalues();
	CustomKeyvalue iCheck_pre( pCheck1_2.GetKeyvalue( "$i_test" ) );
	int iCheck = iCheck_pre.GetInteger();
	if ( iCheck == 1 )
	{
		for ( int i = 1; i <= g_Engine.maxClients; i++ )
		{
			CBasePlayer@ pPlayer = g_PlayerFuncs.FindPlayerByIndex( i );
			
			if ( pPlayer !is null && pPlayer.IsConnected() )
			{
				// Check whenever the player has no deaths
				if ( pPlayer.m_iDeaths == 0 )
				{
					CustomKeyvalues@ pCheck = pPlayer.GetCustomKeyvalues();
					
					// All puzzles clear?
					CustomKeyvalue iPuzzle1_pre( pCheck.GetKeyvalue( "$i_puzzle1" ) );
					CustomKeyvalue iPuzzle2_pre( pCheck.GetKeyvalue( "$i_puzzle2" ) );
					CustomKeyvalue iPuzzle3_pre( pCheck.GetKeyvalue( "$i_puzzle3" ) );
					CustomKeyvalue iPuzzle4_pre( pCheck.GetKeyvalue( "$i_puzzle4" ) );
					CustomKeyvalue iPuzzle5_pre( pCheck.GetKeyvalue( "$i_puzzle5" ) );
					CustomKeyvalue iPuzzle6_pre( pCheck.GetKeyvalue( "$i_puzzle6" ) );
					int iPuzzle1 = iPuzzle1_pre.GetInteger();
					int iPuzzle2 = iPuzzle2_pre.GetInteger();
					int iPuzzle3 = iPuzzle3_pre.GetInteger();
					int iPuzzle4 = iPuzzle4_pre.GetInteger();
					int iPuzzle5 = iPuzzle5_pre.GetInteger();
					int iPuzzle6 = iPuzzle6_pre.GetInteger();
					if ( iPuzzle1 == 1 && iPuzzle2 == 1 && iPuzzle3 == 1 && iPuzzle4 == 1 && iPuzzle5 == 1 && iPuzzle6 == 1 )
					{
						// Get!
						pCheck.SetKeyvalue( "$i_a_unlock", 67 );
					}
				}
			}
		}
		
		return;
	}
	
	g_Scheduler.SetTimeout( "F_6doors_check", 0.1 );
}

void coldburn_beta_check()
{
	if ( szMap != 'coldburn_beta' )
		return;
	
	CBaseEntity@ pCheck1_1 = g_EntityFuncs.FindEntityByTargetname( null, "sys_adata" );
	if ( pCheck1_1 is null )
		return;
	
	CustomKeyvalues@ pCheck1_2 = pCheck1_1.GetCustomKeyvalues();
	CustomKeyvalue iCheck_pre( pCheck1_2.GetKeyvalue( "$i_test" ) );
	int iCheck = iCheck_pre.GetInteger();
	if ( iCheck == 1 )
	{
		for ( int i = 1; i <= g_Engine.maxClients; i++ )
		{
			CBasePlayer@ pPlayer = g_PlayerFuncs.FindPlayerByIndex( i );
			
			if ( pPlayer !is null && pPlayer.IsConnected() )
			{
				// Check whenever the player has no deaths
				if ( pPlayer.m_iDeaths == 0 )
				{
					CustomKeyvalues@ pCheck2_1 = pPlayer.GetCustomKeyvalues();
					
					// No skills check
					CustomKeyvalue iSkill1_pre( pCheck2_1.GetKeyvalue( "$i_health" ) );
					CustomKeyvalue iSkill2_pre( pCheck2_1.GetKeyvalue( "$i_armor" ) );
					CustomKeyvalue iSkill3_pre( pCheck2_1.GetKeyvalue( "$i_rhealth" ) );
					CustomKeyvalue iSkill4_pre( pCheck2_1.GetKeyvalue( "$i_rarmor" ) );
					CustomKeyvalue iSkill5_pre( pCheck2_1.GetKeyvalue( "$i_rammo" ) );
					CustomKeyvalue iSkill6_pre( pCheck2_1.GetKeyvalue( "$i_gravity" ) );
					CustomKeyvalue iSkill7_pre( pCheck2_1.GetKeyvalue( "$i_speed" ) );
					CustomKeyvalue iSkill8_pre( pCheck2_1.GetKeyvalue( "$i_dist" ) );
					CustomKeyvalue iSkill9_pre( pCheck2_1.GetKeyvalue( "$i_dodge" ) );
					int iSkill1 = iSkill1_pre.GetInteger();
					int iSkill2 = iSkill2_pre.GetInteger();
					int iSkill3 = iSkill3_pre.GetInteger();
					int iSkill4 = iSkill4_pre.GetInteger();
					int iSkill5 = iSkill5_pre.GetInteger();
					int iSkill6 = iSkill6_pre.GetInteger();
					int iSkill7 = iSkill7_pre.GetInteger();
					int iSkill8 = iSkill8_pre.GetInteger();
					int iSkill9 = iSkill9_pre.GetInteger();
					if ( iSkill1 == 0 && iSkill2 == 0 && iSkill3 == 0 && iSkill4 == 0 && iSkill5 == 0 && iSkill6 == 0 && iSkill7 == 0 && iSkill8 == 0 && iSkill9 == 0 )
					{
						// No cheating check
						CustomKeyvalue iOldSkill1_pre( pCheck2_1.GetKeyvalue( "$i_old_health" ) );
						CustomKeyvalue iOldSkill2_pre( pCheck2_1.GetKeyvalue( "$i_old_armor" ) );
						CustomKeyvalue iOldSkill3_pre( pCheck2_1.GetKeyvalue( "$i_old_rhealth" ) );
						CustomKeyvalue iOldSkill4_pre( pCheck2_1.GetKeyvalue( "$i_old_rarmor" ) );
						CustomKeyvalue iOldSkill5_pre( pCheck2_1.GetKeyvalue( "$i_old_rammo" ) );
						CustomKeyvalue iOldSkill6_pre( pCheck2_1.GetKeyvalue( "$i_old_gravity" ) );
						CustomKeyvalue iOldSkill7_pre( pCheck2_1.GetKeyvalue( "$i_old_speed" ) );
						CustomKeyvalue iOldSkill8_pre( pCheck2_1.GetKeyvalue( "$i_old_dist" ) );
						CustomKeyvalue iOldSkill9_pre( pCheck2_1.GetKeyvalue( "$i_old_dodge" ) );
						int iOldSkill1 = iOldSkill1_pre.GetInteger();
						int iOldSkill2 = iOldSkill2_pre.GetInteger();
						int iOldSkill3 = iOldSkill3_pre.GetInteger();
						int iOldSkill4 = iOldSkill4_pre.GetInteger();
						int iOldSkill5 = iOldSkill5_pre.GetInteger();
						int iOldSkill6 = iOldSkill6_pre.GetInteger();
						int iOldSkill7 = iOldSkill7_pre.GetInteger();
						int iOldSkill8 = iOldSkill8_pre.GetInteger();
						int iOldSkill9 = iOldSkill9_pre.GetInteger();
						if ( iOldSkill1 == 0 && iOldSkill2 == 0 && iOldSkill3 == 0 && iOldSkill4 == 0 && iOldSkill5 == 0 && iOldSkill6 == 0 && iOldSkill7 == 0 && iOldSkill8 == 0 && iOldSkill9 == 0 )
						{
							// To prevent abuse, player must have at least this much score
							if ( pPlayer.pev.frags >= 90.0 ) // This is 10% of map's max score
							{
								// Get!
								pCheck2_1.SetKeyvalue( "$i_a_unlock", 68 );
							}
						}
					}
				}
			}
		}
		
		return;
	}
	
	g_Scheduler.SetTimeout( "coldburn_beta_check", 0.1 );
}

void gordonsci2_check()
{
	if ( szMap != 'gordonsci2' )
		return;
	
	CBaseEntity@ pCheck1_1 = g_EntityFuncs.FindEntityByTargetname( null, "sys_adata" );
	if ( pCheck1_1 is null )
		return;
	
	CustomKeyvalues@ pCheck1_2 = pCheck1_1.GetCustomKeyvalues();
	CustomKeyvalue iCheck1_pre( pCheck1_2.GetKeyvalue( "$i_fail" ) );
	int iCheck1 = iCheck1_pre.GetInteger();
	if ( iCheck1 == 0 )
	{
		// Completed the map without gordon's death?
		CustomKeyvalue iCheck2_pre( pCheck1_2.GetKeyvalue( "$i_test" ) );
		int iCheck2 = iCheck2_pre.GetInteger();
		if ( iCheck2 == 1 )
		{
			for ( int i = 1; i <= g_Engine.maxClients; i++ )
			{
				CBasePlayer@ pPlayer = g_PlayerFuncs.FindPlayerByIndex( i );
				
				if ( pPlayer !is null && pPlayer.IsConnected() )
				{
					// To prevent abuse, player must have at least this much score
					if ( pPlayer.pev.frags >= 120.0 ) // This is 20% of map's max score
					{
						// Get!
						CustomKeyvalues@ pUnlock = pPlayer.GetCustomKeyvalues();
						pUnlock.SetKeyvalue( "$i_a_unlock", 70 );
					}
				}
			}
			
			return;
		}
	}
	
	g_Scheduler.SetTimeout( "gordonsci2_check", 0.1 );
}

void canyondoom4_check()
{
	if ( szMap != 'canyondoom4' )
		return;
	
	CBaseEntity@ pCheck1_1 = g_EntityFuncs.FindEntityByTargetname( null, "sys_adata" );
	if ( pCheck1_1 is null )
		return;
	
	CustomKeyvalues@ pCheck1_2 = pCheck1_1.GetCustomKeyvalues();
	CustomKeyvalue iCheck_pre( pCheck1_2.GetKeyvalue( "$i_test" ) );
	int iCheck = iCheck_pre.GetInteger();
	if ( iCheck == 1 )
	{
		for ( int i = 1; i <= g_Engine.maxClients; i++ )
		{
			CBasePlayer@ pPlayer = g_PlayerFuncs.FindPlayerByIndex( i );
			
			if ( pPlayer !is null && pPlayer.IsConnected() )
			{
				// To prevent abuse, player must have at least this much score
				if ( pPlayer.pev.frags >= 192.0 ) // This is 12% of map's max score
				{
					// Get!
					CustomKeyvalues@ pUnlock = pPlayer.GetCustomKeyvalues();
					pUnlock.SetKeyvalue( "$i_a_unlock", 71 );
				}
				
				// 2nd achievement, check if still under 15 minute time limit
				CustomKeyvalue iFail_pre( pCheck1_2.GetKeyvalue( "$i_fail" ) );
				int iFail = iFail_pre.GetInteger();
				if ( iFail == 0 )
				{
					// No deaths?
					if ( pPlayer.m_iDeaths == 0 )
					{
						// To prevent abuse, player must have at least this much score
						if ( pPlayer.pev.frags >= 192.0 ) // This is 12% of map's max score
						{
							// Get!
							g_Scheduler.SetTimeout( "a81_unlock", 1.5, pPlayer.entindex() );
						}
					}
				}
			}
		}
		
		return;
	}
	
	g_Scheduler.SetTimeout( "canyondoom4_check", 0.1 );
}
void a81_unlock( const int& in index )
{
	CBasePlayer@ pPlayer = g_PlayerFuncs.FindPlayerByIndex( index );
	if ( pPlayer !is null )
	{
		CustomKeyvalues@ pUnlock = pPlayer.GetCustomKeyvalues();
		pUnlock.SetKeyvalue( "$i_a_unlock", 82 );
	}
}

void sc_defmap_v3_check()
{
	if ( szMap != 'sc_defmap_v3' )
		return;
	
	CBaseEntity@ pCheck1_1 = g_EntityFuncs.FindEntityByTargetname( null, "sys_adata" );
	if ( pCheck1_1 is null )
		return;
	
	CustomKeyvalues@ pCheck1_2 = pCheck1_1.GetCustomKeyvalues();
	CustomKeyvalue iCheck_pre( pCheck1_2.GetKeyvalue( "$i_test" ) );
	int iCheck = iCheck_pre.GetInteger();
	if ( iCheck == 1 )
	{
		CustomKeyvalue iNoRepair_pre( pCheck1_2.GetKeyvalue( "$i_norepair" ) );
		int iNoRepair = iNoRepair_pre.GetInteger();
		if ( iNoRepair == 1 ) // Generator NOT repaired?
		{
			CustomKeyvalue iFail_pre( pCheck1_2.GetKeyvalue( "$i_fail" ) );
			int iFail = iFail_pre.GetInteger();
			if ( iFail == 0 ) // Still under 1,000 HP damage limit?
			{
				for ( int i = 1; i <= g_Engine.maxClients; i++ )
				{
					CBasePlayer@ pPlayer = g_PlayerFuncs.FindPlayerByIndex( i );
					
					if ( pPlayer !is null && pPlayer.IsConnected() )
					{
						// To prevent abuse, player must have at least this much score
						if ( pPlayer.pev.frags >= 150.0 ) // This is 10% of map's max score
						{
							// Get!
							CustomKeyvalues@ pUnlock = pPlayer.GetCustomKeyvalues();
							pUnlock.SetKeyvalue( "$i_a_unlock", 72 );
						}
					}
				}
			}
		}
		
		return;
	}
	
	g_Scheduler.SetTimeout( "sc_defmap_v3_check", 0.1 );
}

void io_v1_check()
{
	if ( szMap != 'io_v1' )
		return;
	
	CBaseEntity@ pCheck1_1 = g_EntityFuncs.FindEntityByTargetname( null, "sys_adata" );
	if ( pCheck1_1 is null )
		return;
	
	CustomKeyvalues@ pCheck1_2 = pCheck1_1.GetCustomKeyvalues();
	CustomKeyvalue iCheck_pre( pCheck1_2.GetKeyvalue( "$i_test" ) );
	int iCheck = iCheck_pre.GetInteger();
	if ( iCheck == 1 )
	{
		for ( int i = 1; i <= g_Engine.maxClients; i++ )
		{
			CBasePlayer@ pPlayer = g_PlayerFuncs.FindPlayerByIndex( i );
			
			if ( pPlayer !is null && pPlayer.IsConnected() )
			{
				// Check whenever the player has no deaths
				if ( pPlayer.m_iDeaths == 0 )
				{
					CustomKeyvalues@ pCheck2_1 = pPlayer.GetCustomKeyvalues();
					
					// No skills check
					CustomKeyvalue iSkill1_pre( pCheck2_1.GetKeyvalue( "$i_health" ) );
					CustomKeyvalue iSkill2_pre( pCheck2_1.GetKeyvalue( "$i_armor" ) );
					CustomKeyvalue iSkill3_pre( pCheck2_1.GetKeyvalue( "$i_rhealth" ) );
					CustomKeyvalue iSkill4_pre( pCheck2_1.GetKeyvalue( "$i_rarmor" ) );
					CustomKeyvalue iSkill5_pre( pCheck2_1.GetKeyvalue( "$i_rammo" ) );
					CustomKeyvalue iSkill6_pre( pCheck2_1.GetKeyvalue( "$i_gravity" ) );
					CustomKeyvalue iSkill7_pre( pCheck2_1.GetKeyvalue( "$i_speed" ) );
					CustomKeyvalue iSkill8_pre( pCheck2_1.GetKeyvalue( "$i_dist" ) );
					CustomKeyvalue iSkill9_pre( pCheck2_1.GetKeyvalue( "$i_dodge" ) );
					int iSkill1 = iSkill1_pre.GetInteger();
					int iSkill2 = iSkill2_pre.GetInteger();
					int iSkill3 = iSkill3_pre.GetInteger();
					int iSkill4 = iSkill4_pre.GetInteger();
					int iSkill5 = iSkill5_pre.GetInteger();
					int iSkill6 = iSkill6_pre.GetInteger();
					int iSkill7 = iSkill7_pre.GetInteger();
					int iSkill8 = iSkill8_pre.GetInteger();
					int iSkill9 = iSkill9_pre.GetInteger();
					if ( iSkill1 == 0 && iSkill2 == 0 && iSkill3 == 0 && iSkill4 == 0 && iSkill5 == 0 && iSkill6 == 0 && iSkill7 == 0 && iSkill8 == 0 && iSkill9 == 0 )
					{
						// No cheating check
						CustomKeyvalue iOldSkill1_pre( pCheck2_1.GetKeyvalue( "$i_old_health" ) );
						CustomKeyvalue iOldSkill2_pre( pCheck2_1.GetKeyvalue( "$i_old_armor" ) );
						CustomKeyvalue iOldSkill3_pre( pCheck2_1.GetKeyvalue( "$i_old_rhealth" ) );
						CustomKeyvalue iOldSkill4_pre( pCheck2_1.GetKeyvalue( "$i_old_rarmor" ) );
						CustomKeyvalue iOldSkill5_pre( pCheck2_1.GetKeyvalue( "$i_old_rammo" ) );
						CustomKeyvalue iOldSkill6_pre( pCheck2_1.GetKeyvalue( "$i_old_gravity" ) );
						CustomKeyvalue iOldSkill7_pre( pCheck2_1.GetKeyvalue( "$i_old_speed" ) );
						CustomKeyvalue iOldSkill8_pre( pCheck2_1.GetKeyvalue( "$i_old_dist" ) );
						CustomKeyvalue iOldSkill9_pre( pCheck2_1.GetKeyvalue( "$i_old_dodge" ) );
						int iOldSkill1 = iOldSkill1_pre.GetInteger();
						int iOldSkill2 = iOldSkill2_pre.GetInteger();
						int iOldSkill3 = iOldSkill3_pre.GetInteger();
						int iOldSkill4 = iOldSkill4_pre.GetInteger();
						int iOldSkill5 = iOldSkill5_pre.GetInteger();
						int iOldSkill6 = iOldSkill6_pre.GetInteger();
						int iOldSkill7 = iOldSkill7_pre.GetInteger();
						int iOldSkill8 = iOldSkill8_pre.GetInteger();
						int iOldSkill9 = iOldSkill9_pre.GetInteger();
						if ( iOldSkill1 == 0 && iOldSkill2 == 0 && iOldSkill3 == 0 && iOldSkill4 == 0 && iOldSkill5 == 0 && iOldSkill6 == 0 && iOldSkill7 == 0 && iOldSkill8 == 0 && iOldSkill9 == 0 )
						{
							// Handicap active?
							CustomKeyvalue iHandicap03_pre( pCheck2_1.GetKeyvalue( "$i_handicap03" ) );
							int iHandicap03 = iHandicap03_pre.GetInteger();
							if ( iHandicap03 == 1 )
							{
								// To prevent abuse, player must have at least this much score
								if ( pPlayer.pev.frags >= 100.0 ) // This is 20% of map's max score
								{
									// Get!
									pCheck2_1.SetKeyvalue( "$i_a_unlock", 73 );
								}
							}
						}
					}
				}
			}
		}
		
		return;
	}
	
	g_Scheduler.SetTimeout( "io_v1_check", 0.1 );
}

void projectg7_check()
{
	if ( szMap != 'projectg7' )
		return;
	
	for ( int i = 1; i <= g_Engine.maxClients; i++ )
	{
		CBasePlayer@ pPlayer = g_PlayerFuncs.FindPlayerByIndex( i );
		
		if ( pPlayer !is null && pPlayer.IsConnected() )
		{
			// Test active?
			CustomKeyvalues@ pCheck = pPlayer.GetCustomKeyvalues();
			CustomKeyvalue iCheck_pre( pCheck.GetKeyvalue( "$i_test" ) );
			int iCheck = iCheck_pre.GetInteger();
			if ( iCheck == 1 )
			{
				// All secret switches pressed?
				CustomKeyvalue iButtons_pre( pCheck.GetKeyvalue( "$i_buttons" ) );
				int iButtons = iButtons_pre.GetInteger();
				if ( iButtons == 3 )
				{
					// Get!
					pCheck.SetKeyvalue( "$i_a_unlock", 74 );
					
					// Reset to prevent looping
					pCheck.SetKeyvalue( "$i_test", 0 );
				}
			}
		}
	}
	
	g_Scheduler.SetTimeout( "projectg7_check", 0.1 );
}

void svencoop2_check()
{
	if ( szMap != 'svencoop2' )
		return;
	
	CBaseEntity@ pCheck1_1 = g_EntityFuncs.FindEntityByTargetname( null, "sys_adata" );
	if ( pCheck1_1 is null )
		return;
	
	CustomKeyvalues@ pCheck1_2 = pCheck1_1.GetCustomKeyvalues();
	CustomKeyvalue iCheck_pre( pCheck1_2.GetKeyvalue( "$i_test" ) );
	int iCheck = iCheck_pre.GetInteger();
	if ( iCheck == 1 )
	{
		for ( int i = 1; i <= g_Engine.maxClients; i++ )
		{
			CBasePlayer@ pPlayer = g_PlayerFuncs.FindPlayerByIndex( i );
			
			if ( pPlayer !is null && pPlayer.IsConnected() )
			{
				CustomKeyvalues@ pCheck = pPlayer.GetCustomKeyvalues();
				
				CustomKeyvalue iSecret_pre( pCheck.GetKeyvalue( "$i_secret" ) );
				CustomKeyvalue iButtons_pre( pCheck.GetKeyvalue( "$i_buttons" ) );
				int iSecret = iSecret_pre.GetInteger();
				int iButtons = iButtons_pre.GetInteger();
				
				// This player activated the secret?
				if ( iSecret == 1 )
				{
					// This player solved the puzzle instead of someone else?
					if ( iButtons >= 10 )
					{
						// Get!
						pCheck.SetKeyvalue( "$i_a_unlock", 76 );
					}
				}
			}
		}
		
		return;
	}
	
	g_Scheduler.SetTimeout( "svencoop2_check", 0.1 );
}

void thewinery_check()
{
	if ( szMap != 'thewinery' )
		return;
	
	CBaseEntity@ pCheck1_1 = g_EntityFuncs.FindEntityByTargetname( null, "sys_adata" );
	if ( pCheck1_1 is null )
		return;
	
	CustomKeyvalues@ pCheck1_2 = pCheck1_1.GetCustomKeyvalues();
	CustomKeyvalue iCheck_pre( pCheck1_2.GetKeyvalue( "$i_test" ) );
	int iCheck = iCheck_pre.GetInteger();
	if ( iCheck == 1 )
	{
		for ( int i = 1; i <= g_Engine.maxClients; i++ )
		{
			CBasePlayer@ pPlayer = g_PlayerFuncs.FindPlayerByIndex( i );
			
			if ( pPlayer !is null && pPlayer.IsConnected() )
			{
				// Check whenever the player has no deaths
				if ( pPlayer.m_iDeaths == 0 )
				{
					// To prevent abuse, player must have at least this much score
					if ( pPlayer.pev.frags >= 135.0 ) // This is 15% of map's max score
					{
						// Get!
						CustomKeyvalues@ pUnlock = pPlayer.GetCustomKeyvalues();
						pUnlock.SetKeyvalue( "$i_a_unlock", 77 );
					}
				}
			}
		}
		
		return;
	}
	
	g_Scheduler.SetTimeout( "thewinery_check", 0.1 );
}

void def_hakase_check()
{
	if ( szMap != 'def_hakase' )
		return;
	
	CBaseEntity@ pCheck1_1 = g_EntityFuncs.FindEntityByTargetname( null, "sys_adata" );
	if ( pCheck1_1 is null )
		return;
	
	CustomKeyvalues@ pCheck1_2 = pCheck1_1.GetCustomKeyvalues();
	CustomKeyvalue iCheck_pre( pCheck1_2.GetKeyvalue( "$i_test" ) );
	int iCheck = iCheck_pre.GetInteger();
	if ( iCheck == 1 )
	{
		for ( int i = 1; i <= g_Engine.maxClients; i++ )
		{
			CBasePlayer@ pPlayer = g_PlayerFuncs.FindPlayerByIndex( i );
			
			if ( pPlayer !is null && pPlayer.IsConnected() )
			{
				// To prevent abuse, player must have at least this much score
				if ( pPlayer.pev.frags >= 490.0 ) // This is 10% of map's max score
				{
					// Get!
					CustomKeyvalues@ pUnlock = pPlayer.GetCustomKeyvalues();
					pUnlock.SetKeyvalue( "$i_a_unlock", 78 );
				}
			}
		}
		
		return;
	}
	
	g_Scheduler.SetTimeout( "def_hakase_check", 0.1 );
}

void sc_downunder_check()
{
	if ( szMap != 'sc_downunder' )
		return;
	
	CBaseEntity@ pCheck1_1 = g_EntityFuncs.FindEntityByTargetname( null, "sys_adata" );
	if ( pCheck1_1 is null )
		return;
	
	CustomKeyvalues@ pCheck1_2 = pCheck1_1.GetCustomKeyvalues();
	CustomKeyvalue iCheck_pre( pCheck1_2.GetKeyvalue( "$i_test" ) );
	int iCheck = iCheck_pre.GetInteger();
	if ( iCheck == 1 )
	{
		for ( int i = 1; i <= g_Engine.maxClients; i++ )
		{
			CBasePlayer@ pPlayer = g_PlayerFuncs.FindPlayerByIndex( i );
			
			if ( pPlayer !is null && pPlayer.IsConnected() )
			{
				// Check whenever the player has no deaths
				if ( pPlayer.m_iDeaths == 0 )
				{
					// To prevent abuse, player must have at least this much score
					if ( pPlayer.pev.frags >= 45.0 ) // This is 15% of map's max score
					{
						// Get!
						CustomKeyvalues@ pUnlock = pPlayer.GetCustomKeyvalues();
						pUnlock.SetKeyvalue( "$i_a_unlock", 79 );
					}
				}
			}
		}
		
		return;
	}
	
	g_Scheduler.SetTimeout( "sc_downunder_check", 0.1 );
}

void tox_silo_check()
{
	if ( szMap != 'tox_silo' )
		return;
	
	CBaseEntity@ pCheck1_1 = g_EntityFuncs.FindEntityByTargetname( null, "sys_adata" );
	if ( pCheck1_1 is null )
		return;
	
	CustomKeyvalues@ pCheck1_2 = pCheck1_1.GetCustomKeyvalues();
	CustomKeyvalue iCheck_pre( pCheck1_2.GetKeyvalue( "$i_test" ) );
	int iCheck = iCheck_pre.GetInteger();
	if ( iCheck == 1 )
	{
		for ( int i = 1; i <= g_Engine.maxClients; i++ )
		{
			CBasePlayer@ pPlayer = g_PlayerFuncs.FindPlayerByIndex( i );
			
			if ( pPlayer !is null && pPlayer.IsConnected() )
			{
				// Check whenever the player has no deaths
				if ( pPlayer.m_iDeaths == 0 )
				{
					// To prevent abuse, player must have at least this much score
					if ( pPlayer.pev.frags >= 195.0 ) // This is 15% of map's max score
					{
						// Get!
						CustomKeyvalues@ pUnlock = pPlayer.GetCustomKeyvalues();
						pUnlock.SetKeyvalue( "$i_a_unlock", 80 );
					}
				}
			}
		}
		
		return;
	}
	
	g_Scheduler.SetTimeout( "tox_silo_check", 0.1 );
}

void zero_check()
{
	if ( szMap != 'zero' )
		return;
	
	CBaseEntity@ pCheck1_1 = g_EntityFuncs.FindEntityByTargetname( null, "sys_adata" );
	if ( pCheck1_1 is null )
		return;
	
	CustomKeyvalues@ pCheck1_2 = pCheck1_1.GetCustomKeyvalues();
	CustomKeyvalue iCheck_pre( pCheck1_2.GetKeyvalue( "$i_test" ) );
	int iCheck = iCheck_pre.GetInteger();
	if ( iCheck == 1 )
	{
		for ( int i = 1; i <= g_Engine.maxClients; i++ )
		{
			CBasePlayer@ pPlayer = g_PlayerFuncs.FindPlayerByIndex( i );
			
			if ( pPlayer !is null && pPlayer.IsConnected() )
			{
				// Check whenever the player has no deaths
				if ( pPlayer.m_iDeaths == 0 )
				{
					// Handicaps active?
					CustomKeyvalues@ pCheck2_1 = pPlayer.GetCustomKeyvalues();
					
					CustomKeyvalue iHandicap04_pre( pCheck2_1.GetKeyvalue( "$i_handicap04" ) );
					CustomKeyvalue iHandicap05_pre( pCheck2_1.GetKeyvalue( "$i_handicap05" ) );
					int iHandicap04 = iHandicap04_pre.GetInteger();
					int iHandicap05 = iHandicap05_pre.GetInteger();
					
					if ( iHandicap04 == 1 && iHandicap05 == 1 )
					{
						// To prevent abuse, player must have at least this much score
						if ( pPlayer.pev.frags >= 30.0 ) // This is 10% of map's max score
						{
							// Get!
							pCheck2_1.SetKeyvalue( "$i_a_unlock", 81 );
						}
					}
				}
			}
		}
		
		return;
	}
	
	g_Scheduler.SetTimeout( "zero_check", 0.1 );
}

void cs_galleon_f_check()
{
	if ( szMap != 'cs_galleon-f' )
		return;
	
	CBaseEntity@ pCheck1_1 = g_EntityFuncs.FindEntityByTargetname( null, "sys_adata" );
	if ( pCheck1_1 is null )
		return;
	
	CustomKeyvalues@ pCheck1_2 = pCheck1_1.GetCustomKeyvalues();
	CustomKeyvalue iCheck_pre( pCheck1_2.GetKeyvalue( "$i_test" ) );
	int iCheck = iCheck_pre.GetInteger();
	if ( iCheck == 1 )
	{
		for ( int i = 1; i <= g_Engine.maxClients; i++ )
		{
			CBasePlayer@ pPlayer = g_PlayerFuncs.FindPlayerByIndex( i );
			
			if ( pPlayer !is null && pPlayer.IsConnected() )
			{
				// Check whenever the player has no deaths
				if ( pPlayer.m_iDeaths == 0 )
				{
					CustomKeyvalues@ pCheck2_1 = pPlayer.GetCustomKeyvalues();
					
					// No skills check
					CustomKeyvalue iSkill1_pre( pCheck2_1.GetKeyvalue( "$i_health" ) );
					CustomKeyvalue iSkill2_pre( pCheck2_1.GetKeyvalue( "$i_armor" ) );
					CustomKeyvalue iSkill3_pre( pCheck2_1.GetKeyvalue( "$i_rhealth" ) );
					CustomKeyvalue iSkill4_pre( pCheck2_1.GetKeyvalue( "$i_rarmor" ) );
					CustomKeyvalue iSkill5_pre( pCheck2_1.GetKeyvalue( "$i_rammo" ) );
					CustomKeyvalue iSkill6_pre( pCheck2_1.GetKeyvalue( "$i_gravity" ) );
					CustomKeyvalue iSkill7_pre( pCheck2_1.GetKeyvalue( "$i_speed" ) );
					CustomKeyvalue iSkill8_pre( pCheck2_1.GetKeyvalue( "$i_dist" ) );
					CustomKeyvalue iSkill9_pre( pCheck2_1.GetKeyvalue( "$i_dodge" ) );
					int iSkill1 = iSkill1_pre.GetInteger();
					int iSkill2 = iSkill2_pre.GetInteger();
					int iSkill3 = iSkill3_pre.GetInteger();
					int iSkill4 = iSkill4_pre.GetInteger();
					int iSkill5 = iSkill5_pre.GetInteger();
					int iSkill6 = iSkill6_pre.GetInteger();
					int iSkill7 = iSkill7_pre.GetInteger();
					int iSkill8 = iSkill8_pre.GetInteger();
					int iSkill9 = iSkill9_pre.GetInteger();
					if ( iSkill1 == 0 && iSkill2 == 0 && iSkill3 == 0 && iSkill4 == 0 && iSkill5 == 0 && iSkill6 == 0 && iSkill7 == 0 && iSkill8 == 0 && iSkill9 == 0 )
					{
						// No cheating check
						CustomKeyvalue iOldSkill1_pre( pCheck2_1.GetKeyvalue( "$i_old_health" ) );
						CustomKeyvalue iOldSkill2_pre( pCheck2_1.GetKeyvalue( "$i_old_armor" ) );
						CustomKeyvalue iOldSkill3_pre( pCheck2_1.GetKeyvalue( "$i_old_rhealth" ) );
						CustomKeyvalue iOldSkill4_pre( pCheck2_1.GetKeyvalue( "$i_old_rarmor" ) );
						CustomKeyvalue iOldSkill5_pre( pCheck2_1.GetKeyvalue( "$i_old_rammo" ) );
						CustomKeyvalue iOldSkill6_pre( pCheck2_1.GetKeyvalue( "$i_old_gravity" ) );
						CustomKeyvalue iOldSkill7_pre( pCheck2_1.GetKeyvalue( "$i_old_speed" ) );
						CustomKeyvalue iOldSkill8_pre( pCheck2_1.GetKeyvalue( "$i_old_dist" ) );
						CustomKeyvalue iOldSkill9_pre( pCheck2_1.GetKeyvalue( "$i_old_dodge" ) );
						int iOldSkill1 = iOldSkill1_pre.GetInteger();
						int iOldSkill2 = iOldSkill2_pre.GetInteger();
						int iOldSkill3 = iOldSkill3_pre.GetInteger();
						int iOldSkill4 = iOldSkill4_pre.GetInteger();
						int iOldSkill5 = iOldSkill5_pre.GetInteger();
						int iOldSkill6 = iOldSkill6_pre.GetInteger();
						int iOldSkill7 = iOldSkill7_pre.GetInteger();
						int iOldSkill8 = iOldSkill8_pre.GetInteger();
						int iOldSkill9 = iOldSkill9_pre.GetInteger();
						if ( iOldSkill1 == 0 && iOldSkill2 == 0 && iOldSkill3 == 0 && iOldSkill4 == 0 && iOldSkill5 == 0 && iOldSkill6 == 0 && iOldSkill7 == 0 && iOldSkill8 == 0 && iOldSkill9 == 0 )
						{
							// Handicap active?
							CustomKeyvalue iHandicap09_pre( pCheck2_1.GetKeyvalue( "$i_handicap09" ) );
							int iHandicap09 = iHandicap09_pre.GetInteger();
							if ( iHandicap09 == 1 )
							{
								// To prevent abuse, player must have at least this much score
								if ( pPlayer.pev.frags >= 15.0 ) // This is 15% of map's max score
								{
									// Get!
									pCheck2_1.SetKeyvalue( "$i_a_unlock", 83 );
								}
							}
						}
					}
				}
			}
		}
		
		return;
	}
	
	g_Scheduler.SetTimeout( "cs_galleon_f_check", 0.1 );
}

void clockwork_check()
{
	if ( szMap != 'clockwork' )
		return;
	
	CBaseEntity@ pCheck1_1 = g_EntityFuncs.FindEntityByTargetname( null, "sys_adata" );
	if ( pCheck1_1 is null )
		return;
	
	CustomKeyvalues@ pCheck1_2 = pCheck1_1.GetCustomKeyvalues();
	CustomKeyvalue iCheck_pre( pCheck1_2.GetKeyvalue( "$i_test" ) );
	int iCheck = iCheck_pre.GetInteger();
	if ( iCheck == 1 )
	{
		for ( int i = 1; i <= g_Engine.maxClients; i++ )
		{
			CBasePlayer@ pPlayer = g_PlayerFuncs.FindPlayerByIndex( i );
			
			if ( pPlayer !is null && pPlayer.IsConnected() )
			{
				// Check whenever the player has no deaths
				if ( pPlayer.m_iDeaths == 0 )
				{
					CustomKeyvalues@ pCheck2_1 = pPlayer.GetCustomKeyvalues();
					
					// No team power?
					CustomKeyvalue iSkill8_pre( pCheck2_1.GetKeyvalue( "$i_dist" ) );
					int iSkill8 = iSkill8_pre.GetInteger();
					if ( iSkill8 == 0 )
					{
						// No cheating check
						CustomKeyvalue iOldSkill8_pre( pCheck2_1.GetKeyvalue( "$i_old_dist" ) );
						int iOldSkill8 = iOldSkill8_pre.GetInteger();
						if ( iOldSkill8 == 0 )
						{
							// To prevent abuse, player must have at least this much score
							if ( pPlayer.pev.frags >= 30.0 ) // This is 15% of map's max score
							{
								// Get!
								pCheck2_1.SetKeyvalue( "$i_a_unlock", 84 );
							}
						}
					}
				}
			}
		}
		
		return;
	}
	
	g_Scheduler.SetTimeout( "clockwork_check", 0.1 );
}

void ub_megaman_check()
{
	if ( szMap != 'ub_megaman' )
		return;
	
	CBaseEntity@ pCheck1_1 = g_EntityFuncs.FindEntityByTargetname( null, "sys_adata" );
	if ( pCheck1_1 is null )
		return;
	
	CustomKeyvalues@ pCheck1_2 = pCheck1_1.GetCustomKeyvalues();
	CustomKeyvalue iCheck_pre( pCheck1_2.GetKeyvalue( "$i_test" ) );
	int iCheck = iCheck_pre.GetInteger();
	if ( iCheck == 1 )
	{
		for ( int i = 1; i <= g_Engine.maxClients; i++ )
		{
			CBasePlayer@ pPlayer = g_PlayerFuncs.FindPlayerByIndex( i );
			
			if ( pPlayer !is null && pPlayer.IsConnected() )
			{
				CustomKeyvalues@ pCheck2_1 = pPlayer.GetCustomKeyvalues();
				
				// Killed by the monster?
				CustomKeyvalue iFail_pre( pCheck2_1.GetKeyvalue( "$i_fail" ) );
				int iFail = iFail_pre.GetInteger();
				if ( iFail == 0 )
				{
					// Dealt enough damage?
					CustomKeyvalue iPass_pre( pCheck2_1.GetKeyvalue( "$i_pass" ) );
					int iPass = iPass_pre.GetInteger();
					if ( iPass == 1 )
					{
						// To prevent abuse, player must have at least this much score
						if ( pPlayer.pev.frags >= 130.0 ) // This is 10% of map's max score
						{
							// Get!
							pCheck2_1.SetKeyvalue( "$i_a_unlock", 85 );
						}
					}
				}
			}
		}
		
		return;
	}
	
	g_Scheduler.SetTimeout( "ub_megaman_check", 0.1 );
}

void pointless_b2_check()
{
	if ( szMap != 'pointless_b2' )
		return;
	
	CBaseEntity@ pCheck1_1 = g_EntityFuncs.FindEntityByTargetname( null, "sys_adata" );
	if ( pCheck1_1 is null )
		return;
	
	CustomKeyvalues@ pCheck1_2 = pCheck1_1.GetCustomKeyvalues();
	CustomKeyvalue iFail_pre( pCheck1_2.GetKeyvalue( "$i_fail" ) );
	int iFail = iFail_pre.GetInteger();
	if ( iFail == 0 ) // Allow as many players possible until failure
	{
		for ( int i = 1; i <= g_Engine.maxClients; i++ )
		{
			CBasePlayer@ pPlayer = g_PlayerFuncs.FindPlayerByIndex( i );
			
			if ( pPlayer !is null && pPlayer.IsConnected() )
			{
				CustomKeyvalues@ pCheck2_1 = pPlayer.GetCustomKeyvalues();
				
				// Pass?
				CustomKeyvalue iPass_pre( pCheck2_1.GetKeyvalue( "$i_test" ) );
				int iPass = iPass_pre.GetInteger();
				if ( iPass == 1 )
				{
					// To prevent abuse, player must have at least this much score
					if ( pPlayer.pev.frags >= 25.0 ) // This is 5% of map's max score
					{
						// Get!
						pCheck2_1.SetKeyvalue( "$i_a_unlock", 89 );
					}
				}
			}
		}
	}
	
	g_Scheduler.SetTimeout( "pointless_b2_check", 0.1 );
}

void syowa_japan_check()
{
	if ( szMap != 'syowa_japan' )
		return;
	
	CBaseEntity@ pCheck1_1 = g_EntityFuncs.FindEntityByTargetname( null, "sys_adata" );
	if ( pCheck1_1 is null )
		return;
	
	CustomKeyvalues@ pCheck1_2 = pCheck1_1.GetCustomKeyvalues();
	CustomKeyvalue iCheck_pre( pCheck1_2.GetKeyvalue( "$i_active" ) );
	int iCheck = iCheck_pre.GetInteger();
	if ( iCheck == 1 )
	{
		// Timer started, 5 minutes has yet to lapse?
		if ( pCheck1_1.pev.iuser3 <= 3000 )
		{
			// Boss killed?
			CustomKeyvalue iKilled_pre( pCheck1_2.GetKeyvalue( "$i_test" ) );
			int iKilled = iKilled_pre.GetInteger();
			if ( iKilled == 1 )
			{
				for ( int i = 1; i <= g_Engine.maxClients; i++ )
				{
					CBasePlayer@ pPlayer = g_PlayerFuncs.FindPlayerByIndex( i );
			
					if ( pPlayer !is null && pPlayer.IsConnected() )
					{
						// To prevent abuse, player must have at least this much score
						if ( pPlayer.pev.frags >= 150.0 ) // This is 15% of map's max score
						{
							// Get!
							CustomKeyvalues@ pUnlock = pPlayer.GetCustomKeyvalues();
							pUnlock.SetKeyvalue( "$i_a_unlock", 90 );
						}
					}
				}
				
				return;
			}
		}
		
		pCheck1_1.pev.iuser3 = pCheck1_1.pev.iuser3 + 1;
	}
	
	g_Scheduler.SetTimeout( "syowa_japan_check", 0.1 );
}

void sc_trapped2_check()
{
	if ( szMap != 'sc_trapped2' )
		return;
	
	CBaseEntity@ pCheck1_1 = g_EntityFuncs.FindEntityByTargetname( null, "sys_adata" );
	if ( pCheck1_1 is null )
		return;
	
	CustomKeyvalues@ pCheck1_2 = pCheck1_1.GetCustomKeyvalues();
	CustomKeyvalue iCheck_pre( pCheck1_2.GetKeyvalue( "$i_test" ) );
	int iCheck = iCheck_pre.GetInteger();
	if ( iCheck == 1 )
	{
		for ( int i = 1; i <= g_Engine.maxClients; i++ )
		{
			CBasePlayer@ pPlayer = g_PlayerFuncs.FindPlayerByIndex( i );
			
			if ( pPlayer !is null && pPlayer.IsConnected() )
			{
				CustomKeyvalues@ pCheck2_1 = pPlayer.GetCustomKeyvalues();
				
				// No skills check
				CustomKeyvalue iSkill1_pre( pCheck2_1.GetKeyvalue( "$i_health" ) );
				CustomKeyvalue iSkill2_pre( pCheck2_1.GetKeyvalue( "$i_armor" ) );
				CustomKeyvalue iSkill3_pre( pCheck2_1.GetKeyvalue( "$i_rhealth" ) );
				CustomKeyvalue iSkill4_pre( pCheck2_1.GetKeyvalue( "$i_rarmor" ) );
				CustomKeyvalue iSkill5_pre( pCheck2_1.GetKeyvalue( "$i_rammo" ) );
				CustomKeyvalue iSkill6_pre( pCheck2_1.GetKeyvalue( "$i_gravity" ) );
				CustomKeyvalue iSkill7_pre( pCheck2_1.GetKeyvalue( "$i_speed" ) );
				CustomKeyvalue iSkill8_pre( pCheck2_1.GetKeyvalue( "$i_dist" ) );
				CustomKeyvalue iSkill9_pre( pCheck2_1.GetKeyvalue( "$i_dodge" ) );
				int iSkill1 = iSkill1_pre.GetInteger();
				int iSkill2 = iSkill2_pre.GetInteger();
				int iSkill3 = iSkill3_pre.GetInteger();
				int iSkill4 = iSkill4_pre.GetInteger();
				int iSkill5 = iSkill5_pre.GetInteger();
				int iSkill6 = iSkill6_pre.GetInteger();
				int iSkill7 = iSkill7_pre.GetInteger();
				int iSkill8 = iSkill8_pre.GetInteger();
				int iSkill9 = iSkill9_pre.GetInteger();
				if ( iSkill1 == 0 && iSkill2 == 0 && iSkill3 == 0 && iSkill4 == 0 && iSkill5 == 0 && iSkill6 == 0 && iSkill7 == 0 && iSkill8 == 0 && iSkill9 == 0 )
				{
					// No cheating check
					CustomKeyvalue iOldSkill1_pre( pCheck2_1.GetKeyvalue( "$i_old_health" ) );
					CustomKeyvalue iOldSkill2_pre( pCheck2_1.GetKeyvalue( "$i_old_armor" ) );
					CustomKeyvalue iOldSkill3_pre( pCheck2_1.GetKeyvalue( "$i_old_rhealth" ) );
					CustomKeyvalue iOldSkill4_pre( pCheck2_1.GetKeyvalue( "$i_old_rarmor" ) );
					CustomKeyvalue iOldSkill5_pre( pCheck2_1.GetKeyvalue( "$i_old_rammo" ) );
					CustomKeyvalue iOldSkill6_pre( pCheck2_1.GetKeyvalue( "$i_old_gravity" ) );
					CustomKeyvalue iOldSkill7_pre( pCheck2_1.GetKeyvalue( "$i_old_speed" ) );
					CustomKeyvalue iOldSkill8_pre( pCheck2_1.GetKeyvalue( "$i_old_dist" ) );
					CustomKeyvalue iOldSkill9_pre( pCheck2_1.GetKeyvalue( "$i_old_dodge" ) );
					int iOldSkill1 = iOldSkill1_pre.GetInteger();
					int iOldSkill2 = iOldSkill2_pre.GetInteger();
					int iOldSkill3 = iOldSkill3_pre.GetInteger();
					int iOldSkill4 = iOldSkill4_pre.GetInteger();
					int iOldSkill5 = iOldSkill5_pre.GetInteger();
					int iOldSkill6 = iOldSkill6_pre.GetInteger();
					int iOldSkill7 = iOldSkill7_pre.GetInteger();
					int iOldSkill8 = iOldSkill8_pre.GetInteger();
					int iOldSkill9 = iOldSkill9_pre.GetInteger();
					if ( iOldSkill1 == 0 && iOldSkill2 == 0 && iOldSkill3 == 0 && iOldSkill4 == 0 && iOldSkill5 == 0 && iOldSkill6 == 0 && iOldSkill7 == 0 && iOldSkill8 == 0 && iOldSkill9 == 0 )
					{
						// Handicap active?
						CustomKeyvalue iHandicap08_pre( pCheck2_1.GetKeyvalue( "$i_handicap08" ) );
						int iHandicap08 = iHandicap08_pre.GetInteger();
						if ( iHandicap08 == 1 )
						{
							// To prevent abuse, player must have at least this much score
							if ( pPlayer.pev.frags >= 80.0 ) // This is 20% of SECOND map's max score
							{
								// Get!
								pCheck2_1.SetKeyvalue( "$i_a_unlock", 91 );
							}
						}
					}
				}
			}
		}
		
		return;
	}
	
	g_Scheduler.SetTimeout( "sc_trapped2_check", 0.1 );
}

void dreamstairs_v3_check()
{
	if ( szMap != 'dreamstairs_v3' )
		return;
	
	CBaseEntity@ pCheck1_1 = g_EntityFuncs.FindEntityByTargetname( null, "sys_adata" );
	if ( pCheck1_1 is null )
		return;
	
	CustomKeyvalues@ pCheck1_2 = pCheck1_1.GetCustomKeyvalues();
	CustomKeyvalue iCheck_pre( pCheck1_2.GetKeyvalue( "$i_test" ) );
	int iCheck = iCheck_pre.GetInteger();
	if ( iCheck == 1 )
	{
		// All enemies killed?
		CustomKeyvalue iKills_pre( pCheck1_2.GetKeyvalue( "$i_kills" ) );
		int iKills = iKills_pre.GetInteger();
		if ( iKills >= 175 ) // Total enemy count is 179. Rounding down to 175 to leave room for some error
		{
			for ( int i = 1; i <= g_Engine.maxClients; i++ )
			{
				CBasePlayer@ pPlayer = g_PlayerFuncs.FindPlayerByIndex( i );
				
				if ( pPlayer !is null && pPlayer.IsConnected() )
				{
					// To prevent abuse, player must have at least this much score
					if ( pPlayer.pev.frags >= 230.0 ) // This is 10% of map's max score
					{
						// Get!
						CustomKeyvalues@ pUnlock = pPlayer.GetCustomKeyvalues();
						pUnlock.SetKeyvalue( "$i_a_unlock", 92 );
					}
				}
			}
		}
		
		return;
	}
	
	g_Scheduler.SetTimeout( "dreamstairs_v3_check", 0.1 );
}

void sc_fortress_check()
{
	if ( szMap != 'sc_fortress' )
		return;
	
	CBaseEntity@ pCheck1_1 = g_EntityFuncs.FindEntityByTargetname( null, "sys_adata" );
	if ( pCheck1_1 is null )
		return;
	
	CustomKeyvalues@ pCheck1_2 = pCheck1_1.GetCustomKeyvalues();
	CustomKeyvalue iFail_pre( pCheck1_2.GetKeyvalue( "$i_fail" ) );
	int iFail = iFail_pre.GetInteger();
	if ( iFail == 0 ) // No spawn destroyed?
	{
		CustomKeyvalue iTest_pre( pCheck1_2.GetKeyvalue( "$i_test" ) );
		int iTest = iTest_pre.GetInteger();
		if ( iTest == 1 )
		{
			for ( int i = 1; i <= g_Engine.maxClients; i++ )
			{
				CBasePlayer@ pPlayer = g_PlayerFuncs.FindPlayerByIndex( i );
				
				if ( pPlayer !is null && pPlayer.IsConnected() )
				{
					// To prevent abuse, player must have at least this much score
					if ( pPlayer.pev.frags >= 280.0 ) // This is 20% of map's max score
					{
						// Get!
						CustomKeyvalues@ pUnlock = pPlayer.GetCustomKeyvalues();
						pUnlock.SetKeyvalue( "$i_a_unlock", 93 );
					}
				}
			}
		}
		
		return;
	}
	
	g_Scheduler.SetTimeout( "sc_fortress_check", 0.1 );
}

void sc_frontline_check()
{
	if ( szMap != 'sc_frontline' )
		return;
	
	CBaseEntity@ pCheck1_1 = g_EntityFuncs.FindEntityByTargetname( null, "sys_adata" );
	if ( pCheck1_1 is null )
		return;
	
	CustomKeyvalues@ pCheck1_2 = pCheck1_1.GetCustomKeyvalues();
	CustomKeyvalue iCheck_pre( pCheck1_2.GetKeyvalue( "$i_test" ) );
	int iCheck = iCheck_pre.GetInteger();
	if ( iCheck == 1 )
	{
		for ( int i = 1; i <= g_Engine.maxClients; i++ )
		{
			CBasePlayer@ pPlayer = g_PlayerFuncs.FindPlayerByIndex( i );
			
			if ( pPlayer !is null && pPlayer.IsConnected() )
			{
				// Check whenever the player has no deaths
				if ( pPlayer.m_iDeaths == 0 )
				{
					// To prevent abuse, player must have at least this much score
					if ( pPlayer.pev.frags >= 30.0 ) // This is 15% of map's max score
					{
						// Get!
						CustomKeyvalues@ pUnlock = pPlayer.GetCustomKeyvalues();
						pUnlock.SetKeyvalue( "$i_a_unlock", 95 );
					}
				}
			}
		}
		
		return;
	}
	
	g_Scheduler.SetTimeout( "sc_frontline_check", 0.1 );
}

void sc_doc_check()
{
	if ( szMap != 'sc_doc' )
		return;
	
	CBaseEntity@ pCheck1_1 = g_EntityFuncs.FindEntityByTargetname( null, "sys_adata" );
	if ( pCheck1_1 is null )
		return;
	
	CustomKeyvalues@ pCheck1_2 = pCheck1_1.GetCustomKeyvalues();
	CustomKeyvalue iCheck_pre( pCheck1_2.GetKeyvalue( "$i_test" ) );
	int iCheck = iCheck_pre.GetInteger();
	if ( iCheck == 1 )
	{
		for ( int i = 1; i <= g_Engine.maxClients; i++ )
		{
			CBasePlayer@ pPlayer = g_PlayerFuncs.FindPlayerByIndex( i );
			
			if ( pPlayer !is null && pPlayer.IsConnected() )
			{
				// Check whenever the player has no deaths
				if ( pPlayer.m_iDeaths == 0 )
				{
					// To prevent abuse, player must have at least this much score
					if ( pPlayer.pev.frags >= 45.0 ) // This is 15% of map's max score
					{
						// Get!
						CustomKeyvalues@ pUnlock = pPlayer.GetCustomKeyvalues();
						pUnlock.SetKeyvalue( "$i_a_unlock", 96 );
					}
				}
			}
		}
		
		return;
	}
	
	g_Scheduler.SetTimeout( "sc_doc_check", 0.1 );
}

void sc_psyko_check()
{
	if ( szMap != 'sc_psyko' )
		return;
	
	CBaseEntity@ pCheck1_1 = g_EntityFuncs.FindEntityByTargetname( null, "sys_adata" );
	if ( pCheck1_1 is null )
		return;
	
	CustomKeyvalues@ pCheck1_2 = pCheck1_1.GetCustomKeyvalues();
	CustomKeyvalue iCheck_pre( pCheck1_2.GetKeyvalue( "$i_test" ) );
	int iCheck = iCheck_pre.GetInteger();
	if ( iCheck == 1 )
	{
		for ( int i = 1; i <= g_Engine.maxClients; i++ )
		{
			CBasePlayer@ pPlayer = g_PlayerFuncs.FindPlayerByIndex( i );
			
			if ( pPlayer !is null && pPlayer.IsConnected() )
			{
				CustomKeyvalues@ pCheck2_1 = pPlayer.GetCustomKeyvalues();
				
				// No skills check
				CustomKeyvalue iSkill1_pre( pCheck2_1.GetKeyvalue( "$i_health" ) );
				CustomKeyvalue iSkill2_pre( pCheck2_1.GetKeyvalue( "$i_armor" ) );
				CustomKeyvalue iSkill3_pre( pCheck2_1.GetKeyvalue( "$i_rhealth" ) );
				CustomKeyvalue iSkill4_pre( pCheck2_1.GetKeyvalue( "$i_rarmor" ) );
				CustomKeyvalue iSkill5_pre( pCheck2_1.GetKeyvalue( "$i_rammo" ) );
				CustomKeyvalue iSkill6_pre( pCheck2_1.GetKeyvalue( "$i_gravity" ) );
				CustomKeyvalue iSkill7_pre( pCheck2_1.GetKeyvalue( "$i_speed" ) );
				CustomKeyvalue iSkill8_pre( pCheck2_1.GetKeyvalue( "$i_dist" ) );
				CustomKeyvalue iSkill9_pre( pCheck2_1.GetKeyvalue( "$i_dodge" ) );
				int iSkill1 = iSkill1_pre.GetInteger();
				int iSkill2 = iSkill2_pre.GetInteger();
				int iSkill3 = iSkill3_pre.GetInteger();
				int iSkill4 = iSkill4_pre.GetInteger();
				int iSkill5 = iSkill5_pre.GetInteger();
				int iSkill6 = iSkill6_pre.GetInteger();
				int iSkill7 = iSkill7_pre.GetInteger();
				int iSkill8 = iSkill8_pre.GetInteger();
				int iSkill9 = iSkill9_pre.GetInteger();
				if ( iSkill1 == 0 && iSkill2 == 0 && iSkill3 == 0 && iSkill4 == 0 && iSkill5 == 0 && iSkill6 == 0 && iSkill7 == 0 && iSkill8 == 0 && iSkill9 == 0 )
				{
					// No cheating check
					CustomKeyvalue iOldSkill1_pre( pCheck2_1.GetKeyvalue( "$i_old_health" ) );
					CustomKeyvalue iOldSkill2_pre( pCheck2_1.GetKeyvalue( "$i_old_armor" ) );
					CustomKeyvalue iOldSkill3_pre( pCheck2_1.GetKeyvalue( "$i_old_rhealth" ) );
					CustomKeyvalue iOldSkill4_pre( pCheck2_1.GetKeyvalue( "$i_old_rarmor" ) );
					CustomKeyvalue iOldSkill5_pre( pCheck2_1.GetKeyvalue( "$i_old_rammo" ) );
					CustomKeyvalue iOldSkill6_pre( pCheck2_1.GetKeyvalue( "$i_old_gravity" ) );
					CustomKeyvalue iOldSkill7_pre( pCheck2_1.GetKeyvalue( "$i_old_speed" ) );
					CustomKeyvalue iOldSkill8_pre( pCheck2_1.GetKeyvalue( "$i_old_dist" ) );
					CustomKeyvalue iOldSkill9_pre( pCheck2_1.GetKeyvalue( "$i_old_dodge" ) );
					int iOldSkill1 = iOldSkill1_pre.GetInteger();
					int iOldSkill2 = iOldSkill2_pre.GetInteger();
					int iOldSkill3 = iOldSkill3_pre.GetInteger();
					int iOldSkill4 = iOldSkill4_pre.GetInteger();
					int iOldSkill5 = iOldSkill5_pre.GetInteger();
					int iOldSkill6 = iOldSkill6_pre.GetInteger();
					int iOldSkill7 = iOldSkill7_pre.GetInteger();
					int iOldSkill8 = iOldSkill8_pre.GetInteger();
					int iOldSkill9 = iOldSkill9_pre.GetInteger();
					if ( iOldSkill1 == 0 && iOldSkill2 == 0 && iOldSkill3 == 0 && iOldSkill4 == 0 && iOldSkill5 == 0 && iOldSkill6 == 0 && iOldSkill7 == 0 && iOldSkill8 == 0 && iOldSkill9 == 0 )
					{
						// To prevent abuse, player must have at least this much score
						if ( pPlayer.pev.frags >= 120.0 ) // This is 15% of map's max score
						{
							// Get!
							pCheck2_1.SetKeyvalue( "$i_a_unlock", 97 );
						}
					}
				}
			}
		}
		
		return;
	}
	
	g_Scheduler.SetTimeout( "sc_psyko_check", 0.1 );
}

void wolf3dlvl1_check()
{
	if ( szMap != 'wolf3dlvl1' )
		return;
	
	CBaseEntity@ pCheck1_1 = g_EntityFuncs.FindEntityByTargetname( null, "sys_adata" );
	if ( pCheck1_1 is null )
		return;
	
	CustomKeyvalues@ pCheck1_2 = pCheck1_1.GetCustomKeyvalues();
	CustomKeyvalue iCheck_pre( pCheck1_2.GetKeyvalue( "$i_test" ) );
	int iCheck = iCheck_pre.GetInteger();
	if ( iCheck == 1 )
	{
		// All enemies killed?
		CustomKeyvalue iKills_pre( pCheck1_2.GetKeyvalue( "$i_kills" ) );
		int iKills = iKills_pre.GetInteger();
		
		// Total enemy count is approximately 372. YES, APPROXIMATELY.
		// I ain't counting the "monstercount" of 350+ squadmakers individually, damn it!
		// Rounding down to 370 to leave some room for error
		if ( iKills >= 370 )
		{
			for ( int i = 1; i <= g_Engine.maxClients; i++ )
			{
				CBasePlayer@ pPlayer = g_PlayerFuncs.FindPlayerByIndex( i );
				
				if ( pPlayer !is null && pPlayer.IsConnected() )
				{
					// Check whenever the player has no deaths
					if ( pPlayer.m_iDeaths == 0 )
					{
						CustomKeyvalues@ pCheck2_1 = pPlayer.GetCustomKeyvalues();
						
						// No skills check
						CustomKeyvalue iSkill1_pre( pCheck2_1.GetKeyvalue( "$i_health" ) );
						CustomKeyvalue iSkill2_pre( pCheck2_1.GetKeyvalue( "$i_armor" ) );
						CustomKeyvalue iSkill3_pre( pCheck2_1.GetKeyvalue( "$i_rhealth" ) );
						CustomKeyvalue iSkill4_pre( pCheck2_1.GetKeyvalue( "$i_rarmor" ) );
						CustomKeyvalue iSkill5_pre( pCheck2_1.GetKeyvalue( "$i_rammo" ) );
						CustomKeyvalue iSkill6_pre( pCheck2_1.GetKeyvalue( "$i_gravity" ) );
						CustomKeyvalue iSkill7_pre( pCheck2_1.GetKeyvalue( "$i_speed" ) );
						CustomKeyvalue iSkill8_pre( pCheck2_1.GetKeyvalue( "$i_dist" ) );
						CustomKeyvalue iSkill9_pre( pCheck2_1.GetKeyvalue( "$i_dodge" ) );
						int iSkill1 = iSkill1_pre.GetInteger();
						int iSkill2 = iSkill2_pre.GetInteger();
						int iSkill3 = iSkill3_pre.GetInteger();
						int iSkill4 = iSkill4_pre.GetInteger();
						int iSkill5 = iSkill5_pre.GetInteger();
						int iSkill6 = iSkill6_pre.GetInteger();
						int iSkill7 = iSkill7_pre.GetInteger();
						int iSkill8 = iSkill8_pre.GetInteger();
						int iSkill9 = iSkill9_pre.GetInteger();
						if ( iSkill1 == 0 && iSkill2 == 0 && iSkill3 == 0 && iSkill4 == 0 && iSkill5 == 0 && iSkill6 == 0 && iSkill7 == 0 && iSkill8 == 0 && iSkill9 == 0 )
						{
							// No cheating check
							CustomKeyvalue iOldSkill1_pre( pCheck2_1.GetKeyvalue( "$i_old_health" ) );
							CustomKeyvalue iOldSkill2_pre( pCheck2_1.GetKeyvalue( "$i_old_armor" ) );
							CustomKeyvalue iOldSkill3_pre( pCheck2_1.GetKeyvalue( "$i_old_rhealth" ) );
							CustomKeyvalue iOldSkill4_pre( pCheck2_1.GetKeyvalue( "$i_old_rarmor" ) );
							CustomKeyvalue iOldSkill5_pre( pCheck2_1.GetKeyvalue( "$i_old_rammo" ) );
							CustomKeyvalue iOldSkill6_pre( pCheck2_1.GetKeyvalue( "$i_old_gravity" ) );
							CustomKeyvalue iOldSkill7_pre( pCheck2_1.GetKeyvalue( "$i_old_speed" ) );
							CustomKeyvalue iOldSkill8_pre( pCheck2_1.GetKeyvalue( "$i_old_dist" ) );
							CustomKeyvalue iOldSkill9_pre( pCheck2_1.GetKeyvalue( "$i_old_dodge" ) );
							int iOldSkill1 = iOldSkill1_pre.GetInteger();
							int iOldSkill2 = iOldSkill2_pre.GetInteger();
							int iOldSkill3 = iOldSkill3_pre.GetInteger();
							int iOldSkill4 = iOldSkill4_pre.GetInteger();
							int iOldSkill5 = iOldSkill5_pre.GetInteger();
							int iOldSkill6 = iOldSkill6_pre.GetInteger();
							int iOldSkill7 = iOldSkill7_pre.GetInteger();
							int iOldSkill8 = iOldSkill8_pre.GetInteger();
							int iOldSkill9 = iOldSkill9_pre.GetInteger();
							if ( iOldSkill1 == 0 && iOldSkill2 == 0 && iOldSkill3 == 0 && iOldSkill4 == 0 && iOldSkill5 == 0 && iOldSkill6 == 0 && iOldSkill7 == 0 && iOldSkill8 == 0 && iOldSkill9 == 0 )
							{
								// Handicaps active?
								CustomKeyvalue iHandicap03_pre( pCheck2_1.GetKeyvalue( "$i_handicap03" ) );
								CustomKeyvalue iHandicap10_pre( pCheck2_1.GetKeyvalue( "$i_handicap10" ) );
								int iHandicap03 = iHandicap03_pre.GetInteger();
								int iHandicap10 = iHandicap10_pre.GetInteger();
								if ( iHandicap03 == 1 && iHandicap10 == 1 )
								{
									// To prevent abuse, player must have at least this much score
									if ( pPlayer.pev.frags >= 16.0 ) // This is 2% of map's max score
									{
										// Get!
										pCheck2_1.SetKeyvalue( "$i_a_unlock", 100 );
									}
								}
							}
						}
					}
				}
			}
		}
		
		return;
	}
	
	g_Scheduler.SetTimeout( "wolf3dlvl1_check", 0.1 );
}

void breakout_extended_check()
{
	if ( szMap != 'breakout_extended' )
		return;
	
	CBaseEntity@ pCheck1_1 = g_EntityFuncs.FindEntityByTargetname( null, "sys_adata" );
	if ( pCheck1_1 is null )
		return;
	
	CustomKeyvalues@ pCheck1_2 = pCheck1_1.GetCustomKeyvalues();
	CustomKeyvalue iCheck_pre( pCheck1_2.GetKeyvalue( "$i_test" ) );
	int iCheck = iCheck_pre.GetInteger();
	if ( iCheck == 1 )
	{
		for ( int i = 1; i <= g_Engine.maxClients; i++ )
		{
			CBasePlayer@ pPlayer = g_PlayerFuncs.FindPlayerByIndex( i );
			
			if ( pPlayer !is null && pPlayer.IsConnected() )
			{
				// Check whenever the player has no deaths
				if ( pPlayer.m_iDeaths == 0 )
				{
					// To prevent abuse, player must have at least this much score
					if ( pPlayer.pev.frags >= 90.0 ) // This is 20% of map's max score
					{
						// Get!
						CustomKeyvalues@ pUnlock = pPlayer.GetCustomKeyvalues();
						pUnlock.SetKeyvalue( "$i_a_unlock", 101 );
					}
				}
			}
		}
		
		return;
	}
	
	g_Scheduler.SetTimeout( "breakout_extended_check", 0.1 );
}

void zombie_nights_v7_check()
{
	if ( szMap != 'zombie_nights_v7' )
		return;
	
	for ( int i = 1; i <= g_Engine.maxClients; i++ )
	{
		CBasePlayer@ pPlayer = g_PlayerFuncs.FindPlayerByIndex( i );
		
		if ( pPlayer !is null && pPlayer.IsConnected() )
		{
			// No deaths?
			if ( pPlayer.m_iDeaths == 0 )
			{
				// Has the medkit?
				if ( pPlayer.HasNamedPlayerItem( "weapon_medkit" ) !is null )
				{
					// To prevent abuse, player must have at least this much score
					if ( pPlayer.pev.frags >= 15.0 ) // Somewhat generic, as the map's max score is infinite
					{
						// Achievement get!
						CustomKeyvalues@ pUnlock = pPlayer.GetCustomKeyvalues();
						pUnlock.SetKeyvalue( "$i_a_unlock", 102 );
					}
				}
			}
		}
	}
	
	g_Scheduler.SetTimeout( "zombie_nights_v7_check", 0.1 );
}

void kh3_check()
{
	if ( szMap != 'kh3' )
		return;
	
	CBaseEntity@ pCheck1_1 = g_EntityFuncs.FindEntityByTargetname( null, "sys_adata" );
	if ( pCheck1_1 is null )
		return;
	
	CustomKeyvalues@ pCheck1_2 = pCheck1_1.GetCustomKeyvalues();
	CustomKeyvalue iCheck_pre( pCheck1_2.GetKeyvalue( "$i_coins" ) );
	int iCheck = iCheck_pre.GetInteger();
	if ( iCheck == 13 ) // All coins get?
	{
		for ( int i = 1; i <= g_Engine.maxClients; i++ )
		{
			CBasePlayer@ pPlayer = g_PlayerFuncs.FindPlayerByIndex( i );
			
			if ( pPlayer !is null && pPlayer.IsConnected() )
			{
				// To prevent abuse, player must have at least this much score
				if ( pPlayer.pev.frags >= 54.0 ) // This is 16% of THIRD map's max score
				{
					// Get!
					CustomKeyvalues@ pUnlock = pPlayer.GetCustomKeyvalues();
					pUnlock.SetKeyvalue( "$i_a_unlock", 103 );
				}
			}
		}
		
		return;
	}
	
	g_Scheduler.SetTimeout( "kh3_check", 0.1 );
}

void infested2_check()
{
	if ( szMap != 'infested2' )
		return;
	
	CBaseEntity@ pCheck1_1 = g_EntityFuncs.FindEntityByTargetname( null, "sys_adata" );
	if ( pCheck1_1 is null )
		return;
	
	CustomKeyvalues@ pCheck1_2 = pCheck1_1.GetCustomKeyvalues();
	CustomKeyvalue iFail_pre( pCheck1_2.GetKeyvalue( "$i_fail" ) );
	int iFail = iFail_pre.GetInteger();
	if ( iFail == 1 )
		return;
	
	CustomKeyvalues@ pCheck1_3 = pCheck1_1.GetCustomKeyvalues();
	CustomKeyvalue iCheck_pre( pCheck1_3.GetKeyvalue( "$i_test" ) );
	int iCheck = iCheck_pre.GetInteger();
	if ( iCheck == 1 )
	{
		for ( int i = 1; i <= g_Engine.maxClients; i++ )
		{
			CBasePlayer@ pPlayer = g_PlayerFuncs.FindPlayerByIndex( i );
			
			if ( pPlayer !is null && pPlayer.IsConnected() )
			{
				CBaseEntity@ pTrain = g_EntityFuncs.Instance( pPlayer.pev.groundentity );
				if ( pTrain !is null )
				{
					// Check if the player is standing on the escape train
					if ( pTrain.pev.model == '*197' || pTrain.pev.model == '*70' )
					{
						// To prevent abuse, player must have at least this much score (OH! AND ALIVE!)
						if ( pPlayer.IsAlive() && pPlayer.pev.frags >= 50.0 ) // This is 20% of SECOND map's max score
						{
							// Get!
							CustomKeyvalues@ pUnlock = pPlayer.GetCustomKeyvalues();
							pUnlock.SetKeyvalue( "$i_a_unlock", 104 );
						}
					}
				}
			}
		}
		
		return;
	}
	
	g_Scheduler.SetTimeout( "infested2_check", 0.1 );
}

void garghnt3_check()
{
	if ( szMap != 'garghnt3' )
		return;
	
	CBaseEntity@ pCheck1_1 = g_EntityFuncs.FindEntityByTargetname( null, "sys_adata" );
	if ( pCheck1_1 is null )
		return;
	
	// Enough kills?
	if ( pCheck1_1.pev.iuser4 >= 15 )
	{
		for ( int i = 1; i <= g_Engine.maxClients; i++ )
		{
			CBasePlayer@ pPlayer = g_PlayerFuncs.FindPlayerByIndex( i );
			
			if ( pPlayer !is null && pPlayer.IsConnected() )
			{
				// To prevent abuse, player must have at least this much score
				if ( pPlayer.pev.frags >= 75.0 ) // This is 100% of map's max score, because Snk.EmA put the wrong number on the .ini file
				{
					// Get!
					CustomKeyvalues@ pUnlock = pPlayer.GetCustomKeyvalues();
					pUnlock.SetKeyvalue( "$i_a_unlock", 105 );
				}
			}
		}
		
		return;
	}
	
	g_Scheduler.SetTimeout( "garghnt3_check", 0.1 );
}

void arc_novus_4_check()
{
	if ( szMap != 'arc-novus-4' )
		return;
	
	CBaseEntity@ pCheck1_1 = g_EntityFuncs.FindEntityByTargetname( null, "sys_adata" );
	if ( pCheck1_1 is null )
		return;
	
	CustomKeyvalues@ pCheck1_2 = pCheck1_1.GetCustomKeyvalues();
	CustomKeyvalue iCheck_pre( pCheck1_2.GetKeyvalue( "$i_test" ) );
	int iCheck = iCheck_pre.GetInteger();
	if ( iCheck == 1 )
	{
		for ( int i = 1; i <= g_Engine.maxClients; i++ )
		{
			CBasePlayer@ pPlayer = g_PlayerFuncs.FindPlayerByIndex( i );
			
			if ( pPlayer !is null && pPlayer.IsConnected() )
			{
				// Less than 4 deaths
				if ( pPlayer.m_iDeaths < 4 )
				{
					CustomKeyvalues@ pCheck2_1 = pPlayer.GetCustomKeyvalues();
					
					// No Armor Usage
					CustomKeyvalue iSkill2_pre( pCheck2_1.GetKeyvalue( "$i_armor" ) );
					int iSkill2 = iSkill2_pre.GetInteger();
					
					// No cheating
					CustomKeyvalue iOldSkill2_pre( pCheck2_1.GetKeyvalue( "$i_old_armor" ) );
					int iOldSkill2 = iOldSkill2_pre.GetInteger();
					
					// Handicap enabled
					CustomKeyvalue iHandicap04_pre( pCheck2_1.GetKeyvalue( "$i_handicap04" ) );
					int iHandicap04 = iHandicap04_pre.GetInteger();
					
					if ( iSkill2 == 0 && iOldSkill2 == 0 && iHandicap04 == 1 )
					{
						// To prevent abuse, player must have at least this much score
						if ( pPlayer.pev.frags >= 20.0 ) // This is 20% of map's max score
						{
							// Get!
							pCheck2_1.SetKeyvalue( "$i_a_unlock", 106 );
						}
					}
				}
			}
		}
		
		return;
	}
	
	g_Scheduler.SetTimeout( "arc_novus_4_check", 0.1 );
}

void adams_puzzles_beta2_check()
{
	if ( szMap != 'adams_puzzles_beta2' )
		return;
	
	CBaseEntity@ pCheck1_1 = g_EntityFuncs.FindEntityByTargetname( null, "sys_adata" );
	if ( pCheck1_1 is null )
		return;
	
	// Again, taking the risk and leaving it as-is
	for ( int i = 1; i <= g_Engine.maxClients; i++ )
	{
		CBasePlayer@ pPlayer = g_PlayerFuncs.FindPlayerByIndex( i );
		
		if ( pPlayer !is null && pPlayer.IsConnected() )
		{
			CustomKeyvalues@ pCheck2_1 = pPlayer.GetCustomKeyvalues();
			
			// Are we in our secret?
			Vector vecOrigin1 = pPlayer.pev.origin;
			Vector vecOrigin2 = pCheck1_1.pev.origin;
			
			// Prevent /spectate exploit
			if ( pPlayer.IsAlive() )
			{
				if ( ( vecOrigin1 - vecOrigin2 ).Length() <= 64.0 )
				{
					// Set puzzle as found, and check below
					pCheck2_1.SetKeyvalue( "$i_secret", 1 );
				}
			}
			
			// Cleared the other puzzles?
			CustomKeyvalue iPuzzle_pre( pCheck2_1.GetKeyvalue( "$i_puzzles" ) );
			CustomKeyvalue iSecret_pre( pCheck2_1.GetKeyvalue( "$i_secret" ) );
			int iPuzzle = iPuzzle_pre.GetInteger();
			int iSecret = iSecret_pre.GetInteger();
			
			if ( iPuzzle == 2 && iSecret == 1 )
			{
				// Get!
				pCheck2_1.SetKeyvalue( "$i_a_unlock", 107 );
				
				pCheck2_1.SetKeyvalue( "$i_puzzles", 0 );
				pCheck2_1.SetKeyvalue( "$i_secret", 0 );
			}
		}
	}
	
	g_Scheduler.SetTimeout( "adams_puzzles_beta2_check", 0.1 );
}

void bossbattle_check()
{
	if ( szMap != 'bossbattle' )
		return;
	
	CBaseEntity@ pCheck1_1 = g_EntityFuncs.FindEntityByTargetname( null, "sys_adata" );
	if ( pCheck1_1 is null )
		return;
	
	CustomKeyvalues@ pCheck1_2 = pCheck1_1.GetCustomKeyvalues();
	CustomKeyvalue iFail_pre( pCheck1_2.GetKeyvalue( "$i_fail" ) );
	int iFail = iFail_pre.GetInteger();
	if ( iFail == 1 )
		return;
	
	for ( int i = 1; i <= g_Engine.maxClients; i++ )
	{
		CBasePlayer@ pPlayer = g_PlayerFuncs.FindPlayerByIndex( i );
		
		if ( pPlayer !is null && pPlayer.IsConnected() )
		{
			CustomKeyvalues@ pCheck2_1 = pPlayer.GetCustomKeyvalues();
			CustomKeyvalue vecLastMove_pre( pCheck2_1.GetKeyvalue( "$v_last_move" ) );
			if ( vecLastMove_pre.Exists() )
			{
				Vector vecLastMove = vecLastMove_pre.GetVector();
				
				// Add distance traveled
				CustomKeyvalue iDistance_pre( pCheck2_1.GetKeyvalue( "$i_distance" ) );
				int iDistance = iDistance_pre.GetInteger();
				pCheck2_1.SetKeyvalue( "$i_distance", ( iDistance + ( vecLastMove - pPlayer.pev.origin ).Length() ) );
				
				pCheck2_1.SetKeyvalue( "$v_last_move", pPlayer.pev.origin );
			}
			else
			{
				pCheck2_1.SetKeyvalue( "$v_last_move", pPlayer.pev.origin );
			}
			
			CustomKeyvalue iCheck_pre( pCheck1_2.GetKeyvalue( "$i_test" ) );
			int iCheck = iCheck_pre.GetInteger();
			if ( iCheck == 1 )
			{
				// Enough travel distance?
				CustomKeyvalue iDistance_pre( pCheck2_1.GetKeyvalue( "$i_distance" ) );
				int iDistance = iDistance_pre.GetInteger();
				if ( iDistance >= 10240 )
				{
					// Get!
					pCheck2_1.SetKeyvalue( "$i_a_unlock", 108 );
				}
			}
		}
	}
	
	g_Scheduler.SetTimeout( "bossbattle_check", 0.1 );
}

void evilmansion_check()
{
	if ( szMap != 'evilmansion' )
		return;
	
	CBaseEntity@ pCheck1_1 = g_EntityFuncs.FindEntityByTargetname( null, "sys_adata" );
	if ( pCheck1_1 is null )
		return;
	
	CustomKeyvalues@ pCheck1_2 = pCheck1_1.GetCustomKeyvalues();
	CustomKeyvalue iCheck_pre( pCheck1_2.GetKeyvalue( "$i_test" ) );
	int iCheck = iCheck_pre.GetInteger();
	if ( iCheck == 1 )
	{
		CustomKeyvalue iCandy_pre( pCheck1_2.GetKeyvalue( "$i_candy" ) );
		int iCandy = iCandy_pre.GetInteger();
		if ( iCandy >= 48 ) // All candy get?
		{
			for ( int i = 1; i <= g_Engine.maxClients; i++ )
			{
				CBasePlayer@ pPlayer = g_PlayerFuncs.FindPlayerByIndex( i );
				
				if ( pPlayer !is null && pPlayer.IsConnected() )
				{
					// To prevent abuse, player must have at least this much score
					if ( pPlayer.pev.frags >= 48.0 ) // MISSING XPGAIN DEFINE !!!
					{
						// Get!
						CustomKeyvalues@ pUnlock = pPlayer.GetCustomKeyvalues();
						pUnlock.SetKeyvalue( "$i_a_unlock", 109 );
					}
				}
			}
		}
		
		return;
	}
	
	g_Scheduler.SetTimeout( "evilmansion_check", 0.1 );
}

void sc_spacewar_check()
{
	if ( szMap != 'sc_spacewar' )
		return;
	
	CBaseEntity@ pCheck1_1 = g_EntityFuncs.FindEntityByTargetname( null, "sys_adata" );
	if ( pCheck1_1 is null )
		return;
	
	CustomKeyvalues@ pCheck1_2 = pCheck1_1.GetCustomKeyvalues();
	CustomKeyvalue iCheck_pre( pCheck1_2.GetKeyvalue( "$i_test" ) );
	int iCheck = iCheck_pre.GetInteger();
	if ( iCheck == 1 )
	{
		for ( int i = 1; i <= g_Engine.maxClients; i++ )
		{
			CBasePlayer@ pPlayer = g_PlayerFuncs.FindPlayerByIndex( i );
			
			if ( pPlayer !is null && pPlayer.IsConnected() )
			{
				// Less than 2 deaths?
				if ( pPlayer.m_iDeaths < 2 )
				{
					// To prevent abuse, player must have at least this much score
					if ( pPlayer.pev.frags >= 28.0 ) // This is 10% of map's max score
					{
						// Get!
						CustomKeyvalues@ pUnlock = pPlayer.GetCustomKeyvalues();
						pUnlock.SetKeyvalue( "$i_a_unlock", 110 );
					}
				}
			}
		}
		
		return;
	}
	
	g_Scheduler.SetTimeout( "sc_spacewar_check", 0.1 );
}

void bw_check()
{
	if ( szMap != 'bw' )
		return;
	
	CBaseEntity@ pCheck1_1 = g_EntityFuncs.FindEntityByTargetname( null, "sys_adata" );
	if ( pCheck1_1 is null )
		return;
	
	CustomKeyvalues@ pCheck1_2 = pCheck1_1.GetCustomKeyvalues();
	CustomKeyvalue iCheck_pre( pCheck1_2.GetKeyvalue( "$i_test" ) );
	int iCheck = iCheck_pre.GetInteger();
	if ( iCheck == 1 )
	{
		for ( int i = 1; i <= g_Engine.maxClients; i++ )
		{
			CBasePlayer@ pPlayer = g_PlayerFuncs.FindPlayerByIndex( i );
			
			if ( pPlayer !is null && pPlayer.IsConnected() )
			{
				// Check whenever the player has no deaths
				if ( pPlayer.m_iDeaths == 0 )
				{
					// To prevent abuse, player must have at least this much score
					if ( pPlayer.pev.frags >= 190.0 ) // This is 15% of map's max score
					{
						// Get!
						CustomKeyvalues@ pUnlock = pPlayer.GetCustomKeyvalues();
						pUnlock.SetKeyvalue( "$i_a_unlock", 113 );
					}
				}
			}
		}
		
		return;
	}
	
	g_Scheduler.SetTimeout( "bw_check", 0.1 );
}

void factions_check()
{
	if ( szMap != 'factions' )
		return;
	
	CBaseEntity@ pCheck1_1 = g_EntityFuncs.FindEntityByTargetname( null, "sys_adata" );
	if ( pCheck1_1 is null )
		return;
	
	CustomKeyvalues@ pCheck1_2 = pCheck1_1.GetCustomKeyvalues();
	CustomKeyvalue iCheck_pre( pCheck1_2.GetKeyvalue( "$i_test" ) );
	int iCheck = iCheck_pre.GetInteger();
	if ( iCheck == 1 )
	{
		CustomKeyvalue iFail_pre( pCheck1_2.GetKeyvalue( "$i_fail" ) );
		int iFail = iFail_pre.GetInteger();
		if ( iFail == 0 ) // Still under 1,000 HP damage limit?
		{
			for ( int i = 1; i <= g_Engine.maxClients; i++ )
			{
				CBasePlayer@ pPlayer = g_PlayerFuncs.FindPlayerByIndex( i );
				
				if ( pPlayer !is null && pPlayer.IsConnected() )
				{
					// To prevent abuse, player must have at least this much score
					if ( pPlayer.pev.frags >= 55.0 ) // This is 10% of map's max score
					{
						// Get!
						CustomKeyvalues@ pUnlock = pPlayer.GetCustomKeyvalues();
						pUnlock.SetKeyvalue( "$i_a_unlock", 115 );
					}
				}
			}
		}
		
		return;
	}
	
	g_Scheduler.SetTimeout( "factions_check", 0.1 );
}

void quad_f_check()
{
	if ( szMap != 'quad_f' )
		return;
	
	CBaseEntity@ pCheck1_1 = g_EntityFuncs.FindEntityByTargetname( null, "sys_adata" );
	if ( pCheck1_1 is null )
		return;
	
	CustomKeyvalues@ pCheck1_2 = pCheck1_1.GetCustomKeyvalues();
	for ( int i = 1; i <= g_Engine.maxClients; i++ )
	{
		CBasePlayer@ pPlayer = g_PlayerFuncs.FindPlayerByIndex( i );
		
		if ( pPlayer !is null && pPlayer.IsConnected() )
		{
			CustomKeyvalues@ pCheck2_1 = pPlayer.GetCustomKeyvalues();
			CustomKeyvalue vecLastMove_pre( pCheck2_1.GetKeyvalue( "$v_last_move" ) );
			if ( vecLastMove_pre.Exists() )
			{
				Vector vecLastMove = vecLastMove_pre.GetVector();
				
				// Add distance traveled
				CustomKeyvalue iDistance_pre( pCheck2_1.GetKeyvalue( "$i_distance" ) );
				int iDistance = iDistance_pre.GetInteger();
				pCheck2_1.SetKeyvalue( "$i_distance", ( iDistance + ( vecLastMove - pPlayer.pev.origin ).Length() ) );
				
				pCheck2_1.SetKeyvalue( "$v_last_move", pPlayer.pev.origin );
			}
			else
			{
				pCheck2_1.SetKeyvalue( "$v_last_move", pPlayer.pev.origin );
			}
			
			CustomKeyvalue iCheck_pre( pCheck1_2.GetKeyvalue( "$i_test" ) );
			int iCheck = iCheck_pre.GetInteger();
			if ( iCheck == 1 )
			{
				// Enough score?
				CBaseEntity@ pScoreEntity = g_EntityFuncs.FindEntityByTargetname( null, "fix1" );
				if ( pScoreEntity !is null )
				{
					CustomKeyvalues@ pScoreKVD = pScoreEntity.GetCustomKeyvalues();
					CustomKeyvalue iScore_pre( pScoreKVD.GetKeyvalue( "$i_stemp" ) );
					int iScore = iScore_pre.GetInteger();
					
					if ( iScore >= 80000 )
					{
						// Enough travel distance?
						CustomKeyvalue iDistance_pre( pCheck2_1.GetKeyvalue( "$i_distance" ) );
						int iDistance = iDistance_pre.GetInteger();
						if ( iDistance >= 10240 )
						{
							// Get!
							pCheck2_1.SetKeyvalue( "$i_a_unlock", 116 );
						}
					}
				}
			}
		}
	}
	
	g_Scheduler.SetTimeout( "quad_f_check", 0.1 );
}

void ra_quad_check()
{
	if ( szMap != 'ra_quad' )
		return;
	
	CBaseEntity@ pCheck1_1 = g_EntityFuncs.FindEntityByTargetname( null, "sys_adata" );
	if ( pCheck1_1 is null )
		return;
	
	CustomKeyvalues@ pCheck1_2 = pCheck1_1.GetCustomKeyvalues();
	for ( int i = 1; i <= g_Engine.maxClients; i++ )
	{
		CBasePlayer@ pPlayer = g_PlayerFuncs.FindPlayerByIndex( i );
		
		if ( pPlayer !is null && pPlayer.IsConnected() )
		{
			CustomKeyvalues@ pCheck2_1 = pPlayer.GetCustomKeyvalues();
			CustomKeyvalue vecLastMove_pre( pCheck2_1.GetKeyvalue( "$v_last_move" ) );
			if ( vecLastMove_pre.Exists() )
			{
				Vector vecLastMove = vecLastMove_pre.GetVector();
				
				// Add distance traveled
				CustomKeyvalue iDistance_pre( pCheck2_1.GetKeyvalue( "$i_distance" ) );
				int iDistance = iDistance_pre.GetInteger();
				pCheck2_1.SetKeyvalue( "$i_distance", ( iDistance + ( vecLastMove - pPlayer.pev.origin ).Length() ) );
				
				pCheck2_1.SetKeyvalue( "$v_last_move", pPlayer.pev.origin );
			}
			else
			{
				pCheck2_1.SetKeyvalue( "$v_last_move", pPlayer.pev.origin );
			}
			
			CustomKeyvalue iCheck_pre( pCheck1_2.GetKeyvalue( "$i_test" ) );
			int iCheck = iCheck_pre.GetInteger();
			if ( iCheck == 1 )
			{
				// Enough score?
				CBaseEntity@ pScoreEntity = g_EntityFuncs.FindEntityByTargetname( null, "fix1" );
				if ( pScoreEntity !is null )
				{
					CustomKeyvalues@ pScoreKVD = pScoreEntity.GetCustomKeyvalues();
					CustomKeyvalue iScore_pre( pScoreKVD.GetKeyvalue( "$i_stemp" ) );
					int iScore = iScore_pre.GetInteger();
					
					if ( iScore >= 40000 )
					{
						// Enough travel distance?
						CustomKeyvalue iDistance_pre( pCheck2_1.GetKeyvalue( "$i_distance" ) );
						int iDistance = iDistance_pre.GetInteger();
						if ( iDistance >= 10240 )
						{
							// Get!
							pCheck2_1.SetKeyvalue( "$i_a_unlock", 117 );
						}
					}
				}
			}
		}
	}
	
	g_Scheduler.SetTimeout( "ra_quad_check", 0.1 );
}

void turretfortress_check()
{
	if ( szMap != 'turretfortress' )
		return;
	
	CBaseEntity@ pCheck1_1 = g_EntityFuncs.FindEntityByTargetname( null, "sys_adata" );
	if ( pCheck1_1 is null )
		return;
	
	CustomKeyvalues@ pCheck1_2 = pCheck1_1.GetCustomKeyvalues();
	CustomKeyvalue iCheck_pre( pCheck1_2.GetKeyvalue( "$i_test" ) );
	int iCheck = iCheck_pre.GetInteger();
	if ( iCheck == 1 )
	{
		for ( int i = 1; i <= g_Engine.maxClients; i++ )
		{
			CBasePlayer@ pPlayer = g_PlayerFuncs.FindPlayerByIndex( i );
			
			if ( pPlayer !is null && pPlayer.IsConnected() )
			{
				// Playing on hard difficulty?
				CustomKeyvalue iDifficulty_pre( pCheck1_2.GetKeyvalue( "$i_difficulty" ) );
				int iDifficulty = iDifficulty_pre.GetInteger();
				if ( iDifficulty == 1 )
				{
					// To prevent abuse, player must have at least this much score
					if ( pPlayer.pev.frags >= 280.0 ) // This is 8% of map's max score
					{
						// Get!
						CustomKeyvalues@ pUnlock = pPlayer.GetCustomKeyvalues();
						pUnlock.SetKeyvalue( "$i_a_unlock", 118 );
					}
				}
			}
		}
		
		return;
	}
	
	g_Scheduler.SetTimeout( "turretfortress_check", 0.1 );
}

void tf_original_check()
{
	if ( szMap != 'tf_original' )
		return;
	
	CBaseEntity@ pCheck1_1 = g_EntityFuncs.FindEntityByTargetname( null, "sys_adata" );
	if ( pCheck1_1 is null )
		return;
	
	CustomKeyvalues@ pCheck1_2 = pCheck1_1.GetCustomKeyvalues();
	for ( int i = 1; i <= g_Engine.maxClients; i++ )
	{
		CBasePlayer@ pPlayer = g_PlayerFuncs.FindPlayerByIndex( i );
		
		if ( pPlayer !is null && pPlayer.IsConnected() )
		{
			// Playing on hard difficulty?
			CustomKeyvalue iDifficulty_pre( pCheck1_2.GetKeyvalue( "$i_difficulty" ) );
			int iDifficulty = iDifficulty_pre.GetInteger();
			if ( iDifficulty == 1 )
			{
				CustomKeyvalues@ pCheck2_1 = pPlayer.GetCustomKeyvalues();
				CustomKeyvalue vecLastMove_pre( pCheck2_1.GetKeyvalue( "$v_last_move" ) );
				if ( vecLastMove_pre.Exists() )
				{
					Vector vecLastMove = vecLastMove_pre.GetVector();
					
					// Add distance traveled
					CustomKeyvalue iDistance_pre( pCheck2_1.GetKeyvalue( "$i_distance" ) );
					int iDistance = iDistance_pre.GetInteger();
					pCheck2_1.SetKeyvalue( "$i_distance", ( iDistance + ( vecLastMove - pPlayer.pev.origin ).Length() ) );
					
					pCheck2_1.SetKeyvalue( "$v_last_move", pPlayer.pev.origin );
				}
				else
				{
					pCheck2_1.SetKeyvalue( "$v_last_move", pPlayer.pev.origin );
				}
				
				CustomKeyvalue iCheck_pre( pCheck1_2.GetKeyvalue( "$i_test" ) );
				int iCheck = iCheck_pre.GetInteger();
				if ( iCheck == 1 )
				{
					// Enough travel distance?
					CustomKeyvalue iDistance_pre( pCheck2_1.GetKeyvalue( "$i_distance" ) );
					int iDistance = iDistance_pre.GetInteger();
					if ( iDistance >= 40960 )
					{
						// Get!
						pCheck2_1.SetKeyvalue( "$i_a_unlock", 119 );
					}
				}
			}
		}
	}
	
	g_Scheduler.SetTimeout( "tf_original_check", 0.1 );
}

void sc_robination_revised_check()
{
	if ( szMap != 'sc_robination_revised' )
		return;
	
	CBaseEntity@ pCheck1_1 = g_EntityFuncs.FindEntityByTargetname( null, "sys_adata" );
	if ( pCheck1_1 is null )
		return;
	
	CustomKeyvalues@ pCheck1_2 = pCheck1_1.GetCustomKeyvalues();
	CustomKeyvalue iCheck_pre( pCheck1_2.GetKeyvalue( "$i_test" ) );
	int iCheck = iCheck_pre.GetInteger();
	if ( iCheck == 1 )
	{
		for ( int i = 1; i <= g_Engine.maxClients; i++ )
		{
			CBasePlayer@ pPlayer = g_PlayerFuncs.FindPlayerByIndex( i );
			
			if ( pPlayer !is null && pPlayer.IsConnected() )
			{
				// No deaths?
				if ( pPlayer.m_iDeaths == 0 )
				{
					// To prevent abuse, player must have at least this much score
					if ( pPlayer.pev.frags >= 228.0 ) // This is 8% of map's max score
					{
						// Get!
						CustomKeyvalues@ pUnlock = pPlayer.GetCustomKeyvalues();
						pUnlock.SetKeyvalue( "$i_a_unlock", 120 );
					}
				}
			}
		}
		
		return;
	}
	
	g_Scheduler.SetTimeout( "sc_robination_revised_check", 0.1 );
}

void hl_trick_check()
{
	if ( szMap != 'hl_trick' )
		return;
	
	CBaseEntity@ pCheck1_1 = g_EntityFuncs.FindEntityByTargetname( null, "sys_adata" );
	if ( pCheck1_1 is null )
		return;
	
	for ( int i = 1; i <= g_Engine.maxClients; i++ )
	{
		CBasePlayer@ pPlayer = g_PlayerFuncs.FindPlayerByIndex( i );
		
		if ( pPlayer !is null && pPlayer.IsConnected() )
		{
			// Prevent /spectate exploit
			if ( pPlayer.IsAlive() )
			{
				Vector vecOrigin1 = pPlayer.pev.origin;
				Vector vecOrigin2 = pCheck1_1.pev.origin;
				
				// Finished?
				if ( ( vecOrigin1 - vecOrigin2 ).Length() <= 64.0 )
				{
					if ( pPlayer.pev.targetname != 'finished' )
					{
						// Get!
						pPlayer.pev.targetname = "finished";
						
						CustomKeyvalues@ pUnlock = pPlayer.GetCustomKeyvalues();
						pUnlock.SetKeyvalue( "$i_kz_clear", 1 );
						pUnlock.SetKeyvalue( "$i_a_unlock", 121 );
						
						// Notification (If perfect clear)
						CustomKeyvalue iCheck_pre( pUnlock.GetKeyvalue( "$i_used_cp" ) );
						int iCheck = iCheck_pre.GetInteger();
						if ( iCheck == 0 )
						{
							HUDTextParams textParams;
							textParams.x = -1;
							textParams.y = 0.7;
							textParams.effect = 2;
							textParams.r1 = 250;
							textParams.g1 = 125;
							textParams.b1 = 75;
							textParams.a1 = 250;
							textParams.r2 = 250;
							textParams.g2 = 250;
							textParams.b2 = 250;
							textParams.a2 = 0;
							textParams.fadeinTime = 0.04;
							textParams.fadeoutTime = 0.70;
							textParams.holdTime = 2.5;
							textParams.fxTime = 0.30;
							textParams.channel = 2;
							g_PlayerFuncs.HudMessage( pPlayer, textParams, "Lo lograste!\n\nSi ya has conseguido el logro antes ahora puedes redimir su recompensa!" );
						}
					}
				}
			}
		}
	}
	
	g_Scheduler.SetTimeout( "hl_trick_check", 0.1 );
}

void d_trick1_check()
{
	if ( szMap != 'd_trick1' )
		return;
	
	CBaseEntity@ pCheck1_1 = g_EntityFuncs.FindEntityByTargetname( null, "sys_adata" );
	if ( pCheck1_1 is null )
		return;
	
	for ( int i = 1; i <= g_Engine.maxClients; i++ )
	{
		CBasePlayer@ pPlayer = g_PlayerFuncs.FindPlayerByIndex( i );
		
		if ( pPlayer !is null && pPlayer.IsConnected() )
		{
			// Prevent /spectate exploit
			if ( pPlayer.IsAlive() )
			{
				Vector vecOrigin1 = pPlayer.pev.origin;
				Vector vecOrigin2 = pCheck1_1.pev.origin;
				
				// Finished?
				if ( ( vecOrigin1 - vecOrigin2 ).Length() <= 64.0 )
				{
					if ( pPlayer.pev.targetname != 'finished' )
					{
						// Get!
						pPlayer.pev.targetname = "finished";
						
						CustomKeyvalues@ pUnlock = pPlayer.GetCustomKeyvalues();
						pUnlock.SetKeyvalue( "$i_kz_clear", 1 );
						pUnlock.SetKeyvalue( "$i_a_unlock", 122 );
						
						// Notification (If perfect clear)
						CustomKeyvalue iCheck_pre( pUnlock.GetKeyvalue( "$i_used_cp" ) );
						int iCheck = iCheck_pre.GetInteger();
						if ( iCheck == 0 )
						{
							HUDTextParams textParams;
							textParams.x = -1;
							textParams.y = 0.7;
							textParams.effect = 2;
							textParams.r1 = 250;
							textParams.g1 = 125;
							textParams.b1 = 75;
							textParams.a1 = 250;
							textParams.r2 = 250;
							textParams.g2 = 250;
							textParams.b2 = 250;
							textParams.a2 = 0;
							textParams.fadeinTime = 0.04;
							textParams.fadeoutTime = 0.70;
							textParams.holdTime = 2.5;
							textParams.fxTime = 0.30;
							textParams.channel = 2;
							g_PlayerFuncs.HudMessage( pPlayer, textParams, "Lo lograste!\n\nSi ya has conseguido el logro antes ahora puedes redimir su recompensa!" );
						}
					}
				}
			}
		}
	}
	
	g_Scheduler.SetTimeout( "d_trick1_check", 0.1 );
}

void hc2b3a_check()
{
	if ( szMap != 'hc2b3a' )
		return;
	
	CBaseEntity@ pCheck1_1 = g_EntityFuncs.FindEntityByTargetname( null, "sys_adata" );
	if ( pCheck1_1 is null )
		return;
	
	for ( int i = 1; i <= g_Engine.maxClients; i++ )
	{
		CBasePlayer@ pPlayer = g_PlayerFuncs.FindPlayerByIndex( i );
		
		if ( pPlayer !is null && pPlayer.IsConnected() )
		{
			// Prevent /spectate exploit
			if ( pPlayer.IsAlive() )
			{
				Vector vecOrigin1 = pPlayer.pev.origin;
				Vector vecOrigin2 = pCheck1_1.pev.origin;
				
				// Finished?
				if ( ( vecOrigin1 - vecOrigin2 ).Length() <= 32.0 )
				{
					if ( pPlayer.pev.targetname != 'finished' )
					{
						// Get!
						pPlayer.pev.targetname = "finished";
						
						CustomKeyvalues@ pUnlock = pPlayer.GetCustomKeyvalues();
						pUnlock.SetKeyvalue( "$i_kz_clear", 1 );
						pUnlock.SetKeyvalue( "$i_a_unlock", 123 );
						
						// Notification (If perfect clear)
						CustomKeyvalue iCheck_pre( pUnlock.GetKeyvalue( "$i_used_cp" ) );
						int iCheck = iCheck_pre.GetInteger();
						if ( iCheck == 0 )
						{
							HUDTextParams textParams;
							textParams.x = -1;
							textParams.y = 0.7;
							textParams.effect = 2;
							textParams.r1 = 250;
							textParams.g1 = 125;
							textParams.b1 = 75;
							textParams.a1 = 250;
							textParams.r2 = 250;
							textParams.g2 = 250;
							textParams.b2 = 250;
							textParams.a2 = 0;
							textParams.fadeinTime = 0.04;
							textParams.fadeoutTime = 0.70;
							textParams.holdTime = 2.5;
							textParams.fxTime = 0.30;
							textParams.channel = 2;
							g_PlayerFuncs.HudMessage( pPlayer, textParams, "Lo lograste!\n\nSi ya has conseguido el logro antes ahora puedes redimir su recompensa!" );
						}
					}
				}
			}
		}
	}
	
	g_Scheduler.SetTimeout( "hc2b3a_check", 0.1 );
}

void sc_mazing_check()
{
	if ( szMap != 'sc_mazing' )
		return;
	
	CBaseEntity@ pCheck1_1 = g_EntityFuncs.FindEntityByTargetname( null, "sys_adata" );
	if ( pCheck1_1 is null )
		return;
	
	// Achievement #123
	CustomKeyvalues@ pCheck1_2 = pCheck1_1.GetCustomKeyvalues();
	CustomKeyvalue iKills_pre( pCheck1_2.GetKeyvalue( "$i_kills" ) );
	int iKills = iKills_pre.GetInteger();
	if ( iKills == 21 ) // All Pit Drones/Baby Gargantuas killed?
	{
		for ( int i = 1; i <= g_Engine.maxClients; i++ )
		{
			CBasePlayer@ pPlayer = g_PlayerFuncs.FindPlayerByIndex( i );
			
			if ( pPlayer !is null && pPlayer.IsConnected() )
			{
				// To prevent abuse, player must have at least this much score
				if ( pPlayer.pev.frags >= 140.0 ) // This is 20% of map's max score
				{
					// Get!
					CustomKeyvalues@ pUnlock = pPlayer.GetCustomKeyvalues();
					pUnlock.SetKeyvalue( "$i_a_unlock", 124 );
				}
			}
		}
		
		// Reset, no looping
		pCheck1_2.SetKeyvalue( "$i_kills", 0 );
	}
	
	// Achievement #146
	// 60 second tolerance before timer starts
	if ( pCheck1_1.pev.iuser4 >= 600 )
	{
		// Timer started, finished in less than 21 minutes?
		if ( pCheck1_1.pev.iuser3 <= 12600 )
		{
			CustomKeyvalue iCheck_pre( pCheck1_2.GetKeyvalue( "$i_test" ) );
			int iCheck = iCheck_pre.GetInteger();
			if ( iCheck == 1 )
			{
				for ( int i = 1; i <= g_Engine.maxClients; i++ )
				{
					CBasePlayer@ pPlayer = g_PlayerFuncs.FindPlayerByIndex( i );
					
					if ( pPlayer !is null && pPlayer.IsConnected() )
					{
						// To prevent abuse, player must have at least this much score
						if ( pPlayer.pev.frags >= 126.0 ) // This is 18% of map's max score
						{
							// Get!
							CustomKeyvalues@ pUnlock = pPlayer.GetCustomKeyvalues();
							pUnlock.SetKeyvalue( "$i_a_unlock", 147 );
						}
					}
				}
				
				return;
			}
		}
		
		pCheck1_1.pev.iuser3 = pCheck1_1.pev.iuser3 + 1;
	}
	else
		pCheck1_1.pev.iuser4 = pCheck1_1.pev.iuser4 + 1;
	
	g_Scheduler.SetTimeout( "sc_mazing_check", 0.1 );
}

void ub_megaman3_check()
{
	if ( szMap != 'ub_megaman3' )
		return;
	
	CBaseEntity@ pCheck1_1 = g_EntityFuncs.FindEntityByTargetname( null, "sys_adata" );
	if ( pCheck1_1 is null )
		return;
	
	CustomKeyvalues@ pCheck1_2 = pCheck1_1.GetCustomKeyvalues();
	CustomKeyvalue iActive_pre( pCheck1_2.GetKeyvalue( "$i_active" ) );
	int iActive = iActive_pre.GetInteger();
	if ( iActive == 1 ) // Timer ON?
	{
		// 15 second tolerance before timer starts
		if ( pCheck1_1.pev.iuser4 >= 150 )
		{
			// Timer started, door opened in less than 2 minutes?
			if ( pCheck1_1.pev.iuser3 <= 1200 )
			{
				CustomKeyvalue iCheck_pre( pCheck1_2.GetKeyvalue( "$i_test" ) );
				int iCheck = iCheck_pre.GetInteger();
				if ( iCheck == 1 )
				{
					for ( int i = 1; i <= g_Engine.maxClients; i++ )
					{
						CBasePlayer@ pPlayer = g_PlayerFuncs.FindPlayerByIndex( i );
						
						if ( pPlayer !is null && pPlayer.IsConnected() )
						{
							// To prevent abuse, player must have at least this much score
							if ( pPlayer.pev.frags >= 6.0 ) // This is 1% of THIRD map's max score
							{
								// Get!
								CustomKeyvalues@ pUnlock = pPlayer.GetCustomKeyvalues();
								pUnlock.SetKeyvalue( "$i_a_unlock", 125 );
							}
						}
					}
					
					return;
				}
			}
			
			pCheck1_1.pev.iuser3 = pCheck1_1.pev.iuser3 + 1;
		}
		else
			pCheck1_1.pev.iuser4 = pCheck1_1.pev.iuser4 + 1;
	}
	
	g_Scheduler.SetTimeout( "ub_megaman3_check", 0.1 );
}

void between_elvis_lg_check()
{
	if ( szMap != 'between_elvis_lg' )
		return;
	
	CBaseEntity@ pCheck1_1 = g_EntityFuncs.FindEntityByTargetname( null, "sys_adata" );
	if ( pCheck1_1 is null )
		return;
	
	CustomKeyvalues@ pCheck1_2 = pCheck1_1.GetCustomKeyvalues();
	CustomKeyvalue iCheck_pre( pCheck1_2.GetKeyvalue( "$i_test" ) );
	int iCheck = iCheck_pre.GetInteger();
	if ( iCheck == 1 )
	{
		for ( int i = 1; i <= g_Engine.maxClients; i++ )
		{
			CBasePlayer@ pPlayer = g_PlayerFuncs.FindPlayerByIndex( i );
			
			if ( pPlayer !is null && pPlayer.IsConnected() )
			{
				// To prevent abuse, player must have at least this much score
				if ( pPlayer.pev.frags >= 325.0 ) // This is 25% of map's max score
				{
					// Get!
					CustomKeyvalues@ pUnlock = pPlayer.GetCustomKeyvalues();
					pUnlock.SetKeyvalue( "$i_a_unlock", 127 );
				}
			}
		}
		
		return;
	}
	
	g_Scheduler.SetTimeout( "between_elvis_lg_check", 0.1 );
}

void cassault1_check()
{
	if ( szMap != 'cassault1' )
		return;
	
	CBaseEntity@ pCheck1_1 = g_EntityFuncs.FindEntityByTargetname( null, "sys_adata" );
	if ( pCheck1_1 is null )
		return;
	
	CustomKeyvalues@ pCheck1_2 = pCheck1_1.GetCustomKeyvalues();
	CustomKeyvalue iCheck_pre( pCheck1_2.GetKeyvalue( "$i_test" ) );
	int iCheck = iCheck_pre.GetInteger();
	if ( iCheck == 1 )
	{
		for ( int i = 1; i <= g_Engine.maxClients; i++ )
		{
			CBasePlayer@ pPlayer = g_PlayerFuncs.FindPlayerByIndex( i );
			
			if ( pPlayer !is null && pPlayer.IsConnected() )
			{
				// No deaths?
				if ( pPlayer.m_iDeaths == 0 )
				{
					CustomKeyvalues@ pCheck2_1 = pPlayer.GetCustomKeyvalues();
					
					// Handicap enabled
					CustomKeyvalue iHandicap09_pre( pCheck2_1.GetKeyvalue( "$i_handicap09" ) );
					int iHandicap09 = iHandicap09_pre.GetInteger();
					
					if ( iHandicap09 == 1 )
					{
						// To prevent abuse, player must have at least this much score
						if ( pPlayer.pev.frags >= 60.0 ) // This is 10% of map's max score
						{
							// Get!
							pCheck2_1.SetKeyvalue( "$i_a_unlock", 128 );
						}
					}
				}
			}
		}
		
		return;
	}
	
	g_Scheduler.SetTimeout( "cassault1_check", 0.1 );
}

void tox_xen5_check()
{
	if ( szMap != 'tox_xen5' )
		return;
	
	CBaseEntity@ pCheck1_1 = g_EntityFuncs.FindEntityByTargetname( null, "sys_adata" );
	if ( pCheck1_1 is null )
		return;
	
	// 60 second tolerance before timer starts
	if ( pCheck1_1.pev.iuser4 >= 600 )
	{
		// Timer started, finished in less than 90 minutes?
		if ( pCheck1_1.pev.iuser3 <= 54000 )
		{
			CustomKeyvalues@ pCheck1_2 = pCheck1_1.GetCustomKeyvalues();
			CustomKeyvalue iCheck_pre( pCheck1_2.GetKeyvalue( "$i_test" ) );
			int iCheck = iCheck_pre.GetInteger();
			if ( iCheck == 1 )
			{
				for ( int i = 1; i <= g_Engine.maxClients; i++ )
				{
					CBasePlayer@ pPlayer = g_PlayerFuncs.FindPlayerByIndex( i );
					
					if ( pPlayer !is null && pPlayer.IsConnected() )
					{
						// No deaths?
						if ( pPlayer.m_iDeaths == 0 )
						{
							// No skills check
							CustomKeyvalues@ pCheck2_1 = pPlayer.GetCustomKeyvalues();
							CustomKeyvalue iSkill1_pre( pCheck2_1.GetKeyvalue( "$i_health" ) );
							CustomKeyvalue iSkill2_pre( pCheck2_1.GetKeyvalue( "$i_armor" ) );
							CustomKeyvalue iSkill3_pre( pCheck2_1.GetKeyvalue( "$i_rhealth" ) );
							CustomKeyvalue iSkill4_pre( pCheck2_1.GetKeyvalue( "$i_rarmor" ) );
							CustomKeyvalue iSkill5_pre( pCheck2_1.GetKeyvalue( "$i_rammo" ) );
							CustomKeyvalue iSkill6_pre( pCheck2_1.GetKeyvalue( "$i_gravity" ) );
							CustomKeyvalue iSkill7_pre( pCheck2_1.GetKeyvalue( "$i_speed" ) );
							CustomKeyvalue iSkill8_pre( pCheck2_1.GetKeyvalue( "$i_dist" ) );
							CustomKeyvalue iSkill9_pre( pCheck2_1.GetKeyvalue( "$i_dodge" ) );
							int iSkill1 = iSkill1_pre.GetInteger();
							int iSkill2 = iSkill2_pre.GetInteger();
							int iSkill3 = iSkill3_pre.GetInteger();
							int iSkill4 = iSkill4_pre.GetInteger();
							int iSkill5 = iSkill5_pre.GetInteger();
							int iSkill6 = iSkill6_pre.GetInteger();
							int iSkill7 = iSkill7_pre.GetInteger();
							int iSkill8 = iSkill8_pre.GetInteger();
							int iSkill9 = iSkill9_pre.GetInteger();
							if ( iSkill1 == 0 && iSkill2 == 0 && iSkill3 == 0 && iSkill4 == 0 && iSkill5 == 0 && iSkill6 == 0 && iSkill7 == 0 && iSkill8 == 0 && iSkill9 == 0 )
							{
								// No cheating check
								CustomKeyvalue iOldSkill1_pre( pCheck2_1.GetKeyvalue( "$i_old_health" ) );
								CustomKeyvalue iOldSkill2_pre( pCheck2_1.GetKeyvalue( "$i_old_armor" ) );
								CustomKeyvalue iOldSkill3_pre( pCheck2_1.GetKeyvalue( "$i_old_rhealth" ) );
								CustomKeyvalue iOldSkill4_pre( pCheck2_1.GetKeyvalue( "$i_old_rarmor" ) );
								CustomKeyvalue iOldSkill5_pre( pCheck2_1.GetKeyvalue( "$i_old_rammo" ) );
								CustomKeyvalue iOldSkill6_pre( pCheck2_1.GetKeyvalue( "$i_old_gravity" ) );
								CustomKeyvalue iOldSkill7_pre( pCheck2_1.GetKeyvalue( "$i_old_speed" ) );
								CustomKeyvalue iOldSkill8_pre( pCheck2_1.GetKeyvalue( "$i_old_dist" ) );
								CustomKeyvalue iOldSkill9_pre( pCheck2_1.GetKeyvalue( "$i_old_dodge" ) );
								int iOldSkill1 = iOldSkill1_pre.GetInteger();
								int iOldSkill2 = iOldSkill2_pre.GetInteger();
								int iOldSkill3 = iOldSkill3_pre.GetInteger();
								int iOldSkill4 = iOldSkill4_pre.GetInteger();
								int iOldSkill5 = iOldSkill5_pre.GetInteger();
								int iOldSkill6 = iOldSkill6_pre.GetInteger();
								int iOldSkill7 = iOldSkill7_pre.GetInteger();
								int iOldSkill8 = iOldSkill8_pre.GetInteger();
								int iOldSkill9 = iOldSkill9_pre.GetInteger();
								if ( iOldSkill1 == 0 && iOldSkill2 == 0 && iOldSkill3 == 0 && iOldSkill4 == 0 && iOldSkill5 == 0 && iOldSkill6 == 0 && iOldSkill7 == 0 && iOldSkill8 == 0 && iOldSkill9 == 0 )
								{
									// Handicap active?
									CustomKeyvalue iHandicap08_pre( pCheck2_1.GetKeyvalue( "$i_handicap08" ) );
									int iHandicap08 = iHandicap08_pre.GetInteger();
									if ( iHandicap08 == 1 )
									{						
										// To prevent abuse, player must have at least this much score
										if ( pPlayer.pev.frags >= 250.0 ) // This is 10% of map's max score
										{
											// Get!
											pCheck2_1.SetKeyvalue( "$i_a_unlock", 129 );
										}
									}
								}
							}
						}
					}
				}
				
				return;
			}
		}
		
		pCheck1_1.pev.iuser3 = pCheck1_1.pev.iuser3 + 1;
	}
	else
		pCheck1_1.pev.iuser4 = pCheck1_1.pev.iuser4 + 1;
	
	g_Scheduler.SetTimeout( "tox_xen5_check", 0.1 );
}

void sc_marioland_check()
{
	if ( szMap != 'sc_marioland' )
		return;
	
	CBaseEntity@ pCheck1_1 = g_EntityFuncs.FindEntityByTargetname( null, "sys_adata" );
	if ( pCheck1_1 is null )
		return;
	
	CustomKeyvalues@ pCheck1_2 = pCheck1_1.GetCustomKeyvalues();
	CustomKeyvalue iCheck_pre( pCheck1_2.GetKeyvalue( "$i_test" ) );
	int iCheck = iCheck_pre.GetInteger();
	if ( iCheck == 1 )
	{
		// All enemies killed?
		CustomKeyvalue iKills_pre( pCheck1_2.GetKeyvalue( "$i_kills" ) );
		int iKills = iKills_pre.GetInteger();
		if ( iKills >= 100 ) // Total enemy count is 111. Rounding down to 100 to leave room for some error
		{
			for ( int i = 1; i <= g_Engine.maxClients; i++ )
			{
				CBasePlayer@ pPlayer = g_PlayerFuncs.FindPlayerByIndex( i );
				
				if ( pPlayer !is null && pPlayer.IsConnected() )
				{
					// Less than 3 deaths?
					if ( pPlayer.m_iDeaths < 3 )
					{
						// To prevent abuse, player must have at least this much score
						if ( pPlayer.pev.frags >= 225.0 ) // This is 15% of map's max score
						{
							// Get!
							CustomKeyvalues@ pUnlock = pPlayer.GetCustomKeyvalues();
							pUnlock.SetKeyvalue( "$i_a_unlock", 130 );
						}
					}
				}
			}
		}
		
		return;
	}
	
	g_Scheduler.SetTimeout( "sc_marioland_check", 0.1 );
}

void hplanet_check()
{
	if ( szMap != 'hplanet' )
		return;
	
	CBaseEntity@ pCheck1_1 = g_EntityFuncs.FindEntityByTargetname( null, "sys_adata" );
	if ( pCheck1_1 is null )
		return;
	
	// 60 second tolerance before timer starts
	if ( pCheck1_1.pev.iuser4 >= 600 )
	{
		// Timer started, finished in less than 20 minutes?
		if ( pCheck1_1.pev.iuser3 <= 12000 )
		{
			CustomKeyvalues@ pCheck1_2 = pCheck1_1.GetCustomKeyvalues();
			CustomKeyvalue iCheck_pre( pCheck1_2.GetKeyvalue( "$i_test" ) );
			int iCheck = iCheck_pre.GetInteger();
			if ( iCheck == 1 )
			{
				for ( int i = 1; i <= g_Engine.maxClients; i++ )
				{
					CBasePlayer@ pPlayer = g_PlayerFuncs.FindPlayerByIndex( i );
					
					if ( pPlayer !is null && pPlayer.IsConnected() )
					{
						// Check if the player has ALL handicaps activated
						CustomKeyvalues@ pCheck3 = pPlayer.GetCustomKeyvalues();
						
						CustomKeyvalue iHandicap01_pre( pCheck3.GetKeyvalue( "$i_handicap01" ) );
						CustomKeyvalue iHandicap02_pre( pCheck3.GetKeyvalue( "$i_handicap02" ) );
						CustomKeyvalue iHandicap03_pre( pCheck3.GetKeyvalue( "$i_handicap03" ) );
						CustomKeyvalue iHandicap04_pre( pCheck3.GetKeyvalue( "$i_handicap04" ) );
						CustomKeyvalue iHandicap05_pre( pCheck3.GetKeyvalue( "$i_handicap05" ) );
						CustomKeyvalue iHandicap06_pre( pCheck3.GetKeyvalue( "$i_handicap06" ) );
						CustomKeyvalue iHandicap07_pre( pCheck3.GetKeyvalue( "$i_handicap07" ) );
						CustomKeyvalue iHandicap08_pre( pCheck3.GetKeyvalue( "$i_handicap08" ) );
						CustomKeyvalue iHandicap09_pre( pCheck3.GetKeyvalue( "$i_handicap09" ) );
						CustomKeyvalue iHandicap10_pre( pCheck3.GetKeyvalue( "$i_handicap10" ) );
						CustomKeyvalue iHandicap11_pre( pCheck3.GetKeyvalue( "$i_handicap11" ) );
						CustomKeyvalue iHandicap12_pre( pCheck3.GetKeyvalue( "$i_handicap12" ) );
						CustomKeyvalue iHandicap13_pre( pCheck3.GetKeyvalue( "$i_handicap13" ) );
						
						int iHandicap01 = iHandicap01_pre.GetInteger();
						int iHandicap02 = iHandicap02_pre.GetInteger();
						int iHandicap03 = iHandicap03_pre.GetInteger();
						int iHandicap04 = iHandicap04_pre.GetInteger();
						int iHandicap05 = iHandicap05_pre.GetInteger();
						int iHandicap06 = iHandicap06_pre.GetInteger();
						int iHandicap07 = iHandicap07_pre.GetInteger();
						int iHandicap08 = iHandicap08_pre.GetInteger();
						int iHandicap09 = iHandicap09_pre.GetInteger();
						int iHandicap10 = iHandicap10_pre.GetInteger();
						int iHandicap11 = iHandicap11_pre.GetInteger();
						int iHandicap12 = iHandicap11_pre.GetInteger();
						int iHandicap13 = iHandicap11_pre.GetInteger();
						
						if ( iHandicap01 == 1 && iHandicap02 == 1 && iHandicap03 == 1 && iHandicap04 == 1 && iHandicap05 == 1 && iHandicap06 == 1 && iHandicap07 == 1 && iHandicap08 == 1 && iHandicap09 == 1 && iHandicap10 == 1 && iHandicap11 == 1 && iHandicap12 == 1 && iHandicap13 == 1 )
						{
							// To prevent abuse, player must have at least this much score
							if ( pPlayer.pev.frags >= 50.0 ) // This is 10% of map's max score
							{
								// Get!
								CustomKeyvalues@ pUnlock = pPlayer.GetCustomKeyvalues();
								pUnlock.SetKeyvalue( "$i_a_unlock", 131 );
							}
						}
					}
				}
				
				return;
			}
		}
		
		pCheck1_1.pev.iuser3 = pCheck1_1.pev.iuser3 + 1;
	}
	else
		pCheck1_1.pev.iuser4 = pCheck1_1.pev.iuser4 + 1;
	
	g_Scheduler.SetTimeout( "hplanet_check", 0.1 );
}

void croodcoop_check()
{
	if ( szMap != 'croodcoop' )
		return;
	
	CBaseEntity@ pCheck1_1 = g_EntityFuncs.FindEntityByTargetname( null, "sys_adata" );
	if ( pCheck1_1 is null )
		return;
	
	CustomKeyvalues@ pCheck1_2 = pCheck1_1.GetCustomKeyvalues();
	CustomKeyvalue iCheck_pre( pCheck1_2.GetKeyvalue( "$i_test" ) );
	int iCheck = iCheck_pre.GetInteger();
	if ( iCheck == 1 )
	{
		for ( int i = 1; i <= g_Engine.maxClients; i++ )
		{
			CBasePlayer@ pPlayer = g_PlayerFuncs.FindPlayerByIndex( i );
			
			if ( pPlayer !is null && pPlayer.IsConnected() )
			{
				// No deaths?
				if ( pPlayer.m_iDeaths == 0 )
				{
					// To prevent abuse, player must have at least this much score
					if ( pPlayer.pev.frags >= 165.0 ) // This is 5% of map's max score (Map XPGain needs to be recalculated)
					{
						// Get!
						CustomKeyvalues@ pUnlock = pPlayer.GetCustomKeyvalues();
						pUnlock.SetKeyvalue( "$i_a_unlock", 132 );
					}
				}
			}
		}
		
		return;
	}
	
	g_Scheduler.SetTimeout( "croodcoop_check", 0.1 );
}

void sc_titans_check()
{
	if ( szMap != 'sc_titans' )
		return;
	
	CBaseEntity@ pCheck1_1 = g_EntityFuncs.FindEntityByTargetname( null, "sys_adata" );
	if ( pCheck1_1 is null )
		return;
	
	CustomKeyvalues@ pCheck1_2 = pCheck1_1.GetCustomKeyvalues();
	CustomKeyvalue iCheck_pre( pCheck1_2.GetKeyvalue( "$i_test" ) );
	int iCheck = iCheck_pre.GetInteger();
	if ( iCheck == 1 )
	{
		for ( int i = 1; i <= g_Engine.maxClients; i++ )
		{
			CBasePlayer@ pPlayer = g_PlayerFuncs.FindPlayerByIndex( i );
			
			if ( pPlayer !is null && pPlayer.IsConnected() )
			{
				CustomKeyvalues@ pCheck2_1 = pPlayer.GetCustomKeyvalues();
				
				// No skills check
				CustomKeyvalue iSkill1_pre( pCheck2_1.GetKeyvalue( "$i_health" ) );
				CustomKeyvalue iSkill2_pre( pCheck2_1.GetKeyvalue( "$i_armor" ) );
				CustomKeyvalue iSkill3_pre( pCheck2_1.GetKeyvalue( "$i_rhealth" ) );
				CustomKeyvalue iSkill4_pre( pCheck2_1.GetKeyvalue( "$i_rarmor" ) );
				CustomKeyvalue iSkill5_pre( pCheck2_1.GetKeyvalue( "$i_rammo" ) );
				CustomKeyvalue iSkill6_pre( pCheck2_1.GetKeyvalue( "$i_gravity" ) );
				CustomKeyvalue iSkill7_pre( pCheck2_1.GetKeyvalue( "$i_speed" ) );
				CustomKeyvalue iSkill8_pre( pCheck2_1.GetKeyvalue( "$i_dist" ) );
				CustomKeyvalue iSkill9_pre( pCheck2_1.GetKeyvalue( "$i_dodge" ) );
				int iSkill1 = iSkill1_pre.GetInteger();
				int iSkill2 = iSkill2_pre.GetInteger();
				int iSkill3 = iSkill3_pre.GetInteger();
				int iSkill4 = iSkill4_pre.GetInteger();
				int iSkill5 = iSkill5_pre.GetInteger();
				int iSkill6 = iSkill6_pre.GetInteger();
				int iSkill7 = iSkill7_pre.GetInteger();
				int iSkill8 = iSkill8_pre.GetInteger();
				int iSkill9 = iSkill9_pre.GetInteger();
				if ( iSkill1 == 0 && iSkill2 == 0 && iSkill3 == 0 && iSkill4 == 0 && iSkill5 == 0 && iSkill6 == 0 && iSkill7 == 0 && iSkill8 == 0 && iSkill9 == 0 )
				{
					// No cheating check
					CustomKeyvalue iOldSkill1_pre( pCheck2_1.GetKeyvalue( "$i_old_health" ) );
					CustomKeyvalue iOldSkill2_pre( pCheck2_1.GetKeyvalue( "$i_old_armor" ) );
					CustomKeyvalue iOldSkill3_pre( pCheck2_1.GetKeyvalue( "$i_old_rhealth" ) );
					CustomKeyvalue iOldSkill4_pre( pCheck2_1.GetKeyvalue( "$i_old_rarmor" ) );
					CustomKeyvalue iOldSkill5_pre( pCheck2_1.GetKeyvalue( "$i_old_rammo" ) );
					CustomKeyvalue iOldSkill6_pre( pCheck2_1.GetKeyvalue( "$i_old_gravity" ) );
					CustomKeyvalue iOldSkill7_pre( pCheck2_1.GetKeyvalue( "$i_old_speed" ) );
					CustomKeyvalue iOldSkill8_pre( pCheck2_1.GetKeyvalue( "$i_old_dist" ) );
					CustomKeyvalue iOldSkill9_pre( pCheck2_1.GetKeyvalue( "$i_old_dodge" ) );
					int iOldSkill1 = iOldSkill1_pre.GetInteger();
					int iOldSkill2 = iOldSkill2_pre.GetInteger();
					int iOldSkill3 = iOldSkill3_pre.GetInteger();
					int iOldSkill4 = iOldSkill4_pre.GetInteger();
					int iOldSkill5 = iOldSkill5_pre.GetInteger();
					int iOldSkill6 = iOldSkill6_pre.GetInteger();
					int iOldSkill7 = iOldSkill7_pre.GetInteger();
					int iOldSkill8 = iOldSkill8_pre.GetInteger();
					int iOldSkill9 = iOldSkill9_pre.GetInteger();
					if ( iOldSkill1 == 0 && iOldSkill2 == 0 && iOldSkill3 == 0 && iOldSkill4 == 0 && iOldSkill5 == 0 && iOldSkill6 == 0 && iOldSkill7 == 0 && iOldSkill8 == 0 && iOldSkill9 == 0 )
					{
						// To prevent abuse, player must have at least this much score
						if ( pPlayer.pev.frags >= 225.0 ) // XPGain may be a little too low... This is 10% of map's max score
						{
							// Get!
							pCheck2_1.SetKeyvalue( "$i_a_unlock", 133 );
						}
					}
				}
			}
		}
		
		return;
	}
	
	g_Scheduler.SetTimeout( "sc_titans_check", 0.1 );
}

void bm_sts_check()
{
	if ( szMap != 'bm_sts' )
		return;
	
	CBaseEntity@ pCheck1_1 = g_EntityFuncs.FindEntityByTargetname( null, "sys_adata" );
	if ( pCheck1_1 is null )
		return;
	
	// Gather Techlevel 5's and check
	CustomKeyvalues@ pCheck1_2 = pCheck1_1.GetCustomKeyvalues();
	CustomKeyvalue iRedLV5_pre( pCheck1_2.GetKeyvalue( "$i_red_level5" ) );
	CustomKeyvalue iBlueLV5_pre( pCheck1_2.GetKeyvalue( "$i_blue_level5" ) );
	CustomKeyvalue iGreenLV5_pre( pCheck1_2.GetKeyvalue( "$i_green_level5" ) );
	CustomKeyvalue iYellowLV5_pre( pCheck1_2.GetKeyvalue( "$i_yellow_level5" ) );
	int iRedLV5 = iRedLV5_pre.GetInteger();
	int iBlueLV5 = iBlueLV5_pre.GetInteger();
	int iGreenLV5 = iGreenLV5_pre.GetInteger();
	int iYellowLV5 = iYellowLV5_pre.GetInteger();
	
	for ( int i = 1; i <= g_Engine.maxClients; i++ )
	{
		CBasePlayer@ pPlayer = g_PlayerFuncs.FindPlayerByIndex( i );
		
		if ( pPlayer !is null && pPlayer.IsConnected() )
		{
			if ( pPlayer.pev.targetname == 'team_red_player' )
			{
				if ( iRedLV5 == 4 )
				{
					// Only unlock if the player was playing the match FROM THE START!
					CustomKeyvalues@ pCheck2_1 = pPlayer.GetCustomKeyvalues();
					CustomKeyvalue bStart_pre( pCheck2_1.GetKeyvalue( "$i_from_start" ) );
					int bStart = bStart_pre.GetInteger();
					if ( bStart == 1 )
					{
						// Get!
						pCheck2_1.SetKeyvalue( "$i_a_unlock", 134 );
					}
					
					// Reset
					pCheck1_2.SetKeyvalue( "$i_red_level5", 0 );
				}
			}
			else if ( pPlayer.pev.targetname == 'team_blue_player' )
			{
				if ( iBlueLV5 == 4 )
				{
					// Only unlock if the player was playing the match FROM THE START!
					CustomKeyvalues@ pCheck2_1 = pPlayer.GetCustomKeyvalues();
					CustomKeyvalue bStart_pre( pCheck2_1.GetKeyvalue( "$i_from_start" ) );
					int bStart = bStart_pre.GetInteger();
					if ( bStart == 1 )
					{
						// Get!
						pCheck2_1.SetKeyvalue( "$i_a_unlock", 134 );
					}
					
					// Reset
					pCheck1_2.SetKeyvalue( "$i_blue_level5", 0 );
				}
			}
			else if ( pPlayer.pev.targetname == 'team_green_player' )
			{
				if ( iGreenLV5 == 4 )
				{
					// Only unlock if the player was playing the match FROM THE START!
					CustomKeyvalues@ pCheck2_1 = pPlayer.GetCustomKeyvalues();
					CustomKeyvalue bStart_pre( pCheck2_1.GetKeyvalue( "$i_from_start" ) );
					int bStart = bStart_pre.GetInteger();
					if ( bStart == 1 )
					{
						// Get!
						pCheck2_1.SetKeyvalue( "$i_a_unlock", 134 );
					}
					
					// Reset
					pCheck1_2.SetKeyvalue( "$i_green_level5", 0 );
				}
			}
			else if ( pPlayer.pev.targetname == 'team_yell_player' )
			{
				if ( iYellowLV5 == 4 )
				{
					// Only unlock if the player was playing the match FROM THE START!
					CustomKeyvalues@ pCheck2_1 = pPlayer.GetCustomKeyvalues();
					CustomKeyvalue bStart_pre( pCheck2_1.GetKeyvalue( "$i_from_start" ) );
					int bStart = bStart_pre.GetInteger();
					if ( bStart == 1 )
					{
						// Get!
						pCheck2_1.SetKeyvalue( "$i_a_unlock", 134 );
					}
					
					// Reset
					pCheck1_2.SetKeyvalue( "$i_yellow_level5", 0 );
				}
			}
		}
	}
	
	g_Scheduler.SetTimeout( "bm_sts_check", 0.1 );
}

void polar_rescue_check()
{
	if ( szMap != 'polar_rescue' )
		return;
	
	CBaseEntity@ pCheck1_1 = g_EntityFuncs.FindEntityByTargetname( null, "sys_adata" );
	if ( pCheck1_1 is null )
		return;
	
	CustomKeyvalues@ pCheck1_2 = pCheck1_1.GetCustomKeyvalues();
	CustomKeyvalue iCheck_pre( pCheck1_2.GetKeyvalue( "$i_test" ) );
	int iCheck = iCheck_pre.GetInteger();
	if ( iCheck == 1 )
	{
		for ( int i = 1; i <= g_Engine.maxClients; i++ )
		{
			CBasePlayer@ pPlayer = g_PlayerFuncs.FindPlayerByIndex( i );
			
			if ( pPlayer !is null && pPlayer.IsConnected() )
			{
				// Playing on hard difficulty?
				CustomKeyvalue iDifficulty_pre( pCheck1_2.GetKeyvalue( "$i_difficulty" ) );
				int iDifficulty = iDifficulty_pre.GetInteger();
				if ( iDifficulty == 1 )
				{
					// To prevent abuse, player must have at least this much score
					if ( pPlayer.pev.frags >= 60.0 ) // This is 20% of map's max score
					{
						// Get!
						CustomKeyvalues@ pUnlock = pPlayer.GetCustomKeyvalues();
						pUnlock.SetKeyvalue( "$i_a_unlock", 135 );
					}
				}
			}
		}
		
		return;
	}
	
	g_Scheduler.SetTimeout( "polar_rescue_check", 0.1 );
}

void sc_tetris1_check()
{
	if ( szMap != 'sc_tetris1' )
		return;
	
	CBaseEntity@ pCheck1_1 = g_EntityFuncs.FindEntityByTargetname( null, "sys_adata" );
	if ( pCheck1_1 is null )
		return;
	
	CustomKeyvalues@ pCheck1_2 = pCheck1_1.GetCustomKeyvalues();
	CustomKeyvalue iCheck_pre( pCheck1_2.GetKeyvalue( "$i_run" ) );
	int iCheck = iCheck_pre.GetInteger();
	if ( iCheck == 1 )
	{
		// Go! Go! Go!
		string szPath = "scripts/plugins/temp/sc_tetris1.lst";
		File@ thefile = g_FileSystem.OpenFile( szPath, OpenFile::WRITE );
		
		if ( thefile !is null && thefile.IsOpen() )
		{
			for ( int i = 1; i <= g_Engine.maxClients; i++ )
			{
				CBasePlayer@ pPlayer = g_PlayerFuncs.FindPlayerByIndex( i );
				
				if ( pPlayer !is null && pPlayer.IsConnected() )
				{
					thefile.Write( "" + g_EngineFuncs.GetPlayerAuthId( pPlayer.edict() ) + "\n" );
				}
			}
			
			thefile.Close();
		}
		
		szPath = "scripts/plugins/temp/sc_tetris.ini";
		@thefile = g_FileSystem.OpenFile( szPath, OpenFile::WRITE );
		
		if ( thefile !is null && thefile.IsOpen() )
		{
			thefile.Write( string( UnixTimestamp() ) );
			thefile.Close();
		}
		
		return;
	}
	
	g_Scheduler.SetTimeout( "sc_tetris1_check", 0.1 );
}
void sc_tetris2_5_check()
{
	if ( szMap != 'sc_tetris2' && szMap != 'sc_tetris3' && szMap != 'sc_tetris4' && szMap != 'sc_tetris5' )
		return;
	
	// Update player list, keep running!
	string szPath = "scripts/plugins/temp/" + szMap + ".lst";
	File@ thefile = g_FileSystem.OpenFile( szPath, OpenFile::WRITE );
	
	if ( thefile !is null && thefile.IsOpen() )
	{
		for ( int i = 1; i <= g_Engine.maxClients; i++ )
		{
			CBasePlayer@ pPlayer = g_PlayerFuncs.FindPlayerByIndex( i );
			
			if ( pPlayer !is null && pPlayer.IsConnected() )
			{
				thefile.Write( "" + g_EngineFuncs.GetPlayerAuthId( pPlayer.edict() ) + "\n" );
			}
		}
		
		thefile.Close();
	}
}

void sc_tetris6_check()
{
	if ( szMap != 'sc_tetris6' )
		return;
	
	CBaseEntity@ pCheck1_1 = g_EntityFuncs.FindEntityByTargetname( null, "sys_adata" );
	if ( pCheck1_1 is null )
		return;
	
	// 65 second tolerance before timer starts
	if ( pCheck1_1.pev.iuser4 >= 651 && pCheck1_1.pev.iuser3 == 0 )
	{
		// One last push!
		string szPath = "scripts/plugins/temp/sc_tetris6.lst";
		File@ thefile = g_FileSystem.OpenFile( szPath, OpenFile::WRITE );
		
		if ( thefile !is null && thefile.IsOpen() )
		{
			for ( int i = 1; i <= g_Engine.maxClients; i++ )
			{
				CBasePlayer@ pPlayer = g_PlayerFuncs.FindPlayerByIndex( i );
				
				if ( pPlayer !is null && pPlayer.IsConnected() )
				{
					thefile.Write( "" + g_EngineFuncs.GetPlayerAuthId( pPlayer.edict() ) + "\n" );
				}
			}
			
			thefile.Close();
		}
		
		pCheck1_1.pev.iuser3 = 1;
	}
	else
		pCheck1_1.pev.iuser4 = pCheck1_1.pev.iuser4 + 1;
	
	CustomKeyvalues@ pCheck1_2 = pCheck1_1.GetCustomKeyvalues();
	CustomKeyvalue iCheck_pre( pCheck1_2.GetKeyvalue( "$i_test" ) );
	int iCheck = iCheck_pre.GetInteger();
	if ( iCheck == 1 )
	{
		string szPath = "scripts/plugins/temp/sc_tetris.ini";
		File@ thefile = g_FileSystem.OpenFile( szPath, OpenFile::READ );
		if ( thefile !is null && thefile.IsOpen() )
		{
			string line;
			thefile.ReadLine( line );
			
			DateTime dtStartTime;
			dtStartTime.SetUnixTimestamp( atoi( line ) );
			DateTime dtEndTime = DateTime( UnixTimestamp() );
			
			TimeDifference tdTotalTime( dtEndTime, dtStartTime );
			if ( tdTotalTime.GetMinutes() < 75 ) // Under 75 minutes?
			{
				for ( int i = 1; i <= g_Engine.maxClients; i++ )
				{
					int iTimes = 0;
					CBasePlayer@ pPlayer = g_PlayerFuncs.FindPlayerByIndex( i );
					
					if ( pPlayer !is null && pPlayer.IsConnected() )
					{
						// Check if the player was present in all the levels
						for ( int iMap = 1; iMap <= 6; iMap++ )
						{
							szPath = "scripts/plugins/temp/sc_tetris" + iMap + ".lst";
							File@ altfile = g_FileSystem.OpenFile( szPath, OpenFile::READ );
							if ( altfile !is null && altfile.IsOpen() )
							{
								string szPlayer;
								while ( !altfile.EOFReached() )
								{
									altfile.ReadLine( szPlayer );
									if ( szPlayer == g_EngineFuncs.GetPlayerAuthId( pPlayer.edict() ) )
									{
										iTimes++;
										break; // This break should only exit the while loop, NOT the for loop!
									}
								}
								altfile.Close();
							}
						}
						
						if ( iTimes == 6 )
						{
							// EVIL SCORE REQUIREMENT
							if ( pPlayer.pev.frags >= 121.0 ) // This is 25% of SIXTH map's max score
							{
								// Get!
								CustomKeyvalues@ pUnlock = pPlayer.GetCustomKeyvalues();
								pUnlock.SetKeyvalue( "$i_a_unlock", 136 );
							}
						}
					}
				}
			}
		}
		
		return;
	}
	
	g_Scheduler.SetTimeout( "sc_tetris6_check", 0.1 );
}

void sc_tombofdeath_v12_1_6_check()
{
	if ( szMap != 'sc_tombofdeath_v12-1' && szMap != 'sc_tombofdeath_v12-2' && szMap != 'sc_tombofdeath_v12-3' && szMap != 'sc_tombofdeath_v12-4' && szMap != 'sc_tombofdeath_v12-5' && szMap != 'sc_tombofdeath_v12-6' )
		return;
	
	// Update death info
	string szPath = "scripts/plugins/temp/" + szMap + ".lst";
	File@ thefile = g_FileSystem.OpenFile( szPath, OpenFile::WRITE );
	
	if ( thefile !is null && thefile.IsOpen() )
	{
		for ( int i = 1; i <= g_Engine.maxClients; i++ )
		{
			CBasePlayer@ pPlayer = g_PlayerFuncs.FindPlayerByIndex( i );
			
			if ( pPlayer !is null && pPlayer.IsConnected() )
			{
				CBaseEntity@ pCheck1_1 = g_EntityFuncs.FindEntityByTargetname( null, "sys_adata" );
				if ( pCheck1_1 is null )
				{
					// Try again
					g_Scheduler.SetTimeout( "sc_tombofdeath_v12_1_6_check", 1.0 );
					return;
				}
				
				CustomKeyvalues@ pCheck1_2 = pCheck1_1.GetCustomKeyvalues();
				string szPlayer = g_EngineFuncs.GetPlayerAuthId( pPlayer.edict() );
				szPlayer.Replace( ':', '_' );
				CustomKeyvalue iPlayerFail( pCheck1_2.GetKeyvalue( "$i_" + szPlayer ) );
				
				// Don't cheat: Don't reset the status if already failed
				if ( !iPlayerFail.Exists() )
				{
					// Less than 2 deaths?
					if ( pPlayer.m_iDeaths < 2 )
						thefile.Write( "" + g_EngineFuncs.GetPlayerAuthId( pPlayer.edict() ) + "#PASS\n" );
					else
					{
						thefile.Write( "" + g_EngineFuncs.GetPlayerAuthId( pPlayer.edict() ) + "#FAIL\n" );
						pCheck1_2.SetKeyvalue( "$i_" + szPlayer, 1 );
					}
				}
				else
					thefile.Write( "" + g_EngineFuncs.GetPlayerAuthId( pPlayer.edict() ) + "#FAIL\n" );
			}
		}
		
		thefile.Close();
	}
	
	g_Scheduler.SetTimeout( "sc_tombofdeath_v12_1_6_check", 1.0 );
}

void sc_tombofdeath_v12_6_check()
{
	if ( szMap != 'sc_tombofdeath_v12-6' )
		return;
	
	CBaseEntity@ pCheck1_1 = g_EntityFuncs.FindEntityByTargetname( null, "sys_adata" );
	if ( pCheck1_1 is null )
		return;
	
	CustomKeyvalues@ pCheck1_2 = pCheck1_1.GetCustomKeyvalues();
	CustomKeyvalue iCheck_pre( pCheck1_2.GetKeyvalue( "$i_test" ) );
	int iCheck = iCheck_pre.GetInteger();
	if ( iCheck == 1 )
	{
		for ( int i = 1; i <= g_Engine.maxClients; i++ )
		{
			int iTimes = 0;
			CBasePlayer@ pPlayer = g_PlayerFuncs.FindPlayerByIndex( i );
			
			if ( pPlayer !is null && pPlayer.IsConnected() )
			{
				// Check if the player passed previous levels
				for ( int iMap = 1; iMap <= 6; iMap++ )
				{
					string szPath = "scripts/plugins/temp/sc_tombofdeath_v12-" + iMap + ".lst";
					File@ altfile = g_FileSystem.OpenFile( szPath, OpenFile::READ );
					if ( altfile !is null && altfile.IsOpen() )
					{
						string szPlayer;
						while ( !altfile.EOFReached() )
						{
							altfile.ReadLine( szPlayer );
							szPlayer.Replace( '#', ' ' );
							array< string >@ pre_data = szPlayer.Split( ' ' );
							if ( pre_data[ 0 ] == g_EngineFuncs.GetPlayerAuthId( pPlayer.edict() ) )
							{
								if ( pre_data[ 1 ] == 'PASS' )
								{
									iTimes++;
									break;
								}
							}
						}
						altfile.Close();
					}
				}
				
				if ( iTimes == 6 )
				{
					// EVIL SCORE REQUIREMENT
					if ( pPlayer.pev.frags >= 17.0 ) // This is 6% of SIXTH map's max score
					{
						// Get!
						CustomKeyvalues@ pUnlock = pPlayer.GetCustomKeyvalues();
						pUnlock.SetKeyvalue( "$i_a_unlock", 137 );
					}
				}
			}
		}
		
		return;
	}
	
	g_Scheduler.SetTimeout( "sc_tombofdeath_v12_6_check", 0.1 );
}

void beatthis_check()
{
	if ( szMap != 'beatthis' )
		return;
	
	CBaseEntity@ pCheck1_1 = g_EntityFuncs.FindEntityByTargetname( null, "sys_adata" );
	if ( pCheck1_1 is null )
		return;
	
	CustomKeyvalues@ pCheck1_2 = pCheck1_1.GetCustomKeyvalues();
	for ( int i = 1; i <= g_Engine.maxClients; i++ )
	{
		CBasePlayer@ pPlayer = g_PlayerFuncs.FindPlayerByIndex( i );
		
		if ( pPlayer !is null && pPlayer.IsConnected() )
		{
			CustomKeyvalues@ pCheck2_1 = pPlayer.GetCustomKeyvalues();
			CustomKeyvalue vecLastMove_pre( pCheck2_1.GetKeyvalue( "$v_last_move" ) );
			if ( vecLastMove_pre.Exists() )
			{
				Vector vecLastMove = vecLastMove_pre.GetVector();
				
				// Add distance traveled
				CustomKeyvalue iDistance_pre( pCheck2_1.GetKeyvalue( "$i_distance" ) );
				int iDistance = iDistance_pre.GetInteger();
				pCheck2_1.SetKeyvalue( "$i_distance", ( iDistance + ( vecLastMove - pPlayer.pev.origin ).Length() ) );
				
				pCheck2_1.SetKeyvalue( "$v_last_move", pPlayer.pev.origin );
			}
			else
			{
				pCheck2_1.SetKeyvalue( "$v_last_move", pPlayer.pev.origin );
			}
			
			CustomKeyvalue iCheck_pre( pCheck1_2.GetKeyvalue( "$i_test" ) );
			int iCheck = iCheck_pre.GetInteger();
			if ( iCheck == 1 )
			{
				// Enough travel distance?
				CustomKeyvalue iDistance_pre( pCheck2_1.GetKeyvalue( "$i_distance" ) );
				int iDistance = iDistance_pre.GetInteger();
				if ( iDistance >= 20480 )
				{
					// Get!
					pCheck2_1.SetKeyvalue( "$i_a_unlock", 138 );
				}
			}
		}
	}
	
	g_Scheduler.SetTimeout( "beatthis_check", 0.1 );
}

void stadium4_check()
{
	if ( szMap != 'stadium4' )
		return;
	
	CBaseEntity@ pCheck1_1 = g_EntityFuncs.FindEntityByTargetname( null, "sys_adata" );
	if ( pCheck1_1 is null )
		return;
	
	CustomKeyvalues@ pCheck1_2 = pCheck1_1.GetCustomKeyvalues();
	CustomKeyvalue iKills_pre( pCheck1_2.GetKeyvalue( "$i_kills" ) );
	int iKills = iKills_pre.GetInteger();
	if ( iKills >= 400 )
	{
		for ( int i = 1; i <= g_Engine.maxClients; i++ )
		{
			CBasePlayer@ pPlayer = g_PlayerFuncs.FindPlayerByIndex( i );
			
			if ( pPlayer !is null && pPlayer.IsConnected() )
			{
				// To prevent abuse, player must have at least this much score
				if ( pPlayer.pev.frags >= 400.0 )
				{
					// Get!
					CustomKeyvalues@ pUnlock = pPlayer.GetCustomKeyvalues();
					pUnlock.SetKeyvalue( "$i_a_unlock", 139 );
				}
			}
		}
		
		// Reset
		pCheck1_2.SetKeyvalue( "$i_kills", 0 );
	}
	
	g_Scheduler.SetTimeout( "stadium4_check", 0.1 );
}

void sectore_3_check()
{
	if ( szMap != 'sectore_3' )
		return;
	
	CBaseEntity@ pCheck1_1 = g_EntityFuncs.FindEntityByTargetname( null, "sys_adata" );
	if ( pCheck1_1 is null )
		return;
	
	CustomKeyvalues@ pCheck1_2 = pCheck1_1.GetCustomKeyvalues();
	CustomKeyvalue iCheck_pre( pCheck1_2.GetKeyvalue( "$i_test" ) );
	int iCheck = iCheck_pre.GetInteger();
	if ( iCheck == 1 )
	{
		for ( int i = 1; i <= g_Engine.maxClients; i++ )
		{
			CBasePlayer@ pPlayer = g_PlayerFuncs.FindPlayerByIndex( i );
			
			if ( pPlayer !is null && pPlayer.IsConnected() )
			{
				// This score is BRUTAL! But it's on purpose because this level is the only DEFINE on the achievement
				// To prevent abuse, player must have at least this much score
				if ( pPlayer.pev.frags >= 105.0 ) // This is 15% of THIRD map's max score
				{
					// Get!
					CustomKeyvalues@ pUnlock = pPlayer.GetCustomKeyvalues();
					pUnlock.SetKeyvalue( "$i_a_unlock", 142 );
				}
			}
		}
		
		return;
	}
	
	g_Scheduler.SetTimeout( "sectore_3_check", 0.1 );
}

void alamo1_check()
{
	if ( szMap != 'alamo1' )
		return;
	
	CBaseEntity@ pCheck1_1 = g_EntityFuncs.FindEntityByTargetname( null, "sys_adata" );
	if ( pCheck1_1 is null )
		return;
	
	CustomKeyvalues@ pCheck1_2 = pCheck1_1.GetCustomKeyvalues();
	CustomKeyvalue iCheck_pre( pCheck1_2.GetKeyvalue( "$i_test" ) );
	int iCheck = iCheck_pre.GetInteger();
	if ( iCheck == 1 )
	{
		for ( int i = 1; i <= g_Engine.maxClients; i++ )
		{
			CBasePlayer@ pPlayer = g_PlayerFuncs.FindPlayerByIndex( i );
			
			if ( pPlayer !is null && pPlayer.IsConnected() )
			{
				// Check whenever the player has no deaths
				if ( pPlayer.m_iDeaths == 0 )
				{
					// Handicap enabled?
					CustomKeyvalues@ pCheck3 = pPlayer.GetCustomKeyvalues();
					
					CustomKeyvalue iHandicap10_pre( pCheck3.GetKeyvalue( "$i_handicap10" ) );
					int iHandicap10 = iHandicap10_pre.GetInteger();
					if ( iHandicap10 == 1 )
					{
						// To prevent abuse, player must have at least this much score
						if ( pPlayer.pev.frags >= 40.0 ) // !!! XPGAIN TOO HIGH !!! - This is 40% of map's max score
						{
							// Get!
							CustomKeyvalues@ pUnlock = pPlayer.GetCustomKeyvalues();
							pUnlock.SetKeyvalue( "$i_a_unlock", 144 );
						}
					}
				}
			}
		}
		
		return;
	}
	
	g_Scheduler.SetTimeout( "alamo1_check", 0.1 );
}

void lmsbath_check()
{
	if ( szMap != 'lmsbath' )
		return;
	
	CBaseEntity@ pCheck1_1 = g_EntityFuncs.FindEntityByTargetname( null, "sys_adata" );
	if ( pCheck1_1 is null )
		return;
	
	CustomKeyvalues@ pCheck1_2 = pCheck1_1.GetCustomKeyvalues();
	CustomKeyvalue iRound_pre( pCheck1_2.GetKeyvalue( "$i_rounds" ) );
	int iRound = iRound_pre.GetInteger();
	if ( iRound < 11 ) // Exclude first round for it may trigger before a player can even join (Map just started)
	{
		for ( int i = 1; i <= g_Engine.maxClients; i++ )
		{
			CBasePlayer@ pPlayer = g_PlayerFuncs.FindPlayerByIndex( i );
			
			if ( pPlayer !is null && pPlayer.IsConnected() )
			{
				// Score goal?
				if ( pPlayer.pev.frags >= 100.0 )
				{
					// Get!
					CustomKeyvalues@ pUnlock = pPlayer.GetCustomKeyvalues();
					pUnlock.SetKeyvalue( "$i_a_unlock", 145 );
				}
			}
		}
	}
	else
		return;
	
	g_Scheduler.SetTimeout( "lmsbath_check", 0.1 );
}

void build_check()
{
	if ( szMap != 'build' )
		return;
	
	for ( int i = 1; i <= g_Engine.maxClients; i++ )
	{
		CBasePlayer@ pPlayer = g_PlayerFuncs.FindPlayerByIndex( i );
		
		if ( pPlayer !is null && pPlayer.IsConnected() )
		{
			if ( pPlayer.pev.origin.z >= -550.0 )
			{
				// Must be on firm ground
				if ( pPlayer.pev.FlagBitSet( FL_ONGROUND ) )
				{
					// Get!
					CustomKeyvalues@ pUnlock = pPlayer.GetCustomKeyvalues();
					pUnlock.SetKeyvalue( "$i_a_unlock", 148 );
				}
			}
		}
	}
	
	// Don't flood
	g_Scheduler.SetTimeout( "build_check", 1.1 );
}

void thevoid_check()
{
	if ( szMap != 'thevoid' )
		return;
	
	for ( int i = 1; i <= g_Engine.maxClients; i++ )
	{
		CBasePlayer@ pPlayer = g_PlayerFuncs.FindPlayerByIndex( i );
		
		if ( pPlayer !is null && pPlayer.IsConnected() )
		{
			if ( pPlayer.pev.targetname != 'usedteleport' )
			{
				CustomKeyvalues@ pCheck = pPlayer.GetCustomKeyvalues();
				CustomKeyvalue iZone1_pre( pCheck.GetKeyvalue( "$i_z1_reach" ) );
				CustomKeyvalue iZone2_pre( pCheck.GetKeyvalue( "$i_z2_reach" ) );
				CustomKeyvalue iZone3_pre( pCheck.GetKeyvalue( "$i_z3_reach" ) );
				CustomKeyvalue iZone4_pre( pCheck.GetKeyvalue( "$i_z4_reach" ) );
				CustomKeyvalue iZone5_pre( pCheck.GetKeyvalue( "$i_end_reach" ) );
				int iZone1 = iZone1_pre.GetInteger();
				int iZone2 = iZone2_pre.GetInteger();
				int iZone3 = iZone3_pre.GetInteger();
				int iZone4 = iZone4_pre.GetInteger();
				int iZone5 = iZone5_pre.GetInteger();
				
				// Cleared the map from beginning to end?
				if ( iZone1 == 1 && iZone2 == 1 && iZone3 == 1 && iZone4 == 1 && iZone5 == 1 )
				{
					// Get!
					pCheck.SetKeyvalue( "$i_a_unlock", 149 );
				}
			}
		}
	}
	
	g_Scheduler.SetTimeout( "thevoid_check", 0.1 );
}

void rc_towerdefense_check()
{
	if ( szMap != 'rc_towerdefense' )
		return;
	
	CBaseEntity@ pCheck1_1 = g_EntityFuncs.FindEntityByTargetname( null, "sys_adata" );
	if ( pCheck1_1 is null )
		return;
	
	CustomKeyvalues@ pCheck1_2 = pCheck1_1.GetCustomKeyvalues();
	
	// Once the map started remove these entities to avoid exploitation
	CustomKeyvalue iFailSafe_pre( pCheck1_2.GetKeyvalue( "$i_start" ) );
	int iFailSafe = iFailSafe_pre.GetInteger();
	if ( iFailSafe == 1 )
	{
		CBaseEntity@ pDelete1 = g_EntityFuncs.FindEntityByTargetname( null, "easy3" );
		CBaseEntity@ pDelete2 = g_EntityFuncs.FindEntityByTargetname( null, "normal3" );
		CBaseEntity@ pDelete3 = g_EntityFuncs.FindEntityByTargetname( null, "hard3" );
		CBaseEntity@ pDelete4 = g_EntityFuncs.FindEntityByTargetname( null, "ultrahard3" );
		CBaseEntity@ pDelete5 = g_EntityFuncs.FindEntityByTargetname( null, "impossible3" );
		
		if ( pDelete1 !is null ) g_EntityFuncs.Remove( pDelete1 );
		if ( pDelete2 !is null ) g_EntityFuncs.Remove( pDelete2 );
		if ( pDelete3 !is null ) g_EntityFuncs.Remove( pDelete3 );
		if ( pDelete4 !is null ) g_EntityFuncs.Remove( pDelete4 );
		if ( pDelete5 !is null ) g_EntityFuncs.Remove( pDelete5 );
	}
	
	for ( int i = 1; i <= g_Engine.maxClients; i++ )
	{
		CBasePlayer@ pPlayer = g_PlayerFuncs.FindPlayerByIndex( i );
		
		if ( pPlayer !is null && pPlayer.IsConnected() )
		{
			CustomKeyvalues@ pCheck2_1 = pPlayer.GetCustomKeyvalues();
			CustomKeyvalue vecLastMove_pre( pCheck2_1.GetKeyvalue( "$v_last_move" ) );
			if ( vecLastMove_pre.Exists() )
			{
				Vector vecLastMove = vecLastMove_pre.GetVector();
				
				// Add distance traveled
				CustomKeyvalue iDistance_pre( pCheck2_1.GetKeyvalue( "$i_distance" ) );
				int iDistance = iDistance_pre.GetInteger();
				pCheck2_1.SetKeyvalue( "$i_distance", ( iDistance + ( vecLastMove - pPlayer.pev.origin ).Length() ) );
				
				pCheck2_1.SetKeyvalue( "$v_last_move", pPlayer.pev.origin );
			}
			else
			{
				pCheck2_1.SetKeyvalue( "$v_last_move", pPlayer.pev.origin );
			}
			
			CustomKeyvalue iCheck_pre( pCheck1_2.GetKeyvalue( "$i_test" ) );
			int iCheck = iCheck_pre.GetInteger();
			if ( iCheck == 1 )
			{
				// Enough travel distance?
				CustomKeyvalue iDistance_pre( pCheck2_1.GetKeyvalue( "$i_distance" ) );
				int iDistance = iDistance_pre.GetInteger();
				if ( iDistance >= 51200 )
				{
					// Ultra Hard diff or greater?
					CustomKeyvalue iDifficulty_pre( pCheck1_2.GetKeyvalue( "$i_difficulty" ) );
					int iDifficulty = iDifficulty_pre.GetInteger();
					if ( iDifficulty >= 4 )
					{
						// GET! On a later time...
						g_Scheduler.SetTimeout( "a154_unlock", 1.50, pPlayer.entindex() );
					}
					
					// Get!
					pCheck2_1.SetKeyvalue( "$i_a_unlock", 151 );
				}
			}
		}
	}
	
	g_Scheduler.SetTimeout( "rc_towerdefense_check", 0.1 );
}
void a154_unlock( const int& in index )
{
	CBasePlayer@ pPlayer = g_PlayerFuncs.FindPlayerByIndex( index );
	if ( pPlayer !is null && pPlayer.IsConnected() )
	{
		CustomKeyvalues@ pUnlock = pPlayer.GetCustomKeyvalues();
		pUnlock.SetKeyvalue( "$i_a_unlock", 155 );
	}
}

void beachxp_isc_check()
{
	if ( szMap != 'beachxp_isc' )
		return;
	
	CBaseEntity@ pCheck1_1 = g_EntityFuncs.FindEntityByTargetname( null, "sys_adata" );
	if ( pCheck1_1 is null )
		return;
	
	CustomKeyvalues@ pCheck1_2 = pCheck1_1.GetCustomKeyvalues();
	CustomKeyvalue iCheck_pre( pCheck1_2.GetKeyvalue( "$i_test" ) );
	int iCheck = iCheck_pre.GetInteger();
	if ( iCheck == 1 )
	{
		for ( int i = 1; i <= g_Engine.maxClients; i++ )
		{
			CBasePlayer@ pPlayer = g_PlayerFuncs.FindPlayerByIndex( i );
			
			if ( pPlayer !is null && pPlayer.IsConnected() )
			{
				// Under 8 deaths?
				if ( pPlayer.m_iDeaths < 8 )
				{
					// To prevent abuse, player must have at least this much score
					if ( pPlayer.pev.frags >= 40.0 ) // This is 20% of map's max score
					{
						// Get!
						CustomKeyvalues@ pUnlock = pPlayer.GetCustomKeyvalues();
						pUnlock.SetKeyvalue( "$i_a_unlock", 152 );
					}
				}
			}
		}
		
		return;
	}
	
	g_Scheduler.SetTimeout( "beachxp_isc_check", 0.1 );
}

void dccoop1_check()
{
	if ( szMap != 'dccoop1' )
		return;
	
	CBaseEntity@ pCheck1_1 = g_EntityFuncs.FindEntityByTargetname( null, "sys_adata" );
	if ( pCheck1_1 is null )
		return;
	
	// Interferance!
	for ( int i = 1; i <= g_Engine.maxClients; i++ )
	{
		CBasePlayer@ pPlayer = g_PlayerFuncs.FindPlayerByIndex( i );
		
		if ( pPlayer !is null && pPlayer.IsConnected() )
		{
			Vector vecOrigin1 = pPlayer.pev.origin;
			Vector vecOrigin2 = pCheck1_1.pev.origin;
			
			// Are we at the end?
			if ( ( vecOrigin1 - vecOrigin2 ).Length() <= 80.0 )
			{
				// Are we alive?
				if ( pPlayer.IsAlive() )
				{
					// Under 20 deaths?
					if ( pPlayer.m_iDeaths < 20 )
					{
						// To prevent abuse, player must have at least this much score
						if ( pPlayer.pev.frags >= 124.0 ) // This is 4% of map's max score (XPGain is too low!)
						{
							// Get!
							CustomKeyvalues@ pUnlock = pPlayer.GetCustomKeyvalues();
							pUnlock.SetKeyvalue( "$i_a_unlock", 153 );
						}
					}
				}
			}
		}
	}
	
	g_Scheduler.SetTimeout( "dccoop1_check", 0.1 );
}

void tox_slug1_check()
{
	if ( szMap != 'tox_slug1' )
		return;
	
	CBaseEntity@ pCheck1_1 = g_EntityFuncs.FindEntityByTargetname( null, "sys_adata" );
	if ( pCheck1_1 is null )
		return;
	
	// 60 second tolerance before timer starts
	if ( pCheck1_1.pev.iuser4 >= 600 )
	{
		// Timer started, finished in less than 20 minutes?
		if ( pCheck1_1.pev.iuser3 <= 24000 ) // Map is loaded twice: timer runs twice as fast. So add additional 20 minutes
		{
			CustomKeyvalues@ pCheck1_2 = pCheck1_1.GetCustomKeyvalues();
			CustomKeyvalue iCheck_pre( pCheck1_2.GetKeyvalue( "$i_test" ) );
			int iCheck = iCheck_pre.GetInteger();
			if ( iCheck == 1 )
			{
				for ( int i = 1; i <= g_Engine.maxClients; i++ )
				{
					CBasePlayer@ pPlayer = g_PlayerFuncs.FindPlayerByIndex( i );
					
					if ( pPlayer !is null && pPlayer.IsConnected() )
					{
						// Handicap enabled?
						CustomKeyvalues@ pCheck3 = pPlayer.GetCustomKeyvalues();
						
						CustomKeyvalue iHandicap13_pre( pCheck3.GetKeyvalue( "$i_handicap13" ) );
						int iHandicap13 = iHandicap13_pre.GetInteger();
						if ( iHandicap13 == 1 )
						{
							// To prevent abuse, player must have at least this much score
							if ( pPlayer.pev.frags >= 100.0 ) // This is 8% of map's max score
							{
								// Get!
								CustomKeyvalues@ pUnlock = pPlayer.GetCustomKeyvalues();
								pUnlock.SetKeyvalue( "$i_a_unlock", 154 );
							}
						}
					}
				}
				
				return;
			}
		}
		
		pCheck1_1.pev.iuser3 = pCheck1_1.pev.iuser3 + 1;
	}
	else
		pCheck1_1.pev.iuser4 = pCheck1_1.pev.iuser4 + 1;
	
	g_Scheduler.SetTimeout( "tox_slug1_check", 0.1 );
}

void toonrun3_check()
{
	if ( szMap != 'toonrun3' )
		return;
	
	CBaseEntity@ pCheck1_1 = g_EntityFuncs.FindEntityByTargetname( null, "sys_adata" );
	if ( pCheck1_1 is null )
		return;
	
	CustomKeyvalues@ pCheck1_2 = pCheck1_1.GetCustomKeyvalues();
	CustomKeyvalue iCheck_pre( pCheck1_2.GetKeyvalue( "$i_test" ) );
	int iCheck = iCheck_pre.GetInteger();
	if ( iCheck == 1 )
	{
		CustomKeyvalue iFail_pre( pCheck1_2.GetKeyvalue( "$i_fail" ) );
		int iFail = iFail_pre.GetInteger();
		if ( iFail == 0 ) // No scientist killed?
		{
			for ( int i = 1; i <= g_Engine.maxClients; i++ )
			{
				CBasePlayer@ pPlayer = g_PlayerFuncs.FindPlayerByIndex( i );
				
				if ( pPlayer !is null && pPlayer.IsConnected() )
				{
					// Get!
					CustomKeyvalues@ pUnlock = pPlayer.GetCustomKeyvalues();
					pUnlock.SetKeyvalue( "$i_a_unlock", 157 );
				}
			}
		}
		
		return;
	}
	
	g_Scheduler.SetTimeout( "toonrun3_check", 0.1 );
}

void extension_check()
{
	if ( szMap != 'extension' )
		return;
	
	CBaseEntity@ pCheck1_1 = g_EntityFuncs.FindEntityByTargetname( null, "sys_adata" );
	if ( pCheck1_1 is null )
		return;
	
	CustomKeyvalues@ pCheck1_2 = pCheck1_1.GetCustomKeyvalues();
	CustomKeyvalue iCheck_pre( pCheck1_2.GetKeyvalue( "$i_test" ) );
	int iCheck = iCheck_pre.GetInteger();
	if ( iCheck == 1 )
	{
		for ( int i = 1; i <= g_Engine.maxClients; i++ )
		{
			CBasePlayer@ pPlayer = g_PlayerFuncs.FindPlayerByIndex( i );
			
			if ( pPlayer !is null && pPlayer.IsConnected() )
			{
				// Still alive?
				if ( pPlayer.IsAlive() )
				{
					// To prevent abuse, player must have at least this much score
					if ( pPlayer.pev.frags >= 40.0 ) // This is 10% of map's max score
					{
						// Get!
						CustomKeyvalues@ pUnlock = pPlayer.GetCustomKeyvalues();
						pUnlock.SetKeyvalue( "$i_a_unlock", 158 );
					}
				}
			}
		}
		
		return;
	}
	
	g_Scheduler.SetTimeout( "extension_check", 0.1 );
}

void warzone_1_15_check()
{
	if ( szMap != 'warzone01' && szMap != 'warzone02' && szMap != 'warzone03' && szMap != 'warzone04' && szMap != 'warzone05' && szMap != 'warzone06' && szMap != 'warzone07' && szMap != 'warzone08' && szMap != 'warzone09' && szMap != 'warzone10' && szMap != 'warzone11' && szMap != 'warzone12' && szMap != 'warzone13' && szMap != 'warzone14' && szMap != 'warzone15' )
		return;
	
	// Update death info
	string szPath = "scripts/plugins/temp/" + szMap + ".lst";
	File@ thefile = g_FileSystem.OpenFile( szPath, OpenFile::WRITE );
	
	if ( thefile !is null && thefile.IsOpen() )
	{
		for ( int i = 1; i <= g_Engine.maxClients; i++ )
		{
			CBasePlayer@ pPlayer = g_PlayerFuncs.FindPlayerByIndex( i );
			
			if ( pPlayer !is null && pPlayer.IsConnected() )
			{
				CBaseEntity@ pCheck1_1 = g_EntityFuncs.FindEntityByTargetname( null, "sys_adata" );
				if ( pCheck1_1 is null )
				{
					// Try again
					g_Scheduler.SetTimeout( "warzone_1_15_check", 1.0 );
					return;
				}
				
				CustomKeyvalues@ pCheck1_2 = pCheck1_1.GetCustomKeyvalues();
				string szPlayer = g_EngineFuncs.GetPlayerAuthId( pPlayer.edict() );
				szPlayer.Replace( ':', '_' );
				CustomKeyvalue iPlayerFail( pCheck1_2.GetKeyvalue( "$i_" + szPlayer ) );
				
				// Don't cheat: Don't reset the status if already failed
				if ( !iPlayerFail.Exists() )
				{
					// No deaths?
					if ( pPlayer.m_iDeaths == 0 )
						thefile.Write( "" + g_EngineFuncs.GetPlayerAuthId( pPlayer.edict() ) + "#PASS\n" );
					else
					{
						thefile.Write( "" + g_EngineFuncs.GetPlayerAuthId( pPlayer.edict() ) + "#FAIL\n" );
						pCheck1_2.SetKeyvalue( "$i_" + szPlayer, 1 );
					}
				}
				else
					thefile.Write( "" + g_EngineFuncs.GetPlayerAuthId( pPlayer.edict() ) + "#FAIL\n" );
			}
		}
		
		thefile.Close();
	}
	
	g_Scheduler.SetTimeout( "warzone_1_15_check", 1.0 );
}

void warzone_15_check()
{
	if ( szMap != 'warzone15' )
		return;
	
	CBaseEntity@ pCheck1_1 = g_EntityFuncs.FindEntityByTargetname( null, "sys_adata" );
	if ( pCheck1_1 is null )
		return;
	
	CustomKeyvalues@ pCheck1_2 = pCheck1_1.GetCustomKeyvalues();
	CustomKeyvalue iCheck_pre( pCheck1_2.GetKeyvalue( "$i_test" ) );
	int iCheck = iCheck_pre.GetInteger();
	if ( iCheck == 1 )
	{
		for ( int i = 1; i <= g_Engine.maxClients; i++ )
		{
			int iTimes = 0;
			CBasePlayer@ pPlayer = g_PlayerFuncs.FindPlayerByIndex( i );
			
			if ( pPlayer !is null && pPlayer.IsConnected() )
			{
				// Check if the player passed previous levels
				for ( int iMap = 1; iMap <= 15; iMap++ )
				{
					string szPath;
					if ( iMap < 10 ) szPath = "scripts/plugins/temp/warzone0" + iMap + ".lst";
					else szPath = "scripts/plugins/temp/warzone" + iMap + ".lst";
					
					File@ altfile = g_FileSystem.OpenFile( szPath, OpenFile::READ );
					if ( altfile !is null && altfile.IsOpen() )
					{
						string szPlayer;
						while ( !altfile.EOFReached() )
						{
							altfile.ReadLine( szPlayer );
							szPlayer.Replace( '#', ' ' );
							array< string >@ pre_data = szPlayer.Split( ' ' );
							if ( pre_data[ 0 ] == g_EngineFuncs.GetPlayerAuthId( pPlayer.edict() ) )
							{
								if ( pre_data[ 1 ] == 'PASS' )
								{
									iTimes++;
									break;
								}
							}
						}
						altfile.Close();
					}
				}
				
				if ( iTimes == 15 )
				{
					// EVIL SCORE REQUIREMENT
					if ( pPlayer.pev.frags >= 13.0 ) // This is 20% of 15th map's max score
					{
						// Get!
						CustomKeyvalues@ pUnlock = pPlayer.GetCustomKeyvalues();
						pUnlock.SetKeyvalue( "$i_a_unlock", 159 );
					}
				}
			}
		}
		
		return;
	}
	
	g_Scheduler.SetTimeout( "warzone_15_check", 0.1 );
}

void disco_boss_check()
{
	if ( szMap != 'disco_boss' )
		return;
	
	CBaseEntity@ pCheck1_1 = g_EntityFuncs.FindEntityByTargetname( null, "sys_adata" );
	if ( pCheck1_1 is null )
		return;
	
	CustomKeyvalues@ pCheck1_2 = pCheck1_1.GetCustomKeyvalues();
	CustomKeyvalue iCheck_pre( pCheck1_2.GetKeyvalue( "$i_test" ) );
	int iCheck = iCheck_pre.GetInteger();
	if ( iCheck == 1 )
	{
		for ( int i = 1; i <= g_Engine.maxClients; i++ )
		{
			CBasePlayer@ pPlayer = g_PlayerFuncs.FindPlayerByIndex( i );
			
			if ( pPlayer !is null && pPlayer.IsConnected() )
			{
				// Under 3 deaths?
				if ( pPlayer.m_iDeaths < 3 )
				{
					// To prevent abuse, player must have at least this much score
					if ( pPlayer.pev.frags >= 30.0 ) // XPGain is set at 100%. Ambiguous score requirement
					{
						// Get!
						CustomKeyvalues@ pUnlock = pPlayer.GetCustomKeyvalues();
						pUnlock.SetKeyvalue( "$i_a_unlock", 160 );
					}
				}
			}
		}
		
		return;
	}
	
	g_Scheduler.SetTimeout( "disco_boss_check", 0.1 );
}

void the_climb3_check()
{
	if ( szMap != 'the-climb3' )
		return;
	
	CBaseEntity@ pCheck1_1 = g_EntityFuncs.FindEntityByTargetname( null, "sys_adata" );
	if ( pCheck1_1 is null )
		return;
	
	for ( int i = 1; i <= g_Engine.maxClients; i++ )
	{
		CBasePlayer@ pPlayer = g_PlayerFuncs.FindPlayerByIndex( i );
		
		if ( pPlayer !is null && pPlayer.IsConnected() )
		{
			// Prevent /spectate exploit
			if ( pPlayer.IsAlive() )
			{
				Vector vecOrigin1 = pPlayer.pev.origin;
				Vector vecOrigin2 = pCheck1_1.pev.origin;
				
				// Finished?
				if ( ( vecOrigin1 - vecOrigin2 ).Length() <= 64.0 )
				{
					if ( pPlayer.pev.targetname != 'finished' )
					{
						// Get!
						pPlayer.pev.targetname = "finished";
						
						CustomKeyvalues@ pUnlock = pPlayer.GetCustomKeyvalues();
						pUnlock.SetKeyvalue( "$i_kz_clear", 1 );
						pUnlock.SetKeyvalue( "$i_a_unlock", 161 );
						
						// Notification (If criteria met)
						CustomKeyvalue iCheck_pre( pUnlock.GetKeyvalue( "$i_kz_cp" ) );
						int iCheck = iCheck_pre.GetInteger();
						if ( iCheck <= 150 )
						{
							HUDTextParams textParams;
							textParams.x = -1;
							textParams.y = 0.7;
							textParams.effect = 2;
							textParams.r1 = 250;
							textParams.g1 = 125;
							textParams.b1 = 75;
							textParams.a1 = 250;
							textParams.r2 = 250;
							textParams.g2 = 250;
							textParams.b2 = 250;
							textParams.a2 = 0;
							textParams.fadeinTime = 0.04;
							textParams.fadeoutTime = 0.70;
							textParams.holdTime = 2.5;
							textParams.fxTime = 0.30;
							textParams.channel = 2;
							g_PlayerFuncs.HudMessage( pPlayer, textParams, "Lo lograste!\n\nSi ya has conseguido el logro antes ahora puedes redimir su recompensa!" );
						}
					}
				}
			}
		}
	}
	
	g_Scheduler.SetTimeout( "the_climb3_check", 0.1 );
}

void q1_e1m4_check()
{
	if ( szMap != 'q1_e1m4' )
		return;
	
	CBaseEntity@ pCheck1_1 = g_EntityFuncs.FindEntityByTargetname( null, "sys_adata" );
	if ( pCheck1_1 is null )
		return;
	
	for ( int i = 1; i <= g_Engine.maxClients; i++ )
	{
		CBasePlayer@ pPlayer = g_PlayerFuncs.FindPlayerByIndex( i );
		
		if ( pPlayer !is null && pPlayer.IsConnected() )
		{
			Vector vecOrigin1 = pPlayer.pev.origin;
			Vector vecOrigin2 = pCheck1_1.pev.origin;
			
			// Prevent /spectate exploit
			if ( pPlayer.IsAlive() )
			{
				// Are we in our secret?
				if ( ( vecOrigin1 - vecOrigin2 ).Length() <= 80.0 )
				{
					// Get!
					CustomKeyvalues@ pUnlock = pPlayer.GetCustomKeyvalues();
					pUnlock.SetKeyvalue( "$i_a_unlock", 162 );
				}
			}
		}
	}
	
	g_Scheduler.SetTimeout( "q1_e1m4_check", 0.1 );
}

void trials_v1_check()
{
	if ( szMap != 'trials_v1' )
		return;
	
	CBaseEntity@ pCheck1_1 = g_EntityFuncs.FindEntityByTargetname( null, "sys_adata" );
	if ( pCheck1_1 is null )
		return;
	
	CustomKeyvalues@ pCheck1_2 = pCheck1_1.GetCustomKeyvalues();
	for ( int i = 1; i <= g_Engine.maxClients; i++ )
	{
		CBasePlayer@ pPlayer = g_PlayerFuncs.FindPlayerByIndex( i );
		
		if ( pPlayer !is null && pPlayer.IsConnected() )
		{
			CustomKeyvalues@ pCheck2_1 = pPlayer.GetCustomKeyvalues();
			CustomKeyvalue vecLastMove_pre( pCheck2_1.GetKeyvalue( "$v_last_move" ) );
			if ( vecLastMove_pre.Exists() )
			{
				Vector vecLastMove = vecLastMove_pre.GetVector();
				
				// Add distance traveled
				CustomKeyvalue iDistance_pre( pCheck2_1.GetKeyvalue( "$i_distance" ) );
				int iDistance = iDistance_pre.GetInteger();
				pCheck2_1.SetKeyvalue( "$i_distance", ( iDistance + ( vecLastMove - pPlayer.pev.origin ).Length() ) );
				
				pCheck2_1.SetKeyvalue( "$v_last_move", pPlayer.pev.origin );
			}
			else
			{
				pCheck2_1.SetKeyvalue( "$v_last_move", pPlayer.pev.origin );
			}
			
			CustomKeyvalue iCheck_pre( pCheck1_2.GetKeyvalue( "$i_test" ) );
			int iCheck = iCheck_pre.GetInteger();
			if ( iCheck == 1 )
			{
				// Enough travel distance?
				CustomKeyvalue iDistance_pre( pCheck2_1.GetKeyvalue( "$i_distance" ) );
				int iDistance = iDistance_pre.GetInteger();
				if ( iDistance >= 20480 )
				{
					// Get!
					pCheck2_1.SetKeyvalue( "$i_a_unlock", 164 );
				}
			}
		}
	}
	
	g_Scheduler.SetTimeout( "trials_v1_check", 0.1 );
}

void suspension_check()
{
	if ( szMap != 'suspension' )
		return;
	
	CBaseEntity@ pCheck1_1 = g_EntityFuncs.FindEntityByTargetname( null, "sys_adata" );
	if ( pCheck1_1 is null )
		return;
	
	CustomKeyvalues@ pCheck1_2 = pCheck1_1.GetCustomKeyvalues();
	CustomKeyvalue iCheck_pre( pCheck1_2.GetKeyvalue( "$i_test" ) );
	int iCheck = iCheck_pre.GetInteger();
	if ( iCheck == 1 )
	{
		for ( int i = 1; i <= g_Engine.maxClients; i++ )
		{
			CBasePlayer@ pPlayer = g_PlayerFuncs.FindPlayerByIndex( i );
			
			if ( pPlayer !is null && pPlayer.IsConnected() )
			{
				// To prevent abuse, player must have at least this much score
				if ( pPlayer.pev.frags >= 30.0 ) // Will depend...
				{
					// Insane difficulty?
					CustomKeyvalue iDifficulty_pre( pCheck1_2.GetKeyvalue( "$i_difficulty" ) );
					int iDifficulty = iDifficulty_pre.GetInteger();
					if ( iDifficulty >= 3 )
					{
						// GET! On a later time...
						g_Scheduler.SetTimeout( "a166_unlock", 1.50, pPlayer.entindex() );
					}
					else if ( iDifficulty >= 1 ) // Normal or higher?
					{
						// Get!
						CustomKeyvalues@ pUnlock = pPlayer.GetCustomKeyvalues();
						pUnlock.SetKeyvalue( "$i_a_unlock", 166 );
					}
				}
			}
		}
		
		return;
	}
	
	g_Scheduler.SetTimeout( "suspension_check", 0.1 );
}
void a166_unlock( const int& in index )
{
	CBasePlayer@ pPlayer = g_PlayerFuncs.FindPlayerByIndex( index );
	if ( pPlayer !is null && pPlayer.IsConnected() )
	{
		CustomKeyvalues@ pUnlock = pPlayer.GetCustomKeyvalues();
		pUnlock.SetKeyvalue( "$i_a_unlock", 167 );
	}
}

// -------
// STOCKS
// -------

/* Get origin of a brush entity */
void get_brush_entity_origin( CBaseEntity@ pEntity, Vector& out vecOrigin )
{
	vecOrigin = pEntity.pev.origin;
	Vector Min = pEntity.pev.mins;
	Vector Max = pEntity.pev.maxs;
	
	vecOrigin.x += ( Min.x + Max.x ) * 0.5;
	vecOrigin.y += ( Min.y + Max.y ) * 0.5;
	vecOrigin.z += ( Min.z + Max.z ) * 0.5;
}
