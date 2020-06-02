#!/bin/bash

export AWS_PROFILE="eks-admin-vasp"

source podname.sh

query=$(cat <<'END_HEREDOC'

use hive.default;
select ts, avg(count) from (
select date_trunc('minute', from_iso8601_timestamp(timestamp)) as ts, sampleimage, count(eventid) as count
from vasp__json
where contains(classification, 'person')
group by date_trunc('minute', from_iso8601_timestamp(timestamp)), sampleimage
)
group by ts
order by ts

END_HEREDOC)

kubectl exec -it $(podname presto) -- presto/bin/presto --execute "${query}"
