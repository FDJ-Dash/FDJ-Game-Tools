;------------- Credits ------------
; Creator: Fernando Daniel Jaime.
; Programmer Alias: FDJ-Dash.
;------------- File Details ------------
; App Name: Task Automator.
; File Description: This file creates Task Automator GUI.
;----------------------------------------------------
; Header list:
;----------------------------------------------------
; PaceControl(...)
; KeyboardAutorun(...)
; ControllerAutoRun(...)
; JumpsModule(...)
; AutoClickerModule(...)
; QuickAccessModule(...)
; ModulesOFF(...)
; SaveAllEditValues(...)
; CheckHotkeyEditMode(...)
; CheckForUpdates(...)
;----------------------------------------------------
; Y-10 / Pace control / Auto Scroll Up / Down
;----------------------------------------------------
PaceControl(TaskAutomatorGui,
			&SwitchKbAutoRun, 
			&SwitchControllerAutoRun,
			&OptionsMenu,
			&TextScrlUp,
			&RadioScrlUpYes,
			&RadioScrlUpNo,
			&TextOnOffScrlUp,
			&TextScrlDown,
			&RadioScrlDownYes,
			&RadioScrlDownNo,
			&TextOnOffScrlDown){
	
	;-------------------------------
	if SwitchKbAutoRun == true or SwitchControllerAutoRun == true {
		try {
			OptionsMenu.SetIcon("Switch Top Mod&ules OFF", IconLib . "\Switch2.ico")
		}
		catch {
		}

		;----------------------------------------------------
		; Auto Scroll Up
		;----------------------------------------------------
		TextScrlUp := TaskAutomatorGui.Add("Text","x10 y10 w110 h20 +0x200", " Auto Scroll up")
		RadioScrlUpYes := TaskAutomatorGui.Add("Radio", "x10 y35 w30 h20", "Y")
		RadioScrlUpNo := TaskAutomatorGui.Add("Radio", "x45 y35 w30 h20 +Checked", "N")
		TextOnOffScrlUp := TaskAutomatorGui.Add("Text","x90 y35 w30 h20 +0x200", " OFF")
		;----------------------------------------------------
		; Auto Scroll Down
		;----------------------------------------------------
		TextScrlDown := TaskAutomatorGui.Add("Text","x130 y10 w110 h20 +0x200", " Auto Scroll down")
		RadioScrlDownYes := TaskAutomatorGui.Add("Radio", "x130 y35 w30 h20", "Y")
		RadioScrlDownNo := TaskAutomatorGui.Add("Radio", "x165 y35 w30 h20 +Checked", "N")
		TextOnOffScrlDown := TaskAutomatorGui.Add("Text","x210 y35 w30 h20 +0x200", " OFF")
		
		TaskAutomatorGui.Add("Text", "x1 y60 w250 h2 +0x10") ; Separator
	}
}
;----------------------------------------------------
; Y-67 / Keyboard AutoRun
;----------------------------------------------------
KeyboardAutorun(TaskAutomatorGui,
				&OptionsMenu,
				&SwitchKbAutoRun,
				&SwitchControllerAutoRun,
				&SwitchQuickAccess,
				&SwitchClicker,
				&SwitchJumps,
				&TextOnOff1,
				&HotkeyEditMode,
				&AuxHkDataFile,
				&KbAutoRunHotkey,
				&CtrlKbAutoRunHotkey,
				&AltKbAutoRunHotkey,
				&ShiftKbAutoRunHotkey,
				&LastYLine){
	;-------------------------------
	try {
		OptionsMenu.SetIcon("5. Switch &Jumps", IconLib . "\Switch2.ico")
		OptionsMenu.SetIcon("4. Switch &Clicker", IconLib . "\Switch2.ico")
		OptionsMenu.SetIcon("3a. Switch Quick &Access", IconLib . "\Switch2.ico")
		OptionsMenu.SetIcon("2. Switch Con&troller Autorun", IconLib . "\Switch2.ico")
		OptionsMenu.SetIcon("1. Switch &Keyboard Autorun", IconLib . "\Switch1.ico")
	}
	catch {
	}
	SwitchQuickAccess := 0
	SwitchClicker := 0
	SwitchJumps := 0
	SwitchControllerAutoRun := 0
	SwitchKbAutoRun := 1
	
	TaskAutomatorGui.Add("Text", "x10 y67 h20 +0x200", " Kb. AutoRun ")
	TextOnOff1 := TaskAutomatorGui.Add("Text","x105 y67 h20 +0x200", " OFF ")
	OptionsMenu.SetIcon("1. Switch &Keyboard Autorun", IconLib . "\Switch1.ico")
	if HotkeyEditMode == true {
		if !FileExist(AuxHkDataFile) {
			CreateNewAuxHkDataFile()
		}
		
		CtrlKbAutoRunHotkey := IniRead(AuxHkDataFile, "CtrlHkFlags", "CtrlKbAutoRunHotkey")
		AltKbAutoRunHotkey := IniRead(AuxHkDataFile, "AltHkFlags", "AltKbAutoRunHotkey")
		ShiftKbAutoRunHotkey := IniRead(AuxHkDataFile, "ShiftHkFlags", "ShiftKbAutoRunHotkey")
		switch true {
		case CtrlKbAutoRunHotkey == 1:
			if KbAutoRunHotkey == "" {
				KbAutoRunHotkey := "Ctrl"
				IniWrite KbAutoRunHotkey, IniFile, "SavedHotkey", "KbAutoRunHotkey"
			}
			CtrlKbAutoRunHotkey := 0
			IniWrite CtrlKbAutoRunHotkey, AuxHkDataFile, "CtrlHkFlags", "CtrlKbAutoRunHotkey"
		case AltKbAutoRunHotkey == 1:
			if KbAutoRunHotkey == "" {
				KbAutoRunHotkey := "Alt"
				IniWrite KbAutoRunHotkey, IniFile, "SavedHotkey", "KbAutoRunHotkey"
			}
			AltKbAutoRunHotkey := 0
			IniWrite AltKbAutoRunHotkey, AuxHkDataFile, "AltHkFlags", "AltKbAutoRunHotkey"
		case ShiftKbAutoRunHotkey == 1:
			if KbAutoRunHotkey == "" {
				KbAutoRunHotkey := "Shift"
				IniWrite KbAutoRunHotkey, IniFile, "SavedHotkey", "KbAutoRunHotkey"
			}
			ShiftKbAutoRunHotkey := 0
			IniWrite ShiftKbAutoRunHotkey, AuxHkDataFile, "ShiftHkFlags", "ShiftKbAutoRunHotkey" 
		case KbAutoRunHotkey == "":
			KbAutoRunHotkey := "Space"
			IniWrite KbAutoRunHotkey, IniFile, "SavedHotkey", "KbAutoRunHotkey"
		}

		KbAutoRunHotkey := TaskAutomatorGui.Add("Hotkey", "vKbAutoRunHotkey x150 y67 w90 h20", KbAutoRunHotkey).OnEvent("Change", SubmitAutoRunHotkey)
	} else {
		if FileExist(AuxHkDataFile){
			try {
				FileDelete AuxHkDataFile
			}
			catch {
			}
		}
		KbAutoRunHotkey := TaskAutomatorGui.Add("Hotkey", "vKbAutoRunHotkey x150 y67 w90 h20 +disabled", KbAutoRunHotkey)
	} ; HotkeyEditMode false end

	LastYLine := 67
}
;----------------------------------------------------
; Y-122 / Controller AutoRun
;----------------------------------------------------
ControllerAutoRun(TaskAutomatorGui,
				  &OptionsMenu,
				  &SwitchControllerAutoRun,
				  &SwitchKbAutoRun,
				  &SwitchQuickAccess,
				  &SwitchClicker,
				  &SwitchJumps,
				  &RadioCtrlAuRunYes,
				  &RadioCtrlAuRunNo, 
				  &TextOnOffController,
				  &ControllerName,
				  &TextOnOffCtrlAuRun,
				  &EditBoxesAvailable,
				  &SeletedButton,
				  &EditSelectedKey,
				  &LastYLine){
	;-------------------------------
	try {
		OptionsMenu.SetIcon("5. Switch &Jumps", IconLib . "\Switch2.ico")
		OptionsMenu.SetIcon("4. Switch &Clicker", IconLib . "\Switch2.ico")
		OptionsMenu.SetIcon("3a. Switch Quick &Access", IconLib . "\Switch2.ico")
		OptionsMenu.SetIcon("2. Switch Con&troller Autorun", IconLib . "\Switch1.ico")
		OptionsMenu.SetIcon("1. Switch &Keyboard Autorun", IconLib . "\Switch2.ico")
	}
	catch {
	}
	SwitchQuickAccess := 0
	SwitchClicker := 0
	SwitchJumps := 0
	SwitchControllerAutoRun := 1
	SwitchKbAutoRun := 0

	TaskAutomatorGui.Add("Text","x10 y67 h20 +0x200", " Controller: ")
	TextOnOffController := TaskAutomatorGui.Add("Text","x85 y67 w155 h20 +0x200", " Controller Not Found")
	ControllerName := TaskAutomatorGui.Add("Text","x10 y92 w230 h20 +0x200", " ")

	TaskAutomatorGui.Add("Text","x10 y117 w110 h20 +0x200", " Controller AutoRun:")
	RadioCtrlAuRunYes := TaskAutomatorGui.Add("Radio", "x130 y117 w30 h20 +Checked", "Y")
	RadioCtrlAuRunNo := TaskAutomatorGui.Add("Radio", "x165 y117 w30 h20", "N")
	TextOnOffCtrlAuRun := TaskAutomatorGui.Add("Text","x210 y117 w30 h20 +0x200", " OFF")
	TaskAutomatorGui.Add("Text","x10 y142 w110 h20 +0x200", " Selected key: ")
	if EditBoxesAvailable == true {
		EditSelectedKey := TaskAutomatorGui.Add("Edit", "vSelectedKey x150 y142 w90 h20 +ReadOnly")
		EditSelectedKey.Value := "Press a button"
		EditSelectedKey.Opt("" . BackgroundMainColor . "")
		RadioCtrlAuRunYes.Value := false
		RadioCtrlAuRunNo.Value := true
		TaskAutomatorGui.SetFont("s8 Bold cYellow", LicenseKeyFontType)
		TaskAutomatorGui.Add("Text","x25 y167 h20 +0x200", " Press SPACE to quit button selection ")
		TaskAutomatorGui.SetFont("s8 Bold cLime", LicenseKeyFontType)
		LastYLine := 167
	} else {
		EditSelectedKey := TaskAutomatorGui.Add("Edit", "vSelectedKey x150 y142 w90 h20 +Disabled")
		EditSelectedKey.Value := SeletedButton
		EditSelectedKey.Opt("" . BackgroundMainColor . "")
		LastYLine := 142
	}
}
;----------------------------------------------------
; Y-226 / Jumps
;----------------------------------------------------
JumpsModule(TaskAutomatorGui,
			&OptionsMenu, 
			&SwitchQuickAccess,
			&SwitchClicker,
			&SwitchJumps,
			&SwitchControllerAutoRun,
			&SwitchKbAutoRun, 
			&TextOnOff2,
			&TextOnOff3,
			&TextOnOff4,
			&TextOnOff5,
			&TextOnOff6,
			&HotkeyEditMode,
			&JumpHotkey0,
			&JumpHotkey1,
			&JumpHotkey2,
			&JumpHotkey3,
			&JumpHotkey4,
			&CtrlJumpHotkey0,
			&AltJumpHotkey0,
			&ShiftJumpHotkey0,
			&CtrlJumpHotkey1,
			&AltJumpHotkey1,
			&ShiftJumpHotkey1,
			&CtrlJumpHotkey2,
			&AltJumpHotkey2,
			&ShiftJumpHotkey2,
			&CtrlJumpHotkey3,
			&AltJumpHotkey3,
			&ShiftJumpHotkey3,
			&CtrlJumpHotkey4,
			&AltJumpHotkey4,
			&ShiftJumpHotkey4,
			&LastYLine){
	;-------------------------------
	try {
		OptionsMenu.SetIcon("5. Switch &Jumps", IconLib . "\Switch1.ico")
		OptionsMenu.SetIcon("4. Switch &Clicker", IconLib . "\Switch2.ico")
		OptionsMenu.SetIcon("3a. Switch Quick &Access", IconLib . "\Switch2.ico")
		OptionsMenu.SetIcon("2. Switch Con&troller Autorun", IconLib . "\Switch2.ico")
		OptionsMenu.SetIcon("1. Switch &Keyboard Autorun", IconLib . "\Switch2.ico")
	}
	catch {
	}
	SwitchQuickAccess := 0
	SwitchClicker := 0
	SwitchJumps := 1
	SwitchControllerAutoRun := 0
	SwitchKbAutoRun := 0
	
	TaskAutomatorGui.Add("Text", "x05 y10 h20 +0x200", " Verify Num Lock key is ON for Numpad keys ")
	TaskAutomatorGui.Add("GroupBox", "x10 y35 w229 h150", "Jumps")
	TaskAutomatorGui.Add("Text", "x20 y57 w95 h20 +0x200", " Very Short jump")
	TextOnOff2 := TaskAutomatorGui.Add("Text","x120 y57 h20 +0x200", " OFF ")
	TaskAutomatorGui.Add("Text", "x20 y82 w95 h20 +0x200", " Short jump")
	TextOnOff3 := TaskAutomatorGui.Add("Text","x120 y82 h20 +0x200", " OFF ")
	TaskAutomatorGui.Add("Text", "x20 y107 w95 h20 +0x200", " Normal jump")
	TextOnOff4 := TaskAutomatorGui.Add("Text","x120 y107 h20 +0x200", " OFF ")
	TaskAutomatorGui.Add("Text", "x20 y132 w95 h20 +0x200", " Long jump")
	TextOnOff5 := TaskAutomatorGui.Add("Text","x120 y132 h20 +0x200", " OFF ")
	TaskAutomatorGui.Add("Text", "x20 y157 w95 h20 +0x200", " Very Long jump")
	TextOnOff6 := TaskAutomatorGui.Add("Text","x120 y157 h20 +0x200", " OFF ")

	if HotkeyEditMode == true {
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
		
		JumpHotkey0 := TaskAutomatorGui.Add("Hotkey", "vJumpHotkey0 x155 y57 w74 h20", JumpHotkey0).OnEvent("Change", SubmitJumpHotkey0)
		JumpHotkey1 := TaskAutomatorGui.Add("Hotkey", "vJumpHotkey1 x155 y82 w74 h20", JumpHotkey1).OnEvent("Change", SubmitJumpHotkey1)
		JumpHotkey2 := TaskAutomatorGui.Add("Hotkey", "vJumpHotkey2 x155 y107 w74 h20", JumpHotkey2).OnEvent("Change", SubmitJumpHotkey2)
		JumpHotkey3 := TaskAutomatorGui.Add("Hotkey", "vJumpHotkey3 x155 y132 w74 h20", JumpHotkey3).OnEvent("Change", SubmitJumpHotkey3)
		JumpHotkey4 := TaskAutomatorGui.Add("Hotkey", "vJumpHotkey4 x155 y157 w74 h20", JumpHotkey4).OnEvent("Change", SubmitJumpHotkey4)
	} else {
		JumpHotkey0 := TaskAutomatorGui.Add("Hotkey", "vJumpHotkey0 x155 y57 w74 h20 +disabled", JumpHotkey0)
		JumpHotkey1 := TaskAutomatorGui.Add("Hotkey", "vJumpHotkey1 x155 y82 w74 h20 +disabled", JumpHotkey1)
		JumpHotkey2 := TaskAutomatorGui.Add("Hotkey", "vJumpHotkey2 x155 y107 w74 h20 +disabled", JumpHotkey2)
		JumpHotkey3 := TaskAutomatorGui.Add("Hotkey", "vJumpHotkey3 x155 y132 w74 h20 +disabled", JumpHotkey3)
		JumpHotkey4 := TaskAutomatorGui.Add("Hotkey", "vJumpHotkey4 x155 y157 w74 h20 +disabled", JumpHotkey4)
	} ; HotkeyEditMode false end
	
	LastYLine := 167
}
;----------------------------------------------------
; Y-226 / Auto Clicker
;----------------------------------------------------
AutoClickerModule(TaskAutomatorGui,
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
		EditPatternClicker := TaskAutomatorGui.Add("Edit", "vClickInterval x60 y35 w50 h20 +Number")
		EditPatternClickerOffset := TaskAutomatorGui.Add("Edit", "vRandomOffset x190 y35 w50 h20 +Number")
	} else {
		try {
			SettingsMenu.SetIcon("Lock Edit &Boxes && Icons: ON/OFF", IconLib . "\EditBox1.png")
		}
		catch {
		}
		EditPatternClicker := TaskAutomatorGui.Add("Edit", "vClickInterval x60 y35 w50 h20 +Number +Disabled")
		EditPatternClickerOffset := TaskAutomatorGui.Add("Edit", "vRandomOffset x190 y35 w50 h20 +Number +Disabled")
	}
	TextPatternClickInterval := TaskAutomatorGui.Add("Text","x10 y35 h20 +0x200", " Interval ")
	TextPatternClickerOffset := TaskAutomatorGui.Add("Text","x120 y35 h20 +0x200", " Rnd Offset ")
	;----------------------------------------------------
	TextLoop := TaskAutomatorGui.Add("Text","x10 y60 h20 +0x200", " Loop amount: ")
	TaskAutomatorGui.SetFont()
	TaskAutomatorGui.SetFont("Bold " . FontClickerPatternColor . "", MainFontType)
	if EditBoxesAvailable == true {
		EditLoopTimes := TaskAutomatorGui.Add("Edit", "vLoopAmount x98 y60 w70 h20 +Number")
	} else {
		EditLoopTimes := TaskAutomatorGui.Add("Edit", "vLoopAmount x98 y60 w70 h20 +Number +Disabled")
	}
	EditLoopTimes.Opt("" . BackgroundMainColor . "")
	TaskAutomatorGui.SetFont()
	TaskAutomatorGui.SetFont("Bold " . MainFontColor, MainFontType)
	EditLoopTimes.Value := LoopAmount
	
	RadioCountLoopsYes := TaskAutomatorGui.Add("Radio", "x179 y60 h20 +Checked", "Y")
	RadioCountLoopsNo := TaskAutomatorGui.Add("Radio", "x211 y60 w30 h20", "N")
	;----------------------------------------------------
	TextPosX := TaskAutomatorGui.Add("Text","x37 y85 h20 +0x200", " X ")
	TextPosY := TaskAutomatorGui.Add("Text","x84 y85 h20 +0x200", " Y ")
	TextPosInterval := TaskAutomatorGui.Add("Text","x121 y85 h20 +0x200", " Interval ")
	ClearButton := TaskAutomatorGui.Add("Button", "x180 y85 h20", "Clear X,Y")
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
	TaskAutomatorGui.Add("Text","x10 y110 h20 +0x200", "1")
	TaskAutomatorGui.SetFont()
	TaskAutomatorGui.SetFont("Bold " . FontClickerPatternColor . "", MainFontType)
	if EditBoxesAvailable == true {
		Position1.EditPosX := TaskAutomatorGui.Add("Edit", "vCoordX1 x25 y110 w40 h20 +Number")
	} else {
		Position1.EditPosX := TaskAutomatorGui.Add("Edit", "vCoordX1 x25 y110 w40 h20 +Number +Disabled")
	}
	Position1.EditPosX.Opt("" . BackgroundMainColor . "")
	TaskAutomatorGui.SetFont()
	TaskAutomatorGui.SetFont("Bold " . MainFontColor, MainFontType)
	Position1.EditPosX.Value := Position1.CoordX
	;--------------------
	TaskAutomatorGui.SetFont()
	TaskAutomatorGui.SetFont("Bold " . FontClickerPatternColor . "", MainFontType)
	if EditBoxesAvailable == true {
		Position1.EditPosY := TaskAutomatorGui.Add("Edit", "vCoordY1 x73 y110 w40 h20 +Number")
	} else {
		Position1.EditPosY := TaskAutomatorGui.Add("Edit", "vCoordY1 x73 y110 w40 h20 +Number +Disabled")
	}
	
	Position1.EditPosY.Opt("" . BackgroundMainColor . "")
	TaskAutomatorGui.SetFont()
	TaskAutomatorGui.SetFont("Bold " . MainFontColor, MainFontType)
	Position1.EditPosY.Value := Position1.CoordY
	;--------------------
	TaskAutomatorGui.SetFont()
	TaskAutomatorGui.SetFont("Bold " . FontClickerPatternColor . "", MainFontType)
	if EditBoxesAvailable == true {
		Position1.EditInterval := TaskAutomatorGui.Add("Edit", "vCoord1Interval x121 y110 w50 h20 +Number")
	} else {
		Position1.EditInterval := TaskAutomatorGui.Add("Edit", "vCoord1Interval x121 y110 w50 h20 +Number +Disabled")
	}
	Position1.EditInterval.Opt("" . BackgroundMainColor . "")
	TaskAutomatorGui.SetFont()
	TaskAutomatorGui.SetFont("Bold " . MainFontColor, MainFontType)
	Position1.EditInterval.Value := Position1.Interval
	;--------------------
	Position1.EditRadioYes := TaskAutomatorGui.Add("Radio", "vRadio1Yes x179 y110 h20", "Y")
	Position1.EditRadioYes.Value := Position1.RadioYes
	Position1.EditRadioNo := TaskAutomatorGui.Add("Radio", "vRadio1No x211 y110 w30 h20", "N")
	Position1.EditRadioNo.Value := Position1.RadioNo
	;----------------------------------------------------
	; Position 2
	;----------------------------------------------------
	TaskAutomatorGui.Add("Text","x10 y131 h20 +0x200", "2")
	TaskAutomatorGui.SetFont()
	TaskAutomatorGui.SetFont("Bold " . FontClickerPatternColor . "", MainFontType)
	if EditBoxesAvailable == true {
		Position2.EditPosX := TaskAutomatorGui.Add("Edit", "vCoordX2 x25 y131 w40 h20 +Number")
	} else {
		Position2.EditPosX := TaskAutomatorGui.Add("Edit", "vCoordX2 x25 y131 w40 h20 +Number +Disabled")
	}
	Position2.EditPosX.Opt("" . BackgroundMainColor . "")
	TaskAutomatorGui.SetFont()
	TaskAutomatorGui.SetFont("Bold " . MainFontColor, MainFontType)
	Position2.EditPosX.Value := Position2.CoordX
	;--------------------
	TaskAutomatorGui.SetFont()
	TaskAutomatorGui.SetFont("Bold " . FontClickerPatternColor . "", MainFontType)
	if EditBoxesAvailable == true {
		Position2.EditPosY := TaskAutomatorGui.Add("Edit", "vCoordY2 x73 y131 w40 h20 +Number")
	} else {
		Position2.EditPosY := TaskAutomatorGui.Add("Edit", "vCoordY2 x73 y131 w40 h20 +Number +Disabled")
	}
	Position2.EditPosY.Opt("" . BackgroundMainColor . "")
	TaskAutomatorGui.SetFont()
	TaskAutomatorGui.SetFont("Bold " . MainFontColor, MainFontType)
	Position2.EditPosY.Value := Position2.CoordY
	;--------------------
	TaskAutomatorGui.SetFont()
	TaskAutomatorGui.SetFont("Bold " . FontClickerPatternColor . "", MainFontType)
	if EditBoxesAvailable == true {
		Position2.EditInterval := TaskAutomatorGui.Add("Edit", "vCoord2Interval x121 y131 w50 h20 +Number")
	} else {
		Position2.EditInterval := TaskAutomatorGui.Add("Edit", "vCoord2Interval x121 y131 w50 h20 +Number +Disabled")
	}
	Position2.EditInterval.Opt("" . BackgroundMainColor . "")
	TaskAutomatorGui.SetFont()
	TaskAutomatorGui.SetFont("Bold " . MainFontColor, MainFontType)
	Position2.EditInterval.Value := Position2.Interval
	;--------------------
	Position2.EditRadioYes := TaskAutomatorGui.Add("Radio", "vRadio2Yes x179 y131 h20", "Y")
	Position2.EditRadioYes.Value := Position2.RadioYes
	Position2.EditRadioNo := TaskAutomatorGui.Add("Radio", "vRadio2No x211 y131 w30 h20", "N")
	Position2.EditRadioNo.Value := Position2.RadioNo
	;----------------------------------------------------
	; Position 3
	;----------------------------------------------------
	TaskAutomatorGui.Add("Text","x10 y152 h20 +0x200", "3")
	TaskAutomatorGui.SetFont()
	TaskAutomatorGui.SetFont("Bold " . FontClickerPatternColor . "", MainFontType)
	if EditBoxesAvailable == true {
		Position3.EditPosX := TaskAutomatorGui.Add("Edit", "vCoordX3 x25 y152 w40 h20 +Number")
	} else {
		Position3.EditPosX := TaskAutomatorGui.Add("Edit", "vCoordX3 x25 y152 w40 h20 +Number +Disabled")
	}
	Position3.EditPosX.Opt("" . BackgroundMainColor . "")
	TaskAutomatorGui.SetFont()
	TaskAutomatorGui.SetFont("Bold " . MainFontColor, MainFontType)
	Position3.EditPosX.Value := Position3.CoordX
	;--------------------
	TaskAutomatorGui.SetFont()
	TaskAutomatorGui.SetFont("Bold " . FontClickerPatternColor . "", MainFontType)
	if EditBoxesAvailable == true {
		Position3.EditPosY := TaskAutomatorGui.Add("Edit", "vCoordY3 x73 y152 w40 h20 +Number")
	} else {
		Position3.EditPosY := TaskAutomatorGui.Add("Edit", "vCoordY3 x73 y152 w40 h20 +Number +Disabled")
	}
	Position3.EditPosY.Opt("" . BackgroundMainColor . "")
	TaskAutomatorGui.SetFont()
	TaskAutomatorGui.SetFont("Bold " . MainFontColor, MainFontType)
	Position3.EditPosY.Value := Position3.CoordY
	;--------------------
	TaskAutomatorGui.SetFont()
	TaskAutomatorGui.SetFont("Bold " . FontClickerPatternColor . "", MainFontType)
	if EditBoxesAvailable == true {
		Position3.EditInterval := TaskAutomatorGui.Add("Edit", "vCoord3Interval x121 y152 w50 h20 +Number")
	} else {
		Position3.EditInterval := TaskAutomatorGui.Add("Edit", "vCoord3Interval x121 y152 w50 h20 +Number +Disabled")
	}
	Position3.EditInterval.Opt("" . BackgroundMainColor . "")
	TaskAutomatorGui.SetFont()
	TaskAutomatorGui.SetFont("Bold " . MainFontColor, MainFontType)
	Position3.EditInterval.Value := Position3.Interval
	;--------------------
	Position3.EditRadioYes := TaskAutomatorGui.Add("Radio", "vRadio3Yes x179 y152 h20", "Y")
	Position3.EditRadioYes.Value := Position3.RadioYes
	Position3.EditRadioNo := TaskAutomatorGui.Add("Radio", "vRadio3No x211 y152 w30 h20", "N")
	Position3.EditRadioNo.Value := Position3.RadioNo
	;----------------------------------------------------
	; Position 4
	;----------------------------------------------------
	TaskAutomatorGui.Add("Text","x10 y173 h20 +0x200", "4")
	TaskAutomatorGui.SetFont()
	TaskAutomatorGui.SetFont("Bold " . FontClickerPatternColor . "", MainFontType)
	if EditBoxesAvailable == true {
		Position4.EditPosX := TaskAutomatorGui.Add("Edit", "vCoordX4 x25 y173 w40 h20 +Number")
	} else {
		Position4.EditPosX := TaskAutomatorGui.Add("Edit", "vCoordX4 x25 y173 w40 h20 +Number +Disabled")
	}
	Position4.EditPosX.Opt("" . BackgroundMainColor . "")
	TaskAutomatorGui.SetFont()
	TaskAutomatorGui.SetFont("Bold " . MainFontColor, MainFontType)
	Position4.EditPosX.Value := Position4.CoordX
	;--------------------
	TaskAutomatorGui.SetFont()
	TaskAutomatorGui.SetFont("Bold " . FontClickerPatternColor . "", MainFontType)
	if EditBoxesAvailable == true {
		Position4.EditPosY := TaskAutomatorGui.Add("Edit", "vCoordY4 x73 y173 w40 h20 +Number")
	} else {
		Position4.EditPosY := TaskAutomatorGui.Add("Edit", "vCoordY4 x73 y173 w40 h20 +Number +Disabled")
	}
	Position4.EditPosY.Opt("" . BackgroundMainColor . "")
	TaskAutomatorGui.SetFont()
	TaskAutomatorGui.SetFont("Bold " . MainFontColor, MainFontType)
	Position4.EditPosY.Value := Position4.CoordY
	;--------------------
	TaskAutomatorGui.SetFont()
	TaskAutomatorGui.SetFont("Bold " . FontClickerPatternColor . "", MainFontType)
	if EditBoxesAvailable == true {
		Position4.EditInterval := TaskAutomatorGui.Add("Edit", "vCoord4Interval x121 y173 w50 h20 +Number")
	} else {
		Position4.EditInterval := TaskAutomatorGui.Add("Edit", "vCoord4Interval x121 y173 w50 h20 +Number +Disabled")
	}
	Position4.EditInterval.Opt("" . BackgroundMainColor . "")
	TaskAutomatorGui.SetFont()
	TaskAutomatorGui.SetFont("Bold " . MainFontColor, MainFontType)
	Position4.EditInterval.Value := Position4.Interval
	;--------------------
	Position4.EditRadioYes := TaskAutomatorGui.Add("Radio", "vRadio4Yes x179 y173 h20", "Y")
	Position4.EditRadioYes.Value := Position4.RadioYes
	Position4.EditRadioNo := TaskAutomatorGui.Add("Radio", "vRadio4No x211 y173 w30 h20", "N")
	Position4.EditRadioNo.Value := Position4.RadioNo
	;----------------------------------------------------
	; Position 5
	;----------------------------------------------------
	TaskAutomatorGui.Add("Text","x10 y194 h20 +0x200", "5")
	TaskAutomatorGui.SetFont()
	TaskAutomatorGui.SetFont("Bold " . FontClickerPatternColor . "", MainFontType)
	if EditBoxesAvailable == true {
		Position5.EditPosX := TaskAutomatorGui.Add("Edit", "vCoordX5 x25 y194 w40 h20 +Number")
	} else {
		Position5.EditPosX := TaskAutomatorGui.Add("Edit", "vCoordX5 x25 y194 w40 h20 +Number +Disabled")
	}
	Position5.EditPosX.Opt("" . BackgroundMainColor . "")
	TaskAutomatorGui.SetFont()
	TaskAutomatorGui.SetFont("Bold " . MainFontColor, MainFontType)
	Position5.EditPosX.Value := Position5.CoordX
	;--------------------
	TaskAutomatorGui.SetFont()
	TaskAutomatorGui.SetFont("Bold " . FontClickerPatternColor . "", MainFontType)
	if EditBoxesAvailable == true {
		Position5.EditPosY := TaskAutomatorGui.Add("Edit", "vCoordY5 x73 y194 w40 h20 +Number")
	} else {
		Position5.EditPosY := TaskAutomatorGui.Add("Edit", "vCoordY5 x73 y194 w40 h20 +Number +Disabled")
	}
	Position5.EditPosY.Opt("" . BackgroundMainColor . "")
	TaskAutomatorGui.SetFont()
	TaskAutomatorGui.SetFont("Bold " . MainFontColor, MainFontType)
	Position5.EditPosY.Value := Position5.CoordY
	;--------------------
	TaskAutomatorGui.SetFont()
	TaskAutomatorGui.SetFont("Bold " . FontClickerPatternColor . "", MainFontType)
	if EditBoxesAvailable == true {
		Position5.EditInterval := TaskAutomatorGui.Add("Edit", "vCoord5Interval x121 y194 w50 h20 +Number")
	} else {
		Position5.EditInterval := TaskAutomatorGui.Add("Edit", "vCoord5Interval x121 y194 w50 h20 +Number +Disabled")
	}
	Position5.EditInterval.Opt("" . BackgroundMainColor . "")
	TaskAutomatorGui.SetFont()
	TaskAutomatorGui.SetFont("Bold " . MainFontColor, MainFontType)
	Position5.EditInterval.Value := Position5.Interval
	;--------------------
	Position5.EditRadioYes := TaskAutomatorGui.Add("Radio", "vRadio5Yes x179 y194 h20", "Y")
	Position5.EditRadioYes.Value := Position5.RadioYes
	Position5.EditRadioNo := TaskAutomatorGui.Add("Radio", "vRadio5No x211 y194 w30 h20", "N")
	Position5.EditRadioNo.Value := Position5.RadioNo
	;----------------------------------------------------
	; Position 6
	;----------------------------------------------------
	TaskAutomatorGui.Add("Text","x10 y215 h20 +0x200", "6")
	TaskAutomatorGui.SetFont()
	TaskAutomatorGui.SetFont("Bold " . FontClickerPatternColor . "", MainFontType)
	if EditBoxesAvailable == true {
		Position6.EditPosX := TaskAutomatorGui.Add("Edit", "vCoordX6 x25 y215 w40 h20 +Number")
	} else {
		Position6.EditPosX := TaskAutomatorGui.Add("Edit", "vCoordX6 x25 y215 w40 h20 +Number +Disabled")
	}
	Position6.EditPosX.Opt("" . BackgroundMainColor . "")
	TaskAutomatorGui.SetFont()
	TaskAutomatorGui.SetFont("Bold " . MainFontColor, MainFontType)
	Position6.EditPosX.Value := Position6.CoordX
	;--------------------
	TaskAutomatorGui.SetFont()
	TaskAutomatorGui.SetFont("Bold " . FontClickerPatternColor . "", MainFontType)
	if EditBoxesAvailable == true {
		Position6.EditPosY := TaskAutomatorGui.Add("Edit", "vCoordY6 x73 y215 w40 h20 +Number")
	} else {
		Position6.EditPosY := TaskAutomatorGui.Add("Edit", "vCoordY6 x73 y215 w40 h20 +Number +Disabled")
	}
	Position6.EditPosY.Opt("" . BackgroundMainColor . "")
	TaskAutomatorGui.SetFont()
	TaskAutomatorGui.SetFont("Bold " . MainFontColor, MainFontType)
	Position6.EditPosY.Value := Position6.CoordY
	;--------------------
	TaskAutomatorGui.SetFont()
	TaskAutomatorGui.SetFont("Bold " . FontClickerPatternColor . "", MainFontType)
	if EditBoxesAvailable == true {
		Position6.EditInterval := TaskAutomatorGui.Add("Edit", "vCoord6Interval x121 y215 w50 h20 +Number")
	} else {
		Position6.EditInterval := TaskAutomatorGui.Add("Edit", "vCoord6Interval x121 y215 w50 h20 +Number +Disabled")
	}
	Position6.EditInterval.Opt("" . BackgroundMainColor . "")
	TaskAutomatorGui.SetFont()
	TaskAutomatorGui.SetFont("Bold " . MainFontColor, MainFontType)
	Position6.EditInterval.Value := Position6.Interval
	;--------------------;--------------------
	Position6.EditRadioYes := TaskAutomatorGui.Add("Radio", "vRadio6Yes x179 y215 h20", "Y")
	Position6.EditRadioYes.Value := Position6.RadioYes
	Position6.EditRadioNo := TaskAutomatorGui.Add("Radio", "vRadio6No x211 y215 w30 h20", "N")
	Position6.EditRadioNo.Value := Position6.RadioNo
	;----------------------------------------------------
	; Position 7
	;----------------------------------------------------
	TaskAutomatorGui.Add("Text","x10 y236 h20 +0x200", "7")
	TaskAutomatorGui.SetFont()
	TaskAutomatorGui.SetFont("Bold " . FontClickerPatternColor . "", MainFontType)
	if EditBoxesAvailable == true {
		Position7.EditPosX := TaskAutomatorGui.Add("Edit", "vCoordX7 x25 y236 w40 h20 +Number")
	} else {
		Position7.EditPosX := TaskAutomatorGui.Add("Edit", "vCoordX7 x25 y236 w40 h20 +Number +Disabled")
	}
	Position7.EditPosX.Opt("" . BackgroundMainColor . "")
	TaskAutomatorGui.SetFont()
	TaskAutomatorGui.SetFont("Bold " . MainFontColor, MainFontType)
	Position7.EditPosX.Value := Position7.CoordX
	;--------------------
	TaskAutomatorGui.SetFont()
	TaskAutomatorGui.SetFont("Bold " . FontClickerPatternColor . "", MainFontType)
	if EditBoxesAvailable == true {
		Position7.EditPosY := TaskAutomatorGui.Add("Edit", "vCoordY7 x73 y236 w40 h20 +Number")
	} else {
		Position7.EditPosY := TaskAutomatorGui.Add("Edit", "vCoordY7 x73 y236 w40 h20 +Number +Disabled")
	}
	Position7.EditPosY.Opt("" . BackgroundMainColor . "")
	TaskAutomatorGui.SetFont()
	TaskAutomatorGui.SetFont("Bold " . MainFontColor, MainFontType)
	Position7.EditPosY.Value := Position7.CoordY
	;--------------------
	TaskAutomatorGui.SetFont()
	TaskAutomatorGui.SetFont("Bold " . FontClickerPatternColor . "", MainFontType)
	if EditBoxesAvailable == true {
		Position7.EditInterval := TaskAutomatorGui.Add("Edit", "vCoord7Interval x121 y236 w50 h20 +Number")
	} else {
		Position7.EditInterval := TaskAutomatorGui.Add("Edit", "vCoord7Interval x121 y236 w50 h20 +Number +Disabled")
	}
	Position7.EditInterval.Opt("" . BackgroundMainColor . "")
	TaskAutomatorGui.SetFont()
	TaskAutomatorGui.SetFont("Bold " . MainFontColor, MainFontType)
	Position7.EditInterval.Value := Position7.Interval
	;--------------------
	Position7.EditRadioYes := TaskAutomatorGui.Add("Radio", "vRadio7Yes x179 y236 h20", "Y")
	Position7.EditRadioYes.Value := Position7.RadioYes
	Position7.EditRadioNo := TaskAutomatorGui.Add("Radio", "vRadio7No x211 y236 w30 h20", "N")
	Position7.EditRadioNo.Value := Position7.RadioNo
	;----------------------------------------------------
	; Position 8
	;----------------------------------------------------
	TaskAutomatorGui.Add("Text","x10 y257 h20 +0x200", "8")
	TaskAutomatorGui.SetFont()
	TaskAutomatorGui.SetFont("Bold " . FontClickerPatternColor . "", MainFontType)
	if EditBoxesAvailable == true {
		Position8.EditPosX := TaskAutomatorGui.Add("Edit", "vCoordX8 x25 y257 w40 h20 +Number")
	} else {
		Position8.EditPosX := TaskAutomatorGui.Add("Edit", "vCoordX8 x25 y257 w40 h20 +Number +Disabled")
	}
	Position8.EditPosX.Opt("" . BackgroundMainColor . "")
	TaskAutomatorGui.SetFont()
	TaskAutomatorGui.SetFont("Bold " . MainFontColor, MainFontType)
	Position8.EditPosX.Value := Position8.CoordX
	;--------------------
	TaskAutomatorGui.SetFont()
	TaskAutomatorGui.SetFont("Bold " . FontClickerPatternColor . "", MainFontType)
	if EditBoxesAvailable == true {
		Position8.EditPosY := TaskAutomatorGui.Add("Edit", "vCoordY8 x73 y257 w40 h20 +Number")
	} else {
		Position8.EditPosY := TaskAutomatorGui.Add("Edit", "vCoordY8 x73 y257 w40 h20 +Number +Disabled")
	}
	Position8.EditPosY.Opt("" . BackgroundMainColor . "")
	TaskAutomatorGui.SetFont()
	TaskAutomatorGui.SetFont("Bold " . MainFontColor, MainFontType)
	Position8.EditPosY.Value := Position8.CoordY
	;--------------------
	TaskAutomatorGui.SetFont()
	TaskAutomatorGui.SetFont("Bold " . FontClickerPatternColor . "", MainFontType)
	if EditBoxesAvailable == true {
		Position8.EditInterval := TaskAutomatorGui.Add("Edit", "vCoord8Interval x121 y257 w50 h20 +Number")
	} else {
		Position8.EditInterval := TaskAutomatorGui.Add("Edit", "vCoord8Interval x121 y257 w50 h20 +Number +Disabled")
	}
	Position8.EditInterval.Opt("" . BackgroundMainColor . "")
	TaskAutomatorGui.SetFont()
	TaskAutomatorGui.SetFont("Bold " . MainFontColor, MainFontType)
	Position8.EditInterval.Value := Position8.Interval
	;--------------------
	Position8.EditRadioYes := TaskAutomatorGui.Add("Radio", "vRadio8Yes x179 y257 h20", "Y")
	Position8.EditRadioYes.Value := Position8.RadioYes
	Position8.EditRadioNo := TaskAutomatorGui.Add("Radio", "vRadio8No x211 y257 w30 h20", "N")
	Position8.EditRadioNo.Value := Position8.RadioNo
	;----------------------------------------------------
	; Position 9
	;----------------------------------------------------
	TaskAutomatorGui.Add("Text","x10 y278 h20 +0x200", "9")
	TaskAutomatorGui.SetFont()
	TaskAutomatorGui.SetFont("Bold " . FontClickerPatternColor . "", MainFontType)
	if EditBoxesAvailable == true {
		Position9.EditPosX := TaskAutomatorGui.Add("Edit", "vCoordX9 x25 y278 w40 h20 +Number")
	} else {
		Position9.EditPosX := TaskAutomatorGui.Add("Edit", "vCoordX9 x25 y278 w40 h20 +Number +Disabled")
	}
	Position9.EditPosX.Opt("" . BackgroundMainColor . "")
	TaskAutomatorGui.SetFont()
	TaskAutomatorGui.SetFont("Bold " . MainFontColor, MainFontType)
	Position9.EditPosX.Value := Position9.CoordX
	;--------------------
	TaskAutomatorGui.SetFont()
	TaskAutomatorGui.SetFont("Bold " . FontClickerPatternColor . "", MainFontType)
	if EditBoxesAvailable == true {
		Position9.EditPosY := TaskAutomatorGui.Add("Edit", "vCoordY9 x73 y278 w40 h20 +Number")
	} else {
		Position9.EditPosY := TaskAutomatorGui.Add("Edit", "vCoordY9 x73 y278 w40 h20 +Number +Disabled")
	}
	Position9.EditPosY.Opt("" . BackgroundMainColor . "")
	TaskAutomatorGui.SetFont()
	TaskAutomatorGui.SetFont("Bold " . MainFontColor, MainFontType)
	Position9.EditPosY.Value := Position9.CoordY
	;--------------------
	TaskAutomatorGui.SetFont()
	TaskAutomatorGui.SetFont("Bold " . FontClickerPatternColor . "", MainFontType)
	if EditBoxesAvailable == true {
		Position9.EditInterval := TaskAutomatorGui.Add("Edit", "vCoord9Interval x121 y278 w50 h20 +Number")
	} else {
		Position9.EditInterval := TaskAutomatorGui.Add("Edit", "vCoord9Interval x121 y278 w50 h20 +Number +Disabled")
	}
	Position9.EditInterval.Opt("" . BackgroundMainColor . "")
	TaskAutomatorGui.SetFont()
	TaskAutomatorGui.SetFont("Bold " . MainFontColor, MainFontType)
	Position9.EditInterval.Value := Position9.Interval
	;--------------------
	Position9.EditRadioYes := TaskAutomatorGui.Add("Radio", "vRadio9Yes x179 y278 h20", "Y")
	Position9.EditRadioYes.Value := Position9.RadioYes
	Position9.EditRadioNo := TaskAutomatorGui.Add("Radio", "vRadio9No x211 y278 w30 h20", "N")
	Position9.EditRadioNo.Value := Position9.RadioNo
	;----------------------------------------------------
	; Position 10
	;----------------------------------------------------
	TaskAutomatorGui.Add("Text","x7 y299 h20 +0x200", "10")
	TaskAutomatorGui.SetFont()
	TaskAutomatorGui.SetFont("Bold " . FontClickerPatternColor . "", MainFontType)
	if EditBoxesAvailable == true {
		Position10.EditPosX := TaskAutomatorGui.Add("Edit", "vCoordX10 x25 y299 w40 h20 +Number")
	} else {
		Position10.EditPosX := TaskAutomatorGui.Add("Edit", "vCoordX10 x25 y299 w40 h20 +Number +Disabled")
	}
	Position10.EditPosX.Opt("" . BackgroundMainColor . "")
	TaskAutomatorGui.SetFont()
	TaskAutomatorGui.SetFont("Bold " . MainFontColor, MainFontType)
	Position10.EditPosX.Value := Position10.CoordX
	;--------------------
	TaskAutomatorGui.SetFont()
	TaskAutomatorGui.SetFont("Bold " . FontClickerPatternColor . "", MainFontType)
	if EditBoxesAvailable == true {
		Position10.EditPosY := TaskAutomatorGui.Add("Edit", "vCoordY10 x73 y299 w40 h20 +Number")
	} else {
		Position10.EditPosY := TaskAutomatorGui.Add("Edit", "vCoordY10 x73 y299 w40 h20 +Number +Disabled")
	}
	Position10.EditPosY.Opt("" . BackgroundMainColor . "")
	TaskAutomatorGui.SetFont()
	TaskAutomatorGui.SetFont("Bold " . MainFontColor, MainFontType)
	Position10.EditPosY.Value := Position10.CoordY
	;--------------------
	TaskAutomatorGui.SetFont()
	TaskAutomatorGui.SetFont("Bold " . FontClickerPatternColor . "", MainFontType)
	if EditBoxesAvailable == true {
		Position10.EditInterval := TaskAutomatorGui.Add("Edit", "vCoord10Interval x121 y299 w50 h20 +Number")
	} else {
		Position10.EditInterval := TaskAutomatorGui.Add("Edit", "vCoord10Interval x121 y299 w50 h20 +Number +Disabled")
	}
	Position10.EditInterval.Opt("" . BackgroundMainColor . "")
	TaskAutomatorGui.SetFont()
	TaskAutomatorGui.SetFont("Bold " . MainFontColor, MainFontType)
	Position10.EditInterval.Value := Position10.Interval
	;--------------------
	Position10.EditRadioYes := TaskAutomatorGui.Add("Radio", "vRadio10Yes x179 y299 h20", "Y")
	Position10.EditRadioYes.Value := Position10.RadioYes
	Position10.EditRadioNo := TaskAutomatorGui.Add("Radio", "vRadio10No x211 y299 w30 h20", "N")
	Position10.EditRadioNo.Value := Position10.RadioNo
	;----------------------------------------------------
	; Position 11
	;----------------------------------------------------
	TaskAutomatorGui.Add("Text","x7 y318 h20 +0x200", "11")
	TaskAutomatorGui.SetFont()
	TaskAutomatorGui.SetFont("Bold " . FontClickerPatternColor . "", MainFontType)
	if EditBoxesAvailable == true {
		Position11.EditPosX := TaskAutomatorGui.Add("Edit", "vCoordX11 x25 y318 w40 h20 +Number")
	} else {
		Position11.EditPosX := TaskAutomatorGui.Add("Edit", "vCoordX11 x25 y318 w40 h20 +Number +Disabled")
	}
	Position11.EditPosX.Opt("" . BackgroundMainColor . "")
	TaskAutomatorGui.SetFont()
	TaskAutomatorGui.SetFont("Bold " . MainFontColor, MainFontType)
	Position11.EditPosX.Value := Position11.CoordX
	;--------------------
	TaskAutomatorGui.SetFont()
	TaskAutomatorGui.SetFont("Bold " . FontClickerPatternColor . "", MainFontType)
	if EditBoxesAvailable == true {
		Position11.EditPosY := TaskAutomatorGui.Add("Edit", "vCoordY11 x73 y318 w40 h20 +Number")
	} else {
		Position11.EditPosY := TaskAutomatorGui.Add("Edit", "vCoordY11 x73 y318 w40 h20 +Number +Disabled")
	}
	Position11.EditPosY.Opt("" . BackgroundMainColor . "")
	TaskAutomatorGui.SetFont()
	TaskAutomatorGui.SetFont("Bold " . MainFontColor, MainFontType)
	Position11.EditPosY.Value := Position11.CoordY
	;--------------------
	TaskAutomatorGui.SetFont()
	TaskAutomatorGui.SetFont("Bold " . FontClickerPatternColor . "", MainFontType)
	if EditBoxesAvailable == true {
		Position11.EditInterval := TaskAutomatorGui.Add("Edit", "vCoord11Interval x121 y318 w50 h20 +Number")
	} else {
		Position11.EditInterval := TaskAutomatorGui.Add("Edit", "vCoord11Interval x121 y318 w50 h20 +Number +Disabled")
	}
	Position11.EditInterval.Opt("" . BackgroundMainColor . "")
	TaskAutomatorGui.SetFont()
	TaskAutomatorGui.SetFont("Bold " . MainFontColor, MainFontType)
	Position11.EditInterval.Value := Position11.Interval
	;--------------------
	Position11.EditRadioYes := TaskAutomatorGui.Add("Radio", "vRadio11Yes x179 y318 h20", "Y")
	Position11.EditRadioYes.Value := Position11.RadioYes
	Position11.EditRadioNo := TaskAutomatorGui.Add("Radio", "vRadio11No x211 y318 w30 h20", "N")
	Position11.EditRadioNo.Value := Position11.RadioNo
	;----------------------------------------------------
	; Position 12
	;----------------------------------------------------
	TaskAutomatorGui.Add("Text","x7 y339 h20 +0x200", "12")
	TaskAutomatorGui.SetFont()
	TaskAutomatorGui.SetFont("Bold " . FontClickerPatternColor . "", MainFontType)
	if EditBoxesAvailable == true {
		Position12.EditPosX := TaskAutomatorGui.Add("Edit", "vCoordX12 x25 y339 w40 h20 +Number")
	} else {
		Position12.EditPosX := TaskAutomatorGui.Add("Edit", "vCoordX12 x25 y339 w40 h20 +Number +Disabled")
	}
	Position12.EditPosX.Opt("" . BackgroundMainColor . "")
	TaskAutomatorGui.SetFont()
	TaskAutomatorGui.SetFont("Bold " . MainFontColor, MainFontType)
	Position12.EditPosX.Value := Position12.CoordX
	;--------------------
	TaskAutomatorGui.SetFont()
	TaskAutomatorGui.SetFont("Bold " . FontClickerPatternColor . "", MainFontType)
	if EditBoxesAvailable == true {
		Position12.EditPosY := TaskAutomatorGui.Add("Edit", "vCoordY12 x73 y339 w40 h20 +Number")
	} else {
		Position12.EditPosY := TaskAutomatorGui.Add("Edit", "vCoordY12 x73 y339 w40 h20 +Number +Disabled")
	}
	Position12.EditPosY.Opt("" . BackgroundMainColor . "")
	TaskAutomatorGui.SetFont()
	TaskAutomatorGui.SetFont("Bold " . MainFontColor, MainFontType)
	Position12.EditPosY.Value := Position12.CoordY
	;--------------------
	TaskAutomatorGui.SetFont()
	TaskAutomatorGui.SetFont("Bold " . FontClickerPatternColor . "", MainFontType)
	if EditBoxesAvailable == true {
		Position12.EditInterval := TaskAutomatorGui.Add("Edit", "vCoord12Interval x121 y339 w50 h20 +Number")
	} else {
		Position12.EditInterval := TaskAutomatorGui.Add("Edit", "vCoord12Interval x121 y339 w50 h20 +Number +Disabled")
	}
	Position12.EditInterval.Opt("" . BackgroundMainColor . "")
	TaskAutomatorGui.SetFont()
	TaskAutomatorGui.SetFont("Bold " . MainFontColor, MainFontType)
	Position12.EditInterval.Value := Position12.Interval
	;--------------------
	Position12.EditRadioYes := TaskAutomatorGui.Add("Radio", "vRadio12Yes x179 y339 h20", "Y")
	Position12.EditRadioYes.Value := Position12.RadioYes
	Position12.EditRadioNo := TaskAutomatorGui.Add("Radio", "vRadio12No x211 y339 w30 h20", "N")
	Position12.EditRadioNo.Value := Position12.RadioNo
	;----------------------------------------------------
	; Position 13
	;----------------------------------------------------
	TaskAutomatorGui.Add("Text","x7 y360 h20 +0x200", "13")
	TaskAutomatorGui.SetFont()
	TaskAutomatorGui.SetFont("Bold " . FontClickerPatternColor . "", MainFontType)
	if EditBoxesAvailable == true {
		Position13.EditPosX := TaskAutomatorGui.Add("Edit", "vCoordX13 x25 y360 w40 h20 +Number")
	} else {
		Position13.EditPosX := TaskAutomatorGui.Add("Edit", "vCoordX13 x25 y360 w40 h20 +Number +Disabled")
	}
	Position13.EditPosX.Opt("" . BackgroundMainColor . "")
	TaskAutomatorGui.SetFont()
	TaskAutomatorGui.SetFont("Bold " . MainFontColor, MainFontType)
	Position13.EditPosX.Value := Position13.CoordX
	;--------------------
	TaskAutomatorGui.SetFont()
	TaskAutomatorGui.SetFont("Bold " . FontClickerPatternColor . "", MainFontType)
	if EditBoxesAvailable == true {
		Position13.EditPosY := TaskAutomatorGui.Add("Edit", "vCoordY13 x73 y360 w40 h20 +Number")
	} else {
		Position13.EditPosY := TaskAutomatorGui.Add("Edit", "vCoordY13 x73 y360 w40 h20 +Number +Disabled")
	}
	Position13.EditPosY.Opt("" . BackgroundMainColor . "")
	TaskAutomatorGui.SetFont()
	TaskAutomatorGui.SetFont("Bold " . MainFontColor, MainFontType)
	Position13.EditPosY.Value := Position13.CoordY
	;--------------------
	TaskAutomatorGui.SetFont()
	TaskAutomatorGui.SetFont("Bold " . FontClickerPatternColor . "", MainFontType)
	if EditBoxesAvailable == true {
		Position13.EditInterval := TaskAutomatorGui.Add("Edit", "vCoord13Interval x121 y360 w50 h20 +Number")
	} else {
		Position13.EditInterval := TaskAutomatorGui.Add("Edit", "vCoord13Interval x121 y360 w50 h20 +Number +Disabled")
	}
	Position13.EditInterval.Opt("" . BackgroundMainColor . "")
	TaskAutomatorGui.SetFont()
	TaskAutomatorGui.SetFont("Bold " . MainFontColor, MainFontType)
	Position13.EditInterval.Value := Position13.Interval
	;--------------------
	Position13.EditRadioYes := TaskAutomatorGui.Add("Radio", "vRadio13Yes x179 y360 h20", "Y")
	Position13.EditRadioYes.Value := Position13.RadioYes
	Position13.EditRadioNo := TaskAutomatorGui.Add("Radio", "vRadio13No x211 y360 w30 h20", "N")
	Position13.EditRadioNo.Value := Position13.RadioNo
	;----------------------------------------------------
	; Position 14
	;----------------------------------------------------
	TaskAutomatorGui.Add("Text","x7 y381 h20 +0x200", "14")
	TaskAutomatorGui.SetFont()
	TaskAutomatorGui.SetFont("Bold " . FontClickerPatternColor . "", MainFontType)
	if EditBoxesAvailable == true {
		Position14.EditPosX := TaskAutomatorGui.Add("Edit", "vCoordX14 x25 y381 w40 h20 +Number")
	} else {
		Position14.EditPosX := TaskAutomatorGui.Add("Edit", "vCoordX14 x25 y381 w40 h20 +Number +Disabled")
	}
	Position14.EditPosX.Opt("" . BackgroundMainColor . "")
	TaskAutomatorGui.SetFont()
	TaskAutomatorGui.SetFont("Bold " . MainFontColor, MainFontType)
	Position14.EditPosX.Value := Position14.CoordX
	;--------------------
	TaskAutomatorGui.SetFont()
	TaskAutomatorGui.SetFont("Bold " . FontClickerPatternColor . "", MainFontType)
	if EditBoxesAvailable == true {
		Position14.EditPosY := TaskAutomatorGui.Add("Edit", "vCoordY14 x73 y381 w40 h20 +Number")
	} else {
		Position14.EditPosY := TaskAutomatorGui.Add("Edit", "vCoordY14 x73 y381 w40 h20 +Number +Disabled")
	}
	Position14.EditPosY.Opt("" . BackgroundMainColor . "")
	TaskAutomatorGui.SetFont()
	TaskAutomatorGui.SetFont("Bold " . MainFontColor, MainFontType)
	Position14.EditPosY.Value := Position14.CoordY
	;--------------------
	TaskAutomatorGui.SetFont()
	TaskAutomatorGui.SetFont("Bold " . FontClickerPatternColor . "", MainFontType)
	if EditBoxesAvailable == true {
		Position14.EditInterval := TaskAutomatorGui.Add("Edit", "vCoord14Interval x121 y381 w50 h20 +Number")
	} else {
		Position14.EditInterval := TaskAutomatorGui.Add("Edit", "vCoord14Interval x121 y381 w50 h20 +Number +Disabled")
	}
	Position14.EditInterval.Opt("" . BackgroundMainColor . "")
	TaskAutomatorGui.SetFont()
	TaskAutomatorGui.SetFont("Bold " . MainFontColor, MainFontType)
	Position14.EditInterval.Value := Position14.Interval
	;--------------------
	Position14.EditRadioYes := TaskAutomatorGui.Add("Radio", "vRadio14Yes x179 y381 h20", "Y")
	Position14.EditRadioYes.Value := Position14.RadioYes
	Position14.EditRadioNo := TaskAutomatorGui.Add("Radio", "vRadio14No x211 y381 w30 h20", "N")
	Position14.EditRadioNo.Value := Position14.RadioNo
	;----------------------------------------------------
	; Position 15
	;----------------------------------------------------
	TaskAutomatorGui.Add("Text","x7 y402 h20 +0x200", "15")
	TaskAutomatorGui.SetFont()
	TaskAutomatorGui.SetFont("Bold " . FontClickerPatternColor . "", MainFontType)
	if EditBoxesAvailable == true {
		Position15.EditPosX := TaskAutomatorGui.Add("Edit", "vCoordX15 x25 y402 w40 h20 +Number")
	} else {
		Position15.EditPosX := TaskAutomatorGui.Add("Edit", "vCoordX15 x25 y402 w40 h20 +Number +Disabled")
	}
	Position15.EditPosX.Opt("" . BackgroundMainColor . "")
	TaskAutomatorGui.SetFont()
	TaskAutomatorGui.SetFont("Bold " . MainFontColor, MainFontType)
	Position15.EditPosX.Value := Position15.CoordX
	;--------------------
	TaskAutomatorGui.SetFont()
	TaskAutomatorGui.SetFont("Bold " . FontClickerPatternColor . "", MainFontType)
	if EditBoxesAvailable == true {
		Position15.EditPosY := TaskAutomatorGui.Add("Edit", "vCoordY15 x73 y402 w40 h20 +Number")
	} else {
		Position15.EditPosY := TaskAutomatorGui.Add("Edit", "vCoordY15 x73 y402 w40 h20 +Number +Disabled")
	}
	Position15.EditPosY.Opt("" . BackgroundMainColor . "")
	TaskAutomatorGui.SetFont()
	TaskAutomatorGui.SetFont("Bold " . MainFontColor, MainFontType)
	Position15.EditPosY.Value := Position15.CoordY
	;--------------------
	TaskAutomatorGui.SetFont()
	TaskAutomatorGui.SetFont("Bold " . FontClickerPatternColor . "", MainFontType)
	if EditBoxesAvailable == true {
		Position15.EditInterval := TaskAutomatorGui.Add("Edit", "vCoord15Interval x121 y402 w50 h20 +Number")
	} else {
		Position15.EditInterval := TaskAutomatorGui.Add("Edit", "vCoord15Interval x121 y402 w50 h20 +Number +Disabled")
	}
	Position15.EditInterval.Opt("" . BackgroundMainColor . "")
	TaskAutomatorGui.SetFont()
	TaskAutomatorGui.SetFont("Bold " . MainFontColor, MainFontType)
	Position15.EditInterval.Value := Position15.Interval
	;--------------------
	Position15.EditRadioYes := TaskAutomatorGui.Add("Radio", "vRadio15Yes x179 y402 h20", "Y")
	Position15.EditRadioYes.Value := Position15.RadioYes
	Position15.EditRadioNo := TaskAutomatorGui.Add("Radio", "vRadio15No x211 y402 w30 h20", "N")
	Position15.EditRadioNo.Value := Position15.RadioNo
	;----------------------------------------------------
	; Position 16
	;----------------------------------------------------
	TaskAutomatorGui.Add("Text","x7 y423 h20 +0x200", "16")
	TaskAutomatorGui.SetFont()
	TaskAutomatorGui.SetFont("Bold " . FontClickerPatternColor . "", MainFontType)
	if EditBoxesAvailable == true {
		Position16.EditPosX := TaskAutomatorGui.Add("Edit", "vCoordX16 x25 y423 w40 h20 +Number")
	} else {
		Position16.EditPosX := TaskAutomatorGui.Add("Edit", "vCoordX16 x25 y423 w40 h20 +Number +Disabled")
	}
	Position16.EditPosX.Opt("" . BackgroundMainColor . "")
	TaskAutomatorGui.SetFont()
	TaskAutomatorGui.SetFont("Bold " . MainFontColor, MainFontType)
	Position16.EditPosX.Value := Position16.CoordX
	;--------------------
	TaskAutomatorGui.SetFont()
	TaskAutomatorGui.SetFont("Bold " . FontClickerPatternColor . "", MainFontType)
	if EditBoxesAvailable == true {
		Position16.EditPosY := TaskAutomatorGui.Add("Edit", "vCoordY16 x73 y423 w40 h20 +Number")
	} else {
		Position16.EditPosY := TaskAutomatorGui.Add("Edit", "vCoordY16 x73 y423 w40 h20 +Number +Disabled")
	}
	Position16.EditPosY.Opt("" . BackgroundMainColor . "")
	TaskAutomatorGui.SetFont()
	TaskAutomatorGui.SetFont("Bold " . MainFontColor, MainFontType)
	Position16.EditPosY.Value := Position16.CoordY
	;--------------------
	TaskAutomatorGui.SetFont()
	TaskAutomatorGui.SetFont("Bold " . FontClickerPatternColor . "", MainFontType)
	if EditBoxesAvailable == true {
		Position16.EditInterval := TaskAutomatorGui.Add("Edit", "vCoord16Interval x121 y423 w50 h20 +Number")
	} else {
		Position16.EditInterval := TaskAutomatorGui.Add("Edit", "vCoord16Interval x121 y423 w50 h20 +Number +Disabled")
	}
	Position16.EditInterval.Opt("" . BackgroundMainColor . "")
	TaskAutomatorGui.SetFont()
	TaskAutomatorGui.SetFont("Bold " . MainFontColor, MainFontType)
	Position16.EditInterval.Value := Position16.Interval
	;--------------------
	Position16.EditRadioYes := TaskAutomatorGui.Add("Radio", "vRadio16Yes x179 y423 h20", "Y")
	Position16.EditRadioYes.Value := Position16.RadioYes
	Position16.EditRadioNo := TaskAutomatorGui.Add("Radio", "vRadio16No x211 y423 w30 h20", "N")
	Position16.EditRadioNo.Value := Position16.RadioNo
	;----------------------------------------------------
	; Position 17
	;----------------------------------------------------
	TaskAutomatorGui.Add("Text","x7 y444 h20 +0x200", "17")
	TaskAutomatorGui.SetFont()
	TaskAutomatorGui.SetFont("Bold " . FontClickerPatternColor . "", MainFontType)
	if EditBoxesAvailable == true {
		Position17.EditPosX := TaskAutomatorGui.Add("Edit", "vCoordX17 x25 y444 w40 h20 +Number")
	} else {
		Position17.EditPosX := TaskAutomatorGui.Add("Edit", "vCoordX17 x25 y444 w40 h20 +Number +Disabled")
	}
	Position17.EditPosX.Opt("" . BackgroundMainColor . "")
	TaskAutomatorGui.SetFont()
	TaskAutomatorGui.SetFont("Bold " . MainFontColor, MainFontType)
	Position17.EditPosX.Value := Position17.CoordX
	;--------------------
	TaskAutomatorGui.SetFont()
	TaskAutomatorGui.SetFont("Bold " . FontClickerPatternColor . "", MainFontType)
	if EditBoxesAvailable == true {
		Position17.EditPosY := TaskAutomatorGui.Add("Edit", "vCoordY17 x73 y444 w40 h20 +Number")
	} else {
		Position17.EditPosY := TaskAutomatorGui.Add("Edit", "vCoordY17 x73 y444 w40 h20 +Number +Disabled")
	}
	Position17.EditPosY.Opt("" . BackgroundMainColor . "")
	TaskAutomatorGui.SetFont()
	TaskAutomatorGui.SetFont("Bold " . MainFontColor, MainFontType)
	Position17.EditPosY.Value := Position17.CoordY
	;--------------------
	TaskAutomatorGui.SetFont()
	TaskAutomatorGui.SetFont("Bold " . FontClickerPatternColor . "", MainFontType)
	if EditBoxesAvailable == true {
		Position17.EditInterval := TaskAutomatorGui.Add("Edit", "vCoord17Interval x121 y444 w50 h20 +Number")
	} else {
		Position17.EditInterval := TaskAutomatorGui.Add("Edit", "vCoord17Interval x121 y444 w50 h20 +Number +Disabled")
	}
	Position17.EditInterval.Opt("" . BackgroundMainColor . "")
	TaskAutomatorGui.SetFont()
	TaskAutomatorGui.SetFont("Bold " . MainFontColor, MainFontType)
	Position17.EditInterval.Value := Position17.Interval
	;--------------------
	Position17.EditRadioYes := TaskAutomatorGui.Add("Radio", "vRadio17Yes x179 y444 h20", "Y")
	Position17.EditRadioYes.Value := Position17.RadioYes
	Position17.EditRadioNo := TaskAutomatorGui.Add("Radio", "vRadio17No x211 y444 w30 h20", "N")
	Position17.EditRadioNo.Value := Position17.RadioNo
	;----------------------------------------------------
	; Position 18
	;----------------------------------------------------
	TaskAutomatorGui.Add("Text","x7 y465 h20 +0x200", "18")
	TaskAutomatorGui.SetFont()
	TaskAutomatorGui.SetFont("Bold " . FontClickerPatternColor . "", MainFontType)
	if EditBoxesAvailable == true {
		Position18.EditPosX := TaskAutomatorGui.Add("Edit", "vCoordX18 x25 y465 w40 h20 +Number")
	} else {
		Position18.EditPosX := TaskAutomatorGui.Add("Edit", "vCoordX18 x25 y465 w40 h20 +Number +Disabled")
	}
	Position18.EditPosX.Opt("" . BackgroundMainColor . "")
	TaskAutomatorGui.SetFont()
	TaskAutomatorGui.SetFont("Bold " . MainFontColor, MainFontType)
	Position18.EditPosX.Value := Position18.CoordX
	;--------------------
	TaskAutomatorGui.SetFont()
	TaskAutomatorGui.SetFont("Bold " . FontClickerPatternColor . "", MainFontType)
	if EditBoxesAvailable == true {
		Position18.EditPosY := TaskAutomatorGui.Add("Edit", "vCoordY18 x73 y465 w40 h20 +Number")
	} else {
		Position18.EditPosY := TaskAutomatorGui.Add("Edit", "vCoordY18 x73 y465 w40 h20 +Number +Disabled")
	}
	Position18.EditPosY.Opt("" . BackgroundMainColor . "")
	TaskAutomatorGui.SetFont()
	TaskAutomatorGui.SetFont("Bold " . MainFontColor, MainFontType)
	Position18.EditPosY.Value := Position18.CoordY
	;--------------------
	TaskAutomatorGui.SetFont()
	TaskAutomatorGui.SetFont("Bold " . FontClickerPatternColor . "", MainFontType)
	if EditBoxesAvailable == true {
		Position18.EditInterval := TaskAutomatorGui.Add("Edit", "vCoord18Interval x121 y465 w50 h20 +Number")
	} else {
		Position18.EditInterval := TaskAutomatorGui.Add("Edit", "vCoord18Interval x121 y465 w50 h20 +Number +Disabled")
	}
	Position18.EditInterval.Opt("" . BackgroundMainColor . "")
	TaskAutomatorGui.SetFont()
	TaskAutomatorGui.SetFont("Bold " . MainFontColor, MainFontType)
	Position18.EditInterval.Value := Position18.Interval
	;--------------------
	Position18.EditRadioYes := TaskAutomatorGui.Add("Radio", "vRadio18Yes x179 y465 h20", "Y")
	Position18.EditRadioYes.Value := Position18.RadioYes
	Position18.EditRadioNo := TaskAutomatorGui.Add("Radio", "vRadio18No x211 y465 w30 h20", "N")
	Position18.EditRadioNo.Value := Position18.RadioNo
	;----------------------------------------------------
	; Position 19
	;----------------------------------------------------
	TaskAutomatorGui.Add("Text","x7 y486 h20 +0x200", "19")
	TaskAutomatorGui.SetFont()
	TaskAutomatorGui.SetFont("Bold " . FontClickerPatternColor . "", MainFontType)
	if EditBoxesAvailable == true {
		Position19.EditPosX := TaskAutomatorGui.Add("Edit", "vCoordX19 x25 y486 w40 h20 +Number")
	} else {
		Position19.EditPosX := TaskAutomatorGui.Add("Edit", "vCoordX19 x25 y486 w40 h20 +Number +Disabled")
	}
	Position19.EditPosX.Opt("" . BackgroundMainColor . "")
	TaskAutomatorGui.SetFont()
	TaskAutomatorGui.SetFont("Bold " . MainFontColor, MainFontType)
	Position19.EditPosX.Value := Position19.CoordX
	;--------------------
	TaskAutomatorGui.SetFont()
	TaskAutomatorGui.SetFont("Bold " . FontClickerPatternColor . "", MainFontType)
	if EditBoxesAvailable == true {
		Position19.EditPosY := TaskAutomatorGui.Add("Edit", "vCoordY19 x73 y486 w40 h20 +Number")
	} else {
		Position19.EditPosY := TaskAutomatorGui.Add("Edit", "vCoordY19 x73 y486 w40 h20 +Number +Disabled")
	}
	Position19.EditPosY.Opt("" . BackgroundMainColor . "")
	TaskAutomatorGui.SetFont()
	TaskAutomatorGui.SetFont("Bold " . MainFontColor, MainFontType)
	Position19.EditPosY.Value := Position19.CoordY
	;--------------------
	TaskAutomatorGui.SetFont()
	TaskAutomatorGui.SetFont("Bold " . FontClickerPatternColor . "", MainFontType)
	if EditBoxesAvailable == true {
		Position19.EditInterval := TaskAutomatorGui.Add("Edit", "vCoord19Interval x121 y486 w50 h20 +Number")
	} else {
		Position19.EditInterval := TaskAutomatorGui.Add("Edit", "vCoord19Interval x121 y486 w50 h20 +Number +Disabled")
	}
	Position19.EditInterval.Opt("" . BackgroundMainColor . "")
	TaskAutomatorGui.SetFont()
	TaskAutomatorGui.SetFont("Bold " . MainFontColor, MainFontType)
	Position19.EditInterval.Value := Position19.Interval
	;--------------------
	Position19.EditRadioYes := TaskAutomatorGui.Add("Radio", "vRadio19Yes x179 y486 h20", "Y")
	Position19.EditRadioYes.Value := Position19.RadioYes
	Position19.EditRadioNo := TaskAutomatorGui.Add("Radio", "vRadio19No x211 y486 w30 h20", "N")
	Position19.EditRadioNo.Value := Position19.RadioNo
	;----------------------------------------------------
	; Position 20
	;----------------------------------------------------
	TaskAutomatorGui.Add("Text","x7 y507 h20 +0x200", "20")
	TaskAutomatorGui.SetFont()
	TaskAutomatorGui.SetFont("Bold " . FontClickerPatternColor . "", MainFontType)
	if EditBoxesAvailable == true {
		Position20.EditPosX := TaskAutomatorGui.Add("Edit", "vCoordX20 x25 y507 w40 h20 +Number")
	} else {
		Position20.EditPosX := TaskAutomatorGui.Add("Edit", "vCoordX20 x25 y507 w40 h20 +Number +Disabled")
	}
	Position20.EditPosX.Opt("" . BackgroundMainColor . "")
	TaskAutomatorGui.SetFont()
	TaskAutomatorGui.SetFont("Bold " . MainFontColor, MainFontType)
	Position20.EditPosX.Value := Position20.CoordX
	;--------------------
	TaskAutomatorGui.SetFont()
	TaskAutomatorGui.SetFont("Bold " . FontClickerPatternColor . "", MainFontType)
	if EditBoxesAvailable == true {
		Position20.EditPosY := TaskAutomatorGui.Add("Edit", "vCoordY20 x73 y507 w40 h20 +Number")
	} else {
		Position20.EditPosY := TaskAutomatorGui.Add("Edit", "vCoordY20 x73 y507 w40 h20 +Number +Disabled")
	}
	Position20.EditPosY.Opt("" . BackgroundMainColor . "")
	TaskAutomatorGui.SetFont()
	TaskAutomatorGui.SetFont("Bold " . MainFontColor, MainFontType)
	Position20.EditPosY.Value := Position20.CoordY
	;--------------------
	TaskAutomatorGui.SetFont()
	TaskAutomatorGui.SetFont("Bold " . FontClickerPatternColor . "", MainFontType)
	if EditBoxesAvailable == true {
		Position20.EditInterval := TaskAutomatorGui.Add("Edit", "vCoord20Interval x121 y507 w50 h20 +Number")
	} else {
		Position20.EditInterval := TaskAutomatorGui.Add("Edit", "vCoord20Interval x121 y507 w50 h20 +Number +Disabled")
	}
	Position20.EditInterval.Opt("" . BackgroundMainColor . "")
	TaskAutomatorGui.SetFont()
	TaskAutomatorGui.SetFont("Bold " . MainFontColor, MainFontType)
	Position20.EditInterval.Value := Position20.Interval
	;--------------------
	Position20.EditRadioYes := TaskAutomatorGui.Add("Radio", "vRadio20Yes x179 y507 h20", "Y")
	Position20.EditRadioYes.Value := Position20.RadioYes
	Position20.EditRadioNo := TaskAutomatorGui.Add("Radio", "vRadio20No x211 y507 w30 h20", "N")
	Position20.EditRadioNo.Value := Position20.RadioNo
	;----------------------------------------------------
	; Position 21
	;----------------------------------------------------
	TaskAutomatorGui.Add("Text","x7 y528 h20 +0x200", "21")
	TaskAutomatorGui.SetFont()
	TaskAutomatorGui.SetFont("Bold " . FontClickerPatternColor . "", MainFontType)
	if EditBoxesAvailable == true {
		Position21.EditPosX := TaskAutomatorGui.Add("Edit", "vCoordX21 x25 y528 w40 h20 +Number")
	} else {
		Position21.EditPosX := TaskAutomatorGui.Add("Edit", "vCoordX21 x25 y528 w40 h20 +Number +Disabled")
	}
	Position21.EditPosX.Opt("" . BackgroundMainColor . "")
	TaskAutomatorGui.SetFont()
	TaskAutomatorGui.SetFont("Bold " . MainFontColor, MainFontType)
	Position21.EditPosX.Value := Position21.CoordX
	;--------------------
	TaskAutomatorGui.SetFont()
	TaskAutomatorGui.SetFont("Bold " . FontClickerPatternColor . "", MainFontType)
	if EditBoxesAvailable == true {
		Position21.EditPosY := TaskAutomatorGui.Add("Edit", "vCoordY21 x73 y528 w40 h20 +Number")
	} else {
		Position21.EditPosY := TaskAutomatorGui.Add("Edit", "vCoordY21 x73 y528 w40 h20 +Number +Disabled")
	}
	Position21.EditPosY.Opt("" . BackgroundMainColor . "")
	TaskAutomatorGui.SetFont()
	TaskAutomatorGui.SetFont("Bold " . MainFontColor, MainFontType)
	Position21.EditPosY.Value := Position21.CoordY
	;--------------------
	TaskAutomatorGui.SetFont()
	TaskAutomatorGui.SetFont("Bold " . FontClickerPatternColor . "", MainFontType)
	if EditBoxesAvailable == true {
		Position21.EditInterval := TaskAutomatorGui.Add("Edit", "vCoord21Interval x121 y528 w50 h20 +Number")
	} else {
		Position21.EditInterval := TaskAutomatorGui.Add("Edit", "vCoord21Interval x121 y528 w50 h20 +Number +Disabled")
	}
	Position21.EditInterval.Opt("" . BackgroundMainColor . "")
	TaskAutomatorGui.SetFont()
	TaskAutomatorGui.SetFont("Bold " . MainFontColor, MainFontType)
	Position21.EditInterval.Value := Position21.Interval
	;--------------------
	Position21.EditRadioYes := TaskAutomatorGui.Add("Radio", "vRadio21Yes x179 y528 h20", "Y")
	Position21.EditRadioYes.Value := Position21.RadioYes
	Position21.EditRadioNo := TaskAutomatorGui.Add("Radio", "vRadio21No x211 y528 w30 h20", "N")
	Position21.EditRadioNo.Value := Position21.RadioNo
	;----------------------------------------------------
	; Position 22
	;----------------------------------------------------
	TaskAutomatorGui.Add("Text","x7 y549 h20 +0x200", "22")
	TaskAutomatorGui.SetFont()
	TaskAutomatorGui.SetFont("Bold " . FontClickerPatternColor . "", MainFontType)
	if EditBoxesAvailable == true {
		Position22.EditPosX := TaskAutomatorGui.Add("Edit", "vCoordX22 x25 y549 w40 h20 +Number")
	} else {
		Position22.EditPosX := TaskAutomatorGui.Add("Edit", "vCoordX22 x25 y549 w40 h20 +Number +Disabled")
	}
	Position22.EditPosX.Opt("" . BackgroundMainColor . "")
	TaskAutomatorGui.SetFont()
	TaskAutomatorGui.SetFont("Bold " . MainFontColor, MainFontType)
	Position22.EditPosX.Value := Position22.CoordX
	;--------------------
	TaskAutomatorGui.SetFont()
	TaskAutomatorGui.SetFont("Bold " . FontClickerPatternColor . "", MainFontType)
	if EditBoxesAvailable == true {
		Position22.EditPosY := TaskAutomatorGui.Add("Edit", "vCoordY22 x73 y549 w40 h20 +Number")
	} else {
		Position22.EditPosY := TaskAutomatorGui.Add("Edit", "vCoordY22 x73 y549 w40 h20 +Number +Disabled")
	}
	Position22.EditPosY.Opt("" . BackgroundMainColor . "")
	TaskAutomatorGui.SetFont()
	TaskAutomatorGui.SetFont("Bold " . MainFontColor, MainFontType)
	Position22.EditPosY.Value := Position22.CoordY
	;--------------------
	TaskAutomatorGui.SetFont()
	TaskAutomatorGui.SetFont("Bold " . FontClickerPatternColor . "", MainFontType)
	if EditBoxesAvailable == true {
		Position22.EditInterval := TaskAutomatorGui.Add("Edit", "vCoord22Interval x121 y549 w50 h20 +Number")
	} else {
		Position22.EditInterval := TaskAutomatorGui.Add("Edit", "vCoord22Interval x121 y549 w50 h20 +Number +Disabled")
	}
	Position22.EditInterval.Opt("" . BackgroundMainColor . "")
	TaskAutomatorGui.SetFont()
	TaskAutomatorGui.SetFont("Bold " . MainFontColor, MainFontType)
	Position22.EditInterval.Value := Position22.Interval
	;--------------------
	Position22.EditRadioYes := TaskAutomatorGui.Add("Radio", "vRadio22Yes x179 y549 h20", "Y")
	Position22.EditRadioYes.Value := Position22.RadioYes
	Position22.EditRadioNo := TaskAutomatorGui.Add("Radio", "vRadio22No x211 y549 w30 h20", "N")
	Position22.EditRadioNo.Value := Position22.RadioNo
	;----------------------------------------------------
	TaskAutomatorGui.Add("Text","x22 y575 +0x200", " Time interval in ms (1 second = 1000) ")
	
	StartTime := A_TickCount
	LastYLine := 570
}
;----------------------------------------------------
; Y-233 / Quick Access
;----------------------------------------------------
QuickAccessModule(TaskAutomatorGui,
				  &OptionsMenu,
				  &SwitchQuickAccess,
				  &SwitchClicker,
				  &SwitchJumps,
				  &SwitchControllerAutoRun,
				  &SwitchKbAutoRun,
				  &FlagReload,
				  &EditBoxesAvailable,
				  &BackgroundMainColor,
				  &QuickAccessButtons,
				  &HotkeyEditMode,
				  &QuickIcon1,
				  &EditQuickAcess1,
				  &QuickAccessButton1,
				  &QuickAccessHk1,
				  &CtrlQuickAccessHk1,
				  &AltQuickAccessHk1,
				  &ShiftQuickAccessHk1,
				  &QuickIcon2,
				  &EditQuickAcess2,
				  &QuickAccessButton2,
				  &QuickAccessHk2,
				  &CtrlQuickAccessHk2,
				  &AltQuickAccessHk2,
				  &ShiftQuickAccessHk2,
				  &QuickIcon3,
				  &EditQuickAcess3,
				  &QuickAccessButton3,
				  &QuickAccessHk3,
				  &CtrlQuickAccessHk3,
				  &AltQuickAccessHk3,
				  &ShiftQuickAccessHk3,
				  &QuickIcon4,
				  &EditQuickAcess4,
				  &QuickAccessButton4,
				  &QuickAccessHk4,
				  &CtrlQuickAccessHk4,
				  &AltQuickAccessHk4,
				  &ShiftQuickAccessHk4,
				  &QuickIcon5,
				  &EditQuickAcess5,
				  &QuickAccessButton5,
				  &QuickAccessHk5,
				  &CtrlQuickAccessHk5,
				  &AltQuickAccessHk5,
				  &ShiftQuickAccessHk5,
				  &QuickIcon6,
				  &EditQuickAcess6,
				  &QuickAccessButton6,
				  &QuickAccessHk6,
				  &CtrlQuickAccessHk6,
				  &AltQuickAccessHk6,
				  &ShiftQuickAccessHk6,
				  &QuickIcon7,
				  &EditQuickAcess7,
				  &QuickAccessButton7,
				  &QuickAccessHk7,
				  &CtrlQuickAccessHk7,
				  &AltQuickAccessHk7,
				  &ShiftQuickAccessHk7,
				  &QuickIcon8,
				  &EditQuickAcess8,
				  &QuickAccessButton8,
				  &QuickAccessHk8,
				  &CtrlQuickAccessHk8,
				  &AltQuickAccessHk8,
				  &ShiftQuickAccessHk8,
				  &QuickIcon9,
				  &EditQuickAcess9,
				  &QuickAccessButton9,
				  &QuickAccessHk9,
				  &CtrlQuickAccessHk9,
				  &AltQuickAccessHk9,
				  &ShiftQuickAccessHk9,
				  &LastYLine){
	;-------------------------------
	try {
		OptionsMenu.SetIcon("4. Switch &Clicker", IconLib . "\Switch2.ico")
		OptionsMenu.SetIcon("5. Switch &Jumps", IconLib . "\Switch2.ico")
		OptionsMenu.SetIcon("3a. Switch Quick &Access", IconLib . "\Switch1.ico")
		OptionsMenu.SetIcon("2. Switch Con&troller Autorun", IconLib . "\Switch2.ico")
		OptionsMenu.SetIcon("1. Switch &Keyboard Autorun", IconLib . "\Switch2.ico")
	}
	catch {
	}
	SwitchQuickAccess := 1
	SwitchClicker := 0
	SwitchJumps := 0
	SwitchControllerAutoRun := 0
	SwitchKbAutoRun := 0
	FlagReload := false
	;----------------------------------------------------
	TaskAutomatorGui.Add("Text", "x7 y10 h20 +0x200", "1")
	if EditBoxesAvailable == true {
		try {
			SettingsMenu.SetIcon("Lock Edit &Boxes && Icons: ON/OFF", IconLib . "\EditBox2.png")
		}
		catch {
		}
		try {
			TaskAutomatorGui.Add("Picture", "x18 y10 w20 h20 +border", QuickIcon1).OnEvent("Click", SelectNewIcon1)
		}
		catch {
			QuickIcon1 := ""
			IniWrite QuickIcon1, IniFile, "QuickAccessIcons", "QuickIcon1"
			FlagReload := true
		}
		EditQuickAcess1 := TaskAutomatorGui.Add("Edit", "vQuickAccess1 x45 y10 w160 h20")
	} else {
		try {
			SettingsMenu.SetIcon("Lock Edit &Boxes && Icons: ON/OFF", IconLib . "\EditBox1.png")
		}
		catch {
		}
		try {
			TaskAutomatorGui.Add("Picture", "x18 y10 w20 h20 +border", QuickIcon1)
		}
		catch {
			QuickIcon1 := ""
			IniWrite QuickIcon1, IniFile, "QuickAccessIcons", "QuickIcon1"
			FlagReload := true
		}
		EditQuickAcess1 := TaskAutomatorGui.Add("Edit", "vQuickAccess1 x45 y10 w160 h20 +Disabled")
	}
	EditQuickAcess1.Opt("" . BackgroundMainColor . "")
	EditQuickAcess1.Value := QuickAccess1
	if QuickAccessButtons == true {
		OptionsMenu.SetIcon("3b. Switch &Quick Access Hotkeys/Buttons", IconLib . "\Switch1.ico")
		QuickAccessButton1 := TaskAutomatorGui.Add("Button", "x210 y10 w30 h20", "Go!")
		QuickAccessButton1.OnEvent("Click", ProccessQuickAccessButton1) 
	} else {
		OptionsMenu.SetIcon("3b. Switch &Quick Access Hotkeys/Buttons", IconLib . "\Switch2.ico")
		if HotkeyEditMode == true {
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
			
			QuickAccessHk1 := TaskAutomatorGui.Add("Hotkey", "vQuickAccessHk1 x210 y10 w30 h20", QuickAccessHk1).OnEvent("Change", SubmitQuickAccess1)
		} else {
			QuickAccessHk1 := TaskAutomatorGui.Add("Hotkey", "vQuickAccessHk1 x210 y10 w30 h20 +disabled", QuickAccessHk1)
		} ; HotkeyEditMode false end
	}
	;----------------------------------------------------
	TaskAutomatorGui.Add("Text", "x7 y41 h20 +0x200", "2")
	if EditBoxesAvailable == true {
		try {
			TaskAutomatorGui.Add("Picture", "x18 y41 w20 h20 +border", QuickIcon2).OnEvent("Click", SelectNewIcon2)
		}
		catch {
			QuickIcon2 := ""
			IniWrite QuickIcon2, IniFile, "QuickAccessIcons", "QuickIcon2"
			FlagReload := true
		}
		EditQuickAcess2 := TaskAutomatorGui.Add("Edit", "vQuickAccess2 x45 y41 w160 h20")
	} else {
		try {
			TaskAutomatorGui.Add("Picture", "x18 y41 w20 h20 +border", QuickIcon2)
		}
		catch {
			QuickIcon2 := ""
			IniWrite QuickIcon2, IniFile, "QuickAccessIcons", "QuickIcon2"
			FlagReload := true
		}
		EditQuickAcess2 := TaskAutomatorGui.Add("Edit", "vQuickAccess2 x45 y41 w160 h20 +Disabled")
	}
	EditQuickAcess2.Opt("" . BackgroundMainColor . "")
	EditQuickAcess2.Value := QuickAccess2
	if QuickAccessButtons == true {
		QuickAccessButton2 := TaskAutomatorGui.Add("Button", "x210 y41 w30 h20", "Go!")
		QuickAccessButton2.OnEvent("Click", ProccessQuickAccessButton2) 
	} else {
		if HotkeyEditMode == true {
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
			
			QuickAccessHk2 := TaskAutomatorGui.Add("Hotkey", "vQuickAccessHk2 x210 y41 w30 h20", QuickAccessHk2).OnEvent("Change", SubmitQuickAccess2)
		} else {
			QuickAccessHk2 := TaskAutomatorGui.Add("Hotkey", "vQuickAccessHk2 x210 y41 w30 h20 +disabled", QuickAccessHk2)
		} ; HotkeyEditMode false end
	}
	;----------------------------------------------------
	TaskAutomatorGui.Add("Text", "x7 y71 h20 +0x200", "3")
	if EditBoxesAvailable == true {
		try {
			TaskAutomatorGui.Add("Picture", "x18 y71 w20 h20 +border", QuickIcon3).OnEvent("Click", SelectNewIcon3)
		}
		catch {
			QuickIcon3 := ""
			IniWrite QuickIcon3, IniFile, "QuickAccessIcons", "QuickIcon3"
			FlagReload := true
		}
		EditQuickAcess3 := TaskAutomatorGui.Add("Edit", "vQuickAccess3 x45 y71 w160 h20")
	} else {
		try {
			TaskAutomatorGui.Add("Picture", "x18 y71 w20 h20 +border", QuickIcon3)
		}
		catch {
			QuickIcon3 := ""
			IniWrite QuickIcon3, IniFile, "QuickAccessIcons", "QuickIcon3"
			FlagReload := true
		}
		EditQuickAcess3 := TaskAutomatorGui.Add("Edit", "vQuickAccess3 x45 y71 w160 h20 +Disabled")
	}
	EditQuickAcess3.Opt("" . BackgroundMainColor . "")
	EditQuickAcess3.Value := QuickAccess3
	if QuickAccessButtons == true {
		QuickAccessButton3 := TaskAutomatorGui.Add("Button", "x210 y71 w30 h20", "Go!")
		QuickAccessButton3.OnEvent("Click", ProccessQuickAccessButton3) 
	} else {
		if HotkeyEditMode == true {
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
			
			QuickAccessHk3 := TaskAutomatorGui.Add("Hotkey", "vQuickAccessHk3 x210 y71 w30 h20", QuickAccessHk3).OnEvent("Change", SubmitQuickAccess3)
		} else {
			QuickAccessHk3 := TaskAutomatorGui.Add("Hotkey", "vQuickAccessHk3 x210 y71 w30 h20 +disabled", QuickAccessHk3)
		} ; HotkeyEditMode false end
	}
	;----------------------------------------------------
	TaskAutomatorGui.Add("Text", "x7 y102 h20 +0x200", "4")
	if EditBoxesAvailable == true {
		try {
			TaskAutomatorGui.Add("Picture", "x18 y102 w20 h20 +border", QuickIcon4).OnEvent("Click", SelectNewIcon4)
		}
		catch {
			QuickIcon4 := ""
			IniWrite QuickIcon4, IniFile, "QuickAccessIcons", "QuickIcon4"
			FlagReload := true
		}
		EditQuickAcess4 := TaskAutomatorGui.Add("Edit", "vQuickAccess4 x45 y102 w160 h20")
	} else {
		try {
			TaskAutomatorGui.Add("Picture", "x18 y102 w20 h20 +border", QuickIcon4)
		}
		catch {
			QuickIcon4 := ""
			IniWrite QuickIcon4, IniFile, "QuickAccessIcons", "QuickIcon4"
			FlagReload := true
		}
		EditQuickAcess4 := TaskAutomatorGui.Add("Edit", "vQuickAccess4 x45 y102 w160 h20 +Disabled")
	}
	EditQuickAcess4.Opt("" . BackgroundMainColor . "")
	EditQuickAcess4.Value := QuickAccess4
	if QuickAccessButtons == true {
		QuickAccessButton4 := TaskAutomatorGui.Add("Button", "x210 y102 w30 h20", "Go!")
		QuickAccessButton4.OnEvent("Click", ProccessQuickAccessButton4) 
	} else {
		if HotkeyEditMode == true {
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
			
			QuickAccessHk4 := TaskAutomatorGui.Add("Hotkey", "vQuickAccessHk4 x210 y102 w30 h20", QuickAccessHk4).OnEvent("Change", SubmitQuickAccess4)
		} else {
			QuickAccessHk4 := TaskAutomatorGui.Add("Hotkey", "vQuickAccessHk4 x210 y102 w30 h20 +disabled", QuickAccessHk4)
		} ; HotkeyEditMode false end
	}
	;----------------------------------------------------
	TaskAutomatorGui.Add("Text", "x7 y133 h20 +0x200", "5")
	if EditBoxesAvailable == true {
		try {
			TaskAutomatorGui.Add("Picture", "x18 y133 w20 h20 +border", QuickIcon5).OnEvent("Click", SelectNewIcon5)
		}
		catch {
			QuickIcon5 := ""
			IniWrite QuickIcon5, IniFile, "QuickAccessIcons", "QuickIcon5"
			FlagReload := true
		}
		EditQuickAcess5 := TaskAutomatorGui.Add("Edit", "vQuickAccess5 x45 y133 w160 h20")
	} else {
		try {
			TaskAutomatorGui.Add("Picture", "x18 y133 w20 h20 +border", QuickIcon5)
		}
		catch {
			QuickIcon5 := ""
			IniWrite QuickIcon5, IniFile, "QuickAccessIcons", "QuickIcon5"
			FlagReload := true
		}
		EditQuickAcess5 := TaskAutomatorGui.Add("Edit", "vQuickAccess5 x45 y133 w160 h20 +Disabled")
	}
	EditQuickAcess5.Opt("" . BackgroundMainColor . "")
	EditQuickAcess5.Value := QuickAccess5
	if QuickAccessButtons == true {
		QuickAccessButton5 := TaskAutomatorGui.Add("Button", "x210 y133 w30 h20", "Go!")
		QuickAccessButton5.OnEvent("Click", ProccessQuickAccessButton5) 
	} else {
		if HotkeyEditMode == true {
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
			
			QuickAccessHk5 := TaskAutomatorGui.Add("Hotkey", "vQuickAccessHk5 x210 y133 w30 h20", QuickAccessHk5).OnEvent("Change", SubmitQuickAccess5)
		} else {
			QuickAccessHk5 := TaskAutomatorGui.Add("Hotkey", "vQuickAccessHk5 x210 y133 w30 h20 +disabled", QuickAccessHk5)
		} ; HotkeyEditMode false end
	}
	;----------------------------------------------------
	TaskAutomatorGui.Add("Text", "x7 y164 h20 +0x200", "6")
	if EditBoxesAvailable == true {
		try {
			TaskAutomatorGui.Add("Picture", "x18 y164 w20 h20 +border", QuickIcon6).OnEvent("Click", SelectNewIcon6)
		}
		catch {
			QuickIcon6 := ""
			IniWrite QuickIcon6, IniFile, "QuickAccessIcons", "QuickIcon6"
			FlagReload := true
		}
		EditQuickAcess6 := TaskAutomatorGui.Add("Edit", "vQuickAccess6 x45 y164 w160 h20")
	} else {
		try {
			TaskAutomatorGui.Add("Picture", "x18 y164 w20 h20 +border", QuickIcon6)
		}
		catch {
			QuickIcon6 := ""
			IniWrite QuickIcon6, IniFile, "QuickAccessIcons", "QuickIcon6"
			FlagReload := true
		}
		EditQuickAcess6 := TaskAutomatorGui.Add("Edit", "vQuickAccess6 x45 y164 w160 h20 +Disabled")
	}
	EditQuickAcess6.Opt("" . BackgroundMainColor . "")
	EditQuickAcess6.Value := QuickAccess6
	if QuickAccessButtons == true {
		QuickAccessButton6 := TaskAutomatorGui.Add("Button", "x210 y164 w30 h20", "Go!")
		QuickAccessButton6.OnEvent("Click", ProccessQuickAccessButton6) 
	} else {
		if HotkeyEditMode == true {
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
			
			QuickAccessHk6 := TaskAutomatorGui.Add("Hotkey", "vQuickAccessHk6 x210 y164 w30 h20", QuickAccessHk6).OnEvent("Change", SubmitQuickAccess6)
		} else {
			QuickAccessHk6 := TaskAutomatorGui.Add("Hotkey", "vQuickAccessHk6 x210 y164 w30 h20 +disabled", QuickAccessHk6)
		} ; HotkeyEditMode false end
	}
	;----------------------------------------------------
	TaskAutomatorGui.Add("Text", "x7 y195 h20 +0x200", "7")
	if EditBoxesAvailable == true {
		try {
			TaskAutomatorGui.Add("Picture", "x18 y195 w20 h20 +border", QuickIcon7).OnEvent("Click", SelectNewIcon7)
		}
		catch {
			QuickIcon7 := ""
			IniWrite QuickIcon7, IniFile, "QuickAccessIcons", "QuickIcon7"
			FlagReload := true
		}
		EditQuickAcess7 := TaskAutomatorGui.Add("Edit", "vQuickAccess7 x45 y195 w160 h20")
	} else {
		try {
			TaskAutomatorGui.Add("Picture", "x18 y195 w20 h20 +border", QuickIcon7)
		}
		catch {
			QuickIcon7 := ""
			IniWrite QuickIcon7, IniFile, "QuickAccessIcons", "QuickIcon7"
			FlagReload := true
		}
		EditQuickAcess7 := TaskAutomatorGui.Add("Edit", "vQuickAccess7 x45 y195 w160 h20 +Disabled")
	}
	EditQuickAcess7.Opt("" . BackgroundMainColor . "")
	EditQuickAcess7.Value := QuickAccess7
	if QuickAccessButtons == true {
		QuickAccessButton7 := TaskAutomatorGui.Add("Button", "x210 y195 w30 h20", "Go!")
		QuickAccessButton7.OnEvent("Click", ProccessQuickAccessButton7) 
	} else {
		if HotkeyEditMode == true {
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
			
			QuickAccessHk7 := TaskAutomatorGui.Add("Hotkey", "vQuickAccessHk7 x210 y195 w30 h20", QuickAccessHk7).OnEvent("Change", SubmitQuickAccess7)
		} else {
			QuickAccessHk7 := TaskAutomatorGui.Add("Hotkey", "vQuickAccessHk7 x210 y195 w30 h20 +disabled", QuickAccessHk7)
		} ; HotkeyEditMode false end
	}
	;----------------------------------------------------
	TaskAutomatorGui.Add("Text", "x7 y226 h20 +0x200", "8")
	if EditBoxesAvailable == true {
		try {
			TaskAutomatorGui.Add("Picture", "x18 y226 w20 h20 +border", QuickIcon8).OnEvent("Click", SelectNewIcon8)
		}
		catch {
			QuickIcon8 := ""
			IniWrite QuickIcon8, IniFile, "QuickAccessIcons", "QuickIcon8"
			FlagReload := true
		}
		EditQuickAcess8 := TaskAutomatorGui.Add("Edit", "vQuickAccess8 x45 y226 w160 h20")
	} else {
		try {
			TaskAutomatorGui.Add("Picture", "x18 y226 w20 h20 +border", QuickIcon8)
		}
		catch {
			QuickIcon8 := ""
			IniWrite QuickIcon8, IniFile, "QuickAccessIcons", "QuickIcon8"
			FlagReload := true
		}
		EditQuickAcess8 := TaskAutomatorGui.Add("Edit", "vQuickAccess8 x45 y226 w160 h20 +Disabled")
	}
	EditQuickAcess8.Opt("" . BackgroundMainColor . "")
	EditQuickAcess8.Value := QuickAccess8
	if QuickAccessButtons == true {
		QuickAccessButton8 := TaskAutomatorGui.Add("Button", "x210 y226 w30 h20", "Go!")
		QuickAccessButton8.OnEvent("Click", ProccessQuickAccessButton8) 
	} else {
		if HotkeyEditMode == true {
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
			
			QuickAccessHk8 := TaskAutomatorGui.Add("Hotkey", "vQuickAccessHk8 x210 y226 w30 h20", QuickAccessHk8).OnEvent("Change", SubmitQuickAccess8)
		} else {
			QuickAccessHk8 := TaskAutomatorGui.Add("Hotkey", "vQuickAccessHk8 x210 y226 w30 h20 +disabled", QuickAccessHk8)
		} ; HotkeyEditMode false end
	}
	;----------------------------------------------------
	TaskAutomatorGui.Add("Text", "x7 y257 h20 +0x200", "9")
	if EditBoxesAvailable == true {
		try {
			TaskAutomatorGui.Add("Picture", "x18 y257 w20 h20 +border", QuickIcon9).OnEvent("Click", SelectNewIcon9)
		}
		catch {
			QuickIcon9 := ""
			IniWrite QuickIcon9, IniFile, "QuickAccessIcons", "QuickIcon9"
			FlagReload := true
		}
		EditQuickAcess9 := TaskAutomatorGui.Add("Edit", "vQuickAccess9 x45 y257 w160 h20")
	} else {
		try {
			TaskAutomatorGui.Add("Picture", "x18 y257 w20 h20 +border", QuickIcon9)
		}
		catch {
			QuickIcon9 := ""
			IniWrite QuickIcon9, IniFile, "QuickAccessIcons", "QuickIcon9"
			FlagReload := true
		}
		EditQuickAcess9 := TaskAutomatorGui.Add("Edit", "vQuickAccess9 x45 y257 w160 h20 +Disabled")
	}
	if FlagReload == true {
		Reload
	}
	EditQuickAcess9.Opt("" . BackgroundMainColor . "")
	EditQuickAcess9.Value := QuickAccess9
	if QuickAccessButtons == true {
		QuickAccessButton9 := TaskAutomatorGui.Add("Button", "x210 y257 w30 h20", "Go!")
		QuickAccessButton9.OnEvent("Click", ProccessQuickAccessButton9) 
	} else {
		if HotkeyEditMode == true {
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
			
			QuickAccessHk9 := TaskAutomatorGui.Add("Hotkey", "vQuickAccessHk9 x210 y257 w30 h20", QuickAccessHk9).OnEvent("Change", SubmitQuickAccess9)
		} else {
			QuickAccessHk9 := TaskAutomatorGui.Add("Hotkey", "vQuickAccessHk9 x210 y257 w30 h20 +disabled", QuickAccessHk9)
		} ; HotkeyEditMode false end
	}
	
	LastYLine := 257
}
;----------------------------------------------------
; Y-510 / Save All EditBox Values
;----------------------------------------------------
SaveAllEditValues(TaskAutomatorGui, &SaveButton, SubmitValues, &LastYLine, &FlagLineValueAdded){
	;-------------------------------
	TaskAutomatorGui.Add("Text", "x1 y" . LastYLine + 25 . " w250 h2 +0x10") ; Separator
	SaveButton := TaskAutomatorGui.Add("Button", "x70 y" . LastYLine + 32 . " h20", "Save Current Values")
	SaveButton.OnEvent("Click", SubmitValues)
	FlagLineValueAdded := true
	if FlagLineValueAdded == true {
		LastYLine := LastYLine + 31
	}
}
;----------------------------------------------------
; Y-510 / Hotkey Edit Mode - TaskAutomatorGui.ahk
;----------------------------------------------------
CheckHotkeyEditMode(TaskAutomatorGui,
					&HotkeyEditMode,
					&LicenseKeyFontType,
					&LastYLine){
	;-------------------------------
	TaskAutomatorGui.Add("Text", "x1 y" . LastYLine + 25 . " w250 h2 +0x10") ; Separator
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
}


;----------------------------------------------------
; Y-539 / Check for updates
;----------------------------------------------------
CheckForUpdates(TaskAutomatorGui, 
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
	; TaskAutomatorGui.Add("Text", "x1 y539 w250 h2 +0x10") ; Separator
	TaskAutomatorGui.Add("Text", "x1 y" . LastYLine + 57  . " w250 h2 +0x10") ; Separator
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
	
	TaskAutomatorGui.Add("Text","x7 y" . LastYLine + 64 . " w84 h20 +0x200", " Update check: ")
	switch true {
	case NeverCheckForUpdates == true:
		TaskAutomatorGui.SetFont("s8 Bold c00A8F3", LicenseKeyFontType)
		TaskAutomatorGui.Add("Text","x97 y" . LastYLine + 64 . " w126 h20 +0x200", " Update check disabled ")
		try {
			TaskAutomatorGui.Add("Picture", "x230 y" . LastYLine + 68 . " w10 h10 +border", IconLib . "\UpdateCheckDisabled.png")
		}
		catch {
		}
	case NeedUpdate == true:
		TaskAutomatorGui.SetFont("s8 Bold cYellow", LicenseKeyFontType)
		TaskAutomatorGui.Add("Text","x97 y" . LastYLine + 64 . " w126 h20 +0x200", " New version available ")
		try {
			TaskAutomatorGui.Add("Picture", "x230 y" . LastYLine + 68 . " w10 h10 +border", IconLib . "\NewVersionAvailable.png")
		}
		catch {
		}
	case FlagCheckTime == false and NeedUpdate == false:
		TaskAutomatorGui.SetFont("s8 Bold cLime", LicenseKeyFontType)
		TaskAutomatorGui.Add("Text","x97 y" . LastYLine + 64 . " w126 h20 +0x200", " Version up to date ")
		try {
			TaskAutomatorGui.Add("Picture", "x230 y" . LastYLine + 68 . " w10 h10 +border", IconLib . "\UpToDate.png")
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
			TaskAutomatorGui.Add("Text","x97 y" . LastYLine + 64 . " w126 h20 +0x200", " No internet connection ")
			try {
				TaskAutomatorGui.Add("Picture", "x230 y" . LastYLine + 68 . " w10 h10 +border", IconLib . "\NoInternetConnection.png")
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
			DownloadUrl := IniRead(DataFile, "EncriptedData", "TADownload")
			TALatestReleaseVersion := IniRead(DataFile, "GeneralData", "TALatestReleaseVersion")
			if TALatestReleaseVersion != CurrentVersion {
				if DownloadUrl != "" {
					TaskAutomatorGui.SetFont("s8 Bold cYellow", LicenseKeyFontType)
					TaskAutomatorGui.Add("Text","x97 y" . LastYLine + 64 . " w126 h20 +0x200", " New version available ")
					try {
						TaskAutomatorGui.Add("Picture", "x230 y" . LastYLine + 68 . " w10 h10 +border", IconLib . "\NewVersionAvailable.png")
					}
					catch {
					}
					NeedUpdate := true
					IniWrite NeedUpdate, IniFile, "Settings", "NeedUpdate"
				}
			}
			if TALatestReleaseVersion == CurrentVersion {
				TaskAutomatorGui.SetFont("s8 Bold cLime", LicenseKeyFontType)
				TaskAutomatorGui.Add("Text","x97 y" . LastYLine + 64 . " w126 h20 +0x200", " Version up to date ")
				if NeedUpdate == 1 or NeedUpdate == "" {
					IniWrite false, IniFile, "Settings", "NeedUpdate"
				}
				try {
					TaskAutomatorGui.Add("Picture", "x230 y" . LastYLine + 68 . " w10 h10 +border", IconLib . "\UpToDate.png")
				}
				catch {
				}
			}
			IniWrite A_Now, IniFile, "Settings", "LastUpdateCheckTimeStamp"
		}
	}
}
