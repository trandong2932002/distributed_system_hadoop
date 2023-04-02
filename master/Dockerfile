FROM hadoop-base

ARG USERNAME=hadooptrandong
ARG HADOOP_HOME=/home/$USERNAME/hadoop
ARG HADOOP_CONF_DIR=$HADOOP_HOME/etc/hadoop

# config hadoop
COPY master/hadoop_config/* $HADOOP_CONF_DIR

# format
# RUN hdfs namenode -format

# RUN ssh-keygen -t rsa -P '' -f ~/.ssh/id_rsa
# RUN cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys
# RUN chmod 600 ~/.ssh/authorized_keys
# RUN ssh-copy-id -i .ssh/id_rsa trandong-slave1