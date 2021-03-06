#!/bin/bash

# create Mesos slaves to connect to multiple Triton data centers
# this adds geographic diversity and redundancy, but adds complexity for everything else
#
# this doesn't use Docker Compose because it doesn't seem to work for this case
# or, perhaps it's just me who can't make it work
#
# anyway, I'll take the opportunity to parralelize this with happy ampersands

echo "     project prefix: $1"
echo "       mesos master: $2"
echo "current Docker host: $3"

function start_slave {

    for i in {1..2}
    do
        name="$COMPOSE_PROJECT_NAME"_slave_"$SLAVE_DC"_"$i"
        link="$COMPOSE_PROJECT_NAME"_zookeeper_1
        echo "creating $name on $DOCKER_HOST connected to $MESOS_MASTER"

        docker run \
        -d \
        -p 5051 \
        -m 128m \
        --name=$name \
        --restart=always \
        --link "$link":zookeeper \
        -e "TLSCA=`cat "$DOCKER_CERT_PATH"/ca.pem`" \
        -e "TLSCERT=`cat "$DOCKER_CERT_PATH"/cert.pem`" \
        -e "TLSKEY=`cat "$DOCKER_CERT_PATH"/key.pem`" \
        -e "DOCKER_HOST=$SLAVE_DOCKER_HOST" \
        -e "MESOS_MASTER=zk://zookeeper:2181/mesos" \
        misterbisson/triton-mesos-slave &
    done
}

export COMPOSE_PROJECT_NAME=$1
export MESOS_MASTER=$2
datacenters=( "us-east-3b" "us-east-1" "us-sw-1" "eu-ams-1" )
for i in "${datacenters[@]}"
do

    # don't create additional hosts for the current data center
    if [ "tcp://$i.docker.joyent.com:2376" == "$3" ]
    then
        continue
    fi

    echo
    echo "Creating slaves for $i"
    export SLAVE_DC=$i
    export SLAVE_DOCKER_HOST="tcp://$i.docker.joyent.com:2376"
    start_slave
done
