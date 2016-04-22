#! /bin/bash

#setting path to directory containing cut wav files
#postavlja se putanja puta do direktorija izrezanih wav datoteka
FILES="/home/matko/Desktop/lab/wav_cut/*wav"

pitch=".pitch"
txt=".txt"

rm -f -r pitch
rm -f -r pitch/txt
mkdir pitch
mkdir pitch/txt
declare j=0

#aproximating f0 values for each file found and saving them for each sample separately
#za svaku pronadjenu datoteku aproksimira se niz vrijednosti f0, koje se spremaju za svaki uzorak zasebno
for i in $FILES

do
#fname path is modified in the way that we are removing absolute component 
#fname putanja se modificira na način da se uklanja absolutni put s ciljem da ostane samo ime datoteke
    fname=$(sed 's|/home/matko/Desktop/lab/wav_cut/||' <<< $fname)	
	fname=$(sed 's/.wav/.pitch/' <<< $fname)
	fname=$i
	txtname=$fname
	txtname=$(sed 's/.pitch/.txt/' <<< $txtname)
#pitch command is used for calculating pitch values
#pitch naredba koja izvršava izračun
	x2x +sf $i | pitch -a 0 -s 16 -p 80 -L 50 -H 400 -o 1 > pitch/$fname
#output values stored in .pitch files are being stored in .txt file due to easier manipulation of values
#izlazne vrijednosti pohranjene u .pitch datoteku spremaju se u tekstualnu, radi lakše obrade u idućem koraku
	dmp +f pitch/$fname > pitch/txt/$txtname 	
done
