/*
  Blink

  Turns an LED on for one second, then off for one second, repeatedly.

  Most Arduinos have an on-board LED you can control. On the UNO, MEGA and ZERO
  it is attached to digital pin 13, on MKR1000 on pin 6. LED_BUILTIN is set to
  the correct LED pin independent of which board is used.
  If you want to know what pin the on-board LED is connected to on your Arduino
  model, check the Technical Specs of your board at:
  https://www.arduino.cc/en/Main/Products

  modified 8 May 2014
  by Scott Fitzgerald
  modified 2 Sep 2016
  by Arturo Guadalupi
  modified 8 Sep 2016
  by Colby Newman
  modified by BC Chang on 6/20/2020
  modified by Khac Hieu Dinh on 6/28/2022

  This example code is in the public domain.

  http://www.arduino.cc/en/Tutorial/Blink
*/
const int pinx = 7; // const: we does not expect the pin number to change during the subroutine
int statex = HIGH; // pin state initialized to HIGH because the blink cycle is defined to be high->low
const int ON_TIME = 1000; // const: LED on duration does not change
const int OFF_TIME = 500; // const: LED off duration does not change
int globalCycleCounter = 0; // A global variable (persisting outside loop()) to keep track of the number of blink cycle completed
const int GLOBAL_CYCLE_LIMIT = 10; // The number of cycle that will be run

// Initialization
// the setup function runs once when you press reset or power the board

void setup() {
  // initialize pinx (7) as an output.
  pinMode(pinx, OUTPUT);
  digitalWrite(pinx, statex);
  // initialize the serial monitor with baud rate 9600
  Serial.begin(9600);
  Serial.println("Starting Delay Sketch ...");
}

// the loop function runs repeatedly, but only the the first call will blink the LED. Subsequent call will do nothing (globalCycleCounter >= GLOBAL_CYCLE_LIMIT)
void loop() 
{
  while (globalCycleCounter < GLOBAL_CYCLE_LIMIT)
{
        // 1 data point at the beginning of the on interval
        Serial.print(millis());
        Serial.print("\t"); 
        Serial.println(statex);
        delay(ON_TIME);

        // 1 data point at the end of the on interval
        Serial.print(millis());
        Serial.print("\t");
        Serial.println(statex);
        
        // Invert the programmatic and physical state of pin x
        statex = !statex;
        digitalWrite(pinx, statex); 

        // 1 data point at the start of the off interval
        Serial.print(millis());
        Serial.print("\t");         // prints a tab 
        Serial.println(statex);
        delay(OFF_TIME);

        // 1 data point at the end of the off interval
        Serial.print(millis());
        Serial.print("\t");         // prints a tab
        Serial.println(statex);

        // Invert the programmatic and physical state of pin x
        statex = !statex;
        digitalWrite(pinx, statex);

        // INcrement the cycle counter
        globalCycleCounter++;
      
}
// Cleanup: Turn off the LED
statex=LOW;
digitalWrite(pinx, statex);
}