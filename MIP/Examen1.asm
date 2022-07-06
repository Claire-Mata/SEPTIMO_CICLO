include mip115.lib
cpila 100h;recibe un tamanio que se va a reservar en la memoria del computador

;segmento de datos
datos SEGMENT 
    blanc db 11110001b,"$"    
    hack db 10011010b,"$" 
    texto db "Opciones","$" 
    text2 db "A-mostrar tecla","$"  
     text3 db "b-about me","$"
    nombre1 DB 0AH, 0DH, "    "
            DB 0AH, 0DH, "    -----------------------------------------------------------"
            DB 0AH, 0DH, "    |                                                         |"
            DB 0AH, 0DH, "    |                                                         |"
            DB 0AH, 0DH, "    |                        MIP115                           |"
            DB 0AH, 0DH, "    |                                                         |"
            DB 0AH, 0DH, "    ___________________________________________________________ ","$"  
tecla db "escriba una letra en mayuscula","$" 
ale db "ALEJANDRA CLAIRE AGUILAR MATA","$" 
letrero1 db "BIOS FABRICADA PARA MIP115","$" 
nombre DB 0AH, 0DH, "         "
            DB 0AH, 0DH, "    -----------------------------------------------------------"
            DB 0AH, 0DH, "    |                                                         |"
            DB 0AH, 0DH, "    |     创   创    创     创     创    创      创    创     | "
            DB 0AH, 0DH, "    |                                                         |"
            DB 0AH, 0DH, "    |                                                         |"
            DB 0AH, 0DH, "    |                                                         |"
            DB 0AH, 0DH, "    |       创    创    创     创     创     创     创        |"
            DB 0AH, 0DH, "    |                                                         |"
            DB 0AH, 0DH, "    |                                                         |"
            DB 0AH, 0DH, "    |                                                         |"
            DB 0AH, 0DH, "    |   创   创创创创创创创创创创创创创创创创创        创     |"
            DB 0AH, 0DH, "    ___________________________________________________________ ","$" 


A db "A","$"
B db "B","$"
C db "C","$"
D db "D","$"
E db "E","$"
F db "F","$"
G db "G","$"
H db "H","$"
I db "I","$"
J db "J","$" 
K db "K","$"

datos ENDS



;segmento de codigo
codigo SEGMENT
    ;coloca direcciones en cada uno de los segmentos
    assume CS:codigo,DS:datos,SS:pila 
    
;procedimiento principal
principal proc 
    iniseg 
   ;cuadro XI,YI,XF,YF                                      
 cuadro 0,0,79,24,hack
 
 ;XI es el incio de x y el XF es el final
 ;lo mismo va YI y YF      
       
                  
 ;2 lineas en y con ancho x cada una
 
 ;bloque XI,XF,Y1,Y2         
 bloque 35,36,0,37,blanc  
 bloque 1,79,1,80,blanc
 bloque 1,79,1,80,blanc 
 bloque 1,79,1,80,blanc
 xycursor 0,4
 imprime nombre  
       
 xycursor 25,13
; imprime texto 
                      
 esperar 
 
  menu:
   clearS
   ;cuadro XI,YI,XF,YF                                      
 cuadro 0,0,79,24,hack
 
 ;XI es el incio de x y el XF es el final
 ;lo mismo va YI y YF      
       
                  
 ;2 lineas en y con ancho x cada una
 
 ;bloque XI,XF,Y1,Y2         
 ;bloque 1,79,4,4,blanc  
 
 xycursor 0,0
 imprime nombre1
       
 xycursor 25,13
 imprime texto
 xycursor 28,14
 imprime text2 
 xycursor 31,15
 imprime text3 
 xycursor 31,15
  
    mov ah,01h;solicito un caracter
        int 21h 
     
    cmp     al, 'A'    ;A
	je MostrarTecla	  
	cmp     al, 'a'    ;A
	je MostrarTecla	
	 cmp     al, 'b'    ;A
	je SobreMi
	 cmp     al, 'B'    ;A
	je SobreMi	
								
    
	;jmp jugar 
      
      MostrarTecla:
      clearS 
      
        mov ah,09h
        lea dx,tecla
        int 21h
        
      
    mov ah,01h;solicito un caracter
        int 21h 
    cmp     al, 'A'    ;A
	je A2
    cmp     al, 'B'    ;izq
	je B2								
    cmp     al, 'C'    ;izq
	je C2	
    cmp     al, 'D'    ;izq
    je D2
    cmp     al, 'E'    ;progreso
	je E2							
    cmp     al, 'F'    ;izq
	je F2									
    cmp     al, 'G'    ;izq
    je G2	
      cmp     al, 'H'    ;izq
    je H2
	cmp     al, 'I'    ;progreso
    je I2					
    cmp     al, 'J'    ;izq
	je J2								
    cmp     al, 'K'    ;izq
	je K2	
        
       A2: 
       clearS 
      
        mov ah,09h
        lea dx,A
        int 21h
        esperar  
         loop menu 
                
                 B2: 
       clearS 
      
        mov ah,09h
        lea dx,B
        int 21h
         esperar  
         loop menu
       
        C2: 
       clearS 
      
        mov ah,09h
        lea dx,C
        int 21h
         esperar  
         loop menu
       
        D2: 
       clearS 
      
        mov ah,09h
        lea dx,D
        int 21h
         esperar  
         loop menu
       
        E2: 
       clearS 
      
        mov ah,09h
        lea dx,E
        int 21h 
         esperar  
         loop menu
       
        F2: 
       clearS 
      
        mov ah,09h
        lea dx,F
        int 21h 
         esperar  
         loop menu
       
        G2: 
       clearS 
      
        mov ah,09h
        lea dx,G
        int 21h
         esperar  
         loop menu 
        
         H2: 
       clearS 
      
        mov ah,09h
        lea dx,H
        int 21h 
         esperar  
         loop menu
               
               I2: 
       clearS 
      
        mov ah,09h
        lea dx,I
        int 21h 
         esperar  
         loop menu
        
        J2: 
       clearS 
      
        mov ah,09h
        lea dx,J
        int 21h 
         esperar  
         loop menu
       
        K2: 
       clearS 
      
        mov ah,09h
        lea dx,K
        int 21h 
         esperar  
         loop menu
        
     SobreMi:
       clearS 
       mov ah,09h
        lea dx,letrero1
        int 21h  
         xycursor 4,4
       mov ah,09h
        lea dx,ale
        int 21h
        bloque 1,32,8,8,blanc 
        esperar 
        loop menu
        
        
    
principal endp    
codigo ENDS
end principal;se hace esto por convencion