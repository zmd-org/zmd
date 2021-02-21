:: ZMD, a Windows command line.
:: Main File

:: Loading Sequence
:load
@echo off
@title ZMD is loading...
@setlocal ENABLEEXTENSIONS
chcp 65001 >NUL

:: Variables
@set maindir=%userprofile%\Documents\GitHub\zmd
@set addons=%maindir%\addons
@set core=%maindir%\core
@set locales=%maindir%\locales
@set language=en-gb

:i18n
if exist %locales%\%language%.cmd (
    call %locales%\%language%.cmd
    goto welcome
) else (
    echo [Internal error] Language file invalid.
    echo Press any key to close the program.
    pause >NUL
    exit
)

:: Welcome Prompt Function
:welcome
echo %i18nWelcome%
goto command

:: Command Handler Function
:command
title ZMD
echo.
echo ┌──(%USERNAME%@%ComputerName%)-[~%CD%]
set /p input="└─$ "
title ZMD - %input%
if exist %core%\builtins\%input%\ (
    echo.
    call %core%\builtins\%input%\index.cmd
    goto command
) else (
    if exist %addons%\plugins\%input%\index.cmd (
        echo.
        call %addons%\plugins\%input%\index.cmd
        goto command
    ) else (
        echo %i18nInvalidCommand%
        goto command
    )
)
