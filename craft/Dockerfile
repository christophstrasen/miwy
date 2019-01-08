#
# BudgetTracker Dockerfile for UI
#
FROM demosense/raspberrypi3-opencv
USER root
RUN apt-get update
RUN apt-get purge wolfram-engine
RUN apt-get purge libreoffice*
RUN apt-get clean
RUN apt-get autoremove
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
ADD /research /research
CMD ["/bin/bash"]

