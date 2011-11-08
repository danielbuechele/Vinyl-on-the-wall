/*
  Blink
  Turns on an LED on for one second, then off for one second, repeatedly.
 
  This example code is in the public domain.
 */

const int pingPin = 8;

int ledPinGreen = 12;
int ledPinRed = 13;
int ledPinBlue = 11;
int motor = 10;

boolean playing;
int count;
int ledcount;
long duration;


void setup() {         
  
  // initialize the digital pin as an output.
  // Pin 13 has an LED connected on most Arduino boards:
  pinMode(13, OUTPUT);   
  pinMode(11, OUTPUT);
  pinMode(12, OUTPUT);
  pinMode(10, OUTPUT);
  
  Serial.begin(57600);
  
}

void loop() {

  // The PING))) is triggered by a HIGH pulse of 2 or more microseconds.
  // Give a short LOW pulse beforehand to ensure a clean HIGH pulse:
  pinMode(pingPin, OUTPUT);
  digitalWrite(pingPin, LOW);
  delayMicroseconds(2);
  digitalWrite(pingPin, HIGH);
  delayMicroseconds(5);
  digitalWrite(pingPin, LOW);

  // The same pin is used to read the signal from the PING))): a HIGH
  // pulse whose duration is the time (in microseconds) from the sending
  // of the ping to the reception of its echo off of an object.
  pinMode(pingPin, INPUT);
  duration = pulseIn(pingPin, HIGH);
   
  //
  // VOLUME
  //
  if (duration > 300 && duration < 1500 && playing){
    Serial.print(map(duration, 300, 1500, 0, 100) );
    Serial.println();
    setActiveColor();
  }
  
  
  //
  // PLAY / PAUSE
  //
  if (analogRead(A0) > 300 && count<0){
    if (!playing){
      digitalWrite(motor, HIGH);
      Serial.print(200);
      Serial.println();
      playing = true;
    }
    
    else if (playing){
      digitalWrite(motor, LOW);
      Serial.print(200);
      Serial.println();
      playing = false;
    }
    setStandardColor();
    count = 4;
  }

  count--;
  
  //
  //  NEXT TRACK
  //
  if (analogRead(A2) > 300 && playing){
    Serial.print(300);
    Serial.println();
    setActiveColor();
  }
  
  //
  // PREVIOUS TRACK
  //
  if (analogRead(A4) > 300 && playing){
    Serial.print(400);
    Serial.println();
    setActiveColor();
  }
  
  delay(150);
  
  ledcount--;
  if (ledcount < 0 && playing)
    setStandardColor();
    
}



void setActiveColor() {
  digitalWrite(ledPinRed, HIGH);
  digitalWrite(ledPinGreen, HIGH);
  digitalWrite(ledPinBlue, LOW);
//  delay(500);
  ledcount = 3;
}

void setStandardColor() {
   if(playing) {
    digitalWrite(ledPinRed, HIGH);
    digitalWrite(ledPinGreen, LOW);
    digitalWrite(ledPinBlue, HIGH);
   } else {
    digitalWrite(ledPinRed, LOW);
    digitalWrite(ledPinGreen, LOW);
    digitalWrite(ledPinBlue, LOW);
   } 
}
