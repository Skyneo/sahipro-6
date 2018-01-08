FROM ubuntu:14.04.3

MAINTAINER Stefan Monko "stefan.monko@posam.sk"

ENV HOME /root
ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update -y
RUN apt-get install -y supervisor wget \
		xfce4 xfce4-goodies x11vnc xvfb \
		gconf-service libnspr4 libnss3 fonts-liberation \
		libappindicator1 libcurl3 fonts-wqy-microhei

# download google chrome and install
RUN wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
RUN dpkg -i google-chrome*.deb
RUN apt-get install -f

RUN apt-get autoclean && apt-get autoremove && \
		rm -rf /var/lib/apt/lists/*

RUN apt-get install -y openjdk-8-jdk && apt-get clean -y

WORKDIR /root

COPY startup.sh ./
COPY supervisord.conf ./

COPY xfce4 ./.config/xfce4

COPY sahipro /root/sahipro

RUN java -jar /root/sahipro/install_sahi_pro_v621_20160411.jar silent_install.xml

EXPOSE 5900

ENTRYPOINT ["./startup.sh"]
