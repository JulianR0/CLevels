/*
	Imperium Sven Co-op's SCXPM: Auxiliary Scripts
	Copyright (C) 2019-2023  Julian Rodriguez
	
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

new g_MaxPlayers;

new medkitpoints_cvar;
new medkitpoints;

public plugin_precache()
{
	register_forward( FM_KeyValue, "check_entities" );
}

public plugin_init()
{
	register_plugin( "SCXPM Helper", "1.3", "Giegue" );
	
	g_MaxPlayers = get_maxplayers();
	
	// Wait for the map to finish loading before getting the value of this CVar
	medkitpoints_cvar = get_cvar_pointer( "mp_disable_medkit_points" );
	set_task( 1.0, "GetPoints" );
	
	// SCXPM HELPER
	RegisterHam( Ham_TakeDamage, "monster_sentry", "rexp_disable" );
	RegisterHam( Ham_TakeDamage, "monster_miniturret", "rexp_disable" );
	RegisterHam( Ham_TakeDamage, "monster_turret", "rexp_disable" );
	RegisterHam( Ham_TakeDamage, "monster_robogrunt", "rexp_disable" );
}

public GetPoints()
{
	medkitpoints = get_pcvar_num( medkitpoints_cvar );
}

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
		// Uncomment the lines below if you see that "_dead" entities are blocking entity spawn, breaking maps or something
		/*
		else if (equali(classname, "monster_barney_dead"))
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
		}
		*/
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
				// Same as above, uncomment if maps get drunk or something
				/*
				else if (equali(value, "monster_barney_dead"))
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
				}
				*/
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
					// If you have tweaked the SCXPM to allow insane amounts of health and armor (600+)
					// then you should allow mappers to use their "anti xpmod" to adjust their difficulty as compensation
					
					// If, however, the SCXPM has been nerfed enough to only let a small boost of health and armor (no more than 200)
					// Then you have two choices:
					
					// a) You can let the below lines UNcommented to remove the difficulty adjustment
					// b) Ripent the map and lower the increased damage (From x3 damage to x1.5, for example)
					
					// You may also consider adding this map to scxpm_mapsettings.ini and use a NO_SKILL setting
					// to disable SCXPM boosts (and still let players level up), or DISABLED to fully turn the xp mod off.
					
					// -Giegue
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
	// Medkit points are disabled. Disable for wrench repair too
	if ( !medkitpoints )
	{
		// Players only
		if ( attacker >= 1 && attacker <= g_MaxPlayers )
		{
			// !!! Only care if player ally !!!
			if ( entity_get_int( victim, EV_INT_iuser4 ) == 0 ) // AngelScript updates the entity's pev->iuser4 so AMXX can know about this.
				return HAM_IGNORED;
			
			// Affect wrench repair only
			if ( get_user_weapon( attacker ) == 20 ) // weapon ID will no longer match if any custom entity is registered
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
	}
	
	return HAM_IGNORED;
}
