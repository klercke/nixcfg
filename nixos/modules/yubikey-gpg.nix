{ pkgs, ... }:

{
  services.pcscd.enable = true;

  environment.systemPackages = with pkgs; [
    gnupg
    pinentry-curses
  ];

  programs.gnupg.agent = {
    enable = true;
    pinentryPackage = pkgs.pinentry-curses;
    enableSSHSupport = true;
  };

  environment.shellInit = ''
    gpg-connect-agent /bye
    export SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)
  '';
}
