echo off
cls
title Start car
color 71
START cmd /k "nodemon app.js -w api -w config"