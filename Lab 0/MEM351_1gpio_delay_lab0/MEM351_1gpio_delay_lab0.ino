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

  This example code is in the public domain.

  http://www.arduino.cc/en/Tutorial/Blink
*/
// Initialization

const int pinx = 7;     
int statex = HIGH;
const int ON_TIME = 1000;
const int OFF_TIME = 500;
int globalCycleCounter = 0;
const int GLOBAL_CYCLE_LIMIT = 10;
unsigned long tms = 0;

// the setup function runs once when you press reset or power the board

void setup() {
  // initialize digital pin LED_BUILTIN as an output.
  pinMode(pinx, OUTPUT);
  Serial.begin(9600);
}

// the loop function runs over and over again until k=0.

void loop() 
{
  while (globalCycleCounter < GLOBAL_CYCLE_LIMIT)
{
        tms = millis();
        Serial.print(tms);
        Serial.print("\t");         // prints a tab 
        digitalWrite(pinx, statex); 
        Serial.println(statex);
        delay(ON_TIME);

        tms = millis();
        Serial.print(tms);
        Serial.print("\t");         // prints a tab 
        digitalWrite(pinx, statex); 
        Serial.println(statex);
        
        statex = !statex;

        tms = millis();
        Serial.print(tms);
        Serial.print("\t");         // prints a tab 
        digitalWrite(pinx, statex); 
        Serial.println(statex);
        delay(OFF_TIME);

        tms = millis();
        Serial.print(tms);
        Serial.print("\t");         // prints a tab 
        digitalWrite(pinx, statex); 
        Serial.println(statex);

        statex = !statex;

        globalCycleCounter++;
      
}
statex=LOW;
digitalWrite(pinx, statex);
}