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
*           adjusting window size
*
*-------------------------------------------------------------------
  MOVE.B #33, D0
  MOVE.L #(600<<16+550), D1 ; setup window size
  TRAP #15
  
*-------------------------------------------------------------------
*
*           ENABLE MOUSE 
*
*-------------------------------------------------------------------
       MOVE.B #60, D0
       TRAP #15
  
*-------------------------------------------------------------------
*
*           GAME LOOP
*
*-------------------------------------------------------------------

GAME_LOOP 
       BSR UPDATE
       BSR RENDER
    
       BRA GAME_LOOP
       
       
*-------------------------------------------------------------------
*
*           UPDATE
*
*-------------------------------------------------------------------
UPDATE
            BSR GET_MOUSE
            RTS
            
            
            
*-------------------------------------------------------------------
*
*           get mouse
*
*-------------------------------------------------------------------
GET_MOUSE
            MOVEQ #61, D0
            MOVE.B #0, D1
            TRAP #15
            
           
            
            MOVE.L D1,D3
            AND.L #$0000FFFF,D1
            MOVE.B #6,D2
            MOVE.B #20,D0
            TRAP #15
            RTS
  
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
    
    ; first line of buttons
    MOVE #0,D6
    MOVE #0,D7
    BSR DRAW_BUTTON
    MOVE #160,D6
    MOVE #0,D7
    BSR DRAW_BUTTON
    MOVE #320,D6
    MOVE #0,D7
    BSR DRAW_BUTTON
    MOVE #480,D6
    MOVE #0,D7
    BSR DRAW_BUTTON
    
    ; SECOND LINE OF BUTTONS
    MOVE #0,D6
    MOVE #100,D7
    BSR DRAW_BUTTON
    MOVE #160,D6
    MOVE #100,D7
    BSR DRAW_BUTTON
    MOVE #320,D6
    MOVE #100,D7
    BSR DRAW_BUTTON
    MOVE #480,D6
    MOVE #100,D7
    BSR DRAW_BUTTON
    
    ; THIRD LINE OF BUTTONS
    MOVE #0,D6
    MOVE #200,D7
    BSR DRAW_BUTTON
    MOVE #160,D6
    MOVE #200,D7
    BSR DRAW_BUTTON
    MOVE #320,D6
    MOVE #200,D7
    BSR DRAW_BUTTON
    MOVE #480,D6
    MOVE #200,D7
    BSR DRAW_BUTTON
    
    ; FOURTH LINE OF BUTTONS
    MOVE #0,D6
    MOVE #300,D7
    BSR DRAW_BUTTON
    MOVE #160,D6
    MOVE #300,D7
    BSR DRAW_BUTTON
    MOVE #320,D6
    MOVE #300,D7
    BSR DRAW_BUTTON
    MOVE #480,D6
    MOVE #300,D7
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
   MOVE.L D6, D1
   MOVE.L D7, D2
   ADD.L   #BUTTON1_POS_X,   D1      ; X START POS
   ADD.L   #BUTTON1_POS_Y,   D2      ; Y START POS
   
   MOVE.L  D1,   D3
   
   ADD.L   #BUTTON1_WIDTH,   D3      ; Width  (STARTPOSX + WIDTH)
   MOVE.L  D2,   D4 
   ADD.L   #BUTTON1_HEIGHT,  D4     ; Height (STARTPOSY + HEIGHT)
     
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

BUTTON1_POS_X EQU 20
BUTTON1_POS_Y EQU 120
BUTTON1_WIDTH EQU 120
BUTTON1_HEIGHT EQU 80

BUTTON2_POS_X EQU 160
BUTTON2_POS_Y EQU 120
BUTTON2_WIDTH EQU 120
BUTTON2_HEIGHT EQU 80

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
