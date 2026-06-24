---
title: 'URL Shortener'
author: 'Pinn Xu'
date: 2026-04-06
description: 'Compact long URLs into shareable short links with customized slugs.'
# categories: [Quarto, CSS, Web Dev, Computer Tips, Knowhow]
categories: [Web Dev, Next.js, MongoDB]
image: "https://raw.githubusercontent.com/Pinn32/img/main/img/pic-go/20260623194155759.png"
order: 2
---

# URL Shortener

This web tool helps you compact long URLs into shareable short links with customized slugs. It was developed by **Next.js**, **TypeScript**, and **MongoDB**.

:::{#fig-url-to width="100%"}
[Click Here to Try](https://url-to.vercel.app/){.btn .btn-outline-primary style="" target="_blank"}

![](https://raw.githubusercontent.com/Pinn32/img/main/img/pic-go/20260623194155759.png){style="width:35rem;"}

"URL Shortener"
:::

A short link is a compact version of a long web address. It saves characters when space is limited, looks cleaner when shared, and is far easier to remember and pass along.

## Key Features

- **Compact long URLs** — turn a sprawling web address into a short, tidy link that's easy to share in messages, slides, or print.
- **Custom slugs** — pick your own memorable ending (e.g. `/my-portfolio`) instead of a random string of characters.
- **Instant redirect** — visiting the short link forwards to the original URL right away, with no intermediate page.
- **Persistent storage** — links are saved in MongoDB, so they keep working every time you share them.

## How to Use

To use it, enter your long URL:

```html
https://example.com/your/very/long/url/
```

Then, choose a slug for your shortened URL:

```html
https://url-to.vercel.app/<your-slug>
```

Click the compact button, and the tool will give you a shortened link that redirects to your URL.

[>> View source on GitHub](https://github.com/Pinn32/mp-5){target="_blank"}

