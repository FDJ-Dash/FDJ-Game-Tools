;------------- Credits ------------
; Creator: Fernando Daniel Jaime.
; Programmer Alias: FDJ-Dash.
;------------- File Details ------------
; App Name: Task Automator.
; File Description: This file contains all submit handlers.
;----------------------------------------------------
; Header list:
;----------------------------------------------------
; SubmitJumpHotkey0(*)
; SubmitJumpHotkey1(*)
; SubmitJumpHotkey2(*)
; SubmitJumpHotkey3(*)
; SubmitJumpHotkey4(*)
; SubmitQuickAccess1(*)
; SubmitQuickAccess2(*)
; SubmitQuickAccess3(*)
; SubmitQuickAccess4(*)
; SubmitQuickAccess5(*)
; SubmitQuickAccess6(*)
; SubmitQuickAccess7(*)
; SubmitQuickAccess8(*)
; SubmitQuickAccess9(*)
; SubmitAutoRunHotkey(*)
; SubmitStopAutoRunHotkey(*)
; SubmitPatternClickerHotkey(*)
; SubmitValues(*)
; ClearValuesXY(*)
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
	GuiName := IniRead(TempSystemFile, "GeneralData", "GuiName")
	if GuiName == "TaskAutomatorGui1" {
		Saved := TaskAutomatorGui1.Submit(false)
	} else {
		Saved := TaskAutomatorGui2.Submit(false)
	}
	IniWrite Saved.JumpHotkey0, IniFile, "SavedHotkey", "JumpHotkey0"
	Reload
}
;----------------------------------------------------
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
	GuiName := IniRead(TempSystemFile, "GeneralData", "GuiName")
	if GuiName == "TaskAutomatorGui1" {
		Saved := TaskAutomatorGui1.Submit(false)
	} else {
		Saved := TaskAutomatorGui2.Submit(false)
	}
	IniWrite Saved.JumpHotkey1, IniFile, "SavedHotkey", "JumpHotkey1"
	Reload
}
;----------------------------------------------------
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
	GuiName := IniRead(TempSystemFile, "GeneralData", "GuiName")
	if GuiName == "TaskAutomatorGui1" {
		Saved := TaskAutomatorGui1.Submit(false)
	} else {
		Saved := TaskAutomatorGui2.Submit(false)
	}
	IniWrite Saved.JumpHotkey2, IniFile, "SavedHotkey", "JumpHotkey2"
	Reload
}
;----------------------------------------------------
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
	GuiName := IniRead(TempSystemFile, "GeneralData", "GuiName")
	if GuiName == "TaskAutomatorGui1" {
		Saved := TaskAutomatorGui1.Submit(false)
	} else {
		Saved := TaskAutomatorGui2.Submit(false)
	}
	IniWrite Saved.JumpHotkey3, IniFile, "SavedHotkey", "JumpHotkey3"
	Reload
}
;----------------------------------------------------
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
	GuiName := IniRead(TempSystemFile, "GeneralData", "GuiName")
	if GuiName == "TaskAutomatorGui1" {
		Saved := TaskAutomatorGui1.Submit(false)
	} else {
		Saved := TaskAutomatorGui2.Submit(false)
	}
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
	GuiName := IniRead(TempSystemFile, "GeneralData", "GuiName")
	if GuiName == "TaskAutomatorGui1" {
		Saved := TaskAutomatorGui1.Submit(false)
	} else {
		Saved := TaskAutomatorGui2.Submit(false)
	}
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
	GuiName := IniRead(TempSystemFile, "GeneralData", "GuiName")
	if GuiName == "TaskAutomatorGui1" {
		Saved := TaskAutomatorGui1.Submit(false)
	} else {
		Saved := TaskAutomatorGui2.Submit(false)
	}
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
	GuiName := IniRead(TempSystemFile, "GeneralData", "GuiName")
	if GuiName == "TaskAutomatorGui1" {
		Saved := TaskAutomatorGui1.Submit(false)
	} else {
		Saved := TaskAutomatorGui2.Submit(false)
	}
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
	GuiName := IniRead(TempSystemFile, "GeneralData", "GuiName")
	if GuiName == "TaskAutomatorGui1" {
		Saved := TaskAutomatorGui1.Submit(false)
	} else {
		Saved := TaskAutomatorGui2.Submit(false)
	}
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
	GuiName := IniRead(TempSystemFile, "GeneralData", "GuiName")
	if GuiName == "TaskAutomatorGui1" {
		Saved := TaskAutomatorGui1.Submit(false)
	} else {
		Saved := TaskAutomatorGui2.Submit(false)
	}
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
	GuiName := IniRead(TempSystemFile, "GeneralData", "GuiName")
	if GuiName == "TaskAutomatorGui1" {
		Saved := TaskAutomatorGui1.Submit(false)
	} else {
		Saved := TaskAutomatorGui2.Submit(false)
	}
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
	GuiName := IniRead(TempSystemFile, "GeneralData", "GuiName")
	if GuiName == "TaskAutomatorGui1" {
		Saved := TaskAutomatorGui1.Submit(false)
	} else {
		Saved := TaskAutomatorGui2.Submit(false)
	}
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
	GuiName := IniRead(TempSystemFile, "GeneralData", "GuiName")
	if GuiName == "TaskAutomatorGui1" {
		Saved := TaskAutomatorGui1.Submit(false)
	} else {
		Saved := TaskAutomatorGui2.Submit(false)
	}
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
	GuiName := IniRead(TempSystemFile, "GeneralData", "GuiName")
	if GuiName == "TaskAutomatorGui1" {
		Saved := TaskAutomatorGui1.Submit(false)
	} else {
		Saved := TaskAutomatorGui2.Submit(false)
	}
	IniWrite Saved.QuickAccessHk9, IniFile, "SavedHotkey", "QuickAccessHk9"
	Reload
}
;----------------------------------------------------
SubmitAutoRunHotkey(*){
	if GetKeyState("Ctrl", "P") {
		CtrlKbAutoRunHotkey := 1
		IniWrite CtrlKbAutoRunHotkey, AuxHkDataFile, "CtrlHkFlags", "CtrlKbAutoRunHotkey"
	}
	if GetKeyState("Alt", "P") {
		AltKbAutoRunHotkey := 1
		IniWrite AltKbAutoRunHotkey, AuxHkDataFile, "AltHkFlags", "AltKbAutoRunHotkey"
	}
	if GetKeyState("Shift", "P") {
		ShiftKbAutoRunHotkey := 1
		IniWrite ShiftKbAutoRunHotkey, AuxHkDataFile, "ShiftHkFlags", "ShiftKbAutoRunHotkey"
	}
	sleep 500
	GuiName := IniRead(TempSystemFile, "GeneralData", "GuiName")
	if GuiName == "TaskAutomatorGui1" {
		Saved := TaskAutomatorGui1.Submit(false)
	} else {
		Saved := TaskAutomatorGui2.Submit(false)
	}
	IniWrite Saved.KbAutoRunHotkey, IniFile, "SavedHotkey", "KbAutoRunHotkey"
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
	GuiName := IniRead(TempSystemFile, "GeneralData", "GuiName")
	if GuiName == "TaskAutomatorGui1" {
		Saved := TaskAutomatorGui1.Submit(false)
	} else {
		Saved := TaskAutomatorGui2.Submit(false)
	}
	IniWrite Saved.PatternClickerHotkey, IniFile, "SavedHotkey", "PatternClickerHotkey"
	Reload
}
;----------------------------------------------------
SubmitValues(*){
	GuiName := IniRead(TempSystemFile, "GeneralData", "GuiName")
	if GuiName == "TaskAutomatorGui1" {
		Saved := TaskAutomatorGui1.Submit(false)
	} else {
		Saved := TaskAutomatorGui2.Submit(false)
	}
	if SwitchClicker == true {
		IniWrite Saved.ClickInterval, IniFile, "AutoClicker", "ClickInterval"
		IniWrite Saved.RandomOffset, IniFile, "AutoClicker", "RandomOffset"
		IniWrite Saved.LoopAmount, IniFile, "Properties", "LoopAmount"
		;----------------------------------------------------
		IniWrite Saved.CoordX1, IniFile, "CursorLocationClicker", "CoordX1"
		IniWrite Saved.CoordY1, IniFile, "CursorLocationClicker", "CoordY1"
		IniWrite Saved.Coord1Interval, IniFile, "CursorLocationClicker", "Coord1Interval"
		IniWrite Saved.Radio1Yes, IniFile, "CursorLocationClicker", "Radio1Yes"
		IniWrite Saved.Radio1No, IniFile, "CursorLocationClicker", "Radio1No"
		;----------------------------------------------------
		IniWrite Saved.CoordX2, IniFile, "CursorLocationClicker", "CoordX2"
		IniWrite Saved.CoordY2, IniFile, "CursorLocationClicker", "CoordY2"
		IniWrite Saved.Coord2Interval, IniFile, "CursorLocationClicker", "Coord2Interval"
		IniWrite Saved.Radio2Yes, IniFile, "CursorLocationClicker", "Radio2Yes"
		IniWrite Saved.Radio2No, IniFile, "CursorLocationClicker", "Radio2No"
		;----------------------------------------------------
		IniWrite Saved.CoordX3, IniFile, "CursorLocationClicker", "CoordX3"
		IniWrite Saved.CoordY3, IniFile, "CursorLocationClicker", "CoordY3"
		IniWrite Saved.Coord3Interval, IniFile, "CursorLocationClicker", "Coord3Interval"
		IniWrite Saved.Radio3Yes, IniFile, "CursorLocationClicker", "Radio3Yes"
		IniWrite Saved.Radio3No, IniFile, "CursorLocationClicker", "Radio3No"
		;----------------------------------------------------
		IniWrite Saved.CoordX4, IniFile, "CursorLocationClicker", "CoordX4"
		IniWrite Saved.CoordY4, IniFile, "CursorLocationClicker", "CoordY4"
		IniWrite Saved.Coord4Interval, IniFile, "CursorLocationClicker", "Coord4Interval"
		IniWrite Saved.Radio4Yes, IniFile, "CursorLocationClicker", "Radio4Yes"
		IniWrite Saved.Radio4No, IniFile, "CursorLocationClicker", "Radio4No"
		;----------------------------------------------------
		IniWrite Saved.CoordX5, IniFile, "CursorLocationClicker", "CoordX5"
		IniWrite Saved.CoordY5, IniFile, "CursorLocationClicker", "CoordY5"
		IniWrite Saved.Coord5Interval, IniFile, "CursorLocationClicker", "Coord5Interval"
		IniWrite Saved.Radio5Yes, IniFile, "CursorLocationClicker", "Radio5Yes"
		IniWrite Saved.Radio5No, IniFile, "CursorLocationClicker", "Radio5No"
		;----------------------------------------------------
		IniWrite Saved.CoordX6, IniFile, "CursorLocationClicker", "CoordX6"
		IniWrite Saved.CoordY6, IniFile, "CursorLocationClicker", "CoordY6"
		IniWrite Saved.Coord6Interval, IniFile, "CursorLocationClicker", "Coord6Interval"
		IniWrite Saved.Radio6Yes, IniFile, "CursorLocationClicker", "Radio6Yes"
		IniWrite Saved.Radio6No, IniFile, "CursorLocationClicker", "Radio6No"
		;----------------------------------------------------
		IniWrite Saved.CoordX7, IniFile, "CursorLocationClicker", "CoordX7"
		IniWrite Saved.CoordY7, IniFile, "CursorLocationClicker", "CoordY7"
		IniWrite Saved.Coord7Interval, IniFile, "CursorLocationClicker", "Coord7Interval"
		IniWrite Saved.Radio7Yes, IniFile, "CursorLocationClicker", "Radio7Yes"
		IniWrite Saved.Radio7No, IniFile, "CursorLocationClicker", "Radio7No"
		;----------------------------------------------------
		IniWrite Saved.CoordX8, IniFile, "CursorLocationClicker", "CoordX8"
		IniWrite Saved.CoordY8, IniFile, "CursorLocationClicker", "CoordY8"
		IniWrite Saved.Coord8Interval, IniFile, "CursorLocationClicker", "Coord8Interval"
		IniWrite Saved.Radio8Yes, IniFile, "CursorLocationClicker", "Radio8Yes"
		IniWrite Saved.Radio8No, IniFile, "CursorLocationClicker", "Radio8No"
		;----------------------------------------------------
		IniWrite Saved.CoordX9, IniFile, "CursorLocationClicker", "CoordX9"
		IniWrite Saved.CoordY9, IniFile, "CursorLocationClicker", "CoordY9"
		IniWrite Saved.Coord9Interval, IniFile, "CursorLocationClicker", "Coord9Interval"
		IniWrite Saved.Radio9Yes, IniFile, "CursorLocationClicker", "Radio9Yes"
		IniWrite Saved.Radio9No, IniFile, "CursorLocationClicker", "Radio9No"
		;----------------------------------------------------
		IniWrite Saved.CoordX10, IniFile, "CursorLocationClicker", "CoordX10"
		IniWrite Saved.CoordY10, IniFile, "CursorLocationClicker", "CoordY10"
		IniWrite Saved.Coord10Interval, IniFile, "CursorLocationClicker", "Coord10Interval"
		IniWrite Saved.Radio10Yes, IniFile, "CursorLocationClicker", "Radio10Yes"
		IniWrite Saved.Radio10No, IniFile, "CursorLocationClicker", "Radio10No"
		;----------------------------------------------------
		IniWrite Saved.CoordX11, IniFile, "CursorLocationClicker", "CoordX11"
		IniWrite Saved.CoordY11, IniFile, "CursorLocationClicker", "CoordY11"
		IniWrite Saved.Coord11Interval, IniFile, "CursorLocationClicker", "Coord11Interval"
		IniWrite Saved.Radio11Yes, IniFile, "CursorLocationClicker", "Radio11Yes"
		IniWrite Saved.Radio11No, IniFile, "CursorLocationClicker", "Radio11No"
		;----------------------------------------------------
		IniWrite Saved.CoordX12, IniFile, "CursorLocationClicker", "CoordX12"
		IniWrite Saved.CoordY12, IniFile, "CursorLocationClicker", "CoordY12"
		IniWrite Saved.Coord12Interval, IniFile, "CursorLocationClicker", "Coord12Interval"
		IniWrite Saved.Radio12Yes, IniFile, "CursorLocationClicker", "Radio12Yes"
		IniWrite Saved.Radio12No, IniFile, "CursorLocationClicker", "Radio12No"
		;----------------------------------------------------
		IniWrite Saved.CoordX13, IniFile, "CursorLocationClicker", "CoordX13"
		IniWrite Saved.CoordY13, IniFile, "CursorLocationClicker", "CoordY13"
		IniWrite Saved.Coord13Interval, IniFile, "CursorLocationClicker", "Coord13Interval"
		IniWrite Saved.Radio13Yes, IniFile, "CursorLocationClicker", "Radio13Yes"
		IniWrite Saved.Radio13No, IniFile, "CursorLocationClicker", "Radio13No"
		;----------------------------------------------------
		IniWrite Saved.CoordX14, IniFile, "CursorLocationClicker", "CoordX14"
		IniWrite Saved.CoordY14, IniFile, "CursorLocationClicker", "CoordY14"
		IniWrite Saved.Coord14Interval, IniFile, "CursorLocationClicker", "Coord14Interval"
		IniWrite Saved.Radio14Yes, IniFile, "CursorLocationClicker", "Radio14Yes"
		IniWrite Saved.Radio14No, IniFile, "CursorLocationClicker", "Radio14No"
		;----------------------------------------------------
		IniWrite Saved.CoordX15, IniFile, "CursorLocationClicker", "CoordX15"
		IniWrite Saved.CoordY15, IniFile, "CursorLocationClicker", "CoordY15"
		IniWrite Saved.Coord15Interval, IniFile, "CursorLocationClicker", "Coord15Interval"
		IniWrite Saved.Radio15Yes, IniFile, "CursorLocationClicker", "Radio15Yes"
		IniWrite Saved.Radio15No, IniFile, "CursorLocationClicker", "Radio15No"
		;----------------------------------------------------
		IniWrite Saved.CoordX16, IniFile, "CursorLocationClicker", "CoordX16"
		IniWrite Saved.CoordY16, IniFile, "CursorLocationClicker", "CoordY16"
		IniWrite Saved.Coord16Interval, IniFile, "CursorLocationClicker", "Coord16Interval"
		IniWrite Saved.Radio16Yes, IniFile, "CursorLocationClicker", "Radio16Yes"
		IniWrite Saved.Radio16No, IniFile, "CursorLocationClicker", "Radio16No"
		;----------------------------------------------------
		IniWrite Saved.CoordX17, IniFile, "CursorLocationClicker", "CoordX17"
		IniWrite Saved.CoordY17, IniFile, "CursorLocationClicker", "CoordY17"
		IniWrite Saved.Coord17Interval, IniFile, "CursorLocationClicker", "Coord17Interval"
		IniWrite Saved.Radio17Yes, IniFile, "CursorLocationClicker", "Radio17Yes"
		IniWrite Saved.Radio17No, IniFile, "CursorLocationClicker", "Radio17No"
		;----------------------------------------------------
		IniWrite Saved.CoordX18, IniFile, "CursorLocationClicker", "CoordX18"
		IniWrite Saved.CoordY18, IniFile, "CursorLocationClicker", "CoordY18"
		IniWrite Saved.Coord18Interval, IniFile, "CursorLocationClicker", "Coord18Interval"
		IniWrite Saved.Radio18Yes, IniFile, "CursorLocationClicker", "Radio18Yes"
		IniWrite Saved.Radio18No, IniFile, "CursorLocationClicker", "Radio18No"
		;----------------------------------------------------
		IniWrite Saved.CoordX19, IniFile, "CursorLocationClicker", "CoordX19"
		IniWrite Saved.CoordY19, IniFile, "CursorLocationClicker", "CoordY19"
		IniWrite Saved.Coord19Interval, IniFile, "CursorLocationClicker", "Coord19Interval"
		IniWrite Saved.Radio19Yes, IniFile, "CursorLocationClicker", "Radio19Yes"
		IniWrite Saved.Radio19No, IniFile, "CursorLocationClicker", "Radio19No"
		;----------------------------------------------------
		IniWrite Saved.CoordX20, IniFile, "CursorLocationClicker", "CoordX20"
		IniWrite Saved.CoordY20, IniFile, "CursorLocationClicker", "CoordY20"
		IniWrite Saved.Coord20Interval, IniFile, "CursorLocationClicker", "Coord20Interval"
		IniWrite Saved.Radio20Yes, IniFile, "CursorLocationClicker", "Radio20Yes"
		IniWrite Saved.Radio20No, IniFile, "CursorLocationClicker", "Radio20No"
		;----------------------------------------------------
		IniWrite Saved.CoordX21, IniFile, "CursorLocationClicker", "CoordX21"
		IniWrite Saved.CoordY21, IniFile, "CursorLocationClicker", "CoordY21"
		IniWrite Saved.Coord21Interval, IniFile, "CursorLocationClicker", "Coord21Interval"
		IniWrite Saved.Radio21Yes, IniFile, "CursorLocationClicker", "Radio21Yes"
		IniWrite Saved.Radio21No, IniFile, "CursorLocationClicker", "Radio21No"
		;----------------------------------------------------
		IniWrite Saved.CoordX22, IniFile, "CursorLocationClicker", "CoordX22"
		IniWrite Saved.CoordY22, IniFile, "CursorLocationClicker", "CoordY22"
		IniWrite Saved.Coord22Interval, IniFile, "CursorLocationClicker", "Coord22Interval"
		IniWrite Saved.Radio22Yes, IniFile, "CursorLocationClicker", "Radio22Yes"
		IniWrite Saved.Radio22No, IniFile, "CursorLocationClicker", "Radio22No"
		;----------------------------------------------------
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
ClearValuesXY(*){
	GuiName := IniRead(TempSystemFile, "GeneralData", "GuiName")
	if GuiName == "TaskAutomatorGui1" {
		Saved := TaskAutomatorGui1.Submit(false)
	} else {
		Saved := TaskAutomatorGui2.Submit(false)
	}
	
	IniWrite true, TempSystemFile, "GeneralData", "ClearXY"
	; Dinamic Reload
	GuiName := IniRead(TempSystemFile, "GeneralData", "GuiName")
	if GuiName == "TaskAutomatorGui1" {
		TaskAutomatorGui1.GetPos(&PosX, &PosY)
	} else {
		TaskAutomatorGui2.GetPos(&PosX, &PosY)
	}
	IniWrite PosX, IniFile, "Properties", "PositionX"
	IniWrite PosY, IniFile, "Properties", "PositionY"
	IniWrite true, TempSystemFile, "GeneralData", "DinamicReload"
}