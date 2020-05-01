@echo off

setlocal

call "C:\Program Files (x86)\Microsoft Visual Studio\2019\Community\VC\Auxiliary\Build\vcvarsall" x64

set PROGRAM_NAME=ctemplateapp

set OUT=.\_build

rem SRC should be relative to the OUT directory
set SRC=..\src
set CODE=%SRC%\code
set ASSETS=%SRC%\assets
set VENDOR=%SRC%\vendor

rem -I%VENDOR%\...\include
set INCLUDES=

rem %VENDOR%\...\lib
set RUNTIME_LIBS=

set BUILD_VARIABLES=
set COMPILER_FLAGS=/Fe%PROGRAM_NAME% %BUILD_VARIABLES% -nologo -W3 -Z7 -EHsc -MDd -GR- %INCLUDES%
set PROGRAM_ENTRY=%CODE%\main.c

rem 32-bit build when using -subsystem:windows,5.01 or -subsystem:console,5.01
rem 64-bit build when using -subsystem:windows,5.02 or -subsystem:console,5.02
set SUBSYSTEM=console,5.02
rem -libpath:%VENDOR%\...\lib
set LINKER_DIRS=
rem -verbose:lib
set LINKER_FLAGS=-incremental:no -opt:ref -subsystem:%SUBSYSTEM% %LINKER_DIRS%

if not exist %OUT% mkdir %OUT%
pushd %OUT%

cl %COMPILER_FLAGS% %PROGRAM_ENTRY% /link %LINKER_FLAGS%

for %%I in (%RUNTIME_LIBS%) do copy %%I .\

popd

endlocal

