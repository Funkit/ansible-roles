proxmox-linux-vm-provisioning
=========

This roles aims to provision a group of VMs defined in the inventory on selected hypervisors. 

**Beware:** the current syntax for boot options is only valid for Proxmox VE 6.3 onwards.

Requirements
------------

- There is a base template from which new VMs can be cloned.
- The base template for provisioned VMs is accessible on the hypervisor the VM is supposed to be on. This means either a shared storage medium or a template located on the hypervisor.

Role Variables
--------------  

Variables have to be defined in either the hypervisor group or the VM groups. See at the end of this document for an example inventory and playbook.

**Hypervisor variables:**
- ***Mandatory:***
  - `vm_group_name`: for a given hypervisor, the associated inventory group name of the VMs that should run on said hypervisor.
- ***Optional:***
  - `template_cloning_timeout_sec`: allowed time for hypervisor operations on VMs (cloning and deleting). Adjust it depending on your storage speed. Defaults to `10`.
  - `vm_setup_delay_sec`: time allowed for the VM to start before trying to connect via SSH. Defaults to `120`.

**VM groups variables:**
- ***Mandatory:***
  - `force_recreate`: if `true`, the target vm will be deleted if it already exists. If `false`, if the VM ID is already taken, the corresponding VM is not modified.
  - `gateway`: network gateway. Will be provided to cloud-init network settings.
  - `ip_address_mask`: network mask in CIDR format, for instance `/24`.
  - `proxmox_storage`: name of the target storage name for the vms. Defaults to `local`.
  - `proxmox_storage_path`: path of the target storage name for the vms. Defaults to the local path, `/var/lib/vz`.
  - `template_vmid`: ID of the template to clone.
  - `vm_network_bridge`: network bridge on which the VM is connected. defaults to `vmbr0`.
  - `vmid`: new vm ID.
- ***Optional:***
  - `vlan_tag`: set to the desired value if you want VLAN tagging enabled.
  - `vm_disk_additional_size`: the memory increase for the VM main disk. Example value would be `20G`. Note that it only increases disk size from the hypervisor point of view: you will still have to resize the partition inside the VM for it to be taken into account.


Dependencies
------------

None.

Example Playbook and associated inventory
-----------------------------------------

In the example below, there are 2 hypervisors:
- `192.168.10.20` hosts VMs:
  - `192.168.11.140`:
    - cloned from template with Proxmox VM ID `190`, allowing `5` seconds for cloning and deleting.
    - `force_recreate` set to `yes`, meaning this VM will be destryed 
    - Proxmox VM name: `vm-1`
    - Proxmox VM ID: `110`
    - gateway IP: `192.168.11.2`
    - IP mask: `/24`
    - VLAN tag enabled with the value `11`.
    - network bridge: `vmbr0`
    - VM disk is on the `local` data storage, with the associated path `/var/lib/vz` on the server.
- `192.168.10.21` hosts VMs:
  - `192.168.12.242`:
    - cloned from template with Proxmox VM ID `290`, allowing `5` seconds for cloning and deleting
    - Proxmox VM name: `vm-2`
    - Proxmox VM ID: `210`
    - gateway IP: `192.168.11.2`
    - IP mask: `/24`
    - VLAN tag enabled with the value `12`.
    - network bridge: `vmbr0`
    - VM disk is on the `local` data storage, with the associated path `/var/lib/vz` on the server.
  - `192.168.50.242`:
    - cloned from template with Proxmox VM ID `290`, allowing `5` seconds for cloning and deleting
    - Proxmox VM name: `vm-3`
    - Proxmox VM ID: `211`
    - gateway IP: `192.168.50.2`
    - IP mask: `/24`
    - VLAN tag enabled with the value `50`.
    - network bridge: `vmbr0`
    - VM disk is on the `local` data storage, with the associated path `/var/lib/vz` on the server.


**Playbook**:

```
- hosts: hypervisors
  vars:
    public_ssh_key: "{{ lookup('file', '~/.ssh/id_rsa.pub') }}"
  tasks:
    - name: linux vm provisioning
      include_role:
        name: proxmox-linux-vm-provisioning
```

**inventory**:

```
[hypervisors]
192.168.10.20 vm_group_name=vm-group-1
192.168.10.21 vm_group_name=vm-group-2

[vm-group-1]
192.168.11.140 vm_name=vm-1 vmid=110 force_recreate=yes vlan_tag=11 gateway=192.168.11.2
[vm-group-1:vars]
ip_address_mask=/24
proxmox_storage=local
proxmox_storage_path=/var/lib/vz
template_cloning_timeout_sec=5
template_vmid=190
vm_network_bridge=vmbr0

[vm-group-2]
192.168.12.242 vm_name=vm-2 vmid=210 force_recreate=no vlan_tag=12 gateway=192.168.12.2
192.168.50.242 vm_name=vm-3 vmid=211 force_recreate=no vlan_tag=50 gateway=192.168.50.2
[vm-group-2:vars]
ip_address_mask=/24
proxmox_storage=local
proxmox_storage_path=/var/lib/vz
template_cloning_timeout_sec=5
template_vmid=290
vm_network_bridge=vmbr0
```

License
-------

MIT

Author Information
------------------

Camille Chomel, camille.chomel@gmail.com
