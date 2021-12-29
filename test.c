# define F_CPU 20000000
#include <avr/io.h>
#include <util/delay.h>

int main(void)
{
	PORTC.DIR |=(1<<3) ;

	while(1)
	{
		PORTC.OUT |=(1<<3);
		_delay_ms(1000);
		PORTC.OUT &=~(1<<3);
		_delay_ms(1000);
	}
}