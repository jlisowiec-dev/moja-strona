@echo off
rem Uruchamia lokalny serwer strony kancelarii na http://localhost:8080
powershell -NoProfile -ExecutionPolicy Bypass -File "%~dp0serve.ps1"
pause
