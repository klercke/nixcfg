{
  programs.btop = {
    enable = true;
    settings = {
      color_theme = "gruvbox_dark_v2";
      theme_background = true;
      truecolor = true;
      vim_keys = true;
      rounded_corners = true;
      proc_sorting = "memory";
      proc_tree = true;
      proc_aggregate = true;
      show_gpu_info = true;
      show_swap = true;
      swap_disk = false;
      show_disks = true;
      only_physical = false;
      zfs_hide_datasets = true;
      show_battery = true;
    };
  };
}
