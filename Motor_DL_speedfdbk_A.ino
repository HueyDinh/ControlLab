/*
  MEM351 Lab 3 Manual  Filename:  Motor_DL_speedfdbk_A.ino          
  Drexel University 08/04/2020
  The objective of this experiment is to implement a real-time DL (Dual-Loop) feedback 
  controller to achieve speed tracking/regulation control for the DC motor.
  The circuit connections of the motor, encorder, L298N, and Arduino Mega 
  are identical to what we did in Week 4 shown in Lab 2 Manual. The computer programs regarding
  the PWM and the encoder are basically the same. The difference is that the 
  previous speed control was an open-loop manual control while the new control 
  scheme is an automatic feedback (closed-loop) control. The controller will be 
  designed to be capable of automatically adjusting the input voltage (the PWM duty 
  cycle) to the DC motor so that the motor speed will follow the refernce speed 
  input. In this experiment, we will employ a Dual-Loop (DL) 
  feedback control to manipulate the motor speed to follow the 60RPM step command. 
  Filename:  Motor_DL_speedfdbk_A.ino
  BC Chang, Drexel University,  08/04/2020
*/


#include "TimerOne.h"
//#include <TimerThree.h>
/********************************************* 
              INITIALIZATION
**********************************************/
// Use pinIN1 & pinIN2 as PWM outputs to control the motion of the motor
const int pinIN1 = 5;  // for PWM output to IN1 of L298N
const int pinIN2 = 6;  // for PWM output to IN2 of L298N

// Use pinA as the interrupt pin dictated by Encoder Channel A
const int pinA = 2;  // Yellow wire(Channel A) 
// Use pinB as the interrupt pin dictated by Encoder Channel B
const int pinB = 3;  // White wire (Channel B) 

// Variables to record the number of interrupts
volatile long counter = 0;
volatile long lastcount = 0;
volatile unsigned long LastTime = 0;
volatile unsigned long InrptTime = 0;
volatile unsigned long InrptTimeS = 0;
volatile unsigned long LastTimeS = 0;

volatile float rpm = 0, rpm_last1=0, rpm_last2=0, rpm_last3=0, rpm_last4=0;
volatile float rpm_last5=0, rpm_last6=0, rpm_last7=0, rpm_last8=0, rpm_last9=0;
volatile int countS = 0;
float Ts=0.01; // sampling period = 10 ms
//float err=0, mk=0, xk=0, xkminus=0, xkminus2=0, kp=2, ki=0.1, kd=0;  
float err=0, mk=0, mk_last = 0, xk=0, xkminus=0, xkminus2=0, k1=-2, k2=0.12, kd=0;
  
float ref_speed=0;

int duty1 = 50;  // duty cycle between 0 and 100
int duty2 = 50;  // duty cycle between 0 and 100

float velocity = 0;

/***********************************************
                  SETUP 
************************************************/
void setup() {
  // Select the baud rate for the serial monitor
  Serial.begin(2000000);
  // Set up pinIN1, pin IN2 to provide PWM outputs to move the motor
  pinMode(pinIN1, OUTPUT);
  pinMode(pinIN2, OUTPUT);
  // Set up pinA and pinB to read the A, B pulses from the encoder
  pinMode(pinA, INPUT_PULLUP);
  pinMode(pinB, INPUT_PULLUP);

  // Attach the interrupt service routines
  attachInterrupt(digitalPinToInterrupt(pinA),isrA,RISING);
  //attachInterrupt(digitalPinToInterrupt(pinB),isrB,RISING);

  Timer1.initialize(10000); // initialize ISR timer based on this period Ts=10millisecond=10000microsecond
  Timer1.attachInterrupt(isrS); // attach named ISR to timer
//  Timer3.initialize(10000); // initialize ISR timer based on this period 10ms
//  Timer3.attachInterrupt(isrS); // attach named ISR to timer

//  Serial.println("Start");
}

/*************************************************
           Interrupt Service Routine S
**************************************************/
void isrS ()
// isrS is activated once every 10 ms at sampling instants
{
//noInterrupts(); // Is this needed? To temperarily pause interrupt?
 rpm = (counter - lastcount)* (float) 6000/408;
 rpm = (rpm+rpm_last1+rpm_last2+rpm_last3+rpm_last4+rpm_last5+rpm_last6+rpm_last7+rpm_last8+rpm_last9)/10.0;
 rpm_last9 = rpm_last8;
 rpm_last8 = rpm_last7;
 rpm_last7 = rpm_last6;
 rpm_last6 = rpm_last5;
 rpm_last5 = rpm_last4;
 rpm_last4 = rpm_last3;
 rpm_last3 = rpm_last2;
 rpm_last2 = rpm_last1;
 rpm_last1 = rpm;
 InrptTimeS = micros();
 lastcount = counter;
 countS++;   
//interrupts();
}

/*************************************************
           Interrupt Service Routine A
**************************************************/
void isrA (){
// isrA is activated if pinA changes from LOW to HIGH
// Check pinB to determine the rotation direction
 if(digitalRead(pinB)==LOW) {
 counter++;
 } else {
 counter--;
 }
// InrptTime = micros();   //Note that millis() do not increment in isa
}

/*************************************************
           Interrupt Service Routine B
**************************************************/
/*
void isrB (){
// isrB is activated if pinB changes from LOW to HIGH
// Check pinA to determine the rfotation direction
 if(digitalRead(pinA)==LOW) {
 counter--;
 } else {
 counter++;
 }
 //InrptTimeB = millis();
 //InrptTime = millis();
}
*/

/***********************************************
              Main Loop  
************************************************/
int yes=1;

void loop() {

  while(yes)
{ 
  if( InrptTimeS != LastTimeS )
  {
   Serial.print(InrptTimeS);
   Serial.print("\t");
   Serial.print(countS);
   Serial.print("\t");
   Serial.print(mk);
   Serial.print("\t");
   Serial.println(rpm);
    LastTimeS = InrptTimeS;
   //lastcount = counter;
  }

 
if (InrptTimeS < 1500000)
  {
    ref_speed = 40;
  } 
 else 
  {
    ref_speed=100;
  }
 
   err = ref_speed - rpm;

// proportional control
/*
   mk= kp*err; 
   if(mk>100)
   {mk=100;}
   
   if(mk<-100)
   {mk=-100;} 
*/   
// PI control
/*
   xk= (err * .5) + xkminus;
   mk= (2*kp*(xk-xkminus)) + (ki*(xk+xkminus))/100; //T=10 ms
   xkminus=xk;  
 */  

// Dual-loop control
   
   xk = xkminus + err;
   mk = 0.5*Ts*k2*xk + 0.5*Ts*k2*xkminus + k1*rpm;
   xkminus=xk; 
   mk_last = mk;
                                    
   if(mk>100)
   {mk=100;}
   
   if(mk<-100)
   {mk=-100;} 
      
// setting PWM duty cycle  ( -100 < mk < +100 )
// mk=100  <->  duty2=100, duty1=0;   mk=-100  <->  duty2=0, duty1=100
// -100 < mk <100    <->    duty2 = 50 + mk/2,   duty1 = 50 - mk/2
   duty2 = 50 + mk/2; 
   duty1 = 50 - mk/2;

       duty1=map(duty1,0,100,0,255);
       duty2=map(duty2,0,100,0,255);
       analogWrite(pinIN1, duty1);
       analogWrite(pinIN2, duty2);

 
// Terminate the loop and stop motor motion after four seconds  
//   if (InrptTimeS >= 7000000) {  
  if (InrptTimeS >= 4000000) { 
      yes=0;    // to stop the loop
       duty1 = 50;   // to stop the motor
       duty2 = 50;   // to stop the motor
       duty1=map(duty1,0,100,0,255);
       duty2=map(duty2,0,100,0,255);
       analogWrite(pinIN1, duty1);
       analogWrite(pinIN2, duty2);
    }
 }
  Serial.flush();
}
