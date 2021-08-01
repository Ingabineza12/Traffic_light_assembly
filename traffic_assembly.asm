; Blinking LED in assembly
    
STATUS	equ 03h ; for selecting BANK
RP0	equ 05h
RP1	equ 06h
PORTC	equ 07h ;BANK0
TRISC	equ 87h ;BANK1
 
COUNTER	    equ 20h ;the counter for our delay loop
 
 ;use directive to force the program to start at reset vector : 00h
 
 org 00h ; the program start from here
 
 clrw ;clear the W register
 
;selecting BANK0
 
 BCF STATUS, RP0; RP0 = 0
 BCF STATUS, RP1; RP1 = 0
 
 CLRF PORTC ;initialise PORTC
 
; switch to bank1 for TRISC register 
 
 BSF STATUS, RP0 ;RPO=1
 
;Next make sure that all pins in PORTC are output
 
 MOVLW 0x00 ;clear w register
 
 MOVWF TRISC ;set PORTC as output
 
 ;back to bank0 for working with PORTC
 
 BCF STATUS, RP0; RP0 = 0
 BCF STATUS, RP1; RP1 = 0
 
 ;Now let us turn on pins at PORTC
 
 
START	MOVLW b'00000001' ;0x01  RC0
	MOVWF PORTC ; turn ON  first LED  PORTC
	;delay
	MOVLW  0xff ; or  b'11111111' decimal 255 
	MOVWF COUNTER    ;set counter to 0xff or load the counter with 255
	
LOOP1	DECFSZ COUNTER, 1;substract 1 from 255
	GOTO	LOOP1     ;if counter is zero then carry on
	
	MOVLW b'00000100' ;load the W with 0x03 
	MOVWF PORTC    ;Turn ON second LED on PORTC
	;delay
	MOVLW  0xff ;  or b'11111111'
	MOVWF COUNTER    ;set counter to 0xff	

LOOP2	DECFSZ COUNTER, 1 ;substract 1 from 255
	GOTO	LOOP2     ;if counter is zero then carry on
	
	MOVLW b'00001000'  ; load the W with 0x04 
	MOVWF PORTC    ;Turn ON third LED on PORTC
	;delay
	MOVLW    0xff ; or b'11111111' 
	MOVWF COUNTER    ;set counter to 0xff	
	

LOOP3   DECFSZ COUNTER, 1 ;substract 1 from 255
	GOTO	LOOP3     ;if counter is zero then carry on
	
	GOTO START
	
	END
	

 





