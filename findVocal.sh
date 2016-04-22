#! /bin/bash

#storing path of directory used for searching vocals in files
#bilježi se putanja direktorija iz kojeg će se povlačiti podatci o zapisima
FILES1="/home/matko/Desktop/lab/*lab"

#setting vocal input option
#skripta od korisnika traži unos vokala
read -p "Enter vowel you want to search for: " vowel
echo "searching for..."

rm -f results.txt

echo "files containing vowel $vowel results" >> log.txt

declare counter=0

#searching for presence of inputted vocal in each .lab file found
#traži se uneseni vokal u.lab datotekama
for i in $FILES1
do	
#results are stored in results.txt file
#rezultati se pohranjuju u datoteku results.txt 
	if grep -e $vowel -w $i -H  >> results.txt
		then ((counter+=1)) 
	fi	

done

echo "finished!"
#storing statistics
#pohranjuju se statistički podatci
echo "$(date): number of files containing $vowel: $counter" >> log.txt



