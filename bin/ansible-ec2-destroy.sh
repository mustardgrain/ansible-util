#!/bin/bash -e

if [ $# -lt 1 ] ; then
  echo "Usage: $0 <instance group name>"
  exit 1
fi

hosts=$1

if [ "$AWS_ACCESS_KEY" = "" ] ; then
    echo "ERROR: AWS_ACCESS_KEY environment variable not set"
    exit 1
fi

if [ "$ANSIBLE_PRIVATE_KEY_FILE" = "" ] ; then
    echo "ERROR: ANSIBLE_PRIVATE_KEY_FILE environment variable not set"
    exit 1
fi

cd "`dirname $0`"/..

ansible-playbook playbooks/destroy-ec2-instances.yml --extra-vars "hosts=$hosts"
