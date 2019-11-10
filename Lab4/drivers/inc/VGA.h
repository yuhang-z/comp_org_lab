#ifndef __VGA
#define __VGA
	
	extern	void VGA_clear_charbuff_ASM();
	extern	void VGA_clear_pixelbuff_ASM();

	extern	void VGA_write_char_ASM(int x, int y, char c);
	extern	void VGA_write_byte_ASM(int x, int y, char byte);
	
	extern	void VGA_draw_point_ASM(int x, int y, short colour);

#endif
