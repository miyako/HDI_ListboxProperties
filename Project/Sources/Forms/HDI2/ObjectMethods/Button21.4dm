
vRowsHeight:=LISTBOX Get property:C917(*; "LB8"; lk row height unit:K53:42)
Case of 
	: (vRowsHeight=lk pixels:K53:22)
		vResult:=Localized string:C991("Pixels")
		
	: (vRowsHeight=lk lines:K53:23)
		vResult:=Localized string:C991("Lines")
		
	Else 
		vResult:="???"
End case 


