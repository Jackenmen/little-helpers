@echo off
REM
REM This script splits a pane vertically in Windows Terminal
REM and runs the given command in it,
REM while keeping focus on the pane it was ran from.
REM
REM Usage: `sp <command...>`
REM
REM
REM Copyright 2021 Jakub Kuczys (https://github.com/jack1142)
REM
REM Licensed under the Apache License, Version 2.0 (the "License");
REM you may not use this file except in compliance with the License.
REM You may obtain a copy of the License at
REM
REM     https://www.apache.org/licenses/LICENSE-2.0
REM
REM Unless required by applicable law or agreed to in writing, software
REM distributed under the License is distributed on an "AS IS" BASIS,
REM WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
REM See the License for the specific language governing permissions and
REM limitations under the License.

REM Set %ESC% to \x1b
FOR /F "delims=#" %%a IN ('PROMPT #$e# FOR %%a IN ^(1^) DO REM') DO (
    SET "ESC=%%a"
)

REM Check if there's at least one argument.
IF "%1" == "" (
    echo %ESC%[91mCommand wasn't passed%ESC%[0m
    EXIT /B 1
)

REM Build and run the command.
SET "command=wt mf left && %* && echo %ESC%[32mSuccess!%ESC%[0m && SLEEP 2"
wt split-pane --startingDirectory . --vertical cmd /C \"%command%\"
