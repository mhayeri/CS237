*----------------------------------------------------------------------
* Programmer: Mustafa Hayeri
* Class Account: cssc0685
* Assignment or Title: Program #4
* Filename: prog4.s
* Date completed:  12/13/16
*----------------------------------------------------------------------
* Problem statement: Calculate the nth Fibonacci term given by the user
* Input: A number entered by the user from 0-30
* Output: The nth term of the Fibonacci sequence
* Error conditions tested: None
* Included files: fib.s
* Method and/or pseudocode: None
* References: None
*----------------------------------------------------------------------
*
        ORG     $0
        DC.L    $3000           * Stack pointer value after a reset
        DC.L    start           * Program counter value after a reset
        ORG     $3000           * Start at location 3000 Hex
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
fib:    EQU               $7000
start:  initIO            * Initialize (required for I/O)
        setEVT            * Error handling routines
*       initF             * For floating point macros only    

        lineout        skipln
        lineout        prompt
        linein         buffer
        cvta2          buffer,D0
        move.w         D0,-(SP)    * push parameter
        jsr            fib         * call to subroutine
        adda.l         #2,SP       * pop the stack
        cvt2a          buffer,#11
        stripp         buffer,#11
        lea            buffer,A1
        adda.l         D0,A1
        clr.b          (A1)
        lineout        answer
            
        break                       * Terminate execution

*
*----------------------------------------------------------------------
*       Storage declarations

    skipln:      ds.b    0
    title:       dc.b    'Program #4, Mustafa Hayeri, cssc0685',0
    prompt:      dc.b    'Enter a number',0
    answer:      dc.b    'The answer is '
    buffer:      ds.b    82
    stop:        dc.b    ',0'
        end
