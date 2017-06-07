# ESBackUp
This script is used for backup elasticsearch data.Please following below steps in order to get the correct results

1, create a share folder >**_/share-test/es_** on the destination server site
then run es_prepare script **on each server** machines as below
```shell
 sed -i 's/\r$//' es_prepare.sh
 chmod 777 es_prepare.sh
 sh es_preare.sh YOUR-SHARE-SERVER-IP-ADDRESS YOUR-SHARE-SERVER-USERNAME YOUR-SHARE-SERVER-PASSWORD

```
For example:
```bash
 sh es_preare.sh 192.168.1.200 admin admin

```

2, Run backup on **elasticsearch master node**

```shell
 sed -i 's/\r$//' es_back.sh
 chmod 777 es_back.sh
 sh es_back.sh YOUR-ELASTICSEARCH-MASTER-IP

```

3, Run restore on **elasticsearch master node**

```shell
 sed -i 's/\r$//' es_restore.sh
 chmod 777 es_restore.sh
 sh es_restore.sh YOUR-ELASTICSEARCH-MASTER-IP

```
