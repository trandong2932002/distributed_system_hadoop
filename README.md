# Resource

You have to download `hadoop-3.3.4.tar.gz` and put it in resources folder

# Build image

```
docker buildx build -f base/Dockerfile -t hadoop-base .
```

## For Master

```
docker buildx build -f master/Dockerfile -t hadoop-master .
```

## For Slave

```
docker buildx build -f slave/Dockerfile -t hadoop-slave .
```

# Run containers

## For Master

If you have more than 1 slave, be sure that add each slave `hostname:ip` at `--add-host` argument
```
docker run \
--add-host trandong-slave1:172.18.0.3 \
--network hadoop \
--ip 172.18.0.2 \
-p 22 \
--hostname trandong-master \
--name hadoop-master \
-it hadoop-master bash
```

## For Slave

Remember change ip, hostname, name for each slave
```
docker run \
--add-host trandong-master:172.18.0.2 \
--network hadoop \
--ip 172.18.0.3 \
-p 22 \
--hostname trandong-slave1 \
--name hadoop-slave \
-it hadoop-slave bash
```

# Configure ssh

## Run ssh service

```
sudo service ssh start
```

After running all containers, run below commands on Master and all Slaves
```
ssh-keygen -t rsa -P '' -f ~/.ssh/id_rsa
cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys
chmod 600 ~/.ssh/authorized_keys
```

Run below command on Master only (If you get a Permission denied, you are right, `Ctrl+C` to done)
```
ssh-copy-id -i .ssh/id_rsa hadooptrandong@trandong-slave1
```
If you have more Slave than 1, run above command one time for each Slave

After that, you have to copy public key of Master from `~/.ssh/id_rsa.pub` to `authorized_keys` of all Slaves

To test connection between Master and all Slaves, type below command for each Salve
```
ssh hadooptrandong@trandong-slave1
```

# Configure Hadoop

## Configure workers

If you have more than 1 Slave, go to `~/hadoop/etc/hadoop/workers` and add all Slave hostname into it

## Format Namenode

```
hdfs namenode -format
```

## Start Hadoop

```
start-all.sh
```

