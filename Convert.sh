#!/bin/bash
for i in $(seq -f "%03g" 40 40)
	do
	for j in $(seq -f "%04g" 1 9999)
	do
		
		FILE="in/"$i"-"$j".txt"

		if [ ! -f $FILE ]; then
			echo "MODS-ifying set "$i"..."
			for k in $(seq -f "%04g" 1 `expr $j - 1`)
			do
				if [ `expr $k % 10` -eq 0 ]; then
					echo " "$i"-"$k".xml is done"
				fi
				java -jar Saxon/saxon9he.jar "-s:out/"$i"-"$k"-Mid.xml" "-xsl:transform.xsl" "-o:out/"$i"-"$k".xml"
			done
			break
		fi
	done
done

