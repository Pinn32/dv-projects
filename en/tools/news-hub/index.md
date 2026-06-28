---
title: 'News Hub'
author: ['Pinn Xu', 'Yuchen Bao', 'Tianpeng Xu']
date: 2026-04-17
description: 'Latest news feed and aggregation web app.'
categories: [Web App, Next.js, MongoDB, Supabase, OAuth]
image: "https://raw.githubusercontent.com/Pinn32/img/main/img/pic-go/20260624190433396.png"
order: 1
---


# News Hub

NewsHub is a full-stack news aggregation web application that allows users to browse, search, filter, and interact with news articles. The application fetches real-time content from **NewsAPI.org**, supports user authentication through **Supabase Auth**, and stores user interactions such as bookmarks and likes with **MongoDB**.

:::{style="text-align:center;"}
[Click Here to Try](https://news-hub-demo.vercel.app/){.btn .btn-outline-primary target="_blank"}
:::

::: {.macbook-frame style="width:40rem;"}
![Home Page](https://raw.githubusercontent.com/Pinn32/img/main/img/pic-go/20260624185727241.png){fig-alt="News Hub home page"}
:::



Built with **Next.js 16**, **React 19**, and **TypeScript**, the project implements the App Router architecture with server-side rendering, API routes, authentication flows, and responsive UI styling using **styled-components**.

## Key Features

- **News browsing** — Display latest news with category filtering and keyword search.
- **Article details** — View article information including title, category, author, summary, images, and source links.
- **User authentication** — Support email/password login, signup, password reset, and Google OAuth via Supabase.
- **Bookmarks** — Save and manage favorite articles with persistent storage.
- **Likes** — Like articles with MongoDB-based persistence.
- **Sharing** — Share articles using Web Share API with clipboard fallback.

## Tech Stack

| Layer | Technology |
| --- | --- |
| Framework | Next.js 16 (App Router) |
| Language | TypeScript |
| UI | React 19 + styled-components |
| Authentication | Supabase Auth |
| Database | MongoDB + Mongoose |
| External API | NewsAPI.org |

## Architecture Highlights

- Uses **Next.js Server Components** and API routes for efficient data fetching.
- Implements **Supabase SSR authentication** with session management.
- Uses **MongoDB + Mongoose** for persistent user interactions.
- Includes API-level caching for news requests to reduce external API calls.

[>> View source on GitHub](https://github.com/Pinn32/news-hub){target="_blank"}

