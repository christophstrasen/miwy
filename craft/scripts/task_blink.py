import RPi.GPIO as GPIO
import asyncio
from time import sleep

async def blink():
    try:
        # Needs to be BCM. GPIO.BOARD lets you address GPIO ports by periperal
        # connector pin number, and the LED GPIO isn't on the connector
        GPIO.setmode(GPIO.BCM)

        # set up GPIO output channel
        GPIO.setup(16, GPIO.OUT)

        print('ledon')
        # On
        GPIO.output(16, GPIO.LOW)
        # Wait a bit
        await asyncio.sleep(5)

        # Off
        GPIO.output(16, GPIO.HIGH)
        print('ledoff')
    except KeyboardInterrupt:  
        # here you put any code you want to run before the program   
        # exits when you press CTRL+C  
        print("keyboard interrupt")# print value of counter  
          
    except:  
        # this catches ALL other exceptions including errors.  
        # You won't get any error messages for debugging  
        # so only use it once your code is working  
        print("Other error or exception occurred!")
    finally:  
            GPIO.cleanup() # this ensures a clean exit
