; This script launches all scripts from `ahk_scripts` directory.
;
; To ignore some of those scripts,
; put the names (including the `.ahk` extension) of them
; in the `start_all_ahk_scripts.ignore` file.
;
;
; Copyright 2021-present Jakub Kuczys (https://github.com/jack1142)
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

#NoEnv
#KeyHistory 0
ListLines Off
; the above are just a bunch of optimizations

ignore_file = %A_ScriptDir%\start_all_ahk_scripts.ignore
ignored_scripts := []
file_exists := FileExist(ignore_file)
if file_exists && !InStr(file_exists, "D")
{
    FileRead, file_contents, %A_ScriptDir%\start_all_ahk_scripts.ignore
    ignored_scripts := StrSplit(Trim(file_contents, " `r`n"), "`n", " `r`t")
}

Loop, Files, %A_ScriptDir%\ahk_scripts\*.ahk
{
    for idx, file_name in ignored_scripts
        if file_name == A_LoopFileName
            continue 2

    Run, %A_LoopFileFullPath%
}
