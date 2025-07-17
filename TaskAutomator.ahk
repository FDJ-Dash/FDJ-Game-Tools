;------------- Credits ------------
; Creator: Fernando Daniel Jaime.
; Programmer Alias: FDJ-Dash.
;------------- App Details ------------
; App Name: Task Automator.
; Description: This is an app aimed towards repetitive tasks like holding a button down for extended time,
; mouse clicks or even click patterns. Additionally it brings interchangeable modules like jumps
; for certain games and Quick access module to run any program in your computer or load
; a web page on your browser easily. 
;----------------------------------------------------
#Requires Autohotkey v2
#SingleInstance
ListLines False
#NoTrayIcon
SetWorkingDir(A_ScriptDir)


Global IconLib := A_ScriptDir . "\Icons"
, ImageLib := A_ScriptDir . "\Images"
, HotkeyGuide := "https://fdj-software.gitbook.io/apps"
, IniFile := A_ScriptDir . "\TaskAutomator.ini"
, LicenseFile := A_ScriptDir . "\LicenseKey.ini"
, DataFile := A_Temp . "\TA_Data.ini"
, TempCleanFileTA := A_Temp . "\TA_CleanFile.ini"
, TempSystemFile := A_Temp . "\TA_SystemFile.ini"
, AuxHkDataFile := A_Temp . "\TA_AuxHkData.ini"
, AppName := "Task Automator"
, CurrentVersion := "v2.0"
, FDJ_SoftwareIcon := "\Logo-FDJ-Dash.png"
, DefaultMsgBackgroundImage := "\Lightning2.jpg"
, Creator := " Fernando Daniel Jaime "
;----------------------------------------------------
; Libraries
;----------------------------------------------------
#Include "*i %A_ScriptDir%\Include\Create_Files.ahk"
#Include "*i %A_ScriptDir%\Include\ReadIniFile.ahk"
#Include "*i %A_ScriptDir%\Include\SetupMenu.ahk"
#Include "*i %A_ScriptDir%\Include\TaskAutomatorGui.ahk"
#Include "*i %A_ScriptDir%\Include\TaskAutomatorGuiResize.ahk"
#Include "*i %A_ScriptDir%\Include\Message_Handlers.ahk"
#Include "*i %A_ScriptDir%\Include\Submit_Handlers.ahk"
#Include "*i %A_ScriptDir%\Include\Menu_Handlers.ahk"
#Include "*i %A_ScriptDir%\Include\Image_File_Select.ahk"
#Include "*i %A_ScriptDir%\Include\General_Functions.ahk"
#Include "*i %A_ScriptDir%\Include\Hotkey_Process.ahk"
#Include "*i %A_ScriptDir%\Include\ClassDefinitions.ahk"
;----------------------------------------------------
; Database Libraries
;----------------------------------------------------
#Include "*i %A_ScriptDir%\Include\Forms_Handler.ahk"
#Include "*i %A_ScriptDir%\Include\DatabaseMsgHandler.ahk"
#Include "*i %A_ScriptDir%\MySQLAPI-v1.1.ahk"
#Include "*i %A_ScriptDir%\DB_Interactions.ahk"
;----------------------------------------------------
; Mail Variables
;----------------------------------------------------
MailPswd := MailPswdGen()
;----------------------------------------------------
; Trigger Delay
;----------------------------------------------------
StartDelay := 500
StopDelay := 1500
;----------------------------------------------------
; DynamicReload variables
;----------------------------------------------------
DynamicReload := true
GuiCount := 1
GuiName := ""
FlagLineValueAdded := false
StartTime := ""

IniWrite DynamicReload, TempSystemFile, "GeneralData", "DynamicReload"
IniWrite GuiCount, TempSystemFile, "GeneralData", "GuiCount"
IniWrite GuiName, TempSystemFile, "GeneralData", "GuiName"
IniWrite false, TempSystemFile, "GeneralData", "ClearXY"
;----------------------------------------------------
; Get Device License Data
;----------------------------------------------------
StringMacAddress := GetMacAddress()
LicenseKey := EncryptMsg(StringMacAddress)
;----------------------------------------------------
; Check connection every minute
;----------------------------------------------------
totalTime := 60000
remainingTime := totalTime
elapsed := 0
KeepChecking := false
;----------------------------------------------------
; General Loop Start
;----------------------------------------------------
Loop {
	ClearXY := IniRead(TempSystemFile, "GeneralData", "ClearXY")
	DynamicReload := IniRead(TempSystemFile, "GeneralData", "DynamicReload")
	if DynamicReload == true {
		;----------------------------------------------------
		; Read ini file - Create_Files.ahk
		;----------------------------------------------------
		if !FileExist(IniFile) {
			CreateNewIniFile()
		}
		if !FileExist(AuxHkDataFile){
			CreateNewAuxHkDataFile()
		}
		;----------------------------------------------------
		; Ini Read Font types - ReadIniFile.ahk
		;----------------------------------------------------
		ReadFontTypes(&MainFontType, 
					  &MessageAppNameFontType, 
					  &LicenseKeyFontType, 
					  &MessageMainMsgFontType, 
					  &MessageFontType)
		;----------------------------------------------------
		; Ini Read Font Colors - ReadIniFile.ahk
		;----------------------------------------------------
		ReadFontColors(&MainFontColor, 
					   &FontClickerPatternColor, 
					   &MessageAppNameFontColor,
					   &MessageMainMsgFontColor,
					   &MessageFontColor, 
					   &LicenseKeyFontColor)
		;----------------------------------------------------
		; Ini Read Background - ReadIniFile.ahk
		;----------------------------------------------------
		ReadBackground(&BackgroundMainColor, 
					   &BackgroundColor,
					   &BackgroundPicture,
					   &MessageBackgroundPicture)		   
		;----------------------------------------------------
		; Ini Read Modules - ReadIniFile.ahk
		;----------------------------------------------------
		ReadModules(&SwitchKbAutoRun, 
					&SwitchControllerAutoRun,
					&SwitchQuickAccess,
					&QuickAccessButtons,
					&SwitchClicker,
					&SwitchJumps)		
		;----------------------------------------------------
		; Read Ini Properties - ReadIniFile.ahk
		;----------------------------------------------------
		ReadProperties(&ExitMessageTimeWait, 
					   &SuspendedHotkeysTimeWait,
					   &SaveSuccesfullTimeWait,
					   &AutoRunLoopInterval,
					   &GeneralLoopInterval,
					   &LoopAmount,
					   &GuiPriorityAlwaysOnTop,
					   &PositionX,
					   &PositionY,
					   &ExitTaskAutomatorKey,
					   &SuspendHotkeysKey)
		;----------------------------------------------------
		; Read ini Settings - ReadIniFile.ahk
		;----------------------------------------------------
		ReadSetting(&HotkeyEditMode,
					&EditBoxesAvailable,
					&ResizeModule,
					&CheckforUpdatesDaily, 
					&CheckforupdatesWeekly, 
					&NeverCheckForUpdates,
					&LastUpdateCheckTimeStamp,
					&NeedUpdate)
		;----------------------------------------------------
		; Read Ini Pace Properties - ReadIniFile.ahk
		;----------------------------------------------------
		ReadPaceProperties(&ScrlUpCount, 
						   &ScrlUpInterval, 
						   &ScrlDownCount,
						   &ScrlDownInterval,
						   &ScrlUpYes,
						   &ScrlUpNo,
						   &ScrlDownYes,
						   &ScrlDownNo)
		;----------------------------------------------------
		; Read Ini Saved Hotkey - ReadIniFile.ahk
		;----------------------------------------------------
		ReadSavedHotkey(&KbAutoRunHotkey,
						&PatternClickerHotkey,
						&JumpHotkey0,
						&JumpHotkey1,
						&JumpHotkey2,
						&JumpHotkey3,
						&JumpHotkey4,
						&QuickAccessHk1,
						&QuickAccessHk2,
						&QuickAccessHk3,
						&QuickAccessHk4,
						&QuickAccessHk5,
						&QuickAccessHk6,
						&QuickAccessHk7,
						&QuickAccessHk8,
						&QuickAccessHk9)
		;----------------------------------------------------
		; Read ini AutoRun - ReadIniFile.ahk
		;----------------------------------------------------
		ReadAutoRun(&SprintKey, 
					&ForwardKey,
					&SelectedButton,
					&ControllerKey)
		;----------------------------------------------------
		; Read ini AutoClicker - ReadIniFile.ahk
		;----------------------------------------------------
		ReadAutoClicker(&ClickInterval, 
						&RandomOffset)
		;----------------------------------------------------
		; Read ini CursorLocationClicker - ReadIniFile.ahk
		;----------------------------------------------------
		ReadCursorLocationClicker(Position1,
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
								  Position22)
		;----------------------------------------------------
		; Read ini QuickAccessPath - ReadIniFile.ahk
		;----------------------------------------------------
		ReadQuickAccessPath(&QuickAccess1, 
							&QuickAccess2, 
							&QuickAccess3,
							&QuickAccess4,
							&QuickAccess5,
							&QuickAccess6,
							&QuickAccess7,
							&QuickAccess8,
							&QuickAccess9)
		;----------------------------------------------------
		; Read ini QuickAccessIcons - ReadIniFile.ahk
		;----------------------------------------------------
		ReadQuickAccessIcons(&QuickIcon1, 
							 &QuickIcon2, 
							 &QuickIcon3,
							 &QuickIcon4,
							 &QuickIcon5,
							 &QuickIcon6,
							 &QuickIcon7,
							 &QuickIcon8,
							 &QuickIcon9)
		;----------------------------------------------------
		; Read ini JumpProperties - ReadIniFile.ahk
		;----------------------------------------------------
		ReadJumpProperties(&VeryShortJumpRace, 
						   &VeryShortJumpLenght, 
						   &ShortJumpRace,
						   &ShortJumpLenght,
						   &NormalJumpRace,
						   &NormalJumpLenght,
						   &LongJumpRace,
						   &LongJumpLenght,
						   &VeryLongJumpRace,
						   &VeryLongJumpLenght)
		;----------------------------------------------------
		; GUI Properties
		;----------------------------------------------------
		if Mod(GuiCount, 2) == 1 {
			;----------------------------------------------------
			; GUI 1 instance - Inside DynamicReload
			;----------------------------------------------------
			GuiName := "TaskAutomatorGui1"
			IniWrite GuiName, TempSystemFile, "GeneralData", "GuiName"
			if GuiPriorityAlwaysOnTop == true {
				TaskAutomatorGui1 := Gui("+AlwaysOnTop")
			} else {
				TaskAutomatorGui1 := Gui()
			}
			
			TaskAutomatorGui1.Opt("+MinimizeBox +OwnDialogs -Theme")
			TaskAutomatorGui1.SetFont("Bold " . MainFontColor, MainFontType)
			TaskAutomatorGui1.BackColor := "0x" . BackgroundColor
			if BackgroundPicture == "" {
				if ResizeModule == true and SwitchClicker == true {
					try {
						TaskAutomatorGui1.Add("Picture", "x0 y0 w750", ImageLib . "\Lightning2.jpg")
					}
					catch {
					}
				} else {
					TaskAutomatorGui1.Add("Picture", "x0 y0 w250", ImageLib . "\Lightning1.jpg")
				}
			} else {
				if ResizeModule == true and SwitchClicker == true {
					try {
						TaskAutomatorGui1.Add("Picture", "x0 y0 w750", BackgroundPicture)
					}
					catch {
						BackgroundPicture := ""
						IniWrite BackgroundPicture, IniFile, "Background", "BackgroundPicture"
						Reload
					}
				} else {
					try {
						TaskAutomatorGui1.Add("Picture", "x0 y0 w250", BackgroundPicture)
					}
					catch {
						BackgroundPicture := ""
						IniWrite BackgroundPicture, IniFile, "Background", "BackgroundPicture"
						Reload
					}
				}
			}
			;----------------------------------------------------
			; Setup Menu Bar - SetupMenu.ahk
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
						 TaskAutomatorGui1)
			;----------------------------------------------------
			; Always On Top: ON/OFF
			;----------------------------------------------------
			if GuiPriorityAlwaysOnTop == true {
				OptionsMenu.SetIcon("&Always On Top: ON/OFF", IconLib . "\Switch1.ico")
			} else {
				OptionsMenu.SetIcon("&Always On Top: ON/OFF", IconLib . "\Switch2.ico")
			}
			;----------------------------------------------------
			; Y-10 / Pace control - TaskAutomatorGui.ahk
			;----------------------------------------------------
			PaceControl(TaskAutomatorGui1,
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
						&TextOnOffScrlDown)
			;----------------------------------------------------
			; Switch Modules
			;----------------------------------------------------
			Switch true {
			case SwitchKbAutoRun:
				;----------------------------------------------------
				; Y-67 / Keyboard AutoRun - TaskAutomatorGui.ahk
				;----------------------------------------------------
				KeyboardAutorun(TaskAutomatorGui1,
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
								&LastYLine)
				;----------------------------------------------------
				; Y-LastYLine / Save All EditBox Values - TaskAutomatorGui.ahk
				;----------------------------------------------------
				SaveAllEditValues(TaskAutomatorGui1,
								  &SaveButton,
								  SubmitValues,
								  &LastYLine,
								  &FlagLineValueAdded)
			case SwitchControllerAutoRun:
				;----------------------------------------------------
				; Y-67 / Controller AutoRun - TaskAutomatorGui.ahk
				;----------------------------------------------------
				ControllerAutoRun(TaskAutomatorGui1,
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
								  &SelectedButton,
								  &EditSelectedKey,
								  &LastYLine)
				;----------------------------------------------------
				; Y-LastYLine / Save All EditBox Values - TaskAutomatorGui.ahk
				;----------------------------------------------------
				SaveAllEditValues(TaskAutomatorGui1,
								  &SaveButton,
								  SubmitValues,
								  &LastYLine,
								  &FlagLineValueAdded)
			case SwitchJumps:
				;----------------------------------------------------
				; Y-10 / Jumps - TaskAutomatorGui.ahk
				;----------------------------------------------------
				JumpsModule(TaskAutomatorGui1,
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
							&LastYLine)
			case SwitchClicker:
				;----------------------------------------------------
				; Y-10 / Auto Clicker - TaskAutomatorGui.ahk
				;----------------------------------------------------
				if ResizeModule == true {
					ResizedAutoClickerModule(TaskAutomatorGui1,
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
											 &LastYLine)
				} else {
					AutoClickerModule(TaskAutomatorGui1,
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
									  &LastYLine)
				}
				;----------------------------------------------------
				; Y-LastYLine / Save All EditBox Values - TaskAutomatorGui.ahk
				;----------------------------------------------------
				if ResizeModule == true {
					ResizedSaveAllEditValues(TaskAutomatorGui1,
											 &SaveButton,
											 SubmitValues,
											 &LastYLine,
											 &FlagLineValueAdded)
				} else {
					SaveAllEditValues(TaskAutomatorGui1,
									  &SaveButton,
									  SubmitValues,
									  &LastYLine,
									  &FlagLineValueAdded)
				}
			case SwitchQuickAccess:
				;----------------------------------------------------
				; Y-10 / Quick Access - TaskAutomatorGui.ahk
				;----------------------------------------------------
				QuickAccessModule(TaskAutomatorGui1,
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
								  &LastYLine)
				;----------------------------------------------------
				; Y-LastYLine / Save All EditBox Values - TaskAutomatorGui.ahk
				;----------------------------------------------------
				SaveAllEditValues(TaskAutomatorGui1,
								  &SaveButton,
								  SubmitValues,
								  &LastYLine,
								  &FlagLineValueAdded)
			} ; End Switch Modules GUI 1
			;----------------------------------------------------
			; Y-LastYLine + 32 / Hotkey Edit Mode - TaskAutomatorGui.ahk
			;----------------------------------------------------
			if ResizeModule == true and SwitchClicker == true {
				ResizedCheckHotkeyEditMode(TaskAutomatorGui1,
										   &HotkeyEditMode,
										   &LicenseKeyFontType,
										   &LastYLine)
			} else {
				CheckHotkeyEditMode(TaskAutomatorGui1,
									&HotkeyEditMode,
									&LicenseKeyFontType,
									&LastYLine)
			}
			;----------------------------------------------------
			; Y-LastYLine + 32 / EditBoxes Mode - TaskAutomatorGui.ahk
			;----------------------------------------------------
			if ResizeModule == true and SwitchClicker == true {
				ResizedCheckEditBoxesAvailable(TaskAutomatorGui1,
											   &EditBoxesAvailable,
											   &LicenseKeyFontType,
											   &LastYLine)
			}else {
				CheckEditBoxesAvailable(TaskAutomatorGui1,
										&EditBoxesAvailable,
										&LicenseKeyFontType,
										&LastYLine)
			}
			;----------------------------------------------------
			; Y-LastYLine +64 / Check for updates - TaskAutomatorGui.ahk
			;----------------------------------------------------
			if ResizeModule == true and SwitchClicker == true {
				ResizedCheckForUpdates(TaskAutomatorGui1, 
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
									   &LastYLine)
			} else {
				CheckForUpdates(TaskAutomatorGui1, 
							   &FlagCheckTime,
							   &LastUpdateCheckTimeStamp,
							   &LicenseKeyFontType,
							   &CheckforUpdatesDaily,
							   &CheckforupdatesWeekly,
							   &NeverCheckForUpdates, 
							   &NeedUpdate,
							   &Connected,
							   &MLTALatestReleaseVersion,
							   &DownloadUrl,
							   &CurrentVersion,
							   &LastYLine)
			}
			;----------------------------------------------------
			SB := TaskAutomatorGui1.Add("StatusBar", , "Ready.")
			;----------------------------------------------------
			TaskAutomatorGui1.OnEvent('Close', (*) => ExitApp())
			TaskAutomatorGui1.Title := AppName
			if ResizeModule == true and SwitchClicker == true {
				TaskAutomatorGui1.Show("x" . PositionX . " y" . PositionY . "w750 h" . LastYLine + 83)
			} else {
				TaskAutomatorGui1.Show("x" . PositionX . " y" . PositionY . "w250 h" . LastYLine + 115)
			}
			Saved := TaskAutomatorGui1.Submit(false)
		} else {
			;----------------------------------------------------
			; GUI 2 instance - Inside DynamicReload
			;----------------------------------------------------
			GuiName := "TaskAutomatorGui2"
			IniWrite GuiName, TempSystemFile, "GeneralData", "GuiName"
			if GuiPriorityAlwaysOnTop == true {
				TaskAutomatorGui2 := Gui("+AlwaysOnTop")
			} else {
				TaskAutomatorGui2 := Gui()
			}
			
			TaskAutomatorGui2.Opt("+MinimizeBox +OwnDialogs -Theme")
			TaskAutomatorGui2.SetFont("Bold " . MainFontColor, MainFontType)
			TaskAutomatorGui2.BackColor := "0x" . BackgroundColor
			if BackgroundPicture == "" {
				if ResizeModule == true and SwitchClicker == true {
					try {
						TaskAutomatorGui2.Add("Picture", "x0 y0 w750", ImageLib . "\Lightning2.jpg")
					}
					catch {
					}
				} else {
					TaskAutomatorGui2.Add("Picture", "x0 y0 w250", ImageLib . "\Lightning1.jpg")
				}
			} else {
				if ResizeModule == true and SwitchClicker == true {
					try {
						TaskAutomatorGui2.Add("Picture", "x0 y0 w750", BackgroundPicture)
					}
					catch {
						BackgroundPicture := ""
						IniWrite BackgroundPicture, IniFile, "Background", "BackgroundPicture"
						Reload
					}
				} else {
					try {
						TaskAutomatorGui2.Add("Picture", "x0 y0 w250", BackgroundPicture)
					}
					catch {
						BackgroundPicture := ""
						IniWrite BackgroundPicture, IniFile, "Background", "BackgroundPicture"
						Reload
					}
				}
			}
			;----------------------------------------------------
			; Setup Menu Bar - SetupMenu.ahk
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
						 TaskAutomatorGui2)
			;----------------------------------------------------
			if GuiPriorityAlwaysOnTop == true {
				OptionsMenu.SetIcon("&Always On Top: ON/OFF", IconLib . "\Switch1.ico")
			} else {
				OptionsMenu.SetIcon("&Always On Top: ON/OFF", IconLib . "\Switch2.ico")
			}
			;----------------------------------------------------
			; Y-10 / Pace control - TaskAutomatorGui.ahk
			;----------------------------------------------------
			PaceControl(TaskAutomatorGui2,
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
						&TextOnOffScrlDown)
			;----------------------------------------------------
			; Switch Modules
			;----------------------------------------------------
			Switch true {
			case SwitchKbAutoRun:
			;----------------------------------------------------
			; Y-67 / Keyboard AutoRun - TaskAutomatorGui.ahk
			;----------------------------------------------------
			KeyboardAutorun(TaskAutomatorGui2,
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
							&LastYLine)
			;----------------------------------------------------
			; Y-LastYLine / Save All EditBox Values - TaskAutomatorGui.ahk
			;----------------------------------------------------
			SaveAllEditValues(TaskAutomatorGui2,
							  &SaveButton,
							  SubmitValues,
							  &LastYLine,
							  &FlagLineValueAdded)
			case SwitchControllerAutoRun:
			;----------------------------------------------------
			; Y-67 / Controller AutoRun - TaskAutomatorGui.ahk
			;----------------------------------------------------
			ControllerAutoRun(TaskAutomatorGui2,
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
							  &SelectedButton,
							  &EditSelectedKey,
							  &LastYLine)
			;----------------------------------------------------
			; Y-LastYLine / Save All EditBox Values - TaskAutomatorGui.ahk
			;----------------------------------------------------
			SaveAllEditValues(TaskAutomatorGui2,
							  &SaveButton,
							  SubmitValues,
							  &LastYLine,
							  &FlagLineValueAdded)
			case SwitchJumps:
				;----------------------------------------------------
				; Y-10 / Jumps - TaskAutomatorGui.ahk
				;----------------------------------------------------
				JumpsModule(TaskAutomatorGui2,
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
							&LastYLine)
			case SwitchClicker:
				;----------------------------------------------------
				; Y-10 / Auto Clicker - TaskAutomatorGui.ahk
				;----------------------------------------------------
				if ResizeModule == true {
					ResizedAutoClickerModule(TaskAutomatorGui2,
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
											 &LastYLine)
				} else {
					AutoClickerModule(TaskAutomatorGui2,
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
									  &LastYLine)
				}
				;----------------------------------------------------
				; Y-LastYLine / Save All EditBox Values - TaskAutomatorGui.ahk
				;----------------------------------------------------
				if ResizeModule == true {
					ResizedSaveAllEditValues(TaskAutomatorGui2,
											 &SaveButton,
											 SubmitValues,
											 &LastYLine,
											 &FlagLineValueAdded)
				} else {
					SaveAllEditValues(TaskAutomatorGui2,
									  &SaveButton,
									  SubmitValues,
									  &LastYLine,
									  &FlagLineValueAdded)
				}
			case SwitchQuickAccess:
				;----------------------------------------------------
				; Y-10 / Quick Access - TaskAutomatorGui.ahk
				;----------------------------------------------------
				QuickAccessModule(TaskAutomatorGui2,
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
								  &LastYLine)
				;----------------------------------------------------
				; Y-LastYLine / Save All EditBox Values - TaskAutomatorGui.ahk
				;----------------------------------------------------
				SaveAllEditValues(TaskAutomatorGui2,
								  &SaveButton,
								  SubmitValues,
								  &LastYLine,
								  &FlagLineValueAdded)
			} ; End Switch Modules GUI 2
			;----------------------------------------------------
			; Y-LastYLine +32 / Hotkey Edit Mode - TaskAutomatorGui.ahk
			;----------------------------------------------------
			if ResizeModule == true and SwitchClicker == true {
				ResizedCheckHotkeyEditMode(TaskAutomatorGui2,
										   &HotkeyEditMode,
										   &LicenseKeyFontType,
										   &LastYLine)
			} else {
				CheckHotkeyEditMode(TaskAutomatorGui2,
									&HotkeyEditMode,
									&LicenseKeyFontType,
									&LastYLine)
			}
			;----------------------------------------------------
			; Y-LastYLine + 32 / EditBoxes Mode - TaskAutomatorGui.ahk
			;----------------------------------------------------
			if ResizeModule == true and SwitchClicker == true {
				ResizedCheckEditBoxesAvailable(TaskAutomatorGui2,
											   &EditBoxesAvailable,
											   &LicenseKeyFontType,
											   &LastYLine)
			}else {
				CheckEditBoxesAvailable(TaskAutomatorGui2,
										&EditBoxesAvailable,
										&LicenseKeyFontType,
										&LastYLine)
			}
			;----------------------------------------------------
			; Y-LastYLine +64 / Check for updates - TaskAutomatorGui.ahk
			;----------------------------------------------------
			if ResizeModule == true and SwitchClicker == true {
				ResizedCheckForUpdates(TaskAutomatorGui2, 
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
									   &LastYLine)
			} else {
				CheckForUpdates(TaskAutomatorGui2, 
							   &FlagCheckTime,
							   &LastUpdateCheckTimeStamp,
							   &LicenseKeyFontType,
							   &CheckforUpdatesDaily,
							   &CheckforupdatesWeekly,
							   &NeverCheckForUpdates, 
							   &NeedUpdate,
							   &Connected,
							   &MLTALatestReleaseVersion,
							   &DownloadUrl,
							   &CurrentVersion,
							   &LastYLine)
			}
			;----------------------------------------------------
			SB := TaskAutomatorGui2.Add("StatusBar", , "Ready.")
			;----------------------------------------------------
			TaskAutomatorGui2.OnEvent('Close', (*) => ExitApp())
			TaskAutomatorGui2.Title := AppName
			if ResizeModule == true and SwitchClicker == true {
				TaskAutomatorGui2.Show("x" . PositionX . " y" . PositionY . "w750 h" . LastYLine + 83)
			} else {
				TaskAutomatorGui2.Show("x" . PositionX . " y" . PositionY . "w250 h" . LastYLine + 115)
			}
			Saved := TaskAutomatorGui2.Submit(false)
			CoordMode "Mouse", "Screen"
		}
		;----------------------------------------------------
		FlagLineValueAdded := false
		;----------------------------------------------------
		; Destroy previous Gui
		;----------------------------------------------------
		if GuiCount != 1 {
			if Mod(GuiCount, 2) == 0 {
				TaskAutomatorGui1.Destroy
			} else {
				TaskAutomatorGui2.Destroy
			}
		}
		GuiCount++
		IniWrite GuiCount, TempSystemFile, "GeneralData", "GuiCount"
		;----------------------------------------------------
		; OnExit Process - General_Functions.ahk
		;----------------------------------------------------
		OnExit ExitMenu
		;----------------------------------------------------
		; Validate Connection
		;----------------------------------------------------
		Connected := CheckConnection()
		;----------------------------------------------------
		; Validate license key and Device Number
		;----------------------------------------------------
		try {
			LicenseKeyInFile := IniRead(LicenseFile, "Data", "LicenseKey")
			DeviceNumber := IniRead(LicenseFile, "Data", "DeviceNumber")
			LicenceAmount := IniRead(LicenseFile, "Data", "LicenceAmount")
			UserName := IniRead(LicenseFile, "Data", "UserName")
		}
		catch as e {
			; License file is missing
			ExitApp(3)
		}

		;----------------------------------------------------
		; Validate Session
		;----------------------------------------------------
		try {
		SessionKey := CurrentSessionKey()
		}
		catch {
		    ; No Session Generated
			SessionKey := ""
		}
		NewSessionKey := SessionGenerationKey()
		if SessionKey != NewSessionKey {
			;------------------------
			CustomerId := ""
			switch true {
			case Connected != true:
				KeepChecking := true
			case LicenseKeyInFile != LicenseKey:
			    SB.SetText("Authenticating..")
				VerifyingPortAccess()
				MySqlInst := DatabaseConnetion()
				;------------------------
				QueryResult := MySqlInst.Query("SELECT * FROM ta_mac WHERE Mac_Address='" StringMacAddress "'" )
				if QueryResult == 0 {
					ResultSet := MySqlInst.GetResult()
					Device := 0
					for k, v in ResultSet.Rows {
						; Process each row (Could be more than 1 row)
						if StringMacAddress == v["Mac_Address"] {
							Device := v["Device_Number"]
							CustomerId := v["Customer_Id"]
							; Add missing device number silently
							DeviceNumber := Device
							IniWrite Device, LicenseFile, "Data", "DeviceNumber"
						}
					}
					if DeviceNumber != Device {
						; Device not found
						LoginOrRegister()
					}
				} else {
					; Unable to connect to server - Using VPN
					if Connected == true {
						; Port 3306 is blocked.
						Port3306Blocked()
					} else {
						LoginOrRegister()
						CheckConnectionMsg()
					}
				}
				LoginOrRegister()
			case UserName == "" or LicenceAmount == "":
			    SB.SetText("Authenticating..")
				VerifyingPortAccess()
				FlagSession := False
				MySqlInst := DatabaseConnetion()
				;------------------------
				QueryResult := MySqlInst.Query("SELECT * FROM ta_mac WHERE Mac_Address='" StringMacAddress "'" )
				if QueryResult == 0 {
					ResultSet := MySqlInst.GetResult()
					Device := 0
					DeviceNumber := ""
					CountDevice := 0
					for k, v in ResultSet.Rows {
						; Process each row (Could be more than 1 row)
						if StringMacAddress == v["Mac_Address"] {
							Device := v["Device_Number"]
							CustomerId := v["Customer_Id"]
							; Add missing device number silently
							DeviceNumber := Device
							IniWrite Device, LicenseFile, "Data", "DeviceNumber"
							FlagSession := true
						}
					}
					if DeviceNumber != Device {
						; Device not found
						LoginOrRegister()
					}
				} else {
					; Unable to connect to server - Using VPN
					if Connected == true {
						; Port 3306 is blocked.
						Port3306Blocked()
					} else {
						LoginOrRegister()
						CheckConnectionMsg()
					}
				}
				;------------------------
				if CustomerId != "" {
					QueryResult := MySqlInst.Query("SELECT * FROM billing_ta WHERE Customer_Id='" CustomerId "'" )
					if QueryResult == 0 {
						ResultSet := MySqlInst.GetResult()
						for k, v in ResultSet.Rows {
							; Process each row (Will always be a unique row for billing_ta table)
							LicAmountTA := v["Lic_Amount_TA"]
							IniWrite LicAmountTA, LicenseFile, "Data", "LicenceAmount"
						}
					}
					if UserName == "" {
						QueryResult := MySqlInst.Query("SELECT * FROM customers WHERE Customer_Id='" CustomerId "'")
						if QueryResult == 0 {
							ResultSet := MySqlInst.GetResult()
							for k, v in ResultSet.Rows {
								; Process each row (Will always be a unique row for customers table)
								UserName := v["User_Name"]
								IniWrite UserName, LicenseFile, "Data", "UserName"
							}
						}
					}
				}
				if FlagSession == true {
				    SetSessionKey(NewSessionKey)
				}
			default:
				SB.SetText("Authenticating..")
				VerifyingPortAccess()
				FlagSession := False
				MySqlInst := DatabaseConnetion()
				;------------------------
				QueryResult := MySqlInst.Query("SELECT * FROM ta_mac WHERE Mac_Address='" StringMacAddress "'" )
				if QueryResult == 0 {
					ResultSet := MySqlInst.GetResult()
					Device := 0
					DeviceNumber := ""
					for k, v in ResultSet.Rows {
						; Process each row (Could be more than 1 row)
						if StringMacAddress == v["Mac_Address"] {
							Device := v["Device_Number"]
							CustomerId := v["Customer_Id"]
							; Add missing device number silently
							DeviceNumber := Device
							IniWrite Device, LicenseFile, "Data", "DeviceNumber"
							FlagSession := true
						}
					}
					if DeviceNumber != Device {
						; Device not found
						LoginOrRegister()
					}
				} else {
					; Unable to connect to server - Using VPN
					if Connected == true {
						; Port 3306 is blocked.
						Port3306Blocked()
					} else {
						LoginOrRegister()
						CheckConnectionMsg()
					}
				}
				if FlagSession == true {
				    SetSessionKey(NewSessionKey)
				}
			} ; End switch
		}
        
		;----------------------------------------------------
		Switch true {
		case SwitchKbAutoRun:
			Hotkey Saved.KbAutoRunHotkey, (ThisHotkey) => ProcessRunWalkHotkey(ThisHotkey)
		case SwitchJumps:
			Hotkey Saved.JumpHotkey0, (ThisHotkey) => ProcessJumpHotkey0(ThisHotkey)
			Hotkey Saved.JumpHotkey1, (ThisHotkey) => ProcessJumpHotkey1(ThisHotkey)
			Hotkey Saved.JumpHotkey2, (ThisHotkey) => ProcessJumpHotkey2(ThisHotkey)
			Hotkey Saved.JumpHotkey3, (ThisHotkey) => ProcessJumpHotkey3(ThisHotkey)
			Hotkey Saved.JumpHotkey4, (ThisHotkey) => ProcessJumpHotkey4(ThisHotkey)
		case SwitchClicker:
			Hotkey Saved.PatternClickerHotkey, (ThisHotkey) => ProcessPatternClicker(ThisHotkey)
		case SwitchQuickAccess:
			if QuickAccessButtons == false {
				Hotkey Saved.QuickAccessHk1, (ThisHotkey) => ProcessQuickAccess(ThisHotkey)
				Hotkey Saved.QuickAccessHk2, (ThisHotkey) => ProcessQuickAccess(ThisHotkey)
				Hotkey Saved.QuickAccessHk3, (ThisHotkey) => ProcessQuickAccess(ThisHotkey)
				Hotkey Saved.QuickAccessHk4, (ThisHotkey) => ProcessQuickAccess(ThisHotkey)
				Hotkey Saved.QuickAccessHk5, (ThisHotkey) => ProcessQuickAccess(ThisHotkey)
				Hotkey Saved.QuickAccessHk6, (ThisHotkey) => ProcessQuickAccess(ThisHotkey)
				Hotkey Saved.QuickAccessHk7, (ThisHotkey) => ProcessQuickAccess(ThisHotkey)
				Hotkey Saved.QuickAccessHk8, (ThisHotkey) => ProcessQuickAccess(ThisHotkey)
				Hotkey Saved.QuickAccessHk9, (ThisHotkey) => ProcessQuickAccess(ThisHotkey)
			}
		}
		;----------------------------------------------------
		; Auto-detect the controller number
		;----------------------------------------------------
		ControllerNumber := 0 ; Auto-detect Controller

		if ControllerNumber <= 0
		{
			Loop 16  ; Query each controller number to find out which ones exist.
			{
				if GetKeyState(A_Index "JoyName")
				{
					ControllerNumber := A_Index
					break
				}
			}
			if ControllerNumber <= 0
			{
				ControllerAvailable := false
			} else {
				ControllerAvailable := true
			}
		}
		
		CountClicker := 0
		;----------------------------------------------------
		; Set DynamicReload to false again
		;----------------------------------------------------
		DynamicReload := false
		IniWrite DynamicReload, TempSystemFile, "GeneralData", "DynamicReload"
		;----------------------------------------------------
	} ; End DynamicReload / GUI Static code
	
	;----------------------------------------------------
	; Dinamic code starts here
	;----------------------------------------------------
	if KeepChecking == true {
		elapsed += GeneralLoopInterval 
		remainingTime := round((totalTime - elapsed) / 1000)
		if (remainingTime <= 0) {
			remainingTime := 0
		}
	}
	if remainingTime == 0 {
		remainingTime := totalTime
		elapsed := 0
	    ; Check connection again
		Connected := CheckConnection()
		if Connected == true {
		    IniWrite true, TempSystemFile, "GeneralData", "DynamicReload"
		}
	}
	
	MouseGetPos(&x, &y)
	if SwitchControllerAutoRun == true {
		OptionsMenu.SetIcon("2. Switch Con&troller Autorun", IconLib . "\Switch1.ico")
		if ControllerAvailable == true {
			TextOnOffController.Value := " Controller Found"
			ControllerName.Value := GetKeyState(ControllerNumber "JoyName")
			cont_info := GetKeyState(ControllerNumber "JoyInfo")
			
			if EditBoxesAvailable == true {
				SelectedButton := ""
				Loop {
					if InStr(cont_info, "Z") {
						try {
							axis_info_Z := Round(GetKeyState(ControllerNumber "JoyZ"))
						}
						catch as e {
							; the controller was disconnected
							TextOnOffController.Value := " Controller Not Found"
							ControllerName.Value := " "
							RadioCtrlAuRunYes.Value := false
							RadioCtrlAuRunNo.Value := true
							ControllerAvailable := false
							break
						}
						switch true {
						case axis_info_Z < 45:
							SelectedButton := "ButtonRT"
						case axis_info_Z > 55:
							SelectedButton := "ButtonLT"
						}	
					}
					switch true {
					case GetKeyState(ControllerNumber "Joy1", "P") == true:
						SelectedButton := "ButtonA"
						ControllerKey := "Joy1"
					case GetKeyState(ControllerNumber "Joy2", "P") == true:
						SelectedButton := "ButtonB"
						ControllerKey := "Joy2"
					case GetKeyState(ControllerNumber "Joy3", "P") == true:
						SelectedButton := "ButtonX"
						ControllerKey := "Joy3"
					case GetKeyState(ControllerNumber "Joy4", "P") == true:
						SelectedButton := "ButtonY"
						ControllerKey := "Joy4"
					case GetKeyState(ControllerNumber "Joy5", "P") == true:
						SelectedButton := "ButtonLB"
						ControllerKey := "Joy5"
					case GetKeyState(ControllerNumber "Joy6", "P") == true:
						SelectedButton := "ButtonRB"
						ControllerKey := "Joy6"
					case GetKeyState(ControllerNumber "Joy7", "P") == true:
						SelectedButton := "ButtonBack"
						ControllerKey := "Joy7"
					case GetKeyState(ControllerNumber "Joy8", "P") == true:
						SelectedButton := "ButtonStart"
						ControllerKey := "Joy8"
					}

					if SelectedButton != "" {
						IniWrite SelectedButton, IniFile, "AutoRun", "SelectedButton"
						IniWrite ControllerKey, IniFile, "AutoRun", "ControllerKey"
						break
					}
					if GetKeyState("Space", "P") {
						break
					}
					Sleep 10
				}
				; EditBoxesHandler Sets edit mode OFF and triggers DynamicReload
				EditBoxesHandler()
			}
			if RadioCtrlAuRunYes.Value == true {
				RadioCtrlAuRunNo.Value := false
				Switch true {
				;----------------------------------------------------
				; Autorun Controller RT key
				;----------------------------------------------------
				case SelectedButton == "ButtonRT":
					if InStr(cont_info, "Z") {
						try {
							axis_info_Z := Round(GetKeyState(ControllerNumber "JoyZ"))
						}
						catch as e {
							; the controller was disconnected
							TextOnOffController.Value := " Controller Not Found"
							ControllerName.Value := " "
							RadioCtrlAuRunYes.Value := false
							RadioCtrlAuRunNo.Value := true
							ControllerAvailable := false
							break
						}
						;----------------------------------------------------
						; Controller RT key
						;----------------------------------------------------
						if axis_info_Z < 45 {
							SB.SetText("Starting Controller autorun..")
							Sleep StartDelay
							TextOnOffCtrlAuRun.Value := " ON"
							SB.SetText("Controller autorun active.")
							Send("{" . SprintKey . " down}")
							Send("{" . ForwardKey . " down}")
							if RadioScrlUpYes.Value == 1 {
								RadioScrlUpNo.Value := 0
								TextOnOffScrlUp.Value := " ON"
								Count := 0
								SB.SetText("AutoRun + Scroll up active. Scrlup count: " Count)
								loop ScrlUpCount {
									Send("{WheelUP}")
									sleep ScrlUpInterval
									axis_info_Z := Round(GetKeyState(ControllerNumber "JoyZ"))
									if axis_info_Z < 45 {
										break
									}
									Count++
									SB.SetText("AutoRun + Scroll up active. Scrlup count: " Count)
								}
								TextOnOffScrlUp.Value := " OFF"
								SB.SetText("AutoRun triggered by controller active.")
							}
							loop {
								try {
									axis_info_Z := Round(GetKeyState(ControllerNumber "JoyZ"))
								}
								catch as e {
									;----------------------------------------------------
									; The controller was disconnected
									;----------------------------------------------------
									TextOnOffController.Value := " Controller Not Found"
									ControllerName.Value := " "
									RadioCtrlAuRunYes.Value := false
									RadioCtrlAuRunNo.Value := true
									ControllerAvailable := false
									TextOnOffCtrlAuRun.Value := " OFF"
									Send("{" . SprintKey . " up}")
									Send("{" . ForwardKey . " up}")
									break
								}
								;----------------------------------------------------
								; Controller RT key
								;----------------------------------------------------
								if axis_info_Z < 45 {
									TextOnOffCtrlAuRun.Value := " OFF"
									MouseGetPos(&x, &y)
									Send("{" . SprintKey . " up}")
									Send("{" . ForwardKey . " up}")
									if RadioScrlDownYes.Value == 1 {
										RadioScrlDownNo.Value := 0
										TextOnOffScrlDown.Value := " ON"
										SB.SetText("Starting ScrlDown..")
										Sleep StartDelay
										Count := 0
										SB.SetText("Scroll down active. ScrlDown count: " Count)
										loop ScrlDownCount {
											Send("{WheelDown}")
											sleep ScrlDownInterval
											axis_info_Z := Round(GetKeyState(ControllerNumber "JoyZ"))
											if axis_info_Z < 45 {
												break
											}
											Count++
											SB.SetText("Scroll down active. ScrlDown count: " Count)
										}
										TextOnOffScrlDown.Value := " OFF"
									}
									SB.SetText("Controller Autorun Stopped")
									sleep StopDelay
									SB.SetText("Ready.                        X:" . x . " Y:" . y )
									break
								} ; End JoyZ RT key
								
								if GetKeyState(ExitTaskAutomatorKey){
									TextOnOffCtrlAuRun.Value := " OFF"
									MouseGetPos(&x, &y)
									SB.SetText("Ready.                        X:" . x . " Y:" . y )
									Send("{" . SprintKey . " up}")
									Send("{" . ForwardKey . " up}")
									ExitApp()
								}
								if GetKeyState(SuspendHotkeysKey){
									TextOnOffCtrlAuRun.Value := " OFF"
									MouseGetPos(&x, &y)
									SB.SetText("Ready.                        X:" . x . " Y:" . y )
									Send("{" . SprintKey . " up}")
									Send("{" . ForwardKey . " up}")
									SuspendMenuHandler()
									break
								}
								Sleep AutoRunLoopInterval
							} ; End AutoRun loop
						} ; End JoyZ RT key
					} ; End cont_info Z
				;----------------------------------------------------
				; Autorun Controller LT key
				;----------------------------------------------------
				case SelectedButton == "ButtonLT":
					if InStr(cont_info, "Z") {
						try {
							axis_info_Z := Round(GetKeyState(ControllerNumber "JoyZ"))
						}
						catch as e {
							; the controller was disconnected
							TextOnOffController.Value := " Controller Not Found"
							ControllerName.Value := " "
							RadioCtrlAuRunYes.Value := false
							RadioCtrlAuRunNo.Value := true
							ControllerAvailable := false
							break
						}
						;----------------------------------------------------
						; Controller LT key
						;----------------------------------------------------
						if axis_info_Z > 55 {
							SB.SetText("Starting Controller autorun..")
							Sleep StartDelay
							TextOnOffCtrlAuRun.Value := " ON"
							SB.SetText("Controller autorun active.")
							Send("{" . SprintKey . " down}")
							Send("{" . ForwardKey . " down}")
							if RadioScrlUpYes.Value == 1 {
								RadioScrlUpNo.Value := 0
								TextOnOffScrlUp.Value := " ON"
								Count := 0
								SB.SetText("AutoRun + Scroll up active. Scrlup count: " Count)
								loop ScrlUpCount {
									Send("{WheelUP}")
									sleep ScrlUpInterval
									axis_info_Z := Round(GetKeyState(ControllerNumber "JoyZ"))
									if axis_info_Z > 55 {
										break
									}
									Count++
									SB.SetText("AutoRun + Scroll up active. Scrlup count: " Count)
								}
								TextOnOffScrlUp.Value := " OFF"
								SB.SetText("AutoRun triggered by controller active.")
							}
							loop {
								try {
									axis_info_Z := Round(GetKeyState(ControllerNumber "JoyZ"))
								}
								catch as e {
									;----------------------------------------------------
									; The controller was disconnected
									;----------------------------------------------------
									TextOnOffController.Value := " Controller Not Found"
									ControllerName.Value := " "
									RadioCtrlAuRunYes.Value := false
									RadioCtrlAuRunNo.Value := true
									ControllerAvailable := false
									TextOnOffCtrlAuRun.Value := " OFF"
									Send("{" . SprintKey . " up}")
									Send("{" . ForwardKey . " up}")
									break
								}
								;----------------------------------------------------
								; Controller LT key
								;----------------------------------------------------
								if axis_info_Z > 55 {
									TextOnOffCtrlAuRun.Value := " OFF"
									MouseGetPos(&x, &y)
									Send("{" . SprintKey . " up}")
									Send("{" . ForwardKey . " up}")
									if RadioScrlDownYes.Value == 1 {
										RadioScrlDownNo.Value := 0
										TextOnOffScrlDown.Value := " ON"
										SB.SetText("Starting ScrlDown..")
										Sleep StartDelay
										Count := 0
										SB.SetText("Scroll down active. ScrlDown count: " Count)
										loop ScrlDownCount {
											Send("{WheelDown}")
											sleep ScrlDownInterval
											axis_info_Z := Round(GetKeyState(ControllerNumber "JoyZ"))
											if axis_info_Z > 55 {
												break
											}
											Count++
											SB.SetText("Scroll down active. ScrlDown count: " Count)
										}
										TextOnOffScrlDown.Value := " OFF"
									}
									SB.SetText("Controller Autorun Stopped")
									sleep StopDelay
									SB.SetText("Ready.                        X:" . x . " Y:" . y )
									break
								} ; End JoyZ LT key
								
								if GetKeyState(ExitTaskAutomatorKey){
									TextOnOffCtrlAuRun.Value := " OFF"
									MouseGetPos(&x, &y)
									SB.SetText("Ready.                        X:" . x . " Y:" . y )
									Send("{" . SprintKey . " up}")
									Send("{" . ForwardKey . " up}")
									ExitApp()
								}
								if GetKeyState(SuspendHotkeysKey){
									TextOnOffCtrlAuRun.Value := " OFF"
									MouseGetPos(&x, &y)
									SB.SetText("Ready.                        X:" . x . " Y:" . y )
									Send("{" . SprintKey . " up}")
									Send("{" . ForwardKey . " up}")
									SuspendMenuHandler()
									break
								}
								Sleep AutoRunLoopInterval
							} ; End AutoRun loop
						} ; End JoyZ LT key
					} ; End cont_info Z
				;----------------------------------------------------
				; Autorun Controller Button A, B, X, Y, LB, RB, Back, Start.
				;----------------------------------------------------
				Default:
					if InStr(cont_info, "Z") {
						try {
							Round(GetKeyState(ControllerNumber "JoyZ"))
						}
						catch as e {
							; the controller was disconnected
							TextOnOffController.Value := " Controller Not Found"
							ControllerName.Value := " "
							RadioCtrlAuRunYes.Value := false
							RadioCtrlAuRunNo.Value := true
							ControllerAvailable := false
							break
						}
					}
					if GetKeyState(ControllerNumber . ControllerKey, "P") {
						SB.SetText("Starting Controller autorun..")
						Sleep StartDelay
						TextOnOffCtrlAuRun.Value := " ON"
						SB.SetText("Controller autorun active.")
						Send("{" . SprintKey . " down}")
						Send("{" . ForwardKey . " down}")
						if RadioScrlUpYes.Value == 1 {
							RadioScrlUpNo.Value := 0
							TextOnOffScrlUp.Value := " ON"
							Count := 0
							SB.SetText("AutoRun + Scroll up active. Scrlup count: " Count)
							loop ScrlUpCount {
								Send("{WheelUP}")
								sleep ScrlUpInterval
								if GetKeyState(ControllerNumber . ControllerKey, "P") {
									break
								}
								Count++
								SB.SetText("AutoRun + Scroll up active. Scrlup count: " Count)
							}
							TextOnOffScrlUp.Value := " OFF"
							SB.SetText("AutoRun triggered by controller active.")
						}
						loop {
							try {
								Round(GetKeyState(ControllerNumber "JoyZ"))
							}
							catch as e {
								;----------------------------------------------------
								; The controller was disconnected
								;----------------------------------------------------
								TextOnOffController.Value := " Controller Not Found"
								ControllerName.Value := " "
								RadioCtrlAuRunYes.Value := false
								RadioCtrlAuRunNo.Value := true
								ControllerAvailable := false
								TextOnOffCtrlAuRun.Value := " OFF"
								Send("{" . SprintKey . " up}")
								Send("{" . ForwardKey . " up}")
								break
							}
							;----------------------------------------------------
							; Controller Joy 1-8 key
							;----------------------------------------------------
							if GetKeyState(ControllerNumber . ControllerKey, "P") {
								TextOnOffCtrlAuRun.Value := " OFF"
								MouseGetPos(&x, &y)
								Send("{" . SprintKey . " up}")
								Send("{" . ForwardKey . " up}")
								if RadioScrlDownYes.Value == 1 {
									RadioScrlDownNo.Value := 0
									TextOnOffScrlDown.Value := " ON"
									SB.SetText("Starting ScrlDown..")
									Sleep StartDelay
									Count := 0
									SB.SetText("Scroll down active. ScrlDown count: " Count)
									loop ScrlDownCount {
										Send("{WheelDown}")
										sleep ScrlDownInterval
										if GetKeyState(ControllerNumber . ControllerKey, "P") {
											break
										}
										Count++
										SB.SetText("Scroll down active. ScrlDown count: " Count)
									}
									TextOnOffScrlDown.Value := " OFF"
								}
								SB.SetText("Controller Autorun Stopped")
								sleep StopDelay
								SB.SetText("Ready.                        X:" . x . " Y:" . y )
								break
							} ; End Joy 1-8 key
							
							if GetKeyState(ExitTaskAutomatorKey){
								TextOnOffCtrlAuRun.Value := " OFF"
								MouseGetPos(&x, &y)
								SB.SetText("Ready.                        X:" . x . " Y:" . y )
								Send("{" . SprintKey . " up}")
								Send("{" . ForwardKey . " up}")
								ExitApp()
							}
							if GetKeyState(SuspendHotkeysKey){
								TextOnOffCtrlAuRun.Value := " OFF"
								MouseGetPos(&x, &y)
								SB.SetText("Ready.                        X:" . x . " Y:" . y )
								Send("{" . SprintKey . " up}")
								Send("{" . ForwardKey . " up}")
								SuspendMenuHandler()
								break
							}
							Sleep AutoRunLoopInterval
						} ; End AutoRun loop
					} ; End Joy 1-8 key
				} ; Switch End
			} ; End RadioCtrlAuRunYes
		} else {
			; Controller Not Available
			if EditSelectedKey.Value == "Press a button" {
				EditBoxesHandler()
			}
			TextOnOffController.Value := " Controller Not Found"
			ControllerName.Value := " "
			RadioCtrlAuRunYes.Value := false
			RadioCtrlAuRunNo.Value := true
		}
	} ; End SwitchControllerAutoRun
	
	if GetKeyState(ExitTaskAutomatorKey){
		ExitApp()
	}
	if GetKeyState(SuspendHotkeysKey){
		SuspendMenuHandler()
	}
	
	if SwitchClicker == true {
		if ResizeModule == true {
			if TextPatternClickerOnOff.Value == " ON" {
				SB.SetText("Infinite Clicker Active. Count: " . CountClicker)
				CountClicker++
			} else {
				if CountClicker != 0 {
					SB.SetText("Clicker Stopped. Count: " CountClicker)
					sleep StopDelay
				}
				SB.SetText("Ready.                                                                                                                                X:" . x . " Y:" . y )
				CountClicker := 0
			}
		} else {
			if TextPatternClickerOnOff.Value == " ON" {
				SB.SetText("Infinite Clicker Active. Count: " . CountClicker)
				CountClicker++
			} else {
				if CountClicker != 0 {
					SB.SetText("Clicker Stopped. Count: " CountClicker)
					sleep StopDelay
				}
				SB.SetText("Ready.                         X:" . x . " Y:" . y )
				CountClicker := 0
			}
		}
		if ClearXY == true {
			ClearXY := false
			IniWrite false, TempSystemFile, "GeneralData", "ClearXY"
			StartTime := A_TickCount
			
			Position1.EditPosX.Value := ""
			Position1.EditPosY.Value := ""
			
			Position2.EditPosX.Value := ""
			Position2.EditPosY.Value := ""
			
			Position3.EditPosX.Value := ""
			Position3.EditPosY.Value := ""
			
			Position4.EditPosX.Value := ""
			Position4.EditPosY.Value := ""
			
			Position5.EditPosX.Value := ""
			Position5.EditPosY.Value := ""
			
			Position6.EditPosX.Value := ""
			Position6.EditPosY.Value := ""
			
			Position7.EditPosX.Value := ""
			Position7.EditPosY.Value := ""
			
			Position8.EditPosX.Value := ""
			Position8.EditPosY.Value := ""
			
			Position9.EditPosX.Value := ""
			Position9.EditPosY.Value := ""
			
			Position10.EditPosX.Value := ""
			Position10.EditPosY.Value := ""
			
			Position11.EditPosX.Value := ""
			Position11.EditPosY.Value := ""
			
			Position12.EditPosX.Value := ""
			Position12.EditPosY.Value := ""
			
			Position13.EditPosX.Value := ""
			Position13.EditPosY.Value := ""
			
			Position14.EditPosX.Value := ""
			Position14.EditPosY.Value := ""
			
			Position15.EditPosX.Value := ""
			Position15.EditPosY.Value := ""
			
			Position16.EditPosX.Value := ""
			Position16.EditPosY.Value := ""
			
			Position17.EditPosX.Value := ""
			Position17.EditPosY.Value := ""
			
			Position18.EditPosX.Value := ""
			Position18.EditPosY.Value := ""
			
			Position19.EditPosX.Value := ""
			Position19.EditPosY.Value := ""
			
			Position20.EditPosX.Value := ""
			Position20.EditPosY.Value := ""
			
			Position21.EditPosX.Value := ""
			Position21.EditPosY.Value := ""
			
			Position22.EditPosX.Value := ""
			Position22.EditPosY.Value := ""
		}
		if StartTime != "" and (A_TickCount - StartTime) < abs(5000) {
			ToolTip("Right click to paste mouse position")
		} else {
			ToolTip()
			StartTime := ""
		}
		
		if Position1.EditPosX.Value == "" or Position1.EditPosY.Value == "" {
			Position1.EditRadioYes.Value := false
			Position1.EditRadioNo.Value := true
		}
		if Position2.EditPosX.Value == "" or Position2.EditPosY.Value == "" {
			Position2.EditRadioYes.Value := false
			Position2.EditRadioNo.Value := true
		}
		if Position3.EditPosX.Value == "" or Position3.EditPosY.Value == "" {
			Position3.EditRadioYes.Value := false
			Position3.EditRadioNo.Value := true
		}
		if Position4.EditPosX.Value == "" or Position4.EditPosY.Value == "" {
			Position4.EditRadioYes.Value := false
			Position4.EditRadioNo.Value := true
		}
		if Position5.EditPosX.Value == "" or Position5.EditPosY.Value == "" {
			Position5.EditRadioYes.Value := false
			Position5.EditRadioNo.Value := true
		}
		if Position6.EditPosX.Value == "" or Position6.EditPosY.Value == "" {
			Position6.EditRadioYes.Value := false
			Position6.EditRadioNo.Value := true
		}
		if Position7.EditPosX.Value == "" or Position7.EditPosY.Value == "" {
			Position7.EditRadioYes.Value := false
			Position7.EditRadioNo.Value := true
		}
		if Position8.EditPosX.Value == "" or Position8.EditPosY.Value == "" {
			Position8.EditRadioYes.Value := false
			Position8.EditRadioNo.Value := true
		}
		if Position9.EditPosX.Value == "" or Position9.EditPosY.Value == "" {
			Position9.EditRadioYes.Value := false
			Position9.EditRadioNo.Value := true
		}
		if Position10.EditPosX.Value == "" or Position10.EditPosY.Value == "" {
			Position10.EditRadioYes.Value := false
			Position10.EditRadioNo.Value := true
		}
		if Position11.EditPosX.Value == "" or Position11.EditPosY.Value == "" {
			Position11.EditRadioYes.Value := false
			Position11.EditRadioNo.Value := true
		}
		if Position12.EditPosX.Value == "" or Position12.EditPosY.Value == "" {
			Position12.EditRadioYes.Value := false
			Position12.EditRadioNo.Value := true
		}
		if Position13.EditPosX.Value == "" or Position13.EditPosY.Value == "" {
			Position13.EditRadioYes.Value := false
			Position13.EditRadioNo.Value := true
		}
		if Position14.EditPosX.Value == "" or Position14.EditPosY.Value == "" {
			Position14.EditRadioYes.Value := false
			Position14.EditRadioNo.Value := true
		}
		if Position15.EditPosX.Value == "" or Position15.EditPosY.Value == "" {
			Position15.EditRadioYes.Value := false
			Position15.EditRadioNo.Value := true
		}
		if Position16.EditPosX.Value == "" or Position16.EditPosY.Value == "" {
			Position16.EditRadioYes.Value := false
			Position16.EditRadioNo.Value := true
		}
		if Position17.EditPosX.Value == "" or Position17.EditPosY.Value == "" {
			Position17.EditRadioYes.Value := false
			Position17.EditRadioNo.Value := true
		}
		if Position18.EditPosX.Value == "" or Position18.EditPosY.Value == "" {
			Position18.EditRadioYes.Value := false
			Position18.EditRadioNo.Value := true
		}
		if Position19.EditPosX.Value == "" or Position19.EditPosY.Value == "" {
			Position19.EditRadioYes.Value := false
			Position19.EditRadioNo.Value := true
		}
		if Position20.EditPosX.Value == "" or Position20.EditPosY.Value == "" {
			Position20.EditRadioYes.Value := false
			Position20.EditRadioNo.Value := true
		}
		if Position21.EditPosX.Value == "" or Position21.EditPosY.Value == "" {
			Position21.EditRadioYes.Value := false
			Position21.EditRadioNo.Value := true
		}
		if Position22.EditPosX.Value == "" or Position22.EditPosY.Value == "" {
			Position22.EditRadioYes.Value := false
			Position22.EditRadioNo.Value := true
		}
	
		if GetKeyState("RButton", "P"){
			MouseGetPos(&x, &y)
			Switch true {
			case Position1.EditPosX.Value == "" or Position1.EditPosY.Value == "":
				Position1.EditPosX.Value := x
				Position1.EditPosY.Value := y
				Position1.EditRadioYes.Value := true
				Position1.EditRadioNo.Value := false
				sleep 500
			case Position2.EditPosX.Value == "" or Position2.EditPosY.Value == "":
				Position2.EditPosX.Value := x
				Position2.EditPosY.Value := y
				Position2.EditRadioYes.Value := true
				Position2.EditRadioNo.Value := false
				sleep 500
			case Position3.EditPosX.Value == "" or Position3.EditPosY.Value == "":
				Position3.EditPosX.Value := x
				Position3.EditPosY.Value := y
				Position3.EditRadioYes.Value := true
				Position3.EditRadioNo.Value := false
				sleep 500
			case Position4.EditPosX.Value == "" or Position4.EditPosY.Value == "":
				Position4.EditPosX.Value := x
				Position4.EditPosY.Value := y
				Position4.EditRadioYes.Value := true
				Position4.EditRadioNo.Value := false
				sleep 500
			case Position5.EditPosX.Value == "" or Position5.EditPosY.Value == "":
				Position5.EditPosX.Value := x
				Position5.EditPosY.Value := y
				Position5.EditRadioYes.Value := true
				Position5.EditRadioNo.Value := false
				sleep 500
			case Position6.EditPosX.Value == "" or Position6.EditPosY.Value == "":
				Position6.EditPosX.Value := x
				Position6.EditPosY.Value := y
				Position6.EditRadioYes.Value := true
				Position6.EditRadioNo.Value := false
				sleep 500
			case Position7.EditPosX.Value == "" or Position7.EditPosY.Value == "":
				Position7.EditPosX.Value := x
				Position7.EditPosY.Value := y
				Position7.EditRadioYes.Value := true
				Position7.EditRadioNo.Value := false
				sleep 500
			case Position8.EditPosX.Value == "" or Position8.EditPosY.Value == "":
				Position8.EditPosX.Value := x
				Position8.EditPosY.Value := y
				Position8.EditRadioYes.Value := true
				Position8.EditRadioNo.Value := false
				sleep 500
			case Position9.EditPosX.Value == "" or Position9.EditPosY.Value == "":
				Position9.EditPosX.Value := x
				Position9.EditPosY.Value := y
				Position9.EditRadioYes.Value := true
				Position9.EditRadioNo.Value := false
				sleep 500
			case Position10.EditPosX.Value == "" or Position10.EditPosY.Value == "":
				Position10.EditPosX.Value := x
				Position10.EditPosY.Value := y
				Position10.EditRadioYes.Value := true
				Position10.EditRadioNo.Value := false
				sleep 500
			case Position11.EditPosX.Value == "" or Position11.EditPosY.Value == "":
				Position11.EditPosX.Value := x
				Position11.EditPosY.Value := y
				Position11.EditRadioYes.Value := true
				Position11.EditRadioNo.Value := false
				sleep 500
			case Position12.EditPosX.Value == "" or Position12.EditPosY.Value == "":
				Position12.EditPosX.Value := x
				Position12.EditPosY.Value := y
				Position12.EditRadioYes.Value := true
				Position12.EditRadioNo.Value := false
				sleep 500
			case Position13.EditPosX.Value == "" or Position13.EditPosY.Value == "":
				Position13.EditPosX.Value := x
				Position13.EditPosY.Value := y
				Position13.EditRadioYes.Value := true
				Position13.EditRadioNo.Value := false
				sleep 500
			case Position14.EditPosX.Value == "" or Position14.EditPosY.Value == "":
				Position14.EditPosX.Value := x
				Position14.EditPosY.Value := y
				Position14.EditRadioYes.Value := true
				Position14.EditRadioNo.Value := false
				sleep 500
			case Position15.EditPosX.Value == "" or Position15.EditPosY.Value == "":
				Position15.EditPosX.Value := x
				Position15.EditPosY.Value := y
				Position15.EditRadioYes.Value := true
				Position15.EditRadioNo.Value := false
				sleep 500
			case Position16.EditPosX.Value == "" or Position16.EditPosY.Value == "":
				Position16.EditPosX.Value := x
				Position16.EditPosY.Value := y
				Position16.EditRadioYes.Value := true
				Position16.EditRadioNo.Value := false
				sleep 500
			case Position17.EditPosX.Value == "" or Position17.EditPosY.Value == "":
				Position17.EditPosX.Value := x
				Position17.EditPosY.Value := y
				Position17.EditRadioYes.Value := true
				Position17.EditRadioNo.Value := false
				sleep 500
			case Position18.EditPosX.Value == "" or Position18.EditPosY.Value == "":
				Position18.EditPosX.Value := x
				Position18.EditPosY.Value := y
				Position18.EditRadioYes.Value := true
				Position18.EditRadioNo.Value := false
				sleep 500
			case Position19.EditPosX.Value == "" or Position19.EditPosY.Value == "":
				Position19.EditPosX.Value := x
				Position19.EditPosY.Value := y
				Position19.EditRadioYes.Value := true
				Position19.EditRadioNo.Value := false
				sleep 500
			case Position20.EditPosX.Value == "" or Position20.EditPosY.Value == "":
				Position20.EditPosX.Value := x
				Position20.EditPosY.Value := y
				Position20.EditRadioYes.Value := true
				Position20.EditRadioNo.Value := false
				sleep 500
			case Position21.EditPosX.Value == "" or Position21.EditPosY.Value == "":
				Position21.EditPosX.Value := x
				Position21.EditPosY.Value := y
				Position21.EditRadioYes.Value := true
				Position21.EditRadioNo.Value := false
				sleep 500
			case Position22.EditPosX.Value == "" or Position22.EditPosY.Value == "":
				Position22.EditPosX.Value := x
				Position22.EditPosY.Value := y
				Position22.EditRadioYes.Value := true
				Position22.EditRadioNo.Value := false
				sleep 500
			}
		}		
	} else {
		if StartTime != "" and (A_TickCount - StartTime) < abs(1000) {
			ToolTip("Right click to paste mouse position")
		} else {
			ToolTip()
			StartTime := ""
		}
		SB.SetText("Ready.                         X:" . x . " Y:" . y )
	}
	Sleep GeneralLoopInterval		
} ; End General Loop

