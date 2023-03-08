/*
 * GccApplication2.c
 *
 * Created: 12/19/2022 2:35:42 PM
 * Author : anamu
 */ 
#define F_CPU 1000000
#include <avr/io.h>
#include <util/delay.h>
#include <avr/io.h>

char row[8] = {1, 2, 4, 8, 16, 32, 64, 128};
char col[8] = {
	0x00,0x1c,0x22,0x02,0x02,0x22,0x1c,0x00
};

void rotateleft(char col[],int nc){
	for(int i=0;i<nc;i++){
		if(( col[i] & 0b00000001 ) ==  0b00000001){
			col[i]=(col[i]>>1) + 0b10000000;
		}
		else{
			col[i]=(col[i]>>1);
		}
		
	}
}

int main(void)
{
	DDRA = 0xFF;
	DDRB = 0xFF;
	DDRD = 0;

    while (1) 
    {
		rotateleft(col, 8);
		for(int j = 0; j < 100; j++){
			for(int i = 0; i < 8; i++){
				PORTA = row[i];
				PORTB = ~col[i];
				_delay_ms(2);
			}
			// _delay_ms(5);
		}
		
    }
}

