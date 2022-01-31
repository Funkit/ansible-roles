proxmox-server
=========

This role installs Proxmox on Debian.

**!!!! IMPORTANT !!!!** This role allows you to also perform the OS update before installing PVE but if you choose to do so on Dell servers with advanced RAID controllers such as the PERC H730p, this role needs the name of the boot disk (not partition !) to perform a grub update. The disk information must be provided in the format `/dev/sdX`, X being a, b...


Requirements
------------

- Internet access for the target machine.

Role Variables
--------------

- `pve_major_version`: defaults to 6.
- `update_distribution` (boolean): does the OS need a major version update or not.
- `old_debian_dist`: Name of the current debian version.
- `target_debian_dist`: Name of the target debian version.
- `update_grub` (boolean): Whether or not to update the grub. Necessary for Dell servers with PERC H730p RAID controllers.
- `boot_disk`: If `update_grub` is set to `true`, name of the disk on which to boot, written as `/dev/sda`. This variable must be provided in the inventory file **per server** to allow for specific setup. See https://docs.ansible.com/ansible/latest/user_guide/intro_inventory.html#adding-variables-to-inventory on how to do it.


Dependencies
------------

- the `ansible-role-postfix` role. (https://github.com/geerlingguy/ansible-role-postfix)

Example Playbook
----------------

```
- hosts: all
  become: yes
  environment:
    PATH: '{{ ansible_env.PATH }}:/usr/local/sbin:/usr/sbin:/sbin'
  tasks:   
    - name: install Proxmox
      import_role:
        name: proxmox-server
      vars:
        update_distribution: true
        old_debian_dist: "stretch"
        target_debian_dist: "buster"
        update_grub: true
```


License
-------

MIT

Author Information
------------------

Camille Chomel, camille.chomel@gmail.com
