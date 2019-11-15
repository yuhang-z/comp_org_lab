		.text
		.equ	PIX_BUFF,	0xC8000000
		.equ	CHR_BUFF,	0xC9000000
		.global	VGA_clear_charbuff_ASM
		.global	VGA_clear_pixelbuff_ASM
		.global	VGA_write_char_ASM
		.global	VGA_write_byte_ASM
		.global	VGA_draw_point_ASM

VGA_draw_point_ASM:
		//R0 for x
		//R1 for y
		//R2 for color in short
		PUSH 	{R3-R6}
		MOVW	R6,		#319
		CMP		R0,		#0
		BLT		BYE
		CMP		R0,		R6
		BGT		BYE
		CMP		R1,		#0
		BLT		BYE
		CMP		R1,		#239
		BGT		BYE
		LDR		R3,		=PIX_BUFF
		ADD		R4,		R0,		R1,		LSL		#9
		ADD		R5,		R3,		R4,		LSL		#1
		STRH 	R2, 	[R5]
		POP 	{R3-R6}
		B		BYE

CHR_BUFF_SNT_CHK:
		BX		LR		

VGA_write_byte_ASM:
		//R0 for x
		//R1 for y
		//R2 for char
		PUSH	{R3-R7}
		CMP		R0,		#0
		BLT		BYE
		CMP		R0,		#79
		BGT		BYE
		CMP		R1,		#0
		BLT		BYE
		CMP		R1,		$59
		BGT		BYE
		ADD 	R3, 	R0, 	R1, 	LSL 	#7
		LDR		R4,		=CHR_BUFF
		ADD		R4,		R4,		R3
		AND		R5,		R2,		#0xF	//Right
		AND		R6,		R2,		#0xF0	//Left
		LSR		R6,		#4
		CMP		R5,		#0xF
		POPGT	{R3-R7}
		BGT		BYE
		CMP		R6,		#0xF
		POPGT	{R3-R7}
		BGT		BYE
		CMP		R5,		#0
		POPLT	{R3-R7}
		BLT		BYE
		CMP		R6,		#0
		POPLT	{R3-R7}
		BLT		BYE
		LDR		R2,		=DIC
		LDRB	R1,		[R2,	R5]
		LDRB	R0,		[R2,	R6]
		STRB	R0,		[R4]
		STRB	R1,		[R4,	#1]
		POP		{R3-R7}
		B		BYE

VGA_write_char_ASM:
		PUSH 	{R3-R5}
		CMP		R0,		#0
		BLT		BYE
		CMP		R0,		#79
		BGT		BYE
		CMP		R1,		#0
		BLT		BYE
		CMP		R1,		#59
		BGT		BYE
		LDR 	R5, 	=CHR_BUFF
		ADD 	R3, 	R0, 	R1, 	LSL 	#7
		ADD 	R3, 	R3, 	R5
		STRB 	R2, 	[R3]
		POP 	{R3-R5}
BYE: 	BX 		LR

VGA_clear_charbuff_ASM:
		//R0 for x
		//R1 for y
		PUSH	{R0-R5}
		MOV		R2,		#0
		LDR		R3,		=CHR_BUFF
		MOV		R1,		#59
CBRF:	MOV		R0,		#79
CAL:	ADD		R4,		R0,		R1,		LSL		#7
		ADD		R5,		R4,		R3
		STRB	R2,		[R5]
		SUBS	R0,		R0,		#1
		BGE		CAL
		CMP		R1,		#0
		POPEQ	{R0-R5}
		BEQ		BYE
		SUBS	R1,		R1,		#1
		B		CBRF

VGA_clear_pixelbuff_ASM:
		//R0 for x
		//R1 for y
		PUSH	{R0-R5}
		MOV		R2,		#0
		LDR		R3,		=PIX_BUFF
		MOV		R1,		#239
PIRF:	MOVW	R0,		#319
CAL2:	ADD		R4,		R0,		R1,		LSL		#9
		ADD		R5,		R3,		R4,		LSL		#1
		STRH	R2,		[R5]
		SUBS	R0,		R0,		#1
		BGE		CAL2
		CMP		R1,		#0
		POPEQ	{R0-R5}
		BEQ		BYE
		SUBS	R1,		R1,		#1
		B		PIRF

DUMMY:
		BX		LR


DIC:	.byte	48, 49, 50, 51, 52, 53, 54, 55, 56, 57, 65, 66, 67, 68, 69, 70
		
		.end
