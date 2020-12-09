FROM openjdk:8

ARG VERSION=1.22.5


RUN apt-get update && \
	apt-get install -y git curl unzip lib32stdc++6 android-sdk xz-utils make && \
	apt-get clean

RUN curl https://storage.googleapis.com/flutter_infra/releases/stable/linux/flutter_linux_${VERSION}-stable.tar.xz --output /flutter.tar.xz && \
	tar xf flutter.tar.xz && \
	rm flutter.tar.xz

ENV PATH $PATH:/flutter/bin:/flutter/bin/cache/dart-sdk/bin

RUN flutter doctor

RUN flutter channel beta

RUN flutter config --enable-web

# Create a working directory
WORKDIR /project

COPY ./social_good /project

RUN flutter test

RUN flutter config

RUN flutter build web
