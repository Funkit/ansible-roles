google/gcloud
=========

This role installs the gcloud CLI and a list of additional related packages.

This role works with:

- Debian 11.4

Requirements
------------

- Internet access on the target.

Role Variables
--------------

**Optional:**

- `gcloud_cli_additional_components`: list of additional components on top of gcloud CLI to install.

Dependencies
------------

None

Example Playbook
----------------

```
- hosts: all
  tasks:
    - name: install google cloud CLI
      include_role: 
        name: google/gcloud
```

License
-------

MIT

Author Information
------------------

Camille Chomel, camille.chomel@gmail.com
