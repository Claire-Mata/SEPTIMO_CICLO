ExitProcess proto
ReadInt64 proto
ReadString proto
WriteString proto
WriteInt64 proto
WriteHex64 proto
RandomRange proto
Crlf proto
TAMANIO_BUFFER=1000
.data
regresar qword ?
opc QWORD ?
variable QWORD ?
txtErrorOpc BYTE "Ingrese una opcion valida",0
txtRegre BYTE " ", 0ah,0dh,"¿Deseas volver a jugar?  S- Si, N- No : ",0
msj BYTE  "¿Adivina el numero que genere?  ", 0ah,0dh, 0
win BYTE " ", 0ah,0dh,"Ganaste", 0
lose BYTE " ", 0ah,0dh,"Fallaste", 0
.code
main proc
Menu:
	call Crlf
	mov rdx, offset msj
	call WriteString
	mov rcx, 2
	call ReadInt64
	mov opc, rax
	call Crlf
	mov rax,11
    call RandomRange
	mov variable,rax
	call gano
	jmp regre
    jmp menu
	regre:
	mov rdx, offset txtRegre
	call WriteString
	mov rcx, 2
	mov rdx,offset regresar
    call ReadString
    cmp regresar,'S'
    je menu
	cmp regresar,'s'
    je menu
    cmp regresar,'N'
    jmp salir
    salir:
    call Crlf ;Limpiar pantalla
    call ExitProcess
main endp
gano proc
mov rax,variable
call WriteInt64
mov rax, opc
cmp rax, variable
je ganar
perder:
mov rdx, offset lose
call WriteString
jmp salir
ganar:
mov rdx, offset win
call WriteString
jmp salir
salir:
ret
gano endp
end