;;;;;		Experimental Script								
;;;;;		by Austin Kathol									
;;;;;		Fri 01-29-2016 1:34 PM
;;;;;		v1.0
;;;;;		For stuff I'm actively working one/playing with

;;;;;	INITIALIZE	;;;;;
#NoEnv
#SingleInstance Force								;Only one of these scripts can be run at a time
#Persistent											;this keeps the script running if no hotkeys are set (though one is)
#NoTrayIcon
SetBatchLines -1	

;;;;;	GAME SPECIFIC KEYS	;;;;;
#IfWinActive ahk_class LaunchUnrealUWindowsClient
SetKeyDelay, 500
Numpad0::Send {1}{1}
Numpad1::Send {1}{2}
Numpad2::Send {1}{3}
Numpad3::Send {1}{4}
Numpad4::Send {2}{1}
Numpad5::Send {2}{2}
Numpad6::Send {2}{3}
Numpad7::Send {2}{4}
Numpad8::Send {3}{1}
Numpad9::Send {3}{2}
NumpadAdd::Send {3}{3}
NumpadSub::Send {3}{4}
NumpadMult::Send {4}{1}
NumpadDiv::Send {4}{2}
NumpadDot::Send {4}{3}
NumpadEnter::Send {4}{4}
#IfWinActive

#IfWinActive ahk_exe FF8_EN.exe 
NumpadEnter::x
NumpadAdd::s
NumpadSub::v
NumpadMult::j
NumpadDot::d
#IfWinActive
