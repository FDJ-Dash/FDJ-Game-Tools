;------------- Credits ------------
; Creator: Fernando Daniel Jaime.
; Programmer Alias: FDJ-Dash.
;------------- File Details ------------
; App Name: Task Automator.
; File Description: This file reads and validates ini file variables.
;----------------------------------------------------
; Header list:
;----------------------------------------------------
; ReadFontTypes(...)
; ReadFontColors(...)
; ReadBackground(...)
; ReadModules(...)
; ReadProperties(...)
; ReadSetting(...)
; ReadPaceProperties(...)
; ReadSavedHotkey(...)
; ReadAutoRun(...)
; ReadAutoClicker(...)
; ReadCursorLocationClicker(...)
; ReadQuickAccessPath(...)
; ReadQuickAccessIcons(...)
; ReadJumpProperties(...)
;----------------------------------------------------
; Ini Read Font types
;----------------------------------------------------
ReadFontTypes(&MainFontType, 
			  &MessageAppNameFontType, 
			  &LicenseKeyFontType, 
			  &MessageMainMsgFontType, 
			  &MessageFontType){
	MainFontType := IniRead(IniFile, "FontType", "MainFontType")
	MessageAppNameFontType := IniRead(IniFile, "FontType", "MessageAppNameFontType")
	LicenseKeyFontType := IniRead(IniFile, "FontType", "LicenseKeyFontType")
	MessageMainMsgFontType := IniRead(IniFile, "FontType", "MessageMainMsgFontType")
	MessageFontType := IniRead(IniFile, "FontType", "MessageFontType")
}
;----------------------------------------------------
; Ini Read Font Colors
;----------------------------------------------------
ReadFontColors(&MainFontColor, 
			   &FontClickerPatternColor, 
			   &MessageAppNameFontColor,
			   &MessageMainMsgFontColor,
			   &MessageFontColor, 
			   &LicenseKeyFontColor){
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
}
;----------------------------------------------------
; Ini Read Background
;----------------------------------------------------
ReadBackground(&BackgroundMainColor, 
			   &BackgroundColor,
			   &BackgroundPicture,
			   &MessageBackgroundPicture){
	BackgroundMainColor := "Background"
	BackgroundColor := IniRead(IniFile, "Background", "BackgroundColor")
	BackgroundMainColor .= BackgroundColor
	BackgroundPicture := IniRead(IniFile, "Background", "BackgroundPicture")
	MessageBackgroundPicture := IniRead(IniFile, "Background", "MessageBackgroundPicture")	   
}
;----------------------------------------------------
; Ini Read Modules
;----------------------------------------------------
ReadModules(&SwitchKbAutoRun, 
			&SwitchControllerAutoRun,
			&SwitchQuickAccess,
			&QuickAccessButtons,
			&SwitchClicker,
			&SwitchJumps){
	SwitchKbAutoRun := IniRead(IniFile, "Modules", "SwitchKbAutoRun")
	SwitchControllerAutoRun := IniRead(IniFile, "Modules", "SwitchControllerAutoRun")
	;-------------------------------
	SwitchQuickAccess := IniRead(IniFile, "Modules", "SwitchQuickAccess")
	QuickAccessButtons := IniRead(IniFile, "Modules", "QuickAccessButtons")
	SwitchClicker := IniRead(IniFile, "Modules", "SwitchClicker")
	SwitchJumps := IniRead(IniFile, "Modules", "SwitchJumps")
	;-------------------------------
	if SwitchKbAutoRun < 0 or SwitchKbAutoRun > 1 or
	 SwitchControllerAutoRun < 0 or SwitchControllerAutoRun > 1 or
	 SwitchJumps < 0 or SwitchJumps > 1 or
	 SwitchClicker < 0 or SwitchClicker > 1  or 
	 SwitchQuickAccess < 0 or SwitchQuickAccess > 1 {
		SwitchKbAutoRun := false
		SwitchControllerAutoRun := false
		SwitchQuickAccess := true
		SwitchClicker := false
		SwitchJumps := false
		IniWrite SwitchKbAutoRun, IniFile, "Modules", "SwitchKbAutoRun"
		IniWrite SwitchControllerAutoRun, IniFile, "Modules", "SwitchControllerAutoRun"
		IniWrite SwitchQuickAccess, IniFile, "Modules", "SwitchQuickAccess"
		IniWrite SwitchClicker, IniFile, "Modules", "SwitchClicker"
		IniWrite SwitchJumps, IniFile, "Modules", "SwitchJumps"
	}
	if QuickAccessButtons > 1 or QuickAccessButtons < 0 {
		QuickAccessButtons := 1
		IniWrite QuickAccessButtons, IniFile, "Modules", "QuickAccessButtons"
	}
}
;----------------------------------------------------
; Read Ini Properties
;----------------------------------------------------
ReadProperties(&ExitMessageTimeWait, 
			   &SuspendedHotkeysTimeWait,
			   &SaveSuccesfullTimeWait,
			   &AutoRunLoopInterval,
			   &GeneralLoopInterval,
			   &LoopAmount,
			   &GuiPriorityAlwaysOnTop,
			   &PositionX,
			   &PositionY,
			   &ExitTaskAutomatorKey,
			   &SuspendHotkeysKey){
	ExitMessageTimeWait := IniRead(IniFile, "Properties", "ExitMessageTimeWait")
	SuspendedHotkeysTimeWait := IniRead(IniFile, "Properties", "SuspendedHotkeysTimeWait")
	SaveSuccesfullTimeWait := IniRead(IniFile, "Properties", "SaveSuccesfullTimeWait")
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
}
;----------------------------------------------------
; Read ini Settings
;----------------------------------------------------
ReadSetting(&HotkeyEditMode,
			&EditBoxesAvailable,
			&CheckforUpdatesDaily, 
			&CheckforupdatesWeekly, 
			&NeverCheckForUpdates,
			&LastUpdateCheckTimeStamp,
			&NeedUpdate){
	HotkeyEditMode := IniRead(IniFile, "Settings", "HotkeyEditMode")
	if HotkeyEditMode > 1 or HotkeyEditMode < 0 {
		HotkeyEditMode := 1
		IniWrite HotkeyEditMode, IniFile, "Settings", "HotkeyEditMode"
	}
	EditBoxesAvailable := IniRead(IniFile, "Settings", "EditBoxesAvailable")
	if EditBoxesAvailable > 1 or EditBoxesAvailable < 0 {
		EditBoxesAvailable := 1
		IniWrite EditBoxesAvailable, IniFile, "Settings", "EditBoxesAvailable"
	}
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
}
;----------------------------------------------------
; Read Ini PaceProperties
;----------------------------------------------------
ReadPaceProperties(&ScrlUpCount, 
				   &ScrlUpInterval, 
				   &ScrlDownCount,
				   &ScrlDownInterval){
	ScrlUpCount := IniRead(IniFile, "PaceProperties", "ScrlUpCount")
	ScrlUpInterval := IniRead(IniFile, "PaceProperties", "ScrlUpInterval")
	ScrlDownCount := IniRead(IniFile, "PaceProperties", "ScrlDownCount")
	ScrlDownInterval := IniRead(IniFile, "PaceProperties", "ScrlDownInterval")
}
;----------------------------------------------------
; Read Ini Saved Hotkey
;----------------------------------------------------
ReadSavedHotkey(&KbAutoRunHotkey, 
				&PatternClickerHotkey,
				&JumpHotkey0,
				&JumpHotkey1,
				&JumpHotkey2,
				&JumpHotkey3,
				&JumpHotkey4,
				&QuickAccessHk1,
				&QuickAccessHk2,
				&QuickAccessHk3,
				&QuickAccessHk4,
				&QuickAccessHk5,
				&QuickAccessHk6,
				&QuickAccessHk7,
				&QuickAccessHk8,
				&QuickAccessHk9){
	KbAutoRunHotkey := IniRead(IniFile, "SavedHotkey", "KbAutoRunHotkey")
	switch true {
	case KbAutoRunHotkey == "+":
		KbAutoRunHotkey := "Shift"
		IniWrite KbAutoRunHotkey, IniFile, "SavedHotkey", "KbAutoRunHotkey"
	case KbAutoRunHotkey == "!":
		KbAutoRunHotkey := "Alt"
		IniWrite KbAutoRunHotkey, IniFile, "SavedHotkey", "KbAutoRunHotkey"
	case KbAutoRunHotkey == "^":
		KbAutoRunHotkey := "Ctrl"
		IniWrite KbAutoRunHotkey, IniFile, "SavedHotkey", "KbAutoRunHotkey"
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
}
;----------------------------------------------------
; Read Ini AutoRun
;----------------------------------------------------
ReadAutoRun(&SprintKey, 
			&ForwardKey, 
			&SelectedButton,
			&ControllerKey){
	SprintKey := IniRead(IniFile, "AutoRun", "SprintKey")
	ForwardKey := IniRead(IniFile, "AutoRun", "ForwardKey")
	SelectedButton := IniRead(IniFile, "AutoRun", "SelectedButton")
	ControllerKey := IniRead(IniFile, "AutoRun", "ControllerKey")
}
;----------------------------------------------------
; Read Ini AutoClicker
;----------------------------------------------------
ReadAutoClicker(&ClickInterval, 
				&RandomOffset){
	ClickInterval := IniRead(IniFile, "AutoClicker", "ClickInterval")
	RandomOffset := IniRead(IniFile, "AutoClicker", "RandomOffset")
}
;----------------------------------------------------
; Read ini CursorLocationClicker
;----------------------------------------------------
ReadCursorLocationClicker(Position1,
						  Position2,
						  Position3,
						  Position4,
						  Position5,
						  Position6,
						  Position7,
						  Position8,
						  Position9,
						  Position10,
						  Position11,
						  Position12,
						  Position13,
						  Position14,
						  Position15,
						  Position16,
						  Position17,
						  Position18,
						  Position19,
						  Position20,
						  Position21,
						  Position22){
	;-------------------------------
	Position1.CoordX := IniRead(IniFile, "CursorLocationClicker", "CoordX1")
	Position1.CoordY := IniRead(IniFile, "CursorLocationClicker", "CoordY1")
	Position1.Interval := IniRead(IniFile, "CursorLocationClicker", "Coord1Interval")
	Position1.RadioYes := IniRead(IniFile, "CursorLocationClicker", "Radio1Yes")
	Position1.RadioNo := IniRead(IniFile, "CursorLocationClicker", "Radio1No")
	;-------------------------------
	Position2.CoordX := IniRead(IniFile, "CursorLocationClicker", "CoordX2")
	Position2.CoordY := IniRead(IniFile, "CursorLocationClicker", "CoordY2")
	Position2.Interval := IniRead(IniFile, "CursorLocationClicker", "Coord2Interval")
	Position2.RadioYes := IniRead(IniFile, "CursorLocationClicker", "Radio2Yes")
	Position2.RadioNo := IniRead(IniFile, "CursorLocationClicker", "Radio2No")
	;-------------------------------
	Position3.CoordX := IniRead(IniFile, "CursorLocationClicker", "CoordX3")
	Position3.CoordY := IniRead(IniFile, "CursorLocationClicker", "CoordY3")
	Position3.Interval := IniRead(IniFile, "CursorLocationClicker", "Coord3Interval")
	Position3.RadioYes := IniRead(IniFile, "CursorLocationClicker", "Radio3Yes")
	Position3.RadioNo := IniRead(IniFile, "CursorLocationClicker", "Radio3No")
	;-------------------------------
	Position4.CoordX := IniRead(IniFile, "CursorLocationClicker", "CoordX4")
	Position4.CoordY := IniRead(IniFile, "CursorLocationClicker", "CoordY4")
	Position4.Interval := IniRead(IniFile, "CursorLocationClicker", "Coord4Interval")
	Position4.RadioYes := IniRead(IniFile, "CursorLocationClicker", "Radio4Yes")
	Position4.RadioNo := IniRead(IniFile, "CursorLocationClicker", "Radio4No")
	;-------------------------------
	Position5.CoordX := IniRead(IniFile, "CursorLocationClicker", "CoordX5")
	Position5.CoordY := IniRead(IniFile, "CursorLocationClicker", "CoordY5")
	Position5.Interval := IniRead(IniFile, "CursorLocationClicker", "Coord5Interval")
	Position5.RadioYes := IniRead(IniFile, "CursorLocationClicker", "Radio5Yes")
	Position5.RadioNo := IniRead(IniFile, "CursorLocationClicker", "Radio5No")
	;-------------------------------
	Position6.CoordX := IniRead(IniFile, "CursorLocationClicker", "CoordX6")
	Position6.CoordY := IniRead(IniFile, "CursorLocationClicker", "CoordY6")
	Position6.Interval := IniRead(IniFile, "CursorLocationClicker", "Coord6Interval")
	Position6.RadioYes := IniRead(IniFile, "CursorLocationClicker", "Radio6Yes")
	Position6.RadioNo := IniRead(IniFile, "CursorLocationClicker", "Radio6No")
	;-------------------------------
	Position7.CoordX := IniRead(IniFile, "CursorLocationClicker", "CoordX7")
	Position7.CoordY := IniRead(IniFile, "CursorLocationClicker", "CoordY7")
	Position7.Interval := IniRead(IniFile, "CursorLocationClicker", "Coord7Interval")
	Position7.RadioYes := IniRead(IniFile, "CursorLocationClicker", "Radio7Yes")
	Position7.RadioNo := IniRead(IniFile, "CursorLocationClicker", "Radio7No")
	;-------------------------------
	Position8.CoordX := IniRead(IniFile, "CursorLocationClicker", "CoordX8")
	Position8.CoordY := IniRead(IniFile, "CursorLocationClicker", "CoordY8")
	Position8.Interval := IniRead(IniFile, "CursorLocationClicker", "Coord8Interval")
	Position8.RadioYes := IniRead(IniFile, "CursorLocationClicker", "Radio8Yes")
	Position8.RadioNo := IniRead(IniFile, "CursorLocationClicker", "Radio8No")
	;-------------------------------
	Position9.CoordX := IniRead(IniFile, "CursorLocationClicker", "CoordX9")
	Position9.CoordY := IniRead(IniFile, "CursorLocationClicker", "CoordY9")
	Position9.Interval := IniRead(IniFile, "CursorLocationClicker", "Coord9Interval")
	Position9.RadioYes := IniRead(IniFile, "CursorLocationClicker", "Radio9Yes")
	Position9.RadioNo := IniRead(IniFile, "CursorLocationClicker", "Radio9No")
	;-------------------------------
	Position10.CoordX := IniRead(IniFile, "CursorLocationClicker", "CoordX10")
	Position10.CoordY := IniRead(IniFile, "CursorLocationClicker", "CoordY10")
	Position10.Interval := IniRead(IniFile, "CursorLocationClicker", "Coord10Interval")
	Position10.RadioYes := IniRead(IniFile, "CursorLocationClicker", "Radio10Yes")
	Position10.RadioNo := IniRead(IniFile, "CursorLocationClicker", "Radio10No")
	;-------------------------------
	Position11.CoordX := IniRead(IniFile, "CursorLocationClicker", "CoordX11")
	Position11.CoordY := IniRead(IniFile, "CursorLocationClicker", "CoordY11")
	Position11.Interval := IniRead(IniFile, "CursorLocationClicker", "Coord11Interval")
	Position11.RadioYes := IniRead(IniFile, "CursorLocationClicker", "Radio11Yes")
	Position11.RadioNo := IniRead(IniFile, "CursorLocationClicker", "Radio11No")
	;-------------------------------
	Position12.CoordX := IniRead(IniFile, "CursorLocationClicker", "CoordX12")
	Position12.CoordY := IniRead(IniFile, "CursorLocationClicker", "CoordY12")
	Position12.Interval := IniRead(IniFile, "CursorLocationClicker", "Coord12Interval")
	Position12.RadioYes := IniRead(IniFile, "CursorLocationClicker", "Radio12Yes")
	Position12.RadioNo := IniRead(IniFile, "CursorLocationClicker", "Radio12No")
	;-------------------------------
	Position13.CoordX := IniRead(IniFile, "CursorLocationClicker", "CoordX13")
	Position13.CoordY := IniRead(IniFile, "CursorLocationClicker", "CoordY13")
	Position13.Interval := IniRead(IniFile, "CursorLocationClicker", "Coord13Interval")
	Position13.RadioYes := IniRead(IniFile, "CursorLocationClicker", "Radio13Yes")
	Position13.RadioNo := IniRead(IniFile, "CursorLocationClicker", "Radio13No")
	;-------------------------------
	Position14.CoordX := IniRead(IniFile, "CursorLocationClicker", "CoordX14")
	Position14.CoordY := IniRead(IniFile, "CursorLocationClicker", "CoordY14")
	Position14.Interval := IniRead(IniFile, "CursorLocationClicker", "Coord14Interval")
	Position14.RadioYes := IniRead(IniFile, "CursorLocationClicker", "Radio14Yes")
	Position14.RadioNo := IniRead(IniFile, "CursorLocationClicker", "Radio14No")
	;-------------------------------
	Position15.CoordX := IniRead(IniFile, "CursorLocationClicker", "CoordX15")
	Position15.CoordY := IniRead(IniFile, "CursorLocationClicker", "CoordY15")
	Position15.Interval := IniRead(IniFile, "CursorLocationClicker", "Coord15Interval")
	Position15.RadioYes := IniRead(IniFile, "CursorLocationClicker", "Radio15Yes")
	Position15.RadioNo := IniRead(IniFile, "CursorLocationClicker", "Radio15No")
	;-------------------------------
	Position16.CoordX := IniRead(IniFile, "CursorLocationClicker", "CoordX16")
	Position16.CoordY := IniRead(IniFile, "CursorLocationClicker", "CoordY16")
	Position16.Interval := IniRead(IniFile, "CursorLocationClicker", "Coord16Interval")
	Position16.RadioYes := IniRead(IniFile, "CursorLocationClicker", "Radio16Yes")
	Position16.RadioNo := IniRead(IniFile, "CursorLocationClicker", "Radio16No")
	;-------------------------------
	Position17.CoordX := IniRead(IniFile, "CursorLocationClicker", "CoordX17")
	Position17.CoordY := IniRead(IniFile, "CursorLocationClicker", "CoordY17")
	Position17.Interval := IniRead(IniFile, "CursorLocationClicker", "Coord17Interval")
	Position17.RadioYes := IniRead(IniFile, "CursorLocationClicker", "Radio17Yes")
	Position17.RadioNo := IniRead(IniFile, "CursorLocationClicker", "Radio17No")
	;-------------------------------
	Position18.CoordX := IniRead(IniFile, "CursorLocationClicker", "CoordX18")
	Position18.CoordY := IniRead(IniFile, "CursorLocationClicker", "CoordY18")
	Position18.Interval := IniRead(IniFile, "CursorLocationClicker", "Coord18Interval")
	Position18.RadioYes := IniRead(IniFile, "CursorLocationClicker", "Radio18Yes")
	Position18.RadioNo := IniRead(IniFile, "CursorLocationClicker", "Radio18No")
	;-------------------------------
	Position19.CoordX := IniRead(IniFile, "CursorLocationClicker", "CoordX19")
	Position19.CoordY := IniRead(IniFile, "CursorLocationClicker", "CoordY19")
	Position19.Interval := IniRead(IniFile, "CursorLocationClicker", "Coord19Interval")
	Position19.RadioYes := IniRead(IniFile, "CursorLocationClicker", "Radio19Yes")
	Position19.RadioNo := IniRead(IniFile, "CursorLocationClicker", "Radio19No")
	;-------------------------------
	Position20.CoordX := IniRead(IniFile, "CursorLocationClicker", "CoordX20")
	Position20.CoordY := IniRead(IniFile, "CursorLocationClicker", "CoordY20")
	Position20.Interval := IniRead(IniFile, "CursorLocationClicker", "Coord20Interval")
	Position20.RadioYes := IniRead(IniFile, "CursorLocationClicker", "Radio20Yes")
	Position20.RadioNo := IniRead(IniFile, "CursorLocationClicker", "Radio20No")
	;-------------------------------
	Position21.CoordX := IniRead(IniFile, "CursorLocationClicker", "CoordX21")
	Position21.CoordY := IniRead(IniFile, "CursorLocationClicker", "CoordY21")
	Position21.Interval := IniRead(IniFile, "CursorLocationClicker", "Coord21Interval")
	Position21.RadioYes := IniRead(IniFile, "CursorLocationClicker", "Radio21Yes")
	Position21.RadioNo := IniRead(IniFile, "CursorLocationClicker", "Radio21No")
	;-------------------------------
	Position22.CoordX := IniRead(IniFile, "CursorLocationClicker", "CoordX22")
	Position22.CoordY := IniRead(IniFile, "CursorLocationClicker", "CoordY22")
	Position22.Interval := IniRead(IniFile, "CursorLocationClicker", "Coord22Interval")
	Position22.RadioYes := IniRead(IniFile, "CursorLocationClicker", "Radio22Yes")
	Position22.RadioNo := IniRead(IniFile, "CursorLocationClicker", "Radio22No")
}
;----------------------------------------------------
; Read ini QuickAccessPath
;----------------------------------------------------
ReadQuickAccessPath(&QuickAccess1, 
					&QuickAccess2, 
					&QuickAccess3,
					&QuickAccess4,
					&QuickAccess5,
					&QuickAccess6,
					&QuickAccess7,
					&QuickAccess8,
					&QuickAccess9){
	QuickAccess1 := IniRead(IniFile, "QuickAccessPath", "QuickAccess1")
	QuickAccess2 := IniRead(IniFile, "QuickAccessPath", "QuickAccess2")
	QuickAccess3 := IniRead(IniFile, "QuickAccessPath", "QuickAccess3")
	QuickAccess4 := IniRead(IniFile, "QuickAccessPath", "QuickAccess4")
	QuickAccess5 := IniRead(IniFile, "QuickAccessPath", "QuickAccess5")
	QuickAccess6 := IniRead(IniFile, "QuickAccessPath", "QuickAccess6")
	QuickAccess7 := IniRead(IniFile, "QuickAccessPath", "QuickAccess7")
	QuickAccess8 := IniRead(IniFile, "QuickAccessPath", "QuickAccess8")
	QuickAccess9 := IniRead(IniFile, "QuickAccessPath", "QuickAccess9")
}
;----------------------------------------------------
; Read ini QuickAccessIcons
;----------------------------------------------------
ReadQuickAccessIcons(&QuickIcon1, 
					 &QuickIcon2, 
					 &QuickIcon3,
					 &QuickIcon4,
					 &QuickIcon5,
					 &QuickIcon6,
					 &QuickIcon7,
					 &QuickIcon8,
					 &QuickIcon9){
	QuickIcon1 := IniRead(IniFile, "QuickAccessIcons", "QuickIcon1")
	QuickIcon2 := IniRead(IniFile, "QuickAccessIcons", "QuickIcon2")
	QuickIcon3 := IniRead(IniFile, "QuickAccessIcons", "QuickIcon3")
	QuickIcon4 := IniRead(IniFile, "QuickAccessIcons", "QuickIcon4")
	QuickIcon5 := IniRead(IniFile, "QuickAccessIcons", "QuickIcon5")
	QuickIcon6 := IniRead(IniFile, "QuickAccessIcons", "QuickIcon6")
	QuickIcon7 := IniRead(IniFile, "QuickAccessIcons", "QuickIcon7")
	QuickIcon8 := IniRead(IniFile, "QuickAccessIcons", "QuickIcon8")
	QuickIcon9 := IniRead(IniFile, "QuickAccessIcons", "QuickIcon9")
}
;----------------------------------------------------
; Read ini JumpProperties
;----------------------------------------------------
ReadJumpProperties(&VeryShortJumpRace, 
				   &VeryShortJumpLenght, 
				   &ShortJumpRace,
				   &ShortJumpLenght,
				   &NormalJumpRace,
				   &NormalJumpLenght,
				   &LongJumpRace,
				   &LongJumpLenght,
				   &VeryLongJumpRace,
				   &VeryLongJumpLenght){
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
}

