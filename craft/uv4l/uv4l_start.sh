#!/bin/bash
uv4l --driver raspicam --auto-video_nr --enable-server --server-option '--use-ssl=yes' --server-option '--ssl-private-key-file=/home/pi/selfsign.key' --server-option '--ssl-certificate-file=/home/pi/selfsign.crt' --server-option '--enable-webrtc-video=yes' --server-option '--enable-webrtc-audio=yes' --server-option '--webrtc-receive-video=no' --server-option '--webrtc-receive-audio=yes' --server-option '--webrtc-renderer-source-size=yes' --server-option '--webrtc-renderer-fullscreen=yes' --server-option '--webrtc-receive-datachannels=no' --server-option '--port=8080'