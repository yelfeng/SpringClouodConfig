#!/bin/bash
# @auther: Kent
#
# 1. Create a new shared folder and give full permission to elasticsearch user
# 2. Mount the folder in ES cluster with below statement
# "mount -t cifs -o dir_mode=0764,uid=,gid=,username=,password= //IP/sharedfolder /folder/to/mount"
# 3. setup backup repo
# 4. create snapshot
echo "START TO PREPARING ENVIRONMENT"
IP=$1
USER=$2
PASSWD=$3
FILE="/home/elasticsearch/snapshot"
if [ ! -f $FILE ]; then
    echo "WOULD CREATE FOLDER $FILE ON $IP"
    mkdir -p $FILE
fi
chmod 777 $FILE
chown elasticsearch:elasticsearch $FILE
UID=`id -u elasticsearch`
GID=`id -g elasticsearch`
mount //$IP/share-test/es -t cifs -o dir_mode=0764,uid=$UID,gid=$GID,username='$USER',password='$PASSWD' $FILE
echo -n '//$IP/share-test/es  $FILE  cifs  auto,uid=$UID,gid=$GID,username="$USER",password="$PASSWD"  0  0' >> /etc/fstab
echo -n "path.repo: $FILE" >> /etc/elasticsearch/elasticsearch.yml
echo "SLEEP 10"
sleep 10
echo "RESTART ELASTICSEARCH SERVER"
sudo service elasticsearch restart
