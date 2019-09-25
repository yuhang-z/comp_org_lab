            .text
            .global _start

_start:
            LDR R4, =RESULT                 //  R4 points to the result location
            LDR R1, =MAX                    //  R1 points to max
            LDR R2, =MIN                    //  R2 points to min
            LDR R3, [R2, #4]                //  R3 holds the number of elements
            ADD R5, R2, #8                  //  R5 points to the first number
            LDR R0, [R5]                    //  R0 holds the first value in the list

LOOP:   
            SUBS R3, R3, #1                 //  decrement the loop counter
            BEQ DONE                        //  end loop if counter has reached 0
            ADD R5, R5, #4                  //  R5 points to next number in the list
            LDR R6, [R5]                    //  R6 Holdes the next number in the list
            CMP R0, R6                      //  check if it is greater than the maximum
            BGE LOOP                        //  if no, branch back to the loop
            MOV R0, R6                      //  if yes, update the current max
            B LOOP                          //  branch back to the loop

DONE:       
            STR R0, [R1]                    //  store the min to min
            LDR R3, [R2, #4]                //  Reset counter
            ADD R5, R2, #8                  //  Reset pointer
            LDR R0, [R5]                    //  Reset R0

LOOP_ii:    
            SUB R3, R3, #1                  //  decrement the loop counter
            BEQ DONE_ii                     //  end loop if counter has reached 0
            ADD R5, R5, #4                  //  R5 points to next number in the list
            LDR R6, [R5]                    //  R6 Holdes the next number in the list
            CMP R6, R0                      //  check if it is smaller than the minimum
            BGE LOOP_ii                     //  if no, branch back to the loop
            MOV R0, R6                      //  if yes, update the current max
            B LOOP_ii                       //  branch back to the loop

DONE_ii:
            STR R0, [R2]                    //  store the min to min
            LDR R1, =MAX                    //  load max result back to R1
            SUBS R1, [R1], R0               //  compute difference
            STR R1, [R4]                    //  load answer to RESULT


END:        B END                           //  infinite loop!

RESULT:     .word   0                       //  memory assigned for result
MAX:        .word   0                       //  memory assigned for max
MIN:        .word   100                     //  memory assigned for min
N:          .word   7                       //  number of entries in the list
NUMBERS:    .word   89,  73,  84,  91,      //  the list data  
            .word   87,  77,  94