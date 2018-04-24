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
	segDatos:db 512 dup(?)	; Reservo el espacio
datos ENDS			; Uso ? para no iniciarlo con un valor expecifico

extra SEGMENT			; Creo el segmento Extra
	segExtra:db 256 dup(?)	; Reservo el espacio
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
; Ej. 1) 
; Escribir un programa que coloque en el segmento 
; de datos de 512 bytes comenzando por el 512 hasta el 0, 
; además el programa debe generar 256 bytes comenzando 
; por el 256 hasta el 0 en el segmento extra de datos.
; ================================================
; Arranca el programa 
; ================================================


; ================================================
; Termina el programa 
; ================================================

	mov AH,4Ch 	; Funcion DOS: Cierre del programa
	int 21h		; Llama a la funcion de DOS
codigo ENDS
	end inicio
