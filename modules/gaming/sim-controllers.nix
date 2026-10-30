{
  flake.modules.nixos.sim-controllers =
    { pkgs, ... }:
    {
      # VKB (USB vendor 231d)
      services.udev.packages = [
        (pkgs.writeTextFile {
          name = "vkb-udev-rules";
          destination = "/etc/udev/rules.d/70-vkb.rules";
          text = ''
            KERNEL=="hidraw*", ATTRS{idVendor}=="231d", MODE="0660", TAG+="uaccess"
          '';
        })
      ];
    };
}
