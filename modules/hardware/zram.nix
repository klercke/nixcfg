{
  flake.modules.nixos.zram = {
    zramSwap = {
      enable = true;
      algorithm = "zstd";
      memoryPercent = 100;
      priority = 100;
      #writebackDevice = "/.swapvol"; # Disabled for now because it seems I need a block device, not a btrfs subvol for this
    };
    #swapDevices = lib.mkForce [ ];
    #boot.kernelParams = [ "systemd.swap=0" ];
    boot.kernel.sysctl = {
      # https://wiki.archlinux.org/title/Zram#Using_zramswap
      # https://github.com/pop-os/default-settings/pull/163
      # https://www.reddit.com/r/linux_gaming/comments/vla9gd/comment/ie1cnrh/
      "vm.swappiness" = 180;
      "vm.watermark_boost_factor" = 0;
      "vm.watermark_scale_factor" = 125;
      "vm.page-cluster" = 0;
    };
  };
}
