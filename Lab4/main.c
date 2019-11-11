#include	<stdio.h>
#include	"./drivers/inc/VGA.h"
#include	"./drivers/inc/pushbuttons.h"
#include	"./drivers/inc/slider_switches.h"

int	part2(){
	int	x = 0;
	int y = 0;
	char read;
	VGA_clear_charbuff_ASM();
	VGA_clear_pixelbuff_ASM();
	while(1){
		if	(read_PS2_data_ASM(&read)){
			VGA_write_byte_ASM(x, y, read);
			if (x == 78){
				y+=1;
				y%=60;
			}
			x+=3;
			x%=81;
		}
	}
	return	0;
}

void test_char(){
	int x, y;
	char c = 0;
	for	(y=0; y<=59; y++)
		for	(x=0; x<=79; x++)
			VGA_write_char_ASM(x, y, c++);
}

void test_byte(){
	int x, y;
	char c = 0;
	for	(y=0; y<=59; y++)
		for	(x=0; x<=79; x+=3)
			VGA_write_byte_ASM(x, y, c++);
}

void test_pixel(){
	int x, y;
	unsigned short colour = 0;
	for	(y=0; y<=59; y++)
		for	(x=0; x<=79; x++)
			VGA_draw_point_ASM(x, y, colour++);
}

int	part1(){
	VGA_clear_charbuff_ASM();
	VGA_clear_pixelbuff_ASM();
	
	while(1){
		printf("1");
		int btn = read_PB_data_ASM();
		if	(btn & PB0){
			if (read_slider_switches_ASM() != 0){
				test_byte();
			} else {
				test_char();
			}
		}
		if	(btn & PB1){
			test_pixel();
		}
		if	(btn & PB2){
			VGA_clear_charbuff_ASM();
		}
		if	(btn & PB3){
			VGA_clear_pixelbuff_ASM();
		}
	}

	return	0;
}

int	main(){
	/* VGA application */
	return part1();
	
	/* Keyboard */
	//return part2();
}
