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
	fuente:db 256 dup(0AAh)	; Reservo el espacio
datos ENDS			; Uso ? para no iniciarlo con un valor expecifico

extra SEGMENT			; Creo el segmento Extra
	destino:db 256 dup(0BBh)	; Reservo el espacio
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
; Ej. 2) 
; Se tiene en el segmento de datos 0,1,2....FF, 
; transferirlo al segmento extra de datos utilizando 
; instrucciones de manejo de cadenas.
; ================================================
; Arranca el programa 
; ================================================

; Transfiero al extra usando cadenas
	mov SI,offset fuente 	; Cargo en Source Index la fuente
	mov DI,offset destino 	; Cargo en Destiny Index el destino
	mov CX,256	; Init Ctrl usado por rep
	rep
	movsb		; Move Standard Byte. Usa SI -> DI.

; ================================================
; Termina el programa 
; ================================================

	mov AH,4Ch 	; Funcion DOS: Cierre del programa
	int 21h		; Llama a la funcion de DOS
codigo ENDS
	end inicio