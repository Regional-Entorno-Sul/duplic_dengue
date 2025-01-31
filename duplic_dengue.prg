Function main()

set century on
set date british

*Procura por duplicidade/triplicidade de registros de Dengue.

copy file "c:\duplic_dengue\reserva\dengon_7000.dbf" to "c:\duplic_dengue\dengon_7000.dbf"
rename "c:\duplic_dengue\dengon_7000.dbf" to "c:\duplic_dengue\dengon_7000_2array.dbf"
copy file "c:\duplic_dengue\reserva\dengon_7000.dbf" to "c:\duplic_dengue\dengon_7000.dbf"
rename "c:\duplic_dengue\dengon_7000.dbf" to "c:\duplic_dengue\dengon_base.dbf"

use "c:\duplic_dengue\dengon_base.dbf"
do while .not. eof()
replace tp_not with ""
skip
enddo

close

	  public aArray1 := {}
	  use "c:\duplic_dengue\dengon_7000_2array.dbf"
      nRecs := reccount()
      FOR x := 1 TO nRecs
	  AAdd( aArray1, {alltrim( fonetica )} )
	  skip
	  NEXT
	  close


? aArray1[1,1]
quit

use "c:\duplic\run\tubenet2.dbf"

*? aArray1[f,1]
*cSoundex := aArray1[f,1]
cSoundex := "W53625322532000"
? cSoundex

locate for soundex = cSoundex
if found()
? "ok!", recno()
replace tp_not with "1"
else
? "Not found."
endif
close

use "c:\duplic\run\tubenet2.dbf"

locate for soundex = cSoundex .and. tp_not <> "1"
if found()
? "ok!", recno()
replace id_agravo with "2"
else
? "Not found."
endif

close

use "c:\duplic\run\tubenet2.dbf"

locate for soundex = cSoundex .and. tp_not <> "1" .and. id_agravo <> "2"
if found()
? "ok!", recno()
replace nu_ano with "3"
else
? "Not found."
endif

close


? "------------------------------"

use "c:\duplic\run\tubenet2.dbf"

copy to "c:\duplic\run\duplic.dbf" for tp_not = "1"
copy to "c:\duplic\run\duplic.dbf" for id_agravo = "2"
copy to "c:\duplic\run\duplic.dbf" for nu_ano = "3"

close

? "******************************"

wait

return nil