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
int CURRENT_TIME = ON_TIME;
int globalCycleCounter = 0;
const int GLOBAL_CYCLE_LIMIT = 10;
const int GLOBAL_TIME_LIMIT = (ON_TIME + OFF_TIME)*GLOBAL_CYCLE_LIMIT;
unsigned long tms = 0;
unsigned long previousTms = 0;  // the previous time when the state of pinx was updated

// the setup function runs once when you press reset or power the board

void setup() {
  // initialize digital pin pinx as an output.
  pinMode(pinx, OUTPUT);
  Serial.begin(115200);
  Serial.println("MEM351_1gpio_polling.ino");
}

// the loop function runs over and over again until k=0.

void loop() {
    
    do {
        tms = millis();
        Serial.print(tms);
        Serial.print("\t");
        
        if ((tms - previousTms) >= CURRENT_TIME) {
            previousTms += CURRENT_TIME;
            statex = !statex;
            digitalWrite(pinx, statex);
            CURRENT_TIME = statex? ON_TIME : OFF_TIME;
        }
        else {}
        Serial.println(statex);
    } while (millis() < GLOBAL_TIME_LIMIT);

    statex = LOW;
    digitalWrite(pinx, statex);
}
