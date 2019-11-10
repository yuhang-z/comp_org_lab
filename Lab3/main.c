#include <stdio.h>
#include "./drivers/inc/LEDs.h"
#include "./drivers/inc/slider_switches.h"
#include "./drivers/inc/pushbuttons.h"
#include "./drivers/inc/HEX_displays.h"
#include "./drivers/inc/HPS_TIM.h"
#include "./drivers/inc/ISRs.h"
#include "./drivers/inc/int_setup.h"

int part0(){
	while(1){
		write_LEDs_ASM(read_slider_switches_ASM());
	}
	return 0;
}

int part1(){
	while (1) {
        int readInteger = read_slider_switches_ASM();
		write_LEDs_ASM(readInteger);		
        int toHEXDisplays = read_PB_data_ASM() & 0x0000000F;
        char readChar = (char)(readInteger & 0x0000000F);
        int isClear = readInteger & 0x00000200;
        if (isClear) {
            HEX_clear_ASM(HEX0 | HEX1 | HEX2 | HEX3 | HEX4 | HEX5);
        } else {
            HEX_flood_ASM(HEX4 | HEX5);
            HEX_write_ASM(toHEXDisplays, readChar);
    	}
	}
	return 0;
}

int part2(){
	unsigned int ms = 0, start = 0, s = 0, min = 0;
	HPS_TIM_config_t timer;
	timer.tim = TIM0;
	timer.timeout = 10000;
	timer.LD_en = 1;
	timer.INT_en = 1;
	timer.enable = 1;
	
	HPS_TIM_config_ASM(&timer);
	HEX_write_ASM(HEX0 | HEX1 | HEX2 | HEX3 | HEX4 | HEX5, 0);
	while(1){
		if (read_PB_edgecap_ASM()){
			if (PB_edgecap_is_pressed_ASM(PB0)){start = 1;}

			if (PB_edgecap_is_pressed_ASM(PB1)){start = 0;}
			
			if (PB_edgecap_is_pressed_ASM(PB2)) {
				start = 0;
				ms = 0;
				s = 0;
				min = 0;
				HEX_write_ASM(HEX0 | HEX1 | HEX2 | HEX3 | HEX4 | HEX5, 0);
			}
			
			PB_clear_edgecp_ASM(PB0);
			PB_clear_edgecp_ASM(PB1);
			PB_clear_edgecp_ASM(PB2);
		}
		if (start&&HPS_TIM_read_INT_ASM(TIM0)){
			HPS_TIM_clear_INT_ASM(TIM0);
			ms++;
			s += (ms%100==0&&ms!=0) ? 1 : 0;
			ms %= 100;
			min += (s%60==0&&s!=0) ? 1 : 0;
			s %= 60;
			min %= 100;
			HEX_write_ASM(HEX0, ms%10);
			HEX_write_ASM(HEX1, (ms/10)%10);
			HEX_write_ASM(HEX2, s%10);
			HEX_write_ASM(HEX3, (s/10)%10);
			HEX_write_ASM(HEX4, min%10);
			HEX_write_ASM(HEX5, (min/10)%10);
		}
	}
	return 0;
	/*
	int count0 = 0, count1 = 0, count2 = 0, count3 = 0;
	int start = 0;	
	HPS_TIM_config_t hps_tiM0;
	hps_tiM0.tim = TIM0;
	hps_tiM0.timeout = 1000000;
	hps_tiM0.LD_en = 1;
	hps_tiM0.INT_en = 1;
	hps_tiM0.enable = 1;
	
	HPS_TIM_config_t hps_tiM1;
	hps_tiM1.tim = TIM1;
	hps_tiM1.timeout = 1000000;
	hps_tiM1.LD_en = 1;
	hps_tiM1.INT_en = 1;
	hps_tiM1.enable = 1;
	HPS_TIM_config_t hps_tiM2;
	hps_tiM2.tim = TIM2;
	hps_tiM2.timeout = 1000000;
	hps_tiM2.LD_en = 1;
	hps_tiM2.INT_en = 1;
	hps_tiM2.enable = 1;
	HPS_TIM_config_t hps_tiM3;
	hps_tiM3.tim = TIM3;
	hps_tiM3.timeout = 1000000;
	hps_tiM3.LD_en = 1;
	hps_tiM3.INT_en = 1;
	hps_tiM3.enable = 1;
	HPS_TIM_config_ASM(&hps_tiM0);
	HPS_TIM_config_ASM(&hps_tiM1);
	HPS_TIM_config_ASM(&hps_tiM2);
	HPS_TIM_config_ASM(&hps_tiM3);
	
	HEX_write_ASM(HEX0, count0);
	HEX_write_ASM(HEX1, count0);
	HEX_write_ASM(HEX2, count0);
	HEX_write_ASM(HEX3, count0);
	while(1){
		if (read_PB_edgecap_ASM()){
			if (PB_edgecap_is_pressed_ASM(PB0)){start = 1;}
			if (PB_edgecap_is_pressed_ASM(PB1)){start = 0;}
			
			if (PB_edgecap_is_pressed_ASM(PB2)) {
				start = 0;
				count0 = 0;
				count1 = 0;
				count2 = 0;
				count3 = 0;
				HEX_write_ASM(HEX0, count0);
				HEX_write_ASM(HEX1, count0);
				HEX_write_ASM(HEX2, count0);
			}
			
			PB_clear_edgecp_ASM(PB0);
			PB_clear_edgecp_ASM(PB1);
			PB_clear_edgecp_ASM(PB2);
			PB_clear_edgecp_ASM(PB3);
		}
		if (start){
			if (HPS_TIM_read_INT_ASM(TIM0)){
				HPS_TIM_clear_INT_ASM(TIM0);
				count0++;
				count0%=16;
				HEX_write_ASM(HEX0, count0);
			}
			if (HPS_TIM_read_INT_ASM(TIM1)){
				HPS_TIM_clear_INT_ASM(TIM1);
				count1++;
				count1%=16;
				HEX_write_ASM(HEX1, count1);
			}
			if (HPS_TIM_read_INT_ASM(TIM2)){
				HPS_TIM_clear_INT_ASM(TIM2);
				count2++;
				count2%=16;
				HEX_write_ASM(HEX2, count2);
			}
			if (HPS_TIM_read_INT_ASM(TIM3)){
				HPS_TIM_clear_INT_ASM(TIM3);
				count3++;
				count3%=16;
				HEX_write_ASM(HEX3, count3);
			}
		}
	}
	return 0;
	*/
}

int part3(){
	int_setup(2, (int []){73, 199});

	enable_PB_INT_ASM(PB0 | PB1 | PB2);

    unsigned int ms = 0, start = 0, s = 0, min = 0;

	HPS_TIM_config_t hps_tim10ms;
	hps_tim10ms.tim = TIM0;
	hps_tim10ms.timeout = 10000;
	hps_tim10ms.LD_en = 1;
	hps_tim10ms.INT_en = 1;
	hps_tim10ms.enable = 1;

	HPS_TIM_config_ASM(&hps_tim10ms);
	HEX_write_ASM(HEX0 | HEX1 | HEX2 | HEX3 | HEX4 | HEX5, 0);
	while (1) {

		if (pushbtn_int_flag == 1) {

            start = 1;

            pushbtn_int_flag = 0;

        } else if (pushbtn_int_flag == 2) {

            start = 0;

            pushbtn_int_flag = 0;

        } else if (pushbtn_int_flag == 4) {

			start = 0;
			ms = 0;

            pushbtn_int_flag = 0;

			HEX_write_ASM(HEX0 | HEX1 | HEX2 | HEX3 | HEX4 | HEX5, 0);

		}

		if (start && hps_tim0_int_flag) {

			hps_tim0_int_flag = 0;
			ms++;
			s += (ms%100==0&&ms!=0) ? 1 : 0;
			ms %= 100;
			min += (s%60==0&&s!=0) ? 1 : 0;
			s %= 60;
			min %= 100;
			HEX_write_ASM(HEX0, ms%10);
			HEX_write_ASM(HEX1, (ms/10)%10);
			HEX_write_ASM(HEX2, s%10);
			HEX_write_ASM(HEX3, (s/10)%10);
			HEX_write_ASM(HEX4, min%10);
			HEX_write_ASM(HEX5, (min/10)%10);
			

		}

	}
	return 0;
}

int	main()	{
	/* Slider switches and LEDs program */
	//return part0();

	/* Basic I/O program */
	//return part1();
	
	/* Polling based stopwatch */
	//return part2();
	
	/* Interrupt based stopwatch */
	return part3();
}