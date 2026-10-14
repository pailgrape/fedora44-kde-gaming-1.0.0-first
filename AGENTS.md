# Repository guidance

## Project context

- This repository contains Fedora developer-portal content and Fedora 44 KDE gaming setup artifacts; it is not currently an API service or a web UI project. Confirm that the target code exists before implementing a feature.
- Treat Fedora 44 KDE Plasma on Wayland as the gaming environment. The Fedora system is already built; do not rebuild or reprovision it unless explicitly asked.
- The existing gaming setup reference is [`overdone_-dry_run/master/original_setup.sh`](overdone_-dry_run/master/original_setup.sh). Its launcher runs Steam inside nested Gamescope and enables MangoHud, alongside GameMode.

## Gaming UI and runtime

- For game-session UI work, use **MangoHud** as the performance overlay and **Gamescope** as the game compositor/session layer. Do not interpret “Gamescore” as a separate product; verify if the intended tool is unclear.
- Preserve the existing Plasma desktop/session and Steam/GameMode behavior. Integrate with the current nested Wayland launcher rather than replacing the desktop session or assuming an embedded Gamescope session.
- Respect existing user configuration. Do not overwrite MangoHud, GameMode, or KDE settings when extending setup behavior.
- Prefer Fedora-packaged components and the repository's existing installation/configuration patterns. Verify Fedora 44 compatibility before using upstream options or commands; do not copy instructions for other distributions without adapting them.
- Use upstream documentation for current capabilities and configuration:
  - [Gamescope](https://github.com/ValveSoftware/gamescope)
  - [MangoHud](https://github.com/flightlessmango/MangoHud)
- Do not add a web UI, dependencies, or a new service unless the requested feature specifically requires them.

## Changes and validation

- Inspect the actual source and existing tests before making changes. Archives and analysis snapshots are not automatically the canonical source to edit.
- Keep changes focused, preserve existing behavior, and update directly related documentation.
- Run the smallest relevant validation. For setup-script changes, at minimum run `bash -n` on the changed script and use its documented dry-run mode when applicable. Do not claim Fedora runtime verification unless it was actually performed on Fedora 44.
- Treat `bash overdone_-dry_run/master/original_setup.sh --dry-run` as the final whole-project integration check: run it once the requested project work is complete, after targeted tests, from the repository root on the built Fedora 44 system with its required commands available. It is not a per-change test and must not be reported as passed if it was not run successfully on Fedora 44. The script writes its log to `$HOME/fedora44-kde-gaming-setup.log`; dry-run mode skips package installation and setup configuration changes.
