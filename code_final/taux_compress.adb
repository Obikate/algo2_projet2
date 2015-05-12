with Ada.text_io, Ada.float_text_io;
use Ada.text_io,Ada.float_text_io ;

procedure taux_compress is
O, C, Res : Float;
begin
put_line("Taille fichier original");
get(O);
put_line("Taille fichier compressé");
get(C);
Res := C/O;
Put(Res);
end;
