FROM hadoop-base

ARG USERNAME=hadooptrandong
ARG HADOOP_HOME=/home/$USERNAME/hadoop
ARG HADOOP_CONF_DIR=$HADOOP_HOME/etc/hadoop

# config hadoop
COPY master/hadoop_config/* $HADOOP_CONF_DIR

# config ssh
RUN ssh-keygen -t rsa -P '' -f ~/.ssh/id_rsa
RUN cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys
RUN chmod 600 ~/.ssh/authorized_keys

# *config hadoop is not complete, must be config in container later*

# derby
COPY resources/db-derby-10.14.2.0-bin.tar.gz .
RUN tar -xzf db-derby-10.14.2.0-bin.tar.gz && \
    mv db-derby-10.14.2.0-bin derby && \
    rm db-derby-10.14.2.0-bin.tar.gz

RUN echo 'export DERBY_HOME=/home/'$USERNAME'/derby\n\
export PATH=$PATH:$DERBY_HOME/bin\n' >> ~/.bashrc

# hive
COPY resources/apache-hive-3.1.3-bin.tar.gz .
RUN tar -xzf apache-hive-3.1.3-bin.tar.gz && \
    mv apache-hive-3.1.3-bin hive && \
    rm apache-hive-3.1.3-bin.tar.gz

RUN echo 'export HIVE_HOME=/home/'$USERNAME'/hive\n\
export PATH=$PATH:$HIVE_HOME/bin\n' >> ~/.bashrc

# hive config 
COPY master/hive_config/hive-site.xml hive/conf

# sqoop
COPY resources/sqoop-1.4.7.bin__hadoop-2.6.0.tar.gz .
RUN tar -xzf sqoop-1.4.7.bin__hadoop-2.6.0.tar.gz && \
    mv sqoop-1.4.7.bin__hadoop-2.6.0 sqoop && \
    rm sqoop-1.4.7.bin__hadoop-2.6.0.tar.gz

RUN echo 'export SQOOP_HOME=/home/'$USERNAME'/sqoop\n\
export PATH=$PATH:$SQOOP_HOME/bin\n' >> ~/.bashrc

# sqoop lib
COPY resources/commons-lang-2.6.jar sqoop/lib
COPY resources/mysql-connector-j-8.0.33.jar sqoop/lib
RUN cp hive/lib/hive-common-3.1.3.jar sqoop/lib