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
            MOVE.L A1, D0
            CMP #1, D0
            BLT NO_CLICK
            BSR HANDLE_CLICK
NO_CLICK
            RTS
            

*-------------------------------------------------------------------
*
*           HANDLE CLICK
*
*-------------------------------------------------------------------
HANDLE_CLICK
            MOVE A2, D0
            
            CMP #1, D0
            BNE NOT_1
            * CLICKED 1 IN BUTTONS
            MOVE A4, D1
            CMP #1, D1
            BLT NO_OP_1
            MOVE #1, A5
            RTS
NO_OP_1
            MOVE #1, A3 
NOT_1
            
            CMP #2, D0
            BNE NOT_2
            * CLICKED 2 IN BUTTONS
            MOVE A4, D1
            CMP #1, D1
            BLT NO_OP_2
            MOVE #2, A5
            RTS
NO_OP_2
            MOVE #2, A3 
NOT_2

            CMP #3, D0
            BNE NOT_3
            * CLICKED 3 IN BUTTONS
            MOVE A4, D1
            CMP #1, D1
            BLT NO_OP_3
            MOVE #3, A5
            RTS
NO_OP_3
            MOVE #3, A3 
NOT_3
      
            
            CMP #4, D0
            BNE NOT_4
            * CLICKED 4 IN BUTTONS
            MOVE A4, D1
            CMP #1, D1
            BLT NO_OP_4
            MOVE #4, A5
            RTS
NO_OP_4
            MOVE #4, A3 
NOT_4

            CMP #5, D0
            BNE NOT_5
            * CLICKED 5 IN BUTTONS
            MOVE A4, D1
            CMP #1, D1
            BLT NO_OP_5
            MOVE #5, A5
            RTS
NO_OP_5
            MOVE #5, A3 
NOT_5

            CMP #6, D0
            BNE NOT_6
            * CLICKED 6 IN BUTTONS
            MOVE A4, D1
            CMP #1, D1
            BLT NO_OP_6
            MOVE #6, A5
            RTS
NO_OP_6
            MOVE #6, A3 
NOT_6
            CMP #7, D0
            BNE NOT_7
            * CLICKED 7 IN BUTTONS
            MOVE A4, D1
            CMP #1, D1
            BLT NO_OP_7
            MOVE #7, A5
            RTS
NO_OP_7
            MOVE #7, A3 
NOT_7

            CMP #8, D0
            BNE NOT_8
            * CLICKED 8 IN BUTTONS
            MOVE A4, D1
            CMP #1, D1
            BLT NO_OP_8
            MOVE #8, A5
            RTS
NO_OP_8
            MOVE #8, A3 
NOT_8

            CMP #9, D0
            BNE NOT_9
            * CLICKED 9 IN BUTTONS
            MOVE A4, D1
            CMP #1, D1
            BLT NO_OP_9
            MOVE #9, A5
            RTS
NO_OP_9
            MOVE #9, A3 
NOT_9

            CMP #10, D0
            BNE NOT_0
            * CLICKED 0 IN BUTTONS
            MOVE A4, D1
            CMP #1, D1
            BLT NO_OP_0
            MOVE #0, A5
            RTS
NO_OP_0
            MOVE #0, A3 
NOT_0



            CMP #11, D0
            BNE NOT_11
            * CLICKED MULTIPLICATION IN BUTTONS
            MOVE #1, A4
NOT_11

            CMP #12, D0
            BNE NOT_12
            * CLICKED PLUS IN BUTTONS
            MOVE #2, A4
NOT_12

            CMP #13, D0
            BNE NOT_13
            * CLICKED MINUS IN BUTTONS
            MOVE #3, A4
NOT_13
            CMP #14, D0
            BNE NOT_14
            * CLICKED clear IN BUTTONS
            MOVE #0, A3
            MOVE #0, A4
            MOVE #0, A5
            MOVE #0, A6
NOT_14   
            CMP #15, D0
            BNE NOT_15
            * CLICKED EQUALS IN BUTTONS
            MOVE A4, D0
            MOVE A3, D1
            MOVE A5, D2
            CMP #1, D0
            BNE NOT_MULTIPLY
            MULS D1, D2
            MOVE D2, A6
            BSR NOT_15
NOT_MULTIPLY
            CMP #2, D0
            BNE NOT_ADDITION
            ADD D1, D2
            MOVE D2, A6
            BSR NOT_15
NOT_ADDITION
            CMP #3, D0
            BNE NOT_SUBTRACTION
            SUB.L D2, D1
            MOVE D2, A6
            BSR NOT_15
NOT_SUBTRACTION
            CMP #4, D0
            BNE NOT_DIVISION
            DIVS D2, D1
            MOVE D2, A6
            BSR NOT_15
NOT_DIVISION

NOT_15
            CMP #16, D0
            BNE NOT_16
            * CLICKED DIVISION IN BUTTONS
            MOVE #4, A4
NOT_16
            MOVE.L #0000,D1
            MOVE.B #11,D0
            TRAP #15
            
            MOVE A6, D1
            MOVE.B #6, D3
            MOVE.B #20, D0
            TRAP #15
            
*            MOVE A4, D1
*            MOVE.B #20, D3
*            MOVE.B #20, D0
*            TRAP #15
*            
*            MOVE A5, D1
*            MOVE.B #20, D3
*            MOVE.B #20, D0
*            TRAP #15
            
            RTS            
            
*-------------------------------------------------------------------
*
*           get mouse
*
*-------------------------------------------------------------------
GET_MOUSE
* CLEARS TEXT FIELDS
            *MOVE.L #0000,D1
            *MOVE.B #11,D0
            *TRAP #15
            
            MOVEQ #61, D0
            MOVE.B #0, D1
            TRAP #15 // take in the mouse coordinates
            
           MOVE.L D1, A0
           MOVE.L D0, D1
           MOVE.L D1, A1
           * if D1 is not 0, theen button is pressed and d5 = 2
           *MOVE.B #4,D2
           *MOVE.B #20,D0
           *TRAP #15
            
           * coords are stored as #YYYY XXXX
           MOVE.L A0, D1
           MOVE.L D1,D3
           AND.L #$0000FFFF,D1
           *MOVE.B #4,D2
           *MOVE.B #20,D0
           *TRAP #15
            
           MOVE.L #0, D1
           MOVE.L D3,D1
           LSR.L #8,D1
           LSR.L #8,D1
           *MOVE.B #6,D2
           *MOVE.B #20,D0
           *TRAP #15

            
            
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
    MOVE #3, A2
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
    

            BSR DRAW_BUTTON_TEXT
    
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
    
    
NOT_YELLOW
    CMP #2, D5
    BNE NOT_BLUE
    MOVE.L #BLUE, D1
    
NOT_BLUE
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
    
   MOVEQ #1, D5

   MOVE.L A1, D0
   CMP #1, D0
   BLT OUTSIDE_BOUNDS
   ADD.L #1, D5
  

OUTSIDE_BOUNDS
   RTS


*-------------------------------------------------------------------
*
*           TEXT LABELS ON THE BUTTONS
*
*-------------------------------------------------------------------
DRAW_BUTTON_TEXT
            MOVE A1, D3
            
            LEA ZERO, A1
            MOVE #95, D0
            MOVE #80, D1 ;X
            MOVE #450, D2 ;Y
            TRAP #15
            
            LEA _CLEAR, A1
            MOVE #95, D0
            MOVE #230, D1 ;X
            MOVE #450, D2 ;Y
            TRAP #15
            
            LEA _EQUAL, A1
            MOVE #95, D0
            MOVE #390, D1 ; X
            MOVE #450, D2 ; Y
            TRAP #15
            
            LEA DIVIDE, A1
            MOVE #95, D0
            MOVE #550, D1 ; X
            MOVE #450, D2 ; Y
            TRAP #15
            
            LEA ONE, A1
            MOVE #95, D0
            MOVE #80, D1 ; X
            MOVE #350, D2 ; Y
            TRAP #15
            
            LEA TWO, A1
            MOVE #95, D0
            MOVE #230, D1 ; X
            MOVE #350, D2 ; Y
            TRAP #15
            
            LEA THREE, A1
            MOVE #95, D0
            MOVE #390, D1 ;X
            MOVE #350, D2 ;Y
            TRAP #15
            
            LEA SUBTRACT, A1
            MOVE #95, D0
            MOVE #550, D1 ;X
            MOVE #350, D2 ;Y
            TRAP #15
            
            LEA FOUR, A1
            MOVE #95, D0
            MOVE #80, D1 ; X
            MOVE #250, D2 ; Y
            TRAP #15
            
            LEA FIVE, A1
            MOVE #95, D0
            MOVE #230, D1 ; X
            MOVE #250, D2 ; Y
            TRAP #15
            
            LEA SIX, A1
            MOVE #95, D0
            MOVE #390, D1 ;X
            MOVE #250, D2 ;Y
            TRAP #15
            
            LEA ADDITION, A1
            MOVE #95, D0
            MOVE #550, D1 ;X
            MOVE #250, D2 ;Y
            TRAP #15
            
            LEA SEVEN, A1
            MOVE #95, D0
            MOVE #80, D1 ; X
            MOVE #150, D2 ; Y
            TRAP #15
            
            LEA EIGHT, A1
            MOVE #95, D0
            MOVE #230, D1 ; X
            MOVE #150, D2 ; Y
            TRAP #15
            
            LEA NINE, A1
            MOVE #95, D0
            MOVE #390, D1 ;X
            MOVE #150, D2 ;Y
            TRAP #15
            
            LEA MULTIPLY, A1
            MOVE #95, D0
            MOVE #550, D1 ;X
            MOVE #150, D2 ;Y
            TRAP #15
            
            MOVE D3, A1
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
ZERO DC.B '0',CR,LF,0
_CLEAR DC.B 'CE',CR,LF,0
_EQUAL DC.B '=',CR,LF,0
DIVIDE DC.B '/',CR,LF,0
ONE DC.B '1',CR,LF,0
TWO DC.B '2',CR,LF,0
THREE DC.B '3',CR,LF,0
SUBTRACT DC.B '-',CR,LF,0
FOUR DC.B '4',CR,LF,0
FIVE DC.B '5',CR,LF,0
SIX DC.B '6',CR,LF,0
ADDITION DC.B '+',CR,LF,0
SEVEN DC.B '7',CR,LF,0
EIGHT DC.B '8',CR,LF,0
NINE DC.B '9',CR,LF,0
MULTIPLY DC.B 'x',CR,LF,0
WHITE           EQU     $00FFFFFF ; A B G R (LEAST SIGNIFICANT)
BLUE           EQU     $00FF0000 ; A B G R (LEAST SIGNIFICANT)
YELLOW           EQU     $0000FFFF ; A B G R (LEAST SIGNIFICANT)
RED             EQU     $000000FF ; A B G R (LEAST SIGNIFICANT)


     END    START        ; last line of source












*~Font name~Courier New~
*~Font size~10~
*~Tab type~0~
*~Tab size~0~
