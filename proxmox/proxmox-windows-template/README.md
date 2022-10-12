proxmox-windows-template
=========

**IMPORTANT:**: as of now, user input is required when installing VirtIO drivers. please connect to the VM through Proxmox's web page to do so.

This role creates a Windows VM template on the target Proxmox node.  
The default behavior will:

- Download the virtIO drivers.
- Download OpenSSH for Windows.
- Push the following files to the hypervisor:
  - autounattend file.
  - OpenSSH files.
- Create a provisioning ISO with the previous files
- Create a VM with the following disks:
  - Windows server installation media.
  - VirtIO drivers.
  - Provisioning data.
- The VM will then:
  - Install VirtIO drivers.
  - Install OpenSSH.
  - copy user data to a local folder.
- The VM is then shutdown.
- The various temporary folders are deleted.

Requirements
------------

- Proxmox VE 6.3.
- Windows server 2016 or 2019 ISO available on the target Proxmox servers.
  - Windows server 2016 DEMO ISO: https://software-download.microsoft.com/download/pr/Windows_Server_2016_Datacenter_EVAL_en-us_14393_refresh.ISO
  - Windows server 2019 DEMO ISO: https://software-download.microsoft.com/download/pr/17763.737.190906-2324.rs5_release_svc_refresh_SERVER_EVAL_x64FRE_en-us_1.iso

Role Variables
--------------

**Mandatory:**

- `os_iso_path`: path to the Windows Server ISO on the Proxmox node, formatted as per the Proxmox nomenclature for storage, for instance `local:iso/WS2016.iso`.
- `virtio_download_url`: URL to download the virtIO drivers. Check the latest version at  `https://fedorapeople.org/groups/virt/virtio-win/direct-downloads/archive-virtio/`.
- `vm_template_name`: template name as displayed on the web page.
- `vm_template_vmid`: ID of the resulting VM template. Must be free on the target Proxmox node.
- `windows_server_version`: `2016` or `2019`.

**Optional:**

- `openssh_download_url`: URL to the openSSH repository. defaults to `https://github.com/PowerShell/Win32-OpenSSH/releases/download/v8.1.0.0p1-Beta/OpenSSH-Win64.zip`
- `org_name`: defaults to `Kratos`.
- `virtio_iso_name`: name of the virtIO ISO after download. Defaults to `virtio-drivers.iso`.
- `vm_cores`: defaults to `2`.
- `vm_drive_size_gb`: defaults to `100`.
- `vm_network_bridge`: Active Linux bridge on the Proxmox node on which to associate the template. Defaults to `vmbr0`.
- `vm_ram_mb`: defaults to `4096`.
- `vm_sockets`: defaults to `1`.
- `vlan_tag`: set to the desired value if you want VLAN tagging enabled.
- `vm_target_storage_id`: defaults to `local`.
- `vm_time_zone`: defaults to `UTC`.
- `windows_server_edition`: SERVERSTANDARD, SERVERDATACENTER, SERVERDATACENTERCORE or SERVERSTANDARDCORE. Defaults to `SERVERSTANDARD`.

Dependencies
------------


Example Playbooks
----------------

```
- hosts: all
  become: yes
  tasks:
    - name: create Windows Proxmox template
      import_role:
        name: proxmox-windows-template
      vars:
        os_iso_path: local:iso/WS2016.iso
        virtio_download_url: https://fedorapeople.org/groups/virt/virtio-win/direct-downloads/archive-virtio/virtio-win-0.1.190-1/virtio-win-0.1.190.iso
        vm_template_name: WS2016Template
        vm_template_vmid: 185
        windows_server_version: 2016
```


License
-------

MIT

Author Information
------------------

Camille Chomel, camille.chomel@gmail.com
