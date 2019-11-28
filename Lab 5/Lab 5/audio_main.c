#include <stdio.h>

#include "./drivers/inc/audio1.h"


int main() {

	int frequency = 100;
	int sample_rate = 48000;
	int half_cycle = sample_rate / (frequency * 2);
	int x = 0;
	int y = 0;

	while(1){
		while (x < half_cycle){
        	if(write_audio_ASM(0x00FFFFFF))
                   x++;
         }
		while (y < half_cycle){
        	if(write_audio_ASM(0x00000000))
                   y++;
         }
		x = 0;
		y = 0;
	}

	return 0;
}
