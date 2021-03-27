:: ZMD, a Windows command line.
:: API: requestPermissions

if [%1] == [] goto usage
if [%2] == [] goto usage

set pluginName=%1
set requestedPermission=%2

:: Check if the user folder exists - if not, create one.
if NOT exist %mainDir%\user (
    md %mainDir%\user\
)

@set userFolder=%mainDir%\user

:: Make a folder for plugin permissions and define it
md %userFolder%\addonData\permissions\
@set permissionsFolder=%userFolder%\addonData\permissions

if %requestedPermission%==superUser (
    echo %i18nSuperUserInitialWarning%
    echo %i18nSuperUserSecondaryWarning%
    echo %i18nAreYouSure%
    choice YN
        if ERRORLEVEL 1 (
            echo @set superUser=true > %permissionsFolders%\%pluginName%.cmd
            echo %i18nSuperUserSuccess%
            set permissionResult=true
            goto :eof
        )
        if ERRORLEVEL 2 (
            echo %i18nCancelled%
            set permissionResult=false
            goto :eof
        )
)

endlocal
goto :eof

:usage
echo Usage: requestPermissions.cmd (plugin name) (permission)