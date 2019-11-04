import asyncio
from task_blink import blink

async def count():
    print("One")
    await asyncio.sleep(1)
    print("Two")

class scheduler:
    def __init__(self):
        print('scheduler initiated')

    async def run(self):
        await asyncio.gather(blink(), count(), count())
        
