#!/bin/bash
SERVER_ADDR=${SERVER_ADDR:-0.0.0.0}
SERVER_PORT=${SERVER_PORT:-80}
LOCAL_PORT=${LOCAL_PORT:-1081}
PASSWORD=${PASSWORD:-ZQoPF2g6uwJE7cy4}
METHOD=${METHOD:-chacha20-ietf}
TIMEOUT=${TIMEOUT:-300
PROTOCOL=${PROTOCOL:-origin}
OBFS=${OBFS:-plain}

while getopts "s:p:l:k:m:t:O:o:" OPT; do
  case $OPT in
    s)
        SERVER_ADDR=$OPTARG;;
    p)
        SERVER_PORT=$OPTARG;;
    l)
        LOCAL_PORT=$OPTARG;;
    k)
        PASSWORD=$OPTARG;;
    m)
        METHOD=$OPTARG;;
    t)
        TIMEOUT=$OPTARG;;
    O)
        PROTOCOL=$OPTARG;;
    o)
        OBFS=$OPTARG;;
  esac
done

/usr/local/bin/sslocal -s $SERVER_ADDR -p $SERVER_PORT -l $LOCAL_PORT -k "$PASSWORD" -m $METHOD -t $TIMEOUT -O $PROTOCOL -o $OBFS --fast-open