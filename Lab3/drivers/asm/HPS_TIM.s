	.text
	
	.global HPS_TIM_config_ASM
	.global HPS_TIM_clear_INT_ASM
	.global HPS_TIM_read_INT_ASM

HPS_TIM_config_ASM:
	PUSH {R4-R7, LR}
	MOV R1, #0		//HPS_TIM_t offset
	MOV R2, #1		//Used to determine HPS_TIM_t
	LDR R7, [R0]	//Contents in Construct
	B LOOP

LOOP:
	TST R7, R2, LSL R1		//Chcek if find the corresponding HPS_TIM_t
	BEQ CONTINUE
	BL CONFIG

CONTINUE:
	ADD R1, R1, #1
	CMP R1, #4
	BLT LOOP

DONE:
	POP {R4-R7, LR}
	BX LR


CONFIG:
	PUSH {LR}
	
	LDR R3, =HPS_TIM_BASE		//Pointer of lists of timer
	LDR R4, [R3, R1, LSL #2]	//Find corresponding HPS Timer
	
	BL DISABLE
	BL SET_LOAD_VAL
	BL SET_LOAD_BIT
	BL SET_INT_BIT
	BL SET_EN_BIT
	
	POP {LR}
	BX LR 

DISABLE:
	LDR R5, [R4, #0x8]		//load control memory to R5
	AND R5, R5, #0xFFFFFFFE	//Set E to 0
	STR R5, [R4, #0x8]		//Write back to control memory
	BX LR
	
SET_LOAD_VAL:
	LDR R5, [R0, #0x4]		//load timeout to R5
	MOV R6, #25				//load 11001 to R6
	MUL R5, R5, R6			//R5 x R6
	CMP R1, #2				//change load value if use 50MHz timer
	LSLLT R5, R5, #2
	STR R5, [R4]			//load to load value memory
	BX LR
	
SET_LOAD_BIT:
	LDR R5, [R4, #0x8]		//load control memory to R5
	LDR R6, [R0, #0x8]		//load LD_en to R6
	AND R5, R5, #0xFFFFFFFD	//set M to 0
	ORR R5, R5, R6, LSL #1	//write LD_en to M
	STR R5, [R4, #0x8]		//write control memory back
	BX LR
	
SET_INT_BIT:
	LDR R5, [R4, #0x8]		//load control memory to R5
	LDR R6, [R0, #0xC]		//load INT_en to R6
	EOR R6, R6, #0x00000001	
	AND R5, R5, #0xFFFFFFFB	//Set I to 0
	ORR R5, R5, R6, LSL #2	//write INT_en to I
	STR R5, [R4, #0x8]
	BX LR
	
SET_EN_BIT:
	LDR R5, [R4, #0x8]		//load control memory to R5
	LDR R6, [R0, #0x10]		//load enable to R6
	AND R5, R5, #0xFFFFFFFE	//Set E to 0
	ORR R5, R5, R6			//Write enable to E
	STR R5, [R4, #0x8]		//Write control memory back
	BX LR

HPS_TIM_clear_INT_ASM:
	PUSH {LR}
	MOV R1, #0
	MOV R2, #1
	B CLEAR_INT_LOOP

CLEAR_INT_LOOP:
	TST R0, R2, LSL R1
	BEQ CLEAR_INT_CONTINUE
	BL CLEAR_INT

CLEAR_INT_CONTINUE:
	ADD R1, R1, #1
	CMP R1, #4
	BLT CLEAR_INT_LOOP
	B CLEAR_INT_DONE

CLEAR_INT_DONE:
	POP {LR}
	BX LR

CLEAR_INT:
	LDR R3, =HPS_TIM_BASE
	LDR R3, [R3, R1, LSL #2]
	LDR R3, [R3, #0xC]
	BX LR

HPS_TIM_read_INT_ASM:
	PUSH {LR}
	PUSH {R4}
	MOV R1, #0
	MOV R2, #1
	MOV R4, #0
	B READ_INT_LOOP

READ_INT_LOOP:
	TST R0, R2, LSL R1
	BEQ READ_INT_CONTINUE
	BL READ_INT

READ_INT_CONTINUE:
	ADD R1, R1, #1
	CMP R1, #4
	BEQ READ_INT_DONE
	LSL R4, R4, #1
	B READ_INT_LOOP
	
READ_INT_DONE:
	MOV R0, R4
	POP {R4}
	POP {LR}
	BX LR

READ_INT:
	LDR R3, =HPS_TIM_BASE
	LDR R3, [R3, R1, LSL #2]
	LDR R3, [R3, #0x10]
	AND R3, R3, #0x1
	EOR R4, R4, R3
	BX LR
	
HPS_TIM_BASE:
	.word 0xFFC08000, 0xFFC09000, 0xFFD00000, 0xFFD01000

	.end
