#!/bin/bash

. mutual_lib.sh
. map_lib.sh
#. chr_lib.sh

#game_pid=$(echo $!)
plyr_x=0	# Players current x location
plyr_y=0	# Players current y location
c_x=0		# Players previous x location
c_y=0		# Players previous y location
quitter=0
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
			tput cup $y $x && echo "@"
			finish=1
			break 2
		fi
		y=$((y+1))
	done
	y=0
	x=$((x+1))
done
while [ $quitter -ne 1 ]
do
	tput cup $plyr_y $plyr_x && echo "@"
	read -n1 -t 0.2 -s cmd
	case "$cmd" in
		w )	#Go Up
			if [ "$plyr_y" -gt 2 ]; then
				c_y="$plyr_y"
				c_x="$plyr_x"
				plyr_y=$((plyr_y-1))
				tput cup "$plyr_y" "$plyr_x" && echo "@"
				map_fill_path
			fi
			;;
		a )	#Go Left
			if [ "$plyr_x" -gt 2 ]; then
				c_y="$plyr_y"
				c_x="$plyr_x"
				plyr_x=$((plyr_x-1))
				tput cup "$plyr_y" "$plyr_x" && echo "@"
				map_fill_path
			fi
			;;
		s )	#Go Down
			if [ "$plyr_y" -lt $((size_y-1)) ]; then
				c_y="$plyr_y"
				c_x="$plyr_x"
				plyr_y=$((plyr_y+1))
				tput cup "$plyr_y" "$plyr_x" && echo "@"
				map_fill_path
			fi
			;;
		d )	#Go Left
			if [ "$plyr_x" -lt $((size_x-1)) ]; then
				c_y="$plyr_y"
				c_x="$plyr_x"
				plyr_x=$((plyr_x+1))
				tput cup "$plyr_y" "$plyr_x" && echo "@"
				map_fill_path
			fi
			;;
		q ) 	#Quit
			tput cup 1 1 && echo "Are you sure? y/n"
			read -n1 -s sure
			if [ "$sure" == 'y' ]; then
				quitter=1
			else
				x=1
				while [ "$x" -le 18 ];
				do
					true
					tput cup 1 $x && echo "e"
					x=$((x+1))
				done
				tput cup "$plyr_y" "$plyr_x"
				tput bold
				quitter=0
			fi
			;;
		i )	#Inventory

			;;
		c )	#Consume 1,2,3,4,... Quick Bar

			;;
		'<' )	#Up Stairs

			;;
		'>' )	#Down Stairs

			;;
		o )	#Open Door
			;;
		c )	#Close Door
			;;
		e )	#Enter
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

#read -n1
tput reset
exit 0
