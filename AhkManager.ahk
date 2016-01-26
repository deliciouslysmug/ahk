; Version of Master TrayIcon to control all running instances of AutoHotkey
;;;;;		AhkManager									
;;;;;		by Austin Kathol									
;;;;;		Tue 01-26-2016 9:15 AM
;;;;;		v1.0

;;;;;	INITIALIZE	;;;;;
#Persistent
#SingleInstance Force
Sb_SetIcon()
DetectHiddenWindows, On
SelfID := WinExist( A_ScriptFullPath " ahk_class AutoHotkey")
Menu, Tray, NoStandard
WinGet, AList, List, ahk_class AutoHotkey
Loop %AList% {
               ID := AList%A_Index%
               IfEqual, ID, %SelfID%, Continue
  
               WinGetTitle, ATitle, ahk_id %ID%
               StringSplit, ATitle, ATitle, -
               SplitPath, ATitle1, Name
               StringUpper, Name, Name

               Menu,%Name%,Add, %A_Index%:Reload , MenuChoice
               Menu,%Name%,Add, %A_Index%:Edit   , MenuChoice
               Menu,%Name%,Add, %A_Index%:Pause  , MenuChoice
               Menu,%Name%,Add, %A_Index%:Suspend, MenuChoice
               Menu,%Name%,Add, %A_Index%:Exit   , MenuChoice
               Menu, Tray, Add, %Name%, :%Name%
             }
Menu, Tray, Add
Menu, Tray, Add, Quick Reload, ReloadScript
Menu, Tray, Add, Start All Scripts, StartAll
Menu, Tray, Add, Quit All Scripts, QuitAll
Menu, Tray, Add, Rocket League, RL
Menu, Tray, Add, FFVIII, FFVIII
Menu, Tray, Add
Menu, Tray, Default, Quick Reload
Menu, Tray, Click, 1
Menu, Tray, Standard

Return

;;;;;	GLOBAL HOTKEYS	;;;;;
CapsLock & f1::
	Suspend, Toggle
	Sb_TogDisableAll()
	return

;;;;;	FUNCTIONS	;;;;;
Sb_TogDisableAll() {
	Global AllOff := !AllOff
	if (AllOff) {
		;TrayTip, Tray, HOTKEYS INACTIVE
		Menu, Tray, Icon, ico\0fill.ico,,1
	} 
	else {
		;TrayTip, Tray, HOTKEYS ACTVE
		Sb_SetIcon()
	}
}

MenuChoice:
	StringSplit, F,A_ThisMenuItem, :
	IfEqual,F2,Reload , PostMessage,0x111,65400,0,,% "ahk_id" AList%F1%
	IfEqual,F2,Edit   , PostMessage,0x111,65401,0,,% "ahk_id" AList%F1%
	IfEqual,F2,Pause  , PostMessage,0x111,65403,0,,% "ahk_id" AList%F1%
	IfEqual,F2,Suspend, PostMessage,0x111,65404,0,,% "ahk_id" AList%F1%
	IfEqual,F2,Exit   , PostMessage,0x111,65405,0,,% "ahk_id" AList%F1%
	Return

ReloadScript:
	Reload
	Return
	
Sb_SetIcon() {
	DetectHiddenWindows, On 
	WinGet, List, List, ahk_class AutoHotkey 
	NumAhk := 0
	Loop %List% 
	{ 
		WinGet, PID, PID, % "ahk_id " List%A_Index% 
		If ( PID <> DllCall("GetCurrentProcessId") ) 
			NumAhk++
	}
	setIcon = %NumAhk%nofill.ico
	if (AllOff) {
		setIcon = 0fill.ico
	}
	if NumAhk not between 0 and 9
	{
		setIcon = plusnofill.ico
	}
	Menu, Tray, Icon, ico\%setIcon%,,1
}
  
StartAll:
	Run, SwitchAudio.ahk
	Run, MainAhkScript.ahk
	Run, SuperSnip.ahk
	Reload
	Return

QuitAll:
	DetectHiddenWindows, On 
	WinGet, List, List, ahk_class AutoHotkey 
	Loop %List% 
	{ 
		WinGet, PID, PID, % "ahk_id " List%A_Index% 
		If ( PID <> DllCall("GetCurrentProcessId") ) 
			PostMessage,0x111,65405,0,, % "ahk_id " List%A_Index% 
	}
	Reload
	Return
	
RL:
	Run, rlAHK.ahk
	Reload
	Return
	
FFVIII:
	Run, ffviiiAHK.ahk
	Reload
	Return	