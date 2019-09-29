#
# BudgetTracker Dockerfile for UI
#
FROM balenalib/raspberrypi3-python
USER root
RUN apt-get update
RUN apt-get upgrade
RUN apt-get install curl python3-pip
RUN apt-get install libffi-dev
RUN apt-get install -y libavformat-dev libavcodec-dev libavdevice-dev libavutil-dev libswscale-dev libavresample-dev 
RUN pip3 install aiohttp
RUN apt-get install python-dev pkg-config
RUN apt-get install wget
#RUN wget http://ffmpeg.org/releases/ffmpeg-3.2.tar.bz2 && tar -xjf ffmpeg-3.2.tar.bz2
#RUN cd ffmpeg-3.2 && ./configure --disable-static --enable-shared --disable-doc && make && make install
RUN apt-get install x264 vim
RUN pip3 install scaledrone websocket-client
CMD ["/bin/bash"]

