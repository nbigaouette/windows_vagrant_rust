# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  # To create this box:
  #   vagrant box add \
  #     --checksum 8896d48cb1c63c53d3e6484bba0a7a539818cf855dab7aeacabc243f004d7f63 \
  #     --checksum-type sha256 \
  #     windows10_x64_1809 \
  #     MSEdgeWin10.box
  # See the README.md for more details
  config.vm.box = "windows10_x64_1809"

  config.vm.hostname = "win-dev-rust"

  # Let Vagrant communicate with the VM using winrm (not ssh)
  config.vm.guest = :windows
  config.vm.communicator = "winrm"

  # See https://az792536.vo.msecnd.net/vms/release_notes_license_terms_8_1_15.pdf
  config.winrm.username = "IEUser"
  config.winrm.password = "Passw0rd!"

  config.vm.provider "virtualbox" do |vb|
    vb.name = "Rust Dev - Windows 10 x64 (1809)"
    # Display the VirtualBox GUI when booting the machine
    vb.gui = true

    # Customize the virtual machine settings:
    vb.cpus = 2
    vb.memory = "2048"
    vb.customize ["modifyvm", :id, "--vram", "128"]
    vb.customize ["modifyvm", :id, "--clipboard-mode", "bidirectional"]
  end

  ########################################################################
  #                         Provisioning
  ########################################################################

  config.vm.provision "file", source: "provisioning/common.ps1", destination: "C:\\provisioning\\common.ps1"
  config.vm.provision "file", source: "provisioning/Microsoft.PowerShell_profile.ps1", destination: "C:\\Users\\IEUser\\Documents\\WindowsPowerShell\\Microsoft.PowerShell_profile.ps1"

  # ----------------------------------------------------------------------
  # OpenSSH
  config.vm.provision "shell", path: "provisioning/ssh.ps1", upload_path: "C:\\provisioning\\ssh.ps1", privileged: true

  # ----------------------------------------------------------------------
  # Chocolatey
  config.vm.provision "shell", path: "provisioning/chocolatey/chocolatey.ps1", upload_path: "C:\\provisioning\\chocolatey\\chocolatey.ps1", privileged: true

  # ----------------------------------------------------------------------
  # Git
  config.vm.provision "shell", path: "provisioning/chocolatey/git.ps1", upload_path: "C:\\provisioning\\chocolatey\\git.ps1", privileged: true

  # ----------------------------------------------------------------------
  # neovim
  config.vm.provision "shell", path: "provisioning/chocolatey/neovim.ps1", upload_path: "C:\\provisioning\\chocolatey\\neovim.ps1", privileged: true

  # ----------------------------------------------------------------------
  # Sysinternal tools
  config.vm.provision "shell", path: "provisioning/chocolatey/sysinternals.ps1", upload_path: "C:\\provisioning\\chocolatey\\sysinternals.ps1", privileged: true

  # ----------------------------------------------------------------------
  # VSCode
  config.vm.provision "shell", path: "provisioning/chocolatey/vscode.ps1", upload_path: "C:\\provisioning\\chocolatey\\vscode.ps1", privileged: true

  # ----------------------------------------------------------------------
  # LLVM
  config.vm.provision "shell", path: "provisioning/chocolatey/llvm.ps1", upload_path: "C:\\provisioning\\chocolatey\\llvm.ps1", privileged: true

  # ----------------------------------------------------------------------
  # Visual C++ Build Tools
  # From https://github.com/rust-lang/rustup.rs/#other-installation-methods
  #     MSVC builds of rustup additionally require an installation
  #     of Visual Studio 2019 or the Visual C++ Build Tools 2019. For
  #     Visual Studio, make sure to check the "C++ tools" option. No
  #     additional software installation is necessary for basic use
  #     of the GNU build.
  # https://visualstudio.microsoft.com/downloads/
  # sha256: b356dde1e719dba8ab56c866a124015438c9a3987286d2fbb6fcfe360080ce22
  config.vm.provision "shell", path: "provisioning/visual_studio.ps1", upload_path: "C:\\provisioning\\visual_studio.ps1", privileged: true

  # ----------------------------------------------------------------------
  # Rust
  config.vm.provision "shell", path: "provisioning/rust.ps1", upload_path: "C:\\provisioning\\rust.ps1"

end
