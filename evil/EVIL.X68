*-----------------------------------------------------------
* Program    :THE GOD PROGRAM
* Written by :EMERSON WILLIAMS
* Date       :4/4/07
* Description:FUNKY PICTURES/RANDOM NUMBERS
*-----------------------------------------------------------
LF      EQU     $0A
CR      EQU     $0D
*FOR THE MOUSE MODE TO WORK YOU MUST ENABLE EXCEPTIONS 
*IN THE SIMULATOR (NOT THE EDITOR/ASSEMBLER) OPTIONS->ENABLE EXCEPTIONS

*GENERATING RANDOM NUMBERS IS EVIL
RAND    MACRO                   MACRO FOR GENERATING RANDOM NUMBER: BASED IN PART ON LEE DAVISON'S RANDOM NUMBER GENERATOR
        MOVE.l  SEED,D0         PUT SEED IN D0
        MOVE.B  #18,D1          
LOOP\@  ROL.L   #1,D0           SHIFT LEFT 1 BIT
        BCC     NEXT\@          SKIP IF CARRY CLEAR 
        EOR.B   #$AF,D0
NEXT\@  DBF     D1,LOOP\@       LOOP
        MOVE.l  D0,SEED         PUT NEW NUMBER INTO SEED
        MOVE.L  \2,D1           HIGH RANGE
        SUB.L   \1,D1           LOW RANGE
        AND.L   #$0000FFFF,D0   
        DIVU    D1,D0           FORCE NUMBER BETWEEN RANGE
        SWAP    D0              ""
        ADD.W   \1,D0           ""
        MOVE.W  D0,\3           MOVE RESULT INTO DESTINATION
        ENDM

DISPLAY MACRO                   MACRO FOR DISPLAYING TEXT
        LEA     \1,A1
        MOVE.B  #14,D0
        TRAP    #15
        ENDM

GETNUM  MACRO                   MACRO FOR GETTING INPUT
        MOVE.B  #4,D0
        TRAP    #15
        ENDM
      
INIT    MACRO                   MACRO FOR SETTING PROGRAM UP
        CMP.B   #1,D1           IF D1=1
        BNE     RND\@           SET UP MOUSE
        MOVE.L  #MOUSEM,$6C     ""
        MOVE.B  #60,d0          ""
        MOVE.W  #$0304,d1       ""
        TRAP    #15             ""
RND\@   MOVE.B  #8,D0           SET UP RANDOM NUMBERS
        TRAP    #15             GET SEED FROM TIMER
        SWAP    D1              MESS WITH SEED TO MAKE IT MORE RANDOM
        MOVE.L  D1,D2           ""
        TRAP    #15             ""
        ADD.L   D2,D1           ""
        MOVE.L  D1,SEED         LOAD INTO SEED
        RAND    #0,#640,X1      GET FIRST X COORDINATE
        RAND    #0,#480,Y1      GET FIRST Y COORDINATE    
        ENDM   

GOD     MACRO                   MACRO FOR DRAWING A LINE FROM
        MOVE.W  \1,D1           X1,Y1 TO X2,Y2
        MOVE.W  \2,D2
        MOVE.W  \3,D3
        MOVE.W  \4,D4
        MOVE.B  #84,D0
        TRAP    #15
        ENDM

START   ORG     $1000
        DISPLAY INSTR           SHOW MENU
        GETNUM                  GET MENU CHOICE
        CMP.B   #0,D1           IF 0
        BEQ     DONE            EXIT
        INIT                    SET UP PROGRAM
LOOP    RAND    #-200,#1000,D6  GET SECOND X
        RAND    #-100,#800,D7   GET SECOND Y
        MOVE.L  SEED,D1         GET COLOR (FROM SEED OF PREVIOUS RAND)
        MOVEQ   #80,D0          "" (HAD BEEN DOING 2 EXTRA RAND CALLS FOR IT)
        TRAP    #15             "" (BUT THEN I REALIZED IT WASNT NECESSARY)
        GOD     X1,Y1,D6,D7     DRAW LINE
        BRA     LOOP            LOOP

        ORG     $2000
X1      DS.W    1
Y1      DS.W    1
SEED    DS.L    1
INSTR   DC.B    'THE GOD PROGRAM',CR,LF,'ENTER 0 TO EXIT',CR,LF,'ENTER 1 FOR MOUSE BASED STARTING POINT',CR,LF
        DC.B    'ENTER ANYTHING ELSE FOR RANDOM STARTING POINT',CR,LF,'ENTER YOUR CHOICE: ',0

MOUSEM  MOVEM.L D0-D1,-(A7)
        MOVE.B  #61,D0          
        MOVE.B  #0,D1           
        TRAP    #15
        MOVE.W  D1,X1
        SWAP    D1
        MOVE.W  D1,Y1
        MOVEM.L (A7)+,D0-D1
        RTE

DONE    MOVE.B  #9,D0
        TRAP    #15             Halt Simulator
        END     START

*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~8~
