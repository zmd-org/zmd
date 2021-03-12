:: ZMD, a Windows command line.
:: API: fetchLine
:: Thank you to https://stackoverflow.com/a/130298 for this, I just edited for use in ZMD

@echo off

if [%1] == [] goto usage
if [%2] == [] goto usage

call :print_head %1 %2
goto :eof

::
:: print_head
:: Prints the first non-blank %1 lines in the file %2.
::
:print_head
setlocal EnableDelayedExpansion
set /a counter=0

for /f ^"usebackq^ eol^=^

^ delims^=^" %%a in (%2) do (
        if "!counter!"=="%1" goto :eof
        echo %%a
        set /a counter+=1
)

goto :eof

:usage
echo Usage: fetchLine.cmd (COUNT) (FILENAME)