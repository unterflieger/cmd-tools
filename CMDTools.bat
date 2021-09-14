@echo off
@mode con cols=40 lines=15
chcp 65001
set startloc=%cd%
if [%1] equ [/?] goto help
if [%1] equ [/settings] goto settings
if [%1] equ [/dos] goto DOSMODE


SETLOCAL EnableDelayedExpansion
for /F "tokens=1,2 delims=#" %%a in ('"prompt #$H#$E# & echo on & for %%b in (1) do rem"') do (
  set "DEL=%%a"
)
if [%2] equ [debug] goto debugcolor
cls
echo.
title CMD Tools
call :ColorText 0b "Welcome to CMD Tools!"
echo.
echo Press any button to proceed...
pause > nul
cls
:mainscrn
cls
echo What do you want to do?
echo 1) Start a program
echo 2) Write a document
echo 3) Connect to a BBS/Telnet
echo 4) Other Applications
echo 5) Exit this application
echo.
choice /C 12345 /N /M "Select option: "
goto app%errorlevel%
:app1
cls
echo Which application do you want to start?
set /p progausw="Type here: "
if [%progausw%] equ [] echo Invalid name! && pause>nul && goto app1
start %progausw%
goto mainscrn
:app2
echo. && echo This function is in development, so report any bugs that you find! && echo. && echo Press any button to continue! && pause>nul
cls
echo.
call :ColorText FF "1111111111"
call :ColorText F0 "TextWriter"
call :ColorText FF "1111111111"
echo.
call :ColorText FF "1111111"
call :ColorText F0 "To end type &&&"
call :ColorText FF "11111111"
echo.
set /p text=
call :ColorText FF "1111111111"
call :ColorText FF "1111111111"
call :ColorText FF "1111111111"
echo.
echo Save?
echo.
echo Y) Yes
echo N) No
choice /c yn /n
if %errorlevel%=="y" goto save123
pause
goto mainscrn
:save123
cls
echo How should the file be named? (Ending is ".txt")
echo Example: somerandomname
set /p filename=
if %filename%=="somerandomname" echo You're a genius. && pause && goto save123
:fileename
cls
echo Where do you want to save the file?
echo Example: C:\examplefolder\
set /p filesave=
if %filesave%=="C:\examplefolder\" echo Haha. Very funny. && pause && goto fileename
cd %filesave%
echo %text% > %filename%.txt
cls
echo Your file was saved.
pause > nul
goto mainscrn
:app3
cls
cd addons
if exist syncterm cd syncterm && if not exist unins000.exe goto sync
if exist unins000.exe cd %startloc% && goto nosyncno
goto nosync
:sync
if not exist syncterm.exe cd %startloc%
echo 1) Yes
echo 2) No
choice /C 12 /N /M "Do you want to use the installed SyncTerm Add-on to connect to a BBS? If not, the CMD-internal Telnet command will be used."
if %errorlevel%=="1" goto syncask
if %errorlevel%=="2" goto nosync
:syncask
cls
echo A few examples:
echo bbs.archaicbinary.net ::Archaic Binary BBS::
echo bbs.bottomlessabyss.net:2023 ::Bottomless Abyss BBS::
echo towel.blinkenlights.nl ::Star Wars IV in ASCII::
echo.
set /p BBS="Type here: "
echo Starting the Telnet-client...
ping localhost -n 3 >nul
start syncterm.exe telnet://%BBS%
cd %startloc%
goto mainscrn
:nosyncno
echo It seems like your Add-on package is faulty. Please re-install the Add-on or contact the developer.
echo The standard Telnet client will be used.
echo Press any button to continue.
pause>nul
cls
:nosync
cd %startloc%
echo Which BBS/Telnet adress do you want to connect to?
echo.
echo A few examples:
echo bbs.archaicbinary.net ::Archaic Binary BBS::
echo bbs.bottomlessabyss.net:2023 ::Bottomless Abyss BBS::
echo towel.blinkenlights.nl ::Star Wars IV in ASCII::
echo.
set /p BBS="Type here: "
echo Starting the Telnet-client...
ping localhost -n 3 >nul
telnet %BBS%
goto mainscrn
:app4
::Other Apps
cd %startloc%
cd addons
if exist youtube-dl.exe set ytdl=="1"
if %ytdl%=="1" goto yas
goto nas
:yas
cls
echo A Youtube-Downloader Add-on was detected.
echo Press any button to continue.
pause > nul
cls
set /p ytdladress="What is the adress of the video?: "
yt-download %ytdladress%
cd %startloc%
goto mainscrn
:nas
echo You have no additional add-on packs installed. Going back to the homescreen.
cd %startloc%
goto mainscrn

:DOSMODE
echo Sorry, Dos-compatible mode doesn't exist yet.
goto end
pause
:help
echo Possible commands:
echo.
echo [/?] Shows this screen.
echo [/settings] Opens the Settings for this program. [NOT FINISHED]
echo [/dos] Starts Program in Dos-compatible mode. [NOT FINISHED]
goto :end
:debugcolor
set /p colortext="Text: "
call :ColorText F0 %colortext%
:ColorText
echo off
<nul set /p ".=%DEL%" > "%~2"
findstr /v /a:%1 /R "^$" "%~2" nul
del "%~2" > nul 2>&1
:app5
:end
