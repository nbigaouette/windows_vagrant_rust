# Windows Virtual Machine

Provisioning a Windows 10 virtual machine allow compiling and debugging the project natively.

Microsoft provides virtual machine images that will expire after 90 days of the their first
use. To prevent issues, _provisioning_ is done to automate the setup of the VM, allowing
deletion without loss of productivity. It also assures that everyone uses the same
reproducible environment ("environment as code").

After a VM is provisioned, it will stay valid for 90 days. One has to _destroy_ that VM
before that and re-provision a new one.

The current working directory
will be shared inside the VM as `C:\vagrant`. In the VM, simply change to that directory
and compile as needed.

**NOTE**: To prevent the `target` directory (where cargo puts its compilation artifacts) to be
recompiling code from macOS/Linux and Windows, the VM has the variable `CARGO_TARGET_DIR`
environment variable set to `C:\cargo_target`. This means the compilation artifacts will
stay _inside_ the VM and will disappear on VM destruction (required at least every 90 days).
Also, this should speed compilation since the shared drive uses the network interface between
the guest VM and the host.

## Vagrant

Vagrant allows provisioning a virtual machine, similarly as Docker allows
provisioning a container.

Download and install vagrant, either from [its website](https://www.vagrantup.com/), homebrew or
your Linux package manager.

You will also need a Virtual Machine hypervisor. The Vagrant configuration file specifies
[VirtualBox](https://www.virtualbox.org/), which is free (and open-source). Other
hypervisors where not tried or tested.

## Download

* Download the virtual machine archive
  * Visit https://developer.microsoft.com/en-us/microsoft-edge/tools/vms/ 
  * **Virtual machine**: Choose `MSEdge on Win10 (x64) Stable 1809
  * **Select platform**: Choose `Vagrant`
  * `MSEdge.Win10.Vagrant.zip`'s sha256sum: `64ab31e1139b7dd43e997e0dde934860c619413c2725076aae41d8878fd0cabe`
* Unzip the archive.
  * `MSEdge - Win10.box`'s sha256sum: 8896d48cb1c63c53d3e6484bba0a7a539818cf855dab7aeacabc243f004d7f63
* Rename the file to `MSEdgeWin10.box` (no spaces)

----

Add the box to Vagrant's database:

```sh
> vagrant box add \
    --checksum 8896d48cb1c63c53d3e6484bba0a7a539818cf855dab7aeacabc243f004d7f63 \
    --checksum-type sha256 \
    windows10_x64_1809 \
    MSEdgeWin10.box
==> box: Box file was not detected as metadata. Adding it directly...
==> box: Adding box 'windows10' (v0) for provider:
    box: Unpacking necessary files from: file:///path/to/MSEdgeWin10.box
==> box: Successfully added box 'windows10' (v0) for 'virtualbox'!
```

## Managing the Virtual Machine

### VM Creation and Provisioning

Create and boot the virtual machine:

```sh
> vagrant up
Bringing machine 'default' up with 'virtualbox' provider...
==> default: Importing base box 'windows10_x64_1809'...
==> default: Matching MAC address for NAT networking...
==> default: Setting the name of the VM: Rust Dev - Windows 10 x64 (1809)
==> default: Clearing any previously set network interfaces...
==> default: Preparing network interfaces based on configuration...
    default: Adapter 1: nat
==> default: Forwarding ports...
    default: 5985 (guest) => 55985 (host) (adapter 1)
    default: 5986 (guest) => 55986 (host) (adapter 1)
    default: 22 (guest) => 2222 (host) (adapter 1)
==> default: Running 'pre-boot' VM customizations...
==> default: Booting VM...
==> default: Waiting for machine to boot. This may take a few minutes...
    default: WinRM address: 127.0.0.1:55985
    default: WinRM username: IEUser
    default: WinRM execution_time_limit: PT2H
    default: WinRM transport: negotiate
==> default: Machine booted and ready!
    [...]
```

The full provisioning can take up to 20 minutes to do. Please be patient!

### Delete VM

Note that this is required to be run at least every 90 days since the VM license expires
after that.

```sh
vagrant destroy
```

## Connection

OpenSSH is installed in the VM. Simply connect to it:

```sh
ssh IEUser@localhost -p 2222
```

Password is `passw0rd!` as defined here: https://az792536.vo.msecnd.net/vms/release_notes_license_terms_8_1_15.pdf
