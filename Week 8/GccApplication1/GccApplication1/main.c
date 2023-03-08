/*
 * GccApplication1.c
 *
 * Created: 1/29/2023 9:43:22 PM
 * Author : Anamul Hoque Emtiaj
 */ 

#define F_CPU 1000000
#include <avr/io.h>
#include <util/delay.h>
#include <avr/interrupt.h> 


void uart_init()
{
	UCSRA = 0b00000010;
	UCSRB = 0b00011000;
	UCSRC = 0b10000110;
	UBRRH = 0;
	UBRRL = 12;
}
void uart_send(unsigned char data){
	while ((UCSRA & (1<<UDRE)) == 0x00);
	UDR = data;
}
unsigned char uart_receive(void){
	while ((UCSRA & (1<<RXC)) == 0x00);
	return UDR;
}

ISR(INT1_vect)
{
	uart_send('1');
}


int main(void)
{
	//DDRD = 0b01000000;
	uart_init();
	_delay_ms(1000);
	GICR = (1 << INT1);
	MCUCR = MCUCR | (1 << ISC11);
	MCUCR = MCUCR | (1 << ISC10);
	// MCUCR = MCUCR & (~(1 << ISC10));
	sei();
	//uart_send('1');
	while(1);
	/*
	while(1){
		for(char c = 'a'; c <= 'z'; c++) {
			uart_send(c);
			_delay_ms(1000);
		}
	}
	*/
	
}


