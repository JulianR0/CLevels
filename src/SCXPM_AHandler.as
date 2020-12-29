/*
	Imperium Sven Co-op's SCXPM: Achievements Handler
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

string szMap;
CScheduledFunction@ g_SCTimer_1;
CScheduledFunction@ g_SCTimer_2; // In case an achievement needs two functions to be run at the same time

void PluginInit()
{
	g_Module.ScriptInfo.SetAuthor( "Julian \"Giegue\" Rodriguez" );
	g_Module.ScriptInfo.SetContactInfo( "www.steamcommunity.com/id/ngiegue" );
	
	// General achievements
	g_Scheduler.SetInterval( "a01_check", 0.20, g_Scheduler.REPEAT_INFINITE_TIMES );
	g_Scheduler.SetInterval( "a25_check", 0.20, g_Scheduler.REPEAT_INFINITE_TIMES );
	
	// Helper for AMXX
	g_Scheduler.SetInterval( "rexp_helper", 0.40, g_Scheduler.REPEAT_INFINITE_TIMES );
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

// General achievements
void a01_check()
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
			CustomKeyvalue iHandicap14_pre( pCheck3.GetKeyvalue( "$i_handicap14" ) );
			
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
			int iHandicap12 = iHandicap12_pre.GetInteger();
			int iHandicap13 = iHandicap13_pre.GetInteger();
			int iHandicap14 = iHandicap14_pre.GetInteger();
			
			if ( iHandicap01 == 1 && iHandicap02 == 1 && iHandicap03 == 1 && iHandicap04 == 1 && iHandicap05 == 1 && iHandicap06 == 1 && iHandicap07 == 1 && iHandicap08 == 1 && iHandicap09 == 1 && iHandicap10 == 1 && iHandicap11 == 1 && iHandicap12 == 1 && iHandicap13 == 1 && iHandicap14 == 1 )
			{
				// To prevent abuse, player must have at least this much score
				if ( pPlayer.pev.frags >= 70.0 ) // This is just a generic score, as it may vary according to map
				{
					// Get!
					
					// On a later time, another achievement might need saving
					g_Scheduler.SetTimeout( "a01_unlock", 2.5, pPlayer.entindex() );
				}
			}
		}
	}
}
void a01_unlock( const int& in index )
{
	CBasePlayer@ pPlayer = g_PlayerFuncs.FindPlayerByIndex( index );
	if ( pPlayer !is null )
	{
		CustomKeyvalues@ pUnlock = pPlayer.GetCustomKeyvalues();
		pUnlock.SetKeyvalue( "$i_a_unlock", 2 );
	}
}

void a25_check()
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
				// Check if we are standing on something
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
									pCheck.SetKeyvalue( "$i_a_unlock", 26 );
									
									// Reset...
									pCheck.SetKeyvalue( "$f_a_holdtime", g_Engine.time );
									pCheck.SetKeyvalue( "$f_a_goaltime", g_Engine.time + 20.0 );
								}
							}
							else
							{
								// Different voltigore
								@pPlayer.pev.euser4 = pPlayer.pev.groundentity;
								
								// Reset timer
								pCheck.SetKeyvalue( "$f_a_holdtime", g_Engine.time );
								pCheck.SetKeyvalue( "$f_a_goaltime", g_Engine.time + 20.0 );
							}
						}
						else
						{
							// Not alive, reset timer
							pCheck.SetKeyvalue( "$f_a_holdtime", 0.0 );
							pCheck.SetKeyvalue( "$f_a_goaltime", g_Engine.time + 20.0 );
						}
					}
					else
					{
						// Standing on something else, reset timer
						pCheck.SetKeyvalue( "$f_a_holdtime", 0.0 );
						pCheck.SetKeyvalue( "$f_a_goaltime", g_Engine.time + 20.0 );
					}
				}
				else
				{
					// Standing on a NULL entity? This is a fail-safe
					pCheck.SetKeyvalue( "$f_a_holdtime", 0.0 );
					pCheck.SetKeyvalue( "$f_a_goaltime", g_Engine.time + 20.0 );
				}
			}
			else
			{
				// Initialize if keyvalues do not exist
				pCheck.SetKeyvalue( "$f_a_holdtime", 0.0 );
				pCheck.SetKeyvalue( "$f_a_goaltime", g_Engine.time + 20.0 );
			}
		}
	}
}

void MapActivate()
{
	// Map-specific achievements
	szMap = g_Engine.mapname;
	CBaseEntity@ pEntity = null;
	
	// Put the mapname on lowercase to avoid case sensitivity
	szMap.ToLowercase();
	
	// Reset schedulers
	if ( g_SCTimer_1 !is null )
	{
		g_Scheduler.RemoveTimer( g_SCTimer_1 );
		@g_SCTimer_1 = null;
	}
	if ( g_SCTimer_2 !is null )
	{
		g_Scheduler.RemoveTimer( g_SCTimer_2 );
		@g_SCTimer_2 = null;
	}
	
	if ( szMap == 'abandoned' )
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
		
		@g_SCTimer_1 = @g_Scheduler.SetInterval( "abandoned_check", 0.10, g_Scheduler.REPEAT_INFINITE_TIMES );
	}
	else if ( szMap == 'toadsnatch' )
	{
		@pEntity = g_EntityFuncs.Create( "info_target", g_vecZero, g_vecZero, false );
		pEntity.pev.targetname = "sys_adata";
		
		// Difficulty achievements
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
		
		// Weapons achievement
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
		
		@g_SCTimer_1 = @g_Scheduler.SetInterval( "toadsnatch_check", 0.10, g_Scheduler.REPEAT_INFINITE_TIMES );
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
		
		@g_SCTimer_1 = @g_Scheduler.SetInterval( "quarter_check", 0.10, g_Scheduler.REPEAT_INFINITE_TIMES );
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
		
		@g_SCTimer_1 = @g_Scheduler.SetInterval( "sc_persia_check", 0.10, g_Scheduler.REPEAT_INFINITE_TIMES );
	}
	else if ( szMap == 'mommamesa' )
	{
		@pEntity = g_EntityFuncs.Create( "info_target", g_vecZero, g_vecZero, false );
		pEntity.pev.targetname = "sys_adata";
		
		// Nightmare difficulty achievement
		@pEntity = g_EntityFuncs.Create( "trigger_changevalue", g_vecZero, g_vecZero, false );
		pEntity.pev.targetname = "setdifficulty_nightmare";
		pEntity.pev.target = "sys_adata";
		pEntity.KeyValue( "m_iszValueName", "$i_difficulty" );
		pEntity.KeyValue( "m_iszNewValue", "1" );
		pEntity.KeyValue( "m_iszValueType", "0" );
		
		// Map wins
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
		
		// Escape sequence achievement
		@pEntity = g_EntityFuncs.Create( "trigger_changevalue", g_vecZero, g_vecZero, false );
		pEntity.pev.targetname = "endgood_escapeseqmm";
		pEntity.pev.target = "!activator";
		pEntity.KeyValue( "m_iszValueName", "$i_escape" );
		pEntity.KeyValue( "m_iszNewValue", "1" );
		pEntity.KeyValue( "m_iszValueType", "0" );
		
		@g_SCTimer_1 = @g_Scheduler.SetInterval( "mommamesa_check", 0.10, g_Scheduler.REPEAT_INFINITE_TIMES );
	}
	else if ( szMap == 'deadsimpleneo2' )
	{
		@pEntity = g_EntityFuncs.Create( "info_target", g_vecZero, g_vecZero, false );
		pEntity.pev.targetname = "sys_adata";
		
		// One achievement for every gamemode except classic
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
		
		@g_SCTimer_1 = @g_Scheduler.SetInterval( "deadsimpleneo2_check", 0.10, g_Scheduler.REPEAT_INFINITE_TIMES );
	}
	else if ( szMap == 'blackmesaepf' )
	{
		// No info_target entity, only checking button
		
		@pEntity = g_EntityFuncs.Create( "trigger_changevalue", g_vecZero, g_vecZero, false );
		pEntity.pev.targetname = "miss4_pushbutton_mm";
		pEntity.pev.target = "!activator";
		pEntity.KeyValue( "m_iszValueName", "$i_pass" );
		pEntity.KeyValue( "m_iszNewValue", "1" );
		pEntity.KeyValue( "m_iszValueType", "0" );
		
		@g_SCTimer_1 = @g_Scheduler.SetInterval( "BlackMesaEPF_check", 0.10, g_Scheduler.REPEAT_INFINITE_TIMES );
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
		
		@g_SCTimer_1 = @g_Scheduler.SetInterval( "sandstone_check", 0.10, g_Scheduler.REPEAT_INFINITE_TIMES );
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
		
		@g_SCTimer_1 = @g_Scheduler.SetInterval( "jumpers_check", 0.10, g_Scheduler.REPEAT_INFINITE_TIMES );
	}
	else if ( szMap == 'fortified1' )
	{
		@pEntity = g_EntityFuncs.Create( "info_target", g_vecZero, g_vecZero, false );
		pEntity.pev.targetname = "sys_adata";
		
		// Difficulty achievements
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
		
		// Survival mode
		@pEntity = g_EntityFuncs.Create( "trigger_changevalue", g_vecZero, g_vecZero, false );
		pEntity.pev.targetname = "legend_selected";
		pEntity.pev.target = "sys_adata";
		pEntity.KeyValue( "m_iszValueName", "$i_survival" );
		pEntity.KeyValue( "m_iszNewValue", "1" );
		pEntity.KeyValue( "m_iszValueType", "0" );
		
		// Commander resign achievement
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
		
		@g_SCTimer_1 = @g_Scheduler.SetInterval( "fortified1_check", 0.10, g_Scheduler.REPEAT_INFINITE_TIMES );
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
		
		@g_SCTimer_1 = @g_Scheduler.SetInterval( "svencoop2_check", 0.10, g_Scheduler.REPEAT_INFINITE_TIMES );
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
		
		@g_SCTimer_1 = @g_Scheduler.SetInterval( "sc_doc_check", 0.10, g_Scheduler.REPEAT_INFINITE_TIMES );
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
		
		@g_SCTimer_1 = @g_Scheduler.SetInterval( "sc_psyko_check", 0.10, g_Scheduler.REPEAT_INFINITE_TIMES );
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
		
		@pEntity = g_EntityFuncs.Create( "trigger_changevalue", g_vecZero, g_vecZero, false );
		pEntity.pev.targetname = "pe1_text1";
		pEntity.pev.target = "sys_adata";
		pEntity.KeyValue( "m_iszValueName", "$i_objetives" );
		pEntity.KeyValue( "m_iszNewValue", "1" );
		pEntity.KeyValue( "m_iszValueType", "1" );
		
		@pEntity = g_EntityFuncs.Create( "trigger_changevalue", g_vecZero, g_vecZero, false );
		pEntity.pev.targetname = "pe2_text1";
		pEntity.pev.target = "sys_adata";
		pEntity.KeyValue( "m_iszValueName", "$i_objetives" );
		pEntity.KeyValue( "m_iszNewValue", "1" );
		pEntity.KeyValue( "m_iszValueType", "1" );
		
		@pEntity = g_EntityFuncs.Create( "trigger_changevalue", g_vecZero, g_vecZero, false );
		pEntity.pev.targetname = "pe3_text1";
		pEntity.pev.target = "sys_adata";
		pEntity.KeyValue( "m_iszValueName", "$i_objetives" );
		pEntity.KeyValue( "m_iszNewValue", "1" );
		pEntity.KeyValue( "m_iszValueType", "1" );
		
		@pEntity = g_EntityFuncs.Create( "trigger_changevalue", g_vecZero, g_vecZero, false );
		pEntity.pev.targetname = "pe4_text1";
		pEntity.pev.target = "sys_adata";
		pEntity.KeyValue( "m_iszValueName", "$i_objetives" );
		pEntity.KeyValue( "m_iszNewValue", "1" );
		pEntity.KeyValue( "m_iszValueType", "1" );
		
		@pEntity = g_EntityFuncs.Create( "trigger_changevalue", g_vecZero, g_vecZero, false );
		pEntity.pev.targetname = "blueprint_t";
		pEntity.pev.target = "sys_adata";
		pEntity.KeyValue( "m_iszValueName", "$i_objetives" );
		pEntity.KeyValue( "m_iszNewValue", "1" );
		pEntity.KeyValue( "m_iszValueType", "1" );
		
		@pEntity = g_EntityFuncs.Create( "trigger_changevalue", g_vecZero, g_vecZero, false );
		pEntity.pev.targetname = "gen_failure_1_t";
		pEntity.pev.target = "sys_adata";
		pEntity.KeyValue( "m_iszValueName", "$i_objetives" );
		pEntity.KeyValue( "m_iszNewValue", "1" );
		pEntity.KeyValue( "m_iszValueType", "1" );
		
		@pEntity = g_EntityFuncs.Create( "trigger_changevalue", g_vecZero, g_vecZero, false );
		pEntity.pev.targetname = "gen_failure_2_t";
		pEntity.pev.target = "sys_adata";
		pEntity.KeyValue( "m_iszValueName", "$i_objetives" );
		pEntity.KeyValue( "m_iszNewValue", "1" );
		pEntity.KeyValue( "m_iszValueType", "1" );
		
		@pEntity = g_EntityFuncs.Create( "trigger_changevalue", g_vecZero, g_vecZero, false );
		pEntity.pev.targetname = "gen_failure_3_t";
		pEntity.pev.target = "sys_adata";
		pEntity.KeyValue( "m_iszValueName", "$i_objetives" );
		pEntity.KeyValue( "m_iszNewValue", "1" );
		pEntity.KeyValue( "m_iszValueType", "1" );
		
		@pEntity = g_EntityFuncs.Create( "trigger_changevalue", g_vecZero, g_vecZero, false );
		pEntity.pev.targetname = "gen_failure_4_t";
		pEntity.pev.target = "sys_adata";
		pEntity.KeyValue( "m_iszValueName", "$i_objetives" );
		pEntity.KeyValue( "m_iszNewValue", "1" );
		pEntity.KeyValue( "m_iszValueType", "1" );
		
		@g_SCTimer_1 = @g_Scheduler.SetInterval( "turretfortress_check", 0.10, g_Scheduler.REPEAT_INFINITE_TIMES );
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
		
		@g_SCTimer_1 = @g_Scheduler.SetInterval( "tf_original_check", 0.10, g_Scheduler.REPEAT_INFINITE_TIMES );
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
		
		@g_SCTimer_1 = @g_Scheduler.SetInterval( "sc_robination_revised_check", 0.10, g_Scheduler.REPEAT_INFINITE_TIMES );
	}
	else if ( szMap == 'sc_mazing' )
	{
		@pEntity = g_EntityFuncs.Create( "info_target", g_vecZero, g_vecZero, false );
		pEntity.pev.targetname = "sys_adata";
		
		// All pit drones/gargantuas killed
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
		
		// Speedrun achievement
		@pEntity = g_EntityFuncs.Create( "trigger_changevalue", g_vecZero, g_vecZero, false );
		pEntity.pev.targetname = "boss1end_mm";
		pEntity.pev.target = "sys_adata";
		pEntity.KeyValue( "m_iszValueName", "$i_test" );
		pEntity.KeyValue( "m_iszNewValue", "1" );
		pEntity.KeyValue( "m_iszValueType", "0" );
		
		@g_SCTimer_1 = @g_Scheduler.SetInterval( "sc_mazing_check", 0.10, g_Scheduler.REPEAT_INFINITE_TIMES );
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
		
		@g_SCTimer_1 = @g_Scheduler.SetInterval( "sc_tetris1_check", 0.10, g_Scheduler.REPEAT_INFINITE_TIMES );
	}
	else if ( szMap == 'sc_tetris2' || szMap == 'sc_tetris3' || szMap == 'sc_tetris4' || szMap == 'sc_tetris5' )
	{
		// Just get player list
		@g_SCTimer_1 = @g_Scheduler.SetInterval( "sc_tetris2_5_check", 65.10, g_Scheduler.REPEAT_INFINITE_TIMES );
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
		
		@g_SCTimer_1 = @g_Scheduler.SetInterval( "sc_tetris6_check", 0.10, g_Scheduler.REPEAT_INFINITE_TIMES );
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
		
		@g_SCTimer_1 = @g_Scheduler.SetInterval( "toonrun3_check", 0.10, g_Scheduler.REPEAT_INFINITE_TIMES );
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
		
		@g_SCTimer_1 = @g_Scheduler.SetInterval( "suspension_check", 0.10, g_Scheduler.REPEAT_INFINITE_TIMES );
	}
	else if ( szMap == 'judgement' )
	{
		@pEntity = g_EntityFuncs.Create( "info_target", g_vecZero, g_vecZero, false );
		pEntity.pev.targetname = "sys_adata";
		
		@pEntity = g_EntityFuncs.Create( "trigger_changevalue", g_vecZero, g_vecZero, false );
		pEntity.pev.targetname = "1weps_txt";
		pEntity.pev.target = "sys_adata";
		pEntity.KeyValue( "m_iszValueName", "$i_active" );
		pEntity.KeyValue( "m_iszNewValue", "1" );
		pEntity.KeyValue( "m_iszValueType", "0" );
		
		@pEntity = g_EntityFuncs.Create( "trigger_changevalue", g_vecZero, g_vecZero, false );
		pEntity.pev.targetname = "winner_text";
		pEntity.pev.target = "sys_adata";
		pEntity.KeyValue( "m_iszValueName", "$i_test" );
		pEntity.KeyValue( "m_iszNewValue", "1" );
		pEntity.KeyValue( "m_iszValueType", "0" );
		
		@g_SCTimer_1 = @g_Scheduler.SetInterval( "judgement_check", 0.10, g_Scheduler.REPEAT_INFINITE_TIMES );
	}
	else if ( szMap == 'infested' )
	{
		@pEntity = g_EntityFuncs.Create( "info_target", g_vecZero, g_vecZero, false );
		pEntity.pev.targetname = "sys_adata";
		
		@pEntity = g_EntityFuncs.Create( "trigger_changevalue", g_vecZero, g_vecZero, false );
		pEntity.pev.targetname = "snipers1";
		pEntity.pev.target = "sys_adata";
		pEntity.KeyValue( "m_iszValueName", "$i_active" );
		pEntity.KeyValue( "m_iszNewValue", "1" );
		pEntity.KeyValue( "m_iszValueType", "0" );
		
		@g_SCTimer_1 = @g_Scheduler.SetInterval( "infested_check", 0.10, g_Scheduler.REPEAT_INFINITE_TIMES );
	}
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
						if ( pPlayer.pev.frags >= 90.0 )
						{
							// Get!
							CustomKeyvalues@ pUnlock = pPlayer.GetCustomKeyvalues();
							pUnlock.SetKeyvalue( "$i_a_unlock", 1 );
						}
					}
				}
				
				g_EntityFuncs.Remove( pCheck1_1 );
				return;
			}
		}
	}
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
				pUnlock.SetKeyvalue( "$i_a_unlock", 6 );
				
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
				
				if ( iDifficulty >= 3 ) // Extreme
				{
					if ( pPlayer.pev.frags >= 218.0 )
					{
						// Get!
						g_Scheduler.SetTimeout( "a04_unlock", 3.00, pPlayer.entindex() );
					}
				}
				if ( iDifficulty >= 2 ) // Hard or higher
				{
					if ( pPlayer.pev.frags >= 145.0 )
					{
						// Get!
						g_Scheduler.SetTimeout( "a03_unlock", 1.50, pPlayer.entindex() );
					}
				}
				if ( iDifficulty >= 1 ) // Normal or higher
				{
					if ( pPlayer.pev.frags >= 73.0 )
					{
						// Get!
						CustomKeyvalues@ pUnlock = pPlayer.GetCustomKeyvalues();
						pUnlock.SetKeyvalue( "$i_a_unlock", 3 );
					}
				}
			}
		}
		
		g_EntityFuncs.Remove( pCheck1_1 );
		return;
	}
}
void a03_unlock( const int& in index )
{
	CBasePlayer@ pPlayer = g_PlayerFuncs.FindPlayerByIndex( index );
	if ( pPlayer !is null )
	{
		CustomKeyvalues@ pUnlock = pPlayer.GetCustomKeyvalues();
		pUnlock.SetKeyvalue( "$i_a_unlock", 4 );
	}
}
void a04_unlock( const int& in index )
{
	CBasePlayer@ pPlayer = g_PlayerFuncs.FindPlayerByIndex( index );
	if ( pPlayer !is null )
	{
		CustomKeyvalues@ pUnlock = pPlayer.GetCustomKeyvalues();
		pUnlock.SetKeyvalue( "$i_a_unlock", 5 );
	}
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
						if ( pPlayer.pev.frags >= 90.0 ) // 15%
						{
							// Get!
							
							// HOLD IT! Two achievements are being given at the same time!
							// Wait for our first achievement to be given first and THEN add this one
							g_Scheduler.SetTimeout( "a07_unlock", 1.50, pPlayer.entindex() );
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
					if ( pPlayer.pev.frags >= 90.0 ) // 15%
					{
						// Get!
						CustomKeyvalues@ pUnlock = pPlayer.GetCustomKeyvalues();
						pUnlock.SetKeyvalue( "$i_a_unlock", 7 );
					}
				}
			}
			
			g_EntityFuncs.Remove( pCheck1_1 );
			return;
		}
	}
}
void a07_unlock( const int& in index )
{
	CBasePlayer@ pPlayer = g_PlayerFuncs.FindPlayerByIndex( index );
	if ( pPlayer !is null && pPlayer.IsConnected() )
	{
		CustomKeyvalues@ pUnlock = pPlayer.GetCustomKeyvalues();
		pUnlock.SetKeyvalue( "$i_a_unlock", 8 );
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
							if ( pPlayer.pev.frags >= 45.0 )
							{
								// Get!
								pCheck2_1.SetKeyvalue( "$i_a_unlock", 9 );
							}
						}
					}
				}
			}
		}
		
		g_EntityFuncs.Remove( pCheck1_1 );
		return;
	}
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
						if ( pPlayer.pev.frags >= 180.0 )
						{
							// Get!
							
							// Another achievement is being given, wait
							g_Scheduler.SetTimeout( "a11_unlock", 1.50, pPlayer.entindex() );
						}
					}
				}
				
				// Any other difficulty
				// To prevent abuse, player must have at least this much score
				if ( pPlayer.pev.frags >= 135.0 )
				{
					// Get!
					pCheck.SetKeyvalue( "$i_a_unlock", 10 );
				}
				
				// Player escaed the self-destruct sequence?
				CustomKeyvalue iEscaped_pre( pCheck.GetKeyvalue( "$i_escape" ) );
				int iEscaped = iEscaped_pre.GetInteger();
				if ( iEscaped == 1 )
				{
					// To prevent abuse, player must have at least this much score, YES I'M THAT EVIL ON THIS ONE
					if ( pPlayer.pev.frags >= 44.0 )
					{
						// Get!
						
						// Another achievement is being given, wait
						g_Scheduler.SetTimeout( "a10_unlock", 1.50, pPlayer.entindex() );
					}
					
				}
			}
		}
		
		g_EntityFuncs.Remove( pCheck1_1 );
		return;
	}
}
void a10_unlock( const int& in index )
{
	CBasePlayer@ pPlayer = g_PlayerFuncs.FindPlayerByIndex( index );
	if ( pPlayer !is null )
	{
		CustomKeyvalues@ pUnlock = pPlayer.GetCustomKeyvalues();
		pUnlock.SetKeyvalue( "$i_a_unlock", 11 );
	}
}
void a11_unlock( const int& in index )
{
	CBasePlayer@ pPlayer = g_PlayerFuncs.FindPlayerByIndex( index );
	if ( pPlayer !is null )
	{
		CustomKeyvalues@ pUnlock = pPlayer.GetCustomKeyvalues();
		pUnlock.SetKeyvalue( "$i_a_unlock", 12 );
	}
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
					if ( pPlayer.pev.frags >= 195.0 )
					{
						// Get!
						CustomKeyvalues@ pUnlock = pPlayer.GetCustomKeyvalues();
						pUnlock.SetKeyvalue( "$i_a_unlock", 13 );
					}
				}
				else if ( iMode == 2 ) // Gonome Hunter gamemode?
				{
					// To prevent abuse, player must have at least this much score
					if ( pPlayer.pev.frags >= 260.0 )
					{
						// Get!
						CustomKeyvalues@ pUnlock = pPlayer.GetCustomKeyvalues();
						pUnlock.SetKeyvalue( "$i_a_unlock", 14 );
					}
				}
				else if ( iMode == 3 ) // Protection gamemode?
				{
					// To prevent abuse, player must have at least this much score
					if ( pPlayer.pev.frags >= 130.0 )
					{
						// Get!
						CustomKeyvalues@ pUnlock = pPlayer.GetCustomKeyvalues();
						pUnlock.SetKeyvalue( "$i_a_unlock", 15 );
					}
				}
			}
		}
		
		g_EntityFuncs.Remove( pCheck1_1 );
		return;
	}
}

void BlackMesaEPF_check()
{
	if ( szMap != 'blackmesaepf' )
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
				pCheck.SetKeyvalue( "$i_a_unlock", 16 );
				
				// Reset to prevent looping
				pCheck.SetKeyvalue( "$i_pass", 0 );
			}
		}
	}
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
						if ( pPlayer.pev.frags >= 25.0 )
						{
							// Get!
							CustomKeyvalues@ pUnlock = pPlayer.GetCustomKeyvalues();
							pUnlock.SetKeyvalue( "$i_a_unlock", 17 );
						}
					}
				}
				
				g_EntityFuncs.Remove( pCheck1_1 );
				return;
			}
		}
		
		pCheck1_1.pev.iuser3 = pCheck1_1.pev.iuser3 + 1;
	}
	else
		pCheck1_1.pev.iuser4 = pCheck1_1.pev.iuser4 + 1;
	
	g_Scheduler.SetTimeout( "sandstone_check", 0.1 );
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
			CBaseEntity@ pScore = g_EntityFuncs.FindEntityByTargetname( null, "capcounter" );
			if ( pScore is null )
				return;
			
			if ( pScore.pev.frags >= 160 )
			{
				// Get players
				for ( int i = 1; i <= g_Engine.maxClients; i++ )
				{
					CBasePlayer@ pPlayer = g_PlayerFuncs.FindPlayerByIndex( i );
					
					if ( pPlayer !is null && pPlayer.IsConnected() )
					{
						// Jumper can unlock the achievement with no score requirement at all
						if ( pPlayer.pev.targetname == "jumper" )
						{
							// Get!
							CustomKeyvalues@ pUnlock = pPlayer.GetCustomKeyvalues();
							pUnlock.SetKeyvalue( "$i_a_unlock", 18 );
						}
						else
						{
							// Other players will need this much score to unlock it
							if ( pPlayer.pev.frags >= 320 )
							{
								// Get!
								CustomKeyvalues@ pUnlock = pPlayer.GetCustomKeyvalues();
								pUnlock.SetKeyvalue( "$i_a_unlock", 18 );
							}
						}
					}
				}
				
				g_EntityFuncs.Remove( pCheck1_1 );
				return;
			}
		}
		
		pCheck1_1.pev.iuser3 = pCheck1_1.pev.iuser3 + 1;
	}
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
						if ( pPlayer.pev.frags >= 195.0 )
						{
							// Get!
							
							// x6 achievements? Okay, handle very carefully the delays
							g_Scheduler.SetTimeout( "a23_unlock", 1.5, pPlayer.entindex() );
						}
					}
					
					// Any difficulty clear
					if ( pPlayer.pev.frags >= 65.0 )
					{
						// Get!
						pUnlock.SetKeyvalue( "$i_a_unlock", 22 );
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
						case 3:
						{
							if ( pPlayer.pev.frags >= 195.0 )
							{
								// Get!
								g_Scheduler.SetTimeout( "a20_unlock", 3.0, pPlayer.entindex() );
							}
							break;
						}
						case 2:
						{
							if ( pPlayer.pev.frags >= 130.0 )
							{
								// Get!
								g_Scheduler.SetTimeout( "a19_unlock", 1.5, pPlayer.entindex() );
							}
							break;
						}
						case 1:
						{
							if ( pPlayer.pev.frags >= 65.0 )
							{
								// Get!
								pUnlock.SetKeyvalue( "$i_a_unlock", 19 );
							}
							break;
						}
					}
				}
				
				// Helper commander?
				CustomKeyvalue iLeft_pre( pUnlock.GetKeyvalue( "$i_left" ) );
				int iLeft = iLeft_pre.GetInteger();
				if ( iLeft == 1 )
				{
					// The commander must also did it's effort fighting, and a little tip bonus as well
					if ( pPlayer.pev.frags >= 220.0 )
					{
						// Get!
						g_Scheduler.SetTimeout( "a22_unlock", 4.5, pPlayer.entindex() );
					}
				}
			}
		}
		
		g_EntityFuncs.Remove( pCheck1_1 );
		return;
	}
}
void a19_unlock( const int& in index )
{
	CBasePlayer@ pPlayer = g_PlayerFuncs.FindPlayerByIndex( index );
	if ( pPlayer !is null )
	{
		CustomKeyvalues@ pUnlock = pPlayer.GetCustomKeyvalues();
		pUnlock.SetKeyvalue( "$i_a_unlock", 20 );
	}
}
void a20_unlock( const int& in index )
{
	CBasePlayer@ pPlayer = g_PlayerFuncs.FindPlayerByIndex( index );
	if ( pPlayer !is null )
	{
		CustomKeyvalues@ pUnlock = pPlayer.GetCustomKeyvalues();
		pUnlock.SetKeyvalue( "$i_a_unlock", 21 );
	}
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
void a23_unlock( const int& in index )
{
	CBasePlayer@ pPlayer = g_PlayerFuncs.FindPlayerByIndex( index );
	if ( pPlayer !is null )
	{
		CustomKeyvalues@ pUnlock = pPlayer.GetCustomKeyvalues();
		pUnlock.SetKeyvalue( "$i_a_unlock", 24 );
	}
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
						pCheck.SetKeyvalue( "$i_a_unlock", 25 );
					}
				}
			}
		}
		
		g_EntityFuncs.Remove( pCheck1_1 );
		return;
	}
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
					if ( pPlayer.pev.frags >= 30.0 )
					{
						// Get!
						CustomKeyvalues@ pUnlock = pPlayer.GetCustomKeyvalues();
						pUnlock.SetKeyvalue( "$i_a_unlock", 27 );
					}
				}
			}
		}
		
		g_EntityFuncs.Remove( pCheck1_1 );
		return;
	}
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
						if ( pPlayer.pev.frags >= 80.0 )
						{
							// Get!
							pCheck2_1.SetKeyvalue( "$i_a_unlock", 28 );
						}
					}
				}
			}
		}
		
		g_EntityFuncs.Remove( pCheck1_1 );
		return;
	}
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
					if ( pPlayer.pev.frags >= 105.0 )
					{
						// Get!
						CustomKeyvalues@ pUnlock = pPlayer.GetCustomKeyvalues();
						pUnlock.SetKeyvalue( "$i_a_unlock", 29 );
					}
				}
			}
		}
		
		g_EntityFuncs.Remove( pCheck1_1 );
		return;
	}
	
	// Second achievement
	CustomKeyvalue iObjetives_pre( pCheck1_2.GetKeyvalue( "$i_objetives" ) );
	int iObjetives = iObjetives_pre.GetInteger();
	if ( iObjetives >= 6 )
	{
		for ( int i = 1; i <= g_Engine.maxClients; i++ )
		{
			CBasePlayer@ pPlayer = g_PlayerFuncs.FindPlayerByIndex( i );
			
			if ( pPlayer !is null && pPlayer.IsConnected() )
			{
				// To prevent abuse, player must have at least this much score
				if ( pPlayer.pev.frags >= 70.0 )
				{
					// Get!
					CustomKeyvalues@ pUnlock = pPlayer.GetCustomKeyvalues();
					pUnlock.SetKeyvalue( "$i_a_unlock", 38 );
				}
			}
		}
		
		// Reset, no looping
		pCheck1_2.SetKeyvalue( "$i_objetives", 0 );
	}
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
						pCheck2_1.SetKeyvalue( "$i_a_unlock", 30 );
					}
				}
			}
		}
	}
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
					if ( pPlayer.pev.frags >= 86.0 )
					{
						// Get!
						CustomKeyvalues@ pUnlock = pPlayer.GetCustomKeyvalues();
						pUnlock.SetKeyvalue( "$i_a_unlock", 31 );
					}
				}
			}
		}
		
		g_EntityFuncs.Remove( pCheck1_1 );
		return;
	}
}

void sc_mazing_check()
{
	if ( szMap != 'sc_mazing' )
		return;
	
	CBaseEntity@ pCheck1_1 = g_EntityFuncs.FindEntityByTargetname( null, "sys_adata" );
	if ( pCheck1_1 is null )
		return;
	
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
				if ( pPlayer.pev.frags >= 70.0 )
				{
					// Get!
					CustomKeyvalues@ pUnlock = pPlayer.GetCustomKeyvalues();
					pUnlock.SetKeyvalue( "$i_a_unlock", 32 );
				}
			}
		}
		
		// Reset, no looping
		pCheck1_2.SetKeyvalue( "$i_kills", 0 );
	}
	
	// Speedrun achievement
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
						if ( pPlayer.pev.frags >= 91.0 ) // 13%
						{
							// Get!
							CustomKeyvalues@ pUnlock = pPlayer.GetCustomKeyvalues();
							pUnlock.SetKeyvalue( "$i_a_unlock", 34 );
						}
					}
				}
				
				g_EntityFuncs.Remove( pCheck1_1 );
				return;
			}
		}
		
		pCheck1_1.pev.iuser3 = pCheck1_1.pev.iuser3 + 1;
	}
	else
		pCheck1_1.pev.iuser4 = pCheck1_1.pev.iuser4 + 1;
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
		
		g_EntityFuncs.Remove( pCheck1_1 );
		return;
	}
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
							if ( pPlayer.pev.frags >= 96.0 )
							{
								// Get!
								CustomKeyvalues@ pUnlock = pPlayer.GetCustomKeyvalues();
								pUnlock.SetKeyvalue( "$i_a_unlock", 33 );
							}
						}
					}
				}
			}
		}
		
		g_EntityFuncs.Remove( pCheck1_1 );
		return;
	}
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
					pUnlock.SetKeyvalue( "$i_a_unlock", 35 );
				}
			}
		}
		
		g_EntityFuncs.Remove( pCheck1_1 );
		return;
	}
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
				if ( pPlayer.pev.frags >= 30.0 )
				{
					// Insane difficulty?
					CustomKeyvalue iDifficulty_pre( pCheck1_2.GetKeyvalue( "$i_difficulty" ) );
					int iDifficulty = iDifficulty_pre.GetInteger();
					if ( iDifficulty >= 3 )
					{
						// GET! On a later time...
						g_Scheduler.SetTimeout( "a36_unlock", 1.50, pPlayer.entindex() );
					}
					if ( iDifficulty >= 1 ) // Normal or higher?
					{
						// Get!
						CustomKeyvalues@ pUnlock = pPlayer.GetCustomKeyvalues();
						pUnlock.SetKeyvalue( "$i_a_unlock", 36 );
					}
				}
			}
		}
		
		g_EntityFuncs.Remove( pCheck1_1 );
		return;
	}
}
void a36_unlock( const int& in index )
{
	CBasePlayer@ pPlayer = g_PlayerFuncs.FindPlayerByIndex( index );
	if ( pPlayer !is null && pPlayer.IsConnected() )
	{
		CustomKeyvalues@ pUnlock = pPlayer.GetCustomKeyvalues();
		pUnlock.SetKeyvalue( "$i_a_unlock", 37 );
	}
}

void judgement_check()
{
	if ( szMap != 'judgement' )
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
				if ( pPlayer.pev.frags >= 80.0 )
				{
					// Max difficulty?
					CustomKeyvalue iDifficulty_pre( pCheck1_2.GetKeyvalue( "$i_active" ) );
					int iDifficulty = iDifficulty_pre.GetInteger();
					if ( iDifficulty == 1 )
					{
						// Get!
						CustomKeyvalues@ pUnlock = pPlayer.GetCustomKeyvalues();
						pUnlock.SetKeyvalue( "$i_a_unlock", 39 );
					}
				}
			}
		}
		
		g_EntityFuncs.Remove( pCheck1_1 );
		return;
	}
}

void infested_check()
{
	if ( szMap != 'infested' )
		return;
	
	CBaseEntity@ pCheck1_1 = g_EntityFuncs.FindEntityByTargetname( null, "sys_adata" );
	if ( pCheck1_1 is null )
		return;
	
	// Osprey destroyed?
	CustomKeyvalues@ pCheck1_2 = pCheck1_1.GetCustomKeyvalues();
	CustomKeyvalue iCheck1_pre( pCheck1_2.GetKeyvalue( "$i_active" ) );
	int iCheck1 = iCheck1_pre.GetInteger();
	if ( iCheck1 == 1 )
	{
		for ( int i = 1; i <= g_Engine.maxClients; i++ )
		{
			CBasePlayer@ pPlayer = g_PlayerFuncs.FindPlayerByIndex( i );
			if ( pPlayer !is null && pPlayer.IsConnected() )
			{
				CBaseEntity@ pHolder = g_EntityFuncs.Instance( pPlayer.pev.groundentity );
				if ( pHolder !is null )
				{
					// Standing on the starting truck?
					if ( pHolder.pev.targetname == 'entrancetruck1' )
					{
						// To prevent abuse, player must have at least this much score
						if ( pPlayer.pev.frags >= 80.0 )
						{
							// Get!
							CustomKeyvalues@ pUnlock = pPlayer.GetCustomKeyvalues();
							pUnlock.SetKeyvalue( "$i_a_unlock", 40 );
						}
					}
				}
			}
		}
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
