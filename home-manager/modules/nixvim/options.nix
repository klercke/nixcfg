let indent = 2; in { lib, ... }: {
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
  config.keymaps = [
    {
      action = ">gv";
      key = ">";
      mode = "v";
    }
    {
      action = "<gv";
      key = "<";
      mode = "v";
    }
    {
      mode = "n";
      key = "<leader>d";
      action = lib.nixvim.mkRaw "vim.diagnostic.open_float";
      options = { noremap = true; silent = true; desc = "Show diagnostics"; };
    }
    {
      mode = "n";
      key = "<leader>?";
      action = lib.nixvim.mkRaw ''
        function()
          require("which-key").show({ global = false })
        end
      '';
      options = { desc = "Show keybinds"; };
    }
  ];
}
