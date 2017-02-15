# socorro-ansible

###Adding a new data node:
- disable_shard_allocation.yml (on a single host w/ http api enabled)
- add a new data node to the ES cluster
- finish_configuring_es_node.yml (run only on the new data node)
- wait for cluster to be green
- enable_shard_allocation.yml
