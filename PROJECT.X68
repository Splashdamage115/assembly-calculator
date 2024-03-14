*-----------------------------------------------------------
* Title      : ASSEMBLY BASED CALCULATOR
* Written by : David Strikaitis, Veronika Syncakova
* Date       : 14/03/2024
* Description:
*-----------------------------------------------------------
      ORG    $1000
START:                ; first instruction of program
  
  * Put program code here
  
*-------------------------------------------------------------------
*
*           GAME LOOP
*
*-------------------------------------------------------------------

LOOP   
       BSR RENDER
       BRA LOOP
  
*-------------------------------------------------------------------
*
*           Render Loop
*
*-------------------------------------------------------------------
RENDER
    ; enable back buffer
    MOVE.B  #94,        D0
    TRAP    #15
    
    BSR DRAW_OUTPUT_FIELD
    BSR DRAW_BUTTON
    RTS
 
 
DRAW_OUTPUT_FIELD
    ; SET PEN STYLE
    MOVE.L  #WHITE,     D1          ; Set PEN color
    MOVE.B  #NORMAL_PEN,     D0     ; SET PEN DRAW TYPE
    TRAP    #15                     ; Trap (Perform action)
  
   ; Set X, Y, Width and Height
   MOVE.L  #OUTPUT_POS_X,   D1      ; X START POS
   MOVE.L  #OUTPUT_POS_Y,   D2      ; Y START POS
    
   MOVE.L  #OUTPUT_POS_X,   D3
   ADD.L   #OUTPUT_WIDTH,   D3      ; Width  (STARTPOSX + WIDTH)
   MOVE.L  #OUTPUT_POS_Y,   D4 
   ADD.L   #OUTPUT_HEIGHT,  D4     ; Height (STARTPOSY + HEIGHT)
     
   ; Draw FIELD
   MOVE.B  #PEN_DRAW,        D0    ; Draw queued pen
   TRAP    #15                     ; Trap (Perform action)
    
   RTS  
 
DRAW_BUTTON
    ; SET PEN STYLE
    MOVE.L  #WHITE,     D1          ; Set PEN color
    MOVE.B  #NORMAL_PEN,     D0     ; SET PEN DRAW TYPE
    TRAP    #15                     ; Trap (Perform action)
  
   ; Set X, Y, Width and Height
   MOVE.L  #BUTTON_POS_X,   D1      ; X START POS
   MOVE.L  #BUTTON_POS_Y,   D2      ; Y START POS
    
   MOVE.L  #BUTTON_POS_X,   D3
   ADD.L   #BUTTON_WIDTH,   D3      ; Width  (STARTPOSX + WIDTH)
   MOVE.L  #BUTTON_POS_Y,   D4 
   ADD.L   #BUTTON_HEIGHT,  D4     ; Height (STARTPOSY + HEIGHT)
     
   ; Draw FIELD
   MOVE.B  #PEN_DRAW,        D0    ; Draw queued pen
   TRAP    #15                     ; Trap (Perform action)
    
   RTS  



SIMHALT             ; halt simulator


* Put variables and constants here

FILL_BOX EQU  81 ; SET PEN TO FILL
NORMAL_PEN EQU  80 ; SET PEN TO NORMAL
PEN_DRAW EQU  87 ; DRAW QUEUED PEN
 
OUTPUT_POS_X EQU 20
OUTPUT_POS_Y EQU 20
OUTPUT_WIDTH EQU 600
OUTPUT_HEIGHT EQU 80

BUTTON_POS_X EQU 20
BUTTON_POS_Y EQU 120
BUTTON_WIDTH EQU 120
BUTTON_HEIGHT EQU 80

CR  EQU  $0D
LF  EQU  $0A
MESSAGE DC.B 'Hello World',CR,LF,0
WHITE           EQU     $00FFFFFF ; A B G R (LEAST SIGNIFICANT)
RED             EQU     $000000FF ; A B G R (LEAST SIGNIFICANT)
     END    START        ; last line of source



*~Font name~Courier New~
*~Font size~10~
*~Tab type~0~
*~Tab size~0~
