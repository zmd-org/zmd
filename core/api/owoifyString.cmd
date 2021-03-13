:: ZMD, a Windows command line.
:: API: owoifyString.cmd
:: owo uwu furry cringe dumb sus

if [%1] == [] goto usage

set string=%1
set string=%string:l=w%
set string=%string:r=w%
set stringResult=%string%

endlocal
goto :eof

:usage
echo Usage: owoifyString.cmd (string)