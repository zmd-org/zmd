:: ZMD, a Windows command line.
:: API: RandomString
:: Fact: This was the first API function ever created.

set stringResult=%random%%random%%random%%random%%random%%random%
set stringResult=%stringResult:0=a%
set stringResult=%stringResult:1=b%
set stringResult=%stringResult:2=c%
set stringResult=%stringResult%