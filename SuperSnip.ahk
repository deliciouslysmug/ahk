SetBatchLines -1									;Go as fast as CPU will allow
#SingleInstance Force								;Only one of these scripts can be run at a time
#Persistent											;this keeps the script running if no hotkeys are set (though one is)
#NoTrayIcon

LCtrl & Capslock::Sb_Snip()					;CTRL + CAPSLOCK OPENS SNIPPING TOOL/SAVES CURRENT SNIP

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
	Run %windir%\System32\SnippingTool.exe
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