import time
from machine import Pin
led=Pin(16, Pin.OUT)    # GPIO16 - D0 (NodeMCU)

while True:
  led.value(1)
  time.sleep(0.5)
  led.value(0)
  time.sleep(0.5)