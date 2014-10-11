echo on
cls
title Start car
color 71
cd C:\Project\car
nodemon -w api -w config
pause > nul