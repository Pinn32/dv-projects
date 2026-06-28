---
title: '短链接生成器'
author: 'Pinn Xu'
date: 2026-04-06
description: '快速缩短网址，支持自定义链接后缀 (slug)。'
categories: [Web App, Next.js, MongoDB]
image: "https://raw.githubusercontent.com/Pinn32/img/main/img/pic-go/20260623194155759.png"
order: 2
---

# 短链接生成器 (URL Shortener)

这是一款简洁易用的短链接生成工具，支持将长网址转换为短链接，并自定义专属链接后缀。基于 **Next.js**、**TypeScript** 和 **MongoDB** 构建，帮助用户更方便地分享和管理链接。

:::{style="text-align:center;"}
[点击此处在线体验](https://url-to.vercel.app/){.btn .btn-outline-primary target="_blank"}
:::

:::{.macbook-frame style="width:35rem;"}
![URL Shortener](https://raw.githubusercontent.com/Pinn32/img/main/img/pic-go/20260623194155759.png)
:::

短链接是将冗长网址转换成简短网址的服务。它能在字数受限时节省篇幅，让分享时的外观更美观整洁，也更容易记忆和传播。

## 功能介绍

- **缩短长网址** —— 将冗长的网址转换为简短整洁的链接，方便在消息、幻灯片或纸质材料中分享。
- **自定义后缀 (slug)** —— 自由设置易记的链接后缀（如 `/my-portfolio`），告别随机字符串。
- **即时跳转** —— 访问短链接会立即跳转至原始网址，没有多余的中间页面。
- **持久化存储** —— 链接保存在 MongoDB 中，每次分享都能稳定访问。

## 使用方法

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