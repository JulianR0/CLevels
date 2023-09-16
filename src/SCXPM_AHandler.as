/*
	Imperium Sven Co-op's SCXPM: Achievements Handler
	Copyright (C) 2019-2022  Julian Rodriguez
	
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
CScheduledFunction@ g_SCTimer;

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
	// Achievement helpers for AMXX
	CBaseEntity@ pEntity = null;
	while( ( @pEntity = g_EntityFuncs.FindEntityByClassname( pEntity, "monster_zombie" ) ) !is null )
	{
		CBaseMonster@ pMonster = cast< CBaseMonster@ >( pEntity );
		
		// Get the current enemy and set it into PEV field so it can be gathered from cross-scripting
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
			CustomKeyvalues@ pHandicaps = pPlayer.GetCustomKeyvalues();
	
			int iHandicaps = 0;
			iHandicaps += pHandicaps.GetKeyvalue( "$i_handicap01" ).GetInteger();
			iHandicaps += pHandicaps.GetKeyvalue( "$i_handicap02" ).GetInteger();
			iHandicaps += pHandicaps.GetKeyvalue( "$i_handicap03" ).GetInteger();
			iHandicaps += pHandicaps.GetKeyvalue( "$i_handicap04" ).GetInteger();
			iHandicaps += pHandicaps.GetKeyvalue( "$i_handicap05" ).GetInteger();
			iHandicaps += pHandicaps.GetKeyvalue( "$i_handicap06" ).GetInteger();
			iHandicaps += pHandicaps.GetKeyvalue( "$i_handicap07" ).GetInteger();
			iHandicaps += pHandicaps.GetKeyvalue( "$i_handicap08" ).GetInteger();
			iHandicaps += pHandicaps.GetKeyvalue( "$i_handicap09" ).GetInteger();
			iHandicaps += pHandicaps.GetKeyvalue( "$i_handicap10" ).GetInteger();
			iHandicaps += pHandicaps.GetKeyvalue( "$i_handicap11" ).GetInteger();
			iHandicaps += pHandicaps.GetKeyvalue( "$i_handicap12" ).GetInteger();
			iHandicaps += pHandicaps.GetKeyvalue( "$i_handicap13" ).GetInteger();
			iHandicaps += pHandicaps.GetKeyvalue( "$i_handicap14" ).GetInteger();
			iHandicaps += pHandicaps.GetKeyvalue( "$i_handicap15" ).GetInteger();
			
			if ( iHandicaps >= 10 )
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
								float flHoldTime = flHoldTime_pre.GetFloat();
								float flGoalTime = pCheck.GetKeyvalue( "$f_a_goaltime" ).GetFloat();
								
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
	if ( g_SCTimer !is null )
	{
		g_Scheduler.RemoveTimer( g_SCTimer );
		@g_SCTimer = null;
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
		
		@g_SCTimer = @g_Scheduler.SetInterval( "abandoned_check", 0.10, g_Scheduler.REPEAT_INFINITE_TIMES );
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
		pEntity.pev.target = "sys_adata";
		pEntity.KeyValue( "m_iszValueName", "$i_weapons_found" );
		pEntity.KeyValue( "m_iszNewValue", "1" );
		pEntity.KeyValue( "m_iszValueType", "1" );
		
		@pEntity = g_EntityFuncs.Create( "trigger_changevalue", g_vecZero, g_vecZero, false );
		pEntity.pev.targetname = "spawnm16";
		pEntity.pev.target = "sys_adata";
		pEntity.KeyValue( "m_iszValueName", "$i_weapons_found" );
		pEntity.KeyValue( "m_iszNewValue", "1" );
		pEntity.KeyValue( "m_iszValueType", "1" );
		
		@pEntity = g_EntityFuncs.Create( "trigger_changevalue", g_vecZero, g_vecZero, false );
		pEntity.pev.targetname = "spawnspore";
		pEntity.pev.target = "sys_adata";
		pEntity.KeyValue( "m_iszValueName", "$i_weapons_found" );
		pEntity.KeyValue( "m_iszNewValue", "1" );
		pEntity.KeyValue( "m_iszValueType", "1" );
		
		@pEntity = g_EntityFuncs.Create( "trigger_changevalue", g_vecZero, g_vecZero, false );
		pEntity.pev.targetname = "spawnhornet";
		pEntity.pev.target = "sys_adata";
		pEntity.KeyValue( "m_iszValueName", "$i_weapons_found" );
		pEntity.KeyValue( "m_iszNewValue", "1" );
		pEntity.KeyValue( "m_iszValueType", "1" );
		
		@pEntity = g_EntityFuncs.Create( "trigger_changevalue", g_vecZero, g_vecZero, false );
		pEntity.pev.targetname = "spawncrossbow";
		pEntity.pev.target = "sys_adata";
		pEntity.KeyValue( "m_iszValueName", "$i_weapons_found" );
		pEntity.KeyValue( "m_iszNewValue", "1" );
		pEntity.KeyValue( "m_iszValueType", "1" );
		
		@pEntity = g_EntityFuncs.Create( "trigger_changevalue", g_vecZero, g_vecZero, false );
		pEntity.pev.targetname = "spawngauss";
		pEntity.pev.target = "sys_adata";
		pEntity.KeyValue( "m_iszValueName", "$i_weapons_found" );
		pEntity.KeyValue( "m_iszNewValue", "1" );
		pEntity.KeyValue( "m_iszValueType", "1" );
		
		@pEntity = g_EntityFuncs.Create( "trigger_changevalue", g_vecZero, g_vecZero, false );
		pEntity.pev.targetname = "spawnsniper";
		pEntity.pev.target = "sys_adata";
		pEntity.KeyValue( "m_iszValueName", "$i_weapons_found" );
		pEntity.KeyValue( "m_iszNewValue", "1" );
		pEntity.KeyValue( "m_iszValueType", "1" );
		
		@pEntity = g_EntityFuncs.Create( "trigger_changevalue", g_vecZero, g_vecZero, false );
		pEntity.pev.targetname = "spawnrevolver";
		pEntity.pev.target = "sys_adata";
		pEntity.KeyValue( "m_iszValueName", "$i_weapons_found" );
		pEntity.KeyValue( "m_iszNewValue", "1" );
		pEntity.KeyValue( "m_iszValueType", "1" );
		
		@pEntity = g_EntityFuncs.Create( "trigger_changevalue", g_vecZero, g_vecZero, false );
		pEntity.pev.targetname = "spawnrpg";
		pEntity.pev.target = "sys_adata";
		pEntity.KeyValue( "m_iszValueName", "$i_weapons_found" );
		pEntity.KeyValue( "m_iszNewValue", "1" );
		pEntity.KeyValue( "m_iszValueType", "1" );
		
		@pEntity = g_EntityFuncs.Create( "trigger_changevalue", g_vecZero, g_vecZero, false );
		pEntity.pev.targetname = "spawnsaw";
		pEntity.pev.target = "sys_adata";
		pEntity.KeyValue( "m_iszValueName", "$i_weapons_found" );
		pEntity.KeyValue( "m_iszNewValue", "1" );
		pEntity.KeyValue( "m_iszValueType", "1" );
		
		@pEntity = g_EntityFuncs.Create( "trigger_changevalue", g_vecZero, g_vecZero, false );
		pEntity.pev.targetname = "spawnuzi";
		pEntity.pev.target = "sys_adata";
		pEntity.KeyValue( "m_iszValueName", "$i_weapons_found" );
		pEntity.KeyValue( "m_iszNewValue", "1" );
		pEntity.KeyValue( "m_iszValueType", "1" );
		
		@pEntity = g_EntityFuncs.Create( "trigger_changevalue", g_vecZero, g_vecZero, false );
		pEntity.pev.targetname = "mapwon";
		pEntity.pev.target = "sys_adata";
		pEntity.KeyValue( "m_iszValueName", "$i_test" );
		pEntity.KeyValue( "m_iszNewValue", "1" );
		pEntity.KeyValue( "m_iszValueType", "0" );
		
		@g_SCTimer = @g_Scheduler.SetInterval( "toadsnatch_check", 0.10, g_Scheduler.REPEAT_INFINITE_TIMES );
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
		
		@g_SCTimer = @g_Scheduler.SetInterval( "quarter_check", 0.10, g_Scheduler.REPEAT_INFINITE_TIMES );
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
		
		@g_SCTimer = @g_Scheduler.SetInterval( "sc_persia_check", 0.10, g_Scheduler.REPEAT_INFINITE_TIMES );
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
		
		@g_SCTimer = @g_Scheduler.SetInterval( "mommamesa_check", 0.10, g_Scheduler.REPEAT_INFINITE_TIMES );
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
		
		@g_SCTimer = @g_Scheduler.SetInterval( "deadsimpleneo2_check", 0.10, g_Scheduler.REPEAT_INFINITE_TIMES );
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
		
		@g_SCTimer = @g_Scheduler.SetInterval( "BlackMesaEPF_check", 0.10, g_Scheduler.REPEAT_INFINITE_TIMES );
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
		
		@g_SCTimer = @g_Scheduler.SetInterval( "sandstone_check", 0.10, g_Scheduler.REPEAT_INFINITE_TIMES );
	}
	else if ( szMap == 'jumpers' )
	{
		@pEntity = g_EntityFuncs.Create( "info_target", g_vecZero, g_vecZero, false );
		pEntity.pev.targetname = "sys_adata";
		
		@pEntity = g_EntityFuncs.Create( "trigger_changevalue", g_vecZero, g_vecZero, false );
		pEntity.pev.targetname = "begin_game"; // Our server uses a modified 4.8 jumpers.bsp, targetname might not match
		pEntity.pev.target = "sys_adata";
		pEntity.KeyValue( "m_iszValueName", "$i_active" );
		pEntity.KeyValue( "m_iszNewValue", "1" );
		pEntity.KeyValue( "m_iszValueType", "0" );
		
		@g_SCTimer = @g_Scheduler.SetInterval( "jumpers_check", 0.10, g_Scheduler.REPEAT_INFINITE_TIMES );
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
		
		@g_SCTimer = @g_Scheduler.SetInterval( "fortified1_check", 0.10, g_Scheduler.REPEAT_INFINITE_TIMES );
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
		
		@g_SCTimer = @g_Scheduler.SetInterval( "svencoop2_check", 0.10, g_Scheduler.REPEAT_INFINITE_TIMES );
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
		
		@g_SCTimer = @g_Scheduler.SetInterval( "sc_doc_check", 0.10, g_Scheduler.REPEAT_INFINITE_TIMES );
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
		
		@g_SCTimer = @g_Scheduler.SetInterval( "sc_psyko_check", 0.10, g_Scheduler.REPEAT_INFINITE_TIMES );
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
		
		@g_SCTimer = @g_Scheduler.SetInterval( "turretfortress_check", 0.10, g_Scheduler.REPEAT_INFINITE_TIMES );
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
		
		@g_SCTimer = @g_Scheduler.SetInterval( "tf_original_check", 0.10, g_Scheduler.REPEAT_INFINITE_TIMES );
	}
	else if ( szMap == 'sc_robination_revised' )
	{
		@pEntity = g_EntityFuncs.Create( "info_target", g_vecZero, g_vecZero, false );
		pEntity.pev.targetname = "sys_adata";
		
		// deathless achievement
		@pEntity = g_EntityFuncs.Create( "trigger_changevalue", g_vecZero, g_vecZero, false );
		pEntity.pev.targetname = "mm_last_final";
		pEntity.pev.target = "sys_adata";
		pEntity.KeyValue( "m_iszValueName", "$i_test" );
		pEntity.KeyValue( "m_iszNewValue", "1" );
		pEntity.KeyValue( "m_iszValueType", "0" );
		
		@g_SCTimer = @g_Scheduler.SetInterval( "sc_robination_revised_check", 0.10, g_Scheduler.REPEAT_INFINITE_TIMES );
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
		
		@g_SCTimer = @g_Scheduler.SetInterval( "sc_mazing_check", 0.10, g_Scheduler.REPEAT_INFINITE_TIMES );
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
		
		@g_SCTimer = @g_Scheduler.SetInterval( "sc_tetris1_check", 0.10, g_Scheduler.REPEAT_INFINITE_TIMES );
	}
	else if ( szMap == 'sc_tetris2' || szMap == 'sc_tetris3' || szMap == 'sc_tetris4' || szMap == 'sc_tetris5' )
	{
		// Just get player list
		@g_SCTimer = @g_Scheduler.SetInterval( "sc_tetris2_5_check", 65.10, g_Scheduler.REPEAT_INFINITE_TIMES );
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
		
		@g_SCTimer = @g_Scheduler.SetInterval( "sc_tetris6_check", 0.10, g_Scheduler.REPEAT_INFINITE_TIMES );
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
		
		@g_SCTimer = @g_Scheduler.SetInterval( "toonrun3_check", 0.10, g_Scheduler.REPEAT_INFINITE_TIMES );
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
		
		@g_SCTimer = @g_Scheduler.SetInterval( "suspension_check", 0.10, g_Scheduler.REPEAT_INFINITE_TIMES );
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
		
		@g_SCTimer = @g_Scheduler.SetInterval( "judgement_check", 0.10, g_Scheduler.REPEAT_INFINITE_TIMES );
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
		
		@g_SCTimer = @g_Scheduler.SetInterval( "infested_check", 0.10, g_Scheduler.REPEAT_INFINITE_TIMES );
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
		
		@g_SCTimer = @g_Scheduler.SetInterval( "sc_face_check", 0.10, g_Scheduler.REPEAT_INFINITE_TIMES );
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
		
		// Function names cannot start with a number
		@g_SCTimer = @g_Scheduler.SetInterval( "F_5minutes_b1_check", 0.10, g_Scheduler.REPEAT_INFINITE_TIMES );
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
		
		@g_SCTimer = @g_Scheduler.SetInterval( "never_check", 0.10, g_Scheduler.REPEAT_INFINITE_TIMES );
	}
	else if ( szMap == 'ub_nagoya_v2' )
	{
		@pEntity = g_EntityFuncs.Create( "info_target", g_vecZero, g_vecZero, false );
		pEntity.pev.targetname = "sys_adata";
		
		@pEntity = g_EntityFuncs.Create( "multi_manager", g_vecZero, g_vecZero, false );
		pEntity.pev.targetname = "btn_seq00";
		pEntity.KeyValue( "fixer_boxes", "0" );
		
		@pEntity = g_EntityFuncs.Create( "trigger_changevalue", g_vecZero, g_vecZero, false );
		pEntity.pev.targetname = "fixer_boxes";
		pEntity.pev.target = "sys_adata";
		pEntity.KeyValue( "m_iszValueName", "$i_boxes" );
		pEntity.KeyValue( "m_iszNewValue", "1" );
		pEntity.KeyValue( "m_iszValueType", "1" );
		
		@pEntity = g_EntityFuncs.Create( "trigger_changevalue", g_vecZero, g_vecZero, false );
		pEntity.pev.targetname = "fixer_boxes";
		pEntity.pev.target = "!activator";
		pEntity.KeyValue( "m_iszValueName", "$i_boxes" );
		pEntity.KeyValue( "m_iszNewValue", "1" );
		pEntity.KeyValue( "m_iszValueType", "1" );
		
		@g_SCTimer = @g_Scheduler.SetInterval( "ub_nagoya_v2_check", 0.10, g_Scheduler.REPEAT_INFINITE_TIMES );
	}
	else if ( szMap == 'ub_iseki2' )
	{
		@pEntity = g_EntityFuncs.Create( "info_target", g_vecZero, g_vecZero, false );
		pEntity.pev.targetname = "sys_adata";
		
		@pEntity = g_EntityFuncs.Create( "trigger_changevalue", g_vecZero, g_vecZero, false );
		pEntity.pev.targetname = "mm_last";
		pEntity.pev.target = "sys_adata";
		pEntity.KeyValue( "m_iszValueName", "$i_test" );
		pEntity.KeyValue( "m_iszNewValue", "1" );
		pEntity.KeyValue( "m_iszValueType", "0" );
		
		@g_SCTimer = @g_Scheduler.SetInterval( "ub_iseki2_check", 0.10, g_Scheduler.REPEAT_INFINITE_TIMES );
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
		
		@g_SCTimer = @g_Scheduler.SetInterval( "sciguard2_check", 0.10, g_Scheduler.REPEAT_INFINITE_TIMES );
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
		
		@g_SCTimer = @g_Scheduler.SetInterval( "keen_birthday_part1_beta_check", 0.10, g_Scheduler.REPEAT_INFINITE_TIMES );
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
		
		@g_SCTimer = @g_Scheduler.SetInterval( "zero_check", 0.10, g_Scheduler.REPEAT_INFINITE_TIMES );
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
		
		@g_SCTimer = @g_Scheduler.SetInterval( "clockwork_check", 0.10, g_Scheduler.REPEAT_INFINITE_TIMES );
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
		
		@g_SCTimer = @g_Scheduler.SetInterval( "sectore_3_check", 0.10, g_Scheduler.REPEAT_INFINITE_TIMES );
	}
	else if ( szMap == 'nm_darkisland' )
	{
		@pEntity = g_EntityFuncs.Create( "info_target", g_vecZero, g_vecZero, false );
		pEntity.pev.targetname = "sys_adata";
		
		@pEntity = g_EntityFuncs.Create( "trigger_changevalue", g_vecZero, g_vecZero, false );
		pEntity.pev.targetname = "the_end";
		pEntity.pev.target = "sys_adata";
		pEntity.KeyValue( "m_iszValueName", "$i_test" );
		pEntity.KeyValue( "m_iszNewValue", "1" );
		pEntity.KeyValue( "m_iszValueType", "0" );
		
		@g_SCTimer = @g_Scheduler.SetInterval( "nm_darkisland_check", 0.10, g_Scheduler.REPEAT_INFINITE_TIMES );
	}
	else if ( szMap == 'why1' )
	{
		@pEntity = g_EntityFuncs.Create( "info_target", g_vecZero, g_vecZero, false );
		pEntity.pev.targetname = "sys_adata";
		
		@pEntity = g_EntityFuncs.Create( "trigger_changevalue", g_vecZero, g_vecZero, false );
		pEntity.pev.targetname = "omggameover";
		pEntity.pev.target = "sys_adata";
		pEntity.KeyValue( "m_iszValueName", "$i_test" );
		pEntity.KeyValue( "m_iszNewValue", "1" );
		pEntity.KeyValue( "m_iszValueType", "0" );
		
		@g_SCTimer = @g_Scheduler.SetInterval( "why1_check", 0.10, g_Scheduler.REPEAT_INFINITE_TIMES );
	}
	else if ( szMap == 'snd' )
	{
		@pEntity = g_EntityFuncs.Create( "info_target", g_vecZero, g_vecZero, false );
		pEntity.pev.targetname = "sys_adata";
		
		@pEntity = g_EntityFuncs.Create( "trigger_changevalue", g_vecZero, g_vecZero, false );
		pEntity.pev.targetname = "win_yellow_text";
		pEntity.pev.target = "sys_adata";
		pEntity.KeyValue( "m_iszValueName", "$i_difficulty" );
		pEntity.KeyValue( "m_iszNewValue", "1" );
		pEntity.KeyValue( "m_iszValueType", "0" );
		
		@pEntity = g_EntityFuncs.Create( "trigger_changevalue", g_vecZero, g_vecZero, false );
		pEntity.pev.targetname = "win_blue_text";
		pEntity.pev.target = "sys_adata";
		pEntity.KeyValue( "m_iszValueName", "$i_difficulty" );
		pEntity.KeyValue( "m_iszNewValue", "2" );
		pEntity.KeyValue( "m_iszValueType", "0" );
		
		@pEntity = g_EntityFuncs.Create( "trigger_changevalue", g_vecZero, g_vecZero, false );
		pEntity.pev.targetname = "win_red_text";
		pEntity.pev.target = "sys_adata";
		pEntity.KeyValue( "m_iszValueName", "$i_difficulty" );
		pEntity.KeyValue( "m_iszNewValue", "3" );
		pEntity.KeyValue( "m_iszValueType", "0" );
		
		@pEntity = g_EntityFuncs.Create( "trigger_changevalue", g_vecZero, g_vecZero, false );
		pEntity.pev.targetname = "mission_win";
		pEntity.pev.target = "sys_adata";
		pEntity.KeyValue( "m_iszValueName", "$i_test" );
		pEntity.KeyValue( "m_iszNewValue", "1" );
		pEntity.KeyValue( "m_iszValueType", "0" );
		
		@g_SCTimer = @g_Scheduler.SetInterval( "snd_check", 0.10, g_Scheduler.REPEAT_INFINITE_TIMES );
	}
	else if ( szMap == 'intruder' )
	{
		@pEntity = g_EntityFuncs.Create( "info_target", g_vecZero, g_vecZero, false );
		pEntity.pev.targetname = "sys_adata";
		
		@pEntity = g_EntityFuncs.Create( "trigger_changevalue", g_vecZero, g_vecZero, false );
		pEntity.pev.targetname = "endyboobs";
		pEntity.pev.target = "sys_adata";
		pEntity.KeyValue( "m_iszValueName", "$i_test" );
		pEntity.KeyValue( "m_iszNewValue", "1" );
		pEntity.KeyValue( "m_iszValueType", "0" );
		
		@g_SCTimer = @g_Scheduler.SetInterval( "intruder_check", 0.10, g_Scheduler.REPEAT_INFINITE_TIMES );
	}
}

void abandoned_check()
{
	if ( szMap != 'abandoned' )
		return;
	
	CBaseEntity@ pCheck = g_EntityFuncs.FindEntityByTargetname( null, "sys_adata" );
	if ( pCheck is null )
		return;
	
	CustomKeyvalues@ pKVD = pCheck.GetCustomKeyvalues();
	
	int iCheck1 = pKVD.GetKeyvalue( "$i_active" ).GetInteger();
	if ( iCheck1 == 1 )
	{
		// Reached map end?
		int iCheck2 = pKVD.GetKeyvalue( "$i_test" ).GetInteger();
		if ( iCheck2 == 1 )
		{
			int iCheck3 = pKVD.GetKeyvalue( "$i_fail" ).GetInteger();
			
			// Check whenever bomb did not detonate
			if ( iCheck3 == 0 )
			{
				for ( int i = 1; i <= g_Engine.maxClients; i++ )
				{
					CBasePlayer@ pPlayer = g_PlayerFuncs.FindPlayerByIndex( i );
					if ( pPlayer !is null && pPlayer.IsConnected() )
					{
						// To prevent abuse, player must have at least this much score
						if ( pPlayer.pev.frags >= 90.0 ) // Max score is 600~ish. This is 15%
						{
							// Get!
							CustomKeyvalues@ pUnlock = pPlayer.GetCustomKeyvalues();
							pUnlock.SetKeyvalue( "$i_a_unlock", 1 );
						}
					}
				}
				
				g_EntityFuncs.Remove( pCheck );
				return;
			}
		}
	}
}

void toadsnatch_check()
{
	if ( szMap != 'toadsnatch' )
		return;
	
	CBaseEntity@ pCheck = g_EntityFuncs.FindEntityByTargetname( null, "sys_adata" );
	if ( pCheck is null )
		return;
	
	// Weapon check
	CustomKeyvalues@ pKVD = pCheck.GetCustomKeyvalues();
	
	int iWeapons = pKVD.GetKeyvalue( "$i_weapons_found" ).GetInteger();
	if ( iWeapons == 11 )
	{
		for ( int i = 1; i <= g_Engine.maxClients; i++ )
		{
			CBasePlayer@ pPlayer = g_PlayerFuncs.FindPlayerByIndex( i );
			
			if ( pPlayer !is null && pPlayer.IsConnected() )
			{
				if ( pPlayer.pev.frags >= 37.0 ) // 1%. Rounded up
				{
					// Get!
					CustomKeyvalues@ pUnlock = pPlayer.GetCustomKeyvalues();
					pUnlock.SetKeyvalue( "$i_a_unlock", 6 );
				}
			}
		}
		
		// Stop looping
		pKVD.SetKeyvalue( "$i_weapons_found", 0 );
	}
	
	// Get map difficulty
	int iDifficulty = pKVD.GetKeyvalue( "$i_difficulty" ).GetInteger();
	if ( iDifficulty >= 3 ) // Extreme
	{
		// 15 second tolerance before timer start
		if ( pCheck.pev.iuser4 >= 150 )
		{
			// Timer started, just count, we check below for time elapsed
			pCheck.pev.iuser3 = pCheck.pev.iuser3 + 1;
		}
		else
			pCheck.pev.iuser4 = pCheck.pev.iuser4 + 1;
	}
	
	int iCheck = pKVD.GetKeyvalue( "$i_test" ).GetInteger();
	if ( iCheck == 1 )
	{
		for ( int i = 1; i <= g_Engine.maxClients; i++ )
		{
			CBasePlayer@ pPlayer = g_PlayerFuncs.FindPlayerByIndex( i );
			
			if ( pPlayer !is null && pPlayer.IsConnected() )
			{
				// Get map difficulty
				// Max score is 3625~ish on extreme difficulty.
				if ( iDifficulty >= 3 ) // Extreme
				{
					// Extreme diff clear
					if ( pPlayer.pev.frags >= 218.0 ) // 6%. Rounded up
					{
						// Get!
						g_Scheduler.SetTimeout( "a04_unlock", 3.00, pPlayer.entindex() );
					}
					
					// Under 20 minutes?
					if ( pCheck.pev.iuser3 <= 12000 )
					{
						if ( pPlayer.pev.frags >= 108.0 ) // 3%. Rounded down
						{
							// Get!
							g_Scheduler.SetTimeout( "a52_unlock", 4.50, pPlayer.entindex() );
						}
					}
				}
				if ( iDifficulty >= 2 ) // Hard or higher
				{
					if ( pPlayer.pev.frags >= 145.0 ) // 4%
					{
						// Get!
						g_Scheduler.SetTimeout( "a03_unlock", 1.50, pPlayer.entindex() );
					}
				}
				if ( iDifficulty >= 1 ) // Normal or higher
				{
					if ( pPlayer.pev.frags >= 73.0 ) // 2%. Rounded up
					{
						// Get!
						CustomKeyvalues@ pUnlock = pPlayer.GetCustomKeyvalues();
						pUnlock.SetKeyvalue( "$i_a_unlock", 3 );
					}
				}
			}
		}
		
		g_EntityFuncs.Remove( pCheck );
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
void a52_unlock( const int& in index )
{
	CBasePlayer@ pPlayer = g_PlayerFuncs.FindPlayerByIndex( index );
	if ( pPlayer !is null )
	{
		CustomKeyvalues@ pUnlock = pPlayer.GetCustomKeyvalues();
		pUnlock.SetKeyvalue( "$i_a_unlock", 53 );
	}
}

void quarter_check()
{
	if ( szMap != 'quarter' )
		return;
	
	CBaseEntity@ pCheck = g_EntityFuncs.FindEntityByTargetname( null, "sys_adata" );
	if ( pCheck is null )
		return;
	
	CustomKeyvalues@ pKVD = pCheck.GetCustomKeyvalues();
	
	int iCheck1 = pKVD.GetKeyvalue( "$i_active" ).GetInteger();
	if ( iCheck1 == 1 )
	{
		// Reached map end?
		int iCheck2 = pKVD.GetKeyvalue( "$i_test" ).GetInteger();
		if ( iCheck2 == 1 )
		{
			int iCheck3 = pKVD.GetKeyvalue( "$i_fail" ).GetInteger();
			
			// Max score is 600~ish assuming all areas broken.
			
			// Perfect run?
			if ( iCheck3 == 0 )
			{
				for ( int i = 1; i <= g_Engine.maxClients; i++ )
				{
					CBasePlayer@ pPlayer = g_PlayerFuncs.FindPlayerByIndex( i );
					if ( pPlayer !is null && pPlayer.IsConnected() )
					{
						// To prevent abuse, player must have at least this much score
						if ( pPlayer.pev.frags >= 80.0 ) // Too many players will make scoring on this map hard
						{
							// Get!
							
							// HOLD IT! Two achievements are being given at the same time
							// and the system does NOT support that! Wait for our first
							// achievement to be given first and THEN add this one
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
					if ( pPlayer.pev.frags >= 80.0 )
					{
						// Get!
						CustomKeyvalues@ pUnlock = pPlayer.GetCustomKeyvalues();
						pUnlock.SetKeyvalue( "$i_a_unlock", 7 );
					}
				}
			}
			
			g_EntityFuncs.Remove( pCheck );
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
	
	CBaseEntity@ pCheck = g_EntityFuncs.FindEntityByTargetname( null, "sys_adata" );
	if ( pCheck is null )
		return;
	
	CustomKeyvalues@ pKVD = pCheck.GetCustomKeyvalues();
	
	int iCheck = pKVD.GetKeyvalue( "$i_test" ).GetInteger();
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
					CustomKeyvalues@ pPlayerKVD = pPlayer.GetCustomKeyvalues();
					
					// Antigravity check
					int iCheck2 = pPlayerKVD.GetKeyvalue( "$i_gravity" ).GetInteger();
					if ( iCheck2 == 0 )
					{
						// No cheating
						int iCheck3 = pPlayerKVD.GetKeyvalue( "$i_old_gravity" ).GetInteger();
						if ( iCheck3 == 0 )
						{
							// To prevent abuse, player must have at least this much score
							if ( pPlayer.pev.frags >= 45.0 ) // Max score is 300~ish. This is 15%
							{
								// Get!
								pPlayerKVD.SetKeyvalue( "$i_a_unlock", 9 );
							}
						}
					}
				}
			}
		}
		
		g_EntityFuncs.Remove( pCheck );
		return;
	}
}

void mommamesa_check()
{
	if ( szMap != 'mommamesa' )
		return;
	
	CBaseEntity@ pCheck = g_EntityFuncs.FindEntityByTargetname( null, "sys_adata" );
	if ( pCheck is null )
		return;
	
	CustomKeyvalues@ pKVD = pCheck.GetCustomKeyvalues();
	
	int iCheck = pKVD.GetKeyvalue( "$i_test" ).GetInteger();
	if ( iCheck == 1 )
	{
		for ( int i = 1; i <= g_Engine.maxClients; i++ )
		{
			CBasePlayer@ pPlayer = g_PlayerFuncs.FindPlayerByIndex( i );
			
			if ( pPlayer !is null && pPlayer.IsConnected() )
			{
				CustomKeyvalues@ pPlayerKVD = pPlayer.GetCustomKeyvalues();
				
				// Max score is 896~ish on nightmare difficulty. Rounded up.
				
				// Get map difficulty
				int iDifficulty = pKVD.GetKeyvalue( "$i_difficulty" ).GetInteger();
				if ( iDifficulty == 1 ) // Nightmare difficulty?
				{
					int iBest = pKVD.GetKeyvalue( "$i_best" ).GetInteger();
					if ( iBest == 1 ) // Best Ending get?
					{
						// To prevent abuse, player must have at least this much score
						if ( pPlayer.pev.frags >= 180.0 ) // 20%. Rounded up
						{
							// Get!
							
							// Another achievement is being given, wait
							g_Scheduler.SetTimeout( "a11_unlock", 1.50, pPlayer.entindex() );
						}
					}
				}
				
				// Any other difficulty
				// To prevent abuse, player must have at least this much score
				if ( pPlayer.pev.frags >= 135.0 ) // 15%. Rounded up
				{
					// Get!
					pPlayerKVD.SetKeyvalue( "$i_a_unlock", 10 );
				}
				
				// Player escaed the self-destruct sequence?
				int iEscaped = pPlayerKVD.GetKeyvalue( "$i_escape" ).GetInteger();
				if ( iEscaped == 1 )
				{
					// To prevent abuse, player must have at least this much score, YES I'M THAT EVIL ON THIS ONE
					if ( pPlayer.pev.frags >= 44.0 ) // 5%. Rounded down
					{
						// Get!
						
						// Another achievement is being given, wait
						g_Scheduler.SetTimeout( "a10_unlock", 1.50, pPlayer.entindex() );
					}
					
				}
			}
		}
		
		g_EntityFuncs.Remove( pCheck );
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
	
	CBaseEntity@ pCheck = g_EntityFuncs.FindEntityByTargetname( null, "sys_adata" );
	if ( pCheck is null )
		return;
	
	CustomKeyvalues@ pKVD = pCheck.GetCustomKeyvalues();
	
	int iCheck = pKVD.GetKeyvalue( "$i_test" ).GetInteger();
	if ( iCheck == 1 )
	{
		for ( int i = 1; i <= g_Engine.maxClients; i++ )
		{
			CBasePlayer@ pPlayer = g_PlayerFuncs.FindPlayerByIndex( i );
			
			if ( pPlayer !is null && pPlayer.IsConnected() )
			{
				// Max score is 1300~ish on Gonome Hunter gamemode
				int iMode = pKVD.GetKeyvalue( "$i_mode" ).GetInteger();
				if ( iMode == 1 ) // Overload gamemode?
				{
					// To prevent abuse, player must have at least this much score
					if ( pPlayer.pev.frags >= 195.0 ) // 15%
					{
						// Get!
						CustomKeyvalues@ pUnlock = pPlayer.GetCustomKeyvalues();
						pUnlock.SetKeyvalue( "$i_a_unlock", 13 );
					}
				}
				else if ( iMode == 2 ) // Gonome Hunter gamemode?
				{
					// To prevent abuse, player must have at least this much score
					if ( pPlayer.pev.frags >= 260.0 ) // 20%
					{
						// Get!
						CustomKeyvalues@ pUnlock = pPlayer.GetCustomKeyvalues();
						pUnlock.SetKeyvalue( "$i_a_unlock", 14 );
					}
				}
				else if ( iMode == 3 ) // Protection gamemode?
				{
					// To prevent abuse, player must have at least this much score
					if ( pPlayer.pev.frags >= 130.0 ) // 10%
					{
						// Get!
						CustomKeyvalues@ pUnlock = pPlayer.GetCustomKeyvalues();
						pUnlock.SetKeyvalue( "$i_a_unlock", 15 );
					}
				}
			}
		}
		
		g_EntityFuncs.Remove( pCheck );
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
			CustomKeyvalues@ pPlayerKVD = pPlayer.GetCustomKeyvalues();
			int iPass = pPlayerKVD.GetKeyvalue( "$i_pass" ).GetInteger();
			if ( iPass == 1 )
			{
				// Get!
				pPlayerKVD.SetKeyvalue( "$i_a_unlock", 16 );
				
				// Reset to prevent looping
				pPlayerKVD.SetKeyvalue( "$i_pass", 0 );
			}
		}
	}
}

void sandstone_check()
{
	if ( szMap != 'sandstone' )
		return;
	
	CBaseEntity@ pCheck = g_EntityFuncs.FindEntityByTargetname( null, "sys_adata" );
	if ( pCheck is null )
		return;
	
	// 60 second tolerance before timer starts
	if ( pCheck.pev.iuser4 >= 600 )
	{
		// Timer started, finished in less than 9 minutes?
		if ( pCheck.pev.iuser3 <= 5400 )
		{
			CustomKeyvalues@ pKVD = pCheck.GetCustomKeyvalues();
			
			int iCheck = pKVD.GetKeyvalue( "$i_test" ).GetInteger();
			if ( iCheck == 1 )
			{
				for ( int i = 1; i <= g_Engine.maxClients; i++ )
				{
					CBasePlayer@ pPlayer = g_PlayerFuncs.FindPlayerByIndex( i );
					
					if ( pPlayer !is null && pPlayer.IsConnected() )
					{
						// To prevent abuse, player must have at least this much score
						if ( pPlayer.pev.frags >= 25.0 ) // Max score of 500~ish. This is 5%
						{
							// Get!
							CustomKeyvalues@ pUnlock = pPlayer.GetCustomKeyvalues();
							pUnlock.SetKeyvalue( "$i_a_unlock", 17 );
						}
					}
				}
				
				g_EntityFuncs.Remove( pCheck );
				return;
			}
		}
		
		pCheck.pev.iuser3 = pCheck.pev.iuser3 + 1;
	}
	else
		pCheck.pev.iuser4 = pCheck.pev.iuser4 + 1;
}

void jumpers_check()
{
	if ( szMap != 'jumpers' )
		return;
	
	CBaseEntity@ pCheck = g_EntityFuncs.FindEntityByTargetname( null, "sys_adata" );
	if ( pCheck is null )
		return;
	
	CustomKeyvalues@ pKVD = pCheck.GetCustomKeyvalues();
	
	int iCheck = pKVD.GetKeyvalue( "$i_active" ).GetInteger();
	if ( iCheck == 1 )
	{
		// Timer started, 60 minutes has yet to lapse?
		if ( pCheck.pev.iuser3 <= 36000 )
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
				
				g_EntityFuncs.Remove( pCheck );
				return;
			}
		}
		
		pCheck.pev.iuser3 = pCheck.pev.iuser3 + 1;
	}
}

void fortified1_check()
{
	if ( szMap != 'fortified1' )
		return;
	
	CBaseEntity@ pCheck = g_EntityFuncs.FindEntityByTargetname( null, "sys_adata" );
	if ( pCheck is null )
		return;
	
	CustomKeyvalues@ pKVD = pCheck.GetCustomKeyvalues();
	
	int iCheck = pKVD.GetKeyvalue( "$i_test" ).GetInteger();
	if ( iCheck == 1 )
	{
		for ( int i = 1; i <= g_Engine.maxClients; i++ )
		{
			CBasePlayer@ pPlayer = g_PlayerFuncs.FindPlayerByIndex( i );
			
			if ( pPlayer !is null && pPlayer.IsConnected() )
			{
				CustomKeyvalues@ pUnlock = pPlayer.GetCustomKeyvalues();
				
				// Max score is of 1300~ish on Ultra Hard difficulty
				
				// Survival mode activated?
				int iSurvival = pKVD.GetKeyvalue( "$i_survival" ).GetInteger();
				if ( iSurvival == 1 )
				{
					// Ultra Hard difficulty selected?
					int iDifficulty = pKVD.GetKeyvalue( "$i_difficulty" ).GetInteger();
					if ( iDifficulty == 3 )
					{
						// To prevent abuse, player must have at least this much score
						if ( pPlayer.pev.frags >= 195.0 ) // 15%
						{
							// Get!
							
							// x6 achievements? Okay, handle very carefully the delays
							g_Scheduler.SetTimeout( "a23_unlock", 1.5, pPlayer.entindex() );
						}
					}
					
					// Any difficulty clear
					if ( pPlayer.pev.frags >= 65.0 ) // 5%
					{
						// Get!
						pUnlock.SetKeyvalue( "$i_a_unlock", 22 );
					}
				}
				else // Classic mode
				{
					// Difficulty clear
					
					// Get map difficulty
					int iDifficulty = pKVD.GetKeyvalue( "$i_difficulty" ).GetInteger();
					switch ( iDifficulty )
					{
						case 3:
						{
							if ( pPlayer.pev.frags >= 195.0 ) // 15%
							{
								// Get!
								g_Scheduler.SetTimeout( "a20_unlock", 3.0, pPlayer.entindex() );
							}
						}
						case 2:
						{
							if ( pPlayer.pev.frags >= 130.0 ) // 10%
							{
								// Get!
								g_Scheduler.SetTimeout( "a19_unlock", 1.5, pPlayer.entindex() );
							}
						}
						case 1:
						{
							if ( pPlayer.pev.frags >= 65.0 ) // 5%
							{
								// Get!
								pUnlock.SetKeyvalue( "$i_a_unlock", 19 );
							}
						}
					}
				}
				
				// Helper commander?
				int iLeft = pUnlock.GetKeyvalue( "$i_left" ).GetInteger();
				if ( iLeft == 1 )
				{
					// The commander must also did it's effort fighting, and a little tip bonus as well
					if ( pPlayer.pev.frags >= 220.0 ) // 17%. Rounded down
					{
						// Get!
						g_Scheduler.SetTimeout( "a22_unlock", 4.5, pPlayer.entindex() );
					}
				}
			}
		}
		
		g_EntityFuncs.Remove( pCheck );
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
	
	CBaseEntity@ pCheck = g_EntityFuncs.FindEntityByTargetname( null, "sys_adata" );
	if ( pCheck is null )
		return;
	
	CustomKeyvalues@ pKVD = pCheck.GetCustomKeyvalues();
	
	int iCheck = pKVD.GetKeyvalue( "$i_test" ).GetInteger();
	if ( iCheck == 1 )
	{
		for ( int i = 1; i <= g_Engine.maxClients; i++ )
		{
			CBasePlayer@ pPlayer = g_PlayerFuncs.FindPlayerByIndex( i );
			
			if ( pPlayer !is null && pPlayer.IsConnected() )
			{
				CustomKeyvalues@ pPlayerKVD = pPlayer.GetCustomKeyvalues();
				
				int iSecret = pPlayerKVD.GetKeyvalue( "$i_secret" ).GetInteger();
				int iButtons = pPlayerKVD.GetKeyvalue( "$i_buttons" ).GetInteger();
				
				// This player activated the secret?
				if ( iSecret >= 0 )
				{
					// This player solved the puzzle instead of someone else?
					if ( iButtons >= 10 )
					{
						// Get!
						pPlayerKVD.SetKeyvalue( "$i_a_unlock", 25 );
					}
				}
			}
		}
		
		g_EntityFuncs.Remove( pCheck );
		return;
	}
}

void sc_doc_check()
{
	if ( szMap != 'sc_doc' )
		return;
	
	CBaseEntity@ pCheck = g_EntityFuncs.FindEntityByTargetname( null, "sys_adata" );
	if ( pCheck is null )
		return;
	
	CustomKeyvalues@ pKVD = pCheck.GetCustomKeyvalues();
	
	int iCheck = pKVD.GetKeyvalue( "$i_test" ).GetInteger();
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
					if ( pPlayer.pev.frags >= 30.0 ) // Max score of 300~ish. This is 10%
					{
						// Get!
						CustomKeyvalues@ pUnlock = pPlayer.GetCustomKeyvalues();
						pUnlock.SetKeyvalue( "$i_a_unlock", 27 );
					}
				}
			}
		}
		
		g_EntityFuncs.Remove( pCheck );
		return;
	}
}

void sc_psyko_check()
{
	if ( szMap != 'sc_psyko' )
		return;
	
	CBaseEntity@ pCheck = g_EntityFuncs.FindEntityByTargetname( null, "sys_adata" );
	if ( pCheck is null )
		return;
	
	CustomKeyvalues@ pKVD = pCheck.GetCustomKeyvalues();
	
	int iCheck = pKVD.GetKeyvalue( "$i_test" ).GetInteger();
	if ( iCheck == 1 )
	{
		for ( int i = 1; i <= g_Engine.maxClients; i++ )
		{
			CBasePlayer@ pPlayer = g_PlayerFuncs.FindPlayerByIndex( i );
			
			if ( pPlayer !is null && pPlayer.IsConnected() )
			{
				CustomKeyvalues@ pPlayerKVD = pPlayer.GetCustomKeyvalues();
				
				// No skills check
				int iSkill1 = pPlayerKVD.GetKeyvalue( "$i_health" ).GetInteger();
				int iSkill2 = pPlayerKVD.GetKeyvalue( "$i_armor" ).GetInteger();
				int iSkill3 = pPlayerKVD.GetKeyvalue( "$i_rhealth" ).GetInteger();
				int iSkill4 = pPlayerKVD.GetKeyvalue( "$i_rarmor" ).GetInteger();
				int iSkill5 = pPlayerKVD.GetKeyvalue( "$i_rammo" ).GetInteger();
				int iSkill6 = pPlayerKVD.GetKeyvalue( "$i_gravity" ).GetInteger();
				int iSkill7 = pPlayerKVD.GetKeyvalue( "$i_speed" ).GetInteger();
				int iSkill8 = pPlayerKVD.GetKeyvalue( "$i_dist" ).GetInteger();
				int iSkill9 = pPlayerKVD.GetKeyvalue( "$i_dodge" ).GetInteger();
				if ( iSkill1 == 0 && iSkill2 == 0 && iSkill3 == 0 && iSkill4 == 0 && iSkill5 == 0 && iSkill6 == 0 && iSkill7 == 0 && iSkill8 == 0 && iSkill9 == 0 )
				{
					// No cheating check
					int iOldSkill1 = pPlayerKVD.GetKeyvalue( "$i_old_health" ).GetInteger();
					int iOldSkill2 = pPlayerKVD.GetKeyvalue( "$i_old_armor" ).GetInteger();
					int iOldSkill3 = pPlayerKVD.GetKeyvalue( "$i_old_rhealth" ).GetInteger();
					int iOldSkill4 = pPlayerKVD.GetKeyvalue( "$i_old_rarmor" ).GetInteger();
					int iOldSkill5 = pPlayerKVD.GetKeyvalue( "$i_old_rammo" ).GetInteger();
					int iOldSkill6 = pPlayerKVD.GetKeyvalue( "$i_old_gravity" ).GetInteger();
					int iOldSkill7 = pPlayerKVD.GetKeyvalue( "$i_old_speed" ).GetInteger();
					int iOldSkill8 = pPlayerKVD.GetKeyvalue( "$i_old_dist" ).GetInteger();
					int iOldSkill9 = pPlayerKVD.GetKeyvalue( "$i_old_dodge" ).GetInteger();
					if ( iOldSkill1 == 0 && iOldSkill2 == 0 && iOldSkill3 == 0 && iOldSkill4 == 0 && iOldSkill5 == 0 && iOldSkill6 == 0 && iOldSkill7 == 0 && iOldSkill8 == 0 && iOldSkill9 == 0 )
					{
						// To prevent abuse, player must have at least this much score
						if ( pPlayer.pev.frags >= 80.0 ) // Max score of 800~ish. This is 10%
						{
							// Get!
							pPlayerKVD.SetKeyvalue( "$i_a_unlock", 28 );
						}
					}
				}
			}
		}
		
		g_EntityFuncs.Remove( pCheck );
		return;
	}
}

void turretfortress_check()
{
	if ( szMap != 'turretfortress' )
		return;
	
	CBaseEntity@ pCheck = g_EntityFuncs.FindEntityByTargetname( null, "sys_adata" );
	if ( pCheck is null )
		return;
	
	CustomKeyvalues@ pKVD = pCheck.GetCustomKeyvalues();
	
	int iCheck = pKVD.GetKeyvalue( "$i_test" ).GetInteger();
	if ( iCheck == 1 )
	{
		for ( int i = 1; i <= g_Engine.maxClients; i++ )
		{
			CBasePlayer@ pPlayer = g_PlayerFuncs.FindPlayerByIndex( i );
			
			if ( pPlayer !is null && pPlayer.IsConnected() )
			{
				// Playing on hard difficulty?
				int iDifficulty = pKVD.GetKeyvalue( "$i_difficulty" ).GetInteger();
				if ( iDifficulty == 1 )
				{
					// To prevent abuse, player must have at least this much score
					if ( pPlayer.pev.frags >= 105.0 ) // Max score of 3500~ish. This is 3%
					{
						// Get!
						CustomKeyvalues@ pUnlock = pPlayer.GetCustomKeyvalues();
						pUnlock.SetKeyvalue( "$i_a_unlock", 29 );
					}
				}
			}
		}
		
		g_EntityFuncs.Remove( pCheck );
		return;
	}
	
	// Second achievement
	int iObjetives = pKVD.GetKeyvalue( "$i_objetives" ).GetInteger();
	if ( iObjetives >= 6 )
	{
		for ( int i = 1; i <= g_Engine.maxClients; i++ )
		{
			CBasePlayer@ pPlayer = g_PlayerFuncs.FindPlayerByIndex( i );
			
			if ( pPlayer !is null && pPlayer.IsConnected() )
			{
				// To prevent abuse, player must have at least this much score
				if ( pPlayer.pev.frags >= 70.0 ) // Max score of 3500~ish. This is 2%
				{
					// Get!
					CustomKeyvalues@ pUnlock = pPlayer.GetCustomKeyvalues();
					pUnlock.SetKeyvalue( "$i_a_unlock", 38 );
				}
			}
		}
		
		// Reset, no looping
		pKVD.SetKeyvalue( "$i_objetives", 0 );
	}
}

void tf_original_check()
{
	if ( szMap != 'tf_original' )
		return;
	
	CBaseEntity@ pCheck = g_EntityFuncs.FindEntityByTargetname( null, "sys_adata" );
	if ( pCheck is null )
		return;
	
	CustomKeyvalues@ pKVD = pCheck.GetCustomKeyvalues();
	for ( int i = 1; i <= g_Engine.maxClients; i++ )
	{
		CBasePlayer@ pPlayer = g_PlayerFuncs.FindPlayerByIndex( i );
		
		if ( pPlayer !is null && pPlayer.IsConnected() )
		{
			// Playing on hard difficulty?
			int iDifficulty = pKVD.GetKeyvalue( "$i_difficulty" ).GetInteger();
			if ( iDifficulty == 1 )
			{
				CustomKeyvalues@ pPlayerKVD = pPlayer.GetCustomKeyvalues();
				int iCheck = pKVD.GetKeyvalue( "$i_test" ).GetInteger();
				
				if ( iCheck == 0 )
				{
					CustomKeyvalue vecLastMove_pre( pPlayerKVD.GetKeyvalue( "$v_last_move" ) );
					if ( vecLastMove_pre.Exists() )
					{
						Vector vecLastMove = vecLastMove_pre.GetVector();
						
						// Add distance traveled
						int iDistance = pPlayerKVD.GetKeyvalue( "$i_distance" ).GetInteger();
						pPlayerKVD.SetKeyvalue( "$i_distance", ( iDistance + ( vecLastMove - pPlayer.pev.origin ).Length() ) );
						
						pPlayerKVD.SetKeyvalue( "$v_last_move", pPlayer.pev.origin );
					}
					else
					{
						pPlayerKVD.SetKeyvalue( "$v_last_move", pPlayer.pev.origin );
					}
				}
				else
				{
					// Enough travel distance?
					int iDistance = pPlayerKVD.GetKeyvalue( "$i_distance" ).GetInteger();
					if ( iDistance >= 40960 )
					{
						// Get!
						pPlayerKVD.SetKeyvalue( "$i_a_unlock", 30 );
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
	
	CBaseEntity@ pCheck = g_EntityFuncs.FindEntityByTargetname( null, "sys_adata" );
	if ( pCheck is null )
		return;
	
	CustomKeyvalues@ pKVD = pCheck.GetCustomKeyvalues();
	
	int iCheck = pKVD.GetKeyvalue( "$i_test" ).GetInteger();
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
					if ( pPlayer.pev.frags >= 86.0 ) // Max score of 2850~ish. This is 3%. Rounded up
					{
						// Get!
						CustomKeyvalues@ pUnlock = pPlayer.GetCustomKeyvalues();
						pUnlock.SetKeyvalue( "$i_a_unlock", 31 );
					}
				}
			}
		}
		
		g_EntityFuncs.Remove( pCheck );
		return;
	}
}

void sc_mazing_check()
{
	if ( szMap != 'sc_mazing' )
		return;
	
	CBaseEntity@ pCheck = g_EntityFuncs.FindEntityByTargetname( null, "sys_adata" );
	if ( pCheck is null )
		return;
	
	CustomKeyvalues@ pKVD = pCheck.GetCustomKeyvalues();
	int iKills = pKVD.GetKeyvalue( "$i_kills" ).GetInteger();
	if ( iKills == 21 ) // All Pit Drones/Baby Gargantuas killed?
	{
		for ( int i = 1; i <= g_Engine.maxClients; i++ )
		{
			CBasePlayer@ pPlayer = g_PlayerFuncs.FindPlayerByIndex( i );
			
			if ( pPlayer !is null && pPlayer.IsConnected() )
			{
				// To prevent abuse, player must have at least this much score
				if ( pPlayer.pev.frags >= 70.0 ) // Max score of 700~ish. This is 10%
				{
					// Get!
					CustomKeyvalues@ pUnlock = pPlayer.GetCustomKeyvalues();
					pUnlock.SetKeyvalue( "$i_a_unlock", 32 );
				}
			}
		}
		
		// Reset, no looping
		pKVD.SetKeyvalue( "$i_kills", 0 );
	}
	
	// Speedrun achievement
	// 60 second tolerance before timer starts
	if ( pCheck.pev.iuser4 >= 600 )
	{
		// Timer started, finished in less than 21 minutes?
		if ( pCheck.pev.iuser3 <= 12600 )
		{
			int iCheck = pKVD.GetKeyvalue( "$i_test" ).GetInteger();
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
				
				g_EntityFuncs.Remove( pCheck );
				return;
			}
		}
		
		pCheck.pev.iuser3 = pCheck.pev.iuser3 + 1;
	}
	else
		pCheck.pev.iuser4 = pCheck.pev.iuser4 + 1;
}

void sc_tetris1_check()
{
	if ( szMap != 'sc_tetris1' )
		return;
	
	CBaseEntity@ pCheck = g_EntityFuncs.FindEntityByTargetname( null, "sys_adata" );
	if ( pCheck is null )
		return;
	
	CustomKeyvalues@ pKVD = pCheck.GetCustomKeyvalues();
	
	int iCheck = pKVD.GetKeyvalue( "$i_run" ).GetInteger();
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
					thefile.Write( g_EngineFuncs.GetPlayerAuthId( pPlayer.edict() ) + "\n" );
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
		
		g_EntityFuncs.Remove( pCheck );
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
				thefile.Write( g_EngineFuncs.GetPlayerAuthId( pPlayer.edict() ) + "\n" );
			}
		}
		
		thefile.Close();
	}
}

void sc_tetris6_check()
{
	if ( szMap != 'sc_tetris6' )
		return;
	
	CBaseEntity@ pCheck = g_EntityFuncs.FindEntityByTargetname( null, "sys_adata" );
	if ( pCheck is null )
		return;
	
	// 65 second tolerance before timer starts
	if ( pCheck.pev.iuser4 >= 651 && pCheck.pev.iuser3 == 0 )
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
					thefile.Write( g_EngineFuncs.GetPlayerAuthId( pPlayer.edict() ) + "\n" );
				}
			}
			
			thefile.Close();
		}
		
		pCheck.pev.iuser3 = 1;
	}
	else
		pCheck.pev.iuser4 = pCheck.pev.iuser4 + 1;
	
	CustomKeyvalues@ pKVD = pCheck.GetCustomKeyvalues();
	
	int iCheck = pKVD.GetKeyvalue( "$i_test" ).GetInteger();
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
							if ( pPlayer.pev.frags >= 96.0 ) // Max score of 484~ish. This is 20%. Rounded down
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
		
		g_EntityFuncs.Remove( pCheck );
		return;
	}
}

void toonrun3_check()
{
	if ( szMap != 'toonrun3' )
		return;
	
	CBaseEntity@ pCheck = g_EntityFuncs.FindEntityByTargetname( null, "sys_adata" );
	if ( pCheck is null )
		return;
	
	CustomKeyvalues@ pKVD = pCheck.GetCustomKeyvalues();
	
	int iCheck = pKVD.GetKeyvalue( "$i_test" ).GetInteger();
	if ( iCheck == 1 )
	{
		int iFail = pKVD.GetKeyvalue( "$i_fail" ).GetInteger();
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
		
		g_EntityFuncs.Remove( pCheck );
		return;
	}
}

void suspension_check()
{
	if ( szMap != 'suspension' )
		return;
	
	CBaseEntity@ pCheck = g_EntityFuncs.FindEntityByTargetname( null, "sys_adata" );
	if ( pCheck is null )
		return;
	
	CustomKeyvalues@ pKVD = pCheck.GetCustomKeyvalues();
	
	int iCheck = pKVD.GetKeyvalue( "$i_test" ).GetInteger();
	if ( iCheck == 1 )
	{
		for ( int i = 1; i <= g_Engine.maxClients; i++ )
		{
			CBasePlayer@ pPlayer = g_PlayerFuncs.FindPlayerByIndex( i );
			
			if ( pPlayer !is null && pPlayer.IsConnected() )
			{
				// To prevent abuse, player must have at least this much score
				if ( pPlayer.pev.frags >= 30.0 ) // Unknown max score. Generic limiter
				{
					// Insane difficulty?
					int iDifficulty = pKVD.GetKeyvalue( "$i_difficulty" ).GetInteger();
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
		
		g_EntityFuncs.Remove( pCheck );
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
	
	CBaseEntity@ pCheck = g_EntityFuncs.FindEntityByTargetname( null, "sys_adata" );
	if ( pCheck is null )
		return;
	
	CustomKeyvalues@ pKVD = pCheck.GetCustomKeyvalues();
	
	int iCheck = pKVD.GetKeyvalue( "$i_test" ).GetInteger();
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
					int iDifficulty = pKVD.GetKeyvalue( "$i_active" ).GetInteger();
					if ( iDifficulty == 1 )
					{
						// Get!
						CustomKeyvalues@ pUnlock = pPlayer.GetCustomKeyvalues();
						pUnlock.SetKeyvalue( "$i_a_unlock", 39 );
					}
				}
			}
		}
		
		g_EntityFuncs.Remove( pCheck );
		return;
	}
}

void infested_check()
{
	if ( szMap != 'infested' )
		return;
	
	CBaseEntity@ pCheck = g_EntityFuncs.FindEntityByTargetname( null, "sys_adata" );
	if ( pCheck is null )
		return;
	
	// Osprey destroyed?
	CustomKeyvalues@ pKVD = pCheck.GetCustomKeyvalues();
	
	int iCheck = pKVD.GetKeyvalue( "$i_active" ).GetInteger();
	if ( iCheck == 1 )
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

void sc_face_check()
{
	if ( szMap != 'sc_face' )
		return;
	
	CBaseEntity@ pCheck = g_EntityFuncs.FindEntityByTargetname( null, "sys_adata" );
	if ( pCheck is null )
		return;
	
	CustomKeyvalues@ pKVD = pCheck.GetCustomKeyvalues();
	
	int iCheck = pKVD.GetKeyvalue( "$i_test" ).GetInteger();
	if ( iCheck == 1 )
	{
		for ( int i = 1; i <= g_Engine.maxClients; i++ )
		{
			CBasePlayer@ pPlayer = g_PlayerFuncs.FindPlayerByIndex( i );
			
			if ( pPlayer !is null && pPlayer.IsConnected() )
			{
				// Under 2 deaths?
				if ( pPlayer.m_iDeaths < 2 )
				{
					// To prevent abuse, player must have at least this much score
					if ( pPlayer.pev.frags >= 60.0 ) // Max score is 400~ish. This is 15%
					{
						// Get!
						CustomKeyvalues@ pUnlock = pPlayer.GetCustomKeyvalues();
						pUnlock.SetKeyvalue( "$i_a_unlock", 41 );
					}
				}
			}
		}
		
		g_EntityFuncs.Remove( pCheck );
		return;
	}
}

void F_5minutes_b1_check()
{
	if ( szMap != '5minutes_b1' )
		return;
	
	CBaseEntity@ pCheck = g_EntityFuncs.FindEntityByTargetname( null, "sys_adata" );
	if ( pCheck is null )
		return;
	
	CustomKeyvalues@ pKVD = pCheck.GetCustomKeyvalues();
	
	int iCheck = pKVD.GetKeyvalue( "$i_test" ).GetInteger();
	if ( iCheck == 1 )
	{
		for ( int i = 1; i <= g_Engine.maxClients; i++ )
		{
			CBasePlayer@ pPlayer = g_PlayerFuncs.FindPlayerByIndex( i );
			
			if ( pPlayer !is null && pPlayer.IsConnected() )
			{
				// To prevent abuse, player must have at least this much score
				if ( pPlayer.pev.frags >= 5.0 ) // Max score is 100~ish. This is 5%
				{
					// Get!
					CustomKeyvalues@ pUnlock = pPlayer.GetCustomKeyvalues();
					pUnlock.SetKeyvalue( "$i_a_unlock", 42 );
				}
			}
		}
		
		g_EntityFuncs.Remove( pCheck );
		return;
	}
}

void never_check()
{
	if ( szMap != 'never' )
		return;
	
	CBaseEntity@ pCheck = g_EntityFuncs.FindEntityByTargetname( null, "sys_adata" );
	if ( pCheck is null )
		return;
	
	CustomKeyvalues@ pKVD = pCheck.GetCustomKeyvalues();
	
	int iCheck = pKVD.GetKeyvalue( "$i_test" ).GetInteger();
	if ( iCheck == 1 )
	{
		for ( int i = 1; i <= g_Engine.maxClients; i++ )
		{
			CBasePlayer@ pPlayer = g_PlayerFuncs.FindPlayerByIndex( i );
			
			if ( pPlayer !is null && pPlayer.IsConnected() )
			{
				// Under 2 deaths?
				if ( pPlayer.m_iDeaths < 2 )
				{
					// To prevent abuse, player must have at least this much score
					if ( pPlayer.pev.frags >= 60.0 ) // Max score of 400~ish. This is 15%
					{
						// Get!
						CustomKeyvalues@ pUnlock = pPlayer.GetCustomKeyvalues();
						pUnlock.SetKeyvalue( "$i_a_unlock", 43 );
					}
				}
			}
		}
		
		g_EntityFuncs.Remove( pCheck );
		return;
	}
}

void ub_nagoya_v2_check()
{
	if ( szMap != 'ub_nagoya_v2' )
		return;
	
	CBaseEntity@ pCheck = g_EntityFuncs.FindEntityByTargetname( null, "sys_adata" );
	if ( pCheck is null )
		return;
	
	CustomKeyvalues@ pKVD = pCheck.GetCustomKeyvalues();
	
	// All 5 boxes breaken?
	int iCheck = pKVD.GetKeyvalue( "$i_boxes" ).GetInteger();
	if ( iCheck == 5 )
	{
		for ( int i = 1; i <= g_Engine.maxClients; i++ )
		{
			CBasePlayer@ pPlayer = g_PlayerFuncs.FindPlayerByIndex( i );
			
			if ( pPlayer !is null && pPlayer.IsConnected() )
			{
				// Check whenever a player has destroyed at least 1 secret box
				CustomKeyvalues@ pPlayerKVD = pPlayer.GetCustomKeyvalues();
				int iBoxes = pPlayerKVD.GetKeyvalue( "$i_boxes" ).GetInteger();
				if ( iBoxes >= 1 )
				{
					// Get!
					pPlayerKVD.SetKeyvalue( "$i_a_unlock", 44 );
				}
			}
		}
		
		g_EntityFuncs.Remove( pCheck );
		return;
	}
}

void ub_iseki2_check()
{
	if ( szMap != 'ub_iseki2' )
		return;
	
	CBaseEntity@ pCheck = g_EntityFuncs.FindEntityByTargetname( null, "sys_adata" );
	if ( pCheck is null )
		return;
	
	CustomKeyvalues@ pKVD = pCheck.GetCustomKeyvalues();
	
	int iCheck = pKVD.GetKeyvalue( "$i_test" ).GetInteger();
	if ( iCheck == 1 )
	{
		for ( int i = 1; i <= g_Engine.maxClients; i++ )
		{
			CBasePlayer@ pPlayer = g_PlayerFuncs.FindPlayerByIndex( i );
			
			if ( pPlayer !is null && pPlayer.IsConnected() )
			{
				// Under 4 deaths?
				if ( pPlayer.m_iDeaths < 4 )
				{
					// To prevent abuse, player must have at least this much score
					if ( pPlayer.pev.frags >= 40.0 ) // Max score is 200~ish. This is 20%
					{
						// Get!
						CustomKeyvalues@ pUnlock = pPlayer.GetCustomKeyvalues();
						pUnlock.SetKeyvalue( "$i_a_unlock", 45 );
					}
				}
			}
		}
		
		g_EntityFuncs.Remove( pCheck );
		return;
	}
}

void sciguard2_check()
{
	if ( szMap != 'sciguard2' )
		return;
	
	CBaseEntity@ pCheck = g_EntityFuncs.FindEntityByTargetname( null, "sys_adata" );
	if ( pCheck is null )
		return;
	
	CustomKeyvalues@ pKVD = pCheck.GetCustomKeyvalues();
	
	int iCheck1 = pKVD.GetKeyvalue( "$i_test" ).GetInteger();
	if ( iCheck1 == 1 )
	{
		// No scientist deaths
		int iCheck2 = pKVD.GetKeyvalue( "$i_fail" ).GetInteger();
		if ( iCheck2 == 0 )
		{
			for ( int i = 1; i <= g_Engine.maxClients; i++ )
			{
				CBasePlayer@ pPlayer = g_PlayerFuncs.FindPlayerByIndex( i );
				
				if ( pPlayer !is null && pPlayer.IsConnected() )
				{
					// To prevent abuse, player must have at least this much score
					if ( pPlayer.pev.frags >= 70.0 ) // Max score of 1400~ish. This is 5%
					{
						// Get!
						CustomKeyvalues@ pUnlock = pPlayer.GetCustomKeyvalues();
						pUnlock.SetKeyvalue( "$i_a_unlock", 46 );
					}
				}
			}
		}
		
		g_EntityFuncs.Remove( pCheck );
		return;
	}
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
			CustomKeyvalues@ pPlayerKVD = pPlayer.GetCustomKeyvalues();
			int iPass = pPlayerKVD.GetKeyvalue( "$i_clear" ).GetInteger();
			if ( iPass == 1 )
			{
				// Get!
				pPlayerKVD.SetKeyvalue( "$i_a_unlock", 47 );
				
				// Reset to prevent looping
				pPlayerKVD.SetKeyvalue( "$i_clear", 0 );
			}
		}
	}
}

void zero_check()
{
	if ( szMap != 'zero' )
		return;
	
	CBaseEntity@ pCheck = g_EntityFuncs.FindEntityByTargetname( null, "sys_adata" );
	if ( pCheck is null )
		return;
	
	CustomKeyvalues@ pKVD = pCheck.GetCustomKeyvalues();
	
	int iCheck = pKVD.GetKeyvalue( "$i_test" ).GetInteger();
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
					CustomKeyvalues@ pPlayerKVD = pPlayer.GetCustomKeyvalues();
					
					int iHandicap01 = pPlayerKVD.GetKeyvalue( "$i_handicap01" ).GetInteger();
					
					if ( iHandicap01 == 1 )
					{
						// To prevent abuse, player must have at least this much score
						if ( pPlayer.pev.frags >= 15.0 ) // Max score of 300~ish. This is 5%
						{
							// Get!
							pPlayerKVD.SetKeyvalue( "$i_a_unlock", 48 );
						}
					}
				}
			}
		}
		
		g_EntityFuncs.Remove( pCheck );
		return;
	}
}

void clockwork_check()
{
	if ( szMap != 'clockwork' )
		return;
	
	CBaseEntity@ pCheck = g_EntityFuncs.FindEntityByTargetname( null, "sys_adata" );
	if ( pCheck is null )
		return;
	
	CustomKeyvalues@ pKVD = pCheck.GetCustomKeyvalues();
	
	int iCheck = pKVD.GetKeyvalue( "$i_test" ).GetInteger();
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
					CustomKeyvalues@ pPlayerKVD = pPlayer.GetCustomKeyvalues();
					
					// No team power?
					int iSkill8 = pKVD.GetKeyvalue( "$i_dist" ).GetInteger();
					if ( iSkill8 == 0 )
					{
						// No cheating check
						int iOldSkill8 = pKVD.GetKeyvalue( "$i_old_dist" ).GetInteger();
						if ( iOldSkill8 == 0 )
						{
							// To prevent abuse, player must have at least this much score
							if ( pPlayer.pev.frags >= 20.0 ) // Max score of 200~ish. This is 10%
							{
								// Get!
								pPlayerKVD.SetKeyvalue( "$i_a_unlock", 49 );
							}
						}
					}
				}
			}
		}
		
		g_EntityFuncs.Remove( pCheck );
		return;
	}
}

void sectore_3_check()
{
	if ( szMap != 'sectore_3' )
		return;
	
	CBaseEntity@ pCheck = g_EntityFuncs.FindEntityByTargetname( null, "sys_adata" );
	if ( pCheck is null )
		return;
	
	CustomKeyvalues@ pKVD = pCheck.GetCustomKeyvalues();
	
	int iCheck = pKVD.GetKeyvalue( "$i_test" ).GetInteger();
	if ( iCheck == 1 )
	{
		for ( int i = 1; i <= g_Engine.maxClients; i++ )
		{
			CBasePlayer@ pPlayer = g_PlayerFuncs.FindPlayerByIndex( i );
			
			if ( pPlayer !is null && pPlayer.IsConnected() )
			{
				// To prevent abuse, player must have at least this much score
				if ( pPlayer.pev.frags >= 70.0 ) // Max score of 700~ish. This is 10%
				{
					// Get!
					CustomKeyvalues@ pUnlock = pPlayer.GetCustomKeyvalues();
					pUnlock.SetKeyvalue( "$i_a_unlock", 50 );
				}
			}
		}
		
		g_EntityFuncs.Remove( pCheck );
		return;
	}
}

void nm_darkisland_check()
{
	if ( szMap != 'nm_darkisland' )
		return;
	
	CBaseEntity@ pCheck = g_EntityFuncs.FindEntityByTargetname( null, "sys_adata" );
	if ( pCheck is null )
		return;
	
	CustomKeyvalues@ pKVD = pCheck.GetCustomKeyvalues();
	
	int iCheck = pKVD.GetKeyvalue( "$i_test" ).GetInteger();
	if ( iCheck == 1 )
	{
		for ( int i = 1; i <= g_Engine.maxClients; i++ )
		{
			CBasePlayer@ pPlayer = g_PlayerFuncs.FindPlayerByIndex( i );
			
			if ( pPlayer !is null && pPlayer.IsConnected() )
			{
				// Handicap enabled?
				CustomKeyvalues@ pPlayerKVD = pPlayer.GetCustomKeyvalues();
				
				int iHandicap05 = pPlayerKVD.GetKeyvalue( "$i_handicap05" ).GetInteger();
				if ( iHandicap05 == 1 )
				{
					// To prevent abuse, player must have at least this much score
					if ( pPlayer.pev.frags >= 80.0 ) // Read above.
					{
						// Get!
						CustomKeyvalues@ pUnlock = pPlayer.GetCustomKeyvalues();
						pUnlock.SetKeyvalue( "$i_a_unlock", 51 );
					}
				}
			}
		}
		
		g_EntityFuncs.Remove( pCheck );
		return;
	}
}

void why1_check()
{
	if ( szMap != 'why1' )
		return;
	
	CBaseEntity@ pCheck = g_EntityFuncs.FindEntityByTargetname( null, "sys_adata" );
	if ( pCheck is null )
		return;
	
	// 60 second tolerance before timer starts
	if ( pCheck.pev.iuser4 >= 600 )
	{
		// Timer started, finished in less than 20 minutes?
		if ( pCheck.pev.iuser3 <= 12000 )
		{
			CustomKeyvalues@ pKVD = pCheck.GetCustomKeyvalues();
			
			int iCheck = pKVD.GetKeyvalue( "$i_test" ).GetInteger();
			if ( iCheck == 1 )
			{
				for ( int i = 1; i <= g_Engine.maxClients; i++ )
				{
					CBasePlayer@ pPlayer = g_PlayerFuncs.FindPlayerByIndex( i );
					
					if ( pPlayer !is null && pPlayer.IsConnected() )
					{
						// Handicap check
						CustomKeyvalues@ pPlayerKVD = pPlayer.GetCustomKeyvalues();
						
						int iHandicaps = 0;
						iHandicaps += pPlayerKVD.GetKeyvalue( "$i_handicap01" ).GetInteger();
						iHandicaps += pPlayerKVD.GetKeyvalue( "$i_handicap02" ).GetInteger();
						iHandicaps += pPlayerKVD.GetKeyvalue( "$i_handicap03" ).GetInteger();
						iHandicaps += pPlayerKVD.GetKeyvalue( "$i_handicap04" ).GetInteger();
						iHandicaps += pPlayerKVD.GetKeyvalue( "$i_handicap05" ).GetInteger();
						iHandicaps += pPlayerKVD.GetKeyvalue( "$i_handicap06" ).GetInteger();
						iHandicaps += pPlayerKVD.GetKeyvalue( "$i_handicap07" ).GetInteger();
						iHandicaps += pPlayerKVD.GetKeyvalue( "$i_handicap08" ).GetInteger();
						iHandicaps += pPlayerKVD.GetKeyvalue( "$i_handicap09" ).GetInteger();
						iHandicaps += pPlayerKVD.GetKeyvalue( "$i_handicap10" ).GetInteger();
						iHandicaps += pPlayerKVD.GetKeyvalue( "$i_handicap11" ).GetInteger();
						iHandicaps += pPlayerKVD.GetKeyvalue( "$i_handicap12" ).GetInteger();
						iHandicaps += pPlayerKVD.GetKeyvalue( "$i_handicap13" ).GetInteger();
						iHandicaps += pPlayerKVD.GetKeyvalue( "$i_handicap14" ).GetInteger();
						iHandicaps += pPlayerKVD.GetKeyvalue( "$i_handicap15" ).GetInteger();
						
						if ( iHandicaps >= 10 ) // 10 or more?
						{
							// To prevent abuse, player must have at least this much score
							if ( pPlayer.pev.frags >= 28.0 ) // Don't make it too difficult!
							{
								// Get!
								CustomKeyvalues@ pUnlock = pPlayer.GetCustomKeyvalues();
								pUnlock.SetKeyvalue( "$i_a_unlock", 52 );
							}
						}
					}
				}
				
				return;
			}
		}
		
		pCheck.pev.iuser3 = pCheck.pev.iuser3 + 1;
	}
	else
		pCheck.pev.iuser4 = pCheck.pev.iuser4 + 1;
}

void snd_check()
{
	if ( szMap != 'snd' )
		return;
	
	CBaseEntity@ pCheck = g_EntityFuncs.FindEntityByTargetname( null, "sys_adata" );
	if ( pCheck is null )
		return;
	
	// Get map difficulty
	CustomKeyvalues@ pKVD = pCheck.GetCustomKeyvalues();
	int iDifficulty = pKVD.GetKeyvalue( "$i_difficulty" ).GetInteger();
	
	int iCheck = pKVD.GetKeyvalue( "$i_test" ).GetInteger();
	if ( iCheck == 1 )
	{
		for ( int i = 1; i <= g_Engine.maxClients; i++ )
		{
			CBasePlayer@ pPlayer = g_PlayerFuncs.FindPlayerByIndex( i );
			
			if ( pPlayer !is null && pPlayer.IsConnected() )
			{
				// Get map difficulty
				if ( iDifficulty >= 1 ) // Standard or higher
				{
					if ( pPlayer.pev.frags >= 100.0 )
					{
						// Get!
						CustomKeyvalues@ pUnlock = pPlayer.GetCustomKeyvalues();
						pUnlock.SetKeyvalue( "$i_a_unlock", 54 );
					}
				}
			}
		}
		
		g_EntityFuncs.Remove( pCheck );
		return;
	}
}

void intruder_check()
{
	if ( szMap != 'intruder' )
		return;
	
	CBaseEntity@ pCheck = g_EntityFuncs.FindEntityByTargetname( null, "sys_adata" );
	if ( pCheck is null )
		return;
	
	CustomKeyvalues@ pKVD = pCheck.GetCustomKeyvalues();
	
	int iCheck = pKVD.GetKeyvalue( "$i_test" ).GetInteger();
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
					// Handicap enabled?
					CustomKeyvalues@ pPlayerKVD = pPlayer.GetCustomKeyvalues();
					
					int iHandicap15 = pPlayerKVD.GetKeyvalue( "$i_handicap15" ).GetInteger();
					if ( iHandicap15 == 1 )
					{
						// No gauss or egon?
						if ( pPlayer.HasNamedPlayerItem( "weapon_gauss" ) is null && pPlayer.HasNamedPlayerItem( "weapon_egon" ) is null )
						{
							// To prevent abuse, player must have at least this much score
							if ( pPlayer.pev.frags >= 200.0 )
							{
								// Get!
								CustomKeyvalues@ pUnlock = pPlayer.GetCustomKeyvalues();
								pUnlock.SetKeyvalue( "$i_a_unlock", 55 );
							}
						}
					}
				}
			}
		}
		
		g_EntityFuncs.Remove( pCheck );
		return;
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
