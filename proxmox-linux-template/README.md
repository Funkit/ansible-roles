proxmox-linux-template
==============================

This role create a Linux template on a Proxmox hypervisor, with cloud-init set up.
It currently supports:

 - CentOS (tested with v8.2)
 - Oracle Linux (tested with v8.3)

It has been validated with the following software versions:

- PVE 6.3
- Ansible 2.7.7

**Beware:** the current syntax for boot options is only valid for PVE 6.3 onwards.

The role will check the chosen VMID on the hypervisor/cluster. If it is already taken and `rebuild` is set to no, the role will fail.

The default cloud init setup performs the following:

- Install Python3.
- Create a symbolic link to the `python` command so that Ansible knows which interpreter to use. 
- On Oracle Linux only, the `$ociregion` variable occurrences are removed from the Oracle Linux and UEK yum repository files, as it currently breaks `package`, `dnf` and `yum` Ansible modules on Ansible 2.7.7. See https://yum.oracle.com/getting-started.html.
- Shutdown the machine.

After shutdown, the default behavior is to convert the VM to a template.

You can choose to not automatically convert the VM to a template in case you have some operations to do before conversion. In that case, you should use a custom cloud-init file to be able to access the VM. See the `Example Playbooks` section for this case.

If using a custom cloud-init file, it is **CRITICAL** that the custom script shuts down the machine at the end, otherwise the cleanup operations will fail. the file is read as a template so you can use the typical Ansible/Jinja syntax to provide variables. You can also adjust the maximum time allowed for cloud-init to finish; default maximum time is 1 hour.  

Requirements
------------

- Internet access for the controller and the target machine.

Role Variables
--------------

**Mandatory:**
- `target_os`: either `oracle-linux` or `centos`.
- `temp_gateway`: gateway for the template to access the internet and download packages.
- `temp_ip_address`: IP address for the template to access the internet and download packages.
- `temp_ip_address_mask`: subnet mask for the template in CIDR format (for instance '/24').
- `template_vmid`: VM template ID.

**Optional:**

- `cloud_image_name`: defaults to the value set in the corresponding `vars` file.
- `cloud_image_url`: URL of the qcow2 image. Defaults to the value set in the corresponding `vars` file.
- `cloud_init_pause_seconds`: time allowed for the VM cloud-init setup to finish. Defaults to `3600.`
- `convert_to_template`: defaults to `yes`. If set to `no`, the VM will not shut down and be accessible via ssh from the controller.
- `custom_cloud_init_path`: used only if `convert_to_template` set to `no`. Path to the custom cloud-init file on the controller.
- `proxmox_storage`: storage name as displayed in Proxmox. Defaults to `local`.
- `proxmox_storage_path`: path to Proxmox storage. defaults to `/var/lib/vz` (path to `local` storage).
- `rebuild`: if set to `yes`, it will destroy the vm with the `template_vmid` VMID if it already exists. Defaults to `no`.
- `vlan_tag`: set to the desired value if you want VLAN tagging enabled.
- `vm_cores`: defaults to `2`.
- `vm_guest_agent`: enable value is 'enabled=1,fstrim_cloned_disks=1,type=virtio', disable value is 'enabled=0'. Defaults to `enabled=1,fstrim_cloned_disks=1,type=virtio`.
- `vm_network_bridge`: network bridge on which the VM is connected. defaults to `vmbr0`.
- `vm_os_type`: defaults to `l26`.
- `vm_ram_mb`: defaults to `2048`.
- `vm_sockets`: defaults to `1`.
- `vm_template_name`: name of the template. Defaults to the value set in the corresponding `vars` file.
- Oracle Linux specific variables:
  - `oci_repo_name`: name of the Oracle Linux repo file in `/etc/yum.repos.d`. Defaults to `oracle-linux-ol8.repo`.
  - `uek_repo_name`: name of the UEK repo file in `/etc/yum.repos.d`. Defaults to `uek-ol8.repo`.


Dependencies
------------

None.

Example Playbooks
----------------

**Default behavior:**

```
- hosts: all
  tasks:   
    - name: create Oracle Linux template
      import_role:
        name: ansible-proxmox-linux-template
      vars:
        target_os: oracle-linux
        temp_gateway: 192.168.10.1
        temp_ip_address: 192.168.10.252
        temp_ip_address_mask: /24
        template_vmid: 182
```

**Disable template conversion, install nano, and allow passwordless SSH access from the controller:**

- playbook:
```
- hosts: all
  vars:
    ansible_roles_directory: "../../../Roles"
    public_ssh_key: "{{ lookup('file', '~/.ssh/id_rsa.pub') }}"
  tasks:   
    - name: create Oracle Linux template
      import_role:
        name: "{{ ansible_roles_directory }}/ansible-proxmox-linux-template"
      vars:
        convert_to_template: no
        custom_cloud_init_path: /home/admin/user-config.yml.j2
        target_os: oracle-linux
        temp_gateway: 192.168.10.1
        temp_ip_address: 192.168.10.252
        temp_ip_address_mask: /24
        template_vmid: 182
```

- cloud-init template file at `/home/admin/user-config.yml.j2`:
```
#cloud-config
users:
  - default
  - name: {{ ansible_env.USER }}
    gecos: default admin user
    sudo: ALL=(ALL) NOPASSWD:ALL
    groups: users
    ssh_import_id: None
    lock_passwd: false
    ssh_authorized_keys:
      - {{ public_ssh_key }}
packages:
  - python3
  - nano
runcmd:
  - [ sh, -c, alternatives --set python /usr/bin/python3 ]
  - sed -i 's/$ociregion//g' "/etc/yum.repos.d/{{ oci_repo_name }}"
  - sed -i 's/$ociregion//g' "/etc/yum.repos.d/{{ uek_repo_name }}"
power_state:
  delay: "+1"
  mode: poweroff
  message: Bye Bye
  timeout: 200
  condition: True
```

License
-------

MIT

Author Information
------------------

Camille Chomel, camille.chomel@gmail.com
