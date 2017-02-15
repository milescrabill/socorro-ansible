# socorro-ansible

###Adding a new data node:
- playbooks/disable_shard_allocation.yml (on a single host w/ http api enabled)
- add a new data node to the ES cluster (increase min/max/desired capacity in ASG)
- wait for puppet and other things to finish
- check to make sure the node joins the ES cluster (/var/log/elasticsearch/sss_{{prod||stage}}.yml)
- playbooks/finish_configuring_es_node.yml (run only on the new data node)
- wait for cluster to be green
- playbooks/enable_shard_allocation.yml
