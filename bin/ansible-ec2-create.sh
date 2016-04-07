#!/bin/bash -e

if [ $# -lt 3 ] ; then
  echo "Usage: $0 <instance group name> <instance size> <instance count>"
  exit 1
fi

hosts=$1
size=$2
count=$3

if [ "$AWS_ACCESS_KEY" = "" ] ; then
    echo "ERROR: AWS_ACCESS_KEY environment variable not set"
    exit 1
fi

if [ "$ANSIBLE_PRIVATE_KEY_FILE" = "" ] ; then
    echo "ERROR: ANSIBLE_PRIVATE_KEY_FILE environment variable not set"
    exit 1
fi

cd "`dirname $0`"/..

ansible-playbook playbooks/launch-ec2-instances.yml --extra-vars "instance_count=$count instance_type=$size instance_group_name=$hosts"
ansible-playbook playbooks/run-script.yml --extra-vars "hosts=$hosts script_path=../scripts/docker-install.sh"
ansible-playbook playbooks/run-script.yml --extra-vars "hosts=$hosts script_path=../scripts/docker-allow-ubuntu.sh"
