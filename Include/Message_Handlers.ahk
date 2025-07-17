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
; VerifyingPortAccess(*)
; Port3306Blocked(*)
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
				Exitmsg.Add("Picture", "x0 y0 w500 h240", ImageLib . DefaultMsgBackgroundImage)
			}
			catch {
			}
		} else {
			try {
				Exitmsg.Add("Picture", "x0 y0 w500 h240", MessageBackgroundPicture)
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
				IniWrite true, TempSystemFile, "GeneralData", "DynamicReload"
			}
		}
		try {
			Exitmsg.Add("Picture", "x9 y10 w32 h32 +border", IconLib . FDJ_SoftwareIcon)
		}
		catch {
		}
		Exitmsg.SetFont("s16 W700 Q4 " . MessageAppNameFontColor, MessageAppNameFontType)
		Exitmsg.Add("Text", "x50 y16 +Center w420", AppName)
		Exitmsg.Add("Text", "x470 y16 +Center w20", "")
		Exitmsg.SetFont("s9 " . MessageFontColor, MessageFontType)
		Exitmsg.Add("Text", "x355 y24 ", CurrentVersion)
		Exitmsg.Add("Text", "x0 y54 w500 h1 +0x5")
		;-----------------
		Exitmsg.SetFont()
		Exitmsg.SetFont("s14 " . MessageMainMsgFontColor, MessageMainMsgFontType)
		Exitmsg.Add("Text", "x70 y110 +Center w360 +0x200", "Task Automator will close in " ExitMessageTimeWait / 1000 " seconds")
        Exitmsg.Add("Text", "x130 y140 +Center w240 +0x200", "Have a nice day!")
		;-----------------
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
        Exitmsg.Show("x" . PosX - 150 . " y" . PosY + 220 . "w500 h240")
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
				InvLicMsg.Add("Picture", "x0 y0 w500 h240", ImageLib . DefaultMsgBackgroundImage)
			}
			catch {
			}
		} else {
			try {
				InvLicMsg.Add("Picture", "x0 y0 w500 h240", MessageBackgroundPicture)
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
				IniWrite true, TempSystemFile, "GeneralData", "DynamicReload"
			}
		}
		try {
			InvLicMsg.Add("Picture", "x9 y10 w32 h32 +border", IconLib . FDJ_SoftwareIcon)
		}
		catch {
		}
		InvLicMsg.SetFont("s16 W700 Q4 " . MessageAppNameFontColor, MessageAppNameFontType)
		InvLicMsg.Add("Text", "x50 y16 +Center w420", AppName)
		InvLicMsg.Add("Text", "x470 y16 +Center w20", "")
		InvLicMsg.SetFont("s9 " . MessageFontColor, MessageFontType)
		InvLicMsg.Add("Text", "x355 y24 ", CurrentVersion)
		InvLicMsg.Add("Text", "x0 y54 w500 h1 +0x5")
		;-----------------
		InvLicMsg.SetFont()
		InvLicMsg.SetFont("s14 cRed", MessageMainMsgFontType)
		InvLicMsg.Add("Text", "x130 y110 +Center w240 +0x200", "Invalid License Key")
        InvLicMsg.Add("Text", "x70 y140 +Center w360 +0x200", "Task Automator will close in " ExitMessageTimeWait / 1000 " seconds")
		;-----------------
        InvLicMsg.Title := "Invalid License Key!"
		if GuiName == "TaskAutomatorGui1" {
			TaskAutomatorGui1.GetPos(&PosX, &PosY)
		} else {
			TaskAutomatorGui2.GetPos(&PosX, &PosY)
		}
        InvLicMsg.Show("x" . PosX - 150 . " y" . PosY + 220 . "w500 h240")
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
				NoLicFileMsg.Add("Picture", "x0 y0 w500 h240", ImageLib . DefaultMsgBackgroundImage)
			}
			catch {
			}
		} else {
			try {
				NoLicFileMsg.Add("Picture", "x0 y0 w500 h240", MessageBackgroundPicture)
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
				IniWrite true, TempSystemFile, "GeneralData", "DynamicReload"
			}
		}
		try {
			NoLicFileMsg.Add("Picture", "x9 y10 w32 h32 +border", IconLib . FDJ_SoftwareIcon)
		}
		catch {
		}
		NoLicFileMsg.SetFont("s16 W700 Q4 " . MessageAppNameFontColor, MessageAppNameFontType)
		NoLicFileMsg.Add("Text", "x50 y16 +Center w420", AppName)
		NoLicFileMsg.Add("Text", "x470 y16 +Center w20", "")
		NoLicFileMsg.SetFont("s9 " . MessageFontColor, MessageFontType)
		NoLicFileMsg.Add("Text", "x355 y24 ", CurrentVersion)
		NoLicFileMsg.Add("Text", "x0 y54 w500 h1 +0x5")
		;-----------------
		NoLicFileMsg.SetFont()
		NoLicFileMsg.SetFont("s14 cRed", MessageMainMsgFontType)
		NoLicFileMsg.Add("Text", "x130 y110 +Center w240 +0x200", "License file not found")
        NoLicFileMsg.Add("Text", "x70 y140 +Center w360 +0x200", "Task Automator will close in " ExitMessageTimeWait / 1000 " seconds")
		;-----------------
        NoLicFileMsg.Title := "Invalid License Key!"
		if GuiName == "TaskAutomatorGui1" {
			TaskAutomatorGui1.GetPos(&PosX, &PosY)
		} else {
			TaskAutomatorGui2.GetPos(&PosX, &PosY)
		}
        NoLicFileMsg.Show("x" . PosX - 150 . " y" . PosY + 220 . "w500 h240")
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
				InvPathmsg.Add("Picture", "x0 y0 w500 h240", ImageLib . DefaultMsgBackgroundImage)
			}
			catch {
			}
		} else {
			try {
				InvPathmsg.Add("Picture", "x0 y0 w500 h240", MessageBackgroundPicture)
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
				IniWrite true, TempSystemFile, "GeneralData", "DynamicReload"
			}
		}
		try {
			InvPathmsg.Add("Picture", "x9 y10 w32 h32 +border", IconLib . FDJ_SoftwareIcon)
		}
		catch {
		}
		InvPathmsg.SetFont("s16 W700 Q4 " . MessageAppNameFontColor, MessageAppNameFontType)
		InvPathmsg.Add("Text", "x50 y16 +Center w420", AppName)
		InvPathmsg.Add("Text", "x470 y16 +Center w20", "")
		InvPathmsg.SetFont("s9 " . MessageFontColor, MessageFontType)
		InvPathmsg.Add("Text", "x355 y24 ", CurrentVersion)
		InvPathmsg.Add("Text", "x0 y54 w500 h1 +0x5")
		;-----------------
		InvPathmsg.SetFont()
		InvPathmsg.SetFont("s14 " . MessageMainMsgFontColor, MessageMainMsgFontType)
		InvPathmsg.Add("Text", "x100 y125 +Center w300 +0x200", "Your path input is invalid.")
        ;-----------------
		InvPathmsg.Title := "Invalid path"
		if GuiName == "TaskAutomatorGui1" {
			TaskAutomatorGui1.GetPos(&PosX, &PosY)
		} else {
			TaskAutomatorGui2.GetPos(&PosX, &PosY)
		}
        InvPathmsg.Show("x" . PosX - 150 . " y" . PosY + 220 . "w500 h240")
        InvPathmsg.Opt("+LastFound")
		Destroy()
    Return
	Destroy(*){
	    Sleep ExitMessageTimeWait
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
				DupHkValue.Add("Picture", "x0 y0 w500 h240", ImageLib . DefaultMsgBackgroundImage)
			}
			catch {
			}
		} else {
			try {
				DupHkValue.Add("Picture", "x0 y0 w500 h240", MessageBackgroundPicture)
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
				IniWrite true, TempSystemFile, "GeneralData", "DynamicReload"
			}
		}
		try {
			DupHkValue.Add("Picture", "x9 y10 w32 h32 +border", IconLib . FDJ_SoftwareIcon)
		}
		catch {
		}
		DupHkValue.SetFont("s16 W700 Q4 " . MessageAppNameFontColor, MessageAppNameFontType)
		DupHkValue.Add("Text", "x50 y16 +Center w420", AppName)
		DupHkValue.Add("Text", "x470 y16 +Center w20", "")
		DupHkValue.SetFont("s9 " . MessageFontColor, MessageFontType)
		DupHkValue.Add("Text", "x355 y24 ", CurrentVersion)
		DupHkValue.Add("Text", "x0 y54 w500 h1 +0x5")
		;-----------------
		DupHkValue.SetFont()
		DupHkValue.SetFont("s14 cRed", MessageMainMsgFontType)
		DupHkValue.Add("Text", "x20 y110 +Center w460 +0x200", "Duplicated hotkey values is a dangerous configuration.")
		DupHkValue.Add("Text", "x100 y140 +Center w300 +0x200", "Returning to default values.")
        ;-----------------
		DupHkValue.Title := "Duplicated Hotkey Values"
		PosX := IniRead(IniFile, "Properties", "PositionX")
		PosY := IniRead(IniFile, "Properties", "PositionY")
        DupHkValue.Show("x" . PosX - 150 . " y" . PosY + 220 . "w500 h240")
        DupHkValue.Opt("+LastFound")
		Destroy()
    Return
	Destroy(*){
	    Sleep ExitMessageTimeWait
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
				Savemsg.Add("Picture", "x0 y0 w500 h240", ImageLib . DefaultMsgBackgroundImage)
			}
			catch {
			}
		} else {
			try {
				Savemsg.Add("Picture", "x0 y0 w500 h240", MessageBackgroundPicture)
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
				IniWrite true, TempSystemFile, "GeneralData", "DynamicReload"
			}
		}
		try {
			Savemsg.Add("Picture", "x9 y10 w32 h32 +border", IconLib . FDJ_SoftwareIcon)
		}
		catch {
		}
		Savemsg.SetFont("s16 W700 Q4 " . MessageAppNameFontColor, MessageAppNameFontType)
		Savemsg.Add("Text", "x50 y16 +Center w420", AppName)
		Savemsg.Add("Text", "x470 y16 +Center w20", "")
		Savemsg.SetFont("s9 " . MessageFontColor, MessageFontType)
		Savemsg.Add("Text", "x355 y24 ", CurrentVersion)
		Savemsg.Add("Text", "x0 y54 w500 h1 +0x5")
		;-----------------
		Savemsg.SetFont()
		Savemsg.SetFont("s14 " . MessageMainMsgFontColor, MessageMainMsgFontType)
		Savemsg.Add("Text", "x90 y125 +Center w320 +0x200", "Values saved successfully to ini file")
		;-----------------
		Savemsg.Title := "Save Successful!"
		if GuiName == "TaskAutomatorGui1" {
			TaskAutomatorGui1.GetPos(&PosX, &PosY)
		} else {
			TaskAutomatorGui2.GetPos(&PosX, &PosY)
		}
        Savemsg.Show("x" . PosX - 150 . " y" . PosY + 220 . "w500 h240")
        Savemsg.Opt("+LastFound")
		Destroy()
    Return
	Destroy(*){
	    Sleep SaveSuccesfullTimeWait
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
				HkEnabled.Add("Picture", "x0 y0 w500 h240", ImageLib . DefaultMsgBackgroundImage)
			}
			catch {
			}
		} else {
			try {
				HkEnabled.Add("Picture", "x0 y0 w500 h240", MessageBackgroundPicture)
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
				IniWrite true, TempSystemFile, "GeneralData", "DynamicReload"
			}
		}
		try {
			HkEnabled.Add("Picture", "x9 y10 w32 h32 +border", IconLib . FDJ_SoftwareIcon)
		}
		catch {
		}
		HkEnabled.SetFont("s16 W700 Q4 " . MessageAppNameFontColor, MessageAppNameFontType)
		HkEnabled.Add("Text", "x50 y16 +Center w420", AppName)
		HkEnabled.Add("Text", "x470 y16 +Center w20", "")
		HkEnabled.SetFont("s9 " . MessageFontColor, MessageFontType)
		HkEnabled.Add("Text", "x355 y24 ", CurrentVersion)
		HkEnabled.Add("Text", "x0 y54 w470 h1 +0x5")
		;-----------------
		HkEnabled.SetFont()
		HkEnabled.SetFont("s14 " . MessageMainMsgFontColor, MessageMainMsgFontType)
		HkEnabled.Add("Text", "x120 y125 +Center w260 +0x200", "Hotkeys Enabled")
		;-----------------
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
        HkEnabled.Show("x" . PosX - 150 . " y" . PosY + 220 . "w500 h240")
        HkEnabled.Opt("+LastFound")
		Destroy()
    Return
	
	Destroy(*) {
	    Sleep SuspendedHotkeysTimeWait
		HkEnabled.Destroy()
	}
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
				HkDisabled.Add("Picture", "x0 y0 w500 h240", ImageLib . DefaultMsgBackgroundImage)
			}
			catch {
			}
		} else {
			try {
				HkDisabled.Add("Picture", "x0 y0 w500 h240", MessageBackgroundPicture)
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
				IniWrite true, TempSystemFile, "GeneralData", "DynamicReload"
			}
		}
		try {
			HkDisabled.Add("Picture", "x9 y10 w32 h32 +border", IconLib . FDJ_SoftwareIcon)
		}
		catch {
		}
		HkDisabled.SetFont("s16 W700 Q4 " . MessageAppNameFontColor, MessageAppNameFontType)
		HkDisabled.Add("Text", "x50 y16 +Center w420", AppName)
		HkDisabled.Add("Text", "x470 y16 +Center w20", "")
		HkDisabled.SetFont("s9 " . MessageFontColor, MessageFontType)
		HkDisabled.Add("Text", "x355 y24 ", CurrentVersion)
		HkDisabled.Add("Text", "x0 y54 w500 h1 +0x5")
		;-----------------
		HkDisabled.SetFont()
		HkDisabled.SetFont("s14 " . MessageMainMsgFontColor, MessageMainMsgFontType)
		HkDisabled.Add("Text", "x120 y110 +Center w260 +0x200", "Hotkeys Suspended")
		HkDisabled.Add("Text", "x100 y140 +Center w300 +0x200", "Press " . SuspendHotkeysKey . " again to anable them.")
		;-----------------
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
        HkDisabled.Show("x" . PosX - 150 . " y" . PosY + 220 . "w500 h240")
        HkDisabled.Opt("+LastFound")
		Destroy()
    Return
	
	Destroy(*) {
	    Sleep SuspendedHotkeysTimeWait
		HkDisabled.Destroy()
	}
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
				HkEditModeOn.Add("Picture", "x0 y0 w500 h240", ImageLib . DefaultMsgBackgroundImage)
			}
			catch {
			}
		} else {
			try {
				HkEditModeOn.Add("Picture", "x0 y0 w500 h240", MessageBackgroundPicture)
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
				IniWrite true, TempSystemFile, "GeneralData", "DynamicReload"
			}
		}
		try {
			HkEditModeOn.Add("Picture", "x9 y10 w32 h32 +border", IconLib . FDJ_SoftwareIcon)
		}
		catch {
		}
		HkEditModeOn.SetFont("s16 W700 Q4 " . MessageAppNameFontColor, MessageAppNameFontType)
		HkEditModeOn.Add("Text", "x50 y16 +Center w420", AppName)
		HkEditModeOn.Add("Text", "x470 y16 +Center w20", "")
		HkEditModeOn.SetFont("s9 " . MessageFontColor, MessageFontType)
		HkEditModeOn.Add("Text", "x355 y24 ", CurrentVersion)
		HkEditModeOn.Add("Text", "x0 y54 w500 h1 +0x5")
		;-----------------
		HkEditModeOn.SetFont()
		HkEditModeOn.SetFont("s14 " . MessageMainMsgFontColor, MessageMainMsgFontType)
		HkEditModeOn.Add("Text", "x100 y110 +Center w300 +0x200", "Hotkey Edit Mode is ON")
		HkEditModeOn.Add("Text", "x100 y140 +Center w300 +0x200", "Switch it OFF and try again.")
        ;-----------------
        HkEditModeOn.Title := "Hotkey Edit Mode ON"
		if GuiName == "TaskAutomatorGui1" {
			TaskAutomatorGui1.GetPos(&PosX, &PosY)
		} else {
			TaskAutomatorGui2.GetPos(&PosX, &PosY)
		}
        HkEditModeOn.Show("x" . PosX - 150 . " y" . PosY + 220 . "w500 h240")
        HkEditModeOn.Opt("+LastFound")
		Destroy()
    Return
	Destroy(*){
	    Sleep ExitMessageTimeWait
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
				About.Add("Picture", "x0 y0 w500 h240", ImageLib . DefaultMsgBackgroundImage)
			}
			catch {
			}
		} else {
			try {
				About.Add("Picture", "x0 y0 w500 h240", MessageBackgroundPicture)
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
				IniWrite true, TempSystemFile, "GeneralData", "DynamicReload"
			}
		}
		try {
			About.Add("Picture", "x9 y10 w32 h32 +border", IconLib . FDJ_SoftwareIcon)
		}
		catch {
		}
		About.SetFont("s16 W700 Q4 " . MessageAppNameFontColor, MessageAppNameFontType)
		About.Add("Text", "x50 y16 +Center w420", AppName)
		About.Add("Text", "x470 y16 +Center w20", "")
		About.SetFont("s9 " . MessageFontColor, MessageFontType)
		About.Add("Text", "x355 y24 ", CurrentVersion)
		About.Add("Text", "x0 y54 w500 h1 +0x5")
		;-----------------
		About.SetFont()
		About.SetFont("s10 " . MessageMainMsgFontColor, MessageMainMsgFontType)
		About.Add("Text", "x100 y75 +Center w300 h23 +0x200", " Programmed and designed by: ")
		About.SetFont("s14 " . MessageMainMsgFontColor, MessageMainMsgFontType)
		About.Add("Text", "x100 y105 +Center w300 h28 +0x200", Creator)
		About.SetFont()
		About.SetFont("s10 " . MessageFontColor, MessageFontType)
		About.Add("Text", "x100 y140 +Center w300 h23 +0x200", " Support mail: fdj.software@gmail.com ")
		About.Add("Text", "x0 y186 w500 h1 +0x5")
		About.SetFont()
		About.SetFont("s10 " . MessageFontColor, MessageFontType)
		About.Add("Text", "x10 y200 +Center w370 h23 +0x200", "Copyright 2024 FDJ-Software. All Rights Reserved.")
		About.SetFont()
		About.SetFont("s8 " . MessageFontColor, MessageFontType)
		ogcButtonOK := About.Add("Button", "x400 y200 w80 h24", "OK")
		ogcButtonOK.OnEvent("Click", Destroy)
		;-----------------
        About.Title := "About"
		if GuiName == "TaskAutomatorGui1" {
			TaskAutomatorGui1.GetPos(&PosX, &PosY)
		} else {
			TaskAutomatorGui2.GetPos(&PosX, &PosY)
		}
        About.Show("x" . PosX - 150 . " y" . PosY + 220 . "w500 h240")
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
				GuideMsg.Add("Picture", "x0 y0 w500 h240", ImageLib . DefaultMsgBackgroundImage)
			}
			catch {
			}
		} else {
			try {
				GuideMsg.Add("Picture", "x0 y0 w500 h240", MessageBackgroundPicture)
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
				IniWrite true, TempSystemFile, "GeneralData", "DynamicReload"
			}
		}
		try {
			GuideMsg.Add("Picture", "x9 y10 w32 h32 +border", IconLib . FDJ_SoftwareIcon)
		}
		catch {
		}
		GuideMsg.SetFont("s16 W700 Q4 " . MessageAppNameFontColor, MessageAppNameFontType)
		GuideMsg.Add("Text", "x50 y16 +Center w420", AppName)
		GuideMsg.Add("Text", "x470 y16 +Center w20", "")
		GuideMsg.SetFont("s9 " . MessageFontColor, MessageFontType)
		GuideMsg.Add("Text", "x355 y24 ", CurrentVersion)
		GuideMsg.Add("Text", "x0 y54 w500 h1 +0x5")
		;-----------------
		GuideMsg.SetFont()
		GuideMsg.SetFont("s14 " . MessageMainMsgFontColor, MessageMainMsgFontType)
		GuideMsg.Add("Text", "x80 y125 +Center w340 +0x200", "The guide will open in your browser.")
        ;-----------------
        GuideMsg.Title := "Guide"
		if GuiName == "TaskAutomatorGui1" {
			TaskAutomatorGui1.GetPos(&PosX, &PosY)
		} else {
			TaskAutomatorGui2.GetPos(&PosX, &PosY)
		}
        GuideMsg.Show("x" . PosX - 150 . " y" . PosY + 220 . "w500 h240")
        GuideMsg.Opt("+LastFound")
		run HotkeyGuide
		Destroy()
    Return
	
	Destroy(*){
	    Sleep ExitMessageTimeWait
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
				QuickAccMsg.Add("Picture", "x0 y0 w500 h240", ImageLib . DefaultMsgBackgroundImage)
			}
			catch {
			}
		} else {
			try {
				QuickAccMsg.Add("Picture", "x0 y0 w500 h240", MessageBackgroundPicture)
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
				IniWrite true, TempSystemFile, "GeneralData", "DynamicReload"
			}
		}
		try {
			QuickAccMsg.Add("Picture", "x9 y10 w32 h32 +border", IconLib . FDJ_SoftwareIcon)
		}
		catch {
		}
		QuickAccMsg.SetFont("s16 W700 Q4 " . MessageAppNameFontColor, MessageAppNameFontType)
		QuickAccMsg.Add("Text", "x50 y16 +Center w420", AppName)
		QuickAccMsg.Add("Text", "x470 y16 +Center w20", "")
		QuickAccMsg.SetFont("s9 " . MessageFontColor, MessageFontType)
		QuickAccMsg.Add("Text", "x355 y24 ", CurrentVersion)
		QuickAccMsg.Add("Text", "x0 y54 w500 h1 +0x5")
		;-----------------
		QuickAccMsg.SetFont()
		QuickAccMsg.SetFont("s14 " . MessageMainMsgFontColor, MessageMainMsgFontType)
		QuickAccMsg.Add("Text", "x50 y110 +Center w400 +0x200", "To switch Quick Access Buttons you need to")
        QuickAccMsg.Add("Text", "x90 y140 +Center w320 +0x200", "switch to Quick Access module first.")
        ;-----------------
		QuickAccMsg.SetFont("s8 " . MessageFontColor, MessageFontType)
        ogcButtonOK := QuickAccMsg.Add("Button", "x210 y190 w80 h24 Default", "OK")
		ogcButtonOK.OnEvent("Click", Destroy)
        QuickAccMsg.Title := "Guide"
		if GuiName == "TaskAutomatorGui1" {
			TaskAutomatorGui1.GetPos(&PosX, &PosY)
		} else {
			TaskAutomatorGui2.GetPos(&PosX, &PosY)
		}
        QuickAccMsg.Show("x" . PosX - 150 . " y" . PosY + 220 . "w500 h240")
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
				ConnectionMsg.Add("Picture", "x0 y0 w500 h240", ImageLib . DefaultMsgBackgroundImage)
			}
			catch {
			}
		} else {
			try {
				ConnectionMsg.Add("Picture", "x0 y0 w500 h240", MessageBackgroundPicture)
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
				IniWrite true, TempSystemFile, "GeneralData", "DynamicReload"
			}
		}
		try {
			ConnectionMsg.Add("Picture", "x9 y10 w32 h32 +border", IconLib . FDJ_SoftwareIcon)
		}
		catch {
		}
		ConnectionMsg.SetFont("s16 W700 Q4 " . MessageAppNameFontColor, MessageAppNameFontType)
		ConnectionMsg.Add("Text", "x50 y16 +Center w420", AppName)
		ConnectionMsg.Add("Text", "x470 y16 +Center w20", "")
		ConnectionMsg.SetFont("s9 " . MessageFontColor, MessageFontType)
		ConnectionMsg.Add("Text", "x355 y24 ", CurrentVersion)
		ConnectionMsg.Add("Text", "x0 y54 w500 h1 +0x5")
		;-----------------
		ConnectionMsg.SetFont()
		ConnectionMsg.SetFont("s14 cRed", MessageMainMsgFontType)
		ConnectionMsg.Add("Text", "x90 y110 +Center w320 +0x200", "Unable to check for new updates.")
		ConnectionMsg.Add("Text", "x100 y140 +Center w300 +0x200", "Please verify your connection.")		
		ConnectionMsg.SetFont("s8 " . MessageFontColor, MessageFontType)
		ogcButtonOK := ConnectionMsg.Add("Button", "x210 y190 w80 h24", "OK")
		ogcButtonOK.OnEvent("Click", Destroy)
		;-----------------
        ConnectionMsg.Title := "Connection Failed!"
		if GuiName == "TaskAutomatorGui1" {
			TaskAutomatorGui1.GetPos(&PosX, &PosY)
		} else {
			TaskAutomatorGui2.GetPos(&PosX, &PosY)
		}
        ConnectionMsg.Show("x" . PosX - 150 . " y" . PosY + 220 . "w500 h240")
        ControlFocus("Button1", "Connection Failed!")
        ConnectionMsg.Opt("+LastFound")
	Return
	Destroy(*){
		ConnectionMsg.Destroy()
	}
}
;----------------------------------------------------
VerifyingPortAccess(*) {
	VerifPortAccess:
		if GuiPriorityAlwaysOnTop == true {
			VerifPortAccess := Gui("+AlwaysOnTop")
		} else {
			VerifPortAccess := Gui()
		}
		GuiName := IniRead(TempSystemFile, "GeneralData", "GuiName")
		VerifPortAccess.BackColor := "0x" . BackgroundColor
		MessageBackgroundPicture := IniRead(IniFile, "Background", "MessageBackgroundPicture")
		if MessageBackgroundPicture == "" {
		try {
				VerifPortAccess.Add("Picture", "x0 y0 w500 h240", ImageLib . DefaultMsgBackgroundImage)
			}
			catch {
			}
		} else {
			try {
				VerifPortAccess.Add("Picture", "x0 y0 w500 h240", MessageBackgroundPicture)
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
				IniWrite true, TempSystemFile, "GeneralData", "DynamicReload"
			}
		}
		try {
			VerifPortAccess.Add("Picture", "x9 y10 w32 h32 +border", IconLib . FDJ_SoftwareIcon)
		}
		catch {
		}
		VerifPortAccess.SetFont("s16 W700 Q4 " . MessageAppNameFontColor, MessageAppNameFontType)
		VerifPortAccess.Add("Text", "x50 y16 +Center w420", AppName)
		VerifPortAccess.Add("Text", "x470 y16 +Center w20", "")
		VerifPortAccess.SetFont("s9 " . MessageFontColor, MessageFontType)
		VerifPortAccess.Add("Text", "x355 y24 ", CurrentVersion)
		VerifPortAccess.Add("Text", "x0 y54 w500 h1 +0x5")
		;-----------------
		VerifPortAccess.SetFont()
		VerifPortAccess.SetFont("s14 " . MessageMainMsgFontColor, MessageMainMsgFontType)
		VerifPortAccess.Add("Text", "x100 y80 +Center w300 +0x200", "Authenticating session.")
		VerifPortAccess.Add("Text", "x50 y110 +Center w400 +0x200", "If ports are blocked then")
		VerifPortAccess.Add("Text", "x10 y140 +Center w480 +0x200", "the extensive check will take up to a minute")
        VerifPortAccess.SetFont("s8 " . MessageFontColor, MessageFontType)
		ogcButtonOK := VerifPortAccess.Add("Button", "x210 y190 w80 h24", "OK")
		ogcButtonOK.OnEvent("Click", Destroy)
		;-----------------
        VerifPortAccess.Title := "Port Access Verification"
		if GuiName == "TaskAutomatorGui1" {
			TaskAutomatorGui1.GetPos(&PosX, &PosY)
		} else {
			TaskAutomatorGui2.GetPos(&PosX, &PosY)
		}
        VerifPortAccess.Show("x" . PosX - 150 . " y" . PosY + 220 . "w500 h240")
        VerifPortAccess.Opt("+LastFound")
		Sleep ExitMessageTimeWait
		VerifPortAccess.Destroy()
    Return
	Destroy(*){
		VerifPortAccess.Destroy()
	}
}
;----------------------------------------------------
Port3306Blocked(*) {
	PortBlocked:
		if GuiPriorityAlwaysOnTop == true {
			PortBlocked := Gui("+AlwaysOnTop")
		} else {
			PortBlocked := Gui()
		}
		GuiName := IniRead(TempSystemFile, "GeneralData", "GuiName")
		PortBlocked.BackColor := "0x" . BackgroundColor
		MessageBackgroundPicture := IniRead(IniFile, "Background", "MessageBackgroundPicture")
		if MessageBackgroundPicture == "" {
		try {
				PortBlocked.Add("Picture", "x0 y0 w500 h240", ImageLib . DefaultMsgBackgroundImage)
			}
			catch {
			}
		} else {
			try {
				PortBlocked.Add("Picture", "x0 y0 w500 h240", MessageBackgroundPicture)
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
				IniWrite true, TempSystemFile, "GeneralData", "DynamicReload"
			}
		}
		try {
			PortBlocked.Add("Picture", "x9 y10 w32 h32 +border", IconLib . FDJ_SoftwareIcon)
		}
		catch {
		}
		PortBlocked.SetFont("s16 W700 Q4 " . MessageAppNameFontColor, MessageAppNameFontType)
		PortBlocked.Add("Text", "x50 y16 +Center w420", AppName)
		PortBlocked.Add("Text", "x470 y16 +Center w20", "")
		PortBlocked.SetFont("s9 " . MessageFontColor, MessageFontType)
		PortBlocked.Add("Text", "x355 y24 ", CurrentVersion)
		PortBlocked.Add("Text", "x0 y54 w500 h1 +0x5")
		;-----------------
		PortBlocked.SetFont()
		PortBlocked.SetFont("s14 " . MessageMainMsgFontColor, MessageMainMsgFontType)
		PortBlocked.Add("Text", "x10 y80 +Center w480 +0x200", "Unable to authenticate. Port 3306 is blocked.")
		PortBlocked.Add("Text", "x50 y110 +Center w400 +0x200", "The app will close")
		PortBlocked.Add("Text", "x10 y140 +Center w480 +0x200", "Maybe your VPN, ISP or firewall is blocking it.")
        PortBlocked.SetFont("s8 " . MessageFontColor, MessageFontType)
		ogcButtonOK := PortBlocked.Add("Button", "x210 y190 w80 h24", "OK")
		ogcButtonOK.OnEvent("Click", Destroy)
		;-----------------
        PortBlocked.Title := "Port 3306 Blocked"
		if GuiName == "TaskAutomatorGui1" {
			TaskAutomatorGui1.GetPos(&PosX, &PosY)
		} else {
			TaskAutomatorGui2.GetPos(&PosX, &PosY)
		}
        PortBlocked.Show("x" . PosX - 150 . " y" . PosY + 220 . "w500 h240")
        PortBlocked.Opt("+LastFound")
		Sleep 15000
		PortBlocked.Destroy()
		ExitApp
    Return
	Destroy(*){
		PortBlocked.Destroy()
		ExitApp
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
				UpToDateMsg.Add("Picture", "x0 y0 w500 h240", ImageLib . DefaultMsgBackgroundImage)
			}
			catch {
			}
		} else {
			try {
				UpToDateMsg.Add("Picture", "x0 y0 w500 h240", MessageBackgroundPicture)
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
				IniWrite true, TempSystemFile, "GeneralData", "DynamicReload"
			}
		}
		try {
			UpToDateMsg.Add("Picture", "x9 y10 w32 h32 +border", IconLib . FDJ_SoftwareIcon)
		}
		catch {
		}
		UpToDateMsg.SetFont("s16 W700 Q4 " . MessageAppNameFontColor, MessageAppNameFontType)
		UpToDateMsg.Add("Text", "x50 y16 +Center w420", AppName)
		UpToDateMsg.Add("Text", "x470 y16 +Center w20", "")
		UpToDateMsg.SetFont("s9 " . MessageFontColor, MessageFontType)
		UpToDateMsg.Add("Text", "x355 y24 ", CurrentVersion)
		UpToDateMsg.Add("Text", "x0 y54 w500 h1 +0x5")
		;-----------------
		UpToDateMsg.SetFont()
		UpToDateMsg.SetFont("s14 " . MessageMainMsgFontColor, MessageMainMsgFontType)
		UpToDateMsg.Add("Text", "x100 y123 +Center w300 +0x200", "Current version is up to date!")
        ;-----------------
		UpToDateMsg.Title := "Up To Date!"
		if GuiName == "TaskAutomatorGui1" {
			TaskAutomatorGui1.GetPos(&PosX, &PosY)
		} else {
			TaskAutomatorGui2.GetPos(&PosX, &PosY)
		}
        UpToDateMsg.Show("x" . PosX - 150 . " y" . PosY + 220 . "w500 h240")
        UpToDateMsg.Opt("+LastFound")
		Destroy()
	Return
	Destroy(*){
	    Sleep ExitMessageTimeWait
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
				NewVerMsg.Add("Picture", "x0 y0 w500 h240", ImageLib . DefaultMsgBackgroundImage)
			}
			catch {
			}
		} else {
			try {
				NewVerMsg.Add("Picture", "x0 y0 w500 h240", MessageBackgroundPicture)
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
				IniWrite true, TempSystemFile, "GeneralData", "DynamicReload"
			}
		}
		try {
			NewVerMsg.Add("Picture", "x9 y10 w32 h32 +border", IconLib . FDJ_SoftwareIcon)
		}
		catch {
		}
		NewVerMsg.SetFont("s16 W700 Q4 " . MessageAppNameFontColor, MessageAppNameFontType)
		NewVerMsg.Add("Text", "x50 y16 +Center w420", AppName)
		NewVerMsg.Add("Text", "x470 y16 +Center w20", "")
		NewVerMsg.SetFont("s9 " . MessageFontColor, MessageFontType)
		NewVerMsg.Add("Text", "x355 y24 ", CurrentVersion)
		NewVerMsg.Add("Text", "x0 y54 w500 h1 +0x5")
		;-----------------
		NewVerMsg.SetFont()
		NewVerMsg.SetFont("s14 " . MessageMainMsgFontColor, MessageMainMsgFontType)
		NewVerMsg.Add("Text", "x80 y115 +Center w340 +0x200", "New release version " . ReleaseVersion . " is available.")
		NewVerMsg.SetFont()
		NewVerMsg.SetFont("s9 " . MessageFontColor, MessageFontType)
		ogcButtonUpdate := NewVerMsg.Add("Button", "x210 y145 w80 h24", "Download")
		ogcButtonUpdate.OnEvent("Click", UpdateDownload)
		;-----------------
        NewVerMsg.Title := "New Version Available!"
		if GuiName == "TaskAutomatorGui1" {
			TaskAutomatorGui1.GetPos(&PosX, &PosY)
		} else {
			TaskAutomatorGui2.GetPos(&PosX, &PosY)
		}
        NewVerMsg.Show("x" . PosX - 150 . " y" . PosY + 220 . "w500 h240")
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
		TADownloadPart1 := DecryptMsg(TADownloadPart1)
		;------------------------
		TADownloadPart2 := IniRead(DataFile, "EncryptedData", "TADownload")
		TADownloadPart2 := DecryptMsg(TADownloadPart2)
		;------------------------
		TADownloadPart3 := "42so"
		TADownloadPart3 := DecryptMsg(TADownloadPart3)
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