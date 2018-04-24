; ================================================
; Universidad Tecnologica Nacional
; Facultad Regional Avellaneda
; ================================================
; Catedra: Tecnicas Digitales 3
; Docente: Ing. Ricardo Calabria
; Ayudante: Ing. Ariel Martin
; Alumno: Manuel Cajide Maidana
; Contacto: manuel.cajide.maidana@ieee.org
; ================================================
; Inicializacion
; ================================================

datos SEGMENT			; Creo el segmento de Datos
	segDatos:db 256 dup (?) ; Reservo el espacio
	txtIn:db 0Ah,"Ingrese un numero del 1 al 9...",0Ah,"$"
	txtOut:db 0Ah,"Ingreso el numero: ","$"
	key db 0 		; Char para el teclado
datos ENDS			; Uso ? para no iniciarlo con un valor expecifico

extra SEGMENT			; Creo el segmento Extra
extra ENDS

pila SEGMENT stack		; Creo el segmento de Pila
	dw 128 dup(?)		; Reservo el Espacio
tope label word			; Identifico el tope
pila ENDS

codigo SEGMENT			; Asociacion de registros de segmento
	ASSUME DS:datos,ES:extra,SS:pila,CS:codigo

inicio: mov AX,datos
	mov DS,AX
	mov AX,extra
	mov ES,AX
	mov AX,pila
	mov SS,AX
	mov SP,offset tope

; ================================================
; TP1 Sistema 80x86: Modo Real
; Ej. 3) 
; Se desea un programa que emita por pantalla: 
; "Ingrese un numero de 1 al 9.".
; Además que emita por pantalla: 
; “Usted ha ingresado el número:”.
; ================================================
; Arranca el programa 
; ================================================

	mov CX,10		; Init Counter usado por loop
ciclo:	mov DX,offset txtIn 	; Cargo el texto
	mov AH,9 		; Imprime en pantalla
	int 21h			; Funcion DOS 

	mov AH,1		; Lee teclado
	int 21h			; Funcion DOS
	mov key,AL		; Guardo el char del teclado en key

	mov DX,offset txtOut 	; Cargo el texto
	mov AH,9 		; Imprime en pantalla
	int 21h			; Funcion DOS 

	mov DL,key		; Cargo el char
	mov AH,2 		; Imprime en pantalla
	int 21h			; Funcion DOS 
	loop ciclo

; ================================================
; Termina el programa 
; ================================================

	mov AH,4Ch 	; Funcion DOS: Cierre del programa
	int 21h		; Llama a la funcion de DOS
codigo ENDS
	end inicio