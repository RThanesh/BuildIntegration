@echo off
SETLOCAL
set DotNetDir=%windir%\Microsoft.NET\Framework\v4.0.30319%
set MSBuildExe=%DotNetDir%\msbuild.exe

IF NOT EXIST "%DotNetDir%" GOTO :NODOTNET
IF NOT EXIST "%MSBuildExe%" GOTO :NODOTNET

IF [%1]==[] GOTO :NOPERMUTATIONID

%MSBuildExe% Sp.Samples.BuildIntegration\Sp.Samples.BuildIntegration/Sp.Samples.BuildIntegration.csproj /t:ConfigurePermutationInfo /p:SlpsRuntimePermutationId=%1
%MSBuildExe% Sp.Samples.BuildIntegration\Sp.Samples.BuildIntegration.Library/Sp.Samples.BuildIntegration.Library.csproj /t:ConfigurePermutationInfo /p:SlpsRuntimePermutationId=%1
IF ERRORLEVEL 1 GOTO :ERROR

echo Sp.Samples.BuildIntegration has been configured for use with Software Potential permutation %1.


echo If you have your solution open in Visual Studio 2010, please Close and re-open it now (Visual Studio caches .targets files that were modified during this operation)
GOTO :EOF

:NOPERMUTATIONID
ECHO Usage: %0 ^<PermutationId^>
ECHO Example: %0 12a87dc3-09a4-ff31-8a22-235f87a09ce9
GOTO :EOF

:NODOTNET
ECHO Error: Could not locate MSBuild. Looked in %DotNetDir%
GOTO :EOF

:ERROR
ECHO ON
EXIT /b %ERRORLEVEL%

:EOF