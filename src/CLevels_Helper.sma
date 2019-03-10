/*
	CLevels (Imperium Sven Co-op's SCXPM): Auxiliary Scripts
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
#include <engine>
#include <fakemeta>
#include <hamsandwich>

new Float:flDamageDealt[2048][33];
new bool:bKilled[2048];

new bool:falling[33];

public plugin_precache()
{
	register_forward( FM_KeyValue, "check_entities" );
}

public plugin_init()
{
	register_plugin( "SCXPM Helper", "1.1", "Giegue" );
	
	// Achievements (General)
	RegisterHam( Ham_Think, "rpg_rocket", "a02_check1", 1 );
	RegisterHam( Ham_TakeDamage, "player", "a02_a20_a68_check" );
	RegisterHam( Ham_TakeDamage, "monster_stukabat", "a23_check" );
	RegisterHam( Ham_TakeDamage, "monster_alien_controller", "a32_check_a" );
	RegisterHam( Ham_TakeDamage, "monster_tripmine", "a32_check_b" );
	RegisterHam( Ham_TakeDamage, "monster_snark", "a41_check" );
	RegisterHam( Ham_Killed, "monster_alien_slave", "a50_check", 1 );
	RegisterHam( Ham_Killed, "monster_zombie", "a53_check", 1 );
	RegisterHam( Ham_Killed, "monster_zombie_barney", "a53_check", 1 );
	RegisterHam( Ham_Killed, "monster_zombie_soldier", "a53_check", 1 );
	RegisterHam( Ham_TakeDamage, "monster_shocktrooper", "a65_check" );
	RegisterHam( Ham_TakeDamage, "monster_shockroach", "a87_check" );
	RegisterHam( Ham_TakeDamage, "monster_babycrab", "a162_check" );
	RegisterHam( Ham_Killed, "monster_male_assassin", "a167_check", 1 );
	
	// Achievements (Map-specific)
	new szMap[32];
	get_mapname( szMap, charsmax( szMap ) );
	
	if ( equal( szMap, "auspices" ) )
		RegisterHam( Ham_Killed, "player", "a04_check", 1 );
	else if ( equal( szMap, "ub_iseki2" ) )
		RegisterHam( Ham_Killed, "player", "a31_check", 1 );
	else if ( equal( szMap, "dc_inflight" ) )
		RegisterHam( Ham_TakeDamage, "func_breakable", "a38_check" );
	else if ( equal( szMap, "sc_defmap_v3" ) )
		RegisterHam( Ham_TakeDamage, "func_breakable", "a71_check" );
	else if ( equal( szMap, "desertcircle" ) )
		RegisterHam( Ham_TakeDamage, "monster_hwgrunt", "a74_check" );
	else if ( equal( szMap, "ub_megaman" ) )
	{
		RegisterHam( Ham_Killed, "player", "a84_helper_a", 1 );
		RegisterHam( Ham_TakeDamage, "monster_alien_grunt", "a84_helper_b" );
	}
	else if ( equal( szMap, "sc_another" ) )
		RegisterHam( Ham_Killed, "monster_barney", "a97_check", 1 );
	else if ( equal( szMap, "garghnt3" ) )
		RegisterHam( Ham_Killed, "monster_gargantua", "a104_check", 1 );
	else if ( equal( szMap, "dmc_", 4 ) )
		RegisterHam( Ham_Killed, "player", "a111_check", 1 );
	else if ( equal( szMap, "aim_ig_", 7 ) )
		RegisterHam( Ham_Killed, "player", "a113_check", 1 );
	else if ( equal( szMap, "factions" ) )
		RegisterHam( Ham_TakeDamage, "monster_zombie", "a114_check" );
	else if ( equal( szMap, "fun_big_city2" ) )
		RegisterHam( Ham_Killed, "player", "a139_check" );
	else if ( equal( szMap, "tunnel" ) )
		RegisterHam( Ham_Killed, "monster_zombie", "a142_check" );
	
	// Don't allow these maps to unlock these general achievements
	if ( !equal( szMap, "shattered" ) && !equal( szMap, "cs_galleon-f" ) && !equal( szMap, "sc_mako" ) && !equal( szMap, "5minutes_b1" ) && !equal( szMap, "tox_xen5" ) && !equal( szMap, "ub_megaman" ) )
	{
		RegisterHam( Ham_TakeDamage, "monster_gargantua", "a05_a29_check" );
		RegisterHam( Ham_TakeDamage, "monster_apache", "a11_check" );
		RegisterHam( Ham_TakeDamage, "monster_kingpin", "a14_check" );
		RegisterHam( Ham_TakeDamage, "monster_robogrunt", "a56_check" );
		RegisterHam( Ham_TakeDamage, "monster_male_assassin", "a62_check" );
		RegisterHam( Ham_TakeDamage, "monster_gonome", "a68_check" );
		RegisterHam( Ham_TakeDamage, "monster_alien_tor", "a86_check" );
		RegisterHam( Ham_TakeDamage, "monster_alien_grunt", "a125_check" );
	}
	
	// SCXPM HELPER
	RegisterHam( Ham_TakeDamage, "monster_sentry", "rexp_disable" );
	RegisterHam( Ham_TakeDamage, "monster_miniturret", "rexp_disable" );
	RegisterHam( Ham_TakeDamage, "monster_turret", "rexp_disable" );
	RegisterHam( Ham_TakeDamage, "monster_robogrunt", "rexp_disable" );
}

// GENERAL ACHIEVEMENTS

public a02_check1( entity )
{
	if ( is_valid_ent( entity ) )
	{
		static eOwner, szClassname[32], ent, Float:vecOrigin[3], iRelationShip;
		
		// Get entity data
		eOwner = entity_get_edict( entity, EV_ENT_owner );
		entity_get_vector( entity, EV_VEC_origin, vecOrigin );
		
		// Get owner classname
		entity_get_string( eOwner, EV_SZ_classname, szClassname, charsmax( szClassname ) );
		
		// Check if a RPG grunt launched this rocket
		if ( equal( szClassname, "monster_human_grunt" ) )
		{
			// This is our rocket, locate nearby players
			while ( ( ent = find_ent_in_sphere( ent, vecOrigin, 50.0 ) ) != 0 )
			{
				// Only care for players
				entity_get_string( ent, EV_SZ_classname, szClassname, charsmax( szClassname ) );
				if ( equal( szClassname, "player" ) )
				{
					// Player has to be alive
					if ( is_user_alive( ent ) )
					{
						// We must be an enemy to the player
						iRelationShip = ExecuteHam( Ham_IRelationship, eOwner, ent );
						if ( iRelationShip >= 1 ) // R_DL
						{
							// Mark player for checking
							entity_set_edict( ent, EV_ENT_euser2, 0 );
							entity_set_edict( ent, EV_ENT_euser3, entity );
							
							if ( !task_exists( ent + 1000 ) )
								set_task( 1.0, "a02_check2", ent + 1000 );
							
							entity_set_edict( ent, EV_ENT_euser4, eOwner );
						}
					}
				}
			}
		}
	}
}

public a02_a20_a68_check( victim, inflictor, attacker, Float:dmg, dmgbits )
{
	if ( attacker < 0 ) // worldspawn (attacker = 0) should be included here
		return HAM_IGNORED;
	
	if ( attacker > 0 )
	{
		if ( !is_valid_ent( attacker ) )
			return HAM_IGNORED;
	}
	
	static szClassname[32];
	entity_get_string( attacker, EV_SZ_classname, szClassname, charsmax( szClassname ) );
	
	// Achievement #02
	// Got hurt by RPG grunt misille?
	if ( ( dmgbits & DMG_BLAST ) && attacker == entity_get_edict( victim, EV_ENT_euser4 ) )
	{
		// FAILED!
		entity_set_edict( victim, EV_ENT_euser2, 1 );
	}
	
	// Achievement #20
	// Barnacle hurting us?
	if ( equal( szClassname, "monster_barnacle" ) )
	{
		// Check
		if ( flDamageDealt[victim][victim] == 30.0 )
		{
			// Get!
			DispatchKeyValue( victim, "$i_a_unlock", "21" );
		}
		else
		{
			// Keep track of how many times the barnacle did damage to us
			flDamageDealt[victim][victim]++;
			
			// Reset if no futher damage is received (either player or barnacle died)
			if ( task_exists( victim + 2000 ) )
				remove_task( victim + 2000 );
			
			set_task( 1.5, "a20_reset", victim + 2000 );
		}
	}
	
	// Achievement #68
	// Gonome hurting us?
	if ( equal( szClassname, "monster_gonome" ) )
	{
		// FAILED!
		entity_set_edict( victim, EV_ENT_euser2, 1 );
	}
	
	return HAM_IGNORED;
}

public a02_check2( TaskID )
{
	new index = TaskID - 1000;
	
	// Player is valid?
	if ( is_user_connected( index ) )
	{
		// Missile detonated?
		if ( !is_valid_ent( entity_get_edict( index, EV_ENT_euser3 ) ) )
		{
			// We did NOT recieve ANY damage from it?
			if ( entity_get_edict( index, EV_ENT_euser2 ) == 0 )
			{
				// Unlock!
				DispatchKeyValue( index, "$i_a_unlock", "3" );
			}
		}
		else
		{
			// Missile is still alive
			set_task( 1.0, "a02_check2", TaskID );
		}
	}
}

public a05_a29_check( victim, inflictor, attacker, Float:dmg, dmgbits )
{
	// Players only
	if ( attacker >= 1 && attacker <= 14 )
	{
		static Float:flHealth, Float:flMaxHealth, Float:flNeededDamage;
		flHealth = entity_get_float( victim, EV_FL_health );
		flMaxHealth = entity_get_float( victim, EV_FL_max_health );
		flNeededDamage = flMaxHealth * 20.0 / 100.0;
		
		if ( ( dmgbits & DMG_BULLET ) || ( dmgbits & DMG_SHOCK ) )
			flDamageDealt[victim][attacker] += dmg;
		
		if ( ( flHealth - dmg ) < 0.0 )
		{
			if ( dmgbits & DMG_CRUSH )
			{
				entity_set_edict( victim, EV_ENT_euser2, attacker );
				set_task( 0.25, "a05_fixer", victim );
			}
			else if ( ( dmgbits & DMG_BULLET ) || ( dmgbits & DMG_SHOCK ) )
			{
				// Dealt at least 20% of the garg's total health?
				if ( flDamageDealt[victim][attacker] >= flNeededDamage )
				{
					entity_set_edict( victim, EV_ENT_euser2, attacker );
					set_task( 0.25, "a29_fixer", victim );
				}
			}
		}
	}
}
public a05_fixer( victim )
{
	// FIX - Check if it did really truly die
	if ( entity_get_int( victim, EV_INT_deadflag ) != DEAD_NO )
	{
		static attacker;
		attacker = entity_get_edict( victim, EV_ENT_euser2 );
		
		if ( is_user_connected( attacker ) )
		{
			// Get!
			DispatchKeyValue( attacker, "$i_a_unlock", "6" );
		}
	}
}
public a29_fixer( victim )
{
	// FIX - Check if it did really truly die
	if ( entity_get_int( victim, EV_INT_deadflag ) != DEAD_NO )
	{
		static attacker;
		attacker = entity_get_edict( victim, EV_ENT_euser2 );
		
		if ( is_user_connected( attacker ) )
		{
			// Get!
			DispatchKeyValue( attacker, "$i_a_unlock", "30" );
		}
		
		// Reset
		flDamageDealt[victim][attacker] = 0.0;
	}
}

public a11_check( victim, inflictor, attacker, Float:dmg, dmgbits )
{
	// Players only
	if ( attacker >= 1 && attacker <= 14 )
	{
		static Float:flHealth, Float:flMaxHealth, Float:flNeededDamage, iWeapon;
		flHealth = entity_get_float( victim, EV_FL_health );
		flMaxHealth = entity_get_float( victim, EV_FL_max_health );
		flNeededDamage = flMaxHealth * 40.0 / 100.0;
		iWeapon = get_user_weapon( attacker );
		
		// Slot 3 weapons ONLY ( MP5 - Crossbow - Shotgun - M16 )
		if ( iWeapon == 4 || iWeapon == 6 || iWeapon == 7 || iWeapon == 25 )
			flDamageDealt[victim][attacker] += dmg;
		
		if ( ( flHealth - dmg ) < 0.0 )
		{
			if ( iWeapon == 4 || iWeapon == 6 || iWeapon == 7 || iWeapon == 25 )
			{
				// Dealt at least 40% of the apaches's total health?
				if ( flDamageDealt[victim][attacker] >= flNeededDamage )
				{
					entity_set_edict( victim, EV_ENT_euser2, attacker );
					set_task( 0.25, "a11_fixer", victim );
				}
			}
		}
	}
}
public a11_fixer( victim )
{
	// FIX - Check if it did really truly die
	static Float:flHealth;
	flHealth = entity_get_float( victim, EV_FL_health );
	
	if ( flHealth <= 0.0 )
	{
		static attacker;
		attacker = entity_get_edict( victim, EV_ENT_euser2 );
		
		if ( is_user_connected( attacker ) )
		{
			// Get!
			DispatchKeyValue( attacker, "$i_a_unlock", "12" );
		}
		
		// Reset
		flDamageDealt[victim][attacker] = 0.0;
	}
}

public a14_check( victim, inflictor, attacker, Float:dmg, dmgbits )
{
	static eEnemy, Float:flShieldDamage;
	eEnemy = pev( victim, pev_euser2 );
	flShieldDamage = entity_get_float( victim, EV_FL_fuser4 );
	
	// Save damage for shield check, but only if active
	if ( eEnemy )
		entity_set_float( victim, EV_FL_fuser4, ( flShieldDamage + floatround( dmg ) ) );
	
	// Players only
	if ( attacker >= 1 && attacker <= 14 )
	{
		static Float:flHealth;
		flHealth = entity_get_float( victim, EV_FL_health );
		
		if ( ( flHealth - dmg ) < 0.0 )
		{
			// Only if the shield has NOT been destroyed
			if ( flShieldDamage < 1250.0 )
			{
				entity_set_edict( victim, EV_ENT_euser3, attacker );
				set_task( 1.00, "a14_fixer", victim );
			}
		}
	}
}
public a14_fixer( victim )
{
	// FIX - Check if it did really truly die
	if ( entity_get_int( victim, EV_INT_deadflag ) != DEAD_NO )
	{	
		static attacker;
		attacker = entity_get_edict( victim, EV_ENT_euser3 );
		
		if ( is_user_connected( attacker ) )
		{
			// Get!
			DispatchKeyValue( attacker, "$i_a_unlock", "15" );
		}
	}
}

public a20_reset( TaskID )
{
	new index = TaskID - 2000;
	flDamageDealt[index][index] = 0.0;
}

public a23_check( victim, inflictor, attacker, Float:dmg, dmgbits )
{
	// Players only
	if ( attacker >= 1 && attacker <= 14 )
	{
		static Float:flHealth, szClassname[32], Float:vecOrigin1[3], Float:vecOrigin2[3];
		flHealth = entity_get_float( victim, EV_FL_health );
		entity_get_string( inflictor, EV_SZ_classname, szClassname, charsmax( szClassname ) );
		entity_get_vector( attacker, EV_VEC_origin, vecOrigin1 );
		entity_get_vector( victim, EV_VEC_origin, vecOrigin2 );
		
		if ( ( flHealth - dmg ) < 0.0 )
		{
			// Thrown crowbar?
			if ( equal( szClassname, "weaponbox" ) )
			{
				// Are we distant enough?
				if ( get_distance_f( vecOrigin1, vecOrigin2 ) >= 512.0 )
				{
					// Mark entity for checking
					entity_set_edict( victim, EV_ENT_euser4, attacker );
					
					// FIX - Check if it did really truly die
					set_task( 0.1, "a23_fix", victim );
				}
			}
		}
	}
}
public a23_fix( victim )
{	
	if ( entity_get_int( victim, pev_sequence ) == 7 )
	{
		static attacker;
		attacker = entity_get_edict( victim, EV_ENT_euser4 );
		
		if ( is_user_connected( attacker ) )
		{
			// Get!
			DispatchKeyValue( attacker, "$i_a_unlock", "24" );
		}
	}
}

public a32_check_a( victim, inflictor, attacker, Float:dmg, dmgbits )
{
	// Players only
	if ( attacker >= 1 && attacker <= 14 )
	{
		static Float:flHealth, szClassname[32], iFail;
		flHealth = entity_get_float( victim, EV_FL_health );
		entity_get_string( inflictor, EV_SZ_classname, szClassname, charsmax( szClassname ) );
		iFail = entity_get_int( inflictor, EV_INT_iuser4 );
		
		if ( ( flHealth - dmg ) < 0.0 )
		{
			// Used tripmine?
			if ( equal( szClassname, "monster_tripmine" ) )
			{
				// The tripmine was NOT detonated purposely by a player?
				if ( iFail == 0 )
				{
					entity_set_edict( victim, EV_ENT_euser2, attacker );
					set_task( 1.00, "a32_fixer", victim );
				}
			}
		}
	}
}
public a32_fixer( victim )
{
	if ( is_valid_ent( victim ) )
	{
		// FIX - Check if it did really truly die
		if ( entity_get_int( victim, EV_INT_deadflag ) != DEAD_NO )
		{
			static attacker;
			attacker = entity_get_edict( victim, EV_ENT_euser2 );
			
			if ( is_user_connected( attacker ) )
			{
				// Get!
				DispatchKeyValue( attacker, "$i_a_unlock", "33" );
			}
		}
	}
}

public a32_check_b( victim, inflictor, attacker, Float:dmg, dmgbits )
{
	// Players only
	if ( attacker >= 1 && attacker <= 14 )
	{
		// If a player intentionally shoots the tripmine for detonation
		// then the achievement is a fail.
		// -
		// Only applies for players, another monster could detonate the
		// tripmine and still get the achievement.
		entity_set_int( victim, EV_INT_iuser4, 1 );
	}
}

public a41_check( victim, inflictor, attacker, Float:dmg, dmgbits )
{
	static eOwner;
	eOwner = entity_get_edict( victim, EV_ENT_owner );
	
	// If this is a player snark, then it's owner is stored in the entity's pev->owner
	if ( eOwner >= 1 && eOwner <= 14 )
	{
		static szClassname[32];
		entity_get_string( attacker, EV_SZ_classname, szClassname, charsmax( szClassname ) );
		
		// OM NOM NOM'd?
		if ( equal( szClassname, "monster_barnacle" ) )
		{
			// Get!
			DispatchKeyValue( eOwner, "$i_a_unlock", "42" );
		}
	}
}

public a50_check( victim, attacker, shouldgib )
{
	if ( !bKilled[victim] )
	{
		bKilled[victim] = true;
		set_task( 0.4, "a50_reset", victim );
		
		// Players only
		if ( attacker >= 1 && attacker <= 14 )
		{
			// Retrieve data of killings/killer
			static iKilled, iKiller;
			iKiller = entity_get_edict( attacker, EV_ENT_euser1 );
			iKilled = entity_get_int( attacker, EV_INT_iuser4 );
			
			if ( iKiller == victim )
			{
				iKilled++;
				if ( iKilled == 5 )
				{
					// Get!
					DispatchKeyValue( attacker, "$i_a_unlock", "51" );
				}
				entity_set_int( attacker, EV_INT_iuser4, iKilled );
			}
			else
			{
				iKilled = 1;
				entity_set_edict( attacker, EV_ENT_euser1, victim );
				entity_set_int( attacker, EV_INT_iuser4, iKilled );
			}
		}
	}
}

public a50_reset( entity )
{
	if ( is_valid_ent( entity ) )
	{
		if ( entity_get_int( entity, EV_INT_deadflag ) == DEAD_NO )
			bKilled[entity] = false;
		else
			set_task( 0.4, "a50_reset", entity );
	}
	else
		bKilled[entity] = false;
}

public a53_check( victim, attacker, shouldgib )
{
	if ( !is_valid_ent( attacker ) )
		return HAM_IGNORED;
	
	static szClassname[32];
	entity_get_string( attacker, EV_SZ_classname, szClassname, charsmax( szClassname ) );
	
	// Another zombie killing us?
	if ( equal( szClassname, "monster_zombie", 14 ) )
	{
		static eEnemy1, eEnemy2;
		eEnemy1 = entity_get_edict( victim, EV_ENT_euser2 );
		eEnemy2 = entity_get_edict( attacker, EV_ENT_euser2 );
		
		// Both zombies had the same target?
		if ( eEnemy1 == eEnemy2 )
		{
			// Make sure it's a player
			if ( eEnemy1 >= 1 && eEnemy1 <= 14 )
			{
				// Get!
				DispatchKeyValue( eEnemy1, "$i_a_unlock", "54" );
			}
		}
	}
	
	return HAM_IGNORED;
}

public a56_check( victim, inflictor, attacker, Float:dmg, dmgbits )
{
	// Players only
	if ( attacker >= 1 && attacker <= 14 )
	{
		static Float:flHealth, Float:flMaxHealth, Float:flNeededDamage, iWeapon;
		flHealth = entity_get_float( victim, EV_FL_health );
		flMaxHealth = entity_get_float( victim, EV_FL_max_health );
		flNeededDamage = flMaxHealth * 30.0 / 100.0;
		iWeapon = get_user_weapon( attacker );
		
		// Slot 1 weapons ONLY ( Crowbar - PipeWrench - BarnacleGrapple )
		if ( iWeapon == 1 || iWeapon == 20 || iWeapon == 22 )
			flDamageDealt[victim][attacker] += dmg;
		
		if ( ( flHealth - dmg ) < 0.0 )
		{
			if ( iWeapon == 1 || iWeapon == 20 || iWeapon == 22 )
			{
				// Dealt at least 30% of the robo grunt's total health?
				if ( flDamageDealt[victim][attacker] >= flNeededDamage )
				{
					entity_set_edict( victim, EV_ENT_euser2, attacker );
					set_task( 0.25, "a56_fixer", victim );
				}
			}
		}
	}
}
public a56_fixer( victim )
{
	if ( is_valid_ent( victim ) )
	{
		// FIX - Check if it did really truly die
		if ( entity_get_int( victim, EV_INT_deadflag ) != DEAD_NO )
		{
			static attacker;
			attacker = entity_get_edict( victim, EV_ENT_euser2 );
			
			if ( is_user_connected( attacker ) )
			{
				// Get!
				DispatchKeyValue( attacker, "$i_a_unlock", "57" );
			}
			
			// Reset
			flDamageDealt[victim][attacker] = 0.0;
		}
	}
}

public a62_check( victim, inflictor, attacker, Float:dmg, dmgbits )
{
	// Players only
	if ( attacker >= 1 && attacker <= 14 )
	{
		static iMonsterWeapon;
		iMonsterWeapon = entity_get_int( victim, EV_INT_weapons );
		
		// Must be a sniper
		if ( iMonsterWeapon == 8 || iMonsterWeapon == 10 || iMonsterWeapon == 256 )
		{
			static Float:vecOrigin1[3], Float:vecOrigin2[3];
			entity_get_vector( attacker, EV_VEC_origin, vecOrigin1 );
			entity_get_vector( victim, EV_VEC_origin, vecOrigin2 );
			
			// Must use crossbow
			if ( ( dmgbits & DMG_BULLET ) && ( dmgbits & DMG_NEVERGIB ) && ( dmgbits & DMG_POISON ) )
			{
				// Enough distance?
				if ( get_distance_f( vecOrigin1, vecOrigin2 ) >= 768.0 )
				{
					static Float:iProgress[3];
					entity_get_vector( attacker, EV_VEC_vuser1, iProgress );
					
					// Increase progress, handler will take care of it
					iProgress[0]++;
					entity_set_vector( attacker, EV_VEC_vuser1, iProgress );
				}
			}
		}
	}
}

public a65_check( victim, inflictor, attacker, Float:dmg, dmgbits )
{
	// Players only
	if ( attacker >= 1 && attacker <= 14 )
	{
		static Float:flHealth, szClassname[32];
		flHealth = entity_get_float( victim, EV_FL_health );
		entity_get_string( inflictor, EV_SZ_classname, szClassname, charsmax( szClassname ) );
		
		if ( ( flHealth - dmg ) < 0.0 )
		{
			if ( equal( szClassname, "monster_shockroach" ) )
			{
				// FIX - Check if it did really truly die
				if ( entity_get_int( victim, EV_INT_deadflag ) != DEAD_NO )
				{
					static Float:iProgress[3];
					entity_get_vector( attacker, EV_VEC_vuser1, iProgress );
					
					// Increase progress, handler will take care of it
					iProgress[1]++;
					entity_set_vector( attacker, EV_VEC_vuser1, iProgress );
				}
			}
		}
	}
}

public a68_check( victim, inflictor, attacker, Float:dmg, dmgbits )
{
	// Players only
	if ( attacker >= 1 && attacker <= 14 )
	{
		static Float:flHealth, Float:flMaxHealth, Float:flNeededDamage, iWeapon, iFail;
		flHealth = entity_get_float( victim, EV_FL_health );
		flMaxHealth = entity_get_float( victim, EV_FL_max_health );
		flNeededDamage = flMaxHealth * 30.0 / 100.0;
		iWeapon = get_user_weapon( attacker );
		iFail = entity_get_edict( attacker, EV_ENT_euser2 );
		
		// Slot 1 weapons ONLY ( Crowbar - PipeWrench - BarnacleGrapple )
		if ( iWeapon == 1 || iWeapon == 20 || iWeapon == 22 )
		{
			// FIX - Prevent Spawn Damage counting as a valid hit
			if ( !( dmgbits & DMG_ENERGYBEAM ) )
				flDamageDealt[victim][attacker] += dmg;
		}
		
		if ( ( flHealth - dmg ) < 0.0 )
		{
			if ( iWeapon == 1 || iWeapon == 20 || iWeapon == 22 )
			{
				// Did NOT get hurt before?
				if ( iFail == 0 )
				{
					// Dealt at least 30% of the gonome's total health?
					if ( flDamageDealt[victim][attacker] >= flNeededDamage )
					{
						entity_set_edict( victim, EV_ENT_euser2, attacker );
						set_task( 0.25, "a68_fixer", victim );
					}
				}
			}
			
			// Reset for another attempt on another gonome
			entity_set_edict( attacker, EV_ENT_euser2, 0 );
		}
	}
}
public a68_fixer( victim )
{
	// FIX - Check if it did really truly die
	if ( entity_get_int( victim, EV_INT_deadflag ) != DEAD_NO )
	{
		static attacker;
		attacker = entity_get_edict( victim, EV_ENT_euser2 );
		
		if ( is_user_connected( attacker ) )
		{
			// Get!
			DispatchKeyValue( attacker, "$i_a_unlock", "69" );
		}
		
		// Reset
		flDamageDealt[victim][attacker] = 0.0;
	}
}

public a86_check( victim, inflictor, attacker, Float:dmg, dmgbits )
{
	// Players only
	if ( attacker >= 1 && attacker <= 14 )
	{
		static Float:flHealth, Float:flMaxHealth, Float:flNeededDamage, iPlayerWeapon;
		flHealth = entity_get_float( victim, EV_FL_health );
		flMaxHealth = entity_get_float( victim, EV_FL_max_health );
		flNeededDamage = flMaxHealth * 15.0 / 100.0;
		iPlayerWeapon = get_user_weapon( attacker );
		
		// Only accumulate damage if using PipeWrench
		if ( iPlayerWeapon == 20 )
		{
			flDamageDealt[victim][attacker] += dmg;
			
			// !!! FIX FIX - Don't allow Tor to be gibbed from PipeWrench's secondary fire
			SetHamParamInteger( 5, ( dmgbits | DMG_NEVERGIB ) &~ DMG_ALWAYSGIB );
		}
		
		if ( ( flHealth - dmg ) < 0.0 )
		{
			// Final hit must also have same condition
			if ( iPlayerWeapon == 20 )
			{
				// Dealt at least 15% of the tor's total health?
				if ( flDamageDealt[victim][attacker] >= flNeededDamage )
				{
					entity_set_edict( victim, EV_ENT_euser2, attacker );
					set_task( 1.00, "a86_fixer", victim );
				}
			}
		}
	}
}
public a86_fixer( victim )
{
	if ( is_valid_ent( victim ) )
	{
		// FIX - Check if it did really truly die
		if ( entity_get_int( victim, EV_INT_deadflag ) != DEAD_NO )
		{
			static attacker;
			attacker = entity_get_edict( victim, EV_ENT_euser2 );
			
			if ( is_user_connected( attacker ) )
			{
				// Get!
				DispatchKeyValue( attacker, "$i_a_unlock", "87" );
			}
			
			// Reset
			flDamageDealt[victim][attacker] = 0.0;
		}
	}
}

public a87_check( victim, inflictor, attacker, Float:dmg, dmgbits )
{
	static eOwner;
	eOwner = entity_get_edict( victim, EV_ENT_owner );
	
	// Owner must still be present
	if ( eOwner >= 1 && eOwner <= 14 )
	{
		static szClassname[32];
		entity_get_string( attacker, EV_SZ_classname, szClassname, charsmax( szClassname ) );
		
		// OM NOM NOM'd?
		if ( equal( szClassname, "monster_barnacle" ) )
		{
			// Get!
			DispatchKeyValue( eOwner, "$i_a_unlock", "88" );
		}
	}
}

public a125_check( victim, inflictor, attacker, Float:dmg, dmgbits )
{
	// Players only
	if ( attacker >= 1 && attacker <= 14 )
	{
		static iPlayerWeapon;
		iPlayerWeapon = get_user_weapon( attacker );
		
		// Prepare auto-reset if first hit
		if ( !flDamageDealt[victim][attacker] )
		{
			// Remember attacker...
			entity_set_edict( attacker, EV_ENT_euser4, victim );
			set_task( 15.0, "a125_reset", attacker );
		}
		
		// Save for each different weapon hit
		if ( iPlayerWeapon == 2 && !( floatround( flDamageDealt[2047][attacker] ) & 1 ) )
		{
			flDamageDealt[victim][attacker]++;
			flDamageDealt[2047][attacker] += 1.0;
		}
		else if ( iPlayerWeapon == 3 && !( floatround( flDamageDealt[2047][attacker] ) & 2 ) )
		{
			flDamageDealt[victim][attacker]++;
			flDamageDealt[2047][attacker] += 2.0;
		}
		else if ( iPlayerWeapon == 4 && !( floatround( flDamageDealt[2047][attacker] ) & 4 ) )
		{
			flDamageDealt[victim][attacker]++;
			flDamageDealt[2047][attacker] += 4.0;
		}
		else if ( iPlayerWeapon == 6 && !( floatround( flDamageDealt[2047][attacker] ) & 8 ) )
		{
			flDamageDealt[victim][attacker]++;
			flDamageDealt[2047][attacker] += 8.0;
		}
		else if ( iPlayerWeapon == 7 && !( floatround( flDamageDealt[2047][attacker] ) & 16 ) )
		{
			flDamageDealt[victim][attacker]++;
			flDamageDealt[2047][attacker] += 16.0;
		}
		else if ( iPlayerWeapon == 8 && !( floatround( flDamageDealt[2047][attacker] ) & 32 ) )
		{
			flDamageDealt[victim][attacker]++;
			flDamageDealt[2047][attacker] += 32.0;
		}
		else if ( iPlayerWeapon == 9 && !( floatround( flDamageDealt[2047][attacker] ) & 64 ) )
		{
			flDamageDealt[victim][attacker]++;
			flDamageDealt[2047][attacker] += 64.0;
		}
		else if ( iPlayerWeapon == 17 && !( floatround( flDamageDealt[2047][attacker] ) & 128 ) )
		{
			flDamageDealt[victim][attacker]++;
			flDamageDealt[2047][attacker] += 128.0;
		}
		else if ( iPlayerWeapon == 21 && !( floatround( flDamageDealt[2047][attacker] ) & 256 ) )
		{
			flDamageDealt[victim][attacker]++;
			flDamageDealt[2047][attacker] += 256.0;
		}
		else if ( iPlayerWeapon == 23 && !( floatround( flDamageDealt[2047][attacker] ) & 512 ) )
		{
			flDamageDealt[victim][attacker]++;
			flDamageDealt[2047][attacker] += 512.0;
		}
		else if ( iPlayerWeapon == 24 && !( floatround( flDamageDealt[2047][attacker] ) & 1024 ) )
		{
			flDamageDealt[victim][attacker]++;
			flDamageDealt[2047][attacker] += 1024.0;
		}
		else if ( iPlayerWeapon == 25 && !( floatround( flDamageDealt[2047][attacker] ) & 2048 ) )
		{
			flDamageDealt[victim][attacker]++;
			flDamageDealt[2047][attacker] += 2048.0;
		}
		else if ( iPlayerWeapon == 27 && !( floatround( flDamageDealt[2047][attacker] ) & 4096 ) )
		{
			flDamageDealt[victim][attacker]++;
			flDamageDealt[2047][attacker] += 4096.0;
		}
		
		// 7 different weapons?
		if ( flDamageDealt[victim][attacker] >= 7.0 )
		{
			// Get!
			DispatchKeyValue( attacker, "$i_a_unlock", "126" );
			
			// Reset
			flDamageDealt[victim][attacker] = 0.0;
			flDamageDealt[2047][attacker] = 0.0;
		}
	}
}
public a125_reset( attacker )
{
	flDamageDealt[ entity_get_edict( attacker, EV_ENT_euser4 ) ][attacker] = 0.0;
	flDamageDealt[2047][attacker] = 0.0;
}

public a162_check( victim, inflictor, attacker, Float:dmg, dmgbits )
{
	// Players only
	if ( attacker >= 1 && attacker <= 14 )
	{
		// Crossbow explosion has the DMG_ALWAYSGIB flag, so let's check by that
		// This will allow other similar stuff to unlock this achievement
		if ( dmgbits & DMG_ALWAYSGIB )
		{
			// This incoming damage will be enough to kill the crab?
			static Float:flHealth;
			flHealth = entity_get_float( victim, EV_FL_health );
			if ( ( flHealth - dmg ) <= 1.0 )
			{
				// Add to total
				flDamageDealt[2046][attacker]++;
				
				// Enough kills?
				if ( flDamageDealt[2046][attacker] >= 10 )
				{
					// Get!
					DispatchKeyValue( attacker, "$i_a_unlock", "163" );
				}
				
				// Reset very quickly
				set_task( 0.1, "a162_reset", attacker );
			}
		}
	}
}
public a162_reset( attacker )
{
	flDamageDealt[2046][attacker] = 0.0;
}

public a167_check( victim, attacker, shouldgib )
{
	// Players only
	if ( attacker >= 1 && attacker <= 14 )
	{
		// FIX - Check if it did really truly die
		if ( entity_get_int( victim, EV_INT_deadflag ) != DEAD_NO )
		{
			static Float:iProgress[3];
			entity_get_vector( attacker, EV_VEC_vuser1, iProgress );
			
			// Increase progress, handler will take care of it
			iProgress[2]++;
			entity_set_vector( attacker, EV_VEC_vuser1, iProgress );
		}
	}
}

// MAP ACHIEVEMENTS

public a04_check( victim, attacker, shouldgib )
{
	static ent;
	ent = find_ent_by_tname( -1, "sys_adata" );
	
	if ( is_valid_ent( ent ) )
	{
		static szNoise[16], szClassname[32];
		entity_get_string( ent, EV_SZ_noise, szNoise, charsmax( szNoise ) );
		
		// Only care if we are active
		if ( equal( szNoise, "ACTIVE" ) )
		{
			// We are active, did we get killed by THE lasers?
			entity_get_string( attacker, EV_SZ_classname, szClassname, charsmax( szClassname ) );
			if ( equal( szClassname, "func_tanklaser" ) || equal( szClassname, "env_laser" ) )
			{
				// FAILED!
				DispatchKeyValue( victim, "$i_fail", "1" );
			}
		}
	}
}

public a31_check( victim, attacker, shouldgib )
{
	static ent;
	ent = find_ent_by_tname( -1, "sys_adata" );
	
	if ( is_valid_ent( ent ) )
	{
		static szNoise[16], szClassname[32];
		entity_get_string( ent, EV_SZ_noise, szNoise, charsmax( szNoise ) );
		
		// Only care if we are active
		if ( equal( szNoise, "ACTIVE" ) )
		{
			// We are active, did we get killed by ANY of the following?
			entity_get_string( attacker, EV_SZ_classname, szClassname, charsmax( szClassname ) );
			if ( equal( szClassname, "func_tankrocket" ) || equal( szClassname, "func_tanklaser" ) || equal( szClassname, "env_explosion" ) || equal( szClassname, "monster_alien_slave" ) || attacker == victim )
			{
				// FAILED!
				DispatchKeyValue( victim, "$i_fail", "1" );
			}
		}
	}
}

public a38_check( victim, inflictor, attacker, Float:dmg, dmgbits )
{
	static szTarget[32];
	entity_get_string( victim, EV_SZ_target, szTarget, charsmax( szTarget ) );
	
	// Is this our breakable?
	if ( equal( szTarget, "endgame" ) )
	{
		// Keep track of how many damage did we recieve
		flDamageDealt[2047][0] += dmg;
		
		// Too much damage?
		if ( flDamageDealt[2047][0] > 925.0 )
		{
			// FAILED!
			static ent;
			ent = find_ent_by_tname( -1, "sys_adata" );
			if ( ent )
				DispatchKeyValue( ent, "$i_fail", "1" );
		}
	}
}

public a71_check( victim, inflictor, attacker, Float:dmg, dmgbits )
{
	static szTargetname[32];
	entity_get_string( victim, EV_SZ_targetname, szTargetname, charsmax( szTargetname ) );
	
	// Is this our breakable?
	if ( equal( szTargetname, "obj" ) )
	{
		// trigger_hurt_remote is healing the entity with negative damage, exclude it
		if ( dmg > 0.0 )
		{
			// Keep track of how many damage did we recieve
			flDamageDealt[2047][0] += dmg;
			
			// Too much damage?
			if ( flDamageDealt[2047][0] > 1000.0 )
			{
				// FAILED!
				static ent;
				ent = find_ent_by_tname( -1, "sys_adata" );
				if ( ent )
					DispatchKeyValue( ent, "$i_fail", "1" );
			}
		}
	}
}

public a74_check( victim, inflictor, attacker, Float:dmg, dmgbits )
{
	// Players only
	if ( attacker >= 1 && attacker <= 14 )
	{
		static Float:flHealth, szNetname[32];
		flHealth = entity_get_float( victim, EV_FL_health );
		entity_get_string( inflictor, EV_SZ_netname, szNetname, charsmax( szNetname ) );
		
		if ( ( flHealth - dmg ) < 0.0 )
		{
			// Killed by mortar?
			if ( equal( szNetname, "models/mortarshell.mdl" ) )
			{
				entity_set_edict( victim, EV_ENT_euser2, attacker );
				set_task( 0.25, "a74_fixer", victim );
			}
		}
	}
}
public a74_fixer( victim )
{
	// FIX - Check if it did really truly die
	if ( entity_get_int( victim, EV_INT_deadflag ) != DEAD_NO )
	{
		static attacker;
		attacker = entity_get_edict( victim, EV_ENT_euser2 );
		
		if ( is_user_connected( attacker ) )
		{
			// Get!
			DispatchKeyValue( attacker, "$i_a_unlock", "75" );
		}
	}
}

public a84_helper_a( victim, attacker, shouldgib )
{
	static ent;
	ent = find_ent_by_tname( -1, "sys_adata" );
	
	if ( is_valid_ent( ent ) )
	{
		static szNoise[16], szClassname[32];
		entity_get_string( ent, EV_SZ_noise, szNoise, charsmax( szNoise ) );
		
		// Only care if we are active
		if ( equal( szNoise, "ACTIVE" ) )
		{
			// We are active, did we get killed by the monster? (Or commited suicide)
			entity_get_string( attacker, EV_SZ_classname, szClassname, charsmax( szClassname ) );
			if ( equal( szClassname, "monster_alien_grunt" ) || victim == attacker )
			{
				// FAILED!
				DispatchKeyValue( victim, "$i_fail", "1" );
			}
		}
	}
}
public a84_helper_b( victim, inflictor, attacker, Float:dmg, dmgbits )
{
	// Players only
	if ( attacker >= 1 && attacker <= 14 )
	{
		static Float:flMaxHealth, Float:flNeededDamage;
		flMaxHealth = entity_get_float( victim, EV_FL_max_health );
		flNeededDamage = flMaxHealth * 15.0 / 100.0;
		
		// Accumulate damage
		flDamageDealt[victim][attacker] += dmg;
		
		// Dealt at least 15% of the monster's total health?
		if ( flDamageDealt[victim][attacker] >= flNeededDamage )
		{
			// Got it!
			DispatchKeyValue( attacker, "$i_pass", "1" );
			
			// Reset
			flDamageDealt[victim][attacker] = 0.0;
		}
	}
}

public a97_check( victim, attacker, shouldgib )
{
	// Players only
	if ( attacker >= 1 && attacker <= 14 )
	{
		static szTargetname[16], szNoise[16];
		entity_get_string( victim, EV_SZ_targetname, szTargetname, charsmax( szTargetname ) );
		
		// Is this our monster?
		if ( equal( szTargetname, "tn_gaurd1" ) )
		{
			static ent;
			ent = find_ent_by_tname( -1, "sys_adata" );
			if ( is_valid_ent( ent ) )
			{
				entity_get_string( ent, EV_SZ_noise, szNoise, charsmax( szNoise ) );
				
				// Turrets NOT yet active?
				if ( !equal( szNoise, "FAIL" ) )
				{
					// Get!
					DispatchKeyValue( attacker, "$i_a_unlock", "98" );
				}
			}
		}
	}
}

public a104_check( victim, attacker, shouldgib )
{
	// Players only
	if ( attacker >= 1 && attacker <= 14 )
	{
		static szNoise[16];
		entity_get_string( victim, EV_SZ_noise, szNoise, charsmax( szNoise ) );
		
		// Prevent looping
		if ( !equal( szNoise, "IAMDEAD" ) )
		{
			DispatchKeyValue( victim, "noise", "IAMDEAD" );
			
			static ent;
			ent = find_ent_by_tname( -1, "sys_adata" );
			if ( is_valid_ent( ent ) )
			{
				// Keep track of how many gargantuas has been killed
				entity_set_int( ent, EV_INT_iuser4, entity_get_int( ent, EV_INT_iuser4 ) + 1 );
			}
		}
	}
}

public a111_check( victim, attacker, shouldgib )
{
	static szCheck[16];
	entity_get_string( victim, EV_SZ_target, szCheck, charsmax( szCheck ) );
	
	// Aerial kill?
	if ( equal( szCheck, "AERIAL_HIT" ) )
	{
		// Get!
		DispatchKeyValue( attacker, "$i_a_unlock", "112" );
	}
}

public a113_check( victim, attacker, shouldgib )
{
	// Store counter
	flDamageDealt[attacker][attacker]++;
	
	// Enough players?
	if ( flDamageDealt[attacker][attacker] >= 2.0 )
	{
		// Get!
		DispatchKeyValue( attacker, "$i_a_unlock", "114" );
	}
	
	// Reset very quickly
	set_task( 0.1, "a113_reset", attacker );
}
public a113_reset( attacker )
{
	flDamageDealt[attacker][attacker] = 0.0;
}

public a114_check( victim, inflictor, attacker, Float:dmg, dmgbits )
{
	static szTargetname[32];
	entity_get_string( victim, EV_SZ_targetname, szTargetname, charsmax( szTargetname ) );
	pev( victim, pev_targetname, szTargetname, charsmax( szTargetname ) );
	
	// Is this our breakable? (WTF G.BALLBLUE A ZOMBIE?)
	if ( equal( szTargetname, "i_dont_even" ) )
	{
		// Keep track of how many damage did we recieve
		flDamageDealt[2047][0] += dmg;
		
		// Too much damage?
		if ( flDamageDealt[2047][0] > 1000.0 )
		{
			// FAILED!
			static ent;
			ent = find_ent_by_tname( -1, "sys_adata" );
			if ( ent )
				DispatchKeyValue( ent, "$i_fail", "1" );
		}
	}
}

public a139_check( victim, attacker, shouldgib )
{
	// Victim was on the vehicle?
	static ent, szTargetname[ 16 ];
	ent = entity_get_edict( victim, EV_ENT_groundentity );
	entity_get_string( ent, EV_SZ_targetname, szTargetname, charsmax( szTargetname ) );
	if ( equal( szTargetname, "auto2" ) || equal( szTargetname, "auto3" ) )
	{
		// Store counter
		flDamageDealt[attacker][attacker]++;
		
		// Reset
		set_task( 30.0, "a139_reset", attacker );
	}
	else
	{
		// Perfomed a second kill ON the vehicle?
		ent = entity_get_edict( attacker, EV_ENT_groundentity );
		entity_get_string( ent, EV_SZ_targetname, szTargetname, charsmax( szTargetname ) );
		if ( equal( szTargetname, "auto2" ) || equal( szTargetname, "auto3" ) )
		{
			if ( entity_get_int( attacker, EV_INT_iuser4 ) && flDamageDealt[attacker][attacker] )
			{
				// Get!
				DispatchKeyValue( attacker, "$i_a_unlock", "140" );
			}
		}
	}
}
public a139_reset( attacker )
{
	flDamageDealt[attacker][attacker] = 0.0;
}

public a142_check( victim, attacker, shouldgib )
{
	// Explosion?
	static szClassname[ 32 ];
	entity_get_string( attacker, EV_SZ_classname, szClassname, charsmax( szClassname ) );
	if ( equal( szClassname, "env_explosion" ) )
	{
		// Store counter
		flDamageDealt[0][0]++;
	}
	
	if ( flDamageDealt[0][0] >= 3.0 )
	{
		// Iterate through all players
		static ent;
		ent = 0;
		while ( ( ent = find_ent_by_class( ent, "player" ) ) != 0 )
		{
			// Get!
			DispatchKeyValue( ent, "$i_a_unlock", "143" );
		}
	}
	
	// Reset very quickly
	set_task( 0.25, "a142_reset", attacker );
}
public a142_reset( attacker )
{
	flDamageDealt[0][0] = 0.0;
}

// END ACHIEVEMENT PROGRAM

public check_entities( entid, kvd_handle )
{
	if (is_valid_ent(entid))
	{
		static classname[32], keyname[32], value[32];
		get_kvd(kvd_handle, KV_ClassName, classname, 31);
		
		// Delete all XP-abusive entities
		if (equali(classname, "monster_cockroach"))
		{
			remove_entity(entid);
			return FMRES_SUPERCEDE;
		}
		else if (equali(classname, "monster_rat"))
		{
			remove_entity(entid);
			return FMRES_SUPERCEDE;
		}
		else if (equali(classname, "monster_leech"))
		{
			remove_entity(entid);
			return FMRES_SUPERCEDE;
		}
		/*else if (equali(classname, "monster_barney_dead")) // Not really XP-abusive, but until the bug gets fixed, these are blocking other entities spawn
		{
			remove_entity(entid);
			return FMRES_SUPERCEDE;
		}
		else if (equali(classname, "monster_hevsuit_dead"))
		{
			remove_entity(entid);
			return FMRES_SUPERCEDE;
		}
		else if (equali(classname, "monster_hgrunt_dead"))
		{
			remove_entity(entid);
			return FMRES_SUPERCEDE;
		}
		else if (equali(classname, "monster_human_grunt_ally_dead"))
		{
			remove_entity(entid);
			return FMRES_SUPERCEDE;
		}
		else if (equali(classname, "monster_otis_dead"))
		{
			remove_entity(entid);
			return FMRES_SUPERCEDE;
		}
		else if (equali(classname, "monster_scientist_dead"))
		{
			remove_entity(entid);
			return FMRES_SUPERCEDE;
		}*/
		else if (equali(classname, "game_score"))
		{
			remove_entity(entid);
			return FMRES_SUPERCEDE;
		}
		else if (equali(classname, "squadmaker") || equali(classname, "monstermaker") || equali(classname, "env_xenmaker")) // Check if any of those monsters are on a squad/monster maker
		{
			get_kvd(kvd_handle, KV_KeyName, keyname, 31);
			if (equali(keyname, "monstertype"))
			{
				get_kvd(kvd_handle, KV_Value, value, 31);
				if (equali(value, "monster_cockroach"))
				{
					remove_entity(entid);
					return FMRES_IGNORED;
				}
				else if (equali(value, "monster_rat"))
				{
					remove_entity(entid);
					return FMRES_IGNORED;
				}
				else if (equali(value, "monster_leech"))
				{
					remove_entity(entid);
					return FMRES_IGNORED;
				}
				/*else if (equali(value, "monster_barney_dead"))
				{
					remove_entity(entid);
					return FMRES_IGNORED;
				}
				else if (equali(value, "monster_hevsuit_dead"))
				{
					remove_entity(entid);
					return FMRES_IGNORED;
				}
				else if (equali(value, "monster_hgrunt_dead"))
				{
					remove_entity(entid);
					return FMRES_IGNORED;
				}
				else if (equali(value, "monster_human_grunt_ally_dead"))
				{
					remove_entity(entid);
					return FMRES_IGNORED;
				}
				else if (equali(value, "monster_otis_dead"))
				{
					remove_entity(entid);
					return FMRES_IGNORED;
				}
				else if (equali(value, "monster_scientist_dead"))
				{
					remove_entity(entid);
					return FMRES_IGNORED;
				}*/
			}
		}
		else if (equali(classname, "trigger_setcvar"))
		{
			get_kvd(kvd_handle, KV_KeyName, keyname, 31);
			if (equali(keyname, "m_iszCVarToChange"))
			{
				get_kvd(kvd_handle, KV_Value, value, 31);
				if (equali(value, "sk_player_", 10))
				{
					// Don't let any "anti-xpmod" setting to take effect
					remove_entity(entid);
					return FMRES_IGNORED;
				}
			}
		}
	}
	
	return FMRES_IGNORED;
}

public rexp_disable( victim, inflictor, attacker, Float:dmg, dmgbits )
{
	// Players only
	if ( attacker >= 1 && attacker <= 14 )
	{
		// !!! Only care if player ally !!!
		if ( entity_get_int( victim, EV_INT_iuser4 ) == 0 )
			return HAM_IGNORED;
		
		// Affect wrench repair only
		if ( get_user_weapon( attacker ) == 20 )
		{
			static Float:flHealth, Float:flMaxHealth;
			flHealth = entity_get_float( victim, EV_FL_health );
			flMaxHealth = entity_get_float( victim, EV_FL_max_health );
			
			if ( ( flHealth + dmg ) > flMaxHealth )
				entity_set_float( victim, EV_FL_health, flMaxHealth );
			else
				entity_set_float( victim, EV_FL_health, ( flHealth + dmg ) );
			
			SetHamParamFloat( 4, 0.0 );
		}
	}
	
	return HAM_IGNORED;
}

public client_PreThink( id )
{
	if ( is_user_alive( id ) && is_user_connected( id ) )
	{
		static Float:flFallVelocity;
		flFallVelocity = entity_get_float( id, EV_FL_flFallVelocity );
		if( flFallVelocity >= 350.0 )
		{
			falling[id] = true;
		}
		else
		{
			falling[id] = false;
		}
	}
}
