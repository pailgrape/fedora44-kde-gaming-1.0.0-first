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
