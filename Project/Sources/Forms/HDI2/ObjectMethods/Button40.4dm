
$selMode:=LISTBOX Get property:C917(*; "LB3_Col1"; lk truncate:K53:37)
Case of 
	: ($selMode=lk without ellipsis:K53:64)
		vResult:=Localized string:C991("Without ellipsis")
	: ($selMode=lk with ellipsis:K53:65)
		vResult:=Localized string:C991("With ellipsis")
	Else 
		vResult:="???"
End case 