; This script adds 2 hotkeys:
; - ``Ctrl+` `` Open new Windows Terminal tab/window
;               in the path of active Explorer window
; - ``Win+` ``  Focus/minimize the current Windows Terminal window
;               or start a new session
;
;
; Copyright 2021 Jakub Kuczys (https://github.com/jack1142)
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

; This was supposed to be Ctrl+Alt+T but Windows plays a bell signal when I try it...
^`:: ; Ctrl+`
    openWindowsTerminalHere() {
        ; Opens new Windows Terminal tab/window in the path of active Explorer window
        path := _getActiveExplorerPath()
        args := ""
        if (path)
            args .= "-d """ path """"
        Run wt.exe %args%
    }

#`:: ; Win+`
    toggleWindowsTerminalWindowFocus() {
        ; Focus/minimize the current Windows Terminal window or start a new session
        wtHwnd := WinExist("ahk_class CASCADIA_HOSTING_WINDOW_CLASS")
        if (wtHwnd)
        {
            activeWtHwnd := WinActive("ahk_id " wtHwnd)
            if (activeWtHwnd)
                WinMinimize, ahk_id %activeWtHwnd%
            else
                WinActivate, ahk_id %wtHwnd%
        }
        else
        {
            Run wt.exe
        }
    }
