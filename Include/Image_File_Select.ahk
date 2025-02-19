;------------- Credits ------------
; Creator: Fernando Daniel Jaime.
; Programmer Alias: FDJ-Dash.
;------------- File Details ------------
; App Name: Task Automator.
; File Description: This file contains functions related to file selection on main app.
;----------------------------------------------------
; Header list:
;----------------------------------------------------
; SelectNewIcon1(*)
; SelectNewIcon2(*)
; SelectNewIcon3(*)
; SelectNewIcon4(*)
; SelectNewIcon5(*)
; SelectNewIcon6(*)
; SelectNewIcon7(*)
; SelectNewIcon8(*)
; SelectNewIcon9(*)
; ChangeBackgroundHandler(*)
; ChangeMessageBackgroundHandler(*)
;----------------------------------------------------
SelectNewIcon1(*) {
	SelectedFile := FileSelect(3, "", "Open a file", "Text Documents (*.ico; *.png; *.jpg)")
	IniWrite SelectedFile, IniFile, "QuickAccessIcons", "QuickIcon1"
	; Reload
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
;----------------------------------------------------
SelectNewIcon2(*) {
	SelectedFile := FileSelect(3, "", "Open a file", "Text Documents (*.ico; *.png; *.jpg)")
	IniWrite SelectedFile, IniFile, "QuickAccessIcons", "QuickIcon2"
	; Reload
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
;----------------------------------------------------
SelectNewIcon3(*) {
	SelectedFile := FileSelect(3, "", "Open a file", "Text Documents (*.ico; *.png; *.jpg)")
	IniWrite SelectedFile, IniFile, "QuickAccessIcons", "QuickIcon3"
	; Reload
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
;----------------------------------------------------
SelectNewIcon4(*) {
	SelectedFile := FileSelect(3, "", "Open a file", "Text Documents (*.ico; *.png; *.jpg)")
	IniWrite SelectedFile, IniFile, "QuickAccessIcons", "QuickIcon4"
	; Reload
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
;----------------------------------------------------
SelectNewIcon5(*) {
	SelectedFile := FileSelect(3, "", "Open a file", "Text Documents (*.ico; *.png; *.jpg)")
	IniWrite SelectedFile, IniFile, "QuickAccessIcons", "QuickIcon5"
	; Reload
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
;----------------------------------------------------
SelectNewIcon6(*) {
	SelectedFile := FileSelect(3, "", "Open a file", "Text Documents (*.ico; *.png; *.jpg)")
	IniWrite SelectedFile, IniFile, "QuickAccessIcons", "QuickIcon6"
	; Reload
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
;----------------------------------------------------
SelectNewIcon7(*) {
	SelectedFile := FileSelect(3, "", "Open a file", "Text Documents (*.ico; *.png; *.jpg)")
	IniWrite SelectedFile, IniFile, "QuickAccessIcons", "QuickIcon7"
	; Reload
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
;----------------------------------------------------
SelectNewIcon8(*) {
	SelectedFile := FileSelect(3, "", "Open a file", "Text Documents (*.ico; *.png; *.jpg)")
	IniWrite SelectedFile, IniFile, "QuickAccessIcons", "QuickIcon8"
	; Reload
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
;----------------------------------------------------
SelectNewIcon9(*) {
	SelectedFile := FileSelect(3, "", "Open a file", "Text Documents (*.ico; *.png; *.jpg)")
	IniWrite SelectedFile, IniFile, "QuickAccessIcons", "QuickIcon9"
	; Reload
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
;----------------------------------------------------
ChangeBackgroundHandler(*){
	SelectedFile := FileSelect(3, "", "Open a file", "Text Documents (*.ico; *.png; *.jpg)")
	IniWrite SelectedFile, IniFile, "Background", "BackgroundPicture"
	; Reload
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
;----------------------------------------------------
ChangeMessageBackgroundHandler(*){
	SelectedFile := FileSelect(3, "", "Open a file", "Text Documents (*.ico; *.png; *.jpg)")
	IniWrite SelectedFile, IniFile, "Background", "MessageBackgroundPicture"
	; Reload
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