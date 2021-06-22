*---------------------------------------------------------------
* Programmer: Mustafa Hayeri
* Class Account: cssc0685
* Assignment or Title: Program #2
* Filename: prog2.s
* Date completed:  10/27/16
*---------------------------------------------------------------
* Problem statement: Find the remainder of the equation using given values 
* Input: None
* Output: The answer(remainder) of the given equation 
* Error conditions tested: None
* Included files: datafile.s
* Method and/or pseudocode: None
* References: None
*---------------------------------------------------------------
*
       ORG     $0
       DC.L    $3000           * Stack pointer value after a reset
       DC.L    start           * Program counter value after a reset
       ORG     $3000           * Start at location 3000 Hex
*
*---------------------------------------------------------------
*
#minclude /home/cs/faculty/riggins/bsvc/macros/iomacs.s
#minclude /home/cs/faculty/riggins/bsvc/macros/evtmacs.s
*
*---------------------------------------------------------------
*
* Register use
*
*---------------------------------------------------------------
*
DATA	    EQU	    $6000
a:	    EQU	    DATA
b: 	    EQU	    a+2
c:	    EQU	    b+2
d:	    EQU     c+2
e:	    EQU	    d+2
f:	    EQU	    e+2
X:	    EQU	    f+2
Y:	    EQU	    X+2
Z:	    EQU	    Y+2

start:      initIO            		* Initialize (required for I/O)
	    setEVT			* Error handling routines
*	    initF			* For floating point macros only

	    lineout		title
	    lineout		skipln
	    move.w		X,D1
	    muls.w		D1,D1		     *ax^3
	    muls.w		X,D1
	    muls.w		a,D1

	    move.w		b,D2
	    asl.w		#1,D2
	    muls.w		Y,D2		     *2by^3	
	    muls.w		Y,D2
	    muls.w		Y,D2
	    add.w		D2,D1
        
            move.w		c,D2
            muls.w		Z,D2
            muls.w		Z,D2		      *cz^2
            add.w		D2,D1

            move.w		d,D2
            muls.w		X,D2
            muls.w		X,D2		      *dx^2y
            muls.w		Y,D2
            sub.w		D2,D1

            move.w		d,D2
            muls.w		X,D2		      *dx^2
            muls.w		X,D2

            move.w		e,D3
            muls.w		Y,D3
            muls.w		Y,D3		      *ey^2
            add.w		D3,D2
        
            move.w		f,D3
            muls.w		X,D3		      *fxb
            muls.w		b,D3

            add.w		D3,D2
            move.w		Z,D3
            muls.w		Z,D3		      *3Z^2
            muls.w		#3,D3
        
            move.w		a,D4
            muls.w		d,D4		      *2ad
            asl.w		#1,D4
            sub.w		D4,D3
        
            divs.w		D2,D1
            add.w		D3,D1
            move.w		D1,D0

            ext.l		D0
            divs.w		#100,D0
            swap		D0

            ext.l		D0

            cvt2a		answer,#6
            stripp		answer,#6
            lea		        answer,A0
            adda.l		D0,A0
            clr.b		(A0)

            lineout		output

            break       * Terminate execution

*
*---------------------------------------------------------------
*       Storage declarations
title:	dc.b	'Program #2, Mustafa Hayeri, cssc0685',0
output:	dc.b	'The answer is: '
answer:	ds.b	10
skipln:	dc.b	0
		
       end
