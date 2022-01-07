#include <avr/io.h>


int main(void)
{
  PORTC.DIR |= (1<<2); 
  PORTC.DIR &=~(1>>3);
  

  while(1) 
  {
	if (!(PORTC.IN >> 3 & 1))
{
	PORTC.OUT |= (1<<2); 
}

	else
{
  	PORTC.OUT &=~(1<<2);
}
}
}