@echo off
REM Enable UTF-8 encoding and delayed expansion
chcp 65001 >nul
setlocal enabledelayedexpansion

:: Configuration file path
set "config_file=%~dp0launcher_config.txt"

:: Initialize variables
set "exit_code=0"

:: Main function
call :main
exit /b %exit_code%

:main
:: Check configuration file
if not exist "%config_file%" (
    call :create_config
    if !errorlevel! neq 0 (
        echo Failed to create configuration file
        set exit_code=1
        exit /b
    )
)

:: Load menu
call :show_menu
exit /b

:show_menu
cls
echo File Launcher Utility
echo =====================

:: Display configured items
set /a item_count=0
for /f "tokens=1-3 delims=|" %%a in ('type "%config_file%" ^| findstr /v "^#"') do (
    set /a item_count+=1
    echo %%a. %%b
    set "option_%%a=%%c"
)

:: Calculate dynamic options
set /a open_all=item_count+1
set /a exit_option=item_count+2

echo %open_all%. Open All Files
echo %exit_option%. Exit
echo =====================

:: Get user input
:input_loop
set "choice="
set /p "choice=Enter your choice (1-%exit_option%): "

:: Validate input
echo !choice!|findstr /r "^[0-9]*$" >nul || (
    echo Invalid input: Numbers only
    goto input_loop
)

if !choice! lss 1 (
    echo Input too small
    goto input_loop
)

if !choice! gtr %exit_option% (
    echo Input too large
    goto input_loop
)

:: Process selection
if "!choice!"=="%open_all%" (
    call :open_all_files
) else if "!choice!"=="%exit_option%" (
    exit /b
) else (
    call :open_single_file !choice!
)

:: Post-action prompt
echo.
choice /c YN /n /m "Return to main menu? (Y/N): "
if errorlevel 2 exit /b
goto show_menu

:open_single_file
set "file_path=!option_%1!"
if not defined file_path (
    echo Invalid selection
    goto input_loop
)

if not exist "!file_path!" (
    echo File not found: "!file_path!"
    pause
    goto input_loop
)

echo Opening: "!file_path!"
start "" "!file_path!"
if !errorlevel! neq 0 (
    echo [ERROR] Failed to open file (Code: !errorlevel!)
    pause
)
exit /b

:open_all_files
echo Opening all files...
set /a success_count=0
set /a fail_count=0

for /f "tokens=1-3 delims=|" %%a in ('type "%config_file%" ^| findstr /v "^#"') do (
    echo Attempting: %%b
    if exist "%%c" (
        start "" "%%c"
        set /a success_count+=1
    ) else (
        echo [ERROR] Missing file: "%%c"
        set /a fail_count+=1
    )
)

echo Operation complete: !success_count! succeeded, !fail_count! failed
pause
exit /b

:create_config
echo Creating new configuration file...
(
    echo # File Launcher Configuration
    echo # Format: ID^|Display Name^|File Path
    echo 1^|Sample Text File^|%%USERPROFILE%%\Documents\example.txt
    echo 2^|Sample Image^|%%USERPROFILE%%\Pictures\sample.jpg
) > "%config_file%"

if exist "%config_file%" (
    echo Configuration file created: "%config_file%"
    timeout /t 3 >nul
    exit /b 0
) else (
    exit /b 1
)