@echo off

rem Verificar si se pasaron los argumentos requeridos
if "%~1"=="" (
    echo Debes proporcionar el argumento MACHINE_OS_MAIN
    exit /b 1
)

if "%~2"=="" (
    echo Debes proporcionar el argumento VIRTUALIZATION
    exit /b 1
)

if "%~3"=="" (
    echo Debes proporcionar el argumento GROUP
    exit /b 1
)

if "%~4"=="" (
    echo Debes proporcionar el argumento HOST
    exit /b 1
)

if "%~5"=="" (
    echo Debes proporcionar el argumento ACTION
    exit /b 1
)

rem MACHINE_OS_MAIN
rem APP_BASE_PATH_PATH_VM
rem VMS_CONFIG_PATH
rem WORKSPACE

rem Capturar los argumentos pasados
set "MACHINE_OS_MAIN=%1"
set "VIRTUALIZATION=%2"
set "GROUP=%3"
set "HOST=%4"
set "ACTION=%~5"
set "WORKSPACE=%6"

set "APP_BASE_PATH=P:\\VMS\\infra-tools-getstart"
set "APP_BASE_PATH=%APP_BASE_PATH:\=/%"

echo %MACHINE_OS_MAIN%
echo %GROUP%
echo %HOST%
echo %ACTION%
echo %WORKSPACE%
echo %APP_BASE_PATH%

"C:\Program Files\Git\bin\bash.exe" -c "'%APP_BASE_PATH%'/vagrant/lib/common.sh %APP_BASE_PATH% '%MACHINE_OS_MAIN%' %VIRTUALIZATION% %GROUP% %HOST% '%ACTION%'"

@REM if not "%WORKSPACE%"=="" (
@REM     set "HOST=%HOST_MAIN%-%ENVIRONMENT%"
@REM     "C:\Program Files\Git\bin\bash.exe" -c "'%APP_BASE_PATH%'/workspace/up_workspace.sh %HOST_VM% %WORKSPACE%"
@REM )
