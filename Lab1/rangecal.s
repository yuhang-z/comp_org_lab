  		 	.text 
			.global _start 

_start:
			LDR R6, =RESULT			//R6 points to the RESULT location 
			LDR R5, [R6, #4]		//R5 stores the content of the largest number 
			LDR R4, [R6, #8]		//R4 stores the content of the smallest number 
			LDR R2, [R6, #12] 		//R2 holds the number of elements in the list 
			ADD R3, R6, #16			//R3 points to the first number -->moving pointer 
			LDR R0, [R3]  			//R0 holds the first number in the list--> content 

LOOP: 			CMP R0, R5			//LARGGEST 
			BGE X
			CMP R0, R4
			BGE Y
			MOV R4, R0
			B Y
X:			MOV R5, R0 
Y:			SUBS R2, R2, #1 		//decrement the loop counter
			BEQ DONE 			//end loop if the counter is reached 0
			ADD R3, R3, #4			//R3 points to the next number in the list
			LDR R0, [R3]		
			B LOOP 

DONE: 			SUBS R5, R5, R4		        //R5 stores the computed range 
			STR R5, [R6]			//store the result to the memory location 

END: 			B END 				//infinite loop!

RESULT:         .word   0                    	 	// RESULT 
LNUM:		.word	0				//memory assigned for the largest number searched 
SNUM:		.word 	100				//memory assigned for the smallest number searched
N: 		.word 	7 				//number of entries in the list 
NUMBERS:	.word	89, 71, 84, 91	      	 	//the list data 
		.word 	87, 77, 91
