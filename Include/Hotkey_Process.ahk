;------------- Credits ------------
; Creator: Fernando Daniel Jaime.
; Programmer Alias: FDJ-Dash.
;------------- File Details ------------
; App Name: Task Automator.
; File Description: This file contains functions related to hotkey processing.
;----------------------------------------------------
; Header list:
;----------------------------------------------------
; ProcessRunWalkHotkey(CurrentHotkey, *)
; ProcessJumpHotkey0(*)
; ProcessJumpHotkey1(*)
; ProcessJumpHotkey2(*)
; ProcessJumpHotkey3(*)
; ProcessJumpHotkey4(*)
; ProcessQuickAccess(CurrentHotkey, *)
; ProccessQuickAccessButton1(*)
; ProccessQuickAccessButton2(*)
; ProccessQuickAccessButton3(*)
; ProccessQuickAccessButton4(*)
; ProccessQuickAccessButton5(*)
; ProccessQuickAccessButton6(*)
; ProccessQuickAccessButton7(*)
; ProccessQuickAccessButton8(*)
; ProccessQuickAccessButton9(*)
; ProcessPatternClicker(CurrentHotkey, *)
;----------------------------------------------------
; Keyboard autorun
ProcessRunWalkHotkey(CurrentHotkey, *){
	SwitchKbAutoRun := IniRead(IniFile, "Modules", "SwitchKbAutoRun")
	if SwitchKbAutoRun == false {
		return
	}
	if String(CurrentHotkey) == "" {
		MsgBox "CurrentHotkey variable is empty: " CurrentHotkey
		return
	}
	if HotkeyEditMode == true {
		HotkeyEditModeOn
		return
	}
	
	; Parse hotkey start
	countParseHK := 1
	countLoop := 1
	KbAutoRunHotkey := ""
	KbAutoRunHotkey1 := ""
	KbAutoRunHotkey2 := ""
	KeyPressed := false
	Loop parse CurrentHotkey {
		if countLoop == 1 {
			switch true {
			case A_LoopField == '+':
				KbAutoRunHotkey1 := "Shift"
				countParseHK++
			case A_LoopField == '^':
				KbAutoRunHotkey1 := "Ctrl"
				
				countParseHK++
			case A_LoopField == '!':
				KbAutoRunHotkey1 := "Alt"
				countParseHK++
			default:
				KbAutoRunHotkey .= A_LoopField
			}
		}
		if countLoop == 2 {
			switch true {
			case A_LoopField == '+':
				KbAutoRunHotkey2 := "Shift"
				countParseHK++
			case A_LoopField == '^':
				KbAutoRunHotkey2 := "Ctrl"
				countParseHK++
			case A_LoopField == '!':
				KbAutoRunHotkey2 := "Alt"
				countParseHK++
			default:
				KbAutoRunHotkey .= A_LoopField
			}
		}
		if countLoop > 2 {
			KbAutoRunHotkey .= A_LoopField
		}
		countLoop++
	} ; Parse hotkey end
	
	FlagStopped := false
	SB.SetText("Keyboard autoRun active")
	Send("{" . SprintKey . " down}")
	Send("{" . ForwardKey . " down}")
	TextOnOff1.Value := " ON"
	sleep StartDelay
	if RadioScrlUpYes.Value == 1 {
		RadioScrlUpNo.Value := 0
		TextOnOffScrlUp.Value := " ON"
		Count := 0
		SB.SetText("AutoRun + Scroll up active. Scrlup count: " Count)
		loop ScrlUpCount {
			Send("{WheelUP}")
			sleep ScrlUpInterval
			switch true {
			case countParseHK == 1:
				if GetKeyState(KbAutoRunHotkey, "P") {
					KeyPressed := true
				}
			case countParseHK == 2:
				if GetKeyState(KbAutoRunHotkey1, "P") and 
					GetKeyState(KbAutoRunHotkey, "P") {
					KeyPressed := true
				}
			case countParseHK == 3:
				if GetKeyState(KbAutoRunHotkey1, "P") and
					GetKeyState(KbAutoRunHotkey2, "P") and
					GetKeyState(KbAutoRunHotkey, "P") {
					KeyPressed := true	
				}
			}
			if KeyPressed == true {
				KeyPressed := false
				Send("{" . SprintKey . " up}")
				Send("{" . ForwardKey . " up}")
				TextOnOff1.Value := " OFF"
				SB.SetText("KeyBoard Autorun Stopped")
				sleep StopDelay
				SB.SetText("Ready")
				FlagStopped := true
				break
			}
			Count++
			SB.SetText("AutoRun + Scroll up active. Scrlup count: " Count)
		}
		TextOnOffScrlUp.Value := " OFF"
		SB.SetText("AutoRun triggered by keyboard active.")
	}
	if FlagStopped == false {
		loop {
			switch true {
			case countParseHK == 1:
				if GetKeyState(KbAutoRunHotkey, "P") {
					KeyPressed := true
				}
			case countParseHK == 2:
				if GetKeyState(KbAutoRunHotkey1, "P") and 
					GetKeyState(KbAutoRunHotkey, "P") {
					KeyPressed := true
				}
			case countParseHK == 3:
				if GetKeyState(KbAutoRunHotkey1, "P") and
					GetKeyState(KbAutoRunHotkey2, "P") and
					GetKeyState(KbAutoRunHotkey, "P") {
					KeyPressed := true	
				}
			}
			if KeyPressed == true {
				KeyPressed := false
				Send("{" . SprintKey . " up}")
				Send("{" . ForwardKey . " up}")
				TextOnOff1.Value := " OFF"
				if RadioScrlDownYes.Value == 1 {
					RadioScrlDownNo.Value := 0
					TextOnOffScrlDown.Value := " ON"
					Count := 0
					SB.SetText("Kb Autorun Stopped. ScrlDown count: " Count)
					sleep StartDelay
					loop ScrlDownCount {
						Send("{WheelDown}")
						sleep ScrlDownInterval
						switch true {
						case countParseHK == 1:
							if GetKeyState(KbAutoRunHotkey, "P") {
								KeyPressed := true
							}
						case countParseHK == 2:
							if GetKeyState(KbAutoRunHotkey1, "P") and 
								GetKeyState(KbAutoRunHotkey, "P") {
								KeyPressed := true
							}
						case countParseHK == 3:
							if GetKeyState(KbAutoRunHotkey1, "P") and
								GetKeyState(KbAutoRunHotkey2, "P") and
								GetKeyState(KbAutoRunHotkey, "P") {
								KeyPressed := true	
							}
						}
						if KeyPressed == true {
							KeyPressed := false
							break
						}
						Count++
						SB.SetText("Scroll down active. ScrlDown count: " Count)
					}
					TextOnOffScrlDown.Value := " OFF"
					SB.SetText("Ready")
				}
				SB.SetText("KeyBoard Autorun Stopped")
				sleep StopDelay
				SB.SetText("Ready")
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
; Very Short Jump
;----------------------------------------------------
ProcessJumpHotkey0(*) {
	if HotkeyEditMode == true {
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
ProcessJumpHotkey1(*) {
	if HotkeyEditMode == true {
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
ProcessJumpHotkey2(*) {
	if HotkeyEditMode == true {
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
ProcessJumpHotkey3(*) {
	if HotkeyEditMode == true {
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
ProcessJumpHotkey4(*) {
	if HotkeyEditMode == true {
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
	GuiName := IniRead(TempSystemFile, "GeneralData", "GuiName")
	if GuiName == "TaskAutomatorGui1" {
		Saved := TaskAutomatorGui1.Submit(false)
	} else {
		Saved := TaskAutomatorGui2.Submit(false)
	}
	if HotkeyEditMode == true {
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
	GuiName := IniRead(TempSystemFile, "GeneralData", "GuiName")
	if GuiName == "TaskAutomatorGui1" {
		Saved := TaskAutomatorGui1.Submit(false)
	} else {
		Saved := TaskAutomatorGui2.Submit(false)
	}
	if HotkeyEditMode == true {
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
	GuiName := IniRead(TempSystemFile, "GeneralData", "GuiName")
	if GuiName == "TaskAutomatorGui1" {
		Saved := TaskAutomatorGui1.Submit(false)
	} else {
		Saved := TaskAutomatorGui2.Submit(false)
	}
	if HotkeyEditMode == true {
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
	GuiName := IniRead(TempSystemFile, "GeneralData", "GuiName")
	if GuiName == "TaskAutomatorGui1" {
		Saved := TaskAutomatorGui1.Submit(false)
	} else {
		Saved := TaskAutomatorGui2.Submit(false)
	}
	if HotkeyEditMode == true {
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
	GuiName := IniRead(TempSystemFile, "GeneralData", "GuiName")
	if GuiName == "TaskAutomatorGui1" {
		Saved := TaskAutomatorGui1.Submit(false)
	} else {
		Saved := TaskAutomatorGui2.Submit(false)
	}
	if HotkeyEditMode == true {
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
	GuiName := IniRead(TempSystemFile, "GeneralData", "GuiName")
	if GuiName == "TaskAutomatorGui1" {
		Saved := TaskAutomatorGui1.Submit(false)
	} else {
		Saved := TaskAutomatorGui2.Submit(false)
	}
	if HotkeyEditMode == true {
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
	GuiName := IniRead(TempSystemFile, "GeneralData", "GuiName")
	if GuiName == "TaskAutomatorGui1" {
		Saved := TaskAutomatorGui1.Submit(false)
	} else {
		Saved := TaskAutomatorGui2.Submit(false)
	}
	if HotkeyEditMode == true {
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
	GuiName := IniRead(TempSystemFile, "GeneralData", "GuiName")
	if GuiName == "TaskAutomatorGui1" {
		Saved := TaskAutomatorGui1.Submit(false)
	} else {
		Saved := TaskAutomatorGui2.Submit(false)
	}
	if HotkeyEditMode == true {
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
	GuiName := IniRead(TempSystemFile, "GeneralData", "GuiName")
	if GuiName == "TaskAutomatorGui1" {
		Saved := TaskAutomatorGui1.Submit(false)
	} else {
		Saved := TaskAutomatorGui2.Submit(false)
	}
	if HotkeyEditMode == true {
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
	GuiName := IniRead(TempSystemFile, "GeneralData", "GuiName")
	if GuiName == "TaskAutomatorGui1" {
		Saved := TaskAutomatorGui1.Submit(false)
	} else {
		Saved := TaskAutomatorGui2.Submit(false)
	}
	if HotkeyEditMode == true {
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
ProcessPatternClicker(CurrentHotkey, *){
	SwitchClicker := IniRead(IniFile, "Modules", "SwitchClicker")
	if SwitchClicker == false {
		return
	}
	GuiName := IniRead(TempSystemFile, "GeneralData", "GuiName")
	if GuiName == "TaskAutomatorGui1" {
		Saved := TaskAutomatorGui1.Submit(false)
	} else {
		Saved := TaskAutomatorGui2.Submit(false)
	}
	if HotkeyEditMode == true {
		HotkeyEditModeOn
		return
	}
	
	; Parse hotkey start
	countParseHK := 1
	countLoop := 1
	PatternClickerHotkey := ""
	PatternClickerHotkey1 := ""
	PatternClickerHotkey2 := ""
	KeyPressed := false
	Loop parse CurrentHotkey {
		if countLoop == 1 {
			switch true {
			case A_LoopField == '+':
				PatternClickerHotkey1 := "Shift"
				countParseHK++
			case A_LoopField == '^':
				PatternClickerHotkey1 := "Ctrl"
				countParseHK++
			case A_LoopField == '!':
				PatternClickerHotkey1 := "Alt"
				countParseHK++
			default:
				PatternClickerHotkey .= A_LoopField
			}
		}
		if countLoop == 2 {
			switch true {
			case A_LoopField == '+':
				PatternClickerHotkey2 := "Shift"
				countParseHK++
			case A_LoopField == '^':
				PatternClickerHotkey2 := "Ctrl"
				countParseHK++
			case A_LoopField == '!':
				PatternClickerHotkey2 := "Alt"
				countParseHK++
			default:
				PatternClickerHotkey .= A_LoopField
			}
		}
		if countLoop > 2 {
			PatternClickerHotkey .= A_LoopField
		}
		countLoop++
	} ; Parse hotkey end
	
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
		
		CoordX7 := Saved.CoordX7
		CoordY7 := Saved.CoordY7
		Coord7Interval := Saved.Coord7Interval
		
		CoordX8:= Saved.CoordX8
		CoordY8 := Saved.CoordY8
		Coord8Interval := Saved.Coord8Interval
		
		CoordX9:= Saved.CoordX9
		CoordY9 := Saved.CoordY9
		Coord9Interval := Saved.Coord9Interval
		
		CoordX10:= Saved.CoordX10
		CoordY10 := Saved.CoordY10
		Coord10Interval := Saved.Coord10Interval
		
		CoordX11:= Saved.CoordX11
		CoordY11 := Saved.CoordY11
		Coord11Interval := Saved.Coord11Interval
		
		CoordX12:= Saved.CoordX12
		CoordY12 := Saved.CoordY12
		Coord12Interval := Saved.Coord12Interval
		
		CoordX13:= Saved.CoordX13
		CoordY13 := Saved.CoordY13
		Coord13Interval := Saved.Coord13Interval
		
		CoordX14:= Saved.CoordX14
		CoordY14 := Saved.CoordY14
		Coord14Interval := Saved.Coord14Interval
		
		CoordX15:= Saved.CoordX15
		CoordY15 := Saved.CoordY15
		Coord15Interval := Saved.Coord15Interval
		
		CoordX16:= Saved.CoordX16
		CoordY16 := Saved.CoordY16
		Coord16Interval := Saved.Coord16Interval
		
		CoordX17:= Saved.CoordX17
		CoordY17 := Saved.CoordY17
		Coord17Interval := Saved.Coord17Interval
		
		CoordX18:= Saved.CoordX18
		CoordY18 := Saved.CoordY18
		Coord18Interval := Saved.Coord18Interval
		
		CoordX19:= Saved.CoordX19
		CoordY19 := Saved.CoordY19
		Coord19Interval := Saved.Coord19Interval
		
		CoordX20:= Saved.CoordX20
		CoordY20 := Saved.CoordY20
		Coord20Interval := Saved.Coord20Interval
		
		CoordX21:= Saved.CoordX21
		CoordY21 := Saved.CoordY21
		Coord21Interval := Saved.Coord21Interval
		
		CoordX22:= Saved.CoordX22
		CoordY22 := Saved.CoordY22
		Coord22Interval := Saved.Coord22Interval
		
		RadioPos1_10AnyYes := false
		RadioPos11_22AnyYes := false
		if Position1.EditRadioYes.Value == true or Position2.EditRadioYes.Value == true or 
		   Position3.EditRadioYes.Value == true or Position4.EditRadioYes.Value == true or 
		   Position5.EditRadioYes.Value == true or Position6.EditRadioYes.Value == true or 
		   Position7.EditRadioYes.Value == true or Position8.EditRadioYes.Value == true or
		   Position9.EditRadioYes.Value == true or Position10.EditRadioYes.Value == true {
			RadioPos1_10AnyYes := true
		}
		if Position11.EditRadioYes.Value == true or Position12.EditRadioYes.Value == true or
		   Position13.EditRadioYes.Value == true or Position14.EditRadioYes.Value == true or
		   Position15.EditRadioYes.Value == true or Position16.EditRadioYes.Value == true or
		   Position17.EditRadioYes.Value == true or Position18.EditRadioYes.Value == true or
		   Position19.EditRadioYes.Value == true or Position20.EditRadioYes.Value == true or
		   Position21.EditRadioYes.Value == true or Position22.EditRadioYes.Value == true {
			RadioPos11_22AnyYes := true
		}
		
		Switch true {
		case RadioCountLoopsYes.Value:
			if  RadioPos1_10AnyYes == false and RadioPos11_22AnyYes == false {
				SB.SetText("Clicker Active. Count: " Count)
				sleep StartDelay
				Loop LoopAmount {
					switch true {
					case countParseHK == 1:
						if GetKeyState(PatternClickerHotkey, "P") {
							KeyPressed := true
						}
					case countParseHK == 2:
						if GetKeyState(PatternClickerHotkey1, "P") and 
							GetKeyState(PatternClickerHotkey, "P") {
							KeyPressed := true
						}
					case countParseHK == 3:
						if GetKeyState(PatternClickerHotkey1, "P") and
							GetKeyState(PatternClickerHotkey2, "P") and
							GetKeyState(PatternClickerHotkey, "P") {
							KeyPressed := true	
						}
					}
					if KeyPressed == true {
						KeyPressed := false
						break
					} 
					SendKey
					Count++
					SB.SetText("Clicker Active. Count: " Count)
					sleep Random(ClickInterval, ClickInterval + RandomOffset) 
				}
			} 
			if RadioPos1_10AnyYes == true or RadioPos11_22AnyYes == true {
				SB.SetText("Pattern Clicker Active. Count: " Count)
				sleep StartDelay
				Loop LoopAmount {
					if Position1.EditRadioYes.Value == true {
						Position1.RadioNo := false
						DllCall("SetCursorPos", "int", CoordX1, "int", CoordY1)
						SendKey
						sleep Coord1Interval
					}
					switch true {
					case countParseHK == 1:
						if GetKeyState(PatternClickerHotkey, "P") {
							KeyPressed := true
						}
					case countParseHK == 2:
						if GetKeyState(PatternClickerHotkey1, "P") and 
							GetKeyState(PatternClickerHotkey, "P") {
							KeyPressed := true
						}
					case countParseHK == 3:
						if GetKeyState(PatternClickerHotkey1, "P") and
							GetKeyState(PatternClickerHotkey2, "P") and
							GetKeyState(PatternClickerHotkey, "P") {
							KeyPressed := true	
						}
					}
					if KeyPressed == true {
						KeyPressed := false
						break
					}
					;------------------------------
					if Position2.EditRadioYes.Value == true {
						Position2.RadioNo := false
						DllCall("SetCursorPos", "int", CoordX2, "int", CoordY2)
						SendKey
						sleep Coord2Interval
					}
					switch true {
					case countParseHK == 1:
						if GetKeyState(PatternClickerHotkey, "P") {
							KeyPressed := true
						}
					case countParseHK == 2:
						if GetKeyState(PatternClickerHotkey1, "P") and 
							GetKeyState(PatternClickerHotkey, "P") {
							KeyPressed := true
						}
					case countParseHK == 3:
						if GetKeyState(PatternClickerHotkey1, "P") and
							GetKeyState(PatternClickerHotkey2, "P") and
							GetKeyState(PatternClickerHotkey, "P") {
							KeyPressed := true	
						}
					}
					if KeyPressed == true {
						KeyPressed := false
						break
					}
					;------------------------------
					if Position3.EditRadioYes.Value == true {
						Position3.RadioNo := false
						DllCall("SetCursorPos", "int", CoordX3, "int", CoordY3)
						SendKey
						sleep Coord3Interval
					}
					switch true {
					case countParseHK == 1:
						if GetKeyState(PatternClickerHotkey, "P") {
							KeyPressed := true
						}
					case countParseHK == 2:
						if GetKeyState(PatternClickerHotkey1, "P") and 
							GetKeyState(PatternClickerHotkey, "P") {
							KeyPressed := true
						}
					case countParseHK == 3:
						if GetKeyState(PatternClickerHotkey1, "P") and
							GetKeyState(PatternClickerHotkey2, "P") and
							GetKeyState(PatternClickerHotkey, "P") {
							KeyPressed := true	
						}
					}
					if KeyPressed == true {
						KeyPressed := false
						break
					}
					;------------------------------
					if Position4.EditRadioYes.Value == true {
						Position4.RadioNo := false
						DllCall("SetCursorPos", "int", CoordX4, "int", CoordY4)
						SendKey
						sleep Coord4Interval
					}
					switch true {
					case countParseHK == 1:
						if GetKeyState(PatternClickerHotkey, "P") {
							KeyPressed := true
						}
					case countParseHK == 2:
						if GetKeyState(PatternClickerHotkey1, "P") and 
							GetKeyState(PatternClickerHotkey, "P") {
							KeyPressed := true
						}
					case countParseHK == 3:
						if GetKeyState(PatternClickerHotkey1, "P") and
							GetKeyState(PatternClickerHotkey2, "P") and
							GetKeyState(PatternClickerHotkey, "P") {
							KeyPressed := true	
						}
					}
					if KeyPressed == true {
						KeyPressed := false
						break
					}
					;------------------------------
					if Position5.EditRadioYes.Value == true {
						Position5.RadioNo := false
						DllCall("SetCursorPos", "int", CoordX5, "int", CoordY5)
						SendKey
						sleep Coord5Interval
					}
					switch true {
					case countParseHK == 1:
						if GetKeyState(PatternClickerHotkey, "P") {
							KeyPressed := true
						}
					case countParseHK == 2:
						if GetKeyState(PatternClickerHotkey1, "P") and 
							GetKeyState(PatternClickerHotkey, "P") {
							KeyPressed := true
						}
					case countParseHK == 3:
						if GetKeyState(PatternClickerHotkey1, "P") and
							GetKeyState(PatternClickerHotkey2, "P") and
							GetKeyState(PatternClickerHotkey, "P") {
							KeyPressed := true	
						}
					}
					if KeyPressed == true {
						KeyPressed := false
						break
					}
					;------------------------------
					if Position6.EditRadioYes.Value == true {
						Position6.RadioNo := false
						DllCall("SetCursorPos", "int", CoordX6, "int", CoordY6)
						SendKey
						sleep Coord6Interval
					}
					switch true {
					case countParseHK == 1:
						if GetKeyState(PatternClickerHotkey, "P") {
							KeyPressed := true
						}
					case countParseHK == 2:
						if GetKeyState(PatternClickerHotkey1, "P") and 
							GetKeyState(PatternClickerHotkey, "P") {
							KeyPressed := true
						}
					case countParseHK == 3:
						if GetKeyState(PatternClickerHotkey1, "P") and
							GetKeyState(PatternClickerHotkey2, "P") and
							GetKeyState(PatternClickerHotkey, "P") {
							KeyPressed := true	
						}
					}
					if KeyPressed == true {
						KeyPressed := false
						break
					}
					;------------------------------
					if Position7.EditRadioYes.Value == true {
						Position7.RadioNo := false
						DllCall("SetCursorPos", "int", CoordX7, "int", CoordY7)
						SendKey
						sleep Coord7Interval
					}
					switch true {
					case countParseHK == 1:
						if GetKeyState(PatternClickerHotkey, "P") {
							KeyPressed := true
						}
					case countParseHK == 2:
						if GetKeyState(PatternClickerHotkey1, "P") and 
							GetKeyState(PatternClickerHotkey, "P") {
							KeyPressed := true
						}
					case countParseHK == 3:
						if GetKeyState(PatternClickerHotkey1, "P") and
							GetKeyState(PatternClickerHotkey2, "P") and
							GetKeyState(PatternClickerHotkey, "P") {
							KeyPressed := true	
						}
					}
					if KeyPressed == true {
						KeyPressed := false
						break
					}
					;------------------------------
					if Position8.EditRadioYes.Value == true {
						Position8.RadioNo := false
						DllCall("SetCursorPos", "int", CoordX8, "int", CoordY8)
						SendKey
						sleep Coord8Interval
					}
					switch true {
					case countParseHK == 1:
						if GetKeyState(PatternClickerHotkey, "P") {
							KeyPressed := true
						}
					case countParseHK == 2:
						if GetKeyState(PatternClickerHotkey1, "P") and 
							GetKeyState(PatternClickerHotkey, "P") {
							KeyPressed := true
						}
					case countParseHK == 3:
						if GetKeyState(PatternClickerHotkey1, "P") and
							GetKeyState(PatternClickerHotkey2, "P") and
							GetKeyState(PatternClickerHotkey, "P") {
							KeyPressed := true	
						}
					}
					if KeyPressed == true {
						KeyPressed := false
						break
					}
					;------------------------------
					if Position9.EditRadioYes.Value == true {
						Position9.RadioNo := false
						DllCall("SetCursorPos", "int", CoordX9, "int", CoordY9)
						SendKey
						sleep Coord9Interval
					}
					switch true {
					case countParseHK == 1:
						if GetKeyState(PatternClickerHotkey, "P") {
							KeyPressed := true
						}
					case countParseHK == 2:
						if GetKeyState(PatternClickerHotkey1, "P") and 
							GetKeyState(PatternClickerHotkey, "P") {
							KeyPressed := true
						}
					case countParseHK == 3:
						if GetKeyState(PatternClickerHotkey1, "P") and
							GetKeyState(PatternClickerHotkey2, "P") and
							GetKeyState(PatternClickerHotkey, "P") {
							KeyPressed := true	
						}
					}
					if KeyPressed == true {
						KeyPressed := false
						break
					}
					;------------------------------
					if Position10.EditRadioYes.Value == true {
						Position10.RadioNo := false
						DllCall("SetCursorPos", "int", CoordX10, "int", CoordY10)
						SendKey
						sleep Coord10Interval
					}
					switch true {
					case countParseHK == 1:
						if GetKeyState(PatternClickerHotkey, "P") {
							KeyPressed := true
						}
					case countParseHK == 2:
						if GetKeyState(PatternClickerHotkey1, "P") and 
							GetKeyState(PatternClickerHotkey, "P") {
							KeyPressed := true
						}
					case countParseHK == 3:
						if GetKeyState(PatternClickerHotkey1, "P") and
							GetKeyState(PatternClickerHotkey2, "P") and
							GetKeyState(PatternClickerHotkey, "P") {
							KeyPressed := true	
						}
					}
					if KeyPressed == true {
						KeyPressed := false
						break
					}
					;------------------------------
					if Position11.EditRadioYes.Value == true {
						Position11.RadioNo := false
						DllCall("SetCursorPos", "int", CoordX11, "int", CoordY11)
						SendKey
						sleep Coord11Interval
					}
					switch true {
					case countParseHK == 1:
						if GetKeyState(PatternClickerHotkey, "P") {
							KeyPressed := true
						}
					case countParseHK == 2:
						if GetKeyState(PatternClickerHotkey1, "P") and 
							GetKeyState(PatternClickerHotkey, "P") {
							KeyPressed := true
						}
					case countParseHK == 3:
						if GetKeyState(PatternClickerHotkey1, "P") and
							GetKeyState(PatternClickerHotkey2, "P") and
							GetKeyState(PatternClickerHotkey, "P") {
							KeyPressed := true	
						}
					}
					if KeyPressed == true {
						KeyPressed := false
						break
					}
					;------------------------------
					if Position12.EditRadioYes.Value == true {
						Position12.RadioNo := false
						DllCall("SetCursorPos", "int", CoordX12, "int", CoordY12)
						SendKey
						sleep Coord12Interval
					}
					switch true {
					case countParseHK == 1:
						if GetKeyState(PatternClickerHotkey, "P") {
							KeyPressed := true
						}
					case countParseHK == 2:
						if GetKeyState(PatternClickerHotkey1, "P") and 
							GetKeyState(PatternClickerHotkey, "P") {
							KeyPressed := true
						}
					case countParseHK == 3:
						if GetKeyState(PatternClickerHotkey1, "P") and
							GetKeyState(PatternClickerHotkey2, "P") and
							GetKeyState(PatternClickerHotkey, "P") {
							KeyPressed := true	
						}
					}
					if KeyPressed == true {
						KeyPressed := false
						break
					}
					;------------------------------
					if Position13.EditRadioYes.Value == true {
						Position13.RadioNo := false
						DllCall("SetCursorPos", "int", CoordX13, "int", CoordY13)
						SendKey
						sleep Coord13Interval
					}
					switch true {
					case countParseHK == 1:
						if GetKeyState(PatternClickerHotkey, "P") {
							KeyPressed := true
						}
					case countParseHK == 2:
						if GetKeyState(PatternClickerHotkey1, "P") and 
							GetKeyState(PatternClickerHotkey, "P") {
							KeyPressed := true
						}
					case countParseHK == 3:
						if GetKeyState(PatternClickerHotkey1, "P") and
							GetKeyState(PatternClickerHotkey2, "P") and
							GetKeyState(PatternClickerHotkey, "P") {
							KeyPressed := true	
						}
					}
					if KeyPressed == true {
						KeyPressed := false
						break
					}
					;------------------------------
					if Position14.EditRadioYes.Value == true {
						Position14.RadioNo := false
						DllCall("SetCursorPos", "int", CoordX14, "int", CoordY14)
						SendKey
						sleep Coord14Interval
					}
					switch true {
					case countParseHK == 1:
						if GetKeyState(PatternClickerHotkey, "P") {
							KeyPressed := true
						}
					case countParseHK == 2:
						if GetKeyState(PatternClickerHotkey1, "P") and 
							GetKeyState(PatternClickerHotkey, "P") {
							KeyPressed := true
						}
					case countParseHK == 3:
						if GetKeyState(PatternClickerHotkey1, "P") and
							GetKeyState(PatternClickerHotkey2, "P") and
							GetKeyState(PatternClickerHotkey, "P") {
							KeyPressed := true	
						}
					}
					if KeyPressed == true {
						KeyPressed := false
						break
					}
					;------------------------------
					if Position15.EditRadioYes.Value == true {
						Position15.RadioNo := false
						DllCall("SetCursorPos", "int", CoordX15, "int", CoordY15)
						SendKey
						sleep Coord15Interval
					}
					switch true {
					case countParseHK == 1:
						if GetKeyState(PatternClickerHotkey, "P") {
							KeyPressed := true
						}
					case countParseHK == 2:
						if GetKeyState(PatternClickerHotkey1, "P") and 
							GetKeyState(PatternClickerHotkey, "P") {
							KeyPressed := true
						}
					case countParseHK == 3:
						if GetKeyState(PatternClickerHotkey1, "P") and
							GetKeyState(PatternClickerHotkey2, "P") and
							GetKeyState(PatternClickerHotkey, "P") {
							KeyPressed := true	
						}
					}
					if KeyPressed == true {
						KeyPressed := false
						break
					}
					;------------------------------
					if Position16.EditRadioYes.Value == true {
						Position16.RadioNo := false
						DllCall("SetCursorPos", "int", CoordX16, "int", CoordY16)
						SendKey
						sleep Coord16Interval
					}
					switch true {
					case countParseHK == 1:
						if GetKeyState(PatternClickerHotkey, "P") {
							KeyPressed := true
						}
					case countParseHK == 2:
						if GetKeyState(PatternClickerHotkey1, "P") and 
							GetKeyState(PatternClickerHotkey, "P") {
							KeyPressed := true
						}
					case countParseHK == 3:
						if GetKeyState(PatternClickerHotkey1, "P") and
							GetKeyState(PatternClickerHotkey2, "P") and
							GetKeyState(PatternClickerHotkey, "P") {
							KeyPressed := true	
						}
					}
					if KeyPressed == true {
						KeyPressed := false
						break
					}
					;------------------------------
					if Position17.EditRadioYes.Value == true {
						Position17.RadioNo := false
						DllCall("SetCursorPos", "int", CoordX17, "int", CoordY17)
						SendKey
						sleep Coord17Interval
					}
					switch true {
					case countParseHK == 1:
						if GetKeyState(PatternClickerHotkey, "P") {
							KeyPressed := true
						}
					case countParseHK == 2:
						if GetKeyState(PatternClickerHotkey1, "P") and 
							GetKeyState(PatternClickerHotkey, "P") {
							KeyPressed := true
						}
					case countParseHK == 3:
						if GetKeyState(PatternClickerHotkey1, "P") and
							GetKeyState(PatternClickerHotkey2, "P") and
							GetKeyState(PatternClickerHotkey, "P") {
							KeyPressed := true	
						}
					}
					if KeyPressed == true {
						KeyPressed := false
						break
					}
					;------------------------------
					if Position18.EditRadioYes.Value == true {
						Position18.RadioNo := false
						DllCall("SetCursorPos", "int", CoordX18, "int", CoordY18)
						SendKey
						sleep Coord18Interval
					}
					switch true {
					case countParseHK == 1:
						if GetKeyState(PatternClickerHotkey, "P") {
							KeyPressed := true
						}
					case countParseHK == 2:
						if GetKeyState(PatternClickerHotkey1, "P") and 
							GetKeyState(PatternClickerHotkey, "P") {
							KeyPressed := true
						}
					case countParseHK == 3:
						if GetKeyState(PatternClickerHotkey1, "P") and
							GetKeyState(PatternClickerHotkey2, "P") and
							GetKeyState(PatternClickerHotkey, "P") {
							KeyPressed := true	
						}
					}
					if KeyPressed == true {
						KeyPressed := false
						break
					}
					;------------------------------
					if Position19.EditRadioYes.Value == true {
						Position19.RadioNo := false
						DllCall("SetCursorPos", "int", CoordX19, "int", CoordY19)
						SendKey
						sleep Coord19Interval
					}
					switch true {
					case countParseHK == 1:
						if GetKeyState(PatternClickerHotkey, "P") {
							KeyPressed := true
						}
					case countParseHK == 2:
						if GetKeyState(PatternClickerHotkey1, "P") and 
							GetKeyState(PatternClickerHotkey, "P") {
							KeyPressed := true
						}
					case countParseHK == 3:
						if GetKeyState(PatternClickerHotkey1, "P") and
							GetKeyState(PatternClickerHotkey2, "P") and
							GetKeyState(PatternClickerHotkey, "P") {
							KeyPressed := true	
						}
					}
					if KeyPressed == true {
						KeyPressed := false
						break
					}
					;------------------------------
					if Position20.EditRadioYes.Value == true {
						Position20.RadioNo := false
						DllCall("SetCursorPos", "int", CoordX20, "int", CoordY20)
						SendKey
						sleep Coord20Interval
					}
					switch true {
					case countParseHK == 1:
						if GetKeyState(PatternClickerHotkey, "P") {
							KeyPressed := true
						}
					case countParseHK == 2:
						if GetKeyState(PatternClickerHotkey1, "P") and 
							GetKeyState(PatternClickerHotkey, "P") {
							KeyPressed := true
						}
					case countParseHK == 3:
						if GetKeyState(PatternClickerHotkey1, "P") and
							GetKeyState(PatternClickerHotkey2, "P") and
							GetKeyState(PatternClickerHotkey, "P") {
							KeyPressed := true	
						}
					}
					if KeyPressed == true {
						KeyPressed := false
						break
					}
					;------------------------------
					if Position21.EditRadioYes.Value == true {
						Position21.RadioNo := false
						DllCall("SetCursorPos", "int", CoordX21, "int", CoordY21)
						SendKey
						sleep Coord21Interval
					}
					switch true {
					case countParseHK == 1:
						if GetKeyState(PatternClickerHotkey, "P") {
							KeyPressed := true
						}
					case countParseHK == 2:
						if GetKeyState(PatternClickerHotkey1, "P") and 
							GetKeyState(PatternClickerHotkey, "P") {
							KeyPressed := true
						}
					case countParseHK == 3:
						if GetKeyState(PatternClickerHotkey1, "P") and
							GetKeyState(PatternClickerHotkey2, "P") and
							GetKeyState(PatternClickerHotkey, "P") {
							KeyPressed := true	
						}
					}
					if KeyPressed == true {
						KeyPressed := false
						break
					}
					;------------------------------
					if Position22.EditRadioYes.Value == true {
						Position22.RadioNo := false
						DllCall("SetCursorPos", "int", CoordX22, "int", CoordY22)
						SendKey
						sleep Coord22Interval
					}
					switch true {
					case countParseHK == 1:
						if GetKeyState(PatternClickerHotkey, "P") {
							KeyPressed := true
						}
					case countParseHK == 2:
						if GetKeyState(PatternClickerHotkey1, "P") and 
							GetKeyState(PatternClickerHotkey, "P") {
							KeyPressed := true
						}
					case countParseHK == 3:
						if GetKeyState(PatternClickerHotkey1, "P") and
							GetKeyState(PatternClickerHotkey2, "P") and
							GetKeyState(PatternClickerHotkey, "P") {
							KeyPressed := true	
						}
					}
					if KeyPressed == true {
						KeyPressed := false
						break
					}
					;------------------------------
					Count++
					SB.SetText("Pattern Clicker Active. Count: " Count)
					sleep Random(ClickInterval, ClickInterval + RandomOffset)
				} ; End Loop
			}
			toggle := !toggle
			TextPatternClickerOnOff.Value := " OFF"
			SB.SetText("Clicker Stopped. Count: " Count)
			sleep StopDelay
			return
		case RadioPos1_10AnyYes == true or RadioPos11_22AnyYes == true:
			SB.SetText("Infinite Pattern Clicker Active. Count: " Count)
			sleep StartDelay
			Loop {
				if Position1.EditRadioYes.Value == true {
					Position1.RadioNo := false
					DllCall("SetCursorPos", "int", CoordX1, "int", CoordY1)
					SendKey
					sleep Coord1Interval
				}
				switch true {
				case countParseHK == 1:
					if GetKeyState(PatternClickerHotkey, "P") {
						KeyPressed := true
					}
				case countParseHK == 2:
					if GetKeyState(PatternClickerHotkey1, "P") and 
						GetKeyState(PatternClickerHotkey, "P") {
						KeyPressed := true
					}
				case countParseHK == 3:
					if GetKeyState(PatternClickerHotkey1, "P") and
						GetKeyState(PatternClickerHotkey2, "P") and
						GetKeyState(PatternClickerHotkey, "P") {
						KeyPressed := true	
					}
				}
				if KeyPressed == true {
					KeyPressed := false
					break
				}
				;------------------------------
				if Position2.EditRadioYes.Value == true {
					Position2.RadioNo := false
					DllCall("SetCursorPos", "int", CoordX2, "int", CoordY2)
					SendKey
					sleep Coord2Interval
				}
				switch true {
				case countParseHK == 1:
					if GetKeyState(PatternClickerHotkey, "P") {
						KeyPressed := true
					}
				case countParseHK == 2:
					if GetKeyState(PatternClickerHotkey1, "P") and 
						GetKeyState(PatternClickerHotkey, "P") {
						KeyPressed := true
					}
				case countParseHK == 3:
					if GetKeyState(PatternClickerHotkey1, "P") and
						GetKeyState(PatternClickerHotkey2, "P") and
						GetKeyState(PatternClickerHotkey, "P") {
						KeyPressed := true	
					}
				}
				if KeyPressed == true {
					KeyPressed := false
					break
				}
				;------------------------------
				if Position3.EditRadioYes.Value == true {
					Position3.RadioNo := false
					DllCall("SetCursorPos", "int", CoordX3, "int", CoordY3)
					SendKey
					sleep Coord3Interval
				}
				switch true {
				case countParseHK == 1:
					if GetKeyState(PatternClickerHotkey, "P") {
						KeyPressed := true
					}
				case countParseHK == 2:
					if GetKeyState(PatternClickerHotkey1, "P") and 
						GetKeyState(PatternClickerHotkey, "P") {
						KeyPressed := true
					}
				case countParseHK == 3:
					if GetKeyState(PatternClickerHotkey1, "P") and
						GetKeyState(PatternClickerHotkey2, "P") and
						GetKeyState(PatternClickerHotkey, "P") {
						KeyPressed := true	
					}
				}
				if KeyPressed == true {
					KeyPressed := false
					break
				}
				;------------------------------
				if Position4.EditRadioYes.Value == true {
					Position4.RadioNo := false
					DllCall("SetCursorPos", "int", CoordX4, "int", CoordY4)
					SendKey
					sleep Coord4Interval
				}
				switch true {
				case countParseHK == 1:
					if GetKeyState(PatternClickerHotkey, "P") {
						KeyPressed := true
					}
				case countParseHK == 2:
					if GetKeyState(PatternClickerHotkey1, "P") and 
						GetKeyState(PatternClickerHotkey, "P") {
						KeyPressed := true
					}
				case countParseHK == 3:
					if GetKeyState(PatternClickerHotkey1, "P") and
						GetKeyState(PatternClickerHotkey2, "P") and
						GetKeyState(PatternClickerHotkey, "P") {
						KeyPressed := true	
					}
				}
				if KeyPressed == true {
					KeyPressed := false
					break
				}
				;------------------------------
				if Position5.EditRadioYes.Value == true {
					Position5.RadioNo := false
					DllCall("SetCursorPos", "int", CoordX5, "int", CoordY5)
					SendKey
					sleep Coord5Interval
				}
				switch true {
				case countParseHK == 1:
					if GetKeyState(PatternClickerHotkey, "P") {
						KeyPressed := true
					}
				case countParseHK == 2:
					if GetKeyState(PatternClickerHotkey1, "P") and 
						GetKeyState(PatternClickerHotkey, "P") {
						KeyPressed := true
					}
				case countParseHK == 3:
					if GetKeyState(PatternClickerHotkey1, "P") and
						GetKeyState(PatternClickerHotkey2, "P") and
						GetKeyState(PatternClickerHotkey, "P") {
						KeyPressed := true	
					}
				}
				if KeyPressed == true {
					KeyPressed := false
					break
				}
				;------------------------------
				if Position6.EditRadioYes.Value == true {
					Position6.RadioNo := false
					DllCall("SetCursorPos", "int", CoordX6, "int", CoordY6)
					SendKey
					sleep Coord6Interval
				}
				switch true {
				case countParseHK == 1:
					if GetKeyState(PatternClickerHotkey, "P") {
						KeyPressed := true
					}
				case countParseHK == 2:
					if GetKeyState(PatternClickerHotkey1, "P") and 
						GetKeyState(PatternClickerHotkey, "P") {
						KeyPressed := true
					}
				case countParseHK == 3:
					if GetKeyState(PatternClickerHotkey1, "P") and
						GetKeyState(PatternClickerHotkey2, "P") and
						GetKeyState(PatternClickerHotkey, "P") {
						KeyPressed := true	
					}
				}
				if KeyPressed == true {
					KeyPressed := false
					break
				}
				;------------------------------
				if Position7.EditRadioYes.Value == true {
					Position7.RadioNo := false
					DllCall("SetCursorPos", "int", CoordX7, "int", CoordY7)
					SendKey
					sleep Coord7Interval
				}
				switch true {
				case countParseHK == 1:
					if GetKeyState(PatternClickerHotkey, "P") {
						KeyPressed := true
					}
				case countParseHK == 2:
					if GetKeyState(PatternClickerHotkey1, "P") and 
						GetKeyState(PatternClickerHotkey, "P") {
						KeyPressed := true
					}
				case countParseHK == 3:
					if GetKeyState(PatternClickerHotkey1, "P") and
						GetKeyState(PatternClickerHotkey2, "P") and
						GetKeyState(PatternClickerHotkey, "P") {
						KeyPressed := true	
					}
				}
				if KeyPressed == true {
					KeyPressed := false
					break
				}
				;------------------------------
				if Position8.EditRadioYes.Value == true {
					Position8.RadioNo := false
					DllCall("SetCursorPos", "int", CoordX8, "int", CoordY8)
					SendKey
					sleep Coord8Interval
				}
				switch true {
				case countParseHK == 1:
					if GetKeyState(PatternClickerHotkey, "P") {
						KeyPressed := true
					}
				case countParseHK == 2:
					if GetKeyState(PatternClickerHotkey1, "P") and 
						GetKeyState(PatternClickerHotkey, "P") {
						KeyPressed := true
					}
				case countParseHK == 3:
					if GetKeyState(PatternClickerHotkey1, "P") and
						GetKeyState(PatternClickerHotkey2, "P") and
						GetKeyState(PatternClickerHotkey, "P") {
						KeyPressed := true	
					}
				}
				if KeyPressed == true {
					KeyPressed := false
					break
				}
				;------------------------------
				if Position9.EditRadioYes.Value == true {
					Position9.RadioNo := false
					DllCall("SetCursorPos", "int", CoordX9, "int", CoordY9)
					SendKey
					sleep Coord9Interval
				}
				switch true {
				case countParseHK == 1:
					if GetKeyState(PatternClickerHotkey, "P") {
						KeyPressed := true
					}
				case countParseHK == 2:
					if GetKeyState(PatternClickerHotkey1, "P") and 
						GetKeyState(PatternClickerHotkey, "P") {
						KeyPressed := true
					}
				case countParseHK == 3:
					if GetKeyState(PatternClickerHotkey1, "P") and
						GetKeyState(PatternClickerHotkey2, "P") and
						GetKeyState(PatternClickerHotkey, "P") {
						KeyPressed := true	
					}
				}
				if KeyPressed == true {
					KeyPressed := false
					break
				}
				;------------------------------
				if Position10.EditRadioYes.Value == true {
					Position10.RadioNo := false
					DllCall("SetCursorPos", "int", CoordX10, "int", CoordY10)
					SendKey
					sleep Coord10Interval
				}
				switch true {
				case countParseHK == 1:
					if GetKeyState(PatternClickerHotkey, "P") {
						KeyPressed := true
					}
				case countParseHK == 2:
					if GetKeyState(PatternClickerHotkey1, "P") and 
						GetKeyState(PatternClickerHotkey, "P") {
						KeyPressed := true
					}
				case countParseHK == 3:
					if GetKeyState(PatternClickerHotkey1, "P") and
						GetKeyState(PatternClickerHotkey2, "P") and
						GetKeyState(PatternClickerHotkey, "P") {
						KeyPressed := true	
					}
				}
				if KeyPressed == true {
					KeyPressed := false
					break
				}
				;------------------------------
				if Position11.EditRadioYes.Value == true {
					Position11.RadioNo := false
					DllCall("SetCursorPos", "int", CoordX11, "int", CoordY11)
					SendKey
					sleep Coord11Interval
				}
				switch true {
				case countParseHK == 1:
					if GetKeyState(PatternClickerHotkey, "P") {
						KeyPressed := true
					}
				case countParseHK == 2:
					if GetKeyState(PatternClickerHotkey1, "P") and 
						GetKeyState(PatternClickerHotkey, "P") {
						KeyPressed := true
					}
				case countParseHK == 3:
					if GetKeyState(PatternClickerHotkey1, "P") and
						GetKeyState(PatternClickerHotkey2, "P") and
						GetKeyState(PatternClickerHotkey, "P") {
						KeyPressed := true	
					}
				}
				if KeyPressed == true {
					KeyPressed := false
					break
				}
				;------------------------------
				if Position12.EditRadioYes.Value == true {
					Position12.RadioNo := false
					DllCall("SetCursorPos", "int", CoordX12, "int", CoordY12)
					SendKey
					sleep Coord12Interval
				}
				switch true {
				case countParseHK == 1:
					if GetKeyState(PatternClickerHotkey, "P") {
						KeyPressed := true
					}
				case countParseHK == 2:
					if GetKeyState(PatternClickerHotkey1, "P") and 
						GetKeyState(PatternClickerHotkey, "P") {
						KeyPressed := true
					}
				case countParseHK == 3:
					if GetKeyState(PatternClickerHotkey1, "P") and
						GetKeyState(PatternClickerHotkey2, "P") and
						GetKeyState(PatternClickerHotkey, "P") {
						KeyPressed := true	
					}
				}
				if KeyPressed == true {
					KeyPressed := false
					break
				}
				;------------------------------
				if Position13.EditRadioYes.Value == true {
					Position13.RadioNo := false
					DllCall("SetCursorPos", "int", CoordX13, "int", CoordY13)
					SendKey
					sleep Coord13Interval
				}
				switch true {
				case countParseHK == 1:
					if GetKeyState(PatternClickerHotkey, "P") {
						KeyPressed := true
					}
				case countParseHK == 2:
					if GetKeyState(PatternClickerHotkey1, "P") and 
						GetKeyState(PatternClickerHotkey, "P") {
						KeyPressed := true
					}
				case countParseHK == 3:
					if GetKeyState(PatternClickerHotkey1, "P") and
						GetKeyState(PatternClickerHotkey2, "P") and
						GetKeyState(PatternClickerHotkey, "P") {
						KeyPressed := true	
					}
				}
				if KeyPressed == true {
					KeyPressed := false
					break
				}
				;------------------------------
				if Position14.EditRadioYes.Value == true {
					Position14.RadioNo := false
					DllCall("SetCursorPos", "int", CoordX14, "int", CoordY14)
					SendKey
					sleep Coord14Interval
				}
				switch true {
				case countParseHK == 1:
					if GetKeyState(PatternClickerHotkey, "P") {
						KeyPressed := true
					}
				case countParseHK == 2:
					if GetKeyState(PatternClickerHotkey1, "P") and 
						GetKeyState(PatternClickerHotkey, "P") {
						KeyPressed := true
					}
				case countParseHK == 3:
					if GetKeyState(PatternClickerHotkey1, "P") and
						GetKeyState(PatternClickerHotkey2, "P") and
						GetKeyState(PatternClickerHotkey, "P") {
						KeyPressed := true	
					}
				}
				if KeyPressed == true {
					KeyPressed := false
					break
				}
				;------------------------------
				if Position15.EditRadioYes.Value == true {
					Position15.RadioNo := false
					DllCall("SetCursorPos", "int", CoordX15, "int", CoordY15)
					SendKey
					sleep Coord15Interval
				}
				switch true {
				case countParseHK == 1:
					if GetKeyState(PatternClickerHotkey, "P") {
						KeyPressed := true
					}
				case countParseHK == 2:
					if GetKeyState(PatternClickerHotkey1, "P") and 
						GetKeyState(PatternClickerHotkey, "P") {
						KeyPressed := true
					}
				case countParseHK == 3:
					if GetKeyState(PatternClickerHotkey1, "P") and
						GetKeyState(PatternClickerHotkey2, "P") and
						GetKeyState(PatternClickerHotkey, "P") {
						KeyPressed := true	
					}
				}
				if KeyPressed == true {
					KeyPressed := false
					break
				}
				;------------------------------
				if Position16.EditRadioYes.Value == true {
					Position16.RadioNo := false
					DllCall("SetCursorPos", "int", CoordX16, "int", CoordY16)
					SendKey
					sleep Coord16Interval
				}
				switch true {
				case countParseHK == 1:
					if GetKeyState(PatternClickerHotkey, "P") {
						KeyPressed := true
					}
				case countParseHK == 2:
					if GetKeyState(PatternClickerHotkey1, "P") and 
						GetKeyState(PatternClickerHotkey, "P") {
						KeyPressed := true
					}
				case countParseHK == 3:
					if GetKeyState(PatternClickerHotkey1, "P") and
						GetKeyState(PatternClickerHotkey2, "P") and
						GetKeyState(PatternClickerHotkey, "P") {
						KeyPressed := true	
					}
				}
				if KeyPressed == true {
					KeyPressed := false
					break
				}
				;------------------------------
				if Position17.EditRadioYes.Value == true {
					Position17.RadioNo := false
					DllCall("SetCursorPos", "int", CoordX17, "int", CoordY17)
					SendKey
					sleep Coord17Interval
				}
				switch true {
				case countParseHK == 1:
					if GetKeyState(PatternClickerHotkey, "P") {
						KeyPressed := true
					}
				case countParseHK == 2:
					if GetKeyState(PatternClickerHotkey1, "P") and 
						GetKeyState(PatternClickerHotkey, "P") {
						KeyPressed := true
					}
				case countParseHK == 3:
					if GetKeyState(PatternClickerHotkey1, "P") and
						GetKeyState(PatternClickerHotkey2, "P") and
						GetKeyState(PatternClickerHotkey, "P") {
						KeyPressed := true	
					}
				}
				if KeyPressed == true {
					KeyPressed := false
					break
				}
				;------------------------------
				if Position18.EditRadioYes.Value == true {
					Position18.RadioNo := false
					DllCall("SetCursorPos", "int", CoordX18, "int", CoordY18)
					SendKey
					sleep Coord18Interval
				}
				switch true {
				case countParseHK == 1:
					if GetKeyState(PatternClickerHotkey, "P") {
						KeyPressed := true
					}
				case countParseHK == 2:
					if GetKeyState(PatternClickerHotkey1, "P") and 
						GetKeyState(PatternClickerHotkey, "P") {
						KeyPressed := true
					}
				case countParseHK == 3:
					if GetKeyState(PatternClickerHotkey1, "P") and
						GetKeyState(PatternClickerHotkey2, "P") and
						GetKeyState(PatternClickerHotkey, "P") {
						KeyPressed := true	
					}
				}
				if KeyPressed == true {
					KeyPressed := false
					break
				}
				;------------------------------
				if Position19.EditRadioYes.Value == true {
					Position19.RadioNo := false
					DllCall("SetCursorPos", "int", CoordX19, "int", CoordY19)
					SendKey
					sleep Coord19Interval
				}
				switch true {
				case countParseHK == 1:
					if GetKeyState(PatternClickerHotkey, "P") {
						KeyPressed := true
					}
				case countParseHK == 2:
					if GetKeyState(PatternClickerHotkey1, "P") and 
						GetKeyState(PatternClickerHotkey, "P") {
						KeyPressed := true
					}
				case countParseHK == 3:
					if GetKeyState(PatternClickerHotkey1, "P") and
						GetKeyState(PatternClickerHotkey2, "P") and
						GetKeyState(PatternClickerHotkey, "P") {
						KeyPressed := true	
					}
				}
				if KeyPressed == true {
					KeyPressed := false
					break
				}
				;------------------------------
				if Position20.EditRadioYes.Value == true {
					Position20.RadioNo := false
					DllCall("SetCursorPos", "int", CoordX20, "int", CoordY20)
					SendKey
					sleep Coord20Interval
				}
				switch true {
				case countParseHK == 1:
					if GetKeyState(PatternClickerHotkey, "P") {
						KeyPressed := true
					}
				case countParseHK == 2:
					if GetKeyState(PatternClickerHotkey1, "P") and 
						GetKeyState(PatternClickerHotkey, "P") {
						KeyPressed := true
					}
				case countParseHK == 3:
					if GetKeyState(PatternClickerHotkey1, "P") and
						GetKeyState(PatternClickerHotkey2, "P") and
						GetKeyState(PatternClickerHotkey, "P") {
						KeyPressed := true	
					}
				}
				if KeyPressed == true {
					KeyPressed := false
					break
				}
				;------------------------------
				if Position21.EditRadioYes.Value == true {
					Position21.RadioNo := false
					DllCall("SetCursorPos", "int", CoordX21, "int", CoordY21)
					SendKey
					sleep Coord21Interval
				}
				switch true {
				case countParseHK == 1:
					if GetKeyState(PatternClickerHotkey, "P") {
						KeyPressed := true
					}
				case countParseHK == 2:
					if GetKeyState(PatternClickerHotkey1, "P") and 
						GetKeyState(PatternClickerHotkey, "P") {
						KeyPressed := true
					}
				case countParseHK == 3:
					if GetKeyState(PatternClickerHotkey1, "P") and
						GetKeyState(PatternClickerHotkey2, "P") and
						GetKeyState(PatternClickerHotkey, "P") {
						KeyPressed := true	
					}
				}
				if KeyPressed == true {
					KeyPressed := false
					break
				}
				;------------------------------
				if Position22.EditRadioYes.Value == true {
					Position22.RadioNo := false
					DllCall("SetCursorPos", "int", CoordX22, "int", CoordY22)
					SendKey
					sleep Coord22Interval
				}
				switch true {
				case countParseHK == 1:
					if GetKeyState(PatternClickerHotkey, "P") {
						KeyPressed := true
					}
				case countParseHK == 2:
					if GetKeyState(PatternClickerHotkey1, "P") and 
						GetKeyState(PatternClickerHotkey, "P") {
						KeyPressed := true
					}
				case countParseHK == 3:
					if GetKeyState(PatternClickerHotkey1, "P") and
						GetKeyState(PatternClickerHotkey2, "P") and
						GetKeyState(PatternClickerHotkey, "P") {
						KeyPressed := true	
					}
				}
				if KeyPressed == true {
					KeyPressed := false
					break
				}
				;------------------------------
				Count++
				SB.SetText("Infinite Pattern Clicker Active. Count: " Count)
			} ; End Loop
			toggle := !toggle
			TextPatternClickerOnOff.Value := " OFF"
			SB.SetText("Clicker Stopped. Count: " Count)
			sleep StopDelay
			return
		Default:
			SB.SetText("Infinite Clicker Active. Count: 0")
			sleep StartDelay
			SetTimer(SendKey, Random(ClickInterval, ClickInterval + RandomOffset))
			return
		}
	} else {
		TextPatternClickerOnOff.Value := " OFF"
		SetTimer(SendKey, 0)
	}
}
