#!/bin/bash

export AWS_PROFILE="eks-admin-vasp"

source podname.sh

query=$(cat <<'END_HEREDOC'

use hive.default;
select count(eventid), sampleimage
from vasp__json
where contains(classification, 'person')
group by sampleimage;

END_HEREDOC)

kubectl exec -it $(podname presto) -- presto/bin/presto --execute "${query}"
