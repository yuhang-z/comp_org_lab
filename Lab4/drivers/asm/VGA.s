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
		PUSH	{R3-R8, LR}
		BL		CHR_BUFF_SNT_CHK
		LSL		R1,		#9
		ORR		R1,		R1,		R0
		LSL		R1,		#1
		LDR		R3,		=PIX_BUFF
		ORR		R3,		R3,		R1
		STRH	R2,		[R3]
		POP		{R3-R8,	LR}
		BX		LR
		

VGA_write_byte_ASM:
		//R0 for x
		//R1 for y
		//R2 for char
		PUSH	{R3-R8, LR}
		BL		CHR_BUFF_SNT_CHK
		LSL		R1,		#7
		ORR		R1,		R1,		R0
		LDR		R3,		=CHE_BUFF
		ORR		R3,		R3,		R1
		AND		R4,		R2,		#0xF
		CMP		R4,		#0xF
		BGT		DUMMY
		CMP		R4,		#0
		BLT		DUMMY
		AND		R5,		R2,		#0xF0
		LSR		R5,		R5,		#4
		CMP		R5,		#0xF
		BGT		DUMMY
		CMP		R5,		#0
		BLT		DUMMY
		LDR		R6,		=DIC
		LDRB	R7,		[R6,	R4]
		LDRB	R8,		[R6,	R5]
		STRB	R8,		[R3]
		STRB	R7,		[R3,	#1]
		POP		{R3-R8, LR}
		BX		LR

CHR_BUFF_SNT_CHK:
		CMP		R0,		#0
		BLT		DUMMY
		CMP		R0,		#79
		BGT		DUMMY
		CMP		R1,		#0
		BLT		DUMMY
		CMP		R1,		$59
		BGT		DUMMY
		BX		LR

VGA_write_char_ASM:
		//R0 for x
		//R1 for y
		//R2 for char
		PUSH	{R3-R8, LR}
		BL		CHR_BUFF_SNT_CHK
		LSL		R1,		#7
		ORR		R1,		R1,		R2
		LDR		R3,		=CHR_BUFF
		ORR		R3,		R3,		R1
		STR		R2,		[R3]
		POP		{R3-R8, LR}
		BX		LR

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
		ORR		R3,		R3,		R2
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
		ORR		R3,		R3,		R2
		LDR		R2,		[R3]
		AND		R2,		R2,		#0
		STR		R2,		[R3]
		SUB		R1,		R1,		#1
		B		PB_CL_INNER_LP

DUMMY:
		POP		{R3-R8, LR}
		BX		LR

DIC:	.byte	48, 49, 50, 51, 52, 53, 54, 55, 56, 57, 65, 66, 67, 68, 69, 70
		
		.end
