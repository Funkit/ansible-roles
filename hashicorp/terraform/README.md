terraform
=========

This role installs docker for Debian, Ubuntu, CentOS and Oracle Linux distributions.

This role has been tested with:

- Debian 11.4

Requirements
------------

- Internet access on the target.

Role Variables
--------------

**Optional:**


Dependencies
------------

None

Example Playbook
----------------

```
- hosts: all
  tasks:
    - name: install terraform
      include_role: 
        name: hashicorp/terraform
      
```

License
-------

MIT

Author Information
------------------

Camille Chomel, camille.chomel@gmail.com
