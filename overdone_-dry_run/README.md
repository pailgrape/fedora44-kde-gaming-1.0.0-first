overdone_-dry_run
Statistical analysis of fedora44-kde-gaming-1.1.0-fork using PyTorch

This project performs statistical analysis on the Fedora 44 KDE Plasma
gaming setup script (FIRST-FORK 1.1.0). It extracts metrics from the
shell script and applies tensor-based statistical methods via PyTorch.
The analysis can use the archived copy or the maintained project script.

## Project structure
- master/pytorch_analyzer.py : Main analysis script using torch
- master/original_setup.sh : Copy of the setup script under analysis
- ANALYSIS_RESULTS.md and Analysis_Complete.md : Generated analysis reports
- requirements.txt : Python analysis dependencies (torch, numpy)

## Usage
```bash
cd overdone_-dry_run
python -m master.pytorch_analyzer --dry-run \
  --script ../fedora44-kde-gaming-1.1.0-fork/bin/fedora44-kde-gaming-setup.sh
```

Create a virtual environment and install the analysis dependencies with:

```bash
python3 -m venv .venv
.venv/bin/python -m pip install -r requirements.txt
```

In the Fedora Codespace, use the **FIRST: Install PyTorch analysis
dependencies** task to install NumPy and the CPU-only PyTorch wheel into
`.venv-fedora44`. PyTorch is optional and may require more free disk space than
a small Codespace allocation provides.

Results are written to [ANALYSIS_RESULTS.md](ANALYSIS_RESULTS.md) and
[Analysis_Complete.md](Analysis_Complete.md). Without `--script`, analysis uses
the archived copy at `master/original_setup.sh`.

## What it analyzes
- Line counts, function definitions, command frequencies
- Package installation patterns
- Dry-run action counts and synthetic perturbation ranges
- GPU vendor detection and retry-success heuristics (illustrative, not measured)

## Notes
The original package is a commercial fork with restrictive license.
This analysis is for educational/statistical purposes only.
Checksum verified: matches provided SHA256SUMS.

Copyright and licensing research search queries are collected in
[`copyright_disclaimer_searches.csv`](../copyright_disclaimer_searches.csv).
The links are search queries, not legal advice.
