:: Name: settings
:: Description: Allows you to change ZMD settings.
:: Usage: settings (setting)
:: Author: rem

:input
echo === %i18nSettingsBanner% ===
echo %i18nValidSettings%: language

set /p inputSetting="%i18nTypeSetting%: "

if %inputSetting%==language (
        goto language
) ELSE (
        echo That's not a valid setting!
        goto input
)

:language
echo.
echo %i18nChosenSetting%: %inputSetting%
echo.
echo %i18nWhatValue%
echo %i18nCurrentValue%: %language%
echo.
echo %i18nValidValues%:
for /R %locales% %%f in (*.cmd) do ( 
        echo %%f
)
set /p inputValue="%i18nTypeValue%: "
if exist %locales%\%inputValue%.cmd (
        set language=%inputValue%
        call %functions%\saveConfig.cmd
        goto :eof
) ELSE (
        echo %i18nInvalidValue%
        goto :eof
)