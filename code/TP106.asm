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
	txtIn:db 0Ah,"Precione teclas. Para finalizar el conteo precione ENTER. ",0Ah,"$"
	txtOut:db 0Ah,"La cantidad de letras A, B o C ingresadas son: ","$"
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
; Ej. 6) 
; Desarrollar un programa que cuente la cantidad de 
; veces que se ingresan por teclado las letras 
; “a, b y c” alfabéticas pulsadas antes de presionar
; "ENTER". Deberá emitir el mensaje "la cantidad de 
; letras a, b ó c ingresadas son:" e imprimir la cantidad.
; [Se aceptará max. 9 teclas, se valorará que sea “n” 
; números ingresados]. 
; La rutina que cuenta los caracteres (máx. 9) es una 
; lejana (librería pública) que se llamará Sxxx2. 
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
	cmp key,'a'		; Compara con A
	jz suma			; Suma si es A
	cmp key,'b'		; Compara con B
	jz suma			; Suma si es B
	cmp key,'c'		; Compara con C
	jz suma			; Suma si es C
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