#!/bin/bash

podname() {
  local pod=$(kubectl get po | grep $1 | awk 'NR==1{print $1;}')
  if [[ -z $pod ]]; then
    echo No pods matching $1 found
  else
    echo $pod
  fi
}

