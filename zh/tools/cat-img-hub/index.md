---
title: '猫咪图片收藏站'
author: ['Pinn Xu', 'Yuchen Bao', 'Tianpeng Xu']
date: 2026-04-19
description: '浏览随机猫咪图片，登录后收藏自己喜欢的猫咪图片。'
categories: [Web App, Next.js, MongoDB, OAuth]
image: "https://raw.githubusercontent.com/Pinn32/img/main/img/pic-go/20260624000221390.png"
order: 3
---

# 猫咪图片收藏站 (Cat Image Hub)

猫咪图片收藏站是一款随机浏览猫咪图片并收藏喜爱图片的 Web 应用。用户可以通过登录账号保存个人收藏，项目基于 **Next.js**、**TypeScript** 和 **MongoDB** 开发，并集成 Cat API 提供图片数据，使用 Google OAuth 实现用户认证。

:::{style="text-align:center;"}
[点击此处在线体验](https://cat-img-hub.vercel.app/){.btn .btn-outline-primary target="_blank"}
:::

![主页: 随机猫咪图片](https://raw.githubusercontent.com/Pinn32/img/main/img/pic-go/20260623235024432.png){#fig-gallery style="width:40rem;"}


![登录界面](https://raw.githubusercontent.com/Pinn32/img/main/img/pic-go/20260624000817849.png){#fig-login style="width:30rem;"}

![收藏界面](https://raw.githubusercontent.com/Pinn32/img/main/img/pic-go/20260623234247520.png){#fig-favorites style="width:40rem;"}


## 核心功能

- **随机图库** —— 首页以网格形式加载随机猫咪图片，并附带品种、寿命和性格信息，数据在服务端从 Cat API 获取。
- **按 ID 搜索** —— 可通过 Cat API 的图片 ID 查找任意一张猫咪图片。
- **收藏功能** —— 登录用户可以点赞 / 取消点赞，收藏的猫咪会保存到 MongoDB，并在专属页面中展示。
- **Google 登录** —— 通过 Auth.js v5 实现一键 OAuth 登录，不存储任何密码。

## 工作原理

页面采用 Next.js 服务端组件 (Server Component) 获取初始数据，再交给小型交互式客户端组件处理，从而保持客户端 JavaScript 的轻量。

- **Cat API 层** —— 一个轻量封装用于获取随机图片与单张图片数据，并在 API 缺少品种信息时进行补全。
- **收藏服务** —— MongoDB 中的 `favorites` 集合（使用原生驱动，无 ORM）以用户的 Google 账号 ID 为键存储每只收藏的猫咪，并对添加 / 删除操作做去重处理。
- **身份认证** —— Auth.js 将 Google 账号 ID 存入会话令牌 (session token)，因此每个服务端组件和 API 路由都能直接识别用户，无需额外查询数据库。

## 技术栈

| 层级 | 技术 |
| --- | --- |
| 框架 | Next.js 16 (App Router) |
| 语言 | TypeScript 5 |
| 认证 | Auth.js v5 + Google OAuth |
| 数据库 | MongoDB 6（原生驱动）|
| 样式 | styled-components 6 |
| 外部 API | [The Cat API](https://thecatapi.com){target="_blank"} |

## 团队

由 **Pinn (Aiqi) Xu**（身份认证、布局、导航、样式）、**Yuchen Bao**（Cat API 集成、首页与搜索页、猫咪卡片）和 **Tianpeng Xu**（MongoDB、收藏服务与页面、共享类型）共同开发。


[>> 查看 GitHub 源码](https://github.com/Pinn32/cat-img-hub){target="_blank"}

