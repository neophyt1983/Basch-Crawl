#!/bin/bash

#Declerations
. map_lib.sh
. chr_lib.sh

#Vars
plyr_x=0
plyr_y=0

tput civis
map_screen_draw
while [ $c_x <= $set_x ] || [ $fini -ne 1 ]
do
	if [ "${maps[$loc_lev,$loc_x,$loc_y,0]:0:1}" == '.' ]; then
		plyr_x=$c_x
		plyr_y=$c_y
		tput cup $c_y $c_x && echo "@"
	fi
done
while [ "$cmd" != "q" ]
do
	read -n1 -t 0.5 cmd
	case "$cmd" in
		w )	#Go Up
			#Check for obsticles
			#Get new x and y coords
				#rdr_x=$plyr_x
				#rdr_y=$plyr_y
				#plyr_x=$((plyr_x+1))
			#tput cup $plyr_y $plyr_x & echo "@" & map_rdr
			;;
		a )	#Go Left

			;;
		s )	#Go Down

			;;
		d )	#Go Left

			;;
		i )	#Inventory

			;;
		c )	#Consume 1,2,3,4,... Quick Bar

			;;
		'<' )	#Target previous

			;;
		'>' )	#Target next

			;;
		1 )	#Action 1

			;;
		2 )	#Action 2

			;;
		3 )	#Action 3

			;;
		5 )	#Action 4

			;;
		5 )	#Action 5

			;;
		6 )	#Action 6

			;;
		7 )	#Action 7

			;;
		8 )	#Action 8

			;;
		9 )	#Action 9

			;;
		0 )	#Action 0

			;;
		h )	#Help

			;;
		~ )	#Save
			;;
		*)

			;;
	esac
done

read -n1
tput reset
exit 0
