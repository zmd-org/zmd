:: ZMD, a Windows command line.
:: API: sendWebhook

@echo off

if [%1] == [] goto usage
if [%2] == [] goto usage
if [%3] == [] goto usage
if [%4] == [] goto usage

:curlCheck
where curl >NUL
if NOT ERRORLEVEL 0 (
        echo Looks like you don't have curl installed, or an unexpected error occurred.
        for /f "tokens=4-8 delims=. " %%i in ('ver') do set winVersion=%%i.%%j
        echo It comes pre-installed with Windows 10. Your Windows version is %winVersion%.
) ELSE (
        goto webhookSend
)

:webhookSend
SET webhookURL=https://discord.com/api/webhooks/%3/%4
curl -X POST ^
  -H "Content-Type: application/json" ^
  -d "{\"username\": \"%1\", \"content\": \"%2\"}" ^
  %webhookURL%

endlocal
goto :eof

:usage
echo Usage: sendWebhook.cmd (username) (content) (id) (token)