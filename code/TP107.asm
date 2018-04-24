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
	txtIn:db 0Ah,"Precione numeros. Se contaran los que cumplan: N>6, N<3 y N!=9.",0Ah,"Para finalizar el conteo precione ENTER. ",0Ah,"$"
	txtOut:db 0Ah,"Cantidad de numeros con las caracteristicas pedidas: ","$"
	key db 0 		; Char para el teclado
	cont db 0		; Contador teclas A, B o C
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
; Ej. 7) 
; Desarrollar un programa que cuente y emita por 
; pantalla la cantidad teclas numéricas ingresadas 
; que cumplan con la siguiente condición: el número
; debe ser mayor que 6, menor que 3 y no puede ser el 9.
; El conteo se debe hacer antes de ingresar el ENTER (0Dh).
; La rutina que cuenta las teclas numéricas (máx. 9)
; es una lejana (librería pública) que se llamara Sxxx2.
; ================================================
; Arranca el programa 
; ================================================

	mov DX,offset txtIn 	; Cargo el texto
	mov AH,9 		; Imprime en pantalla
	int 21h			; Funcion DOS 

ciclo:	mov AH,1		; Lee teclado
	int 21h			; Funcion DOS
	mov key,AL		; Guardo el char del teclado en key
	cmp key,0Dh		; Compara con ENTER
	jz cierre		; Cierra si es ENTER
	cmp key,'0'		; Compara con 0
	jl ciclo		; Ignora si no es numero
	cmp key,'9'		; Compara con 9
	jge ciclo		; Ignora si es 9 o no es numero
	cmp key,'6'		; Compara con 6
	jg suma			; Suma si N>6
	cmp key,'3'		; Compara con 3
	jl suma			; Suma si N<3
	jmp ciclo		; Ciclo infinito

; ================================================
; Llamadas y saltos
; ================================================

suma:	inc cont
	jmp ciclo

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
