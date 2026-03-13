#Requires AutoHotkey v2.0
#SingleInstance Force

global gameExe := "Diablo IV.exe"

global spamDelay := 120
global toggleKey := "F8"
global exitKey := "F10"

global spamEnabled := false
global scriptRunning := false
global showOverlay := true
global lastSpamTick := 0

global overlay := 0
global statusText := 0

global mainGui := 0
global delayEdit := 0
global overlayCheckbox := 0
global qCheckbox := 0
global wCheckbox := 0
global eCheckbox := 0
global rCheckbox := 0
global startBtn := 0
global stopBtn := 0
global stateLabel := 0
global infoLabel := 0

CreateMainUI()
CreateOverlay()

SetTimer(SpamLoop, 25)
SetTimer(UpdateOverlayVisibility, 150)

return

CreateMainUI() {
    global mainGui, delayEdit, overlayCheckbox
    global qCheckbox, wCheckbox, eCheckbox, rCheckbox
    global startBtn, stopBtn, stateLabel, infoLabel
    global spamDelay, toggleKey, exitKey, gameExe

    mainGui := Gui(, "Diablo IV Spam Controller")
    mainGui.SetFont("s10", "Segoe UI")

    mainGui.AddText("xm ym w320", "Game:")
    infoLabel := mainGui.AddText("xm y+4 w320 cBlue", gameExe)

    mainGui.AddText("xm y+16 w320", "Keys to spam:")
    qCheckbox := mainGui.AddCheckbox("xm y+6 Checked", "Q")
    wCheckbox := mainGui.AddCheckbox("x+18 yp Checked", "W")
    eCheckbox := mainGui.AddCheckbox("x+18 yp Checked", "E")
    rCheckbox := mainGui.AddCheckbox("x+18 yp", "R")

    mainGui.AddText("xm y+18 w160", "Interval (ms):")
    delayEdit := mainGui.AddEdit("xm y+4 w320 Number", String(spamDelay))

    overlayCheckbox := mainGui.AddCheckbox("xm y+14 Checked", "Show overlay")
    overlayCheckbox.Value := 1

    mainGui.AddText("xm y+16 w320", "Hotkeys:")
    mainGui.AddText("xm y+4 w320", toggleKey " = Toggle spam")
    mainGui.AddText("xm y+2 w320", exitKey " = Exit script")

    startBtn := mainGui.AddButton("xm y+20 w100 h30", "Start")
    stopBtn  := mainGui.AddButton("x+10 yp w100 h30", "Stop")
    stateLabel := mainGui.AddText("x+14 yp+6 w120", "Status: Stopped")

    startBtn.OnEvent("Click", StartScript)
    stopBtn.OnEvent("Click", StopScript)
    mainGui.OnEvent("Close", (*) => ExitApp())

    mainGui.Show("w360 h320")
}

CreateOverlay() {
    global overlay, statusText

    overlay := Gui("+AlwaysOnTop -Caption +ToolWindow")
    overlay.BackColor := "Black"
    overlay.MarginX := 10
    overlay.MarginY := 8
    overlay.SetFont("s12", "Segoe UI")

    statusText := overlay.AddText("w200 Center cRed", "Spam: OFF")
    overlay.Show("x20 y20 NoActivate")
    WinSetTransparent(210, "ahk_id " overlay.Hwnd)

    exStyle := WinGetExStyle("ahk_id " overlay.Hwnd)
    WinSetExStyle(exStyle | 0x20, "ahk_id " overlay.Hwnd)

    overlay.Hide()
}

StartScript(*) {
    global delayEdit, overlayCheckbox
    global qCheckbox, wCheckbox, eCheckbox, rCheckbox
    global spamDelay, showOverlay
    global scriptRunning, spamEnabled, stateLabel, lastSpamTick

    delayValue := Trim(delayEdit.Value)
    showOverlay := (overlayCheckbox.Value = 1)

    if !RegExMatch(delayValue, "^\d+$") {
        MsgBox("Please enter a valid interval in milliseconds.")
        return
    }

    if !qCheckbox.Value && !wCheckbox.Value && !eCheckbox.Value && !rCheckbox.Value {
        MsgBox("Please select at least one key.")
        return
    }

    spamDelay := Integer(delayValue)
    spamEnabled := false
    scriptRunning := true
    lastSpamTick := 0

    stateLabel.Text := "Status: Ready"
    UpdateStatusText()
}

StopScript(*) {
    global scriptRunning, spamEnabled, stateLabel

    scriptRunning := false
    spamEnabled := false
    stateLabel.Text := "Status: Stopped"
    UpdateStatusText()
}

ToggleSpam(*) {
    global scriptRunning, spamEnabled, stateLabel

    if !scriptRunning
        return

    spamEnabled := !spamEnabled

    if spamEnabled
        stateLabel.Text := "Status: Running"
    else
        stateLabel.Text := "Status: Paused"

    UpdateStatusText()
}

UpdateStatusText() {
    global statusText, spamEnabled

    if spamEnabled {
        statusText.Text := "Spam: ON"
        statusText.Opt("cLime")
    } else {
        statusText.Text := "Spam: OFF"
        statusText.Opt("cRed")
    }
}

SpamLoop() {
    global scriptRunning, spamEnabled, gameExe
    global spamDelay, lastSpamTick
    global qCheckbox, wCheckbox, eCheckbox, rCheckbox

    if !scriptRunning || !spamEnabled
        return

    if !WinActive("ahk_exe " gameExe)
        return

    now := A_TickCount
    if (now - lastSpamTick < spamDelay)
        return

    lastSpamTick := now

    if qCheckbox.Value {
        SendInput("{q down}")
        Sleep(10)
        SendInput("{q up}")
        Sleep(10)
    }

    if wCheckbox.Value {
        SendInput("{w down}")
        Sleep(10)
        SendInput("{w up}")
        Sleep(10)
    }

    if eCheckbox.Value {
        SendInput("{e down}")
        Sleep(10)
        SendInput("{e up}")
        Sleep(10)
    }

    if rCheckbox.Value {
        SendInput("{r down}")
        Sleep(10)
        SendInput("{r up}")
        Sleep(10)
    }
}

UpdateOverlayVisibility() {
    global overlay, showOverlay, gameExe, scriptRunning

    if !showOverlay || !scriptRunning {
        overlay.Hide()
        return
    }

    if WinActive("ahk_exe " gameExe)
        overlay.Show("x20 y20 NoActivate")
    else
        overlay.Hide()
}

F8::ToggleSpam()
F10::ExitApp
