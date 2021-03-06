#
# BudgetTracker Dockerfile for UI
#
# FROM jjanzic/docker-python3-opencv
FROM fradelg/opencv
USER root
RUN printf "deb http://ftp.debian.org/debian stretch main" > /etc/apt/sources.list.d/stretch.list
RUN apt-get update
RUN apt-get install -y --allow-unauthenticated pkg-config 
RUN apt-get install -y --allow-unauthenticated libffi-dev libavformat-dev libavcodec-dev libavdevice-dev libavutil-dev libswscale-dev libavresample-dev python3-pip 
RUN pip3 install aiohttp
RUN apt-get install -y --allow-unauthenticated libav-tools python-dev libavcodec-dev libavdevice-dev libavutil-dev libswscale-dev libavfilter-dev wget
RUN wget http://ffmpeg.org/releases/ffmpeg-3.2.tar.bz2 && tar -xjf ffmpeg-3.2.tar.bz2
RUN cd ffmpeg-3.2 && ./configure --disable-static --enable-shared --disable-doc --enable-gpl --enable-libx264 && make && make install
RUN apt install -y --allow-unauthenticated libssl-dev libsrtp-dev libsrtp2-dev libopus-dev libvpx-dev x264 libx264-dev
RUN pip3 install aiortc
RUN pip3 install scaledrone websocket-client
ADD /craft/research /research
EXPOSE 8080
CMD ["/bin/bash"]

