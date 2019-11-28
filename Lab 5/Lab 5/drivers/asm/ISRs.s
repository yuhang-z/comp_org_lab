	.text
	
	.global hps_tim0_int_flag
	.global button_interrupt_flag
	.global A9_PRIV_TIM_ISR
	.global HPS_GPIO1_ISR
	.global HPS_TIM0_ISR
	.global HPS_TIM1_ISR
	.global HPS_TIM2_ISR
	.global HPS_TIM3_ISR
	.global FPGA_INTERVAL_TIM_ISR
	.global FPGA_PB_KEYS_ISR
	.global FPGA_Audio_ISR
	.global FPGA_PS2_ISR
	.global FPGA_JTAG_ISR
	.global FPGA_IrDA_ISR
	.global FPGA_JP1_ISR
	.global FPGA_JP2_ISR
	.global FPGA_PS2_DUAL_ISR

A9_PRIV_TIM_ISR:
	BX LR
	
HPS_GPIO1_ISR:
	BX LR
	
HPS_TIM0_ISR:
    PUSH {LR}
	MOV R0, #0x1
	BL HPS_TIM_clear_INT_ASM
	LDR R0, =hps_tim0_int_flag // interrrupt status address
	MOV R1, #1
	STR R1, [R0]   //enable interrupt
	POP {LR} 
	BX LR
	
HPS_TIM1_ISR:
	BX LR
	
HPS_TIM2_ISR:
	BX LR
	
HPS_TIM3_ISR:
	BX LR
	
FPGA_INTERVAL_TIM_ISR:
	BX LR
	
FPGA_PB_KEYS_ISR:
//first call the subroutine read_PB_edgecap_ASM to find out which pushbutton is pressed
//and then set the flag when the interrupt is done
// then clear the edgecap for the next run
    PUSH {LR}
	BL read_PB_edgecap_ASM       // get the interrupt information  //get putshbutton was pressed
	//BL PB_edgecap_is_pressed_ASM // read the interrupt information
	LDR R1, =button_interrupt_flag
	STR R0, [R1]                 // store info to flag
	BL PB_clear_edgecp_ASM       // clear
	POP {LR}
	BX LR
	
FPGA_Audio_ISR:
	BX LR
	
FPGA_PS2_ISR:
	BX LR
	
FPGA_JTAG_ISR:
	BX LR
	
FPGA_IrDA_ISR:
	BX LR
	
FPGA_JP1_ISR:
	BX LR
	
FPGA_JP2_ISR:
	BX LR
	
FPGA_PS2_DUAL_ISR:
	BX LR
	
hps_tim0_int_flag:
    .word 0x0

button_interrupt_flag:
    .word 0x0	
	
	.end
