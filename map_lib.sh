#!/bin/bash

declare -A maps
declare depth

loc_lev=0
loc_x=1
loc_y=1
size_x=0
size_y=0
timer=1
top=0
btm=0
final=0
generated=0

tput reset
echo "Enter the number representing which level this is."
read loc_lev
#echo "Enter the name of the level up to 30 characters."
#read -n30 maps[$loc_lev,0,0,0]
echo "What is the horizontal (x) size of you dungeon?"
read size_x
size_x=$((size_x))
echo "What is the verticle (y) size of you dungeon?"
read size_y
size_y=$((size_y))
tput reset
echo "${maps[loc_lev,0,0,0]}"

map_rand()
{
	final=$(((RANDOM % top)+btm))
}

map_dungeon()
{
	#Dungeon Builder - this function will work out the usable space of the building area and fill it
	#with relevant structures and content.
	if [ "${maps[$loc_sel,$loc_x,$loc_y,0]}" != "e" ]; then
		#is_odd_even x
		#random between 4 and 8
		#x_var = (size_x - 2) / final
		#loop place wall upper right corner block
		#is_odd_even y
		#random between 2 and 4
		#y_var = ((size_y / 2) - 2) / final
	fi

}

map_forest()
{
	#Turns out that the original random wall placement works pretty well for a forest map

	temp_x=$((size_x-1))
	temp_y=$((size_y-1))
	loc_x=1
	wall=0
	if [ "${maps[$loc_sel,$loc_x,$loc_y,0]}" != "e" ];then
		while [ $loc_x -le $temp_x ];
		do
			while [ $loc_y -le $temp_y ];
			do
				top=100
				btm=3
				map_rand
				case $final in
					1|2|3|4|5|6|7|8|9|10|11|12|13|15|15|16|17|18|19|20 )

						maps[$loc_lev,$loc_x,$loc_y,0]='T'
						wall=$((wall+1))
						;;
					21|22|23|24 ) #fallen trees
						if [ "$maps[$loc_lev,$loc_x,$loc_y,0]" != "T" ]; then
							maps[$loc_lev,$loc_x,$loc_y,0]="t"
						fi
						;;
						* )
						maps[$loc_lev,$loc_x,$loc_y,0]='.'
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
		#This seems to be an issue with BASH so to avoid drawing the map on 1 more line than is available
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
	echo "$max_x, $max_y | $(tput cols), $(tput lines)"
	read -n1
	while [ $loc_x -le $max_x ];
	do	
		while [ $loc_y -le $max_y ];
		do
			tput cup $loc_y $loc_x && echo "${maps[$loc_lev,$loc_x,$loc_y,0]}" 
			loc_y=$((loc_y+1))
		done
	loc_y=1
	loc_x=$((loc_x+1))
	done
}

map_builder()
{
	generated=$((generated+1))
	
	# Make the initial outline of the level based on the set size from size_x and size_y variables
	loc_x=1
	loc_y=1
	while [ $loc_x -le $size_x ];
	do
			maps[$loc_lev,$loc_x,$loc_y,0]='e'
			loc_x=$((loc_x+1))
			#echo "$loc_x"
			#read -n1
	done
	loc_x=1
	while [ $loc_y -le $size_y ];
	do
			maps[$loc_lev,$loc_x,$loc_y,0]='e'
			loc_y=$((loc_y+1))
	done
	loc_y=1
	while [ $loc_x -le $size_x ];
	do
			maps[$loc_lev,$loc_x,$size_y,0]='e'
			loc_x=$((loc_x+1))
	done
	while [ $loc_y -le $size_y ];
	do
			maps[$loc_lev,$size_x,$loc_y,0]='e'
			loc_y=$((loc_y+1))
	done

	# Randomly select map type from a list and build
	top=2
	btm=1
	map_rand
	case $final in
	1 )
	#This map is currently almost identicle to the forest map except walls' can't be placed by the edge of
		#The map. This is just a placeholder while I figure out how to do it the way I want. What I want
		#to see is a very linear and boxy map with many small rectangles and groups of small rectangles
		#producing hallways as an emergent property of their orientation
		map_dungeon
		;;
	2 )
		#This map uses randomly placed 'walls' or trees that go right up to the edge of the map container
		maps[$loc_lev,0,0,0]="forest"
		map_forest
		;;
	* )
		map_dungeon
		;;
esac
}

map_builder
map_screen_draw
#tput cup $(tput lines) 1 && echo "${#maps[*]} ${maps[$loc_lev,$loc_x,$loc_y,0]} ${#maps[$loc_lev,2,2,0]} ${maps[$loc_lev,2,2,0]} | $top $btm $final w = $wall"
read -n1
tput reset
