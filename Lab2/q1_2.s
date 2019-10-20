			.text
			.global _start

_start:		MOV R0, #89
			MOV R1, #71 
			MOV R2, #84 
			MOV R3, #91 

			MOV R4, #87
			PUSH {R4}
			MOV R4, #77
			PUSH {R4}
			MOV R4, #91
			PUSH {R4}
			

			BL FIND_MIN

			LDR R1, [R3]
			POP {R2}
			BL FIND_MIN 

			POP {R2}
			POP {R3}
			BL FIND_MIN 
			
			STR R0, [R0]

END:		B END
			 

FIND_MIN:	CMP R0, R1
			BGE X 
A:			CMP R0, R2
			BGE Y
			B Z
X:			MOV R0, R1
			B A
Y:			MOV R0, R2
Z:			BX LR
	

NUMBERS:	.word	89, 71, 84, 91,	87, 77, 91
