---
title: 'Quarto Image Centering Styles'
author: 'Pinn Xu'
date: 2026-06-15
description: 'Exploring image centering styles in a Quarto Website and fixing hover preview issues.'
# categories: [Quarto, CSS, Web Dev, Computer Tips, Knowhow]
categories: [Quarto, CSS, Web Dev, Knowhow]
image: "https://raw.githubusercontent.com/Pinn32/img/main/img/pic-go/20260615190606193.png"
---

<style>
	figcaption {
		text-align: center;
	}
</style>

# Summary

To achieve all of the following in a Quarto Website:

- Control image width with `rem`
- Cross-reference hover preview displays correctly
- Image centering
- Image caption centering

Use the approach below.


## Step 1: External CSS

```css
.quarto-float.quarto-figure.quarto-figure-center.anchored {
    width: 100% !important;
}
```

Register it in `_quarto.yml`:

```yaml
format:
  html:
	css:
	  - path/to/style.css
```

## Step 2: Page-level Internal CSS

Add a `<style>` tag at the top of the page (below the YAML block):

```markdown
<style>
	figcaption {
		text-align: center;
	}
</style>
```

## Step 3: Image Inline Styles

```markdown
![Caption a](URL){#fig-a style="width:20rem;"}
![Caption b](URL){#fig-b style="width:15rem;"}
```

> This post is implemented using the approach above. Click `</> Code` in the top-right corner of the page to view the full source.

---

Here is the full walkthrough:

# Controlling Image Size

## The Traditional Approach

When writing my Quarto Website, I initially controlled image size using Quarto's built-in `width` attribute:

```markdown
![Caption](image URL){#fig-title width="15%"}
```

This approach is clean and intuitive — no need to write inline styles like `style="width:15%"` — and the results looked good.

:::{.macbook-frame style="width:35rem;"}
![Preview of image width controlled by percentage](https://raw.githubusercontent.com/Pinn32/img/main/img/pic-go/1.png){#fig-width-pct-preview}
:::

## Issue 1: Hover Preview Breaks

After using cross-references (e.g. `@fig-title`) in the body text, I noticed the hover preview inherited the `width` percentage, causing it to display incorrectly.

:::{.macbook-frame style="width:30rem;"}
![Issue 1 — Hover preview broken](https://raw.githubusercontent.com/Pinn32/img/main/img/pic-go/20260615184737385.png){#fig-hover-error}
:::

To fix this, I tried switching to `rem` as the width unit, which behaves consistently regardless of page scaling and hover context.

I first tried:

```markdown
![Caption](image URL){#fig-title width="7rem"}
```

This had no effect — Quarto's `width` attribute does not support `rem` (it accepts `px`, percentages, etc.).

I then switched to:

```markdown
![Caption](image URL){#fig-title style="width:7rem;"}
```

## Issue 2: Image No Longer Centers

A new problem appeared: the image was no longer centered, and setting `{fig-align="center"}` had no effect.

:::{.macbook-frame style="width:35rem;"}
![Issue 2: Image no longer centered](https://raw.githubusercontent.com/Pinn32/img/main/img/pic-go/20260615190316080.png){#fig-center-error}
:::


Inspecting with browser DevTools revealed that when `style="width:7rem"` is set, Quarto also constrains the parent container's width to `7rem`.

:::{.macbook-frame style="width:35rem;"}
![Parent container width constraint](https://raw.githubusercontent.com/Pinn32/img/main/img/pic-go/20260615190502775.png){#fig-parent-width-limit}
:::

Removing the parent container's width constraint restored image centering.

:::{.macbook-frame style="width:35rem;"}
![After removing the parent container width constraint: centering restored](https://raw.githubusercontent.com/Pinn32/img/main/img/pic-go/20260615190606193.png){#fig-remove-parent-width-limit}
:::

I also tried several other approaches, such as:

```markdown
# Attempt 1
:::{#fig-title width="100%"}
![](image URL){style="width:7rem;"}
Caption
:::

# Attempt 2
:::{#fig-title style="width:100% !important;"}
![Caption](image URL){style="width:7rem;"}
:::

# Attempt 3
:::{#fig-title style="text-align:center; width:100% !important;"}
![](image URL){style="width:7rem;"}
Caption
:::

# ...
```

None of them achieved the desired result.

In the end, I decided to target the parent container directly via CSS, adding this rule to `style.css`:

```css
.quarto-float.quarto-figure.quarto-figure-center.anchored {
    width: 100% !important;
}
```

Combined with the image syntax:

```markdown
![Caption](image URL){#fig-title style="width:7rem;"}
```

This successfully centered the image while keeping the hover preview intact:

:::{.macbook-frame style="width:30rem;"}
![Centering achieved](https://raw.githubusercontent.com/Pinn32/img/main/img/pic-go/20260615190729348.png){#fig-center-success}
:::

:::{.img-frame style="width:18rem;"}
![Hover preview working](https://raw.githubusercontent.com/Pinn32/img/main/img/pic-go/20260615190756159.png){#fig-hover-success}
:::

# Centering Both Image and Caption

After fixing image centering, the caption still defaulted to left-aligned.

While Quarto's `fig-cap-location` attribute lets you place the caption at `top`, `bottom`, or `margin`, it does not control alignment.

After testing, the simplest solution is to set alignment directly in the image's inline style:

```markdown
# Method 1

![Caption](image URL){#fig-title style="text-align:center; width:7rem;"}
```

This requires no extra container and no caption separation.

Other viable approaches:

```markdown
# Method 2

:::{#fig-title fig-cap="write caption here"}
![leave empty](image URL){style="text-align:center; width:7rem;"}
:::

# Method 3

:::{#fig-title}
![leave empty](image URL){style="text-align:center; width:7rem;"}
<note: a blank line is required here>
Caption
:::
```

Method 1 has the cleanest syntax and the best code highlighting; Methods 2 and 3 are more verbose and introduce additional container nesting.

:::{.macbook-frame style="width:35rem;"}
![Syntax highlighting](https://raw.githubusercontent.com/Pinn32/img/main/img/pic-go/20260615190824762.png){#fig-syntax-highlight}
:::

To center all captions on a page, add internal CSS instead:

```markdown
<style>
	figcaption {
		text-align: center;
	}
</style>
```

The image syntax stays the same:

```markdown
![Caption](<image URL>){#fig-title style="width:7rem;"}
```
