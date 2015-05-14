
all:
	gnatmake ./src/huffman_sans_optimisation
	gnatmake ./src/huffman_decodage_code
	gnatmake ./src/huffman_final
	./script_tests

clean:
	gnatclean huffman_sans_optimisation
	gnatclean huffman_decodage_code
	gnatclean huffman_final
	rm ./resultats/resultats.txt
	rm ./resultats/sans_optimisation/*
	rm ./resultats/decodage_code/*
	rm ./resultats/final/*
	rm ./fichiers_compresses/sans_optimisation/*.huff
	rm ./fichiers_compresses/decodage_code/*.huff
	rm ./fichiers_compresses/final/*.huff
