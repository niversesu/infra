{ ...}: {
  flake.nixosModules = {
    # The "Standard Fixes" - Everything needed to make a VM actually work.
    vm-baseline = {config, lib, ...}: {
      # Standard Resources
      virtualisation.vmVariant.virtualisation = {
        memorySize = lib.mkDefault 8192;
        cores = lib.mkDefault 8;
        diskSize = lib.mkDefault 20480;
        # Standard QEMU options (Resolution + GPU + Acceleration)
        qemu.options = [
          "-device virtio-vga-gl"
          "-display gtk,gl=on,zoom-to-fit=on"
        ];
        # Standard Port Forwarding
        forwardPorts = [
          { host.port = 2222; guest.port = 22; }
        ];
      };

      # Kill hardware drivers that crash VMs
      mySystem.host-kale-hw.enable = lib.mkForce false;
      mySystem.host-nomi-hw.enable = lib.mkForce false;
      mySystem.host-dream-hw.enable = lib.mkForce false;

      # Standard VM User Settings
      users.users.${config.mySystem.shared.user}.password = lib.mkDefault "123";
      
      # Guest agent for better integration
      services.spice-vdagentd.enable = true;
    };

    # Lego: Resource Boost (16GB RAM / 12 Cores)
    vm-boost = {lib, ...}: {
      virtualisation.vmVariant.virtualisation = {
        memorySize = lib.mkForce 16384;
        cores = lib.mkForce 12;
      };
    };

    # Lego: Lite Mode (4GB RAM / 4 Cores)
    vm-lite = {lib, ...}: {
      virtualisation.vmVariant.virtualisation = {
        memorySize = lib.mkForce 4096;
        cores = lib.mkForce 4;
      };
    };
  };
}
