		.text
		.equ	PIX_BUFF,	0xC8000000
		.equ	CHR_BUFF,	0xC9000000
		.global	VGA_clear_charbuff_ASM
		.global	VGA_clear_pixelbuff_ASM
		.global	VGA_write_char_ASM
		.global	VGA_write_byte_ASM
		.global	VGA_draw_point_ASM

VGA_write_byte_ASM:
		PUSH	{LR}
		BL		CHR_BUFF_SNT_CHK
		//todo
		POP		{LR}
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
		PUSH	{LR}
		BL		CHR_BUFF_SNT_CHK
		LSL		R1,		#7
		ORR		R1,		R1,		R2
		LDR		R3,		=CHR_BUFF
		ORR		R3,		R3,		R1
		STR		R2,		[R3]
		POP		{LR}
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
		B	DUMMY

DIC:	.byte	0x30, 0x31, 0x32, 0x33, 0x34, 0x35, 0x36, 0x37, 0x38, 0x39, 0x41, 0x42, 0x43, 0x44, 0x45, 0x46
		
		.end
