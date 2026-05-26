#
#	Imperium Sven Co-op's SCXPM: Data Converter
#	Copyright (C) 2019-2021  Julian Rodriguez
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

# This tool converts old v3.14 save files to v3.20 format
import os

directory1 = 'data'
directory2 = 'achievement'

# iterate through the directories.
# main data
newbuffer = ''
files = 0
for filename in os.listdir( directory1 ):
#{
	datafile = os.path.join( directory1, filename )
	
	# ensure it's a file
	if os.path.isfile( datafile ):
	#{
		# a vault exists?
		if filename == 'main-vault.ini':
		#{
			# safe to assume that if this file exists, the same can be said of the achievement one
			print( "*** WARNING: A vault already exists. ***" )
			print( "*** Running this tool will overwrite all of its contents. ***" )
			print( "*** This action cannot be undone. ***" )
			print( "" )
			input( "Press Ctrl-C to abort or any other key to continue..." )
			print( "" )
		#}
		
		# ignore the vault itself if it exists
		if 'main-vault.ini' not in filename:
		#{
			olddata = open( datafile )
			files += 1
			
			# read file contents
			merge = olddata.readline()
			
			# remove the newline at the end
			merge = merge.replace( '\n', '' )
			
			# grab the steamid from the filename. (remove the SCXPM_ and .dat from the string)
			steamid = filename
			steamid = steamid.replace( 'SCXPM_', '' )
			steamid = steamid.replace( '.dat', '' )
			
			# restore '_' to ':' (minus the starting STEAM_ text)
			
			# don't change LAN ID
			if 'STEAM_ID_LAN' not in steamid:
			#{
				# gah, what is this bullshit? -Giegue
				fix = list( steamid )
				fix[ 7 ] = ':'
				fix[ 9 ] = ':'
				steamid = ''.join( fix )
			#}
			
			# steamid + tab + data
			line = steamid + '\t' + merge
			
			# add to buffer
			newbuffer = newbuffer + line + '\n'
			
			# file no longer needed
			olddata.close()
		#}
	#}
#}

if files > 0:
#{
	print( 'Processed {} file(s) on data folder.'.format( files ) )
	
	# create main data vault
	print( 'Creating main vault.' )
	vault1 = open( directory1 + '/main-vault.ini', 'w' )
	vault1.write( newbuffer )
	vault1.close()
	print( 'Main vault done.' )
#}
else:
	print( 'No files found on data folder.' )

# achievement data
newbuffer = ''
files = 0
for filename in os.listdir( directory2 ):
#{
	datafile = os.path.join( directory2, filename )
	
	# ensure it's a file
	if os.path.isfile( datafile ):
	#{
		# ignore the vault itself if it exists
		if 'achievement-vault.ini' not in filename:
		#{
			olddata = open( datafile )
			files += 1
			
			# oh boy...
			merge = ''
			
			# read file contents
			for oldbuffer in olddata:
			#{
				if len( oldbuffer ) > 0:
				#{
					pre_data = oldbuffer.split( '#' )
					
					# remove the new lines!
					progress = pre_data[ 2 ].replace( '\n', '' )
					
					if pre_data[ 1 ] == "FALSE":
					#{
						# locked achievement
						merge = merge + '0_' + progress + '#'
					#}
					else:
					#{
						# unlocked achievement
						merge = merge + '1_' + progress + '#'
					#}
				#}
			#}
			
			# grab the steamid from the filename. (remove the A_ and .ini from the string)
			steamid = filename
			steamid = steamid.replace( 'A_', '' )
			steamid = steamid.replace( '.ini', '' )
			
			# restore '_' to ':' (minus the starting STEAM_ text)
			
			# don't change LAN ID
			if 'STEAM_ID_LAN' not in steamid:
			#{
				# gah, what is this bullshit? -Giegue
				fix = list( steamid )
				fix[ 7 ] = ':'
				fix[ 9 ] = ':'
				steamid = ''.join( fix )
			#}
			
			# steamid + tab + data
			line = steamid + '\t' + merge
			
			# add to buffer
			newbuffer = newbuffer + line + '\n'
			
			# file no longer needed
			olddata.close()
		#}
	#}
#}

if files > 0:
#{
	print( 'Processed {} file(s) on achievement folder.'.format( files ) )
	
	# create achievement data vault
	print( 'Creating achievement vault.' )
	vault2 = open( directory2 + '/achievement-vault.ini', 'w' )
	vault2.write( newbuffer )
	vault2.close()
	print( 'Achievement vault done.' )
#}
else:
	print( 'No files found on achievement folder.' )

print( '' )
print( 'Conversion complete.' )
print( '' )
confirm = input( "Delete old save files? (Y/N): " )

# yeah, poor code. blame me. first thing i do on python lmao -Giegue
confirm = confirm.lower()
if confirm[ 0 ] == 'y':
#{
	print( 'Deleting...' )
	
	for filename in os.listdir( directory1 ):
	#{
		datafile = os.path.join( directory1, filename )
		
		# ensure it's a file
		if os.path.isfile( datafile ):
		#{
			# don't delete the newly created vault
			if 'main-vault.ini' not in filename:
			#{
				os.remove( datafile )
			#}
		#}
	#}
	
	for filename in os.listdir( directory2 ):
	#{
		datafile = os.path.join( directory2, filename )
		
		# ensure it's a file
		if os.path.isfile( datafile ):
		#{
			# don't delete the newly created vault
			if 'achievement-vault.ini' not in filename:
			#{
				os.remove( datafile )
			#}
		#}
	#}
#}

print( '' )
print( 'All done.' )
