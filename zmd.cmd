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
@set mainDir=%~dp0

:: Convenience™
@set addons=%mainDir%addons
@set core=%mainDir%core
@set api=%core%\api
@set functions=%core%\functions
@set locales=%mainDir%locales

:: Check if the user folder exists - if not, create one.
if NOT exist %mainDir%user (
    md %mainDir%user\
)

@set userFolder=%mainDir%user

:: Check if the config exists - if not, create it!
:configHandler
if NOT exist %userFolder%\config.cmd (
    call %functions%\saveConfig.cmd
    call %userFolder%\config.cmd
) ELSE (
    call %userFolder%\config.cmd
)

:: Check if the current language file actually exists. If yes, then call it. Else, error.
:i18nHandler
if exist %locales%\%language%.cmd (
    if not exist %locales%\en-gb.cmd (
        echo [Internal error] Backup language file invalid.
        echo Press any key to close the program.
        echo We'd recommend re-cloning ZMD.
        pause >NUL
        exit
    )
    :: Here, we call the backup language file first, as to stop any "ECHO is on." strings being printed when a language entry is invalid.
    call %locales%\en-gb.cmd
    call %locales%\%language%.cmd
    goto welcomePrompt
) else (
    if not exist %locales%\en-gb.cmd (
        echo [Internal error] Backup language file invalid.
        echo Press any key to close the program.
        echo We'd recommend re-cloning ZMD.
        pause >NUL
        exit
    )
    echo [Internal error] Language file invalid, defaulting to en-gb.
    call %locales%\en-gb.cmd
    echo.
    goto welcomePrompt
)

:: Welcome Prompt Function
:welcomePrompt
echo.
echo %i18nWelcome%
goto command

:: Command Handler Function
:command
:: Re-call the language file each time the command handler is used.
:: Shouldn't cause slowdown, unless you're using an absolute potato.
call %locales%\%language%.cmd

:: Remove DelayedExpansion because AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA I despise it
setlocal DisableDelayedExpansion

:: Set the program title, in case it has been overwritten
title ZMD

if NOT [%1] == [] (
    set input=%1
    goto exec
)

echo.
echo ┌──(%USERNAME%@%ComputerName%)-[~%CD%]
set /p input="└─$ "
goto exec

:: Execute Command Function
:exec
title ZMD - %input%

if exist %core%\builtins\%input%\*.manifest (
    echo.
    call %core%\builtins\%input%\index.cmd
    goto returner
) else (
    if exist %addons%\plugins\%input%\*.manifest (
        echo.
        @set pluginPermissions=%userFolder%\addonData\permissions\%input%
        
        if NOT exist %pluginPermissions%\.superUser (
            :: Here, we "sandbox" any plugins that do not have superUser, making them run locally in their own file. However, we do give them some variable access.
            setlocal
            @set mainDir=%~dp0
            @set api=%~dp0core\api
            if exist %~dp0user (
                @set userFolder=%~dp0user
            )
            if exist %userFolder%\addonData\permissions\%input%\ (
                @set pluginPermissions=%userFolder%\addonData\permissions\%input%
            )
            call %addons%\plugins\%input%\index.cmd
            endlocal
        ) else (
            :: If the specified plugin does have superUser, run it like a built-in.
            call %locales%\%language%.cmd
            call %addons%\plugins\%input%\index.cmd
        )

        goto returner
    ) else (
        echo %i18nInvalidCommand%
        goto returner
    )
)

:returner
if NOT [%1] == [] (
    if NOT [%2] == [] (
        cmd /c %~dp0zmd.cmd
    )
goto :eof
)
goto command