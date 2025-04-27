@echo off
REM #wsl -d paul-laptop01-wsl-w001-app -u paul

REM Esperar un momento para asegurarse de que WSL está completamente iniciado
REM timeout /t 2 /nobreak >nul

REM Abrir el workspace de Visual Studio Code desde WSL
wsl -d paul-laptop01-wsl-w001-app -u paul -- code /home/paul/workspace/projects/w001-app/campaign.code-workspace
