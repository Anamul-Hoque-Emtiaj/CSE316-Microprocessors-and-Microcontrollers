#ifndef F_CPU
#define F_CPU 16000000UL // 16 MHz clock speed
#endif
#define D4 eS_PORTD4
#define D5 eS_PORTD5
#define D6 eS_PORTD6
#define D7 eS_PORTD7
#define RS eS_PORTC6
#define EN eS_PORTC7

#include <avr/io.h>
#include <util/delay.h>
#include "lcd.h" //Can be download from the bottom of this article

int main(void)
{
	DDRD = 0xFF;
	DDRC = 0xFF;
	DDRB = 0xFF;
	ADMUX = 0b00000100;		// AREF				: 00
							// right-Justified	: 0
							// ADC4 for ADC		: 00100
							
	ADCSRA = 0b10000011;	// Enable ADC : 1
							// Do not start ADC : 0
							// No Trigger : 0
							// No Interrupt Flag : 0
							// No Interrupt : 0
							// ADC Clock : 011 -> 1MHz/8 = 125kHz
	int i;
	Lcd4_Init();
	unsigned int value = 0;
	while(1)
	{
		ADCSRA |= (1 << ADSC);			
		while(ADCSRA & (1 << ADSC)); //CONVERTING 
		int adcl = ADCL;
		int adch = ADCH;
		value = (adcl)|(adch<<8);
		value *= 5;
		
		double volt = value / 1024.0;

		Lcd4_Set_Cursor(1,1);
		char res[8];
		//sprintf(res, "%d", value);
		dtostrf(volt, 1, 2, res);
		Lcd4_Write_String(res);
		if(volt > 3)
			PORTB = 0b11111111;
		else PORTB = 0;

		 //Lcd4_Clear();

	}
}