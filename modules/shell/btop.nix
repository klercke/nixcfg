{
  flake.modules.homeManager.btop = {
    programs.btop = {
      enable = true;
      settings = {
        color_theme = "gruvbox_dark_v2";
        theme_background = true;
        truecolor = true;
        vim_keys = true;
        rounded_corners = true;
        proc_sorting = "cpu lazy";
        proc_tree = false;
        proc_aggregate = true;
        show_gpu_info = true;
        show_swap = true;
        swap_disk = false;
        show_disks = true;
        only_physical = false;
        disks_filter = "exclude=/.swapvol";
        zfs_hide_datasets = true;
        show_battery = true;
      };
    };
  };
}
