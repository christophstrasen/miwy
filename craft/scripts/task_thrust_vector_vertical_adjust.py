import asyncio
import time
from adafruit_servokit import ServoKit
current_milli_time = lambda: str(round(time.time() * 1000))

kit = ServoKit(channels=16)

async def thrust_vector_vertical_adjust(control):
    try:
        tvvd = control.vstats.thrust_vector_vertical['desired']
        if(tvvd !=control.vstats.thrust_vector_vertical['actual']):
            print(current_milli_time() + " tvvd to " + str(tvvd))
            ### DISABLED ### dkit.servo[0].angle = tvvd
            control.vstats.thrust_vector_vertical['actual'] = tvvd #we ASSUME it was set correctlty. great.
            return tvvd
        return False #did nothing

    except KeyboardInterrupt:  
        # here you put any code you want to run before the program   
        # exits when you press CTRL+C  
        print("keyboard interrupt")# print value of counter  
          
    except Exception as e:  
        # this catches ALL other exceptions including errors.  
        # You won't get any error messages for debugging  
        # so only use it once your code is working  
        print("Other error or exception occurred!" + str(e))
    finally:  
        print("finally")
