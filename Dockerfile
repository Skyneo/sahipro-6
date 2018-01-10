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

# download google chrome and install
#RUN wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
# COPY chrome/ ./
#
# RUN dpkg -i ./google-chrome-stable_current_amd64.deb
# RUN apt-get install -f
#RUN xfconf-query --channel xfce4-desktop --property /backdrop/screen0/monitor0/image-path --set /usr/share/backgrounds/xfce/xfce-blue.jpg

USER 1984

WORKDIR /headless

COPY sahipro /headless
COPY sahipro.desktop /headless/Desktop/sahipro.desktop

RUN wget http://sahipro.com/static/builds/pro/install_sahi_pro_v621_20160411.jar -P /headless && \
    wget http://sahipro.com/static/builds/pro/install_sahi_pro_runner_v621_20160411.jar -P /headless

RUN java -jar /headless/install_sahi_pro_v621_20160411.jar /headless/silent_install.xml

RUN mkdir /headless/sahidata && ln -s /headless/sahidata/license.data /headless/sahi_pro/userdata/config/license.data && chmod +x /headless/Desktop/sahipro.desktop

EXPOSE 5901 6901 9999

ENTRYPOINT ["/dockerstartup/vnc_startup.sh"]
CMD ["--tail-log"]
