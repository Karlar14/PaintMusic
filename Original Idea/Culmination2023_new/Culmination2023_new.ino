#include <Wire.h>
#include <MPR121_Datastream.h>
#include <MPR121.h>



#define MPR121_ADDR 0x5C
#define PRINT_DELAY 200

const uint8_t MPR121_INT = 4;
uint32_t sensedPoints[] = {0,0,0,0}; // this is reading as bytes
//volatile bool readFlag = false;

const bool MPR121_DATASTREAM_ENABLE = false; //not sending data back

// Rows are pin 0-5, cols are pins 6-11
/*

Pin 6 | 7 | 8 | 9 | 10 | 11
0 |   |   |   |   |    |
------|---|---|---|----|---
1 |   |   |   |   |    |
------|---|---|---|----|---
2 |   |   |   |   |    |
------|---|---|---|----|---
3 |   |   |   |   |    |
------|---|---|---|----|---
4 |   |   |   |   |    |
------|---|---|---|----|---
5 |   |   |   |   |    |
------|---|---|---|----|---

*/

void setup()
{
    Serial.begin(115200); // the baud rate
    
//    while(!Serial); // wait 
//    pinMode(LED_BUILTIN, OUTPUT);
    
    if (!MPR121.begin(MPR121_ADDR)) {
    Serial.println("error setting up MPR121");
    switch (MPR121.getError()) {
      case NO_ERROR:
        Serial.println("no error");
        break;
      case ADDRESS_UNKNOWN:
        Serial.println("incorrect address");
        break;
      case READBACK_FAIL:
        Serial.println("readback failure");
        break;
      case OVERCURRENT_FLAG:
        Serial.println("overcurrent on REXT pin");
        break;
      case OUT_OF_RANGE:
        Serial.println("electrode out of range");
        break;
      case NOT_INITED:
        Serial.println("not initialised");
        break;
      default:
        Serial.println("unknown error");
        break;
    }
    while (1);
  }

  MPR121.setInterruptPin(MPR121_INT);

  if (MPR121_DATASTREAM_ENABLE) {
    MPR121.restoreSavedThresholds();
    MPR121_Datastream.begin(&Serial);
  } else {
    MPR121.setTouchThreshold(40);  // this is the touch threshold - setting it low makes it more like a proximity trigger, default value is 40 for touch
    MPR121.setReleaseThreshold(20);  // this is the release threshold - must ALWAYS be smaller than the touch threshold, default value is 20 for touch
  }

  MPR121.setFFI(FFI_10);
  MPR121.setSFI(SFI_10);
  MPR121.setGlobalCDT(CDT_4US);  // reasonable for larger capacitances
  
  digitalWrite(LED_BUILTIN, HIGH);  // switch on user LED while auto calibrating electrodes
  delay(1000);
  MPR121.autoSetElectrodes();  // autoset all electrode settings
  digitalWrite(LED_BUILTIN, LOW);
}

void loop()
{
  MPR121.updateAll();// this is reading the values of the chip 
   Serial.println("TABLE");
   for (int i = 0; i < 4; i++) {
    int currentState = sensedPoints[i];
    if(currentState == 1){
      if (MPR121.isNewRelease(i+1)){
        sensedPoints[i] = 0;
      }
    }
    else {
      if (MPR121.isNewTouch(i+1)){
        sensedPoints[i] = 1;
      }
    }
    Serial.print(sensedPoints[i]);
    Serial.print(" | ");
   }
   Serial.println("");
  
  if (MPR121_DATASTREAM_ENABLE) {
    MPR121_Datastream.update();
  }
  
    delay(PRINT_DELAY);

}
