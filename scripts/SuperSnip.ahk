;;;;;		SuperSnip									
;;;;;		by Austin Kathol									
;;;;;		Tue 01-26-2016 9:15 AM
;;;;;		v1.0

;;;;;	INITIALIZE	;;;;;
#NoEnv
#SingleInstance Force								;Only one of these scripts can be run at a time
#Persistent											;this keeps the script running if no hotkeys are set (though one is)
#NoTrayIcon
;SetBatchLines -1

;;;;;	HOTKEYS	;;;;;
LCtrl & Capslock::Sb_Snip()					;CTRL + CAPSLOCK OPENS SNIPPING TOOL/SAVES CURRENT SNIP

;;;;;	FUNCTIONS	;;;;;
Sb_Snip() {
	If WinExist("Snipping Tool")
	{
		IfWinActive, Snipping Tool 
		{
			Fn_SaveSnip()
		} else Fn_ActivateStartSnip()
	} else Fn_OpenSnippingTool()
	return

}

Fn_SaveSnip() {
	Send ^s
	Sleep, 450
	FormatTime, CurrentDate,, yyyyMMddhhmmss
	SendInput %A_Desktop%
	SendInput \
	SendInput %CurrentDate%
	Sleep, 200
	Send !s
	Sleep, 200
	WinClose, Snipping Tool
}

Fn_OpenSnippingTool() {
	Run %A_WinDir%\System32\SnippingTool.exe
	WinWait, Snipping Tool
	WinActivate, Snipping Tool
	Send !n
	Send r
}

Fn_ActivateStartSnip() {
	WinActivate, Snipping Tool
	WinWaitActive, Snipping Tool
	Send !n
	Send r
}