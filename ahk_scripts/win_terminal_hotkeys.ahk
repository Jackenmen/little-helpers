; This script adds 2 hotkeys:
; - ``Ctrl+Shift+` `` Open new Windows Terminal tab/window
;               in the path of active Explorer window
; - ``Win+` ``  Focus/minimize the current Windows Terminal window
;               or start a new session
;
;
; Copyright 2021-present Jakub Kuczys (https://github.com/Jackenmen)
;
; Licensed under the Apache License, Version 2.0 (the "License");
; you may not use this file except in compliance with the License.
; You may obtain a copy of the License at
;
;     https://www.apache.org/licenses/LICENSE-2.0
;
; Unless required by applicable law or agreed to in writing, software
; distributed under the License is distributed on an "AS IS" BASIS,
; WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
; See the License for the specific language governing permissions and
; limitations under the License.

#SingleInstance force
#NoEnv
#KeyHistory 0
ListLines Off
; the above are just a bunch of optimizations

; Make MouseGetPos return position relative to the entire screen, not active window.
CoordMode, Mouse, Screen

_getActiveExplorerPath() {
    ; source: https://www.autohotkey.com/boards/viewtopic.php?f=6&t=69925
    explorerHwnd := WinActive("ahk_class CabinetWClass")
    if (!explorerHwnd)
        explorerHwnd := WinActive("ahk_class ExplorerWClass")

    if (!explorerHwnd)
        return

    for window in ComObjCreate("Shell.Application").Windows
        if (window.hwnd == explorerHwnd)
            return window.Document.Folder.Self.Path
}
_getMouseMonitorIndex() {
    MouseGetPos, x, y
    SysGet, monitorCount, MonitorCount
    Loop, %monitorCount% {
        SysGet, bounds, Monitor, %A_Index%
        if (boundsLeft <= x
            && boundsTop <= y
            && x <= boundsRight
            && y <= boundsBottom)
        {
            return %A_Index%
        }
    }
    ; this should never happen but just in case...
    SysGet, primaryMonitorIndex, MonitorPrimary
    return %primaryMonitorIndex%
}
_waitAndMoveWindowsTerminalWindowToMouse() {
    WinWait, ahk_class CASCADIA_HOSTING_WINDOW_CLASS
    _moveWindowToMouse()
}
_moveWindowToMouse(winTitle := "") {
    monitorIndex := _getMouseMonitorIndex()
    SysGet, bounds, MonitorWorkArea, %monitorIndex%
    MouseGetPos, mouseX, mouseY
    WinGetPos, x, y, windowWidth, windowHeight, %winTitle%

    newX := mouseX - (windowWidth / 2)
    newY := mouseY - (windowHeight / 2)
    if (newX > (boundsRight - windowWidth))
        newX := boundsRight - windowWidth
    if (newY > (boundsBottom - windowHeight))
        newY := boundsBottom - windowHeight
    if (newX < boundsLeft)
        newX := boundsLeft
    if (newY < boundsTop)
        newY := boundsTop

    WinMove, %winTitle%,, %newX%, %newY%
}

; This was supposed to be Ctrl+Alt+T but Windows plays a bell signal when I try it...
^+`:: ; Ctrl+Shift+`
    openWindowsTerminalHere() {
        ; Opens new Windows Terminal tab/window in the path of active Explorer window
        path := _getActiveExplorerPath()
        args := ""
        if (path)
            args .= "-d """ path """"
        Run wt.exe %args%
        _waitAndMoveWindowsTerminalWindowToMouse()
    }
