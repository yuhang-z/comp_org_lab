#include	<stdio.h>
#include	"./drivers/inc/VGA.h"

int	main(){
	VGA_write_char_ASM(1, 2, 'a');
	return	0;
}
