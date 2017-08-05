@ECHO off
REM This script has been created by Zarco Zwier, Aug 5th, 2017
REM This script can freely be re-used and distributed as long as this comment remains.

IF "%1"=="" goto Empty

SET force=
IF "%1"=="disable" (
  ECHO Removing SUBST mappings...
  ECHO:
  REG DELETE "HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v NoDrives /f 2>NUL
)

FOR %%A IN (C D E F G H I J K L M N O P) DO (
  IF "%1"=="enable"  IF NOT EXIST %%A:\ SUBST %%A: C:\>NUL
  IF "%1"=="disable" SUBST %%A: /D>NUL
)

IF "%1"=="enable" (

  IF "%3"=="force" SET force=/f
  IF "%2"=="hideq" (
    ECHO Adding NoDrives to registry
	REG ADD "HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v NoDrives /t REG_DWORD /d 65536 %force%
  )
  
  ECHO:
  ECHO Drive through P: have been mapped using SUBST command
  ECHO:
  ECHO Now enter a removable drive or map a network drive using: NET USE \\SERVER\SHARE
  CHOICE /M "Remove SUBSTed drives through P: right now?"
  IF ERRORLEVEL 2 GOTO Die
  GOTO Disable
)

GOTO Die

:Empty
  ECHO:
  ECHO Use: %~n0%~x0 enable [hideq [force]]
  ECHO Or:  %~n0%~x0 disable
  ECHO - hideq:	Hides Q: drive, user needs to logon again.
  ECHO - force:	Forces overwriting registry value.
  ECHO:
  PAUSE
  GOTO Die 

:Disable
  CALL %0 disable  

:Die
