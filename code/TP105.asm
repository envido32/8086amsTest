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
	txtIn:db 0Ah,"Ingrese numeros... ",0Ah,"$"
	txtOut:db 0Ah,"La cantidad de numeros pares ingresados son: ","$"
	key db 0 		; Char para el teclado
	cont db 0		; Contador de pares
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
; Ej. 5) 
; Escribir un programa que imprima por pantalla
; el mensaje “Ingrese numeros”, luego que imprima 
; la cantidad de numeros pares ingresados por teclado. 
; Imprimiendo por pantalla un mensaje como el siguiente 
; “La cantidad de números pares ingresados son:” 
; [Máximo 9 números].
; ================================================
; Arranca el programa 
; ================================================

	mov CX,9		; Init Counter usado por loop
	mov DX,offset txtIn 	; Cargo el texto
	mov AH,9 		; Imprime en pantalla
	int 21h			; Funcion DOS 

ciclo:	mov AH,1		; Lee teclado
	int 21h			; Funcion DOS
	mov key,AL		; Guardo el char del teclado en key
	sub key,30h		; ASCII to Num
	and key,1
	jp par
vuelve:	loop ciclo
	jmp cierre

; ================================================
; Llamadas y saltos
; ================================================

par:	inc cont
	jmp vuelve

cierre:	mov DX,offset txtOut 	; Cargo el texto
	mov AH,9 		; Imprime en pantalla
	int 21h			; Funcion DOS 

	add cont,30h		; Num to ASCII
	mov DL,cont		; Cargo el dato
	mov AH,2 		; Imprime en pantalla
	int 21h			; Funcion DOS 

; ================================================
; Termina el programa 
; ================================================

	mov AH,4Ch 	; Funcion DOS: Cierre del programa
	int 21h		; Llama a la funcion de DOS
codigo ENDS
	end inicio