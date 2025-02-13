;------------- Credits ------------
; Creator: Fernando Daniel Jaime.
; Programmer Alias: FDJ-Dash.
;------------- File Details ------------
; App Name: Task Automator.
; File Description: This file contains all posible messages handled by Task Automator.
;----------------------------------------------------
; Header list:
;----------------------------------------------------
; ExitMsg(*)
; InvalidLicenseMsg(*)
; LicenseFileMissingMsg(*)
; InvalidPath(*)
; DuplicatedHotkeyValue(*)
; SaveMsg(*)
; ToggleHotkeysEnabled(*)
; ToggleHotkeysDisabled(*)
; HotkeyEditModeOn(*)
; MenuHandlerAbout(*)
; MenuHandlerGuide(*)
; MenuHandlerQuickAccessMsg(*)
; ConnectionMessage(*)
; UpToDateMessage(*)
; NewVersionAvailableMessage(ReleaseVersion, *)
;----------------------------------------------------
ExitMsg(*){
	ShowExit:
		if GuiPriorityAlwaysOnTop == true {
			Exitmsg := Gui("+AlwaysOnTop")
		} else {
			Exitmsg := Gui()
		}
		GuiName := IniRead(TempSystemFile, "GeneralData", "GuiName")
		Exitmsg.BackColor := "0x" . BackgroundColor
		MessageBackgroundPicture := IniRead(IniFile, "Background", "MessageBackgroundPicture")
		if MessageBackgroundPicture == "" {
			try {
				Exitmsg.Add("Picture", "x0 y0 w470 h240", ImageLib . DefaultMsgBackgroundImage)
			}
			catch {
			}
		} else {
			try {
				Exitmsg.Add("Picture", "x0 y0 w470 h240", MessageBackgroundPicture)
			}
			catch {
				MessageBackgroundPicture := ""
				IniWrite MessageBackgroundPicture, IniFile, "Background", "MessageBackgroundPicture"
				; Reload
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
		try {
			Exitmsg.Add("Picture", "x9 y12 w64 h64 +border", IconLib . FDJ_SoftwareIcon)
		}
		catch {
		}
		Exitmsg.SetFont("s20 W700 Q4 " . MessageAppNameFontColor, MessageAppNameFontType)
		Exitmsg.Add("Text", "x80 y16", AppName)
		Exitmsg.SetFont("s9 " . MessageFontColor, MessageFontType)
		Exitmsg.Add("Text", "x303 y31 ", CurrentVersion)
		Exitmsg.Add("Text", "x80 y55 ", "License key: " )
		Exitmsg.SetFont()
		Exitmsg.SetFont("s8 Bold " . LicenseKeyFontColor, LicenseKeyFontType)
		Exitmsg.Add("Text", "x160 y55 ", LicenseKey)
		Exitmsg.Add("Text", "x0 y90 w470 h1 +0x5")
		Exitmsg.SetFont()
		Exitmsg.SetFont("s12 " . MessageMainMsgFontColor, MessageMainMsgFontType)
		Exitmsg.Add("Text", "x80 y110", "ML Task Automator will close in " ExitMessageTimeWait / 1000 " seconds")
        Exitmsg.Add("Text", "x175 y140", "Have a nice day!")
		Exitmsg.SetFont()
		Exitmsg.SetFont("s9 " . MessageFontColor, MessageFontType)
		Exitmsg.Add("Text", "x0 y180 w470 h1 +0x5")
		Exitmsg.Add("Text", "x107 y190", "Copyright 2024 FDJ-Software. All Rights Reserved.")
		Exitmsg.SetFont()
		Exitmsg.SetFont("s8 " . MessageFontColor, MessageFontType)
		Exitmsg.Add("Text", "x116 y212", "Made with AutoHotkey V" A_AhkVersion . " " . (1 ? "Unicode" : "ANSI") . " " . (A_PtrSize == 8 ? "64-bit" : "32-bit"))
        Exitmsg.Title := "Goodbye!"
		if GuiName == "TaskAutomatorGui1" {
			TaskAutomatorGui1.GetPos(&PosX, &PosY)
		} else {
			TaskAutomatorGui2.GetPos(&PosX, &PosY)
		}
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
		GuiName := IniRead(TempSystemFile, "GeneralData", "GuiName")
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
				; Reload
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
		try {
			InvLicMsg.Add("Picture", "x9 y12 w64 h64 +border", IconLib . FDJ_SoftwareIcon)
		}
		catch {
		}
		InvLicMsg.SetFont("s20 W700 Q4 " . MessageAppNameFontColor, MessageAppNameFontType)
        InvLicMsg.Add("Text", "x80 y16", AppName)
		InvLicMsg.SetFont("s9 " . MessageFontColor, MessageFontType)
		InvLicMsg.Add("Text", "x303 y31 ", CurrentVersion)
		InvLicMsg.Add("Text", "x80 y55 ", "License key: " )
		InvLicMsg.SetFont()
		InvLicMsg.SetFont("s8 Bold cRed", LicenseKeyFontType)
		InvLicMsg.Add("Text", "x160 y55", "???")
		InvLicMsg.Add("Text", "x0 y90 w470 h1 +0x5")
		InvLicMsg.SetFont()
		InvLicMsg.SetFont("s12 cRed", MessageMainMsgFontType)
		InvLicMsg.Add("Text", "x167 y110", "Invalid License Key")
        InvLicMsg.Add("Text", "x80 y140", "ML Task Automator will close in " ExitMessageTimeWait / 1000 " seconds")
		InvLicMsg.SetFont()
		InvLicMsg.SetFont("s9 " . MessageFontColor, MessageFontType)
		InvLicMsg.Add("Text", "x0 y180 w470 h1 +0x5")
		InvLicMsg.Add("Text", "x100 y190", "Copyright 2024 FDJ-Software. All Rights Reserved.")
		InvLicMsg.SetFont()
		InvLicMsg.SetFont("s8 " . MessageFontColor, MessageFontType)
		InvLicMsg.Add("Text", "x120 y212", "Made with AutoHotkey V" A_AhkVersion . " " . (1 ? "Unicode" : "ANSI") . " " . (A_PtrSize == 8 ? "64-bit" : "32-bit"))
        InvLicMsg.Title := "Invalid License Key!"
		if GuiName == "TaskAutomatorGui1" {
			TaskAutomatorGui1.GetPos(&PosX, &PosY)
		} else {
			TaskAutomatorGui2.GetPos(&PosX, &PosY)
		}
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
		GuiName := IniRead(TempSystemFile, "GeneralData", "GuiName")
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
				; Reload
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
		try {
			NoLicFileMsg.Add("Picture", "x9 y12 w64 h64 +border", IconLib . FDJ_SoftwareIcon)
		}
		catch {
		}
		NoLicFileMsg.SetFont("s20 W700 Q4 " . MessageAppNameFontColor, MessageAppNameFontType)
        NoLicFileMsg.Add("Text", "x80 y16", AppName)
		NoLicFileMsg.SetFont("s9 " . MessageFontColor, MessageFontType)
		NoLicFileMsg.Add("Text", "x303 y31 ", CurrentVersion)
		NoLicFileMsg.Add("Text", "x80 y55 ", "License key: " )
		NoLicFileMsg.SetFont()
		NoLicFileMsg.SetFont("s8 Bold cRed", LicenseKeyFontType)
		NoLicFileMsg.Add("Text", "x160 y55", "???")
		NoLicFileMsg.Add("Text", "x0 y90 w470 h1 +0x5")
		NoLicFileMsg.SetFont()
		NoLicFileMsg.SetFont("s12 cRed", MessageMainMsgFontType)
		NoLicFileMsg.Add("Text", "x160 y110", "License file not found")
        NoLicFileMsg.Add("Text", "x80 y140", "ML Task Automator will close in " ExitMessageTimeWait / 1000 " seconds")
		NoLicFileMsg.SetFont()
		NoLicFileMsg.SetFont("s9 " . MessageFontColor, MessageFontType)
		NoLicFileMsg.Add("Text", "x0 y180 w470 h1 +0x5")
		NoLicFileMsg.Add("Text", "x100 y190", "Copyright 2024 FDJ-Software. All Rights Reserved.")
		NoLicFileMsg.SetFont()
		NoLicFileMsg.SetFont("s8 " . MessageFontColor, MessageFontType)
		NoLicFileMsg.Add("Text", "x120 y212", "Made with AutoHotkey V" A_AhkVersion . " " . (1 ? "Unicode" : "ANSI") . " " . (A_PtrSize == 8 ? "64-bit" : "32-bit"))
        NoLicFileMsg.Title := "Invalid License Key!"
		if GuiName == "TaskAutomatorGui1" {
			TaskAutomatorGui1.GetPos(&PosX, &PosY)
		} else {
			TaskAutomatorGui2.GetPos(&PosX, &PosY)
		}
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
		GuiName := IniRead(TempSystemFile, "GeneralData", "GuiName")
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
				; Reload
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
		try {
			InvPathmsg.Add("Picture", "x9 y12 w64 h64 +border", IconLib . FDJ_SoftwareIcon)
		}
		catch {
		}
		InvPathmsg.SetFont("s20 W700 Q4 " . MessageAppNameFontColor, MessageAppNameFontType)
        InvPathmsg.Add("Text", "x80 y16", AppName)
		InvPathmsg.SetFont("s9 " . MessageFontColor, MessageFontType)
		InvPathmsg.Add("Text", "x303 y31 ", CurrentVersion)
		InvPathmsg.Add("Text", "x80 y55 ", "License key: " )
		InvPathmsg.SetFont()
		InvPathmsg.SetFont("s8 Bold " . LicenseKeyFontColor, LicenseKeyFontType)
		InvPathmsg.Add("Text", "x160 y55 ", LicenseKey)
		InvPathmsg.Add("Text", "x0 y90 w470 h1 +0x5")
		InvPathmsg.SetFont()
		InvPathmsg.SetFont("s12 " . MessageMainMsgFontColor, MessageMainMsgFontType)
		InvPathmsg.Add("Text", "x145 y125", "Your path input is invalid.")
		InvPathmsg.SetFont()
		InvPathmsg.SetFont("s9 " . MessageFontColor, MessageFontType)
		InvPathmsg.Add("Text", "x0 y180 w470 h1 +0x5")
		InvPathmsg.Add("Text", "x25 y190", "Copyright 2024 FDJ-Software. All Rights Reserved.")
		InvPathmsg.SetFont()
		InvPathmsg.SetFont("s8 " . MessageFontColor, MessageFontType)
		InvPathmsg.Add("Text", "x25 y212", "Made with AutoHotkey V" A_AhkVersion . " " . (1 ? "Unicode" : "ANSI") . " " . (A_PtrSize == 8 ? "64-bit" : "32-bit"))
        ogcButtonOK := InvPathmsg.Add("Button", "x370 y200 w80 h24", "OK")
		ogcButtonOK.OnEvent("Click", Destroy)
		InvPathmsg.Title := "Invalid path"
		if GuiName == "TaskAutomatorGui1" {
			TaskAutomatorGui1.GetPos(&PosX, &PosY)
		} else {
			TaskAutomatorGui2.GetPos(&PosX, &PosY)
		}
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
		try {
			DupHkValue.Add("Picture", "x9 y12 w64 h64 +border", IconLib . FDJ_SoftwareIcon)
		}
		catch {
		}
		DupHkValue.SetFont("s20 W700 Q4 " . MessageAppNameFontColor, MessageAppNameFontType)
        DupHkValue.Add("Text", "x80 y16", AppName)
		DupHkValue.SetFont("s9 " . MessageFontColor, MessageFontType)
		DupHkValue.Add("Text", "x303 y31 ", CurrentVersion)
		DupHkValue.Add("Text", "x80 y55 ", "License key: " )
		DupHkValue.SetFont()
		DupHkValue.SetFont("s8 Bold " . LicenseKeyFontColor, LicenseKeyFontType)
		LicenseKeyInFile := IniRead(LicenseFile, "Data", "LicenseKey")
		DupHkValue.Add("Text", "x160 y55", LicenseKeyInFile)
		DupHkValue.Add("Text", "x0 y90 w470 h1 +0x5")
		DupHkValue.SetFont()
		DupHkValue.SetFont("s12 cRed", MessageMainMsgFontType)
		DupHkValue.Add("Text", "x40 y110", "Duplicated hotkey values is a dangerous configuration")
		DupHkValue.Add("Text", "x135 y140", "Returning to default values")
		DupHkValue.SetFont()
		DupHkValue.SetFont("s9 " . MessageFontColor, MessageFontType)
		DupHkValue.Add("Text", "x0 y180 w470 h1 +0x5")
		DupHkValue.Add("Text", "x25 y190", "Copyright 2024 FDJ-Software. All Rights Reserved.")
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
		GuiName := IniRead(TempSystemFile, "GeneralData", "GuiName")
		SaveSuccesfullTimeWait := IniRead(IniFile, "Properties", "SaveSuccesfullTimeWait")
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
				; Reload
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
		try {
			Savemsg.Add("Picture", "x9 y12 w64 h64 +border", IconLib . FDJ_SoftwareIcon)
		}
		catch {
		}
		Savemsg.SetFont("s20 W700 Q4 " . MessageAppNameFontColor, MessageAppNameFontType)
        Savemsg.Add("Text", "x80 y16", AppName)
		Savemsg.SetFont("s9 " . MessageFontColor, MessageFontType)
		Savemsg.Add("Text", "x303 y31 ", CurrentVersion)
		Savemsg.Add("Text", "x80 y55 ", "License key: " )
		Savemsg.SetFont()
		Savemsg.SetFont("s8 Bold " . LicenseKeyFontColor, LicenseKeyFontType)
		Savemsg.Add("Text", "x160 y55 ", LicenseKey)
		Savemsg.Add("Text", "x0 y90 w470 h1 +0x5")
		Savemsg.SetFont()
		Savemsg.SetFont("s12 " . MessageMainMsgFontColor, MessageMainMsgFontType)
		Savemsg.Add("Text", "x110 y125", "Values saved successfully to ini file")
		Savemsg.SetFont()
		Savemsg.SetFont("s9 " . MessageFontColor, MessageFontType)
		Savemsg.Add("Text", "x0 y180 w470 h1 +0x5")
		Savemsg.Add("Text", "x107 y190", "Copyright 2024 FDJ-Software. All Rights Reserved.")
		Savemsg.SetFont()
		Savemsg.SetFont("s8 " . MessageFontColor, MessageFontType)
		Savemsg.Add("Text", "x116 y212", "Made with AutoHotkey V" A_AhkVersion . " " . (1 ? "Unicode" : "ANSI") . " " . (A_PtrSize == 8 ? "64-bit" : "32-bit"))
		Savemsg.Title := "Save Successful!"
		if GuiName == "TaskAutomatorGui1" {
			TaskAutomatorGui1.GetPos(&PosX, &PosY)
		} else {
			TaskAutomatorGui2.GetPos(&PosX, &PosY)
		}
        Savemsg.Show("x" . PosX - 150 . " y" . PosY + 220 . "w470 h240")
        Savemsg.Opt("+LastFound")
		Sleep SaveSuccesfullTimeWait
		Savemsg.Destroy()
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
		GuiName := IniRead(TempSystemFile, "GeneralData", "GuiName")
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
				; Reload
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
		try {
			HkEnabled.Add("Picture", "x9 y12 w64 h64 +border", IconLib . FDJ_SoftwareIcon)
		}
		catch {
		}
		HkEnabled.SetFont("s20 W700 Q4 " . MessageAppNameFontColor, MessageAppNameFontType)
        HkEnabled.Add("Text", "x80 y16", AppName)
		HkEnabled.SetFont("s9 " . MessageFontColor, MessageFontType)
		HkEnabled.Add("Text", "x303 y31 ", CurrentVersion)
		HkEnabled.Add("Text", "x80 y55 ", "License key: " )
		HkEnabled.SetFont()
		HkEnabled.SetFont("s8 Bold " . LicenseKeyFontColor, LicenseKeyFontType)
		HkEnabled.Add("Text", "x160 y55 ", LicenseKey)
		HkEnabled.Add("Text", "x0 y90 w470 h1 +0x5")
		HkEnabled.SetFont()
		HkEnabled.SetFont("s12 " . MessageMainMsgFontColor, MessageMainMsgFontType)
		HkEnabled.Add("Text", "x170 y125", "Hotkeys Enabled")
		HkEnabled.SetFont()
		HkEnabled.SetFont("s9 " . MessageFontColor, MessageFontType)
		HkEnabled.Add("Text", "x0 y180 w470 h1 +0x5")
		HkEnabled.Add("Text", "x107 y190", "Copyright 2024 FDJ-Software. All Rights Reserved.")
		HkEnabled.SetFont()
		HkEnabled.SetFont("s8 " . MessageFontColor, MessageFontType)
		HkEnabled.Add("Text", "x116 y212", "Made with AutoHotkey V" A_AhkVersion . " " . (1 ? "Unicode" : "ANSI") . " " . (A_PtrSize == 8 ? "64-bit" : "32-bit"))
		HkEnabled.Title := "Hotkeys Enabled"
		if GuiName == "TaskAutomatorGui1" {
			TaskAutomatorGui1.GetPos(&PosX, &PosY)
		} else {
			TaskAutomatorGui2.GetPos(&PosX, &PosY)
		}
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
		GuiName := IniRead(TempSystemFile, "GeneralData", "GuiName")
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
				; Reload
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
		try {
			HkDisabled.Add("Picture", "x9 y12 w64 h64 +border", IconLib . FDJ_SoftwareIcon)
		}
		catch {
		}
		HkDisabled.SetFont("s20 W700 Q4 " . MessageAppNameFontColor, MessageAppNameFontType)
        HkDisabled.Add("Text", "x80 y16", AppName)
		HkDisabled.SetFont("s9 " . MessageFontColor, MessageFontType)
		HkDisabled.Add("Text", "x303 y31 ", CurrentVersion)
		HkDisabled.Add("Text", "x80 y55 ", "License key: " )
		HkDisabled.SetFont()
		HkDisabled.SetFont("s8 Bold " . LicenseKeyFontColor, LicenseKeyFontType)
		HkDisabled.Add("Text", "x160 y55 ", LicenseKey)
		HkDisabled.Add("Text", "x0 y90 w470 h1 +0x5")
		HkDisabled.SetFont()
		HkDisabled.SetFont("s12 " . MessageMainMsgFontColor, MessageMainMsgFontType)
		HkDisabled.Add("Text", "x167 y110", "Hotkeys Suspended")
		HkDisabled.Add("Text", "x116 y140", "Press " . SuspendHotkeysKey . " again to anable them.")
		HkDisabled.SetFont()
		HkDisabled.SetFont("s9 " . MessageFontColor, MessageFontType)
		HkDisabled.Add("Text", "x0 y180 w470 h1 +0x5")
		HkDisabled.Add("Text", "x107 y190", "Copyright 2024 FDJ-Software. All Rights Reserved.")
		HkDisabled.SetFont()
		HkDisabled.SetFont("s8 " . MessageFontColor, MessageFontType)
		HkDisabled.Add("Text", "x116 y212", "Made with AutoHotkey V" A_AhkVersion . " " . (1 ? "Unicode" : "ANSI") . " " . (A_PtrSize == 8 ? "64-bit" : "32-bit"))
		HkDisabled.Title := "Hotkeys Suspended"
		if GuiName == "TaskAutomatorGui1" {
			TaskAutomatorGui1.GetPos(&PosX, &PosY)
		} else {
			TaskAutomatorGui2.GetPos(&PosX, &PosY)
		}
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
		GuiName := IniRead(TempSystemFile, "GeneralData", "GuiName")
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
				; Reload
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
		try {
			HkEditModeOn.Add("Picture", "x9 y12 w64 h64 +border", IconLib . FDJ_SoftwareIcon)
		}
		catch {
		}
		HkEditModeOn.SetFont("s20 W700 Q4 " . MessageAppNameFontColor, MessageAppNameFontType)
        HkEditModeOn.Add("Text", "x80 y16", AppName)
		HkEditModeOn.SetFont("s9 " . MessageFontColor, MessageFontType)
		HkEditModeOn.Add("Text", "x303 y31 ", CurrentVersion)
		HkEditModeOn.Add("Text", "x80 y55 ", "License key: " )
		HkEditModeOn.SetFont()
		HkEditModeOn.SetFont("s8 Bold " . LicenseKeyFontColor, LicenseKeyFontType)
		HkEditModeOn.Add("Text", "x160 y55 ", LicenseKey)
		HkEditModeOn.Add("Text", "x0 y90 w470 h1 +0x5")
		HkEditModeOn.SetFont()
		HkEditModeOn.SetFont("s12 " . MessageMainMsgFontColor, MessageMainMsgFontType)
		HkEditModeOn.Add("Text", "x148 y110", "Hotkey Edit Mode is ON")
		HkEditModeOn.Add("Text", "x136 y140", "Switch it OFF and try again.")
		HkEditModeOn.SetFont()
		HkEditModeOn.SetFont("s9 " . MessageFontColor, MessageFontType)
		HkEditModeOn.Add("Text", "x0 y180 w470 h1 +0x5")
		HkEditModeOn.Add("Text", "x25 y190", "Copyright 2024 FDJ-Software. All Rights Reserved.")
		HkEditModeOn.SetFont()
		HkEditModeOn.SetFont("s8 " . MessageFontColor, MessageFontType)
		HkEditModeOn.Add("Text", "x25 y212", "Made with AutoHotkey V" A_AhkVersion . " " . (1 ? "Unicode" : "ANSI") . " " . (A_PtrSize == 8 ? "64-bit" : "32-bit"))
        ogcButtonOK := HkEditModeOn.Add("Button", "x370 y200 w80 h24", "OK")
		ogcButtonOK.OnEvent("Click", Destroy)
        HkEditModeOn.Title := "Hotkey Edit Mode ON"
		if GuiName == "TaskAutomatorGui1" {
			TaskAutomatorGui1.GetPos(&PosX, &PosY)
		} else {
			TaskAutomatorGui2.GetPos(&PosX, &PosY)
		}
        HkEditModeOn.Show("x" . PosX - 150 . " y" . PosY + 220 . "w470 h240")
        ControlFocus("Button1", "Hotkey Edit Mode ON")
        HkEditModeOn.Opt("+LastFound")
    Return
	Destroy(*){
		HkEditModeOn.Destroy()
	}
}
;----------------------------------------------------
MenuHandlerAbout(*){
	ShowAbout:
		if GuiPriorityAlwaysOnTop == true {
			About := Gui("+AlwaysOnTop")
		} else {
			About := Gui()
		}
		GuiName := IniRead(TempSystemFile, "GeneralData", "GuiName")
		About.BackColor := "0x" . BackgroundColor
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
				; Reload
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
		try {
			About.Add("Picture", "x9 y12 w64 h64 +border", IconLib . FDJ_SoftwareIcon)
		}
		catch {
		}
		About.SetFont("s20 W700 Q4 " . MessageAppNameFontColor, MessageAppNameFontType)
        About.Add("Text", "x80 y16", AppName)
		About.SetFont("s9 " . MessageFontColor, MessageFontType)
		About.Add("Text", "x303 y31 ", CurrentVersion)
		About.SetFont("s9 bold " . MessageFontColor, MessageFontType)
		About.Add("Text", "x80 y55 ", "License key: " )
		About.SetFont()
		About.SetFont("s8 Bold " . LicenseKeyFontColor, LicenseKeyFontType)
		About.Add("Text", "x160 y55 ", LicenseKey)
		About.Add("Text", "x0 y90 w470 h1 +0x5")
		About.SetFont()
		About.SetFont("s10 " . MessageMainMsgFontColor, MessageMainMsgFontType)
		About.Add("Text", "x135 y100", " Programmed and designed by: ")
		About.SetFont("s14 Bold " . MessageMainMsgFontColor, MessageMainMsgFontType)
		About.Add("Text", "x115 y125", Creator)
		; About.Add("Link", "x310 y115", "<a href=`"https://github.com/FDJ-Dash`">FDJ-Dash</a>")
		About.SetFont()
		About.SetFont("s9 " . MessageFontColor, MessageFontType)
		About.Add("Text", "x124 y156", " Support mail: fdj.software@gmail.com ")
		About.Add("Text", "x0 y180 w470 h1 +0x5")
        About.Add("Text", "x25 y190", "Copyright 2024 FDJ-Software. All Rights Reserved.")
		About.SetFont()
		About.SetFont("s8 " . MessageFontColor, MessageFontType)
		About.Add("Text", "x25 y212", "Made with AutoHotkey V" A_AhkVersion . " " . (1 ? "Unicode" : "ANSI") . " " . (A_PtrSize == 8 ? "64-bit" : "32-bit"))
		ogcButtonOK := About.Add("Button", "x370 y200 w80 h24", "OK")
		ogcButtonOK.OnEvent("Click", Destroy)
        About.Title := "About"
		if GuiName == "TaskAutomatorGui1" {
			TaskAutomatorGui1.GetPos(&PosX, &PosY)
		} else {
			TaskAutomatorGui2.GetPos(&PosX, &PosY)
		}
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
		GuiName := IniRead(TempSystemFile, "GeneralData", "GuiName")
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
				; Reload
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
		try {
			GuideMsg.Add("Picture", "x9 y12 w64 h64 +border", IconLib . FDJ_SoftwareIcon)
		}
		catch {
		}
		GuideMsg.SetFont("s20 W700 Q4 " . MessageAppNameFontColor, MessageAppNameFontType)
        GuideMsg.Add("Text", "x80 y16", AppName)
		GuideMsg.SetFont("s9 " . MessageFontColor, MessageFontType)
		GuideMsg.Add("Text", "x303 y31 ", CurrentVersion)
		GuideMsg.Add("Text", "x80 y55 ", "License key: " )
		GuideMsg.SetFont()
		GuideMsg.SetFont("s8 Bold " . LicenseKeyFontColor, LicenseKeyFontType)
		GuideMsg.Add("Text", "x160 y55 ", LicenseKey)
		GuideMsg.Add("Text", "x0 y90 w470 h1 +0x5")
		GuideMsg.SetFont()
		GuideMsg.SetFont("s12 " . MessageMainMsgFontColor, MessageMainMsgFontType)
		GuideMsg.Add("Text", "x100 y110", "The guide will open in your browser.")
        GuideMsg.Add("Text", "x137 y140", "You can close this message.")
		GuideMsg.SetFont()
		GuideMsg.SetFont("s9 " . MessageFontColor, MessageFontType)
		GuideMsg.Add("Text", "x0 y180 w470 h1 +0x5")
		GuideMsg.Add("Text", "x25 y190", "Copyright 2024 FDJ-Software. All Rights Reserved.")
		GuideMsg.SetFont()
		GuideMsg.SetFont("s8 " . MessageFontColor, MessageFontType)
		GuideMsg.Add("Text", "x25 y212", "Made with AutoHotkey V" A_AhkVersion . " " . (1 ? "Unicode" : "ANSI") . " " . (A_PtrSize == 8 ? "64-bit" : "32-bit"))
        ogcButtonOK := GuideMsg.Add("Button", "x370 y200 w80 h24 Default", "OK")
		ogcButtonOK.OnEvent("Click", Destroy)
        GuideMsg.Title := "Guide"
		if GuiName == "TaskAutomatorGui1" {
			TaskAutomatorGui1.GetPos(&PosX, &PosY)
		} else {
			TaskAutomatorGui2.GetPos(&PosX, &PosY)
		}
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
		GuiName := IniRead(TempSystemFile, "GeneralData", "GuiName")
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
				; Reload
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
		try {
			QuickAccMsg.Add("Picture", "x9 y12 w64 h64 +border", IconLib . FDJ_SoftwareIcon)
		}
		catch {
		}
		QuickAccMsg.SetFont("s20 W700 Q4 " . MessageAppNameFontColor, MessageAppNameFontType)
        QuickAccMsg.Add("Text", "x80 y16", AppName)
		QuickAccMsg.SetFont("s9 " . MessageFontColor, MessageFontType)
		QuickAccMsg.Add("Text", "x303 y31 ", CurrentVersion)
		QuickAccMsg.Add("Text", "x80 y55 ", "License key: " )
		QuickAccMsg.SetFont()
		QuickAccMsg.SetFont("s8 Bold " . LicenseKeyFontColor, LicenseKeyFontType)
		QuickAccMsg.Add("Text", "x160 y55 ", LicenseKey)
		QuickAccMsg.Add("Text", "x0 y90 w470 h1 +0x5")
		QuickAccMsg.SetFont()
		QuickAccMsg.SetFont("s12 " . MessageMainMsgFontColor, MessageMainMsgFontType)
		QuickAccMsg.Add("Text", "x80 y110", "To switch Quick Access Buttons you need to")
        QuickAccMsg.Add("Text", "x110 y140", "switch to Quick Access module first.")
		QuickAccMsg.SetFont()
		QuickAccMsg.SetFont("s9 " . MessageFontColor, MessageFontType)
		QuickAccMsg.Add("Text", "x0 y180 w470 h1 +0x5")
		QuickAccMsg.Add("Text", "x25 y190", "Copyright 2024 FDJ-Software. All Rights Reserved.")
		QuickAccMsg.SetFont()
		QuickAccMsg.SetFont("s8 " . MessageFontColor, MessageFontType)
		QuickAccMsg.Add("Text", "x25 y212", "Made with AutoHotkey V" A_AhkVersion . " " . (1 ? "Unicode" : "ANSI") . " " . (A_PtrSize == 8 ? "64-bit" : "32-bit"))
        ogcButtonOK := QuickAccMsg.Add("Button", "x370 y200 w80 h24 Default", "OK")
		ogcButtonOK.OnEvent("Click", Destroy)
        QuickAccMsg.Title := "Guide"
		if GuiName == "TaskAutomatorGui1" {
			TaskAutomatorGui1.GetPos(&PosX, &PosY)
		} else {
			TaskAutomatorGui2.GetPos(&PosX, &PosY)
		}
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
		GuiName := IniRead(TempSystemFile, "GeneralData", "GuiName")
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
				; Reload
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
		try {
			ConnectionMsg.Add("Picture", "x9 y12 w64 h64 +border", IconLib . FDJ_SoftwareIcon)
		}
		catch {
		}
		ConnectionMsg.SetFont("s20 W700 Q4 " . MessageAppNameFontColor, MessageAppNameFontType)
		ConnectionMsg.Add("Text", "x80 y16", AppName)
		ConnectionMsg.SetFont("s9 " . MessageFontColor, MessageFontType)
		ConnectionMsg.Add("Text", "x303 y31 ", CurrentVersion)
		ConnectionMsg.Add("Text", "x80 y55 ", "License key: " )
		ConnectionMsg.SetFont()
		ConnectionMsg.SetFont("s8 Bold " . LicenseKeyFontColor, LicenseKeyFontType)
		ConnectionMsg.Add("Text", "x160 y55 ", LicenseKey)
		ConnectionMsg.Add("Text", "x0 y90 w470 h1 +0x5")
		ConnectionMsg.SetFont()
		ConnectionMsg.SetFont("s12 cRed", MessageMainMsgFontType)
		ConnectionMsg.Add("Text", "x115 y110", "Unable to check for new updates.")
		ConnectionMsg.Add("Text", "x127 y140", "Please verify your connection.")		
		ConnectionMsg.SetFont()
		ConnectionMsg.SetFont("s9 " . MessageFontColor, MessageFontType)
		ConnectionMsg.Add("Text", "x0 y180 w470 h1 +0x5")
        ConnectionMsg.Add("Text", "x25 y190", "Copyright 2024 FDJ-Software. All Rights Reserved.")
		ConnectionMsg.SetFont()
		ConnectionMsg.SetFont("s8 " . MessageFontColor, MessageFontType)
		ConnectionMsg.Add("Text", "x25 y212", "Made with AutoHotkey V" A_AhkVersion . " " . (1 ? "Unicode" : "ANSI") . " " . (A_PtrSize == 8 ? "64-bit" : "32-bit"))
		ogcButtonOK := ConnectionMsg.Add("Button", "x370 y200 w80 h24", "OK")
		ogcButtonOK.OnEvent("Click", Destroy)
        ConnectionMsg.Title := "Connection Failed!"
		if GuiName == "TaskAutomatorGui1" {
			TaskAutomatorGui1.GetPos(&PosX, &PosY)
		} else {
			TaskAutomatorGui2.GetPos(&PosX, &PosY)
		}
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
		GuiName := IniRead(TempSystemFile, "GeneralData", "GuiName")
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
				; Reload
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
		try {
			UpToDateMsg.Add("Picture", "x9 y12 w64 h64 +border", IconLib . FDJ_SoftwareIcon)
		}
		catch {
		}
		UpToDateMsg.SetFont("s20 W700 Q4 " . MessageAppNameFontColor, MessageAppNameFontType)
		UpToDateMsg.Add("Text", "x80 y16", AppName)
		UpToDateMsg.SetFont("s9 " . MessageFontColor, MessageFontType)
		UpToDateMsg.Add("Text", "x303 y31 ", CurrentVersion)
		UpToDateMsg.Add("Text", "x80 y55 ", "License key: " )
		UpToDateMsg.SetFont()
		UpToDateMsg.SetFont("s8 Bold " . LicenseKeyFontColor, LicenseKeyFontType)
		UpToDateMsg.Add("Text", "x160 y55 ", LicenseKey)
		UpToDateMsg.Add("Text", "x0 y90 w470 h1 +0x5")
		UpToDateMsg.SetFont()
		UpToDateMsg.SetFont("s12 " . MessageMainMsgFontColor, MessageMainMsgFontType)
		UpToDateMsg.Add("Text", "x135 y123", "Current version is up to date!")
		UpToDateMsg.SetFont()
		UpToDateMsg.SetFont("s9 " . MessageFontColor, MessageFontType)
		UpToDateMsg.Add("Text", "x0 y180 w470 h1 +0x5")
        UpToDateMsg.Add("Text", "x25 y190", "Copyright 2024 FDJ-Software. All Rights Reserved.")
		UpToDateMsg.SetFont()
		UpToDateMsg.SetFont("s8 " . MessageFontColor, MessageFontType)
		UpToDateMsg.Add("Text", "x25 y212", "Made with AutoHotkey V" A_AhkVersion . " " . (1 ? "Unicode" : "ANSI") . " " . (A_PtrSize == 8 ? "64-bit" : "32-bit"))
		ogcButtonOK := UpToDateMsg.Add("Button", "x370 y200 w80 h24", "OK")
		ogcButtonOK.OnEvent("Click", Destroy)
        UpToDateMsg.Title := "Up To Date!"
		if GuiName == "TaskAutomatorGui1" {
			TaskAutomatorGui1.GetPos(&PosX, &PosY)
		} else {
			TaskAutomatorGui2.GetPos(&PosX, &PosY)
		}
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
		GuiName := IniRead(TempSystemFile, "GeneralData", "GuiName")
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
				; Reload
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
		try {
			NewVerMsg.Add("Picture", "x9 y12 w64 h64 +border", IconLib . FDJ_SoftwareIcon)
		}
		catch {
		}
		NewVerMsg.SetFont("s20 W700 Q4 " . MessageAppNameFontColor, MessageAppNameFontType)
		NewVerMsg.Add("Text", "x80 y16", AppName)
		NewVerMsg.SetFont("s9 " . MessageFontColor, MessageFontType)
		NewVerMsg.Add("Text", "x303 y31 ", CurrentVersion)
		NewVerMsg.Add("Text", "x80 y55 ", "License key: " )
		NewVerMsg.SetFont()
		NewVerMsg.SetFont("s8 Bold " . LicenseKeyFontColor, LicenseKeyFontType)
		NewVerMsg.Add("Text", "x160 y55 ", LicenseKey)
		NewVerMsg.Add("Text", "x0 y90 w470 h1 +0x5")
		NewVerMsg.SetFont()
		NewVerMsg.SetFont("s12 " . MessageMainMsgFontColor, MessageMainMsgFontType)
		NewVerMsg.Add("Text", "x100 y115", "New release version " . ReleaseVersion . " is available")
		NewVerMsg.SetFont()
		NewVerMsg.SetFont("s9 " . MessageFontColor, MessageFontType)
		ogcButtonUpdate := NewVerMsg.Add("Button", "x190 y145 w80 h24", "Download")
		ogcButtonUpdate.OnEvent("Click", UpdateDownload)
		NewVerMsg.Add("Text", "x0 y180 w470 h1 +0x5")
        NewVerMsg.Add("Text", "x25 y190", "Copyright 2024 FDJ-Software. All Rights Reserved.")
		NewVerMsg.SetFont()
		NewVerMsg.SetFont("s8 " . MessageFontColor, MessageFontType)
		NewVerMsg.Add("Text", "x25 y212", "Made with AutoHotkey V" A_AhkVersion . " " . (1 ? "Unicode" : "ANSI") . " " . (A_PtrSize == 8 ? "64-bit" : "32-bit"))
		ogcButtonOK := NewVerMsg.Add("Button", "x370 y200 w80 h24", "Close")
		ogcButtonOK.OnEvent("Click", Destroy)
        NewVerMsg.Title := "New Version Available!"
		if GuiName == "TaskAutomatorGui1" {
			TaskAutomatorGui1.GetPos(&PosX, &PosY)
		} else {
			TaskAutomatorGui2.GetPos(&PosX, &PosY)
		}
        NewVerMsg.Show("x" . PosX - 150 . " y" . PosY + 220 . "w470 h240")
        ControlFocus("Button1", "New Version Available!")
        NewVerMsg.Opt("+LastFound")
		NewVerMsg.OnEvent("Close", NewVerMsg_Close)
	Return
	Destroy(*){
		NewVerMsg.Destroy()
	}
	UpdateDownload(*){
		TAName := IniRead(DataFile, "GeneralData", "TAName")
		; Scaped character included: ``
		TADownloadPart1 := "PLjr_f_[HF16S_KEBLbjHF16AJKEQ[23BIPLRZU\gc75EJ7?U\c_LTahPL7?Y``ok``h]d93so=EY``eaT\BLNUgcZbW^JFdlCAEJ71HTV``CA,5ovgcNVelmi\d3:JFT\ahsoX``49KEY``sobjW^kgV``V^ahgcNVovMIB@PX<Cgc?DFCGR23EQJS89amGU,5+(ZbKRJK<HDObkTUwsBNjr9@V_E?DRVW_kmiDMbj>?KWPYHOc_.6\]am\eNUGC.6``a]d6B=:;Fc_PYLTJXY``YUIQBI.+D@XYNV_k]dGC>GFNDEGRip6B5C;D>?Q]=:>I;DAOPQ6BfoPL\dno[bQ["
		TADownloadPart1 := DecriptMsg(TADownloadPart1)
		;------------------------
		TADownloadPart2 := IniRead(DataFile, "EncriptedData", "TADownload")
		TADownloadPart2 := DecriptMsg(TADownloadPart2)
		;------------------------
		TADownloadPart3 := "42so"
		TADownloadPart3 := DecriptMsg(TADownloadPart3)
		;------------------------
		TADownloadPart4 := FileSelect("S16", A_MyDocuments . "\" . TAName , "Save File", "Executable files (*.exe)")
		FullPathDownLoad := TADownloadPart1 . " " . TADownloadPart2 . " " . TADownloadPart3 . " " . TADownloadPart4
		if TADownloadPart4 != "" {
			RunWait(A_ComSpec " /c " . FullPathDownLoad . " > " TempCleanFileTA, , "Hide")
		}
		NewVerMsg.Destroy()
	}
	NewVerMsg_Close(*){
		try {
			FileDelete DataFile
			FileDelete TempCleanFileTA
		}
		catch {
		}
	}
}