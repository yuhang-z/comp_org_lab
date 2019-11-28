#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include "./drivers/inc/vga.h"
#include "./drivers/inc/ISRs.h"
#include "./drivers/inc/LEDs.h"
#include "./drivers/inc/audio.h"
#include "./drivers/inc/HPS_TIM.h"
#include "./drivers/inc/int_setup.h"
#include "./drivers/inc/wavetable.h"
#include "./drivers/inc/pushbuttons.h"
#include "./drivers/inc/ps2_keyboard.h"
#include "./drivers/inc/HEX_displays.h"
#include "./drivers/inc/slider_switches.h"
#include "./drivers/inc/audio1.h"
/*
int t = 0; // sample
int amplitude = 5;
int vol_gain = 5;
int key[] = {0,0,0,0,0,0,0,0}; // key status (0 released, 1 pressed)
int break_flag = 0; // flag for keyboard break code
// arrays to store signal
int C1[48000]; 
int D1[48000]; 
int E1[48000]; 
int F1[48000];
int G1[48000];
int A1[48000];
int B1[48000];
int C2[48000];

// t is each sample
// index is the total frequency, 48k(maximum) cycle
// table calculate the postion of the wave
int signal (double f, int t) {
	double multiplication;
	double table;
	double decimal;
	double sig;
	double integer;
	multiplication = f * t;
	decimal = modf(multiplication, &integer);
	integer = (int)integer % 48000;
	table = (1 - decimal) * sine[(int)integer] + decimal * sine[(int)integer + 1];
	sig = amplitude * table;
	return sig;
}

// calculate signals for all frequencies and sampling instants
void make_wave(){
	int t=0;	
	while (t<48000){
		C1[t]=signal(130.813,t);
		D1[t]=signal(146.832,t);
		E1[t]=signal(164.814,t);
		F1[t]=signal(174.614,t);
		G1[t]=signal(195.998,t);
		A1[t]=signal(220.000,t);
		B1[t]=signal(246.942,t);
		C2[t]=signal(261.626,t);
		t++;
	}t=0;
}


int main()
{
	make_wave(); // calculate all signals first
	
	double generated_sample = 0; // for feeding to the audio codec
    char data = 0;

	int_setup(1, (int []){199}); // 199 is Interrupt ID for HPS Timer 0

	// set up timer
	HPS_TIM_config_t hps_tim0;
	hps_tim0.tim = TIM0;
	hps_tim0.timeout = 20;     //1/48000 = 20us for each sample
	hps_tim0.LD_en = 1;
	hps_tim0.INT_en = 1;
	hps_tim0.enable = 1;
	HPS_TIM_config_ASM(&hps_tim0);

	//int i = 0; // used for for-loop
	while(1){
		if(hps_tim0_int_flag){ // if the flag detects an interrupt
			hps_tim0_int_flag = 0; // set flag from 1 to 0
			if (read_ps2_data_ASM(&data)){ // if there is data in keyboard buffer
				if (break_flag == 1){ // key released
					if (data == 0x1C) {key[0] = 0;} // A
					if (data == 0x1B) {key[1] = 0;} // S
					if (data == 0x23) {key[2] = 0;} // D
					if (data == 0x2B) {key[3] = 0;} // F
					if (data == 0x3B) {key[4] = 0;} // J
					if (data == 0x42) {key[5] = 0;} // K
					if (data == 0x4B) {key[6] = 0;} // L
					if (data == 0x4C) {key[7] = 0;} // ;
					if (data == 0x41) {vol_gain --;}// , to decrease volume
					if (data == 0x49) {vol_gain ++;}// . to increase volume
					break_flag = 0;
				}
				else{ // key pressed
					if (data == 0x1C) {key[0] = 1;} // A
					if (data == 0x1B) {key[1] = 1;} // S
					if (data == 0x23) {key[2] = 1;} // D
					if (data == 0x2B) {key[3] = 1;} // F					
					if (data == 0x3B) {key[4] = 1;} // J
					if (data == 0x42) {key[5] = 1;} // K
					if (data == 0x4B) {key[6] = 1;} // L
					if (data == 0x4C) {key[7] = 1;} // ;
					if (data == 0xF0) {break_flag = 1;} // check if the key is released
                }             
			}

			if(key[0]){							
				generated_sample +=  C1[t];
			}if(key[1]){
				generated_sample +=  D1[t];
			}if(key[2]){
				generated_sample +=  E1[t];
			}if(key[3]){
				generated_sample +=  F1[t];
			}if(key[4]){
				generated_sample +=  G1[t];
			}if(key[5]){
				generated_sample +=  A1[t];
			}if(key[6]){
				generated_sample +=  B1[t];
			}if(key[7]){
				generated_sample +=  C2[t];
			}			
			
			generated_sample *= vol_gain ;

			if(audio_write_data_ASM((int)generated_sample,(int)generated_sample)){
				t++;
			}

			if (t >= 48000){t = 0;}
			generated_sample = 0;
		}
		// limit amplitude
		 if (vol_gain > 10) {vol_gain = 10;}
        else if (vol_gain < 0) {vol_gain = 0;}
	}

	return 0;
}
*/