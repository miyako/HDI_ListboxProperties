Case of 
	: (Form event code:C388=On Selection Change:K2:29)
		
		$n:=Size of array:C274(_Pages)
		ARRAY LONGINT:C221(_fontStyle; 0)
		ARRAY LONGINT:C221(_fontStyle; $n)
		
		ARRAY LONGINT:C221(_FontBackground; 0)
		ARRAY LONGINT:C221(_FontBackground; $n)
		ARRAY LONGINT:C221(_FontColor; 0)
		ARRAY LONGINT:C221(_FontColor; $n)
		For ($i; 1; $n)
			_FontColor{$i}:=vLBPageTextColor
			_FontBackground{$i}:=vLBPageFillColor
		End for 
		
		_fontStyle{_Pages}:=Bold:K14:2
		_FontColor{_Pages}:=vLBPageSelectedTextColor
		_FontBackground{_Pages}:=vLBPageSelectedFillColor
		
End case 
