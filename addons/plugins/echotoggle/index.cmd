@echo off
echo === ZMD EchoToggle ===
echo TRUE = echo on
echo FALSE = echo off
set /p input=""
if "%input%"=="TRUE" (
	@echo on
)
if "%input%"=="FALSE" (
	@echo off
)