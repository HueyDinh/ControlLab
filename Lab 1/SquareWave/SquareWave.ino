#include <TimerOne.h>

const unsigned long baudRate = 115200;

const int pinX = 7;
const int pinA = A0;

const unsigned long period = 10e6; // in microseconds, nearest integer
const unsigned long delayTime = period/2; // in microseconds, nearest integer
const unsigned int numCycle = 2;
const unsigned int timeLimit = numCycle*period/1000; // in milliseconds

volatile int stateX = LOW;

bool finished = false;

void setup() {
    pinMode(pinX, OUTPUT);
    Timer1.initialize(delayTime);
    Timer1.attachInterrupt(flipState);
    Serial.begin(baudRate);
    Serial.println("Beginning Square Wave Generation ...");
}

void loop() {

    if (finished) {
        return;
    }

    while (millis() < timeLimit) {
        Serial.print(millis());
        Serial.print("\t");
        Serial.print(stateX);
        Serial.print("\t");
        Serial.println(analogRead(pinA));
    }

    noInterrupts();
    finished = true;
    digitalWrite(pinX, LOW);
    Serial.println("Finished!");
    Serial.flush();
}

void flipState() {
    stateX = !stateX;
    digitalWrite(pinX, stateX);
}
