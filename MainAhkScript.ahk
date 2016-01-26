;;;;;		Main AHK Script								
;;;;;		by Austin Kathol									
;;;;;		Tue 01-26-2016 9:15 AM
;;;;;		v1.0

;;;;;	INITIALIZE	;;;;;
#NoEnv
#SingleInstance Force								;Only one of these scripts can be run at a time
#Persistent											;this keeps the script running if no hotkeys are set (though one is)
#NoTrayIcon
SetBatchLines -1									;Go as fast as CPU will allow

;;;;;	REFERENCE	;;;;;
; ^ - ctrl
; # - win
; ! - alt
; + - shift

;;;;;	HOTKEYS	;;;;;
^Right::Send, {LCtrl down}{tab}{LCtrl up}	;CTRL + RIGHT (next tab)
^Left::Send, {LShift down}{LCtrl down}{tab}{LCtrl up}{LShift up}	;CTRL + LEFT (prev tab)
Capslock & f2::Run https://inbox.google.com	;Open up inbox
Capslock & f3::Run https://play.google.com/music/listen#/now ;Open up music
Capslock & f4::Run https://play.pocketcasts.com/web#/podcasts/new_releases ;Open up podcasts
;;;;;	INACTIVE HOTKEYS	;;;;;
;inbox := "https://inbox.google.com"
;Capslock & f5::Run C:\Users\Austin\AppData\Local\Google\Chrome SxS\Application\chrome.exe
;Capslock & K::Run C:\Users\Austin\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Accessibility\On-Screen Keyboard.lnk
;Capslock & f2::Sb_CurWinTop()
;Capslock & f3::Sb_CurWinBot()

;;;;;	HOTSTRINGS	;;;;;
::ee::akathol@gmail.com						;DOUBLE E + TAB SENDS EMAIL ADDRESS
::jj::akathol@j2interactive.com				;DOUBLE J + TAB SENDS EMAIL ADDRESS
::nn::
	Fn_Date("yyyyMMddhhmmss")				;DOUBLE N + TAB SENDS CURRENT DATE
	return
::dd::
	Fn_Date("yyyyMMdd")
	return
::tt::
	Fn_Date("ddd MM-dd-yyyy h:mm tt")
	return
:*?:c`t::
	TextMenu("¢,£,€,¥")
	Return
:*?:f`t::
	TextMenu("¼,½,¾")
	Return
:*?:m`t::
	TextMenu("±,÷,×,¹,²,³,ƒ,∫,∑,∞,≈,≠")
	Return

;;;;;	FUNCTIONS	;;;;;
Fn_Date(format) {
	FormatTime, CurrentDate,, %format%
	SendInput %CurrentDate%
}

TextMenu(TextOptions)
{
	StringSplit, MenuItems, TextOptions , `,
	Loop %MenuItems0%
	{
		Item := MenuItems%A_Index%						;THIS IS BROKEN. SOMETHING IS INSERTING A char BEFORE THE ITEM
		;Item := StrReplace(%Item%, Â)
		Menu, MyMenu, add, %Item%, MenuAction
	}
	Menu, MyMenu, Show
	Menu, MyMenu, DeleteAll
}
MenuBlank:
	return
MenuAction:
	SendInput %A_ThisMenuItem%{raw}%A_EndChar%
	return