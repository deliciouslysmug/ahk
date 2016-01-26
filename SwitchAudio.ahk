;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;		SwitchAudio tools									;
;		by Austin Kathol									;
;		v1.0												;
;															;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


SetBatchLines -1									;Go as fast as CPU will allow
#SingleInstance Force								;Only one of these scripts can be run at a time
#include ahk-lib\VA.ahk										;VA.ahk is needed to be in the same folder as this script
#include ahk-lib\TTS.ahk									;TTS.ahk is needed for text to speech tools
#Persistent											;this keeps the script running if no hotkeys are set (though one is)
;#include %A_ScriptDir%								;Load all .ahks in the same folder
Global Voice := ComObjCreate("SAPI.SpVoice")		;Define the Voice variable
Global rate := 2									;Set default rate to 2 "kinda fast"
TTS(Voice, "SetRate", rate)							;Set default rate to 2 "kinda fast"
TTS(Voice, "SetVoice", "Microsoft Zira Desktop")	;Change to female voice

;;;;;	SETUP MENU	;;;;;
Menu, Tray, Icon, ico\h.ico,,1					;default is headphones icon
Menu, Tray, NoStandard						;?
Menu, Tray, Add, &Switch Playback Device (shift+caps), LShift & Capslock	;add tray option
Menu, Tray, Add, &Speak (highlight-caps), Capslock				;add tray option
Menu, Tray, Add, &Suspend hotkeys/strings (caps+f1), CapsLock & f1				;add tray option
Menu, Tray, Add, 						;add blank line
Menu, Tray, Standard						;?
Menu, Tray, Default, &Switch Playback Device (shift+caps)			;default option is new option

;;;;;	HOTKEYS	;;;;;
CapsLock & f1::
	Suspend, Toggle
	Sb_TogDisableAll()
	return
Capslock::Sb_Speak()						;Capslock SPEAKS COPIED TEXT
Capslock & Tab::Sb_SwapVoice()				;Swap Male/Female Voice
Capslock & Up::Sb_VoiceFaster()				;Turn voice rate 1 faster
Capslock & Down::Sb_VoiceSlower()			;Turn voice rate 1 slower
!Capslock::Capslock							;ALT + CAPS IS CAPSLOCK
LShift & Capslock::Sb_ToggleSwitch()		;ShiftTOGGLES HEADPHONES AND SPEAKERS




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

Sb_TogDisableAll() {
	Global AllOff := !AllOff
	if (AllOff) {
		TrayTip, Tray, HOTKEYS INACTIVE
	} 
	else {
		TrayTip, Tray, HOTKEYS ACTVE
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

Sb_CurWinTop() {
	GetMonitorInformation()
	winInfo := GetActiveWindowInfo()
    m := "m" . winInfo.newMonitor
    X := Monitors[m].Left
    Y := Monitors[m].Top + (Monitors[m].Height // 2)
	W := Monitors[m].Width
    H := Monitors[m].Height // 2
	If (winInfo.windowState = 1) ; Maxmized
        WinRestore, A

    WinMove, A,, newCords.X, newCords.Y, newCords.W, newCords.H
}

Sb_CurWinBot() {
	GetMonitorInformation()
	
	MsgBox, left %xm%
	xm1 := Monitors.Count
	MsgBox, left %xm1%
	m := "m" . 2
	xmon := Monitors[m].Left
	MsgBox, Monitors   %xmon%
	
	winInfo := GetActiveWindowInfo()
	nMonitor := winInfo.newMonitor
	MsgBox, %nMonitor%
	mon := M1.Left
	MsgBox, mon %mon%
    m := "m" . nMonitor
    X := Monitors[m].Left
    Y := Monitors[m].Top + (Monitors[m].Height // 2)
	W := Monitors[m].Width
    H := Monitors[m].Height // 2
	If (winInfo.windowState = 1) ; Maxmized
        WinRestore, A

    WinMove, A,, newCords.X, newCords.Y, newCords.W, newCords.H
}

GetMonitorInformation()
{
    global Mon1 := Object()
	SysGet, m1, MonitorWorkArea, 1
	Mon1.Left := m1.Left
	Mon1.Right := m1.Right
	Mon1.Top := m1.Top
	Mon1.Width := m1.Width
	Mon1.Height := m1.Height
	mon := Mon1.Left
	MsgBox, mon %mon%
	global M2 := Object()
	SysGet, m2, MonitorWorkArea, 2
	M2.Left := m2.Left
	M2.Right := m2.Right
	M2.Top := m2.Top
	M2.Width := m2.Width
	M2.Height := m2.Height
	
	
	global Monitors := Object()
	
	
    SysGet, monitorCount, MonitorCount
    SysGet, primaryMonitor, MonitorPrimary

    Monitors.Insert("Count", monitorCount)
	Monitors.Insert("Primary", primaryMonitor)
	
    ; Get work area for each monitor (excludes toolbars, taskbar, etc.)
    Loop, % Monitors.Count
    {
        SysGet, m%A_Index%, MonitorWorkArea, %A_Index%
        m_%A_Index% := Object("Left"  , m%A_Index%Left
                             ,"Right" , m%A_Index%Right
                             ,"Top"   , m%A_Index%Top
                             ,"Bottom", m%A_Index%Bottom
                             ,"Width" , m%A_Index%Right  - m%A_Index%Left
                             ,"Height", m%A_Index%Bottom - m%A_Index%Top)
        xm := m%A_Index%Left
		Monitors.Insert("m" . A_Index . left, m%A_Index%Left)
        Monitors.Insert("m" . A_Index, m_%A_Index%)
		;xm := Monitors.m2Left
		MsgBox, left %xm%
    }
}

GetActiveWindowInfo()
{
    WinGetPos, X, Y, W, H, A
    WinGet, windowState, MinMax, A
    Monitor := GetMonitorAt(X + W/2, Y + H/2)
    return Object("X", X
                 ,"Y", Y
                 ,"W", W
                 ,"H", H
                 ,"Monitor", Monitor
                 ,"windowState", windowState
                 ,"newMonitor", Monitor)
}

GetMonitorAt(x, y, default = 1)
{
    global Monitors

    ; Iterate through all monitors.
    Loop, % Monitors.count
    {   ; Check if the window is on this monitor.
        m := "m" A_Index
        if   (x >= Monitors[m].Left
           && x <= Monitors[m].Right
           && y >= Monitors[m].Top
           && y <= Monitors[m].Bottom)

            return A_Index
    }

    return default
}

;Fn_MessageUser(message) {
;	MsgBox, %message%
;	Return
;}