@echo off

REM Ensure this Node.js and npm are first in the PATH
SET PATH=%APPDATA%\npm;%~dp0;%PATH%
SET PATH=%PATH%;c:\here\is\path\to\npm\dir