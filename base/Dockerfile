FROM ubuntu:20.04

EXPOSE 22

ARG USERNAME=hadooptrandong
ARG USERPASSWD=2932002

RUN apt update && apt -y install sudo nano ssh openssh-server iputils-ping iproute2 openjdk-8-jdk

# config ssh
RUN sed -i '/#PubkeyAuthentication/s/^#//' /etc/ssh/sshd_config
RUN sed -i '/#PasswordAuthentication/s/^#//' /etc/ssh/sshd_config

# add user
RUN useradd -rm -d /home/$USERNAME -s /bin/bash -g root -G sudo -p $USERPASSWD $USERNAME
RUN echo "$USERNAME ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers
USER $USERNAME

# copy hadoop
WORKDIR /home/$USERNAME
COPY resources/hadoop-3.3.4.tar.gz .
RUN tar -xzf hadoop-3.3.4.tar.gz && \
    mv hadoop-3.3.4 hadoop && \
    rm hadoop-3.3.4.tar.gz

# config hadoop
RUN echo 'export JAVA_HOME=/usr/lib/jvm/java-1.8.0-openjdk-amd64\n\
export HADOOP_HOME=/home/'$USERNAME'/hadoop\n\
export PATH=$PATH:$HADOOP_HOME/bin\n\
export PATH=$PATH:$HADOOP_HOME/sbin\n\
export HADOOP_MAPRED_HOME=$HADOOP_HOME\n\
export HADOOP_COMMON_HOME=$HADOOP_HOME\n\
export HADOOP_HDFS_HOME=$HADOOP_HOME\n\
export HADOOP_CONF_DIR=$HADOOP_HOME/etc/hadoop\n\
export HADOOP_YARN_HOME=$HADOOP_HOME\n\
export HADOOP_COMMON_LIB_NATIVE_DIR=$HADOOP_HOME/lib/native\n\
export HADOOP_OPTS="-Djava.library.path=$HADOOP_HOME/lib/native"\n' >> ~/.bashrc

RUN echo 'export JAVA_HOME=/usr/lib/jvm/java-1.8.0-openjdk-amd64\n' >> ~/hadoop/etc/hadoop/hadoop-env.sh
