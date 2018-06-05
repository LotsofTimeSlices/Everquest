
#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
#Warn  ; Recommended for catching common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

;These 1st 3 lines are built with the create shortcuts script
Run C:\PATH\Rof2\Shortcuts\Toon1.lnk  ;Launch shortcut
WinWaitActive, EverQuest	;Wait for Everquest titled window to become active
WinSetTitle, Toon1 	;Change name of window title to ToonName

Sleep, 1000 ;This isn't required but may help smooth out the process.  MQ2AutoLogin works very well regadless of a delay.

Run C:\PATH\Rof2\Shortcuts\Toon2.lnk
WinWaitActive, EverQuest
WinSetTitle, Toon2

;Set CPU affinity
Run powershell.exe "Start-Process 'C:\PATH\Rof2\EQAffinity.bat' -WindowStyle Minimized"
	
^!1::WinActivate, Toon1 ;Control-Alt-1 hotkey
^+1::WinActivate, Toon2 ;Control-Shift-1 hotkey
