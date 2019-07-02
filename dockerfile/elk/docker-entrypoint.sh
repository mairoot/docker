#!/bin/bash

_term() {
  echo "Terminating ELK stoping"
  kill -9 java
  exit 0
}
trap _term SIGTERM SIGINT
OUTPUT_LOGFILES=""
ELK_VERSION="7.1"

if [ ! $OUTPUT_LOGFILES ]; then
cat << EOB
    
    ******************************************************
    *                                                    *
    *    Copyright: https://www.mairoot.com              *
    *    Docker image: mairoot/elk                       *
    *    https://github.com/mairoot/docker/elk           *
    *                                                    *
    ******************************************************
    SERVER SETTINGS
    ---------------
    + elk version: $ELK_VERSION
    + elk version: $ELK_VERSION
    + elk version: $ELK_VERSION
EOB
fi

ELK_HOME=/data/elk
ES_HOME=$ELK_HOME/elasticsearch
LGS_HOME=$ELK_HOME/logstash
KBN_HOME=$ELK_HOME/kibana


gosu elk $ES_HOME/bin/elasticsearch -d
OUTPUT_LOGFILES+="$ES_HOME/logs/elasticsearch.log "
gosu elk $KBN_HOME/bin/kibana >> $KBN_HOME/logs/kibana.log &
OUTPUT_LOGFILES+="$KBN_HOME/logs/kibana.log "
chown elk:elk $ES_HOME -R

touch $OUTPUT_LOGFILES
tail -f $OUTPUT_LOGFILES &
wait
