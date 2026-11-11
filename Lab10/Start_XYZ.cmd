@echo off
cd /d "%~dp0"
if exist ".venv\Scripts\python.exe" (
  ".venv\Scripts\python.exe" view_xyz.py
) else (
  python view_xyz.py
)
if errorlevel 1 pause
