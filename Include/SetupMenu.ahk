;------------- Credits ------------
; Creator: Fernando Daniel Jaime.
; Programmer Alias: FDJ-Dash.
;------------- File Details ------------
; App Name: Task Automator.
; File Description: This file contains the Setup Menu that interacts with the GUI.
;----------------------------------------------------
; Header list:
;----------------------------------------------------
; SetupMenuBar(...)
;----------------------------------------------------
; Setup Menu Bar
;----------------------------------------------------
SetupMenuBar(&MenuBar_Storage,
			 &FileMenu,
			 &SuspendHotkeysKey,
			 &ExitTaskAutomatorKey,
			 &OptionsMenu,
			 &EditBoxesAvailable,
			 &HotkeyEditMode,
			 &SettingsMenu,
			 &HelpMenu,
			 TaskAutomatorGui){
	;-------------------------------		 
	MenuBar_Storage := MenuBar()
	;-------------------------------
	FileMenu := Menu()
	MenuBar_Storage.Add("&File", FileMenu)
	FileMenu.Add("Suspend Hotkeys`t" . SuspendHotkeysKey,SuspendMenuHandler)
	FileMenu.Insert()
	FileMenu.Add("Exit`t" . ExitTaskAutomatorKey,MenuHandlerExit)
	try {
		FileMenu.SetIcon("Suspend Hotkeys`t" . SuspendHotkeysKey,IconLib . "\stop.ico")
		FileMenu.SetIcon("Exit`t" . ExitTaskAutomatorKey,IconLib . "\exit.ico")
	}
	catch {
	}
	;-------------------------------
	OptionsMenu := Menu()
	MenuBar_Storage.Add("&Options", OptionsMenu)
	OptionsMenu.Add("Edit &Ini File", EditIniFileHandler)
	OptionsMenu.Insert()
	OptionsMenu.Add("1. Switch &Keyboard Autorun", KbAutoRunOFFHandler)
	OptionsMenu.Add("2. Switch Con&troller Autorun", ControllerAutoRunOFFHandler)
	OptionsMenu.Insert()
	OptionsMenu.Add("3a. Switch Quick &Access", QuickAccessHandler)
	OptionsMenu.Add("3b. Switch &Quick Access Hotkeys/Buttons", QuickAccessButtonsHandler)
	OptionsMenu.Insert()
	OptionsMenu.Add("4. Switch &Clicker", SwitchClickerHandler)
	OptionsMenu.Add("5. Switch &Jumps", SwitchJumpsHandler)
	OptionsMenu.Insert()
	OptionsMenu.Add("Change Background &Image", ChangeBackgroundHandler)
	OptionsMenu.Add("Change M&essage Background Image", ChangeMessageBackgroundHandler)
	OptionsMenu.Insert()
	OptionsMenu.Add("&Always On Top: ON/OFF", GuiPriorityAlwaysOnTopHandler)
	try {
		OptionsMenu.SetIcon("1. Switch &Keyboard Autorun", IconLib . "\Switch2.ico")
		OptionsMenu.SetIcon("2. Switch Con&troller Autorun", IconLib . "\Switch2.ico")
		OptionsMenu.SetIcon("Edit &Ini File", IconLib . "\File.ico")
		OptionsMenu.SetIcon("3a. Switch Quick &Access", IconLib . "\Switch2.ico")
		OptionsMenu.SetIcon("3b. Switch &Quick Access Hotkeys/Buttons", IconLib . "\Switch2.ico")
		OptionsMenu.SetIcon("4. Switch &Clicker", IconLib . "\Switch2.ico")
		OptionsMenu.SetIcon("5. Switch &Jumps", IconLib . "\Switch2.ico")
		OptionsMenu.SetIcon("Change Background &Image", IconLib . "\ChangeBackground.png")
		OptionsMenu.SetIcon("Change M&essage Background Image", IconLib . "\ChangeBackground.png")
		OptionsMenu.SetIcon("&Always On Top: ON/OFF", IconLib . "\Switch2.ico")
	}
	catch {
	}
	;-------------------------------
	SettingsMenu := Menu()
	MenuBar_Storage.Add("&Settings", SettingsMenu)
	SettingsMenu.Add("Hotkey Mode: Active/Edit", HotkeyEditModeHandler)
	SettingsMenu.Add("EditBox Mode: Locked/Unlocked", EditBoxesHandler)
	SettingsMenu.Insert()
	SettingsMenu.Add("Resize Large Modules", ResizeModuleHandler)
	SettingsMenu.Insert()
	SettingsMenu.Add("Check for updates &daily", MenuHandlerCheckUptDaily)
	SettingsMenu.Add("Check for updates &weekly", MenuHandlerCheckUptWeekly)
	SettingsMenu.Add("&Never check for updates", MenuHandlerNeverCheckUpt)

	try {
		if EditBoxesAvailable == true {
			SettingsMenu.SetIcon("EditBox Mode: Locked/Unlocked", IconLib . "\EditBox2.png")
		} else {
			SettingsMenu.SetIcon("EditBox Mode: Locked/Unlocked", IconLib . "\EditBox1.png")
		}
		if HotkeyEditMode == true {
			SettingsMenu.SetIcon("Hotkey Mode: Active/Edit", IconLib . "\Unlocked.png")
		} else {
			SettingsMenu.SetIcon("Hotkey Mode: Active/Edit", IconLib . "\Locked.ico")
		}
		if ResizeModule == true {
			SettingsMenu.SetIcon("Resize Large Modules", IconLib . "\Switch1.ico")
		} else {
			SettingsMenu.SetIcon("Resize Large Modules", IconLib . "\Switch2.ico")
		}
		SettingsMenu.SetIcon("Check for updates &daily", IconLib . "\CheckDaily.png")
		SettingsMenu.SetIcon("Check for updates &weekly", IconLib . "\CheckWeekly.png")
		SettingsMenu.SetIcon("&Never check for updates", IconLib . "\stop.ico")
	}
	catch {
	}
	;-------------------------------
	HelpMenu := Menu()
	MenuBar_Storage.Add("&Help", HelpMenu)
	HelpMenu.Add("Guide", MenuHandlerGuide)
	HelpMenu.Add("Quick Fix", MenuHandlerQuickFix)
	HelpMenu.Insert()
	HelpMenu.Add("Update", MenuHandlerUpdate)
	HelpMenu.Insert()
	HelpMenu.Add("About", MenuHandlerAbout)

	try {
		HelpMenu.SetIcon("Guide", IconLib . "\Logo-MLTA.ico")
		HelpMenu.SetIcon("Quick Fix", IconLib . "\Fix.ico")
		HelpMenu.SetIcon("Update", IconLib . "\Update.png")
		HelpMenu.SetIcon("About", IconLib . "\info.ico")
	}
	catch {
	}
	TaskAutomatorGui.MenuBar := MenuBar_Storage
}