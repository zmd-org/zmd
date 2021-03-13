:: ZMD, a Windows command line.
:: Main File

:: Loading Sequence
:load
@echo off
@title ZMD is loading...
@setlocal ENABLEEXTENSIONS
chcp 65001 >NUL

:: Variables

:: We use %~dp0 here to account for whatever directory ZMD is running in - this will always specify the script directory.
@set maindir=%~dp0
@set addons=%maindir%\addons
@set core=%maindir%\core
:: Convenience™
@set api=%core%\api
@set functions=%core%\functions
@set locales=%maindir%\locales

:: Check if the user folder exists - if not, create one.
if NOT exist %maindir%\user (
    md %maindir%\user\
)
@set userFolder=%maindir%\user

:configHandler
if NOT exist %userFolder%\config.cmd (
    call %functions%\saveConfig.cmd
    call %userFolder%\config.cmd
) ELSE (
    set userFolder=%maindir%\user
    call %userFolder%\config.cmd
)

:i18nHandler
if exist %locales%\%language%.cmd (
    call %locales%\%language%.cmd
    goto welcomePrompt
) else (
    echo [Internal error] Language file invalid.
    echo Press any key to close the program.
    pause >NUL
    exit
)

:: Welcome Prompt Function
:welcomePrompt
echo %i18nWelcome%
goto command

:: Command Handler Function
:command
call %locales%\%language%.cmd
setlocal DisableDelayedExpansion
title ZMD
echo.
echo ┌──(%USERNAME%@%ComputerName%)-[~%CD%]
set /p input="└─$ "
title ZMD - %input%
if exist %core%\builtins\%input%\*.manifest (
    echo.
    call %core%\builtins\%input%\index.cmd
    goto command
) else (
    if exist %addons%\plugins\%input%\*.manifest (
        echo.
        call %addons%\plugins\%input%\index.cmd
        goto command
    ) else (
        echo %i18nInvalidCommand%
        goto command
    )
)
