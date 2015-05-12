with Ada.Text_IO, Comparaisons, File_Priorite, ada.integer_text_io, Ada.Streams.Stream_IO;
use Ada.Text_IO, Comparaisons, ada.integer_text_io, Ada.Streams.Stream_IO;

package body Arbre_Huffman is

        package Ma_File is new File_Priorite(Natural, Compare, Arbre);
        use Ma_File;

        type TabFils is array(ChiffreBinaire) of Arbre ;

        type Noeud(EstFeuille: Boolean) is record
                case EstFeuille is
                        when True => Char : Character;
                        when False =>
                                Fils: TabFils;
                                -- on a: Fils(0) /= null and Fils(1) /= null
                end case ;
        end record;

        procedure Affiche_Arbre(A: Arbre) is
        begin
        if a.estfeuille then
                if a /= null then
                        put(a.char);
            end if;
        else
                        put("0");
                        affiche_arbre(a.fils(0));
                        put("1");
                        affiche_arbre(a.fils(1));
        end if;
        end Affiche_Arbre;

        --algo principal : calcul l'arbre a partir des frequences
        function Calcul_Arbre(Frequences : in Tableau_Ascii) return Arbre is
                A : Arbre;
                f: file := nouvelle_file(frequences'length);
                arbre_courant: arbre;
                --variables pour la procédure "meileur"
                arbre_min_1, arbre_min_2: arbre;
                prio_1, prio_2: natural;
                statut_1, statut_2: boolean;

        begin
                --on construit la file de priorité
                for i in frequences'range loop
                        if frequences(i) /= 0 then
                                arbre_courant := new noeud(true);
                                arbre_courant.char := i;
                                insertion(f, frequences(i), arbre_courant);
                        end if;
                end loop;

                --on construit l'arbre dans la file de priorité
                --initialisation des variables
                meilleur(f, prio_1, arbre_min_1, statut_1);
                suppression(f);
                meilleur(f, prio_2, arbre_min_2, statut_2);
                suppression(f);
                while statut_2 loop
                        --on remplace les deux feuilles de priorité minimale par leur "fusion" dans un tab_fils
                        arbre_courant := new noeud(false);
                        arbre_courant.fils(0) := arbre_min_1;
                        arbre_courant.fils(1) := arbre_min_2;
                        insertion(f, prio_1 + prio_2, arbre_courant);
                        a := arbre_courant;
                        --on réinitialise les variables statut_i
                        meilleur(f, prio_1, arbre_min_1, statut_1);
                        suppression(f);
                        meilleur(f, prio_2, arbre_min_2, statut_2);
                        suppression(f);
                end loop;

                --on peut alors récupérer l'arbre final, les variables prio_1 et statut_1 ne servent à rien
                meilleur(f, prio_1, a, statut_1);
                return a;
        end Calcul_Arbre;

        procedure construction_dico_intermediaire(a: arbre; niveau: natural; code_intermediaire: in out code;d: out dico) is
                code_gauche, code_droite: code;
                nouveau_niveau: natural := niveau + 1;
        begin
        if a.estfeuille then
                --d'abord le cas de base, où on tombe sur une feuille
                d(a.char) := code_intermediaire;
        else
                        --dans ce cas, on est tombé sur un branchement
                        --il faut construire des nouveaux codes pour les niveaux inférieurs
                        code_gauche := new tabbits(1..nouveau_niveau);
                        code_droite := new tabbits(1..nouveau_niveau);
                        if code_intermediaire /= null then
                                code_gauche(code_gauche'first .. (code_gauche'last - 1)) := code_intermediaire(code_intermediaire'range);
                                code_droite(code_droite'first .. (code_droite'last - 1)) := code_intermediaire(code_intermediaire'range);
                        end if;
                        code_gauche(code_gauche'last) := 0;
                        code_droite(code_droite'last) := 1;
                        liberer(code_intermediaire);

                        --on continue alors de chercher dans l'arbre
                        construction_dico_intermediaire(a.fils(0), nouveau_niveau, code_gauche, d);
                        construction_dico_intermediaire(a.fils(1), nouveau_niveau, code_droite, d);
        end if;
        end;

        procedure afficher_dico(d: dico) is
        begin
                new_line;
                put_line("affichage du dictionnaire:");
                for i in d'range loop
                        if d(i) /= null then
                                put(i);
                                for j in d(i)'range loop
                                        put(d(i)(j));
                                end loop;
                                new_line;
                        end if;
                end loop;
        end;

        function Calcul_Dictionnaire(A : Arbre) return Dico is
                D : Dico := (others => null);
                code_initial: code := null;
                niveau: natural := 0;
        begin
                construction_dico_intermediaire(a, niveau, code_initial, d);
                return d;
        end;

        procedure Decodage_Code(Reste : in out Code;
                Arbre_Huffman : Arbre;
                Caractere : out Character) is

                Position_Courante : Arbre;
                Tmp,R : Natural;
                Nouveau_Reste : Code;
        begin
                Position_Courante := Arbre_Huffman;
                while not Position_Courante.EstFeuille loop
                        if Reste = null then
                                --chargement de l'octet suivant du fichier
                                Reste := new TabBits(1..8);
                                Caractere := Octet_Suivant;
                                Tmp := Character'Pos(Caractere);
                                for I in Reste'Range loop
                                        R := Tmp mod 2;
                                        Reste(Reste'Last + Reste'First - I) := R;
                                        Tmp := Tmp / 2;
                                end loop;
                        end if;
                        Position_Courante := Position_Courante.Fils(Reste(1)) ;
                        if Reste'Last = 1 then
                                Liberer(Reste);
                                Reste := null;
                        else
                                -- TODO : modifier cette procedure
                                -- pour eviter de faire a chaque iteration
                                -- une allocation + 1 liberation
                                Nouveau_Reste := new TabBits(1..(Reste'Last - 1));
                                for I in Nouveau_Reste'Range loop
                                        Nouveau_Reste(I) := Reste(I+1);
                                end loop;
                                Liberer(Reste);
                                Reste := Nouveau_Reste;
                        end if;
                end loop;
                Caractere := Position_Courante.Char;
        end;

end;
