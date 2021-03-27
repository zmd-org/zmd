:: ZMD, a Windows command line.
:: API: requestPermissions

if [%1] == [] goto usage
if [%2] == [] goto usage

set pluginName=%1
set requestedPermission=%2

:: Check if the plugin specified is valid, if not, error.
if NOT exist %addons%\plugins\%pluginName%\%pluginName%.manifest (
    echo %i18nPluginNotFound%
    set permissionResult=error
    goto :eof
)

:: Check if the user folder exists - if not, create one.
if NOT exist %mainDir%user (
    md %mainDir%user\
)

@set userFolder=%mainDir%user

:: Make a folder for plugin permissions and define it
if NOT exist %userFolder%\addonData\permissions\ (
    md %userFolder%\addonData\permissions\
)
@set permissionsFolder=%userFolder%\addonData\permissions

if %requestedPermission%==superUser (
    echo %pluginName% %i18nSuperUserInitialWarning%
    echo %i18nSuperUserSecondaryWarning%
    echo %i18nAreYouSure%
    set /p choice=""
        if [%choice%]=="yes" (
            if NOT exist %permissionsFolder%\%pluginName% (
                md %permissionsFolder%\%pluginName%\
            )
            @set pluginPermissions=%permissionsFolder%\%pluginName%
            echo [] > %pluginPermissions%\.superUser
            echo %pluginName% %i18nSuperUserSuccess%
            set permissionResult=true
            goto :eof
        ) ELSE (
            echo %i18nCancelled%
            set permissionResult=false
            goto :eof
        )
)

goto :eof

:usage
echo Usage: requestPermissions.cmd (plugin name) (permission)