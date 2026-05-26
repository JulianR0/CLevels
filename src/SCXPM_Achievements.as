/*
	Giegue's SCXPM: Achievements Handler
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

string MAP;
dictionary STORE;

void AchievementInit()
{
/*000*/	AddAchievement( "It would be a shame", "On map abandoned, let the bomb get activated, then\nescape from the facility before it explodes", LEGACY, NONE, "0" );
/*001*/	AddAchievement( "Who needs assistance?", "Reach 70 score on any map with\n10 or more handicaps enabled", NORMAL, XP, "1500" );
/*002*/	AddAchievement( "Bronze Chumtoad", "Clear map toadsnatch on Normal difficulty or higher", LEGACY, NONE, "0" );
/*003*/	AddAchievement( "Silver Chumtoad", "Clear map toadsnatch on Hard difficulty or higher", LEGACY, NONE, "0" );
/*004*/	AddAchievement( "Golden Chumtoad", "Clear map toadsnatch on Extreme difficulty", NORMAL, MULTIPLIER_2, "60" );
/*005*/	AddAchievement( "A secretless chumtoad", "On toadsnatch, unlock all weapons", NORMAL, XP, "1100" );
/*006*/	AddAchievement( "Over MY dead body!", "Clear map quarter on Hard difficulty", NORMAL, XP, "1200" );
/*007*/	AddAchievement( "Over YOUR dead body!", "Clear map quarter on Hard difficulty\nwithout letting ANY spawnpoint be destroyed", HIDDEN, XP, "60000" );
/*008*/	AddAchievement( "Climbing all day", "Clear map sc_persia without deaths", NORMAL, XP, "800" );
/*009*/	AddAchievement( "Just another worker", "Clear map mommamesa on any difficulty", LEGACY, NONE, "0" );
/*010*/	AddAchievement( "HD Graphics with 3D Support", "On mommamesa, escape from the self destruction sequence", NORMAL, MEDAL, "1" );
/*011*/	AddAchievement( "Svenmessa", "On mommamesa, clear all map objetives on Nightmare difficulty", NORMAL, XP, "800" );
/*012*/	AddAchievement( "Electrician from Hell", "Clear map deadsimpleneo2 on Overload gamemode", NORMAL, MULTIPLIER_2, "15" );
/*013*/	AddAchievement( "Gonome Degree", "Clear map deadsimpleneo2 on Gonome Hunter gamemode", NORMAL, MULTIPLIER_2, "60" );
/*014*/	AddAchievement( "NeoDifference", "Clear map deadsimpleneo2 on Protection gamemode", NORMAL, XP, "1600" );
/*015*/	AddAchievement( "No more fighting", "On BlackMesaEPF, get across the red lasers and reset the fuse", NORMAL, XP, "1000" );
/*016*/	AddAchievement( "Express Squadron", "Clear map sandstone under 9 minutes", NORMAL, XP, "1800" );
/*017*/	AddAchievement( "No Lifer? Lies!", "On jumpers, reach 160 score (Rank 1) under 60 minutes", NORMAL, MEDAL, "1" );
/*018*/	AddAchievement( "Routine tasks", "Clear map fortified1 on Normal difficulty or higher", LEGACY, NONE, "0" );
/*019*/	AddAchievement( "Apache? Where?", "Clear map fortified1 on Hard difficulty or higher", LEGACY, NONE, "0" );
/*020*/	AddAchievement( "S.A.C. Elite", "Clear map fortified1 on Ultra Hard difficulty", NORMAL, XP, "8000" );
/*021*/	AddAchievement( "Cheating Death", "Clear map fortified1 on any difficulty with Survival Mode", NORMAL, XP, "9000" );
/*022*/	AddAchievement( "I can help, too!", "On map fortified1, resign as commander to assist players\nin the battlefield and help them win the mission.", NORMAL, GOLDEN_HAMMER, "1" );
/*023*/	AddAchievement( "INMORTAL", "Clear map fortified1 on Ultra Hard difficulty with Survival Mode", NORMAL, MODIFIER, "15", "Extreme Fortifier\tAward for unlocking <IMMORTAL> achievement." );
/*024*/	AddAchievement( "2.5D Platformer", "Clear svencoop2's secret puzzle", NORMAL, XP, "600" );
/*025*/	AddAchievement( "My horse is amazing", "Mount a Voltigore and survive for 20 or more seconds", LEGACY, NONE, "0" );
/*026*/	AddAchievement( "Decollapse", "Clear map sc_doc without deaths", NORMAL, XP, "600" );
/*027*/	AddAchievement( "Wasting time", "Clear map sc_psyko without using skills", NORMAL, XP, "2000" );
/*028*/	AddAchievement( "Upside down", "Clear map turretfortress on Reverse gamemode in Hard difficulty", NORMAL, XP, "3000" );
/*029*/	AddAchievement( "Unbeatable Defense", "Clear map turretfortress on Original gamemode in Hard difficulty", NORMAL, XP, "6000" );
/*030*/	AddAchievement( "A survivor from beyond", "Clear map sc_robination_revised without deaths", NORMAL, XP, "6000" );
/*031*/	AddAchievement( "Neutral Labyrinth", "On sc_mazing, kill all labyrinth hunters and gargantuas", NORMAL, XP, "840" );
/*032*/	AddAchievement( "Not so tedious, okay?", "Clear the entire sc_tetris series under 75 minutes", NORMAL, MULTIPLIER_3, "60" );
/*033*/	AddAchievement( "quadrazid", "Clear map sc_mazing under 21 minutes", NORMAL, XP, "840" );
/*034*/	AddAchievement( "Forced to Discriminate", "Clear toonrun3's minigame without killing any scientist", NORMAL, XP, "7500" );
/*035*/	AddAchievement( "Movie Ticket", "Clear map suspension on Medium difficulty or higher", LEGACY, NONE, "0" );
/*036*/	AddAchievement( "Suicide Squad", "Clear map suspension on Insane difficulty", NORMAL, XP, "36000" );
/*037*/	AddAchievement( "Complete Infiltration", "On map turretfortress, clear 6 secondary objetives (Reverse)", NORMAL, XP, "1800" );
/*038*/	AddAchievement( "Pure Atheism", "Clear map judgement on its maximum difficulty\n(Hard difficulty and increased respawn time)", NORMAL, XP, "700" );
/*039*/	AddAchievement( "Return to Sender", "On map infested, destroy the Osprey Helicopter\nand then return to the starting truck", NORMAL, XP, "600" );
/*040*/	AddAchievement( "Your face doesn't scare me", "Clear map sc_face under 2 deaths", NORMAL, XP, "1600" );
/*041*/	AddAchievement( "5 minutes equals 5", "Clear map 5minutes_b1", NORMAL, XP, "1000" );
/*042*/	AddAchievement( "Never? Forever", "Clear map never under 2 deaths", NORMAL, XP, "600" );
/*043*/	AddAchievement( "Nagoya", "Destroy all 5 secret boxes on ub_nagoya_v2", NORMAL, XP, "5000" );
/*044*/	AddAchievement( "Face vs Face", "Clear map ub_iseki2 under 4 deaths", NORMAL, GOLDEN_HAMMER, "1" );
/*045*/	AddAchievement( "Perfect Protection", "Clear map sciguard2 without\nletting ANY scientist to die", NORMAL, XP, "6000" );
/*046*/	AddAchievement( "Expert Gausser", "Clear the secret puzzle of map keen_birthday_part1_beta", NORMAL, XP, "600" );
/*047*/	AddAchievement( "Zero times Zero", "Clear map zero:\n\n> No deaths\n> With handicap [Medical Phobia]", NORMAL, XP, "2000" );
/*048*/	AddAchievement( "Like clockwork", "Clear map clockwork:\n\n> No deaths\n> Without skill [Team Power]", NORMAL, XP, "4000" );
/*049*/	AddAchievement( "Yoshi's Island", "Find all Freaky Flowers of sectore series", NORMAL, XP, "800" );
/*050*/	AddAchievement( "Point of View", "Clear map nm_darkisland with the [Realism] handicap", NORMAL, XP, "1000" );
/*051*/	AddAchievement( "That's the question", "Clear map Why1:\n\n> Under 20 minutes\n> With 10 or more handicaps activated", NORMAL, XP, "800" );
/*052*/	AddAchievement( "TAS-like", "Clear map toadsnatch on Extreme difficulty\nunder 20 minutes", NORMAL, MEDAL, "1" );
/*053*/	AddAchievement( "Unbalanced", "Clear map snd on Standard difficulty or higher", NORMAL, XP, "1200" );
/*054*/	AddAchievement( "Last Normalcy", "Clear map intruder:\n\n> No deaths\n> Without using Gauss or Egon\n> With handicap [Health Crisis]", NORMAL, MEDAL, "1" );
/*055*/	AddAchievement( "Is that it?", "Clear map auspices under 3 deaths", NORMAL, GOLDEN_HAMMER, "1" );
/*056*/	AddAchievement( "Made in Quake", "Clear map it_has_leaks:\n\n> No deaths\n> With handicap [Limited Equipment]", NORMAL, MULTIPLIER_2, "60" );
/*057*/	AddAchievement( "Tedious luck", "Get the good ending on leprechaun3-2", NORMAL, XP, "8000" );
/*058*/	AddAchievement( "I care", "Unlock all weapons on ub_megaman2", NORMAL, XP, "3000" );
/*059*/	AddAchievement( "A good movie", "Clear map deluge_beta_v3\non Ultra Violence difficulty without deaths", NORMAL, XP, "9000" );
/*060*/	AddAchievement( "The unfair winery", "Clear map thewinery under 2 deaths", NORMAL, XP, "4000" );
/*061*/	AddAchievement( "Hide and Seek", "Find all secrets on it_has_leaks", HIDDEN, XP, "24000" );
/*062*/	AddAchievement( "Team Fortress", "Clear map sc_fortress without deaths", NORMAL, XP, "3500" );
/*063*/	AddAchievement( "Quadratic Precision", "Clear map quad_f with a score of 80,000+ points", NORMAL, XP, "4444" );
/*064*/	AddAchievement( "Ah? Was I supposed to die?", "Survive the final explosion of map extension", NORMAL, XP, "777" );
/*065*/	AddAchievement( "Reimu's Cafe", "Clear map touhou_hakureijinja", NORMAL, XP, "1200" );
/*066*/	AddAchievement( "Capitalism Failures", "Clear map mustard on Very Hard difficulty or higher", NORMAL, MEDAL, "2" );
/*067*/	AddAchievement( "Revobination", "Find all hidden items on sc_robination_revised", HIDDEN, XP, "22000" );
/*068*/	AddAchievement( "Did I waste 20 minutes on this?", "On desertcircle, kill the King using the mortar", NORMAL, MULTIPLIER_2, "60" );
/*069*/	AddAchievement( "I think I broke it", "On map sc_another, kill the barney\nbefore it can activate the turrets", NORMAL, XP, "2750" );
/*070*/	AddAchievement( "Yes, hello. The exit?", "Find gmantowers's secret", HIDDEN, XP, "2000" );
/*071*/	AddAchievement( "Pet the Skulk", "Clear map ns_escape on Veteran difficulty or higher", NORMAL, XP, "6000" );

	
	for ( int iPlayerIndex = 0; iPlayerIndex < 33; iPlayerIndex++ )
	{
		playerAchievements[ iPlayerIndex ].resize( gameAchievements.length() );
	}
	
	// Think for global achievements
	g_Scheduler.SetInterval( "__global", 0.3, g_Scheduler.REPEAT_INFINITE_TIMES );
	
	// Hooks for global and map achievements
	g_Hooks.RegisterHook( Hooks::Monster::MonsterTakeDamage, @MonsterTakeDamage );
	g_Hooks.RegisterHook( Hooks::Monster::MonsterKilled, @MonsterKilled );
}

void AddAchievement( const string achievementName, const string achievementDescription, achievementType T, achievementReward R, const string B, const string moDATA = "" )
{
	gameAchievements.insertLast( achievementName + "#" + achievementDescription + "#" + string( T ) + "#" + string( R ) + "#" + B + "#" + moDATA );
	
	if ( T == NORMAL ) gameNormalAchievements++;
	if ( T != LEGACY ) gameMaxAchievements++;
}

void MapStart()
{
	MAP = string( g_Engine.mapname ).ToLowercase();
	g_Engine.found_secrets = 0;
	
	CBaseEntity@ pThinker = g_EntityFuncs.Create( "scxpm_achievement_thinker", g_vecZero, g_vecZero, true );
	CBaseEntity@ pEntity = null;
	
	// Setup triggers
	if ( MAP == "toadsnatch" )
	{
		// #004 (Golden Chumtoad)
		@pEntity = g_EntityFuncs.Create( "trigger_changevalue", g_vecZero, g_vecZero, false );
		pEntity.pev.targetname = "extreme_selected";
		pEntity.pev.target = "mapwon";
		pEntity.KeyValue( "m_iszValueName", "$i_difficulty" );
		pEntity.KeyValue( "m_iszNewValue", "1" );
		
		pThinker.pev.targetname = "mapwon"; 
		
		// #005 (A secretless chumtoad)
		const array< string > arrTargetnames = { "spawnshotgun", "spawnm16", "spawnspore", "spawnhornet", "spawncrossbow", "spawngauss", "spawnsniper", "spawnrevolver", "spawnrpg", "spawnsaw", "spawnuzi" };
		for ( uint i = 0; i < arrTargetnames.length(); i++ )
		{
			@pEntity = g_EntityFuncs.Create( "trigger_relay", g_vecZero, g_vecZero, true );
			pEntity.pev.targetname = arrTargetnames[ i ];
			pEntity.pev.target = "weapon_counter";
			pEntity.KeyValue( "triggerstate", "2" );
			g_EntityFuncs.DispatchSpawn( pEntity.edict() );
		}
		
		@pEntity = g_EntityFuncs.Create( "game_counter", g_vecZero, g_vecZero, true );
		pEntity.pev.targetname = "weapon_counter";
		pEntity.pev.target = "toadsnatch_allweapons";
		pEntity.pev.health = 11;
		pEntity.pev.spawnflags = 1;
		g_EntityFuncs.DispatchSpawn( pEntity.edict() );
		
		@pEntity = g_EntityFuncs.Create( "scxpm_achievement_thinker", g_vecZero, g_vecZero, true );
		pEntity.pev.targetname = "toadsnatch_allweapons";
		pEntity.pev.target = "toadsnatch_allweapons";
		g_EntityFuncs.DispatchSpawn( pEntity.edict() );
		
		// #052 (TAS-like)
		@pEntity = g_EntityFuncs.Create( "scxpm_achievement_thinker", g_vecZero, g_vecZero, true );
		pEntity.pev.targetname = "extreme_selected";
		pEntity.pev.target = "toadsnatch_tasstart";
		g_EntityFuncs.DispatchSpawn( pEntity.edict() );
	}
	else if ( MAP == "quarter" )
	{
		// #006 (Over MY dead body!)
		pThinker.pev.targetname = "win"; 
		
		// #007 (Over YOUR dead body!)
		@pEntity = g_EntityFuncs.Create( "trigger_changevalue", g_vecZero, g_vecZero, false );
		pEntity.pev.targetname = "area4_lose";
		pEntity.pev.target = "win";
		pEntity.KeyValue( "m_iszValueName", "$i_fail" );
		pEntity.KeyValue( "m_iszNewValue", "1" );
	}
	else if ( MAP == "sc_persia" )					pThinker.pev.targetname = "texte_final";
	else if ( MAP == "mommamesa" )
	{
		// #010 (HD Graphics with 3D Support)
		@pEntity = g_EntityFuncs.Create( "trigger_changevalue", g_vecZero, g_vecZero, false );
		pEntity.pev.targetname = "endgood_escapeseqmm";
		pEntity.pev.target = "!activator";
		pEntity.KeyValue( "m_iszValueName", "$i_escape" );
		pEntity.KeyValue( "m_iszNewValue", "1" );
		
		@pEntity = g_EntityFuncs.Create( "scxpm_achievement_thinker", g_vecZero, g_vecZero, true );
		pEntity.pev.targetname = "endgood_escapemker";
		pEntity.pev.target = "mommamesa_escape";
		g_EntityFuncs.DispatchSpawn( pEntity.edict() );
		
		// #011 (Svenmessa)
		@pEntity = g_EntityFuncs.Create( "trigger_changevalue", g_vecZero, g_vecZero, false );
		pEntity.pev.targetname = "setdifficulty_nightmare";
		pEntity.pev.target = "mm_ending";
		pEntity.KeyValue( "m_iszValueName", "$i_nightmare" );
		pEntity.KeyValue( "m_iszNewValue", "1" );
		
		pThinker.pev.targetname = "mm_ending";
	}
	else if ( MAP == "deadsimpleneo2" )
	{
		// #012 (Electrician from Hell)
		@pEntity = g_EntityFuncs.Create( "trigger_changevalue", g_vecZero, g_vecZero, false );
		pEntity.pev.targetname = "objective2t";
		pEntity.pev.target = "endrelay";
		pEntity.KeyValue( "m_iszValueName", "$i_gamemode" );
		pEntity.KeyValue( "m_iszNewValue", "1" );
		
		// #013 (Gonome Degree)
		@pEntity = g_EntityFuncs.Create( "trigger_changevalue", g_vecZero, g_vecZero, false );
		pEntity.pev.targetname = "objective4t";
		pEntity.pev.target = "endrelay";
		pEntity.KeyValue( "m_iszValueName", "$i_gamemode" );
		pEntity.KeyValue( "m_iszNewValue", "2" );
		
		// #014 (NeoDifference)
		@pEntity = g_EntityFuncs.Create( "trigger_changevalue", g_vecZero, g_vecZero, false );
		pEntity.pev.targetname = "objective3t";
		pEntity.pev.target = "endrelay";
		pEntity.KeyValue( "m_iszValueName", "$i_gamemode" );
		pEntity.KeyValue( "m_iszNewValue", "3" );
		
		pThinker.pev.targetname = "endrelay";
	}
	else if ( MAP == "blackmesaepf" )
	{
		pThinker.pev.targetname = "miss4_pushbutton_mm";
		
		// #015 (No more fighting)
		@pEntity = g_EntityFuncs.Create( "info_target", g_vecZero, g_vecZero, true );
		pEntity.pev.targetname = "passed_laser";
		pEntity.pev.solid = SOLID_TRIGGER;
		g_EntityFuncs.SetSize( pEntity.pev, Vector( -184, -218, -128 ), Vector( 184, 218, 128 ) );
		g_EntityFuncs.SetOrigin( pEntity, Vector( -715, -1200, 10 ) );
	}
	else if ( MAP == "sandstone" )					pThinker.pev.targetname = "8min";
	else if ( MAP == "jumpers" )
	{
		// #017 (No Lifer? Lies!)
		@pEntity = g_EntityFuncs.Create( "game_counter", g_vecZero, g_vecZero, false );
		pEntity.pev.spawnflags = 1;
		pEntity.pev.health = 160;
		pEntity.pev.target = "goal_reach";
		pEntity.pev.targetname = "pad_touched_txt";
		
		@pEntity = g_EntityFuncs.Create( "trigger_relay", g_vecZero, g_vecZero, true );
		pEntity.pev.targetname = "begin_game";
		pEntity.pev.target = "time_expired";
		pEntity.KeyValue( "delay", "180" );
		pEntity.KeyValue( "triggerstate", "2" );
		g_EntityFuncs.DispatchSpawn( pEntity.edict() );
		
		@pEntity = g_EntityFuncs.Create( "trigger_changevalue", g_vecZero, g_vecZero, false );
		pEntity.pev.targetname = "time_expired";
		pEntity.pev.target = "goal_reach";
		pEntity.KeyValue( "m_iszValueName", "$i_fail" );
		pEntity.KeyValue( "m_iszNewValue", "1" );
		
		pThinker.pev.targetname = "goal_reach";
	}
	else if ( MAP == "fortified1" )
	{
		// #020 (S.A.C. Elite)
		@pEntity = g_EntityFuncs.Create( "trigger_changevalue", g_vecZero, g_vecZero, false );
		pEntity.pev.targetname = "ultra_selected";
		pEntity.pev.target = "gocreditsgo_win";
		pEntity.KeyValue( "m_iszValueName", "$i_difficulty" );
		pEntity.KeyValue( "m_iszNewValue", "1" );
		
		// #021 (Cheating Death)
		@pEntity = g_EntityFuncs.Create( "trigger_changevalue", g_vecZero, g_vecZero, false );
		pEntity.pev.targetname = "legend_selected";
		pEntity.pev.target = "gocreditsgo_win";
		pEntity.KeyValue( "m_iszValueName", "$i_survival" );
		pEntity.KeyValue( "m_iszNewValue", "1" );
		
		// #022 (I can help, too!)
		// activate the flag on resign, after mission "officially" starts
		@pEntity = g_EntityFuncs.Create( "trigger_createentity", g_vecZero, g_vecZero, false );
		pEntity.pev.targetname = "timer_started";
		pEntity.KeyValue( "m_iszCrtEntChildClass", "trigger_changevalue" );
		pEntity.KeyValue( "m_iszCrtEntChildName", "resign_manager" );
		pEntity.KeyValue( "-target", "!activator" );
		pEntity.KeyValue( "-m_iszValueName", "$i_left" );
		pEntity.KeyValue( "-m_iszNewValue", "1" );
		pEntity.KeyValue( "-m_iszValueType", "0" );
		
		pThinker.pev.targetname = "gocreditsgo_win";
	}
	else if ( MAP == "svencoop2" )
	{
		// #024 (2.5D Platformer)
		const array< string > arrTargetnames = { "grugam_left", "grugam_right" };
		for ( uint i = 0; i < arrTargetnames.length(); i++ )
		{
			@pEntity = g_EntityFuncs.Create( "trigger_changevalue", g_vecZero, g_vecZero, false );
			pEntity.pev.targetname = arrTargetnames[ i ];
			pEntity.pev.target = "!activator";
			pEntity.KeyValue( "m_iszValueName", "$i_buttons" );
			pEntity.KeyValue( "m_iszNewValue", "1" );
			pEntity.KeyValue( "m_iszValueType", "1" );
		}
		
		pThinker.pev.targetname = "grugam_win";
	}
	else if ( MAP == "sc_doc" )					pThinker.pev.targetname = "mapchangeset";
	else if ( MAP == "sc_psyko" )				pThinker.pev.targetname = "fade1";
	else if ( MAP == "turretfortress" )
	{
		// #028 (Upside down)
		pThinker.pev.targetname = "reverse_win_text";
		
		@pEntity = g_EntityFuncs.Create( "trigger_changevalue", g_vecZero, g_vecZero, false );
		pEntity.pev.targetname = "hard_selected";
		pEntity.pev.target = "reverse_win_text";
		pEntity.KeyValue( "m_iszValueName", "$i_difficulty" );
		pEntity.KeyValue( "m_iszNewValue", "1" );
		
		// #037 (Complete Infiltration)
		const array< string > arrTargetnames = { "pe1_text1", "pe2_text1", "pe3_text1", "pe4_text1", "blueprint_t", "gen_failure_1_t", "gen_failure_2_t", "gen_failure_3_t", "gen_failure_4_t" };
		for ( uint i = 0; i < arrTargetnames.length(); i++ )
		{
			@pEntity = g_EntityFuncs.Create( "trigger_relay", g_vecZero, g_vecZero, true );
			pEntity.pev.targetname = arrTargetnames[ i ];
			pEntity.pev.target = "sobj_counter";
			pEntity.KeyValue( "triggerstate", "2" );
			g_EntityFuncs.DispatchSpawn( pEntity.edict() );
		}
		
		@pEntity = g_EntityFuncs.Create( "game_counter", g_vecZero, g_vecZero, true );
		pEntity.pev.targetname = "sobj_counter";
		pEntity.pev.target = "turretfortress_sobj";
		pEntity.pev.health = 6;
		pEntity.pev.spawnflags = 1;
		g_EntityFuncs.DispatchSpawn( pEntity.edict() );
		
		@pEntity = g_EntityFuncs.Create( "scxpm_achievement_thinker", g_vecZero, g_vecZero, true );
		pEntity.pev.targetname = "turretfortress_sobj";
		pEntity.pev.target = "turretfortress_sobj";
		g_EntityFuncs.DispatchSpawn( pEntity.edict() );
	}
	else if ( MAP == "tf_original" )
	{
		// #029 (Unbeatable Defense)
		UpdateTravel( MAP );
		pThinker.pev.targetname = "kfcdeeeeead";
		
		@pEntity = g_EntityFuncs.Create( "trigger_changevalue", g_vecZero, g_vecZero, false );
		pEntity.pev.targetname = "hard_selected";
		pEntity.pev.target = "kfcdeeeeead";
		pEntity.KeyValue( "m_iszValueName", "$i_difficulty" );
		pEntity.KeyValue( "m_iszNewValue", "1" );
	}
	else if ( MAP == "sc_robination_revised" )
	{
		// #030 (A survivor from beyond)
		pThinker.pev.targetname = "mm_last_final";
		
		// #067 (Revobination)
		const array< string > arrTargetnames = { "collected_green_key", "collected_red_key", "collected_blue_key", "collected_yellow_key", "collected_gas_mask", "collected_radio_part" };
		for ( uint i = 0; i < arrTargetnames.length(); i++ )
		{
			@pEntity = g_EntityFuncs.Create( "trigger_relay", g_vecZero, g_vecZero, true );
			pEntity.pev.targetname = arrTargetnames[ i ];
			pEntity.pev.target = "item_counter";
			pEntity.KeyValue( "triggerstate", "2" );
			g_EntityFuncs.DispatchSpawn( pEntity.edict() );
		}
		
		@pEntity = g_EntityFuncs.Create( "game_counter", g_vecZero, g_vecZero, true );
		pEntity.pev.targetname = "item_counter";
		pEntity.pev.target = "sc_robination_allitems";
		pEntity.pev.health = 10;
		pEntity.pev.spawnflags = 1;
		g_EntityFuncs.DispatchSpawn( pEntity.edict() );
		
		@pEntity = g_EntityFuncs.Create( "scxpm_achievement_thinker", g_vecZero, g_vecZero, true );
		pEntity.pev.targetname = "sc_robination_allitems";
		pEntity.pev.target = "sc_robination_allitems";
		g_EntityFuncs.DispatchSpawn( pEntity.edict() );
	}
	else if ( MAP == "sc_mazing" )
	{
		// #031 (Neutral Labyrinth)
		const array< string > arrTargetnames = { "lab_hunter_dies", "lab_garg_dies" };
		for ( uint i = 0; i < arrTargetnames.length(); i++ )
		{
			@pEntity = g_EntityFuncs.Create( "trigger_relay", g_vecZero, g_vecZero, true );
			pEntity.pev.targetname = arrTargetnames[ i ];
			pEntity.pev.target = "kill_counter";
			pEntity.KeyValue( "triggerstate", "2" );
			g_EntityFuncs.DispatchSpawn( pEntity.edict() );
		}
		
		@pEntity = g_EntityFuncs.Create( "game_counter", g_vecZero, g_vecZero, true );
		pEntity.pev.targetname = "kill_counter";
		pEntity.pev.target = "sc_mazing_allkills";
		pEntity.pev.health = 21;
		pEntity.pev.spawnflags = 1;
		g_EntityFuncs.DispatchSpawn( pEntity.edict() );
		
		@pEntity = g_EntityFuncs.Create( "scxpm_achievement_thinker", g_vecZero, g_vecZero, true );
		pEntity.pev.targetname = "sc_mazing_allkills";
		pEntity.pev.target = "sc_mazing_allkills";
		g_EntityFuncs.DispatchSpawn( pEntity.edict() );
		
		// #033 (quadrazid)
		pThinker.pev.targetname = "boss1end_mm";
	}
	else if ( MAP.StartsWith( "sc_tetris" ) )
	{
		// #032 (Not so tedious, okay?)
		if ( MAP == "sc_tetris1" )
		{
			dictionary L = { { "starttime", UnixTimestamp() } };
			STORE[ "sc_tetris" ] = L;
		}
		
		@pEntity = g_EntityFuncs.Create( "scxpm_achievement_thinker", g_vecZero, g_vecZero, true );
		if ( MAP == "sc_tetris1" )				pEntity.pev.targetname = "end1msg";
		else if ( MAP == "sc_tetris2" )			pEntity.pev.targetname = "boss1cam1";
		else if ( MAP == "sc_tetris3" )			pEntity.pev.targetname = "boss1text2";
		else if ( MAP == "sc_tetris4" )			pEntity.pev.targetname = "boss1end1text1";
		else if ( MAP == "sc_tetris5" )			pEntity.pev.targetname = "boss1end1text1";
		else if ( MAP == "sc_tetris6" )			pEntity.pev.targetname = "bu1text1";
		pEntity.pev.target = "sc_tetris_savejoiners";
		g_EntityFuncs.DispatchSpawn( pEntity.edict() );
		
		if ( MAP == "sc_tetris6" )
		{
			pThinker.pev.target = "sc_tetris";
			pThinker.pev.targetname = "boss1end1mm";
		}
	}
	else if ( MAP == "toonrun3" )
	{
		// #034 (Forced to discriminate)
		@pEntity = g_EntityFuncs.Create( "trigger_changevalue", g_vecZero, g_vecZero, false );
		pEntity.pev.targetname = "whack_fail";
		pEntity.pev.target = "mm_goal_reached";
		pEntity.KeyValue( "m_iszValueName", "$i_fail" );
		pEntity.KeyValue( "m_iszNewValue", "1" );
		
		pThinker.pev.targetname = "mm_goal_reached";
	}
	else if ( MAP == "suspension" )
	{
		// #036 (Suicide Squad)
		@pEntity = g_EntityFuncs.Create( "trigger_changevalue", g_vecZero, g_vecZero, false );
		pEntity.pev.targetname = "win_white_text";
		pEntity.pev.target = "final_win";
		pEntity.KeyValue( "m_iszValueName", "$i_difficulty" );
		pEntity.KeyValue( "m_iszNewValue", "1" );
		
		pThinker.pev.targetname = "final_win";
	}
	else if ( MAP == "judgement" )
	{
		// #038 (Pure Atheism)
		@pEntity = g_EntityFuncs.Create( "trigger_changevalue", g_vecZero, g_vecZero, false );
		pEntity.pev.targetname = "1weps_txt";
		pEntity.pev.target = "winner_text";
		pEntity.KeyValue( "m_iszValueName", "$i_difficulty" );
		pEntity.KeyValue( "m_iszNewValue", "1" );
		
		pThinker.pev.targetname = "winner_text";
	}
	else if ( MAP == "infested" )
	{
		// #039 (Return to Sender)
		pThinker.pev.targetname = "in_truck";
		pThinker.pev.solid = SOLID_TRIGGER;
		g_EntityFuncs.SetSize( pThinker.pev, Vector( -100, -100, -50 ), Vector( 100, 100, 10 ) );
		g_EntityFuncs.SetOrigin( pThinker, Vector( -396, 2040, -456 ) );
		
		@pEntity = g_EntityFuncs.Create( "trigger_changevalue", g_vecZero, g_vecZero, false );
		pEntity.pev.targetname = "snipers1";
		pEntity.pev.target = "in_truck";
		pEntity.KeyValue( "m_iszValueName", "$i_active" );
		pEntity.KeyValue( "m_iszNewValue", "1" );
	}
	if ( MAP == "sc_face" )							pThinker.pev.targetname = "end_msg";
	else if ( MAP == "5minutes_b1" )				pThinker.pev.targetname = "text_zenbu";
	else if ( MAP == "never" )						pThinker.pev.targetname = "therealend_text1";
	else if ( MAP == "ub_nagoya_v2" )
	{
		// #043 (Nagoya)
		// pass player (!activator) to box breaks
		@pEntity = g_EntityFuncs.Create( "multi_manager", g_vecZero, g_vecZero, false );
		pEntity.pev.targetname = "btn_seq00";
		pEntity.KeyValue( "box_counter", "0" );
		
		@pEntity = g_EntityFuncs.Create( "trigger_changevalue", g_vecZero, g_vecZero, false );
		pEntity.pev.targetname = "box_counter";
		pEntity.pev.target = "!activator";
		pEntity.KeyValue( "m_iszValueName", "$i_boxes" );
		pEntity.KeyValue( "m_iszNewValue", "1" );
		pEntity.KeyValue( "m_iszValueType", "1" );
		
		@pEntity = g_EntityFuncs.Create( "game_counter", g_vecZero, g_vecZero, true );
		pEntity.pev.targetname = "box_counter";
		pEntity.pev.target = "all_boxes";
		pEntity.pev.health = 5;
		pEntity.pev.spawnflags = 1;
		g_EntityFuncs.DispatchSpawn( pEntity.edict() );
		
		pThinker.pev.targetname = "all_boxes";
	}
	else if ( MAP == "ub_iseki2" )					pThinker.pev.targetname = "mm_last";
	else if ( MAP == "sciguard2" )
	{
		// #045 (Perfect Protection)
		@pEntity = g_EntityFuncs.Create( "trigger_changevalue", g_vecZero, g_vecZero, false );
		pEntity.pev.targetname = "scidiesnd";
		pEntity.pev.target = "win";
		pEntity.KeyValue( "m_iszValueName", "$i_fail" );
		pEntity.KeyValue( "m_iszNewValue", "1" );
		
		pThinker.pev.targetname = "win";
	}
	else if ( MAP == "keen_birthday_part1_beta" )
	{
		// #046 (Expert Gausser)
		pThinker.pev.targetname = "gausswin";
		pThinker.pev.solid = SOLID_TRIGGER;
		g_EntityFuncs.SetSize( pThinker.pev, Vector( -110, -40, -50 ), Vector( 110, 40, 50 ) );
		g_EntityFuncs.SetOrigin( pThinker, Vector( 2910, 2270, -200 ) );
	}
	else if ( MAP == "zero" )
	{
		// #047 (Zero times Zero)
		g_Engine.found_secrets = MEDICAL_PHOBIA;
		pThinker.pev.targetname = "saving";
	}
	else if ( MAP == "clockwork" )					pThinker.pev.targetname = "finaldoor";
	else if ( MAP == "sectore_3" )				pThinker.pev.targetname = "allflowers_msg";
	else if ( MAP == "nm_darkisland" )
	{
		// #050 (Point of View)
		g_Engine.found_secrets = REALISM;
		pThinker.pev.targetname = "the_end";
	}
	else if ( MAP == "why1" )					pThinker.pev.targetname = "omggameover";
	else if ( MAP == "snd" )
	{
		// #053 (Unbalanced)
		@pEntity = g_EntityFuncs.Create( "trigger_changevalue", g_vecZero, g_vecZero, false );
		pEntity.pev.targetname = "win_white_text";
		pEntity.pev.target = "mission_win";
		pEntity.KeyValue( "m_iszValueName", "$i_easy" );
		pEntity.KeyValue( "m_iszNewValue", "1" );
		
		pThinker.pev.targetname = "mission_win";
	}
	else if ( MAP == "intruder" )
	{
		// #054 (Last Normalcy)
		g_Engine.found_secrets = HEALTH_CRISIS;
		pThinker.pev.targetname = "endyboobs";
	}
	else if ( MAP == "auspices" )					pThinker.pev.targetname = "multifinal12";
	else if ( MAP == "it_has_leaks" )
	{
		// #056 (Made in Quake)
		g_Engine.found_secrets = LIMITED_EQUIPMENT;
		pThinker.pev.targetname = "it_end_text";
		
		// #061 (Hide and Seek)
		const array< string > arrTargetnames = { "it_secret_disc_1", "it_secret_disc_2", "it_secret_disc_3", "it_secret_disc_4", "it_secret_disc_6", "it_secret_disc_7", "it_secret_disc_8", "it_secret_disc_9", "it_secret_disc_10", "it_secret_disc_11", "it_secret_disc_12", "it_secret_disc_13" };
		for ( uint i = 0; i < arrTargetnames.length(); i++ )
		{
			@pEntity = g_EntityFuncs.Create( "trigger_relay", g_vecZero, g_vecZero, true );
			pEntity.pev.targetname = arrTargetnames[ i ];
			pEntity.pev.target = "secret_counter";
			pEntity.KeyValue( "triggerstate", "2" );
			g_EntityFuncs.DispatchSpawn( pEntity.edict() );
		}
		
		@pEntity = g_EntityFuncs.Create( "game_counter", g_vecZero, g_vecZero, true );
		pEntity.pev.targetname = "secret_counter";
		pEntity.pev.target = "it_has_leaks_allsecrets";
		pEntity.pev.health = 12;
		pEntity.pev.spawnflags = 1;
		g_EntityFuncs.DispatchSpawn( pEntity.edict() );
		
		@pEntity = g_EntityFuncs.Create( "scxpm_achievement_thinker", g_vecZero, g_vecZero, true );
		pEntity.pev.targetname = "it_has_leaks_allsecrets";
		pEntity.pev.target = "it_has_leaks_allsecrets";
		g_EntityFuncs.DispatchSpawn( pEntity.edict() );
	}
	else if ( MAP == "leprechaun3-2" )			pThinker.pev.targetname = "the_end_mm";
	else if ( MAP == "ub_megaman2" )
	{
		// #058 (I care)
		const array< string > arrTargetnames = { "roll_bns1", "roll_bns2", "roll_bns3" };
		for ( uint i = 0; i < arrTargetnames.length(); i++ )
		{
			@pEntity = g_EntityFuncs.Create( "trigger_relay", g_vecZero, g_vecZero, true );
			pEntity.pev.targetname = arrTargetnames[ i ];
			pEntity.pev.target = "weapon_counter";
			pEntity.KeyValue( "triggerstate", "2" );
			g_EntityFuncs.DispatchSpawn( pEntity.edict() );
		}
		
		@pEntity = g_EntityFuncs.Create( "game_counter", g_vecZero, g_vecZero, true );
		pEntity.pev.targetname = "weapon_counter";
		pEntity.pev.target = "ub_megaman2_allweapons";
		pEntity.pev.health = 3;
		pEntity.pev.spawnflags = 1;
		g_EntityFuncs.DispatchSpawn( pEntity.edict() );
		
		@pEntity = g_EntityFuncs.Create( "scxpm_achievement_thinker", g_vecZero, g_vecZero, true );
		pEntity.pev.targetname = "ub_megaman2_allweapons";
		pEntity.pev.target = "ub_megaman2_allweapons";
		g_EntityFuncs.DispatchSpawn( pEntity.edict() );
	}
	else if ( MAP == "deluge_beta_v3" )				pThinker.pev.targetname = "map_end_uv";
	else if ( MAP == "thewinery" )					pThinker.pev.targetname = "endgameTR";
	else if ( MAP == "sc_fortress" )				pThinker.pev.targetname = "lastmgr";
	else if ( MAP == "quad_f" )
	{
		// #063 (Quadratic Precision)
		UpdateTravel( MAP );
		pThinker.pev.targetname = "txt_temp";
	}
	else if ( MAP == "extension" )				pThinker.pev.targetname = "killass";
	else if ( MAP == "touhou_hakureijinja" )	pThinker.pev.targetname = "game_end_mm";
	else if ( MAP == "mustard" )
	{
		// #066 (Capitalism Failures)
		@pEntity = g_EntityFuncs.Create( "trigger_changevalue", g_vecZero, g_vecZero, false );
		pEntity.pev.targetname = "hard_win";
		pEntity.pev.target = "evenlonger_fadein_hold";
		pEntity.KeyValue( "m_iszValueName", "$i_difficulty" );
		pEntity.KeyValue( "m_iszNewValue", "2" );
		
		pThinker.pev.targetname = "evenlonger_fadein_hold";
	}
	else if ( MAP == "sc_another" )
	{
		// #069 (I think I broke it)
		@pEntity = g_EntityFuncs.Create( "trigger_changevalue", g_vecZero, g_vecZero, false );
		pEntity.pev.targetname = "tn_turrets_active";
		pEntity.pev.target = "sec_kill_c";
		pEntity.KeyValue( "m_iszValueName", "$i_fail" );
		pEntity.KeyValue( "m_iszNewValue", "1" );
		
		pThinker.pev.targetname = "sec_kill_c";
	}
	else if ( MAP == "gmantowers" )
	{
		// #070 (Yes, hello. The exit?)
		pThinker.pev.targetname = "found";
		pThinker.pev.solid = SOLID_TRIGGER;
		g_EntityFuncs.SetSize( pThinker.pev, Vector( -35, -35, -70 ), Vector( 35, 35, 70 ) );
		g_EntityFuncs.SetOrigin( pThinker, Vector( -1606, 158, -1860 ) );
	}
	else if ( MAP == "ns_escape" )
	{
		// #071 (Pet the Skulk)
		@pEntity = g_EntityFuncs.Create( "trigger_changevalue", g_vecZero, g_vecZero, false );
		pEntity.pev.targetname = "game_mm_start_vet";
		pEntity.pev.target = "game_end_tri";
		pEntity.KeyValue( "m_iszValueName", "$i_difficulty" );
		pEntity.KeyValue( "m_iszNewValue", "1" );
		
		@pEntity = g_EntityFuncs.Create( "trigger_changevalue", g_vecZero, g_vecZero, false );
		pEntity.pev.targetname = "game_mm_start_leg";
		pEntity.pev.target = "game_end_tri";
		pEntity.KeyValue( "m_iszValueName", "$i_difficulty" );
		pEntity.KeyValue( "m_iszNewValue", "2" );
		
		pThinker.pev.targetname = "vote_end_win_save";
	}
	
	g_EntityFuncs.DispatchSpawn( pThinker.edict() );
}

class CAThinker : ScriptBaseEntity
{
	void Spawn()
	{
		if ( string( self.pev.targetname ).Length() == 0 )
			g_EntityFuncs.Remove( self );
		
		g_EntityFuncs.SetSize( self.pev, self.pev.mins, self.pev.maxs );
	}
	
	void Use( CBaseEntity@ pActivator, CBaseEntity@ pCaller, USE_TYPE useType, float flValue )
	{
		Reflection::Function@ F = null;
		
		// override
		if ( string( self.pev.target ).Length() != 0 )
		{
			@F = Reflection::g_Reflection.Module.FindGlobalFunction( self.pev.target );
			if ( F !is null )
				F.Call();
			return;
		}
		
		// fix hypens
		string _MAP = MAP;
		_MAP.Replace( "-", "_" );
		
		@F = Reflection::g_Reflection.Module.FindGlobalFunction( ( isdigit( _MAP[ 0 ] ) ? "_" : "" ) + _MAP );
		if ( F !is null )
			F.Call();
	}
	
	void Touch( CBaseEntity@ pOther )
	{
		// don't spam it
		if ( g_Engine.time < self.pev.ltime )
			return;
		
		Use( pOther, self, USE_TOGGLE, 0.0 );
		self.pev.ltime = g_Engine.time + 0.03;
	}
}

/** SHARED HOOKS FOR GLOBAL AND MAP ACHIEVEMENTS */
HookReturnCode MonsterTakeDamage( DamageInfo@ diData )
{
	CBaseEntity@ pAttacker = diData.pAttacker;
	CBaseEntity@ pInflictor = diData.pInflictor;
	CBaseMonster@ pVictim = cast< CBaseMonster@ >( g_EntityFuncs.Instance( diData.pVictim.pev ) );
	
	if ( pAttacker is null )
		return HOOK_CONTINUE;
	
	CBasePlayer@ pPlayer = null;
	if ( pAttacker.IsPlayer() )
		@pPlayer = cast< CBasePlayer@ >( pAttacker );
	
	// #068 (Did I waste 20 minutes on this?)
	if ( MAP == "desertcircle" )
	{
		if ( pVictim.pev.classname != "monster_hwgrunt" )
			return HOOK_CONTINUE;
		
		if ( pAttacker.IsPlayer() && pInflictor !is null )
		{
			if ( pInflictor.pev.classname != "grenade" || string( pInflictor.pev.model ) != "models/mortarshell.mdl" )
				return HOOK_CONTINUE;
			
			if ( ( pVictim.pev.health - diData.flDamage ) < 0.0 )
				UnlockAchievement( pPlayer, 68 );
		}
	}
	
	return HOOK_CONTINUE;
}

HookReturnCode MonsterKilled( CBaseMonster@ pVictim, CBaseEntity@ pAttacker, int iGib )
{
	if ( pAttacker is null )
		return HOOK_CONTINUE;
	
	CBasePlayer@ pPlayer = null;
	if ( pAttacker.IsPlayer() )
		@pPlayer = cast< CBasePlayer@ >( pAttacker );
	
	// #069 (I think I broke it)
	if ( MAP == "sc_another" )
	{
		if ( pVictim.pev.classname != "monster_barney" )
			return HOOK_CONTINUE;
		
		if ( pVictim.pev.targetname != "tn_gaurd1" )
			return HOOK_CONTINUE;
		
		if ( pAttacker.IsPlayer() )
		{
			pAttacker.KeyValue( "$i_barney_kill", "1" );
			g_EntityFuncs.FireTargets( "sec_kill_c", null, null, USE_TOGGLE, 0.0, 0.1 );
		}
	}
	
	return HOOK_CONTINUE;
}

/** UTILITY CODE (for achievements) **/
// GetHandicapCount
/* Returns how many handicaps (not forced) are enabled on the player */
int GetHandicapCount( CBasePlayer@ pPlayer )
{
	const int iPlayerIndex = pPlayer.entindex();
	
	int iHandicapCount = 0;
	if ( IsBitSet( playerHandicaps[ iPlayerIndex ], MEDICAL_PHOBIA ) ) iHandicapCount++;
	if ( IsBitSet( playerHandicaps[ iPlayerIndex ], OBSOLETE_TECHNOLOGY ) ) iHandicapCount++;
	if ( IsBitSet( playerHandicaps[ iPlayerIndex ], NITROGEN_BLOOD ) ) iHandicapCount++;
	if ( IsBitSet( playerHandicaps[ iPlayerIndex ], KARMIC_RETRIBUTION ) ) iHandicapCount++;
	if ( IsBitSet( playerHandicaps[ iPlayerIndex ], REALISM ) ) iHandicapCount++;
	if ( IsBitSet( playerHandicaps[ iPlayerIndex ], BIG_EXPLOSION ) ) iHandicapCount++;
	if ( IsBitSet( playerHandicaps[ iPlayerIndex ], LIMITED_EQUIPMENT ) ) iHandicapCount++;
	if ( IsBitSet( playerHandicaps[ iPlayerIndex ], DEAD_WEIGHT ) ) iHandicapCount++;
	if ( IsBitSet( playerHandicaps[ iPlayerIndex ], LACKING_HELP ) ) iHandicapCount++;
	if ( IsBitSet( playerHandicaps[ iPlayerIndex ], DIRTY_MAG ) ) iHandicapCount++;
	if ( IsBitSet( playerHandicaps[ iPlayerIndex ], LOST_BULLETS ) ) iHandicapCount++;
	if ( IsBitSet( playerHandicaps[ iPlayerIndex ], WEAK_RESTART ) ) iHandicapCount++;
	if ( IsBitSet( playerHandicaps[ iPlayerIndex ], DANGEROUS_WATERS ) ) iHandicapCount++;
	if ( IsBitSet( playerHandicaps[ iPlayerIndex ], BLEEDING_VIEW ) ) iHandicapCount++;
	if ( IsBitSet( playerHandicaps[ iPlayerIndex ], HEALTH_CRISIS ) ) iHandicapCount++;
	
	return iHandicapCount;
}

// GetGrace
/* Returns TRUE if the player is still within GRACE limit */
enum graceCheck
{
	GRACE_BASIC = 0,
	GRACE_SPECIAL,
	GRACE_HANDICAP
};
bool GetGrace( CBasePlayer@ pPlayer, graceCheck CHECK )
{
	const int iPlayerIndex = pPlayer.entindex();
	
	switch ( CHECK )
	{
		case GRACE_BASIC:
		{
			if ( ( lastBasicReset[ iPlayerIndex ] - gameStartTime ) > GRACE_TIME )
				return false;
			break;
		}
		case GRACE_SPECIAL:
		{
			if ( ( lastSpecialReset[ iPlayerIndex ] - gameStartTime ) > GRACE_TIME )
				return false;
			break;
		}
		case GRACE_HANDICAP:
		{
			if ( ( lastHandicapEdit[ iPlayerIndex ] - gameStartTime ) > GRACE_TIME )
				return false;
			break;
		}
	}
	
	return true;
}

// HasBasicSkills
/* Returns TRUE if the player has at least one skillpoint assigned on ANY basic skill */
bool HasBasicSkills( CBasePlayer@ pPlayer )
{
	const int iPlayerIndex = pPlayer.entindex();
	
	if ( health[ iPlayerIndex ] > 0 ) return true;
	if ( armor[ iPlayerIndex ] > 0 ) return true;
	if ( rhealth[ iPlayerIndex ] > 0 ) return true;
	if ( rarmor[ iPlayerIndex ] > 0 ) return true;
	if ( rammo[ iPlayerIndex ] > 0 ) return true;
	if ( gravity[ iPlayerIndex ] > 0 ) return true;
	if ( speed[ iPlayerIndex ] > 0 ) return true;
	if ( dist[ iPlayerIndex ] > 0 ) return true;
	if ( dodge[ iPlayerIndex ] > 0 ) return true;
	
	return false;
}

// HasSkill
/* Returns TRUE if the player has at least one skillpoint assigned on A skill */
enum skillCheck
{
	sHEALTH = 0,	// Strength
	sARMOR,			// Superior Armor
	sRHEALTH,		// Regeneration
	sRARMOR,		// Nano Armor
	sRAMMO,			// Ammo Reincarnation
	sGRAVITY,		// Anti-Gravity Device
	sSPEED,			// Awareness
	sDIST,			// Team Power
	sDODGE			// Block Attack
};
bool HasSkill( CBasePlayer@ pPlayer, skillCheck SKILL )
{
	const int iPlayerIndex = pPlayer.entindex();
	
	switch ( SKILL )
	{
		case sHEALTH:
		{
			if ( health[ iPlayerIndex ] > 0 )
				return true;
			break;
		}
		case sARMOR:
		{
			if ( armor[ iPlayerIndex ] > 0 )
				return true;
			break;
		}
		case sRHEALTH:
		{
			if ( rhealth[ iPlayerIndex ] > 0 )
				return true;
			break;
		}
		case sRARMOR:
		{
			if ( rarmor[ iPlayerIndex ] > 0 )
				return true;
			break;
		}
		case sRAMMO:
		{
			if ( rammo[ iPlayerIndex ] > 0 )
				return true;
			break;
		}
		case sGRAVITY:
		{
			if ( gravity[ iPlayerIndex ] > 0 )
				return true;
			break;
		}
		case sSPEED:
		{
			if ( speed[ iPlayerIndex ] > 0 )
				return true;
			break;
		}
		case sDIST:
		{
			if ( dist[ iPlayerIndex ] > 0 )
				return true;
			break;
		}
		case sDODGE:
		{
			if ( dodge[ iPlayerIndex ] > 0 )
				return true;
			break;
		}
	}
	
	return false;
}

// UpdateTravel
/* Stores travelled distance to all players */
void UpdateTravel( const string LOOP )
{
	if ( MAP != LOOP )
		return;
	
	for ( int iPlayerIndex = 1; iPlayerIndex <= g_Engine.maxClients; iPlayerIndex++ )
	{
		CBasePlayer@ pPlayer = g_PlayerFuncs.FindPlayerByIndex( iPlayerIndex );
		if ( pPlayer is null || !pPlayer.IsConnected() )
			continue;
		
		if ( pPlayer.GetCustomKeyvalues().GetKeyvalue( "$v_last_move" ).Exists() )
		{
			Vector vecLastMove = pPlayer.GetCustomKeyvalues().GetKeyvalue( "$v_last_move" ).GetVector();
			
			// Add distance traveled
			int iDistance = pPlayer.GetCustomKeyvalues().GetKeyvalue( "$i_distance" ).GetInteger();
			pPlayer.KeyValue( "$i_distance", string( iDistance + ( vecLastMove - pPlayer.pev.origin ).Length() ) );
		}
		
		pPlayer.GetCustomKeyvalues().SetKeyvalue( "$v_last_move", pPlayer.pev.origin );
	}
	
	g_Scheduler.SetTimeout( "UpdateTravel", 0.1, LOOP );
}

/** GLOBAL ACHIEVEMENT THINKS **/
void __global()
{
	for ( int iPlayerIndex = 1; iPlayerIndex <= g_Engine.maxClients; iPlayerIndex++ )
	{
		CBasePlayer@ pPlayer = g_PlayerFuncs.FindPlayerByIndex( iPlayerIndex );
		if ( pPlayer is null || !pPlayer.IsConnected() )
			continue;
		
		// Achievement #001 (Who needs assistance?)
		// Use custom grace time
		if ( ( lastHandicapEdit[ iPlayerIndex ] - gameStartTime ) < ( GRACE_TIME * 2.5 ) )
		{
			if ( GetHandicapCount( pPlayer ) >= 10 )
			{
				if ( pPlayer.pev.frags < 70 )
					continue;
				
				UnlockAchievement( pPlayer, 1 );
			}
		}
	}
}

/** MAP ACHIEVEMENT TRIGGERS **/
void toadsnatch()
{
	CBaseEntity@ pEntity = g_EntityFuncs.FindEntityByTargetname( null, "mapwon" );
	if ( pEntity.GetCustomKeyvalues().GetKeyvalue( "$i_difficulty" ).GetInteger() == 0 )
		return; // not on extreme difficulty
	
	for ( int iPlayerIndex = 1; iPlayerIndex <= g_Engine.maxClients; iPlayerIndex++ )
	{
		CBasePlayer@ pPlayer = g_PlayerFuncs.FindPlayerByIndex( iPlayerIndex );
		if ( pPlayer is null || !pPlayer.IsConnected() )
			continue;
		
		const float flStartTime = pEntity.GetCustomKeyvalues().GetKeyvalue( "$f_starttime" ).GetFloat();
		const float flTotalTime = g_Engine.time - flStartTime;
		
		if ( flTotalTime < 1215 && pPlayer.pev.frags >= 105 )
			UnlockAchievement( pPlayer, 52 );
		
		if ( pPlayer.pev.frags < 200 )
			continue;
		
		UnlockAchievement( pPlayer, 4 );
	}
}

void toadsnatch_allweapons()
{
	for ( int iPlayerIndex = 1; iPlayerIndex <= g_Engine.maxClients; iPlayerIndex++ )
	{
		CBasePlayer@ pPlayer = g_PlayerFuncs.FindPlayerByIndex( iPlayerIndex );
		if ( pPlayer is null || !pPlayer.IsConnected() )
			continue;
		
		if ( pPlayer.pev.frags < 35 )
			continue;
		
		UnlockAchievement( pPlayer, 5 );
	}
}

void toadsnatch_tasstart()
{
	CBaseEntity@ pEntity = g_EntityFuncs.FindEntityByTargetname( null, "mapwon" );
	pEntity.KeyValue( "$f_starttime", string( g_Engine.time ) );
}

void quarter()
{
	CBaseEntity@ pEntity = g_EntityFuncs.FindEntityByTargetname( null, "win" );
	
	for ( int iPlayerIndex = 1; iPlayerIndex <= g_Engine.maxClients; iPlayerIndex++ )
	{
		CBasePlayer@ pPlayer = g_PlayerFuncs.FindPlayerByIndex( iPlayerIndex );
		if ( pPlayer is null || !pPlayer.IsConnected() )
			continue;
		
		if ( pPlayer.pev.frags < 60 )
			continue;
		
		UnlockAchievement( pPlayer, 6 );
		
		if ( pEntity.GetCustomKeyvalues().GetKeyvalue( "$i_fail" ).GetInteger() == 0 )
			UnlockAchievement( pPlayer, 7 );
	}
}

void sc_persia()
{
	for ( int iPlayerIndex = 1; iPlayerIndex <= g_Engine.maxClients; iPlayerIndex++ )
	{
		CBasePlayer@ pPlayer = g_PlayerFuncs.FindPlayerByIndex( iPlayerIndex );
		if ( pPlayer is null || !pPlayer.IsConnected() )
			continue;
		
		if ( pPlayer.m_iDeaths > 2 )
			continue;
		
		if ( pPlayer.pev.frags < 45 )
			continue;
		
		UnlockAchievement( pPlayer, 8 );
	}
}

void mommamesa_escape()
{
	for ( int iPlayerIndex = 1; iPlayerIndex <= g_Engine.maxClients; iPlayerIndex++ )
	{
		CBasePlayer@ pPlayer = g_PlayerFuncs.FindPlayerByIndex( iPlayerIndex );
		if ( pPlayer is null || !pPlayer.IsConnected() )
			continue;
		
		if ( pPlayer.GetCustomKeyvalues().GetKeyvalue( "$i_escape" ).GetInteger() == 0 )
			continue;
		
		if ( pPlayer.pev.frags < 40 )
			continue;
		
		UnlockAchievement( pPlayer, 10 );
	}
}

void mommamesa()
{
	CBaseEntity@ pEntity = g_EntityFuncs.FindEntityByTargetname( null, "mm_ending" );
	if ( pEntity.GetCustomKeyvalues().GetKeyvalue( "$i_nightmare" ).GetInteger() == 0 )
		return; // not playing on nightmare difficulty
	
	for ( int iPlayerIndex = 1; iPlayerIndex <= g_Engine.maxClients; iPlayerIndex++ )
	{
		CBasePlayer@ pPlayer = g_PlayerFuncs.FindPlayerByIndex( iPlayerIndex );
		if ( pPlayer is null || !pPlayer.IsConnected() )
			continue;
		
		if ( pPlayer.pev.frags < 150 )
			continue;
		
		UnlockAchievement( pPlayer, 11 );
	}
}

void deadsimpleneo2()
{
	CBaseEntity@ pEntity = g_EntityFuncs.FindEntityByTargetname( null, "endrelay" );
	int iGameMode = pEntity.GetCustomKeyvalues().GetKeyvalue( "$i_gamemode" ).GetInteger();
	if ( iGameMode == 0 )
		return; // classic gamemode does not qualify
	
	for ( int iPlayerIndex = 1; iPlayerIndex <= g_Engine.maxClients; iPlayerIndex++ )
	{
		CBasePlayer@ pPlayer = g_PlayerFuncs.FindPlayerByIndex( iPlayerIndex );
		if ( pPlayer is null || !pPlayer.IsConnected() )
			continue;
		
		if ( iGameMode == 1 && pPlayer.pev.frags >= 180 )
			UnlockAchievement( pPlayer, 12 );
		else if ( iGameMode == 2 && pPlayer.pev.frags >= 240 )
			UnlockAchievement( pPlayer, 13 );
		else if ( iGameMode == 3 && pPlayer.pev.frags >= 120 )
			UnlockAchievement( pPlayer, 14 );
	}
}

void blackmesaepf()
{
	CBaseEntity@ pBox = g_EntityFuncs.FindEntityByTargetname( null, "passed_laser" );
	if ( pBox is null )
		return;
	
	for ( int iPlayerIndex = 1; iPlayerIndex <= g_Engine.maxClients; iPlayerIndex++ )
	{
		CBasePlayer@ pPlayer = g_PlayerFuncs.FindPlayerByIndex( iPlayerIndex );
		if ( pPlayer is null || !pPlayer.IsConnected() )
			continue;
		
		if ( pPlayer.pev.frags < 20 )
			continue;
		
		if ( !pBox.Intersects( pPlayer ) )
			continue;
		
		UnlockAchievement( pPlayer, 15 );
	}
}

void sandstone()
{
	if ( ( g_Engine.time - gameStartTime ) > 600 )
		return; // out of time
	
	for ( int iPlayerIndex = 1; iPlayerIndex <= g_Engine.maxClients; iPlayerIndex++ )
	{
		CBasePlayer@ pPlayer = g_PlayerFuncs.FindPlayerByIndex( iPlayerIndex );
		if ( pPlayer is null || !pPlayer.IsConnected() )
			continue;
		
		if ( pPlayer.pev.frags < 25 )
			continue;
		
		UnlockAchievement( pPlayer, 16 );
	}
}

void jumpers()
{
	CBaseEntity@ pEntity = g_EntityFuncs.FindEntityByTargetname( null, "goal_reach" );
	if ( pEntity.GetCustomKeyvalues().GetKeyvalue( "$i_fail" ).GetInteger() == 1 )
		return; // out of time
	
	for ( int iPlayerIndex = 1; iPlayerIndex <= g_Engine.maxClients; iPlayerIndex++ )
	{
		CBasePlayer@ pPlayer = g_PlayerFuncs.FindPlayerByIndex( iPlayerIndex );
		if ( pPlayer is null || !pPlayer.IsConnected() )
			continue;
		
		if ( pPlayer.pev.targetname != "jumper" && pPlayer.pev.frags < 300 )
			continue;
		
		UnlockAchievement( pPlayer, 17 );
	}
}

void fortified1()
{
	CBaseEntity@ pEntity = g_EntityFuncs.FindEntityByTargetname( null, "gocreditsgo_win" );
	const int bOnUH = pEntity.GetCustomKeyvalues().GetKeyvalue( "$i_difficulty" ).GetInteger();
	const int bOnSurvival = pEntity.GetCustomKeyvalues().GetKeyvalue( "$i_survival" ).GetInteger();
	
	for ( int iPlayerIndex = 1; iPlayerIndex <= g_Engine.maxClients; iPlayerIndex++ )
	{
		CBasePlayer@ pPlayer = g_PlayerFuncs.FindPlayerByIndex( iPlayerIndex );
		if ( pPlayer is null || !pPlayer.IsConnected() )
			continue;
		
		if ( pPlayer.GetCustomKeyvalues().GetKeyvalue( "$i_left" ).GetInteger() == 1 )
		{
			if ( pPlayer.pev.frags < 120 )
				continue;
			
			UnlockAchievement( pPlayer, 22 );
		}
		
		if ( bOnUH == 1 )
		{
			if ( pPlayer.pev.frags < 180 )
				continue;
			
			UnlockAchievement( pPlayer, 20 );
		}
		
		if ( bOnSurvival == 1 )
		{
			if ( pPlayer.pev.frags < 60 )
				continue;
			
			UnlockAchievement( pPlayer, 21 );
		}
		
		if ( bOnUH == 1 && bOnSurvival == 1 )
		{
			if ( pPlayer.pev.frags < 150 )
				continue;
			
			UnlockAchievement( pPlayer, 23 );
		}
	}
}

void svencoop2()
{
	for ( int iPlayerIndex = 1; iPlayerIndex <= g_Engine.maxClients; iPlayerIndex++ )
	{
		CBasePlayer@ pPlayer = g_PlayerFuncs.FindPlayerByIndex( iPlayerIndex );
		if ( pPlayer is null || !pPlayer.IsConnected() )
			continue;
		
		const int iButtons = pPlayer.GetCustomKeyvalues().GetKeyvalue( "$i_buttons" ).GetInteger();
		if ( iButtons < 10 )
			continue;
		
		UnlockAchievement( pPlayer, 24 );
	}
}

void sc_doc()
{
	for ( int iPlayerIndex = 1; iPlayerIndex <= g_Engine.maxClients; iPlayerIndex++ )
	{
		CBasePlayer@ pPlayer = g_PlayerFuncs.FindPlayerByIndex( iPlayerIndex );
		if ( pPlayer is null || !pPlayer.IsConnected() )
			continue;
		
		if ( pPlayer.m_iDeaths > 0 )
			continue;
		
		if ( pPlayer.pev.frags < 30 )
			continue;
		
		UnlockAchievement( pPlayer, 26 );
	}
}

void sc_psyko()
{
	if ( ( g_Engine.time - gameStartTime ) > 960 )
		return; // out of time
	
	for ( int iPlayerIndex = 1; iPlayerIndex <= g_Engine.maxClients; iPlayerIndex++ )
	{
		CBasePlayer@ pPlayer = g_PlayerFuncs.FindPlayerByIndex( iPlayerIndex );
		if ( pPlayer is null || !pPlayer.IsConnected() )
			continue;
		
		if ( pPlayer.pev.frags < 80 )
			continue;
		
		UnlockAchievement( pPlayer, 27 );
	}
}

void turretfortress()
{
	CBaseEntity@ pEntity = g_EntityFuncs.FindEntityByTargetname( null, "reverse_win_text" );
	if ( pEntity.GetCustomKeyvalues().GetKeyvalue( "$i_difficulty" ).GetInteger() == 0 )
		return; // not on hard difficulty
	
	for ( int iPlayerIndex = 1; iPlayerIndex <= g_Engine.maxClients; iPlayerIndex++ )
	{
		CBasePlayer@ pPlayer = g_PlayerFuncs.FindPlayerByIndex( iPlayerIndex );
		if ( pPlayer is null || !pPlayer.IsConnected() )
			continue;
		
		if ( pPlayer.pev.frags < 100 )
			continue;
		
		UnlockAchievement( pPlayer, 28 );
	}
}

void turretfortress_sobj()
{
	for ( int iPlayerIndex = 1; iPlayerIndex <= g_Engine.maxClients; iPlayerIndex++ )
	{
		CBasePlayer@ pPlayer = g_PlayerFuncs.FindPlayerByIndex( iPlayerIndex );
		if ( pPlayer is null || !pPlayer.IsConnected() )
			continue;
		
		if ( pPlayer.pev.frags < 30 )
			continue;
		
		UnlockAchievement( pPlayer, 37 );
	}
}

void tf_original()
{
	CBaseEntity@ pEntity = g_EntityFuncs.FindEntityByTargetname( null, "kfcdeeeeead" );
	if ( pEntity.GetCustomKeyvalues().GetKeyvalue( "$i_difficulty" ).GetInteger() == 0 )
		return; // not on hard difficulty
	
	for ( int iPlayerIndex = 1; iPlayerIndex <= g_Engine.maxClients; iPlayerIndex++ )
	{
		CBasePlayer@ pPlayer = g_PlayerFuncs.FindPlayerByIndex( iPlayerIndex );
		if ( pPlayer is null || !pPlayer.IsConnected() )
			continue;
		
		if ( pPlayer.GetCustomKeyvalues().GetKeyvalue( "$i_distance" ).GetInteger() < 40960 )
			continue;
		
		UnlockAchievement( pPlayer, 29 );
	}
}

void sc_robination_revised()
{
	for ( int iPlayerIndex = 1; iPlayerIndex <= g_Engine.maxClients; iPlayerIndex++ )
	{
		CBasePlayer@ pPlayer = g_PlayerFuncs.FindPlayerByIndex( iPlayerIndex );
		if ( pPlayer is null || !pPlayer.IsConnected() )
			continue;
		
		if ( pPlayer.m_iDeaths > 0 )
			continue;
		
		if ( pPlayer.pev.frags < 80 )
			continue;
		
		UnlockAchievement( pPlayer, 30 );
	}
}

void sc_mazing_allkills()
{
	for ( int iPlayerIndex = 1; iPlayerIndex <= g_Engine.maxClients; iPlayerIndex++ )
	{
		CBasePlayer@ pPlayer = g_PlayerFuncs.FindPlayerByIndex( iPlayerIndex );
		if ( pPlayer is null || !pPlayer.IsConnected() )
			continue;
		
		if ( pPlayer.pev.frags < 70 )
			continue;
		
		UnlockAchievement( pPlayer, 31 );
	}
}

void sc_mazing()
{
	if ( ( g_Engine.time - gameStartTime ) > 1320 )
		return; // out of time
	
	for ( int iPlayerIndex = 1; iPlayerIndex <= g_Engine.maxClients; iPlayerIndex++ )
	{
		CBasePlayer@ pPlayer = g_PlayerFuncs.FindPlayerByIndex( iPlayerIndex );
		if ( pPlayer is null || !pPlayer.IsConnected() )
			continue;
		
		if ( pPlayer.pev.frags < 90 )
			continue;
		
		UnlockAchievement( pPlayer, 33 );
	}
}

void sc_tetris_savejoiners()
{
	dictionary L;
	STORE.get( "sc_tetris", L );
	
	for ( int iPlayerIndex = 1; iPlayerIndex <= g_Engine.maxClients; iPlayerIndex++ )
	{
		CBasePlayer@ pPlayer = g_PlayerFuncs.FindPlayerByIndex( iPlayerIndex );
		if ( pPlayer is null || !pPlayer.IsConnected() )
			continue;
		
		const string STEAMID = g_EngineFuncs.GetPlayerAuthId( pPlayer.edict() );
		const int iMapCount = int( L[ STEAMID + "_maps" ] );
		
		L[ STEAMID + "_maps" ] = iMapCount + 1;
	}
	
	STORE[ "sc_tetris" ] = L;
}

void sc_tetris()
{
	dictionary L;
	STORE.get( "sc_tetris", L );
	
	time_t T = time_t( L[ "starttime" ] );
	if ( ( UnixTimestamp() - T ) > 4560 )
		return; // out of time
	
	for ( int iPlayerIndex = 1; iPlayerIndex <= g_Engine.maxClients; iPlayerIndex++ )
	{
		CBasePlayer@ pPlayer = g_PlayerFuncs.FindPlayerByIndex( iPlayerIndex );
		if ( pPlayer is null || !pPlayer.IsConnected() )
			continue;
		
		const string STEAMID = g_EngineFuncs.GetPlayerAuthId( pPlayer.edict() );
		
		const int iMapCount = int( L[ STEAMID + "_maps" ] );
		if ( iMapCount != 6 )
			continue; // did not play full series, disqualified
		
		if ( pPlayer.pev.frags < 60 )
			continue;
		
		UnlockAchievement( pPlayer, 32 );
	}
}

void toonrun3()
{
	CBaseEntity@ pEntity = g_EntityFuncs.FindEntityByTargetname( null, "mm_goal_reached" );
	if ( pEntity.GetCustomKeyvalues().GetKeyvalue( "$i_fail" ).GetInteger() == 1 )
		return; // a scientist was killed
	
	for ( int iPlayerIndex = 1; iPlayerIndex <= g_Engine.maxClients; iPlayerIndex++ )
	{
		CBasePlayer@ pPlayer = g_PlayerFuncs.FindPlayerByIndex( iPlayerIndex );
		if ( pPlayer is null || !pPlayer.IsConnected() )
			continue;
		
		UnlockAchievement( pPlayer, 34 );
	}
}

void suspension()
{
	CBaseEntity@ pEntity = g_EntityFuncs.FindEntityByTargetname( null, "final_win" );
	if ( pEntity.GetCustomKeyvalues().GetKeyvalue( "$i_difficulty" ).GetInteger() == 0 )
		return; // not on insane difficulty
	
	for ( int iPlayerIndex = 1; iPlayerIndex <= g_Engine.maxClients; iPlayerIndex++ )
	{
		CBasePlayer@ pPlayer = g_PlayerFuncs.FindPlayerByIndex( iPlayerIndex );
		if ( pPlayer is null || !pPlayer.IsConnected() )
			continue;
		
		if ( pPlayer.pev.frags < 30 )
			continue;
		
		UnlockAchievement( pPlayer, 36 );
	}
}

void judgement()
{
	CBaseEntity@ pEntity = g_EntityFuncs.FindEntityByTargetname( null, "winner_text" );
	if ( pEntity.GetCustomKeyvalues().GetKeyvalue( "$i_difficulty" ).GetInteger() == 0 )
		return; // not on (full) hard mode
	
	if ( ( g_Engine.time - gameStartTime ) > 1260 )
		return; // out of time
	
	for ( int iPlayerIndex = 1; iPlayerIndex <= g_Engine.maxClients; iPlayerIndex++ )
	{
		CBasePlayer@ pPlayer = g_PlayerFuncs.FindPlayerByIndex( iPlayerIndex );
		if ( pPlayer is null || !pPlayer.IsConnected() )
			continue;
		
		if ( pPlayer.pev.frags < 80 )
			continue;
		
		UnlockAchievement( pPlayer, 38 );
	}
}

void infested()
{
	CBaseEntity@ pBox = g_EntityFuncs.FindEntityByTargetname( null, "in_truck" );
	if ( pBox is null )
		return;
	
	if ( pBox.GetCustomKeyvalues().GetKeyvalue( "$i_active" ).GetInteger() == 0 )
		return; // osprey not yet destroyed
	
	for ( int iPlayerIndex = 1; iPlayerIndex <= g_Engine.maxClients; iPlayerIndex++ )
	{
		CBasePlayer@ pPlayer = g_PlayerFuncs.FindPlayerByIndex( iPlayerIndex );
		if ( pPlayer is null || !pPlayer.IsConnected() )
			continue;
		
		CBaseEntity@ pHolder = g_EntityFuncs.Instance( pPlayer.pev.groundentity );
		if ( pHolder is null )
			continue;
		
		if ( pHolder.pev.targetname != "entrancetruck1" )
			continue;
		
		if ( pPlayer.pev.frags < 80 )
			continue;
		
		UnlockAchievement( pPlayer, 39 );
	}
}

void sc_face()
{
	for ( int iPlayerIndex = 1; iPlayerIndex <= g_Engine.maxClients; iPlayerIndex++ )
	{
		CBasePlayer@ pPlayer = g_PlayerFuncs.FindPlayerByIndex( iPlayerIndex );
		if ( pPlayer is null || !pPlayer.IsConnected() )
			continue;
		
		if ( pPlayer.m_iDeaths > 1 )
			continue;
		
		if ( pPlayer.pev.frags < 50 )
			continue;
		
		UnlockAchievement( pPlayer, 40 );
	}
}

void _5minutes_b1()
{
	for ( int iPlayerIndex = 1; iPlayerIndex <= g_Engine.maxClients; iPlayerIndex++ )
	{
		CBasePlayer@ pPlayer = g_PlayerFuncs.FindPlayerByIndex( iPlayerIndex );
		if ( pPlayer is null || !pPlayer.IsConnected() )
			continue;
		
		if ( pPlayer.pev.frags < 5 )
			continue;
		
		UnlockAchievement( pPlayer, 41 );
	}
}

void never()
{
	for ( int iPlayerIndex = 1; iPlayerIndex <= g_Engine.maxClients; iPlayerIndex++ )
	{
		CBasePlayer@ pPlayer = g_PlayerFuncs.FindPlayerByIndex( iPlayerIndex );
		if ( pPlayer is null || !pPlayer.IsConnected() )
			continue;
		
		if ( pPlayer.m_iDeaths > 1 )
			continue;
		
		if ( pPlayer.pev.frags < 60 )
			continue;
		
		UnlockAchievement( pPlayer, 42 );
	}
}

void ub_nagoya_v2()
{
	for ( int iPlayerIndex = 1; iPlayerIndex <= g_Engine.maxClients; iPlayerIndex++ )
	{
		CBasePlayer@ pPlayer = g_PlayerFuncs.FindPlayerByIndex( iPlayerIndex );
		if ( pPlayer is null || !pPlayer.IsConnected() )
			continue;
		
		if ( pPlayer.GetCustomKeyvalues().GetKeyvalue( "$i_boxes" ).GetInteger() == 0 )
			continue;
		
		UnlockAchievement( pPlayer, 43 );
	}
}

void ub_iseki2()
{
	for ( int iPlayerIndex = 1; iPlayerIndex <= g_Engine.maxClients; iPlayerIndex++ )
	{
		CBasePlayer@ pPlayer = g_PlayerFuncs.FindPlayerByIndex( iPlayerIndex );
		if ( pPlayer is null || !pPlayer.IsConnected() )
			continue;
		
		if ( pPlayer.m_iDeaths > 3 )
			continue;
		
		if ( pPlayer.pev.frags < 40 )
			continue;
		
		UnlockAchievement( pPlayer, 44 );
	}
}

void sciguard2()
{
	CBaseEntity@ pEntity = g_EntityFuncs.FindEntityByTargetname( null, "win" );
	if ( pEntity.GetCustomKeyvalues().GetKeyvalue( "$i_fail" ).GetInteger() == 1 )
		return; // a scientist died
	
	for ( int iPlayerIndex = 1; iPlayerIndex <= g_Engine.maxClients; iPlayerIndex++ )
	{
		CBasePlayer@ pPlayer = g_PlayerFuncs.FindPlayerByIndex( iPlayerIndex );
		if ( pPlayer is null || !pPlayer.IsConnected() )
			continue;
		
		if ( pPlayer.pev.frags < 70 )
			continue;
		
		UnlockAchievement( pPlayer, 45 );
	}
}

void keen_birthday_part1_beta()
{
	CBaseEntity@ pBox = g_EntityFuncs.FindEntityByTargetname( null, "gausswin" );
	if ( pBox is null )
		return;
	
	for ( int iPlayerIndex = 1; iPlayerIndex <= g_Engine.maxClients; iPlayerIndex++ )
	{
		CBasePlayer@ pPlayer = g_PlayerFuncs.FindPlayerByIndex( iPlayerIndex );
		if ( pPlayer is null || !pPlayer.IsConnected() )
			continue;
		
		if ( !pBox.Intersects( pPlayer ) )
			continue;
		
		UnlockAchievement( pPlayer, 46 );
	}
}

void zero()
{
	for ( int iPlayerIndex = 1; iPlayerIndex <= g_Engine.maxClients; iPlayerIndex++ )
	{
		CBasePlayer@ pPlayer = g_PlayerFuncs.FindPlayerByIndex( iPlayerIndex );
		if ( pPlayer is null || !pPlayer.IsConnected() )
			continue;
		
		if ( pPlayer.m_iDeaths > 0 )
			continue;
		
		if ( !GetGrace( pPlayer, GRACE_HANDICAP ) || !IsBitSet( playerHandicaps[ iPlayerIndex ], MEDICAL_PHOBIA ) )
			continue;
		
		if ( pPlayer.pev.frags < 15 )
			continue;
		
		UnlockAchievement( pPlayer, 47 );
	}
}

void clockwork()
{
	for ( int iPlayerIndex = 1; iPlayerIndex <= g_Engine.maxClients; iPlayerIndex++ )
	{
		CBasePlayer@ pPlayer = g_PlayerFuncs.FindPlayerByIndex( iPlayerIndex );
		if ( pPlayer is null || !pPlayer.IsConnected() )
			continue;
		
		if ( pPlayer.m_iDeaths > 0 )
			continue;
		
		if ( !GetGrace( pPlayer, GRACE_BASIC ) || HasSkill( pPlayer, sDIST ) )
			continue;
		
		if ( pPlayer.pev.frags < 20 )
			continue;
		
		UnlockAchievement( pPlayer, 48 );
	}
}

void sectore_3()
{
	for ( int iPlayerIndex = 1; iPlayerIndex <= g_Engine.maxClients; iPlayerIndex++ )
	{
		CBasePlayer@ pPlayer = g_PlayerFuncs.FindPlayerByIndex( iPlayerIndex );
		if ( pPlayer is null || !pPlayer.IsConnected() )
			continue;
		
		if ( pPlayer.pev.frags < 70 )
			continue;
		
		UnlockAchievement( pPlayer, 49 );
	}
}

void nm_darkisland()
{
	for ( int iPlayerIndex = 1; iPlayerIndex <= g_Engine.maxClients; iPlayerIndex++ )
	{
		CBasePlayer@ pPlayer = g_PlayerFuncs.FindPlayerByIndex( iPlayerIndex );
		if ( pPlayer is null || !pPlayer.IsConnected() )
			continue;
		
		if ( !GetGrace( pPlayer, GRACE_HANDICAP ) || !IsBitSet( playerHandicaps[ iPlayerIndex ], REALISM ) )
			continue;
		
		if ( pPlayer.pev.frags < 80 )
			continue;
		
		UnlockAchievement( pPlayer, 50 );
	}
}

void why1()
{
	if ( ( g_Engine.time - gameStartTime ) > 1260 )
		return; // out of time
	
	for ( int iPlayerIndex = 1; iPlayerIndex <= g_Engine.maxClients; iPlayerIndex++ )
	{
		CBasePlayer@ pPlayer = g_PlayerFuncs.FindPlayerByIndex( iPlayerIndex );
		if ( pPlayer is null || !pPlayer.IsConnected() )
			continue;
		
		if ( !GetGrace( pPlayer, GRACE_HANDICAP ) || GetHandicapCount( pPlayer ) < 10 )
			continue;
		
		if ( pPlayer.pev.frags < 25 )
			continue;
		
		UnlockAchievement( pPlayer, 51 );
	}
}

void snd()
{
	CBaseEntity@ pEntity = g_EntityFuncs.FindEntityByTargetname( null, "mission_win" );
	if ( pEntity.GetCustomKeyvalues().GetKeyvalue( "$i_easy" ).GetInteger() == 1 )
		return; // casual difficulty not allowed
	
	for ( int iPlayerIndex = 1; iPlayerIndex <= g_Engine.maxClients; iPlayerIndex++ )
	{
		CBasePlayer@ pPlayer = g_PlayerFuncs.FindPlayerByIndex( iPlayerIndex );
		if ( pPlayer is null || !pPlayer.IsConnected() )
			continue;
		
		if ( pPlayer.pev.frags < 100 )
			continue;
		
		UnlockAchievement( pPlayer, 53 );
	}
}

void intruder()
{
	for ( int iPlayerIndex = 1; iPlayerIndex <= g_Engine.maxClients; iPlayerIndex++ )
	{
		CBasePlayer@ pPlayer = g_PlayerFuncs.FindPlayerByIndex( iPlayerIndex );
		if ( pPlayer is null || !pPlayer.IsConnected() )
			continue;
		
		if ( pPlayer.m_iDeaths > 0 )
			continue;
		
		if ( !GetGrace( pPlayer, GRACE_HANDICAP ) || !IsBitSet( playerHandicaps[ iPlayerIndex ], HEALTH_CRISIS ) )
			continue;
		
		if ( pPlayer.HasNamedPlayerItem( "weapon_gauss" ) !is null || pPlayer.HasNamedPlayerItem( "weapon_egon" ) !is null )
			continue;
		
		if ( pPlayer.pev.frags < 140 )
			continue;
		
		UnlockAchievement( pPlayer, 54 );
	}
}

void auspices()
{
	for ( int iPlayerIndex = 1; iPlayerIndex <= g_Engine.maxClients; iPlayerIndex++ )
	{
		CBasePlayer@ pPlayer = g_PlayerFuncs.FindPlayerByIndex( iPlayerIndex );
		if ( pPlayer is null || !pPlayer.IsConnected() )
			continue;
		
		if ( pPlayer.m_iDeaths > 2 )
			continue;
		
		if ( pPlayer.pev.frags < 40 )
			continue;
		
		UnlockAchievement( pPlayer, 55 );
	}
}

void it_has_leaks()
{
	for ( int iPlayerIndex = 1; iPlayerIndex <= g_Engine.maxClients; iPlayerIndex++ )
	{
		CBasePlayer@ pPlayer = g_PlayerFuncs.FindPlayerByIndex( iPlayerIndex );
		if ( pPlayer is null || !pPlayer.IsConnected() )
			continue;
		
		if ( pPlayer.m_iDeaths > 0 )
			continue;
		
		if ( !GetGrace( pPlayer, GRACE_HANDICAP ) || !IsBitSet( playerHandicaps[ iPlayerIndex ], LIMITED_EQUIPMENT ) )
			continue;
		
		if ( pPlayer.pev.frags < 90 )
			continue;
		
		UnlockAchievement( pPlayer, 56 );
	}
}

void leprechaun3_2()
{
	for ( int iPlayerIndex = 1; iPlayerIndex <= g_Engine.maxClients; iPlayerIndex++ )
	{
		CBasePlayer@ pPlayer = g_PlayerFuncs.FindPlayerByIndex( iPlayerIndex );
		if ( pPlayer is null || !pPlayer.IsConnected() )
			continue;
		
		if ( pPlayer.pev.frags < 40 )
			continue;
		
		UnlockAchievement( pPlayer, 57 );
	}
}

void ub_megaman2_allweapons()
{
	for ( int iPlayerIndex = 1; iPlayerIndex <= g_Engine.maxClients; iPlayerIndex++ )
	{
		CBasePlayer@ pPlayer = g_PlayerFuncs.FindPlayerByIndex( iPlayerIndex );
		if ( pPlayer is null || !pPlayer.IsConnected() )
			continue;
		
		if ( pPlayer.pev.frags < 28 )
			continue;
		
		UnlockAchievement( pPlayer, 58 );
	}
}

void deluge_beta_v3()
{
	for ( int iPlayerIndex = 1; iPlayerIndex <= g_Engine.maxClients; iPlayerIndex++ )
	{
		CBasePlayer@ pPlayer = g_PlayerFuncs.FindPlayerByIndex( iPlayerIndex );
		if ( pPlayer is null || !pPlayer.IsConnected() )
			continue;
		
		if ( pPlayer.m_iDeaths > 0 )
			continue;
		
		if ( pPlayer.pev.frags < 70 )
			continue;
		
		UnlockAchievement( pPlayer, 59 );
	}
}

void thewinery()
{
	for ( int iPlayerIndex = 1; iPlayerIndex <= g_Engine.maxClients; iPlayerIndex++ )
	{
		CBasePlayer@ pPlayer = g_PlayerFuncs.FindPlayerByIndex( iPlayerIndex );
		if ( pPlayer is null || !pPlayer.IsConnected() )
			continue;
		
		if ( pPlayer.m_iDeaths > 1 )
			continue;
		
		if ( pPlayer.pev.frags < 90 )
			continue;
		
		UnlockAchievement( pPlayer, 60 );
	}
}

void it_has_leaks_allsecrets()
{
	for ( int iPlayerIndex = 1; iPlayerIndex <= g_Engine.maxClients; iPlayerIndex++ )
	{
		CBasePlayer@ pPlayer = g_PlayerFuncs.FindPlayerByIndex( iPlayerIndex );
		if ( pPlayer is null || !pPlayer.IsConnected() )
			continue;
		
		if ( pPlayer.pev.frags < 60 )
			continue;
		
		UnlockAchievement( pPlayer, 61 );
	}
}

void sc_fortress()
{
	for ( int iPlayerIndex = 1; iPlayerIndex <= g_Engine.maxClients; iPlayerIndex++ )
	{
		CBasePlayer@ pPlayer = g_PlayerFuncs.FindPlayerByIndex( iPlayerIndex );
		if ( pPlayer is null || !pPlayer.IsConnected() )
			continue;
		
		if ( pPlayer.m_iDeaths > 0 )
			continue;
		
		if ( pPlayer.pev.frags < 200 )
			continue;
		
		UnlockAchievement( pPlayer, 62 );
	}
}

void quad_f()
{
	CBaseEntity@ pScoreEntity = g_EntityFuncs.FindEntityByTargetname( null, "fix1" );
	if ( pScoreEntity.GetCustomKeyvalues().GetKeyvalue( "$i_stemp" ).GetInteger() < 80000 )
		return; // not enough score
	
	for ( int iPlayerIndex = 1; iPlayerIndex <= g_Engine.maxClients; iPlayerIndex++ )
	{
		CBasePlayer@ pPlayer = g_PlayerFuncs.FindPlayerByIndex( iPlayerIndex );
		if ( pPlayer is null || !pPlayer.IsConnected() )
			continue;
		
		if ( pPlayer.GetCustomKeyvalues().GetKeyvalue( "$i_distance" ).GetInteger() < 10240 )
			continue;
		
		UnlockAchievement( pPlayer, 63 );
	}
}

void extension()
{
	for ( int iPlayerIndex = 1; iPlayerIndex <= g_Engine.maxClients; iPlayerIndex++ )
	{
		CBasePlayer@ pPlayer = g_PlayerFuncs.FindPlayerByIndex( iPlayerIndex );
		if ( pPlayer is null || !pPlayer.IsConnected() )
			continue;
		
		if ( !pPlayer.IsAlive() )
			continue;
		
		if ( pPlayer.pev.frags < 20 )
			continue;
		
		UnlockAchievement( pPlayer, 64 );
	}
}

void touhou_hakureijinja()
{
	for ( int iPlayerIndex = 1; iPlayerIndex <= g_Engine.maxClients; iPlayerIndex++ )
	{
		CBasePlayer@ pPlayer = g_PlayerFuncs.FindPlayerByIndex( iPlayerIndex );
		if ( pPlayer is null || !pPlayer.IsConnected() )
			continue;
		
		if ( pPlayer.pev.frags < 50 )
			continue;
		
		UnlockAchievement( pPlayer, 65 );
	}
}

void mustard()
{
	CBaseEntity@ pEntity = g_EntityFuncs.FindEntityByTargetname( null, "evenlonger_fadein_hold" );
	const int iDifficulty = pEntity.GetCustomKeyvalues().GetKeyvalue( "$i_difficulty" ).GetInteger();
	if ( iDifficulty == 0 )
		return; // not valid on easier difficulties
	
	for ( int iPlayerIndex = 1; iPlayerIndex <= g_Engine.maxClients; iPlayerIndex++ )
	{
		CBasePlayer@ pPlayer = g_PlayerFuncs.FindPlayerByIndex( iPlayerIndex );
		if ( pPlayer is null || !pPlayer.IsConnected() )
			continue;
		
		// Why is it "2"?
		// At one point, I considered adding another achievement for Medium+ Clear.
		// But that would be making the same mistake as v4 achievements - one map with many achievements, one for each difficulty
		// We already have far enough of those. -Giegue
		if ( iDifficulty == 2 ) // Hard or higher
		{
			if ( pPlayer.pev.frags < 50 )
				continue;
			
			UnlockAchievement( pPlayer, 66 );
		}
	}
}

void sc_robination_allitems()
{
	for ( int iPlayerIndex = 1; iPlayerIndex <= g_Engine.maxClients; iPlayerIndex++ )
	{
		CBasePlayer@ pPlayer = g_PlayerFuncs.FindPlayerByIndex( iPlayerIndex );
		if ( pPlayer is null || !pPlayer.IsConnected() )
			continue;
		
		if ( pPlayer.pev.frags < 55 )
			continue;
		
		UnlockAchievement( pPlayer, 67 );
	}
}

void sc_another()
{
	CBaseEntity@ pEntity = g_EntityFuncs.FindEntityByTargetname( null, "sec_kill_c" );
	if ( pEntity.GetCustomKeyvalues().GetKeyvalue( "$i_fail" ).GetInteger() == 1 )
		return; // turrets activated
	
	for ( int iPlayerIndex = 1; iPlayerIndex <= g_Engine.maxClients; iPlayerIndex++ )
	{
		CBasePlayer@ pPlayer = g_PlayerFuncs.FindPlayerByIndex( iPlayerIndex );
		if ( pPlayer is null || !pPlayer.IsConnected() )
			continue;
		
		if ( pPlayer.GetCustomKeyvalues().GetKeyvalue( "$i_barney_kill" ).GetInteger() == 0 )
			continue;
		
		UnlockAchievement( pPlayer, 69 );
	}
}

void gmantowers()
{
	CBaseEntity@ pBox = g_EntityFuncs.FindEntityByTargetname( null, "found" );
	if ( pBox is null )
		return;
	
	for ( int iPlayerIndex = 1; iPlayerIndex <= g_Engine.maxClients; iPlayerIndex++ )
	{
		CBasePlayer@ pPlayer = g_PlayerFuncs.FindPlayerByIndex( iPlayerIndex );
		if ( pPlayer is null || !pPlayer.IsConnected() )
			continue;
		
		if ( !pBox.Intersects( pPlayer ) )
			continue;
		
		UnlockAchievement( pPlayer, 70 );
	}
}

void ns_escape()
{
	CBaseEntity@ pEntity = g_EntityFuncs.FindEntityByTargetname( null, "game_end_tri" );
	if ( pEntity.GetCustomKeyvalues().GetKeyvalue( "$i_difficulty" ).GetInteger() == 0 )
		return; // not on veteran or higher
	
	for ( int iPlayerIndex = 1; iPlayerIndex <= g_Engine.maxClients; iPlayerIndex++ )
	{
		CBasePlayer@ pPlayer = g_PlayerFuncs.FindPlayerByIndex( iPlayerIndex );
		if ( pPlayer is null || !pPlayer.IsConnected() )
			continue;
		
		if ( pPlayer.pev.frags < 20 )
			continue;
		
		UnlockAchievement( pPlayer, 71 );
	}
}
