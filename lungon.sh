#!/bin/bash

#Declerations
. map_lib.sh
. chr_lib.sh

#Functions
save()
{
	#Save Game, The whole thing up to 1000
}

#Vars
plyr_x=0
plyr_y=0

map_screen_draw
while [ "$cmd" != "q" ]
do
	read -n1 -t 0.5 cmd
	case "$cmd" in
		w )	#Go Up

			;;
		a )	#Turn Left

			;;
		s )	#Go Down

			;;
		d )	#Turn Right

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
	map_screen_draw
done

read -n1
tput reset
exit 0
