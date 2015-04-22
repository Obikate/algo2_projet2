
With Ada.Text_IO;
use Ada.Text_IO;

package body File_Priorite is

	function Nouvelle_File(Taille: Positive) return File is
		F: File;
		tas: file_interne(1 .. taille);
	begin
		F := new file_interne'(tas);
		return F;
	end Nouvelle_File;

	procedure Insertion(F: in out File; P: Priorite; D: Donnee) is
	begin
		null; --TODO
	end Insertion;

	procedure Meilleur(F: in File; P: out Priorite; D: out Donnee; Statut: out Boolean) is
	begin
		null; --TODO
	end;

	procedure Suppression(F: in out File) is
	begin
		null; --TODO
	end;

end;
