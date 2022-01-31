linux-basic-setup
=========================

The `linux-basic-setup` role aims to customize a group of already deployed VMs with options that are not available with cloud-init (like keyboard setup) as well as providing a consistent admin login/password, and checking that various packages have indeed been installed.

Requirements
------------

VMs have access to the internet or a local package repository.

Role Variables
--------------  

**Mandatory:**
- `admin_login`: passwordless sudo admin login.
- `admin_password`: passwordless sudo admin password. Should be provided as sha512 hash (see `Example Playbook` to see how to encrypt a password prompt).

**Optional:**
- `keyboard_locale`: defaults to `gb`.
- `packages_to_install`: list of packages that you want installed on the VMs. The `package` module is installed, which means the default OS mackage manager is used. Defaults to `nano`.
- `ssh_with_password`: allowing (or not) ssh login with password instead of public key authentication. Defaults to `yes`.

Dependencies
------------

None.

Example playbooks
----------------

```
- hosts: target-vms
  become: yes
  vars_prompt:
    - name: admin_login
      prompt: "admin user login"
    - name: admin_password
      prompt: "admin user password"
      private: yes
      encrypt: "sha512_crypt"
      confirm: yes
  tasks:
    - name: linux basic setup
      include_role:
        name: linux-basic-setup
      vars:
        packages_to_install:
          - nano
          - python3-pip
          - bind-utils
```

License
-------

MIT

Author Information
------------------

Camille Chomel, camille.chomel@gmail.com
