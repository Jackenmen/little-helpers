@echo off
setlocal EnableDelayedExpansion
setlocal

if "%1" == "" (
    echo Usage: ^<pr_number^> [issue_numbers...]
    exit /B 1
)

echo git diff
git diff
set /p CONFIRMATION=Do you want to continue (Yn)?
if /i "%CONFIRMATION%"=="n" (
    exit /B 0
)

if "%2" == "" (
    echo git commit -am "PR %1" || exit %errorlevel%
    git commit -am "PR %1" || exit %errorlevel%
) else (
    set issue_numbers=%2
    :while
    if not "%3" == "" (
        set issue_numbers=!issue_numbers!, %3
        shift /2
        goto :while
    )
    echo git commit -am "PR %1 (issue !issue_numbers!)"
    git commit -am "PR %1 (issue !issue_numbers!)"
)
echo gh ca %1
gh ca %1
