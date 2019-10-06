#!/bin/bash

. mutual_lib.sh
. map_lib.sh
#. chr_lib.sh

#game_pid=$(echo $!)
plyr_x=0	# Players current x location
plyr_y=0	# Players current y location
c_x=0		# Players previous x location
c_y=0		# Players previous y location
finish=0	# Temporary
x=2		# Temporary
y=4		# Temporary

tput civis
map_builder
map_screen_draw
while [ $x -le $size_x ] || [ $finish -ne 1 ]
do
	while [ $y -le $size_y ] || [ $finish -lt 1 ]
	do
		if [ "${maps[$loc_lev,$x,$y,0]:0:1}" == "." ]; then
			plyr_x=$x
			plyr_y=$y
			c_x=$x
			c_y=$y
			tput cup $y $x && echo "@" "$(tput bold)"
			finish=1
			break 2
		fi
		y=$((y+1))
	done
	y=0
	x=$((x+1))
done
while [ "$cmd" != "q" ]
do
	tput cup $plyr_y $plyr_x && echo "@" "$(tput bold)"
	read -n1 -t 0.2 -s cmd
	case "$cmd" in
		w )	#Go Up
			tput cup $((plyr_y-1)) $plyr_x && echo "@"
			;;
		a )	#Go Left
			tput cup $plyr_y $((plyr_x-1)) && echo "@"
			;;
		s )	#Go Down
			tput cup $((plyr_y+1)) $plyr_x && echo "@"
			;;
		d )	#Go Left
			tput cup $plyr_y $((plyr_x-1)) && echo "@"
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
