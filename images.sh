#!/bin/bash

export AWS_PROFILE="eks-admin-vasp"
frame_number=$1
frame_index="$(($frame_number-1))"
file_name="/tmp/frame${frame_number}.jpg"

source podname.sh

pod_name=$(podname kafka)

kubectl exec -it ${pod_name} -- bash -c "/opt/kafka/bin/kafka-console-consumer.sh --bootstrap-server localhost:9092 --partition 0 --offset $frame_index --max-messages 1 --topic the_actual_video > ${file_name}"

kubectl cp ${pod_name}:${file_name} ${file_name}
