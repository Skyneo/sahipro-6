[![Docker Automated build](https://img.shields.io/docker/automated/jrottenberg/ffmpeg.svg)]()

Sahi PRO 6.2 with chrome
---

Based on consol/ubuntu-xfce-vnc:1.2.3

* sahipro 6.2.1
* java
* chrome
* ubuntu
* xfce


Start container with:

docker run -d -p 5901:5901 -p 6901:6901 -p 9999:9999 -v /opt/sahipro:/headless/sahidata smonko/sahipro-6

5901 - VNC
6901 - web VNC
9999 - sahi api

/headless/sahidata - copy your license.data here
/headless/sahidata/scripts - copy your scripts here

Maintainer
======================
Stefan Monko, stefan.monko@posam.sk
