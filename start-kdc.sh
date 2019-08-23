#! /bin/bash

/usr/sbin/kdb5_util -P changeme create -s


## password only user
/usr/sbin/kadmin.local -q "addprinc  -randkey ifilonenko"
/usr/sbin/kadmin.local -q "ktadd -k /var/keytabs/ifilonenko.keytab ifilonenko"

/usr/sbin/kadmin.local -q "addprinc -randkey HTTP/server.bigdata.svc.cluster.local"
/usr/sbin/kadmin.local -q "ktadd -k /var/keytabs/server.keytab HTTP/server.bigdata.svc.cluster.local"

/usr/sbin/kadmin.local -q "addprinc -randkey hdfs/nn.bigdata.svc.cluster.local"
/usr/sbin/kadmin.local -q "addprinc -randkey HTTP/nn.bigdata.svc.cluster.local"
/usr/sbin/kadmin.local -q "addprinc -randkey hdfs/dn1.bigdata.svc.cluster.local"
/usr/sbin/kadmin.local -q "addprinc -randkey HTTP/dn1.bigdata.svc.cluster.local"

/usr/sbin/kadmin.local -q "ktadd -k /var/keytabs/hdfs.keytab hdfs/nn.bigdata.svc.cluster.local"
/usr/sbin/kadmin.local -q "ktadd -k /var/keytabs/hdfs.keytab HTTP/nn.bigdata.svc.cluster.local"
/usr/sbin/kadmin.local -q "ktadd -k /var/keytabs/hdfs.keytab hdfs/dn1.bigdata.svc.cluster.local"
/usr/sbin/kadmin.local -q "ktadd -k /var/keytabs/hdfs.keytab HTTP/dn1.bigdata.svc.cluster.local"

chown hdfs /var/keytabs/hdfs.keytab

keytool -genkey -alias nn.bigdata.svc.cluster.local -keyalg rsa -keysize 1024 -dname "CN=nn.bigdata.svc.cluster.local" -keypass changeme -keystore /var/keytabs/hdfs.jks -storepass changeme
keytool -genkey -alias dn1.bigdata.svc.cluster.local -keyalg rsa -keysize 1024 -dname "CN=dn1.bigdata.svc.cluster.local" -keypass changeme -keystore /var/keytabs/hdfs.jks -storepass changeme

chmod 700 /var/keytabs/hdfs.jks
chown hdfs /var/keytabs/hdfs.jks


krb5kdc -n
