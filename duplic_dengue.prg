Function main()

set century on
set date british
set color to g+/
cls

*Procura por duplicidade/triplicidade de registros de Dengue.

copy file "c:\duplic_dengue\reserva\dengon.dbf" to "c:\duplic_dengue\run\dengon.dbf"
rename "c:\duplic_dengue\run\dengon.dbf" to "c:\duplic_dengue\run\dengon_2array.dbf"
copy file "c:\duplic_dengue\reserva\dengon.dbf" to "c:\duplic_dengue\run\dengon.dbf"
rename "c:\duplic_dengue\run\dengon.dbf" to "c:\duplic_dengue\run\dengon_base.dbf"
copy file "c:\duplic_dengue\reserva\dengon_zero.dbf" to "c:\duplic_dengue\run\dengon_zero.dbf"

use "c:\duplic_dengue\run\dengon_base.dbf"
do while .not. eof()
replace tp_not with ""
skip
enddo
close

use "c:\duplic_dengue\run\dengon_base.dbf"
delete for sg_uf <> "52"
pack
close

use "c:\duplic_dengue\run\dengon_2array.dbf"
delete for sg_uf <> "52"
pack
close

use "c:\duplic_dengue\run\dengon_base.dbf"
do while .not. eof()
cToken := alltrim(alltrim(fonetica_n)+alltrim(dtoc(dt_nasc))+alltrim((token(nm_mae_pac,,1))))
replace soundex with alltrim( cToken )
skip
enddo
close

use "c:\duplic_dengue\run\dengon_2array.dbf"
do while .not. eof()
cToken := alltrim(alltrim(fonetica_n)+alltrim(dtoc(dt_nasc))+alltrim((token(nm_mae_pac,,1))))
replace soundex with alltrim( cToken )
skip
enddo
close

use "c:\duplic_dengue\run\dengon_base.dbf"
index on soundex to "c:\duplic_dengue\run\index_base" ascending
close

use "c:\duplic_dengue\run\dengon_2array.dbf"
index on soundex to "c:\duplic_dengue\run\index_array" ascending
close

	  public aArray1 := {}
	  public aArray_level1 := {}	  
	  public aArray_level2 := {}	  	  
	  use "c:\duplic_dengue\run\dengon_2array.dbf" index "c:\duplic_dengue\run\index_array.ntx"
      nRecs := reccount()
      FOR x := 1 TO nRecs
	  AAdd( aArray1, {alltrim( soundex )})
	  skip
	  NEXT
	  close

@ 1,0 say aArray1[1,1]
@ 2,0 say aArray1[2,1]
@ 3,0 say aArray1[3,1]
@ 4,0 say aArray1[4,1]
@ 5,0 say aArray1[5,1]

@ 6,0 say "--------------------------------"

for n = 1 to nRecs

use "c:\duplic_dengue\run\dengon_base.dbf" index "c:\duplic_dengue\run\index_base.ntx"
nRecBase := reccount()

nPercent := (n * 100) / nRecs

cFonetica := alltrim( aArray1[n,1] )
@ 10,0 say alltrim(str(n)) + " " + str(nPercent) + "%"

locate for soundex = cFonetica
if found()
replace tp_not with "1"
AAdd( aArray_level1, {( recno() )})
else
endif

locate for soundex = cFonetica .and. tp_not <> "1"
if found()
replace id_agravo with "2"
AAdd( aArray_level2, {( recno() )})
@ 11,0 say ( aArray_level1[1,1] )
@ 12,0 say ( aArray_level2[1,1] )

use "c:\duplic_dengue\run\dengon_zero.dbf"
append record aArray_level1[1,1] from "c:\duplic_dengue\run\dengon_base.dbf"
append record aArray_level2[1,1] from "c:\duplic_dengue\run\dengon_base.dbf"

else
endif

aArray_level1 := {}	  
aArray_level2 := {}	  

next

close

use "c:\duplic_dengue\run\dengon_zero.dbf"
do while .not. eof()
replace nu_idade_n with 0
skip
enddo
close

	  public aArray1 := {}
	  use "c:\duplic_dengue\run\dengon_zero.dbf"
      nRecs := reccount()
      FOR x := 1 TO nRecs
	  AAdd( aArray1, {alltrim( soundex )})
	  skip
	  NEXT
	  close

@ 1,0 say aArray1[1,1]
@ 2,0 say aArray1[2,1]
@ 3,0 say aArray1[3,1]
@ 4,0 say aArray1[4,1]
@ 5,0 say aArray1[5,1]

for n := 1 to nRecs

use "c:\duplic_dengue\run\dengon_zero.dbf"
nQuant := 0
do while .not. eof()

@ 6,0 say nu_notific + " " + str(nQuant)
if soundex = alltrim(aArray1[n,1])
nQuant = nQuant + 1
replace nu_idade_n with nQuant
endif

skip
enddo

delete for nu_idade_n >= 3
pack
close

next

return nil