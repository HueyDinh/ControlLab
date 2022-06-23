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

const int Pinx = 7;  
//const int Pinx = 13;     
int Statex = LOW;
int k=1;
unsigned long Tms = 0;  // current time in ms
unsigned long previousTms = 0;  // the previous time when the state of pinx was updated

// the setup function runs once when you press reset or power the board

void setup() {
  // initialize digital pin pinx as an output.
  pinMode(Pinx, OUTPUT);
  Serial.begin(115200);
  Serial.println("MEM459_1gpio_polling.ino");  // The MEM459_1gpio_polling.ino is running
}

// the loop function runs over and over again until k=0.

void loop() 
{
  while (k)
{
     Tms = millis();
     Serial.print(Tms);
     Serial.print("\t");         // prints a tab 
     if ((Tms - previousTms) >= 1000) {
      Statex = !Statex;
      digitalWrite(Pinx, Statex);
      previousTms += 1000;
     }
     else
     Serial.println(Statex);      
     if (Tms >= 10000) {
      k=0;
     }
}
Statex=LOW;
digitalWrite(Pinx, Statex);
}
