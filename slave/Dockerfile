FROM hadoop-base

ARG USERNAME=hadooptrandong
ARG HADOOP_HOME=/home/$USERNAME/hadoop
ARG HADOOP_CONF_DIR=$HADOOP_HOME/etc/hadoop

# config hadoop
COPY slave/hadoop_config/* $HADOOP_CONF_DIR

