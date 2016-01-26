; Master TrayIcon to control all running instances of AutoHotkey

#Persistent
#SingleInstance Force
Menu, Tray, Icon, ico\1fill.ico, ,1
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
Menu, Tray, Add, Quick Reload, Reload
Menu, Tray, Add, Start All Scripts, StartAll
Menu, Tray, Add, Rocket League, RL
Menu, Tray, Add, FFVIII, FFVIII
Menu, Tray, Add
Menu, Tray, Default, Quick Reload
Menu, Tray, Click, 1
Menu, Tray, Standard

Return

MenuChoice:
	StringSplit, F,A_ThisMenuItem, :
	IfEqual,F2,Reload , PostMessage,0x111,65400,0,,% "ahk_id" AList%F1%
	IfEqual,F2,Edit   , PostMessage,0x111,65401,0,,% "ahk_id" AList%F1%
	IfEqual,F2,Pause  , PostMessage,0x111,65403,0,,% "ahk_id" AList%F1%
	IfEqual,F2,Suspend, PostMessage,0x111,65404,0,,% "ahk_id" AList%F1%
	IfEqual,F2,Exit   , PostMessage,0x111,65405,0,,% "ahk_id" AList%F1%
	Return

Reload:
	Reload
	Return
  
StartAll:
	Run, SwitchAudio.ahk
	Run, DateTimeStrings.ahk
	Run, SuperSnip.ahk
	Return
	
RL:
	Run, rlAHK.ahk
	Return
	
FFVIII:
	Run, ffviiiAHK.ahk
	Return	