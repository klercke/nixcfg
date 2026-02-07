{ lib, ... }: {
  config.plugins = {
    conform-nvim = {
      enable = true;
        settings = {formatters_by_ft.rust = ["rustfmt"];};
    };
    rustaceanvim = {
      enable = true;
      settings = {
        tools.enable_clippy = true;
        server = {
          default_settings = {
            inlayHints = {lifetimeElisionHints = {enable = "always";};};
            rust-analyzer = {
              cargo = {allFeatures = true;};
              check = {command = "clippy";};
              files = {excludeDirs = ["target" ".git" ".cargo" ".github" ".direnv"];};
            };
          };
        };
      };
    };   
  };
  config.keymaps = [
    {
      mode = "n";
      key = "K";
      action = lib.nixvim.mkRaw ''
        function()
          vim.cmd.RustLsp({'hover', 'actions'})
        end
      '';
      options = { silent = true; desc = "Hover action"; };
    }
    {
      mode = "n";
      key = "<leader>a";
      action = lib.nixvim.mkRaw ''
        function()
          vim.cmd.RustLsp('codeAction')
        end
      '';
      options = { silent = true; desc = "Code action"; };
    }
  ];
}
