			.text
			.global _start

_start:
			LDR		R0,		N		
			LDR		R1,		=RESULT
			MOV		R2,		#1
			BL		FAC
			B		END

FAC:
			CMP 	R0, 	#0      
        	MOVLE	R0,		#1
        	MOVLE 	PC, 	LR
			MOV		R2,		R0
			SUB		R0,		R0,		#1
			PUSH	{LR,	R2}
			BL		FAC
			POP		{R2}
			MUL		R0,		R2,		R0
			POP		{PC}
						
END:		
			STR		R0,		[R1]
			B 		END


N:			.word	5			//N to be computed
RESULT:		.word	0			//Result
