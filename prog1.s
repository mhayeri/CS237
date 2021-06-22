*---------------------------------------------------------------
* Programmer: Mustafa Hayeri
* Class Account: cssc0685
* Assignment or Title: Program 1
* Filename: prog1.s
* Date completed:  10/10/16
*---------------------------------------------------------------
* Problem statement: Calculate the user's age in 2016
* Input: The user's date of birth
* Output: The age of the user in 2016
* Error conditions tested: None
* Included files: None
* Method and/or pseudocode: None
* References: None
*---------------------------------------------------------------
*
       ORG     $0
       DC.L    $3000       * Stack pointer value after a reset
       DC.L    start       * Program counter value after a reset
       ORG     $3000       * Start at location 3000 Hex
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
start:   	 initIO           	  	 * Initialize (required for I/O)
	   	 setEVT			  	 * Error handling routines
*	   	 initF			  	 * For floating point macros only	

		lineout	   title
		lineout	   skipln
		lineout    prompt
		linein	   buffer	         * User input is stored at this address
		cvta2	   buffer+6,#4	         * Takes 4 bytes starting at address(year * of birth) and coverts to 2s-comp
		move.l	   D0,D1
		move.l	   #2016,D0
		sub.l	   D1,D0		 * Subtracts year of birth from 2016
		cvt2a	   age,#3
		stripp     age,#3
		lea        age,A0
		adda.l	   D0,A0
		move.b	   #' ',(A0)+	         * Increments address register to complete string
		move.b	   #'y',(A0)+
		move.b	   #'e',(A0)+
		move.b	   #'a',(A0)+ 
		move.b	   #'r',(A0)+
		move.b	   #'s',(A0)+
		move.b	   #' ',(A0)+
		move.b	   #'o',(A0)+
		move.b	   #'l',(A0)+
		move.b	   #'d',(A0)+
		move.b	   #'.',(A0)+
		move.b	   #' ',(A0)+
		move.b	   #'*',(A0)+
		clr.b	   (A0)			* Null terminate the string
		lea        stars+35,A1
		adda.l	   D0,A1
		clr.b	   (A1)
		lineout	   stars
		lineout	   answer
		lineout	   stars
		move.b	   #’*',(A1)            * Replace the '*' that gets null terminated		

		break                           * Terminate execution

*
*----------------------------------------------------------------------
*       Storage declarations
title:	    	dc.b	'Program #1, Mustafa Hayeri, cssc0685',0
prompt: 	dc.b	'Please enter your date of birth (MM/DD/YYYY):',0
buffer: 	ds.b	80
answer:	    	dc.b	'* In 2016 you will be '
age:		ds.b	20
stars:	    	dcb.b	40,'*'
skipln:		dc.b	0	
	end
