dhcp-container
======================

This role runs a dhcpd container on Docker on the target machine, from a provided `dhcpd.conf` file (for nomenclature, see https://kb.isc.org/docs/isc-dhcp-41-manual-pages-dhcpdconf).

Requirements
------------

- Docker up and running on the target.
- Internet access or local repository on the target to pull docker images.
- The `community.general` collection installed on the controller.

Role Variables
--------------

**Mandatory:**
- `dhcp_configuration_file`: path to the `dhcpd.conf` file on the controller that is to be used by the DHCP server.

**Optional:**
- `container_name`: defaults to `dhcpd`.
- `delete_lease_files`: if set to `yes`, the `dhcpd_folder` folder will be deleted (with the lease files and the previous configuration file). Defaults to `no`.
- `dhcpd_folder`: folder mounted to the dhcpd container `/data` folder. Defaults to `/opt/dhcpd`.
- `ethernet_interface_name`: interface on the machine that will be used by the container. Defaults to `eth0`.

Dependencies
------------

None

Example playbook
----------------

```
- hosts: all
  become: yes
  tasks:
    - name: DHCP setup
      include_role:
        name: dhcp-container
      vars:
        dhcp_configuration_file: "/tmp/dhcpd.conf"
```

License
-------

MIT

Author Information
------------------

Camille Chomel, camille.chomel@gmail.com
