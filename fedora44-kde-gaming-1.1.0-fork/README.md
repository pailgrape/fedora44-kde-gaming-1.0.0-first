# FIRST-FORK 1.1.0

Fork of fedora44-kde-gaming-1.0.0-first. Same Fedora 44 KDE Plasma target.
Adds the after-reboot session script, NTSYNC load, GameMode user service,
Plasma adaptive sync through kwriteconfig6, and a Desktop Steam shortcut.

Run from this directory:

```bash
chmod +x install.sh bin/*.sh
./bin/fedora44-kde-gaming-setup.sh --dry-run
./bin/fedora44-kde-gaming-setup.sh
```

On Ubuntu, open the repository in VS Code and choose **Terminal → Run Test Task → FIRST: Fedora gaming setup dry run**. It previews Fedora 44 package actions without requiring `dnf` or changing the Ubuntu system. The preview log is written to `~/fedora44-kde-gaming-setup-dry-run.log`; it does not verify Fedora package state.

The Ubuntu preview is not the final integration test. After the project is complete, run the setup dry run on the built Fedora 44 system.

The checked-in ZIP and tar archives remain the original 1.1.0 release snapshots. The VS Code task runs the maintained source in this directory; do not regenerate or distribute updated archives until the release license is corrected and authorized.

After reboot:

```bash
./bin/plasma-game-session.sh
```

Desktop icon is copied by `./install.sh` to ~/Desktop/Steam-Gaming.desktop.

## Package sets

The installer uses Fedora DNF for the system gaming stack:

- Multimedia groups and Vulkan/VA-API support: `@"Multimedia"`, `@"Sound and Video"`,
  `vulkan-tools`, `vulkan-loader`, `vulkan-validation-layers`,
  `mesa-vulkan-drivers`, `mesa-vulkan-drivers.i686`, and `libva-utils`.
- Gaming tools: `gamemode`, `mangohud`, `goverlay`, `gamescope`, `wine`,
  `wine-ntsync`, `winetricks`, `lutris`, `steam`, `kdialog`, and `qt6-qtbase`.
- NVIDIA packages are selected by detection: `akmod-nvidia` (or
  `akmod-nvidia-open`), `xorg-x11-drv-nvidia-cuda`, `nvidia-vaapi-driver`, and
  `xorg-x11-drv-nvidia-libs.i686` and `nvidia-vaapi-driver.i686` for 32-bit apps.
- AMD uses Mesa with optional `mesa-va-drivers-freeworld` and
  `mesa-vdpau-drivers-freeworld` swaps; Intel adds `intel-media-driver` and
  `libva-intel-driver`.
- Optional Flathub IDs: `com.heroicgameslauncher.hgl`,
  `net.davidotek.pupgui2`, and `com.discordapp.Discord`.

These are Fedora runtime packages, not Python dependencies. The analysis tool's
Python dependencies (`torch` and `numpy`) are listed separately in
[`overdone_-dry_run/requirements.txt`](../overdone_-dry_run/requirements.txt).
To run the analysis in Codespaces, install them into `.venv-fedora44` with:

```bash
.venv-fedora44/bin/python -m pip install -r overdone_-dry_run/requirements.txt
```

## Setup function inventory

The maintained setup script is [`bin/fedora44-kde-gaming-setup.sh`](bin/fedora44-kde-gaming-setup.sh).
Its functions are:

- `log`, `run`, `retry`, `run_net`: timestamped logging, command execution,
  retries, and network-operation handling.
- `clear_stale_dnf`, `need_cmd`, `confirm_fedora`, `detect_gpu`: package-manager
  preparation and host/GPU checks.
- `enable_rpmfusion`, `install_codecs_and_base`, `install_gpu_stack`,
  `install_flatpaks`: repositories and system/optional package installation.
- `write_gamemode_ini`, `write_mangohud_conf`, `write_kwin_vrr`,
  `install_launchers`: user configuration and launcher setup.
- `load_ntsync`, `enable_gamemode`, `verify`: runtime setup and verification.
- `main`: parses options and runs the setup steps in order.

See the [analysis report](../overdone_-dry_run/Analysis_Complete.md) for
measured line, comment, function, and package-command counts. The Codespaces
container is a Fedora 44 command-line/test environment; it does not provide a
KDE desktop, gaming GPU, or permission to install the host gaming stack.
