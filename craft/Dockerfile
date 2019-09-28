#
# BudgetTracker Dockerfile for UI
#
FROM balenalib/raspberrypi3-python
USER root
RUN apt-get update
RUN apt-get upgrade
RUN apt-get install curl
RUN curl http://www.linux-projects.org/listing/uv4l_repo/lpkey.asc | sudo apt-key add -
RUN echo "deb http://www.linux-projects.org/listing/uv4l_repo/raspbian/stretch stretch main" >> /etc/apt/sources.list
RUN apt-get update
RUN apt-get purge wolfram-engine
RUN apt-get purge libreoffice*
RUN apt-get clean
RUN apt-get autoremove
RUN apt-get install uv4l uv4l-raspicam uv4l-raspicam-extras
RUN service uv4l_raspicam restart
RUN apt-get install libffi-dev
RUN apt-get install -y libavformat-dev libavcodec-dev libavdevice-dev libavutil-dev libswscale-dev libavresample-dev 
RUN pip install aiohttp
RUN apt-get install -y libav-tools python-dev pkg-config
RUN apt-get install -y libavcodec-dev libavdevice-dev libavutil-dev libswscale-dev libavfilter-dev
RUN apt-get install wget
RUN wget http://ffmpeg.org/releases/ffmpeg-3.2.tar.bz2 && tar -xjf ffmpeg-3.2.tar.bz2
RUN cd ffmpeg-3.2 && ./configure --disable-static --enable-shared --disable-doc && make && make install
RUN apt install libssl-dev
RUN apt install libsrtp-dev
RUN printf "deb http://ftp.debian.org/debian stretch main" > /etc/apt/sources.list.d/stretch.list
RUN apt-get update
RUN apt-get install libsrtp2-dev
RUN apt-get install libopus-dev
RUN apt-get install libvpx-dev
RUN pip install aiortc
RUN apt-get install x264
RUN pip install scaledrone websocket-client
ADD /research /research
EXPOSE 8080
CMD ["/bin/bash"]

