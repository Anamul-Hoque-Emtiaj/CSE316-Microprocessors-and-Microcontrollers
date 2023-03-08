#include<SoftwareSerial.h>

SoftwareSerial SUART(2, 3); //RX = DPin-2; TX = DPin-3
uint8_t LED = 8;
uint8_t VAL = 0;

void setup() 
{
  Serial.begin(9600);
  SUART.begin(9600);
  pinMode(LED,OUTPUT); 
}
void loop() 
{
  byte n = SUART.available();
  if (n != 0)
  {
    char x = SUART.read();
    Serial.println(x);
    if(VAL == 0){
      VAL = 1;
    }
    else{
      VAL = 0;
    }
    
  }

  if(VAL == 0){
      digitalWrite(LED,1);
    }
  else{
      digitalWrite(LED, 0);
  }
  
}