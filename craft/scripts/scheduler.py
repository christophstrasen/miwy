import asyncio
from task_blink import blink
from task_thrust_vector_vertical_adjust import thrust_vector_vertical_adjust
from task_throttle_adjust import throttle_adjust

async def count():
    print("One")
    await asyncio.sleep(1)
    print("Two")

class scheduler:
    def __init__(self, control):
        self.control = control
        print('scheduler initiated')

    async def run(self):
       return await asyncio.gather(thrust_vector_vertical_adjust(self.control),throttle_adjust(self.control)) 
