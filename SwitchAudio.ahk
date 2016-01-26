;;;;;		SwitchAudio tools									
;;;;;		by Austin Kathol									
;;;;;		Tue 01-26-2016 9:15 AM
;;;;;		v1.1
;;;;;	Update 20160126: Remove obsolete functions. Break out hotkeys and hotstrings to separate ahks.

;;;;;	INITIALIZE	;;;;;
#NoEnv
;SetBatchLines -1									;Go as fast as CPU will allow
#SingleInstance Force								;Only one of these scripts can be run at a time
#include ahk-lib\VA.ahk										;VA.ahk is needed to be in the same folder as this script
#include ahk-lib\TTS.ahk									;TTS.ahk is needed for text to speech tools
#Persistent											;this keeps the script running if no hotkeys are set (though one is)
Global Voice := ComObjCreate("SAPI.SpVoice")		;Define the Voice variable
Global rate := 2									;Set default rate to 2 "kinda fast"
TTS(Voice, "SetRate", rate)							;Set default rate to 2 "kinda fast"
TTS(Voice, "SetVoice", "Microsoft Zira Desktop")	;Change to female voice

;;;;;	SETUP MENU	;;;;;
Menu, Tray, Icon, ico\h.ico,,1					;default is headphones icon
Menu, Tray, NoStandard						;?
Menu, Tray, Add, &Switch Playback Device (shift+caps), LShift & Capslock	;add tray option
Menu, Tray, Add, &Speak (highlight-caps), Capslock				;add tray option
Menu, Tray, Add, 						;add blank line
Menu, Tray, Standard						;?
Menu, Tray, Default, &Switch Playback Device (shift+caps)			;default option is new option

;;;;;	HOTKEYS	;;;;;
!Capslock::Capslock							;ALT + CAPS IS NOW CAPSLOCK
Capslock::Sb_Speak()						;Capslock SPEAKS COPIED TEXT
Capslock & Tab::Sb_SwapVoice()				;Swap Male/Female Voice
Capslock & Up::Sb_VoiceFaster()				;Turn voice rate 1 faster
Capslock & Down::Sb_VoiceSlower()			;Turn voice rate 1 slower
LShift & Capslock::Sb_ToggleSwitch()		;Shift TOGGLES HEADPHONES AND SPEAKERS

;;;;;	FUNCTIONS	;;;;;
Sb_ToggleSwitch() {
	Global SwitchAudio := !SwitchAudio
	VA_SetDefaultEndpoint("playback:" (SwitchAudio ? 1 : 2), 0)
	if (SwitchAudio) {
		Menu, Tray, Icon, ico\s.ico,,1
	} 
	else {
		Menu, Tray, Icon, ico\h.ico,,1
	}
}

Sb_Speak() {
	selectedText := Sb_GetSelected()
	TTS(Voice, "ToggleSpeak", selectedText)	; select some text and press F1
	return
}

Sb_GetSelected() {   ; GetSelectedText by Learning one 
	IsClipEmpty := (Clipboard = "") ? 1 : 0
	if !IsClipEmpty {
		ClipboardBackup := ClipboardAll
		While !(Clipboard = "") {
			Clipboard =
			Sleep, 10
		}
	}
	Send, ^c
	ClipWait, 0.1
	ToReturn := Clipboard, Clipboard := ClipboardBackup
	if !IsClipEmpty
	ClipWait, 0.5, 1
	Return ToReturn
}

Sb_SwapVoice() {
	Global togVN := !togVN
	if (togVN) {
		TTS(Voice, "SetVoice", "Microsoft David Desktop")
	} else {
		TTS(Voice, "SetVoice", "Microsoft Zira Desktop")
	}
	;tmp := TTS(Voice, "GetVoices")  ;available voices
	;MsgBox, %tmp%
}

Sb_VoiceFaster() {
	rate := rate+1
	if (rate > 10) 
	{
		rate := 10
	}
	TTS(Voice, "SetRate", rate)
	TTS(Voice, "ToggleSpeak", rate)
}

Sb_VoiceSlower() {
	rate := rate-1
	if (rate < -10) 
	{
		rate := -10
	}
	TTS(Voice, "SetRate", rate)
	TTS(Voice, "ToggleSpeak", rate)
}

