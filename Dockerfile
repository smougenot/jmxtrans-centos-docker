FROM smougenot/java-centos:javac7
MAINTAINER sylvain.mougenot@gmail.com

ENV jmxtrans_version 20121016.145842.6a28c97fbb-0

	
RUN wget "https://github.com/downloads/jmxtrans/jmxtrans/jmxtrans-${jmxtrans_version}.noarch.rpm"
RUN yum localinstall -y "jmxtrans-${jmxtrans_version}.noarch.rpm" && \
    yum clean all && \ 
	rm -f jmxtrans*.rpm

# Changes :
# Config is changed to /etc/jmxtrans/jmxtrans to be exposed using volume
# A preinit script is added to add defaut config file
# TODO vérifier logrotate

ENV jmxtrans_conf_dir /etc/jmxtrans
ENV jmxtrans_heap 128

VOLUME /etc/jmxtrans
VOLUME /var/lib/jmxtrans
VOLUME /var/log/jmxtrans

# keep the shell running after java process launch
RUN sed -i " \
    s|\(\$JAVA.*\)2>&1 &|\1|g \
	" \
    /usr/share/jmxtrans/jmxtrans.sh

ADD sources/launch.sh /usr/share/jmxtrans/launch.sh

ENTRYPOINT ["/usr/share/jmxtrans/launch.sh"]

