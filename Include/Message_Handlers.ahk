;------------- Credits ------------
; Creator: Fernando Daniel Jaime.
; Programmer Alias: FDJ-Dash.
;------------- File Details ------------
; App Name: Game Tools.
; File Description: This file contains all posible messages handled by Task Automator.
;----------------------------------------------------
; Header list:
;----------------------------------------------------
; ExitMsg(*)
; InvalidPath(*)
; DuplicatedHotkeyValue(*)
; SaveMsg(*)
; ToggleHotkeysEnabled(*)
; ToggleHotkeysDisabled(*)
; HotkeyEditModeOn(*)
; MenuHandlerAbout(*)
; MenuHandlerWebLink(*)
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
		Exitmsg.Add("Text", "x330 y24 ", CurrentVersion)
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
		InvPathmsg.Add("Text", "x330 y24 ", CurrentVersion)
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
		DupHkValue.Add("Text", "x330 y24 ", CurrentVersion)
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
		Savemsg.Add("Text", "x330 y24 ", CurrentVersion)
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
		HkEnabled.Add("Text", "x330 y24 ", CurrentVersion)
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
		HkDisabled.Add("Text", "x330 y24 ", CurrentVersion)
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
		HkEditModeOn.Add("Text", "x330 y24 ", CurrentVersion)
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
				About.Add("Picture", "x0 y0 w500 h375", ImageLib . DefaultMsgBackgroundImage)
			}
			catch {
			}
		} else {
			try {
				About.Add("Picture", "x0 y0 w500 h375", MessageBackgroundPicture)
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
		About.Add("Text", "x330 y24 ", CurrentVersion)
		About.Add("Text", "x0 y54 w500 h1 +0x5")
		;-----------------
		About.SetFont()
		About.SetFont("s10 " . MessageMainMsgFontColor, MessageMainMsgFontType)
		About.Add("Text", "x100 y75 +Center w300 h28 +0x200", " Programmed and designed by: ")
		About.SetFont("s14 " . MessageMainMsgFontColor, MessageMainMsgFontType)
		About.Add("Text", "x100 y105 +Center w300 h28 +0x200", Creator)
		About.SetFont()
		About.SetFont("s10 " . MessageFontColor, MessageFontType)
		
		About.Add("Picture", "x100 y135 w260 h28 +border", ImageLib . "\LinkedIn-logo5.png")
		ogcLinkedInButton := About.Add("Button", "x368 y135 w30 h28", "Go")
		ogcLinkedInButton.OnEvent("Click", OnLinkedinClick)
		
		About.Add("Picture", "x100 y165 w260 h28 +border", ImageLib . "\BuyMeACoffee2.png")
		ogcBuyCoffeeButton := About.Add("Button", "x368 y165 w30 h28", "Go")
		ogcBuyCoffeeButton.OnEvent("Click", OnBuyMeACoffeeClick)
		
		About.Add("Picture", "x100 y195 w260 h28 +border", ImageLib . "\Github3.png")
		ogcBuyCoffeeButton := About.Add("Button", "x368 y195 w30 h28", "Go")
		ogcBuyCoffeeButton.OnEvent("Click", OnGithubClick)
		
		About.Add("Text", "x100 y225 +Center w300 h28 +0x200", " This Software is free and licensed under: ")
		
		About.Add("Picture", "x100 y255 w260 h28 +border", ImageLib . "\GLP-3.0-License3.png")
		ogcBuyCoffeeButton := About.Add("Button", "x368 y255 w30 h28", "Go")
		ogcBuyCoffeeButton.OnEvent("Click", OnLicenseClick)
		
		About.SetFont("s7 " . MessageFontColor, MessageFontType)
		About.Add("Text", "x25 y297 +Center w450 h15 +0x200", " You can reach me by email: fernando.daniel.jaime@gmail.com ")
		
		About.Add("Text", "x0 y324 w500 h1 +0x5")
		About.SetFont()
		
		About.SetFont("s8 " . MessageFontColor, MessageFontType)
        About.Add("Text", "x25 y333 +Center w350 h15 +0x200", "Copyright (C) 2024 Fernando Daniel Jaime")
		About.Add("Text", "x25 y353 +Center w350 h15 +0x200", "Made with AutoHotkey V" A_AhkVersion . " " . (1 ? "Unicode" : "ANSI") . " " . (A_PtrSize == 8 ? "64-bit" : "32-bit"))
		ogcButtonOK := About.Add("Button", "x400 y338 w80 h24", "OK")
		ogcButtonOK.OnEvent("Click", Destroy)
		;-----------------
        About.Title := "About"
		if GuiName == "TaskAutomatorGui1" {
			TaskAutomatorGui1.GetPos(&PosX, &PosY)
		} else {
			TaskAutomatorGui2.GetPos(&PosX, &PosY)
		}
        About.Show("x" . PosX - 150 . " y" . PosY + 220 . "w500 h375")
        ControlFocus("Button1", "About")
        About.Opt("+LastFound")
    Return
	Destroy(*){
		About.Destroy()
	}
	OnLinkedinClick(*) {
        Run "https://www.linkedin.com/in/fernando-daniel-jaime/"
		; Opening on web browser message
		MenuHandlerWebLink
		sleep 1000
    }
	OnBuyMeACoffeeClick(*) {
        Run "https://buymeacoffee.com/fdjdash"
		; Opening on web browser message
		MenuHandlerWebLink
		sleep 1000
    }
	OnGithubClick(*) {
	    Run "https://github.com/FDJ-Dash/FDJ-Game-Tools"
		; Opening on web browser message
		MenuHandlerWebLink
		sleep 1000
	}
	OnLicenseClick(*) {
		Run "https://www.gnu.org/licenses/gpl-3.0.html"
		; Opening on web browser message
		MenuHandlerWebLink
		sleep 1000
	}
}
;----------------------------------------------------
MenuHandlerWebLink(*) {
	ShowWebLink:
		if GuiPriorityAlwaysOnTop == true {
			WebLinkMsg := Gui("+AlwaysOnTop")
		} else {
			WebLinkMsg := Gui()
		}
		GuiName := IniRead(TempSystemFile, "GeneralData", "GuiName")
		WebLinkMsg.BackColor := "0x" . BackgroundColor
		MessageBackgroundPicture := IniRead(IniFile, "Background", "MessageBackgroundPicture")
		if MessageBackgroundPicture == "" {
		try {
				WebLinkMsg.Add("Picture", "x0 y0 w500 h240", ImageLib . DefaultMsgBackgroundImage)
			}
			catch {
			}
		} else {
			try {
				WebLinkMsg.Add("Picture", "x0 y0 w500 h240", MessageBackgroundPicture)
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
			WebLinkMsg.Add("Picture", "x9 y10 w32 h32 +border", IconLib . FDJ_SoftwareIcon)
		}
		catch {
		}
		WebLinkMsg.SetFont("s16 W700 Q4 " . MessageAppNameFontColor, MessageAppNameFontType)
		WebLinkMsg.Add("Text", "x50 y16 +Center w400", AppName)
		WebLinkMsg.Add("Text", "x450 y16 +Center w40", "")
		WebLinkMsg.SetFont("s9 " . MessageFontColor, MessageFontType)
		WebLinkMsg.Add("Text", "x390 y24 ", CurrentVersion)
		WebLinkMsg.Add("Text", "x0 y54 w500 h1 +0x5")
		;-----------------
		WebLinkMsg.SetFont()
		WebLinkMsg.SetFont("s14 " . MessageMainMsgFontColor, MessageMainMsgFontType)
		WebLinkMsg.Add("Text", "x100 y130 +Center w300 +0x200", "The link will open in your browser.")
        ;-----------------
		WebLinkMsg.Title := "Guide"
		if GuiName == "TaskAutomatorGui1" {
			TaskAutomatorGui1.GetPos(&PosX, &PosY)
		} else {
			TaskAutomatorGui2.GetPos(&PosX, &PosY)
		}
        WebLinkMsg.Show("x" . PosX - 150 . " y" . PosY + 120 . "w500 h240")
        WebLinkMsg.Opt("+LastFound")
		Destroy()
	Return

	Destroy(*){
	    Sleep ExitMessageTimeWait
		WebLinkMsg.Destroy()
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
		GuideMsg.Add("Text", "x330 y24 ", CurrentVersion)
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
		QuickAccMsg.Add("Text", "x330 y24 ", CurrentVersion)
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
		ConnectionMsg.Add("Text", "x330 y24 ", CurrentVersion)
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
		UpToDateMsg.Add("Text", "x330 y24 ", CurrentVersion)
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
		NewVerMsg.Add("Text", "x328 y24 ", CurrentVersion)
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
		GTName := IniRead(DataFile, "GeneralData", "GTName")
		; Scaped character included: ``
		GTDownloadPart1 := "PLjr_f_[HF16S_KEBL42IQNU_[16X``el71miRZHOsobjW^"
		GTDownloadPart1 := DecryptMsg(GTDownloadPart1)
		;------------------------
		GTDownloadPart2 := IniRead(DataFile, "EncryptedData", "GTDownload")
		GTDownloadPart2 := DecryptMsg(GTDownloadPart2)
		;------------------------
		GTDownloadPart3 := "42so"
		GTDownloadPart3 := DecryptMsg(GTDownloadPart3)
		;------------------------
		GTDownloadPart4 := FileSelect("S16", A_MyDocuments . "\" . GTName , "Save File", "Executable files (*.exe)")
		FullPathDownLoad := GTDownloadPart1 . " " . GTDownloadPart2 . " " . GTDownloadPart3 . " " . GTDownloadPart4
		if GTDownloadPart4 != "" {
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