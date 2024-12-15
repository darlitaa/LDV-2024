@ECHO OFF
timeout 1
cd /d C:\Program Files\Microsoft Visual Studio\2022\Community\VC\Auxiliary\Build
call vcvarsall.bat x86
cd /d D:\study(3sem)\LDV-2024\LDV-2024\ASM
ml /c /coff /Zi Asm.asm
link /OPT:NOREF /DEBUG /SUBSYSTEM:CONSOLE libucrt.lib Asm.obj 
call Asm.exe
timeout 5
cd /d D:\study(3sem)\LDV-2024\LDV-2024\Debug
pause