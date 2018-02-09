# socorro-ansible

Ansible, and more!

### Adding a new data node:

- run playbooks/disable_shard_allocation.yml (on a single host w/ http api enabled)
  - needs to be run on a host already in the cluster
  - so start with a hosts file that has an existing working host in it
- add a new data node to the ES cluster (increase min/max/desired capacity in ASG)
- wait for puppet and other things to finish
- check to make sure the node joins the ES cluster (/var/log/elasticsearch/sss_{{prod||stage}}.yml)
- playbooks/finish_configuring_es_node.yml (run only on the new data node)
  - remove all other nodes from hosts file
  - need to set new_datadog_api_key (get this from webeng datadog acct)
- wait for cluster to be green
- playbooks/enable_shard_allocation.yml
