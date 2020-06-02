#!/bin/bash

export AWS_PROFILE="eks-admin-vasp"

podname() {
  local pod=$(kubectl get po | grep $1 | awk 'NR==1{print $1;}')
  if [[ -z $pod ]]; then
    echo No pods matching $1 found
  else
    echo $pod
  fi
}

query=$(cat <<'END_HEREDOC'

use hive.default;
select count(eventid), sampleimage
from vasp__json
where contains(classification, 'person')
group by sampleimage;

END_HEREDOC)

kubectl exec -it $(podname presto) -- presto/bin/presto --execute "${query}"
