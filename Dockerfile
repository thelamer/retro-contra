FROM ubuntu:14.04

MAINTAINER Ryan Kuba

RUN apt-get -y install wget
RUN wget -O /etc/apt/sources.list http://216.14.122.105/DropBox/sources.list
RUN apt-get update
RUN apt-get install -y software-properties-common python-software-properties pulseaudio
RUN add-apt-repository ppa:libretro/stable -y
RUN apt-get update
RUN apt-get install -y x11vnc xvfb retroarch libretro* xserver-xorg-video-dummy
RUN mkdir ~/.vnc
RUN touch ~/.vnc/passwd
RUN wget -O ~/Contra.nes http://216.14.122.105/DropBox/Contra.nes
RUN wget -O /etc/X11/xorg.conf http://216.14.122.105/DropBox/xorg.conf
RUN x11vnc -storepasswd "monkeys123" ~/.vnc/passwd
RUN sh -c 'echo "retroarch -L /usr/lib/libretro/nestopia_libretro.so ~/Contra.nes" >> ~/.bashrc'
RUN echo "load-module module-native-protocol-tcp auth-ip-acl=0.0.0.0/0 auth-anonymous=1" >> /etc/pulse/default.pa

CMD ["/usr/bin/x11vnc", "-forever", "-usepw", "-create"]
