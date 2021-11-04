[all:vars]
ansible_connection=ssh
ansible_user=<USER>
ansible_ssh_private_key_file=<PATH_TO_PRIVATEKEY>

[web1]
<IP_FIRST_VM>
[web2]
<IP_SECOND_VM>

[web1:vars]
VM_ID=First
[web2:vars]
VM_ID=Second
