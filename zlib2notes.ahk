#Requires AutoHotkey v2.0
#Include D:\OneDrive\AutoHotkey\UIA-v2\Lib\UIA.ahk
#Include D:\OneDrive\AutoHotkey\UIA-v2\Lib\UIA_Browser.ahk

IsLegalWindowsFilename(name) {
  name := Trim(name)
  if (name = "")
    return false
  if (RegExMatch(name, "[<>:\`"/\\|?*]"))
    return false
  if (RegExMatch(name, "i)^(con|prn|aux|nul|com[1-9]|lpt[1-9])(\.|$)"))
    return false
  if (SubStr(name, 1, 1) = "." || SubStr(name, -1) = ".")
    return false
  if (SubStr(name, 1, 1) = " " || SubStr(name, -1) = " ")
    return false
  return StrLen(name) <= 255
}

if (!WinExist("ahk_exe msedge.exe"))
  ExitApp
WinActivate "ahk_exe msedge.exe"

cUIA := UIA_Browser()
url := cUIA.GetCurrentURL()
title := RegExReplace(WinGetTitle(), "( et (\d+ pages de plus|1 page supplémentaire))? - Personnel – Microsoft​ Edge$")
today := FormatTime(A_Now, "yyyy-MM-dd")
safeTitle := StrReplace(title, ": ", " - ")

if (!IsLegalWindowsFilename(safeTitle)) {
  while true {
    fileNamePrompt := InputBox("The note title is not valid for a Windows file name.`nEnter a file name without the .md extension:", "Choose note file name", , safeTitle)
    if (fileNamePrompt.Result != "OK") {
      TrayTip(, "No new note created.", 1 + 16)
      Sleep 3000
      ExitApp
    }

    suggestedTitle := Trim(fileNamePrompt.Value)
    if (IsLegalWindowsFilename(suggestedTitle)) {
      safeTitle := suggestedTitle
      break
    }

    MsgBox("That file name is not valid for Windows. Please use a name without special characters, trailing periods/spaces, or reserved device names.", "Invalid file name", 0x10)
  }
}

filePath := "D:\Notes\" safeTitle ".md"

fileContent := "---`n"
fileContent .= "z-lib: " url "`n"
fileContent .= "author: `n"
fileContent .= "created: " today "`n"
fileContent .= "---`n"

if FileExist(filePath) {
  response := MsgBox("File already exists:`n" filePath "`nDo you want to overwrite it?", "Confirm overwrite", 4)
  if (response != "Yes") {
    TrayTip(, "No new note created.", 1 + 16)
    Sleep 3000
    ExitApp
  }
}

Try FileDelete(filePath)
FileAppend(fileContent, filePath)
TrayTip(, "Saved to:`n" filePath, 1 + 16)
Sleep 3000
