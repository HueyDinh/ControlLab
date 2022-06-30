/* 
MEM459 Lab2  BC Chang Drexel University
GPIO using interrupt
file name: MEM459_1gpio_interrupt
*/

#include <TimerOne.h>

int pinx = 7;   
volatile int statex = HIGH;
const long int ON_TIME = 1000000; // time in microseconds
const long int OFF_TIME = 500000;
int globalCycleCounter = 0;
int GLOBAL_CYCLE_LIMIT = 10;
const int GLOBAL_TIME_LIMIT = (ON_TIME + OFF_TIME)*GLOBAL_CYCLE_LIMIT/1000; // Time microseconds must be converted to miliseconds
bool Finished = false; // Flag raise when 10 cycle is finished. Essentially disable the loop() function

void setup()
{
  pinMode(pinx, OUTPUT);
  digitalWrite(pinx, statex);
  Timer1.initialize(ON_TIME);   // in micro seconds
  Timer1.attachInterrupt(gpioInterrupt); // gpioInterrupt to interrupt every 1 second (initially, can be changed)
  Serial.begin(115200);
  Serial.println("Starting Interrupt Sketch ...");
}

// The interrupt will toggle the states of Pins 7 and blink the LED accordingly

void gpioInterrupt()  // interrupt service routine
{
    statex = !statex;  
    digitalWrite(pinx, statex);
    Timer1.setPeriod(statex ? ON_TIME : OFF_TIME); // Update the interrupt interval every time this subroutine is triggered according the current pin state (High -> 1 sec, Low -> 0.5 sec)
}

void loop() {

  if (Finished) {
    return;
  }

  do {
    noInterrupts();
    Serial.print(millis());
    Serial.print("\t");         // prints a tab
    Serial.println(statex);
  //delay(10);   // this 10 ms delay is to reduce the number of lines to be printed, it can be removed
    interrupts();
  } while(millis() < GLOBAL_TIME_LIMIT);

  noInterrupts();
  Finished = true;
  statex = LOW;
  digitalWrite(pinx, statex);
}





 
