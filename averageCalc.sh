#! /bin/bash

#setting path to pitch command output values .txt 
#putanja na pohranjene izlazne vrijednosti naredbe pitch
FILES="/home/matko/Desktop/lab/pitch/txt/*.txt"

typeset -i END k
let j=1 avrg=0 sum=0 counter=0 value=0

#value in each of .txt file is being processed; sum values >0 and incrementing counter
#svaka .txt datoteka se čita, pritom se svaka vrijednost >0 zbraja u sumu, i povećava se brojač
for i in $FILES
do
	
	line=( $(wc -w $i) )
	let END=$line
	collection=( $(cut -d ' ' -f 2 $i) )
	((j+=1))
	let k=1

	while ((k<=END))
	do
		value=${collection[k]}
		read value <<< $(echo "$value"| bc -l)
			
		if [ $(echo "$value >= 0" | bc) -eq 1 ]; then	
		
		#incrementing sum for current value > 0
		#povećavanje sume za trenutnu vrijednost >0
			read sum <<< $(echo "$sum"+"$value" | bc -l)
			((counter+=1))

		fi
		
		#jumping to next value
		#skakanje na slijedeću vrijednost 
		((k+=2))
	done

done

#calculating averages
#izračun prosjeka
if [ "$counter" -ne "0" ]; then
	read avrg <<< $(echo "$sum"/"$counter" | bc -l)

fi

echo $avrg > f0_res.txt
