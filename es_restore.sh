#!/bin/bash
filename=$1
IP=$2
backesFile=es$filename.tar.gz
cd /home/elasticsearch/back
tar zxvf $backesFile
rm /home/elasticsearch/snapshot/* -rf
cp /home/elasticsearch/back/es_dump/* /home/elasticsearch/snapshot -rf

echo 'sleep 5'
sleep 5
curl -XPOST '$IP:9200/_snapshot/backup/$filename/_restore?pretty' -d '{"indices":"datastore_*"}' 
echo 'sleep 5'
sleep 5
sudo service elasticsearch restart
rm es_dump -rf 