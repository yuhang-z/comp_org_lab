			.text
			
			.equ CONTROL, 0xFF203040
			.equ FIFO, 0xFF203044
			.equ LEFT_DATA, 0xFF203048
			.equ RIGHT_DATA, 0xFF20304C
			.global write_audio_ASM

write_audio_ASM:
			LDR R1, =FIFO
			LDRB R2, [R1, #2]		// Load the address of WSRC
			LDRB R3, [R1, #3]		// Load the address of WSLC
			
			CMP R2, #0			// Compare R2 with the minimum space 0
			BEQ audio_end			
			CMP R3, #0			// Compare R3 with the minimum space 0
			BEQ audio_end

			LDR R4, =LEFT_DATA		// Load the address of LEFT_DATA
			LDR R5, =RIGHT_DATA		// Load the address of RIGHT_DATA
			STR R0, [R4]			// Store input value to R4
			STR R0, [R5]			// Store input value to R5
			MOV R0, #1				// return 1
			BX LR					// Exit

audio_end:
			MOV R0, #0				// If there is no space to write, return 0
			BX LR					// Exit

			.end
