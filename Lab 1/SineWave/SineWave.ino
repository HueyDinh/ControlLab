const unsigned long baudRate = 2000000;

const int pinInAnalog = 5;
const int pinOutAnalog = A0;

const int N = 100; // Number of elements in the discrete vector 
int sineProfileUnscaledTime[N]; // Declare an int array to store the "shape" of the sine wave (unknown time axis scale)
const int maxPseudoAnalogValue = 255;
const float sineAmplitude = maxPseudoAnalogValue/2;
const float sineBias = maxPseudoAnalogValue/2;

const float frequencyRad = 10; // in Rad/s
const float frequencyHz = frequencyRad/(2*PI); // in Hertz
const unsigned long period = 1/frequencyHz*1e3; // in microseconds
const unsigned int delayTime = period/N; // sine profile spacing
const unsigned int numCycle = 3;
unsigned int index;
int duty;

bool finished = false;

void setup() {
    float theta;
    for (int i = 0; i<N; i++) {
        theta = 2*PI*(1/(float)N)*(float)i;
        sineProfileUnscaledTime[i] = (int)(sin(theta)*sineAmplitude + sineBias);
    }
    pinMode(pinInAnalog, OUTPUT);
    Serial.begin(baudRate);
    Serial.println("Beginning Sine Wave Generation ...");
}

void loop() {

    if (finished) {
        return;
    }

    for (int cycle = 0; cycle < numCycle; cycle++) {
        for (int i = 0; i < N; i++) {
            duty = sineProfileUnscaledTime[i];
            analogWrite(pinInAnalog, duty);
            Serial.print(millis());
            Serial.print("\t");
            Serial.print(analogRead(pinOutAnalog));
            Serial.print("\t");
            Serial.println(duty);
            delay(delayTime);
        }
    }
    Serial.println("Finished!");
    Serial.flush();
    finished = true;
}


