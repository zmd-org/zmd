:: ZMD, a Windows command line.
:: saveConfig
:: A handy-dandy function to save the config file from anywhere.

if exist %userFolder%\config.cmd (
    echo @set language=%language%>%userFolder%\config.cmd
) ELSE (
    echo @set language=en-gb>%userFolder%\config.cmd
)