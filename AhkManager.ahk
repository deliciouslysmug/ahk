; Version of Master TrayIcon to control all running instances of AutoHotkey
;;;;;		AhkManager									
;;;;;		by Austin Kathol									
;;;;;		Tue 01-26-2016 9:15 AM
;;;;;		v1.0

;;;;;	INITIALIZE	;;;;;
#Persistent
#SingleInstance Force
DetectHiddenWindows, On 
SetTitleMatchMode, 2
Sb_SetMenu()

Return

;;;;;	GLOBAL HOTKEYS	;;;;;
CapsLock & f1::
	Suspend, Toggle
	Sb_TogDisableAll()
	return

;;;;;	FUNCTIONS	;;;;;
Sb_SetMenu() {
	Menu, Tray, DeleteAll
	SelfID := WinExist( A_ScriptFullPath " ahk_class AutoHotkey")
	Menu, Tray, NoStandard
	WinGet, AList, List, ahk_class AutoHotkey
	Loop %AList% {
		ID := AList%A_Index%
		IfEqual, ID, %SelfID%, Continue
		WinGetTitle, ATitle, ahk_id %ID%
		StringSplit, ATitle, ATitle, -
		SplitPath, ATitle1, Name
		StringSplit, Name, Name, `.
		Name = %Name1%
		;StringUpper, Name, Name
		Menu,%Name%,Add, %Name%:Reload , MenuChoice
		Menu,%Name%,Add, %Name%:Edit   , MenuChoice
		Menu,%Name%,Add, %Name%:Pause  , MenuChoice
		Menu,%Name%,Add, %Name%:Suspend, MenuChoice
		Menu,%Name%,Add, %Name%:Exit   , MenuChoice
		
;		Menu,%Name%,Add, %A_Index%:Reload , MenuChoice
;		Menu,%Name%,Add, %A_Index%:Edit   , MenuChoice
;		Menu,%Name%,Add, %A_Index%:Pause  , MenuChoice
;		Menu,%Name%,Add, %A_Index%:Suspend, MenuChoice
;		Menu,%Name%,Add, %A_Index%:Exit   , MenuChoice
		Menu, Tray, Add, %Name%, :%Name%
	}
	Menu, Tray, Add
	Menu, Tray, Add, Quick Reload, Sb_ReloadScript
	Menu, Tray, Add, Start All Scripts, Sb_StartAll
	Menu, Tray, Add, Quit All Scripts, Sb_QuitAll
	Menu, Tray, Add, Rocket League, RL
	Menu, Tray, Add, FFVIII, FFVIII
	Menu, Tray, Add
	Menu, Tray, Default, Quick Reload
	Menu, Tray, Click, 1
	Menu, Tray, Standard
	Sb_SetIcon()
}

Sb_TogDisableAll() {
	Global AllOff := !AllOff
	SelfID := WinExist( A_ScriptFullPath " ahk_class AutoHotkey")
	if (AllOff) {
		;TrayTip, Tray, HOTKEYS INACTIVE
		DetectHiddenWindows, On 
		WinGet, AList, List, ahk_class AutoHotkey
		Loop %AList% 
		{ 
			ID := AList%A_Index%
			IfEqual, ID, %SelfID%, Continue
			WinGetTitle, ATitle, ahk_id %ID%
			PostMessage,0x111,65305,,,%ATitle%
		}
		Menu, Tray, Icon, ico\0fill.ico,,1
	} 
	else {
		;TrayTip, Tray, HOTKEYS ACTVE
		WinGet, AList, List, ahk_class AutoHotkey
		Loop %AList% 
		{ 
			ID := AList%A_Index%
			IfEqual, ID, %SelfID%, Continue
			WinGetTitle, ATitle, ahk_id %ID%
			PostMessage,0x111,65305,,,%ATitle%
		}
		Sb_SetIcon()
	}
}
	
Sb_SetIcon() {
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
  
MenuChoice:
	StringSplit, F,A_ThisMenuItem, :
	IfEqual,F2,Reload , PostMessage,0x111,65400,0,,%F1% ahk_class AutoHotkey
	IfEqual,F2,Edit   , PostMessage,0x111,65401,0,,%F1% ahk_class AutoHotkey
	IfEqual,F2,Pause  , PostMessage,0x111,65403,0,,%F1% ahk_class AutoHotkey
	IfEqual,F2,Suspend, PostMessage,0x111,65404,0,,%F1% ahk_class AutoHotkey
	IfEqual,F2,Exit   , PostMessage,0x111,65405,0,,%F1% ahk_class AutoHotkey
	Sb_ReloadScript()
	Return

Sb_ReloadScript() {
	Reload
}
  
Sb_StartAll() {
	Loop %A_WorkingDir%\scripts\*.ahk
	{
		if (A_LoopFileFullPath != A_ScriptFullPath)
			Run, %A_LoopFileFullPath%
	}
	Sleep, 200
	Sb_SetMenu()
	Sb_SetIcon()
}

Sb_QuitAll() {
	DetectHiddenWindows, On 
	WinGet, List, List, ahk_class AutoHotkey 
	Loop %List% 
	{ 
		WinGet, PID, PID, % "ahk_id " List%A_Index% 
		If ( PID <> DllCall("GetCurrentProcessId") ) 
			PostMessage,0x111,65405,0,, % "ahk_id " List%A_Index% 
	}
	Sleep, 200
	Sb_SetMenu()
	Sb_SetIcon()
}
	
RL:
	ifExist games\rlAHK.ahk
		Run, games\rlAHK.ahk
	Reload
	Return
	
FFVIII:
	ifExist games\ffviiiAHK.ahk
		Run, games\ffviiiAHK.ahk
	Reload
	Return
	
	