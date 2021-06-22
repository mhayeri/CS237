*----------------------------------------------------------------------
* Programmer: Mustafa Hayeri
* Class Account: cssc0685
* Assignment or Title: Program #3
* Filename: prog3.s
* Date completed:  11/17/16
*----------------------------------------------------------------------
* Problem statement: Convert a number between 0 - 3999 to Roman numerals 
* Input: A user inputted number between 0 - 3999
* Output: The user inputted number in Roman numerals
* Error conditions tested: 
* Included files: None
* Method and/or pseudocode: Find the largest sentinel value of the users inputted number. Then continue to subtract that sentinel value from the number until the number is less than the sentinel value. 
* Branch down to the next highest sentinel value and continue the process
* until the number entered by the user is 0.
*                
* References: None
*----------------------------------------------------------------------
*
        ORG     $0
        DC.L    $3000          * Stack pointer value after a reset
        DC.L    start          * Program counter value after a reset
        ORG     $3000          * Start at location 3000 Hex
*
*----------------------------------------------------------------------
*
#minclude /home/cs/faculty/riggins/bsvc/macros/iomacs.s
#minclude /home/cs/faculty/riggins/bsvc/macros/evtmacs.s
*
*----------------------------------------------------------------------
*
* Register use
*
*----------------------------------------------------------------------
*
start:    initIO                  * Initialize (required for I/O)
   	  setEVT                  * Error handling routines
*         nitF                    * For floating point macros only    

    lineout       title
    lineout       skipln

prompt:
    lineout       promptmsg
    linein        buffer
    stripp        buffer,D0
    cmpi.l        #4,D0
    bhi           error               *Checks if string length is valid
    move.l        D0,D1
    tst.w         D1
    beq           error
    subq.w        #1,D1
    cvta2         buffer,D0        
    lea           buffer,A0

loop:
    cmpi.b        #'0',(A0)
    blo           error
    cmpi.b        #'9',(A0)+
    bhi           error
    dbra          D1,loop
    lea           Roman,A1

ChkZero:
    cmpi.l        #0,D0               *Check if number is 0 --> error
    beq           error

ChkFThousand:
    cmpi.l        #3999,D0            *Check if greater than 3999 --> error
    bhi           error

CheckThousand: 
    cmpi.l        #1000,D0
    blt           CheckNineHundred
    subi.w        #1000,D0            *Checks number for total thousands
    move.b        #'M',(A1)+
    clr.b         (A1)
    bra           CheckThousand

CheckNineHundred: 
    cmpi.l        #900,D0
    blt           CheckFiveHundred
    subi.w        #900,D0            *Checks number for 9 hundred
    move.b        #'C',(A1)+
    move.b        #'M',(A1)+
    clr.b         (A1)

CheckFiveHundred: 
    cmpi.l        #500,D0
    blt           CheckFourHundred
    subi.w        #500,D0           *Checks number for 5 hundreds
    move.b        #'D',(A1)+
    clr.b         (A1)
    bra           CheckFiveHundred

CheckFourHundred: 
    cmpi.l        #400,D0
    blt           CheckOneHundred
    subi.w        #400,D0
    move.b        #'C',(A1)+         *Checks number for 4 hundreds
    move.b        #'D',(A1)+
    clr.b         (A1)
    bra           CheckFourHundred

CheckOneHundred: 
    cmpi.l        #100,D0
    blt           Ninety
    subi.w        #100,D0
    move.b        #'C',(A1)+         *Checks number for total hundreds
    clr.b         (A1)
    bra           CheckOneHundred

Ninety: 
    cmpi.l        #90,D0
    blt           Fifty
    subi.w        #90,D0
    move.b        #'X',(A1)+         *Checks number for total ninety
    move.b        #'C',(A1)+
    clr.b         (A1)

Fifty: 
    cmpi.l        #50,D0
    blt           CheckForty
    subi.w        #50,D0             *Checks number for total fifties
    move.b        #'L',(A1)+
    clr.b         (A1)
    bra           Fifty

CheckForty: 
    cmpi.l        #40,D0
    blt           Tens
    subi.w        #40,D0
    move.b        #'X',(A1)+         *Checks number for total forty
    move.b        #'L',(A1)+
    clr.b         (A1)

Tens: 
    cmpi.l        #10,D0
    blt           ChkNine
    subi.w        #10,D0             *Check the number for total tens
    move.b        #'X',(A1)+
    clr.b         (A1)
    bra           Tens

ChkNine: 
    cmpi.l        #9,D0
    blt           ChkFive
    subi.w        #9,D0              *Check the number for total nine
    move.b        #'I',(A1)+
    move.b        #'X',(A1)+
    clr.b         (A1)

ChkFive: 
    cmpi.l        #5,D0
    blt           ChkFour
    subi.w        #5,D0              *Check the number for total fives
    move.b        #'V',(A1)+
    clr.b         (A1)

ChkFour: 
    cmpi.l        #4,D0
    blt           ChkOnes            *Check number for total fours
    subi.w        #4,D0
    move.b        #'I',(A1)+
    move.b        #'V',(A1)+
    clr.b         (A1)

ChkOnes: 
    cmpi.l        #1,D0
    blt           romanans           *Check the number for total ones
    subi.w        #1,D0
    move.b        #'I',(A1)+
    clr.b         (A1)
    bra           ChkOnes

romanans:
    lineout       answer
            
query:
    lineout       again
    linein        buffer
    cmpi.w        #1,D0              * Check if user wants to enter another number
    bne           query
    ori.b         #$20,buffer
    cmpi.b        #'y',buffer
    beq           prompt
    cmpi.b        #'n',buffer
    beq           end
    lineout       errormsg
    bra           query

error:
    lineout       errormsg
    bra           prompt

end:
    lineout       endmsg
    break         * Terminate execution

*
*----------------------------------------------------------------------
*       Storage declarations

    title:        dc.b    'Program #3, Mustafa Hayeri, cssc0685',0
    promptmsg:    dc.b    'Enter a number between 1 - 3999:',0
    buffer:       ds.b     80
    answer:       dc.b    'The Roman numeral equivalent is '
    Roman:        ds.b     82
    skipln:       dc.b     0
    again:        dc.b    'Do you want to convert another number (y/n)?',0
    errormsg:     dc.b    'Invalid input. Please try again.',0
    endmsg:       dc.b    'The program is now complete.',0

        end
