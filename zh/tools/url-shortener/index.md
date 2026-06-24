---
title: '短链接生成器'
author: 'Pinn Xu'
date: 2026-04-06
description: '快速缩短网址，支持自定义链接后缀 (slug)。'
# categories: [Quarto, CSS, Web Dev, Computer Tips, Knowhow]
categories: [Web Dev, Next.js, MongoDB]
image: "https://raw.githubusercontent.com/Pinn32/img/main/img/pic-go/20260623194155759.png"
---

# 短链接生成器

这是一款简洁易用的短链接生成工具，支持将长网址转换为短链接，并自定义专属链接后缀。基于 **Next.js**、**TypeScript** 和 **MongoDB** 构建，帮助用户更方便地分享和管理链接。

:::{#fig-url-to width="100%"}
[点击此处在线体验](https://url-to.vercel.app/){.btn .btn-outline-primary style="" target="_blank"}

![](https://raw.githubusercontent.com/Pinn32/img/main/img/pic-go/20260623194155759.png){style="width:35rem;"}

"URL Shortener"
:::

使用方法非常简单，首先输入需要缩短的长网址：

```html
https://example.com/your/very/long/url/
```

然后为短链接设置一个自定义后缀 (slug)：

```html
https://url-to.vercel.app/<your-slug>
```

点击「Click to Compact」按钮后，系统会生成对应的短链接。访问该短链接时，将自动跳转到原始网址。

[>> 查看 GitHub 源码](https://github.com/Pinn32/mp-5){target="_blank"}