FROM centos:latest
MAINTAINER Support <support@atomicorp.com>

RUN yum -y update
RUN yum -y install wget useradd postfix && yum clean all

# RUN cd /root; NON_INT=1 wget -q -O - https://updates.atomicorp.com/installers/atomic |sh
RUN cd /tmp; wget https://packages.wazuh.com/3.x/yum/wazuh-manager-3.2.0-2.x86_64.rpm

RUN yum -y localinstall /tmp/wazuh-manager-3.2.0-2.x86_64.rpm

ADD default_agent /var/ossec/default_agent
RUN service ossec restart &&\
  /var/ossec/bin/manage_agents -f /var/ossec/default_agent &&\
  rm /var/ossec/default_agent &&\
  service ossec stop &&\
  echo -n "" /var/ossec/logs/ossec.log


#
# Initialize the data volume configuration
#
ADD data_dirs.env /data_dirs.env
ADD init.sh /init.sh
# Sync calls are due to https://github.com/docker/docker/issues/9547
RUN chmod 755 /init.sh &&\
  sync && /init.sh &&\
  sync && rm /init.sh


#
# Add the bootstrap script
#
ADD ossec-server.sh /ossec-server.sh
RUN chmod 755 /ossec-server.sh

#
# Specify the data volume 
#
VOLUME ["/var/ossec/data"]

# Expose ports for sharing
EXPOSE 1514/udp 1515/tcp

#
# Define default command.
#
ENTRYPOINT ["/ossec-server.sh"]
