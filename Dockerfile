FROM ubuntu:20.04
MAINTAINER Marco De Simone "marco.desimone@ceric-eric.eu"

ENV DEBIAN_FRONTEND=noninteractive
#ENV LANG=C.UTF-8 LC_ALL=C.UTF-8
ENV LC_ALL en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US.UTF-8
ENV USERNAME=oasys
ADD ./*.sh /
ADD ./limits.conf /etc/security/limits.conf
RUN chmod +x /*.sh && \
    /build-base.sh && \
    rm /build-base.sh 
ENV TINI_SUBREAPER=1
#RUN apt-get install -y libglu1-mesa-dev freeglut3-dev mesa-common-dev
ENTRYPOINT [ "/usr/bin/tini", "--" ]
CMD [ "/runoasys.sh" ]

