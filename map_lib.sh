#!/bin/bash

declare -A maps
declare depth

loc_lev=0
loc_x=1
loc_y=1
size_x=0
size_y=0
timer=1

tput reset
echo "Enter the number representing which level this is."
read loc_lev
#echo "Enter the name of the level up to 30 characters."
#read -n30 maps[$loc_lev,0,0,0]
echo "What is the horizontal (x) size of you dungeon?"
read size_x
size_x=$((size_x+1))
echo "What is the verticle (y) size of you dungeon?"
read size_y
size_y=$((size_y+1))
tput reset
echo "${maps[loc_lev,0,0,0]}"

map_builder()
{
			# Make the initial outline of the level based on the set size from size_x and size_y variables
			while [ $loc_x -le $size_x ];
			do
					maps[$loc_lev,$loc_x,$loc_y,0]='w'
					loc_x=$((loc_x+1))
					#echo "$loc_x"
					#read -n1
			done
			loc_x=1
			while [ $loc_y -le $size_y ];
			do
					maps[$loc_lev,$loc_x,$loc_y,0]='w'
					loc_y=$((loc_y+1))
			done
			loc_y=1
			while [ $loc_x -le $size_x ];
			do
					maps[$loc_lev,$loc_x,$size_y,0]='w'
					loc_x=$((loc_x+1))
			done

			while [ $loc_y -le $size_y ];
			do
					maps[$loc_lev,$size_x,$loc_y,0]='w'
					loc_y=$((loc_y+1))
			done

			# Fill the map with game structures
			
}
map_builder
tput reset
#read -n1

loc_x=1
loc_y=1
while [ $loc_x -le $size_x ];
do
	while [ $loc_y -le $size_y ];
	do
			tput cup $loc_y $loc_x && echo "${maps[$loc_lev,$loc_x,$loc_y,0]}" 
# echo "${maps[$loc_lev,$loc_x,$loc_y,0]}"
			#echo "$loc_x, $loc_y"
			loc_y=$((loc_y+1))
			#read -n1
	done
loc_y=1
loc_x=$((loc_x+1))
done

loc_y=1
loc_x=1
tput cup $(tput lines) 1 && echo "${#maps[*]} ${maps[$loc_lev,$loc_x,$loc_y,0]} ${#maps[$loc_lev,2,2,0]} ${maps[$loc_lev,2,2,0]}"
read -n1
tput reset
