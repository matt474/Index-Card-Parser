#!/bin/bash
for i in $(seq -f "%03g" 40 75)
do

	java Clean $i 5
	ruby RubyParse.rb $i 5

	for j in $(seq -f "%04g" 1 5)
	do
		echo $i"-"$j
		cp  "in/"$i"-"$j".txt" "sample"
		cp "out/"$i"-"$j"-Mid.xml" "sample"
		java -jar Saxon/saxon9he.jar "-s:sample/"$i"-"$j"-Mid.xml" "-xsl:transform.xsl" "-o:sample/"$i"-"$j".xml"
		#cp  "in/"$i"-"$j".tif" "sample"
	done
done

