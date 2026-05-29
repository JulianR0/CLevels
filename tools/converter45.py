#
#	Imperium Sven Co-op's SCXPM: Data Converter
#	Copyright (C) 2019-2026  Julian Rodriguez
#	
#	This program is free software: you can redistribute it and/or modify
#	it under the terms of the GNU General Public License as published by
#	the Free Software Foundation, either version 3 of the License, or
#	(at your option) any later version.
#	
#	This program is distributed in the hope that it will be useful,
#	but WITHOUT ANY WARRANTY; without even the implied warranty of
#	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#	GNU General Public License for more details.
#	
#	You should have received a copy of the GNU General Public License
#	along with this program. If not, see <https://www.gnu.org/licenses/>.
#

# This tool converts old v4.02 save files to v5.00 format
import os
import sys

def printHelp():
	print( "Usage: convert45.py [input] ..." )
	print( "Converts v4.02 SCXPM save data to v5.00.\n" )
	
	print( "input      : Save file to convert. If '-3' or no switch is used, input is treated as a folder." )
	print( "...        : Additional settings. The following values are accepted:" )
	print( "\n             -v = Verbose mode.\n             -o [output] = Where to export new save files." )
	print( "\n             -1 = Only convert main data.\n             -2 = Only convert achievement data.\n             -3 = Only convert permaincrease data." )
	
	print( "\nIf neither '-1', '-2' or '-3' switches are used, the save files and folders must have the following structure:\n" )
	print( "[input]/data/main-vault.ini" )
	print( "[input]/achievement/achievement-vault.ini" )
	print( "[input]/permaincrease/*.cfg" )
	
	print( "\nIf '-o' is not specified, files will be exported to the same folder as the input files." )

def IsLegacyAchievement( achievementID ):
	IDs = [ 0, 2, 3, 9, 18, 19, 25, 35 ]
	
	if achievementID in IDs:
		return True
	return False

def HasNewReward( achievementID ):
	IDs = [ 0, 2, 3, 9, 18, 19, 25, 35 ]
	
	if achievementID not in IDs:
		return True
	return False

def doConvert():
	args = []
	for arg in sys.argv:
		if arg == sys.argv[ 0 ]:
			continue
		args.append( arg )
	
	input = args[ 0 ]
	output = None
	verbose = True if "-v" in args else False
	
	if "-o" in args:
		if args.index( "-o" ) == len( sys.argv ) - 2:
			print( "ERROR: '-o' switch used but no output folder provided." )
			exit()
		output = args[ args.index( "-o" ) + 1 ]
		if verbose:
			print( f"Using '{output}' as output folder." )
	
	if "-1" in args:
		type = 1
		print( "Converting main data only." )
		convertMain( input, output, verbose )
	elif "-2" in args:
		type = 2
		print( "Converting achievement data only." )
		convertAchievement( input, output, verbose )
	elif "-3" in args:
		type = 3
		print( "Converting permaincrease data only." )
		convertPermaincrease( input, output, verbose )
	else:
		type = 0
		print( "Converting all data." )
		convertMain( f"{input}/data/main-vault.ini", output, verbose )
		convertAchievement( f"{input}/achievement/achievement-vault.ini", output, verbose )
		convertPermaincrease( f"{input}/permaincrease", output, verbose )

def convertMain( input, output, verbose ):
	if verbose:
		print( f"Reading '{input}'." )
	
	buffer = ""
	count = 0
	try:
		with open( input ) as OLD:
			for LINE in OLD:
				LINE = LINE.replace( "\n", "" )
				if len( LINE ) == 0:
					continue
				
				RAW = LINE.split( "\t" )
				
				STEAMID = RAW[ 0 ]
				DATA = RAW[ 1 ].split( "#" )
				
				# oddities
				if len( DATA[ -1 ] ) == 0:
					DATA.pop()
				while len( DATA ) < 38:
					DATA.append( "0" )
				
				xp = DATA[ 0 ]
				medals = DATA[ 1 ]
				
				health = DATA[ 2 ]
				armor = DATA[ 3 ]
				rhealth = DATA[ 4 ]
				rarmor = DATA[ 5 ]
				rammo = DATA[ 6 ]
				gravity = DATA[ 7 ]
				speed = DATA[ 8 ]
				dist = DATA[ 9 ]
				dodge = DATA[ 10 ]
				
				spawndmg = DATA[ 11 ]
				ubercharge = DATA[ 12 ]
				fastheal = DATA[ 13 ]
				demoman = DATA[ 14 ]
				practiceshot = DATA[ 15 ]
				bioelectric = DATA[ 16 ]
				redcross = DATA[ 17 ]
				
				expamp = int( DATA[ 31 ] )
				expamptime = DATA[ 32 ]
				
				nextdaily = DATA[ 34 ]
				dailyget = DATA[ 35 ]
				
				bHandicaps = DATA[ 36 ]
				
				hud_red1 = DATA[ 19 ]
				hud_green1 = DATA[ 20 ]
				hud_blue1 = DATA[ 21 ]
				hud_alpha = DATA[ 25 ]
				
				hud_pos_x = DATA[ 26 ]
				hud_pos_y = DATA[ 27 ]
				
				hud_effect = DATA[ 28 ]
				
				firstplay = DATA[ 33 ]
				
				hammers = DATA[ 37 ]
				
				bData = int( DATA[ 18 ] )
				
				expamp += 1
				if hud_alpha == "250": hud_alpha = "255"
				oldBits = bData
				bData = 0
				if ( oldBits & 1 ) != 0: bData |= ( 1 << 0 )
				if ( oldBits & 2 ) != 0: bData |= ( 1 << 2 )
				if ( oldBits & 4 ) != 0: bData |= ( 1 << 3 )
				if ( oldBits & 8 ) != 0: bData |= ( 1 << 1 )
				if ( oldBits & 32 ) != 0: bData |= ( 1 << 4 )
				if ( oldBits & 64 ) != 0: bData |= ( 1 << 7 )
				if ( oldBits & 128 ) != 0: bData |= ( 1 << 8 )
				if ( oldBits & 256 ) != 0: bData |= ( 1 << 5 )
				if ( oldBits & 512 ) != 0: bData |= ( 1 << 10 )
				if ( oldBits & 1024 ) != 0: bData |= ( 1 << 9 )
				
				NEW = STEAMID + "\t"
				
				NEW += str( xp ) + "#" + str( medals ) + "#"
				NEW += str( health ) + "#" + str( armor ) + "#" + str( rhealth ) + "#" + str( rarmor ) + "#" + str( rammo ) + "#" + str( gravity ) + "#" + str( speed ) + "#" + str( dist ) + "#" + str( dodge ) + "#"
				NEW += str( spawndmg ) + "#" + str( ubercharge ) + "#" + str( fastheal ) + "#" + str( demoman ) + "#" + str( practiceshot ) + "#" + str( bioelectric ) + "#" + str( redcross ) + "#"
				NEW += str( expamp ) + "#" + str( expamptime ) + "#"
				NEW += str( nextdaily ) + "#" + str( dailyget ) + "#"
				NEW += str( bHandicaps ) + "#"
				NEW += str( hud_red1 ) + "#" + str( hud_green1 ) + "#" + str( hud_blue1 ) + "#" + str( hud_alpha ) + "#"
				NEW += str( hud_pos_x ) + "#" + str( hud_pos_y ) + "#"
				NEW += str( hud_effect ) + "#"
				NEW += str( firstplay ) + "#"
				NEW += str( hammers ) + "#"
				NEW += str( bData )
				
				buffer += "\n" + NEW
				count += 1
				if verbose:
					print( f"Processed player {STEAMID} main data." )
				
			OLD.close()
			print( f"Converted {count} entries in main vault." )
			
			TO = f"{input[:-4]}.new"
			if output != None:
				TO = f"{output}/main-vault.new"
			
			if verbose:
				print( f"Writing '{TO}'." )
			try:
				O = open( TO, 'w' )
				O.write( buffer )
				print( f"Exported new vault to {TO}." )
				O.close()
			except Exception as E:
				print( f"Failed to write '{TO}'. Aborting.\n\n{E}" )
				exit()
	except Exception as E:
		print( f"Failed to open '{input}'. Aborting.\n\n{E}" )
		exit()

def convertAchievement( input, output, verbose ):
	if verbose:
		print( f"Reading '{input}'." )
	
	buffer = ""
	count = 0
	try:
		with open( input ) as OLD:
			for LINE in OLD:
				LINE = LINE.replace( "\n", "" )
				if len( LINE ) == 0:
					continue
				
				RAW = LINE.split( "\t" )
				
				STEAMID = RAW[ 0 ]
				DATA = RAW[ 1 ]
				
				char = 0
				achievementID = 0
				newDATA = ""
				
				while char < len( DATA ):
					if DATA[ char ] == "1":
						if IsLegacyAchievement( achievementID ):
							# UNLOCKED
							newDATA += "1"
							char = char + 1
						else:
							if HasNewReward( achievementID ):
								# UNCLAIMED
								newDATA += "2"
								char += 1
							else:
								if DATA[ char + 1 ] == "1":
									# UNLOCKED
									newDATA += "1"
									char += 1
								else:
									# UNCLAIMED
									newDATA += "2"
									char += 1
					else:
						# LOCKED
						newDATA += "0"
						char += 1
					
					achievementID += 1
					char += 1
				
				while len( newDATA ) < 72:
					newDATA += "0"
				
				NEW = STEAMID + "\t" + newDATA
				
				buffer += "\n" + NEW
				count += 1
				if verbose:
					print( f"Processed player {STEAMID} achievement data." )
			
			OLD.close()
			print( f"Converted {count} entries in achievement vault." )
			
			TO = f"{input[:-4]}.new"
			if output != None:
				TO = f"{output}/achievement-vault.new"
			
			if verbose:
				print( f"Writing '{TO}'." )
			try:
				O = open( TO, 'w' )
				O.write( buffer )
				print( f"Exported new vault to {TO}." )
				O.close()
			except Exception as E:
				print( f"Failed to write '{TO}'. Aborting.\n\n{E}" )
				exit()
	except Exception as E:
		print( f"Failed to open '{input}'. Aborting.\n\n{E}" )
		exit()

def convertPermaincrease( input, output, verbose ):
	if verbose:
		print( f"Reading '{input}' folder." )
	
	count = 0
	vaultdata = ""
	for filename in os.listdir( input ):
		datafile = os.path.join( input, filename )
		
		if os.path.isfile( datafile ):
			try:
				with open( datafile ) as OLD:
					STEAMID = filename[10:-4]
					STEAMID = "STEAM_0" + STEAMID.replace( "_", ":" )
					
					mod = []
					newDATA = ""
					
					for LINE in OLD:
						LINE = LINE.replace( "\n", "" )
						if len( LINE ) == 0:
							continue
						
						DATA = LINE[ 0 : LINE.rfind( "!n!n" ) ].split( "#" )
						
						percent = int( float( DATA[ 0 ] ) )
						name = DATA[ 1 ]
						description = DATA[ 2 ].replace( "!n", "\\n" )
						
						if name in mod:
							if verbose:
								print( f"Removing duplicate XP Mod: {name}" )
							continue
						mod.append( name )
						
						if len( newDATA ) != 0:
							newDATA += "\x17"
						newDATA += str( percent ) + "#" + name + "#" + description
					
					OLD.close()
					vaultdata += "\n" + STEAMID + "\t" + newDATA
					
					if verbose:
						print( f"Processed player {STEAMID} permaincrease data." )
					count += 1
			except Exception as E:
				print( f"Failed to open file '{datafile}'. Aborting.\n\n{E}" )
				exit()
	
	print( f"Converted {count} entries in permaincrease folder." )
	
	TO = f"{input}/permaincrease-vault.ini"
	if output != None:
		TO = f"{output}/permaincrease-vault.ini"

	if verbose:
		print( f"Writing '{TO}'." )
	try:
		O = open( TO, 'w' )
		O.write( vaultdata )
		print( f"Exported new vault to {TO}." )
		O.close()
	except Exception as E:
		print( f"Failed to write '{TO}'. Aborting.\n\n{E}" )
		exit()

if __name__ == "__main__":
	args = len( sys.argv )
	if args == 1:
		printHelp()
		exit()
	
	doConvert()
	exit()
