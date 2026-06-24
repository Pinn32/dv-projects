---
title: '新闻汇总收藏站'
author: ['Pinn Xu', 'Yuchen Bao', 'Tianpeng Xu']
date: 2026-04-17
description: '最新资讯流与新闻聚合 Web 应用。'
categories: [Web App, Next.js, MongoDB, Supabase, OAuth]
image: "https://raw.githubusercontent.com/Pinn32/img/main/img/pic-go/20260624190433396.png"
order: 1
---


# 新闻汇总收藏站 (News Hub)

NewsHub 是一款全栈新闻聚合 Web 应用，用户可以浏览、搜索、筛选新闻文章并与之互动。应用从 **NewsAPI.org** 实时获取内容，通过 **Supabase Auth** 实现用户认证，并使用 **MongoDB** 存储收藏、点赞等用户互动数据。

:::{style="text-align:center;"}
[点击此处在线体验](https://news-hub-demo.vercel.app/){.btn .btn-outline-primary target="_blank"}
:::

![主页](https://raw.githubusercontent.com/Pinn32/img/main/img/pic-go/20260624185727241.png){style="width:40rem;"}



项目基于 **Next.js 16**、**React 19** 和 **TypeScript** 构建，采用 App Router 架构，实现了服务端渲染、API 路由、认证流程，并使用 **styled-components** 完成响应式 UI 样式。

## 核心功能

- **新闻浏览** —— 展示最新资讯，支持按分类筛选和关键词搜索。
- **文章详情** —— 查看文章的标题、分类、作者、摘要、配图及来源链接等信息。
- **用户认证** —— 通过 Supabase 支持邮箱 / 密码登录、注册、密码重置以及 Google OAuth 登录。
- **收藏功能** —— 收藏并管理喜爱的文章，数据持久化存储。
- **点赞功能** —— 为文章点赞，并基于 MongoDB 持久化保存。
- **分享功能** —— 使用 Web Share API 分享文章，并在不支持时回退到剪贴板复制。

## 技术栈

| 层级 | 技术 |
| --- | --- |
| 框架 | Next.js 16 (App Router) |
| 语言 | TypeScript |
| UI | React 19 + styled-components |
| 认证 | Supabase Auth |
| 数据库 | MongoDB + Mongoose |
| 外部 API | NewsAPI.org |

## 架构亮点

- 使用 **Next.js 服务端组件 (Server Component)** 和 API 路由实现高效的数据获取。
- 基于 **Supabase SSR 认证**，并配合会话 (session) 管理。
- 使用 **MongoDB + Mongoose** 持久化存储用户互动数据。
- 在 API 层为新闻请求加入缓存，减少对外部 API 的调用。

[>> 查看 GitHub 源码](https://github.com/Pinn32/news-hub){target="_blank"}

