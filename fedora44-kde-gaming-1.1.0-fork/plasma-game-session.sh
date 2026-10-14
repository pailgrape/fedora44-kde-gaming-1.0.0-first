#!/usr/bin/env bash
# plasma-game-session.sh
# Run this after the Fedora 44 KDE setup and the reboot.
#
#   ./bin/plasma-game-session.sh
#   ./bin/plasma-game-session.sh after-reboot
#   ./bin/plasma-game-session.sh status
#   ./bin/plasma-game-session.sh launch -- steam

set -euo pipefail

status() {
  echo "session:  ${XDG_SESSION_TYPE:-unknown}  desktop=${XDG_CURRENT_DESKTOP:-unknown}"
  echo "kernel:   $(uname -r)"
  if [[ -e /dev/ntsync ]]; then
    echo "ntsync:   /dev/ntsync present"
  else
    echo "ntsync:   /dev/ntsync missing"
  fi
  if command -v gamemoded >/dev/null 2>&1; then
    echo "gamemode: $(systemctl --user is-active gamemoded.service 2>/dev/null || echo inactive)"
  else
    echo "gamemode: not installed"
  fi
  if command -v gamescope >/dev/null 2>&1; then
    echo "gamescope: $(command -v gamescope)"
  else
    echo "gamescope: missing"
  fi
  if rpm -q steam >/dev/null 2>&1; then
    echo "steam:    $(rpm -q steam)"
  else
    echo "steam:    not installed"
  fi
}

after_reboot() {
  if [[ "${XDG_SESSION_TYPE:-}" != "wayland" || "${XDG_CURRENT_DESKTOP:-}" != *KDE* ]]; then
    echo "Warning: not a Plasma Wayland session (${XDG_SESSION_TYPE:-unknown} / ${XDG_CURRENT_DESKTOP:-unknown})." >&2
  fi
  if [[ ! -e /dev/ntsync ]]; then
    sudo modprobe ntsync
    echo ntsync | sudo tee /etc/modules-load.d/ntsync.conf >/dev/null
  fi
  if command -v gamemoded >/dev/null 2>&1; then
    systemctl --user enable --now gamemoded.service || true
  fi
  if command -v kwriteconfig6 >/dev/null 2>&1; then
    kwriteconfig6 --file "${HOME}/.config/kwinrc" --group Wayland --key AdaptiveSync Automatic
  fi
  status
  echo "next: open Steam, launch options: gamemoderun mangohud %command%"
}

launch() {
  if [[ "${XDG_SESSION_TYPE:-}" != "wayland" ]]; then
    echo "Refusing to launch: not a Wayland session." >&2
    exit 1
  fi
  if [[ $# -eq 0 ]]; then
    echo "Usage: $0 launch -- <command> [args...]" >&2
    exit 2
  fi
  export MANGOHUD="${MANGOHUD:-1}"
  exec gamemoderun "$@"
}

case "${1:-after-reboot}" in
  after-reboot) after_reboot ;;
  status) status ;;
  launch)
    shift
    if [[ "${1:-}" == "--" ]]; then shift; fi
    launch "$@"
    ;;
  *)
    echo "Usage: $0 {after-reboot|status|launch -- cmd}" >&2
    exit 2
    ;;
esac
