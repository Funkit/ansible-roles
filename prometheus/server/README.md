prometheus/server
==================

This role runs a Prometheus container on Docker on the target machine, from a provided `prometheus.yml` file (for nomenclature, see https://prometheus.io/docs/prometheus/latest/configuration/configuration/).

Requirements
------------

- Docker up and running on the target.
- Internet access or local repository on the target to pull docker images.
- The `community.general` collection installed on the controller.

Role Variables
--------------

**Mandatory:**
- `prometheus_configuration_file`: path to the `prometheus.yml` file on the controller that is to be used by the DHCP server.

**Optional:**
- `container_name`: defaults to `prometheus`.
- `delete_data`: if set to `yes`, the `prometheus_folder` folder will be deleted (with the lease files and the previous configuration file). Defaults to `no`.
- `prometheus_folder`: folder mounted to the Prometheus container `/etc/prometheus` folder. Defaults to `/opt/prometheus`.
- `prometheus_port`:  Defaults to `9090`.
- `data_folder`: folder mounted to the Prometheus container `/data/prometheus` folder. Defaults to `/opt/prometheus/data`.

Dependencies
------------

None

Example playbook
----------------

```
- hosts: all
  become: yes
  tasks:
    - name: Start Prometheus server
      include_role:
        name: prometheus/server
      vars:
        prometheus_configuration_file: prometheus.yml
```

License
-------

MIT

Author Information
------------------

Camille Chomel, camille.chomel@gmail.com
