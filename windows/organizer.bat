
@echo off
setlocal DisableDelayedExpansion

set "target=%~1"

:: Check that a target folder was provided
if "%target%"=="" (
    echo Usage: %~nx0 "target_folder"
    exit /b 1
)

:: Check that the target folder exists
if not exist "%target%\" (
    echo Error: Target folder does not exist.
    exit /b 1
)

:: Create destination folders
for %%D in (images docs videos archives other) do (
    if not exist "%target%\%%D\" mkdir "%target%\%%D"
)

:: Organize files in the target folder
for %%F in ("%target%\*") do (
    if exist "%%~fF" if not exist "%%~fF\" (
        if /i not "%%~fF"=="%~f0" (
            call :organize "%%~fF" "%%~xF"
        )
    )
)

echo Organization complete!
exit /b 0


:organize
set "file=%~1"
set "ext=%~2"

if /i "%ext%"==".jpg"  goto image
if /i "%ext%"==".jpeg" goto image
if /i "%ext%"==".png"  goto image
if /i "%ext%"==".gif"  goto image
if /i "%ext%"==".bmp"  goto image
if /i "%ext%"==".webp" goto image

if /i "%ext%"==".pdf"  goto doc
if /i "%ext%"==".doc"  goto doc
if /i "%ext%"==".docx" goto doc
if /i "%ext%"==".txt"  goto doc
if /i "%ext%"==".rtf"  goto doc
if /i "%ext%"==".xls"  goto doc
if /i "%ext%"==".xlsx" goto doc
if /i "%ext%"==".ppt"  goto doc
if /i "%ext%"==".pptx" goto doc

if /i "%ext%"==".mp4"  goto video
if /i "%ext%"==".mkv"  goto video
if /i "%ext%"==".avi"  goto video
if /i "%ext%"==".mov"  goto video
if /i "%ext%"==".wmv"  goto video

if /i "%ext%"==".zip"  goto archive
if /i "%ext%"==".rar"  goto archive
if /i "%ext%"==".7z"   goto archive
if /i "%ext%"==".tar"  goto archive
if /i "%ext%"==".gz"   goto archive

move "%file%" "%target%\other\" >nul
exit /b

:image
move "%file%" "%target%\images\" >nul
exit /b

:doc
move "%file%" "%target%\docs\" >nul
exit /b

:video
move "%file%" "%target%\videos\" >nul
exit /b

:archive
move "%file%" "%target%\archives\" >nul
exit /b
