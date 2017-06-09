#!/usr/bin/env ruby

require 'anystyle/parser'

loop = ARGV[0].to_i
prefix = ""
suffix = ""
if ARGV.length > 0 and ARGV[1] != nil
  prefix = ARGV[1]
end
if ARGV.length > 1 and ARGV[2] != nil
  suffix = ARGV[2]
end
count = 1
zeros = "000"

Anystyle.parser.train 'TrainingData.txt', true

while count <= loop
	if count == 10; zeros = "00"; end
	if count == 100; zeros = "0"; end
	if count == 1000; zeros = ""; end
	fileName = prefix+zeros+"#{count}"+suffix
	begin
		inFile = File.open("mid1/"+fileName+".txt", "r")
		contents = inFile.read
		inFile.close

		begin
			output = Anystyle.parse contents, format="xml"

			#output result before further changes for debugging purposes
			outFile = File.open("mid2/"+fileName+".xml", "w")
			outFile.puts output
			outFile.close

      #FIX for incorectly formatted pages
      output = output.gsub(/([Pp][Pp]?\.)(<\/pages>)(<[a-zA-Z]*>)([0-9-]*[ .,:;])/, '\4\2\3')
      output = output.gsub(/(<\/date>)(<[a-zA-Z]*>)([0-9]*, ?[0-9]*[ .,:;])/, '\3\1\2')
      
      #FIX for microfilm
      output = output.gsub("microfilm", "Microfilm")
      output = output.gsub(/<footer>[Mm]i.{0,12}<\/footer>/, "<footer>Microfilm</footer>")
      output = output.gsub(/<footer>.{0,12}lm<\/footer>/, "<footer>Microfilm</footer>")

			#Remove extra words in fields
			output = output.gsub(/<pages>p{0,2}\./,"<pages>")
			output = output.gsub(/<author>[Bb]y /,"<author>")
			output = output.gsub(/<author>[Rr]eview by /,"<author>")
			output = output.gsub(/<journal>[Ii]n /,"<journal>")
			output = output.gsub(/<journal>[Rr]eview in /,"<journal>")
			output = output.gsub(/<booktitle>[Ii]n /,"<booktitle>")
			output = output.gsub(/<volume>[Vv]ol\./,"<volume>")
			output = output.gsub(/<volume>[Nn]o\./,"<volume>")
			#Split different references ( look for a field that ends with a semicolon that is not part of a character, such as &lt; for < )
			output = output.gsub(/(?<!&amp)(?<!&lt)(?<!&gt)(?<!&apos)(?<!&quot)(;)(<\/[a-zA-Z]*>)/, '\2</reference><reference>')
			#reformat date, might need more adjustment
			output = output.gsub(/(<date>)([a-zA-Z]{2,4}.)( ?)([0-9]{4})/, '\1\4 \2')
			output = output.gsub(/(<date>)([a-zA-Z]{2,4}.)( ?)([0-9]{1,2})(,? ?)([0-9]{4})/, '\1\6 \2 \4')
			#Remove empty fields
			output = output.gsub(/<[a-zA-Z]*> *<\/[a-zA-Z]*>/, '')
			output = output.gsub(/<[a-zA-Z]*>-<\/[a-zA-Z]*>/, '')

      #a little more cleaning
			output = output.gsub(/[.,:]<\//,"</")

			outFile = File.open("mid3/"+fileName+".xml", "w")
			outFile.puts output
			outFile.close
		rescue
			puts "ERROR: File "+prefix+zeros+"#{count}"+suffix+".xml could not be created"
		end

	rescue
		puts "ERROR: File "+prefix+zeros+"#{count}"+suffix+".txt not found"
	end


	
	count += 1
end
