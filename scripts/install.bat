@echo off
REM Installation script for Windows
REM professoroakz/.github repository

echo ========================================
echo   professoroakz/.github installer
echo ========================================
echo.

REM Check for Node.js
where node >nul 2>nul
if %ERRORLEVEL% NEQ 0 (
    echo [ERROR] Node.js not found
    echo.
    echo Please install Node.js first:
    echo   - Visit: https://nodejs.org/
    echo   - Or use Chocolatey: choco install nodejs
    echo   - Or use Scoop: scoop install nodejs
    echo.
    pause
    exit /b 1
)

REM Check for npm
where npm >nul 2>nul
if %ERRORLEVEL% NEQ 0 (
    echo [ERROR] npm not found
    echo.
    echo Please install npm (usually comes with Node.js)
    echo.
    pause
    exit /b 1
)

REM Display versions
for /f "delims=" %%i in ('node --version') do set NODE_VERSION=%%i
for /f "delims=" %%i in ('npm --version') do set NPM_VERSION=%%i

echo [OK] Node.js found: %NODE_VERSION%
echo [OK] npm found: %NPM_VERSION%
echo.

REM Installation menu
echo Choose installation method:
echo   1) Install globally via npm (recommended)
echo   2) Install locally (development)
echo   3) Exit
echo.
set /p choice="Enter choice [1-3]: "

if "%choice%"=="1" goto install_global
if "%choice%"=="2" goto install_local
if "%choice%"=="3" goto exit_script
goto invalid_choice

:install_global
echo.
echo Installing @professoroakz/github via npm...
npm install -g @professoroakz/github
if %ERRORLEVEL% EQU 0 (
    echo.
    echo [OK] Successfully installed @professoroakz/github
    goto complete
) else (
    echo.
    echo [ERROR] Failed to install @professoroakz/github
    pause
    exit /b 1
)

:install_local
echo.
echo Installing from local directory...
if not exist package.json (
    echo [ERROR] package.json not found
    pause
    exit /b 1
)
npm install
if %ERRORLEVEL% EQU 0 (
    echo.
    echo [OK] Dependencies installed successfully
    goto complete
) else (
    echo.
    echo [ERROR] Failed to install dependencies
    pause
    exit /b 1
)

:invalid_choice
echo.
echo [ERROR] Invalid choice
pause
exit /b 1

:exit_script
echo.
echo Installation cancelled
exit /b 0

:complete
echo.
echo ========================================
echo   Installation complete!
echo ========================================
echo.
pause
exit /b 0
