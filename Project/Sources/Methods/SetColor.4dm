//%attributes = {"invisible":true}
#DECLARE($mode : Text)->$result : Integer

var $angle : Real
var $red; $green; $blue; $n : Integer

Case of 
		
	: ($mode="background")
		
		$angle:=((Selected record number:C246([TEST:1])/Records in selection:C76([TEST:1])))*2*Pi:K30:1
		
		$red:=0x00E0+Round:C94(0x001F*Cos:C18($angle); 0)
		$angle:=$angle+(2*Pi:K30:1/3)
		
		$green:=0x00E0+Round:C94(0x001F*Cos:C18($angle); 0)
		$angle:=$angle+(2*Pi:K30:1/3)
		
		$blue:=0x00E0+Round:C94(0x001F*Cos:C18($angle); 0)
		
		$result:=($red << 16)+($green << 8)+$blue
		
		
	: ($mode="fontcolor")
		
		$angle:=((Selected record number:C246([TEST:1])/Records in selection:C76([TEST:1])))*2*Pi:K30:1
		
		$red:=0x0040+Round:C94(0x0040*Cos:C18($angle); 0)
		$angle:=$angle+(2*Pi:K30:1/3)
		
		$green:=0x0040+Round:C94(0x0040*Cos:C18($angle); 0)
		$angle:=$angle+(2*Pi:K30:1/3)
		
		$blue:=0x0040+Round:C94(0x0040*Cos:C18($angle); 0)
		
		$result:=($red << 16)+($green << 8)+$blue
		
	: ($mode="fontstyle")
		
		$n:=Selected record number:C246([TEST:1])
		
		$result:=Choose:C955(($n-1)%4; Plain:K14:1; Italic:K14:3; Bold:K14:2; Underline:K14:4)
		
End case 



