var $result : Integer

$result:=LISTBOX Get property:C917(*; "LB20"; lk display footer:K53:20)
vResult:=Choose:C955($result; Localized string:C991("CommonFalse"); Localized string:C991("CommonTrue"))