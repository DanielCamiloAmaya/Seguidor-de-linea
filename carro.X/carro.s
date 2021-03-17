; *****************************************************************************
;                                                                             *
;   __      __  _____ __________________________ _____________________        *
;  /  \    /  \/  _  \\______   \_   _____/  _  \\______   \_   _____/        *
;  \   \/\/   /  /_\  \|       _/|    __)/  /_\  \|       _/|    __)_         *
;   \        /    |    \    |   \|     \/    |    \    |   \|        \        *
;    \__/\  /\____|__  /____|_  /\___  /\____|__  /____|_  /_______  /        *
;         \/         \/       \/     \/         \/       \/        \/         *
;                                                                             *
;******************************************************************************
;   Description                                                               *
;                                                                             *
;									      *
;******************************************************************************
;                                                                             *
;    Filename: seguidor                                                       *
;    Designed by: Daniel Camilo Amaya  2420191010                             *
;		  0scar Rojas Caicedo  2420191009	 		      *	       *
;    Date:  15.03.21                                                          *
;******************************************************************************
;                                                                             *
;    FDEVICE:         P16F877A                                                *
;                                                                             *
;******************************************************************************
PROCESSOR 16F877A
#include <xc.inc>

; CONFIGURATION WORD PG 144 datasheet

CONFIG CP=OFF ; PFM and Data EEPROM code protection disabled
CONFIG DEBUG=OFF ; Background debugger disabled
CONFIG WRT=OFF
CONFIG CPD=OFF
CONFIG WDTE=OFF ; WDT Disabled; SWDTEN is ignored
CONFIG LVP=ON ; Low voltage programming enabled, MCLR pin, MCLRE ignored
CONFIG FOSC=XT
CONFIG PWRTE=ON
CONFIG BOREN=OFF
PSECT udata_bank0

max:
DS 1 ;reserve 1 byte for max

tmp:
DS 1 ;reserve 1 byte for tmp
PSECT resetVec,class=CODE,delta=2

resetVec:
    PAGESEL INISYS ;jump to the main routine
    goto INISYS

PSECT code

INISYS:
    ;Cambio a Banco N1
    BCF STATUS, 6
    BSF STATUS, 5 ; Bank1
   
    ; Modificar TRIS
    BSF TRISC, 0    ; PortC0 <- entrada SA 
    BSF TRISC, 1    ; PortC1 <- entrada SB
    BSF TRISC, 2    ; PortC2 <- entrada SC
    BSF TRISC, 3    ; PortC3 <- entrada SD
    BSF TRISC, 4    ; PortC4 <- entrada SE

    BCF TRISD, 0    ; PortD0 <- salida M1
    BCF TRISD, 1    ; PortD1 <- salida MR1
    BCF TRISD, 2    ; PortD2 <- salida M2
    BCF TRISD, 3    ; PortD3 <- salida MR2
    BCF TRISD, 4    ; PortD2 <- salida L1-IZQ 
    BCF TRISD, 5    ; PortD3 <- salida L2-DER
    BCF TRISD, 6    ; portD4 <- salida DYR
    
    ; Regresar a banco 
    BCF STATUS, 5 ; Bank0

Main:
    
    MOVF PORTC,0
    MOVWF 0X20
    
    ;SA=31
    MOVF   0X20,0
    ANDLW 0b00000001
    MOVWF 0X31
    MOVF  0X31,0
    ANDLW 0b00000001
    MOVWF 0X31
    
    ;SB=32
    MOVF    0X20,0
    ANDLW 0b00000010
    MOVWF 0x32
    RRF   0x32,1
    MOVF  0x32,0
    ANDLW 0b00000001
    MOVWF 0x32
    
    ;SC=33
    MOVF    0X20,0
    ANDLW   0b00000100
    MOVWF   0x33
    RRF	    0x33,1
    RRF	    0x33,1
    MOVF    0x33,0
    ANDLW   0b00000001
    MOVWF   0x33
    
    ;SD=34
    MOVF    0X20,0
    ANDLW  0b00001000
    MOVWF   0X34
    RRF	    0X34,1
    RRF	    0X34,1
    RRF	    0X34,1
    MOVF    0X34,0
    ANDLW   0b00000001
    MOVWF   0X34
    
    ;SE=35
    MOVF    0X20,0
    ANDLW  0b00010000
    MOVWF   0X35
    RRF	    0X35,1
    RRF	    0X35,1
    RRF	    0X35,1
    RRF	    0X35,1
    MOVF    0X35,0
    ANDLW   0b00000001
    MOVWF   0X35
    
     ;SA!=36
    MOVF    0X20,0
    ANDLW   0b00000001
    MOVWF   0X36
    COMF    0X36,1
    MOVF  0X36,0
    ANDLW 0b00000001
    MOVWF 0X36
    
     ;SB!=37
    MOVF    0X20,0
    ANDLW 0b00000010
    MOVWF   0X37
    RRF	    0X37,1
    COMF    0X37
    MOVF    0X37,0
    ANDLW 0b00000001
    MOVWF   0X37
    
    ;SC!=38
    MOVF    0X20,0
    ANDLW 0b00000100
    MOVWF   0X38
    RRF	    0X38,1
    RRF	    0X38,1
    COMF    0X38
    MOVF    0X38,0
    ANDLW 0b00000001
    MOVWF   0X38
    
    ;SD!=39
    MOVF    0X20,0
    ANDLW 0b00001000
    MOVWF   0X39
    RRF	    0X39,1
    RRF	    0X39,1
    RRF	    0X39,1
    COMF    0X39
    MOVF    0X39,0
    ANDLW 0b00000001
    MOVWF   0X39
      
    ;SE!=40
    MOVF    0X20,0
    ANDLW 0b00010000
    MOVWF   0X40
    RRF	    0X40,1
    RRF	    0X40,1
    RRF	    0X40,1
    RRF	    0X40,1
    COMF    0X40
    MOVF    0X40,0
    ANDLW 0b00000001
    MOVWF   0X40
    
;INICIO
; Operaciones
    
; SC! & SE
    MOVF  0X38,0
    ANDWF 0X35,0
    MOVWF 0X41
    
; SC & SD!
    MOVF  0X33,0
    ANDWF 0X39,0
    MOVWF 0X42
    
; SA & SB!
    MOVF  0X31,0
    ANDWF 0X37,0
    MOVWF 0X43
;(SC! & SE) + (	SC & SD!)
    MOVF  0X41,0
    IORWF 0X42,0 
    MOVWF 0X44   
    
    ; M1: (SC! & SE) + (SA & SD!) + (SA & SB!)
    MOVF  0X43,0
    IORWF 0X44,0
    MOVWF 0X45   
    
;-----------------------------------------------------------------------------

    ; SD & SE!
    MOVF  0X34,0
    ANDWF 0X40,0
    MOVWF 0X46   
    
     ; SB & SC! 
    MOVF  0X32,0
    ANDWF 0X38,0
    MOVWF 0X47
    
    ;(SD & SE!) + (SB & SC! )
    MOVF 0x46,0
    IORWF 0x47,0
    MOVWF 0x48
    
    ;SA & SC!
    MOVF 0x31,0
    ANDWF 0x38,0
    MOVWF 0x49
	
; M2:  (SD & SE!) + (SB & SC! ) + (SA & SC!)
    MOVF  0X48,0
    IORWF 0X49,0
    MOVWF 0X50      
    
;--------------------------------------------------------------------------
    
  
    
    ;MR1: SA! & SB! & SC! & SE! 
    MOVF  0X36,0
    ANDWF 0X37,0
    ANDWF 0X38,0
    ANDWF 0X40,0
    MOVWF 0X51
   
  
    
	
    
;--------------------------------------------------------------------------
 
    
    ; MR2: SA! & SB! & SC! & SD! 
    MOVF  0X36,0
    ANDWF 0X37,0
    ANDWF 0X38,0
    ANDWF 0X39,0
    MOVWF 0X54
    
   
    
    
;-----------------------------------------------------------------

  
 ; LED1-IZQ:(SB & SC!) + (SD & SE!)
 MOVF 0x47,0
 IORWF 0x46,0
 MOVWF 0x55

    
;-----------------------------------------------------------------
    
    ;LED2-DER: (SC! & SE) + (SC & SD!)
    MOVF  0X41,0
    IORWF 0X42,0
    MOVWF 0X56

;-----------------------------------------------------------------
    
    ;SD & SE
    MOVF  0X34,0
    ANDWF 0X35,0
    MOVWF 0X57
    
    ;SA! & SB! & SC! & SD! & SE!
    MOVF  0X36,0
    ANDWF 0X37,0
    ANDWF 0X38,0
    ANDWF 0X39,0
    ANDWF 0X40,0
    MOVWF 0X58
    
    ;DYR: SC1 & SC2+SA! & SB1! & SB2! & SC1! & SC2!
    MOVF  0X57,0
    IORWF 0X58,0
    MOVWF 0X59
    
;-----------------------------------------------------------------

    CLRF    PORTD
    BTFSC 0X45,0	;M1
    BSF PORTD,0		
    
    BTFSC 0X51,0	;MR1
    BSF PORTD,1		
    
    BTFSC 0X50,0	;M2
    BSF PORTD,2		
    
    BTFSC 0X54,0	;MR2
    BSF PORTD,3		
    
    BTFSC 0X55,0	;LED1-IZQ
    BSF PORTD,4		
    
    BTFSC 0X56,0	;LED2-DER
    BSF PORTD,5		
    
    BTFSC 0X59,0	;DYR
    BSF PORTD,6		
 
GOTO Main
END


