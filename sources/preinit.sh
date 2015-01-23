#!/bin/sh
#
# Check defaut config exists for jmxtrans
#

if [ ! -z "$jmxtrans_conf_dir" ]; then
  echo "Checking config dir $jmxtrans_conf_dir"
  
  # create dir
  if [ ! -d "${jmxtrans_conf_dir}" ]; then
    mkdir -p "${jmxtrans_conf_dir}"
  fi
  
  # copy default config
  if [ ! -f "${jmxtrans_conf_dir}/jmxtrans" ]; then
	[ -f /etc/sysconfig/jmxtrans ] && cp -f /etc/sysconfig/jmxtrans "${jmxtrans_conf_dir}/"
  fi
  
  # setup config
  if [ ! -z "${jmxtrans_heap}" ]; then
    sed -i "s|\(HEAP_SIZE=\).*|\1${jmxtrans_heap}|g" "${jmxtrans_conf_dir}/jmxtrans"
  fi
else
  echo "No config dir variable jmxtrans_conf_dir"
fi
