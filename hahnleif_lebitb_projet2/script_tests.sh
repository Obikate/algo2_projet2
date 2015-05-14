#!/bin/bash
for fichier in $(find ./tests/*.txt)
do
#on compresse et décompresse tous les tests
echo $fichier >> ./resultats/resultats.txt
echo "Sans optimisations:" >> ./resultats/resultats.txt
/usr/bin/time -f "%e" -o ./resultats/resultats.txt -a ./huffman_sans_optimisation -c $fichier ./fichiers_compresses/sans_optimisation/$(basename $fichier).huff >> ./resultats/resultats.txt
./huffman_sans_optimisation -d ./fichiers_compresses/sans_optimisation/$(basename $fichier).huff ./resultats/sans_optimisation/$(basename $fichier) >> ./resultats/resultats.txt
echo "taux de compression réel:" >> ./resultats/resultats.txt
echo $(bc -l <<< $(stat -c%s ./fichiers_compresses/sans_optimisation/$(basename $fichier).huff)/$(stat -c%s $fichier)) >> ./resultats/resultats.txt
printf "\n" >>./resultats/resultats.txt

echo "Decodage code:" >> ./resultats/resultats.txt
/usr/bin/time -f "%e" -o ./resultats/resultats.txt -a ./huffman_decodage_code -c $fichier ./fichiers_compresses/decodage_code/$(basename $fichier).huff >> ./resultats/resultats.txt
./huffman_decodage_code -d ./fichiers_compresses/decodage_code/$(basename $fichier).huff ./resultats/decodage_code/$(basename $fichier) >> ./resultats/resultats.txt
echo "taux de compression réel:" >> ./resultats/resultats.txt
echo $(bc -l <<< $(stat -c%s ./fichiers_compresses/decodage_code/$(basename $fichier).huff)/$(stat -c%s $fichier)) >> ./resultats/resultats.txt
printf "\n" >>./resultats/resultats.txt

echo "Code final:" >> ./resultats/resultats.txt
/usr/bin/time -f "%e" -o ./resultats/resultats.txt -a ./huffman_final -c $fichier ./fichiers_compresses/final/$(basename $fichier).huff >> ./resultats/resultats.txt
./huffman_final -d ./fichiers_compresses/final/$(basename $fichier).huff ./resultats/final/$(basename $fichier) >> ./resultats/resultats.txt
echo "taux de compression réel:" >> ./resultats/resultats.txt
echo $(bc -l <<< $(stat -c%s ./fichiers_compresses/final/$(basename $fichier).huff)/$(stat -c%s $fichier)) >> ./resultats/resultats.txt
printf "\n" >>./resultats/resultats.txt
done
