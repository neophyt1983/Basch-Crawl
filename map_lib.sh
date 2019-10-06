#!/bin/bash


#trap "set +x; sleep 5; set -x" DEBUG
#Libraries
. mutual_lib.sh

declare -A maps
#declare -A maps_oper
declare -A map_error
declare -A NPC
map_err_count=0

#NPC[0,0,0,0]=3		# This variable will hold a list of NPC's in the current stage

loc_lev=1
loc_x=1
loc_y=1
tput_x=$(tput cols)
tput_y=$(tput lines)
if [ $tput_x -gt 20 ] && [ $tput_y -gt 20 ]; then
	size_x=$((tput_x-2))
	size_y=$((tput_y-4))
else
	exit 1
fi
timer=1
top=0
btm=0
final=0
generated=0

map_rdr()
{
	tput cup $rdr_y $rdr_x && echo "${maps[$loc_lev,$rdr_x,$rdr_y,0]}"
}

map_cell_blok()
{
	#Cells are 4 by 4 walls with a door and blocks are 4 cells
	cb_x=$((cbt_x-8))
	cb_y=$((cbt_y-8))

	while [ $cb_x -le $cbt_x ];
	do
		maps[$loc_sel,$cb_x,$cbt_y,0]="$bar"
		cb_x=$((cb_x+1))
		maps[$loc_sel,$cbt_x,$cb_y,0]="$bar"
		cb_y=$((cb_y+1))
	done
}

map_column()
{
	#for making support columns
	true
}

map_dungeon()
{
	bar="W"
	#Dungeon Builder - this function will work out the usable space of the building area and fill it
	#with relevant structures and content.
	if [ "${maps[$loc_sel,$loc_x,$loc_y,0]}" != "e" ]; then
		odev=$set_x
		odd_even
		if [ $set_x -ne $odev ] && [ $set_x -gt $set_y ]; then
			true
		elif [ $set_x -ne $odev ] && [ $set_x -lt $set_y ]; then
			true			
		else
			true
		fi
		true
	fi

}

map_forest()
{
	bar="T"
	#Turns out that the original random wall placement works pretty well for a forest map

	temp_x=$((size_x-1))
	temp_y=$((size_y-1))
	loc_x=1
	wall=0
	if [ "${maps[$loc_sel,$loc_x,$loc_y,10]}" != "e" ];then
		while [ $loc_x -le $temp_x ];
		do
			while [ $loc_y -le $temp_y ];
			do
				top=100
				btm=3
				rando
				case $final in
					1|2|3|4|5|6|7|8|9|10|11|12|13|15|15|16|17 )

						maps[$loc_lev,$loc_x,$loc_y,1]="${bar}000"
						wall=$((wall+1))
						;;
					21|22|23 ) #fallen trees
						if [ "$maps{[$loc_lev,$loc_x,$loc_y,0]:0:4}" != "${bar:0:1}" ]; then
							maps[$loc_lev,$loc_x,$loc_y,1]="t"
						fi
						;;
					30 )
						maps[$loc_lev,$loc_x,$loc_y,2]="${maps[$Loc_lev,$Loc_x,$loc_y,0]}n100"
						;;
						* )
						maps[$loc_lev,$loc_x,$loc_y,0]='.000'
						;;
				esac
				loc_y=$((loc_y+1))
			done
			loc_y=2
			loc_x=$((loc_x+1))
		done
	fi
}

map_screen_draw()
{
	tput reset
	loc_x=1
	loc_y=1
	if [ $size_x -ge $(tput cols) ]; then
		max_x=$(tput cols)
		max_x=$((max_x-2))
	else
		max_x=$size_x
	fi
	
	if [ $size_y -ge $(tput lines) ]; then
		max_y=$(tput lines)
		max_y=$((max_y-2))
		#This seems to be an issue with BASH 4.4 so to avoid drawing the map on 1 more line than is available
		#I have to make sure that y never equals 43
		if [ $max_y -eq 43 ]; then
			max_y=42
		fi
	else
		if [ $size_y -eq 43 ]; then
			max_y=42
		else
			max_y=$size_y
		fi
	fi
	while [ $loc_x -le $max_x ];
	do	
		while [ $loc_y -le $max_y ];
		do
			dep="${#maps[$loc_lev,$loc_x,$loc_y,0]}"
			n=0
			while [ $n -le $dep ]
			do
				#tput cup $loc_y $loc_x && echo "${maps[$loc_lev,$loc_x,$loc_y,0]:${n}:1}"
				#tput cup $loc_y $loc_x && echo "${maps[$loc_lev,$loc_x,$loc_y,1]:${n}:1}"
				#tput cup $loc_y $loc_x && echo "${maps[$loc_lev,$loc_x,$loc_y,2]:${n}:1}"
				#tput cup $loc_y $loc_x && echo "${maps[$loc_lev,$loc_x,$loc_y,3]:${n}:1}"
				tput cup $loc_y $loc_x && echo "${maps[$loc_lev,$loc_x,$loc_y,10]:${n}:1}"
				n=$((n+4))
			done
			loc_y=$((loc_y+1))
		done
	loc_y=1
	loc_x=$((loc_x+1))
	done
}

map_builder()
{
	generated=$((generated+1))
	depth=$((depth+1))
	# Make the initial outline of the level based on the set size from size_x and size_y variables
	loc_x=1
	loc_y=1
	while [ $loc_x -le $size_x ];
	do
			maps[$loc_lev,$loc_x,$loc_y,10]='e'
			loc_x=$((loc_x+1))
	done
	loc_x=1
	while [ $loc_y -le $size_y ];
	do
			maps[$loc_lev,$loc_x,$loc_y,10]='e'
			loc_y=$((loc_y+1))
	done
	loc_y=1
	while [ $loc_x -le $size_x ];
	do
			maps[$loc_lev,$loc_x,$size_y,10]='e'
			loc_x=$((loc_x+1))
	done
	while [ $loc_y -le $size_y ];
	do
			maps[$loc_lev,$size_x,$loc_y,10]='e'
			loc_y=$((loc_y+1))
	done

	# Randomly select map type from a list and build
	top=2
	btm=1
	rando
	case $final in
	1 )
		#map_dungeon
		map_forest
		maps[$loc_lev,0,0,100]="dungeon"
		;;
	2 )
		#This map uses randomly placed 'walls' or trees that go right up to the edge of the map container
		maps[$loc_lev,0,0,100]="forest"
		map_forest
		;;
	* )
		#map_dungeon
		map_forest
		maps[$loc_lev,0,0,100]="forest"
		;;
esac
}
