var $result : Integer

$result:=LISTBOX Get property:C917(*; "LB21"; lk display header:K53:4)
vResult:=Choose:C955($result; Localized string:C991("CommonFalse"); Localized string:C991("CommonTrue"))