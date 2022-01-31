dns-container
=====================

This role runs a CoreDNS container on Docker on the target machine that:

- Resolves the entries specified in the source CSV (an example CSV is provided below in `Example playbook and associated CSV`).
- Forwards all other requests to the general purpose DNS.

The CSV file is read, then used to create host files on the target. These files are used in `hosts` plugin server blocks (see `Corefile.j2` Corefile template).

Requirements
------------

- Docker up and running on the target.
- Internet access or local repository on the target to pull docker images.
- The `community.general` collection installed on the controller.
- The equipment CSV must have the following columns:
  - `hostname`: equipment hostname without the zone. If the FQDN is `eqt-1.zone1.client`, hostname is `eqt-1`.
  - `dns_zone`: zone part of the FQDN. If the FQDN is `eqt-1.zone1.client`, dns_zone is `zone1.client`.
  - `ipaddr`: associated ip.

Role Variables
--------------

**Mandatory:**
- `csv_source`: CSV file to use as a source for DNS entries.

**Optional:**

- `container_name`: defaults to `dns`.
- `coredns_folder`: the folder on the target machine that will be used as a bind mount for the `/root` folder in the container. Defaults to `/opt/coredns`.
- `dns_port`: the container's published port on the host. Defaults to `53`.
- `dns_record_ttl_sec`: defaults to `3600`.
- `general_dns`: defaults to `8.8.8.8 1.1.1.1`.
- `rebuild`: choose if the container is rebuilt when running the playbook. Defaults to `yes`.


Dependencies
------------

None

Example playbook and associated CSV
-----------------------------------

**Playbook:**
```
- hosts: all
  become: yes
  tasks:
    - name: DNS setup
      include_role:
        name: dns-container
      vars:
        csv_source: dns.csv
```

**dns.csv:**
```
name,hostname,ipaddr,dns_zone
Equipment 1,eqt1,10.0.5.10,zone1.client
Equipment 2,eqt2,10.0.5.255,zone1.client
Equipment 3,eqt3,10.0.50.10,zone2.client
Equipment 4,eqt4,10.0.50.255,zone2.client
Equipment 5,eqt5,10.0.75.10,zone3.client
Equipment 6,eqt6,10.0.75.255,zone3.client
Equipment 7,eqt7,10.0.120.10,zone4.client
Equipment 8,eqt8,10.0.120.255,zone4.client
```

License
-------

MIT

Author Information
------------------

Camille Chomel, camille.chomel@gmail.com
