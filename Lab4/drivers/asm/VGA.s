		.text
		.equ	PIX_BUFF,	0xC8000000
		.equ	CHR_BUFF,	0xC9000000
		.global	VGA_clear_charbuff_ASM
		.global	VGA_clear_pixelbuff_ASM
		.global	VGA_write_char_ASM
		.global	VGA_write_byte_ASM
		.global	VGA_draw_point_ASM

VGA_write_char_ASM:
		CMP		R0,		#1
		MOVEQ	R4,		#12
		B	DUMMY

VGA_clear_charbuff_ASM:
		PUSH	{R0-R3,	LR}
		MOV		R0,		#59
		MOV		R1,		#79
		BL		CB_CL_LP
		POP		{R0-R3,	LR}
		BX		LR

CB_CL_LP:
		PUSH	{LR}
		B		CB_CL_INNER_LP
		POP		{LR}
		SUB		R0,		R0,		#1
		CMP		R0,		#0
		BXLT	LR
		MOV		R1,		#79
		B		CB_CL_LP

CB_CL_INNER_LP:
		CMP		R1,		#0
		BXLT	LR
		MOV		R2,		R0
		LSL		R2,		#7
		ORR		R2,		R2,		R1
		LDR		R3,		=CHR_BUFF
		ADD		R3,		R3,		R2
		LDR		R2,		[R3]
		AND		R2,		R2,		#0
		STR		R2,		[R3]
		SUB		R1,		R1,		#1
		B		CB_CL_INNER_LP

VGA_clear_pixelbuff_ASM:
		PUSH	{R0-R3,	LR}
		MOV		R0,		#239
		MOV		R1,		#1
		LSL		R1,		#8
		ORR		R1,		R1,		#63
		BL		PB_CL_LP
		POP		{R0-R3,	LR}
		BX		LR

PB_CL_LP:
		PUSH	{LR}
		B		PB_CL_INNER_LP
		POP		{LR}
		SUB		R0,		R0,		#1
		CMP		R0,		#0
		BXLT	LR
		MOV		R1,		#1
		LSL		R1,		#8
		ORR		R1,		R1,		#63
		B		PB_CL_LP

PB_CL_INNER_LP:
		CMP		R1,		#0
		BXLT	LR
		MOV		R2,		R0
		LSL		R2,		#9
		ORR		R2,		R2,		R1
		LSL		R2,		#2
		LDR		R3,		=PIX_BUFF
		ADD		R3,		R3,		R2
		LDR		R2,		[R3]
		AND		R2,		R2,		#0
		STR		R2,		[R3]
		SUB		R1,		R1,		#1
		B		PB_CL_INNER_LP

DUMMY:
		B	DUMMY

		.end
