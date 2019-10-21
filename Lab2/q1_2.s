			.text
			.global _start

_start:		
			MOV R0, #89		//to assign three numbers to 3 independent registers
			MOV R1, #71 
			MOV R2, #84 

			MOV R3, #91 		//to build a stack on register,R3,with built in function "PUSH"
			PUSH {R3}
			MOV R3, #27
			PUSH {R3}
			
			

			BL FIND_MIN		//do comparision 

			POP {R1}		//extract numbers from the stack 
			POP {R2}
			BL FIND_MIN 

			
			STR R0, [R0]		//store min_value in the according memory address 

END:			B END
			 

FIND_MIN:		CMP R0, R1
			BGE X 

A:			CMP R0, R2
			BGE Y
			B Z

X:			MOV R0, R1
			B A

Y:			MOV R0, R2

Z:			BX LR
