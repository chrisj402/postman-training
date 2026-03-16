@echo off
REM Postman Training Framework - Setup Script for Windows
REM This script installs all necessary dependencies for running the Postman training framework

echo ===================================================
echo   Postman Training Framework Setup (Windows)
echo ===================================================
echo.

REM Check Node.js
echo Checking Node.js installation...
node --version >nul 2>&1
if %errorlevel% neq 0 (
    echo [ERROR] Node.js is not installed
    echo Please install Node.js from: https://nodejs.org/
    pause
    exit /b 1
)

for /f "tokens=*" %%i in ('node --version') do set NODE_VERSION=%%i
echo [OK] Node.js is installed: %NODE_VERSION%

REM Check npm
echo Checking npm installation...
npm --version >nul 2>&1
if %errorlevel% neq 0 (
    echo [ERROR] npm is not installed
    echo npm usually comes with Node.js. Please reinstall Node.js.
    pause
    exit /b 1
)

for /f "tokens=*" %%i in ('npm --version') do set NPM_VERSION=%%i
echo [OK] npm is installed: %NPM_VERSION%

REM Install Newman
echo.
echo Checking Newman (Postman CLI) installation...
newman --version >nul 2>&1
if %errorlevel% neq 0 (
    echo Newman is not installed. Installing now...
    call npm install -g newman
    if %errorlevel% neq 0 (
        echo [ERROR] Failed to install Newman
        pause
        exit /b 1
    )
    echo [OK] Newman installed successfully
) else (
    for /f "tokens=*" %%i in ('newman --version') do set NEWMAN_VERSION=%%i
    echo [OK] Newman is already installed: %NEWMAN_VERSION%
)

REM Install Newman HTML Reporter
echo.
echo Installing Newman HTML Reporter...
call npm install -g newman-reporter-html
if %errorlevel% neq 0 (
    echo [WARNING] Failed to install Newman HTML Reporter (optional)
) else (
    echo [OK] Newman HTML Reporter installed successfully
)

REM Validate JSON files
echo.
echo Validating collection and environment files...
if not exist "collections\01-basics\rest-api-basics.json" (
    echo [ERROR] Collection file not found: collections\01-basics\rest-api-basics.json
    pause
    exit /b 1
)
echo [OK] Collection file found

if not exist "environments\training-local.json" (
    echo [ERROR] Environment file not found: environments\training-local.json
    pause
    exit /b 1
)
echo [OK] Environment file found

REM Run test
echo.
echo Running a quick test to verify setup...
newman run collections\01-basics\rest-api-basics.json --environment environments\training-local.json --reporters cli --bail >nul 2>&1
if %errorlevel% neq 0 (
    echo [WARNING] Test run failed. Please check your internet connection.
    echo JSONPlaceholder API must be accessible.
) else (
    echo [OK] Test run successful! All systems operational.
)

REM Summary
echo.
echo ===================================================
echo   Setup Complete!
echo ===================================================
echo.
echo All dependencies are installed and configured
echo.
echo Next Steps:
echo   1. Import collection: collections\01-basics\rest-api-basics.json
echo   2. Import environment: environments\training-local.json
echo   3. Run tests: newman run collections\01-basics\rest-api-basics.json --environment environments\training-local.json
echo   4. View dashboard: test-results.html
echo   5. Start learning: guides\01-getting-started.md
echo.
echo Happy Testing!
echo.
pause
