# CLAUDE.md

## Project Overview

Quarto website for data visualization projects and tutorials by Pinn (Aiqi) Xu.
**URL:** https://pinn32.github.io/dv-projects

Content is organized into two language trees (`en/`, `zh/`), each mirroring the same structure:
- **Projects** — analytical write-ups (Catalan referendum sentiment, visa costs, Spotify streams, student media usage)
- **Tutorials** — data visualization guides (data processing, amounts & distribution, multivariate plots, Sankey & network)
- **Hobbies**, **About** pages

## Tech Stack

- **Quarto** — static site generator (`_quarto.yml`)
- **Python kernel** — `dv-env` conda env (`envs/environment.yml`); Python 3.12, pandas, plotly, seaborn, matplotlib, pyvis, networkx
- **Theme** — Minty (Bootswatch)

## File Structure

```
_quarto.yml               # site config, navbar, sidebar, format defaults
_brand.yml                # branding (logo)
en/                       # English content
  _metadata.yml
  index.qmd
  404.qmd
  projects/<name>/index.qmd
  tutorials/<name>/index.qmd
  hobbies/index.qmd
  about/index.qmd
zh/                       # Chinese content (same structure as en/)
src/
  styles/
    portfolio.scss         # self-contained LIGHT theme (tokens, layout, code, listings)
    portfolio-dark.scss    # self-contained DARK theme (same section order as portfolio.css)
  scripts/
    fix-code-fold.html    # JS post-processing
    lang-switch.html      # language switcher logic
  filters/
    reading-stats.lua     # reading time
  img/
  data/                   # shared CSV datasets
  apa.csl                 # APA citation format
```

## Common Commands

```bash
quarto preview                                        # local dev server
quarto render                                         # full build
quarto render en/tutorials/amounts-and-distribution/index.qmd  # single file
conda activate dv-env                                 # needed for Python cells
```

## Conventions

- **Code folding** — on by default (`code-fold: true`); tutorials override with `code-fold: false`
- **Sidebar** — manually listed in `_quarto.yml`; add new pages there when creating content
- **Citations** — APA style (`apa.csl`); `.bib` files live alongside each project's `index.qmd`
- Chinese content (`zh/`) is standalone `.qmd`, not converted from `.ipynb`

## After Fixing Bugs
- Run tests after fixing bugs until no more errors
