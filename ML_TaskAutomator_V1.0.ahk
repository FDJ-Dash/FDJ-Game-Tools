#Requires Autohotkey v2
#SingleInstance
SetWorkingDir(A_ScriptDir)
Global IconLib := A_ScriptDir . "\Icons"
, ImageLib := A_ScriptDir . "\Images"
, HotkeyGuide := "https://mean-littles-app.gitbook.io/mean-littles-app-docs/ml-task-automator/how-does-it-work"
, IniFile := A_ScriptDir . "\ML_TaskAutomator.ini"
, LicenseFile := A_ScriptDir . "\LicenseKey.ini"
, CurrentVersion := "1.0", FlagMissingIcons := 0, FlagMissingImage := 0
, AppName := "ML Task Automator", BlueFont := "c0x70A0FA", BackgroundDarkGrey := "Background2F2F2F"
;----------------------------------------------------
; GUI Properties
GameToolGui := Gui("+AlwaysOnTop")
GameToolGui.Opt("+MinimizeBox +OwnDialogs -Theme")
GameToolGui.SetFont("Bold cLime", "Comic Sans MS")
GameToolGui.BackColor := "0x2F2F2F"
try {
	GameToolGui.Add("Picture", "x-16 y0 w304 h712", ImageLib . "\MLTABackground.png")
}
catch {
	FlagMissingImage := 1
}
;----------------------------------------------------
; Read ini Modules
if !FileExist(IniFile) {
	CreateNewIniFile
}
SwitchJumps := IniRead(IniFile, "Modules", "SwitchJumps")
SwitchClicker := IniRead(IniFile, "Modules", "SwitchClicker")
if SwitchJumps == SwitchClicker or SwitchJumps > 1 or SwitchJumps < 0 or SwitchClicker > 1 or SwitchClicker < 0 {
	SwitchJumps := false
	SwitchClicker := true
	IniWrite SwitchJumps, IniFile, "Modules", "SwitchJumps"
	IniWrite SwitchClicker, IniFile, "Modules", "SwitchClicker"	
}
;----------------------------------------------------
; Read Ini Properties
ExitMessageTimeWait := IniRead(IniFile, "Properties", "ExitMessageTimeWait")
SecureMode := IniRead(IniFile, "Properties", "SecureMode")
if SecureMode > 1 or SecureMode < 0 {
	SecureMode := 1
	IniWrite SecureMode, IniFile, "Properties", "SecureMode"
}
EditBoxesAvailable := IniRead(IniFile, "Properties", "EditBoxesAvailable")
if EditBoxesAvailable > 1 or EditBoxesAvailable < 0 {
	EditBoxesAvailable := 1
	IniWrite EditBoxesAvailable, IniFile, "Properties", "EditBoxesAvailable"
}
SuspendHotkeys := IniRead(IniFile, "Properties", "SuspendHotkeys")
if SuspendHotkeys > 1 or SuspendHotkeys < 0 {
	SuspendHotkeys := 0
	IniWrite SuspendHotkeys, IniFile, "Properties", "SuspendHotkeys"
}
AutoRunLoop := IniRead(IniFile, "Properties", "AutoRunLoop")
if AutoRunLoop < 0  {
	AutoRunLoop := 0
	IniWrite AutoRunLoop, IniFile, "Properties", "AutoRunLoop"
}
GeneralLoopInterval := IniRead(IniFile, "Properties", "GeneralLoopInterval")
if GeneralLoopInterval < 0  {
	GeneralLoopInterval := 0
	IniWrite GeneralLoopInterval, IniFile, "Properties", "GeneralLoopInterval"
}
LoopAmount := IniRead(IniFile, "Properties", "LoopAmount")
if LoopAmount < 0  {
	LoopAmount := 0
	IniWrite LoopAmount, IniFile, "Properties", "LoopAmount"
}
;----------------------------------------------------
; Read Ini PaceProperties
ScrlUpCount := IniRead(IniFile, "PaceProperties", "ScrlUpCount")
ScrlUpInterval := IniRead(IniFile, "PaceProperties", "ScrlUpInterval")
ScrlDownCount := IniRead(IniFile, "PaceProperties", "ScrlDownCount")
ScrlDownInterval := IniRead(IniFile, "PaceProperties", "ScrlDownInterval")
;----------------------------------------------------
; Read Ini Saved Hotkey
StartAutoRunHotkey := IniRead(IniFile, "SavedHotkey", "StartAutoRunHotkey")
StopAutoRunHotKey := IniRead(IniFile, "SavedHotkey", "StopAutoRunHotKey")
PatternClickerHotkey := IniRead(IniFile, "SavedHotkey", "PatternClickerHotkey")
StopPatternHotkey := IniRead(IniFile, "SavedHotkey", "StopPatternHotkey")
JumpHotkey0 := IniRead(IniFile, "SavedHotkey", "JumpHotkey0")
JumpHotkey1 := IniRead(IniFile, "SavedHotkey", "JumpHotkey1")
JumpHotkey2 := IniRead(IniFile, "SavedHotkey", "JumpHotkey2")
JumpHotkey3 := IniRead(IniFile, "SavedHotkey", "JumpHotkey3")
JumpHotkey4 := IniRead(IniFile, "SavedHotkey", "JumpHotkey4")
;----------------------------------------------------
; Read ini AutoRun
SprintKey := IniRead(IniFile, "AutoRun", "SprintKey")
;----------------------------------------------------
; Read ini AutoRunKeyboard
ForwardKey := IniRead(IniFile, "AutoRunKeyboard", "ForwardKey")
;----------------------------------------------------
; Read ini AutoRunController
ButtonRT := IniRead(IniFile, "AutoRunController", "ButtonRT")
;----------------------------------------------------
; Read ini AutoClicker
ClickInterval := IniRead(IniFile, "AutoClicker", "ClickInterval")
RandomOffset := IniRead(IniFile, "AutoClicker", "RandomOffset")
;--------------------------------------------------
; Read ini CursorLocationClicker
CoordX0 := IniRead(IniFile, "CursorLocationClicker", "CoordX0")
CoordY0 := IniRead(IniFile, "CursorLocationClicker", "CoordY0")
Coord0Interval := IniRead(IniFile, "CursorLocationClicker", "Coord0Interval")
;-------------------------------
CoordX1 := IniRead(IniFile, "CursorLocationClicker", "CoordX1")
CoordY1 := IniRead(IniFile, "CursorLocationClicker", "CoordY1")
Coord1Interval := IniRead(IniFile, "CursorLocationClicker", "Coord1Interval")
;-------------------------------
CoordX2 := IniRead(IniFile, "CursorLocationClicker", "CoordX2")
CoordY2 := IniRead(IniFile, "CursorLocationClicker", "CoordY2")
Coord2Interval := IniRead(IniFile, "CursorLocationClicker", "Coord2Interval")
;-------------------------------
CoordX3 := IniRead(IniFile, "CursorLocationClicker", "CoordX3")
CoordY3 := IniRead(IniFile, "CursorLocationClicker", "CoordY3")
Coord3Interval := IniRead(IniFile, "CursorLocationClicker", "Coord3Interval")
;-------------------------------
CoordX4 := IniRead(IniFile, "CursorLocationClicker", "CoordX4")
CoordY4 := IniRead(IniFile, "CursorLocationClicker", "CoordY4")
Coord4Interval := IniRead(IniFile, "CursorLocationClicker", "Coord4Interval")
;--------------------------------------------------
; Read ini JumpProperties
VeryShortJumpRace := IniRead(IniFile, "JumpProperties", "VeryShortJumpRace")
VeryShortJumpLenght := IniRead(IniFile, "JumpProperties", "VeryShortJumpLenght")
;-------------------------------
ShortJumpRace := IniRead(IniFile, "JumpProperties", "ShortJumpRace")
ShortJumpLenght := IniRead(IniFile, "JumpProperties", "ShortJumpLenght")
;-------------------------------
NormalJumpRace := IniRead(IniFile, "JumpProperties", "NormalJumpRace")
NormalJumpLenght := IniRead(IniFile, "JumpProperties", "NormalJumpLenght")
;-------------------------------
LongJumpRace := IniRead(IniFile, "JumpProperties", "LongJumpRace")
LongJumpLenght := IniRead(IniFile, "JumpProperties", "LongJumpLenght")
;-------------------------------
VeryLongJumpRace := IniRead(IniFile, "JumpProperties", "VeryLongJumpRace")
VeryLongJumpLenght := IniRead(IniFile, "JumpProperties", "VeryLongJumpLenght")
;----------------------------------------------------
; Setup Menu
FileMenu := Menu()
MenuBar_Storage := MenuBar()
MenuBar_Storage.Add("&File", FileMenu)
FileMenu.Add("S&uspend Hotkeys`tCtrl+U",SuspendMenuHandler)
FileMenu.Insert()
FileMenu.Add("&Exit`tCtrl+K",MenuHandlerExit)
try {
	FileMenu.SetIcon("S&uspend Hotkeys`tCtrl+U",IconLib . "\stop.ico")
	FileMenu.SetIcon("&Exit`tCtrl+K",IconLib . "\exit.ico")
}
catch {
	FlagMissingIcons := 1
}
OptionsMenu := Menu()
MenuBar_Storage.Add("&Options", OptionsMenu)
OptionsMenu.Add("Secure &Mode: On/Off", SecureModeHandler)
OptionsMenu.Add("Secure Edit &Boxes: On/Off", EditBoxesHandler)
OptionsMenu.Insert()
OptionsMenu.Add("Edit &Ini File", EditIniFileHandler)
OptionsMenu.Insert()
OptionsMenu.Add("Switch &Jumps", SwitchJumpsHandler)
OptionsMenu.Add("Switch &Clicker", SwitchClickerHandler)

try {
	OptionsMenu.SetIcon("Edit &Ini File", IconLib . "\File.ico")
	OptionsMenu.SetIcon("Switch &Jumps", IconLib . "\Switch1.ico")
	OptionsMenu.SetIcon("Switch &Clicker", IconLib . "\auto.ico")
}
catch {
	FlagMissingIcons := 1
}
HelpMenu := Menu()
MenuBar_Storage.Add("&Help", HelpMenu)
HelpMenu.Add("Guide", MenuHandlerGuide)
HelpMenu.Add("Quick Fix", MenuHandlerQuickFix)
HelpMenu.Insert()
HelpMenu.Add("About", MenuHandlerAbout)

try {
	HelpMenu.SetIcon("Guide", IconLib . "\ML-TA.ico")
	HelpMenu.SetIcon("Quick Fix", IconLib . "\Fix.ico")
	HelpMenu.SetIcon("About", IconLib . "\info.ico")
}
catch {
	FlagMissingIcons := 1
}
GameToolGui.MenuBar := MenuBar_Storage
;----------------------------------------------------
; Keyboard AutoRun
GameToolGui.Add("Text", "x10 y10 h20 +0x200", " Auto Run ")
TextOnOff1 := GameToolGui.Add("Text","x105 y10 h20 +0x200", " OFF ")
GameToolGui.Add("Text", "x10 y35 h20 +0x200", " Stop Auto Run ")
if SecureMode == true {
	try {
		OptionsMenu.SetIcon("Secure &Mode: On/Off", IconLib . "\Locked.ico")
	}
	catch {
		FlagMissingIcons := 1
	}
	StartAutoRunHotkey := GameToolGui.Add("Hotkey", "vStartAutoRunHotkey x150 y10 w74 h20 +disabled", StartAutoRunHotkey)
	StopAutoRunHotKey := GameToolGui.Add("Hotkey", "vStopAutoRunHotKey x150 y35 w74 h20 +disabled", StopAutoRunHotKey)
} else {
	try {
		OptionsMenu.SetIcon("Secure &Mode: On/Off", IconLib . "\Unlocked.ico")
	}
	catch {
		FlagMissingIcons := 1
	}
	StartAutoRunHotkey := GameToolGui.Add("Hotkey", "vStartAutoRunHotkey x150 y10 w74 h20", StartAutoRunHotkey).OnEvent("Change", SubmitAutoRunHotkey)
	StopAutoRunHotKey := GameToolGui.Add("Hotkey", "vStopAutoRunHotKey x150 y35 w74 h20", StopAutoRunHotKey).OnEvent("Change", SubmitAutoRunHotkey)
}
;----------------------------------------------------
GameToolGui.Add("Text", "x1 y60 w250 h2 +0x10") ; Separator
;----------------------------------------------------
; Auto Scroll Up
TextScrlUp := GameToolGui.Add("Text","x10 y66 w110 h20 +0x200", " Auto Scroll up")
RadioScrlUpYes := GameToolGui.Add("Radio", "x10 y91 w30 h20", "Y")
RadioScrlUpNo := GameToolGui.Add("Radio", "x45 y91 w30 h20 +Checked", "N")
TextOnOffScrlUp := GameToolGui.Add("Text","x90 y91 w30 h20 +0x200", " OFF")
;----------------------------------------------------
; Auto Scroll Down
TextScrlDown := GameToolGui.Add("Text","x130 y66 w110 h20 +0x200", " Auto Scroll down")
RadioScrlDownYes := GameToolGui.Add("Radio", "x130 y91 w30 h20", "Y")
RadioScrlDownNo := GameToolGui.Add("Radio", "x165 y91 w30 h20 +Checked", "N")
TextOnOffScrlDown := GameToolGui.Add("Text","x210 y91 w30 h20 +0x200", " OFF")
;----------------------------------------------------
GameToolGui.Add("Text", "x1 y116 w250 h2 +0x10") ; Separator
;----------------------------------------------------
; Controller
GameToolGui.Add("Text","x10 y122 h20 +0x200", " Controller: ")
TextOnOffController := GameToolGui.Add("Text","x85 y122 w155 h20 +0x200", " Controller Not Found")
ControllerName := GameToolGui.Add("Text","x10 y147 w230 h20 +0x200", " ")
;----------------------------------------------------
; Controller AutoRun
GameToolGui.Add("Text","x10 y172 w110 h20 +0x200", " Controller AutoRun:")
RadioCtrlAuRunYes := GameToolGui.Add("Radio", "x130 y172 w30 h20 +Checked", "Y")
RadioCtrlAuRunNo := GameToolGui.Add("Radio", "x165 y172 w30 h20", "N")
TextOnOffCtrlAuRun := GameToolGui.Add("Text","x210 y172 w30 h20 +0x200", " OFF")
GameToolGui.Add("Text","x25 y197 w200 h20 +0x200", " Use RT / LT Keys to turn it on / off ")
;----------------------------------------------------
GameToolGui.Add("Text", "x1 y221 w250 h2 +0x10") ; Separator
;----------------------------------------------------
; Jumps
Switch true {
case SwitchJumps:
	try {
		OptionsMenu.SetIcon("Switch &Jumps", IconLib . "\Switch1.ico")
		OptionsMenu.SetIcon("Switch &Clicker", IconLib . "\Switch2.ico")
	}
	catch {
		FlagMissingIcons := 1
	}
	GameToolGui.Add("Text", "x05 y226 h20 +0x200", " Verify Num Lock key is ON for Numpad keys ")
	GameToolGui.Add("GroupBox", "x10 y250 w229 h150", "Jumps")
	GameToolGui.Add("Text", "x20 y273 w95 h20 +0x200", " Very Short jump")
	TextOnOff2 := GameToolGui.Add("Text","x120 y273 h20 +0x200", " OFF ")
	GameToolGui.Add("Text", "x20 y298 w95 h20 +0x200", " Short jump")
	TextOnOff3 := GameToolGui.Add("Text","x120 y298 h20 +0x200", " OFF ")
	GameToolGui.Add("Text", "x20 y323 w95 h20 +0x200", " Normal jump")
	TextOnOff4 := GameToolGui.Add("Text","x120 y323 h20 +0x200", " OFF ")
	GameToolGui.Add("Text", "x20 y348 w95 h20 +0x200", " Long jump")
	TextOnOff5 := GameToolGui.Add("Text","x120 y348 h20 +0x200", " OFF ")
	GameToolGui.Add("Text", "x20 y373 w95 h20 +0x200", " Very Long jump")
	TextOnOff6 := GameToolGui.Add("Text","x120 y373 h20 +0x200", " OFF ")

	if SecureMode == true {
		JumpHotkey0 := GameToolGui.Add("Hotkey", "vJumpHotkey0 x155 y273 w74 h20 +disabled", JumpHotkey0)
		JumpHotkey1 := GameToolGui.Add("Hotkey", "vJumpHotkey1 x155 y298 w74 h20 +disabled", JumpHotkey1)
		JumpHotkey2 := GameToolGui.Add("Hotkey", "vJumpHotkey2 x155 y323 w74 h20 +disabled", JumpHotkey2)
		JumpHotkey3 := GameToolGui.Add("Hotkey", "vJumpHotkey3 x155 y348 w74 h20 +disabled", JumpHotkey3)
		JumpHotkey4 := GameToolGui.Add("Hotkey", "vJumpHotkey4 x155 y373 w74 h20 +disabled", JumpHotkey4)
	} else {
		JumpHotkey0 := GameToolGui.Add("Hotkey", "vJumpHotkey0 x155 y273 w74 h20", JumpHotkey0).OnEvent("Change", SubmitJumpHotkey)
		JumpHotkey1 := GameToolGui.Add("Hotkey", "vJumpHotkey1 x155 y298 w74 h20", JumpHotkey1).OnEvent("Change", SubmitJumpHotkey)
		JumpHotkey2 := GameToolGui.Add("Hotkey", "vJumpHotkey2 x155 y323 w74 h20", JumpHotkey2).OnEvent("Change", SubmitJumpHotkey)
		JumpHotkey3 := GameToolGui.Add("Hotkey", "vJumpHotkey3 x155 y348 w74 h20", JumpHotkey3).OnEvent("Change", SubmitJumpHotkey)
		JumpHotkey4 := GameToolGui.Add("Hotkey", "vJumpHotkey4 x155 y373 w74 h20", JumpHotkey4).OnEvent("Change", SubmitJumpHotkey)
	}
case SwitchClicker:
	try {
		OptionsMenu.SetIcon("Switch &Clicker", IconLib . "\Switch1.ico")
		OptionsMenu.SetIcon("Switch &Jumps", IconLib . "\Switch2.ico")
	}
	catch {
		FlagMissingIcons := 1
	}
	GameToolGui.Add("Text","x48 y226 h20 +0x200", " Auto Clicker - Toggle Key ")
	
	if SecureMode == true {
		PatternClickerHotkey := GameToolGui.Add("Hotkey", "vPatternClickerHotkey x55 y276 w65 h20 +disabled", PatternClickerHotkey)
		StopPatternHotkey := GameToolGui.Add("Hotkey", "vStopPatternHotkey x177 y276 w65 h20 +disabled", StopPatternHotkey)
	} else {
		PatternClickerHotkey := GameToolGui.Add("Hotkey", "vPatternClickerHotkey x55 y276 w65 h20", PatternClickerHotkey).OnEvent("Change", SubmitPatternClickerHotkey)
		StopPatternHotkey := GameToolGui.Add("Hotkey", "vStopPatternHotkey x177 y276 w65 h20", StopPatternHotkey).OnEvent("Change", SubmitPatternClickerHotkey)
	}
	if EditBoxesAvailable == true {
		OptionsMenu.SetIcon("Secure Edit &Boxes: On/Off", IconLib . "\EditBox2.ico")
		EditPatternClicker := GameToolGui.Add("Edit", "vClickInterval x60 y251 w50 h20 +Number")
		EditPatternClickerOffset := GameToolGui.Add("Edit", "vRandomOffset x190 y251 w50 h20 +Number")
	} else {
		try {
			OptionsMenu.SetIcon("Secure Edit &Boxes: On/Off", IconLib . "\EditBox1.ico")
		}
		catch {
			FlagMissingIcons := 1
		}
		EditPatternClicker := GameToolGui.Add("Edit", "vClickInterval x60 y251 w50 h20 +Number +Disabled")
		EditPatternClickerOffset := GameToolGui.Add("Edit", "vRandomOffset x190 y251 w50 h20 +Number +Disabled")
	}
	TextPatternClickInterval := GameToolGui.Add("Text","x10 y251 h20 +0x200", " Interval ")
	TextPatternClickerOffset := GameToolGui.Add("Text","x120 y251 h20 +0x200", " Rnd Offset ")
	TextToggleClicker := GameToolGui.Add("Text","x07 y276 h20 +0x200", "ON/OFF")
	TextPosX := GameToolGui.Add("Text","x25 y301 h20 +0x200", "X")
	TextPosY := GameToolGui.Add("Text","x80 y301 h20 +0x200", "Y")
	TextPosInterval := GameToolGui.Add("Text","x120 y301 h20 +0x200", " Interval ")
	TextPatternClickerOnOff := GameToolGui.Add("Text","x195 y301 h20 +0x200", " OFF ")
	
	GameToolGui.SetFont()
	GameToolGui.SetFont("Bold " . BlueFont . "", "Comic Sans MS")
	TextPos0Interval := GameToolGui.Add("Text","x125 y276 h20 +0x200", "Stop Ptrn")
	GameToolGui.SetFont()
	GameToolGui.SetFont("Bold cLime", "Comic Sans MS")
	EditPatternClicker.Value := ClickInterval
	EditPatternClicker.Opt("" . BackgroundDarkGrey . "")
	EditPatternClickerOffset.Value := RandomOffset
	EditPatternClickerOffset.Opt("" . BackgroundDarkGrey . "")
	;----------------------------------------------------
	GameToolGui.SetFont()
	GameToolGui.SetFont("Bold " . BlueFont . "", "Comic Sans MS")
	if EditBoxesAvailable == true {
		EditPosX0 := GameToolGui.Add("Edit", "vCoordX0 x10 y326 w40 h20 +Number")
	} else {
		EditPosX0 := GameToolGui.Add("Edit", "vCoordX0 x10 y326 w40 h20 +Number +Disabled")
	}
	EditPosX0.Opt("" . BackgroundDarkGrey . "")
	GameToolGui.SetFont()
	GameToolGui.SetFont("Bold cLime", "Comic Sans MS")
	EditPosX0.Value := CoordX0
	GameToolGui.SetFont()
	GameToolGui.SetFont("Bold " . BlueFont . "", "Comic Sans MS")
	if EditBoxesAvailable == true {
		EditPosY0 := GameToolGui.Add("Edit", "vCoordY0 x65 y326 w40 h20 +Number")
	} else {
		EditPosY0 := GameToolGui.Add("Edit", "vCoordY0 x65 y326 w40 h20 +Number +Disabled")
	}
	EditPosY0.Opt("" . BackgroundDarkGrey . "")
	GameToolGui.SetFont()
	GameToolGui.SetFont("Bold cLime", "Comic Sans MS")
	EditPosY0.Value := CoordY0
	GameToolGui.SetFont()
	GameToolGui.SetFont("Bold " . BlueFont . "", "Comic Sans MS")
	if EditBoxesAvailable == true {
		EditPos0Interval := GameToolGui.Add("Edit", "vCoord0Interval x120 y326 w50 h20 +Number")
	} else {
		EditPos0Interval := GameToolGui.Add("Edit", "vCoord0Interval x120 y326 w50 h20 +Number +Disabled")
	}
	EditPos0Interval.Opt("" . BackgroundDarkGrey . "")
	GameToolGui.SetFont()
	GameToolGui.SetFont("Bold cLime", "Comic Sans MS")
	EditPos0Interval.Value := Coord0Interval
	
	RadioPos0Yes := GameToolGui.Add("Radio", "x184 y326 h20", "Y")
	RadioPos0No := GameToolGui.Add("Radio", "x216 y326 w30 h20 +Checked", "N")
	;----------------------------------------------------
	GameToolGui.SetFont()
	GameToolGui.SetFont("Bold " . BlueFont . "", "Comic Sans MS")
	if EditBoxesAvailable == true {
		EditPosX1 := GameToolGui.Add("Edit", "vCoordX1 x10 y351 w40 h20 +Number")
	} else {
		EditPosX1 := GameToolGui.Add("Edit", "vCoordX1 x10 y351 w40 h20 +Number +Disabled")
	}
	EditPosX1.Opt("" . BackgroundDarkGrey . "")
	GameToolGui.SetFont()
	GameToolGui.SetFont("Bold cLime", "Comic Sans MS")
	EditPosX1.Value := CoordX1
	GameToolGui.SetFont()
	GameToolGui.SetFont("Bold " . BlueFont . "", "Comic Sans MS")
	if EditBoxesAvailable == true {
		EditPosY1 := GameToolGui.Add("Edit", "vCoordY1 x65 y351 w40 h20 +Number")
	} else {
		EditPosY1 := GameToolGui.Add("Edit", "vCoordY1 x65 y351 w40 h20 +Number +Disabled")
	}
	EditPosY1.Opt("" . BackgroundDarkGrey . "")
	GameToolGui.SetFont()
	GameToolGui.SetFont("Bold cLime", "Comic Sans MS")
	EditPosY1.Value := CoordY1
	GameToolGui.SetFont()
	GameToolGui.SetFont("Bold " . BlueFont . "", "Comic Sans MS")
	if EditBoxesAvailable == true {
		EditPos1Interval := GameToolGui.Add("Edit", "vCoord1Interval x120 y351 w50 h20 +Number")
	} else {
		EditPos1Interval := GameToolGui.Add("Edit", "vCoord1Interval x120 y351 w50 h20 +Number +Disabled")
	}
	EditPos1Interval.Opt("" . BackgroundDarkGrey . "")
	GameToolGui.SetFont()
	GameToolGui.SetFont("Bold cLime", "Comic Sans MS")
	EditPos1Interval.Value := Coord1Interval
	
	RadioPos1Yes := GameToolGui.Add("Radio", "x184 y351 h20", "Y")
	RadioPos1No := GameToolGui.Add("Radio", "x216 y351 w30 h20 +Checked", "N")
	;----------------------------------------------------
	GameToolGui.SetFont()
	GameToolGui.SetFont("Bold " . BlueFont . "", "Comic Sans MS")
	if EditBoxesAvailable == true {
		EditPosX2 := GameToolGui.Add("Edit", "vCoordX2 x10 y376 w40 h20 +Number")
	} else {
		EditPosX2 := GameToolGui.Add("Edit", "vCoordX2 x10 y376 w40 h20 +Number +Disabled")
	}
	EditPosX2.Opt("" . BackgroundDarkGrey . "")
	GameToolGui.SetFont()
	GameToolGui.SetFont("Bold cLime", "Comic Sans MS")
	EditPosX2.Value := CoordX2
	GameToolGui.SetFont()
	GameToolGui.SetFont("Bold " . BlueFont . "", "Comic Sans MS")
	if EditBoxesAvailable == true {
		EditPosY2 := GameToolGui.Add("Edit", "vCoordY2 x65 y376 w40 h20 +Number")
	} else {
		EditPosY2 := GameToolGui.Add("Edit", "vCoordY2 x65 y376 w40 h20 +Number +Disabled")
	}
	EditPosY2.Opt("" . BackgroundDarkGrey . "")
	GameToolGui.SetFont()
	GameToolGui.SetFont("Bold cLime", "Comic Sans MS")
	EditPosY2.Value := CoordY2
	GameToolGui.SetFont()
	GameToolGui.SetFont("Bold " . BlueFont . "", "Comic Sans MS")
	if EditBoxesAvailable == true {
		EditPos2Interval := GameToolGui.Add("Edit", "vCoord2Interval x120 y376 w50 h20 +Number")
	} else {
		EditPos2Interval := GameToolGui.Add("Edit", "vCoord2Interval x120 y376 w50 h20 +Number +Disabled")
	}
	EditPos2Interval.Opt("" . BackgroundDarkGrey . "")
	GameToolGui.SetFont()
	GameToolGui.SetFont("Bold cLime", "Comic Sans MS")
	EditPos2Interval.Value := Coord2Interval
	
	RadioPos2Yes := GameToolGui.Add("Radio", "x184 y376 h20", "Y")
	RadioPos2No := GameToolGui.Add("Radio", "x216 y376 w30 h20 +Checked", "N")
	;----------------------------------------------------
	GameToolGui.SetFont()
	GameToolGui.SetFont("Bold " . BlueFont . "", "Comic Sans MS")
	if EditBoxesAvailable == true {
		EditPosX3 := GameToolGui.Add("Edit", "vCoordX3 x10 y401 w40 h20 +Number")
	} else {
		EditPosX3 := GameToolGui.Add("Edit", "vCoordX3 x10 y401 w40 h20 +Number +Disabled")
	}
	EditPosX3.Opt("" . BackgroundDarkGrey . "")
	GameToolGui.SetFont()
	GameToolGui.SetFont("Bold cLime", "Comic Sans MS")
	EditPosX3.Value := CoordX3
	GameToolGui.SetFont()
	GameToolGui.SetFont("Bold " . BlueFont . "", "Comic Sans MS")
	if EditBoxesAvailable == true {
		EditPosY3 := GameToolGui.Add("Edit", "vCoordY3 x65 y401 w40 h20 +Number")
	} else {
		EditPosY3 := GameToolGui.Add("Edit", "vCoordY3 x65 y401 w40 h20 +Number +Disabled")
	}
	EditPosY3.Opt("" . BackgroundDarkGrey . "")
	GameToolGui.SetFont()
	GameToolGui.SetFont("Bold cLime", "Comic Sans MS")
	EditPosY3.Value := CoordY3
	GameToolGui.SetFont()
	GameToolGui.SetFont("Bold " . BlueFont . "", "Comic Sans MS")
	if EditBoxesAvailable == true {
		EditPos3Interval := GameToolGui.Add("Edit", "vCoord3Interval x120 y401 w50 h20 +Number")
	} else {
		EditPos3Interval := GameToolGui.Add("Edit", "vCoord3Interval x120 y401 w50 h20 +Number +Disabled")
	}
	EditPos3Interval.Opt("" . BackgroundDarkGrey . "")
	GameToolGui.SetFont()
	GameToolGui.SetFont("Bold cLime", "Comic Sans MS")
	EditPos3Interval.Value := Coord3Interval
	
	RadioPos3Yes := GameToolGui.Add("Radio", "x184 y401 h20", "Y")
	RadioPos3No := GameToolGui.Add("Radio", "x216 y401 w30 h20 +Checked", "N")
	;----------------------------------------------------
	GameToolGui.SetFont()
	GameToolGui.SetFont("Bold " . BlueFont . "", "Comic Sans MS")
	if EditBoxesAvailable == true {
		EditPosX4 := GameToolGui.Add("Edit", "vCoordX4 x10 y426 w40 h20 +Number")
	} else {
		EditPosX4 := GameToolGui.Add("Edit", "vCoordX4 x10 y426 w40 h20 +Number +Disabled")
	}
	EditPosX4.Opt("" . BackgroundDarkGrey . "")
	GameToolGui.SetFont()
	GameToolGui.SetFont("Bold cLime", "Comic Sans MS")
	EditPosX4.Value := CoordX4
	GameToolGui.SetFont()
	GameToolGui.SetFont("Bold " . BlueFont . "", "Comic Sans MS")
	if EditBoxesAvailable == true {
		EditPosY4 := GameToolGui.Add("Edit", "vCoordY4 x65 y426 w40 h20 +Number")
	} else {
		EditPosY4 := GameToolGui.Add("Edit", "vCoordY4 x65 y426 w40 h20 +Number +Disabled")
	}
	EditPosY4.Opt("" . BackgroundDarkGrey . "")
	GameToolGui.SetFont()
	GameToolGui.SetFont("Bold cLime", "Comic Sans MS")
	EditPosY4.Value := CoordY4
	GameToolGui.SetFont()
	GameToolGui.SetFont("Bold " . BlueFont . "", "Comic Sans MS")
	if EditBoxesAvailable == true {
		EditPos4Interval := GameToolGui.Add("Edit", "vCoord4Interval x120 y426 w50 h20 +Number")
	} else {
		EditPos4Interval := GameToolGui.Add("Edit", "vCoord4Interval x120 y426 w50 h20 +Number +Disabled")
	}
	EditPos4Interval.Opt("" . BackgroundDarkGrey . "")
	GameToolGui.SetFont()
	GameToolGui.SetFont("Bold cLime", "Comic Sans MS")
	EditPos4Interval.Value := Coord4Interval
	
	RadioPos4Yes := GameToolGui.Add("Radio", "x184 y426 h20", "Y")
	RadioPos4No := GameToolGui.Add("Radio", "x216 y426 w30 h20 +Checked", "N")
	;----------------------------------------------------
	TextLoop := GameToolGui.Add("Text","x10 y451 h20 +0x200", " Loop amount: ")
	GameToolGui.SetFont()
	GameToolGui.SetFont("Bold " . BlueFont . "", "Comic Sans MS")
	if EditBoxesAvailable == true {
		EditLoopTimes := GameToolGui.Add("Edit", "vLoopAmount x100 y451 w70 h20 +Number")
	} else {
		EditLoopTimes := GameToolGui.Add("Edit", "vLoopAmount x100 y451 w70 h20 +Number +Disabled")
	}
	EditLoopTimes.Opt("" . BackgroundDarkGrey . "")
	GameToolGui.SetFont()
	GameToolGui.SetFont("Bold cLime", "Comic Sans MS")
	EditLoopTimes.Value := LoopAmount
	
	RadioCountLoopsYes := GameToolGui.Add("Radio", "x184 y451 h20", "Y")
	RadioCountLoopsNo := GameToolGui.Add("Radio", "x216 y451 w30 h20 +Checked", "N")
	GameToolGui.Add("Text","x22 y485 h20 +0x100", " Time interval in ms (1 second = 1000) ")
}
;----------------------------------------------------
; Save All EditBox Values
GameToolGui.Add("Text", "x1 y510 w250 h2 +0x10") ; Separator
SaveButton := GameToolGui.Add("Button", "x70 y520 h20", "Save Current Values")
SaveButton.OnEvent("Click", SubmitValues) 
;----------------------------------------------------
SB := GameToolGui.Add("StatusBar", , "Ready.")
;----------------------------------------------------
GameToolGui.OnEvent('Close', (*) => ExitApp())
GameToolGui.Title := AppName
GameToolGui.Show("w250 h570")
Saved := GameToolGui.Submit(false)
CoordMode "Mouse", "Screen"
;----------------------------------------------------
OnExit ExitMenu
ExitMenu(ExitReason,ExitCode)
{
	SB.SetText("Quiting..")
	SuspendHotkeys := IniRead(IniFile, "Properties", "SuspendHotkeys")
	if SuspendHotkeys != 0 {
		SuspendHotkeys := 0
		IniWrite SuspendHotkeys, IniFile, "Properties", "SuspendHotkeys"
	}
	If ExitReason == "Reload" {
		return 0
	}
	If ExitCode == 2 {
		InvalidLicenseMsg
		sleep ExitMessageTimeWait
		return 0
	}
	If ExitCode == 3 {
		LicenseFileMissingMsg
		sleep ExitMessageTimeWait
		return 0
	}
	Send("{w up}")
	Send("{shift up}")
	ExitMsg
	sleep ExitMessageTimeWait
	return 0
}
;----------------------------------------------------
; Auto-detect the controller number if called for:
ControllerNumber := 0 ; Auto-detect Controller

if ControllerNumber <= 0
{
    Loop 16  ; Query each controller number to find out which ones exist.
    {
        if GetKeyState(A_Index "JoyName")
        {
            ControllerNumber := A_Index
            break
        }
    }
    if ControllerNumber <= 0
    {
        ControllerAvailable := false
    } else {
		ControllerAvailable := true
	}
}

;----------------------------------------------------
; Verify License

TempFile := A_Temp . "\AuxData.ini"
if !FileExist(TempFile) {
	RunWait(A_ComSpec " /c getmac /NH > " TempFile, , "Hide") ; ipconfig (slow)
	FileAppend "[AuxData]" , TempFile
}
Count := 0
FlagError := 0
Loop Read, TempFile
{
	; Check if the current line is empty
	if !A_LoopReadLine {
		Count++
		continue
	}

	; Process the non-empty line here
	Match := RegExMatch(A_LoopReadLine, ".*?([0-9A-F])(?!\\Device)", &mac)
	Match2 := RegExMatch(A_LoopReadLine, ".*?([0-9A-Z])(?!\\w\\Device)", &mac)
	Switch true {
	case Match == true:
		MacAddress := StrSplit( A_LoopReadLine, A_Space)
	case Match2 == true:
		MacAddress := StrSplit( A_LoopReadLine, A_Space)
	Default:
		MacAddress := "An Error Ocurred"
		FlagError := 1
	}
	break
}

MixedPattern := "Az0By9Cx7Da8Eb2Fc4Gw3Hv5Ij6Js1KlLhMpNeOtPgQnRrSiTqUoVkWmXdYfZu"
if FlagError == 0 {
	StringMacAddress := MacAddress[Count]
} else {
	StringMacAddress := MacAddress
}
LicenseKey := ""
Count := 0
flag := 0
Loop Parse StringMacAddress {
	; 48 - 57
	if ord(A_LoopField) == 45 {
		if flag == 4 {
			LicenseKey .= "\"
		} else if flag == 3 {
			LicenseKey .= "@"
			flag := 4
		} else if flag == 2 {
			LicenseKey .= "["
			flag := 3
		} else if flag == 1 {
			LicenseKey .= "!"
			flag := 2
		} else {
			LicenseKey .= "."
			flag := 1
		}	
	}
	if ord(A_LoopField) == 46 {
		LicenseKey .= "-"
	}
	if ord(A_LoopField) < 58 {
		; (0,9)
		EncriptedString := A_LoopField
		for index, letter in StrSplit(MixedPattern) {
			if (letter == A_LoopField) {
				LicenseKey .= chr(index + 33)
				LicenseKey .= chr(index + 39)
				LicenseKey .= chr(index + 36)
				break
			}
		}
	}
	
	if ord(A_LoopField) == 58 {
		LicenseKey .= ";"
	}
	if ord(A_LoopField) == 59 {
		LicenseKey .= ":"
	}
	; 65 - 90
	if ord(A_LoopField) > 66 and ord(A_LoopField) < 91 {
		; (0,25) + 10 = (10,35)
		EncriptedString := A_LoopField
		for index, letter in StrSplit(MixedPattern) {
			if (letter == A_LoopField) {
				LicenseKey .= chr(index + 65)
				LicenseKey .= chr(index + 33)
				LicenseKey .= chr(index + 45)
				break
			}
		}
	}
	; 97 - 122
	if ord(A_LoopField) > 96 and ord(A_LoopField) < 123 {
		; (0,26) + 10 + 26 = (36,61)
		EncriptedString := A_LoopField
		for index, letter in StrSplit(MixedPattern) {
			if (letter == A_LoopField) {
				LicenseKey .= chr(index + 33)
				LicenseKey .= chr(index + 25)
				LicenseKey .= chr(index + 45)
				break
			}
		}
	}
}
try {
	LicenseKeyInFile := IniRead(LicenseFile, "Data", "LicenseKey")
}
catch as e {
	; License file is missing
	ExitApp(3)
}
Switch true {
case LicenseKeyInFile == "":
	try {
		LicenseKeyInAuxFile := IniRead(TempFile, "AuxData", "LicenseKey")
		if (LicenseKeyInAuxFile != LicenseKeyInFile) {
			ExitApp(2)
		}
	}
	catch as e {
		; No license key on TempFile yet
		IniWrite LicenseKey, LicenseFile, "Data", "LicenseKey"
		IniWrite LicenseKey, TempFile, "AuxData", "LicenseKey"
	}
case LicenseKeyInFile == LicenseKey:
	IniWrite LicenseKey, TempFile, "AuxData", "LicenseKey"
case LicenseKeyInFile != LicenseKey:
	IniWrite LicenseKey, TempFile, "AuxData", "LicenseKey"
	; Invalid License
	ExitApp(2)
}
;----------------------------------------------------
FirstRun := IniRead(IniFile, "Properties", "FirstRun")
if FirstRun == true {
	AntivirusMsg
	FirstRun := 0
	IniWrite FirstRun, IniFile, "Properties", "FirstRun"
}
;----------------------------------------------------
 if FlagMissingIcons == true {
	IconsFolderMissingMsg
 }
;----------------------------------------------------
if FlagMissingImage == true {
	ImageFolderMissingMsg
}
;----------------------------------------------------
Hotkey Saved.StartAutoRunHotkey, (ThisHotkey) => ProcessRunWalkHotkey(RunSelected := true, ThisHotkey)

Switch true {
case SwitchJumps:
	Hotkey Saved.JumpHotkey0, (ThisHotkey) => ProcessJumpHotkey0(ThisHotkey)
	Hotkey Saved.JumpHotkey1, (ThisHotkey) => ProcessJumpHotkey1(ThisHotkey)
	Hotkey Saved.JumpHotkey2, (ThisHotkey) => ProcessJumpHotkey2(ThisHotkey)
	Hotkey Saved.JumpHotkey3, (ThisHotkey) => ProcessJumpHotkey3(ThisHotkey)
	Hotkey Saved.JumpHotkey4, (ThisHotkey) => ProcessJumpHotkey4(ThisHotkey)
case SwitchClicker:
	Hotkey Saved.PatternClickerHotkey, (ThisHotkey) => ProcessPatternClicker(ThisHotkey)
}
;----------------------------------------------------
ExitMsg(*){
	ShowExit:
		Exitmsg := Gui("+AlwaysOnTop")
		Exitmsg.BackColor := "0x2F2F2F"
		try {
			Exitmsg.Add("Picture", "x-32 y0 w712 h300", ImageLib . "\MLTABackground2.png")
		}
		catch {
			FlagMissingImage := 1
		}
		try {
			Exitmsg.Add("Picture", "x9 y14 w64 h64", IconLib . "\ML-TA.ico")
		}
		catch {
			FlagMissingIcons := 1
		}
		Exitmsg.SetFont("s20 W700 Q4 cLime", "Georgia")
		Exitmsg.Add("Text", "x80 y8", "ML Task Automator")
		Exitmsg.SetFont("s9 cLime", "Comic Sans MS")
		Exitmsg.Add("Text", "x80 y45", "Mean Little's Task Automator v" CurrentVersion)
		Exitmsg.Add("Text", "x80 y65", "License key: ")
		Exitmsg.SetFont()
		Exitmsg.SetFont("s7 Bold " . BlueFont . "", "Comic Sans MS")
		Exitmsg.Add("Text", "x160 y68", LicenseKey)
		Exitmsg.Add("Text", "x0 y90 w470 h1 +0x5")
		Exitmsg.SetFont()
		Exitmsg.SetFont("s12 cLime", "Comic Sans MS")
		Exitmsg.Add("Text", "x80 y110", "ML Task Automator will close in " ExitMessageTimeWait / 1000 " seconds")
        Exitmsg.Add("Text", "x175 y140", "Have a nice day!")
		Exitmsg.SetFont()
		Exitmsg.SetFont("s9 cLime", "Comic Sans MS")
		Exitmsg.Add("Text", "x0 y180 w470 h1 +0x5")
		Exitmsg.Add("Text", "x100 y203", "Made with AutoHotkey V" A_AhkVersion . " " . (1 ? "Unicode" : "ANSI") . " " . (A_PtrSize == 8 ? "64-bit" : "32-bit"))
        Exitmsg.Title := "Goodbye!"
        Exitmsg.Show("w470 h240")
        Exitmsg.Opt("+LastFound")
    Return
}
;----------------------------------------------------
AntivirusMsg(*){
	ShowAntivirusMsg:
        AntivMsg := Gui("+AlwaysOnTop")
		AntivMsg.BackColor := "0x2F2F2F"
		try {
			AntivMsg.Add("Picture", "x-32 y0 w712 h300", ImageLib . "\MLTABackground2.png")
		}
		catch {
			FlagMissingImage := 1
		}
		try {
			AntivMsg.Add("Picture", "x9 y14 w64 h64", IconLib . "\ML-TA.ico")
		}
		catch {
			FlagMissingIcons := 1
		}
		AntivMsg.SetFont("s20 W700 Q4 cLime", "Georgia")
        AntivMsg.Add("Text", "x80 y8", AppName)
		AntivMsg.SetFont("s9 cLime", "Comic Sans MS")
		AntivMsg.Add("Text", "x80 y45", "Mean Little's Task Automator v" CurrentVersion)
		AntivMsg.Add("Text", "x80 y65", "License key: ")
		AntivMsg.SetFont()
		AntivMsg.SetFont("s7 Bold " . BlueFont . "", "Comic Sans MS")
		AntivMsg.Add("Text", "x160 y68", LicenseKey)
		AntivMsg.Add("Text", "x0 y90 w470 h1 +0x5")
		AntivMsg.SetFont()
		AntivMsg.SetFont("s11 cLime", "Comic Sans MS")
		AntivMsg.Add("Text", "x112 y100", "Welcome! This is the initial Check.")
		AntivMsg.Add("Text", "x112 y125", "Your antivirus may check the app.")
        AntivMsg.Add("Text", "x100 y150", "Once done the app will load properly")
		AntivMsg.SetFont()
		AntivMsg.SetFont("s9 cLime", "Comic Sans MS")
		AntivMsg.Add("Text", "x0 y180 w470 h1 +0x5")
		AntivMsg.Add("Text", "x25 y203", "Made with AutoHotkey V" A_AhkVersion . " " . (1 ? "Unicode" : "ANSI") . " " . (A_PtrSize == 8 ? "64-bit" : "32-bit"))
        ogcButtonOK := AntivMsg.Add("Button", "x370 y200 w80 h24", "OK")
		ogcButtonOK.OnEvent("Click", Destroy)
		AntivMsg.Title := "Initial load.."
        AntivMsg.Show("w470 h240")
        AntivMsg.Opt("+LastFound")
    Return
	Destroy(*){
		AntivMsg.Destroy()
	}
}
;----------------------------------------------------
ImageFolderMissingMsg(*){
	ShowImageFolderMissing:
        ImgMissingMsg := Gui("+AlwaysOnTop")
		ImgMissingMsg.BackColor := "0x2F2F2F"
		try {
			ImgMissingMsg.Add("Picture", "x-32 y0 w712 h300", ImageLib . "\MLTABackground2.png")
		}
		catch {
			FlagMissingImage := 1
		}
		try {
			ImgMissingMsg.Add("Picture", "x9 y14 w64 h64", IconLib . "\ML-TA.ico")
		}
		catch {
			FlagMissingIcons := 1
		}
		ImgMissingMsg.SetFont("s20 W700 Q4 cLime", "Georgia")
        ImgMissingMsg.Add("Text", "x80 y8", AppName)
		ImgMissingMsg.SetFont("s9 cLime", "Comic Sans MS")
		ImgMissingMsg.Add("Text", "x80 y45", "Mean Little's Task Automator v" CurrentVersion)
		ImgMissingMsg.Add("Text", "x80 y65", "License key: ")
		ImgMissingMsg.SetFont()
		ImgMissingMsg.SetFont("s7 Bold " . BlueFont . "", "Comic Sans MS")
		ImgMissingMsg.Add("Text", "x160 y68", LicenseKey)
		ImgMissingMsg.Add("Text", "x0 y90 w470 h1 +0x5")
		ImgMissingMsg.SetFont()
		ImgMissingMsg.SetFont("s12 cRed", "Comic Sans MS")
		ImgMissingMsg.Add("Text", "x70 y110", "Image folder probably missing. Please check..")
        ImgMissingMsg.Add("Text", "x85 y140", "You can still run the app like this though..")
		ImgMissingMsg.SetFont()
		ImgMissingMsg.SetFont("s9 cLime", "Comic Sans MS")
		ImgMissingMsg.Add("Text", "x0 y180 w470 h1 +0x5")
		ImgMissingMsg.Add("Text", "x100 y203", "Made with AutoHotkey V" A_AhkVersion . " " . (1 ? "Unicode" : "ANSI") . " " . (A_PtrSize == 8 ? "64-bit" : "32-bit"))
        ImgMissingMsg.Title := "Image Folder Missing!"
        ImgMissingMsg.Show("w470 h240")
        ImgMissingMsg.Opt("+LastFound")
    Return
}
;----------------------------------------------------
IconsFolderMissingMsg(*){
	ShowIconFolderMissing:
        IconMissingMsg := Gui("+AlwaysOnTop")
		IconMissingMsg.BackColor := "0x2F2F2F"
		try {
			IconMissingMsg.Add("Picture", "x-32 y0 w712 h300", ImageLib . "\MLTABackground2.png")
		}
		catch {
			FlagMissingImage := 1
		}
		try {
			IconMissingMsg.Add("Picture", "x9 y14 w64 h64", IconLib . "\ML-TA.ico")
		}
		catch {
			FlagMissingIcons := 1
		}
		IconMissingMsg.SetFont("s20 W700 Q4 cLime", "Georgia")
        IconMissingMsg.Add("Text", "x80 y8", AppName)
		IconMissingMsg.SetFont("s9 cLime", "Comic Sans MS")
		IconMissingMsg.Add("Text", "x80 y45", "Mean Little's Task Automator v" CurrentVersion)
		IconMissingMsg.Add("Text", "x80 y65", "License key: ")
		IconMissingMsg.SetFont()
		IconMissingMsg.SetFont("s7 Bold " . BlueFont . "", "Comic Sans MS")
		IconMissingMsg.Add("Text", "x160 y68", LicenseKey)
		IconMissingMsg.Add("Text", "x0 y90 w470 h1 +0x5")
		IconMissingMsg.SetFont()
		IconMissingMsg.SetFont("s12 cRed", "Comic Sans MS")
		IconMissingMsg.Add("Text", "x70 y110", "Icons folder probably missing. Please check..")
        IconMissingMsg.Add("Text", "x85 y140", "You can still run the app like this though..")
		IconMissingMsg.SetFont()
		IconMissingMsg.SetFont("s9 cLime", "Comic Sans MS")
		IconMissingMsg.Add("Text", "x0 y180 w470 h1 +0x5")
		IconMissingMsg.Add("Text", "x100 y203", "Made with AutoHotkey V" A_AhkVersion . " " . (1 ? "Unicode" : "ANSI") . " " . (A_PtrSize == 8 ? "64-bit" : "32-bit"))
        IconMissingMsg.Title := "Icons Folder Missing?"
        IconMissingMsg.Show("w470 h240")
        IconMissingMsg.Opt("+LastFound")
    Return
}
;----------------------------------------------------
InvalidLicenseMsg(*){
	ShowLicense:
        InvLicMsg := Gui("+AlwaysOnTop")
		InvLicMsg.BackColor := "0x2F2F2F"
		try {
			InvLicMsg.Add("Picture", "x-32 y0 w712 h300", ImageLib . "\MLTABackground2.png")
		}
		catch {
			FlagMissingImage := 1
		}
		try {
			InvLicMsg.Add("Picture", "x9 y14 w64 h64", IconLib . "\ML-TA.ico")
		}
		catch {
			FlagMissingIcons := 1
		}
		InvLicMsg.SetFont("s20 W700 Q4 cLime", "Georgia")
        InvLicMsg.Add("Text", "x80 y8", AppName)
		InvLicMsg.SetFont("s9 cLime", "Comic Sans MS")
		InvLicMsg.Add("Text", "x80 y45", "Mean Little's Task Automator v" CurrentVersion)
		InvLicMsg.Add("Text", "x80 y65", "License key: ")
		InvLicMsg.SetFont()
		InvLicMsg.SetFont("s7 Bold cRed", "Comic Sans MS")
		InvLicMsg.Add("Text", "x160 y68", "???")
		InvLicMsg.Add("Text", "x0 y90 w470 h1 +0x5")
		InvLicMsg.SetFont()
		InvLicMsg.SetFont("s12 cRed", "Comic Sans MS")
		InvLicMsg.Add("Text", "x175 y110", "Invalid License Key")
        InvLicMsg.Add("Text", "x80 y140", "ML Task Automator will close in " ExitMessageTimeWait / 1000 " seconds")
		InvLicMsg.SetFont()
		InvLicMsg.SetFont("s9 cLime", "Comic Sans MS")
		InvLicMsg.Add("Text", "x0 y180 w470 h1 +0x5")
		InvLicMsg.Add("Text", "x100 y203", "Made with AutoHotkey V" A_AhkVersion . " " . (1 ? "Unicode" : "ANSI") . " " . (A_PtrSize == 8 ? "64-bit" : "32-bit"))
        InvLicMsg.Title := "Invalid License Key!"
        InvLicMsg.Show("w470 h240")
        InvLicMsg.Opt("+LastFound")
    Return
}
;----------------------------------------------------
LicenseFileMissingMsg(*){
	ShowMissingLicFile:
        NoLicFileMsg := Gui("+AlwaysOnTop")
		NoLicFileMsg.BackColor := "0x2F2F2F"
		try {
			NoLicFileMsg.Add("Picture", "x-32 y0 w712 h300", ImageLib . "\MLTABackground2.png")
		}
		catch {
			FlagMissingImage := 1
		}
		try {
			NoLicFileMsg.Add("Picture", "x9 y14 w64 h64", IconLib . "\ML-TA.ico")
		}
		catch {
			FlagMissingIcons := 1
		}
		NoLicFileMsg.SetFont("s20 W700 Q4 cLime", "Georgia")
        NoLicFileMsg.Add("Text", "x80 y8", AppName)
		NoLicFileMsg.SetFont("s9 cLime", "Comic Sans MS")
		NoLicFileMsg.Add("Text", "x80 y45", "Mean Little's Task Automator v" CurrentVersion)
		NoLicFileMsg.Add("Text", "x80 y65", "License key: ")
		NoLicFileMsg.SetFont()
		NoLicFileMsg.SetFont("s7 Bold cRed", "Comic Sans MS")
		NoLicFileMsg.Add("Text", "x160 y68", "???")
		NoLicFileMsg.Add("Text", "x0 y90 w470 h1 +0x5")
		NoLicFileMsg.SetFont()
		NoLicFileMsg.SetFont("s12 cRed", "Comic Sans MS")
		NoLicFileMsg.Add("Text", "x170 y110", "License file not found")
        NoLicFileMsg.Add("Text", "x80 y140", "ML Task Automator will close in " ExitMessageTimeWait / 1000 " seconds")
		NoLicFileMsg.SetFont()
		NoLicFileMsg.SetFont("s9 cLime", "Comic Sans MS")
		NoLicFileMsg.Add("Text", "x0 y180 w470 h1 +0x5")
		NoLicFileMsg.Add("Text", "x100 y203", "Made with AutoHotkey V" A_AhkVersion . " " . (1 ? "Unicode" : "ANSI") . " " . (A_PtrSize == 8 ? "64-bit" : "32-bit"))
        NoLicFileMsg.Title := "Invalid License Key!"
        NoLicFileMsg.Show("w470 h240")
        NoLicFileMsg.Opt("+LastFound")
    Return
}
;----------------------------------------------------
SaveMsg(*){
	ShowSave:
		Savemsg := Gui("+AlwaysOnTop")
		Savemsg.BackColor := "0x2F2F2F"
		try {
			Savemsg.Add("Picture", "x-32 y0 w712 h300", ImageLib . "\MLTABackground2.png")
		}
		catch {
			FlagMissingImage := 1
		}
		try {
			Savemsg.Add("Picture", "x9 y14 w64 h64", IconLib . "\ML-TA.ico")
		}
		catch {
			FlagMissingIcons := 1
		}
		Savemsg.SetFont("s20 W700 Q4 cLime", "Georgia")
        Savemsg.Add("Text", "x80 y8", AppName)
		Savemsg.SetFont("s9 cLime", "Comic Sans MS")
		Savemsg.Add("Text", "x80 y45", "Mean Little's Task Automator v" CurrentVersion)
		Savemsg.Add("Text", "x80 y65", "License key: ")
		Savemsg.SetFont()
		Savemsg.SetFont("s7 Bold " . BlueFont . "", "Comic Sans MS")
		Savemsg.Add("Text", "x160 y68", LicenseKey)
		Savemsg.Add("Text", "x0 y90 w470 h1 +0x5")
		Savemsg.SetFont()
		Savemsg.SetFont("s12 cLime", "Comic Sans MS")
		Savemsg.Add("Text", "x110 y125", "Values saved successfully to ini file")
		Savemsg.SetFont()
		Savemsg.SetFont("s9 cLime", "Comic Sans MS")
		Savemsg.Add("Text", "x0 y180 w470 h1 +0x5")
		Savemsg.Add("Text", "x25 y203", "Made with AutoHotkey V" A_AhkVersion . " " . (1 ? "Unicode" : "ANSI") . " " . (A_PtrSize == 8 ? "64-bit" : "32-bit"))
        ogcButtonOK := Savemsg.Add("Button", "x370 y200 w80 h24", "OK")
		ogcButtonOK.OnEvent("Click", Destroy)
		Savemsg.Title := "Save Successful!"
        Savemsg.Show("w470 h240")
		ControlFocus("Button1", "Save Successful!")
        Savemsg.Opt("+LastFound")
    Return
	Destroy(*){
		Savemsg.Destroy()
	}
}
;----------------------------------------------------
SecureModeOff(*){
	ShowSecModeOff:
        SecModeOff := Gui("+AlwaysOnTop")
		SecModeOff.BackColor := "0x2F2F2F"
		try {
			SecModeOff.Add("Picture", "x-32 y0 w712 h300", ImageLib . "\MLTABackground2.png")
		}
		catch {
			FlagMissingImage := 1
		}
		try {
			SecModeOff.Add("Picture", "x9 y14 w64 h64", IconLib . "\ML-TA.ico")
		}
		catch {
			FlagMissingIcons := 1
		}
		SecModeOff.SetFont("s20 W700 Q4 cLime", "Georgia")
        SecModeOff.Add("Text", "x80 y8", AppName)
		SecModeOff.SetFont("s9 cLime", "Comic Sans MS")
		SecModeOff.Add("Text", "x80 y45", "Mean Little's Task Automator v" CurrentVersion)
		SecModeOff.Add("Text", "x80 y65", "License key: ")
		SecModeOff.SetFont()
		SecModeOff.SetFont("s7 Bold " . BlueFont . "", "Comic Sans MS")
		SecModeOff.Add("Text", "x160 y68", LicenseKey)
		SecModeOff.Add("Text", "x0 y90 w470 h1 +0x5")
		SecModeOff.SetFont()
		SecModeOff.SetFont("s12 cLime", "Comic Sans MS")
		SecModeOff.Add("Text", "x145 y110", "Secure Mode is OFF.")
		SecModeOff.Add("Text", "x80 y140", "Switch Secure Mode ON and try again.")
		SecModeOff.SetFont()
		SecModeOff.SetFont("s9 cLime", "Comic Sans MS")
		SecModeOff.Add("Text", "x0 y180 w470 h1 +0x5")
		SecModeOff.Add("Text", "x25 y203", "Made with AutoHotkey V" A_AhkVersion . " " . (1 ? "Unicode" : "ANSI") . " " . (A_PtrSize == 8 ? "64-bit" : "32-bit"))
        ogcButtonOK := SecModeOff.Add("Button", "x370 y200 w80 h24", "OK")
		ogcButtonOK.OnEvent("Click", Destroy)
        SecModeOff.Title := "Secure Mode Off"
        SecModeOff.Show("w470 h240")
        ControlFocus("Button1", "Secure Mode Off")
        SecModeOff.Opt("+LastFound")
    Return
	Destroy(*){
		SecModeOff.Destroy()
	}
}
;----------------------------------------------------
MenuHandlerAbout(*)
{
	ShowAbout:
        About := Gui("+AlwaysOnTop")
		About.BackColor := "0x2F2F2F"
		try {
			About.Add("Picture", "x-32 y0 w712 h300", ImageLib . "\MLTABackground2.png")
		}
		catch {
			FlagMissingImage := 1
		}
		try {
			About.Add("Picture", "x9 y14 w64 h64", IconLib . "\ML-TA.ico")
		}
		catch {
			FlagMissingIcons := 1
		}
		About.SetFont("s20 W700 Q4 cLime", "Georgia")
        About.Add("Text", "x80 y8", AppName)
		About.SetFont("s9 cLime", "Comic Sans MS")
		About.Add("Text", "x80 y45", "Mean Little's Task Automator v" CurrentVersion)
		About.Add("Text", "x80 y65", "License key: ")
		About.SetFont()
		About.SetFont("s7 Bold " . BlueFont . "", "Comic Sans MS")
		EditLicAbout := About.Add("Edit", "x160 y65 h20 +Readonly", LicenseKey)
		EditLicAbout.Opt("" . BackgroundDarkGrey . "")
		About.Add("Text", "x0 y90 w470 h1 +0x5")
		About.SetFont()
		About.SetFont("s12 cLime", "Comic Sans MS")
		About.Add("Text", "x80 y125", "Programmed and designed by:")
		About.Add("Link", "x310 y125", "<a href=`"https://github.com/FDJ-Dash`">FDJ-Dash</a>")
		About.SetFont()
		About.SetFont("s9 cLime", "Comic Sans MS")
		About.Add("Text", "x0 y180 w470 h1 +0x5")
        About.Add("Text", "x25 y190", "Support mail:")
		EditAbout := About.Add("Edit", "x105 y187 h20 +Readonly", "mean.little.software@gmail.com")
		EditAbout.Opt("" . BackgroundDarkGrey . "")
		About.Add("Text", "x25 y212", "Made with AutoHotkey V" A_AhkVersion . " " . (1 ? "Unicode" : "ANSI") . " " . (A_PtrSize == 8 ? "64-bit" : "32-bit"))
		ogcButtonOK := About.Add("Button", "x370 y200 w80 h24", "OK")
		ogcButtonOK.OnEvent("Click", Destroy)
        About.Title := "About"
        About.Show("w470 h240")
        ControlFocus("Button1", "About")
        About.Opt("+LastFound")
    Return
	Destroy(*){
		About.Destroy()
	}
}
;----------------------------------------------------
MenuHandlerGuide(*) {
	ShowGuide:
        GuideMsg := Gui("+AlwaysOnTop")
		GuideMsg.BackColor := "0x2F2F2F"
		try {
			GuideMsg.Add("Picture", "x-32 y0 w712 h300", ImageLib . "\MLTABackground2.png")
		}
		catch {
			FlagMissingImage := 1
		}
		try {
			GuideMsg.Add("Picture", "x9 y14 w64 h64", IconLib . "\ML-TA.ico")
		}
		catch {
			FlagMissingIcons := 1
		}
		GuideMsg.SetFont("s20 W700 Q4 cLime", "Georgia")
        GuideMsg.Add("Text", "x80 y8", AppName)
		GuideMsg.SetFont("s9 cLime", "Comic Sans MS")
		GuideMsg.Add("Text", "x80 y45", "Mean Little's Task Automator v" CurrentVersion)
		GuideMsg.Add("Text", "x80 y65", "License key: ")
		GuideMsg.SetFont()
		GuideMsg.SetFont("s7 Bold " . BlueFont . "", "Comic Sans MS")
		GuideMsg.Add("Text", "x160 y68", LicenseKey)
		GuideMsg.Add("Text", "x0 y90 w470 h1 +0x5")
		GuideMsg.SetFont()
		GuideMsg.SetFont("s12 cLime", "Comic Sans MS")
		GuideMsg.Add("Text", "x100 y110", "The guide will open in your browser.")
        GuideMsg.Add("Text", "x137 y140", "You can close this message.")
		GuideMsg.SetFont()
		GuideMsg.SetFont("s9 cLime", "Comic Sans MS")
		GuideMsg.Add("Text", "x0 y180 w470 h1 +0x5")
		GuideMsg.Add("Text", "x25 y203", "Made with AutoHotkey V" A_AhkVersion . " " . (1 ? "Unicode" : "ANSI") . " " . (A_PtrSize == 8 ? "64-bit" : "32-bit"))
        ogcButtonOK := GuideMsg.Add("Button", "x370 y200 w80 h24 Default", "OK")
		ogcButtonOK.OnEvent("Click", Destroy)
        GuideMsg.Title := "Guide"
        GuideMsg.Show("w470 h240")
        ControlFocus("Button1", "Guide")
        GuideMsg.Opt("+LastFound")
		run HotkeyGuide
    Return
	
	Destroy(*){
		GuideMsg.Destroy()
	}
}
;----------------------------------------------------
; Initial state for selected modes
RunSelected := false
WalkSelected := true
;----------------------------------------------------
; Keyboard Autorun Loop
ProcessRunWalkHotkey(RunSelected, CurrentHotkey, *){
	if String(CurrentHotkey) == "" {
		MsgBox "CurrentHotkey variable is empty: " CurrentHotkey
		return
	}
	if SecureMode == false {
		SecureModeOff
		return
	}
	WalkSelected := true
	if RunSelected == true {
		SB.SetText("AutoRun triggered by keyboard active.")
		WalkSelected := false
		Send("{" . SprintKey . " down}")
		Send("{" . ForwardKey . " down}")
		TextOnOff1.Value := " ON"
		if RadioScrlUpYes.Value == 1 {
			RadioScrlUpNo.Value := 0
			TextOnOffScrlUp.Value := " ON"
			Count := 0
			SB.SetText("AutoRun + Scroll up active. Scrlup count: " Count)
			loop ScrlUpCount {
				Send("{WheelUP}")
				sleep ScrlUpInterval
				if GetKeyState(StopAutoRunHotKey.Value, "P") {
					break
				}
				Count++
				SB.SetText("AutoRun + Scroll up active. Scrlup count: " Count)
			}
			TextOnOffScrlUp.Value := " OFF"
			SB.SetText("AutoRun triggered by keyboard active.")
		}
		loop {
			if GetKeyState(StopAutoRunHotKey.Value, "P") {
				Send("{" . SprintKey . " up}")
				Send("{" . ForwardKey . " up}")
				TextOnOff1.Value := " OFF"
				SB.SetText("Ready")
				if RadioScrlDownYes.Value == 1 {
					RadioScrlDownNo.Value := 0
					TextOnOffScrlDown.Value := " ON"
					Count := 0
					SB.SetText("Scroll down active. ScrlDown count: " Count)
					loop ScrlDownCount {
						Send("{WheelDown}")
						sleep ScrlDownInterval
						if GetKeyState(StartAutoRunHotkey.Value, "P") {
							break
						}
						Count++
						SB.SetText("Scroll down active. ScrlDown count: " Count)
					}
					TextOnOffScrlDown.Value := " OFF"
					SB.SetText("Ready")
				}
				break
			}
			Sleep AutoRunLoop
		}
	}
}
;----------------------------------------------------
; General Loop
Loop {
	MouseGetPos(&x, &y)
	if ControllerAvailable == true {
		TextOnOffController.Value := " Controller Found"
		ControllerName.Value := GetKeyState(ControllerNumber "JoyName")
		cont_info := GetKeyState(ControllerNumber "JoyInfo")
		if RadioCtrlAuRunYes.Value == true {
			RadioCtrlAuRunNo.Value := false
			if InStr(cont_info, "Z") {
				try {
					axis_info_Z := Round(GetKeyState(ControllerNumber "JoyZ"))
				}
				catch as e {
					; the controller was disconnected
					TextOnOffController.Value := " Controller Not Found"
					ControllerName.Value := " "
					RadioCtrlAuRunYes.Value := false
					RadioCtrlAuRunNo.Value := true
					ControllerAvailable := false
				}
				; Controller RT key
				if axis_info_Z < 45 {
					RunSelected := true
					WalkSelected := false
					TextOnOffCtrlAuRun.Value := " ON"
					SB.SetText("Controller autorun active.")
					Send("{" . SprintKey . " down}")
					Send("{" . ButtonRT . " down}")
					if RadioScrlUpYes.Value == 1 {
						RadioScrlUpNo.Value := 0
						TextOnOffScrlUp.Value := " ON"
						Count := 0
						SB.SetText("AutoRun + Scroll up active. Scrlup count: " Count)
						loop ScrlUpCount {
							Send("{WheelUP}")
							sleep ScrlUpInterval
							axis_info_Z := Round(GetKeyState(ControllerNumber "JoyZ"))
							if axis_info_Z > 55 {
								break
							}
							Count++
							SB.SetText("AutoRun + Scroll up active. Scrlup count: " Count)
						}
						TextOnOffScrlUp.Value := " OFF"
						SB.SetText("AutoRun triggered by controller active.")
					}
					loop {
						try {
							axis_info_Z := Round(GetKeyState(ControllerNumber "JoyZ"))
						}
						catch as e {
							; the controller was disconnected
							TextOnOffController.Value := " Controller Not Found"
							ControllerName.Value := " "
							RadioCtrlAuRunYes.Value := false
							RadioCtrlAuRunNo.Value := true
							ControllerAvailable := false
							TextOnOffCtrlAuRun.Value := " OFF"
							Send("{" . SprintKey . " up}")
							Send("{" . ButtonRT . " up}")
							break
						}
						; Controller LT key
						if axis_info_Z > 55 or GetKeyState(StopAutoRunHotKey.Value, "P") {
							RunSelected := false
							WalkSelected := true
							TextOnOffCtrlAuRun.Value := " OFF"
							MouseGetPos(&x, &y)
							SB.SetText("Ready.                        X:" . x . " Y:" . y )
							Send("{" . SprintKey . " up}")
							Send("{" . ButtonRT . " up}")
							if RadioScrlDownYes.Value == 1 {
								RadioScrlDownNo.Value := 0
								TextOnOffScrlDown.Value := " ON"
								Count := 0
								SB.SetText("Scroll down active. ScrlDown count: " Count)
								loop ScrlDownCount {
									Send("{WheelDown}")
									sleep ScrlDownInterval
									axis_info_Z := Round(GetKeyState(ControllerNumber "JoyZ"))
									if axis_info_Z < 45 {
										break
									}
									Count++
									SB.SetText("Scroll down active. ScrlDown count: " Count)
								}
								TextOnOffScrlDown.Value := " OFF"
								SB.SetText("Ready.                        X:" . x . " Y:" . y )
							}
							break
						} ; End JoyZ LT key
						Sleep AutoRunLoop
					} ; End AutoRun loop
				} ; End JoyZ RT key
			} ; End cont_info Z
		} ; End RadioCtrlAuRunYes
	} ; End Controller Available
	
	if ControllerAvailable == false {
		TextOnOffController.Value := " Controller Not Found"
		ControllerName.Value := " "
		RadioCtrlAuRunYes.Value := false
		RadioCtrlAuRunNo.Value := true
	} ; End Controller Not Available
	
	if SwitchClicker == true {
		if TextPatternClickerOnOff.Value == " ON" {
			SB.SetText("Auto Clicker Active.           X:" . x . " Y:" . y )
		} else {
			SB.SetText("Ready.                         X:" . x . " Y:" . y )
		}
	} else {
		SB.SetText("Ready.                         X:" . x . " Y:" . y )
	}
	Sleep GeneralLoopInterval		
} ; End General Loop
;----------------------------------------------------
; Very Short Jump
ProcessJumpHotkey0(*)
{
	if SecureMode == false {
		SecureModeOff
		return
	}
	SB.SetText("Very short jump active.")
	TextOnOff2.Value := " ON"
	Send("{shift down}")
	Send("{w down}")
	Sleep VeryShortJumpRace
	Send("{Space down}")
	Sleep VeryShortJumpLenght
	Send("{w up}")
	Send("{shift up}")
	Send("{Space up}")
	TextOnOff2.Value := " OFF"
	SB.SetText("Ready")
}
;----------------------------------------------------
; Short Jump
ProcessJumpHotkey1(*)
{	
	if SecureMode == false {
		SecureModeOff
		return
	}
	SB.SetText("Short jump active.")
	TextOnOff3.Value := " ON"
	Send("{shift down}")
	Send("{w down}")
	Sleep ShortJumpRace
	Send("{Space down}")
	Sleep ShortJumpLenght
	Send("{w up}")
	Send("{shift up}")
	Send("{Space up}")
	TextOnOff3.Value := " OFF"
	SB.SetText("Ready")
}
;----------------------------------------------------
; Normal Jump
ProcessJumpHotkey2(*)
{
	if SecureMode == false {
		SecureModeOff
		return
	}
	SB.SetText("Normal jump active.")
	TextOnOff4.Value := " ON"
	Send("{shift down}")
	Send("{w down}")
	Sleep NormalJumpRace
	Send("{Space down}")
	Sleep NormalJumpLenght
	Send("{w up}")
	Send("{shift up}")
	Send("{Space up}")
	TextOnOff4.Value := " OFF"
	SB.SetText("Ready")
}
;----------------------------------------------------
; Long Jump
ProcessJumpHotkey3(*)
{
	if SecureMode == false {
		SecureModeOff
		return
	}
	SB.SetText("Long jump active.")
	TextOnOff5.Value := " ON"
	Send("{shift down}")
	Send("{w down}")
	Sleep LongJumpRace
	Send("{Space down}")
	Sleep LongJumpLenght
	Send("{w up}")
	Send("{shift up}")
	Send("{Space up}")
	TextOnOff5.Value := " OFF"
	SB.SetText("Ready")
}
;----------------------------------------------------
; Very Long Jump 
ProcessJumpHotkey4(*)
{
	if SecureMode == false {
		SecureModeOff
		return
	}
	SB.SetText("Very long jump active.")
	TextOnOff6.Value := " ON"
	Send("{shift down}")
	Send("{w down}")
	Sleep VeryLongJumpRace
	Send("{Space down}")
	Sleep VeryLongJumpLenght
	Send("{w up}")
	Send("{shift up}")
	Send("{Space up}")
	TextOnOff6.Value := " OFF"
	SB.SetText("Ready")
}
;----------------------------------------------------
ProcessPatternClicker(*){
	Saved := GameToolGui.Submit(false)	
	if SecureMode == false {
		SecureModeOff
		return
	}
	static toggle := false
	static SendKey := Send.Bind('{Click}')
	;----------------------------------------------------
	if (toggle := !toggle){
		TextPatternClickerOnOff.Value := " ON"
		ClickInterval := Saved.ClickInterval
		RandomOffset := Saved.RandomOffset
		Count := 0
		LoopAmount := Saved.LoopAmount
		CoordX0 := Saved.CoordX0
		CoordY0 := Saved.CoordY0
		Coord0Interval := Saved.Coord0Interval
		
		CoordX1 := Saved.CoordX1
		CoordY1 := Saved.CoordY1
		Coord1Interval := Saved.Coord1Interval
		
		CoordX2 := Saved.CoordX2
		CoordY2 := Saved.CoordY2
		Coord2Interval := Saved.Coord2Interval
		
		CoordX3 := Saved.CoordX3
		CoordY3 := Saved.CoordY3
		Coord3Interval := Saved.Coord3Interval
		
		CoordX4 := Saved.CoordX4
		CoordY4 := Saved.CoordY4
		Coord4Interval := Saved.Coord4Interval
		
		Switch true {
		case RadioCountLoopsYes.Value:
			if RadioPos0Yes.Value == false and RadioPos1Yes.Value == false and RadioPos2Yes.Value == false and RadioPos3Yes.Value == false and RadioPos4Yes.Value == false {
				SB.SetText("Count Clicker Active. Count: " Count)
				Loop LoopAmount {
					if GetKeyState(StopPatternHotkey.Value, "P") {
						break
					} 
					SendKey
					Count++
					SB.SetText("Count Clicker Active. Count: " Count)
					sleep Random(ClickInterval, ClickInterval + RandomOffset) 
				}
			} else {
				SB.SetText("Count Pattern Clicker Active. Count: " Count)
				Loop LoopAmount {
					if RadioPos0Yes.Value == true {
						RadioPos0No.Value := false
						DllCall("SetCursorPos", "int", CoordX0, "int", CoordY0)
						SendKey
						sleep Coord0Interval
					}
					if GetKeyState(StopPatternHotkey.Value, "P") or 
						(RadioPos0No.Value == true and RadioPos1No.Value == true and RadioPos2No.Value == true and RadioPos3No.Value == true and RadioPos4No.Value == true) {
						break
					}
					if RadioPos1Yes.Value == true {
						RadioPos1No.Value := false
						DllCall("SetCursorPos", "int", CoordX1, "int", CoordY1)
						SendKey
						sleep Coord1Interval
					}
					if GetKeyState(StopPatternHotkey.Value, "P") or 
						(RadioPos0No.Value == true and RadioPos1No.Value == true and RadioPos2No.Value == true and RadioPos3No.Value == true and RadioPos4No.Value == true) {
						break
					}
					if RadioPos2Yes.Value == true {
						RadioPos2No.Value := false
						DllCall("SetCursorPos", "int", CoordX2, "int", CoordY2)
						SendKey
						sleep Coord2Interval
					}
					if GetKeyState(StopPatternHotkey.Value, "P") or 
						(RadioPos0No.Value == true and RadioPos1No.Value == true and RadioPos2No.Value == true and RadioPos3No.Value == true and RadioPos4No.Value == true) {
						break
					}
					if RadioPos3Yes.Value == true {
						RadioPos3No.Value := false
						DllCall("SetCursorPos", "int", CoordX3, "int", CoordY3)
						SendKey
						sleep Coord3Interval
					}
					if GetKeyState(StopPatternHotkey.Value, "P") or 
						(RadioPos0No.Value == true and RadioPos1No.Value == true and RadioPos2No.Value == true and RadioPos3No.Value == true and RadioPos4No.Value == true) {
						break
					}
					if RadioPos4Yes.Value == true {
						RadioPos4No.Value := false
						DllCall("SetCursorPos", "int", CoordX4, "int", CoordY4)
						SendKey
						sleep Coord4Interval
					}
					if GetKeyState(StopPatternHotkey.Value, "P") or 
						(RadioPos0No.Value == true and RadioPos1No.Value == true and RadioPos2No.Value == true and RadioPos3No.Value == true and RadioPos4No.Value == true) {
						break
					}
					Count++
					SB.SetText("Count Pattern Clicker Active. Count: " Count)
					sleep Random(ClickInterval, ClickInterval + RandomOffset)
				} ; End Loop
			}
			toggle := !toggle
			TextPatternClickerOnOff.Value := " OFF"
			return
		case RadioPos0Yes.Value == true, RadioPos1Yes.Value == true, RadioPos2Yes.Value == true, RadioPos3Yes.Value == true, RadioPos4Yes.Value == true:
			Loop {
				SB.SetText("Pattern Clicker Active.")
				if RadioPos0Yes.Value == true {
					RadioPos0No.Value := false
					DllCall("SetCursorPos", "int", CoordX0, "int", CoordY0)
					SendKey
					sleep Coord0Interval
				}
				if GetKeyState(StopPatternHotkey.Value, "P") or 
					(RadioPos0No.Value == true and RadioPos1No.Value == true and RadioPos2No.Value == true and RadioPos3No.Value == true and RadioPos4No.Value == true) {
					break
				}
				if RadioPos1Yes.Value == true {
					RadioPos1No.Value := false
					DllCall("SetCursorPos", "int", CoordX1, "int", CoordY1)
					SendKey
					sleep Coord1Interval
				}
				if GetKeyState(StopPatternHotkey.Value, "P") or 
					(RadioPos0No.Value == true and RadioPos1No.Value == true and RadioPos2No.Value == true and RadioPos3No.Value == true and RadioPos4No.Value == true) {
					break
				}
				if RadioPos2Yes.Value == true {
					RadioPos2No.Value := false
					DllCall("SetCursorPos", "int", CoordX2, "int", CoordY2)
					SendKey
					sleep Coord2Interval
				}
				if GetKeyState(StopPatternHotkey.Value, "P") or 
					(RadioPos0No.Value == true and RadioPos1No.Value == true and RadioPos2No.Value == true and RadioPos3No.Value == true and RadioPos4No.Value == true) {
					break
				}
				if RadioPos3Yes.Value == true {
					RadioPos3No.Value := false
					DllCall("SetCursorPos", "int", CoordX3, "int", CoordY3)
					SendKey
					sleep Coord3Interval
				}
				if GetKeyState(StopPatternHotkey.Value, "P") or 
					(RadioPos0No.Value == true and RadioPos1No.Value == true and RadioPos2No.Value == true and RadioPos3No.Value == true and RadioPos4No.Value == true) {
					break
				}
				if RadioPos4Yes.Value == true {
					RadioPos4No.Value := false
					DllCall("SetCursorPos", "int", CoordX4, "int", CoordY4)
					SendKey
					sleep Coord4Interval
				}
				if GetKeyState(StopPatternHotkey.Value, "P") or 
					(RadioPos0No.Value == true and RadioPos1No.Value == true and RadioPos2No.Value == true and RadioPos3No.Value == true and RadioPos4No.Value == true) {
					break
				}
			} ; End Loop
			toggle := !toggle
			TextPatternClickerOnOff.Value := " OFF"
			return
		Default:
			SB.SetText("Auto Clicker Active.")
			SetTimer(SendKey, Random(ClickInterval, ClickInterval + RandomOffset))
			return
		}
	} else {
		TextPatternClickerOnOff.Value := " OFF"
		SetTimer(SendKey, 0)
	}
}
;----------------------------------------------------
MenuHandlerExit(*){
	ExitApp()
}
;----------------------------------------------------
EditIniFileHandler(*) {
	run IniFile
}
;----------------------------------------------------
SuspendMenuHandler(*){
	SuspendHotkeys := IniRead(IniFile, "Properties", "SuspendHotkeys")
	SuspendHotkeys := !SuspendHotkeys
	IniWrite SuspendHotkeys, IniFile, "Properties", "SuspendHotkeys"
	if SuspendHotkeys == true {
		FileMenu.ToggleCheck("S&uspend Hotkeys`tCtrl+U")
	} else {
		FileMenu.Uncheck("S&uspend Hotkeys`tCtrl+U")
	}
	Suspend
}
;----------------------------------------------------
MenuHandlerQuickFix(*) {
	Send("{w up}")
	Send("{shift up}")
	Reload
}
;----------------------------------------------------
; Save to ini file and reload
SecureModeHandler(*) {
	SecureMode := IniRead(IniFile, "Properties", "SecureMode")
	SecureMode := !SecureMode
	IniWrite SecureMode, IniFile, "Properties", "SecureMode"
	Reload
}
EditBoxesHandler(*){
	EditBoxesAvailable := IniRead(IniFile, "Properties", "EditBoxesAvailable")
	EditBoxesAvailable := !EditBoxesAvailable
	IniWrite EditBoxesAvailable, IniFile, "Properties", "EditBoxesAvailable"
	Reload
}
;----------------------------------------------------
SwitchJumpsHandler(*){
	SwitchClicker := false
	SwitchJumps := true
	IniWrite SwitchJumps, IniFile, "Modules", "SwitchJumps"
	IniWrite SwitchClicker, IniFile, "Modules", "SwitchClicker"
	Reload
}
;----------------------------------------------------
SwitchClickerHandler(*){
	SwitchJumps := false
	SwitchClicker := true
	IniWrite SwitchJumps, IniFile, "Modules", "SwitchJumps"
	IniWrite SwitchClicker, IniFile, "Modules", "SwitchClicker"
	Reload
}
;----------------------------------------------------
SubmitJumpHotkey(*){
	Saved := GameToolGui.Submit(false)
	if GetKeyState("Shift", "P") {
		return
	}
	if Saved.JumpHotkey0 == "" or Saved.JumpHotkey1 == "" 
		or Saved.JumpHotkey2 == "" or Saved.JumpHotkey3 == ""
		or Saved.JumpHotkey4 == ""{
		return
	}
	IniWrite Saved.JumpHotkey0, IniFile, "SavedHotkey", "JumpHotkey0"
	IniWrite Saved.JumpHotkey1, IniFile, "SavedHotkey", "JumpHotkey1"
	IniWrite Saved.JumpHotkey2, IniFile, "SavedHotkey", "JumpHotkey2"
	IniWrite Saved.JumpHotkey3, IniFile, "SavedHotkey", "JumpHotkey3"
	IniWrite Saved.JumpHotkey4, IniFile, "SavedHotkey", "JumpHotkey4"
	Reload
}
;----------------------------------------------------
SubmitAutoRunHotkey(*){
	Saved := GameToolGui.Submit(false)
	if GetKeyState("Shift", "P") {
		return
	}
	; MsgBox "ini variable: " Saved.JumpHotkey0
	if Saved.StartAutoRunHotkey == "" or Saved.StopAutoRunHotKey == "" {
		return
	}
	IniWrite Saved.StartAutoRunHotkey, IniFile, "SavedHotkey", "StartAutoRunHotkey"
	IniWrite Saved.StopAutoRunHotKey, IniFile, "SavedHotkey", "StopAutoRunHotKey"
	Reload
}
;----------------------------------------------------
SubmitPatternClickerHotkey(*){
	if GetKeyState("Shift", "P") {
		return
	}
	Saved := GameToolGui.Submit(false)
	if Saved.PatternClickerHotkey == "" or Saved.StopPatternHotkey == "" {
		return
	}
	IniWrite Saved.PatternClickerHotkey, IniFile, "SavedHotkey", "PatternClickerHotkey"
	IniWrite Saved.StopPatternHotkey, IniFile, "SavedHotkey", "StopPatternHotkey"
	IniWrite Saved.ClickInterval, IniFile, "AutoClicker", "ClickInterval"
	IniWrite Saved.RandomOffset, IniFile, "AutoClicker", "RandomOffset"
	Reload
}
;----------------------------------------------------
SubmitValues(*){
	Saved := GameToolGui.Submit(false)
	if SwitchClicker == true {
		IniWrite Saved.ClickInterval, IniFile, "AutoClicker", "ClickInterval"
		IniWrite Saved.RandomOffset, IniFile, "AutoClicker", "RandomOffset"
		IniWrite Saved.LoopAmount, IniFile, "Properties", "LoopAmount"
		;----------------------------------------------------
		IniWrite Saved.CoordX0, IniFile, "CursorLocationClicker", "CoordX0"
		IniWrite Saved.CoordY0, IniFile, "CursorLocationClicker", "CoordY0"
		IniWrite Saved.Coord0Interval, IniFile, "CursorLocationClicker", "Coord0Interval"
		;----------------------------------------------------
		IniWrite Saved.CoordX1, IniFile, "CursorLocationClicker", "CoordX1"
		IniWrite Saved.CoordY1, IniFile, "CursorLocationClicker", "CoordY1"
		IniWrite Saved.Coord1Interval, IniFile, "CursorLocationClicker", "Coord1Interval"
		;----------------------------------------------------
		IniWrite Saved.CoordX2, IniFile, "CursorLocationClicker", "CoordX2"
		IniWrite Saved.CoordY2, IniFile, "CursorLocationClicker", "CoordY2"
		IniWrite Saved.Coord2Interval, IniFile, "CursorLocationClicker", "Coord2Interval"
		;----------------------------------------------------
		IniWrite Saved.CoordX3, IniFile, "CursorLocationClicker", "CoordX3"
		IniWrite Saved.CoordY3, IniFile, "CursorLocationClicker", "CoordY3"
		IniWrite Saved.Coord3Interval, IniFile, "CursorLocationClicker", "Coord3Interval"
		;----------------------------------------------------
		IniWrite Saved.CoordX4, IniFile, "CursorLocationClicker", "CoordX4"
		IniWrite Saved.CoordY4, IniFile, "CursorLocationClicker", "CoordY4"
		IniWrite Saved.Coord4Interval, IniFile, "CursorLocationClicker", "Coord4Interval"
		SaveMsg
	}
}
;----------------------------------------------------
CreateNewIniFile(*) {
	FileAppend "; NOTE: For all numpad keys, verify that NumLock key is activated / deactivated in order to trigger them.`n" , IniFile
	FileAppend ";--------------------------------------------------`n" , IniFile
	FileAppend "; HINT: If you delete this file or move it away from its forder,`n" , IniFile 
	FileAppend "; Task Automator will generate a new file on the spot.`n" , IniFile
	FileAppend ";--------------------------------------------------`n" , IniFile
	FileAppend "; WARNING 1: When asigning hotkeys, make sure none of them are the same as other asigned hotkeys.`n" , IniFile
	FileAppend ";--------------------------------------------------`n" , IniFile
	FileAppend "; WARNING 2: Don't set this file as read only!`n" , IniFile
	FileAppend ";--------------------------------------------------`n" , IniFile
	FileAppend "[Modules]`n" , IniFile
	FileAppend "SwitchJumps=0`n" , IniFile
	FileAppend "SwitchClicker=1`n" , IniFile
	FileAppend ";--------------------------------------------------`n" , IniFile
	FileAppend "[Properties]`n" , IniFile
	FileAppend "ExitMessageTimeWait=3000`n" , IniFile
	FileAppend "SecureMode=1`n" , IniFile
	FileAppend "EditBoxesAvailable=0`n" , IniFile
	FileAppend "SuspendHotkeys=0`n" , IniFile
	FileAppend "AutoRunLoop=100`n" , IniFile
	FileAppend "GeneralLoopInterval=100`n" , IniFile
	FileAppend "LoopAmount=100`n" , IniFile
	FileAppend "FirstRun=0`n" , IniFile
	FileAppend ";--------------------------------------------------`n" , IniFile
	FileAppend "[PaceProperties]`n" , IniFile
	FileAppend "ScrlUpCount=33`n" , IniFile
	FileAppend "ScrlUpInterval=150`n" , IniFile
	FileAppend "ScrlDownCount=33`n" , IniFile
	FileAppend "ScrlDownInterval=150`n" , IniFile
	FileAppend ";--------------------------------------------------`n" , IniFile
	FileAppend "[SavedHotkey]`n" , IniFile
	FileAppend "StartAutoRunHotkey=r`n" , IniFile
	FileAppend "StopAutoRunHotKey=t`n" , IniFile
	FileAppend "PatternClickerHotkey=Numpad8`n" , IniFile
	FileAppend "StopPatternHotkey=Numpad9`n" , IniFile
	FileAppend "JumpHotkey0=Numpad0`n" , IniFile
	FileAppend "JumpHotkey1=Numpad1`n" , IniFile
	FileAppend "JumpHotkey2=Numpad2`n" , IniFile
	FileAppend "JumpHotkey3=Numpad3`n" , IniFile
	FileAppend "JumpHotkey4=Numpad4`n" , IniFile
	FileAppend ";--------------------------------------------------`n" , IniFile
	FileAppend "[AutoRun]`n" , IniFile
	FileAppend "SprintKey=Shift`n" , IniFile
	FileAppend ";--------------------------------------------------`n" , IniFile
	FileAppend "[AutoRunKeyboard]`n" , IniFile
	FileAppend "ForwardKey=w`n" , IniFile
	FileAppend ";--------------------------------------------------`n" , IniFile
	FileAppend "[AutoRunController]`n" , IniFile
	FileAppend "ButtonRT=w`n" , IniFile
	FileAppend ";--------------------------------------------------`n" , IniFile
	FileAppend "[AutoClicker]`n" , IniFile
	FileAppend "ClickInterval=50`n" , IniFile
	FileAppend "RandomOffset=50`n" , IniFile
	FileAppend ";--------------------------------------------------`n" , IniFile
	FileAppend "[CursorLocationClicker]`n" , IniFile
	FileAppend "CoordX0=950`n" , IniFile
	FileAppend "CoordY0=240`n" , IniFile
	FileAppend "Coord0Interval=1000`n" , IniFile
	FileAppend ";-------------------------------`n" , IniFile
	FileAppend "CoordX1=950`n" , IniFile
	FileAppend "CoordY1=770`n" , IniFile
	FileAppend "Coord1Interval=1000`n" , IniFile
	FileAppend ";-------------------------------`n" , IniFile
	FileAppend "CoordX2=840`n" , IniFile
	FileAppend "CoordY2=474`n" , IniFile
	FileAppend "Coord2Interval=1000`n" , IniFile
	FileAppend ";-------------------------------`n" , IniFile
	FileAppend "CoordX3=1076`n" , IniFile
	FileAppend "CoordY3=474`n" , IniFile
	FileAppend "Coord3Interval=1000`n" , IniFile
	FileAppend ";-------------------------------`n" , IniFile
	FileAppend "CoordX4=949`n" , IniFile
	FileAppend "CoordY4=463`n" , IniFile
	FileAppend "Coord4Interval=1000`n" , IniFile
	FileAppend ";--------------------------------------------------`n" , IniFile
	FileAppend "[JumpProperties]`n" , IniFile
	FileAppend "VeryShortJumpRace=400`n" , IniFile
	FileAppend "VeryShortJumpLenght=500`n" , IniFile
	FileAppend ";-------------------------------`n" , IniFile
	FileAppend "ShortJumpRace=550`n" , IniFile
	FileAppend "ShortJumpLenght=500`n" , IniFile
	FileAppend ";-------------------------------`n" , IniFile
	FileAppend "NormalJumpRace=550`n" , IniFile
	FileAppend "NormalJumpLenght=600`n" , IniFile
	FileAppend ";-------------------------------`n" , IniFile
	FileAppend "LongJumpRace=550`n" , IniFile
	FileAppend "LongJumpLenght=700`n" , IniFile
	FileAppend ";-------------------------------`n" , IniFile
	FileAppend "VeryLongJumpRace=600`n" , IniFile
	FileAppend "VeryLongJumpLenght=750`n" , IniFile
}