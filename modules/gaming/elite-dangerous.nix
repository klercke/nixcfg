{
  flake.modules.nixos.elite-dangerous = {
    unfree.allowedPackages = [ "edhm-ui" ];
  };

  flake.modules.homeManager.elite-dangerous =
    # This file was written by an LLM and checked over by me
    #
    # Elite Dangerous on Steam/Proton:
    #   - min-ed-launcher, pinned, linked into ~/.local/bin
    #   - min-ed-launcher settings.json (starts EDMC, sets gameLocation)
    #   - EDMC wrapped with plugin Python deps
    #   - EDMC plugins, hash-pinned, copied writable into the plugin dir
    #   - EDHM-UI and EDOMH
    #   - a text file with the Steam launch options and journal path

    {
      config,
      lib,
      pkgs,
      ...
    }:

    let
      # ---- Settings ------------------------------------------------------------

      # Library containing steamapps/common/Elite Dangerous
      steamLibrary = "${config.home.homeDirectory}/.local/share/Steam";

      # "/edo" = Odyssey, "/edh4" = Horizons 4.0
      product = "/edo";

      # Terminal to show the launcher in, e.g. "ghostty -e". Must take the command
      # to run as trailing args. null = no window (output still goes to
      # ~/.local/state/min-ed-launcher/min-ed-launcher.log). A ghostty update
      # broke launching entirely, so default to null.
      terminal = null;

      # Keep these two on the same nixpkgs, or plugin deps get built for the
      # wrong Python
      edmcPkg = pkgs.edmarketconnector;
      edmcPython = pkgs.python3;

      # Names from pluginCatalog. `requires` deps are pulled in automatically.
      edmcPlugins = [
        "EDMC-Mining-Analytics"
        "EDMC-Pioneer"
        "EDMC-BioScan"
        "EDMC-SpanshTools"
        "EDMC-Screenshot-Linux"
        "LandingPad"
        "EDR"
        "EDMC-Massacres"
        # "EDMC-NeutronDancer"
        # "BGS-Tally"
        # "EDMC-PowerPlayProgress"
        # "route_scoop"
        # "cargo_manifest"
        # "docking_denied_reason"
      ];

      # EDMC-Screenshot-Linux filename format:
      #   0 = Date_System_Body
      #   1 = System(Body)_Counter
      #   2 = CMDR_Date_System_Body
      #   3 = System_Body_Date
      screenshotNameFormat = 2;

      # Unfree. EDHM-UI installs the mod into the game dir itself.
      enableEdhm = true;
      # 3.0.72 in nixpkgs bundles EDHM v22.03, which darkens the first letter of
      # status labels on 4.4.2.0+. 3.0.74 was pulled upstream; 3.0.75 replaces it.
      # Same Electron, so only version/src change. Drop when nixpkgs catches up.
      edhmPkg = pkgs.edhm-ui.overrideAttrs {
        version = "3.0.75";
        src = pkgs.fetchzip {
          url = "https://github.com/BlueMystical/EDHM_UI/releases/download/v3.0.75/edhm-ui-v3-linux-x64.zip";
          hash = "sha256-hc3rF641jdk+qPKyiy6KKMU4xHz2hwE3GS7nyajP5BY=";
        };
      };

      # Upstream portable release; nixpkgs is behind and has features disabled
      enableEdomh = true;
      edomhVersion = "3.15.10";
      edomhHash = "sha256-6lJosqY23QILiQhGGgxUipH+HgWGBR2SxcFNWXruiuQ=";

      # To bump: change version, set hash to lib.fakeHash, build, copy the real one
      minEdLauncherVersion = "0.14.0";
      minEdLauncherHash = "sha256-J/tPAxixOZNPUDbLq+DxIftyctj9h6WyuBkvtKjsjcc=";

      # ---- Plugin catalog ------------------------------------------------------
      #
      # From EDCD/EDMC-Plugin-Registry master_plugin_list.json (2026-10-16).
      # Missing hashes: nix hash file --type sha256 <zip>
      #
      # Attr name = install folder name. ExploData must keep its name or
      # Pioneer/BioScan can't import it.

      pluginCatalog = {
        EDMC-Mining-Analytics = {
          version = "1.2.0";
          url = "https://github.com/SweetJonnySauce/EDMC-Mining-Analytics/releases/download/1.2.0/EDMC-Mining-Analytics-1.2.0.zip";
          sha256 = "4cab5456770bdc3f09cd190e2778e5dfd4e979ae4cc8a54b0d16ef902be7175a";
        };

        EDMC-Pioneer = {
          version = "2.4.2";
          url = "https://github.com/Silarn/EDMC-Pioneer/releases/download/v2.4.2/EDMC-Pioneer-2.4.2.zip";
          sha256 = "f6719ccb780247fc5a721eb56b251b81be93df4659d0215c81895574f24cff32";
          requires = [ "ExploData" ];
        };

        EDMC-BioScan = {
          version = "2.12.2";
          url = "https://github.com/Silarn/EDMC-BioScan/releases/download/v2.12.2/EDMC-BioScan-2.12.2.zip";
          sha256 = "dfc8d8233ba9f3d4357757e6d3f4a3fd52d1169cdb25a168af0ffe2e45dfa1dd";
          requires = [ "ExploData" ];
        };

        # Flatpak bundle instead of the registry's Windows one. Its vendored
        # SQLAlchemy/greenlet are non-Nix binaries, so swap in nixpkgs' SQLAlchemy.
        ExploData = {
          version = "1.5.1";
          url = "https://github.com/Silarn/EDMC-Pioneer/releases/download/v2.4.2/ExploData-1.5.1-db-12.flatpak.zip";
          sha256 = "6b682d5781bd0c3b5907b437f124adae337a2474ae2311fed66e9655ee942fa1";
          strip = [
            "sqlalchemy"
            "greenlet"
            "typing_extensions.py"
          ];
          python = ps: [ ps.sqlalchemy ];
        };

        EDMC-SpanshTools = {
          version = "1.1.2";
          url = "https://github.com/wuuthradd/EDMC-SpanshTools/releases/download/v1.1.2/EDMC-SpanshTools-v1.1.2.zip";
          sha256 = "11dc77b5cd3b0d121b5fedf8cc52183bb0e48cf96d63e774af56793aa720b15c";
        };

        EDMC-NeutronDancer = {
          version = "2.0.0";
          url = "https://github.com/dwomble/EDMC-NeutronDancer/releases/download/v2.0.0/EDMC-NeutronDancer.zip";
          sha256 = "502261ce52c10d579e9a91af6cc3306c3c9c2caf8e9bcec6070b08fce221a086";
        };

        BGS-Tally = {
          version = "5.6.1";
          url = "https://github.com/aussig/BGS-Tally/releases/download/5.6.1/BGS-Tally.zip";
          sha256 = "2976378ab99165396f13983b1eb5789ac1bfa7a71096f4096bd0a097a17e00c4";
        };

        EDMC-Screenshot-Linux = {
          version = "0.1.4";
          url = "https://github.com/adieball/EDMC-Screenshot-Linux/releases/download/0.1.4/EDMC-Screenshot-Linux.zip";
          sha256 = "bf838ceb96486aad0f7fa3917219f08bc71479a89f00895854b290e900988744";
          # Patch the default format; --replace-fail catches upstream changes
          postInstall = ''
            substituteInPlace "$out/load.py" --replace-fail \
              "config.get_int(CFG_FORMAT) or 0" \
              "config.get_int(CFG_FORMAT) or ${toString screenshotNameFormat}"
          '';
        };

        LandingPad = {
          version = "2.6.0";
          url = "https://github.com/bgol/LandingPad/releases/download/v2.6.0/LandingPad_v2.6.0.zip";
          sha256 = "7d2051bd7f64cb62d7f50bb9d2f18e6f8f1669fca3664aca34386dd2be61861b";
        };

        EDMC-PowerPlayProgress = {
          version = "0.9.15";
          url = "https://github.com/alby666/EDMC-PowerPlayProgress/releases/download/v0.9.15/EDMC-PowerPlayProgress.zip";
          sha256 = "1f15faa47a7c8521fffd24058cc583d57cbd054a43f7971d747255f9a2552e4c";
        };

        # Not in the registry
        EDMC-Massacres = {
          version = "2.0.5";
          url = "https://github.com/CMDR-WDX/EDMC-Massacres/releases/download/v2.0.5/EDMC-Massacres-v2.0.5.zip";
          sha256 = "551057b63c8b02c60921567df23395c5c40a1eae546972e8406a4a8c2d3d3ff2";
        };

        # Registry has 3.3.0 with no download; this is 3.4.2 from GitHub.
        # Needs playsound on Linux, which uses GStreamer via PyGObject.
        # Folder must not be "edr" or it shadows EDR's internal edr package.
        EDR = {
          version = "3.4.2";
          url = "https://github.com/lekeno/edr/releases/download/v3.4.2/EDRv3.4.2.zip";
          sha256 = "97a1ad04193f3cca898b75cd4997193544983531fb1803902271f00990477fb8";
          python = ps: [
            ps.playsound
            ps.pygobject3
          ];
          wrapperArgs = with pkgs.gst_all_1; [
            "--prefix"
            "GI_TYPELIB_PATH"
            ":"
            # gstreamer's libs are in .out, not the default .bin
            (lib.makeSearchPath "lib/girepository-1.0" [
              gstreamer.out
              gst-plugins-base
            ])
            "--prefix"
            "GST_PLUGIN_SYSTEM_PATH_1_0"
            ":"
            (lib.makeSearchPath "lib/gstreamer-1.0" [
              gstreamer.out
              gst-plugins-base
              gst-plugins-good
            ])
          ];
        };

        # GitLab-hosted, zip layout unverified
        route_scoop = {
          version = "7.2.1";
          url = "https://gitlab.com/inutt/edmc-jump-fuel-plugin/-/releases/v7.2.1/downloads/route_scoop.zip";
          sha256 = "12eac1cf66ec453977722adcb5492be290a8e0695f464c627275b304fa950142";
        };

        cargo_manifest = {
          version = "2.2.3";
          url = "https://gitlab.com/inutt/edmc-cargo-manifest/-/releases/v2.2.3/downloads/cargo_manifest.zip";
          sha256 = "f06f90c7ea8859bf29b4d6e0a87011edc8e72da76969029b6005c66a5b3eb8c2";
        };

        docking_denied_reason = {
          version = "1.0.0";
          url = "https://gitlab.com/inutt/edmc-docking-denied-reason/-/releases/v1.0.0/downloads/docking_denied_reason.zip";
          sha256 = "0173ea6e64febb3061688c08e75c2b7e709bcaa74688d239d31580b447023c5d";
        };
      };

      # ---- Derived -------------------------------------------------------------

      appId = "359320";
      gameDir = "${steamLibrary}/steamapps/common/Elite Dangerous";
      journalDir = "${steamLibrary}/steamapps/compatdata/${appId}/pfx/drive_c/users/steamuser/Saved Games/Frontier Developments/Elite Dangerous";
      pluginDir = "${config.xdg.dataHome}/EDMarketConnector/plugins";
      melBin = "${config.home.homeDirectory}/.local/bin/MinEdLauncher";

      getPlugin =
        name:
        pluginCatalog.${name}
          or (throw "elite-dangerous.nix: unknown EDMC plugin '${name}'. Known plugins: ${lib.concatStringsSep ", " (lib.attrNames pluginCatalog)}");

      enabledPlugins = lib.unique (
        lib.concatMap (name: ((getPlugin name).requires or [ ]) ++ [ name ]) edmcPlugins
      );

      pluginPython = lib.concatMap (
        name: ((getPlugin name).python or (_: [ ])) edmcPython.pkgs
      ) enabledPlugins;

      # Zips either wrap everything in one folder or don't; handle both and
      # fail if there's no load.py
      mkPlugin =
        name: p:
        pkgs.stdenvNoCC.mkDerivation {
          pname = "edmc-plugin-${name}";
          inherit (p) version;
          src = pkgs.fetchurl { inherit (p) url sha256; };
          nativeBuildInputs = [ pkgs.unzip ];
          dontUnpack = true;
          dontConfigure = true;
          dontBuild = true;
          dontFixup = true;
          installPhase = ''
            runHook preInstall
            mkdir unpacked
            unzip -q "$src" -d unpacked
            shopt -s nullglob dotglob
            entries=(unpacked/*)
            if [ ''${#entries[@]} -eq 1 ] && [ -d "''${entries[0]}" ]; then
              root="''${entries[0]}"
            else
              root=unpacked
            fi
            if [ ! -f "$root/load.py" ]; then
              echo "EDMC plugin ${name}: no load.py found in release zip" >&2
              exit 1
            fi
            cp -r "$root" "$out"
            ${lib.concatMapStrings (f: ''
              rm -rf "$out/${f}"
            '') (p.strip or [ ])}
            ${p.postInstall or ""}
            runHook postInstall
          '';
        };

      plugins = lib.genAttrs enabledPlugins (name: mkPlugin name (getPlugin name));

      pluginWrapperArgs = lib.concatMap (name: (getPlugin name).wrapperArgs or [ ]) enabledPlugins;

      # Replaces the plain package so the desktop entry gets the same env
      edmc =
        if pluginPython == [ ] && pluginWrapperArgs == [ ] then
          edmcPkg
        else
          pkgs.symlinkJoin {
            name = "edmarketconnector-with-plugin-deps";
            paths = [ edmcPkg ];
            nativeBuildInputs = [ pkgs.makeWrapper ];
            postBuild = ''
              wrapProgram "$out/bin/${edmcPkg.meta.mainProgram}" \
                --prefix PYTHONPATH : "${edmcPython.pkgs.makePythonPath pluginPython}" \
                ${lib.escapeShellArgs pluginWrapperArgs}
            '';
            inherit (edmcPkg) meta;
          };

      # Started from the launcher, EDMC inherits Steam's environment: its
      # LD_LIBRARY_PATH breaks EDMC's Tk UI, and its LD_PRELOAD injects the Steam
      # overlay into EDMC. Without a terminal there's nowhere for errors to go, so
      # log them.
      edmcLog = "${config.xdg.stateHome}/edmc-launch.log";
      edmc-launch = pkgs.writeShellScriptBin "edmc-launch" ''
        unset LD_LIBRARY_PATH LD_PRELOAD
        if [ -t 2 ]; then
          exec ${lib.getExe edmc} "$@"
        fi
        mkdir -p "$(dirname "${edmcLog}")"
        echo "=== $(date -Is) edmc-launch" >> "${edmcLog}"
        exec ${lib.getExe edmc} "$@" >> "${edmcLog}" 2>&1
      '';

      # jpackage bundle with its own JRE; JavaFX dlopens GTK/GL, so run it in an
      # FHS env (AppImage lib set + ffmpeg) instead of patching
      edomhSrc = pkgs.fetchzip {
        url = "https://github.com/jixxed/ed-odyssey-materials-helper/releases/download/${edomhVersion}/edomh-${edomhVersion}.portable.linux.zip";
        hash = edomhHash;
        stripRoot = false;
      };

      edomh = pkgs.buildFHSEnv {
        name = "ed-odyssey-materials-helper";
        inherit (pkgs.appimageTools.defaultFhsEnvArgs) multiPkgs;
        targetPkgs = p: (pkgs.appimageTools.defaultFhsEnvArgs.targetPkgs p) ++ [ p.ffmpeg ];
        # Binary name has spaces
        runScript = pkgs.writeShellScript "edomh-run" ''
          exec "${edomhSrc}/bin/Elite Dangerous Odyssey Materials Helper" "$@"
        '';
      };

      # .NET single-file binary; strip/patchelf break it. Only runs under
      # Steam's FHS env (or steam-run).
      min-ed-launcher = pkgs.stdenvNoCC.mkDerivation {
        pname = "min-ed-launcher";
        version = minEdLauncherVersion;
        src = pkgs.fetchurl {
          url = "https://github.com/rfvgyhn/min-ed-launcher/releases/download/v${minEdLauncherVersion}/min-ed-launcher_v${minEdLauncherVersion}_linux-x64.tar.gz";
          hash = minEdLauncherHash;
        };
        dontConfigure = true;
        dontBuild = true;
        dontFixup = true;
        installPhase = ''
          runHook preInstall
          install -Dm755 MinEdLauncher "$out/bin/MinEdLauncher"
          runHook postInstall
        '';
      };

      # Full upstream default settings.json (v0.14.0); the launcher doesn't fill
      # in missing keys. filterOverrides is what makes /edo and /edh4 work.
      melSettings = {
        apiUri = "https://api.zaonce.net";
        watchForCrashes = false;
        gameLocation = gameDir;
        language = null;
        autoUpdate = true;
        checkForLauncherUpdates = false; # pinned by Nix
        maxConcurrentDownloads = 4;
        forceUpdate = [ ];
        processes = [
          {
            fileName = "${edmc-launch}/bin/edmc-launch";
            alias = "EDMC";
          }
        ];
        shutdownProcesses = [ ];
        filterOverrides = [
          {
            sku = "FORC-FDEV-DO-1000";
            filter = "edo";
          }
          {
            sku = "FORC-FDEV-DO-38-IN-40";
            filter = "edh4";
          }
        ];
        additionalProducts = [ ];
      };

      melSettingsFile = pkgs.writeText "min-ed-launcher-settings.json" (builtins.toJSON melSettings);

      launcherArgs = "${melBin} %command% ${product} /autorun /autoquit waitForExit";
      # With a terminal: clear LD_LIBRARY_PATH for it, restore it for Proton
      launchOptions =
        if terminal == null then
          launcherArgs
        else
          ''LD_LIBRARY_PATH="" ${terminal} env LD_LIBRARY_PATH="$LD_LIBRARY_PATH" ${launcherArgs}'';

      pluginInstall =
        name: src:
        let
          marker = pkgs.writeText "edmc-plugin-${name}-src" "${src}";
        in
        ''
          if [ "$(cat "${pluginDir}/${name}/.hm-src" 2>/dev/null)" != "${src}" ]; then
            run rm -rf "${pluginDir}/${name}"
            run cp -rT --no-preserve=mode "${src}" "${pluginDir}/${name}"
            run install -m644 "${marker}" "${pluginDir}/${name}/.hm-src"
          fi
        '';
    in
    {
      # edomh: scheme handles the Frontier login callback and wishlist links
      xdg.desktopEntries = lib.mkIf enableEdomh {
        ed-odyssey-materials-helper = {
          name = "ED Odyssey Materials Helper";
          comment = "Engineering and materials tracker for Elite Dangerous";
          exec = "ed-odyssey-materials-helper %u";
          icon = "${edomhSrc}/lib/Elite Dangerous Odyssey Materials Helper.png";
          categories = [ "Game" ];
          mimeType = [ "x-scheme-handler/edomh" ];
        };
      };

      home = {
        packages = [
          edmc
          edmc-launch
        ]
        ++ lib.optional enableEdhm edhmPkg
        ++ lib.optional enableEdomh edomh;

        file = {
          ".local/bin/MinEdLauncher".source = "${min-ed-launcher}/bin/MinEdLauncher";

          ".local/share/min-ed-launcher/steam-launch-options.txt".text = ''
            Steam launch options (Elite Dangerous > Properties > General > Launch Options):

            ${launchOptions}

            EDMC journal folder (EDMC > File > Settings > Configuration):

            ${journalDir}
          ''
          + lib.optionalString enableEdhm ''

            EDHM-UI game folder (EDHM-UI > Settings > game instance path):

            ${gameDir}/Products/elite-dangerous-odyssey-64
          '';
        };

        activation = {
          # Copied so the launcher can write to it; overwritten on switch
          minEdLauncherSettings = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
            run install -Dm644 ${melSettingsFile} "${config.xdg.configHome}/min-ed-launcher/settings.json"
          '';

          # Copied writable since some plugins keep state in their folder.
          # Re-copied only on version change. Removed plugins are left behind.
          edmcPlugins = lib.hm.dag.entryAfter [ "writeBoundary" ] (
            ''
              run mkdir -p "${pluginDir}"
              # Clean up the old "edr" folder, only if we created it
              if [ -f "${pluginDir}/edr/.hm-src" ]; then
                run rm -rf "${pluginDir}/edr"
              fi
            ''
            + lib.concatStrings (lib.mapAttrsToList pluginInstall plugins)
          );
        };
      };
    };
}
