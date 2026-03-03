{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    clinfo
    rocmPackages.amdsmi
    btop-rocm
  ];

  hardware.amdgpu.opencl.enable = true;

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };
}
