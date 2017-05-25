# Index-Card-Parser
Included in this repository is a set of scripts for reading library index cards that have been converted into a .txt format, and putting that information into a MODS format.

# Requirements
Java

Saxon XSLT processor. This must be a .jar file called "saxon9he.jar" and placed in a "Saxon" directory

Input Files. These must be placed in a directory called "in" and must have a name in the format "###-####.txt"

Directories called "mid1", "mid2", "mid3" and "out"

Ruby (ruby-dev), with the required gems for the [anystyle-parser](https://github.com/inukshuk/anystyle-parser).

The gem and its dependencies can be installed with

	$ gem install anystyle-parser
