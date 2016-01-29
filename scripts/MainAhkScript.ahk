;;;;;		Main AHK Script								
;;;;;		by Austin Kathol									
;;;;;		Tue 01-26-2016 9:15 AM
;;;;;		v1.0

;;;;;	INITIALIZE	;;;;;
#NoEnv
#SingleInstance Force								;Only one of these scripts can be run at a time
#Persistent											;this keeps the script running if no hotkeys are set (though one is)
#NoTrayIcon
;SetBatchLines -1									;Go as fast as CPU will allow

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
::e@::akathol@gmail.com						;DOUBLE E + TAB SENDS EMAIL ADDRESS
::j@::akathol@j2interactive.com				;DOUBLE J + TAB SENDS EMAIL ADDRESS
:*?:c`t::
	TextMenu("¢,£,€,¥")
	Return
:*?:f`t::
	TextMenu("¼,½,¾")
	Return
:*?:m`t::
	TextMenu("±,÷,×,¹,²,³,ƒ,∫,∑,∞,≈,≠")
	Return

:c:NNN::
	Fn_Date("yyyyMMddhhmmss")				;DOUBLE N + TAB SENDS CURRENT DATE
	return
:c:DDD::
	Fn_Date("yyyyMMdd")
	return
:c:TTT::
	Fn_Date("ddd MM-dd-yyyy h:mm tt")
	return
:c:DD+::
	InputBox, add, "Enter days to add","value: ",,300,,,,,2,0
	NewTime := A_Now
	EnvAdd, NewTime, %add%, d
	FormatTime, NewTime2, %NewTime%, yyyyMMdd
	SendInput, %NewTime2%
	Return
:c:DD-::
	InputBox, add, "Enter days to add","value: ",,300,,,,,2,0
	add *= -1
	NewTime := A_Now
	EnvAdd, NewTime, %add%, d
	FormatTime, NewTime2, %NewTime%, yyyyMMdd
	SendInput, %NewTime2%
	Return
:c:NN+::
	InputBox, add, "Enter days to add","value: ",,300,,,,,2,0
	NewTime := A_Now
	EnvAdd, NewTime, %add%, minute
	FormatTime, NewTime2, %NewTime%, yyyyMMddHHmmss
	SendInput, %NewTime2%
	Return
:c:NN-::
	InputBox, add, "Enter days to add","value: ",,300,,,,,2,0
	add *= -1
	NewTime := A_Now
	EnvAdd, NewTime, %add%, minute
	FormatTime, NewTime2, %NewTime%, yyyyMMddHHmmss
	SendInput, %NewTime2%
	Return
	
:c:mm+::
	InputBox, add, "minutes to add","value: ",,300,,,,,2,0
	NewTime := A_Now
	EnvAdd, NewTime, %add%, minute
	FormatTime,NewTime2,%NewTime%,hh:mm tt
	SendInput %NewTime2%
	return
	
:c:hh+::
	InputBox, add, "hours to add","value: ",,50,,,,,2,0
	NewTime := A_Now
	EnvAdd, NewTime, %add%, hour
	FormatTime,NewTime2,%NewTime%,hh:mm tt
	SendInput %NewTime2%
	return

:c:dd+::
	InputBox, add, "Enter days to add","value: ",,300,,,,,2,0
	NewTime := A_Now
	EnvAdd, NewTime, %add%, d
	FormatTime, NewTime2, %NewTime%, ddd MM-dd-yyyy
	SendInput, %NewTime2%
	Return

:c:mm-::
	InputBox, add, "minutes to add","value: ",,300,,,,,2,0
	add *= -1
	NewTime := A_Now
	EnvAdd, NewTime, %add%, minute
	FormatTime,NewTime2,%NewTime%,hh:mm tt
	SendInput %NewTime2%
	return

:c:hh-::
	InputBox, add, "hours to add","value: ",,300,,,,,2,0
	add *= -1
	NewTime := A_Now
	EnvAdd, NewTime, %add%, hour
	FormatTime,NewTime2,%NewTime%,hh:mm tt
	SendInput %NewTime2%
	return
	
:c:dd-::
	InputBox, add, "Enter days to add","value: ",,300,,,,,2,0
	add *= -1
	NewTime := A_Now
	EnvAdd, NewTime, %add%, d
	FormatTime, NewTime2, %NewTime%, ddd MM-dd-yyyy
	SendInput, %NewTime2%
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