#Requires Autohotkey v2.0

; https://github.com/Vonng/Capslock
SetCapsLockState("AlwaysOff")

#HotIf (GetKeyState("LWin", "P") || GetKeyState("RWin", "P"))
CapsLock & j::WinMinimize("A")
CapsLock & k::WinMaximize("A")

#HotIf
CapsLock & `::{
  CapsLockState := GetKeyState("CapsLock", "T") ? "D" : "U"
  if (CapsLockState = "D")
    SetCapsLockState("AlwaysOff")
  else
    SetCapsLockState("AlwaysOn")
  KeyWait("``")
}

CapsLock::Send("{ESC}")

CapsLock & h::{
  if GetKeyState("control") = 0 {
    if GetKeyState("alt") = 0
      Send("{Left}")
    else
      Send("+{Left}")
  } else {
    if GetKeyState("alt") = 0
      Send("^{Left}")
    else
      Send("+^{Left}")
  }
}

CapsLock & j::{
  if GetKeyState("control") = 0 {
    if GetKeyState("alt") = 0
      Send("{Down}")
    else
      Send("+{Down}")
  } else {
    if GetKeyState("alt") = 0
      Send("^{Down}")
    else
      Send("+^{Down}")
  }
}

CapsLock & k::{
  if GetKeyState("control") = 0 {
    if GetKeyState("alt") = 0
      Send("{Up}")
    else
      Send("+{Up}")
  } else {
    if GetKeyState("alt") = 0
      Send("^{Up}")
    else
      Send("+^{Up}")
  }
}

CapsLock & l::{
  if GetKeyState("control") = 0 {
    if GetKeyState("alt") = 0
      Send("{Right}")
    else
      Send("+{Right}")
  } else {
    if GetKeyState("alt") = 0
      Send("^{Right}")
    else
      Send("+^{Right}")
  }
}

CapsLock & i::{
  if GetKeyState("control") = 0 {
    if GetKeyState("alt") = 0
      Send("{Home}")
    else
      Send("+{Home}")
  } else {
    if GetKeyState("alt") = 0
      Send("^{Home}")
    else
      Send("+^{Home}")
  }
}

CapsLock & o::{
  if GetKeyState("control") = 0 {
    if GetKeyState("alt") = 0
      Send("{End}")
    else
      Send("+{End}")
  } else {
    if GetKeyState("alt") = 0
      Send("^{End}")
    else
      Send("+^{End}")
  }
}

CapsLock & u::{
  if GetKeyState("control") = 0 {
    if GetKeyState("alt") = 0
      Send("{PgUp}")
    else
      Send("+{PgUp}")
  } else {
    if GetKeyState("alt") = 0
      Send("^{PgUp}")
    else
      Send("+^{PgUp}")
  }
}

CapsLock & p::{
  if GetKeyState("control") = 0 {
    if GetKeyState("alt") = 0
      Send("{PgDn}")
    else
      Send("+{PgDn}")
  } else {
    if GetKeyState("alt") = 0
      Send("^{PgDn}")
    else
      Send("+^{PgDn}")
  }
}

CapsLock & Up::
CapsLock & NumpadUp:: MouseMove(0, -10, 0, "R")
CapsLock & Down::
CapsLock & NumpadDown:: MouseMove(0, 10, 0, "R")
CapsLock & Left::
CapsLock & NumpadLeft:: MouseMove(-10, 0, 0, "R")
CapsLock & Right::
CapsLock & NumpadRight:: MouseMove(10, 0, 0, "R")

CapsLock & [::Send("{WheelUp}")
CapsLock & ]::Send("{WheelDown}")

CapsLock & Enter::{
  SendEvent("{Blind}{LButton down}")
  KeyWait("Enter")
  SendEvent("{Blind}{LButton up}")
}

NotCtrlDelWnd() {
  return WinActive("ahk_exe AutoHotkey.exe")
      || WinActive("ahk_exe AutoHotkeyU64.exe")
      || WinActive("ahk_class CabinetWClass ahk_exe explorer.exe")
}

CapsLock & ,::Send("{Del}")
CapsLock & .::Send((NotCtrlDelWnd()) ? "^+{Right}{Del}" : "^{Del}")
CapsLock & m::Send("{BS}")
CapsLock & n::Send((NotCtrlDelWnd()) ? "^+{Left}{BS}" : "^{BS}")

CapsLock & w::{
  if GetKeyState("alt")
    Send("^+{Right}")
  else
    Send("^{Right}")
}

CapsLock & b::{
  if GetKeyState("alt")
    Send("^+{Left}")
  else
    Send("^{Left}")
}

CapsLock & F1::Send("{Volume_Mute}")
CapsLock & F2::Send("{Volume_Down}")
CapsLock & F3::Send("{Volume_Up}")
CapsLock & F4::Send("{Media_Play_Pause}")
CapsLock & F5::Send("{Media_Next}")
CapsLock & F6::Send("{Media_Stop}")

CapsLock & s::Send("{Ins}")
CapsLock & g::Send("{AppsKey}")
CapsLock & Tab::Send("!{Tab}")

!F4::
CapsLock & q::{
  if (WinActive("ahk_exe Discord.exe")) {
    WinClose()
  } else {
    Send("!{F4}")
  }
}

#f::{
  path15 := "C:\Program Files\Everything 1.5a\Everything.exe"
  path := "C:\Program Files\Everything\Everything.exe"

  if FileExist(path15) {
    targetPath := path15
    targetWinClass := "ahk_class EVERYTHING_1.5_FRAME"
  } else if FileExist(path) {
    targetPath := path
    targetWinClass := "ahk_class EVERYTHING"
  } else {
    MsgBox("Everything is not found.", "Error", 48)
    return
  }

  if WinExist(targetWinClass) {
    if WinActive(targetWinClass) {
      WinMinimize(targetWinClass)
    } else {
      WinActivate(targetWinClass)
    }
  } else {
    Run('"' targetPath '"')
  }
}

!+v::{
  clipSaved := ClipboardAll()
  A_Clipboard := A_Clipboard
  Send "^v"
  Sleep 100
  A_Clipboard := clipSaved
}
