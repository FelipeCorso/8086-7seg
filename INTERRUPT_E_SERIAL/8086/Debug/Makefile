###############################################################################
# Makefile for project 
###############################################################################

## General options
PROJECT = 
MCU = 8086
COMPILER = "MASM32"
TARGET = Debug
SHELL = C:\WINDOWS\system32\cmd.exe

## Tools general options
ASMFLAGS=/c /Zd /Zi
LDFLAGS=/CODEVIEW

## Processing Tools
ASM=ml.exe
LD=link16.exe
#  D:/Dados Didho/Faculdade/Ciências da Computação/2016-02/Arquitetura de Computadores II/8086-7seg/INTERRUPT_E_SERIAL/8086/Debug/Debug.exe: TOOL=LD

# Build tree:
all:	Debug

Debug:	Debug.exe

Debug.exe:	
	$(LD) $(LDFLAGS) %INFILE%,Debug.exe,nul.map,,,

# tidy - delete all temporary files which are not involved in the target generation
tidy:

# cleanup - delete all generated files
clean:	tidy
