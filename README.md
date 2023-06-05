# Resource

You have to download `hadoop-3.3.4.tar.gz` and put it in resources folder

# Build image

```
docker build -f base/Dockerfile -t hadoop-base \
--build-arg USERNAME=<username> \
--build-arg USERPASSWD=<password> \
.
```

## For Master

```
docker build -f master/Dockerfile -t hadoop-master \
--build-arg USERNAME=<username> \
.
```

## For Slave

```
docker build -f slave/Dockerfile -t hadoop-slave \
--build-arg USERNAME=<username> \
.
```

# Run containers

## For Master

If you have more than 1 slave, be sure that add each slave `hostname:ip` at `--add-host` argument
```
docker run \
--add-host trandong-slave1:172.18.0.3 \
--network hadoop \
--ip 172.18.0.2 \
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
--hostname trandong-slave1 \
--name hadoop-slave1 \
-it hadoop-slave bash
```

# Configure ssh

## Run ssh service

Start ssh service.
```
sudo service ssh start
```

After running all containers, run below commands on Master to get public key.
```
cat .ssh/id_rsa.pub
```
And copy public key to `authorized_keys` in all Slaves

```
mkdir .ssh
cat << EOF >> .ssh/authorized_keys
<public key>
EOF
chmod 600 ~/.ssh/authorized_keys
```

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

## Start Derby Server

```
startNetworkServer -h 0.0.0.0 &
```

## Hive Create Derby Schema

```
schematool -dbType derby -initSchema
```