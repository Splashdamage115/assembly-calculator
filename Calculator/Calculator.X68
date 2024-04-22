*-----------------------------------------------------------
* Program    :	FINAL PROJECT
* Written by :	JOSH BOFF
* Date       :	4/24/2013
* Description:	CALCULATOR. 
*-----------------------------------------------------------
	
	ORG	$1000

START:
	MOVE.L	#MOUSEDOWNIRQ,$68		
	MOVE.B	#60,D0				
	MOVE.W	#$0201,D1			
	TRAP	#15

CLEAR	
	CLR.B	D7
	BRA	DRAWBUTTONS
	
MAINLOOP:
	
	NOP
	NOP
	NOP
	NOP
	CMP.B	#0,D7
	BEQ	MAINLOOP
	BRA	CLEAR
	
*********SUBR***********************************************	
DRAWBUTTONS:
	

	LEA	$1000,A7
	PEA	FIELD_L	
	PEA	FIELD_T
	PEA	FIELD_W
	PEA	FIELD_H
	BSR	RECT

	LEA	$1000,A7
	PEA	CLR_L	
	PEA	CLR_T
	PEA	CLR_W
	PEA	CLR_H
	BSR	RECT
	
	LEA	$1000,A7
	PEA	CLR_TEXT
	BSR	TEXT
	
	LEA	$1000,A7
	PEA	EQU_L	
	PEA	EQU_T
	PEA	EQU_W
	PEA	EQU_H
	BSR	RECT
	
	LEA	$1000,A7
	PEA	EQU_TEXT
	BSR	TEXT
	
	LEA	$1000,A7
	PEA	DIV_L	
	PEA	DIV_T
	PEA	DIV_W
	PEA	DIV_H
	BSR	RECT
	
	LEA	$1000,A7
	PEA	DIV_TEXT
	BSR	TEXT
	
	LEA	$1000,A7
	PEA	MUL_L	
	PEA	MUL_T
	PEA	MUL_W
	PEA	MUL_H
	BSR	RECT
	
	LEA	$1000,A7
	PEA	MUL_TEXT
	BSR	TEXT
	
	LEA	$1000,A7
	PEA	SUB_L	
	PEA	SUB_T
	PEA	SUB_W
	PEA	SUB_H
	BSR	RECT
	
	LEA	$1000,A7
	PEA	SUB_TEXT
	BSR	TEXT
	
	LEA	$1000,A7
	PEA	ADD_L	
	PEA	ADD_T
	PEA	ADD_W
	PEA	ADD_H
	BSR	RECT
	
	LEA	$1000,A7
	PEA	ADD_TEXT
	BSR	TEXT
	
	
	
	LEA	$1000,A7
	PEA	ZERO_L	
	PEA	ZERO_T
	PEA	ZERO_W
	PEA	ZERO_H
	BSR	RECT
	
	LEA	$1000,A7
	PEA	ZERO_text
	BSR	TEXT
	
	LEA	$1000,A7
	PEA	ONE_L	
	PEA	ONE_T
	PEA	ONE_W
	PEA	ONE_H
	BSR	RECT
	
	LEA	$1000,A7
	PEA	ONE_text
	BSR	TEXT
	
	LEA	$1000,A7
	PEA	TWO_L	
	PEA	TWO_T
	PEA	TWO_W
	PEA	TWO_H
	BSR	RECT
	
	LEA	$1000,A7
	PEA	TWO_text
	BSR	TEXT
	
	LEA	$1000,A7
	PEA	THREE_L	
	PEA	THREE_T
	PEA	THREE_W
	PEA	THREE_H
	BSR	RECT
	
	LEA	$1000,A7
	PEA	THREE_text
	BSR	TEXT
	
	LEA	$1000,A7
	PEA	FOUR_L	
	PEA	FOUR_T
	PEA	FOUR_W
	PEA	FOUR_H
	BSR	RECT
	
	LEA	$1000,A7
	PEA	FOUR_text
	BSR	TEXT
	
	LEA	$1000,A7
	PEA	FIVE_L	
	PEA	FIVE_T
	PEA	FIVE_W
	PEA	FIVE_H
	BSR	RECT
	
	LEA	$1000,A7
	PEA	FIVE_text
	BSR	TEXT
	
	LEA	$1000,A7
	PEA	SIX_L	
	PEA	SIX_T
	PEA	SIX_W
	PEA	SIX_H
	BSR	RECT
	
	LEA	$1000,A7
	PEA	SIX_text
	BSR	TEXT
	
	LEA	$1000,A7
	PEA	SEVEN_L	
	PEA	SEVEN_T
	PEA	SEVEN_W
	PEA	SEVEN_H
	BSR	RECT
	
	LEA	$1000,A7
	PEA	SEVEN_text
	BSR	TEXT
	
	LEA	$1000,A7
	PEA	EIGHT_L	
	PEA	EIGHT_T
	PEA	EIGHT_W
	PEA	EIGHT_H
	BSR	RECT
	
	LEA	$1000,A7
	PEA	EIGHT_text
	BSR	TEXT
	
	LEA	$1000,A7
	PEA	NINE_L	
	PEA	NINE_T
	PEA	NINE_W
	PEA	NINE_H
	BSR	RECT
	
	LEA	$1000,A7
	PEA	NINE_text
	BSR	TEXT
	
	MOVE.W	#1000,D1
	CLR.B	D1
	MOVE.B	#3,D1
	MOVE.B	#11,D0
	TRAP	#15
	CLR.L	D1
	
	clr.l	d0
	clr.l	d1
	clr.l	d2
	clr.l	d3
	clr.l	d4
	
	BRA	MAINLOOP
	

	
	
RECT:
	MOVEA.L	16(A7),A2
	MOVEA.L	12(A7),A3
	MOVEA.L	8(A7),A4
	MOVEA.L	4(A7),A5

	MOVE.W	(A2),D1
	MOVE.W	(A3),D2
	MOVE.W	(A2),D3
	ADD.W	(A4),D3
	MOVE.W	(A3),D4
	ADD.W	(A5),D4
	
	MOVE.B	#87,D0
	TRAP	#15
	RTS
	
TEXT:
       MOVEA.L	4(A7),A1
       
       ADD.W	#14,D1
       ADD.W	#17,D2

       MOVE.B	#95,D0
       TRAP	#15
       
       RTS
			
*THANKS TO PROF. KELLY I HAVE A SUBROUTINE APPEND.       
APPEND
	move.l D2,d0
        asl.l  #3,d0        
        bvs    overflow
        add.l  D2,d0    
        bvs    overflow
        add.l  D2,d0    
        bvs    overflow
        add.l  d1,d0       
        move.L d0,NUM
overflow
        rts
DIV
	
	CLR.L	D1
	CLR.L	D2
	
	MOVE.L	NUM2,D1
	MOVE.L	NUM,D2
	DIVS.W	D2,D1
	EXT.L	D1
	
	MOVE.B	#3,D0
	trap	#15
	BRA	EXIT
	
MUL
		
	CLR.L	D1
	CLR.L	D2
	
	MOVE.L	NUM2,D1
	MOVE.L	NUM,D2
	MULS.W	D2,D1
	MOVE.L	D1,D3
	
	
	MOVE.B	#3,D0
	trap	#15
	BRA	EXIT
	

SUB
		
	CLR.L	D1
	CLR.L	D2
	
	MOVE.L	NUM2,D1
	MOVE.L	NUM,D2
	SUB.L	D2,D1
	
	MOVE.B	#3,D0
	trap	#15
	BRA	EXIT
	

ADD
		
	CLR.L	D1
	CLR.L	D2
	
	MOVE.L	NUM2,D1
	ADD.L	NUM,D1
	
	MOVE.B	#3,D0
	TRAP	#15
	BRA	EXIT


* I WOULD ALSO LIKE TO GIVE CREDIT TO PROF KELLY FOR 
* HELPING ME UNDERSTAND AND CREATE A MOUSEDOWNIRQ.	
MOUSEDOWNIRQ
	
	MOVE.B  #61,d0       
    	MOVE.B  #2,d1        
    	TRAP    #15
    	CLR.L   d2
   	MOVE.W  d1,d2        
    	SWAP    d1           
    	AND.L   #$0FFFF,d1
    	
    	*CLR
    	if.w d1 <gt> #240 and.w d1 <lt> #290 then
    	  if.w d2 <gt> #10 and.w d2 <lt> #60 then
	      	MOVE.W	#$FF00,D1
		MOVE.B	#11,D0
		TRAP	#15
		
		CLR.L	NUM
		CLR.L	NUM2
		CLR.B	OPRAND
		
		clr.l	d1
	      	clr.l	d2
	      	clr.l	d3
	      
	      	MOVE.B	#1,D7
		BRA	EXIT
	      	
	    endi
	 endi
	*EQU
    	if.w d1 <gt> #240 and.w d1 <lt> #290 then
    	  if.w d2 <gt> #120 and.w d2 <lt> #170 then
	        LEA	EQU_TEXT,A1
	        MOVE.B	#14,D0
	        TRAP	#15
	        
		CMP.B	#1,OPRAND
	      	BEQ	DIV
	      	CMP.B	#2,OPRAND
	      	BEQ	MUL
	      	CMP.B	#3,OPRAND
	      	BEQ	SUB
	      	CMP.B	#4,OPRAND
	      	BEQ	ADD
	      	
	     endi
	 endi
    	*DIV
    	if.w d1 <gt> #75 and.w d1 <lt> #125 then
    	  if.w d2 <gt> #175 and.w d2 <lt> #225 then
	      	CMP.B	#0,OPRAND
		BNE	EXIT
		
		LEA	DIV_TEXT,A1
	        MOVE.B	#14,D0
	        TRAP	#15
		
		MOVE.L	NUM,NUM2
		CLR.L	NUM
		MOVE.B	#1,OPRAND
	      	
	      	BRA	EXIT
	    endi
	 endi
    	*MUL
    	if.w d1 <gt> #130 and.w d1 <lt> #180 then
    	  if.w d2 <gt> #175 and.w d2 <lt> #225 then
	      	CMP.B	#0,OPRAND
		BNE	EXIT
		
		LEA	MUL_TEXT,A1
	        MOVE.B	#14,D0
	        TRAP	#15
		
		MOVE.L	NUM,NUM2
		CLR.L	NUM
		MOVE.B	#2,OPRAND
		
		BRA	EXIT
	    endi
	 endi
    	*SUB
    	if.w d1 <gt> #185 and.w d1 <lt> #235 then
    	  if.w d2 <gt> #175 and.w d2 <lt> #225 then
    	  	CMP.B	#0,OPRAND
		BNE	EXIT
		
		LEA	SUB_TEXT,A1
	        MOVE.B	#14,D0
	        TRAP	#15
		
		MOVE.L	NUM,NUM2
		CLR.L	NUM
		MOVE.B	#3,OPRAND
		
		BRA	EXIT
	    endi
	 endi
    	*ADD
    	if.w d1 <gt> #240 and.w d1 <lt> #290 then
    	  if.w d2 <gt> #175 and.w d2 <lt> #225 then
	        CMP.B	#0,OPRAND
		BNE	EXIT
		
		LEA	ADD_TEXT,A1
	        MOVE.B	#14,D0
	        TRAP	#15
		
		MOVE.L	NUM,NUM2
		CLR.L	NUM
		MOVE.B	#4,OPRAND
		
		BRA	EXIT
	    endi
	 endi
    	*ZERO
    	if.w d1 <gt> #240 and.w d1 <lt> #290 then
    	  if.w d2 <gt> #65 and.w d2 <lt> #115 then
	        CLR.L	D1
	        CLR.L	D2
	  	move.b	#0,d1
	  	MOVE.B	#3,D0
		TRAP	#15
		MOVE.L	NUM,D2
		bsr	APPEND
		
		BRA	EXIT
	    endi
	 endi
    	*ONE
    	if.w d1 <gt> #185 and.w d1 <lt> #235 then
    	  if.w d2 <gt> #10 and.w d2 <lt> #60 then
	        CLR.L	D1
	        CLR.L	D2
		move.b	#1,d1
		MOVE.B	#3,D0
		TRAP	#15
		MOVE.L	NUM,D2
		bsr	APPEND 
    	
    		BRA	EXIT
	   endi
	 endi
    	*TWO
    	if.w d1 <gt> #185 and.w d1 <lt> #235 then
    	  if.w d2 <gt> #65 and.w d2 <lt> #115 then
	      	CLR.L	D1
	        CLR.L	D2
		move.b	#2,d1
		MOVE.B	#3,D0
		TRAP	#15
		MOVE.L	NUM,D2
		bsr	APPEND
		
		BRA	EXIT
	    endi
	 endi
    	*THREE
    	if.w d1 <gt> #185 and.w d1 <lt> #235 then
    	  if.w d2 <gt> #120 and.w d2 <lt> #170 then
	      	CLR.L	D1
	        CLR.L	D2
		move.b	#3,d1
		MOVE.B	#3,D0
		TRAP	#15
		MOVE.L	NUM,D2
		bsr	APPEND
		
		BRA	EXIT
	    endi
	 endi
    	*FOUR
    	if.w d1 <gt> #130 and.w d1 <lt> #180 then
    	  if.w d2 <gt> #10 and.w d2 <lt> #60 then
	       	CLR.L	D1
	        CLR.L	D2
		move.b	#4,d1
		MOVE.B	#3,D0
		TRAP	#15
		MOVE.L	NUM,D2
		bsr	APPEND
		
		BRA	EXIT
	    endi
	 endi
    	*FIVE
    	if.w d1 <gt> #130 and.w d1 <lt> #180 then
    	  if.w d2 <gt> #65 and.w d2 <lt> #115 then
	       	CLR.L	D1
	        CLR.L	D2
	        MOVE.B	#5,D1
	        MOVE.B	#3,D0
		TRAP	#15
		MOVE.L	NUM,D2
		bsr	APPEND
		
		BRA	EXIT
	    endi
	 endi
    	*SIX
    	if.w d1 <gt> #130 and.w d1 <lt> #180 then
    	  if.w d2 <gt> #120 and.w d2 <lt> #170 then
    	  	CLR.L	D1
	        CLR.L	D2
	        move.b	#6,d1
		MOVE.B	#3,D0
		TRAP	#15
		MOVE.L	NUM,D2
		bsr	APPEND
		
		BRA	EXIT
	    endi
	 endi
    	*SEVEN
    	if.w d1 <gt> #75 and.w d1 <lt> #125 then
    	  if.w d2 <gt> #10 and.w d2 <lt> #60 then
	        CLR.L	D1
	        CLR.L	D2
		move.b	#7,d1
		MOVE.B	#3,D0
		TRAP	#15
		MOVE.L	NUM,D2
		bsr	APPEND
		
		BRA	EXIT
	    endi
	 endi
    	*EIGHT
    	if.w d1 <gt> #75 and.w d1 <lt> #125 then
    	  if.w d2 <gt> #65 and.w d2 <lt> #115 then
	        CLR.L	D1
	        CLR.L	D2
		move.b	#8,d1
		MOVE.B	#3,D0
		TRAP	#15
		MOVE.L	NUM,D2
		bsr	APPEND
		
		BRA	EXIT
	    endi
	 endi
    	*NINE
    	if.w d1 <gt> #75 and.w d1 <lt> #125 then
    	  if.w d2 <gt> #120 and.w d2 <lt> #170 then
	       	CLR.L	D1
	        CLR.L	D2
		move.b	#9,d1
		MOVE.B	#3,D0
		TRAP	#15
		MOVE.L	NUM,D2
		bsr	APPEND
	    endi
	 endi
	 
	 
		
EXIT
	
	RTE
	
*VAR--------------------------------------------
CLR_L	  DC.W	10
CLR_T	  DC.W	240
CLR_W	  DC.W	50	
CLR_H     DC.W	50
	  
EQU_L	  DC.W	120
EQU_T	  DC.W	240
EQU_W	  DC.W	50	
EQU_H     DC.W	50

DIV_L	  DC.W	175
DIV_T	  DC.W	75
DIV_W	  DC.W	50	
DIV_H     DC.W	50

MUL_L	  DC.W	175
MUL_T	  DC.W	130
MUL_W	  DC.W	50	
MUL_H     DC.W	50

SUB_L	  DC.W	175
SUB_T	  DC.W	185
SUB_W	  DC.W	50	
SUB_H     DC.W	50

ADD_L	  DC.W	175
ADD_T	  DC.W	240
ADD_W	  DC.W	50	
ADD_H     DC.W	50

FIELD_L	  DC.W	10
FIELD_T	  DC.W	20
FIELD_W	  DC.W	215	
FIELD_H   DC.W	50

ZERO_L	  DC.W	65
ZERO_T	  DC.W	240
ZERO_W	  DC.W	50	
ZERO_H    DC.W	50

ONE_L	  DC.W	10
ONE_T	  DC.W	185
ONE_W	  DC.W	50	
ONE_H     DC.W	50

TWO_L	  DC.W	65
TWO_T	  DC.W	185
TWO_W	  DC.W	50	
TWO_H     DC.W	50

THREE_L	  DC.W	120
THREE_T	  DC.W	185
THREE_W	  DC.W	50	
THREE_H   DC.W	50

FOUR_L	  DC.W	10
FOUR_T	  DC.W	130
FOUR_W	  DC.W	50	
FOUR_H    DC.W	50

FIVE_L	  DC.W	65
FIVE_T	  DC.W	130
FIVE_W	  DC.W	50	
FIVE_H    DC.W	50

SIX_L	  DC.W	120
SIX_T	  DC.W	130
SIX_W	  DC.W	50	
SIX_H     DC.W	50

SEVEN_L	  DC.W	10
SEVEN_T	  DC.W	75
SEVEN_W	  DC.W	50	
SEVEN_H   DC.W	50

EIGHT_L	  DC.W	65
EIGHT_T	  DC.W	75
EIGHT_W	  DC.W	50	
EIGHT_H   DC.W	50

NINE_L	  DC.W	120
NINE_T	  DC.W	75
NINE_W	  DC.W	50	
NINE_H    DC.W	50

*RECTANGLE TEXT----------------
CLR_TEXT	DC.B	'CE ',0
EQU_TEXT	DC.B	' = ',0
DIV_TEXT	DC.B	' / ',0
MUL_TEXT	DC.B	' X ',0
SUB_TEXT	DC.B	' - ',0
ADD_TEXT	DC.B	' + ',0

ZERO_text	DC.B	' 0 ',0
ONE_text	DC.B	' 1 ',0
TWO_text	DC.B	' 2 ',0
THREE_text	DC.B	' 3 ',0
FOUR_text	DC.B	' 4 ',0
FIVE_text	DC.B	' 5 ',0
SIX_text	DC.B	' 6 ',0
SEVEN_text	DC.B	' 7 ',0
EIGHT_text	DC.B	' 8 ',0
NINE_text	DC.B	' 9 ',0

NUM	DC.L	0
NUM2	DC.L	0
OPRAND	DC.B	0
RETURN	DC.B	$d,$a,0



	END	        START











*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~8~
