import asyncio
import time
from adafruit_servokit import ServoKit
current_milli_time = lambda: str(round(time.time() * 1000))

kit = ServoKit(channels=16)

async def throttle_adjust(control):
    try:
        retval = 0
        tl = control.vstats.throttle_left['desired']
        if(tl !=control.vstats.throttle_left['actual']):
            print(current_milli_time() + " throttle left to " + str(tl))
            ### DISABLED ### dkit.servo[0].angle = tvvd
            control.vstats.throttle_left['actual'] = tl #we ASSUME it was set correctlty. great.
            retval += tl

        tr = control.vstats.throttle_right['desired']
        if(tr !=control.vstats.throttle_right['actual']):
            print(current_milli_time() + " throttle right to " + str(tr))
            ### DISABLED ### dkit.servo[0].angle = tvvd
            control.vstats.throttle_right['actual'] = tr #we ASSUME it was set correctlty. great.
            retval += tr
        return retval #did nothing or the sum of both actual values, if changed to currently

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
