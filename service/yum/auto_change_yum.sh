#!/bin/bash
for ip in `awk '{if (NR>2){print $1}}' /etc/hosts`
do
    if [ $? = 0 ] ; then
    ssh root@$ip <<EOF
        cd /etc/yum.repos.d
        mkdir repo.bak
        mv *.repo repo.bak
        cat > yisa.repo <<eof
        [yisa]
        name=Server
        baseurl=http://51.1.1.124:8000
        enable=1
        gpgcheck=0
        eof
        yum clean all
EOF
        if [ $? = 0 ] ; then
            echo "$ip change yum is ok"
        else
            echo "$ip change yum is faild"
        fi
    fi
done
