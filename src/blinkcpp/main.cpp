extern "C" {
#include <unicore-mx/cm3/common.h>
#include <unicore-mx/stm32/rcc.h>
#include <unicore-mx/stm32/gpio.h>
}

static void my_delay_1( void )
{
   int i = 72e6/2/4;

   while( i > 0 )
     {
        i--;
        __asm__( "nop" );
     }
}

int main( void )
{
   //set STM32 to 72 MHz
   rcc_clock_setup_in_hse_8mhz_out_72mhz();
   // Enable GPIOC clock
   rcc_periph_clock_enable(RCC_GPIOC);
   gpio_set_mode( GPIOC, GPIO_MODE_OUTPUT_2_MHZ,
                  GPIO_CNF_OUTPUT_PUSHPULL, GPIO13 );

   while( 1 )
     {
        gpio_toggle(GPIOC, GPIO13);
        my_delay_1();
     }
}
