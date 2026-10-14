# Repository guidance

## Project context

- This repository contains Fedora developer-portal content and Fedora 44 KDE gaming setup artifacts; it is not currently an issues API service or a web UI project. Confirm that the target code exists before implementing a feature.
- The maintained gaming package source is under [`fedora44-kde-gaming-1.1.0-fork/`](fedora44-kde-gaming-1.1.0-fork/). The checked-in ZIP and tar files are release snapshots; do not regenerate or distribute updated archives until the release license is corrected and authorized.
- The outer repository at the workspace root is the canonical Git remote for the gaming package. `overdone_-dry_run/` is analysis source/report content tracked by this repository, not a separate push target. Make package edits in the maintained source, commit from the root repo, and push the current root branch to `origin`; do not push analysis files to a second remote.
- The Codespace is an authoring and command-line validation environment, not a master branch or a gaming desktop. Use its Fedora 44 package-check task for syntax, ShellCheck, and dry-run validation. Merge reviewed changes into the remote `master` branch through the repository's normal review process.
- The optional report refresh task needs PyTorch and NumPy in `.venv-fedora44`; use the CPU-only PyTorch dependency task to avoid CUDA downloads. Do not install analysis dependencies automatically in the image because they are large and may exceed Codespace storage.
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
- Treat the VS Code task **FIRST: Fedora gaming setup dry run** as an Ubuntu-safe preview of Fedora 44 package actions; it does not install packages or verify installed Fedora state.
- Treat `bash fedora44-kde-gaming-1.1.0-fork/bin/fedora44-kde-gaming-setup.sh --dry-run` as the final whole-project integration check: run it once the requested project work is complete, after targeted tests, on the built Fedora 44 system. It is not a per-change test and must not be reported as passed if it was not run successfully on Fedora 44. Dry-run logs go to `$HOME/fedora44-kde-gaming-setup-dry-run.log`; normal setup logs remain in `$HOME/fedora44-kde-gaming-setup.log`.
