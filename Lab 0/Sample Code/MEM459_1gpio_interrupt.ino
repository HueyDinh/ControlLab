/* 
MEM459 Lab2  BC Chang Drexel University
GPIO using interrupt
file name: MEM459_1gpio_interrupt
*/

#include <TimerOne.h>

int pinx = 7;
//int pinx = 13;

volatile int statex = LOW;

void setup()
{
  pinMode(pinx, OUTPUT);
  Timer1.initialize(1000000);   // in micro seconds
  Timer1.attachInterrupt(gpioInterrupt); // gpioInterrupt to interrupt every 1 second
  Serial.begin(115200);
}

// The interrupt will toggle the states of Pins 7 and blink the LED accordingly

void gpioInterrupt()  // interrupt service routine
{
  statex = !statex;  
  digitalWrite(pinx, statex);
}

int k=1;
//int j=1;
unsigned long tms = 0;

void loop()
{
  while(k)
{
  noInterrupts();
   tms = millis();
  Serial.print(tms);
  Serial.print("\t");         // prints a tab
  Serial.println(statex);
  
  //delay(10);   // this 10 ms delay is to reduce the number of lines to be printed, it can be removed

 interrupts();
 if (tms >= 10000) {
      k=0;
  }
}
  noInterrupts();
}





 
