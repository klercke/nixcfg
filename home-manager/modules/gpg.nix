{
  programs.gpg = {
    enable = true;
    publicKeys = [
      { source = "${builtins.fetchurl { url = "https://z3r0d4y.dev/pgp-key.txt"; sha256 = "75f7c6e56436582a1dad19007de3516e9975a1e30633c00af3eb6aef89ef994e"; }}"; trust = 5; }
    ];
  };
}
