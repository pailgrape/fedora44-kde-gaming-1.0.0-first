#!/usr/bin/env bash
set -euo pipefail
ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DEST="${HOME}/.local"
mkdir -p "${DEST}/bin" "${DEST}/share/applications" "${DEST}/share/first"
install -m 0755 "${ROOT}/bin/fedora44-kde-gaming-setup.sh" "${DEST}/bin/fedora44-kde-gaming-setup.sh"
install -m 0755 "${ROOT}/bin/plasma-game-session.sh" "${DEST}/bin/plasma-game-session.sh"
install -m 0755 "${ROOT}/bin/plasma-link.sh" "${DEST}/bin/plasma-link.sh"
install -m 0644 "${ROOT}/share/applications/Steam-Gaming.desktop" "${HOME}/Desktop/Steam-Gaming.desktop"
chmod +x "${HOME}/Desktop/Steam-Gaming.desktop"
install -m 0644 "${ROOT}/LABEL" "${DEST}/share/first/LABEL"
echo "FIRST-FORK 1.1.0 installed"
echo "Desktop shortcut: ${HOME}/Desktop/Steam-Gaming.desktop"
