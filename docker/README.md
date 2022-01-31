docker
=========

This role installs docker for Debian, Ubuntu, CentOS and Oracle Linux distributions.

This role works with:

- Centos 8
- Oracle Linux 8
- Debian 10
- Ubuntu 20

Requirements
------------

- Internet access on the target.

Role Variables
--------------

**Optional:**

- `docker_repository_gpg_key_fingerprint`: for Debian/Ubuntu install only. Defaults to `9DC8 5822 9FC7 DD38 854A E2D8 8D81 803C 0EBF CD88`.

Dependencies
------------

None

Example Playbook
----------------

```
- hosts: all
  tasks:
    - name: install docker
      include_role: docker
```

License
-------

MIT

Author Information
------------------

Camille Chomel, camille.chomel@gmail.com
