{
  programs.zellij = {
    enable = true;
    enableBashIntegration = false;
    enableFishIntegration = false;
    enableZshIntegration = false;

    layouts = {
      rust = {
        layout = {
          _children = [
            {pane = {
              split_direction = "vertical";
              _children = [
                {pane = {
                  edit = "src";
                  size = "66%";
                };}
                {pane = {
                  split_direction = "horizontal";
                  _children = [{
                    bacon = {
                      args = [ "clippy" ];
                    };}
                    {cargo = {
                      args = [ "run" ];
                    };}
                    {cargo = {
                      args = [ "test" ];
                    };}
                  ];
                };}
              ];
            };}
            {pane = {
              size = 1;
              borderless = true;
              plugin = {
                location = "zellij:status-bar";
              };
            };}
            {pane_template = {
              name = "cargo";
              command = "cargo";
              start_suspended = true;
            };}
            {pane_template = {
              name = "bacon";
              command = "bacon";
              start_suspended = true;
            };}
          ];
        };
      };
    };
  };
}
