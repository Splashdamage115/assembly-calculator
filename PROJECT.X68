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
* CLEARS TEXT FIELDS
            MOVE.L #0000,D1
            MOVE.B #11,D0
            TRAP #15
            
            MOVEQ #61, D0
            MOVE.B #0, D1
            TRAP #15 // take in the mouse coordinates
            
           MOVE.L D1, A0
           MOVE.L D0, D1
           MOVE.L D1, A1
           * if D1 is not 0, theen button is pressed and d5 = 2
           MOVE.B #4,D2
           MOVE.B #20,D0
           TRAP #15
            
           * coords are stored as #YYYY XXXX
           MOVE.L A0, D1
           MOVE.L D1,D3
           AND.L #$0000FFFF,D1
           MOVE.B #4,D2
           MOVE.B #20,D0
           TRAP #15
            
           MOVE.L #0, D1
           MOVE.L D3,D1
           LSR.L #8,D1
           LSR.L #8,D1
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
    
    
    MOVE #0, A2
    
    ; first line of buttons
    MOVE #0,D6
    MOVE #0,D7
    BSR CHECK_MOUSE
    BSR DRAW_BUTTON
    
    CMP #0, D5
    BEQ CONTINUE7
    MOVE #7, A2
CONTINUE7
    MOVE #0,D5
    
    MOVE #160,D6
    MOVE #0,D7
    BSR CHECK_MOUSE
    BSR DRAW_BUTTON
    
    CMP #0, D5
    BEQ CONTINUE8
    MOVE #8, A2
CONTINUE8
    MOVE #0,D5
    

    MOVE #320,D6
    MOVE #0,D7
    BSR CHECK_MOUSE
    BSR DRAW_BUTTON
    
    CMP #0, D5
    BEQ CONTINUE9
    MOVE #9, A2
CONTINUE9
    MOVE #0,D5
    

    MOVE #480,D6
    MOVE #0,D7
    BSR CHECK_MOUSE
    BSR DRAW_BUTTON
    
    CMP #0, D5
    BEQ CONTINUE11
    MOVE #11, A2
CONTINUE11
    MOVE #0,D5
    

    
    ; SECOND LINE OF BUTTONS
    MOVE #0,D6
    MOVE #100,D7
    BSR CHECK_MOUSE
    BSR DRAW_BUTTON
    
    CMP #0, D5
    BEQ CONTINUE4
    MOVE #4, A2
CONTINUE4
    MOVE #0,D5
    

    MOVE #160,D6
    MOVE #100,D7
    BSR CHECK_MOUSE
    BSR DRAW_BUTTON
    
    CMP #0, D5
    BEQ CONTINUE5
    MOVE #5, A2
CONTINUE5
    MOVE #0,D5
    

    MOVE #320,D6
    MOVE #100,D7    
    BSR CHECK_MOUSE
    BSR DRAW_BUTTON
    
    CMP #0, D5
    BEQ CONTINUE6
    MOVE #6, A2
CONTINUE6
    MOVE #0,D5
    

    MOVE #480,D6
    MOVE #100,D7
    BSR CHECK_MOUSE
    BSR DRAW_BUTTON
    
    CMP #0, D5
    BEQ CONTINUE12
    MOVE #12, A2
CONTINUE12
    MOVE #0,D5
    

    
    ; THIRD LINE OF BUTTONS
    MOVE #0,D6
    MOVE #200,D7
    BSR CHECK_MOUSE
    BSR DRAW_BUTTON
    
    CMP #0, D5
    BEQ CONTINUE1
    MOVE #1, A2
CONTINUE1
    MOVE #0,D5
    

    MOVE #160,D6
    MOVE #200,D7
    BSR CHECK_MOUSE
    BSR DRAW_BUTTON
    
    CMP #0, D5
    BEQ CONTINUE2
    MOVE #2, A2
CONTINUE2
    MOVE #0,D5
    

    MOVE #320,D6
    MOVE #200,D7
    BSR CHECK_MOUSE
    BSR DRAW_BUTTON
    
     CMP #0, D5
    BEQ CONTINUE3
    MOVE #4, A2
CONTINUE3
    MOVE #0,D5
    

    MOVE #480,D6
    MOVE #200,D7
    BSR CHECK_MOUSE
    BSR DRAW_BUTTON
    
    CMP #0, D5
    BEQ CONTINUE13
    MOVE #13, A2
CONTINUE13
    MOVE #0,D5
    

    
    ; FOURTH LINE OF BUTTONS
    MOVE #0,D6
    MOVE #300,D7
    BSR CHECK_MOUSE
    BSR DRAW_BUTTON
    
    CMP #0, D5
    BEQ CONTINUE10
    MOVE #10, A2
CONTINUE10
    MOVE #0,D5
    

    MOVE #160,D6
    MOVE #300,D7
    BSR CHECK_MOUSE
    BSR DRAW_BUTTON
    
    CMP #0, D5
    BEQ CONTINUE14
    MOVE #14, A2
CONTINUE14
    MOVE #0,D5
    

    MOVE #320,D6
    MOVE #300,D7
    BSR CHECK_MOUSE
    BSR DRAW_BUTTON
    
    CMP #0, D5
    BEQ CONTINUE15
    MOVE #15, A2
CONTINUE15
    MOVE #0,D5
    

    
    MOVE #480,D6
    MOVE #300,D7
    BSR CHECK_MOUSE
    BSR DRAW_BUTTON
    
    CMP #0, D5
    BEQ CONTINUE16
    MOVE #16, A2
CONTINUE16
    MOVE #0,D5
    

    
    RTS


*-------------------------------------------------------------------
*
*           draw output field
*
*-------------------------------------------------------------------
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
 
*-------------------------------------------------------------------
*
*           DRAW BUTTON
*
*-------------------------------------------------------------------
DRAW_BUTTON
    ; SET PEN STYLE
    MOVE.L  #WHITE,     D1          ; Set PEN color
    CMP #1, D5
    BNE NOT_YELLOW

    MOVE.L  #YELLOW,     D1  

    CMP #2, D5
    BNE NOT_BLUE
    MOVE.L  #BLUE,     D1  

NOT_BLUE
NOT_YELLOW
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


*-------------------------------------------------------------------
*
*           Check mouse
*
*-------------------------------------------------------------------
CHECK_MOUSE
   * SET X BUTTON POSITION
   MOVE.L D6, D1
   ADD.L #BUTTON1_POS_X,   D1
   
   * SET X MOUSE COORDINATES INTO D3
   MOVE.L A0,D3
   AND.L #$0000FFFF,D3

   * CHECK X COORDS ARE WITHIN BOX
   CMP D3, D1
   BGT OUTSIDE_BOUNDS
   ADD.L   #BUTTON1_WIDTH,   D1
   CMP D3, D1
   BLT OUTSIDE_BOUNDS
    
    
    * SET Y BUTTON POSITION
   MOVE.L D7, D1
   ADD.L #BUTTON1_POS_Y,   D1
   
   * SET Y MOUSE COORDINATES INTO D3
    MOVE.L A0,D3
    LSR.L #8,D3
    LSR.L #8,D3
   

   CMP D3, D1
   BGT OUTSIDE_BOUNDS
   ADD.L   #BUTTON1_HEIGHT,   D1
   CMP D3, D1
   BLT OUTSIDE_BOUNDS
    
   MOVE A1, D5
   CMP #0, D5
   BNE NO_CLICK
   MOVEQ #2, D5

NO_CLICK  
   MOVEQ #1, D5
   
  

OUTSIDE_BOUNDS
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
BLUE           EQU     $00FF0000 ; A B G R (LEAST SIGNIFICANT)
YELLOW           EQU     $0000FFFF ; A B G R (LEAST SIGNIFICANT)
RED             EQU     $000000FF ; A B G R (LEAST SIGNIFICANT)
     END    START        ; last line of source







*~Font name~Courier New~
*~Font size~10~
*~Tab type~0~
*~Tab size~0~
