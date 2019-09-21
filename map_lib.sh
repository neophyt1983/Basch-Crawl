#!/bin/bash

declare -A maps
declare depth

loc_lev=0
loc_x=1
loc_y=1
size_x=0
size_y=0
timer=1

echo "Enter the number representing which level this is."
read loc_lev
echo "Enter the name of the level up to 30 characters."
read -n30 maps[$loc_lev,0,0,0]
echo "What is the horizontal (x) size of you dungeon?"
read size_x
echo "What is the verticle (y) size of you dungeon?"
read size_y
tput reset
echo "${maps[loc_lev,0,0,0]}"

map_builder()
{
			for loc_x in {1..10000}
			do
				if [ $loc_x -le $size_x ]; then
					maps[$loc_lev,$loc_x,$loc_y,0]='w'
					tput cup $((loc_y+5)) $loc_x && echo "${maps[$loc_lev,$loc_x,$loc_y,0]}"
				fi
			done
			loc_x=0
			for loc_y in {1..10000}
			do
				if [ $loc_y -le $size_y ]; then
					maps[$loc_lev,$loc_x,$loc_y,0]='w'
					tput cup $((loc_y+5)) $loc_x && echo "${maps[$loc_lev,$loc_x,$loc_y,0]}"
				fi
			done
			for loc_x in {10000..1}
			do
				if [ $loc_x -ge 1 ] && [ $loc_x -le $size_x ]; then
					loc_y=$size_y
					maps[$loc_lev,$loc_x,$loc_y,0]='w'
					tput cup $((loc_y+5)) $loc_x && echo "${maps[$loc_lev,$loc_x,$loc_y,0]}"
				fi
			done
			for loc_y in {10000..1}
			do
				if [ $loc_y -ge 1 ] && [ $loc_y -le $size_y ]; then
					loc_x=$size_x
					maps[$loc_lev,$loc_x,$loc_y,0]='w'
					tput cup $((loc_y+5)) $loc_x && echo "${maps[$loc_lev,$loc_x,$loc_y,0]}"
				fi
			done

			
}
map_builder &
wait
echo "${#maps[*]}"
read -n1
tput reset
