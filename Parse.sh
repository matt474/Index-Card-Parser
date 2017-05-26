#!/bin/bash
prefix="indexcards_"
suffix="_OCR"
copyImage="false"

for i in $(seq -f "%03g" 1 100)
	do
	for j in $(seq -f "%04g" 1 9999)
	do
		
		FILE="in/"$prefix$i"-"$j$suffix".txt"

		if [ -f $FILE ]; then
			if [ $copyImage = "true" ]; then
				cp "in/"$i"-"$j".tif" "out"
			fi
		else
			if [ $j -gt 1 ]; then
				echo "Found "`expr $j - 1`" items in set "$i
				echo "Cleaning set "$i"..."
				java Clean `expr $j - 1` $prefix$i"-" $suffix
				echo "Parseing set "$i"..."
				ruby RubyParse.rb `expr $j - 1` $prefix$i"-" $suffix
			fi
			break
		fi
	done
done
echo "Converting to MODS format"
java -jar Saxon/saxon9he.jar "-s:mid3" "-xsl:Transform.xsl" "-o:out"


