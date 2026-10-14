#!/usr/bin/env bash
# Link the package scripts to the names the short commands expect,
# and register the Plasma launcher without a full dnf run.
set -euo pipefail
root="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
if [[ -d "${root}/bin" ]]; then
  ln -sfn bin/fedora44-kde-gaming-setup.sh "${root}/fedora44-kde-gaming-setup.sh"
  ln -sfn bin/plasma-game-session.sh "${root}/plasma-game-session.sh"
  chmod +x "${root}/bin/fedora44-kde-gaming-setup.sh" "${root}/bin/plasma-game-session.sh" "${root}/install.sh" 2>/dev/null || true
fi
mkdir -p "${HOME}/.local/bin" "${HOME}/.local/share/applications"
if [[ -f "${root}/bin/plasma-game-session.sh" ]]; then
  install -m 0755 "${root}/bin/plasma-game-session.sh" "${HOME}/.local/bin/plasma-game-session.sh"
elif [[ -f "${root}/plasma-game-session.sh" ]]; then
  install -m 0755 "${root}/plasma-game-session.sh" "${HOME}/.local/bin/plasma-game-session.sh"
fi
if command -v kwriteconfig6 >/dev/null 2>&1; then
  kwriteconfig6 --file "${HOME}/.config/kwinrc" --group Wayland --key AdaptiveSync Automatic
fi
cat >"${HOME}/.local/share/applications/plasma-gamescope-steam.desktop" <<EOF
[Desktop Entry]
Type=Application
Name=Steam Gaming Mode
Exec=${HOME}/.local/bin/plasma-gamescope-steam
Icon=steam
Terminal=false
Categories=Game;
OnlyShowIn=KDE
EOF
echo "Plasma links ready in ${root}"
echo "Konsole profiles not modified: ${HOME}/.local/share/konsole"
ls -l "${root}/fedora44-kde-gaming-setup.sh" "${HOME}/.local/bin/plasma-game-session.sh"
