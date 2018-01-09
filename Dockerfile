FROM ubuntu:14.04.3

MAINTAINER Stefan Monko "stefan.monko@posam.sk"

ENV HOME /root
ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update -y
RUN apt-get install -y supervisor wget \
		xfce4 xfce4-goodies x11vnc xvfb \
		gconf-service libnspr4 libnss3 fonts-liberation \
		libappindicator1 libcurl3 fonts-wqy-microhei

RUN apt-get install -y openjdk-7-jre && apt-get clean -y

# download google chrome and install
#RUN wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
COPY chrome/ ./

RUN dpkg -i ./google-chrome-stable_current_amd64.deb
RUN apt-get install -f

RUN apt-get autoclean && apt-get autoremove && \
		rm -rf /var/lib/apt/lists/*

WORKDIR /root

COPY startup.sh ./
COPY supervisord.conf ./

COPY xfce4 ./.config/xfce4

COPY sahipro ./

RUN wget http://sahipro.com/static/builds/pro/install_sahi_pro_v621_20160411.jar && \
    wget http://sahipro.com/static/builds/pro/install_sahi_pro_runner_v621_20160411.jar

RUN java -jar ./install_sahi_pro_v621_20160411.jar ./silent_install.xml

EXPOSE 5900

ENTRYPOINT ["./startup.sh"]
