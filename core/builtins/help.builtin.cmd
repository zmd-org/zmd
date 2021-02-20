:: Name: help
:: Description: Displays all valid ZMD commands, and fetches info about specific commands.
:: Usage: help <command name>
:: Author: Beef

echo === ZMD %allCommands% ===
echo === %builtins% ===
for %%f in (%core%\builtins\*.builtin.cmd) do ( 
        for /F "delims=:: " %%i in (%%f) do set name=%%i
        for /F "delims=::  skip=1" %%i in (%%f) do set description=%%i
        for /F "delims=::  skip=2" %%i in (%%f) do set usage=%%i
        for /F "delims=::  skip=3" %%i in (%%f) do set author=%%i
        echo %name%
)
echo === %plugins% ===
for %%f in (%core%\builtins\*.plugin.cmd) do ( 
        for /F "delims=:: " %%i in (%%f) do set name=%%i
        for /F "delims=::  skip=1" %%i in (%%f) do set description=%%i
        for /F "delims=::  skip=2" %%i in (%%f) do set usage=%%i
        for /F "delims=::  skip=3" %%i in (%%f) do set author=%%i
        echo %name%
)