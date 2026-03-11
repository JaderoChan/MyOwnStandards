@echo off
setlocal EnableExtensions

REM Usage check
if "%~1"=="" goto :usage
if "%~2"=="" goto :usage

set "SRC=%~1"
set "OUT_DIR=%~2"

REM Check source file
if not exist "%SRC%" (
    echo [ERROR] Input image does not exist: "%SRC%"
    exit /b 1
)

REM Check magick
where magick >nul 2>nul
if errorlevel 1 (
    echo [ERROR] ImageMagick command "magick" not found. Please install it and add to PATH.
    exit /b 1
)

REM Create output directory
if not exist "%OUT_DIR%" (
    mkdir "%OUT_DIR%" || (
        echo [ERROR] Failed to create output directory: "%OUT_DIR%"
        exit /b 1
    )
)

echo [INFO] Generating PNG sizes: 16,32,64,128,256,512,1024
for %%S in (16 32 64 128 256 512 1024) do (
    magick "%SRC%" -resize %%Sx%%S -filter Lanczos -strip "%OUT_DIR%\app_%%S.png"
    if errorlevel 1 (
        echo [ERROR] Failed to generate app_%%S.png
        exit /b 1
    )
)

echo [INFO] Generating ICO (16,24,32,48,64,128,256)
magick "%SRC%" -define icon:auto-resize=16,24,32,48,64,128,256 "%OUT_DIR%\app.ico"

echo [INFO] Generating ICNS (16,32,64,128,256,512,1024)
magick "%SRC%" -define icon:auto-resize=16,32,64,128,256,512,1024 "%OUT_DIR%\app.icns"

echo [OK] Done
echo [OK] Output directory: "%OUT_DIR%"
exit /b 0

:usage
echo Usage:
echo   %~nx0 ^<input.png^> ^<output_folder^>
echo Example:
echo   %~nx0 "C:\images\logo_1024.png" "C:\images\out"
exit /b 2
