@echo off
setlocal enabledelayedexpansion

set "dir1=C:\path\to\directory1"
set "dir2=C:\path\to\directory2"

if not exist "%dir1%" exit /b 1
if not exist "%dir2%" exit /b 1

:compareAndCopy
    set "file1=%1"
    set "file2=%2"
    for %%A in ("%file1%") do set "mod1=%%~tA"
    for %%B in ("%file2%") do set "mod2=%%~tB"
    if "%mod1%" GTR "%mod2%" (
        copy /Y "%file1%" "%file2%"
    ) else (
        copy /Y "%file2%" "%file1%"
    )
    goto :eof

for %%F in ("%dir1%\*") do (
    set "file1=%%F"
    set "file2=%dir2%\%%~nxF"
    if exist "!file2!" (
        call :compareAndCopy "!file1!" "!file2!"
    ) else (
        copy /Y "!file1!" "%dir2%"
    )
)

for %%F in ("%dir2%\*") do (
    set "file2=%%F"
    set "file1=%dir1%\%%~nxF"
    if not exist "!file1!" (
        copy /Y "!file2!" "%dir1%"
    )
)

endlocal
pause
