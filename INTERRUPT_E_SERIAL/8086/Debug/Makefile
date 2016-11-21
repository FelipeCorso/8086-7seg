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
#     D:/Dados Didho/Faculdade/Ciências da Computação/2016-02/Arquitetura de Computadores II/8086-7seg/INTERRUPT_E_SERIAL/8086/Debug/io.obj: TOOL=ASM
#        D:/Dados Didho/Faculdade/Ciências da Computação/2016-02/Arquitetura de Computadores II/8086-7seg/INTERRUPT_E_SERIAL/8086/io.asm

# Build tree:
all:	Debug

Debug:	Debug.exe

Debug.exe:	io.obj 
	$(LD) $(LDFLAGS) io.obj,Debug.exe,nul.map,,,

io.obj:	../io.asm 
	$(ASM) $(ASMFLAGS) ../io.asm

# tidy - delete all temporary files which are not involved in the target generation
tidy:

# cleanup - delete all generated files
clean:	tidy
	rm -rf Debug.exe
	rm -rf io.obj
