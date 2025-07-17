;------------- Credits ------------
; Creator: Fernando Daniel Jaime.
; Programmer Alias: FDJ-Dash.
;------------- File Details ------------
; App Name: Task Automator.
; File Description: This file creates Task Automator GUI.
;----------------------------------------------------
; Header list:
;----------------------------------------------------
; ResizedAutoClickerModule(...)
; ResizedSaveAllEditValues(...)
; ResizedCheckHotkeyEditMode(...)
; ResizedCheckEditBoxesAvailable(...)
; ResizedCheckForUpdates(...)
;----------------------------------------------------
;----------------------------------------------------
; Y-226 / Auto Clicker
;----------------------------------------------------
ResizedAutoClickerModule(TaskAutomatorGui,
						 &OptionsMenu,
						 &SwitchQuickAccess,
						 &SwitchClicker,
						 &SwitchJumps,
						 &SwitchControllerAutoRun,
						 &SwitchKbAutoRun,
						 &TextPatternClickerOnOff,
						 &HotkeyEditMode,
						 &PatternClickerHotkey,
						 &CtrlPatternClickerHotkey,
						 &AltPatternClickerHotkey,
						 &ShiftPatternClickerHotkey,
						 &EditBoxesAvailable,
						 &EditPatternClicker,
						 &EditPatternClickerOffset,
						 &TextPatternClickInterval,
						 &TextPatternClickerOffset,
						 &TextLoop,
						 &EditLoopTimes,
						 &RadioCountLoopsYes,
						 &RadioCountLoopsNo,
						 &TextPosX,
						 &TextPosY,
						 &TextPosInterval,
						 Position1,
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
						 Position22,
						 &StartTime,
						 &LastYLine){
	;-------------------------------
	try {
		OptionsMenu.SetIcon("4. Switch &Clicker", IconLib . "\Switch1.ico")
		OptionsMenu.SetIcon("5. Switch &Jumps", IconLib . "\Switch2.ico")
		OptionsMenu.SetIcon("3a. Switch Quick &Access", IconLib . "\Switch2.ico")
		OptionsMenu.SetIcon("2. Switch Con&troller Autorun", IconLib . "\Switch2.ico")
		OptionsMenu.SetIcon("1. Switch &Keyboard Autorun", IconLib . "\Switch2.ico")
	}
	catch {
	}
	SwitchQuickAccess := 0
	SwitchClicker := 1
	SwitchJumps := 0
	SwitchControllerAutoRun := 0
	SwitchKbAutoRun := 0
	
	TaskAutomatorGui.Add("Text","x10 y10 h20 +0x200", " Auto Clicker ")
	TextPatternClickerOnOff := TaskAutomatorGui.Add("Text","x105 y10 h20 +0x200", " OFF ")
	if HotkeyEditMode == true {
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
		
		PatternClickerHotkey := TaskAutomatorGui.Add("Hotkey", "vPatternClickerHotkey x150 y10 w90 h20", PatternClickerHotkey).OnEvent("Change", SubmitPatternClickerHotkey)
	} else {
		PatternClickerHotkey := TaskAutomatorGui.Add("Hotkey", "vPatternClickerHotkey x150 y10 w90 h20 +disabled", PatternClickerHotkey)
	} ; HotkeyEditMode false end
	if EditBoxesAvailable == true {
		try {
			SettingsMenu.SetIcon("Lock Edit &Boxes && Icons: ON/OFF", IconLib . "\EditBox2.png")
		}
		catch {
		}
		EditPatternClicker := TaskAutomatorGui.Add("Edit", "vClickInterval x310 y10 w50 h20 +Number")
		EditPatternClickerOffset := TaskAutomatorGui.Add("Edit", "vRandomOffset x440 y10 w50 h20 +Number")
	} else {
		try {
			SettingsMenu.SetIcon("Lock Edit &Boxes && Icons: ON/OFF", IconLib . "\EditBox1.png")
		}
		catch {
		}
		EditPatternClicker := TaskAutomatorGui.Add("Edit", "vClickInterval x310 y10 w50 h20 +Number +Disabled")
		EditPatternClickerOffset := TaskAutomatorGui.Add("Edit", "vRandomOffset x440 y10 w50 h20 +Number +Disabled")
	}
	TextPatternClickInterval := TaskAutomatorGui.Add("Text","x260 y10 h20 +0x200", " Interval ")
	TextPatternClickerOffset := TaskAutomatorGui.Add("Text","x370 y10 h20 +0x200", " Rnd Offset ")
	;----------------------------------------------------
	TextLoop := TaskAutomatorGui.Add("Text","x510 y10 h20 +0x200", " Loop amount: ")
	TaskAutomatorGui.SetFont()
	TaskAutomatorGui.SetFont("Bold " . FontClickerPatternColor . "", MainFontType)
	if EditBoxesAvailable == true {
		EditLoopTimes := TaskAutomatorGui.Add("Edit", "vLoopAmount x598 y10 w70 h20 +Number")
	} else {
		EditLoopTimes := TaskAutomatorGui.Add("Edit", "vLoopAmount x598 y10 w70 h20 +Number +Disabled")
	}
	EditLoopTimes.Opt("" . BackgroundMainColor . "")
	TaskAutomatorGui.SetFont()
	TaskAutomatorGui.SetFont("Bold " . MainFontColor, MainFontType)
	EditLoopTimes.Value := LoopAmount
	
	RadioCountLoopsYes := TaskAutomatorGui.Add("Radio", "x679 y10 h20 +Checked", "Y")
	RadioCountLoopsNo := TaskAutomatorGui.Add("Radio", "x711 y10 w30 h20", "N")
	;----------------------------------------------------
	TaskAutomatorGui.Add("Text", "x1 y34 w750 h2 +0x10") ; Separator
	TextPosX1 := TaskAutomatorGui.Add("Text","x37 y40 h20 +0x200", " X ")
	TextPosY1 := TaskAutomatorGui.Add("Text","x84 y40 h20 +0x200", " Y ")
	TextPosInterval1 := TaskAutomatorGui.Add("Text","x121 y40 h20 +0x200", " Interval ")
	TaskAutomatorGui.Add("Text", "x249 y36 w3 h203 +0x11") ; Vertical Separator
	TextPosX1 := TaskAutomatorGui.Add("Text","x287 y40 h20 +0x200", " X ")
	TextPosY1 := TaskAutomatorGui.Add("Text","x334 y40 h20 +0x200", " Y ")
	TextPosInterval1 := TaskAutomatorGui.Add("Text","x371 y40 h20 +0x200", " Interval ")
	TaskAutomatorGui.Add("Text", "x499 y36 w3 h177 +0x11") ; Vertical Separator
	TextPosX1 := TaskAutomatorGui.Add("Text","x537 y40 h20 +0x200", " X ")
	TextPosY1 := TaskAutomatorGui.Add("Text","x584 y40 h20 +0x200", " Y ")
	TextPosInterval1 := TaskAutomatorGui.Add("Text","x621 y40 h20 +0x200", " Interval ")
	ClearButton := TaskAutomatorGui.Add("Button", "x680 y40 h20", "Clear X,Y")
	ClearButton.OnEvent("Click", ClearValuesXY)
	TaskAutomatorGui.SetFont()
	TaskAutomatorGui.SetFont("Bold " . MainFontColor, MainFontType)
	EditPatternClicker.Value := ClickInterval
	EditPatternClicker.Opt("" . BackgroundMainColor . "")
	EditPatternClickerOffset.Value := RandomOffset
	EditPatternClickerOffset.Opt("" . BackgroundMainColor . "")
	;----------------------------------------------------
	; Position 1
	;----------------------------------------------------
	TaskAutomatorGui.Add("Text","x10 y65 h20 +0x200", "1")
	TaskAutomatorGui.SetFont()
	TaskAutomatorGui.SetFont("Bold " . FontClickerPatternColor . "", MainFontType)
	if EditBoxesAvailable == true {
		Position1.EditPosX := TaskAutomatorGui.Add("Edit", "vCoordX1 x25 y65 w40 h20 +Number")
	} else {
		Position1.EditPosX := TaskAutomatorGui.Add("Edit", "vCoordX1 x25 y65 w40 h20 +Number +Disabled")
	}
	Position1.EditPosX.Opt("" . BackgroundMainColor . "")
	TaskAutomatorGui.SetFont()
	TaskAutomatorGui.SetFont("Bold " . MainFontColor, MainFontType)
	Position1.EditPosX.Value := Position1.CoordX
	;--------------------
	TaskAutomatorGui.SetFont()
	TaskAutomatorGui.SetFont("Bold " . FontClickerPatternColor . "", MainFontType)
	if EditBoxesAvailable == true {
		Position1.EditPosY := TaskAutomatorGui.Add("Edit", "vCoordY1 x73 y65 w40 h20 +Number")
	} else {
		Position1.EditPosY := TaskAutomatorGui.Add("Edit", "vCoordY1 x73 y65 w40 h20 +Number +Disabled")
	}
	
	Position1.EditPosY.Opt("" . BackgroundMainColor . "")
	TaskAutomatorGui.SetFont()
	TaskAutomatorGui.SetFont("Bold " . MainFontColor, MainFontType)
	Position1.EditPosY.Value := Position1.CoordY
	;--------------------
	TaskAutomatorGui.SetFont()
	TaskAutomatorGui.SetFont("Bold " . FontClickerPatternColor . "", MainFontType)
	if EditBoxesAvailable == true {
		Position1.EditInterval := TaskAutomatorGui.Add("Edit", "vCoord1Interval x121 y65 w50 h20 +Number")
	} else {
		Position1.EditInterval := TaskAutomatorGui.Add("Edit", "vCoord1Interval x121 y65 w50 h20 +Number +Disabled")
	}
	Position1.EditInterval.Opt("" . BackgroundMainColor . "")
	TaskAutomatorGui.SetFont()
	TaskAutomatorGui.SetFont("Bold " . MainFontColor, MainFontType)
	Position1.EditInterval.Value := Position1.Interval
	;--------------------
	Position1.EditRadioYes := TaskAutomatorGui.Add("Radio", "vRadio1Yes x179 y65 h20", "Y")
	Position1.EditRadioYes.Value := Position1.RadioYes
	Position1.EditRadioNo := TaskAutomatorGui.Add("Radio", "vRadio1No x211 y65 w30 h20", "N")
	Position1.EditRadioNo.Value := Position1.RadioNo
	;----------------------------------------------------
	; Position 2
	;----------------------------------------------------
	TaskAutomatorGui.Add("Text","x260 y65 h20 +0x200", "2")
	TaskAutomatorGui.SetFont()
	TaskAutomatorGui.SetFont("Bold " . FontClickerPatternColor . "", MainFontType)
	if EditBoxesAvailable == true {
		Position2.EditPosX := TaskAutomatorGui.Add("Edit", "vCoordX2 x275 y65 w40 h20 +Number")
	} else {
		Position2.EditPosX := TaskAutomatorGui.Add("Edit", "vCoordX2 x275 y65 w40 h20 +Number +Disabled")
	}
	Position2.EditPosX.Opt("" . BackgroundMainColor . "")
	TaskAutomatorGui.SetFont()
	TaskAutomatorGui.SetFont("Bold " . MainFontColor, MainFontType)
	Position2.EditPosX.Value := Position2.CoordX
	;--------------------
	TaskAutomatorGui.SetFont()
	TaskAutomatorGui.SetFont("Bold " . FontClickerPatternColor . "", MainFontType)
	if EditBoxesAvailable == true {
		Position2.EditPosY := TaskAutomatorGui.Add("Edit", "vCoordY2 x323 y65 w40 h20 +Number")
	} else {
		Position2.EditPosY := TaskAutomatorGui.Add("Edit", "vCoordY2 x323 y65 w40 h20 +Number +Disabled")
	}
	Position2.EditPosY.Opt("" . BackgroundMainColor . "")
	TaskAutomatorGui.SetFont()
	TaskAutomatorGui.SetFont("Bold " . MainFontColor, MainFontType)
	Position2.EditPosY.Value := Position2.CoordY
	;--------------------
	TaskAutomatorGui.SetFont()
	TaskAutomatorGui.SetFont("Bold " . FontClickerPatternColor . "", MainFontType)
	if EditBoxesAvailable == true {
		Position2.EditInterval := TaskAutomatorGui.Add("Edit", "vCoord2Interval x371 y65 w50 h20 +Number")
	} else {
		Position2.EditInterval := TaskAutomatorGui.Add("Edit", "vCoord2Interval x371 y65 w50 h20 +Number +Disabled")
	}
	Position2.EditInterval.Opt("" . BackgroundMainColor . "")
	TaskAutomatorGui.SetFont()
	TaskAutomatorGui.SetFont("Bold " . MainFontColor, MainFontType)
	Position2.EditInterval.Value := Position2.Interval
	;--------------------
	Position2.EditRadioYes := TaskAutomatorGui.Add("Radio", "vRadio2Yes x429 y65 h20", "Y")
	Position2.EditRadioYes.Value := Position2.RadioYes
	Position2.EditRadioNo := TaskAutomatorGui.Add("Radio", "vRadio2No x461 y65 w30 h20", "N")
	Position2.EditRadioNo.Value := Position2.RadioNo
	;----------------------------------------------------
	; Position 3
	;----------------------------------------------------
	TaskAutomatorGui.Add("Text","x510 y65 h20 +0x200", "3")
	TaskAutomatorGui.SetFont()
	TaskAutomatorGui.SetFont("Bold " . FontClickerPatternColor . "", MainFontType)
	if EditBoxesAvailable == true {
		Position3.EditPosX := TaskAutomatorGui.Add("Edit", "vCoordX3 x525 y65 w40 h20 +Number")
	} else {
		Position3.EditPosX := TaskAutomatorGui.Add("Edit", "vCoordX3 x525 y65 w40 h20 +Number +Disabled")
	}
	Position3.EditPosX.Opt("" . BackgroundMainColor . "")
	TaskAutomatorGui.SetFont()
	TaskAutomatorGui.SetFont("Bold " . MainFontColor, MainFontType)
	Position3.EditPosX.Value := Position3.CoordX
	;--------------------
	TaskAutomatorGui.SetFont()
	TaskAutomatorGui.SetFont("Bold " . FontClickerPatternColor . "", MainFontType)
	if EditBoxesAvailable == true {
		Position3.EditPosY := TaskAutomatorGui.Add("Edit", "vCoordY3 x573 y65 w40 h20 +Number")
	} else {
		Position3.EditPosY := TaskAutomatorGui.Add("Edit", "vCoordY3 x573 y65 w40 h20 +Number +Disabled")
	}
	Position3.EditPosY.Opt("" . BackgroundMainColor . "")
	TaskAutomatorGui.SetFont()
	TaskAutomatorGui.SetFont("Bold " . MainFontColor, MainFontType)
	Position3.EditPosY.Value := Position3.CoordY
	;--------------------
	TaskAutomatorGui.SetFont()
	TaskAutomatorGui.SetFont("Bold " . FontClickerPatternColor . "", MainFontType)
	if EditBoxesAvailable == true {
		Position3.EditInterval := TaskAutomatorGui.Add("Edit", "vCoord3Interval x621 y65 w50 h20 +Number")
	} else {
		Position3.EditInterval := TaskAutomatorGui.Add("Edit", "vCoord3Interval x621 y65 w50 h20 +Number +Disabled")
	}
	Position3.EditInterval.Opt("" . BackgroundMainColor . "")
	TaskAutomatorGui.SetFont()
	TaskAutomatorGui.SetFont("Bold " . MainFontColor, MainFontType)
	Position3.EditInterval.Value := Position3.Interval
	;--------------------
	Position3.EditRadioYes := TaskAutomatorGui.Add("Radio", "vRadio3Yes x679 y65 h20", "Y")
	Position3.EditRadioYes.Value := Position3.RadioYes
	Position3.EditRadioNo := TaskAutomatorGui.Add("Radio", "vRadio3No x711 y65 w30 h20", "N")
	Position3.EditRadioNo.Value := Position3.RadioNo
	;----------------------------------------------------
	; Position 4
	;----------------------------------------------------
	TaskAutomatorGui.Add("Text","x10 y86 h20 +0x200", "4")
	TaskAutomatorGui.SetFont()
	TaskAutomatorGui.SetFont("Bold " . FontClickerPatternColor . "", MainFontType)
	if EditBoxesAvailable == true {
		Position4.EditPosX := TaskAutomatorGui.Add("Edit", "vCoordX4 x25 y86 w40 h20 +Number")
	} else {
		Position4.EditPosX := TaskAutomatorGui.Add("Edit", "vCoordX4 x25 y86 w40 h20 +Number +Disabled")
	}
	Position4.EditPosX.Opt("" . BackgroundMainColor . "")
	TaskAutomatorGui.SetFont()
	TaskAutomatorGui.SetFont("Bold " . MainFontColor, MainFontType)
	Position4.EditPosX.Value := Position4.CoordX
	;--------------------
	TaskAutomatorGui.SetFont()
	TaskAutomatorGui.SetFont("Bold " . FontClickerPatternColor . "", MainFontType)
	if EditBoxesAvailable == true {
		Position4.EditPosY := TaskAutomatorGui.Add("Edit", "vCoordY4 x73 y86 w40 h20 +Number")
	} else {
		Position4.EditPosY := TaskAutomatorGui.Add("Edit", "vCoordY4 x73 y86 w40 h20 +Number +Disabled")
	}
	Position4.EditPosY.Opt("" . BackgroundMainColor . "")
	TaskAutomatorGui.SetFont()
	TaskAutomatorGui.SetFont("Bold " . MainFontColor, MainFontType)
	Position4.EditPosY.Value := Position4.CoordY
	;--------------------
	TaskAutomatorGui.SetFont()
	TaskAutomatorGui.SetFont("Bold " . FontClickerPatternColor . "", MainFontType)
	if EditBoxesAvailable == true {
		Position4.EditInterval := TaskAutomatorGui.Add("Edit", "vCoord4Interval x121 y86 w50 h20 +Number")
	} else {
		Position4.EditInterval := TaskAutomatorGui.Add("Edit", "vCoord4Interval x121 y86 w50 h20 +Number +Disabled")
	}
	Position4.EditInterval.Opt("" . BackgroundMainColor . "")
	TaskAutomatorGui.SetFont()
	TaskAutomatorGui.SetFont("Bold " . MainFontColor, MainFontType)
	Position4.EditInterval.Value := Position4.Interval
	;--------------------
	Position4.EditRadioYes := TaskAutomatorGui.Add("Radio", "vRadio4Yes x179 y86 h20", "Y")
	Position4.EditRadioYes.Value := Position4.RadioYes
	Position4.EditRadioNo := TaskAutomatorGui.Add("Radio", "vRadio4No x211 y86 w30 h20", "N")
	Position4.EditRadioNo.Value := Position4.RadioNo
	;----------------------------------------------------
	; Position 5
	;----------------------------------------------------
	TaskAutomatorGui.Add("Text","x260 y86 h20 +0x200", "5")
	TaskAutomatorGui.SetFont()
	TaskAutomatorGui.SetFont("Bold " . FontClickerPatternColor . "", MainFontType)
	if EditBoxesAvailable == true {
		Position5.EditPosX := TaskAutomatorGui.Add("Edit", "vCoordX5 x275 y86 w40 h20 +Number")
	} else {
		Position5.EditPosX := TaskAutomatorGui.Add("Edit", "vCoordX5 x275 y86 w40 h20 +Number +Disabled")
	}
	Position5.EditPosX.Opt("" . BackgroundMainColor . "")
	TaskAutomatorGui.SetFont()
	TaskAutomatorGui.SetFont("Bold " . MainFontColor, MainFontType)
	Position5.EditPosX.Value := Position5.CoordX
	;--------------------
	TaskAutomatorGui.SetFont()
	TaskAutomatorGui.SetFont("Bold " . FontClickerPatternColor . "", MainFontType)
	if EditBoxesAvailable == true {
		Position5.EditPosY := TaskAutomatorGui.Add("Edit", "vCoordY5 x323 y86 w40 h20 +Number")
	} else {
		Position5.EditPosY := TaskAutomatorGui.Add("Edit", "vCoordY5 x323 y86 w40 h20 +Number +Disabled")
	}
	Position5.EditPosY.Opt("" . BackgroundMainColor . "")
	TaskAutomatorGui.SetFont()
	TaskAutomatorGui.SetFont("Bold " . MainFontColor, MainFontType)
	Position5.EditPosY.Value := Position5.CoordY
	;--------------------
	TaskAutomatorGui.SetFont()
	TaskAutomatorGui.SetFont("Bold " . FontClickerPatternColor . "", MainFontType)
	if EditBoxesAvailable == true {
		Position5.EditInterval := TaskAutomatorGui.Add("Edit", "vCoord5Interval x371 y86 w50 h20 +Number")
	} else {
		Position5.EditInterval := TaskAutomatorGui.Add("Edit", "vCoord5Interval x371 y86 w50 h20 +Number +Disabled")
	}
	Position5.EditInterval.Opt("" . BackgroundMainColor . "")
	TaskAutomatorGui.SetFont()
	TaskAutomatorGui.SetFont("Bold " . MainFontColor, MainFontType)
	Position5.EditInterval.Value := Position5.Interval
	;--------------------
	Position5.EditRadioYes := TaskAutomatorGui.Add("Radio", "vRadio5Yes x429 y86 h20", "Y")
	Position5.EditRadioYes.Value := Position5.RadioYes
	Position5.EditRadioNo := TaskAutomatorGui.Add("Radio", "vRadio5No x461 y86 w30 h20", "N")
	Position5.EditRadioNo.Value := Position5.RadioNo
	;----------------------------------------------------
	; Position 6
	;----------------------------------------------------
	TaskAutomatorGui.Add("Text","x510 y86 h20 +0x200", "6")
	TaskAutomatorGui.SetFont()
	TaskAutomatorGui.SetFont("Bold " . FontClickerPatternColor . "", MainFontType)
	if EditBoxesAvailable == true {
		Position6.EditPosX := TaskAutomatorGui.Add("Edit", "vCoordX6 x525 y86 w40 h20 +Number")
	} else {
		Position6.EditPosX := TaskAutomatorGui.Add("Edit", "vCoordX6 x525 y86 w40 h20 +Number +Disabled")
	}
	Position6.EditPosX.Opt("" . BackgroundMainColor . "")
	TaskAutomatorGui.SetFont()
	TaskAutomatorGui.SetFont("Bold " . MainFontColor, MainFontType)
	Position6.EditPosX.Value := Position6.CoordX
	;--------------------
	TaskAutomatorGui.SetFont()
	TaskAutomatorGui.SetFont("Bold " . FontClickerPatternColor . "", MainFontType)
	if EditBoxesAvailable == true {
		Position6.EditPosY := TaskAutomatorGui.Add("Edit", "vCoordY6 x573 y86 w40 h20 +Number")
	} else {
		Position6.EditPosY := TaskAutomatorGui.Add("Edit", "vCoordY6 x573 y86 w40 h20 +Number +Disabled")
	}
	Position6.EditPosY.Opt("" . BackgroundMainColor . "")
	TaskAutomatorGui.SetFont()
	TaskAutomatorGui.SetFont("Bold " . MainFontColor, MainFontType)
	Position6.EditPosY.Value := Position6.CoordY
	;--------------------
	TaskAutomatorGui.SetFont()
	TaskAutomatorGui.SetFont("Bold " . FontClickerPatternColor . "", MainFontType)
	if EditBoxesAvailable == true {
		Position6.EditInterval := TaskAutomatorGui.Add("Edit", "vCoord6Interval x621 y86 w50 h20 +Number")
	} else {
		Position6.EditInterval := TaskAutomatorGui.Add("Edit", "vCoord6Interval x621 y86 w50 h20 +Number +Disabled")
	}
	Position6.EditInterval.Opt("" . BackgroundMainColor . "")
	TaskAutomatorGui.SetFont()
	TaskAutomatorGui.SetFont("Bold " . MainFontColor, MainFontType)
	Position6.EditInterval.Value := Position6.Interval
	;--------------------;--------------------
	Position6.EditRadioYes := TaskAutomatorGui.Add("Radio", "vRadio6Yes x679 y86 h20", "Y")
	Position6.EditRadioYes.Value := Position6.RadioYes
	Position6.EditRadioNo := TaskAutomatorGui.Add("Radio", "vRadio6No x711 y86 w30 h20", "N")
	Position6.EditRadioNo.Value := Position6.RadioNo
	;----------------------------------------------------
	; Position 7
	;----------------------------------------------------
	TaskAutomatorGui.Add("Text","x10 y107 h20 +0x200", "7")
	TaskAutomatorGui.SetFont()
	TaskAutomatorGui.SetFont("Bold " . FontClickerPatternColor . "", MainFontType)
	if EditBoxesAvailable == true {
		Position7.EditPosX := TaskAutomatorGui.Add("Edit", "vCoordX7 x25 y107 w40 h20 +Number")
	} else {
		Position7.EditPosX := TaskAutomatorGui.Add("Edit", "vCoordX7 x25 y107 w40 h20 +Number +Disabled")
	}
	Position7.EditPosX.Opt("" . BackgroundMainColor . "")
	TaskAutomatorGui.SetFont()
	TaskAutomatorGui.SetFont("Bold " . MainFontColor, MainFontType)
	Position7.EditPosX.Value := Position7.CoordX
	;--------------------
	TaskAutomatorGui.SetFont()
	TaskAutomatorGui.SetFont("Bold " . FontClickerPatternColor . "", MainFontType)
	if EditBoxesAvailable == true {
		Position7.EditPosY := TaskAutomatorGui.Add("Edit", "vCoordY7 x73 y107 w40 h20 +Number")
	} else {
		Position7.EditPosY := TaskAutomatorGui.Add("Edit", "vCoordY7 x73 y107 w40 h20 +Number +Disabled")
	}
	Position7.EditPosY.Opt("" . BackgroundMainColor . "")
	TaskAutomatorGui.SetFont()
	TaskAutomatorGui.SetFont("Bold " . MainFontColor, MainFontType)
	Position7.EditPosY.Value := Position7.CoordY
	;--------------------
	TaskAutomatorGui.SetFont()
	TaskAutomatorGui.SetFont("Bold " . FontClickerPatternColor . "", MainFontType)
	if EditBoxesAvailable == true {
		Position7.EditInterval := TaskAutomatorGui.Add("Edit", "vCoord7Interval x121 y107 w50 h20 +Number")
	} else {
		Position7.EditInterval := TaskAutomatorGui.Add("Edit", "vCoord7Interval x121 y107 w50 h20 +Number +Disabled")
	}
	Position7.EditInterval.Opt("" . BackgroundMainColor . "")
	TaskAutomatorGui.SetFont()
	TaskAutomatorGui.SetFont("Bold " . MainFontColor, MainFontType)
	Position7.EditInterval.Value := Position7.Interval
	;--------------------
	Position7.EditRadioYes := TaskAutomatorGui.Add("Radio", "vRadio7Yes x179 y107 h20", "Y")
	Position7.EditRadioYes.Value := Position7.RadioYes
	Position7.EditRadioNo := TaskAutomatorGui.Add("Radio", "vRadio7No x211 y107 w30 h20", "N")
	Position7.EditRadioNo.Value := Position7.RadioNo
	;----------------------------------------------------
	; Position 8
	;----------------------------------------------------
	TaskAutomatorGui.Add("Text","x260 y107 h20 +0x200", "8")
	TaskAutomatorGui.SetFont()
	TaskAutomatorGui.SetFont("Bold " . FontClickerPatternColor . "", MainFontType)
	if EditBoxesAvailable == true {
		Position8.EditPosX := TaskAutomatorGui.Add("Edit", "vCoordX8 x275 y107 w40 h20 +Number")
	} else {
		Position8.EditPosX := TaskAutomatorGui.Add("Edit", "vCoordX8 x275 y107 w40 h20 +Number +Disabled")
	}
	Position8.EditPosX.Opt("" . BackgroundMainColor . "")
	TaskAutomatorGui.SetFont()
	TaskAutomatorGui.SetFont("Bold " . MainFontColor, MainFontType)
	Position8.EditPosX.Value := Position8.CoordX
	;--------------------
	TaskAutomatorGui.SetFont()
	TaskAutomatorGui.SetFont("Bold " . FontClickerPatternColor . "", MainFontType)
	if EditBoxesAvailable == true {
		Position8.EditPosY := TaskAutomatorGui.Add("Edit", "vCoordY8 x323 y107 w40 h20 +Number")
	} else {
		Position8.EditPosY := TaskAutomatorGui.Add("Edit", "vCoordY8 x323 y107 w40 h20 +Number +Disabled")
	}
	Position8.EditPosY.Opt("" . BackgroundMainColor . "")
	TaskAutomatorGui.SetFont()
	TaskAutomatorGui.SetFont("Bold " . MainFontColor, MainFontType)
	Position8.EditPosY.Value := Position8.CoordY
	;--------------------
	TaskAutomatorGui.SetFont()
	TaskAutomatorGui.SetFont("Bold " . FontClickerPatternColor . "", MainFontType)
	if EditBoxesAvailable == true {
		Position8.EditInterval := TaskAutomatorGui.Add("Edit", "vCoord8Interval x371 y107 w50 h20 +Number")
	} else {
		Position8.EditInterval := TaskAutomatorGui.Add("Edit", "vCoord8Interval x371 y107 w50 h20 +Number +Disabled")
	}
	Position8.EditInterval.Opt("" . BackgroundMainColor . "")
	TaskAutomatorGui.SetFont()
	TaskAutomatorGui.SetFont("Bold " . MainFontColor, MainFontType)
	Position8.EditInterval.Value := Position8.Interval
	;--------------------
	Position8.EditRadioYes := TaskAutomatorGui.Add("Radio", "vRadio8Yes x429 y107 h20", "Y")
	Position8.EditRadioYes.Value := Position8.RadioYes
	Position8.EditRadioNo := TaskAutomatorGui.Add("Radio", "vRadio8No x461 y107 w30 h20", "N")
	Position8.EditRadioNo.Value := Position8.RadioNo
	;----------------------------------------------------
	; Position 9
	;----------------------------------------------------
	TaskAutomatorGui.Add("Text","x510 y107 h20 +0x200", "9")
	TaskAutomatorGui.SetFont()
	TaskAutomatorGui.SetFont("Bold " . FontClickerPatternColor . "", MainFontType)
	if EditBoxesAvailable == true {
		Position9.EditPosX := TaskAutomatorGui.Add("Edit", "vCoordX9 x525 y107 w40 h20 +Number")
	} else {
		Position9.EditPosX := TaskAutomatorGui.Add("Edit", "vCoordX9 x525 y107 w40 h20 +Number +Disabled")
	}
	Position9.EditPosX.Opt("" . BackgroundMainColor . "")
	TaskAutomatorGui.SetFont()
	TaskAutomatorGui.SetFont("Bold " . MainFontColor, MainFontType)
	Position9.EditPosX.Value := Position9.CoordX
	;--------------------
	TaskAutomatorGui.SetFont()
	TaskAutomatorGui.SetFont("Bold " . FontClickerPatternColor . "", MainFontType)
	if EditBoxesAvailable == true {
		Position9.EditPosY := TaskAutomatorGui.Add("Edit", "vCoordY9 x573 y107 w40 h20 +Number")
	} else {
		Position9.EditPosY := TaskAutomatorGui.Add("Edit", "vCoordY9 x573 y107 w40 h20 +Number +Disabled")
	}
	Position9.EditPosY.Opt("" . BackgroundMainColor . "")
	TaskAutomatorGui.SetFont()
	TaskAutomatorGui.SetFont("Bold " . MainFontColor, MainFontType)
	Position9.EditPosY.Value := Position9.CoordY
	;--------------------
	TaskAutomatorGui.SetFont()
	TaskAutomatorGui.SetFont("Bold " . FontClickerPatternColor . "", MainFontType)
	if EditBoxesAvailable == true {
		Position9.EditInterval := TaskAutomatorGui.Add("Edit", "vCoord9Interval x621 y107 w50 h20 +Number")
	} else {
		Position9.EditInterval := TaskAutomatorGui.Add("Edit", "vCoord9Interval x621 y107 w50 h20 +Number +Disabled")
	}
	Position9.EditInterval.Opt("" . BackgroundMainColor . "")
	TaskAutomatorGui.SetFont()
	TaskAutomatorGui.SetFont("Bold " . MainFontColor, MainFontType)
	Position9.EditInterval.Value := Position9.Interval
	;--------------------
	Position9.EditRadioYes := TaskAutomatorGui.Add("Radio", "vRadio9Yes x679 y107 h20", "Y")
	Position9.EditRadioYes.Value := Position9.RadioYes
	Position9.EditRadioNo := TaskAutomatorGui.Add("Radio", "vRadio9No x711 y107 w30 h20", "N")
	Position9.EditRadioNo.Value := Position9.RadioNo
	;----------------------------------------------------
	; Position 10
	;----------------------------------------------------
	TaskAutomatorGui.Add("Text","x7 y128 h20 +0x200", "10")
	TaskAutomatorGui.SetFont()
	TaskAutomatorGui.SetFont("Bold " . FontClickerPatternColor . "", MainFontType)
	if EditBoxesAvailable == true {
		Position10.EditPosX := TaskAutomatorGui.Add("Edit", "vCoordX10 x25 y128 w40 h20 +Number")
	} else {
		Position10.EditPosX := TaskAutomatorGui.Add("Edit", "vCoordX10 x25 y128 w40 h20 +Number +Disabled")
	}
	Position10.EditPosX.Opt("" . BackgroundMainColor . "")
	TaskAutomatorGui.SetFont()
	TaskAutomatorGui.SetFont("Bold " . MainFontColor, MainFontType)
	Position10.EditPosX.Value := Position10.CoordX
	;--------------------
	TaskAutomatorGui.SetFont()
	TaskAutomatorGui.SetFont("Bold " . FontClickerPatternColor . "", MainFontType)
	if EditBoxesAvailable == true {
		Position10.EditPosY := TaskAutomatorGui.Add("Edit", "vCoordY10 x73 y128 w40 h20 +Number")
	} else {
		Position10.EditPosY := TaskAutomatorGui.Add("Edit", "vCoordY10 x73 y128 w40 h20 +Number +Disabled")
	}
	Position10.EditPosY.Opt("" . BackgroundMainColor . "")
	TaskAutomatorGui.SetFont()
	TaskAutomatorGui.SetFont("Bold " . MainFontColor, MainFontType)
	Position10.EditPosY.Value := Position10.CoordY
	;--------------------
	TaskAutomatorGui.SetFont()
	TaskAutomatorGui.SetFont("Bold " . FontClickerPatternColor . "", MainFontType)
	if EditBoxesAvailable == true {
		Position10.EditInterval := TaskAutomatorGui.Add("Edit", "vCoord10Interval x121 y128 w50 h20 +Number")
	} else {
		Position10.EditInterval := TaskAutomatorGui.Add("Edit", "vCoord10Interval x121 y128 w50 h20 +Number +Disabled")
	}
	Position10.EditInterval.Opt("" . BackgroundMainColor . "")
	TaskAutomatorGui.SetFont()
	TaskAutomatorGui.SetFont("Bold " . MainFontColor, MainFontType)
	Position10.EditInterval.Value := Position10.Interval
	;--------------------
	Position10.EditRadioYes := TaskAutomatorGui.Add("Radio", "vRadio10Yes x179 y128 h20", "Y")
	Position10.EditRadioYes.Value := Position10.RadioYes
	Position10.EditRadioNo := TaskAutomatorGui.Add("Radio", "vRadio10No x211 y128 w30 h20", "N")
	Position10.EditRadioNo.Value := Position10.RadioNo
	;----------------------------------------------------
	; Position 11
	;----------------------------------------------------
	TaskAutomatorGui.Add("Text","x257 y128 h20 +0x200", "11")
	TaskAutomatorGui.SetFont()
	TaskAutomatorGui.SetFont("Bold " . FontClickerPatternColor . "", MainFontType)
	if EditBoxesAvailable == true {
		Position11.EditPosX := TaskAutomatorGui.Add("Edit", "vCoordX11 x275 y128 w40 h20 +Number")
	} else {
		Position11.EditPosX := TaskAutomatorGui.Add("Edit", "vCoordX11 x275 y128 w40 h20 +Number +Disabled")
	}
	Position11.EditPosX.Opt("" . BackgroundMainColor . "")
	TaskAutomatorGui.SetFont()
	TaskAutomatorGui.SetFont("Bold " . MainFontColor, MainFontType)
	Position11.EditPosX.Value := Position11.CoordX
	;--------------------
	TaskAutomatorGui.SetFont()
	TaskAutomatorGui.SetFont("Bold " . FontClickerPatternColor . "", MainFontType)
	if EditBoxesAvailable == true {
		Position11.EditPosY := TaskAutomatorGui.Add("Edit", "vCoordY11 x323 y128 w40 h20 +Number")
	} else {
		Position11.EditPosY := TaskAutomatorGui.Add("Edit", "vCoordY11 x323 y128 w40 h20 +Number +Disabled")
	}
	Position11.EditPosY.Opt("" . BackgroundMainColor . "")
	TaskAutomatorGui.SetFont()
	TaskAutomatorGui.SetFont("Bold " . MainFontColor, MainFontType)
	Position11.EditPosY.Value := Position11.CoordY
	;--------------------
	TaskAutomatorGui.SetFont()
	TaskAutomatorGui.SetFont("Bold " . FontClickerPatternColor . "", MainFontType)
	if EditBoxesAvailable == true {
		Position11.EditInterval := TaskAutomatorGui.Add("Edit", "vCoord11Interval x371 y128 w50 h20 +Number")
	} else {
		Position11.EditInterval := TaskAutomatorGui.Add("Edit", "vCoord11Interval x371 y128 w50 h20 +Number +Disabled")
	}
	Position11.EditInterval.Opt("" . BackgroundMainColor . "")
	TaskAutomatorGui.SetFont()
	TaskAutomatorGui.SetFont("Bold " . MainFontColor, MainFontType)
	Position11.EditInterval.Value := Position11.Interval
	;--------------------
	Position11.EditRadioYes := TaskAutomatorGui.Add("Radio", "vRadio11Yes x429 y128 h20", "Y")
	Position11.EditRadioYes.Value := Position11.RadioYes
	Position11.EditRadioNo := TaskAutomatorGui.Add("Radio", "vRadio11No x461 y128 w30 h20", "N")
	Position11.EditRadioNo.Value := Position11.RadioNo
	;----------------------------------------------------
	; Position 12
	;----------------------------------------------------
	TaskAutomatorGui.Add("Text","x507 y128 h20 +0x200", "12")
	TaskAutomatorGui.SetFont()
	TaskAutomatorGui.SetFont("Bold " . FontClickerPatternColor . "", MainFontType)
	if EditBoxesAvailable == true {
		Position12.EditPosX := TaskAutomatorGui.Add("Edit", "vCoordX12 x525 y128 w40 h20 +Number")
	} else {
		Position12.EditPosX := TaskAutomatorGui.Add("Edit", "vCoordX12 x525 y128 w40 h20 +Number +Disabled")
	}
	Position12.EditPosX.Opt("" . BackgroundMainColor . "")
	TaskAutomatorGui.SetFont()
	TaskAutomatorGui.SetFont("Bold " . MainFontColor, MainFontType)
	Position12.EditPosX.Value := Position12.CoordX
	;--------------------
	TaskAutomatorGui.SetFont()
	TaskAutomatorGui.SetFont("Bold " . FontClickerPatternColor . "", MainFontType)
	if EditBoxesAvailable == true {
		Position12.EditPosY := TaskAutomatorGui.Add("Edit", "vCoordY12 x573 y128 w40 h20 +Number")
	} else {
		Position12.EditPosY := TaskAutomatorGui.Add("Edit", "vCoordY12 x573 y128 w40 h20 +Number +Disabled")
	}
	Position12.EditPosY.Opt("" . BackgroundMainColor . "")
	TaskAutomatorGui.SetFont()
	TaskAutomatorGui.SetFont("Bold " . MainFontColor, MainFontType)
	Position12.EditPosY.Value := Position12.CoordY
	;--------------------
	TaskAutomatorGui.SetFont()
	TaskAutomatorGui.SetFont("Bold " . FontClickerPatternColor . "", MainFontType)
	if EditBoxesAvailable == true {
		Position12.EditInterval := TaskAutomatorGui.Add("Edit", "vCoord12Interval x621 y128 w50 h20 +Number")
	} else {
		Position12.EditInterval := TaskAutomatorGui.Add("Edit", "vCoord12Interval x621 y128 w50 h20 +Number +Disabled")
	}
	Position12.EditInterval.Opt("" . BackgroundMainColor . "")
	TaskAutomatorGui.SetFont()
	TaskAutomatorGui.SetFont("Bold " . MainFontColor, MainFontType)
	Position12.EditInterval.Value := Position12.Interval
	;--------------------
	Position12.EditRadioYes := TaskAutomatorGui.Add("Radio", "vRadio12Yes x679 y128 h20", "Y")
	Position12.EditRadioYes.Value := Position12.RadioYes
	Position12.EditRadioNo := TaskAutomatorGui.Add("Radio", "vRadio12No x711 y128 w30 h20", "N")
	Position12.EditRadioNo.Value := Position12.RadioNo
	;----------------------------------------------------
	; Position 13
	;----------------------------------------------------
	TaskAutomatorGui.Add("Text","x7 y149 h20 +0x200", "13")
	TaskAutomatorGui.SetFont()
	TaskAutomatorGui.SetFont("Bold " . FontClickerPatternColor . "", MainFontType)
	if EditBoxesAvailable == true {
		Position13.EditPosX := TaskAutomatorGui.Add("Edit", "vCoordX13 x25 y149 w40 h20 +Number")
	} else {
		Position13.EditPosX := TaskAutomatorGui.Add("Edit", "vCoordX13 x25 y149 w40 h20 +Number +Disabled")
	}
	Position13.EditPosX.Opt("" . BackgroundMainColor . "")
	TaskAutomatorGui.SetFont()
	TaskAutomatorGui.SetFont("Bold " . MainFontColor, MainFontType)
	Position13.EditPosX.Value := Position13.CoordX
	;--------------------
	TaskAutomatorGui.SetFont()
	TaskAutomatorGui.SetFont("Bold " . FontClickerPatternColor . "", MainFontType)
	if EditBoxesAvailable == true {
		Position13.EditPosY := TaskAutomatorGui.Add("Edit", "vCoordY13 x73 y149 w40 h20 +Number")
	} else {
		Position13.EditPosY := TaskAutomatorGui.Add("Edit", "vCoordY13 x73 y149 w40 h20 +Number +Disabled")
	}
	Position13.EditPosY.Opt("" . BackgroundMainColor . "")
	TaskAutomatorGui.SetFont()
	TaskAutomatorGui.SetFont("Bold " . MainFontColor, MainFontType)
	Position13.EditPosY.Value := Position13.CoordY
	;--------------------
	TaskAutomatorGui.SetFont()
	TaskAutomatorGui.SetFont("Bold " . FontClickerPatternColor . "", MainFontType)
	if EditBoxesAvailable == true {
		Position13.EditInterval := TaskAutomatorGui.Add("Edit", "vCoord13Interval x121 y149 w50 h20 +Number")
	} else {
		Position13.EditInterval := TaskAutomatorGui.Add("Edit", "vCoord13Interval x121 y149 w50 h20 +Number +Disabled")
	}
	Position13.EditInterval.Opt("" . BackgroundMainColor . "")
	TaskAutomatorGui.SetFont()
	TaskAutomatorGui.SetFont("Bold " . MainFontColor, MainFontType)
	Position13.EditInterval.Value := Position13.Interval
	;--------------------
	Position13.EditRadioYes := TaskAutomatorGui.Add("Radio", "vRadio13Yes x179 y149 h20", "Y")
	Position13.EditRadioYes.Value := Position13.RadioYes
	Position13.EditRadioNo := TaskAutomatorGui.Add("Radio", "vRadio13No x211 y149 w30 h20", "N")
	Position13.EditRadioNo.Value := Position13.RadioNo
	;----------------------------------------------------
	; Position 14
	;----------------------------------------------------
	TaskAutomatorGui.Add("Text","x257 y149 h20 +0x200", "14")
	TaskAutomatorGui.SetFont()
	TaskAutomatorGui.SetFont("Bold " . FontClickerPatternColor . "", MainFontType)
	if EditBoxesAvailable == true {
		Position14.EditPosX := TaskAutomatorGui.Add("Edit", "vCoordX14 x275 y149 w40 h20 +Number")
	} else {
		Position14.EditPosX := TaskAutomatorGui.Add("Edit", "vCoordX14 x275 y149 w40 h20 +Number +Disabled")
	}
	Position14.EditPosX.Opt("" . BackgroundMainColor . "")
	TaskAutomatorGui.SetFont()
	TaskAutomatorGui.SetFont("Bold " . MainFontColor, MainFontType)
	Position14.EditPosX.Value := Position14.CoordX
	;--------------------
	TaskAutomatorGui.SetFont()
	TaskAutomatorGui.SetFont("Bold " . FontClickerPatternColor . "", MainFontType)
	if EditBoxesAvailable == true {
		Position14.EditPosY := TaskAutomatorGui.Add("Edit", "vCoordY14 x323 y149 w40 h20 +Number")
	} else {
		Position14.EditPosY := TaskAutomatorGui.Add("Edit", "vCoordY14 x323 y149 w40 h20 +Number +Disabled")
	}
	Position14.EditPosY.Opt("" . BackgroundMainColor . "")
	TaskAutomatorGui.SetFont()
	TaskAutomatorGui.SetFont("Bold " . MainFontColor, MainFontType)
	Position14.EditPosY.Value := Position14.CoordY
	;--------------------
	TaskAutomatorGui.SetFont()
	TaskAutomatorGui.SetFont("Bold " . FontClickerPatternColor . "", MainFontType)
	if EditBoxesAvailable == true {
		Position14.EditInterval := TaskAutomatorGui.Add("Edit", "vCoord14Interval x371 y149 w50 h20 +Number")
	} else {
		Position14.EditInterval := TaskAutomatorGui.Add("Edit", "vCoord14Interval x371 y149 w50 h20 +Number +Disabled")
	}
	Position14.EditInterval.Opt("" . BackgroundMainColor . "")
	TaskAutomatorGui.SetFont()
	TaskAutomatorGui.SetFont("Bold " . MainFontColor, MainFontType)
	Position14.EditInterval.Value := Position14.Interval
	;--------------------
	Position14.EditRadioYes := TaskAutomatorGui.Add("Radio", "vRadio14Yes x429 y149 h20", "Y")
	Position14.EditRadioYes.Value := Position14.RadioYes
	Position14.EditRadioNo := TaskAutomatorGui.Add("Radio", "vRadio14No x461 y149 w30 h20", "N")
	Position14.EditRadioNo.Value := Position14.RadioNo
	;----------------------------------------------------
	; Position 15
	;----------------------------------------------------
	TaskAutomatorGui.Add("Text","x507 y149 h20 +0x200", "15")
	TaskAutomatorGui.SetFont()
	TaskAutomatorGui.SetFont("Bold " . FontClickerPatternColor . "", MainFontType)
	if EditBoxesAvailable == true {
		Position15.EditPosX := TaskAutomatorGui.Add("Edit", "vCoordX15 x525 y149 w40 h20 +Number")
	} else {
		Position15.EditPosX := TaskAutomatorGui.Add("Edit", "vCoordX15 x525 y149 w40 h20 +Number +Disabled")
	}
	Position15.EditPosX.Opt("" . BackgroundMainColor . "")
	TaskAutomatorGui.SetFont()
	TaskAutomatorGui.SetFont("Bold " . MainFontColor, MainFontType)
	Position15.EditPosX.Value := Position15.CoordX
	;--------------------
	TaskAutomatorGui.SetFont()
	TaskAutomatorGui.SetFont("Bold " . FontClickerPatternColor . "", MainFontType)
	if EditBoxesAvailable == true {
		Position15.EditPosY := TaskAutomatorGui.Add("Edit", "vCoordY15 x573 y149 w40 h20 +Number")
	} else {
		Position15.EditPosY := TaskAutomatorGui.Add("Edit", "vCoordY15 x573 y149 w40 h20 +Number +Disabled")
	}
	Position15.EditPosY.Opt("" . BackgroundMainColor . "")
	TaskAutomatorGui.SetFont()
	TaskAutomatorGui.SetFont("Bold " . MainFontColor, MainFontType)
	Position15.EditPosY.Value := Position15.CoordY
	;--------------------
	TaskAutomatorGui.SetFont()
	TaskAutomatorGui.SetFont("Bold " . FontClickerPatternColor . "", MainFontType)
	if EditBoxesAvailable == true {
		Position15.EditInterval := TaskAutomatorGui.Add("Edit", "vCoord15Interval x621 y149 w50 h20 +Number")
	} else {
		Position15.EditInterval := TaskAutomatorGui.Add("Edit", "vCoord15Interval x621 y149 w50 h20 +Number +Disabled")
	}
	Position15.EditInterval.Opt("" . BackgroundMainColor . "")
	TaskAutomatorGui.SetFont()
	TaskAutomatorGui.SetFont("Bold " . MainFontColor, MainFontType)
	Position15.EditInterval.Value := Position15.Interval
	;--------------------
	Position15.EditRadioYes := TaskAutomatorGui.Add("Radio", "vRadio15Yes x679 y149 h20", "Y")
	Position15.EditRadioYes.Value := Position15.RadioYes
	Position15.EditRadioNo := TaskAutomatorGui.Add("Radio", "vRadio15No x711 y149 w30 h20", "N")
	Position15.EditRadioNo.Value := Position15.RadioNo
	;----------------------------------------------------
	; Position 16
	;----------------------------------------------------
	TaskAutomatorGui.Add("Text","x7 y170 h20 +0x200", "16")
	TaskAutomatorGui.SetFont()
	TaskAutomatorGui.SetFont("Bold " . FontClickerPatternColor . "", MainFontType)
	if EditBoxesAvailable == true {
		Position16.EditPosX := TaskAutomatorGui.Add("Edit", "vCoordX16 x25 y170 w40 h20 +Number")
	} else {
		Position16.EditPosX := TaskAutomatorGui.Add("Edit", "vCoordX16 x25 y170 w40 h20 +Number +Disabled")
	}
	Position16.EditPosX.Opt("" . BackgroundMainColor . "")
	TaskAutomatorGui.SetFont()
	TaskAutomatorGui.SetFont("Bold " . MainFontColor, MainFontType)
	Position16.EditPosX.Value := Position16.CoordX
	;--------------------
	TaskAutomatorGui.SetFont()
	TaskAutomatorGui.SetFont("Bold " . FontClickerPatternColor . "", MainFontType)
	if EditBoxesAvailable == true {
		Position16.EditPosY := TaskAutomatorGui.Add("Edit", "vCoordY16 x73 y170 w40 h20 +Number")
	} else {
		Position16.EditPosY := TaskAutomatorGui.Add("Edit", "vCoordY16 x73 y170 w40 h20 +Number +Disabled")
	}
	Position16.EditPosY.Opt("" . BackgroundMainColor . "")
	TaskAutomatorGui.SetFont()
	TaskAutomatorGui.SetFont("Bold " . MainFontColor, MainFontType)
	Position16.EditPosY.Value := Position16.CoordY
	;--------------------
	TaskAutomatorGui.SetFont()
	TaskAutomatorGui.SetFont("Bold " . FontClickerPatternColor . "", MainFontType)
	if EditBoxesAvailable == true {
		Position16.EditInterval := TaskAutomatorGui.Add("Edit", "vCoord16Interval x121 y170 w50 h20 +Number")
	} else {
		Position16.EditInterval := TaskAutomatorGui.Add("Edit", "vCoord16Interval x121 y170 w50 h20 +Number +Disabled")
	}
	Position16.EditInterval.Opt("" . BackgroundMainColor . "")
	TaskAutomatorGui.SetFont()
	TaskAutomatorGui.SetFont("Bold " . MainFontColor, MainFontType)
	Position16.EditInterval.Value := Position16.Interval
	;--------------------
	Position16.EditRadioYes := TaskAutomatorGui.Add("Radio", "vRadio16Yes x179 y170 h20", "Y")
	Position16.EditRadioYes.Value := Position16.RadioYes
	Position16.EditRadioNo := TaskAutomatorGui.Add("Radio", "vRadio16No x211 y170 w30 h20", "N")
	Position16.EditRadioNo.Value := Position16.RadioNo
	;----------------------------------------------------
	; Position 17
	;----------------------------------------------------
	TaskAutomatorGui.Add("Text","x257 y170 h20 +0x200", "17")
	TaskAutomatorGui.SetFont()
	TaskAutomatorGui.SetFont("Bold " . FontClickerPatternColor . "", MainFontType)
	if EditBoxesAvailable == true {
		Position17.EditPosX := TaskAutomatorGui.Add("Edit", "vCoordX17 x275 y170 w40 h20 +Number")
	} else {
		Position17.EditPosX := TaskAutomatorGui.Add("Edit", "vCoordX17 x275 y170 w40 h20 +Number +Disabled")
	}
	Position17.EditPosX.Opt("" . BackgroundMainColor . "")
	TaskAutomatorGui.SetFont()
	TaskAutomatorGui.SetFont("Bold " . MainFontColor, MainFontType)
	Position17.EditPosX.Value := Position17.CoordX
	;--------------------
	TaskAutomatorGui.SetFont()
	TaskAutomatorGui.SetFont("Bold " . FontClickerPatternColor . "", MainFontType)
	if EditBoxesAvailable == true {
		Position17.EditPosY := TaskAutomatorGui.Add("Edit", "vCoordY17 x323 y170 w40 h20 +Number")
	} else {
		Position17.EditPosY := TaskAutomatorGui.Add("Edit", "vCoordY17 x323 y170 w40 h20 +Number +Disabled")
	}
	Position17.EditPosY.Opt("" . BackgroundMainColor . "")
	TaskAutomatorGui.SetFont()
	TaskAutomatorGui.SetFont("Bold " . MainFontColor, MainFontType)
	Position17.EditPosY.Value := Position17.CoordY
	;--------------------
	TaskAutomatorGui.SetFont()
	TaskAutomatorGui.SetFont("Bold " . FontClickerPatternColor . "", MainFontType)
	if EditBoxesAvailable == true {
		Position17.EditInterval := TaskAutomatorGui.Add("Edit", "vCoord17Interval x371 y170 w50 h20 +Number")
	} else {
		Position17.EditInterval := TaskAutomatorGui.Add("Edit", "vCoord17Interval x371 y170 w50 h20 +Number +Disabled")
	}
	Position17.EditInterval.Opt("" . BackgroundMainColor . "")
	TaskAutomatorGui.SetFont()
	TaskAutomatorGui.SetFont("Bold " . MainFontColor, MainFontType)
	Position17.EditInterval.Value := Position17.Interval
	;--------------------
	Position17.EditRadioYes := TaskAutomatorGui.Add("Radio", "vRadio17Yes x429 y170 h20", "Y")
	Position17.EditRadioYes.Value := Position17.RadioYes
	Position17.EditRadioNo := TaskAutomatorGui.Add("Radio", "vRadio17No x461 y170 w30 h20", "N")
	Position17.EditRadioNo.Value := Position17.RadioNo
	;----------------------------------------------------
	; Position 18
	;----------------------------------------------------
	TaskAutomatorGui.Add("Text","x507 y170 h20 +0x200", "18")
	TaskAutomatorGui.SetFont()
	TaskAutomatorGui.SetFont("Bold " . FontClickerPatternColor . "", MainFontType)
	if EditBoxesAvailable == true {
		Position18.EditPosX := TaskAutomatorGui.Add("Edit", "vCoordX18 x525 y170 w40 h20 +Number")
	} else {
		Position18.EditPosX := TaskAutomatorGui.Add("Edit", "vCoordX18 x525 y170 w40 h20 +Number +Disabled")
	}
	Position18.EditPosX.Opt("" . BackgroundMainColor . "")
	TaskAutomatorGui.SetFont()
	TaskAutomatorGui.SetFont("Bold " . MainFontColor, MainFontType)
	Position18.EditPosX.Value := Position18.CoordX
	;--------------------
	TaskAutomatorGui.SetFont()
	TaskAutomatorGui.SetFont("Bold " . FontClickerPatternColor . "", MainFontType)
	if EditBoxesAvailable == true {
		Position18.EditPosY := TaskAutomatorGui.Add("Edit", "vCoordY18 x573 y170 w40 h20 +Number")
	} else {
		Position18.EditPosY := TaskAutomatorGui.Add("Edit", "vCoordY18 x573 y170 w40 h20 +Number +Disabled")
	}
	Position18.EditPosY.Opt("" . BackgroundMainColor . "")
	TaskAutomatorGui.SetFont()
	TaskAutomatorGui.SetFont("Bold " . MainFontColor, MainFontType)
	Position18.EditPosY.Value := Position18.CoordY
	;--------------------
	TaskAutomatorGui.SetFont()
	TaskAutomatorGui.SetFont("Bold " . FontClickerPatternColor . "", MainFontType)
	if EditBoxesAvailable == true {
		Position18.EditInterval := TaskAutomatorGui.Add("Edit", "vCoord18Interval x621 y170 w50 h20 +Number")
	} else {
		Position18.EditInterval := TaskAutomatorGui.Add("Edit", "vCoord18Interval x621 y170 w50 h20 +Number +Disabled")
	}
	Position18.EditInterval.Opt("" . BackgroundMainColor . "")
	TaskAutomatorGui.SetFont()
	TaskAutomatorGui.SetFont("Bold " . MainFontColor, MainFontType)
	Position18.EditInterval.Value := Position18.Interval
	;--------------------
	Position18.EditRadioYes := TaskAutomatorGui.Add("Radio", "vRadio18Yes x679 y170 h20", "Y")
	Position18.EditRadioYes.Value := Position18.RadioYes
	Position18.EditRadioNo := TaskAutomatorGui.Add("Radio", "vRadio18No x711 y170 w30 h20", "N")
	Position18.EditRadioNo.Value := Position18.RadioNo
	;----------------------------------------------------
	; Position 19
	;----------------------------------------------------
	TaskAutomatorGui.Add("Text","x7 y191 h20 +0x200", "19")
	TaskAutomatorGui.SetFont()
	TaskAutomatorGui.SetFont("Bold " . FontClickerPatternColor . "", MainFontType)
	if EditBoxesAvailable == true {
		Position19.EditPosX := TaskAutomatorGui.Add("Edit", "vCoordX19 x25 y191 w40 h20 +Number")
	} else {
		Position19.EditPosX := TaskAutomatorGui.Add("Edit", "vCoordX19 x25 y191 w40 h20 +Number +Disabled")
	}
	Position19.EditPosX.Opt("" . BackgroundMainColor . "")
	TaskAutomatorGui.SetFont()
	TaskAutomatorGui.SetFont("Bold " . MainFontColor, MainFontType)
	Position19.EditPosX.Value := Position19.CoordX
	;--------------------
	TaskAutomatorGui.SetFont()
	TaskAutomatorGui.SetFont("Bold " . FontClickerPatternColor . "", MainFontType)
	if EditBoxesAvailable == true {
		Position19.EditPosY := TaskAutomatorGui.Add("Edit", "vCoordY19 x73 y191 w40 h20 +Number")
	} else {
		Position19.EditPosY := TaskAutomatorGui.Add("Edit", "vCoordY19 x73 y191 w40 h20 +Number +Disabled")
	}
	Position19.EditPosY.Opt("" . BackgroundMainColor . "")
	TaskAutomatorGui.SetFont()
	TaskAutomatorGui.SetFont("Bold " . MainFontColor, MainFontType)
	Position19.EditPosY.Value := Position19.CoordY
	;--------------------
	TaskAutomatorGui.SetFont()
	TaskAutomatorGui.SetFont("Bold " . FontClickerPatternColor . "", MainFontType)
	if EditBoxesAvailable == true {
		Position19.EditInterval := TaskAutomatorGui.Add("Edit", "vCoord19Interval x121 y191 w50 h20 +Number")
	} else {
		Position19.EditInterval := TaskAutomatorGui.Add("Edit", "vCoord19Interval x121 y191 w50 h20 +Number +Disabled")
	}
	Position19.EditInterval.Opt("" . BackgroundMainColor . "")
	TaskAutomatorGui.SetFont()
	TaskAutomatorGui.SetFont("Bold " . MainFontColor, MainFontType)
	Position19.EditInterval.Value := Position19.Interval
	;--------------------
	Position19.EditRadioYes := TaskAutomatorGui.Add("Radio", "vRadio19Yes x179 y191 h20", "Y")
	Position19.EditRadioYes.Value := Position19.RadioYes
	Position19.EditRadioNo := TaskAutomatorGui.Add("Radio", "vRadio19No x211 y191 w30 h20", "N")
	Position19.EditRadioNo.Value := Position19.RadioNo
	;----------------------------------------------------
	; Position 20
	;----------------------------------------------------
	TaskAutomatorGui.Add("Text","x257 y191 h20 +0x200", "20")
	TaskAutomatorGui.SetFont()
	TaskAutomatorGui.SetFont("Bold " . FontClickerPatternColor . "", MainFontType)
	if EditBoxesAvailable == true {
		Position20.EditPosX := TaskAutomatorGui.Add("Edit", "vCoordX20 x275 y191 w40 h20 +Number")
	} else {
		Position20.EditPosX := TaskAutomatorGui.Add("Edit", "vCoordX20 x275 y191 w40 h20 +Number +Disabled")
	}
	Position20.EditPosX.Opt("" . BackgroundMainColor . "")
	TaskAutomatorGui.SetFont()
	TaskAutomatorGui.SetFont("Bold " . MainFontColor, MainFontType)
	Position20.EditPosX.Value := Position20.CoordX
	;--------------------
	TaskAutomatorGui.SetFont()
	TaskAutomatorGui.SetFont("Bold " . FontClickerPatternColor . "", MainFontType)
	if EditBoxesAvailable == true {
		Position20.EditPosY := TaskAutomatorGui.Add("Edit", "vCoordY20 x323 y191 w40 h20 +Number")
	} else {
		Position20.EditPosY := TaskAutomatorGui.Add("Edit", "vCoordY20 x323 y191 w40 h20 +Number +Disabled")
	}
	Position20.EditPosY.Opt("" . BackgroundMainColor . "")
	TaskAutomatorGui.SetFont()
	TaskAutomatorGui.SetFont("Bold " . MainFontColor, MainFontType)
	Position20.EditPosY.Value := Position20.CoordY
	;--------------------
	TaskAutomatorGui.SetFont()
	TaskAutomatorGui.SetFont("Bold " . FontClickerPatternColor . "", MainFontType)
	if EditBoxesAvailable == true {
		Position20.EditInterval := TaskAutomatorGui.Add("Edit", "vCoord20Interval x371 y191 w50 h20 +Number")
	} else {
		Position20.EditInterval := TaskAutomatorGui.Add("Edit", "vCoord20Interval x371 y191 w50 h20 +Number +Disabled")
	}
	Position20.EditInterval.Opt("" . BackgroundMainColor . "")
	TaskAutomatorGui.SetFont()
	TaskAutomatorGui.SetFont("Bold " . MainFontColor, MainFontType)
	Position20.EditInterval.Value := Position20.Interval
	;--------------------
	Position20.EditRadioYes := TaskAutomatorGui.Add("Radio", "vRadio20Yes x429 y191 h20", "Y")
	Position20.EditRadioYes.Value := Position20.RadioYes
	Position20.EditRadioNo := TaskAutomatorGui.Add("Radio", "vRadio20No x461 y191 w30 h20", "N")
	Position20.EditRadioNo.Value := Position20.RadioNo
	;----------------------------------------------------
	; Position 21
	;----------------------------------------------------
	TaskAutomatorGui.Add("Text","x507 y191 h20 +0x200", "21")
	TaskAutomatorGui.SetFont()
	TaskAutomatorGui.SetFont("Bold " . FontClickerPatternColor . "", MainFontType)
	if EditBoxesAvailable == true {
		Position21.EditPosX := TaskAutomatorGui.Add("Edit", "vCoordX21 x525 y191 w40 h20 +Number")
	} else {
		Position21.EditPosX := TaskAutomatorGui.Add("Edit", "vCoordX21 x525 y191 w40 h20 +Number +Disabled")
	}
	Position21.EditPosX.Opt("" . BackgroundMainColor . "")
	TaskAutomatorGui.SetFont()
	TaskAutomatorGui.SetFont("Bold " . MainFontColor, MainFontType)
	Position21.EditPosX.Value := Position21.CoordX
	;--------------------
	TaskAutomatorGui.SetFont()
	TaskAutomatorGui.SetFont("Bold " . FontClickerPatternColor . "", MainFontType)
	if EditBoxesAvailable == true {
		Position21.EditPosY := TaskAutomatorGui.Add("Edit", "vCoordY21 x573 y191 w40 h20 +Number")
	} else {
		Position21.EditPosY := TaskAutomatorGui.Add("Edit", "vCoordY21 x573 y191 w40 h20 +Number +Disabled")
	}
	Position21.EditPosY.Opt("" . BackgroundMainColor . "")
	TaskAutomatorGui.SetFont()
	TaskAutomatorGui.SetFont("Bold " . MainFontColor, MainFontType)
	Position21.EditPosY.Value := Position21.CoordY
	;--------------------
	TaskAutomatorGui.SetFont()
	TaskAutomatorGui.SetFont("Bold " . FontClickerPatternColor . "", MainFontType)
	if EditBoxesAvailable == true {
		Position21.EditInterval := TaskAutomatorGui.Add("Edit", "vCoord21Interval x621 y191 w50 h20 +Number")
	} else {
		Position21.EditInterval := TaskAutomatorGui.Add("Edit", "vCoord21Interval x621 y191 w50 h20 +Number +Disabled")
	}
	Position21.EditInterval.Opt("" . BackgroundMainColor . "")
	TaskAutomatorGui.SetFont()
	TaskAutomatorGui.SetFont("Bold " . MainFontColor, MainFontType)
	Position21.EditInterval.Value := Position21.Interval
	;--------------------
	Position21.EditRadioYes := TaskAutomatorGui.Add("Radio", "vRadio21Yes x679 y191 h20", "Y")
	Position21.EditRadioYes.Value := Position21.RadioYes
	Position21.EditRadioNo := TaskAutomatorGui.Add("Radio", "vRadio21No x711 y191 w30 h20", "N")
	Position21.EditRadioNo.Value := Position21.RadioNo
	;----------------------------------------------------
	; Position 22
	;----------------------------------------------------
	TaskAutomatorGui.Add("Text","x7 y212 h20 +0x200", "22")
	TaskAutomatorGui.SetFont()
	TaskAutomatorGui.SetFont("Bold " . FontClickerPatternColor . "", MainFontType)
	if EditBoxesAvailable == true {
		Position22.EditPosX := TaskAutomatorGui.Add("Edit", "vCoordX22 x25 y212 w40 h20 +Number")
	} else {
		Position22.EditPosX := TaskAutomatorGui.Add("Edit", "vCoordX22 x25 y212 w40 h20 +Number +Disabled")
	}
	Position22.EditPosX.Opt("" . BackgroundMainColor . "")
	TaskAutomatorGui.SetFont()
	TaskAutomatorGui.SetFont("Bold " . MainFontColor, MainFontType)
	Position22.EditPosX.Value := Position22.CoordX
	;--------------------
	TaskAutomatorGui.SetFont()
	TaskAutomatorGui.SetFont("Bold " . FontClickerPatternColor . "", MainFontType)
	if EditBoxesAvailable == true {
		Position22.EditPosY := TaskAutomatorGui.Add("Edit", "vCoordY22 x73 y212 w40 h20 +Number")
	} else {
		Position22.EditPosY := TaskAutomatorGui.Add("Edit", "vCoordY22 x73 y212 w40 h20 +Number +Disabled")
	}
	Position22.EditPosY.Opt("" . BackgroundMainColor . "")
	TaskAutomatorGui.SetFont()
	TaskAutomatorGui.SetFont("Bold " . MainFontColor, MainFontType)
	Position22.EditPosY.Value := Position22.CoordY
	;--------------------
	TaskAutomatorGui.SetFont()
	TaskAutomatorGui.SetFont("Bold " . FontClickerPatternColor . "", MainFontType)
	if EditBoxesAvailable == true {
		Position22.EditInterval := TaskAutomatorGui.Add("Edit", "vCoord22Interval x121 y212 w50 h20 +Number")
	} else {
		Position22.EditInterval := TaskAutomatorGui.Add("Edit", "vCoord22Interval x121 y212 w50 h20 +Number +Disabled")
	}
	Position22.EditInterval.Opt("" . BackgroundMainColor . "")
	TaskAutomatorGui.SetFont()
	TaskAutomatorGui.SetFont("Bold " . MainFontColor, MainFontType)
	Position22.EditInterval.Value := Position22.Interval
	;--------------------
	Position22.EditRadioYes := TaskAutomatorGui.Add("Radio", "vRadio22Yes x179 y212 h20", "Y")
	Position22.EditRadioYes.Value := Position22.RadioYes
	Position22.EditRadioNo := TaskAutomatorGui.Add("Radio", "vRadio22No x211 y212 w30 h20", "N")
	Position22.EditRadioNo.Value := Position22.RadioNo
	;----------------------------------------------------
	TaskAutomatorGui.Add("Text","x397 y217 +0x200", " Time interval in ms (1 second = 1000) ")
	
	StartTime := A_TickCount
	LastYLine := 212
}
;----------------------------------------------------
; Y-LastYLine / Resized Save All EditBox Values
;----------------------------------------------------
ResizedSaveAllEditValues(TaskAutomatorGui, &SaveButton, SubmitValues, &LastYLine, &FlagLineValueAdded){
	;-------------------------------
	TaskAutomatorGui.Add("Text", "x1 y" . LastYLine + 25 . " w750 h2 +0x10") ; Separator
	SaveButton := TaskAutomatorGui.Add("Button", "x320 y" . LastYLine + 32 . " h20", "Save Current Values")
	SaveButton.OnEvent("Click", SubmitValues)
	FlagLineValueAdded := true
	if FlagLineValueAdded == true {
		LastYLine := LastYLine + 31
	}
}
;----------------------------------------------------
; Y-LastYLine + 32 / Resized Hotkey Edit Mode - TaskAutomatorGui.ahk
;----------------------------------------------------
ResizedCheckHotkeyEditMode(TaskAutomatorGui,
						   &HotkeyEditMode,
						   &LicenseKeyFontType,
						   &LastYLine){
	;-------------------------------
	TaskAutomatorGui.Add("Text", "x1 y" . LastYLine + 25 . " w750 h2 +0x10") ; Separator
	TaskAutomatorGui.Add("Text","x7 y" . LastYLine + 32 . " w84 h20 +0x200", " Hotkey Mode: ")
	if HotkeyEditMode == true {
		TaskAutomatorGui.SetFont("s8 Bold cYellow", LicenseKeyFontType)
		TaskAutomatorGui.Add("Text","x97 y" . LastYLine + 32 . " w126 h20 +0x200", " Hotkey Edit Mode ")
		TaskAutomatorGui.Add("Picture", "x230 y" . LastYLine + 36 . " w10 h10 +border", IconLib . "\NewVersionAvailable.png")
		TaskAutomatorGui.SetFont("s8 Bold cLime", LicenseKeyFontType)
	} else {
		TaskAutomatorGui.Add("Text","x97 y" . LastYLine + 32 . " w126 h20 +0x200", " Hotkey Active Mode ")
		TaskAutomatorGui.Add("Picture", "x230 y" . LastYLine + 36 . " w10 h10 +border", IconLib . "\UpToDate.png")
	}
	TaskAutomatorGui.Add("Text", "x249 y" . LastYLine + 26 . " w3 h36 +0x11") ; Vertical Separator
}
;----------------------------------------------------
; Y-LastYLine + 32 / EditBoxes Mode - TaskAutomatorGui.ahk
;----------------------------------------------------
ResizedCheckEditBoxesAvailable(TaskAutomatorGui,
							   &EditBoxesAvailable,
							   &LicenseKeyFontType,
							   &LastYLine){
	;-------------------------------
	TaskAutomatorGui.Add("Text","x257 y" . LastYLine + 32 . " w84 h20 +0x200", " EditBox Mode: ")
	if EditBoxesAvailable == true {
		TaskAutomatorGui.SetFont("s8 Bold cYellow", LicenseKeyFontType)
		TaskAutomatorGui.Add("Text","x347 y" . LastYLine + 32 . " w126 h20 +0x200", " Unlocked ")
		TaskAutomatorGui.Add("Picture", "x480 y" . LastYLine + 36 . " w10 h10 +border", IconLib . "\NewVersionAvailable.png")
		TaskAutomatorGui.SetFont("s8 Bold cLime", LicenseKeyFontType)
	} else {
		TaskAutomatorGui.Add("Text","x347 y" . LastYLine + 32 . " w126 h20 +0x200", " Locked ")
		TaskAutomatorGui.Add("Picture", "x480 y" . LastYLine + 36 . " w10 h10 +border", IconLib . "\UpToDate.png")
	}
	TaskAutomatorGui.Add("Text", "x499 y" . LastYLine + 26 . " w3 h36 +0x11") ; Vertical Separator
}
;----------------------------------------------------
; Y-LastYLine + 32  / Check for updates
;----------------------------------------------------
ResizedCheckForUpdates(TaskAutomatorGui, 
					   &FlagCheckTime,
					   &LastUpdateCheckTimeStamp,
					   &LicenseKeyFontType,
					   &CheckforUpdatesDaily,
					   &CheckforupdatesWeekly,
					   &NeverCheckForUpdates, 
					   &NeedUpdate,
					   &Connected,
					   &TALatestReleaseVersion,
					   &DownloadUrl,
					   &CurrentVersion,
					   &LastYLine){
	;-------------------------------
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
	
	TaskAutomatorGui.Add("Text","x507 y" . LastYLine + 32 . " w84 h20 +0x200", " Update check: ")
	switch true {
	case NeverCheckForUpdates == true:
		TaskAutomatorGui.SetFont("s8 Bold c00A8F3", LicenseKeyFontType)
		TaskAutomatorGui.Add("Text","x597 y" . LastYLine + 32 . " w126 h20 +0x200", " Update check disabled ")
		try {
			TaskAutomatorGui.Add("Picture", "x730 y" . LastYLine + 36 . " w10 h10 +border", IconLib . "\UpdateCheckDisabled.png")
		}
		catch {
		}
	case NeedUpdate == true:
		TaskAutomatorGui.SetFont("s8 Bold cYellow", LicenseKeyFontType)
		TaskAutomatorGui.Add("Text","x597 y" . LastYLine + 32 . " w126 h20 +0x200", " New version available ")
		try {
			TaskAutomatorGui.Add("Picture", "x730 y" . LastYLine + 36 . " w10 h10 +border", IconLib . "\NewVersionAvailable.png")
		}
		catch {
		}
	case FlagCheckTime == false and NeedUpdate == false:
		TaskAutomatorGui.SetFont("s8 Bold cLime", LicenseKeyFontType)
		TaskAutomatorGui.Add("Text","x597 y" . LastYLine + 32 . " w126 h20 +0x200", " Version up to date ")
		try {
			TaskAutomatorGui.Add("Picture", "x730 y" . LastYLine + 36 . " w10 h10 +border", IconLib . "\UpToDate.png")
		}
		catch {
		}
	case NeedUpdate == "":
		FlagCheckTime := true
	}
	;-------------------------------
	if FlagCheckTime == true {
		Connected := CheckConnection()
		if Connected != true {
			TaskAutomatorGui.SetFont("s8 Bold cRed", LicenseKeyFontType)
			TaskAutomatorGui.Add("Text","x597 y" . LastYLine + 32 . " w126 h20 +0x200", " No internet connection ")
			try {
				TaskAutomatorGui.Add("Picture", "x730 y" . LastYLine + 36 . " w10 h10 +border", IconLib . "\NoInternetConnection.png")
			}
			catch {
			}
		} else {
			if !FileExist(DataFile) {
				ParseRequest()
			}
			TALatestReleaseVersion := IniRead(DataFile, "GeneralData", "TALatestReleaseVersion")
			if TALatestReleaseVersion == "" {
				ParseRequest()
			}
			DownloadUrl := IniRead(DataFile, "EncryptedData", "TADownload")
			TALatestReleaseVersion := IniRead(DataFile, "GeneralData", "TALatestReleaseVersion")
			if TALatestReleaseVersion != CurrentVersion {
				if DownloadUrl != "" {
					TaskAutomatorGui.SetFont("s8 Bold cYellow", LicenseKeyFontType)
					TaskAutomatorGui.Add("Text","x597 y" . LastYLine + 32 . " w126 h20 +0x200", " New version available ")
					try {
						TaskAutomatorGui.Add("Picture", "x730 y" . LastYLine + 36 . " w10 h10 +border", IconLib . "\NewVersionAvailable.png")
					}
					catch {
					}
					NeedUpdate := true
					IniWrite NeedUpdate, IniFile, "Settings", "NeedUpdate"
				}
			}
			if TALatestReleaseVersion == CurrentVersion {
				TaskAutomatorGui.SetFont("s8 Bold cLime", LicenseKeyFontType)
				TaskAutomatorGui.Add("Text","x597 y" . LastYLine + 32 . " w126 h20 +0x200", " Version up to date ")
				if NeedUpdate == 1 or NeedUpdate == "" {
					IniWrite false, IniFile, "Settings", "NeedUpdate"
				}
				try {
					TaskAutomatorGui.Add("Picture", "x730 y" . LastYLine + 36 . " w10 h10 +border", IconLib . "\UpToDate.png")
				}
				catch {
				}
			}
			IniWrite A_Now, IniFile, "Settings", "LastUpdateCheckTimeStamp"
		}
	}
}
