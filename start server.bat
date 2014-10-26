echo off
cls
title Start car
color 71
RMDIR /S /Q ".tmp/public"
tasklist /FI "IMAGENAME eq Open Server.exe" | find /i "Open Server.exe"
IF ERRORLEVEL 1 start "" "../OpenServer/Open Server.exe"
START cmd /k "nodemon app.js -w api -w config"
exit