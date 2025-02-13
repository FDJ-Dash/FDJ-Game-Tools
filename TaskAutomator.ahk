; ------------ Credits ------------
; Creator: Fernando Daniel Jaime.
; Programmer Alias: FDJ-Dash.
; Gamer Alias: Mean Little, Grey Dash, Dash.
; ------------ App Details ------------
; App Full Name: Mean Little's Task Automator.
; Description: This is an app aimed towards repetitive tasks like holding a button down for extended time,
; mouse clicks or even click patterns. Additionally it brings interchangeable modules like jumps
; for certain games and Quick access module to store and run any program in your computer or load
; a web page on your browser easily. 
; --------------------------------
#Requires Autohotkey v2
#SingleInstance
SetWorkingDir(A_ScriptDir)
Global IconLib := A_ScriptDir . "\Icons"
, ImageLib := A_ScriptDir . "\Images"
, HotkeyGuide := "https://mean-littles-app.gitbook.io/mean-littles-software"
, IniFile := A_ScriptDir . "\ML_TaskAutomator.ini"
, LicenseFile := A_ScriptDir . "\LicenseKey.ini"
, DataFile := A_Temp . "\MLTA_Data.ini"
, TempCleanFileMLTA := A_Temp . "\MLTA_CleanFile.ini"
, AppName := "ML Task Automator"
, CurrentVersion := "v1.4"
, MLSoftwareIcon := "\Logo-FDJ-Dash.png"
, DefaultMsgBackgroundImage := "\Lightning2.jpg"

AuxHkDataFile := A_Temp . "\MLTA_AuxHkData.ini"
ClikerStartInterval := 500
ClikerStopInterval := 1500
;----------------------------------------------------
; Read ini file
if !FileExist(IniFile) {
	CreateNewIniFile
}
;----------------------------------------------------
; Ini Read Font types
MainFontType := IniRead(IniFile, "FontType", "MainFontType")
MessageAppNameFontType := IniRead(IniFile, "FontType", "MessageAppNameFontType")
LicenseKeyFontType := IniRead(IniFile, "FontType", "LicenseKeyFontType")
MessageMainMsgFontType := IniRead(IniFile, "FontType", "MessageMainMsgFontType")
MessageFontType := IniRead(IniFile, "FontType", "MessageFontType")
;----------------------------------------------------
; Ini Read Font Colors
;-------------------------------
MainFontColor := "c"
MainFontColor .= IniRead(IniFile, "FontColors", "MainFontColor")
;-------------------------------
FontClickerPatternColor := "c0x"
FontClickerPatternColor .= IniRead(IniFile, "FontColors", "FontClickerPatternColor")
;-------------------------------
MessageAppNameFontColor := "c"
MessageAppNameFontColor .= IniRead(IniFile, "FontColors", "MessageAppNameFontColor")
;-------------------------------
MessageMainMsgFontColor := "c"
MessageMainMsgFontColor .= IniRead(IniFile, "FontColors", "MessageMainMsgFontColor")
;-------------------------------
MessageFontColor := "c"
MessageFontColor .= IniRead(IniFile, "FontColors", "MessageFontColor")
;-------------------------------
LicenseKeyFontColor := "c0x"
LicenseKeyFontColor .= IniRead(IniFile, "FontColors", "LicenseKeyFontColor")
;-------------------------------
; Ini Read Background
BackgroundMainColor := "Background"
BackgroundColor := IniRead(IniFile, "Background", "BackgroundColor")
BackgroundMainColor .= BackgroundColor
;-------------------------------
BackgroundPicture := IniRead(IniFile, "Background", "BackgroundPicture")
MessageBackgroundPicture := IniRead(IniFile, "Background", "MessageBackgroundPicture")
;----------------------------------------------------
; Ini Read Modules
SwitchKbAutoRun := IniRead(IniFile, "Modules", "SwitchKbAutoRun")
SwitchControllerAutoRun := IniRead(IniFile, "Modules", "SwitchControllerAutoRun")
SwitchTopModulesOFF := IniRead(IniFile, "Modules", "SwitchTopModulesOFF")
;-------------------------------
SwitchQuickAccess := IniRead(IniFile, "Modules", "SwitchQuickAccess")
QuickAccessButtons := IniRead(IniFile, "Modules", "QuickAccessButtons")
SwitchClicker := IniRead(IniFile, "Modules", "SwitchClicker")
SwitchJumps := IniRead(IniFile, "Modules", "SwitchJumps")
SwitchModulesOFF := IniRead(IniFile, "Modules", "SwitchModulesOFF")
;-------------------------------
if  SwitchJumps < 0 or SwitchJumps > 1 or
 SwitchClicker < 0 or SwitchClicker > 1  or SwitchQuickAccess < 0 or SwitchQuickAccess > 1 or 
 SwitchModulesOFF < 0 or SwitchModulesOFF > 1{
	SwitchQuickAccess := true
	SwitchClicker := false
	SwitchJumps := false
	SwitchModulesOFF := false
	IniWrite SwitchQuickAccess, IniFile, "Modules", "SwitchQuickAccess"
	IniWrite SwitchClicker, IniFile, "Modules", "SwitchClicker"
	IniWrite SwitchJumps, IniFile, "Modules", "SwitchJumps"
	IniWrite SwitchModulesOFF, IniFile, "Modules", "SwitchModulesOFF"
}
if QuickAccessButtons > 1 or QuickAccessButtons < 0 {
	QuickAccessButtons := 1
	IniWrite QuickAccessButtons, IniFile, "Modules", "QuickAccessButtons"
}
if SwitchKbAutoRun > 1 or SwitchKbAutoRun < 0 {
	SwitchKbAutoRun := 1
	IniWrite SwitchKbAutoRun, IniFile, "Modules", "SwitchKbAutoRun"
}
if SwitchControllerAutoRun > 1 or SwitchControllerAutoRun < 0 {
	SwitchControllerAutoRun := 1
	IniWrite SwitchControllerAutoRun, IniFile, "Modules", "SwitchControllerAutoRun"
}
if SwitchModulesOFF > 1 or SwitchModulesOFF < 0 {
	SwitchModulesOFF := 1
	IniWrite SwitchModulesOFF, IniFile, "Modules", "SwitchModulesOFF"
}
;----------------------------------------------------
; Read Ini Properties
ExitMessageTimeWait := IniRead(IniFile, "Properties", "ExitMessageTimeWait")
SuspendedHotkeysTimeWait := IniRead(IniFile, "Properties", "SuspendedHotkeysTimeWait")
HotkeyEditMode := IniRead(IniFile, "Properties", "HotkeyEditMode")
if HotkeyEditMode > 1 or HotkeyEditMode < 0 {
	HotkeyEditMode := 1
	IniWrite HotkeyEditMode, IniFile, "Properties", "HotkeyEditMode"
}
EditBoxesAvailable := IniRead(IniFile, "Properties", "EditBoxesAvailable")
if EditBoxesAvailable > 1 or EditBoxesAvailable < 0 {
	EditBoxesAvailable := 1
	IniWrite EditBoxesAvailable, IniFile, "Properties", "EditBoxesAvailable"
}
AutoRunLoopInterval := IniRead(IniFile, "Properties", "AutoRunLoopInterval")
if AutoRunLoopInterval < 0  {
	AutoRunLoopInterval := 0
	IniWrite AutoRunLoopInterval, IniFile, "Properties", "AutoRunLoopInterval"
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
GuiPriorityAlwaysOnTop := IniRead(IniFile, "Properties", "GuiPriorityAlwaysOnTop")
if GuiPriorityAlwaysOnTop < 0 or GuiPriorityAlwaysOnTop > 1 {
	GuiPriorityAlwaysOnTop := 0
	IniWrite GuiPriorityAlwaysOnTop, IniFile, "Properties", "GuiPriorityAlwaysOnTop"
}
PositionX := IniRead(IniFile, "Properties", "PositionX")
PositionY := IniRead(IniFile, "Properties", "PositionY")
if isInteger(PositionX) != true or PositionX == "" or PositionX == -32000 {
	PositionX := A_ScreenWidth / 2 - 200
}
if isInteger(PositionY) != true or PositionY == "" or PositionY == -32000 {
	PositionY := 150
}
ExitTaskAutomatorKey := IniRead(IniFile, "Properties", "ExitTaskAutomatorKey")
SuspendHotkeysKey := IniRead(IniFile, "Properties", "SuspendHotkeysKey")
;----------------------------------------------------
; Read ini Settings
CheckforUpdatesDaily := IniRead(IniFile, "Settings", "CheckforUpdatesDaily")
CheckforupdatesWeekly := IniRead(IniFile, "Settings", "CheckforupdatesWeekly")
NeverCheckForUpdates := IniRead(IniFile, "Settings", "NeverCheckForUpdates")
LastUpdateCheckTimeStamp := IniRead(IniFile, "Settings", "LastUpdateCheckTimeStamp")
NeedUpdate := IniRead(IniFile, "Settings", "NeedUpdate")
switch true {
case CheckforUpdatesDaily == true:
	CheckforupdatesWeekly := false
	NeverCheckForUpdates := false
case CheckforupdatesWeekly == true:
	CheckforUpdatesDaily := false
	NeverCheckForUpdates := false
case NeverCheckForUpdates == true:
	CheckforUpdatesDaily := false
	CheckforupdatesWeekly := false
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
switch true {
case StartAutoRunHotkey == "+":
	StartAutoRunHotkey := "Shift"
	IniWrite StartAutoRunHotkey, IniFile, "SavedHotkey", "StartAutoRunHotkey"
case StartAutoRunHotkey == "!":
	StartAutoRunHotkey := "Alt"
	IniWrite StartAutoRunHotkey, IniFile, "SavedHotkey", "StartAutoRunHotkey"
case StartAutoRunHotkey == "^":
	StartAutoRunHotkey := "Ctrl"
	IniWrite StartAutoRunHotkey, IniFile, "SavedHotkey", "StartAutoRunHotkey"
}
switch true {
case StopAutoRunHotKey == "+":
	StopAutoRunHotKey := "Shift"
	IniWrite StopAutoRunHotKey, IniFile, "SavedHotkey", "StopAutoRunHotKey"
case StopAutoRunHotKey == "!":
	StopAutoRunHotKey := "Alt"
	IniWrite StopAutoRunHotKey, IniFile, "SavedHotkey", "StopAutoRunHotKey"
case StopAutoRunHotKey == "^":
	StopAutoRunHotKey := "Ctrl"
	IniWrite StopAutoRunHotKey, IniFile, "SavedHotkey", "StopAutoRunHotKey"
}
;-------------------------------
PatternClickerHotkey := IniRead(IniFile, "SavedHotkey", "PatternClickerHotkey")
switch true {
case PatternClickerHotkey == "+":
	PatternClickerHotkey := "Shift"
	IniWrite PatternClickerHotkey, IniFile, "SavedHotkey", "PatternClickerHotkey"
case PatternClickerHotkey == "!":
	PatternClickerHotkey := "Alt"
	IniWrite PatternClickerHotkey, IniFile, "SavedHotkey", "PatternClickerHotkey"
case PatternClickerHotkey == "^":
	PatternClickerHotkey := "Ctrl"
	IniWrite PatternClickerHotkey, IniFile, "SavedHotkey", "PatternClickerHotkey"
}
;-------------------------------
JumpHotkey0 := IniRead(IniFile, "SavedHotkey", "JumpHotkey0")
JumpHotkey1 := IniRead(IniFile, "SavedHotkey", "JumpHotkey1")
JumpHotkey2 := IniRead(IniFile, "SavedHotkey", "JumpHotkey2")
JumpHotkey3 := IniRead(IniFile, "SavedHotkey", "JumpHotkey3")
JumpHotkey4 := IniRead(IniFile, "SavedHotkey", "JumpHotkey4")
switch true {
case JumpHotkey0 == "+":
	JumpHotkey0 := "Shift"
	IniWrite JumpHotkey0, IniFile, "SavedHotkey", "JumpHotkey0"
case JumpHotkey0 == "!":
	JumpHotkey0 := "Alt"
	IniWrite JumpHotkey0, IniFile, "SavedHotkey", "JumpHotkey0"
case JumpHotkey0 == "^":
	JumpHotkey0 := "Ctrl"
	IniWrite JumpHotkey0, IniFile, "SavedHotkey", "JumpHotkey0"
}
switch true {
case JumpHotkey1 == "+":
	JumpHotkey1 := "Shift"
	IniWrite JumpHotkey1, IniFile, "SavedHotkey", "JumpHotkey1"
case JumpHotkey1 == "!":
	JumpHotkey1 := "Alt"
	IniWrite JumpHotkey1, IniFile, "SavedHotkey", "JumpHotkey1"
case JumpHotkey1 == "^":
	JumpHotkey1 := "Ctrl"
	IniWrite JumpHotkey1, IniFile, "SavedHotkey", "JumpHotkey1"
}
switch true {
case JumpHotkey2 == "+":
	JumpHotkey2 := "Shift"
	IniWrite JumpHotkey2, IniFile, "SavedHotkey", "JumpHotkey2"
case JumpHotkey2 == "!":
	JumpHotkey2 := "Alt"
	IniWrite JumpHotkey2, IniFile, "SavedHotkey", "JumpHotkey2"
case JumpHotkey2 == "^":
	JumpHotkey2 := "Ctrl"
	IniWrite JumpHotkey2, IniFile, "SavedHotkey", "JumpHotkey2"
}
switch true {
case JumpHotkey3 == "+":
	JumpHotkey3 := "Shift"
	IniWrite JumpHotkey3, IniFile, "SavedHotkey", "JumpHotkey3"
case JumpHotkey3 == "!":
	JumpHotkey3 := "Alt"
	IniWrite JumpHotkey3, IniFile, "SavedHotkey", "JumpHotkey3"
case JumpHotkey3 == "^":
	JumpHotkey3 := "Ctrl"
	IniWrite JumpHotkey3, IniFile, "SavedHotkey", "JumpHotkey3"
}
switch true {
case JumpHotkey4 == "+":
	JumpHotkey4 := "Shift"
	IniWrite JumpHotkey4, IniFile, "SavedHotkey", "JumpHotkey4"
case JumpHotkey4 == "!":
	JumpHotkey4 := "Alt"
	IniWrite JumpHotkey4, IniFile, "SavedHotkey", "JumpHotkey4"
case JumpHotkey4 == "^":
	JumpHotkey4 := "Ctrl"
	IniWrite JumpHotkey4, IniFile, "SavedHotkey", "JumpHotkey4"
}
;-------------------------------
QuickAccessHk1 := IniRead(IniFile, "SavedHotkey", "QuickAccessHk1")
QuickAccessHk2 := IniRead(IniFile, "SavedHotkey", "QuickAccessHk2")
QuickAccessHk3 := IniRead(IniFile, "SavedHotkey", "QuickAccessHk3")
QuickAccessHk4 := IniRead(IniFile, "SavedHotkey", "QuickAccessHk4")
QuickAccessHk5 := IniRead(IniFile, "SavedHotkey", "QuickAccessHk5")
QuickAccessHk6 := IniRead(IniFile, "SavedHotkey", "QuickAccessHk6")
QuickAccessHk7 := IniRead(IniFile, "SavedHotkey", "QuickAccessHk7")
QuickAccessHk8 := IniRead(IniFile, "SavedHotkey", "QuickAccessHk8")
QuickAccessHk9 := IniRead(IniFile, "SavedHotkey", "QuickAccessHk9")

switch true {
case QuickAccessHk1 == "+":
	QuickAccessHk1 := "Shift"
	IniWrite QuickAccessHk1, IniFile, "SavedHotkey", "QuickAccessHk1"
case QuickAccessHk1 == "!":
	QuickAccessHk1 := "Alt"
	IniWrite QuickAccessHk1, IniFile, "SavedHotkey", "QuickAccessHk1"
case QuickAccessHk1 == "^":
	QuickAccessHk1 := "Ctrl"
	IniWrite QuickAccessHk1, IniFile, "SavedHotkey", "QuickAccessHk1"
}
switch true {
case QuickAccessHk2 == "+":
	QuickAccessHk2 := "Shift"
	IniWrite QuickAccessHk2, IniFile, "SavedHotkey", "QuickAccessHk2"
case QuickAccessHk2 == "!":
	QuickAccessHk2 := "Alt"
	IniWrite QuickAccessHk2, IniFile, "SavedHotkey", "QuickAccessHk2"
case QuickAccessHk2 == "^":
	QuickAccessHk2 := "Ctrl"
	IniWrite QuickAccessHk2, IniFile, "SavedHotkey", "QuickAccessHk2"
}
switch true {
case QuickAccessHk3 == "+":
	QuickAccessHk3 := "Shift"
	IniWrite QuickAccessHk3, IniFile, "SavedHotkey", "QuickAccessHk3"
case QuickAccessHk3 == "!":
	QuickAccessHk3 := "Alt"
	IniWrite QuickAccessHk3, IniFile, "SavedHotkey", "QuickAccessHk3"
case QuickAccessHk3 == "^":
	QuickAccessHk3 := "Ctrl"
	IniWrite QuickAccessHk3, IniFile, "SavedHotkey", "QuickAccessHk3"
}
switch true {
case QuickAccessHk4 == "+":
	QuickAccessHk4 := "Shift"
	IniWrite QuickAccessHk4, IniFile, "SavedHotkey", "QuickAccessHk4"
case QuickAccessHk4 == "!":
	QuickAccessHk4 := "Alt"
	IniWrite QuickAccessHk4, IniFile, "SavedHotkey", "QuickAccessHk4"
case QuickAccessHk4 == "^":
	QuickAccessHk4 := "Ctrl"
	IniWrite QuickAccessHk4, IniFile, "SavedHotkey", "QuickAccessHk4"
}
switch true {
case QuickAccessHk5 == "+":
	QuickAccessHk5 := "Shift"
	IniWrite QuickAccessHk5, IniFile, "SavedHotkey", "QuickAccessHk5"
case QuickAccessHk5 == "!":
	QuickAccessHk5 := "Alt"
	IniWrite QuickAccessHk5, IniFile, "SavedHotkey", "QuickAccessHk5"
case QuickAccessHk5 == "^":
	QuickAccessHk5 := "Ctrl"
	IniWrite QuickAccessHk5, IniFile, "SavedHotkey", "QuickAccessHk5"
}
switch true {
case QuickAccessHk6 == "+":
	QuickAccessHk6 := "Shift"
	IniWrite QuickAccessHk6, IniFile, "SavedHotkey", "QuickAccessHk6"
case QuickAccessHk6 == "!":
	QuickAccessHk6 := "Alt"
	IniWrite QuickAccessHk6, IniFile, "SavedHotkey", "QuickAccessHk6"
case QuickAccessHk6 == "^":
	QuickAccessHk6 := "Ctrl"
	IniWrite QuickAccessHk6, IniFile, "SavedHotkey", "QuickAccessHk6"
}
switch true {
case QuickAccessHk7 == "+":
	QuickAccessHk7 := "Shift"
	IniWrite QuickAccessHk7, IniFile, "SavedHotkey", "QuickAccessHk7"
case QuickAccessHk7 == "!":
	QuickAccessHk7 := "Alt"
	IniWrite QuickAccessHk7, IniFile, "SavedHotkey", "QuickAccessHk7"
case QuickAccessHk7 == "^":
	QuickAccessHk7 := "Ctrl"
	IniWrite QuickAccessHk7, IniFile, "SavedHotkey", "QuickAccessHk7"
}
switch true {
case QuickAccessHk8 == "+":
	QuickAccessHk8 := "Shift"
	IniWrite QuickAccessHk8, IniFile, "SavedHotkey", "QuickAccessHk8"
case QuickAccessHk8 == "!":
	QuickAccessHk8 := "Alt"
	IniWrite QuickAccessHk8, IniFile, "SavedHotkey", "QuickAccessHk8"
case QuickAccessHk8 == "^":
	QuickAccessHk8 := "Ctrl"
	IniWrite QuickAccessHk8, IniFile, "SavedHotkey", "QuickAccessHk8"
}
switch true {
case QuickAccessHk9 == "+":
	QuickAccessHk9 := "Shift"
	IniWrite QuickAccessHk9, IniFile, "SavedHotkey", "QuickAccessHk9"
case QuickAccessHk9 == "!":
	QuickAccessHk9 := "Alt"
	IniWrite QuickAccessHk9, IniFile, "SavedHotkey", "QuickAccessHk9"
case QuickAccessHk9 == "^":
	QuickAccessHk9 := "Ctrl"
	IniWrite QuickAccessHk9, IniFile, "SavedHotkey", "QuickAccessHk9"
}
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
;-------------------------------
CoordX5 := IniRead(IniFile, "CursorLocationClicker", "CoordX5")
CoordY5 := IniRead(IniFile, "CursorLocationClicker", "CoordY5")
Coord5Interval := IniRead(IniFile, "CursorLocationClicker", "Coord5Interval")
;-------------------------------
CoordX6 := IniRead(IniFile, "CursorLocationClicker", "CoordX6")
CoordY6 := IniRead(IniFile, "CursorLocationClicker", "CoordY6")
Coord6Interval := IniRead(IniFile, "CursorLocationClicker", "Coord6Interval")
;--------------------------------------------------
; Read ini QuickAccessPath
QuickAccess1 := IniRead(IniFile, "QuickAccessPath", "QuickAccess1")
QuickAccess2 := IniRead(IniFile, "QuickAccessPath", "QuickAccess2")
QuickAccess3 := IniRead(IniFile, "QuickAccessPath", "QuickAccess3")
QuickAccess4 := IniRead(IniFile, "QuickAccessPath", "QuickAccess4")
QuickAccess5 := IniRead(IniFile, "QuickAccessPath", "QuickAccess5")
QuickAccess6 := IniRead(IniFile, "QuickAccessPath", "QuickAccess6")
QuickAccess7 := IniRead(IniFile, "QuickAccessPath", "QuickAccess7")
QuickAccess8 := IniRead(IniFile, "QuickAccessPath", "QuickAccess8")
QuickAccess9 := IniRead(IniFile, "QuickAccessPath", "QuickAccess9")
;--------------------------------------------------
; Read ini QuickAccessIcons
QuickIcon1 := IniRead(IniFile, "QuickAccessIcons", "QuickIcon1")
QuickIcon2 := IniRead(IniFile, "QuickAccessIcons", "QuickIcon2")
QuickIcon3 := IniRead(IniFile, "QuickAccessIcons", "QuickIcon3")
QuickIcon4 := IniRead(IniFile, "QuickAccessIcons", "QuickIcon4")
QuickIcon5 := IniRead(IniFile, "QuickAccessIcons", "QuickIcon5")
QuickIcon6 := IniRead(IniFile, "QuickAccessIcons", "QuickIcon6")
QuickIcon7 := IniRead(IniFile, "QuickAccessIcons", "QuickIcon7")
QuickIcon8 := IniRead(IniFile, "QuickAccessIcons", "QuickIcon8")
QuickIcon9 := IniRead(IniFile, "QuickAccessIcons", "QuickIcon9")
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
TopPicture := IniRead(IniFile, "Pictures", "TopPicture")
BottomPicture := IniRead(IniFile, "Pictures", "BottomPicture")
; ;----------------------------------------------------
; GUI Properties
if GuiPriorityAlwaysOnTop == true {
	TaskAutomatorGui := Gui("+AlwaysOnTop")
} else {
	TaskAutomatorGui := Gui()
}
TaskAutomatorGui.Opt("+MinimizeBox +OwnDialogs -Theme")
TaskAutomatorGui.SetFont("Bold " . MainFontColor, MainFontType)
TaskAutomatorGui.BackColor := "0x" . BackgroundColor
if BackgroundPicture == "" {
	try {
		TaskAutomatorGui.Add("Picture", "x-16 y0 w304 h712", ImageLib . "\Lightning1.jpg")
	}
	catch {
	}
} else {
	try {
		TaskAutomatorGui.Add("Picture", "x0 y0 w250 h590", BackgroundPicture)
	}
	catch {
		BackgroundPicture := ""
		IniWrite BackgroundPicture, IniFile, "Background", "BackgroundPicture"
		Reload
	}
}
;----------------------------------------------------
; Setup Menu
MenuBar_Storage := MenuBar()
;-------------------------------
FileMenu := Menu()
MenuBar_Storage.Add("&File", FileMenu)
FileMenu.Add("Suspend Hotkeys`t" . SuspendHotkeysKey,SuspendMenuHandler)
FileMenu.Insert()
FileMenu.Add("Exit`t" . ExitTaskAutomatorKey,MenuHandlerExit)
try {
	FileMenu.SetIcon("Suspend Hotkeys`t" . SuspendHotkeysKey,IconLib . "\stop.ico")
	FileMenu.SetIcon("Exit`t" . ExitTaskAutomatorKey,IconLib . "\exit.ico")
}
catch {
}
;-------------------------------
OptionsMenu := Menu()
MenuBar_Storage.Add("&Options", OptionsMenu)
OptionsMenu.Add("Switch Hotkey Edit Mode: On/Off", HotkeyEditModeHandler)
OptionsMenu.Add("Switch Secure Edit &Boxes && Icons: On/Off", EditBoxesHandler)
OptionsMenu.Insert()
OptionsMenu.Add("Edit &Ini File", EditIniFileHandler)
OptionsMenu.Insert()
OptionsMenu.Add("Switch &Keyboard Autorun ON/OFF", KbAutoRunOFFHandler)
OptionsMenu.Add("Switch Con&troller Autorun ON/OFF", ControllerAutoRunOFFHandler)
OptionsMenu.Add("Switch Top Mod&ules OFF", SwitchTopModulesOFFHandler)
OptionsMenu.Insert()
OptionsMenu.Add("1. Switch Quick &Access", QuickAccessHandler)
OptionsMenu.Add("1b. Switch &Quick Access Hotkeys/Buttons", QuickAccessButtonsHandler)
OptionsMenu.Add("2. Switch &Clicker", SwitchClickerHandler)
OptionsMenu.Add("3. Switch &Jumps", SwitchJumpsHandler)
OptionsMenu.Add("4. Switch Bottom Mo&dules OFF", SwitchBottomModulesOFFHandler)
OptionsMenu.Insert()
OptionsMenu.Add("Change Background &Image", ChangeBackgroundHandler)
OptionsMenu.Add("Change M&essage Background Image", ChangeMessageBackgroundHandler)
OptionsMenu.Insert()
OptionsMenu.Add("&Always On Top: ON/OFF", GuiPriorityAlwaysOnTopHandler)
try {
	if EditBoxesAvailable == true {
		OptionsMenu.SetIcon("Switch Secure Edit &Boxes && Icons: On/Off", IconLib . "\EditBox2.png")
	} else {
		OptionsMenu.SetIcon("Switch Secure Edit &Boxes && Icons: On/Off", IconLib . "\EditBox1.png")
	}
	if HotkeyEditMode == true {
		OptionsMenu.SetIcon("Switch Hotkey Edit Mode: On/Off", IconLib . "\Locked.ico")
	} else {
		OptionsMenu.SetIcon("Switch Hotkey Edit Mode: On/Off", IconLib . "\Unlocked.png")
	}
	OptionsMenu.SetIcon("Switch &Keyboard Autorun ON/OFF", IconLib . "\Switch2.ico")
	OptionsMenu.SetIcon("Switch Con&troller Autorun ON/OFF", IconLib . "\Switch2.ico")
	OptionsMenu.SetIcon("Switch Top Mod&ules OFF", IconLib . "\Switch2.ico")
	OptionsMenu.SetIcon("Edit &Ini File", IconLib . "\File.ico")
	OptionsMenu.SetIcon("1. Switch Quick &Access", IconLib . "\Switch2.ico")
	OptionsMenu.SetIcon("1b. Switch &Quick Access Hotkeys/Buttons", IconLib . "\Switch2.ico")
	OptionsMenu.SetIcon("2. Switch &Clicker", IconLib . "\Switch2.ico")
	OptionsMenu.SetIcon("3. Switch &Jumps", IconLib . "\Switch2.ico")
	OptionsMenu.SetIcon("4. Switch Bottom Mo&dules OFF", IconLib . "\Switch2.ico")
	OptionsMenu.SetIcon("Change Background &Image", IconLib . "\ChangeBackground.png")
	OptionsMenu.SetIcon("Change M&essage Background Image", IconLib . "\ChangeBackground.png")
	OptionsMenu.SetIcon("&Always On Top: ON/OFF", IconLib . "\Switch2.ico")
}
catch {
}
;-------------------------------
SettingsMenu := Menu()
MenuBar_Storage.Add("&Settings", SettingsMenu)
SettingsMenu.Add("Check for updates &daily", MenuHandlerCheckUptDaily)
SettingsMenu.Add("Check for updates &weekly", MenuHandlerCheckUptWeekly)
SettingsMenu.Add("&Never check for updates", MenuHandlerNeverCheckUpt)

try {
	SettingsMenu.SetIcon("Check for updates &daily", IconLib . "\CheckDaily.png")
	SettingsMenu.SetIcon("Check for updates &weekly", IconLib . "\CheckWeekly.png")
	SettingsMenu.SetIcon("&Never check for updates", IconLib . "\stop.ico")
}
catch {
}
;-------------------------------
HelpMenu := Menu()
MenuBar_Storage.Add("&Help", HelpMenu)
HelpMenu.Add("Guide", MenuHandlerGuide)
HelpMenu.Add("Quick Fix", MenuHandlerQuickFix)
HelpMenu.Insert()
HelpMenu.Add("Update", MenuHandlerUpdate)
HelpMenu.Insert()
HelpMenu.Add("About", MenuHandlerAbout)

try {
	HelpMenu.SetIcon("Guide", IconLib . "\Logo-MLTA.ico")
	HelpMenu.SetIcon("Quick Fix", IconLib . "\Fix.ico")
	HelpMenu.SetIcon("Update", IconLib . "\Update.png")
	HelpMenu.SetIcon("About", IconLib . "\info.ico")
}
catch {
}
TaskAutomatorGui.MenuBar := MenuBar_Storage
;----------------------------------------------------
if GuiPriorityAlwaysOnTop == true {
	OptionsMenu.SetIcon("&Always On Top: ON/OFF", IconLib . "\Switch1.ico")
} else {
	OptionsMenu.SetIcon("&Always On Top: ON/OFF", IconLib . "\Switch2.ico")
}
;----------------------------------------------------
; Keyboard AutoRun
if SwitchKbAutoRun == false {
	OptionsMenu.SetIcon("Switch &Keyboard Autorun ON/OFF", IconLib . "\Switch2.ico")
} else {
	TaskAutomatorGui.Add("Text", "x10 y10 h20 +0x200", " Kb. AutoRun ")
	TextOnOff1 := TaskAutomatorGui.Add("Text","x105 y10 h20 +0x200", " OFF ")
	TaskAutomatorGui.Add("Text", "x10 y35 h20 +0x200", " Stop AutoRun ")
	OptionsMenu.SetIcon("Switch &Keyboard Autorun ON/OFF", IconLib . "\Switch1.ico")
	if HotkeyEditMode == true {
		if FileExist(AuxHkDataFile){
			try {
				FileDelete AuxHkDataFile
			}
			catch {
			}
		}
		try {
			OptionsMenu.SetIcon("Switch Secure &Mode: On/Off", IconLib . "\Locked.ico")
		}
		catch {
		}
		StartAutoRunHotkey := TaskAutomatorGui.Add("Hotkey", "vStartAutoRunHotkey x150 y10 w90 h20 +disabled", StartAutoRunHotkey)
		StopAutoRunHotKey := TaskAutomatorGui.Add("Hotkey", "vStopAutoRunHotKey x150 y35 w90 h20 +disabled", StopAutoRunHotKey)
	} else {
		try {
			OptionsMenu.SetIcon("Switch Secure &Mode: On/Off", IconLib . "\Unlocked.ico")
		}
		catch {
		}
		if !FileExist(AuxHkDataFile) {
			CreateNewAuxHkDataFile()
		}
		
		CtrlStartAutoRunHotkey := IniRead(AuxHkDataFile, "CtrlHkFlags", "CtrlStartAutoRunHotkey")
		AltStartAutoRunHotkey := IniRead(AuxHkDataFile, "AltHkFlags", "AltStartAutoRunHotkey")
		ShiftStartAutoRunHotkey := IniRead(AuxHkDataFile, "ShiftHkFlags", "ShiftStartAutoRunHotkey")
		switch true {
		case CtrlStartAutoRunHotkey == 1:
			if StartAutoRunHotkey == "" {
				StartAutoRunHotkey := "Ctrl"
				IniWrite StartAutoRunHotkey, IniFile, "SavedHotkey", "StartAutoRunHotkey"
			}
			CtrlStartAutoRunHotkey := 0
			IniWrite CtrlStartAutoRunHotkey, AuxHkDataFile, "CtrlHkFlags", "CtrlStartAutoRunHotkey"
		case AltStartAutoRunHotkey == 1:
			if StartAutoRunHotkey == "" {
				StartAutoRunHotkey := "Alt"
				IniWrite StartAutoRunHotkey, IniFile, "SavedHotkey", "StartAutoRunHotkey"
			}
			AltStartAutoRunHotkey := 0
			IniWrite AltStartAutoRunHotkey, AuxHkDataFile, "AltHkFlags", "AltStartAutoRunHotkey"
		case ShiftStartAutoRunHotkey == 1:
			if StartAutoRunHotkey == "" {
				StartAutoRunHotkey := "Shift"
				IniWrite StartAutoRunHotkey, IniFile, "SavedHotkey", "StartAutoRunHotkey"
			}
			ShiftStartAutoRunHotkey := 0
			IniWrite ShiftStartAutoRunHotkey, AuxHkDataFile, "ShiftHkFlags", "ShiftStartAutoRunHotkey" 
		case StartAutoRunHotkey == "":
			StartAutoRunHotkey := "Space"
			IniWrite StartAutoRunHotkey, IniFile, "SavedHotkey", "StartAutoRunHotkey"
		}
		
		CtrlStopAutoRunHotKey := IniRead(AuxHkDataFile, "CtrlHkFlags", "CtrlStopAutoRunHotKey")
		AltStopAutoRunHotKey := IniRead(AuxHkDataFile, "AltHkFlags", "AltStopAutoRunHotKey")
		ShiftStopAutoRunHotKey := IniRead(AuxHkDataFile, "ShiftHkFlags", "ShiftStopAutoRunHotKey")
		switch true {
		case CtrlStopAutoRunHotKey == 1:
			if StopAutoRunHotKey == "" {
				StopAutoRunHotKey := "Ctrl"
				IniWrite StopAutoRunHotKey, IniFile, "SavedHotkey", "StopAutoRunHotKey"
			}
			CtrlStopAutoRunHotKey := 0
			IniWrite CtrlStopAutoRunHotKey, AuxHkDataFile, "CtrlHkFlags", "CtrlStopAutoRunHotKey"
		case AltStopAutoRunHotKey == 1:
			if StopAutoRunHotKey == "" {
				StopAutoRunHotKey := "Alt"
				IniWrite StopAutoRunHotKey, IniFile, "SavedHotkey", "StopAutoRunHotKey"
			}
			AltStopAutoRunHotKey := 0
			IniWrite AltStopAutoRunHotKey, AuxHkDataFile, "AltHkFlags", "AltStopAutoRunHotKey"
		case ShiftStopAutoRunHotKey == 1:
			if StopAutoRunHotKey == "" {
				StopAutoRunHotKey := "Shift"
				IniWrite StopAutoRunHotKey, IniFile, "SavedHotkey", "StopAutoRunHotKey"
			}
			ShiftStopAutoRunHotKey := 0
			IniWrite ShiftStopAutoRunHotKey, AuxHkDataFile, "ShiftHkFlags", "ShiftStopAutoRunHotKey" 
		case StopAutoRunHotKey == "":
			StopAutoRunHotKey := "Space"
			IniWrite StopAutoRunHotKey, IniFile, "SavedHotkey", "StopAutoRunHotKey"
		}
		; compare both hotkeys
		if StartAutoRunHotkey == StopAutoRunHotKey {
			LicenseKeyInFile := IniRead(LicenseFile, "Data", "LicenseKey")
			DuplicatedHotkeyValue()
			StartAutoRunHotkey := "r"
			StopAutoRunHotKey := "t"
			IniWrite StartAutoRunHotkey, IniFile, "SavedHotkey", "StartAutoRunHotkey"
			IniWrite StopAutoRunHotKey, IniFile, "SavedHotkey", "StopAutoRunHotKey"
		}
		
		StartAutoRunHotkey := TaskAutomatorGui.Add("Hotkey", "vStartAutoRunHotkey x150 y10 w90 h20", StartAutoRunHotkey).OnEvent("Change", SubmitAutoRunHotkey)
		StopAutoRunHotKey := TaskAutomatorGui.Add("Hotkey", "vStopAutoRunHotKey x150 y35 w90 h20", StopAutoRunHotKey).OnEvent("Change", SubmitStopAutoRunHotkey)
	}
}

if SwitchKbAutoRun == false and SwitchControllerAutoRun == false {
	try {
		OptionsMenu.SetIcon("Switch Top Mod&ules OFF", IconLib . "\Switch1.ico")
	}
	catch {
	}
	if EditBoxesAvailable == true {
		try {
			TaskAutomatorGui.Add("Picture", "x9 y7 w230 h205 +border", TopPicture).OnEvent("Click", SelectTopPicture)
		}
		catch {
			TopPicture := ""
			IniWrite TopPicture, IniFile, "Pictures", "TopPicture"
			Reload
		}
	} else {
		try {
			TaskAutomatorGui.Add("Picture", "x9 y7 w230 h205 +border", TopPicture)
		}
		catch {
			TopPicture := ""
			IniWrite TopPicture, IniFile, "Pictures", "TopPicture"
			Reload
		}
	}
} else {
	try {
		OptionsMenu.SetIcon("Switch Top Mod&ules OFF", IconLib . "\Switch2.ico")
	}
	catch {
	}
	;----------------------------------------------------
	TaskAutomatorGui.Add("Text", "x1 y60 w250 h2 +0x10") ; Separator
	;----------------------------------------------------
	; Auto Scroll Up
	TextScrlUp := TaskAutomatorGui.Add("Text","x10 y66 w110 h20 +0x200", " Auto Scroll up")
	RadioScrlUpYes := TaskAutomatorGui.Add("Radio", "x10 y91 w30 h20", "Y")
	RadioScrlUpNo := TaskAutomatorGui.Add("Radio", "x45 y91 w30 h20 +Checked", "N")
	TextOnOffScrlUp := TaskAutomatorGui.Add("Text","x90 y91 w30 h20 +0x200", " OFF")
	;----------------------------------------------------
	; Auto Scroll Down
	TextScrlDown := TaskAutomatorGui.Add("Text","x130 y66 w110 h20 +0x200", " Auto Scroll down")
	RadioScrlDownYes := TaskAutomatorGui.Add("Radio", "x130 y91 w30 h20", "Y")
	RadioScrlDownNo := TaskAutomatorGui.Add("Radio", "x165 y91 w30 h20 +Checked", "N")
	TextOnOffScrlDown := TaskAutomatorGui.Add("Text","x210 y91 w30 h20 +0x200", " OFF")
	
	;----------------------------------------------------
	TaskAutomatorGui.Add("Text", "x1 y116 w250 h2 +0x10") ; Separator
	;----------------------------------------------------
}

; Controller
if SwitchControllerAutoRun == false {
	OptionsMenu.SetIcon("Switch Con&troller Autorun ON/OFF", IconLib . "\Switch2.ico")
	
	RadioCtrlAuRunYes := false
	RadioCtrlAuRunNo := true
} else {
	OptionsMenu.SetIcon("Switch Con&troller Autorun ON/OFF", IconLib . "\Switch1.ico")
	TaskAutomatorGui.Add("Text","x10 y122 h20 +0x200", " Controller: ")
	TextOnOffController := TaskAutomatorGui.Add("Text","x85 y122 w155 h20 +0x200", " Controller Not Found")
	ControllerName := TaskAutomatorGui.Add("Text","x10 y147 w230 h20 +0x200", " ")
	;----------------------------------------------------
	; Controller AutoRun
	TaskAutomatorGui.Add("Text","x10 y172 w110 h20 +0x200", " Controller AutoRun:")
	RadioCtrlAuRunYes := TaskAutomatorGui.Add("Radio", "x130 y172 w30 h20", "Y")
	RadioCtrlAuRunNo := TaskAutomatorGui.Add("Radio", "x165 y172 w30 h20 +Checked", "N")
	TextOnOffCtrlAuRun := TaskAutomatorGui.Add("Text","x210 y172 w30 h20 +0x200", " OFF")
	TaskAutomatorGui.Add("Text","x25 y197 w200 h20 +0x200", " Use RT / LT Keys to turn it on / off ")
}
;----------------------------------------------------
TaskAutomatorGui.Add("Text", "x1 y221 w250 h2 +0x10") ; Separator
;----------------------------------------------------
; Jumps
Switch true {
case SwitchJumps:
	try {
		OptionsMenu.SetIcon("3. Switch &Jumps", IconLib . "\Switch1.ico")
		OptionsMenu.SetIcon("2. Switch &Clicker", IconLib . "\Switch2.ico")
		OptionsMenu.SetIcon("1. Switch Quick &Access", IconLib . "\Switch2.ico")
		OptionsMenu.SetIcon("4. Switch Bottom Mo&dules OFF", IconLib . "\Switch2.ico")
	}
	catch {
	}
	SwitchQuickAccess := 0
	SwitchClicker := 0
	SwitchJumps := 1
	SwitchModulesOFF := 0
	TaskAutomatorGui.Add("Text", "x05 y226 h20 +0x200", " Verify Num Lock key is ON for Numpad keys ")
	TaskAutomatorGui.Add("GroupBox", "x10 y250 w229 h150", "Jumps")
	TaskAutomatorGui.Add("Text", "x20 y273 w95 h20 +0x200", " Very Short jump")
	TextOnOff2 := TaskAutomatorGui.Add("Text","x120 y273 h20 +0x200", " OFF ")
	TaskAutomatorGui.Add("Text", "x20 y298 w95 h20 +0x200", " Short jump")
	TextOnOff3 := TaskAutomatorGui.Add("Text","x120 y298 h20 +0x200", " OFF ")
	TaskAutomatorGui.Add("Text", "x20 y323 w95 h20 +0x200", " Normal jump")
	TextOnOff4 := TaskAutomatorGui.Add("Text","x120 y323 h20 +0x200", " OFF ")
	TaskAutomatorGui.Add("Text", "x20 y348 w95 h20 +0x200", " Long jump")
	TextOnOff5 := TaskAutomatorGui.Add("Text","x120 y348 h20 +0x200", " OFF ")
	TaskAutomatorGui.Add("Text", "x20 y373 w95 h20 +0x200", " Very Long jump")
	TextOnOff6 := TaskAutomatorGui.Add("Text","x120 y373 h20 +0x200", " OFF ")

	if HotkeyEditMode == true {
		JumpHotkey0 := TaskAutomatorGui.Add("Hotkey", "vJumpHotkey0 x155 y273 w74 h20 +disabled", JumpHotkey0)
		JumpHotkey1 := TaskAutomatorGui.Add("Hotkey", "vJumpHotkey1 x155 y298 w74 h20 +disabled", JumpHotkey1)
		JumpHotkey2 := TaskAutomatorGui.Add("Hotkey", "vJumpHotkey2 x155 y323 w74 h20 +disabled", JumpHotkey2)
		JumpHotkey3 := TaskAutomatorGui.Add("Hotkey", "vJumpHotkey3 x155 y348 w74 h20 +disabled", JumpHotkey3)
		JumpHotkey4 := TaskAutomatorGui.Add("Hotkey", "vJumpHotkey4 x155 y373 w74 h20 +disabled", JumpHotkey4)
	} else {
		CtrlJumpHotkey0 := IniRead(AuxHkDataFile, "CtrlHkFlags", "CtrlJumpHotkey0")
		AltJumpHotkey0 := IniRead(AuxHkDataFile, "AltHkFlags", "AltJumpHotkey0")
		ShiftJumpHotkey0 := IniRead(AuxHkDataFile, "ShiftHkFlags", "ShiftJumpHotkey0")
		switch true {
		case CtrlJumpHotkey0 == 1:
			if JumpHotkey0 == "" {
				JumpHotkey0 := "Ctrl"
				IniWrite JumpHotkey0, IniFile, "SavedHotkey", "JumpHotkey0"
			}
			CtrlJumpHotkey0 := 0
			IniWrite CtrlJumpHotkey0, AuxHkDataFile, "CtrlHkFlags", "CtrlJumpHotkey0"
		case AltJumpHotkey0 == 1:
			if JumpHotkey0 == "" {
				JumpHotkey0 := "Alt"
				IniWrite JumpHotkey0, IniFile, "SavedHotkey", "JumpHotkey0"
			}
			AltJumpHotkey0 := 0
			IniWrite AltJumpHotkey0, AuxHkDataFile, "AltHkFlags", "AltJumpHotkey0"
		case ShiftJumpHotkey0 == 1:
			if JumpHotkey0 == "" {
				JumpHotkey0 := "Shift"
				IniWrite JumpHotkey0, IniFile, "SavedHotkey", "JumpHotkey0"
			}
			ShiftJumpHotkey0 := 0
			IniWrite ShiftJumpHotkey0, AuxHkDataFile, "ShiftHkFlags", "ShiftJumpHotkey0" 
		case JumpHotkey0 == "":
			JumpHotkey0 := "Space"
			IniWrite JumpHotkey0, IniFile, "SavedHotkey", "JumpHotkey0"
		}
		
		CtrlJumpHotkey1 := IniRead(AuxHkDataFile, "CtrlHkFlags", "CtrlJumpHotkey1")
		AltJumpHotkey1 := IniRead(AuxHkDataFile, "AltHkFlags", "AltJumpHotkey1")
		ShiftJumpHotkey1 := IniRead(AuxHkDataFile, "ShiftHkFlags", "ShiftJumpHotkey1")
		switch true {
		case CtrlJumpHotkey1 == 1:
			if JumpHotkey1 == "" {
				JumpHotkey1 := "Ctrl"
				IniWrite JumpHotkey1, IniFile, "SavedHotkey", "JumpHotkey1"
			}
			CtrlJumpHotkey1 := 0
			IniWrite CtrlJumpHotkey1, AuxHkDataFile, "CtrlHkFlags", "CtrlJumpHotkey1"
		case AltJumpHotkey1 == 1:
			if JumpHotkey1 == "" {
				JumpHotkey1 := "Alt"
				IniWrite JumpHotkey1, IniFile, "SavedHotkey", "JumpHotkey1"
			}
			AltJumpHotkey1 := 0
			IniWrite AltJumpHotkey1, AuxHkDataFile, "AltHkFlags", "AltJumpHotkey1"
		case ShiftJumpHotkey1 == 1:
			if JumpHotkey1 == "" {
				JumpHotkey1 := "Shift"
				IniWrite JumpHotkey1, IniFile, "SavedHotkey", "JumpHotkey1"
			}
			ShiftJumpHotkey1 := 0
			IniWrite ShiftJumpHotkey1, AuxHkDataFile, "ShiftHkFlags", "ShiftJumpHotkey1" 
		case JumpHotkey1 == "":
			JumpHotkey1 := "Space"
			IniWrite JumpHotkey1, IniFile, "SavedHotkey", "JumpHotkey1"
		}
		
		CtrlJumpHotkey2 := IniRead(AuxHkDataFile, "CtrlHkFlags", "CtrlJumpHotkey2")
		AltJumpHotkey2 := IniRead(AuxHkDataFile, "AltHkFlags", "AltJumpHotkey2")
		ShiftJumpHotkey2 := IniRead(AuxHkDataFile, "ShiftHkFlags", "ShiftJumpHotkey2")
		switch true {
		case CtrlJumpHotkey2 == 1:
			if JumpHotkey2 == "" {
				JumpHotkey2 := "Ctrl"
				IniWrite JumpHotkey2, IniFile, "SavedHotkey", "JumpHotkey2"
			}
			CtrlJumpHotkey2 := 0
			IniWrite CtrlJumpHotkey2, AuxHkDataFile, "CtrlHkFlags", "CtrlJumpHotkey2"
		case AltJumpHotkey2 == 1:
			if JumpHotkey2 == "" {
				JumpHotkey2 := "Alt"
				IniWrite JumpHotkey2, IniFile, "SavedHotkey", "JumpHotkey2"
			}
			AltJumpHotkey2 := 0
			IniWrite AltJumpHotkey2, AuxHkDataFile, "AltHkFlags", "AltJumpHotkey2"
		case ShiftJumpHotkey2 == 1:
			if JumpHotkey2 == "" {
				JumpHotkey2 := "Shift"
				IniWrite JumpHotkey2, IniFile, "SavedHotkey", "JumpHotkey2"
			}
			ShiftJumpHotkey2 := 0
			IniWrite ShiftJumpHotkey2, AuxHkDataFile, "ShiftHkFlags", "ShiftJumpHotkey2" 
		case JumpHotkey2 == "":
			JumpHotkey2 := "Space"
			IniWrite JumpHotkey2, IniFile, "SavedHotkey", "JumpHotkey2"
		}
		
		CtrlJumpHotkey3 := IniRead(AuxHkDataFile, "CtrlHkFlags", "CtrlJumpHotkey3")
		AltJumpHotkey3 := IniRead(AuxHkDataFile, "AltHkFlags", "AltJumpHotkey3")
		ShiftJumpHotkey3 := IniRead(AuxHkDataFile, "ShiftHkFlags", "ShiftJumpHotkey3")
		switch true {
		case CtrlJumpHotkey3 == 1:
			if JumpHotkey3 == "" {
				JumpHotkey3 := "Ctrl"
				IniWrite JumpHotkey3, IniFile, "SavedHotkey", "JumpHotkey3"
			}
			CtrlJumpHotkey3 := 0
			IniWrite CtrlJumpHotkey3, AuxHkDataFile, "CtrlHkFlags", "CtrlJumpHotkey3"
		case AltJumpHotkey3 == 1:
			if JumpHotkey3 == "" {
				JumpHotkey3 := "Alt"
				IniWrite JumpHotkey3, IniFile, "SavedHotkey", "JumpHotkey3"
			}
			AltJumpHotkey3 := 0
			IniWrite AltJumpHotkey3, AuxHkDataFile, "AltHkFlags", "AltJumpHotkey3"
		case ShiftJumpHotkey3 == 1:
			if JumpHotkey3 == "" {
				JumpHotkey3 := "Shift"
				IniWrite JumpHotkey3, IniFile, "SavedHotkey", "JumpHotkey3"
			}
			ShiftJumpHotkey3 := 0
			IniWrite ShiftJumpHotkey3, AuxHkDataFile, "ShiftHkFlags", "ShiftJumpHotkey3" 
		case JumpHotkey3 == "":
			JumpHotkey3 := "Space"
			IniWrite JumpHotkey3, IniFile, "SavedHotkey", "JumpHotkey3"
		}
		
		CtrlJumpHotkey4 := IniRead(AuxHkDataFile, "CtrlHkFlags", "CtrlJumpHotkey4")
		AltJumpHotkey4 := IniRead(AuxHkDataFile, "AltHkFlags", "AltJumpHotkey4")
		ShiftJumpHotkey4 := IniRead(AuxHkDataFile, "ShiftHkFlags", "ShiftJumpHotkey4")
		switch true {
		case CtrlJumpHotkey4 == 1:
			if JumpHotkey4 == "" {
				JumpHotkey4 := "Ctrl"
				IniWrite JumpHotkey4, IniFile, "SavedHotkey", "JumpHotkey4"
			}
			CtrlJumpHotkey4 := 0
			IniWrite CtrlJumpHotkey4, AuxHkDataFile, "CtrlHkFlags", "CtrlJumpHotkey4"
		case AltJumpHotkey4 == 1:
			if JumpHotkey4 == "" {
				JumpHotkey4 := "Alt"
				IniWrite JumpHotkey4, IniFile, "SavedHotkey", "JumpHotkey4"
			}
			AltJumpHotkey4 := 0
			IniWrite AltJumpHotkey4, AuxHkDataFile, "AltHkFlags", "AltJumpHotkey4"
		case ShiftJumpHotkey4 == 1:
			if JumpHotkey4 == "" {
				JumpHotkey4 := "Shift"
				IniWrite JumpHotkey4, IniFile, "SavedHotkey", "JumpHotkey4"
			}
			ShiftJumpHotkey4 := 0
			IniWrite ShiftJumpHotkey4, AuxHkDataFile, "ShiftHkFlags", "ShiftJumpHotkey4" 
		case JumpHotkey4 == "":
			JumpHotkey4 := "Space"
			IniWrite JumpHotkey4, IniFile, "SavedHotkey", "JumpHotkey4"
		}
		
		JumpHotkey0 := TaskAutomatorGui.Add("Hotkey", "vJumpHotkey0 x155 y273 w74 h20", JumpHotkey0).OnEvent("Change", SubmitJumpHotkey0)
		JumpHotkey1 := TaskAutomatorGui.Add("Hotkey", "vJumpHotkey1 x155 y298 w74 h20", JumpHotkey1).OnEvent("Change", SubmitJumpHotkey1)
		JumpHotkey2 := TaskAutomatorGui.Add("Hotkey", "vJumpHotkey2 x155 y323 w74 h20", JumpHotkey2).OnEvent("Change", SubmitJumpHotkey2)
		JumpHotkey3 := TaskAutomatorGui.Add("Hotkey", "vJumpHotkey3 x155 y348 w74 h20", JumpHotkey3).OnEvent("Change", SubmitJumpHotkey3)
		JumpHotkey4 := TaskAutomatorGui.Add("Hotkey", "vJumpHotkey4 x155 y373 w74 h20", JumpHotkey4).OnEvent("Change", SubmitJumpHotkey4)
	}
case SwitchClicker:
	try {
		OptionsMenu.SetIcon("2. Switch &Clicker", IconLib . "\Switch1.ico")
		OptionsMenu.SetIcon("3. Switch &Jumps", IconLib . "\Switch2.ico")
		OptionsMenu.SetIcon("1. Switch Quick &Access", IconLib . "\Switch2.ico")
		OptionsMenu.SetIcon("Switch Secure Edit &Boxes && Icons: On/Off", IconLib . "\EditBox2.png")
		OptionsMenu.SetIcon("4. Switch Bottom Mo&dules OFF", IconLib . "\Switch2.ico")
	}
	catch {
	}
	SwitchQuickAccess := 0
	SwitchClicker := 1
	SwitchJumps := 0
	SwitchModulesOFF := 0
	TaskAutomatorGui.Add("Text","x10 y226 h20 +0x200", " Auto Clicker ")
	TextPatternClickerOnOff := TaskAutomatorGui.Add("Text","x105 y226 h20 +0x200", " OFF ")
	if HotkeyEditMode == true {
		PatternClickerHotkey := TaskAutomatorGui.Add("Hotkey", "vPatternClickerHotkey x150 y226 w90 h20 +disabled", PatternClickerHotkey)
	} else {
		CtrlPatternClickerHotkey := IniRead(AuxHkDataFile, "CtrlHkFlags", "CtrlPatternClickerHotkey")
		AltPatternClickerHotkey := IniRead(AuxHkDataFile, "AltHkFlags", "AltPatternClickerHotkey")
		ShiftPatternClickerHotkey := IniRead(AuxHkDataFile, "ShiftHkFlags", "ShiftPatternClickerHotkey")
		switch true {
		case CtrlPatternClickerHotkey == 1:
			if PatternClickerHotkey == "" {
				PatternClickerHotkey := "Ctrl"
				IniWrite PatternClickerHotkey, IniFile, "SavedHotkey", "PatternClickerHotkey"
			}
			CtrlPatternClickerHotkey := 0
			IniWrite CtrlPatternClickerHotkey, AuxHkDataFile, "CtrlHkFlags", "CtrlPatternClickerHotkey"
		case AltPatternClickerHotkey == 1:
			if PatternClickerHotkey == "" {
				PatternClickerHotkey := "Alt"
				IniWrite PatternClickerHotkey, IniFile, "SavedHotkey", "PatternClickerHotkey"
			}
			AltPatternClickerHotkey := 0
			IniWrite AltPatternClickerHotkey, AuxHkDataFile, "AltHkFlags", "AltPatternClickerHotkey"
		case ShiftPatternClickerHotkey == 1:
			if PatternClickerHotkey == "" {
				PatternClickerHotkey := "Shift"
				IniWrite PatternClickerHotkey, IniFile, "SavedHotkey", "PatternClickerHotkey"
			}
			ShiftPatternClickerHotkey := 0
			IniWrite ShiftPatternClickerHotkey, AuxHkDataFile, "ShiftHkFlags", "ShiftPatternClickerHotkey" 
		case PatternClickerHotkey == "":
			PatternClickerHotkey := "Space"
			IniWrite PatternClickerHotkey, IniFile, "SavedHotkey", "PatternClickerHotkey"
		}
		
		PatternClickerHotkey := TaskAutomatorGui.Add("Hotkey", "vPatternClickerHotkey x150 y226 w90 h20", PatternClickerHotkey).OnEvent("Change", SubmitPatternClickerHotkey)
	}
	if EditBoxesAvailable == true {
		try {
			OptionsMenu.SetIcon("Switch Secure Edit &Boxes && Icons: On/Off", IconLib . "\EditBox2.png")
		}
		catch {
		}
		EditPatternClicker := TaskAutomatorGui.Add("Edit", "vClickInterval x60 y251 w50 h20 +Number")
		EditPatternClickerOffset := TaskAutomatorGui.Add("Edit", "vRandomOffset x190 y251 w50 h20 +Number")
	} else {
		try {
			OptionsMenu.SetIcon("Switch Secure Edit &Boxes && Icons: On/Off", IconLib . "\EditBox1.png")
		}
		catch {
		}
		EditPatternClicker := TaskAutomatorGui.Add("Edit", "vClickInterval x60 y251 w50 h20 +Number +Disabled")
		EditPatternClickerOffset := TaskAutomatorGui.Add("Edit", "vRandomOffset x190 y251 w50 h20 +Number +Disabled")
	}
	TextPatternClickInterval := TaskAutomatorGui.Add("Text","x10 y251 h20 +0x200", " Interval ")
	TextPatternClickerOffset := TaskAutomatorGui.Add("Text","x120 y251 h20 +0x200", " Rnd Offset ")
	;----------------------------------------------------
	TextLoop := TaskAutomatorGui.Add("Text","x10 y276 h20 +0x200", " Loop amount: ")
	TaskAutomatorGui.SetFont()
	TaskAutomatorGui.SetFont("Bold " . FontClickerPatternColor . "", MainFontType)
	if EditBoxesAvailable == true {
		EditLoopTimes := TaskAutomatorGui.Add("Edit", "vLoopAmount x98 y276 w70 h20 +Number")
	} else {
		EditLoopTimes := TaskAutomatorGui.Add("Edit", "vLoopAmount x98 y276 w70 h20 +Number +Disabled")
	}
	EditLoopTimes.Opt("" . BackgroundMainColor . "")
	TaskAutomatorGui.SetFont()
	TaskAutomatorGui.SetFont("Bold " . MainFontColor, MainFontType)
	EditLoopTimes.Value := LoopAmount
	
	RadioCountLoopsYes := TaskAutomatorGui.Add("Radio", "x179 y276 h20 +Checked", "Y")
	RadioCountLoopsNo := TaskAutomatorGui.Add("Radio", "x211 y276 w30 h20", "N")
	;----------------------------------------------------
	TextPosX := TaskAutomatorGui.Add("Text","x37 y300 +0x200", " X ")
	TextPosY := TaskAutomatorGui.Add("Text","x84 y300 +0x200", " Y ")
	TextPosInterval := TaskAutomatorGui.Add("Text","x121 y300 +0x200", " Interval ")
	TaskAutomatorGui.SetFont()
	TaskAutomatorGui.SetFont("Bold " . MainFontColor, MainFontType)
	EditPatternClicker.Value := ClickInterval
	EditPatternClicker.Opt("" . BackgroundMainColor . "")
	EditPatternClickerOffset.Value := RandomOffset
	EditPatternClickerOffset.Opt("" . BackgroundMainColor . "")
	;----------------------------------------------------
	TextPosX1 := TaskAutomatorGui.Add("Text","x10 y319 h20 +0x200", "1")
	TaskAutomatorGui.SetFont()
	TaskAutomatorGui.SetFont("Bold " . FontClickerPatternColor . "", MainFontType)
	if EditBoxesAvailable == true {
		EditPosX0 := TaskAutomatorGui.Add("Edit", "vCoordX0 x25 y319 w40 h20 +Number")
	} else {
		EditPosX0 := TaskAutomatorGui.Add("Edit", "vCoordX0 x25 y319 w40 h20 +Number +Disabled")
	}
	EditPosX0.Opt("" . BackgroundMainColor . "")
	TaskAutomatorGui.SetFont()
	TaskAutomatorGui.SetFont("Bold " . MainFontColor, MainFontType)
	EditPosX0.Value := CoordX0
	TaskAutomatorGui.SetFont()
	TaskAutomatorGui.SetFont("Bold " . FontClickerPatternColor . "", MainFontType)
	if EditBoxesAvailable == true {
		EditPosY0 := TaskAutomatorGui.Add("Edit", "vCoordY0 x73 y319 w40 h20 +Number")
	} else {
		EditPosY0 := TaskAutomatorGui.Add("Edit", "vCoordY0 x73 y319 w40 h20 +Number +Disabled")
	}
	EditPosY0.Opt("" . BackgroundMainColor . "")
	TaskAutomatorGui.SetFont()
	TaskAutomatorGui.SetFont("Bold " . MainFontColor, MainFontType)
	EditPosY0.Value := CoordY0
	TaskAutomatorGui.SetFont()
	TaskAutomatorGui.SetFont("Bold " . FontClickerPatternColor . "", MainFontType)
	if EditBoxesAvailable == true {
		EditPos0Interval := TaskAutomatorGui.Add("Edit", "vCoord0Interval x121 y319 w50 h20 +Number")
	} else {
		EditPos0Interval := TaskAutomatorGui.Add("Edit", "vCoord0Interval x121 y319 w50 h20 +Number +Disabled")
	}
	EditPos0Interval.Opt("" . BackgroundMainColor . "")
	TaskAutomatorGui.SetFont()
	TaskAutomatorGui.SetFont("Bold " . MainFontColor, MainFontType)
	EditPos0Interval.Value := Coord0Interval
	
	RadioPos0Yes := TaskAutomatorGui.Add("Radio", "x179 y319 h20", "Y")
	RadioPos0No := TaskAutomatorGui.Add("Radio", "x211 y319 w30 h20 +Checked", "N")
	;----------------------------------------------------
	TextPosX2 := TaskAutomatorGui.Add("Text","x10 y344 h20 +0x200", "2")
	TaskAutomatorGui.SetFont()
	TaskAutomatorGui.SetFont("Bold " . FontClickerPatternColor . "", MainFontType)
	if EditBoxesAvailable == true {
		EditPosX1 := TaskAutomatorGui.Add("Edit", "vCoordX1 x25 y344 w40 h20 +Number")
	} else {
		EditPosX1 := TaskAutomatorGui.Add("Edit", "vCoordX1 x25 y344 w40 h20 +Number +Disabled")
	}
	EditPosX1.Opt("" . BackgroundMainColor . "")
	TaskAutomatorGui.SetFont()
	TaskAutomatorGui.SetFont("Bold " . MainFontColor, MainFontType)
	EditPosX1.Value := CoordX1
	TaskAutomatorGui.SetFont()
	TaskAutomatorGui.SetFont("Bold " . FontClickerPatternColor . "", MainFontType)
	if EditBoxesAvailable == true {
		EditPosY1 := TaskAutomatorGui.Add("Edit", "vCoordY1 x73 y344 w40 h20 +Number")
	} else {
		EditPosY1 := TaskAutomatorGui.Add("Edit", "vCoordY1 x73 y344 w40 h20 +Number +Disabled")
	}
	EditPosY1.Opt("" . BackgroundMainColor . "")
	TaskAutomatorGui.SetFont()
	TaskAutomatorGui.SetFont("Bold " . MainFontColor, MainFontType)
	EditPosY1.Value := CoordY1
	TaskAutomatorGui.SetFont()
	TaskAutomatorGui.SetFont("Bold " . FontClickerPatternColor . "", MainFontType)
	if EditBoxesAvailable == true {
		EditPos1Interval := TaskAutomatorGui.Add("Edit", "vCoord1Interval x121 y344 w50 h20 +Number")
	} else {
		EditPos1Interval := TaskAutomatorGui.Add("Edit", "vCoord1Interval x121 y344 w50 h20 +Number +Disabled")
	}
	EditPos1Interval.Opt("" . BackgroundMainColor . "")
	TaskAutomatorGui.SetFont()
	TaskAutomatorGui.SetFont("Bold " . MainFontColor, MainFontType)
	EditPos1Interval.Value := Coord1Interval
	
	RadioPos1Yes := TaskAutomatorGui.Add("Radio", "x179 y344 h20", "Y")
	RadioPos1No := TaskAutomatorGui.Add("Radio", "x211 y344 w30 h20 +Checked", "N")
	;----------------------------------------------------
	TextPosX3 := TaskAutomatorGui.Add("Text","x10 y369 h20 +0x200", "3")
	TaskAutomatorGui.SetFont()
	TaskAutomatorGui.SetFont("Bold " . FontClickerPatternColor . "", MainFontType)
	if EditBoxesAvailable == true {
		EditPosX2 := TaskAutomatorGui.Add("Edit", "vCoordX2 x25 y369 w40 h20 +Number")
	} else {
		EditPosX2 := TaskAutomatorGui.Add("Edit", "vCoordX2 x25 y369 w40 h20 +Number +Disabled")
	}
	EditPosX2.Opt("" . BackgroundMainColor . "")
	TaskAutomatorGui.SetFont()
	TaskAutomatorGui.SetFont("Bold " . MainFontColor, MainFontType)
	EditPosX2.Value := CoordX2
	TaskAutomatorGui.SetFont()
	TaskAutomatorGui.SetFont("Bold " . FontClickerPatternColor . "", MainFontType)
	if EditBoxesAvailable == true {
		EditPosY2 := TaskAutomatorGui.Add("Edit", "vCoordY2 x73 y369 w40 h20 +Number")
	} else {
		EditPosY2 := TaskAutomatorGui.Add("Edit", "vCoordY2 x73 y369 w40 h20 +Number +Disabled")
	}
	EditPosY2.Opt("" . BackgroundMainColor . "")
	TaskAutomatorGui.SetFont()
	TaskAutomatorGui.SetFont("Bold " . MainFontColor, MainFontType)
	EditPosY2.Value := CoordY2
	TaskAutomatorGui.SetFont()
	TaskAutomatorGui.SetFont("Bold " . FontClickerPatternColor . "", MainFontType)
	if EditBoxesAvailable == true {
		EditPos2Interval := TaskAutomatorGui.Add("Edit", "vCoord2Interval x121 y369 w50 h20 +Number")
	} else {
		EditPos2Interval := TaskAutomatorGui.Add("Edit", "vCoord2Interval x121 y369 w50 h20 +Number +Disabled")
	}
	EditPos2Interval.Opt("" . BackgroundMainColor . "")
	TaskAutomatorGui.SetFont()
	TaskAutomatorGui.SetFont("Bold " . MainFontColor, MainFontType)
	EditPos2Interval.Value := Coord2Interval
	
	RadioPos2Yes := TaskAutomatorGui.Add("Radio", "x179 y369 h20", "Y")
	RadioPos2No := TaskAutomatorGui.Add("Radio", "x211 y369 w30 h20 +Checked", "N")
	;----------------------------------------------------
	TextPosX4 := TaskAutomatorGui.Add("Text","x10 y394 h20 +0x200", "4")
	TaskAutomatorGui.SetFont()
	TaskAutomatorGui.SetFont("Bold " . FontClickerPatternColor . "", MainFontType)
	if EditBoxesAvailable == true {
		EditPosX3 := TaskAutomatorGui.Add("Edit", "vCoordX3 x25 y394 w40 h20 +Number")
	} else {
		EditPosX3 := TaskAutomatorGui.Add("Edit", "vCoordX3 x25 y394 w40 h20 +Number +Disabled")
	}
	EditPosX3.Opt("" . BackgroundMainColor . "")
	TaskAutomatorGui.SetFont()
	TaskAutomatorGui.SetFont("Bold " . MainFontColor, MainFontType)
	EditPosX3.Value := CoordX3
	TaskAutomatorGui.SetFont()
	TaskAutomatorGui.SetFont("Bold " . FontClickerPatternColor . "", MainFontType)
	if EditBoxesAvailable == true {
		EditPosY3 := TaskAutomatorGui.Add("Edit", "vCoordY3 x73 y394 w40 h20 +Number")
	} else {
		EditPosY3 := TaskAutomatorGui.Add("Edit", "vCoordY3 x73 y394 w40 h20 +Number +Disabled")
	}
	EditPosY3.Opt("" . BackgroundMainColor . "")
	TaskAutomatorGui.SetFont()
	TaskAutomatorGui.SetFont("Bold " . MainFontColor, MainFontType)
	EditPosY3.Value := CoordY3
	TaskAutomatorGui.SetFont()
	TaskAutomatorGui.SetFont("Bold " . FontClickerPatternColor . "", MainFontType)
	if EditBoxesAvailable == true {
		EditPos3Interval := TaskAutomatorGui.Add("Edit", "vCoord3Interval x121 y394 w50 h20 +Number")
	} else {
		EditPos3Interval := TaskAutomatorGui.Add("Edit", "vCoord3Interval x121 y394 w50 h20 +Number +Disabled")
	}
	EditPos3Interval.Opt("" . BackgroundMainColor . "")
	TaskAutomatorGui.SetFont()
	TaskAutomatorGui.SetFont("Bold " . MainFontColor, MainFontType)
	EditPos3Interval.Value := Coord3Interval
	
	RadioPos3Yes := TaskAutomatorGui.Add("Radio", "x179 y394 h20", "Y")
	RadioPos3No := TaskAutomatorGui.Add("Radio", "x211 y394 w30 h20 +Checked", "N")
	;----------------------------------------------------
	TextPosX5 := TaskAutomatorGui.Add("Text","x10 y419 h20 +0x200", "5")
	TaskAutomatorGui.SetFont()
	TaskAutomatorGui.SetFont("Bold " . FontClickerPatternColor . "", MainFontType)
	if EditBoxesAvailable == true {
		EditPosX4 := TaskAutomatorGui.Add("Edit", "vCoordX4 x25 y419 w40 h20 +Number")
	} else {
		EditPosX4 := TaskAutomatorGui.Add("Edit", "vCoordX4 x25 y419 w40 h20 +Number +Disabled")
	}
	EditPosX4.Opt("" . BackgroundMainColor . "")
	TaskAutomatorGui.SetFont()
	TaskAutomatorGui.SetFont("Bold " . MainFontColor, MainFontType)
	EditPosX4.Value := CoordX4
	TaskAutomatorGui.SetFont()
	TaskAutomatorGui.SetFont("Bold " . FontClickerPatternColor . "", MainFontType)
	if EditBoxesAvailable == true {
		EditPosY4 := TaskAutomatorGui.Add("Edit", "vCoordY4 x73 y419 w40 h20 +Number")
	} else {
		EditPosY4 := TaskAutomatorGui.Add("Edit", "vCoordY4 x73 y419 w40 h20 +Number +Disabled")
	}
	EditPosY4.Opt("" . BackgroundMainColor . "")
	TaskAutomatorGui.SetFont()
	TaskAutomatorGui.SetFont("Bold " . MainFontColor, MainFontType)
	EditPosY4.Value := CoordY4
	TaskAutomatorGui.SetFont()
	TaskAutomatorGui.SetFont("Bold " . FontClickerPatternColor . "", MainFontType)
	if EditBoxesAvailable == true {
		EditPos4Interval := TaskAutomatorGui.Add("Edit", "vCoord4Interval x121 y419 w50 h20 +Number")
	} else {
		EditPos4Interval := TaskAutomatorGui.Add("Edit", "vCoord4Interval x121 y419 w50 h20 +Number +Disabled")
	}
	EditPos4Interval.Opt("" . BackgroundMainColor . "")
	TaskAutomatorGui.SetFont()
	TaskAutomatorGui.SetFont("Bold " . MainFontColor, MainFontType)
	EditPos4Interval.Value := Coord4Interval
	
	RadioPos4Yes := TaskAutomatorGui.Add("Radio", "x179 y419 h20", "Y")
	RadioPos4No := TaskAutomatorGui.Add("Radio", "x211 y419 w30 h20 +Checked", "N")
	;----------------------------------------------------
	TextPosX6 := TaskAutomatorGui.Add("Text","x10 y444 h20 +0x200", "6")
	TaskAutomatorGui.SetFont()
	TaskAutomatorGui.SetFont("Bold " . FontClickerPatternColor . "", MainFontType)
	if EditBoxesAvailable == true {
		EditPosX5 := TaskAutomatorGui.Add("Edit", "vCoordX5 x25 y444 w40 h20 +Number")
	} else {
		EditPosX5 := TaskAutomatorGui.Add("Edit", "vCoordX5 x25 y444 w40 h20 +Number +Disabled")
	}
	EditPosX5.Opt("" . BackgroundMainColor . "")
	TaskAutomatorGui.SetFont()
	TaskAutomatorGui.SetFont("Bold " . MainFontColor, MainFontType)
	EditPosX5.Value := CoordX5
	TaskAutomatorGui.SetFont()
	TaskAutomatorGui.SetFont("Bold " . FontClickerPatternColor . "", MainFontType)
	if EditBoxesAvailable == true {
		EditPosY5 := TaskAutomatorGui.Add("Edit", "vCoordY5 x73 y444 w40 h20 +Number")
	} else {
		EditPosY5 := TaskAutomatorGui.Add("Edit", "vCoordY5 x73 y444 w40 h20 +Number +Disabled")
	}
	EditPosY5.Opt("" . BackgroundMainColor . "")
	TaskAutomatorGui.SetFont()
	TaskAutomatorGui.SetFont("Bold " . MainFontColor, MainFontType)
	EditPosY5.Value := CoordY5
	TaskAutomatorGui.SetFont()
	TaskAutomatorGui.SetFont("Bold " . FontClickerPatternColor . "", MainFontType)
	if EditBoxesAvailable == true {
		EditPos5Interval := TaskAutomatorGui.Add("Edit", "vCoord5Interval x121 y444 w50 h20 +Number")
	} else {
		EditPos5Interval := TaskAutomatorGui.Add("Edit", "vCoord5Interval x121 y444 w50 h20 +Number +Disabled")
	}
	EditPos5Interval.Opt("" . BackgroundMainColor . "")
	TaskAutomatorGui.SetFont()
	TaskAutomatorGui.SetFont("Bold " . MainFontColor, MainFontType)
	EditPos5Interval.Value := Coord5Interval
	
	RadioPos5Yes := TaskAutomatorGui.Add("Radio", "x179 y444 h20", "Y")
	RadioPos5No := TaskAutomatorGui.Add("Radio", "x211 y444 w30 h20 +Checked", "N")
	;----------------------------------------------------
	TextPosX7 := TaskAutomatorGui.Add("Text","x10 y469 h20 +0x200", "7")
	TaskAutomatorGui.SetFont()
	TaskAutomatorGui.SetFont("Bold " . FontClickerPatternColor . "", MainFontType)
	if EditBoxesAvailable == true {
		EditPosX6 := TaskAutomatorGui.Add("Edit", "vCoordX6 x25 y469 w40 h20 +Number")
	} else {
		EditPosX6 := TaskAutomatorGui.Add("Edit", "vCoordX6 x25 y469 w40 h20 +Number +Disabled")
	}
	EditPosX6.Opt("" . BackgroundMainColor . "")
	TaskAutomatorGui.SetFont()
	TaskAutomatorGui.SetFont("Bold " . MainFontColor, MainFontType)
	EditPosX6.Value := CoordX6
	TaskAutomatorGui.SetFont()
	TaskAutomatorGui.SetFont("Bold " . FontClickerPatternColor . "", MainFontType)
	if EditBoxesAvailable == true {
		EditPosY6 := TaskAutomatorGui.Add("Edit", "vCoordY6 x73 y469 w40 h20 +Number")
	} else {
		EditPosY6 := TaskAutomatorGui.Add("Edit", "vCoordY6 x73 y469 w40 h20 +Number +Disabled")
	}
	EditPosY6.Opt("" . BackgroundMainColor . "")
	TaskAutomatorGui.SetFont()
	TaskAutomatorGui.SetFont("Bold " . MainFontColor, MainFontType)
	EditPosY6.Value := CoordY6
	TaskAutomatorGui.SetFont()
	TaskAutomatorGui.SetFont("Bold " . FontClickerPatternColor . "", MainFontType)
	if EditBoxesAvailable == true {
		EditPos6Interval := TaskAutomatorGui.Add("Edit", "vCoord6Interval x121 y469 w50 h20 +Number")
	} else {
		EditPos6Interval := TaskAutomatorGui.Add("Edit", "vCoord6Interval x121 y469 w50 h20 +Number +Disabled")
	}
	EditPos6Interval.Opt("" . BackgroundMainColor . "")
	TaskAutomatorGui.SetFont()
	TaskAutomatorGui.SetFont("Bold " . MainFontColor, MainFontType)
	EditPos6Interval.Value := Coord6Interval
	
	RadioPos6Yes := TaskAutomatorGui.Add("Radio", "x179 y469 h20", "Y")
	RadioPos6No := TaskAutomatorGui.Add("Radio", "x211 y469 w30 h20 +Checked", "N")
	;----------------------------------------------------
	TaskAutomatorGui.Add("Text","x22 y493 +0x200", " Time interval in ms (1 second = 1000) ")
case SwitchQuickAccess:
	try {
		OptionsMenu.SetIcon("2. Switch &Clicker", IconLib . "\Switch2.ico")
		OptionsMenu.SetIcon("3. Switch &Jumps", IconLib . "\Switch2.ico")
		OptionsMenu.SetIcon("1. Switch Quick &Access", IconLib . "\Switch1.ico")
		OptionsMenu.SetIcon("4. Switch Bottom Mo&dules OFF", IconLib . "\Switch2.ico")
	}
	catch {
	}
	SwitchQuickAccess := 1
	SwitchClicker := 0
	SwitchJumps := 0
	SwitchModulesOFF := 0
	FlagReload := false
	;----------------------------------------------------
	TaskAutomatorGui.Add("Text", "x7 y233 h20 +0x200", "1")
	if EditBoxesAvailable == true {
		try {
			OptionsMenu.SetIcon("Switch Secure Edit &Boxes && Icons: On/Off", IconLib . "\EditBox2.png")
		}
		catch {
		}
		try {
			TaskAutomatorGui.Add("Picture", "x18 y233 w20 h20 +border", QuickIcon1).OnEvent("Click", SelectNewIcon1)
		}
		catch {
			QuickIcon1 := ""
			IniWrite QuickIcon1, IniFile, "QuickAccessIcons", "QuickIcon1"
			FlagReload := true
		}
		EditQuickAcess1 := TaskAutomatorGui.Add("Edit", "vQuickAccess1 x45 y233 w160 h20")
	} else {
		try {
			OptionsMenu.SetIcon("Switch Secure Edit &Boxes && Icons: On/Off", IconLib . "\EditBox1.png")
		}
		catch {
		}
		try {
			TaskAutomatorGui.Add("Picture", "x18 y233 w20 h20 +border", QuickIcon1)
		}
		catch {
			QuickIcon1 := ""
			IniWrite QuickIcon1, IniFile, "QuickAccessIcons", "QuickIcon1"
			FlagReload := true
		}
		EditQuickAcess1 := TaskAutomatorGui.Add("Edit", "vQuickAccess1 x45 y233 w160 h20 +Disabled")
	}
	EditQuickAcess1.Opt("" . BackgroundMainColor . "")
	EditQuickAcess1.Value := QuickAccess1
	if QuickAccessButtons == true {
		OptionsMenu.SetIcon("1b. Switch &Quick Access Hotkeys/Buttons", IconLib . "\Switch1.ico")
		QuickAccessButton1 := TaskAutomatorGui.Add("Button", "x210 y233 w30 h20", "Go!")
		QuickAccessButton1.OnEvent("Click", ProccessQuickAccessButton1) 
	} else {
		OptionsMenu.SetIcon("1b. Switch &Quick Access Hotkeys/Buttons", IconLib . "\Switch2.ico")
		if HotkeyEditMode == true {
			QuickAccessHk1 := TaskAutomatorGui.Add("Hotkey", "vQuickAccessHk1 x210 y233 w30 h20 +disabled", QuickAccessHk1)
		} else {
			CtrlQuickAccessHk1 := IniRead(AuxHkDataFile, "CtrlHkFlags", "CtrlQuickAccessHk1")
			AltQuickAccessHk1 := IniRead(AuxHkDataFile, "AltHkFlags", "AltQuickAccessHk1")
			ShiftQuickAccessHk1 := IniRead(AuxHkDataFile, "ShiftHkFlags", "ShiftQuickAccessHk1")
			switch true {
			case CtrlQuickAccessHk1 == 1:
				if QuickAccessHk1 == "" {
					QuickAccessHk1 := "Ctrl"
					IniWrite QuickAccessHk1, IniFile, "SavedHotkey", "QuickAccessHk1"
				}
				CtrlQuickAccessHk1 := 0
				IniWrite CtrlQuickAccessHk1, AuxHkDataFile, "CtrlHkFlags", "CtrlQuickAccessHk1"
			case AltQuickAccessHk1 == 1:
				if QuickAccessHk1 == "" {
					QuickAccessHk1 := "Alt"
					IniWrite QuickAccessHk1, IniFile, "SavedHotkey", "QuickAccessHk1"
				}
				AltQuickAccessHk1 := 0
				IniWrite AltQuickAccessHk1, AuxHkDataFile, "AltHkFlags", "AltQuickAccessHk1"
			case ShiftQuickAccessHk1 == 1:
				if QuickAccessHk1 == "" {
					QuickAccessHk1 := "Shift"
					IniWrite QuickAccessHk1, IniFile, "SavedHotkey", "QuickAccessHk1"
				}
				ShiftQuickAccessHk1 := 0
				IniWrite ShiftQuickAccessHk1, AuxHkDataFile, "ShiftHkFlags", "ShiftQuickAccessHk1" 
			case QuickAccessHk1 == "":
				QuickAccessHk1 := "Space"
				IniWrite QuickAccessHk1, IniFile, "SavedHotkey", "QuickAccessHk1"
			}
			
			QuickAccessHk1 := TaskAutomatorGui.Add("Hotkey", "vQuickAccessHk1 x210 y233 w30 h20", QuickAccessHk1).OnEvent("Change", SubmitQuickAccess1)
		}
	}
	;----------------------------------------------------
	TaskAutomatorGui.Add("Text", "x7 y264 h20 +0x200", "2")
	if EditBoxesAvailable == true {
		try {
			TaskAutomatorGui.Add("Picture", "x18 y264 w20 h20 +border", QuickIcon2).OnEvent("Click", SelectNewIcon2)
		}
		catch {
			QuickIcon2 := ""
			IniWrite QuickIcon2, IniFile, "QuickAccessIcons", "QuickIcon2"
			FlagReload := true
		}
		EditQuickAcess2 := TaskAutomatorGui.Add("Edit", "vQuickAccess2 x45 y264 w160 h20")
	} else {
		try {
			TaskAutomatorGui.Add("Picture", "x18 y264 w20 h20 +border", QuickIcon2)
		}
		catch {
			QuickIcon2 := ""
			IniWrite QuickIcon2, IniFile, "QuickAccessIcons", "QuickIcon2"
			FlagReload := true
		}
		EditQuickAcess2 := TaskAutomatorGui.Add("Edit", "vQuickAccess2 x45 y264 w160 h20 +Disabled")
	}
	EditQuickAcess2.Opt("" . BackgroundMainColor . "")
	EditQuickAcess2.Value := QuickAccess2
	if QuickAccessButtons == true {
		QuickAccessButton2 := TaskAutomatorGui.Add("Button", "x210 y264 w30 h20", "Go!")
		QuickAccessButton2.OnEvent("Click", ProccessQuickAccessButton2) 
	} else {
		if HotkeyEditMode == true {
			QuickAccessHk2 := TaskAutomatorGui.Add("Hotkey", "vQuickAccessHk2 x210 y264 w30 h20 +disabled", QuickAccessHk2)
		} else {
			CtrlQuickAccessHk2 := IniRead(AuxHkDataFile, "CtrlHkFlags", "CtrlQuickAccessHk2")
			AltQuickAccessHk2 := IniRead(AuxHkDataFile, "AltHkFlags", "AltQuickAccessHk2")
			ShiftQuickAccessHk2 := IniRead(AuxHkDataFile, "ShiftHkFlags", "ShiftQuickAccessHk2")
			switch true {
			case CtrlQuickAccessHk2 == 1:
				if QuickAccessHk2 == "" {
					QuickAccessHk2 := "Ctrl"
					IniWrite QuickAccessHk2, IniFile, "SavedHotkey", "QuickAccessHk2"
				}
				CtrlQuickAccessHk2 := 0
				IniWrite CtrlQuickAccessHk2, AuxHkDataFile, "CtrlHkFlags", "CtrlQuickAccessHk2"
			case AltQuickAccessHk2 == 1:
				if QuickAccessHk2 == "" {
					QuickAccessHk2 := "Alt"
					IniWrite QuickAccessHk2, IniFile, "SavedHotkey", "QuickAccessHk2"
				}
				AltQuickAccessHk2 := 0
				IniWrite AltQuickAccessHk2, AuxHkDataFile, "AltHkFlags", "AltQuickAccessHk2"
			case ShiftQuickAccessHk2 == 1:
				if QuickAccessHk2 == "" {
					QuickAccessHk2 := "Shift"
					IniWrite QuickAccessHk2, IniFile, "SavedHotkey", "QuickAccessHk2"
				}
				ShiftQuickAccessHk2 := 0
				IniWrite ShiftQuickAccessHk2, AuxHkDataFile, "ShiftHkFlags", "ShiftQuickAccessHk2" 
			case QuickAccessHk2 == "":
				QuickAccessHk2 := "Space"
				IniWrite QuickAccessHk2, IniFile, "SavedHotkey", "QuickAccessHk2"
			}
			
			QuickAccessHk2 := TaskAutomatorGui.Add("Hotkey", "vQuickAccessHk2 x210 y264 w30 h20", QuickAccessHk2).OnEvent("Change", SubmitQuickAccess2)
		}
	}
	;----------------------------------------------------
	TaskAutomatorGui.Add("Text", "x7 y295 h20 +0x200", "3")
	if EditBoxesAvailable == true {
		try {
			TaskAutomatorGui.Add("Picture", "x18 y295 w20 h20 +border", QuickIcon3).OnEvent("Click", SelectNewIcon3)
		}
		catch {
			QuickIcon3 := ""
			IniWrite QuickIcon3, IniFile, "QuickAccessIcons", "QuickIcon3"
			FlagReload := true
		}
		EditQuickAcess3 := TaskAutomatorGui.Add("Edit", "vQuickAccess3 x45 y295 w160 h20")
	} else {
		try {
			TaskAutomatorGui.Add("Picture", "x18 y295 w20 h20 +border", QuickIcon3)
		}
		catch {
			QuickIcon3 := ""
			IniWrite QuickIcon3, IniFile, "QuickAccessIcons", "QuickIcon3"
			FlagReload := true
		}
		EditQuickAcess3 := TaskAutomatorGui.Add("Edit", "vQuickAccess3 x45 y295 w160 h20 +Disabled")
	}
	EditQuickAcess3.Opt("" . BackgroundMainColor . "")
	EditQuickAcess3.Value := QuickAccess3
	if QuickAccessButtons == true {
		QuickAccessButton3 := TaskAutomatorGui.Add("Button", "x210 y295 w30 h20", "Go!")
		QuickAccessButton3.OnEvent("Click", ProccessQuickAccessButton3) 
	} else {
		if HotkeyEditMode == true {
			QuickAccessHk3 := TaskAutomatorGui.Add("Hotkey", "vQuickAccessHk3 x210 y295 w30 h20 +disabled", QuickAccessHk3)
		} else {
			CtrlQuickAccessHk3 := IniRead(AuxHkDataFile, "CtrlHkFlags", "CtrlQuickAccessHk3")
			AltQuickAccessHk3 := IniRead(AuxHkDataFile, "AltHkFlags", "AltQuickAccessHk3")
			ShiftQuickAccessHk3 := IniRead(AuxHkDataFile, "ShiftHkFlags", "ShiftQuickAccessHk3")
			switch true {
			case CtrlQuickAccessHk3 == 1:
				if QuickAccessHk3 == "" {
					QuickAccessHk3 := "Ctrl"
					IniWrite QuickAccessHk3, IniFile, "SavedHotkey", "QuickAccessHk3"
				}
				CtrlQuickAccessHk3 := 0
				IniWrite CtrlQuickAccessHk3, AuxHkDataFile, "CtrlHkFlags", "CtrlQuickAccessHk3"
			case AltQuickAccessHk3 == 1:
				if QuickAccessHk3 == "" {
					QuickAccessHk3 := "Alt"
					IniWrite QuickAccessHk3, IniFile, "SavedHotkey", "QuickAccessHk3"
				}
				AltQuickAccessHk3 := 0
				IniWrite AltQuickAccessHk3, AuxHkDataFile, "AltHkFlags", "AltQuickAccessHk3"
			case ShiftQuickAccessHk3 == 1:
				if QuickAccessHk3 == "" {
					QuickAccessHk3 := "Shift"
					IniWrite QuickAccessHk3, IniFile, "SavedHotkey", "QuickAccessHk3"
				}
				ShiftQuickAccessHk3 := 0
				IniWrite ShiftQuickAccessHk3, AuxHkDataFile, "ShiftHkFlags", "ShiftQuickAccessHk3" 
			case QuickAccessHk3 == "":
				QuickAccessHk3 := "Space"
				IniWrite QuickAccessHk3, IniFile, "SavedHotkey", "QuickAccessHk3"
			}
			
			QuickAccessHk3 := TaskAutomatorGui.Add("Hotkey", "vQuickAccessHk3 x210 y295 w30 h20", QuickAccessHk3).OnEvent("Change", SubmitQuickAccess3)
		}
	}
	;----------------------------------------------------
	TaskAutomatorGui.Add("Text", "x7 y326 h20 +0x200", "4")
	if EditBoxesAvailable == true {
		try {
			TaskAutomatorGui.Add("Picture", "x18 y326 w20 h20 +border", QuickIcon4).OnEvent("Click", SelectNewIcon4)
		}
		catch {
			QuickIcon4 := ""
			IniWrite QuickIcon4, IniFile, "QuickAccessIcons", "QuickIcon4"
			FlagReload := true
		}
		EditQuickAcess4 := TaskAutomatorGui.Add("Edit", "vQuickAccess4 x45 y326 w160 h20")
	} else {
		try {
			TaskAutomatorGui.Add("Picture", "x18 y326 w20 h20 +border", QuickIcon4)
		}
		catch {
			QuickIcon4 := ""
			IniWrite QuickIcon4, IniFile, "QuickAccessIcons", "QuickIcon4"
			FlagReload := true
		}
		EditQuickAcess4 := TaskAutomatorGui.Add("Edit", "vQuickAccess4 x45 y326 w160 h20 +Disabled")
	}
	EditQuickAcess4.Opt("" . BackgroundMainColor . "")
	EditQuickAcess4.Value := QuickAccess4
	if QuickAccessButtons == true {
		QuickAccessButton4 := TaskAutomatorGui.Add("Button", "x210 y326 w30 h20", "Go!")
		QuickAccessButton4.OnEvent("Click", ProccessQuickAccessButton4) 
	} else {
		if HotkeyEditMode == true {
			QuickAccessHk4 := TaskAutomatorGui.Add("Hotkey", "vQuickAccessHk4 x210 y326 w30 h20 +disabled", QuickAccessHk4)
		} else {
			CtrlQuickAccessHk4 := IniRead(AuxHkDataFile, "CtrlHkFlags", "CtrlQuickAccessHk4")
			AltQuickAccessHk4 := IniRead(AuxHkDataFile, "AltHkFlags", "AltQuickAccessHk4")
			ShiftQuickAccessHk4 := IniRead(AuxHkDataFile, "ShiftHkFlags", "ShiftQuickAccessHk4")
			switch true {
			case CtrlQuickAccessHk4 == 1:
				if QuickAccessHk4 == "" {
					QuickAccessHk4 := "Ctrl"
					IniWrite QuickAccessHk4, IniFile, "SavedHotkey", "QuickAccessHk4"
				}
				CtrlQuickAccessHk4 := 0
				IniWrite CtrlQuickAccessHk4, AuxHkDataFile, "CtrlHkFlags", "CtrlQuickAccessHk4"
			case AltQuickAccessHk4 == 1:
				if QuickAccessHk4 == "" {
					QuickAccessHk4 := "Alt"
					IniWrite QuickAccessHk4, IniFile, "SavedHotkey", "QuickAccessHk4"
				}
				AltQuickAccessHk4 := 0
				IniWrite AltQuickAccessHk4, AuxHkDataFile, "AltHkFlags", "AltQuickAccessHk4"
			case ShiftQuickAccessHk4 == 1:
				if QuickAccessHk4 == "" {
					QuickAccessHk4 := "Shift"
					IniWrite QuickAccessHk4, IniFile, "SavedHotkey", "QuickAccessHk4"
				}
				ShiftQuickAccessHk4 := 0
				IniWrite ShiftQuickAccessHk4, AuxHkDataFile, "ShiftHkFlags", "ShiftQuickAccessHk4" 
			case QuickAccessHk4 == "":
				QuickAccessHk4 := "Space"
				IniWrite QuickAccessHk4, IniFile, "SavedHotkey", "QuickAccessHk4"
			}
			
			QuickAccessHk4 := TaskAutomatorGui.Add("Hotkey", "vQuickAccessHk4 x210 y326 w30 h20", QuickAccessHk4).OnEvent("Change", SubmitQuickAccess4)
		}
	}
	;----------------------------------------------------
	TaskAutomatorGui.Add("Text", "x7 y357 h20 +0x200", "5")
	if EditBoxesAvailable == true {
		try {
			TaskAutomatorGui.Add("Picture", "x18 y357 w20 h20 +border", QuickIcon5).OnEvent("Click", SelectNewIcon5)
		}
		catch {
			QuickIcon5 := ""
			IniWrite QuickIcon5, IniFile, "QuickAccessIcons", "QuickIcon5"
			FlagReload := true
		}
		EditQuickAcess5 := TaskAutomatorGui.Add("Edit", "vQuickAccess5 x45 y357 w160 h20")
	} else {
		try {
			TaskAutomatorGui.Add("Picture", "x18 y357 w20 h20 +border", QuickIcon5)
		}
		catch {
			QuickIcon5 := ""
			IniWrite QuickIcon5, IniFile, "QuickAccessIcons", "QuickIcon5"
			FlagReload := true
		}
		EditQuickAcess5 := TaskAutomatorGui.Add("Edit", "vQuickAccess5 x45 y357 w160 h20 +Disabled")
	}
	EditQuickAcess5.Opt("" . BackgroundMainColor . "")
	EditQuickAcess5.Value := QuickAccess5
	if QuickAccessButtons == true {
		QuickAccessButton5 := TaskAutomatorGui.Add("Button", "x210 y357 w30 h20", "Go!")
		QuickAccessButton5.OnEvent("Click", ProccessQuickAccessButton5) 
	} else {
		if HotkeyEditMode == true {
			QuickAccessHk5 := TaskAutomatorGui.Add("Hotkey", "vQuickAccessHk5 x210 y357 w30 h20 +disabled", QuickAccessHk5)
		} else {
			CtrlQuickAccessHk5 := IniRead(AuxHkDataFile, "CtrlHkFlags", "CtrlQuickAccessHk5")
			AltQuickAccessHk5 := IniRead(AuxHkDataFile, "AltHkFlags", "AltQuickAccessHk5")
			ShiftQuickAccessHk5 := IniRead(AuxHkDataFile, "ShiftHkFlags", "ShiftQuickAccessHk5")
			switch true {
			case CtrlQuickAccessHk5 == 1:
				if QuickAccessHk5 == "" {
					QuickAccessHk5 := "Ctrl"
					IniWrite QuickAccessHk5, IniFile, "SavedHotkey", "QuickAccessHk5"
				}
				CtrlQuickAccessHk5 := 0
				IniWrite CtrlQuickAccessHk5, AuxHkDataFile, "CtrlHkFlags", "CtrlQuickAccessHk5"
			case AltQuickAccessHk5 == 1:
				if QuickAccessHk5 == "" {
					QuickAccessHk5 := "Alt"
					IniWrite QuickAccessHk5, IniFile, "SavedHotkey", "QuickAccessHk5"
				}
				AltQuickAccessHk5 := 0
				IniWrite AltQuickAccessHk5, AuxHkDataFile, "AltHkFlags", "AltQuickAccessHk5"
			case ShiftQuickAccessHk5 == 1:
				if QuickAccessHk5 == "" {
					QuickAccessHk5 := "Shift"
					IniWrite QuickAccessHk5, IniFile, "SavedHotkey", "QuickAccessHk5"
				}
				ShiftQuickAccessHk5 := 0
				IniWrite ShiftQuickAccessHk5, AuxHkDataFile, "ShiftHkFlags", "ShiftQuickAccessHk5" 
			case QuickAccessHk5 == "":
				QuickAccessHk5 := "Space"
				IniWrite QuickAccessHk5, IniFile, "SavedHotkey", "QuickAccessHk5"
			}
			
			QuickAccessHk5 := TaskAutomatorGui.Add("Hotkey", "vQuickAccessHk5 x210 y357 w30 h20", QuickAccessHk5).OnEvent("Change", SubmitQuickAccess5)
		}
	}
	;----------------------------------------------------
	TaskAutomatorGui.Add("Text", "x7 y388 h20 +0x200", "6")
	if EditBoxesAvailable == true {
		try {
			TaskAutomatorGui.Add("Picture", "x18 y388 w20 h20 +border", QuickIcon6).OnEvent("Click", SelectNewIcon6)
		}
		catch {
			QuickIcon6 := ""
			IniWrite QuickIcon6, IniFile, "QuickAccessIcons", "QuickIcon6"
			FlagReload := true
		}
		EditQuickAcess6 := TaskAutomatorGui.Add("Edit", "vQuickAccess6 x45 y388 w160 h20")
	} else {
		try {
			TaskAutomatorGui.Add("Picture", "x18 y388 w20 h20 +border", QuickIcon6)
		}
		catch {
			QuickIcon6 := ""
			IniWrite QuickIcon6, IniFile, "QuickAccessIcons", "QuickIcon6"
			FlagReload := true
		}
		EditQuickAcess6 := TaskAutomatorGui.Add("Edit", "vQuickAccess6 x45 y388 w160 h20 +Disabled")
	}
	EditQuickAcess6.Opt("" . BackgroundMainColor . "")
	EditQuickAcess6.Value := QuickAccess6
	if QuickAccessButtons == true {
		QuickAccessButton6 := TaskAutomatorGui.Add("Button", "x210 y388 w30 h20", "Go!")
		QuickAccessButton6.OnEvent("Click", ProccessQuickAccessButton6) 
	} else {
		if HotkeyEditMode == true {
			QuickAccessHk6 := TaskAutomatorGui.Add("Hotkey", "vQuickAccessHk6 x210 y388 w30 h20 +disabled", QuickAccessHk6)
		} else {
			CtrlQuickAccessHk6 := IniRead(AuxHkDataFile, "CtrlHkFlags", "CtrlQuickAccessHk6")
			AltQuickAccessHk6 := IniRead(AuxHkDataFile, "AltHkFlags", "AltQuickAccessHk6")
			ShiftQuickAccessHk6 := IniRead(AuxHkDataFile, "ShiftHkFlags", "ShiftQuickAccessHk6")
			switch true {
			case CtrlQuickAccessHk6 == 1:
				if QuickAccessHk6 == "" {
					QuickAccessHk6 := "Ctrl"
					IniWrite QuickAccessHk6, IniFile, "SavedHotkey", "QuickAccessHk6"
				}
				CtrlQuickAccessHk6 := 0
				IniWrite CtrlQuickAccessHk6, AuxHkDataFile, "CtrlHkFlags", "CtrlQuickAccessHk6"
			case AltQuickAccessHk6 == 1:
				if QuickAccessHk6 == "" {
					QuickAccessHk6 := "Alt"
					IniWrite QuickAccessHk6, IniFile, "SavedHotkey", "QuickAccessHk6"
				}
				AltQuickAccessHk6 := 0
				IniWrite AltQuickAccessHk6, AuxHkDataFile, "AltHkFlags", "AltQuickAccessHk6"
			case ShiftQuickAccessHk6 == 1:
				if QuickAccessHk6 == "" {
					QuickAccessHk6 := "Shift"
					IniWrite QuickAccessHk6, IniFile, "SavedHotkey", "QuickAccessHk6"
				}
				ShiftQuickAccessHk6 := 0
				IniWrite ShiftQuickAccessHk6, AuxHkDataFile, "ShiftHkFlags", "ShiftQuickAccessHk6" 
			case QuickAccessHk6 == "":
				QuickAccessHk6 := "Space"
				IniWrite QuickAccessHk6, IniFile, "SavedHotkey", "QuickAccessHk6"
			}
			
			QuickAccessHk6 := TaskAutomatorGui.Add("Hotkey", "vQuickAccessHk6 x210 y388 w30 h20", QuickAccessHk6).OnEvent("Change", SubmitQuickAccess6)
		}
	}
	;----------------------------------------------------
	TaskAutomatorGui.Add("Text", "x7 y419 h20 +0x200", "7")
	if EditBoxesAvailable == true {
		try {
			TaskAutomatorGui.Add("Picture", "x18 y419 w20 h20 +border", QuickIcon7).OnEvent("Click", SelectNewIcon7)
		}
		catch {
			QuickIcon7 := ""
			IniWrite QuickIcon7, IniFile, "QuickAccessIcons", "QuickIcon7"
			FlagReload := true
		}
		EditQuickAcess7 := TaskAutomatorGui.Add("Edit", "vQuickAccess7 x45 y419 w160 h20")
	} else {
		try {
			TaskAutomatorGui.Add("Picture", "x18 y419 w20 h20 +border", QuickIcon7)
		}
		catch {
			QuickIcon7 := ""
			IniWrite QuickIcon7, IniFile, "QuickAccessIcons", "QuickIcon7"
			FlagReload := true
		}
		EditQuickAcess7 := TaskAutomatorGui.Add("Edit", "vQuickAccess7 x45 y419 w160 h20 +Disabled")
	}
	EditQuickAcess7.Opt("" . BackgroundMainColor . "")
	EditQuickAcess7.Value := QuickAccess7
	if QuickAccessButtons == true {
		QuickAccessButton7 := TaskAutomatorGui.Add("Button", "x210 y419 w30 h20", "Go!")
		QuickAccessButton7.OnEvent("Click", ProccessQuickAccessButton7) 
	} else {
		if HotkeyEditMode == true {
			QuickAccessHk7 := TaskAutomatorGui.Add("Hotkey", "vQuickAccessHk7 x210 y419 w30 h20 +disabled", QuickAccessHk7)
		} else {
			CtrlQuickAccessHk7 := IniRead(AuxHkDataFile, "CtrlHkFlags", "CtrlQuickAccessHk7")
			AltQuickAccessHk7 := IniRead(AuxHkDataFile, "AltHkFlags", "AltQuickAccessHk7")
			ShiftQuickAccessHk7 := IniRead(AuxHkDataFile, "ShiftHkFlags", "ShiftQuickAccessHk7")
			switch true {
			case CtrlQuickAccessHk7 == 1:
				if QuickAccessHk7 == "" {
					QuickAccessHk7 := "Ctrl"
					IniWrite QuickAccessHk7, IniFile, "SavedHotkey", "QuickAccessHk7"
				}
				CtrlQuickAccessHk7 := 0
				IniWrite CtrlQuickAccessHk7, AuxHkDataFile, "CtrlHkFlags", "CtrlQuickAccessHk7"
			case AltQuickAccessHk7 == 1:
				if QuickAccessHk7 == "" {
					QuickAccessHk7 := "Alt"
					IniWrite QuickAccessHk7, IniFile, "SavedHotkey", "QuickAccessHk7"
				}
				AltQuickAccessHk7 := 0
				IniWrite AltQuickAccessHk7, AuxHkDataFile, "AltHkFlags", "AltQuickAccessHk7"
			case ShiftQuickAccessHk7 == 1:
				if QuickAccessHk7 == "" {
					QuickAccessHk7 := "Shift"
					IniWrite QuickAccessHk7, IniFile, "SavedHotkey", "QuickAccessHk7"
				}
				ShiftQuickAccessHk7 := 0
				IniWrite ShiftQuickAccessHk7, AuxHkDataFile, "ShiftHkFlags", "ShiftQuickAccessHk7" 
			case QuickAccessHk7 == "":
				QuickAccessHk7 := "Space"
				IniWrite QuickAccessHk7, IniFile, "SavedHotkey", "QuickAccessHk7"
			}
			
			QuickAccessHk7 := TaskAutomatorGui.Add("Hotkey", "vQuickAccessHk7 x210 y419 w30 h20", QuickAccessHk7).OnEvent("Change", SubmitQuickAccess7)
		}
	}
	;----------------------------------------------------
	TaskAutomatorGui.Add("Text", "x7 y450 h20 +0x200", "8")
	if EditBoxesAvailable == true {
		try {
			TaskAutomatorGui.Add("Picture", "x18 y450 w20 h20 +border", QuickIcon8).OnEvent("Click", SelectNewIcon8)
		}
		catch {
			QuickIcon8 := ""
			IniWrite QuickIcon8, IniFile, "QuickAccessIcons", "QuickIcon8"
			FlagReload := true
		}
		EditQuickAcess8 := TaskAutomatorGui.Add("Edit", "vQuickAccess8 x45 y450 w160 h20")
	} else {
		try {
			TaskAutomatorGui.Add("Picture", "x18 y450 w20 h20 +border", QuickIcon8)
		}
		catch {
			QuickIcon8 := ""
			IniWrite QuickIcon8, IniFile, "QuickAccessIcons", "QuickIcon8"
			FlagReload := true
		}
		EditQuickAcess8 := TaskAutomatorGui.Add("Edit", "vQuickAccess8 x45 y450 w160 h20 +Disabled")
	}
	EditQuickAcess8.Opt("" . BackgroundMainColor . "")
	EditQuickAcess8.Value := QuickAccess8
	if QuickAccessButtons == true {
		QuickAccessButton8 := TaskAutomatorGui.Add("Button", "x210 y450 w30 h20", "Go!")
		QuickAccessButton8.OnEvent("Click", ProccessQuickAccessButton8) 
	} else {
		if HotkeyEditMode == true {
			QuickAccessHk8 := TaskAutomatorGui.Add("Hotkey", "vQuickAccessHk8 x210 y450 w30 h20 +disabled", QuickAccessHk8)
		} else {
			CtrlQuickAccessHk8 := IniRead(AuxHkDataFile, "CtrlHkFlags", "CtrlQuickAccessHk8")
			AltQuickAccessHk8 := IniRead(AuxHkDataFile, "AltHkFlags", "AltQuickAccessHk8")
			ShiftQuickAccessHk8 := IniRead(AuxHkDataFile, "ShiftHkFlags", "ShiftQuickAccessHk8")
			switch true {
			case CtrlQuickAccessHk8 == 1:
				if QuickAccessHk8 == "" {
					QuickAccessHk8 := "Ctrl"
					IniWrite QuickAccessHk8, IniFile, "SavedHotkey", "QuickAccessHk8"
				}
				CtrlQuickAccessHk8 := 0
				IniWrite CtrlQuickAccessHk8, AuxHkDataFile, "CtrlHkFlags", "CtrlQuickAccessHk8"
			case AltQuickAccessHk8 == 1:
				if QuickAccessHk8 == "" {
					QuickAccessHk8 := "Alt"
					IniWrite QuickAccessHk8, IniFile, "SavedHotkey", "QuickAccessHk8"
				}
				AltQuickAccessHk8 := 0
				IniWrite AltQuickAccessHk8, AuxHkDataFile, "AltHkFlags", "AltQuickAccessHk8"
			case ShiftQuickAccessHk8 == 1:
				if QuickAccessHk8 == "" {
					QuickAccessHk8 := "Shift"
					IniWrite QuickAccessHk8, IniFile, "SavedHotkey", "QuickAccessHk8"
				}
				ShiftQuickAccessHk8 := 0
				IniWrite ShiftQuickAccessHk8, AuxHkDataFile, "ShiftHkFlags", "ShiftQuickAccessHk8" 
			case QuickAccessHk8 == "":
				QuickAccessHk8 := "Space"
				IniWrite QuickAccessHk8, IniFile, "SavedHotkey", "QuickAccessHk8"
			}
			
			QuickAccessHk8 := TaskAutomatorGui.Add("Hotkey", "vQuickAccessHk8 x210 y450 w30 h20", QuickAccessHk8).OnEvent("Change", SubmitQuickAccess8)
		}
	}
	;----------------------------------------------------
	TaskAutomatorGui.Add("Text", "x7 y481 h20 +0x200", "9")
	if EditBoxesAvailable == true {
		try {
			TaskAutomatorGui.Add("Picture", "x18 y481 w20 h20 +border", QuickIcon9).OnEvent("Click", SelectNewIcon9)
		}
		catch {
			QuickIcon9 := ""
			IniWrite QuickIcon9, IniFile, "QuickAccessIcons", "QuickIcon9"
			FlagReload := true
		}
		EditQuickAcess9 := TaskAutomatorGui.Add("Edit", "vQuickAccess9 x45 y481 w160 h20")
	} else {
		try {
			TaskAutomatorGui.Add("Picture", "x18 y481 w20 h20 +border", QuickIcon9)
		}
		catch {
			QuickIcon9 := ""
			IniWrite QuickIcon9, IniFile, "QuickAccessIcons", "QuickIcon9"
			FlagReload := true
		}
		EditQuickAcess9 := TaskAutomatorGui.Add("Edit", "vQuickAccess9 x45 y481 w160 h20 +Disabled")
	}
	if FlagReload == true {
		Reload
	}
	EditQuickAcess9.Opt("" . BackgroundMainColor . "")
	EditQuickAcess9.Value := QuickAccess9
	if QuickAccessButtons == true {
		QuickAccessButton9 := TaskAutomatorGui.Add("Button", "x210 y481 w30 h20", "Go!")
		QuickAccessButton9.OnEvent("Click", ProccessQuickAccessButton9) 
	} else {
		if HotkeyEditMode == true {
			QuickAccessHk9 := TaskAutomatorGui.Add("Hotkey", "vQuickAccessHk9 x210 y481 w30 h20 +disabled", QuickAccessHk9)
		} else {
			CtrlQuickAccessHk9 := IniRead(AuxHkDataFile, "CtrlHkFlags", "CtrlQuickAccessHk9")
			AltQuickAccessHk9 := IniRead(AuxHkDataFile, "AltHkFlags", "AltQuickAccessHk9")
			ShiftQuickAccessHk9 := IniRead(AuxHkDataFile, "ShiftHkFlags", "ShiftQuickAccessHk9")
			switch true {
			case CtrlQuickAccessHk9 == 1:
				if QuickAccessHk9 == "" {
					QuickAccessHk9 := "Ctrl"
					IniWrite QuickAccessHk9, IniFile, "SavedHotkey", "QuickAccessHk9"
				}
				CtrlQuickAccessHk9 := 0
				IniWrite CtrlQuickAccessHk9, AuxHkDataFile, "CtrlHkFlags", "CtrlQuickAccessHk9"
			case AltQuickAccessHk9 == 1:
				if QuickAccessHk9 == "" {
					QuickAccessHk9 := "Alt"
					IniWrite QuickAccessHk9, IniFile, "SavedHotkey", "QuickAccessHk9"
				}
				AltQuickAccessHk9 := 0
				IniWrite AltQuickAccessHk9, AuxHkDataFile, "AltHkFlags", "AltQuickAccessHk9"
			case ShiftQuickAccessHk9 == 1:
				if QuickAccessHk9 == "" {
					QuickAccessHk9 := "Shift"
					IniWrite QuickAccessHk9, IniFile, "SavedHotkey", "QuickAccessHk9"
				}
				ShiftQuickAccessHk9 := 0
				IniWrite ShiftQuickAccessHk9, AuxHkDataFile, "ShiftHkFlags", "ShiftQuickAccessHk9" 
			case QuickAccessHk9 == "":
				QuickAccessHk9 := "Space"
				IniWrite QuickAccessHk9, IniFile, "SavedHotkey", "QuickAccessHk9"
			}
			
			QuickAccessHk9 := TaskAutomatorGui.Add("Hotkey", "vQuickAccessHk9 x210 y481 w30 h20", QuickAccessHk9).OnEvent("Change", SubmitQuickAccess9)
		}
	}
case SwitchModulesOFF:
	try {
		OptionsMenu.SetIcon("2. Switch &Clicker", IconLib . "\Switch2.ico")
		OptionsMenu.SetIcon("3. Switch &Jumps", IconLib . "\Switch2.ico")
		OptionsMenu.SetIcon("1. Switch Quick &Access", IconLib . "\Switch2.ico")
		OptionsMenu.SetIcon("Switch Secure Edit &Boxes && Icons: On/Off", IconLib . "\EditBox2.png")
		OptionsMenu.SetIcon("4. Switch Bottom Mo&dules OFF", IconLib . "\Switch1.ico")
	}
	catch {
	}
	SwitchQuickAccess := 0
	SwitchClicker := 0
	SwitchJumps := 0
	SwitchModulesOFF := 1
	if EditBoxesAvailable == true {
		OptionsMenu.SetIcon("Switch Secure Edit &Boxes && Icons: On/Off", IconLib . "\EditBox2.png")
		try {
			TaskAutomatorGui.Add("Picture", "x9 y230 w230 h271 +border", BottomPicture).OnEvent("Click", SelectBottomPicture)
		}
		catch {
			BottomPicture := ""
			IniWrite BottomPicture, IniFile, "Pictures", "BottomPicture"
			Reload
		}
	} else {
		OptionsMenu.SetIcon("Switch Secure Edit &Boxes && Icons: On/Off", IconLib . "\EditBox1.png")
		try {
			TaskAutomatorGui.Add("Picture", "x9 y230 w230 h271 +border", BottomPicture)
		}
		catch {
			BottomPicture := ""
			IniWrite BottomPicture, IniFile, "Pictures", "BottomPicture"
			Reload
		}
	}
}
;----------------------------------------------------
; Save All EditBox Values
TaskAutomatorGui.Add("Text", "x1 y510 w250 h2 +0x10") ; Separator
SaveButton := TaskAutomatorGui.Add("Button", "x70 y516 h20", "Save Current Values")
SaveButton.OnEvent("Click", SubmitValues)
;----------------------------------------------------
; Check for updates
; A_Now - The current local time in YYYYMMDDHH24MISS format.
;-------------------------------
TaskAutomatorGui.Add("Text", "x1 y539 w250 h2 +0x10") ; Separator
FlagCheckTime := false
if CheckforUpdatesDaily == true and 
	(LastUpdateCheckTimeStamp == "" or DateDiff(A_Now, LastUpdateCheckTimeStamp, "Days") > 0) {
	FlagCheckTime := true
} 
;-------------------------------
if CheckforupdatesWeekly == true and 
	(LastUpdateCheckTimeStamp == "" or DateDiff(A_Now, LastUpdateCheckTimeStamp, "Days") > 6) {
	FlagCheckTime := true
}

switch true {
case NeverCheckForUpdates == true:
	TaskAutomatorGui.Add("Text","x10 y544 h20 +0x200", "Update check: ")
	TaskAutomatorGui.SetFont("s8 Bold c00A8F3", LicenseKeyFontType)
	TaskAutomatorGui.Add("Text","x97 y544 w126 h20 +0x200", " Update check disabled ")
	try {
		TaskAutomatorGui.Add("Picture", "x230 y548 w10 h10 +border", IconLib . "\UpdateCheckDisabled.png")
	}
	catch {
	}
case NeedUpdate == true:
	TaskAutomatorGui.Add("Text","x10 y544 h20 +0x200", "Update check: ")
	TaskAutomatorGui.SetFont("s8 Bold cYellow", LicenseKeyFontType)
	TaskAutomatorGui.Add("Text","x97 y544 w126 h20 +0x200", " New version available ")
	try {
		TaskAutomatorGui.Add("Picture", "x230 y548 w10 h10 +border", IconLib . "\NewVersionAvailable.png")
	}
	catch {
	}
case FlagCheckTime == false and NeedUpdate == false:
	TaskAutomatorGui.Add("Text","x10 y544 h20 +0x200", "Update check: ")
	TaskAutomatorGui.SetFont("s8 Bold cLime", LicenseKeyFontType)
	TaskAutomatorGui.Add("Text","x97 y544 w126 h20 +0x200", " Version up to date ")
	try {
		TaskAutomatorGui.Add("Picture", "x230 y548 w10 h10 +border", IconLib . "\UpToDate.png")
	}
	catch {
	}
}
;-------------------------------
if FlagCheckTime == true {
	Connected := CheckConnection()
	if Connected != true {
		TaskAutomatorGui.Add("Text","x10 y544 h20 +0x200", "Update check: ")
		TaskAutomatorGui.SetFont("s8 Bold cRed", LicenseKeyFontType)
		TaskAutomatorGui.Add("Text","x97 y544 h20 +0x200", " No internet connection ")
		try {
			TaskAutomatorGui.Add("Picture", "x230 y548 w10 h10 +border", IconLib . "\NoInternetConnection.png")
		}
		catch {
		}
	} else {
		if !FileExist(DataFile) {
			ParseRequest()
		}
		MLTALatestReleaseVersion := IniRead(DataFile, "GeneralData", "MLTALatestReleaseVersion")
		if MLTALatestReleaseVersion == "" {
			ParseRequest()
		}
		DownloadUrl := IniRead(DataFile, "EncriptedData", "MLTADownload")
		MLTALatestReleaseVersion := IniRead(DataFile, "GeneralData", "MLTALatestReleaseVersion")
		if MLTALatestReleaseVersion != CurrentVersion {
			if DownloadUrl != "" {
				TaskAutomatorGui.Add("Text","x10 y544 h20 +0x200", "Update check: ")
				TaskAutomatorGui.SetFont("s8 Bold cYellow", LicenseKeyFontType)
				TaskAutomatorGui.Add("Text","x101 y544 h20 +0x200", " New version available ")
				TaskAutomatorGui.Add("Picture", "x230 y548 w10 h10 +border", IconLib . "\NewVersionAvailable.png")
				NeedUpdate := true
				IniWrite NeedUpdate, IniFile, "Settings", "NeedUpdate"
			}
		}
		if MLTALatestReleaseVersion == CurrentVersion {
			TaskAutomatorGui.Add("Text","x10 y544 h20 +0x200", "Update check: ")
			TaskAutomatorGui.SetFont("s8 Bold cLime", LicenseKeyFontType)
			TaskAutomatorGui.Add("Text","x130 y544 h20 +0x200", " Up to date ")
			TaskAutomatorGui.Add("Picture", "x230 y548 w10 h10 +border", IconLib . "\UpToDate.png")
		}
		IniWrite A_Now, IniFile, "Settings", "LastUpdateCheckTimeStamp"
	}
}
;----------------------------------------------------
SB := TaskAutomatorGui.Add("StatusBar", , "Ready.")
;----------------------------------------------------
TaskAutomatorGui.OnEvent('Close', (*) => ExitApp())
TaskAutomatorGui.Title := AppName
TaskAutomatorGui.Show("x" . PositionX . " y" . PositionY . "w250 h590")
Saved := TaskAutomatorGui.Submit(false)
CoordMode "Mouse", "Screen"
;----------------------------------------------------
OnExit ExitMenu
ExitMenu(ExitReason,ExitCode)
{
	SB.SetText("Quiting..")
	TaskAutomatorGui.GetPos(&PosX, &PosY)
	if PosX != -32000 {
		IniWrite PosX, IniFile, "Properties", "PositionX"
	}
	if PosY != -32000 {
		IniWrite PosY, IniFile, "Properties", "PositionY"
	}
	If ExitReason == "Reload" {
		return 0
	}
	try {
		FileDelete DataFile
		FileDelete TempCleanFileMLTA
	}
	catch {
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

if FlagError == 0 {
	StringMacAddress := MacAddress[Count]
} else {
	StringMacAddress := MacAddress
}

LicenseKey := EncriptMsg(StringMacAddress)

try {
	LicenseKeyInFile := IniRead(LicenseFile, "Data", "LicenseKey")
}
catch as e {
	; License file is missing
	ExitApp(3)
}

Switch true {
case LicenseKeyInFile == "":
	IniWrite LicenseKey, LicenseFile, "Data", "LicenseKey"
case LicenseKeyInFile == LicenseKey:
case LicenseKeyInFile != LicenseKey:
	; Invalid License
	ExitApp(2)
}

try {
	FileDelete TempFile
}
catch {

}
;----------------------------------------------------
if SwitchKbAutoRun == true {
	Hotkey Saved.StartAutoRunHotkey, (ThisHotkey) => ProcessRunWalkHotkey(RunSelected := true, ThisHotkey)
}
Switch true {
case SwitchJumps:
	Hotkey Saved.JumpHotkey0, (ThisHotkey) => ProcessJumpHotkey0(ThisHotkey)
	Hotkey Saved.JumpHotkey1, (ThisHotkey) => ProcessJumpHotkey1(ThisHotkey)
	Hotkey Saved.JumpHotkey2, (ThisHotkey) => ProcessJumpHotkey2(ThisHotkey)
	Hotkey Saved.JumpHotkey3, (ThisHotkey) => ProcessJumpHotkey3(ThisHotkey)
	Hotkey Saved.JumpHotkey4, (ThisHotkey) => ProcessJumpHotkey4(ThisHotkey)
case SwitchClicker:
	Hotkey Saved.PatternClickerHotkey, (ThisHotkey) => ProcessPatternClicker(ThisHotkey)
case SwitchQuickAccess:
	if QuickAccessButtons == false {
		Hotkey Saved.QuickAccessHk1, (ThisHotkey) => ProcessQuickAccess(ThisHotkey)
		Hotkey Saved.QuickAccessHk2, (ThisHotkey) => ProcessQuickAccess(ThisHotkey)
		Hotkey Saved.QuickAccessHk3, (ThisHotkey) => ProcessQuickAccess(ThisHotkey)
		Hotkey Saved.QuickAccessHk4, (ThisHotkey) => ProcessQuickAccess(ThisHotkey)
		Hotkey Saved.QuickAccessHk5, (ThisHotkey) => ProcessQuickAccess(ThisHotkey)
		Hotkey Saved.QuickAccessHk6, (ThisHotkey) => ProcessQuickAccess(ThisHotkey)
		Hotkey Saved.QuickAccessHk7, (ThisHotkey) => ProcessQuickAccess(ThisHotkey)
		Hotkey Saved.QuickAccessHk8, (ThisHotkey) => ProcessQuickAccess(ThisHotkey)
		Hotkey Saved.QuickAccessHk9, (ThisHotkey) => ProcessQuickAccess(ThisHotkey)
	}
case SwitchModulesOFF:
}
;----------------------------------------------------
ExitMsg(*){
	ShowExit:
		if GuiPriorityAlwaysOnTop == true {
			Exitmsg := Gui("+AlwaysOnTop")
		} else {
			Exitmsg := Gui()
		}
		Exitmsg.BackColor := "0x" . BackgroundColor
		MessageBackgroundPicture := IniRead(IniFile, "Background", "MessageBackgroundPicture")
		if MessageBackgroundPicture == "" {
			try {
				Exitmsg.Add("Picture", "x0 y0 w470 h240 +BackgroundTrans", ImageLib . DefaultMsgBackgroundImage)
			}
			catch {
			}
		} else {
			try {
				Exitmsg.Add("Picture", "x0 y0 w470 h240 +BackgroundTrans", MessageBackgroundPicture)
			}
			catch {
				MessageBackgroundPicture := ""
				IniWrite MessageBackgroundPicture, IniFile, "Background", "MessageBackgroundPicture"
				Reload
			}
		}
		try {
			Exitmsg.Add("Picture", "x9 y14 w64 h64 +border", IconLib . MLSoftwareIcon)
		}
		catch {
		}
		Exitmsg.SetFont("s20 W700 Q4 " . MessageAppNameFontColor, MessageAppNameFontType)
		Exitmsg.Add("Text", "x80 y8", AppName)
		Exitmsg.SetFont("s9 " . MessageFontColor, MessageFontType)
		Exitmsg.Add("Text", "x80 y45", "Mean Little's Task Automator " CurrentVersion)
		Exitmsg.Add("Text", "x80 y65", "License key: ")
		Exitmsg.SetFont()
		Exitmsg.SetFont("s8 Bold " . LicenseKeyFontColor, LicenseKeyFontType)
		Exitmsg.Add("Text", "x160 y65", LicenseKey)
		Exitmsg.Add("Text", "x0 y90 w470 h1 +0x5")
		Exitmsg.SetFont()
		Exitmsg.SetFont("s12 " . MessageMainMsgFontColor, MessageMainMsgFontType)
		Exitmsg.Add("Text", "x80 y110", "ML Task Automator will close in " ExitMessageTimeWait / 1000 " seconds")
        Exitmsg.Add("Text", "x175 y140", "Have a nice day!")
		Exitmsg.SetFont()
		Exitmsg.SetFont("s9 " . MessageFontColor, MessageFontType)
		Exitmsg.Add("Text", "x0 y180 w470 h1 +0x5")
		Exitmsg.Add("Text", "x107 y190", "Copyright 2024 FDJ-Dash. All Rights Reserved.")
		Exitmsg.SetFont()
		Exitmsg.SetFont("s8 " . MessageFontColor, MessageFontType)
		Exitmsg.Add("Text", "x116 y212", "Made with AutoHotkey V" A_AhkVersion . " " . (1 ? "Unicode" : "ANSI") . " " . (A_PtrSize == 8 ? "64-bit" : "32-bit"))
        Exitmsg.Title := "Goodbye!"
		TaskAutomatorGui.GetPos(&PosX, &PosY)
		if PosX == -32000 {
			PosX := IniRead(IniFile, "Properties", "PositionX")
		}
		if PosY == -32000 {
			PosY := IniRead(IniFile, "Properties", "PositionY")
		}
        Exitmsg.Show("x" . PosX - 150 . " y" . PosY + 220 . "w470 h240")
        Exitmsg.Opt("+LastFound")
    Return
}
;----------------------------------------------------
InvalidLicenseMsg(*){
	ShowLicense:
		if GuiPriorityAlwaysOnTop == true {
			InvLicMsg := Gui("+AlwaysOnTop")
		} else {
			InvLicMsg := Gui()
		}
		InvLicMsg.BackColor := "0x" . BackgroundColor
		MessageBackgroundPicture := IniRead(IniFile, "Background", "MessageBackgroundPicture")
		if MessageBackgroundPicture == "" {
			try {
				InvLicMsg.Add("Picture", "x0 y0 w470 h240", ImageLib . DefaultMsgBackgroundImage)
			}
			catch {
			}
		} else {
			try {
				InvLicMsg.Add("Picture", "x0 y0 w470 h240", MessageBackgroundPicture)
			}
			catch {
				MessageBackgroundPicture := ""
				IniWrite MessageBackgroundPicture, IniFile, "Background", "MessageBackgroundPicture"
				Reload
			}
		}
		try {
			InvLicMsg.Add("Picture", "x9 y14 w64 h64 +border", IconLib . MLSoftwareIcon)
		}
		catch {
		}
		InvLicMsg.SetFont("s20 W700 Q4 " . MessageAppNameFontColor, MessageAppNameFontType)
        InvLicMsg.Add("Text", "x80 y8", AppName)
		InvLicMsg.SetFont("s9 " . MessageFontColor, MessageFontType)
		InvLicMsg.Add("Text", "x80 y45", "Mean Little's Task Automator " CurrentVersion)
		InvLicMsg.Add("Text", "x80 y65", "License key: ")
		InvLicMsg.SetFont()
		InvLicMsg.SetFont("s8 Bold cRed", LicenseKeyFontType)
		InvLicMsg.Add("Text", "x160 y65", "???")
		InvLicMsg.Add("Text", "x0 y90 w470 h1 +0x5")
		InvLicMsg.SetFont()
		InvLicMsg.SetFont("s12 cRed", MessageMainMsgFontType)
		InvLicMsg.Add("Text", "x167 y110", "Invalid License Key")
        InvLicMsg.Add("Text", "x80 y140", "ML Task Automator will close in " ExitMessageTimeWait / 1000 " seconds")
		InvLicMsg.SetFont()
		InvLicMsg.SetFont("s9 " . MessageFontColor, MessageFontType)
		InvLicMsg.Add("Text", "x0 y180 w470 h1 +0x5")
		InvLicMsg.Add("Text", "x100 y190", "Copyright 2024 FDJ-Dash. All Rights Reserved.")
		InvLicMsg.SetFont()
		InvLicMsg.SetFont("s8 " . MessageFontColor, MessageFontType)
		InvLicMsg.Add("Text", "x120 y212", "Made with AutoHotkey V" A_AhkVersion . " " . (1 ? "Unicode" : "ANSI") . " " . (A_PtrSize == 8 ? "64-bit" : "32-bit"))
        InvLicMsg.Title := "Invalid License Key!"
		TaskAutomatorGui.GetPos(&PosX, &PosY)
        InvLicMsg.Show("x" . PosX - 150 . " y" . PosY + 220 . "w470 h240")
        InvLicMsg.Opt("+LastFound")
    Return
}
;----------------------------------------------------
LicenseFileMissingMsg(*){
	ShowMissingLicFile:
		if GuiPriorityAlwaysOnTop == true {
			NoLicFileMsg := Gui("+AlwaysOnTop")
		} else {
			NoLicFileMsg := Gui()
		}
		NoLicFileMsg.BackColor := "0x" . BackgroundColor
		MessageBackgroundPicture := IniRead(IniFile, "Background", "MessageBackgroundPicture")
		if MessageBackgroundPicture == "" {
			try {
				NoLicFileMsg.Add("Picture", "x0 y0 w470 h240", ImageLib . DefaultMsgBackgroundImage)
			}
			catch {
			}
		} else {
			try {
				NoLicFileMsg.Add("Picture", "x0 y0 w470 h240", MessageBackgroundPicture)
			}
			catch {
				MessageBackgroundPicture := ""
				IniWrite MessageBackgroundPicture, IniFile, "Background", "MessageBackgroundPicture"
				Reload
			}
		}
		try {
			NoLicFileMsg.Add("Picture", "x9 y14 w64 h64 +border", IconLib . MLSoftwareIcon)
		}
		catch {
		}
		NoLicFileMsg.SetFont("s20 W700 Q4 " . MessageAppNameFontColor, MessageAppNameFontType)
        NoLicFileMsg.Add("Text", "x80 y8", AppName)
		NoLicFileMsg.SetFont("s9 " . MessageFontColor, MessageFontType)
		NoLicFileMsg.Add("Text", "x80 y45", "Mean Little's Task Automator " CurrentVersion)
		NoLicFileMsg.Add("Text", "x80 y65", "License key: ")
		NoLicFileMsg.SetFont()
		NoLicFileMsg.SetFont("s8 Bold cRed", LicenseKeyFontType)
		NoLicFileMsg.Add("Text", "x160 y65", "???")
		NoLicFileMsg.Add("Text", "x0 y90 w470 h1 +0x5")
		NoLicFileMsg.SetFont()
		NoLicFileMsg.SetFont("s12 cRed", MessageMainMsgFontType)
		NoLicFileMsg.Add("Text", "x160 y110", "License file not found")
        NoLicFileMsg.Add("Text", "x80 y140", "ML Task Automator will close in " ExitMessageTimeWait / 1000 " seconds")
		NoLicFileMsg.SetFont()
		NoLicFileMsg.SetFont("s9 " . MessageFontColor, MessageFontType)
		NoLicFileMsg.Add("Text", "x0 y180 w470 h1 +0x5")
		NoLicFileMsg.Add("Text", "x100 y190", "Copyright 2024 FDJ-Dash. All Rights Reserved.")
		NoLicFileMsg.SetFont()
		NoLicFileMsg.SetFont("s8 " . MessageFontColor, MessageFontType)
		NoLicFileMsg.Add("Text", "x120 y212", "Made with AutoHotkey V" A_AhkVersion . " " . (1 ? "Unicode" : "ANSI") . " " . (A_PtrSize == 8 ? "64-bit" : "32-bit"))
        NoLicFileMsg.Title := "Invalid License Key!"
		TaskAutomatorGui.GetPos(&PosX, &PosY)
        NoLicFileMsg.Show("x" . PosX - 150 . " y" . PosY + 220 . "w470 h240")
        NoLicFileMsg.Opt("+LastFound")
    Return
}
;----------------------------------------------------
InvalidPath(*){
	ShowInvPath:
		if GuiPriorityAlwaysOnTop == true {
			InvPathmsg := Gui("+AlwaysOnTop")
		} else {
			InvPathmsg := Gui()
		}
		InvPathmsg.BackColor := "0x" . BackgroundColor
		MessageBackgroundPicture := IniRead(IniFile, "Background", "MessageBackgroundPicture")
		if MessageBackgroundPicture == "" {
			try {
				InvPathmsg.Add("Picture", "x0 y0 w470 h240", ImageLib . DefaultMsgBackgroundImage)
			}
			catch {
			}
		} else {
			try {
				InvPathmsg.Add("Picture", "x0 y0 w470 h240", MessageBackgroundPicture)
			}
			catch {
				MessageBackgroundPicture := ""
				IniWrite MessageBackgroundPicture, IniFile, "Background", "MessageBackgroundPicture"
				Reload
			}
		}
		try {
			InvPathmsg.Add("Picture", "x9 y14 w64 h64 +border", IconLib . MLSoftwareIcon)
		}
		catch {
		}
		InvPathmsg.SetFont("s20 W700 Q4 " . MessageAppNameFontColor, MessageAppNameFontType)
        InvPathmsg.Add("Text", "x80 y8", AppName)
		InvPathmsg.SetFont("s9 " . MessageFontColor, MessageFontType)
		InvPathmsg.Add("Text", "x80 y45", "Mean Little's Task Automator " CurrentVersion)
		InvPathmsg.Add("Text", "x80 y65", "License key: ")
		InvPathmsg.SetFont()
		InvPathmsg.SetFont("s8 Bold " . LicenseKeyFontColor, LicenseKeyFontType)
		InvPathmsg.Add("Text", "x160 y65", LicenseKey)
		InvPathmsg.Add("Text", "x0 y90 w470 h1 +0x5")
		InvPathmsg.SetFont()
		InvPathmsg.SetFont("s12 " . MessageMainMsgFontColor, MessageMainMsgFontType)
		InvPathmsg.Add("Text", "x145 y125", "Your path input is invalid.")
		InvPathmsg.SetFont()
		InvPathmsg.SetFont("s9 " . MessageFontColor, MessageFontType)
		InvPathmsg.Add("Text", "x0 y180 w470 h1 +0x5")
		InvPathmsg.Add("Text", "x25 y190", "Copyright 2024 FDJ-Dash. All Rights Reserved.")
		InvPathmsg.SetFont()
		InvPathmsg.SetFont("s8 " . MessageFontColor, MessageFontType)
		InvPathmsg.Add("Text", "x25 y212", "Made with AutoHotkey V" A_AhkVersion . " " . (1 ? "Unicode" : "ANSI") . " " . (A_PtrSize == 8 ? "64-bit" : "32-bit"))
        ogcButtonOK := InvPathmsg.Add("Button", "x370 y200 w80 h24", "OK")
		ogcButtonOK.OnEvent("Click", Destroy)
		InvPathmsg.Title := "Invalid path"
		TaskAutomatorGui.GetPos(&PosX, &PosY)
        InvPathmsg.Show("x" . PosX - 150 . " y" . PosY + 220 . "w470 h240")
		ControlFocus("Button1", "Invalid path")
        InvPathmsg.Opt("+LastFound")
    Return
	Destroy(*){
		InvPathmsg.Destroy()
	}
}
;----------------------------------------------------
DuplicatedHotkeyValue(*){
	ShowDupHotkey:
		if GuiPriorityAlwaysOnTop == true {
			DupHkValue := Gui("+AlwaysOnTop")
		} else {
			DupHkValue := Gui()
		}
		DupHkValue.BackColor := "0x" . BackgroundColor
		MessageBackgroundPicture := IniRead(IniFile, "Background", "MessageBackgroundPicture")
		if MessageBackgroundPicture == "" {
			try {
				DupHkValue.Add("Picture", "x0 y0 w470 h240", ImageLib . DefaultMsgBackgroundImage)
			}
			catch {
			}
		} else {
			try {
				DupHkValue.Add("Picture", "x0 y0 w470 h240", MessageBackgroundPicture)
			}
			catch {
				MessageBackgroundPicture := ""
				IniWrite MessageBackgroundPicture, IniFile, "Background", "MessageBackgroundPicture"
				Reload
			}
		}
		try {
			DupHkValue.Add("Picture", "x9 y14 w64 h64 +border", IconLib . MLSoftwareIcon)
		}
		catch {
		}
		DupHkValue.SetFont("s20 W700 Q4 " . MessageAppNameFontColor, MessageAppNameFontType)
        DupHkValue.Add("Text", "x80 y8", AppName)
		DupHkValue.SetFont("s9 " . MessageFontColor, MessageFontType)
		DupHkValue.Add("Text", "x80 y45", "Mean Little's Task Automator " CurrentVersion)
		DupHkValue.Add("Text", "x80 y65", "License key: ")
		DupHkValue.SetFont()
		DupHkValue.SetFont("s8 Bold " . LicenseKeyFontColor, LicenseKeyFontType)
		DupHkValue.Add("Text", "x160 y65", LicenseKeyInFile)
		DupHkValue.Add("Text", "x0 y90 w470 h1 +0x5")
		DupHkValue.SetFont()
		DupHkValue.SetFont("s12 cRed", MessageMainMsgFontType)
		DupHkValue.Add("Text", "x40 y110", "Duplicated hotkey values is a dangerous configuration")
		DupHkValue.Add("Text", "x135 y140", "Returning to default values")
		DupHkValue.SetFont()
		DupHkValue.SetFont("s9 " . MessageFontColor, MessageFontType)
		DupHkValue.Add("Text", "x0 y180 w470 h1 +0x5")
		DupHkValue.Add("Text", "x25 y190", "Copyright 2024 FDJ-Dash. All Rights Reserved.")
		DupHkValue.SetFont()
		DupHkValue.SetFont("s8 " . MessageFontColor, MessageFontType)
		DupHkValue.Add("Text", "x25 y212", "Made with AutoHotkey V" A_AhkVersion . " " . (1 ? "Unicode" : "ANSI") . " " . (A_PtrSize == 8 ? "64-bit" : "32-bit"))
        ogcButtonOK := DupHkValue.Add("Button", "x370 y200 w80 h24", "OK")
		ogcButtonOK.OnEvent("Click", Destroy)
		DupHkValue.Title := "Duplicated Hotkey Values"
		PosX := IniRead(IniFile, "Properties", "PositionX")
		PosY := IniRead(IniFile, "Properties", "PositionY")
        DupHkValue.Show("x" . PosX - 150 . " y" . PosY + 220 . "w470 h240")
		ControlFocus("Button1", "Duplicated Hotkey Values")
        DupHkValue.Opt("+LastFound")
    Return
	Destroy(*){
		DupHkValue.Destroy()
	}
}
;----------------------------------------------------
SaveMsg(*){
	ShowSave:
		if GuiPriorityAlwaysOnTop == true {
			Savemsg := Gui("+AlwaysOnTop")
		} else {
			Savemsg := Gui()
		}
		Savemsg.BackColor := "0x" . BackgroundColor
		MessageBackgroundPicture := IniRead(IniFile, "Background", "MessageBackgroundPicture")
		if MessageBackgroundPicture == "" {
		try {
				Savemsg.Add("Picture", "x0 y0 w470 h240", ImageLib . DefaultMsgBackgroundImage)
			}
			catch {
			}
		} else {
			try {
				Savemsg.Add("Picture", "x0 y0 w470 h240", MessageBackgroundPicture)
			}
			catch {
				MessageBackgroundPicture := ""
				IniWrite MessageBackgroundPicture, IniFile, "Background", "MessageBackgroundPicture"
				Reload
			}
		}
		try {
			Savemsg.Add("Picture", "x9 y14 w64 h64 +border", IconLib . MLSoftwareIcon)
		}
		catch {
		}
		Savemsg.SetFont("s20 W700 Q4 " . MessageAppNameFontColor, MessageAppNameFontType)
        Savemsg.Add("Text", "x80 y8", AppName)
		Savemsg.SetFont("s9 " . MessageFontColor, MessageFontType)
		Savemsg.Add("Text", "x80 y45", "Mean Little's Task Automator " CurrentVersion)
		Savemsg.Add("Text", "x80 y65", "License key: ")
		Savemsg.SetFont()
		Savemsg.SetFont("s8 Bold " . LicenseKeyFontColor, LicenseKeyFontType)
		Savemsg.Add("Text", "x160 y65", LicenseKey)
		Savemsg.Add("Text", "x0 y90 w470 h1 +0x5")
		Savemsg.SetFont()
		Savemsg.SetFont("s12 " . MessageMainMsgFontColor, MessageMainMsgFontType)
		Savemsg.Add("Text", "x110 y125", "Values saved successfully to ini file")
		Savemsg.SetFont()
		Savemsg.SetFont("s9 " . MessageFontColor, MessageFontType)
		Savemsg.Add("Text", "x0 y180 w470 h1 +0x5")
		Savemsg.Add("Text", "x25 y190", "Copyright 2024 FDJ-Dash. All Rights Reserved.")
		Savemsg.SetFont()
		Savemsg.SetFont("s8 " . MessageFontColor, MessageFontType)
		Savemsg.Add("Text", "x25 y212", "Made with AutoHotkey V" A_AhkVersion . " " . (1 ? "Unicode" : "ANSI") . " " . (A_PtrSize == 8 ? "64-bit" : "32-bit"))
        ogcButtonOK := Savemsg.Add("Button", "x370 y200 w80 h24", "OK")
		ogcButtonOK.OnEvent("Click", Destroy)
		Savemsg.Title := "Save Successful!"
		TaskAutomatorGui.GetPos(&PosX, &PosY)
        Savemsg.Show("x" . PosX - 150 . " y" . PosY + 220 . "w470 h240")
		ControlFocus("Button1", "Save Successful!")
        Savemsg.Opt("+LastFound")
    Return
	Destroy(*){
		Savemsg.Destroy()
	}
}
;----------------------------------------------------
ToggleHotkeysEnabled(*){
	ShowTgHkEnabled:
		if GuiPriorityAlwaysOnTop == true {
			HkEnabled := Gui("+AlwaysOnTop")
		} else {
			HkEnabled := Gui()
		}
		HkEnabled.BackColor := "0x" . BackgroundColor
		MessageBackgroundPicture := IniRead(IniFile, "Background", "MessageBackgroundPicture")
		if MessageBackgroundPicture == "" {
		try {
				HkEnabled.Add("Picture", "x0 y0 w470 h240", ImageLib . DefaultMsgBackgroundImage)
			}
			catch {
			}
		} else {
			try {
				HkEnabled.Add("Picture", "x0 y0 w470 h240", MessageBackgroundPicture)
			}
			catch {
				MessageBackgroundPicture := ""
				IniWrite MessageBackgroundPicture, IniFile, "Background", "MessageBackgroundPicture"
				Reload
			}
		}
		try {
			HkEnabled.Add("Picture", "x9 y14 w64 h64 +border", IconLib . MLSoftwareIcon)
		}
		catch {
		}
		HkEnabled.SetFont("s20 W700 Q4 " . MessageAppNameFontColor, MessageAppNameFontType)
        HkEnabled.Add("Text", "x80 y8", AppName)
		HkEnabled.SetFont("s9 " . MessageFontColor, MessageFontType)
		HkEnabled.Add("Text", "x80 y45", "Mean Little's Task Automator " CurrentVersion)
		HkEnabled.Add("Text", "x80 y65", "License key: ")
		HkEnabled.SetFont()
		HkEnabled.SetFont("s8 Bold " . LicenseKeyFontColor, LicenseKeyFontType)
		HkEnabled.Add("Text", "x160 y65", LicenseKey)
		HkEnabled.Add("Text", "x0 y90 w470 h1 +0x5")
		HkEnabled.SetFont()
		HkEnabled.SetFont("s12 " . MessageMainMsgFontColor, MessageMainMsgFontType)
		HkEnabled.Add("Text", "x170 y125", "Hotkeys Enabled")
		HkEnabled.SetFont()
		HkEnabled.SetFont("s9 " . MessageFontColor, MessageFontType)
		HkEnabled.Add("Text", "x0 y180 w470 h1 +0x5")
		HkEnabled.Add("Text", "x107 y190", "Copyright 2024 FDJ-Dash. All Rights Reserved.")
		HkEnabled.SetFont()
		HkEnabled.SetFont("s8 " . MessageFontColor, MessageFontType)
		HkEnabled.Add("Text", "x116 y212", "Made with AutoHotkey V" A_AhkVersion . " " . (1 ? "Unicode" : "ANSI") . " " . (A_PtrSize == 8 ? "64-bit" : "32-bit"))
		HkEnabled.Title := "Hotkeys Enabled"
		TaskAutomatorGui.GetPos(&PosX, &PosY)
		if PosX == -32000 {
			PosX := IniRead(IniFile, "Properties", "PositionX")
		}
		if PosY == -32000 {
			PosY := IniRead(IniFile, "Properties", "PositionY")
		}
        HkEnabled.Show("x" . PosX - 150 . " y" . PosY + 220 . "w470 h240")
        HkEnabled.Opt("+LastFound")
		sleep SuspendedHotkeysTimeWait
		HkEnabled.Destroy()
    Return
}
;----------------------------------------------------
ToggleHotkeysDisabled(*){
	ShowTgHkDisabled:
		if GuiPriorityAlwaysOnTop == true {
			HkDisabled := Gui("+AlwaysOnTop")
		} else {
			HkDisabled := Gui()
		}
		HkDisabled.BackColor := "0x" . BackgroundColor
		MessageBackgroundPicture := IniRead(IniFile, "Background", "MessageBackgroundPicture")
		if MessageBackgroundPicture == "" {
		try {
				HkDisabled.Add("Picture", "x0 y0 w470 h240", ImageLib . DefaultMsgBackgroundImage)
			}
			catch {
			}
		} else {
			try {
				HkDisabled.Add("Picture", "x0 y0 w470 h240", MessageBackgroundPicture)
			}
			catch {
				MessageBackgroundPicture := ""
				IniWrite MessageBackgroundPicture, IniFile, "Background", "MessageBackgroundPicture"
				Reload
			}
		}
		try {
			HkDisabled.Add("Picture", "x9 y14 w64 h64 +border", IconLib . MLSoftwareIcon)
		}
		catch {
		}
		HkDisabled.SetFont("s20 W700 Q4 " . MessageAppNameFontColor, MessageAppNameFontType)
        HkDisabled.Add("Text", "x80 y8", AppName)
		HkDisabled.SetFont("s9 " . MessageFontColor, MessageFontType)
		HkDisabled.Add("Text", "x80 y45", "Mean Little's Task Automator " CurrentVersion)
		HkDisabled.Add("Text", "x80 y65", "License key: ")
		HkDisabled.SetFont()
		HkDisabled.SetFont("s8 Bold " . LicenseKeyFontColor, LicenseKeyFontType)
		HkDisabled.Add("Text", "x160 y65", LicenseKey)
		HkDisabled.Add("Text", "x0 y90 w470 h1 +0x5")
		HkDisabled.SetFont()
		HkDisabled.SetFont("s12 " . MessageMainMsgFontColor, MessageMainMsgFontType)
		HkDisabled.Add("Text", "x167 y110", "Hotkeys Suspended")
		HkDisabled.Add("Text", "x116 y140", "Press " . SuspendHotkeysKey . " again to anable them.")
		HkDisabled.SetFont()
		HkDisabled.SetFont("s9 " . MessageFontColor, MessageFontType)
		HkDisabled.Add("Text", "x0 y180 w470 h1 +0x5")
		HkDisabled.Add("Text", "x107 y190", "Copyright 2024 FDJ-Dash. All Rights Reserved.")
		HkDisabled.SetFont()
		HkDisabled.SetFont("s8 " . MessageFontColor, MessageFontType)
		HkDisabled.Add("Text", "x116 y212", "Made with AutoHotkey V" A_AhkVersion . " " . (1 ? "Unicode" : "ANSI") . " " . (A_PtrSize == 8 ? "64-bit" : "32-bit"))
		HkDisabled.Title := "Hotkeys Suspended"
		TaskAutomatorGui.GetPos(&PosX, &PosY)
		if PosX == -32000 {
			PosX := IniRead(IniFile, "Properties", "PositionX")
		}
		if PosY == -32000 {
			PosY := IniRead(IniFile, "Properties", "PositionY")
		}
        HkDisabled.Show("x" . PosX - 150 . " y" . PosY + 220 . "w470 h240")
        HkDisabled.Opt("+LastFound")
		sleep SuspendedHotkeysTimeWait
		HkDisabled.Destroy()
    Return
}
;----------------------------------------------------
HotkeyEditModeOn(*){
	ShowHkEditModeOn:
		if GuiPriorityAlwaysOnTop == true {
			HkEditModeOn := Gui("+AlwaysOnTop")
		} else {
			HkEditModeOn := Gui()
		}
		HkEditModeOn.BackColor := "0x" . BackgroundColor
		MessageBackgroundPicture := IniRead(IniFile, "Background", "MessageBackgroundPicture")
		if MessageBackgroundPicture == "" {
		try {
				HkEditModeOn.Add("Picture", "x0 y0 w470 h240", ImageLib . DefaultMsgBackgroundImage)
			}
			catch {
			}
		} else {
			try {
				HkEditModeOn.Add("Picture", "x0 y0 w470 h240", MessageBackgroundPicture)
			}
			catch {
				MessageBackgroundPicture := ""
				IniWrite MessageBackgroundPicture, IniFile, "Background", "MessageBackgroundPicture"
				Reload
			}
		}
		try {
			HkEditModeOn.Add("Picture", "x9 y14 w64 h64 +border", IconLib . MLSoftwareIcon)
		}
		catch {
		}
		HkEditModeOn.SetFont("s20 W700 Q4 " . MessageAppNameFontColor, MessageAppNameFontType)
        HkEditModeOn.Add("Text", "x80 y8", AppName)
		HkEditModeOn.SetFont("s9 " . MessageFontColor, MessageFontType)
		HkEditModeOn.Add("Text", "x80 y45", "Mean Little's Task Automator " CurrentVersion)
		HkEditModeOn.Add("Text", "x80 y65", "License key: ")
		HkEditModeOn.SetFont()
		HkEditModeOn.SetFont("s8 Bold " . LicenseKeyFontColor, LicenseKeyFontType)
		HkEditModeOn.Add("Text", "x160 y65", LicenseKey)
		HkEditModeOn.Add("Text", "x0 y90 w470 h1 +0x5")
		HkEditModeOn.SetFont()
		HkEditModeOn.SetFont("s12 " . MessageMainMsgFontColor, MessageMainMsgFontType)
		HkEditModeOn.Add("Text", "x148 y110", "Hotkey Edit Mode is ON")
		HkEditModeOn.Add("Text", "x136 y140", "Switch it OFF and try again.")
		HkEditModeOn.SetFont()
		HkEditModeOn.SetFont("s9 " . MessageFontColor, MessageFontType)
		HkEditModeOn.Add("Text", "x0 y180 w470 h1 +0x5")
		HkEditModeOn.Add("Text", "x25 y190", "Copyright 2024 FDJ-Dash. All Rights Reserved.")
		HkEditModeOn.SetFont()
		HkEditModeOn.SetFont("s8 " . MessageFontColor, MessageFontType)
		HkEditModeOn.Add("Text", "x25 y212", "Made with AutoHotkey V" A_AhkVersion . " " . (1 ? "Unicode" : "ANSI") . " " . (A_PtrSize == 8 ? "64-bit" : "32-bit"))
        ogcButtonOK := HkEditModeOn.Add("Button", "x370 y200 w80 h24", "OK")
		ogcButtonOK.OnEvent("Click", Destroy)
        HkEditModeOn.Title := "Hotkey Edit Mode ON"
		TaskAutomatorGui.GetPos(&PosX, &PosY)
        HkEditModeOn.Show("x" . PosX - 150 . " y" . PosY + 220 . "w470 h240")
        ControlFocus("Button1", "Hotkey Edit Mode ON")
        HkEditModeOn.Opt("+LastFound")
    Return
	Destroy(*){
		HkEditModeOn.Destroy()
	}
}
;----------------------------------------------------
MenuHandlerAbout(*)
{
	ShowAbout:
		if GuiPriorityAlwaysOnTop == true {
			About := Gui("+AlwaysOnTop")
		} else {
			About := Gui()
		}
		About.BackColor := "0x" . BackgroundColor
		; About.BackColor := ""
		MessageBackgroundPicture := IniRead(IniFile, "Background", "MessageBackgroundPicture")
		if MessageBackgroundPicture == "" {
		try {
				About.Add("Picture", "x0 y0 w470 h240", ImageLib . DefaultMsgBackgroundImage)
			}
			catch {
			}
		} else {
			try {
				About.Add("Picture", "x0 y0 w470 h240", MessageBackgroundPicture)
			}
			catch {
				MessageBackgroundPicture := ""
				IniWrite MessageBackgroundPicture, IniFile, "Background", "MessageBackgroundPicture"
				Reload
			}
		}
		try {
			About.Add("Picture", "x9 y14 w64 h64 +border", IconLib . MLSoftwareIcon)
		}
		catch {
		}
		About.SetFont("s20 W700 Q4 " . MessageAppNameFontColor, MessageAppNameFontType)
        About.Add("Text", "x80 y8", AppName)
		About.SetFont("s9 " . MessageFontColor, MessageFontType)
		About.Add("Text", "x80 y45", "Mean Little's Task Automator " CurrentVersion)
		About.Add("Text", "x80 y65", "License key: ")
		About.SetFont()
		About.SetFont("s8 Bold " . LicenseKeyFontColor, LicenseKeyFontType)
		About.Add("Text", "x160 y65", LicenseKey)
		About.Add("Text", "x0 y90 w470 h1 +0x5")
		About.SetFont()
		About.SetFont("s12 " . MessageMainMsgFontColor, MessageMainMsgFontType)
		About.Add("Text", "x80 y115", "Programmed and designed by:")
		About.Add("Link", "x310 y115", "<a href=`"https://github.com/FDJ-Dash`">FDJ-Dash</a>")
		About.SetFont()
		About.SetFont("s9 " . MessageFontColor, MessageFontType)
		About.Add("Text", "x105 y155", "Support mail: mean.little.software@gmail.com")
		About.Add("Text", "x0 y180 w470 h1 +0x5")
        About.Add("Text", "x25 y190", "Copyright 2024 FDJ-Dash. All Rights Reserved.")
		About.SetFont()
		About.SetFont("s8 " . MessageFontColor, MessageFontType)
		About.Add("Text", "x25 y212", "Made with AutoHotkey V" A_AhkVersion . " " . (1 ? "Unicode" : "ANSI") . " " . (A_PtrSize == 8 ? "64-bit" : "32-bit"))
		ogcButtonOK := About.Add("Button", "x370 y200 w80 h24", "OK")
		ogcButtonOK.OnEvent("Click", Destroy)
        About.Title := "About"
		TaskAutomatorGui.GetPos(&PosX, &PosY)
        About.Show("x" . PosX - 150 . " y" . PosY + 220 . "w470 h240")
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
		if GuiPriorityAlwaysOnTop == true {
			GuideMsg := Gui("+AlwaysOnTop")
		} else {
			GuideMsg := Gui()
		}
		GuideMsg.BackColor := "0x" . BackgroundColor
		MessageBackgroundPicture := IniRead(IniFile, "Background", "MessageBackgroundPicture")
		if MessageBackgroundPicture == "" {
		try {
				GuideMsg.Add("Picture", "x0 y0 w470 h240", ImageLib . DefaultMsgBackgroundImage)
			}
			catch {
			}
		} else {
			try {
				GuideMsg.Add("Picture", "x0 y0 w470 h240", MessageBackgroundPicture)
			}
			catch {
				MessageBackgroundPicture := ""
				IniWrite MessageBackgroundPicture, IniFile, "Background", "MessageBackgroundPicture"
				Reload
			}
		}
		try {
			GuideMsg.Add("Picture", "x9 y14 w64 h64 +border", IconLib . MLSoftwareIcon)
		}
		catch {
		}
		GuideMsg.SetFont("s20 W700 Q4 " . MessageAppNameFontColor, MessageAppNameFontType)
        GuideMsg.Add("Text", "x80 y8", AppName)
		GuideMsg.SetFont("s9 " . MessageFontColor, MessageFontType)
		GuideMsg.Add("Text", "x80 y45", "Mean Little's Task Automator " CurrentVersion)
		GuideMsg.Add("Text", "x80 y65", "License key: ")
		GuideMsg.SetFont()
		GuideMsg.SetFont("s8 Bold " . LicenseKeyFontColor, LicenseKeyFontType)
		GuideMsg.Add("Text", "x160 y65", LicenseKey)
		GuideMsg.Add("Text", "x0 y90 w470 h1 +0x5")
		GuideMsg.SetFont()
		GuideMsg.SetFont("s12 " . MessageMainMsgFontColor, MessageMainMsgFontType)
		GuideMsg.Add("Text", "x100 y110", "The guide will open in your browser.")
        GuideMsg.Add("Text", "x137 y140", "You can close this message.")
		GuideMsg.SetFont()
		GuideMsg.SetFont("s9 " . MessageFontColor, MessageFontType)
		GuideMsg.Add("Text", "x0 y180 w470 h1 +0x5")
		GuideMsg.Add("Text", "x25 y190", "Copyright 2024 FDJ-Dash. All Rights Reserved.")
		GuideMsg.SetFont()
		GuideMsg.SetFont("s8 " . MessageFontColor, MessageFontType)
		GuideMsg.Add("Text", "x25 y212", "Made with AutoHotkey V" A_AhkVersion . " " . (1 ? "Unicode" : "ANSI") . " " . (A_PtrSize == 8 ? "64-bit" : "32-bit"))
        ogcButtonOK := GuideMsg.Add("Button", "x370 y200 w80 h24 Default", "OK")
		ogcButtonOK.OnEvent("Click", Destroy)
        GuideMsg.Title := "Guide"
		TaskAutomatorGui.GetPos(&PosX, &PosY)
        GuideMsg.Show("x" . PosX - 150 . " y" . PosY + 220 . "w470 h240")
        ControlFocus("Button1", "Guide")
        GuideMsg.Opt("+LastFound")
		run HotkeyGuide
    Return
	
	Destroy(*){
		GuideMsg.Destroy()
	}
}
;----------------------------------------------------
MenuHandlerQuickAccessMsg(*) {
	ShowQuickAccMsg:
		if GuiPriorityAlwaysOnTop == true {
			QuickAccMsg := Gui("+AlwaysOnTop")
		} else {
			QuickAccMsg := Gui()
		}
        QuickAccMsg := Gui("+AlwaysOnTop")
		QuickAccMsg.BackColor := "0x" . BackgroundColor
		MessageBackgroundPicture := IniRead(IniFile, "Background", "MessageBackgroundPicture")
		if MessageBackgroundPicture == "" {
		try {
				QuickAccMsg.Add("Picture", "x0 y0 w470 h240", ImageLib . DefaultMsgBackgroundImage)
			}
			catch {
			}
		} else {
			try {
				QuickAccMsg.Add("Picture", "x0 y0 w470 h240", MessageBackgroundPicture)
			}
			catch {
				MessageBackgroundPicture := ""
				IniWrite MessageBackgroundPicture, IniFile, "Background", "MessageBackgroundPicture"
				Reload
			}
		}
		try {
			QuickAccMsg.Add("Picture", "x9 y14 w64 h64 +border", IconLib . MLSoftwareIcon)
		}
		catch {
		}
		QuickAccMsg.SetFont("s20 W700 Q4 " . MessageAppNameFontColor, MessageAppNameFontType)
        QuickAccMsg.Add("Text", "x80 y8", AppName)
		QuickAccMsg.SetFont("s9 " . MessageFontColor, MessageFontType)
		QuickAccMsg.Add("Text", "x80 y45", "Mean Little's Task Automator " CurrentVersion)
		QuickAccMsg.Add("Text", "x80 y65", "License key: ")
		QuickAccMsg.SetFont()
		QuickAccMsg.SetFont("s8 Bold " . LicenseKeyFontColor, LicenseKeyFontType)
		QuickAccMsg.Add("Text", "x160 y65", LicenseKey)
		QuickAccMsg.Add("Text", "x0 y90 w470 h1 +0x5")
		QuickAccMsg.SetFont()
		QuickAccMsg.SetFont("s12 " . MessageMainMsgFontColor, MessageMainMsgFontType)
		QuickAccMsg.Add("Text", "x80 y110", "To switch Quick Access Buttons you need to")
        QuickAccMsg.Add("Text", "x110 y140", "switch to Quick Access module first.")
		QuickAccMsg.SetFont()
		QuickAccMsg.SetFont("s9 " . MessageFontColor, MessageFontType)
		QuickAccMsg.Add("Text", "x0 y180 w470 h1 +0x5")
		QuickAccMsg.Add("Text", "x25 y190", "Copyright 2024 FDJ-Dash. All Rights Reserved.")
		QuickAccMsg.SetFont()
		QuickAccMsg.SetFont("s8 " . MessageFontColor, MessageFontType)
		QuickAccMsg.Add("Text", "x25 y212", "Made with AutoHotkey V" A_AhkVersion . " " . (1 ? "Unicode" : "ANSI") . " " . (A_PtrSize == 8 ? "64-bit" : "32-bit"))
        ogcButtonOK := QuickAccMsg.Add("Button", "x370 y200 w80 h24 Default", "OK")
		ogcButtonOK.OnEvent("Click", Destroy)
        QuickAccMsg.Title := "Guide"
		TaskAutomatorGui.GetPos(&PosX, &PosY)
        QuickAccMsg.Show("x" . PosX - 150 . " y" . PosY + 220 . "w470 h240")
        ControlFocus("Button1", "Guide")
        QuickAccMsg.Opt("+LastFound")
    Return
	
	Destroy(*){
		QuickAccMsg.Destroy()
	}
}
;----------------------------------------------------
ConnectionMessage(*) {
	ShowConnection:
		if GuiPriorityAlwaysOnTop == true {
			ConnectionMsg := Gui("+AlwaysOnTop")
		} else {
			ConnectionMsg := Gui()
		}
		ConnectionMsg.BackColor := "0x" . BackgroundColor
		MessageBackgroundPicture := IniRead(IniFile, "Background", "MessageBackgroundPicture")
		if MessageBackgroundPicture == "" {
		try {
				ConnectionMsg.Add("Picture", "x0 y0 w470 h240", ImageLib . DefaultMsgBackgroundImage)
			}
			catch {
			}
		} else {
			try {
				ConnectionMsg.Add("Picture", "x0 y0 w470 h240", MessageBackgroundPicture)
			}
			catch {
				MessageBackgroundPicture := ""
				IniWrite MessageBackgroundPicture, IniFile, "Background", "MessageBackgroundPicture"
				Reload
			}
		}
		try {
			ConnectionMsg.Add("Picture", "x9 y14 w64 h64 +border", IconLib . MLSoftwareIcon)
		}
		catch {
		}
		ConnectionMsg.SetFont("s20 W700 Q4 " . MessageAppNameFontColor, MessageAppNameFontType)
		ConnectionMsg.Add("Text", "x80 y8", AppName)
		ConnectionMsg.SetFont("s9 " . MessageFontColor, MessageFontType)
		ConnectionMsg.Add("Text", "x80 y45", "Mean Little's Task Automator " CurrentVersion)
		ConnectionMsg.Add("Text", "x80 y65", "License key: ")
		ConnectionMsg.SetFont()
		ConnectionMsg.SetFont("s8 Bold " . LicenseKeyFontColor, LicenseKeyFontType)
		ConnectionMsg.Add("Text", "x160 y65", LicenseKey)
		ConnectionMsg.Add("Text", "x0 y90 w470 h1 +0x5")
		ConnectionMsg.SetFont()
		ConnectionMsg.SetFont("s12 cRed", MessageMainMsgFontType)
		ConnectionMsg.Add("Text", "x125 y110", "Unable to check for new updates.")
		ConnectionMsg.Add("Text", "x135 y140", "Please verify your connection")		
		ConnectionMsg.SetFont()
		ConnectionMsg.SetFont("s9 " . MessageFontColor, MessageFontType)
		ConnectionMsg.Add("Text", "x0 y180 w470 h1 +0x5")
        ConnectionMsg.Add("Text", "x25 y190", "Copyright 2024 FDJ-Dash. All Rights Reserved.")
		ConnectionMsg.SetFont()
		ConnectionMsg.SetFont("s8 " . MessageFontColor, MessageFontType)
		ConnectionMsg.Add("Text", "x25 y212", "Made with AutoHotkey V" A_AhkVersion . " " . (1 ? "Unicode" : "ANSI") . " " . (A_PtrSize == 8 ? "64-bit" : "32-bit"))
		ogcButtonOK := ConnectionMsg.Add("Button", "x370 y200 w80 h24", "OK")
		ogcButtonOK.OnEvent("Click", Destroy)
        ConnectionMsg.Title := "Connection Failed!"
		TaskAutomatorGui.GetPos(&PosX, &PosY)
        ConnectionMsg.Show("x" . PosX - 150 . " y" . PosY + 220 . "w470 h240")
        ControlFocus("Button1", "Connection Failed!")
        ConnectionMsg.Opt("+LastFound")
	Return
	Destroy(*){
		ConnectionMsg.Destroy()
	}
}
;----------------------------------------------------
UpToDateMessage(*) {
	ShowUpToDate:
		if GuiPriorityAlwaysOnTop == true {
			UpToDateMsg := Gui("+AlwaysOnTop")
		} else {
			UpToDateMsg := Gui()
		}
		UpToDateMsg.BackColor := "0x" . BackgroundColor
		MessageBackgroundPicture := IniRead(IniFile, "Background", "MessageBackgroundPicture")
		if MessageBackgroundPicture == "" {
		try {
				UpToDateMsg.Add("Picture", "x0 y0 w470 h240", ImageLib . DefaultMsgBackgroundImage)
			}
			catch {
			}
		} else {
			try {
				UpToDateMsg.Add("Picture", "x0 y0 w470 h240", MessageBackgroundPicture)
			}
			catch {
				MessageBackgroundPicture := ""
				IniWrite MessageBackgroundPicture, IniFile, "Background", "MessageBackgroundPicture"
				Reload
			}
		}
		try {
			UpToDateMsg.Add("Picture", "x9 y14 w64 h64 +border", IconLib . MLSoftwareIcon)
		}
		catch {
		}
		UpToDateMsg.SetFont("s20 W700 Q4 " . MessageAppNameFontColor, MessageAppNameFontType)
		UpToDateMsg.Add("Text", "x80 y8", AppName)
		UpToDateMsg.SetFont("s9 " . MessageFontColor, MessageFontType)
		UpToDateMsg.Add("Text", "x80 y45", "Mean Little's Task Automator " CurrentVersion)
		UpToDateMsg.Add("Text", "x80 y65", "License key: ")
		UpToDateMsg.SetFont()
		UpToDateMsg.SetFont("s8 Bold " . LicenseKeyFontColor, LicenseKeyFontType)
		UpToDateMsg.Add("Text", "x160 y65", LicenseKey)
		UpToDateMsg.Add("Text", "x0 y90 w470 h1 +0x5")
		UpToDateMsg.SetFont()
		UpToDateMsg.SetFont("s12 " . MessageMainMsgFontColor, MessageMainMsgFontType)
		UpToDateMsg.Add("Text", "x135 y123", "Current version is up to date!")
		UpToDateMsg.SetFont()
		UpToDateMsg.SetFont("s9 " . MessageFontColor, MessageFontType)
		UpToDateMsg.Add("Text", "x0 y180 w470 h1 +0x5")
        UpToDateMsg.Add("Text", "x25 y190", "Copyright 2024 FDJ-Dash. All Rights Reserved.")
		UpToDateMsg.SetFont()
		UpToDateMsg.SetFont("s8 " . MessageFontColor, MessageFontType)
		UpToDateMsg.Add("Text", "x25 y212", "Made with AutoHotkey V" A_AhkVersion . " " . (1 ? "Unicode" : "ANSI") . " " . (A_PtrSize == 8 ? "64-bit" : "32-bit"))
		ogcButtonOK := UpToDateMsg.Add("Button", "x370 y200 w80 h24", "OK")
		ogcButtonOK.OnEvent("Click", Destroy)
        UpToDateMsg.Title := "Up To Date!"
		TaskAutomatorGui.GetPos(&PosX, &PosY)
        UpToDateMsg.Show("x" . PosX - 150 . " y" . PosY + 220 . "w470 h240")
        ControlFocus("Button1", "Up To Date!")
        UpToDateMsg.Opt("+LastFound")
	Return
	Destroy(*){
		UpToDateMsg.Destroy()
	}
}
;----------------------------------------------------
NewVersionAvailableMessage(ReleaseVersion, *) {
	ShowNewVerMsg:
		if GuiPriorityAlwaysOnTop == true {
			NewVerMsg := Gui("+AlwaysOnTop")
		} else {
			NewVerMsg := Gui()
		}
		NewVerMsg.BackColor := "0x" . BackgroundColor
		MessageBackgroundPicture := IniRead(IniFile, "Background", "MessageBackgroundPicture")
		if MessageBackgroundPicture == "" {
		try {
				NewVerMsg.Add("Picture", "x0 y0 w470 h240", ImageLib . DefaultMsgBackgroundImage)
			}
			catch {
			}
		} else {
			try {
				NewVerMsg.Add("Picture", "x0 y0 w470 h240", MessageBackgroundPicture)
			}
			catch {
				MessageBackgroundPicture := ""
				IniWrite MessageBackgroundPicture, IniFile, "Background", "MessageBackgroundPicture"
				Reload
			}
		}
		try {
			NewVerMsg.Add("Picture", "x9 y14 w64 h64 +border", IconLib . MLSoftwareIcon)
		}
		catch {
		}
		NewVerMsg.SetFont("s20 W700 Q4 " . MessageAppNameFontColor, MessageAppNameFontType)
		NewVerMsg.Add("Text", "x80 y8", AppName)
		NewVerMsg.SetFont("s9 " . MessageFontColor, MessageFontType)
		NewVerMsg.Add("Text", "x80 y45", "Mean Little's Task Automator " CurrentVersion)
		NewVerMsg.Add("Text", "x80 y65", "License key: ")
		NewVerMsg.SetFont()
		NewVerMsg.SetFont("s8 Bold " . LicenseKeyFontColor, LicenseKeyFontType)
		NewVerMsg.Add("Text", "x160 y65", LicenseKey)
		NewVerMsg.Add("Text", "x0 y90 w470 h1 +0x5")
		NewVerMsg.SetFont()
		NewVerMsg.SetFont("s12 " . MessageMainMsgFontColor, MessageMainMsgFontType)
		NewVerMsg.Add("Text", "x100 y115", "New release version " . ReleaseVersion . " is available")
		NewVerMsg.SetFont()
		NewVerMsg.SetFont("s9 " . MessageFontColor, MessageFontType)
		ogcButtonUpdate := NewVerMsg.Add("Button", "x190 y145 w80 h24", "Download")
		ogcButtonUpdate.OnEvent("Click", UpdateDownload)
		NewVerMsg.Add("Text", "x0 y180 w470 h1 +0x5")
        NewVerMsg.Add("Text", "x25 y190", "Copyright 2024 FDJ-Dash. All Rights Reserved.")
		NewVerMsg.SetFont()
		NewVerMsg.SetFont("s8 " . MessageFontColor, MessageFontType)
		NewVerMsg.Add("Text", "x25 y212", "Made with AutoHotkey V" A_AhkVersion . " " . (1 ? "Unicode" : "ANSI") . " " . (A_PtrSize == 8 ? "64-bit" : "32-bit"))
		ogcButtonOK := NewVerMsg.Add("Button", "x370 y200 w80 h24", "Close")
		ogcButtonOK.OnEvent("Click", Destroy)
        NewVerMsg.Title := "New Version Available!"
		TaskAutomatorGui.GetPos(&PosX, &PosY)
        NewVerMsg.Show("x" . PosX - 150 . " y" . PosY + 220 . "w470 h240")
        ControlFocus("Button1", "New Version Available!")
        NewVerMsg.Opt("+LastFound")
		NewVerMsg.OnEvent("Close", NewVerMsg_Close)
	Return
	Destroy(*){
		NewVerMsg.Destroy()
	}
	UpdateDownload(*){
		MLTAName := IniRead(DataFile, "GeneralData", "MLTAName")
		; Scaped character included: ``
		MLTADownloadPart1 := "PLjr_f_[HF16S_KEBLbjHF16AJKEQ[23BIPLRZU\gc75EJ7?U\c_LTahPL7?Y``ok``h]d93so=EY``eaT\BLNUgcZbW^JFdlCAEJ71HTV``CA,5ovgcNVelmi\d3:JFT\ahsoX``49KEY``sobjW^kgV``V^ahgcNVovMIB@PX<Cgc?DFCGR23EQJS89amGU,5+(ZbKRJK<HDObkTUwsBNjr9@V_E?DRVW_kmiDMbj>?KWPYHOc_.6\]am\eNUGC.6``a]d6B=:;Fc_PYLTJXY``YUIQBI.+D@XYNV_k]dGC>GFNDEGRip6B5C;D>?Q]=:>I;DAOPQ6BfoPL\dno[bQ["
		MLTADownloadPart1 := DecriptMsg(MLTADownloadPart1)
		;------------------------
		MLTADownloadPart2 := IniRead(DataFile, "EncriptedData", "MLTADownload")
		MLTADownloadPart2 := DecriptMsg(MLTADownloadPart2)
		;------------------------
		MLTADownloadPart3 := "42so"
		MLTADownloadPart3 := DecriptMsg(MLTADownloadPart3)
		;------------------------
		MLTADownloadPart4 := FileSelect("S16", A_MyDocuments . "\" . MLTAName , "Save File", "Executable files (*.exe)")
		FullPathDownLoad := MLTADownloadPart1 . " " . MLTADownloadPart2 . " " . MLTADownloadPart3 . " " . MLTADownloadPart4
		if MLTADownloadPart4 != "" {
			RunWait(A_ComSpec " /c " . FullPathDownLoad . " > " TempCleanFileMLTA, , "Hide")
		}
	}
	NewVerMsg_Close(*){
		try {
			FileDelete DataFile
			FileDelete TempCleanFileMLTA
		}
		catch {
		}
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
	if HotkeyEditMode == false {
		HotkeyEditModeOn
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
			if GetKeyState(ExitTaskAutomatorKey){
				Send("{" . SprintKey . " up}")
				Send("{" . ForwardKey . " up}")
				TextOnOff1.Value := " OFF"
				SB.SetText("Ready")
				ExitApp()
			}
			if GetKeyState(SuspendHotkeysKey){
				Send("{" . SprintKey . " up}")
				Send("{" . ForwardKey . " up}")
				TextOnOff1.Value := " OFF"
				SB.SetText("Ready")
				SuspendMenuHandler()
			}
			Sleep AutoRunLoopInterval
		}
	}
}
;----------------------------------------------------
CountClicker := 0
; General Loop
Loop {
	MouseGetPos(&x, &y)
	if SwitchControllerAutoRun == false {
	} else {	
		if ControllerAvailable == true {
			TextOnOffController.Value := " Controller Found"
			ControllerName.Value := GetKeyState(ControllerNumber "JoyName")
			cont_info := GetKeyState(ControllerNumber "JoyInfo")
			if RadioCtrlAuRunYes.Value == true {
				if HotkeyEditMode == false {
					HotkeyEditModeOn
					RadioCtrlAuRunYes.Value := false
					RadioCtrlAuRunNo.Value := true
					continue
				}
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
							if axis_info_Z > 55 {
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
							if GetKeyState(ExitTaskAutomatorKey){
								RunSelected := false
								WalkSelected := true
								TextOnOffCtrlAuRun.Value := " OFF"
								MouseGetPos(&x, &y)
								SB.SetText("Ready.                        X:" . x . " Y:" . y )
								Send("{" . SprintKey . " up}")
								Send("{" . ButtonRT . " up}")
								ExitApp()
							}
							if GetKeyState(SuspendHotkeysKey){
								RunSelected := false
								WalkSelected := true
								TextOnOffCtrlAuRun.Value := " OFF"
								MouseGetPos(&x, &y)
								SB.SetText("Ready.                        X:" . x . " Y:" . y )
								Send("{" . SprintKey . " up}")
								Send("{" . ButtonRT . " up}")
								SuspendMenuHandler()
								break
							}
							Sleep AutoRunLoopInterval
						} ; End AutoRun loop
					} ; End JoyZ RT key
				} ; End cont_info Z
			} ; End RadioCtrlAuRunYes
		} ; End Controller Available
	} ; End else
	
	if ControllerAvailable == false {
		TextOnOffController.Value := " Controller Not Found"
		ControllerName.Value := " "
		RadioCtrlAuRunYes.Value := false
		RadioCtrlAuRunNo.Value := true
	} ; End Controller Not Available
	
	if GetKeyState(ExitTaskAutomatorKey){
		ExitApp()
	}
	if GetKeyState(SuspendHotkeysKey){
		SuspendMenuHandler()
	}
	
	if SwitchClicker == true {
		if TextPatternClickerOnOff.Value == " ON" {
			SB.SetText("Infinite Clicker Active. Count: " . CountClicker)
			CountClicker++
		} else {
			if CountClicker != 0 {
				SB.SetText("Clicker Stopped. Count: " CountClicker)
				sleep ClikerStopInterval
			}
			SB.SetText("Ready.                         X:" . x . " Y:" . y )
			CountClicker := 0
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
	if HotkeyEditMode == false {
		HotkeyEditModeOn
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
	if HotkeyEditMode == false {
		HotkeyEditModeOn
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
	if HotkeyEditMode == false {
		HotkeyEditModeOn
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
	if HotkeyEditMode == false {
		HotkeyEditModeOn
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
	if HotkeyEditMode == false {
		HotkeyEditModeOn
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
ProcessQuickAccess(CurrentHotkey, *) {
	Saved := TaskAutomatorGui.Submit(false)
	if HotkeyEditMode == false {
		HotkeyEditModeOn
		return
	}
	Switch true {
	case CurrentHotkey == Saved.QuickAccessHk1:
		try {
			run "" . Saved.QuickAccess1 . ""
		}
		catch {
			InvalidPath
		}
	case CurrentHotkey == Saved.QuickAccessHk2:
		try {
			run "" . Saved.QuickAccess2 . ""
		}
		catch {
			InvalidPath
		}
	case CurrentHotkey == Saved.QuickAccessHk3:
		try {
			run "" . Saved.QuickAccess3 . ""
		}
		catch {
			InvalidPath
		}
	case CurrentHotkey == Saved.QuickAccessHk4:
		try {
			run "" . Saved.QuickAccess4 . ""
		}
		catch {
			InvalidPath
		}
	case CurrentHotkey == Saved.QuickAccessHk5:
		try {
			run "" . Saved.QuickAccess5 . ""
		}
		catch {
			InvalidPath
		}
	case CurrentHotkey == Saved.QuickAccessHk6:
		try {
			run "" . Saved.QuickAccess6 . ""
		}
		catch {
			InvalidPath
		}
	case CurrentHotkey == Saved.QuickAccessHk7:
		try {
			run "" . Saved.QuickAccess7 . ""
		}
		catch {
			InvalidPath
		}
	case CurrentHotkey == Saved.QuickAccessHk8:
		try {
			run "" . Saved.QuickAccess8 . ""
		}
		catch {
			InvalidPath
		}
	case CurrentHotkey == Saved.QuickAccessHk9:
		try {
			run "" . Saved.QuickAccess9 . ""
		}
		catch {
			InvalidPath
		}
	}
	
}
;----------------------------------------------------¨
ProccessQuickAccessButton1(*){
	Saved := TaskAutomatorGui.Submit(false)
	if HotkeyEditMode == false {
		HotkeyEditModeOn
		return
	}
	try {
		run "" . Saved.QuickAccess1 . ""
	}
	catch {
		InvalidPath
	}
	
}
;----------------------------------------------------¨
ProccessQuickAccessButton2(*){
	Saved := TaskAutomatorGui.Submit(false)
	if HotkeyEditMode == false {
		HotkeyEditModeOn
		return
	}
	try {
		run "" . Saved.QuickAccess2 . ""
	}
	catch {
		InvalidPath
	}
	
}
;----------------------------------------------------¨
ProccessQuickAccessButton3(*){
	Saved := TaskAutomatorGui.Submit(false)
	if HotkeyEditMode == false {
		HotkeyEditModeOn
		return
	}
	try {
		run "" . Saved.QuickAccess3 . ""
	}
	catch {
		InvalidPath
	}
	
}
;----------------------------------------------------¨
ProccessQuickAccessButton4(*){
	Saved := TaskAutomatorGui.Submit(false)
	if HotkeyEditMode == false {
		HotkeyEditModeOn
		return
	}
	try {
		run "" . Saved.QuickAccess4 . ""
	}
	catch {
		InvalidPath
	}
	
}
;----------------------------------------------------¨
ProccessQuickAccessButton5(*){
	Saved := TaskAutomatorGui.Submit(false)
	if HotkeyEditMode == false {
		HotkeyEditModeOn
		return
	}
	try {
		run "" . Saved.QuickAccess5 . ""
	}
	catch {
		InvalidPath
	}
	
}
;----------------------------------------------------¨
ProccessQuickAccessButton6(*){
	Saved := TaskAutomatorGui.Submit(false)
	if HotkeyEditMode == false {
		HotkeyEditModeOn
		return
	}
	try {
		run "" . Saved.QuickAccess6 . ""
	}
	catch {
		InvalidPath
	}
	
}
;----------------------------------------------------¨
ProccessQuickAccessButton7(*){
	Saved := TaskAutomatorGui.Submit(false)
	if HotkeyEditMode == false {
		HotkeyEditModeOn
		return
	}
	try {
		run "" . Saved.QuickAccess7 . ""
	}
	catch {
		InvalidPath
	}
	
}
;----------------------------------------------------¨
ProccessQuickAccessButton8(*){
	Saved := TaskAutomatorGui.Submit(false)
	if HotkeyEditMode == false {
		HotkeyEditModeOn
		return
	}
	try {
		run "" . Saved.QuickAccess8 . ""
	}
	catch {
		InvalidPath
	}
	
}
;----------------------------------------------------¨
ProccessQuickAccessButton9(*){
	Saved := TaskAutomatorGui.Submit(false)
	if HotkeyEditMode == false {
		HotkeyEditModeOn
		return
	}
	try {
		run "" . Saved.QuickAccess9 . ""
	}
	catch {
		InvalidPath
	}
	
}
;----------------------------------------------------
ProcessPatternClicker(*){
	Saved := TaskAutomatorGui.Submit(false)	
	if HotkeyEditMode == false {
		HotkeyEditModeOn
		return
	}
	static toggle := false
	static SendKey := Send.Bind('{Click}')
	;----------------------------------------------------
	if (toggle := !toggle){
		TextPatternClickerOnOff.Value := " ON"
		ClickInterval := Saved.ClickInterval
		RandomOffset := Saved.RandomOffset
		CoordMode "Mouse", "Screen"
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
		
		CoordX5 := Saved.CoordX5
		CoordY5 := Saved.CoordY5
		Coord5Interval := Saved.Coord5Interval
		
		CoordX6 := Saved.CoordX6
		CoordY6 := Saved.CoordY6
		Coord6Interval := Saved.Coord6Interval
		
		Switch true {
		case RadioCountLoopsYes.Value:
			if RadioPos0Yes.Value == false and RadioPos1Yes.Value == false and RadioPos2Yes.Value == false and RadioPos3Yes.Value == false and 
				RadioPos4Yes.Value == false and RadioPos5Yes.Value == false and RadioPos6Yes.Value == false {
				SB.SetText("Clicker Active. Count: " Count)
				sleep ClikerStartInterval
				Loop LoopAmount {
					if GetKeyState(PatternClickerHotkey.Value, "P") {
						break
					} 
					SendKey
					Count++
					SB.SetText("Clicker Active. Count: " Count)
					sleep Random(ClickInterval, ClickInterval + RandomOffset) 
				}
			} else {
				SB.SetText("Pattern Clicker Active. Count: " Count)
				sleep ClikerStartInterval
				Loop LoopAmount {
					if RadioPos0Yes.Value == true {
						RadioPos0No.Value := false
						DllCall("SetCursorPos", "int", CoordX0, "int", CoordY0)
						SendKey
						sleep Coord0Interval
					}
					if GetKeyState(PatternClickerHotkey.Value, "P") {
						break
					}
					if RadioPos1Yes.Value == true {
						RadioPos1No.Value := false
						DllCall("SetCursorPos", "int", CoordX1, "int", CoordY1)
						SendKey
						sleep Coord1Interval
					}
					if GetKeyState(PatternClickerHotkey.Value, "P") {
						break
					}
					if RadioPos2Yes.Value == true {
						RadioPos2No.Value := false
						DllCall("SetCursorPos", "int", CoordX2, "int", CoordY2)
						SendKey
						sleep Coord2Interval
					}
					if GetKeyState(PatternClickerHotkey.Value, "P") {
						break
					}
					if RadioPos3Yes.Value == true {
						RadioPos3No.Value := false
						DllCall("SetCursorPos", "int", CoordX3, "int", CoordY3)
						SendKey
						sleep Coord3Interval
					}
					if GetKeyState(PatternClickerHotkey.Value, "P") {
						break
					}
					if RadioPos4Yes.Value == true {
						RadioPos4No.Value := false
						DllCall("SetCursorPos", "int", CoordX4, "int", CoordY4)
						SendKey
						sleep Coord4Interval
					}
					if GetKeyState(PatternClickerHotkey.Value, "P") {
						break
					}
					if RadioPos5Yes.Value == true {
						RadioPos5No.Value := false
						DllCall("SetCursorPos", "int", CoordX5, "int", CoordY5)
						SendKey
						sleep Coord5Interval
					}
					if GetKeyState(PatternClickerHotkey.Value, "P") {
						break
					}
					if RadioPos6Yes.Value == true {
						RadioPos6No.Value := false
						DllCall("SetCursorPos", "int", CoordX6, "int", CoordY6)
						SendKey
						sleep Coord6Interval
					}
					if GetKeyState(PatternClickerHotkey.Value, "P") {
						break
					}
					Count++
					SB.SetText("Pattern Clicker Active. Count: " Count)
					sleep Random(ClickInterval, ClickInterval + RandomOffset)
				} ; End Loop
			}
			toggle := !toggle
			TextPatternClickerOnOff.Value := " OFF"
			SB.SetText("Clicker Stopped. Count: " Count)
			sleep ClikerStopInterval
			return
		case RadioPos0Yes.Value == true, RadioPos1Yes.Value == true, RadioPos2Yes.Value == true, RadioPos3Yes.Value == true, RadioPos4Yes.Value == true, RadioPos5Yes.Value == true, RadioPos6Yes.Value == true:
			SB.SetText("Infinite Pattern Clicker Active. Count: " Count)
			sleep ClikerStartInterval
			Loop {
				if RadioPos0Yes.Value == true {
					RadioPos0No.Value := false
					DllCall("SetCursorPos", "int", CoordX0, "int", CoordY0)
					SendKey
					sleep Coord0Interval
				}
				if GetKeyState(PatternClickerHotkey.Value, "P") {
					break
				}
				if RadioPos1Yes.Value == true {
					RadioPos1No.Value := false
					DllCall("SetCursorPos", "int", CoordX1, "int", CoordY1)
					SendKey
					sleep Coord1Interval
				}
				if GetKeyState(PatternClickerHotkey.Value, "P") {
					break
				}
				if RadioPos2Yes.Value == true {
					RadioPos2No.Value := false
					DllCall("SetCursorPos", "int", CoordX2, "int", CoordY2)
					SendKey
					sleep Coord2Interval
				}
				if GetKeyState(PatternClickerHotkey.Value, "P") {
					break
				}
				if RadioPos3Yes.Value == true {
					RadioPos3No.Value := false
					DllCall("SetCursorPos", "int", CoordX3, "int", CoordY3)
					SendKey
					sleep Coord3Interval
				}
				if GetKeyState(PatternClickerHotkey.Value, "P") {
					break
				}
				if RadioPos4Yes.Value == true {
					RadioPos4No.Value := false
					DllCall("SetCursorPos", "int", CoordX4, "int", CoordY4)
					SendKey
					sleep Coord4Interval
				}
				if GetKeyState(PatternClickerHotkey.Value, "P") {
					break
				}
				if RadioPos5Yes.Value == true {
					RadioPos5No.Value := false
					DllCall("SetCursorPos", "int", CoordX5, "int", CoordY5)
					SendKey
					sleep Coord5Interval
				}
				if GetKeyState(PatternClickerHotkey.Value, "P") {
					break
				}
				if RadioPos6Yes.Value == true {
					RadioPos6No.Value := false
					DllCall("SetCursorPos", "int", CoordX6, "int", CoordY6)
					SendKey
					sleep Coord6Interval
				}
				if GetKeyState(PatternClickerHotkey.Value, "P") {
					break
				}
				Count++
				SB.SetText("Infinite Pattern Clicker Active. Count: " Count)
			} ; End Loop
			toggle := !toggle
			TextPatternClickerOnOff.Value := " OFF"
			SB.SetText("Clicker Stopped. Count: " Count)
			sleep ClikerStopInterval
			return
		Default:
			; SB.SetText("Auto Clicker Active.")
			SB.SetText("Infinite Clicker Active. Count: 0")
			sleep ClikerStartInterval
			SetTimer(SendKey, Random(ClickInterval, ClickInterval + RandomOffset))
			return
		}
	} else {
		TextPatternClickerOnOff.Value := " OFF"
		SetTimer(SendKey, 0)
	}
}
;----------------------------------------------------
EncriptMsg(OriginalMsg, *){
	MixedPattern := "Az0By9Cx7Da8Eb2Fc4Gw3Hv5Ij6Js1KlLhMpNeOtPgQnRrSiTqUoVkWmXdYfZu"
	PunctuationPattern := "!#$%&'()*+,-./:;<=>?@[\]^_`"{|}~ "
	
	EncriptedMsg := ""
	FlagSignCount := 0
	FlagNmCount := 0
	Flag_az_Count := 0
	Flag_AZ_Count2 := 0
	Loop Parse OriginalMsg {
		switch true {
		case ord(A_LoopField) > 31 and ord(A_LoopField) < 48:
			; punctuation signs
			for index, letter in StrSplit(PunctuationPattern) {
				switch true {
				case FlagSignCount == 0:
					if (letter == A_LoopField) {
						EncriptedMsg .= chr(index + 34 + 6)
						EncriptedMsg .= chr(index + 34 + 4)
						FlagSignCount++
						break
					}
				case FlagSignCount == 1:
					if (letter == A_LoopField) {
						EncriptedMsg .= chr(index + 34 + 3)
						EncriptedMsg .= chr(index + 34 + 8)
						FlagSignCount++
						break
					}
				case FlagSignCount == 2:
					if (letter == A_LoopField) {
						EncriptedMsg .= chr(index + 34 + 9)
						EncriptedMsg .= chr(index + 34 + 3)
						FlagSignCount++
						break
					}
				case FlagSignCount == 3:
					if (letter == A_LoopField) {
						EncriptedMsg .= chr(index + 34 + 20)
						EncriptedMsg .= chr(index + 34 + 30)
						FlagSignCount := 0
						break
					}
				}
			}
		case ord(A_LoopField) > 47 and ord(A_LoopField) < 58:
			; (0,9)
			EncriptedString := A_LoopField
			for index, letter in StrSplit(MixedPattern) {
				switch true {
				case FlagNmCount == 0:
					if (letter == A_LoopField) {
						EncriptedMsg .= chr(index + 34 + 6)
						EncriptedMsg .= chr(index + 34 + 3)
						FlagNmCount++
						break
					}
				case FlagNmCount == 1:
					if (letter == A_LoopField) {
						EncriptedMsg .= chr(index + 34 + 7)
						EncriptedMsg .= chr(index + 34 + 18)
						FlagNmCount++
						break
					}
				case FlagNmCount == 2:
					if (letter == A_LoopField) {
						EncriptedMsg .= chr(index + 34 + 10)
						EncriptedMsg .= chr(index + 34 + 24)
						FlagNmCount := 0
						break
					}
				}
			}
		case ord(A_LoopField) > 57 and ord(A_LoopField) < 65:
			; punctuation signs
			for index, letter in StrSplit(PunctuationPattern) {
				switch true {
				case FlagSignCount == 0:
					if (letter == A_LoopField) {
						EncriptedMsg .= chr(index + 34 + 6)
						EncriptedMsg .= chr(index + 34 + 4)
						FlagSignCount++
						break
					}
				case FlagSignCount == 1:
					if (letter == A_LoopField) {
						EncriptedMsg .= chr(index + 34 + 3)
						EncriptedMsg .= chr(index + 34 + 8)
						FlagSignCount++
						break
					}
				case FlagSignCount == 2:
					if (letter == A_LoopField) {
						EncriptedMsg .= chr(index + 34 + 9)
						EncriptedMsg .= chr(index + 34 + 3)
						FlagSignCount++
						break
					}
				case FlagSignCount == 3:
					if (letter == A_LoopField) {
						EncriptedMsg .= chr(index + 34 + 20)
						EncriptedMsg .= chr(index + 34 + 30)
						FlagSignCount := 0
						break
					}
				}
			}
		case ord(A_LoopField) > 64 and ord(A_LoopField) < 91:
			; (A-Z)
			EncriptedString := A_LoopField
			for index, letter in StrSplit(MixedPattern) {
				switch true {
				case Flag_AZ_Count2 == 0:
					if (letter == A_LoopField) {
						EncriptedMsg .= chr(index + 34 + 16)
						EncriptedMsg .= chr(index + 34 + 28)
						Flag_AZ_Count2++
						break
					}
				case Flag_AZ_Count2 == 1:
					if (letter == A_LoopField) {
						EncriptedMsg .= chr(index + 34 + 9)
						EncriptedMsg .= chr(index + 34 + 18)
						Flag_AZ_Count2++
						break
					}
				case Flag_AZ_Count2 == 2:
					if (letter == A_LoopField) {
						EncriptedMsg .= chr(index + 34 + 15)
						EncriptedMsg .= chr(index + 34 + 16)
						Flag_AZ_Count2 := 0
						break
					}
				}
			}
		case ord(A_LoopField) > 90 and ord(A_LoopField) < 97:
			; punctuation signs
			for index, letter in StrSplit(PunctuationPattern) {
				switch true {
				case FlagSignCount == 0:
					if (letter == A_LoopField) {
						EncriptedMsg .= chr(index + 34 + 6)
						EncriptedMsg .= chr(index + 34 + 4)
						FlagSignCount++
						break
					}
				case FlagSignCount == 1:
					if (letter == A_LoopField) {
						EncriptedMsg .= chr(index + 34 + 3)
						EncriptedMsg .= chr(index + 34 + 8)
						FlagSignCount++
						break
					}
				case FlagSignCount == 2:
					if (letter == A_LoopField) {
						EncriptedMsg .= chr(index + 34 + 9)
						EncriptedMsg .= chr(index + 34 + 3)
						FlagSignCount++
						break
					}
				case FlagSignCount == 3:
					if (letter == A_LoopField) {
						EncriptedMsg .= chr(index + 34 + 20)
						EncriptedMsg .= chr(index + 34 + 30)
						FlagSignCount := 0
						break
					}
				}
			}
		case ord(A_LoopField) > 96 and ord(A_LoopField) < 123:
			; (a-z)
			EncriptedString := A_LoopField
			for index, letter in StrSplit(MixedPattern) {
				switch true {
				case Flag_az_Count == 0:
					if (letter == A_LoopField) {
						EncriptedMsg .= chr(index + 34 + 29)
						EncriptedMsg .= chr(index + 34 + 25)
						Flag_az_Count++
						break
					}
				case Flag_az_Count == 1:
					if (letter == A_LoopField) {
						EncriptedMsg .= chr(index + 34 + 10)
						EncriptedMsg .= chr(index + 34 + 18)
						Flag_az_Count++
						break
					}
				case Flag_az_Count == 2:
					if (letter == A_LoopField) {
						EncriptedMsg .= chr(index + 34 + 15)
						EncriptedMsg .= chr(index + 34 + 22)
						Flag_az_Count := 0
						break
					}
				}
			}
		case ord(A_LoopField) > 122 and ord(A_LoopField) < 127:
			; punctuation signs
			for index, letter in StrSplit(PunctuationPattern) {
				switch true {
				case FlagSignCount == 0:
					if (letter == A_LoopField) {
						EncriptedMsg .= chr(index + 34 + 6)
						EncriptedMsg .= chr(index + 34 + 4)
						FlagSignCount++
						break
					}
				case FlagSignCount == 1:
					if (letter == A_LoopField) {
						EncriptedMsg .= chr(index + 34 + 3)
						EncriptedMsg .= chr(index + 34 + 8)
						FlagSignCount++
						break
					}
				case FlagSignCount == 2:
					if (letter == A_LoopField) {
						EncriptedMsg .= chr(index + 34 + 9)
						EncriptedMsg .= chr(index + 34 + 3)
						FlagSignCount++
						break
					}
				case FlagSignCount == 3:
					if (letter == A_LoopField) {
						EncriptedMsg .= chr(index + 34 + 20)
						EncriptedMsg .= chr(index + 34 + 30)
						FlagSignCount := 0
						break
					}
				}
			}
		}
	}
	return EncriptedMsg
}
;----------------------------------------------------
DecriptMsg(EncriptedMsgMLTA, *) {
	MixedPattern := "Az0By9Cx7Da8Eb2Fc4Gw3Hv5Ij6Js1KlLhMpNeOtPgQnRrSiTqUoVkWmXdYfZu"
	PunctuationPattern := "!#$%&'()*+,-./:;<=>?@[\]^_`"{|}~ "
	DecriptedMsg := ""
	
	count := 1
	DiffValue := 0
	IndexKey := 0
	Loop Parse EncriptedMsgMLTA {
		if Mod(count, 2) == 1 {
			RealKey := ord(A_LoopField)
		}
		
		if Mod(count, 2) == 0 {
			AddedKey1 := ord(A_LoopField)
			DiffValue := Abs(RealKey - AddedKey1)
			flagLetterFound := 0
			switch true {
			case DiffValue == 1:
				IndexKey := RealKey - 34 - 15
				for index, letter in StrSplit(MixedPattern) {
					if IndexKey < 0 {
						; continue
					}
					if index == IndexKey {
						DecriptedMsg .= letter
						break
					}
				}
			case DiffValue == 2:
				IndexKey := RealKey - 34 - 6
				for index, letter in StrSplit(PunctuationPattern) {
					if IndexKey < 0 {
						; continue
					}
					if index == IndexKey {
						DecriptedMsg .= letter
						break
					}
				}
			case DiffValue == 3:
				IndexKey := RealKey - 34 - 6
				for index, letter in StrSplit(MixedPattern) {
					if IndexKey < 0 {
						; continue
					}
					if index == IndexKey {
						DecriptedMsg .= letter
						break
					}
				}
			case DiffValue == 4:
				IndexKey := RealKey - 34 - 29
				for index, letter in StrSplit(MixedPattern) {
					if IndexKey < 0 {
						continue
					}
					if index == IndexKey {
						DecriptedMsg .= letter
						break
					}
				}
			case DiffValue == 5:
				IndexKey := RealKey - 34 - 3
				for index, letter in StrSplit(PunctuationPattern) {
					if IndexKey < 0 {
						; continue
					}
					if index == IndexKey {
						DecriptedMsg .= letter
						break
					}
				}
			case DiffValue == 6:
				IndexKey := RealKey - 34 - 9
				for index, letter in StrSplit(PunctuationPattern) {
					if IndexKey < 0 {
						; continue
					}
					if index == IndexKey {
						DecriptedMsg .= letter
						break
					}
				}
			case DiffValue == 7:
				IndexKey := RealKey - 34 - 15
				for index, letter in StrSplit(MixedPattern) {
					if IndexKey < 0 {
						; continue
					}
					if index == IndexKey {
						DecriptedMsg .= letter
						break
					}
				}
			case DiffValue == 8:
				IndexKey := RealKey - 34 - 10
				for index, letter in StrSplit(MixedPattern) {
					if IndexKey < 0 {
						; continue
					}
					if index == IndexKey {
						DecriptedMsg .= letter
						break
					}
				}
			case DiffValue == 9:
				IndexKey := RealKey - 34 - 9
				for index, letter in StrSplit(MixedPattern) {
					if IndexKey < 0 {
						; continue
					}
					if index == IndexKey {
						DecriptedMsg .= letter
						break
					}
				}
			case DiffValue == 10:
				IndexKey := RealKey - 34 - 20
				for index, letter in StrSplit(PunctuationPattern) {
					if IndexKey < 0 {
						; continue
					}
					if index == IndexKey {
						DecriptedMsg .= letter
						break
					}
				}
			case DiffValue == 11:
				IndexKey := RealKey - 34 - 7
				for index, letter in StrSplit(MixedPattern) {
					if IndexKey < 0 {
						continue
					}
					if index == IndexKey {
						DecriptedMsg .= letter
						break
					}
				}
			case DiffValue == 12:
				IndexKey := RealKey - 34 - 16
				for index, letter in StrSplit(MixedPattern) {
					if IndexKey < 0 {
						continue
					}
					if index == IndexKey {
						DecriptedMsg .= letter
						break
					}
				}
			case DiffValue == 14:
				IndexKey := RealKey - 34 - 10
				for index, letter in StrSplit(MixedPattern) {
					if IndexKey < 0 {
						continue
					}
					if index == IndexKey {
						DecriptedMsg .= letter
						break
					}
				}
			}
		}
		count++
	}
	return DecriptedMsg
}
;----------------------------------------------------
ParseRequest(*){
	TempFileMLTA := A_Temp . "\MLTA_UpdateData.ini"
	EncCurl := "PLjr_f_[HF16bjKEBLHTHF@E,5ovgcNVelmi\d3:JFT\ahsoX``:4V``Y``sobjW^kgHFV^ahgcNVovMI?DPX<CgcE?FCGR23EQJS89amGU,5+(ZbKRJK<HDObkTUwsBNjr9@V_PZDRVW_kmiDMbj>?KWPYHOc_.6\]am\eNUGC.6``a]d6B=:;Fc_PYLTJXY``YUIQBI.+D@XYNV_k]dGC>GFNDEGRip6B5C;D>?Q]=:>I;DAOPQ6BfoPL\dno[bCAEJa]T\Y``c_IQ:4DN64<Cc_\d27[bokT\SZ}y:B82BIsodlDN_feaPXel\X64BN5>MN16<H7?NUa]93NWRSBLco7?NUuq42,5jrY``sodl<Cgc``h_f38miRZQXea7?NUeaIQ93QXJFT\W^\XT\"
	RunWait(A_ComSpec " /c " . DecriptMsg(EncCurl) . " > " TempFileMLTA, , "Hide")
	
	ReleaseVersion := ""
	DownloadFile := ""
	Count := 0

	Loop Read, TempFileMLTA
	{
		; Check if the current line is empty
		if !A_LoopReadLine {
			Count++
			continue
		}
		
		; Process the non-empty line here
		Flag1stLetter := 0
		CountOrd34 := 0
		FlagAddedSpace := 0
		CleanLine := ""
		Loop parse A_LoopReadLine {
			if ord(A_LoopField) == 34 {
				CountOrd34++
				if CountOrd34 == 4 {
					break
				}
			}
			if Flag1stLetter == 1 {
				Switch true {
				case ord(A_LoopField) == 32 and FlagAddedSpace == 0:
					CleanLine .= A_LoopField
					FlagAddedSpace := 1
				case ord(A_LoopField) == 34 and FlagAddedSpace == 0:
					CleanLine .= " "
					FlagAddedSpace := 1
				case ord(A_LoopField) == 44:
					break
				case ord(A_LoopField) != 34:
					CleanLine .= A_LoopField
					FlagAddedSpace := 0
				}	
			} 
			if ord(A_LoopField) != 32 and Flag1stLetter == 0 {
				Flag1stLetter := 1
				if ord(A_LoopField) != 34 {
					break
				}
			}
		}
		FileAppend CleanLine . "`n", TempCleanFileMLTA
		Match := RegExMatch(CleanLine, "tag_name : v\d+\.\d+", &tag_name)
		Match2 := RegExMatch(CleanLine, "url : https://api.github.com/repos/FDJ-Dash/ML-Task-Automator/releases/assets/\d+", &download_url)
		Match3 := RegExMatch(CleanLine, "name : \w+-\w+-\w+-\w+-v\d+\.\d+\.\w+", &name)
		Switch true {
		case Match == true:
			for index, word in StrSplit(tag_name[0], A_Space) {
				if index == 3 {
					MLTALatestReleaseVersion := word
					IniWrite MLTALatestReleaseVersion, DataFile, "GeneralData", "MLTALatestReleaseVersion"
				}
			}
		case Match2 == true:
			for index, word in StrSplit(download_url[0], A_Space) {
				if index == 3 {
					DownloadUrl := word
					DownloadUrl := EncriptMsg(DownloadUrl)
					IniWrite DownloadUrl, DataFile, "EncriptedData", "MLTADownload"
				}
			}
		case Match3 == true:
			for index, word in StrSplit(name[0], A_Space) {
				if index == 3 {
					Name := word
					IniWrite Name, DataFile, "GeneralData", "MLTAName"
				}
			}
		}
	}
	
	try {
		FileDelete TempFileMLTA
	}
	catch {

	}
}
;----------------------------------------------------
CheckConnection(*){
	TempFileConnectionMLTA := A_Temp . "\MLTA_Connection.log"
	RunWait(A_ComSpec " /c curl -k -L https://www.google.com > " TempFileConnectionMLTA, , "Hide")
	Match := false
	Count := 0
	Loop Read, TempFileConnectionMLTA
	{
		; Check if the current line is empty
		if !A_LoopReadLine {
			Count++
			continue
		}
		if Count > 0 {
			Match := true
			break
		}
		Count++
	}
	
	try {
		FileDelete TempFileConnectionMLTA
	}
	catch {

	}
	return Match
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
MenuHandlerUpdate(*){
	SB.SetText("Checking for updates..")
	Connection := CheckConnection()
	if Connection != true {
		ConnectionMessage()
		return
	}
	ParseRequest()
	DownloadUrl := IniRead(DataFile, "EncriptedData", "MLTADownload")
	MLTALatestReleaseVersion := IniRead(DataFile, "GeneralData", "MLTALatestReleaseVersion")
	IniWrite A_Now, IniFile, "Settings", "LastUpdateCheckTimeStamp"
	if MLTALatestReleaseVersion != CurrentVersion {
		if DownloadUrl != "" {
			IniWrite true, IniFile, "Settings", "NeedUpdate"
			NewVersionAvailableMessage(MLTALatestReleaseVersion)
		}
	}
	If MLTALatestReleaseVersion == CurrentVersion {
		UpToDateMessage()
	}
}
;----------------------------------------------------
MenuHandlerCheckUptDaily(*){
	CheckforUpdatesDaily := true
	CheckforupdatesWeekly := false
	NeverCheckForUpdates := false
	IniWrite CheckforUpdatesDaily, IniFile, "Settings", "CheckforUpdatesDaily"
	IniWrite CheckforupdatesWeekly, IniFile, "Settings", "CheckforupdatesWeekly"
	IniWrite NeverCheckForUpdates, IniFile, "Settings", "NeverCheckForUpdates"
	Reload
}
;----------------------------------------------------
MenuHandlerCheckUptWeekly(*){
	CheckforUpdatesDaily := false
	CheckforupdatesWeekly := true
	NeverCheckForUpdates := false
	IniWrite CheckforUpdatesDaily, IniFile, "Settings", "CheckforUpdatesDaily"
	IniWrite CheckforupdatesWeekly, IniFile, "Settings", "CheckforupdatesWeekly"
	IniWrite NeverCheckForUpdates, IniFile, "Settings", "NeverCheckForUpdates"
	Reload
}
;----------------------------------------------------
MenuHandlerNeverCheckUpt(*){
	CheckforUpdatesDaily := false
	CheckforupdatesWeekly := false
	NeverCheckForUpdates := true
	IniWrite CheckforUpdatesDaily, IniFile, "Settings", "CheckforUpdatesDaily"
	IniWrite CheckforupdatesWeekly, IniFile, "Settings", "CheckforupdatesWeekly"
	IniWrite NeverCheckForUpdates, IniFile, "Settings", "NeverCheckForUpdates"
	Reload
}
;----------------------------------------------------
SuspendMenuHandler(*){
	AuxSuspend := A_IsSuspended
	AuxSuspend := !AuxSuspend
	if AuxSuspend == true {
		FileMenu.ToggleCheck("Suspend Hotkeys`t" . SuspendHotkeysKey)
		ToggleHotkeysDisabled()
		sleep 500
	} else {
		FileMenu.Uncheck("Suspend Hotkeys`t" . SuspendHotkeysKey)
		ToggleHotkeysEnabled()
		sleep 500
	}
	Suspend()
}
;----------------------------------------------------
MenuHandlerQuickFix(*) {
	Send("{w up}")
	Send("{shift up}")
	Reload
}
;----------------------------------------------------
; Save to ini file and reload
HotkeyEditModeHandler(*) {
	HotkeyEditMode := IniRead(IniFile, "Properties", "HotkeyEditMode")
	HotkeyEditMode := !HotkeyEditMode
	IniWrite HotkeyEditMode, IniFile, "Properties", "HotkeyEditMode"
	Reload
}
;----------------------------------------------------
EditBoxesHandler(*){
	EditBoxesAvailable := IniRead(IniFile, "Properties", "EditBoxesAvailable")
	EditBoxesAvailable := !EditBoxesAvailable
	IniWrite EditBoxesAvailable, IniFile, "Properties", "EditBoxesAvailable"
	Reload
}
;----------------------------------------------------
GuiPriorityAlwaysOnTopHandler(*){
	GuiPriorityAlwaysOnTop := IniRead(IniFile, "Properties", "GuiPriorityAlwaysOnTop")
	GuiPriorityAlwaysOnTop := !GuiPriorityAlwaysOnTop
	IniWrite GuiPriorityAlwaysOnTop, IniFile, "Properties", "GuiPriorityAlwaysOnTop"
	Reload
}
;----------------------------------------------------
KbAutoRunOFFHandler(*){
	SwitchKbAutoRun := IniRead(IniFile, "Modules", "SwitchKbAutoRun")
	SwitchKbAutoRun := !SwitchKbAutoRun
	IniWrite SwitchKbAutoRun, IniFile, "Modules", "SwitchKbAutoRun"
	Send("{" . SprintKey . " up}")
	Send("{" . ForwardKey . " up}")
	Reload
}
;----------------------------------------------------
ControllerAutoRunOFFHandler(*){
	SwitchControllerAutoRun := IniRead(IniFile, "Modules", "SwitchControllerAutoRun")
	SwitchControllerAutoRun := !SwitchControllerAutoRun
	IniWrite SwitchControllerAutoRun, IniFile, "Modules", "SwitchControllerAutoRun"
	Send("{" . SprintKey . " up}")
	Send("{" . ButtonRT . " up}")
	Reload
}
;----------------------------------------------------
SwitchJumpsHandler(*){
	SwitchClicker := false
	SwitchQuickAccess := false
	SwitchJumps := true
	SwitchModulesOFF := false
	IniWrite SwitchJumps, IniFile, "Modules", "SwitchJumps"
	IniWrite SwitchQuickAccess, IniFile, "Modules", "SwitchQuickAccess"
	IniWrite SwitchClicker, IniFile, "Modules", "SwitchClicker"
	IniWrite SwitchModulesOFF, IniFile, "Modules", "SwitchModulesOFF"
	Reload
}
;----------------------------------------------------
SwitchClickerHandler(*){
	SwitchJumps := false
	SwitchQuickAccess := false
	SwitchClicker := true
	SwitchModulesOFF := false
	IniWrite SwitchJumps, IniFile, "Modules", "SwitchJumps"
	IniWrite SwitchQuickAccess, IniFile, "Modules", "SwitchQuickAccess"
	IniWrite SwitchClicker, IniFile, "Modules", "SwitchClicker"
	IniWrite SwitchModulesOFF, IniFile, "Modules", "SwitchModulesOFF"
	Reload
}
;----------------------------------------------------
QuickAccessHandler(*) {
	SwitchJumps := false
	SwitchClicker := false
	SwitchQuickAccess := true
	SwitchModulesOFF := false
	IniWrite SwitchJumps, IniFile, "Modules", "SwitchJumps"
	IniWrite SwitchClicker, IniFile, "Modules", "SwitchClicker"
	IniWrite SwitchQuickAccess, IniFile, "Modules", "SwitchQuickAccess"
	IniWrite SwitchModulesOFF, IniFile, "Modules", "SwitchModulesOFF"
	Reload
}
;----------------------------------------------------
SwitchTopModulesOFFHandler(*){
	SwitchKbAutoRun := false
	SwitchControllerAutoRun := false
	SwitchTopModulesOFF := true
	IniWrite SwitchKbAutoRun, IniFile, "Modules", "SwitchKbAutoRun"
	IniWrite SwitchControllerAutoRun, IniFile, "Modules", "SwitchControllerAutoRun"
	IniWrite SwitchTopModulesOFF, IniFile, "Modules", "SwitchTopModulesOFF"
	Reload
}
;----------------------------------------------------
SwitchBottomModulesOFFHandler(*){
	SwitchJumps := false
	SwitchQuickAccess := false
	SwitchClicker := false
	SwitchModulesOFF := true
	IniWrite SwitchJumps, IniFile, "Modules", "SwitchJumps"
	IniWrite SwitchClicker, IniFile, "Modules", "SwitchClicker"
	IniWrite SwitchQuickAccess, IniFile, "Modules", "SwitchQuickAccess"
	IniWrite SwitchModulesOFF, IniFile, "Modules", "SwitchModulesOFF"
	Send("{" . SprintKey . " up}")
	Send("{" . ButtonRT . " up}")
	Reload
}
;----------------------------------------------------
QuickAccessButtonsHandler(*) {
	if SwitchQuickAccess == false {
		MenuHandlerQuickAccessMsg
	} else {
		QuickAccessButtons := IniRead(IniFile, "Modules", "QuickAccessButtons")
		QuickAccessButtons := !QuickAccessButtons
		IniWrite QuickAccessButtons, IniFile, "Modules", "QuickAccessButtons"
		Reload
	}
}
;----------------------------------------------------
ChangeBackgroundHandler(*){
	SelectedFile := FileSelect(3, "", "Open a file", "Text Documents (*.ico; *.png; *.jpg)")
	IniWrite SelectedFile, IniFile, "Background", "BackgroundPicture"
	Reload
}
;----------------------------------------------------
ChangeMessageBackgroundHandler(*){
	SelectedFile := FileSelect(3, "", "Open a file", "Text Documents (*.ico; *.png; *.jpg)")
	IniWrite SelectedFile, IniFile, "Background", "MessageBackgroundPicture"
	Reload
}
;----------------------------------------------------
SelectNewIcon1(*) {
	SelectedFile := FileSelect(3, "", "Open a file", "Text Documents (*.ico; *.png; *.jpg)")
	IniWrite SelectedFile, IniFile, "QuickAccessIcons", "QuickIcon1"
	Reload
}
;----------------------------------------------------
SelectNewIcon2(*) {
	SelectedFile := FileSelect(3, "", "Open a file", "Text Documents (*.ico; *.png; *.jpg)")
	IniWrite SelectedFile, IniFile, "QuickAccessIcons", "QuickIcon2"
	Reload
}
;----------------------------------------------------
SelectNewIcon3(*) {
	SelectedFile := FileSelect(3, "", "Open a file", "Text Documents (*.ico; *.png; *.jpg)")
	IniWrite SelectedFile, IniFile, "QuickAccessIcons", "QuickIcon3"
	Reload
}
;----------------------------------------------------
SelectNewIcon4(*) {
	SelectedFile := FileSelect(3, "", "Open a file", "Text Documents (*.ico; *.png; *.jpg)")
	IniWrite SelectedFile, IniFile, "QuickAccessIcons", "QuickIcon4"
	Reload
}
;----------------------------------------------------
SelectNewIcon5(*) {
	SelectedFile := FileSelect(3, "", "Open a file", "Text Documents (*.ico; *.png; *.jpg)")
	IniWrite SelectedFile, IniFile, "QuickAccessIcons", "QuickIcon5"
	Reload
}
;----------------------------------------------------
SelectNewIcon6(*) {
	SelectedFile := FileSelect(3, "", "Open a file", "Text Documents (*.ico; *.png; *.jpg)")
	IniWrite SelectedFile, IniFile, "QuickAccessIcons", "QuickIcon6"
	Reload
}
;----------------------------------------------------
SelectNewIcon7(*) {
	SelectedFile := FileSelect(3, "", "Open a file", "Text Documents (*.ico; *.png; *.jpg)")
	IniWrite SelectedFile, IniFile, "QuickAccessIcons", "QuickIcon7"
	Reload
}
;----------------------------------------------------
SelectNewIcon8(*) {
	SelectedFile := FileSelect(3, "", "Open a file", "Text Documents (*.ico; *.png; *.jpg)")
	IniWrite SelectedFile, IniFile, "QuickAccessIcons", "QuickIcon8"
	Reload
}
;----------------------------------------------------
SelectNewIcon9(*) {
	SelectedFile := FileSelect(3, "", "Open a file", "Text Documents (*.ico; *.png; *.jpg)")
	IniWrite SelectedFile, IniFile, "QuickAccessIcons", "QuickIcon9"
	Reload
}
;----------------------------------------------------
SelectTopPicture(*) {
	SelectedFile := FileSelect(3, "", "Open a file", "Text Documents (*.ico; *.png; *.jpg)")
	IniWrite SelectedFile, IniFile, "Pictures", "TopPicture"
	Reload
}
;----------------------------------------------------
SelectBottomPicture(*) {
	SelectedFile := FileSelect(3, "", "Open a file", "Text Documents (*.ico; *.png; *.jpg)")
	IniWrite SelectedFile, IniFile, "Pictures", "BottomPicture"
	Reload
}
;----------------------------------------------------
SubmitJumpHotkey0(*){
	if GetKeyState("Ctrl", "P") {
		CtrlJumpHotkey0 := 1
		IniWrite CtrlJumpHotkey0, AuxHkDataFile, "CtrlHkFlags", "CtrlJumpHotkey0"
	}
	if GetKeyState("Alt", "P") {
		AltJumpHotkey0 := 1
		IniWrite AltJumpHotkey0, AuxHkDataFile, "AltHkFlags", "AltJumpHotkey0"
	}
	if GetKeyState("Shift", "P") {
		ShiftJumpHotkey0 := 1
		IniWrite ShiftJumpHotkey0, AuxHkDataFile, "ShiftHkFlags", "ShiftJumpHotkey0"
	}
	sleep 500
	Saved := TaskAutomatorGui.Submit(false)
	IniWrite Saved.JumpHotkey0, IniFile, "SavedHotkey", "JumpHotkey0"
	Reload
}
SubmitJumpHotkey1(*){
	if GetKeyState("Ctrl", "P") {
		CtrlJumpHotkey1 := 1
		IniWrite CtrlJumpHotkey1, AuxHkDataFile, "CtrlHkFlags", "CtrlJumpHotkey1"
	}
	if GetKeyState("Alt", "P") {
		AltJumpHotkey1 := 1
		IniWrite AltJumpHotkey1, AuxHkDataFile, "AltHkFlags", "AltJumpHotkey1"
	}
	if GetKeyState("Shift", "P") {
		ShiftJumpHotkey1 := 1
		IniWrite ShiftJumpHotkey1, AuxHkDataFile, "ShiftHkFlags", "ShiftJumpHotkey1"
	}
	sleep 500
	Saved := TaskAutomatorGui.Submit(false)
	IniWrite Saved.JumpHotkey1, IniFile, "SavedHotkey", "JumpHotkey1"
	Reload
}
SubmitJumpHotkey2(*){
	if GetKeyState("Ctrl", "P") {
		CtrlJumpHotkey2 := 1
		IniWrite CtrlJumpHotkey2, AuxHkDataFile, "CtrlHkFlags", "CtrlJumpHotkey2"
	}
	if GetKeyState("Alt", "P") {
		AltJumpHotkey2 := 1
		IniWrite AltJumpHotkey2, AuxHkDataFile, "AltHkFlags", "AltJumpHotkey2"
	}
	if GetKeyState("Shift", "P") {
		ShiftJumpHotkey2 := 1
		IniWrite ShiftJumpHotkey2, AuxHkDataFile, "ShiftHkFlags", "ShiftJumpHotkey2"
	}
	sleep 500
	Saved := TaskAutomatorGui.Submit(false)
	IniWrite Saved.JumpHotkey2, IniFile, "SavedHotkey", "JumpHotkey2"
	Reload
}
SubmitJumpHotkey3(*){
	if GetKeyState("Ctrl", "P") {
		CtrlJumpHotkey3 := 1
		IniWrite CtrlJumpHotkey3, AuxHkDataFile, "CtrlHkFlags", "CtrlJumpHotkey3"
	}
	if GetKeyState("Alt", "P") {
		AltJumpHotkey3 := 1
		IniWrite AltJumpHotkey3, AuxHkDataFile, "AltHkFlags", "AltJumpHotkey3"
	}
	if GetKeyState("Shift", "P") {
		ShiftJumpHotkey3 := 1
		IniWrite ShiftJumpHotkey3, AuxHkDataFile, "ShiftHkFlags", "ShiftJumpHotkey3"
	}
	sleep 500
	Saved := TaskAutomatorGui.Submit(false)
	IniWrite Saved.JumpHotkey3, IniFile, "SavedHotkey", "JumpHotkey3"
	Reload
}
SubmitJumpHotkey4(*){
	if GetKeyState("Ctrl", "P") {
		CtrlJumpHotkey4 := 1
		IniWrite CtrlJumpHotkey4, AuxHkDataFile, "CtrlHkFlags", "CtrlJumpHotkey4"
	}
	if GetKeyState("Alt", "P") {
		AltJumpHotkey4 := 1
		IniWrite AltJumpHotkey4, AuxHkDataFile, "AltHkFlags", "AltJumpHotkey4"
	}
	if GetKeyState("Shift", "P") {
		ShiftJumpHotkey4 := 1
		IniWrite ShiftJumpHotkey4, AuxHkDataFile, "ShiftHkFlags", "ShiftJumpHotkey4"
	}
	sleep 500
	Saved := TaskAutomatorGui.Submit(false)
	IniWrite Saved.JumpHotkey4, IniFile, "SavedHotkey", "JumpHotkey4"
	Reload
}
;----------------------------------------------------
SubmitQuickAccess1(*){
	if GetKeyState("Ctrl", "P") {
		CtrlQuickAccessHk1 := 1
		IniWrite CtrlQuickAccessHk1, AuxHkDataFile, "CtrlHkFlags", "CtrlQuickAccessHk1"
	}
	if GetKeyState("Alt", "P") {
		AltQuickAccessHk1 := 1
		IniWrite AltQuickAccessHk1, AuxHkDataFile, "AltHkFlags", "AltQuickAccessHk1"
	}
	if GetKeyState("Shift", "P") {
		ShiftQuickAccessHk1 := 1
		IniWrite ShiftQuickAccessHk1, AuxHkDataFile, "ShiftHkFlags", "ShiftQuickAccessHk1"
	}
	sleep 500
	Saved := TaskAutomatorGui.Submit(false)
	IniWrite Saved.QuickAccessHk1, IniFile, "SavedHotkey", "QuickAccessHk1"
	Reload
}
;----------------------------------------------------
SubmitQuickAccess2(*){
	if GetKeyState("Ctrl", "P") {
		CtrlQuickAccessHk2 := 1
		IniWrite CtrlQuickAccessHk2, AuxHkDataFile, "CtrlHkFlags", "CtrlQuickAccessHk2"
	}
	if GetKeyState("Alt", "P") {
		AltQuickAccessHk2 := 1
		IniWrite AltQuickAccessHk2, AuxHkDataFile, "AltHkFlags", "AltQuickAccessHk2"
	}
	if GetKeyState("Shift", "P") {
		ShiftQuickAccessHk2 := 1
		IniWrite ShiftQuickAccessHk2, AuxHkDataFile, "ShiftHkFlags", "ShiftQuickAccessHk2"
	}
	sleep 500
	Saved := TaskAutomatorGui.Submit(false)
	IniWrite Saved.QuickAccessHk2, IniFile, "SavedHotkey", "QuickAccessHk2"
	Reload
}
;----------------------------------------------------
SubmitQuickAccess3(*){
	if GetKeyState("Ctrl", "P") {
		CtrlQuickAccessHk3 := 1
		IniWrite CtrlQuickAccessHk3, AuxHkDataFile, "CtrlHkFlags", "CtrlQuickAccessHk3"
	}
	if GetKeyState("Alt", "P") {
		AltQuickAccessHk3 := 1
		IniWrite AltQuickAccessHk3, AuxHkDataFile, "AltHkFlags", "AltQuickAccessHk3"
	}
	if GetKeyState("Shift", "P") {
		ShiftQuickAccessHk3 := 1
		IniWrite ShiftQuickAccessHk3, AuxHkDataFile, "ShiftHkFlags", "ShiftQuickAccessHk3"
	}
	sleep 500
	Saved := TaskAutomatorGui.Submit(false)
	IniWrite Saved.QuickAccessHk3, IniFile, "SavedHotkey", "QuickAccessHk3"
	Reload
}
;----------------------------------------------------
SubmitQuickAccess4(*){
	if GetKeyState("Ctrl", "P") {
		CtrlQuickAccessHk4 := 1
		IniWrite CtrlQuickAccessHk4, AuxHkDataFile, "CtrlHkFlags", "CtrlQuickAccessHk4"
	}
	if GetKeyState("Alt", "P") {
		AltQuickAccessHk4 := 1
		IniWrite AltQuickAccessHk4, AuxHkDataFile, "AltHkFlags", "AltQuickAccessHk4"
	}
	if GetKeyState("Shift", "P") {
		ShiftQuickAccessHk4 := 1
		IniWrite ShiftQuickAccessHk4, AuxHkDataFile, "ShiftHkFlags", "ShiftQuickAccessHk4"
	}
	sleep 500
	Saved := TaskAutomatorGui.Submit(false)
	IniWrite Saved.QuickAccessHk4, IniFile, "SavedHotkey", "QuickAccessHk4"
	Reload
}
;----------------------------------------------------
SubmitQuickAccess5(*){
	if GetKeyState("Ctrl", "P") {
		CtrlQuickAccessHk5 := 1
		IniWrite CtrlQuickAccessHk5, AuxHkDataFile, "CtrlHkFlags", "CtrlQuickAccessHk5"
	}
	if GetKeyState("Alt", "P") {
		AltQuickAccessHk5 := 1
		IniWrite AltQuickAccessHk5, AuxHkDataFile, "AltHkFlags", "AltQuickAccessHk5"
	}
	if GetKeyState("Shift", "P") {
		ShiftQuickAccessHk5 := 1
		IniWrite ShiftQuickAccessHk5, AuxHkDataFile, "ShiftHkFlags", "ShiftQuickAccessHk5"
	}
	sleep 500
	Saved := TaskAutomatorGui.Submit(false)
	IniWrite Saved.QuickAccessHk5, IniFile, "SavedHotkey", "QuickAccessHk5"
	Reload
}
;----------------------------------------------------
SubmitQuickAccess6(*){
	if GetKeyState("Ctrl", "P") {
		CtrlQuickAccessHk6 := 1
		IniWrite CtrlQuickAccessHk6, AuxHkDataFile, "CtrlHkFlags", "CtrlQuickAccessHk6"
	}
	if GetKeyState("Alt", "P") {
		AltQuickAccessHk6 := 1
		IniWrite AltQuickAccessHk6, AuxHkDataFile, "AltHkFlags", "AltQuickAccessHk6"
	}
	if GetKeyState("Shift", "P") {
		ShiftQuickAccessHk6 := 1
		IniWrite ShiftQuickAccessHk6, AuxHkDataFile, "ShiftHkFlags", "ShiftQuickAccessHk6"
	}
	sleep 500
	Saved := TaskAutomatorGui.Submit(false)
	IniWrite Saved.QuickAccessHk6, IniFile, "SavedHotkey", "QuickAccessHk6"
	Reload
}
;----------------------------------------------------
SubmitQuickAccess7(*){
	if GetKeyState("Ctrl", "P") {
		CtrlQuickAccessHk7 := 1
		IniWrite CtrlQuickAccessHk7, AuxHkDataFile, "CtrlHkFlags", "CtrlQuickAccessHk7"
	}
	if GetKeyState("Alt", "P") {
		AltQuickAccessHk7 := 1
		IniWrite AltQuickAccessHk7, AuxHkDataFile, "AltHkFlags", "AltQuickAccessHk7"
	}
	if GetKeyState("Shift", "P") {
		ShiftQuickAccessHk7 := 1
		IniWrite ShiftQuickAccessHk7, AuxHkDataFile, "ShiftHkFlags", "ShiftQuickAccessHk7"
	}
	sleep 500
	Saved := TaskAutomatorGui.Submit(false)
	IniWrite Saved.QuickAccessHk7, IniFile, "SavedHotkey", "QuickAccessHk7"
	Reload
}
;----------------------------------------------------
SubmitQuickAccess8(*){
	if GetKeyState("Ctrl", "P") {
		CtrlQuickAccessHk8 := 1
		IniWrite CtrlQuickAccessHk8, AuxHkDataFile, "CtrlHkFlags", "CtrlQuickAccessHk8"
	}
	if GetKeyState("Alt", "P") {
		AltQuickAccessHk8 := 1
		IniWrite AltQuickAccessHk8, AuxHkDataFile, "AltHkFlags", "AltQuickAccessHk8"
	}
	if GetKeyState("Shift", "P") {
		ShiftQuickAccessHk8 := 1
		IniWrite ShiftQuickAccessHk8, AuxHkDataFile, "ShiftHkFlags", "ShiftQuickAccessHk8"
	}
	sleep 500
	Saved := TaskAutomatorGui.Submit(false)
	IniWrite Saved.QuickAccessHk8, IniFile, "SavedHotkey", "QuickAccessHk8"
	Reload
}
;----------------------------------------------------
SubmitQuickAccess9(*){
	if GetKeyState("Ctrl", "P") {
		CtrlQuickAccessHk9 := 1
		IniWrite CtrlQuickAccessHk9, AuxHkDataFile, "CtrlHkFlags", "CtrlQuickAccessHk9"
	}
	if GetKeyState("Alt", "P") {
		AltQuickAccessHk9 := 1
		IniWrite AltQuickAccessHk9, AuxHkDataFile, "AltHkFlags", "AltQuickAccessHk9"
	}
	if GetKeyState("Shift", "P") {
		ShiftQuickAccessHk9 := 1
		IniWrite ShiftQuickAccessHk9, AuxHkDataFile, "ShiftHkFlags", "ShiftQuickAccessHk9"
	}
	sleep 500
	Saved := TaskAutomatorGui.Submit(false)
	IniWrite Saved.QuickAccessHk9, IniFile, "SavedHotkey", "QuickAccessHk9"
	Reload
}
;----------------------------------------------------
SubmitAutoRunHotkey(*){
	if GetKeyState("Ctrl", "P") {
		CtrlStartAutoRunHotkey := 1
		IniWrite CtrlStartAutoRunHotkey, AuxHkDataFile, "CtrlHkFlags", "CtrlStartAutoRunHotkey"
	}
	if GetKeyState("Alt", "P") {
		AltStartAutoRunHotkey := 1
		IniWrite AltStartAutoRunHotkey, AuxHkDataFile, "AltHkFlags", "AltStartAutoRunHotkey"
	}
	if GetKeyState("Shift", "P") {
		ShiftStartAutoRunHotkey := 1
		IniWrite ShiftStartAutoRunHotkey, AuxHkDataFile, "ShiftHkFlags", "ShiftStartAutoRunHotkey"
	}
	sleep 500
	Saved := TaskAutomatorGui.Submit(false)
	IniWrite Saved.StartAutoRunHotkey, IniFile, "SavedHotkey", "StartAutoRunHotkey"
	Reload
}
SubmitStopAutoRunHotkey(*){
	if GetKeyState("Ctrl", "P") {
		CtrlStopAutoRunHotKey := 1
		IniWrite CtrlStopAutoRunHotKey, AuxHkDataFile, "CtrlHkFlags", "CtrlStopAutoRunHotKey"
	}
	if GetKeyState("Alt", "P") {
		AltStopAutoRunHotKey := 1
		IniWrite AltStopAutoRunHotKey, AuxHkDataFile, "AltHkFlags", "AltStopAutoRunHotKey"
	}
	if GetKeyState("Shift", "P") {
		ShiftStopAutoRunHotKey := 1
		IniWrite ShiftStopAutoRunHotKey, AuxHkDataFile, "ShiftHkFlags", "ShiftStopAutoRunHotKey"
	}
	sleep 500
	Saved := TaskAutomatorGui.Submit(false)
	IniWrite Saved.StopAutoRunHotKey, IniFile, "SavedHotkey", "StopAutoRunHotKey"
	Reload
}
;----------------------------------------------------
SubmitPatternClickerHotkey(*){
	if GetKeyState("Ctrl", "P") {
		CtrlPatternClickerHotkey := 1
		IniWrite CtrlPatternClickerHotkey, AuxHkDataFile, "CtrlHkFlags", "CtrlPatternClickerHotkey"
	}
	if GetKeyState("Alt", "P") {
		AltPatternClickerHotkey := 1
		IniWrite AltPatternClickerHotkey, AuxHkDataFile, "AltHkFlags", "AltPatternClickerHotkey"
	}
	if GetKeyState("Shift", "P") {
		ShiftPatternClickerHotkey := 1
		IniWrite ShiftPatternClickerHotkey, AuxHkDataFile, "ShiftHkFlags", "ShiftPatternClickerHotkey"
	}
	sleep 500
	Saved := TaskAutomatorGui.Submit(false)
	IniWrite Saved.PatternClickerHotkey, IniFile, "SavedHotkey", "PatternClickerHotkey"
	Reload
}
;----------------------------------------------------
SubmitValues(*){
	Saved := TaskAutomatorGui.Submit(false)
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
		;----------------------------------------------------
		IniWrite Saved.CoordX5, IniFile, "CursorLocationClicker", "CoordX5"
		IniWrite Saved.CoordY5, IniFile, "CursorLocationClicker", "CoordY5"
		IniWrite Saved.Coord5Interval, IniFile, "CursorLocationClicker", "Coord5Interval"
		;----------------------------------------------------
		IniWrite Saved.CoordX6, IniFile, "CursorLocationClicker", "CoordX6"
		IniWrite Saved.CoordY6, IniFile, "CursorLocationClicker", "CoordY6"
		IniWrite Saved.Coord6Interval, IniFile, "CursorLocationClicker", "Coord6Interval"
		SaveMsg
	}
	if SwitchQuickAccess == true {
		IniWrite Saved.QuickAccess1, IniFile, "QuickAccessPath", "QuickAccess1"
		IniWrite Saved.QuickAccess2, IniFile, "QuickAccessPath", "QuickAccess2"
		IniWrite Saved.QuickAccess3, IniFile, "QuickAccessPath", "QuickAccess3"
		IniWrite Saved.QuickAccess4, IniFile, "QuickAccessPath", "QuickAccess4"
		IniWrite Saved.QuickAccess5, IniFile, "QuickAccessPath", "QuickAccess5"
		IniWrite Saved.QuickAccess6, IniFile, "QuickAccessPath", "QuickAccess6"
		IniWrite Saved.QuickAccess7, IniFile, "QuickAccessPath", "QuickAccess7"
		IniWrite Saved.QuickAccess8, IniFile, "QuickAccessPath", "QuickAccess8"
		IniWrite Saved.QuickAccess9, IniFile, "QuickAccessPath", "QuickAccess9"
		SaveMsg
	}
}
;----------------------------------------------------
CreateNewIniFile(*) {
	FileAppend "; ------------ Credits ------------`n" , IniFile
	FileAppend "; Creator: Fernando Daniel Jaime.`n" , IniFile
	FileAppend "; Programmer Alias: FDJ-Dash.`n" , IniFile
	FileAppend "; Gamer Alias: Mean Little, Grey Dash, Dash.`n" , IniFile
	FileAppend "; ------------ App Details ------------`n" , IniFile
	FileAppend "; App Full Name: Mean Little's Task Automator.`n" , IniFile
	FileAppend "; Description: This is an app aimed towards repetitive tasks like holding a`n" , IniFile
	FileAppend "; button down for extended time, mouse clicks or even click patterns.`n" , IniFile
	FileAppend "; Additionally, it brings interchangeable modules like jumps for certain`n" , IniFile
	FileAppend "; games and Quick access module to store and run any program in your computer`n" , IniFile
	FileAppend "; or load a web page on your browser easily.`n" , IniFile
	FileAppend ";--------------------------------------------------`n" , IniFile
	FileAppend "; NOTE: For all numpad keys, verify that NumLock key is activated / deactivated in order to trigger them.`n" , IniFile
	FileAppend ";--------------------------------------------------`n" , IniFile
	FileAppend "; HINT: If you delete this file or move it away from its forder,`n" , IniFile 
	FileAppend "; Task Automator will generate a new file with dafault values on the spot`n" , IniFile
	FileAppend ";--------------------------------------------------`n" , IniFile
	FileAppend "; ADVISE: If you need to use a specific Module, its a good idea to turn all`n" , IniFile
	FileAppend "; other modules OFF from the Options menu bar.`n" , IniFile
	FileAppend ";--------------------------------------------------`n" , IniFile
	FileAppend "; Find the list of key names here: https://www.autohotkey.com/docs/v2/KeyList.htm`n" , IniFile
	FileAppend ";-------------------------------`n" , IniFile
	FileAppend "; See the list of recommended fonts here: https://www.autohotkey.com/docs/v2/misc/FontsStandard.htm`n" , IniFile
	FileAppend ";-------------------------------`n" , IniFile
	FileAppend "; See the list of color names and RGB values here: https://www.autohotkey.com/docs/v2/misc/Colors.htm`n" , IniFile
	FileAppend "; Black Silver Gray White Maroon Red Purple Fuchsia Green Lime Olive Yellow Navy Blue Teal Aqua`n" , IniFile
	FileAppend "; If the color name you need is not listed you can still write its RGB value`n" , IniFile
	FileAppend ";--------------------------------------------------`n" , IniFile
	FileAppend "[Modules]`n" , IniFile
	FileAppend "SwitchKbAutoRun=1`n" , IniFile
	FileAppend "SwitchControllerAutoRun=1`n" , IniFile
	FileAppend "SwitchTopModulesOFF=1`n" , IniFile
	FileAppend ";-------------------------------`n" , IniFile
	FileAppend "SwitchQuickAccess=0`n" , IniFile
	FileAppend "QuickAccessButtons=1`n" , IniFile
	FileAppend "SwitchClicker=1`n" , IniFile
	FileAppend "SwitchJumps=0`n" , IniFile
	FileAppend "SwitchModulesOFF=0`n" , IniFile
	FileAppend ";--------------------------------------------------`n" , IniFile
	FileAppend "[Properties]`n" , IniFile
	FileAppend "ExitMessageTimeWait=3000`n" , IniFile
	FileAppend "SuspendedHotkeysTimeWait=1000`n" , IniFile
	FileAppend "HotkeyEditMode=1`n" , IniFile
	FileAppend "EditBoxesAvailable=1`n" , IniFile
	FileAppend "AutoRunLoopInterval=100`n" , IniFile
	FileAppend "GeneralLoopInterval=100`n" , IniFile
	FileAppend "LoopAmount=100`n" , IniFile
	FileAppend "GuiPriorityAlwaysOnTop=0`n" , IniFile
	FileAppend ";-------------------------------`n" , IniFile
	FileAppend "PositionX=928`n" , IniFile
	FileAppend "PositionY=115`n" , IniFile
	FileAppend ";-------------------------------`n" , IniFile
	FileAppend "ExitTaskAutomatorKey=Esc`n" , IniFile
	FileAppend "SuspendHotkeysKey=Enter`n" , IniFile
	FileAppend ";--------------------------------------------------`n" , IniFile
	FileAppend "[Settings]`n" , IniFile
	FileAppend "CheckforUpdatesDaily=1`n" , IniFile
	FileAppend "CheckforupdatesWeekly=0`n" , IniFile
	FileAppend "NeverCheckForUpdates=0`n" , IniFile
	FileAppend "NeedUpdate=0`n" , IniFile
	FileAppend ";-------------------------------`n" , IniFile
	FileAppend "LastUpdateCheckTimeStamp=`n" , IniFile
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
	FileAppend ";-------------------------------`n" , IniFile
	FileAppend "PatternClickerHotkey=Shift`n" , IniFile
	FileAppend ";-------------------------------`n" , IniFile
	FileAppend "JumpHotkey0=Numpad0`n" , IniFile
	FileAppend "JumpHotkey1=Numpad1`n" , IniFile
	FileAppend "JumpHotkey2=Numpad2`n" , IniFile
	FileAppend "JumpHotkey3=Numpad3`n" , IniFile
	FileAppend "JumpHotkey4=Numpad4`n" , IniFile
	FileAppend ";-------------------------------`n" , IniFile
	FileAppend "QuickAccessHk1=1`n" , IniFile
	FileAppend "QuickAccessHk2=2`n" , IniFile
	FileAppend "QuickAccessHk3=3`n" , IniFile
	FileAppend "QuickAccessHk4=4`n" , IniFile
	FileAppend "QuickAccessHk5=5`n" , IniFile
	FileAppend "QuickAccessHk6=6`n" , IniFile
	FileAppend "QuickAccessHk7=7`n" , IniFile
	FileAppend "QuickAccessHk8=8`n" , IniFile
	FileAppend "QuickAccessHk9=9`n" , IniFile
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
	FileAppend "Coord0Interval=450`n" , IniFile
	FileAppend ";-------------------------------`n" , IniFile
	FileAppend "CoordX1=950`n" , IniFile
	FileAppend "CoordY1=770`n" , IniFile
	FileAppend "Coord1Interval=450`n" , IniFile
	FileAppend ";-------------------------------`n" , IniFile
	FileAppend "CoordX2=840`n" , IniFile
	FileAppend "CoordY2=474`n" , IniFile
	FileAppend "Coord2Interval=450`n" , IniFile
	FileAppend ";-------------------------------`n" , IniFile
	FileAppend "CoordX3=1076`n" , IniFile
	FileAppend "CoordY3=474`n" , IniFile
	FileAppend "Coord3Interval=450`n" , IniFile
	FileAppend ";-------------------------------`n" , IniFile
	FileAppend "CoordX4=949`n" , IniFile
	FileAppend "CoordY4=463`n" , IniFile
	FileAppend "Coord4Interval=450`n" , IniFile
	FileAppend ";-------------------------------`n" , IniFile
	FileAppend "CoordX5=698`n" , IniFile
	FileAppend "CoordY5=336`n" , IniFile
	FileAppend "Coord5Interval=450`n" , IniFile
	FileAppend ";-------------------------------`n" , IniFile
	FileAppend "CoordX6=854`n" , IniFile
	FileAppend "CoordY6=175`n" , IniFile
	FileAppend "Coord6Interval=450`n" , IniFile
	FileAppend ";--------------------------------------------------`n" , IniFile
	FileAppend "[QuickAccessPath]`n" , IniFile
	FileAppend "QuickAccess1=https://mean-littles-app.gitbook.io/mean-littles-software`n" , IniFile
	FileAppend "QuickAccess2=https://cornucopias.io/`n" , IniFile
	FileAppend "QuickAccess3=C:\Users\`n" , IniFile
	FileAppend "QuickAccess4=https://outlook.live.com/mail/`n" , IniFile
	FileAppend "QuickAccess5=https://drive.google.com/drive/`n" , IniFile
	FileAppend "QuickAccess6=`n" , IniFile
	FileAppend "QuickAccess7=`n" , IniFile
	FileAppend "QuickAccess8=`n" , IniFile
	FileAppend "QuickAccess9=`n" , IniFile
	FileAppend ";--------------------------------------------------`n" , IniFile
	FileAppend "[QuickAccessIcons]`n" , IniFile
	FileAppend "QuickIcon1=`n" , IniFile
	FileAppend "QuickIcon2=`n" , IniFile
	FileAppend "QuickIcon3=`n" , IniFile
	FileAppend "QuickIcon4=`n" , IniFile
	FileAppend "QuickIcon5=`n" , IniFile
	FileAppend "QuickIcon6=`n" , IniFile
	FileAppend "QuickIcon7=`n" , IniFile
	FileAppend "QuickIcon8=`n" , IniFile
	FileAppend "QuickIcon9=`n" , IniFile
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
	FileAppend ";--------------------------------------------------`n" , IniFile
	FileAppend "[FontType]`n" , IniFile
	FileAppend "MainFontType=Comic Sans MS`n" , IniFile
	FileAppend "MessageAppNameFontType=Georgia`n" , IniFile
	FileAppend "LicenseKeyFontType=Comic Sans MS`n" , IniFile
	FileAppend "MessageMainMsgFontType=Georgia`n" , IniFile
	FileAppend "MessageFontType=Georgia`n" , IniFile
	FileAppend ";--------------------------------------------------`n" , IniFile
	FileAppend "[FontColors]`n" , IniFile
	FileAppend "MainFontColor=Lime`n" , IniFile
	FileAppend "FontClickerPatternColor=70A0FA`n" , IniFile
	FileAppend ";-------------------------------`n" , IniFile
	FileAppend "MessageAppNameFontColor=Lime`n" , IniFile
	FileAppend "LicenseKeyFontColor=70A0FA`n" , IniFile
	FileAppend "MessageMainMsgFontColor=Lime`n" , IniFile
	FileAppend "MessageFontColor=Lime`n" , IniFile
	FileAppend ";--------------------------------------------------`n" , IniFile
	FileAppend "[Background]`n" , IniFile
	FileAppend "BackgroundColor=2F2F2F`n" , IniFile
	FileAppend "BackgroundPicture=`n" , IniFile
	FileAppend "MessageBackgroundPicture=`n" , IniFile
	FileAppend ";--------------------------------------------------`n" , IniFile
	FileAppend "[Pictures]`n" , IniFile
	FileAppend "TopPicture=`n" , IniFile
	FileAppend "BottomPicture=`n" , IniFile
}
;----------------------------------------------------
CreateNewAuxHkDataFile(*){
	FileAppend ";--------------------------------------------------`n" , AuxHkDataFile
	FileAppend "; Hotkey Flags`n" , AuxHkDataFile
	FileAppend ";--------------------------------------------------`n" , AuxHkDataFile
	FileAppend "[CtrlHkFlags]`n" , AuxHkDataFile
	FileAppend "CtrlStartAutoRunHotkey=0`n" , AuxHkDataFile
	FileAppend "CtrlStopAutoRunHotKey=0`n" , AuxHkDataFile
	FileAppend "CtrlPatternClickerHotkey=0`n" , AuxHkDataFile
	FileAppend "CtrlJumpHotkey0=0`n" , AuxHkDataFile
	FileAppend "CtrlJumpHotkey1=0`n" , AuxHkDataFile
	FileAppend "CtrlJumpHotkey2=0`n" , AuxHkDataFile
	FileAppend "CtrlJumpHotkey3=0`n" , AuxHkDataFile
	FileAppend "CtrlJumpHotkey4=0`n" , AuxHkDataFile
	FileAppend "CtrlQuickAccessHk1=0`n" , AuxHkDataFile
	FileAppend "CtrlQuickAccessHk2=0`n" , AuxHkDataFile
	FileAppend "CtrlQuickAccessHk3=0`n" , AuxHkDataFile
	FileAppend "CtrlQuickAccessHk4=0`n" , AuxHkDataFile
	FileAppend "CtrlQuickAccessHk5=0`n" , AuxHkDataFile
	FileAppend "CtrlQuickAccessHk6=0`n" , AuxHkDataFile
	FileAppend "CtrlQuickAccessHk7=0`n" , AuxHkDataFile
	FileAppend "CtrlQuickAccessHk8=0`n" , AuxHkDataFile
	FileAppend "CtrlQuickAccessHk9=0`n" , AuxHkDataFile
	FileAppend ";--------------------------------------------------`n" , AuxHkDataFile
	FileAppend "[AltHkFlags]`n" , AuxHkDataFile
	FileAppend "AltStartAutoRunHotkey=0`n" , AuxHkDataFile
	FileAppend "AltStopAutoRunHotKey=0`n" , AuxHkDataFile
	FileAppend "AltPatternClickerHotkey=0`n" , AuxHkDataFile
	FileAppend "AltStopPatternHotkey=0`n" , AuxHkDataFile
	FileAppend "AltJumpHotkey0=0`n" , AuxHkDataFile
	FileAppend "AltJumpHotkey1=0`n" , AuxHkDataFile
	FileAppend "AltJumpHotkey2=0`n" , AuxHkDataFile
	FileAppend "AltJumpHotkey3=0`n" , AuxHkDataFile
	FileAppend "AltJumpHotkey4=0`n" , AuxHkDataFile
	FileAppend "AltQuickAccessHk1=0`n" , AuxHkDataFile
	FileAppend "AltQuickAccessHk2=0`n" , AuxHkDataFile
	FileAppend "AltQuickAccessHk3=0`n" , AuxHkDataFile
	FileAppend "AltQuickAccessHk4=0`n" , AuxHkDataFile
	FileAppend "AltQuickAccessHk5=0`n" , AuxHkDataFile
	FileAppend "AltQuickAccessHk6=0`n" , AuxHkDataFile
	FileAppend "AltQuickAccessHk7=0`n" , AuxHkDataFile
	FileAppend "AltQuickAccessHk8=0`n" , AuxHkDataFile
	FileAppend "AltQuickAccessHk9=0`n" , AuxHkDataFile
	FileAppend ";--------------------------------------------------`n" , AuxHkDataFile
	FileAppend "[ShiftHkFlags]`n" , AuxHkDataFile
	FileAppend "ShiftStartAutoRunHotkey=0`n" , AuxHkDataFile
	FileAppend "ShiftStopAutoRunHotKey=0`n" , AuxHkDataFile
	FileAppend "ShiftPatternClickerHotkey=0`n" , AuxHkDataFile
	FileAppend "ShiftStopPatternHotkey=0`n" , AuxHkDataFile
	FileAppend "ShiftJumpHotkey0=0`n" , AuxHkDataFile
	FileAppend "ShiftJumpHotkey1=0`n" , AuxHkDataFile
	FileAppend "ShiftJumpHotkey2=0`n" , AuxHkDataFile
	FileAppend "ShiftJumpHotkey3=0`n" , AuxHkDataFile
	FileAppend "ShiftJumpHotkey4=0`n" , AuxHkDataFile
	FileAppend "ShiftQuickAccessHk1=0`n" , AuxHkDataFile
	FileAppend "ShiftQuickAccessHk2=0`n" , AuxHkDataFile
	FileAppend "ShiftQuickAccessHk3=0`n" , AuxHkDataFile
	FileAppend "ShiftQuickAccessHk4=0`n" , AuxHkDataFile
	FileAppend "ShiftQuickAccessHk5=0`n" , AuxHkDataFile
	FileAppend "ShiftQuickAccessHk6=0`n" , AuxHkDataFile
	FileAppend "ShiftQuickAccessHk7=0`n" , AuxHkDataFile
	FileAppend "ShiftQuickAccessHk8=0`n" , AuxHkDataFile
	FileAppend "ShiftQuickAccessHk9=0`n" , AuxHkDataFile
}
