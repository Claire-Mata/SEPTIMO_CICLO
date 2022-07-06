INCLUDE MIP115.INC
INCLUDE MACROS.INC
includelib winmm.lib
TAMANIO_BUFFER=1000
.data
txtRegre BYTE "Deseas regresar AL MENU(R/n) : ",0
txtErrorOpc BYTE "Ingrese una opcion valida",0
ColorFrenteJugadorPrincipal	BYTE	white		;0Fh
regresar BYTE ?
puntaje byte "0",0dh,0ah
bufferTamanio DWORD ($-puntaje)
error BYTE "no se puede abrir el archivo",0dh,0ah,0
archivo_lista4 BYTE "historia.txt",0
verificar BYTE 1
nombrearchivo BYTE "puntaje.txt",0
manejadorArchivo HANDLE ?
buffer BYTE TAMANIO_BUFFER DUP(0)
stringLength DWORD ? ;alvergar el tamnio de caracteres
xPos BYTE 0
yPos BYTE 29
xPremioPos BYTE 15
yPremioPos BYTE 15
entrada BYTE ?
fondo BYTE " "
fondoColor DWORD (lightblue*16)+lightblue
LimitePantallaIzquierda BYTE 0
pantallaLimiteDerecho BYTE 79
SalirBandera BYTE 0
ColorFrenteMascara BYTE 0Fh
.code
main proc
menu:
    call clrscr ; limpia pantalla
	mWrite<"PARCIAL 2 AM19089",0dh,0ah,0dh,0ah>
    mWrite<"1 - Jugar",0dh,0ah,"2 - Historia",0dh,0ah,"3 - Puntaje",0dh,0ah>
    mWrite<"4 - Salir",0dh,0ah,0dh,0ah>
    mWrite <"Ingrese una opcion: ">
    mov eax,0
    call readdec;LEEMOS
    cmp al,1;COMPARAMOS
    je siguiente
    cmp al,2;COMPARAMOS
    je siguiente2
    cmp al,3;COMPARAMOS
    je siguiente3
    cmp al,4;COMPARAMOS
    je salir
    call errorOpc
    mov eax,3000
    call Delay;demora
    jmp menu
    siguiente:
	call jugar
    siguiente2:
	call historia
    siguiente3:
		mWrite<"puntaje:",0>
		mov edx, offset nombrearchivo
		call leer_archivo
    mov dl,0        ;Posicion x
    mov dh,28        ;Posicion y
    call Gotoxy        ;Establecer ubicacion
    mov edx,OFFSET txtRegre    ;Texto a imprimir
    call WriteString        ;Impresion
    ; Obtiene la tecla que presiona el usuario
    call ReadChar
    mov regresar,al
    cmp regresar,"R"
    je menu
    cmp regresar,"n"
    je salir
    call errorOpc
    ;jmp opc3
    salir:
    call Clrscr ;Limpiar pantalla
    exit
main endp
errorOpc PROC
    mov dl,0        ;Posicion x
    mov dh,29        ;Posicion y
    call Gotoxy        ;Establecer ubicacion
    mov edx,OFFSET txtErrorOpc    ;Texto a imprimir
    call WriteString        ;Impresion
    ret
errorOpc ENDP
historia PROC
mov edx,offset archivo_lista4
	call leer_archivo
	call crlf
ret
historia endp
leer_archivo proc
call OpenInputFile
mov manejadorArchivo,eax
;Verifica errores
cmp eax,INVALID_HANDLE_VALUE ;hay error al abrir el archivo?
jne archivo_correcto ;no: salir
mWrite<"No se puede abrir el archivo">,0dh,0ah>
jmp Salir ;and salir
archivo_correcto:
	;leemos archivo
	mov edx, offset buffer
	mov ecx,TAMANIO_BUFFER
	call ReadFromFile
	jnc verifica_tamanio_buffer ;error al leer el archivo
	mWrite "error de lectura del archivo." 
	call WriteWindowsMsg
	jmp cerrar_archivo
	verifica_tamanio_buffer:
		cmp eax,TAMANIO_BUFFER  ;es suficiente el tamanio del buffer
		jb buffer_tamanio_correcto ;si
		mWrite<"Error: buffer demasiado pequenio para el archivo",0dh,0ah>
		jmp Salir
		buffer_tamanio_correcto:
			mov buffer[eax],0 ;inserta null al final del buffer
	mov edx, offset buffer ;muestra el buffer
	call WriteString
	call Crlf
	cerrar_archivo:
		mov eax,manejadorArchivo
		call CloseFile
	Salir:
		ret
leer_archivo endp
jugar proc
call Clrscr						; limpia pantalla
	call Intro
	call DibujarJugador2
	call DibujarEnemigo
	L0:
	call ReadChar ;lo que ingresa el usuario
						mov entrada,al
						cmp entrada,"x"
						je Exit0 ;si son iguales	
						cmp entrada,"w"
						je MoverArriba
						cmp entrada,"s"
						je MoverAbajo
						MoverArriba:
							mov ecx,1 ;ecx es un contador 
							SaltoLoop:
								call ActualizarJugador
								dec yPos ;decrementamos
								call DibujarJugador2
							loop SaltoLoop
							jmp L0
						MoverAbajo:
							call ActualizarJugador
							inc yPos
							call DibujarJugador2
							jmp L0
	cmp SalirBandera, 1
	je Exit0
	jmp L0
Exit0:
	ret
jugar endp
DibujarJugador2 PROC
	;colocar el cursor
	 mov dl,xPos
	 mov dh,yPos
	 call Gotoxy ;coloca el cursor
	 ;el jugador
	 add al, ColorFrenteJugadorPrincipal; 20h+0Fh=2Fh
	call SetTextColor
	 mov al, "@"
	 call writeChar;impimimos el jugador
	 ret
DibujarJugador2 ENDP
ActualizarJugador PROC
	;colocar el cursor
	 mov dl,xPos
	 mov dh,yPos
	 call Gotoxy ;coloca el cursor
	 mov eax, fondoColor
	call SetTextColor
	 ;el jugador se borra
	 mov al, " "
	 call writeChar;impimimos el espacio en blanco
	 ret
ActualizarJugador ENDP
;INTRO DEL JUEGO
Intro PROC
	pushad
	mov eax, fondoColor
	call SetTextColor
	mov dh, 10
	mov dl, 0
	mov bx, dx
	mov eax, 80
	mov ecx, eax
L1:	
	mov eax, ecx
	mov ecx, 20
L0:
	mov dx, bx	
	call Gotoxy
	mov edx, offset fondo
	call WriteString
	inc bh
	loop L0
	mov bh, 10
	inc bl
	mov ecx, eax
	loop L1
	popad
	ret
Intro ENDP
DibujarEnemigo PROC
	;ponemos el color
	mov eax,yellow(yellow*16)
	call SetTextColor ;establece el color
	;colocar el cursor
	 mov dl,xPremioPos
	 mov dh,yPremioPos
	 call Gotoxy ;coloca el cursor
	 ;el premio
	 add al, ColorFrenteJugadorPrincipal; 20h+0Fh=2Fh
	call SetTextColor
	 mov al, "I"
	 call writeChar;impimimos el premio
	 ret
DibujarEnemigo ENDP
end main