:: Name: devkit
:: Description: ZMD's official developer toolkit. Contains a bundle of tools for developers.
:: Usage: devkit
:: Author: rem

:: Variables

:: Define directories
@set devkitComponents=%~dp0components
@set devkitLocales=%devkitComponents%\locales

call %devkitLocales%\%language%.cmd

:: Request Permissions
:: Here, we use an API function to request superUser rights. This will probably be changed later to more specific permissions.
if exist %pluginPermissions%\.superUser (
    goto i18nHandler
)
call %api%\requestPermissions.cmd devkit superUser
if NOT %permissionResult% == true (
    echo %i18nDevkitPermissionError%
    goto :eof
)
:: Re-call the current script, so that we have SU.
cmd /c %mainDir%zmd.cmd devkit keepAlive

:: i18n
:: Hey devs! If you're looking through this plugin for inspiration, or simply how to do something, here's an example of i18n integration in a plugin!
:: It's loosely based upon ZMD's i18n handler.
:i18nHandler
if NOT exist %devkitLocales%\%language%.cmd (
    echo Hey! Sorry about this, but the language you're using in ZMD hasn't been implemented into this plugin yet.
    echo Because of this, the plugin's language has been set to en-gb.
    call %devkitLocales%\en-gb.cmd
    echo.
    goto input
)
call %devkitLocales%\%language%.cmd
goto input

:: Input Function
:input
echo %i18nDevkitWhatOption%
echo %i18nDevkitValidOptions%: manifestor (m), zdebugger (z)
:: This method is in testing.
choice /C mz
if ERRORLEVEL 1 (
    call %devkitComponents%\manifestor.cmd
)
if ERRORLEVEL 2 (
    call %devkitComponents%\zdebugger.cmd
)