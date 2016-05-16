#!/bin/bash
# used by jenkins to lint ansible playbooks

echo "=> Linting Ansible Code"
fail_ansible=0
for f in `find . -name "*.yml"`; do
    echo "==> LINTING $f"
    if [[ ! -z "$1" ]]; then
        ansible-lint $1 $f
    else
        ansible-lint $f
    fi
    rc=$?
    if [[ $rc != 0 ]]; then
        echo "==> LINTING FAIL: $f"
        fail_ansible=1
    fi
done

if [[ $fail_ansible == 1 ]]; then
	echo "=> FAIL"
	exit 1
else
	echo "=> SUCCESS"
fi
