docker
=========

This role installs docker for Debian, Ubuntu, CentOS and Oracle Linux distributions.

This role works with:

- Debian 11.4

Requirements
------------

- Internet access on the target.

Role Variables
--------------

**Optional:**

- `gpg_key_path`: directory where to store the GPG key. Defaults to `/etc/apt/keyrings`.

Dependencies
------------

None

Example Playbook
----------------

```
- hosts: all
  tasks:
    - name: install docker
      include_role: 
        name: docker
```

License
-------

MIT

Author Information
------------------

Camille Chomel, camille.chomel@gmail.com
