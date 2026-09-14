var $selName : Text
$selName:=LISTBOX Get property:C917(*; "LB19"; lk named selection:K53:67)

If ($selName#"")
	vResult:=Localized string:C991("Selecion name: ")+$selName
Else 
	vResult:=Localized string:C991("Selecion name: none")
End if 
