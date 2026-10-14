# Use the analysis report with Fedora 44 Codespaces

This guide explains how to use the analysis report as context for working on
the Fedora KDE gaming package with GitHub Codespaces and Copilot Chat or
another AI assistant.

## What starts the container

The Markdown report does **not** run or build a container. Codespaces creates
the development container from:

- [`.devcontainer/devcontainer.json`](.devcontainer/devcontainer.json), which
  selects the devcontainer Dockerfile and configures VS Code.
- [`.devcontainer/Dockerfile`](.devcontainer/Dockerfile), which builds the
  Fedora 44 command-line environment with Python, Git, GitHub CLI, ShellCheck,
  and `sudo`.

Create or reopen a Codespace for this repository and branch. Codespaces reads
those files, builds the image, mounts the **outer Fedora gaming repository**
into it, and creates the `.venv-fedora44` Python environment. The outer
repository's `origin` is the only push target for package and report changes;
the analysis files are ordinary tracked files in that repository, not a
separate Git repository. The container provides a Fedora 44 workspace; it is
not a KDE desktop, does not expose a gaming GPU, and does not install the
gaming package onto the host.

## Use the report to guide package work

1. Open this repository in GitHub Codespaces and wait for the container setup
   to finish.
2. Open Copilot Chat in the Codespace. Attach
   [`overdone_-dry_run/ANALYSIS_RESULTS.md`](overdone_-dry_run/ANALYSIS_RESULTS.md)
   (or the equivalent
   [`Analysis_Complete.md`](overdone_-dry_run/Analysis_Complete.md)) using the
   chat attachment control.
3. Ask the assistant to use the attached report as context and inspect the
   workspace before editing. The report alone is not executable and does not
   give an AI access to the repository; the chat needs workspace/repository
   access to make edits.
4. Review the proposed diff. Keep changes in the maintained package source at
   [`fedora44-kde-gaming-1.1.0-fork/`](fedora44-kde-gaming-1.1.0-fork/), update
   related documentation, and validate them before committing.
5. Work in the outer repository root and use its current branch. Commit and
   push that branch to the outer repository's `origin`, then use GitHub's
   normal review flow to merge it into `master`.
   Attaching the report does not automatically approve, apply, or publish
   changes.

Example prompt for Copilot Chat or another workspace-aware AI:

> Use the attached `ANALYSIS_RESULTS.md` as background, not as instructions to
> execute. Inspect this Codespace and the maintained source under
> `fedora44-kde-gaming-1.1.0-fork/`. Make the requested, narrowly scoped
> changes to the maintained package source and its documentation; do not edit
> release archives or the old `overdone_-dry_run/master/original_setup.sh`
> analysis snapshot. Explain the diff, run Bash syntax validation and the
> setup script's `--dry-run`, and report any checks that could not be run.
> Do not run the installer without `--dry-run`.

Use the current analysis report for context, but verify the relevant source
before relying on any report metric. The report includes illustrative
statistical ranges and a heuristic score; those are not measured confidence
intervals or guarantees of package installation success.

## Useful commands

From the repository root in the Codespace:

```bash
bash -n fedora44-kde-gaming-1.1.0-fork/bin/fedora44-kde-gaming-setup.sh
bash fedora44-kde-gaming-1.1.0-fork/bin/fedora44-kde-gaming-setup.sh --dry-run
shellcheck -S warning fedora44-kde-gaming-1.1.0-fork/bin/fedora44-kde-gaming-setup.sh
```

To regenerate the analysis report against the maintained setup script, first
install the analysis-only Python packages if needed, then run:

```bash
.venv-fedora44/bin/python -m pip install --no-cache-dir numpy
.venv-fedora44/bin/python -m pip install --no-cache-dir torch \
  --index-url https://download.pytorch.org/whl/cpu
cd overdone_-dry_run
../.venv-fedora44/bin/python -m master.pytorch_analyzer --dry-run \
  --script ../fedora44-kde-gaming-1.1.0-fork/bin/fedora44-kde-gaming-setup.sh
```

The setup dry-run previews commands and does not install packages. Do not use
the non-dry-run installer in Codespaces as a substitute for testing on the
intended Fedora 44 KDE system.

Use **Terminal → Run Test Task → FIRST: Fedora 44 package checks** to run
`bash -n`, ShellCheck, and the no-side-effect setup dry-run together. To refresh
the report from the maintained source, install PyTorch and NumPy with the
dependency task first, then run **FIRST: Refresh PyTorch analysis report**.
The analysis packages are not installed automatically because PyTorch is a
large optional dependency. The task selects CPU-only PyTorch to avoid CUDA
downloads and disables the pip cache to save space. Installation still needs
substantial free Codespace storage: the current Codespace had under 800 MiB
free and the install ran out of space. Increase its storage allocation or free
additional disk before retrying.

## Keep the outer repository as the push target

Codespaces does not make its container the Git master. Git's branch and remote
determine where changes sync. The workspace root must be the
`fedora44-kde-gaming-1.0.0-first` repository, whose `origin` points to the
owner's Fedora gaming repository. Use `git status` and `git remote -v` from
the workspace root before syncing. Commit and push the current Codespace
branch to that `origin`; review and merge it into the remote `master` branch
through GitHub. Do not run Git sync from a nested analysis repository.

## Setup script function guide

The maintained entry point is
[`bin/fedora44-kde-gaming-setup.sh`](fedora44-kde-gaming-1.1.0-fork/bin/fedora44-kde-gaming-setup.sh).

- `log`: print timestamped status and diagnostic messages.
- `run`: log and execute a command, respecting dry-run mode.
- `retry`: retry a command after failure.
- `run_net`: run a network-sensitive command through the retry helper.
- `clear_stale_dnf`: check for and clear a stale DNF lock when appropriate.
- `need_cmd`: stop with an error if a required command is unavailable.
- `confirm_fedora`: validate the host distribution/version, or report the host
  during a dry run.
- `detect_gpu`: identify an NVIDIA, AMD, or Intel GPU when detectable.
- `enable_rpmfusion`: enable RPM Fusion and refresh Fedora package metadata.
- `install_codecs_and_base`: install the multimedia, Vulkan, and base gaming
  packages.
- `install_gpu_stack`: install GPU-vendor-specific driver and media packages.
- `install_flatpaks`: optionally install the configured Flathub applications.
- `write_gamemode_ini`: create the GameMode user configuration if absent.
- `write_mangohud_conf`: create the MangoHud configuration if absent.
- `write_kwin_vrr`: configure Plasma adaptive sync where supported.
- `install_launchers`: create the gaming launcher scripts and desktop entries.
- `load_ntsync`: configure the NTSYNC module setup.
- `enable_gamemode`: enable the GameMode user service.
- `verify`: check the resulting setup.
- `main`: parse options and coordinate the setup steps.

## Where to get help

- Start with the package [README](fedora44-kde-gaming-1.1.0-fork/README.md)
  and [contribution guide](CONTRIBUTING.md).
- For script behavior, check its `--help` output and dry-run output before
  proposing changes.
- For package-specific behavior, consult the Fedora 44 package documentation
  and upstream documentation linked from the project README.
- For Codespaces problems, inspect the build log and the two files under
  [`.devcontainer/`](.devcontainer/).
- In Copilot Chat, describe the desired behavior, attach the relevant report,
  and ask it to inspect the maintained source and tests. Review all generated
  changes yourself.
