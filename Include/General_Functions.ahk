;------------- Credits ------------
; Creator: Fernando Daniel Jaime.
; Programmer Alias: FDJ-Dash.
;------------- File Details ------------
; App Name: Game Tools.
; File Description: This file contains general functions.
;----------------------------------------------------
; Header list:
;----------------------------------------------------
; ExitMenu(ExitReason,ExitCode)
; EncryptMsg(OriginalMsg, *)
; DecryptMsg(EncryptedMsgTA, *)
; ParseRequest(*)
; CheckConnection(*)
;----------------------------------------------------
ExitMenu(ExitReason,ExitCode)
{	
	SB.SetText("Quiting..")
	GuiName := IniRead(TempSystemFile, "GeneralData", "GuiName")
	if GuiName == "TaskAutomatorGui1" {
		TaskAutomatorGui1.GetPos(&PosX, &PosY)
	} else {
		TaskAutomatorGui2.GetPos(&PosX, &PosY)
	}
	if PosX != -32000 {
		IniWrite PosX, IniFile, "Properties", "PositionX"
	}
	if PosY != -32000 {
		IniWrite PosY, IniFile, "Properties", "PositionY"
	}
	If ExitReason == "Reload" {
		return 0
	}
	try {
		FileDelete DataFile
		FileDelete TempCleanFileTA
	}
	catch {
	}
	Send("{w up}")
	Send("{shift up}")
	ExitMsg
	try {
		FileDelete TempSystemFile
		FileDelete AuxHkDataFile
	}
	catch {
	}
	sleep ExitMessageTimeWait
	return 0
}
;----------------------------------------------------
EncryptMsg(OriginalMsg, *){
	MixedPattern := "Az0By9Cx7Da8Eb2Fc4Gw3Hv5Ij6Js1KlLhMpNeOtPgQnRrSiTqUoVkWmXdYfZu"
	PunctuationPattern := "!#$%&'()*+,-./:;<=>?@[\]^_`"{|}~ "
	
	EncryptedMsg := ""
	FlagSignCount := 0
	FlagNmCount := 0
	Flag_az_Count := 0
	Flag_AZ_Count2 := 0
	Loop Parse OriginalMsg {
		switch true {
		case ord(A_LoopField) > 31 and ord(A_LoopField) < 48:
			; punctuation signs
			for index, letter in StrSplit(PunctuationPattern) {
				switch true {
				case FlagSignCount == 0:
					if (letter == A_LoopField) {
						EncryptedMsg .= chr(index + 34 + 6)
						EncryptedMsg .= chr(index + 34 + 4)
						FlagSignCount++
						break
					}
				case FlagSignCount == 1:
					if (letter == A_LoopField) {
						EncryptedMsg .= chr(index + 34 + 3)
						EncryptedMsg .= chr(index + 34 + 8)
						FlagSignCount++
						break
					}
				case FlagSignCount == 2:
					if (letter == A_LoopField) {
						EncryptedMsg .= chr(index + 34 + 9)
						EncryptedMsg .= chr(index + 34 + 3)
						FlagSignCount++
						break
					}
				case FlagSignCount == 3:
					if (letter == A_LoopField) {
						EncryptedMsg .= chr(index + 34 + 20)
						EncryptedMsg .= chr(index + 34 + 30)
						FlagSignCount := 0
						break
					}
				}
			}
		case ord(A_LoopField) > 47 and ord(A_LoopField) < 58:
			; (0,9)
			EncryptedString := A_LoopField
			for index, letter in StrSplit(MixedPattern) {
				switch true {
				case FlagNmCount == 0:
					if (letter == A_LoopField) {
						EncryptedMsg .= chr(index + 34 + 6)
						EncryptedMsg .= chr(index + 34 + 3)
						FlagNmCount++
						break
					}
				case FlagNmCount == 1:
					if (letter == A_LoopField) {
						EncryptedMsg .= chr(index + 34 + 7)
						EncryptedMsg .= chr(index + 34 + 18)
						FlagNmCount++
						break
					}
				case FlagNmCount == 2:
					if (letter == A_LoopField) {
						EncryptedMsg .= chr(index + 34 + 10)
						EncryptedMsg .= chr(index + 34 + 24)
						FlagNmCount := 0
						break
					}
				}
			}
		case ord(A_LoopField) > 57 and ord(A_LoopField) < 65:
			; punctuation signs
			for index, letter in StrSplit(PunctuationPattern) {
				switch true {
				case FlagSignCount == 0:
					if (letter == A_LoopField) {
						EncryptedMsg .= chr(index + 34 + 6)
						EncryptedMsg .= chr(index + 34 + 4)
						FlagSignCount++
						break
					}
				case FlagSignCount == 1:
					if (letter == A_LoopField) {
						EncryptedMsg .= chr(index + 34 + 3)
						EncryptedMsg .= chr(index + 34 + 8)
						FlagSignCount++
						break
					}
				case FlagSignCount == 2:
					if (letter == A_LoopField) {
						EncryptedMsg .= chr(index + 34 + 9)
						EncryptedMsg .= chr(index + 34 + 3)
						FlagSignCount++
						break
					}
				case FlagSignCount == 3:
					if (letter == A_LoopField) {
						EncryptedMsg .= chr(index + 34 + 20)
						EncryptedMsg .= chr(index + 34 + 30)
						FlagSignCount := 0
						break
					}
				}
			}
		case ord(A_LoopField) > 64 and ord(A_LoopField) < 91:
			; (A-Z)
			EncryptedString := A_LoopField
			for index, letter in StrSplit(MixedPattern) {
				switch true {
				case Flag_AZ_Count2 == 0:
					if (letter == A_LoopField) {
						EncryptedMsg .= chr(index + 34 + 16)
						EncryptedMsg .= chr(index + 34 + 28)
						Flag_AZ_Count2++
						break
					}
				case Flag_AZ_Count2 == 1:
					if (letter == A_LoopField) {
						EncryptedMsg .= chr(index + 34 + 9)
						EncryptedMsg .= chr(index + 34 + 18)
						Flag_AZ_Count2++
						break
					}
				case Flag_AZ_Count2 == 2:
					if (letter == A_LoopField) {
						EncryptedMsg .= chr(index + 34 + 15)
						EncryptedMsg .= chr(index + 34 + 16)
						Flag_AZ_Count2 := 0
						break
					}
				}
			}
		case ord(A_LoopField) > 90 and ord(A_LoopField) < 97:
			; punctuation signs
			for index, letter in StrSplit(PunctuationPattern) {
				switch true {
				case FlagSignCount == 0:
					if (letter == A_LoopField) {
						EncryptedMsg .= chr(index + 34 + 6)
						EncryptedMsg .= chr(index + 34 + 4)
						FlagSignCount++
						break
					}
				case FlagSignCount == 1:
					if (letter == A_LoopField) {
						EncryptedMsg .= chr(index + 34 + 3)
						EncryptedMsg .= chr(index + 34 + 8)
						FlagSignCount++
						break
					}
				case FlagSignCount == 2:
					if (letter == A_LoopField) {
						EncryptedMsg .= chr(index + 34 + 9)
						EncryptedMsg .= chr(index + 34 + 3)
						FlagSignCount++
						break
					}
				case FlagSignCount == 3:
					if (letter == A_LoopField) {
						EncryptedMsg .= chr(index + 34 + 20)
						EncryptedMsg .= chr(index + 34 + 30)
						FlagSignCount := 0
						break
					}
				}
			}
		case ord(A_LoopField) > 96 and ord(A_LoopField) < 123:
			; (a-z)
			EncryptedString := A_LoopField
			for index, letter in StrSplit(MixedPattern) {
				switch true {
				case Flag_az_Count == 0:
					if (letter == A_LoopField) {
						EncryptedMsg .= chr(index + 34 + 29)
						EncryptedMsg .= chr(index + 34 + 25)
						Flag_az_Count++
						break
					}
				case Flag_az_Count == 1:
					if (letter == A_LoopField) {
						EncryptedMsg .= chr(index + 34 + 10)
						EncryptedMsg .= chr(index + 34 + 18)
						Flag_az_Count++
						break
					}
				case Flag_az_Count == 2:
					if (letter == A_LoopField) {
						EncryptedMsg .= chr(index + 34 + 15)
						EncryptedMsg .= chr(index + 34 + 22)
						Flag_az_Count := 0
						break
					}
				}
			}
		case ord(A_LoopField) > 122 and ord(A_LoopField) < 127:
			; punctuation signs
			for index, letter in StrSplit(PunctuationPattern) {
				switch true {
				case FlagSignCount == 0:
					if (letter == A_LoopField) {
						EncryptedMsg .= chr(index + 34 + 6)
						EncryptedMsg .= chr(index + 34 + 4)
						FlagSignCount++
						break
					}
				case FlagSignCount == 1:
					if (letter == A_LoopField) {
						EncryptedMsg .= chr(index + 34 + 3)
						EncryptedMsg .= chr(index + 34 + 8)
						FlagSignCount++
						break
					}
				case FlagSignCount == 2:
					if (letter == A_LoopField) {
						EncryptedMsg .= chr(index + 34 + 9)
						EncryptedMsg .= chr(index + 34 + 3)
						FlagSignCount++
						break
					}
				case FlagSignCount == 3:
					if (letter == A_LoopField) {
						EncryptedMsg .= chr(index + 34 + 20)
						EncryptedMsg .= chr(index + 34 + 30)
						FlagSignCount := 0
						break
					}
				}
			}
		}
	}
	return EncryptedMsg
}
;----------------------------------------------------
DecryptMsg(EncryptedMsgTA, *) {
	MixedPattern := "Az0By9Cx7Da8Eb2Fc4Gw3Hv5Ij6Js1KlLhMpNeOtPgQnRrSiTqUoVkWmXdYfZu"
	PunctuationPattern := "!#$%&'()*+,-./:;<=>?@[\]^_`"{|}~ "
	DecryptedMsg := ""
	
	count := 1
	DiffValue := 0
	IndexKey := 0
	Loop Parse EncryptedMsgTA {
		if Mod(count, 2) == 1 {
			RealKey := ord(A_LoopField)
		}
		
		if Mod(count, 2) == 0 {
			AddedKey1 := ord(A_LoopField)
			DiffValue := Abs(RealKey - AddedKey1)
			flagLetterFound := 0
			switch true {
			case DiffValue == 1:
				IndexKey := RealKey - 34 - 15
				for index, letter in StrSplit(MixedPattern) {
					if IndexKey < 0 {
						; continue
					}
					if index == IndexKey {
						DecryptedMsg .= letter
						break
					}
				}
			case DiffValue == 2:
				IndexKey := RealKey - 34 - 6
				for index, letter in StrSplit(PunctuationPattern) {
					if IndexKey < 0 {
						; continue
					}
					if index == IndexKey {
						DecryptedMsg .= letter
						break
					}
				}
			case DiffValue == 3:
				IndexKey := RealKey - 34 - 6
				for index, letter in StrSplit(MixedPattern) {
					if IndexKey < 0 {
						; continue
					}
					if index == IndexKey {
						DecryptedMsg .= letter
						break
					}
				}
			case DiffValue == 4:
				IndexKey := RealKey - 34 - 29
				for index, letter in StrSplit(MixedPattern) {
					if IndexKey < 0 {
						continue
					}
					if index == IndexKey {
						DecryptedMsg .= letter
						break
					}
				}
			case DiffValue == 5:
				IndexKey := RealKey - 34 - 3
				for index, letter in StrSplit(PunctuationPattern) {
					if IndexKey < 0 {
						; continue
					}
					if index == IndexKey {
						DecryptedMsg .= letter
						break
					}
				}
			case DiffValue == 6:
				IndexKey := RealKey - 34 - 9
				for index, letter in StrSplit(PunctuationPattern) {
					if IndexKey < 0 {
						; continue
					}
					if index == IndexKey {
						DecryptedMsg .= letter
						break
					}
				}
			case DiffValue == 7:
				IndexKey := RealKey - 34 - 15
				for index, letter in StrSplit(MixedPattern) {
					if IndexKey < 0 {
						; continue
					}
					if index == IndexKey {
						DecryptedMsg .= letter
						break
					}
				}
			case DiffValue == 8:
				IndexKey := RealKey - 34 - 10
				for index, letter in StrSplit(MixedPattern) {
					if IndexKey < 0 {
						; continue
					}
					if index == IndexKey {
						DecryptedMsg .= letter
						break
					}
				}
			case DiffValue == 9:
				IndexKey := RealKey - 34 - 9
				for index, letter in StrSplit(MixedPattern) {
					if IndexKey < 0 {
						; continue
					}
					if index == IndexKey {
						DecryptedMsg .= letter
						break
					}
				}
			case DiffValue == 10:
				IndexKey := RealKey - 34 - 20
				for index, letter in StrSplit(PunctuationPattern) {
					if IndexKey < 0 {
						; continue
					}
					if index == IndexKey {
						DecryptedMsg .= letter
						break
					}
				}
			case DiffValue == 11:
				IndexKey := RealKey - 34 - 7
				for index, letter in StrSplit(MixedPattern) {
					if IndexKey < 0 {
						continue
					}
					if index == IndexKey {
						DecryptedMsg .= letter
						break
					}
				}
			case DiffValue == 12:
				IndexKey := RealKey - 34 - 16
				for index, letter in StrSplit(MixedPattern) {
					if IndexKey < 0 {
						continue
					}
					if index == IndexKey {
						DecryptedMsg .= letter
						break
					}
				}
			case DiffValue == 14:
				IndexKey := RealKey - 34 - 10
				for index, letter in StrSplit(MixedPattern) {
					if IndexKey < 0 {
						continue
					}
					if index == IndexKey {
						DecryptedMsg .= letter
						break
					}
				}
			}
		}
		count++
	}
	return DecryptedMsg
}
;----------------------------------------------------
ParseRequest(*){
	TempFileTA := A_Temp . "\TA_UpdateData.ini"
	EncCurl := "PLjr_f_[HF16S_KEBL42IQNU_[16X``el71miRZHOsobjW^V``a]T\Y``c_IQ753893<Cc_\dCM[bokT\SZ}y:B53BIsodl38_feaPXel\X93;D;<NZBL5>7?NUa]64AB<HGP16DE7?ipea71co``hel_[IQDN_feaLTW^JFIQW^\X64LT<CgcRZNUgc"
	RunWait(A_ComSpec " /c " . DecryptMsg(EncCurl) . " > " TempFileTA, , "Hide")
	
	Count := 0
	Loop Read, TempFileTA
	{
		; Check if the current line is empty
		if !A_LoopReadLine {
			Count++
			continue
		}
		
		; Process the non-empty line here
		Flag1stLetter := 0
		CountOrd34 := 0
		FlagAddedSpace := 0
		CleanLine := ""
		Loop parse A_LoopReadLine {
			if ord(A_LoopField) == 34 {
				CountOrd34++
				if CountOrd34 == 4 {
					break
				}
			}
			if Flag1stLetter == 1 {
				Switch true {
				case ord(A_LoopField) == 32 and FlagAddedSpace == 0:
					CleanLine .= A_LoopField
					FlagAddedSpace := 1
				case ord(A_LoopField) == 34 and FlagAddedSpace == 0:
					CleanLine .= " "
					FlagAddedSpace := 1
				case ord(A_LoopField) == 44:
					break
				case ord(A_LoopField) != 34:
					CleanLine .= A_LoopField
					FlagAddedSpace := 0
				}	
			} 
			if ord(A_LoopField) != 32 and Flag1stLetter == 0 {
				Flag1stLetter := 1
				if ord(A_LoopField) != 34 {
					break
				}
			}
		}
		FileAppend CleanLine . "`n", TempCleanFileTA
		Match := RegExMatch(CleanLine, "tag_name : v\d+\.\d+", &tag_name)
		Match2 := RegExMatch(CleanLine, "browser_download_url : https://github.com/FDJ-Dash/FDJ-Game-Tools/releases/download/v\d+\.\d+/\w+-\w+-\w+-\w+-v\d+\.\d+\.\w+", &download_url)
		Match3 := RegExMatch(CleanLine, "name : \w+-\w+-\w+-\w+-v\d+\.\d+\.\w+", &name)
		Switch true {
		case Match == true:
			for index, word in StrSplit(tag_name[0], A_Space) {
				if index == 3 {
					TALatestReleaseVersion := word
					IniWrite TALatestReleaseVersion, DataFile, "GeneralData", "GTLatestReleaseVersion"
				}
			}
		case Match2 == true:
			for index, word in StrSplit(download_url[0], A_Space) {
				if index == 3 {
					DownloadUrl := word
					DownloadUrl := EncryptMsg(DownloadUrl)
					IniWrite DownloadUrl, DataFile, "EncryptedData", "GTDownload"
				}
			}
		case Match3 == true:
			for index, word in StrSplit(name[0], A_Space) {
				if index == 3 {
					Name := word
					IniWrite Name, DataFile, "GeneralData", "GTName"
				}
			}
		}
	}
	
	try {
		FileDelete TempFileTA
	}
	catch {

	}
}
;----------------------------------------------------
CheckConnection(*){
	TempFileConnectionTA := A_Temp . "\TA_Connection.log"
	RunWait(A_ComSpec " /c curl -k -L https://www.google.com > " TempFileConnectionTA, , "Hide")
	Match := false
	Count := 0
	Loop Read, TempFileConnectionTA
	{
		; Check if the current line is empty
		if !A_LoopReadLine {
			Count++
			continue
		}
		if Count > 0 {
			Match := true
			break
		}
		Count++
	}
	
	try {
		FileDelete TempFileConnectionTA
	}
	catch {

	}
	return Match
}