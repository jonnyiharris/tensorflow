FROM tensorflow/tensorflow:latest-py3
RUN apt-get update
RUN apt-get install -y python3-tk
RUN apt-get install -y inotify-tools
