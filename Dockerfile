FROM consol/ubuntu-xfce-vnc:1.2.3

MAINTAINER Stefan Monko "stefan.monko@posam.sk"

### Environment config
ENV VNC_PORT=5901 \
    NO_VNC_PORT=6901 \
    VNC_COL_DEPTH=24 \
    VNC_RESOLUTION=1280x1024 \
    VNC_PW=sahipro

USER 0

RUN apt-get update && apt-get install -y openjdk-8-jre && apt-get clean -y

WORKDIR /headless

COPY sahipro/silent_install.xml /headless/silent_install.xml
COPY sahipro.desktop /headless/Desktop/sahipro.desktop

#USER 1984

RUN chmod +x /headless/Desktop/sahipro.desktop && \
    wget http://sahipro.com/static/builds/pro/install_sahi_pro_v621_20160411.jar -P /headless && \
    wget http://sahipro.com/static/builds/pro/install_sahi_pro_runner_v621_20160411.jar -P /headless

RUN java -jar /headless/install_sahi_pro_v621_20160411.jar /headless/silent_install.xml && \
    mkdir /headless/sahidata && \
    mkdir /headless/sahi_pro/userdata/scripts/user && \
    ln -s /headless/sahidata/license.data /headless/sahi_pro/userdata/config/license.data && \
    ln -s /headless/sahidata/scripts /headless/sahi_pro/userdata/scripts/user && \
    cp /headless/sahi_pro/certgen/X509CA/ca/new_ca.crt /usr/share/ca-certificates/sahipro.crt && \
    dpkg-reconfigure ca-certificates

COPY sahipro/sahi.properties /headless/sahi_pro/config/sahi.properties
COPY sahipro/userdata.properties /headless/sahi_pro/userdata/config/userdata.properties

EXPOSE 5901 6901 9999

ENTRYPOINT ["/dockerstartup/vnc_startup.sh"]
CMD ["--tail-log"]
