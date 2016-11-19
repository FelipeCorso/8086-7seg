.MODEL	SMALL
; I/O Address Bus decode - every device gets 0x200 addresses */
IO0  EQU  0000h
IO1  EQU  0200h
IO2  EQU  0400h
IO3  EQU  0600h
IO4  EQU  0800h
IO5  EQU  0A00h
IO6  EQU  0C00h
IO7  EQU  0E00h
IO8  EQU  1000h
IO9  EQU  1200h
IO10 EQU  1400h
IO11 EQU  1600h
IO12 EQU  1800h
IO13 EQU  1A00h
IO14 EQU  1C00h
IO15 EQU  1E00h

; 8251A USART 
ADR_USART_DATA EQU  (IO6 + 00h)
;ONDE VOCE VAI MANDAR E RECEBER DADOS DO 8251

ADR_USART_CMD  EQU  (IO6 + 02h)
;É O LOCAL ONDE VOCE VAI ESCREVER PARA PROGRAMAR O 8251

ADR_USART_STAT EQU  (IO6 + 02h)
;RETORNA O STATUS SE UM CARACTER FOI DIGITADO
;RETORNA O STATUS SE POSSO TRANSMITIR CARACTER PARA O TERMINAL

;Numeros
DIG0 = 10111111B ;DEC = 191
DIG1 = 10000110B ;DEC = 134
DIG2 = 11011011B ;DEC = 219
DIG3 = 11001111B ;DEC = 207
DIG4 = 11100110B ;DEC = 230
DIG5 = 11101101B ;DEC = 237
DIG6 = 11111101B ;DEC = 253
DIG7 = 10000111B ;DEC = 135
DIG8 = 11111111B ;DEC = 255
DIG9 = 11101111B ;DEC = 239


.8086
.CODE
   ;assume    CS:code,DS:data
   org 0008h
   PONTEIRO_TRATADOR_INTERRUPCAO DB 4 DUP(?) ; PONTEIRO PARA INTERRUPCAO
   ;APONTA PARA UMA ROTINA CHAMADA A CADA 1 SEGUNDO VIA HARDWARE INTERRUPT
   ;OBSERVE NO 8086 O PINO NMI, ELE ESTA RECEBENDO UM PULSO A CADA UM SEGUNDO, FORÇANDO A INTERRUPÇÃO

   ;RESERVADO PARA VETOR DE INTERRUPCOES
   org 0400h
	  
inicio:
     MOV AX,@DATA
     MOV DS,AX
     MOV AX,@STACK
     MOV SS,AX

ZERA:
    MOV DX, IO0
    MOV AL, DIG0
    OUT DX, AL
    
    MOV DX, IO1
    MOV AL, DIG0
    OUT DX, AL
    
    MOV DX, IO2
    MOV AL, DIG0
    OUT DX, AL
    
    MOV DX, IO3
    MOV AL, DIG0
    OUT DX, AL
    
    MOV DX, IO4
    MOV AL, DIG0
    OUT DX, AL
    
    MOV DX, IO5
    MOV AL, DIG0
    OUT DX, AL
    
    jmp seg_uni_show

seg_uni_plus:
   ; lopop
    JMP seg_uni_plus
    ;inc seg_uni
    ;jmp seg_uni_show

zera_seg_uni:
    mov seg_uni,30h
    inc seg_dez
    jmp seg_dez_show
zera_seg_dez:
    mov seg_dez,30h
    inc min_uni
    jmp min_uni_show
zera_min_uni:
    mov min_uni,30h
    inc min_dez
    jmp min_dez_show
zera_min_dez:
    mov min_dez,30h
    inc hor_uni
    jmp hor_uni_show
zera_hor_uni:
    mov hor_uni,30h
    inc hor_dez
    jmp hor_dez_show 
zera_hor_dez:
    mov hor_dez,30h
    mov hor_uni,30h
    mov min_dez,30h
    mov min_uni,30h
    mov seg_dez,30h
    mov seg_uni,30h
    jmp ZERA

;Verificando que número da unidade dos segundos deve ser exibida
seg_uni_show:
    cmp seg_uni, 30h
    je seg_uni_0
    cmp seg_uni, 31h 
    je seg_uni_1
    cmp seg_uni, 32h 
    je seg_uni_2
    cmp seg_uni, 33h 
    je seg_uni_3
    cmp seg_uni, 34h
    je seg_uni_4
    cmp seg_uni, 35h 
    je seg_uni_5
    cmp seg_uni, 36h 
    je seg_uni_6
    cmp seg_uni, 37h 
    je seg_uni_7
    cmp seg_uni, 38h 
    je seg_uni_8
    cmp seg_uni, 39h
    je seg_uni_9

;Verificando que número da dezena dos segundos deve ser exibida	
seg_dez_show:
    cmp seg_dez, 30h
    je seg_dez_0
    cmp seg_dez, 31h 
    je seg_dez_1
    cmp seg_dez, 32h 
    je seg_dez_2
    cmp seg_dez, 33h 
    je seg_dez_3
    cmp seg_dez, 34h
    je seg_dez_4
    cmp seg_dez, 35h 
    je seg_dez_5
    cmp seg_dez, 36h
    je seg_dez_6

;Verificando que número da unidade dos minutos deve ser exibida
min_uni_show:
    cmp min_uni, 30h
    je min_uni_0
    cmp min_uni, 31h 
    je min_uni_1
    cmp min_uni, 32h 
    je min_uni_2
    cmp min_uni, 33h 
    je min_uni_3
    cmp min_uni, 34h
    je min_uni_4
    cmp min_uni, 35h 
    je min_uni_5
    cmp min_uni, 36h 
    je min_uni_6
    cmp min_uni, 37h 
    je min_uni_7
    cmp min_uni, 38h 
    je min_uni_8
    cmp min_uni, 39h
    je min_uni_9

;Verificando que número da dezena dos minutos deve ser exibida	
min_dez_show:
    cmp min_dez, 30h
    je min_dez_0
    cmp min_dez, 31h 
    je min_dez_1
    cmp min_dez, 32h 
    je min_dez_2
    cmp min_dez, 33h 
    je min_dez_3
    cmp min_dez, 34h
    je min_dez_4
    cmp min_dez, 35h 
    je min_dez_5
    cmp min_dez, 36h
    je min_dez_6

;Verificando que número da unidade das horas deve ser exibida
hor_uni_show:
    cmp hor_uni, 30h
    je hor_uni_0
    cmp hor_uni, 31h 
    je hor_uni_1
    cmp hor_uni, 32h 
    je hor_uni_2
    cmp hor_uni, 33h 
    je hor_uni_3
    cmp hor_uni, 34h
    je hor_uni_4
    cmp hor_uni, 35h 
    je hor_uni_5
    cmp hor_uni, 36h 
    je hor_uni_6
    cmp hor_uni, 37h 
    je hor_uni_7
    cmp hor_uni, 38h 
    je hor_uni_8
    cmp hor_uni, 39h
    je hor_uni_9

;Verificando que número da dezena das horas deve ser exibida
hor_dez_show:
    cmp hor_dez, 30h
    je hor_dez_0
    cmp hor_dez, 31h 
    je hor_dez_1
    cmp hor_dez, 32h 
    je hor_dez_2
    cmp hor_dez, 33h 
    je hor_dez_3
    cmp hor_dez, 34h
    je hor_dez_4
    cmp hor_dez, 35h 
    je hor_dez_5
    cmp hor_dez, 36h
    je hor_dez_6
    
;Mostrando dígitos da unidade dos segundos 0-9 
seg_uni_0:
    MOV DX, IO0
    MOV AL, DIG0
    OUT DX, AL
    jmp seg_uni_plus
seg_uni_1:
    MOV DX, IO0
    MOV AL, DIG1
    OUT DX, AL
    jmp seg_uni_plus
seg_uni_2:
    MOV DX, IO0
    MOV AL, DIG2
    OUT DX, AL
    jmp seg_uni_plus
seg_uni_3:
    MOV DX, IO0
    MOV AL, DIG3
    OUT DX, AL
    jmp seg_uni_plus
seg_uni_4:
    MOV DX, IO0
    MOV AL, DIG4
    OUT DX, AL
    jmp seg_uni_plus
seg_uni_5:
    MOV DX, IO0
    MOV AL, DIG5
    OUT DX, AL
    jmp seg_uni_plus
seg_uni_6:
    MOV DX, IO0
    MOV AL, DIG6
    OUT DX, AL
    jmp seg_uni_plus
seg_uni_7:
    MOV DX, IO0
    MOV AL, DIG7
    OUT DX, AL
    jmp seg_uni_plus
seg_uni_8:
    MOV DX, IO0
    MOV AL, DIG8
    OUT DX, AL
    jmp seg_uni_plus
seg_uni_9:
    MOV DX, IO0
    MOV AL, DIG9
    OUT DX, AL
    jmp seg_uni_plus

;Mostrando dígitos da dezena dos segundos 0-6
seg_dez_0:
    MOV DX, IO1
    MOV AL, DIG0
    OUT DX, AL
    jmp seg_uni_show
seg_dez_1:
    MOV DX, IO1
    MOV AL, DIG1
    OUT DX, AL
    jmp seg_uni_show
seg_dez_2:
    MOV DX, IO1
    MOV AL, DIG2
    OUT DX, AL
    jmp seg_uni_show
seg_dez_3:
    MOV DX, IO1
    MOV AL, DIG3
    OUT DX, AL
    jmp seg_uni_show
seg_dez_4:
    MOV DX, IO1
    MOV AL, DIG4
    OUT DX, AL
    jmp seg_uni_show
seg_dez_5:
    MOV DX, IO1
    MOV AL, DIG5
    OUT DX, AL
    jmp seg_uni_show
seg_dez_6:
    MOV DX, IO1
    MOV AL, DIG6
    OUT DX, AL
    jmp seg_uni_show

;Mostrando dígitos da unidade dos minutos 0-9 
min_uni_0:
    MOV DX, IO2
    MOV AL, DIG0
    OUT DX, AL
    jmp seg_dez_show
min_uni_1:
    MOV DX, IO2
    MOV AL, DIG1
    OUT DX, AL
    jmp seg_dez_show
min_uni_2:
    MOV DX, IO2
    MOV AL, DIG2
    OUT DX, AL
    jmp seg_dez_show
min_uni_3:
    MOV DX, IO2
    MOV AL, DIG3
    OUT DX, AL
    jmp seg_dez_show
min_uni_4:
    MOV DX, IO2
    MOV AL, DIG4
    OUT DX, AL
    jmp seg_dez_show
min_uni_5:
    MOV DX, IO2
    MOV AL, DIG5
    OUT DX, AL
    jmp seg_dez_show
min_uni_6:
    MOV DX, IO2
    MOV AL, DIG6
    OUT DX, AL
    jmp seg_dez_show
min_uni_7:
    MOV DX, IO2
    MOV AL, DIG7
    OUT DX, AL
    jmp seg_dez_show
min_uni_8:
    MOV DX, IO2
    MOV AL, DIG8
    OUT DX, AL
    jmp seg_dez_show
min_uni_9:
    MOV DX, IO2
    MOV AL, DIG9
    OUT DX, AL
    jmp seg_dez_show

;Mostrando dígitos da dezena dos minutos 0-6
min_dez_0:
    MOV DX, IO3
    MOV AL, DIG0
    OUT DX, AL
    jmp min_uni_show
min_dez_1:
    MOV DX, IO3
    MOV AL, DIG1
    OUT DX, AL
    jmp min_uni_show
min_dez_2:
    MOV DX, IO3
    MOV AL, DIG2
    OUT DX, AL
    jmp min_uni_show
min_dez_3:
    MOV DX, IO3
    MOV AL, DIG3
    OUT DX, AL
    jmp min_uni_show
min_dez_4:
    MOV DX, IO3
    MOV AL, DIG4
    OUT DX, AL
    jmp min_uni_show
min_dez_5:
    MOV DX, IO3
    MOV AL, DIG5
    OUT DX, AL
    jmp min_uni_show
min_dez_6:
    MOV DX, IO3
    MOV AL, DIG6
    OUT DX, AL
    jmp min_uni_show

;Mostrando dígitos da unidade das horas 0-9 
hor_uni_0:
    MOV DX, IO4
    MOV AL, DIG0
    OUT DX, AL
    jmp min_dez_show
hor_uni_1:
    MOV DX, IO4
    MOV AL, DIG1
    OUT DX, AL
    jmp min_dez_show
hor_uni_2:
    MOV DX, IO4
    MOV AL, DIG2
    OUT DX, AL
    jmp min_dez_show
hor_uni_3:
    MOV DX, IO4
    MOV AL, DIG3
    OUT DX, AL
    jmp min_dez_show
hor_uni_4:
    MOV DX, IO4
    MOV AL, DIG4
    OUT DX, AL
    jmp min_dez_show
hor_uni_5:
    MOV DX, IO4
    MOV AL, DIG5
    OUT DX, AL
    jmp min_dez_show
hor_uni_6:
    MOV DX, IO4
    MOV AL, DIG6
    OUT DX, AL
    jmp min_dez_show
hor_uni_7:
    MOV DX, IO4
    MOV AL, DIG7
    OUT DX, AL
    jmp min_dez_show
hor_uni_8:
    MOV DX, IO4
    MOV AL, DIG8
    OUT DX, AL
    jmp min_dez_show
hor_uni_9:
    MOV DX, IO4
    MOV AL, DIG9
    OUT DX, AL
    jmp min_dez_show   

;Mostrando dígitos da dezena das horas 0-6
hor_dez_0:
    MOV DX, IO5
    MOV AL, DIG0
    OUT DX, AL
    jmp hor_uni_show
hor_dez_1:
    MOV DX, IO5
    MOV AL, DIG1
    OUT DX, AL
    jmp hor_uni_show
hor_dez_2:
    MOV DX, IO5
    MOV AL, DIG2
    OUT DX, AL
    jmp hor_uni_show
hor_dez_3:
    MOV DX, IO5
    MOV AL, DIG3
    OUT DX, AL
    jmp hor_uni_show
hor_dez_4:
    MOV DX, IO5
    MOV AL, DIG4
    OUT DX, AL
    jmp hor_uni_show
hor_dez_5:
    MOV DX, IO5
    MOV AL, DIG5
    OUT DX, AL
    jmp hor_uni_show
hor_dez_6:
    MOV DX, IO5
    MOV AL, DIG6
    OUT DX, AL
    jmp hor_uni_show  
    
JMP inicio

INICIALIZA_8251:                                     
   MOV AL,0
   MOV DX, ADR_USART_CMD
   OUT DX,AL
   OUT DX,AL
   OUT DX,AL
   MOV AL,40H
   OUT DX,AL
   MOV AL,4DH
   OUT DX,AL
   MOV AL,37H
   OUT DX,AL
   RET

RECEBE_CARACTER:
   PUSHF
   PUSH DX
AGUARDA_CARACTER:
   MOV DX, ADR_USART_STAT
   IN  AL,DX
   TEST AL,2
   JZ AGUARDA_CARACTER
   MOV DX, ADR_USART_DATA
   IN AL,DX
   SHR AL,1
NAO_RECEBIDO:
   POP DX
   POPF
   RET

MANDA_CARACTER:
   PUSHF
   PUSH DX
   PUSH AX  ; SALVA AL   
BUSY:
   MOV DX, ADR_USART_STAT
   IN  AL,DX
   TEST AL,1
   JZ BUSY
   MOV DX, ADR_USART_DATA
   POP AX  ; RESTAURA AL
   OUT DX,AL
   POP DX
   POPF
   RET 
    
.startup
	MOV AX,0000
	MOV DS,AX
	
	MOV WORD PTR PONTEIRO_TRATADOR_INTERRUPCAO, OFFSET INTERRUPT_ONE_SECOND
	MOV WORD PTR PONTEIRO_TRATADOR_INTERRUPCAO + 2, SEG INTERRUPT_ONE_SECOND 

	MOV AX,@DATA
	MOV DS,AX
	MOV AX,@STACK
	MOV SS,AX

	CALL INICIALIZA_8251 

	LEA BX, MSG_INI
	LEA BX, MSG_DESP
	
	CALL ZERA
	
	

PROCURA_0:
	MOV AL, [BX]
	CMP AL, 0
	JE ECOAR
	CALL MANDA_CARACTER
	INC BX
	JMP PROCURA_0

ECOAR:
	CALL RECEBE_CARACTER
	CALL MANDA_CARACTER
	JMP ECOAR

INTERRUPT_ONE_SECOND:
	PUSHF 
	PUSH AX
	PUSH DX
	
	 cmp hor_dez,32h
    jne continua
    cmp hor_uni,34h
    je zera_hor_dez
    continua:
    cmp hor_uni,39h
    je zera_hor_uni
    cmp min_dez,36h
    je zera_min_dez
    cmp min_uni,39h
    je zera_min_uni
    cmp seg_dez,36h
    je zera_seg_dez
    cmp seg_uni,39h
    je zera_seg_uni

	inc seg_uni
	 jmp seg_uni_show
	 
	POP DX
	POP AX
	POPF
	IRET

;MEUS DADOS
.DATA
    seg_uni db 30h
    seg_dez db 30h
    min_uni db 30h
    min_dez db 30h
    hor_uni db 30h
    hor_dez db 30h
    
    MSG_INI  DB "DIGITE O HORARIO INICIAL",13,10,0
    MSG_DESP DB "DIGITE O HORARIO PARA O DESPERTADOR",13,10,0

    seg_uni_des db 00h
    seg_dez_des db 00h
    min_uni_des db 00h
    min_dez_des db 00h
    hor_uni_des db 00h
    hor_dez_des db 00h
    
;MILHA PILHA
.STACK
MINHA_PILHA DW 128 DUP(0) 

END