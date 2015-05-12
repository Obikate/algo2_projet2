
With Ada.Text_IO;
use Ada.Text_IO;

package body File_Priorite is

        function Nouvelle_File(Taille: Positive) return File is
                F: File;
                tas: file_interne(taille);
        begin
                tas.nb_elements := 0;
                F := new file_interne'(tas);
                return F;
        end Nouvelle_File;

        -- simple procédure auxiliaire pour échanger deux éléments de la file
        procedure echanger(f: in out file; i, j: integer) is
                tmp: element := f.tab(i);
        begin
                f.tab(i) := f.tab(j);
                f.tab(j) := tmp;
        end;

        procedure Insertion(F: in out File; P: Priorite; D: Donnee) is
                -- un compteur pour remonter
                i: natural := f.nb_elements + 1;
        begin
                -- on n'a pas intérêt à dépasser la taille de la file
                if f.nb_elements < f.tab'length then
                        -- on place l'élément à la fin du tas
                        f.nb_elements := f.nb_elements + 1;
                        f.tab(f.nb_elements) := (p, d);
                        -- on fait remonter l'élément jusqu'à ce qu'on a trouvé sa place
                        while (i > f.tab'first) and then (compare(f.tab(i/2).p, f.tab(i).p) = sup) loop
                                echanger(f, i/2, i);
                                i := i/2;
                        end loop;
                end if;
        end Insertion;

        procedure Meilleur(F: in File; P: out Priorite; D: out Donnee; Statut: out Boolean) is
        begin
                if f.nb_elements /= 0 then
                        p := f.tab(f.tab'first).p;
                        d := f.tab(f.tab'first).d;
                        statut := true;
                else
                        statut := false;
                end if;
        end;

        --procédure auxiliaire pour la procédure suppression
        -- on fait descendre l'élément qui se trouve à la place ind
        procedure descendre(f: in out file; ind: integer) is
                max, l, r: integer;
        begin
                -- on compare l'élément actuel avec ses deux fils
                l := 2*ind;
                r := 2*ind + 1;
                if (l <= f.nb_elements) and then (compare(f.tab(l).p, f.tab(ind).p) = inf) then
                        max := l;
                else
                        max := ind;
                end if;
                if (r <= f.nb_elements) and then (compare(f.tab(r).p, f.tab(max).p) = inf) then
                        max := r;
                end if;
                -- le cas d'arrêt est le cas où max = ind
                if max /= ind then
                        echanger(f, ind, max);
                        descendre(f, max);
                end if;
        end;

        procedure Suppression(F: in out File) is
        begin
                if f.nb_elements /= 0 then
                        f.tab(f.tab'first) := f.tab(f.nb_elements);
                        f.nb_elements := f.nb_elements - 1;
                        descendre(f, f.tab'first);
                end if;
        end Suppression;

        end File_Priorite;
