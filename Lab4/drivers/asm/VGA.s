		.text
		.equ	PIX_BUFF,	0xC8000000
		.global	VGA_clear_charbuff_ASM
		.global	VGA_clear_pixelbuff_ASM
		.global	VGA_write_char_ASM
		.global	VGA_write_byte_ASM
		.global	VGA_draw_point_ASM

VGA_clear_charbuff_ASM:

VGA_clear_pixelbuff_ASM:
		PUSH	{R0-R3,	LR}
		LDR		R0,		#239
		LDR		R1,		#319
		BL		PB_CL_LP
		POP		{LR, R3, R2, R1, R0}
		BX		LR
PB_CL_LP:
		CMP		R0,		#0
		BXLT	LR
		CMP		R1,		#0
		MOVLT	R1,		#319
		SUBLT	R0,		R0,		#1
		MOV		R2,		R0
		LSL		R2,		#10
		AND		R2,		R1
		LSL		R2,		#1
		LDR		R3,		=PIX_BUFF
		ADD		R3,		R3,		R2
		LDR		R2,		[R3]
		AND		R2,		R2,		#0
		STR		R2,		[R3]
		SUB		R1,		R1,		#1
		B		PB_CL_LP