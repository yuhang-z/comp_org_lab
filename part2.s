		 	.text 
			.global _start 

_start:
			LDR R4, =SMALLESTN	//R4 points to the updating samllest value  
			LDR R5, =LARGESTN	//R5 points to the updating largest value
			LDR R2, [R4, #8] 	//R2 holds the number of elements in the list 
			ADD R3, R4, #8		//R3 points to the first number -->moving pointer 
			LDR R0, [R3]  		//R0 holds the first number in the list 
			SUBS R6, R5, R4		//R6 stores the computed range 

LOOP: 		SUBS R2, R2, #1 	//decrement the loop counter
			BEQ DONE 			//end loop if the counter is reached 0 
			ADD R3, R3, #4		//R3 points to the next number in the list
			LDR R1, [R3]		//R1 holds the next number in the list 
			CMP R5, R1 			//check if it is greater than the max 
			BGE X 				//BGE stands for --if greater or equal, then --
            CMP R1, R4			//check if it is samller that the min
			BGE LOOP 			//if no, branch back to the loop
			MOV R4, R1
X:			MOV R5, R1 			//set instruction
//Y:			MOV R4, R1			//set instruction
			
			B LOOP 				// branch back to the loop 

DONE: 		STR R4, [R4]		//store the result to the memory location 
			STR R5, [R5]		//store the result to the memory location 

END: 		B END 				//infinite loop!

LARGESTN:	.word	0			//memory assigned for the largest number searched 
SMALLESTN:	.word 	0			//memory assigned for the smallest number searched
N: 			.word 	7 			//number of entries in the list 
NUMBERS:	.word	89, 71, 84, 91	//the list data 
			.word 	87, 77, 91	

