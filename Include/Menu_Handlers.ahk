;------------- Credits ------------
; Creator: Fernando Daniel Jaime.
; Programmer Alias: FDJ-Dash.
;------------- File Details ------------
; App Name: Task Automator.
; File Description: This file contains all menu handlers.
;----------------------------------------------------
; Header list:
;----------------------------------------------------
; MenuHandlerExit(*)
; EditIniFileHandler(*)
; MenuHandlerUpdate(*)
; MenuHandlerCheckUptDaily(*)
; MenuHandlerCheckUptWeekly(*)
; MenuHandlerNeverCheckUpt(*)
; SuspendMenuHandler(*)
; MenuHandlerQuickFix(*)
; HotkeyEditModeHandler(*)
; EditBoxesHandler(*)
; GuiPriorityAlwaysOnTopHandler(*)
; KbAutoRunOFFHandler(*)
; ControllerAutoRunOFFHandler(*)
; SwitchJumpsHandler(*)
; SwitchClickerHandler(*)
; QuickAccessHandler(*)
; QuickAccessButtonsHandler(*)
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
	DownloadUrl := IniRead(DataFile, "EncriptedData", "TADownload")
	TALatestReleaseVersion := IniRead(DataFile, "GeneralData", "TALatestReleaseVersion")
	IniWrite A_Now, IniFile, "Settings", "LastUpdateCheckTimeStamp"
	if TALatestReleaseVersion != CurrentVersion {
		if DownloadUrl != "" {
			IniWrite true, IniFile, "Settings", "NeedUpdate"
			NewVersionAvailableMessage(TALatestReleaseVersion)
		}
	}
	if TALatestReleaseVersion == CurrentVersion {
		if NeedUpdate == 1 {
			IniWrite false, IniFile, "Settings", "NeedUpdate"
		}
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
MenuHandlerCheckUptWeekly(*){
	CheckforUpdatesDaily := false
	CheckforupdatesWeekly := true
	NeverCheckForUpdates := false
	IniWrite CheckforUpdatesDaily, IniFile, "Settings", "CheckforUpdatesDaily"
	IniWrite CheckforupdatesWeekly, IniFile, "Settings", "CheckforupdatesWeekly"
	IniWrite NeverCheckForUpdates, IniFile, "Settings", "NeverCheckForUpdates"
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
MenuHandlerNeverCheckUpt(*){
	CheckforUpdatesDaily := false
	CheckforupdatesWeekly := false
	NeverCheckForUpdates := true
	IniWrite CheckforUpdatesDaily, IniFile, "Settings", "CheckforUpdatesDaily"
	IniWrite CheckforupdatesWeekly, IniFile, "Settings", "CheckforupdatesWeekly"
	IniWrite NeverCheckForUpdates, IniFile, "Settings", "NeverCheckForUpdates"
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
HotkeyEditModeHandler(*) {
	HotkeyEditMode := IniRead(IniFile, "Settings", "HotkeyEditMode")
	HotkeyEditMode := !HotkeyEditMode
	IniWrite HotkeyEditMode, IniFile, "Settings", "HotkeyEditMode"
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
EditBoxesHandler(*){
	EditBoxesAvailable := IniRead(IniFile, "Settings", "EditBoxesAvailable")
	EditBoxesAvailable := !EditBoxesAvailable
	IniWrite EditBoxesAvailable, IniFile, "Settings", "EditBoxesAvailable"
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
ResizeModuleHandler(*){
	ResizeModule := IniRead(IniFile, "Settings", "ResizeModule")
	ResizeModule := !ResizeModule
	IniWrite ResizeModule, IniFile, "Settings", "ResizeModule"
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
GuiPriorityAlwaysOnTopHandler(*){
	GuiPriorityAlwaysOnTop := IniRead(IniFile, "Properties", "GuiPriorityAlwaysOnTop")
	GuiPriorityAlwaysOnTop := !GuiPriorityAlwaysOnTop
	IniWrite GuiPriorityAlwaysOnTop, IniFile, "Properties", "GuiPriorityAlwaysOnTop"
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
KbAutoRunOFFHandler(*){
	SwitchClicker := false
	SwitchQuickAccess := false
	SwitchJumps := false
	SwitchControllerAutoRun := false
	SwitchKbAutoRun := true
	IniWrite SwitchJumps, IniFile, "Modules", "SwitchJumps"
	IniWrite SwitchQuickAccess, IniFile, "Modules", "SwitchQuickAccess"
	IniWrite SwitchClicker, IniFile, "Modules", "SwitchClicker"
	IniWrite SwitchControllerAutoRun, IniFile, "Modules", "SwitchControllerAutoRun"
	IniWrite SwitchKbAutoRun, IniFile, "Modules", "SwitchKbAutoRun"
	
	HotkeyEditMode := IniRead(IniFile, "Settings", "HotkeyEditMode")
	if HotkeyEditMode == true {
		Reload
	} else {
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
	
}
;----------------------------------------------------
ControllerAutoRunOFFHandler(*){
	SwitchClicker := false
	SwitchQuickAccess := false
	SwitchJumps := false
	SwitchControllerAutoRun := true
	SwitchKbAutoRun := false
	IniWrite SwitchJumps, IniFile, "Modules", "SwitchJumps"
	IniWrite SwitchQuickAccess, IniFile, "Modules", "SwitchQuickAccess"
	IniWrite SwitchClicker, IniFile, "Modules", "SwitchClicker"
	IniWrite SwitchControllerAutoRun, IniFile, "Modules", "SwitchControllerAutoRun"
	IniWrite SwitchKbAutoRun, IniFile, "Modules", "SwitchKbAutoRun"
	if HotkeyEditMode == true {
		Reload
	} else {
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
}
;----------------------------------------------------
SwitchJumpsHandler(*){
	SwitchClicker := false
	SwitchQuickAccess := false
	SwitchJumps := true
	SwitchControllerAutoRun := false
	SwitchKbAutoRun := false
	IniWrite SwitchJumps, IniFile, "Modules", "SwitchJumps"
	IniWrite SwitchQuickAccess, IniFile, "Modules", "SwitchQuickAccess"
	IniWrite SwitchClicker, IniFile, "Modules", "SwitchClicker"
	IniWrite SwitchControllerAutoRun, IniFile, "Modules", "SwitchControllerAutoRun"
	IniWrite SwitchKbAutoRun, IniFile, "Modules", "SwitchKbAutoRun"
	if HotkeyEditMode == true {
		Reload
	} else {
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
}
;----------------------------------------------------
SwitchClickerHandler(*){
	SwitchJumps := false
	SwitchQuickAccess := false
	SwitchClicker := true
	SwitchControllerAutoRun := false
	SwitchKbAutoRun := false
	IniWrite SwitchJumps, IniFile, "Modules", "SwitchJumps"
	IniWrite SwitchQuickAccess, IniFile, "Modules", "SwitchQuickAccess"
	IniWrite SwitchClicker, IniFile, "Modules", "SwitchClicker"
	IniWrite SwitchControllerAutoRun, IniFile, "Modules", "SwitchControllerAutoRun"
	IniWrite SwitchKbAutoRun, IniFile, "Modules", "SwitchKbAutoRun"
	if HotkeyEditMode == true {
		Reload
	} else {
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
}
;----------------------------------------------------
QuickAccessHandler(*) {
	SwitchJumps := false
	SwitchClicker := false
	SwitchQuickAccess := true
	SwitchControllerAutoRun := false
	SwitchKbAutoRun := false
	IniWrite SwitchJumps, IniFile, "Modules", "SwitchJumps"
	IniWrite SwitchClicker, IniFile, "Modules", "SwitchClicker"
	IniWrite SwitchQuickAccess, IniFile, "Modules", "SwitchQuickAccess"
	IniWrite SwitchControllerAutoRun, IniFile, "Modules", "SwitchControllerAutoRun"
	IniWrite SwitchKbAutoRun, IniFile, "Modules", "SwitchKbAutoRun"
	if HotkeyEditMode == true {
		Reload
	} else {
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
}
;----------------------------------------------------
QuickAccessButtonsHandler(*) {
	if SwitchQuickAccess == false {
		MenuHandlerQuickAccessMsg
	} else {
		QuickAccessButtons := IniRead(IniFile, "Modules", "QuickAccessButtons")
		QuickAccessButtons := !QuickAccessButtons
		IniWrite QuickAccessButtons, IniFile, "Modules", "QuickAccessButtons"
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
}
