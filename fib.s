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
            ORG $7000
    fib:    link         A6,#0
            movem.l      D1-D2,-(SP)
            move.w       8(A6),D2     *n in D2
            cmpi.w       #0,D2        *Check if user entered 0
            BNE          CheckIfOne
            move.w       #0,D0
            BRA          finish

    CheckIfOne:    
            cmpi.w       #1,D2        *Check if user entered 1
            BNE          recurse
            move.w       #1,D0
            BRA          finish

    recurse:
            move.w       D2,D1
            subq.w       #1,D1        *n-1
            move.w       D1,-(SP)
            jsr          fib          *Call to subroutine
            adda.l       #2,SP
            move.w       D0,D2

            subq.w       #1,D1        *n-2
            move.w       D1,-(SP)
            jsr          fib          *Call to subroutine
            adda.l       #2,SP
            add.l        D2,D0

    finish:
            movem.l     (SP)+,D1/D2    *Restore the registers 
            unlk         A6
            rts
        end
