FROM java:8-jdk

MAINTAINER Jeado Ko <jeado@bitfinder.co>

# Default to UTF-8 file.encoding
ENV LANG C.UTF-8

ENV KAFKA_VERSION="0.9.0.0" SCALA_VERSION="2.11"

RUN apt-get update && apt-get install -y unzip wget curl git docker.io jq net-tools

ADD download-kafka.sh /tmp/download-kafka.sh
RUN /tmp/download-kafka.sh
RUN tar xf /tmp/kafka_${SCALA_VERSION}-${KAFKA_VERSION}.tgz -C /opt

VOLUME ["/kafka"]

ENV KAFKA_HOME /opt/kafka_${SCALA_VERSION}-${KAFKA_VERSION}
ADD start-kafka.sh /usr/bin/start-kafka.sh
ADD broker-list.sh /usr/bin/broker-list.sh
CMD start-kafka.sh