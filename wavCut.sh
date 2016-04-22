#! /bin/bash
 
#changing path to file results.txt
#mijenjanje putanja do datoteke results.txt 
sed -i s/:/' '/ results.txt 
sed -i 's/\/lab/\/wav/' results.txt
sed -i s/.lab/.wav/ results.txt
sed -i -r 's/\S+//4' results.txt

#first three columns are stored in array collection fo further processing
#prva 3 stupca pohranjuju se u polje collection za daljnju obradu
collection=( $(cut -d ' ' -f-3 results.txt) )

line=( $(wc -w results.txt) )

#declaring variables
#deklariraju se varijable
typeset -i i END
let END=$line cut_counter=1 count_fname=0 count_startt=1 count_endt=2 

rm -f ispis.txt
rm -f -r wav_cut 

mkdir wav_cut

#for each audio file cut vocals duration (.wav) and saving in modificated file (.wav) in wav_cut directory 
#u petlji se za svaku datoteku izrezuju trajanja vokala i spremaju u wav_cut direktorij
while ((count_startt<=END))
do
#duration unit value (ns) transcribing to seconds (s) (Sox tool input value condition)
#povučene vrijednosti se pretvaraju u sekunde (zapis u ns) za potrebe Sox alata
	read startt <<< $(echo "${collection[count_startt]}"*10^-09 | bc -l)
    read endt <<< $(echo "${collection[count_endt]}"*10^-09 | bc -l)

#creating string that will be used as a name of next modified cut file
#string koji će biti ime iduće izrezane datoteke
    fpath=${collection[count_fname]}
	wav=".wav"
	
	sox $fpath wav_cut/$cut_counter$wav trim $startt $endt

#setting values of increment for filed searching; pointers on stored filed values
#namještanje vrijednosti inkrementa za pretraživanje polja; pokazivači na vrijednosti u polju
	((count_startt+=3))
	((count_endt+=3))
    ((count_fname+=3))
	((cut_counter+=1))

done
