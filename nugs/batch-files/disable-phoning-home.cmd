SET NEWLINE=^& echo.

FIND /C /I "activate.company-server.com" %WINDIR%\system32\drivers\etc\hosts
IF %ERRORLEVEL% NEQ 0 ECHO %NEWLINE%^127.0.0.1                   activate.company-server.com>>%WINDIR%\system32\drivers\etc\hosts

FIND /C /I "licenses.company-server.com" %WINDIR%\system32\drivers\etc\hosts
IF %ERRORLEVEL% NEQ 0 ECHO ^127.0.0.1                   licenses.company-server.com>>%WINDIR%\system32\drivers\etc\hosts


