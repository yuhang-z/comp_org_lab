		.text
		.global	_start

_start:
			LDR	R0,	=MIN			//	R0 points to MIN
			LDR	R1,	=MAX			//	R1 points to MAX
			LDR	R2,	=LIST			//	R2 points to the first item in LIST
			LDR R3, [R2]			//	Load value of LIST[0] to R3
			LDR R4, [R2, #4]		//	Load value of LIST[1] to R4
			LDR R5, [R2, #8]		//	Load value of LIST[2] to R5
			LDR R6, [R2, #12]		//	Load value of LIST[3] to R6
			LDR R7, =RESULT			//  R7 points to RESULT[0]
			
CALCULATE:	
			ADD R8, R3, R4			//	R8 = LIST[0] + LIST[1]
			ADD R9, R5, R6			//	R9 = LIST[2] + LIST[3]
			MUL R10, R8, R9			//	R10 = R8 * R9
			STR R10, [R7]			// 	Store R10 to RESULT[0]
			ADD R7, R7, #4			//	R7 points to RESULT[1]
			
			ADD R8, R3, R5			//	R8 = LIST[0] + LIST[2]
			ADD R9, R4, R6			//	R9 = LIST[1] + LIST[3]
			MUL R10, R8, R9			//	R10 = R8 * R9
			STR R10, [R7]			// 	Store R10 to RESULT[1]
			ADD R7, R7, #4			//	R7 points to RESULT[2]
			
			ADD R8, R3, R6			//	R8 = LIST[0] + LIST[3]
			ADD R9, R4, R5			//	R9 = LIST[1] + LIST[2]
			MUL R10, R8, R9			//	R10 = R8 * R9
			STR R10, [R7]			// 	Store R10 to RESULT[1]

PREPARE:	
			LDR R7, =RESULT			//  R7 points to RESULT[0]
			LDR R2, N				//	Load value of N to R2
			LDR R3, [R7]			// 	Load RESULT[0] to R3

FIND_MAX:	
			SUBS R2, R2, #1			//	Decrement
			BEQ STORE_MAX			//	Store value of MAX
			ADD R7, R7, #4			//	R7 points to the next element in RESULT
			LDR R8, [R7]			//	Load the value of next element in RESULT to R8
			CMP R3, R8				//	Compare
			BGE	FIND_MAX			//	R3 >= R8, continue
			MOV R3, R8				//	Save R8 at R3
			B FIND_MAX

STORE_MAX:
			STR R3, [R1]			//	Store value to MAX
			LDR R7, =RESULT			//  R7 points to RESULT[0]
			LDR R2, N				//	Load value of N to R2
			LDR R3, [R7]			// 	Load RESULT[0] to R3

FIND_MIN:	
			SUBS R2, R2, #1			//	Decrement
			BEQ STORE_MIN			//	Store value of MAX
			ADD R7, R7, #4			//	R7 points to the next element in RESULT
			LDR R8, [R7]			//	Load the value of next element in RESULT to R8
			CMP R8, R3				//	Compare
			BGE	FIND_MIN			//	R8 >= R3, continue
			MOV R3, R8				//	Save R8 at R3
			B FIND_MIN			

STORE_MIN:
			STR R3, [R0]			//	Store value to MAX

DONE:		
			B DONE

MIN:		.word	100
MAX:		.word	0
LIST:		.word	4, 2, 1, 3
RESULT:		.word	0, 0, 0
N:			.word 	3