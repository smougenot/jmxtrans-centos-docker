FROM smougenot/java-centos:javac7
MAINTAINER sylvain.mougenot@gmail.com

ENV jmxtrans_version 20121016.145842.6a28c97fbb-0

	
RUN wget "https://github.com/downloads/jmxtrans/jmxtrans/jmxtrans-${jmxtrans_version}.noarch.rpm"
RUN yum localinstall -y "jmxtrans-${jmxtrans_version}.noarch.rpm" && \
    yum clean all && \ 
	rm -f jmxtrans.rpm

# Changes :
# Config is changed to /etc/jmxtrans/jmxtrans to be exposed using volume
# A preinit script is added to add defaut config file
# TODO vérifier logrotate

ENV jmxtrans_conf_dir /etc/jmxtrans
ENV jmxtrans_heap 128

VOLUME /etc/jmxtrans
VOLUME /var/lib/jmxtrans
VOLUME /var/log/jmxtrans

RUN sed -i " \
    s|/etc/sysconfig/jmxtrans|${jmxtrans_conf_dir}/jmxtrans|g; \
    s|/var/lock/subsys/jmxtrans|/var/lock/jmxtrans|g; \
    s|^\(### END INIT INFO\)$|\1\nsh /usr/share/jmxtrans/preinit.sh|g \
	" \
    /etc/init.d/jmxtrans
ADD sources/preinit.sh /usr/share/jmxtrans/preinit.sh

