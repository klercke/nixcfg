{
  services.udev.extraRules = ''
    # Espressif USB Serial/JTAG Controller
    SUBSYSTEM=="tty", ATTRS{idVendor}=="303a", ATTRS{idProduct}=="1001", MODE="0660", TAG+="uaccess"
  '';
}
