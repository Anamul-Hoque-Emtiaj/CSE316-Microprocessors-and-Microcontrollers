/*
 * GccApplication1.c
 *
 * Created: 12/12/2022 3:02:50 PM
 * Author : anamu
 */ 
#define F_CPU 1000000
#include<util/delay.h>
#include <avr/io.h>


int main(void)
{
	int led_a = 1;
    /* Replace with your application code */
    DDRA = 0b00110000;
	PORTA = 0;
	while (1) 
    {
		led_a = !led_a;
		PORTA = 0;
		if(led_a) PORTA = (1 << 5);
		if(!led_a) PORTA = (1 << 6);
		_delay_ms(1000);
    }
}

