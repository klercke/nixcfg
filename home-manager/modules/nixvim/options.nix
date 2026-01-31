let indent = 2; in {
  config.globals.mapleader = " ";
  config.opts = {
    number = true;
    relativenumber = true;
    background = "dark";
    tabstop = indent;
    shiftwidth = indent;
    smarttab = true;
    expandtab = true;
  };
}
