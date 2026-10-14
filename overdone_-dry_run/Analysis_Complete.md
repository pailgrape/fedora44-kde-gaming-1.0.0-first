=== overdone_-dry_run Statistical Analysis ===
Source file: fedora44-kde-gaming-setup.sh
Script lines: 474 (non-empty 439)
Comments: 32
Functions defined: 20 → ['log', 'run', 'retry', 'run_net', 'clear_stale_dnf', 'need_cmd', 'confirm_fedora', 'detect_gpu', 'enable_rpmfusion', 'install_codecs_and_base', 'install_gpu_stack', 'install_flatpaks', 'write_gamemode_ini', 'write_mangohud_conf', 'write_kwin_vrr', 'install_launchers', 'load_ntsync', 'enable_gamemode', 'verify', 'main']
run() calls: 1, run_net() (retry): 1
dnf install mentions: 13

PyTorch tensor stats on counts:
  mean=140.00  std=200.64  median=20.00
  95% illustrative perturbation range low:  [435.8, 400.2, -7.7, -16.9, -37.1, -37.9, -30.2]
  95% illustrative perturbation range high: [512.7, 478.3, 71.7, 56.2, 40.2, 41.6, 55.6]
  (synthetic range, not an empirical confidence interval)

Heuristic dry-run success score: 87.0%
(illustrative formula only; not an empirical probability)

Top token frequencies (rough package/command proxy):
  then: 42
  sudo: 22
  null: 21
  run_net: 20
  true: 18
  install: 17
  local: 15
  return: 15
  ntsync: 13
  echo: 11

Dry-run mode: no packages would be installed; only logged actions.
Setup script supports --dry-run, --no-flatpak, --nvidia-open.

=== table1.csv actions (NVIDIA / ROCm) ===
  - akmods --force + reboot | NVIDIA driver | No (already working)
  - usermod -a -G render,video | AMD ROCm access | Yes, if you want to use ROCm
  - dnf install rocm | Full ROCm stack | Optional

=== ROCm notes for AMD Radeon VII ===
HIP_VISIBLE_DEVICES=0 rocminfo   # if the app is using system ROCm
sudo usermod -a -G render,video $USER
sudo dnf install rocm

=== NVIDIA note ===
After the RPM Fusion akmod-nvidia-580xx packages were installed, the proprietary driver took over.

[dry-run] Analysis complete. No side effects.
