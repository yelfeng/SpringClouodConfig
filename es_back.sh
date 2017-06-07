#!/bin/bash
# @auther: Kent
#

IP=`ifconfig eth0 | awk -F"[: ]+" '/inet addr:/ {print $4}'`
curl -XPUT 'http://$IP:9200/_snapshot/backup' -d '{ "type": "fs", "settings": { "location": "/home/elasticsearch/snapshot","compress": true }}'
filename=`date+%Y%m%d%H`
backupFile=es$filename.tar.gz
FILE='/home/elasticsearch/back/es_dump'
if [ ! -f $FILE ];then
	mkdir -p $FILE
fi
chmod 777 $FILE
cd $FILE
curl -XDELETE '$IP:9200/_snapshot/backup/$filename?pretty'
echo 'sleep 30'
sleep 30
curl -XPUT '$IP:9200/_snapshot/backup/$filename?wait_for_completion=true&pretty'
echo 'sleep 30'
sleep 30
cp /home/elasticsearch/snapshot/* /home/elasticsearch/back/es_dump -rf
cd ..
tar czf $backupFile  es_dump/
rm es_dump -rf

