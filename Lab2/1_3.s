			.text
			.global _start

_start:
			LDR		R0,		N		
			LDR		R1,		=RESULT
			B		FAC

FAC:
			CMP R0, #0      
        	MOVEQ R0, #1
        	MOVEQ PC, LR
        	MOV R2, R0
        	SUB R0, R0, #1
			SUB	SP,	SP,	#8
			STR	LR,	[SP, #4]
			STR	R2,	[SP]
        	BL FAC
			LDR	R2,	[SP]
        	MUL R0, R2, R0
			LDR	LR,	[SP, #4]
			ADD	SP,	SP,	#8
        	MOV PC, LR
						
END:		
			STR		R0,		[R1]
			B 		END


N:			.word	2			//N to be computed
RESULT:		.word	-1			//Result
