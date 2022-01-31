prometheus/node_exporter
========================

This role installs the [Prometheus](https://prometheus.io/) Linux node exporter on the target machine.

Requirements
------------

- Internet access on the controller.
- The `ansible.posix` collection installed on the controller.

Role Variables
--------------

**Mandatory:**
- `exporter_version`: version of the exporter to install.

**Optional:**
- `service_user`: name of the service user that will be used by the exporter. Defaults to `node_exporter`.

Dependencies
------------

None.

Example Playbook
----------------

```
- hosts: all
  tasks:
    - name: install exporter
      include_role: 
        name: prometheus/node_exporter
      vars:
        exporter_version: 1.1.2
```

License
-------

MIT

Author Information
------------------

Camille Chomel, camille.chomel@gmail.com
