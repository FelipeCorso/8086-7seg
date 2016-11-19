;PROGRAMA PRINCIPAL

;1.	Definir o formato em que o Alarme vai trabalhar ( BCD )
;2.	Perguntar a Hora do Alarme
;3.	Ler a Hora do Alarme
;4.	Converter a Hora introduzida pelo utilizador para BCD
;5.	Acrescentar a Hora do Alarme ao Real Time Clock
;6.	Repetir os passos 2,3,4 e 5 novamente mas agora correspondentes aos minutos
;7.	Definir os segundos do Alarme
;8.	Garantir que o Interrupt MAsk Register não está mascarado
;9.	Tornar o programa Residente

;ROTINA DO INTERRUPT
;1.	Definir 1 ponteiro de leitura
;2.	Definir 1 ponteiro de escrita
;3.	Ler o carácter do ponteiro de leitura
;4.	Comparar com “$”
;5.	Se não for igual
;6.	Escrever o carácter no ponteiro de escrita
;7.	Actualizar o ponteiro de escrita
;8.	actualizar o ponteiro de leitura
;9.	Voltar ao passo 3
;10.	Se for igual “$” então Terminar

.386
cseg segment use16
main proc far
assume cs:cseg
mov dx,offset int4a
mov ax, seg int4a
mov ds,ax
mov ah,25h
mov al,4ah
int 21h ;;coloca o endereço da rotina int4a no vector de interrupt 4AH
;DEFENIR O FORMATO A TRABALHAR (BCD)
mov al,0bh
out 70H,al
in al,71h
and al,11111011B
out 71H,al


Aqui neste passo, vou querer trabalhar com o formato BCD. Então para que isso aconteça, terei de colocar no Status B no bit 2 o valor de zero. Para isso utilizei o AND al, 11111011B porque:




;PERGUNTAR A HORA DO ALARME
mov ah,1 ;;Fica a espera que o utilizador prime numa tecla
int 21H
sub al,'0' ;;Converte o codigo ASCII em binario
mov bl,al ;;Coloca o valor de al no bl
shl bl,4 ;;Converte o codigo binario para BCD
mov ah,1 ;;Fica a espera que prime outra tecla
int 21H
sub al,'0'
add bl,al ;; 12 d = 0001 0010 bcd

;Acrescentar a Hora ao Real Time Clock
mov al,05H
out 70H,al ;;Coloquei a hora do formato BCD no
mov al,bl ; ;Real Time Clock corresondente as
out 71H,al ;; horas do Alarme = 05H
;Perguntar os Minutos do Alarme
mov ah,1 ;;Fica a espera que o utilizador prime numa tecla
int 21H
sub al,'0' ;;Converte o codigo ASCII em binario
mov bl,al	;;Coloca o valor de al no bl
shl bl,4 ;:Converte o codigo binario para BCD
mov ah,1 ;;Fica a espera que prime outra tecla
int 21H
sub al,'0'
add bl,al ;; 12 d = 0001 0010 bcd

;Acrescentar os minutos ao Real Time Clock
mov al,03H
out 70H,al ;;Coloquei os minutos do formato BCD no
mov al,bl ;; Real Time Clock corresondente as
out 71H,al ;; horas do Alarme = 05H

;Defenir os Segundos do Alarme
mov bl,00000000

;Neste ultimo caso, o codigo BCD de 0 e igual ao binario

;Acrescentar os segundos ao Real Time Clock
mov al,01H
out 70H,al ;;Coloquei os segundos do formato BCD no
mov al,bl ;; Real Time Clock corresondente as
out 71H,al ;; horas do Alarme = 01H

;Colocar o Bit 5 do Status B a 1
mov al,0bH
out 70H,al ;; Activamos o Interrupt do Alarme
in al,71H
mov al,00100010B
out 71H,al

;IR ao Interrupt Mask Register e garantir k nao esta MASCARADO IRQ8 =A1H
in al,0a1h
and al,11111110B
out 0a1h,al

mov dx,zseg
mov ax,es
sub dx,ax ;;determina o numero de paragrafos para deixar em memoria
mov ah,31h
int 21h ;:termina o programa deixando o residente em memoria
main endp


; Definir a Mensagem de Alerta
mesg db 'ALARME!! ALARME!! ALARME!! ALARME!!$'

int4a proc far ; rotina de atendimento ao interrupt
push ax
push bx
push cx
push di
push es ;;faz o push de todos os registos que utiliza
;Activar o SOM BEEEEEEEPPPPPP
in al, 061H
and al,11111110b 
out 061H,al

;Definir um ponteiro de leitura
mov ax,0B800H
mov es,ax
mov di,0
;Definir um ponteiro de escrita
mov ax,seg mesg
mov ds,ax
mov si,offset mesg
;Ler o character do ponteiro de leitura
Lb2: mov al,ds:[si]
;Comparar com ‘$’
Cmp al,’$’
;Se não for igual Escreve o carácter no ponteiro de escrita
JE Fim
mov es:[di],al
;Actualizar o ponteiro de escrita e de leitura
inc si
add di,2
jmp Lb2
; Se for igual ao dólar terminar
Fim: pop es
pop di
pop cx
pop bx
pop ax ;; restaura todos os registos usados
iret ; ;termina a rotina de interrupt
int4a endp
cseg ends
zseg segment use16
zseg ends ; ;segmento para calcular o tamanho do programa
end