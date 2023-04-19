
DNW
Add the following into `/etc/ansible.cfg` on the server running the ansible
https://www.2daygeek.com/how-to-automatically-accept-ssh-key-fingerprint/

```cfg
[defaults]
host_key_checking = false
ansible_python_interpreter=/usr/bin/python3
```


## Docker Swarm Deploy

```bash
pip3 install docker
ansible-galaxy collection install community.docker
ansible-galaxy collection install community.general

ansible-playbook playbook.yaml -i inv
```
