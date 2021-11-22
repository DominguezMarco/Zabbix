#!/usr/bin/env bash

blstatus=0
blresult=""

NETWORKS="45.226.144. 45.226.145. 45.226.146. 45.226.147. 200.115.15. 156.245.0."

for NETWORK in $NETWORKS
do
        for HOST in $(seq 0 255)
        do
                IP=$NETWORK$HOST
                r_ip=$(echo $IP|awk -F"." '{for(i=NF;i>0;i--) printf i!=1?$i".":"%s",$i}')
                result=$(dig +short $r_ip.$2)

                if [ ! -z "$result" ]
                then
                        blstatus=$(($blstatus + 1))
                        blresult=${blresult}:$IP
                        result=""
                fi
        done
done
if [ $blstatus -gt 0 ]
then
        echo "IPLISTED[$blstatus]$blresult"
else
        echo "OK"
fi
exit 0
