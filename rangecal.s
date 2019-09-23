            .text
            .global _start

_start:
            LDR R0, =MIN                //Load the value of MIN to R0
            LDR R1, [R0, #4]            //Load the value of MAX to R1
            ADD R2, R0, #8              //Load the address of N
            LDR R3, R2, #4            //Load the value of the first score

LOOP:
            SUBS R2, R2, #1             //"i = i - 1"
            BEQ DONE                    //If true, terminate this program
            LDR R4, [R3]                //Load the value of the pointer (R3) of the list (current score)
            ADD R3, R3, #4              //Load the address of the next score
            B CHECK_MAX                 //Jump to branch CHECH_MAX

CHECK_MAX:
            CMP R0, R4                  //Compare max with score
            BGE CHECK_MIN               //Check min
            MOV R0, R4                  //Load the score to R0
            B CHECH_MIN                 //Jump to check min

CHECK_MIN:
            CMP R4, R1                  //Compare score and max
            BGE LOOP                    //Back to loop
            MOV R1, R4                  //Load score to max
            B LOOP                      //Jump to the loop

DONE:       SUBS R5, R1, R0

MIN:        .word 100
MAX:        .word 0
N:          .word 7
SCORE:      .word 89, 73, 84, 91
            .word 87, 77, 94