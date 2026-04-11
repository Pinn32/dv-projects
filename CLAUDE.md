# CLAUDE.md

## Project Overview

A Quarto website (`_quarto.yml`) for data visualization projects and tutorials by Pinn (Aiqi) Xu. The site contains:
- **Projects** — analytical write-ups (e.g., Catalan referendum sentiment, visa costs, Spotify streams)
- **Tutorials** — data visualization guides using Python (Matplotlib, Seaborn, Plotly, Pyvis, NetworkX)

Tutorials have a Chinese (`zh/`) variant (`index.qmd`) alongside the English source notebook (`.ipynb`).

## Tech Stack

- **Quarto** — static site generator; content lives in `.qmd` and `.ipynb` files
- **Python kernel** — `dv-env` (conda env defined in `envs/environment.yml`)
  - Python 3.12, pandas, plotly, seaborn, matplotlib, pyvis, networkx
- **Theme** — Minty (Bootswatch), custom CSS at `src/styles/styles.css`

## File Structure

```
_quarto.yml               # site config, navbar, sidebar, format defaults
_brand.yml                # site branding (logo)
404.qmd                   # 404 page
projects/
  _metadata.yml           # shared metadata for all projects (jupyter: dv-env, sidebar: true)
  <project-name>/
    index.qmd
    index.zh.qmd
tutorials/
  _metadata.yml           # shared metadata for all tutorials
  <tutorial-name>/
    index.qmd             # English version
    index.zh.qmd          # Chinese version
hobbies/                  
  index.qmd               # hobbies page
src/
  styles/
    styles.css            # customized styles for general elements
    portfolio.css         # customized professional portfolio styles & root elements
    projects.css          # project/tutorial landing page styles
  scripts/
    <script-name>.html    # JS post-processing (fix-code-fold.html, etc.)
  img/
  apa.csl                 # APA citation format
```

## Common Commands

```bash
# Preview site locally
quarto preview

# Render full site
quarto render

# Render a single file
quarto render tutorials/amounts-and-distribution/zh/index.qmd

# Activate conda env (needed to run Python cells)
conda activate dv-env
```

## Conventions

- **Code folding** is on by default (`code-fold: true` in `_quarto.yml`); tutorials override with `code-fold: false`
- **Citations** use APA style (`apa.csl`); `.bib` files live alongside each project's `index.qmd`
- **Sidebar** is docked and manually listed in `_quarto.yml` — add new pages there when creating content
- Chinese tutorials (`zh/index.qmd`) are standalone `.qmd` files, not converted from the `.ipynb` directly
- `raw-index.qmd` files are drafts/scratch — not part of the published site

## After Fixing Bugs
- run test after fixing bugs, until no more errors