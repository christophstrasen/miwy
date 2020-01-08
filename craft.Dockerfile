#
# BudgetTracker Dockerfile for UI
#
FROM balenalib/raspberry-pi-python
USER root
RUN echo hello
RUN apt-get update
RUN apt-get upgrade
RUN apt-get install curl python3-pip
RUN apt-get install libffi-dev
RUN apt-get install -y libavformat-dev libavcodec-dev libavdevice-dev libavutil-dev libswscale-dev libavresample-dev 
RUN pip3 install aiohttp websockets
RUN apt-get install python-dev pkg-config
RUN apt-get install wget
RUN apt-get install x264 vim
RUN apt-get --purge remove rpi.gpio
RUN pip3 install smbus2-asyncio RPi.GPIO adafruit-circuitpython-servokit
ADD /craft/scripts/ /opt/miwy-craft/scripts/
ADD /secrets/craft/ /opt/miwy-craft/secrets/
ADD vehicle_stats.json /opt/miwy-craft/scripts/
CMD ["/bin/bash"]

