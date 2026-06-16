---
title: "误移系统文件夹恢复"
author: 'Pinn Xu'
date: 2024-04-22
word-count: true
description: "恢复错误移动到根目录的Windows系统文件夹, 如 `文档`, `视频`, `图片`等。"
categories: [Windows, Powershell, 电脑技巧, 解决方案]
sidebar: true
number-sections: true
---

# 前言

# 问题: 误移系统文件夹

早起心血来潮，打开 C盘 User 文件夹，发现还有一堆系统文件没有转移到 E盘，虽然基本用不上，但为了强迫症还是移动吧。

![系统文件夹](https://raw.githubusercontent.com/Pinn32/img/refs/heads/main/blogs/fix-misplaced-sysfolders/fig1.png){#fig-sysfolders width="15%"}


我找到 `保存的游戏` 文件的 `属性 > 位置`，直接把 `C:\User\Lenovo\Saved Games` 改成 `E:\` 并点击 `移动`。

![更改文件夹位置](https://raw.githubusercontent.com/Pinn32/img/refs/heads/main/blogs/fix-misplaced-sysfolders/fig2.png){#fig-relocate-folder width="50%"}


结果 “保存的游戏” 文件夹直接没了！我顿时明白我这是把 E盘根目录设置为 “保存的游戏” 了，于是开始搜索解决办法。  
但搜索结果似乎和我想的不太一样。

![搜寻解决办法](https://raw.githubusercontent.com/Pinn32/img/refs/heads/main/blogs/fix-misplaced-sysfolders/fig3.png){#fig-search-sol width="80%"}


于是我重新搜索其他类似的系统文件夹: 视频 (名字大众，不好搜); 3D对象 (名字特殊好搜，但文件夹小众); 桌面 (情况特殊，不一定适用) 等。

![搜寻类似系统文件夹](https://raw.githubusercontent.com/Pinn32/img/refs/heads/main/blogs/fix-misplaced-sysfolders/fig4.png){#fig-search-other-sysfolders width="70%"} 


最终找到此解决办法: 修改注册表。

![解决办法: 修改注册表](https://raw.githubusercontent.com/Pinn32/img/refs/heads/main/blogs/fix-misplaced-sysfolders/fig5.png){#fig-sol-modify-reg width="70%"}


# 解决: 修改注册表

**于是我按照步骤执行: **

1. **新建 `E:\Saved Games` 文件夹用于储存 “保存的游戏” 文件夹。**

2. **按 `WIN + R` 打开 `运行` 窗口, 输入 `regedit` 打开注册表。**

![打开注册表](https://raw.githubusercontent.com/Pinn32/img/refs/heads/main/blogs/fix-misplaced-sysfolders/fig6.png){#fig-open-reg width="50%"}


3. **找到路径并修改数据**  
**前往以下路径:**  
`HKEY_CURRENT_USER\HKEY_CURRENT_USER\Software\ Microsoft\Windows\CurrentVersion\Explorer\User Shell Folders` (注意最后是 “User Shell Folders” 而不是 “Shell Folders”)  
**查看并修改 "数据":**  
找到误改成 `E:\` 的路径, 修改 "数据" 为刚刚新建的文件夹的路径: `E:\Saved Games` 。  
(注意: 要先创建文件夹再修改注册表)

![修改注册表](https://raw.githubusercontent.com/Pinn32/img/refs/heads/main/blogs/fix-misplaced-sysfolders/fig7.png){#fig-modify-reg width="90%"}


4. **重启电脑, 查验结果**  
重启电脑后, 注册表生效, “保存的游戏” 文件夹恢复。为了验证, 再次按 `WIN` + `R` 打开 `运行` 窗口, 输入 `shell:SavedGames` 并确认, 如果成功跳转到 `E:\Saved Games` 文件夹则恢复成功。

![验证注册表修改成功](https://raw.githubusercontent.com/Pinn32/img/refs/heads/main/blogs/fix-misplaced-sysfolders/fig11.png){#fig-test-reg width="50%"}

![成功跳转 Saved Games](https://raw.githubusercontent.com/Pinn32/img/refs/heads/main/blogs/fix-misplaced-sysfolders/fig12.png){#fig-jump-saved-games width="70%"}

**但是！这样还不是完全复原，文件夹图标不是原来的，名称也没显示成中文 “保存的游戏” (见 @fig-sysfolders)。看似没恢复，但其实不改也行，下面的部分是为了满足强迫症。**

# 恢复图标

我首先想到的是 **手动修改文件夹图标** 。

![直接搜索图标](https://raw.githubusercontent.com/Pinn32/img/refs/heads/main/blogs/fix-misplaced-sysfolders/fig13.png){#fig-search-fodler-icon width="80%"}


搜寻到 [一篇文章](https://www.digitalcitizen.life/where-find-most-windows-10s-native-icons/#How%20Are%20Windows%20Icons%20stored?) 介绍 Windows 系统文件图标都储存在哪里。

![文章: Win图标存储位置](https://raw.githubusercontent.com/Pinn32/img/refs/heads/main/blogs/fix-misplaced-sysfolders/fig14.png){#fig-win-icon-loc width="70%"}

我打算尝试自行更改图标，然后发现当前图标的所在的文件是 `SHELL32.dll`，但进一步查看了一番发现这里并没有 “保存的游戏” 的图标。
于是我推测，除了 `SHELL32.dll` ，还有其他储存图标的文件。

:::{#fig-current-icon-loc layout-ncol=2}

![属性 > 自定义 > 更改图标](https://raw.githubusercontent.com/Pinn32/img/refs/heads/main/blogs/fix-misplaced-sysfolders/fig15-1.png){width="85%"}  

![当前图标位置](https://raw.githubusercontent.com/Pinn32/img/refs/heads/main/blogs/fix-misplaced-sysfolders/fig15-2.png){width="85%"}

当前图标文件 - SHELL32.dll
:::


查看刚刚搜寻到的 [网站](https://www.digitalcitizen.life/where-find-most-windows-10s-native-icons/#How%20Are%20Windows%20Icons%20stored?) 得知, 还有很多包含图标的 dll 文件。

![其他包含图标的系统文件](https://raw.githubusercontent.com/Pinn32/img/refs/heads/main/blogs/fix-misplaced-sysfolders/fig-icon-dll.png){#fig-icon-dll width="45%"}

于是我尝试查看其他文件, 最终在 `imageres.dll` 内发现了 "保存的游戏" 的图标, 除此之外还有 "桌面", "视频" 等图标。

![找到图标 - imageres.dll](https://raw.githubusercontent.com/Pinn32/img/refs/heads/main/blogs/fix-misplaced-sysfolders/fig17.png){#fig-imageres width="50%"}



现在成功恢复图标了，但文件名称还未恢复至 "保存的游戏"，我又开始思考如何才能实现文件名是 `Saved Game` 的同时显示名称为 `保存的游戏` 。

![成功恢复图标](https://raw.githubusercontent.com/Pinn32/img/refs/heads/main/blogs/fix-misplaced-sysfolders/fig18.png){#fig-icon-recovered width="20%"}


# 恢复文件名

再次搜索，找到如下结果: 

:::{#fig-search-results layout-nrow=2}

![搜索结果](https://raw.githubusercontent.com/Pinn32/img/refs/heads/main/blogs/fix-misplaced-sysfolders/fig19-1.png){width="60%"}

![搜索结果: 具体内容](https://raw.githubusercontent.com/Pinn32/img/refs/heads/main/blogs/fix-misplaced-sysfolders/fig19-2.png){width="60%"}

搜索结果 - 让文件名和显示名不一样

:::

**依据指示, 进行如下操作:**  

1. **勾选 “隐藏的项目”（为了显示隐藏的项目）**
2. **点击打开 “选项”**

![显示隐藏的项目](https://raw.githubusercontent.com/Pinn32/img/refs/heads/main/blogs/fix-misplaced-sysfolders/fig20.png){#fig-show-hidden width="90%"}

3. **点击 “查看”**
4. **取消勾选 “隐藏受保护的操作系统文件”**
5. **点击 "是"**

![取消隐藏受保护的操作系统文件](https://raw.githubusercontent.com/Pinn32/img/refs/heads/main/blogs/fix-misplaced-sysfolders/fig21.png){#fig-show-hidden-sysfiles width="50%"}

![确定显示](https://raw.githubusercontent.com/Pinn32/img/refs/heads/main/blogs/fix-misplaced-sysfolders/fig22.png){#fig-confirm width="70%"}


确定后, `Saved Games` 文件夹里出现 `desktop.ini` 文件。


![desktop.ini 文件](https://raw.githubusercontent.com/Pinn32/img/refs/heads/main/blogs/fix-misplaced-sysfolders/fig23.png){#fig-desktop-ini width="70%"}


用记事本打开后内容如下 (), 可见其中 `IconResource` 项是指向 `imageres.dll` 的, 即刚刚恢复的图标。

![desktop.ini 文件具体内容](https://raw.githubusercontent.com/Pinn32/img/refs/heads/main/blogs/fix-misplaced-sysfolders/fig23.png){#fig-desktop-ini-content width="50%"}

按照指示, 添加了 `LocalizedResourceName=保存的游戏` 行

按照教程指示添加了 。
但是发现系统识别不出来中文...






















































# 总结

## 问题

Win10 系统文件夹 (Sell Files, 如 `桌面`, `文档`, `图片` ) 不小心移动到磁盘根目录 (如 `D:\`, `E:\` ), 如何恢复文件夹?

## 解决方法

1. 新建文件夹, 用于储存系统文件夹 (如 `E:\User\UserName\Desktop\`)
2. 修改注册表, 将文件夹路径改为新建文件夹的路径
   - 按 `WIN + R` 打开 `运行` 窗口, 输入 `regedit` 打开注册表
   - 找到 `HKEY_CURRENT_USER\HKEY_CURRENT_USER\Software\ Microsoft\Windows\CurrentVersion\Explorer\User Shell Folders`
   - 找到 `数据` 为磁盘根目录的条目 (如 `E:\`)
   - 修改 `数据` 为新建文件夹的路径 (如 `E:\User\UserName\Desktop\`)
   - 保存后重启电脑
3. 显示隐藏的系统文件
   - 打开新建的文件夹 (如 `E:\User\UserName\Desktop`)
   - 打开 `文件 > 选项 > 查看`
   - 勾选 `⏺ 显示隐藏的文件、文件夹或驱动器`
   - 取消勾选 `◻ 隐藏受保护的操作系统文件`
4. 修改 `desktop.ini` 文件
   - 用记事本打开 `desktop.ini` 文件
   - 填写 `IconResource` 和 `LocalizedResourceName` 项



```shell
[.ShellClassInfo]
LocalizedResourceName=@%SystemRoot%\system32\shell32.dll,<文件名对应数值>
IconResource=hello
```

