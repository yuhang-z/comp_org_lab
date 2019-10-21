			.text
			.global _start

_start:		
			MOV R0, #89
			MOV R1, #71 
			MOV R2, #84 

			MOV R3, #91 

			PUSH {R3}
			MOV R3, #27
			PUSH {R3}
			
			

			BL FIND_MIN

			POP {R1}
			POP {R2}
			BL FIND_MIN 

			
			
			STR R0, [R0]

END:		
			B END
			 

FIND_MIN:	
			CMP R0, R1
			BGE X 

A:			
			CMP R0, R2
			BGE Y
			B Z

X:			
			MOV R0, R1
			B A

Y:			
			MOV R0, R2

Z:			
			BX LR

