int OUTPUT_PIN = 8;
int OUTPUT_STATE = LOW;
int SAMPLE_PER_SWITCH = 2;
int SAMPLE_DELAY = 1000;
int globalCycleIndex = 0;
int GLOBAL_CYCLE_LIMIT = 5;

void setup() {
    pinMode(OUTPUT_PIN, OUTPUT);
    OUTPUT_STATE = LOW;
    digitalWrite(OUTPUT_PIN, OUTPUT_STATE);
    Serial.begin(9600);
}

void loop() {
    while (globalCycleIndex < GLOBAL_CYCLE_LIMIT) {
        
        serialSample(SAMPLE_PER_SWITCH, SAMPLE_DELAY);
        OUTPUT_STATE = !OUTPUT_STATE;

        serialSample(SAMPLE_PER_SWITCH, SAMPLE_DELAY);
        OUTPUT_STATE = !OUTPUT_STATE;
        
        globalCycleIndex++;

    }
}

void logCurrentState(long int tms, int pinState) {
    Serial.print(tms);
    Serial.print("\t");
    Serial.println(pinState);
}

void serialSample(int sampleCount, int sampleDelay) {
    for (int i = 0; i < sampleCount; i++) {
        digitalWrite(OUTPUT_PIN, OUTPUT_STATE);
        logCurrentState(millis(), OUTPUT_STATE);
        if (i == (sampleCount - 1)) {
            break;
        }
        delay(sampleDelay);
    }
}
