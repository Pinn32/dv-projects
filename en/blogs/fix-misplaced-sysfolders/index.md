---
title: "EN误移系统文件夹恢复"
author: 'Pinn Xu'
date: 2024-04-22
description: "恢复错误移动到根目录的Windows系统文件夹, 如 `文档`, `视频`, `图片`等。"
categories: [Windows, Powershell, 电脑技巧, 解决方案]
image: "https://raw.githubusercontent.com/Pinn32/img/main/img/pic-go/20260615210515071.png"
---

<style>
figcaption {
   text-align: center;
}
</style>


# 前言
这篇文章是我在 Notion 写的第一篇长篇解决问题过程记录，从那时起我第一次开始培养记录解决问题的过程的习惯。目的是 1）为了分享其他遇到类似问题的人；2）给自己看，万一以后自己忘了，就可以翻来查看。

也是在写完这篇之后，我使用 Notion 记录的频率大大提高；同时，在对这件事的研究让我第一次接触到 VSCode，这是我第一次接触 IDE，也是激发我对编程的兴趣的里程碑节点。

# 问题: 误移系统文件夹

早起心血来潮，打开 C盘 User 文件夹，发现还有一堆系统文件没有转移到 E盘，虽然基本用不上，但为了强迫症还是移动吧。

![系统文件夹](https://raw.githubusercontent.com/Pinn32/img/refs/heads/main/blogs/fix-misplaced-sysfolders/fig1.png){#fig-sysfolders style="width:8rem;"}


我找到 `保存的游戏` 文件的 `属性 > 位置`，直接把 `C:\User\Lenovo\Saved Games` 改成 `E:\` 并点击 `移动`。

![更改文件夹位置](https://raw.githubusercontent.com/Pinn32/img/refs/heads/main/blogs/fix-misplaced-sysfolders/fig2.png){#fig-relocate-folder style="width:24rem;"}


结果 “保存的游戏” 文件夹直接没了！我顿时明白我这是把 E盘根目录设置为 “保存的游戏” 了，于是开始搜索解决办法。但搜索结果似乎和我想的不太一样。

![搜寻解决办法](https://raw.githubusercontent.com/Pinn32/img/refs/heads/main/blogs/fix-misplaced-sysfolders/fig3.png){#fig-search-sol style="width:35rem;"}



于是我重新搜索其他类似的系统文件夹: 视频 (名字大众，不好搜); 3D对象 (名字特殊好搜，但文件夹小众); 桌面 (情况特殊，不一定适用) 等。

![搜寻类似系统文件夹](https://raw.githubusercontent.com/Pinn32/img/refs/heads/main/blogs/fix-misplaced-sysfolders/fig4.png){#fig-search-other-sysfolders style="width:35rem;"} 



最终找到此解决办法: 修改注册表。

![解决办法: 修改注册表](https://raw.githubusercontent.com/Pinn32/img/refs/heads/main/blogs/fix-misplaced-sysfolders/fig5.png){#fig-sol-modify-reg style="width:35rem;"}



# 解决: 修改注册表

**于是我按照步骤执行: **

1. **新建 `E:\Saved Games` 文件夹用于储存 “保存的游戏” 文件夹。**

2. **按 `WIN + R` 打开 `运行` 窗口, 输入 `regedit` 打开注册表。**

![打开注册表](https://raw.githubusercontent.com/Pinn32/img/refs/heads/main/blogs/fix-misplaced-sysfolders/fig6.png){#fig-open-reg style="width:25rem;"}



3. **找到路径并修改数据**  
**前往以下路径:**  
`HKEY_CURRENT_USER\HKEY_CURRENT_USER\Software\ Microsoft\Windows\CurrentVersion\Explorer\User Shell Folders` (注意最后是 “User Shell Folders” 而不是 “Shell Folders”)  
**查看并修改 "数据":**  
找到误改成 `E:\` 的路径, 修改 "数据" 为刚刚新建的文件夹的路径: `E:\Saved Games` 。  
(注意: 要先创建文件夹再修改注册表)

![修改注册表](https://raw.githubusercontent.com/Pinn32/img/refs/heads/main/blogs/fix-misplaced-sysfolders/fig7.png){#fig-modify-reg style="width:40rem;"}



4. **重启电脑, 查验结果**  
重启电脑后, 注册表生效, “保存的游戏” 文件夹恢复。为了验证, 再次按 `WIN` + `R` 打开 `运行` 窗口, 输入 `shell:SavedGames` 并确认, 如果成功跳转到 `E:\Saved Games` 文件夹则恢复成功。

![验证注册表修改成功](https://raw.githubusercontent.com/Pinn32/img/refs/heads/main/blogs/fix-misplaced-sysfolders/fig11.png){#fig-test-reg style="width:25rem;"}

![成功跳转 Saved Games](https://raw.githubusercontent.com/Pinn32/img/refs/heads/main/blogs/fix-misplaced-sysfolders/fig12.png){#fig-jump-saved-games style="width:35rem;"}


**但是！这样还不是完全复原，文件夹图标不是原来的，名称也没显示成中文 “保存的游戏” (见 @fig-sysfolders)。看似没恢复，但其实不改也行，下面的部分是为了满足强迫症。**



# 恢复图标

我首先想到的是 **手动修改文件夹图标** 。

![直接搜索图标](https://raw.githubusercontent.com/Pinn32/img/refs/heads/main/blogs/fix-misplaced-sysfolders/fig13.png){#fig-search-fodler-icon style="width:40rem;"}



搜寻到 [一篇文章](https://www.digitalcitizen.life/where-find-most-windows-10s-native-icons/#How%20Are%20Windows%20Icons%20stored?) 介绍 Windows 系统文件图标都储存在哪里。

![文章: Win图标存储位置](https://raw.githubusercontent.com/Pinn32/img/refs/heads/main/blogs/fix-misplaced-sysfolders/fig14.png){#fig-win-icon-loc style="width:35rem;"}



我打算尝试自行更改图标，然后发现当前图标的所在的文件是 `SHELL32.dll`，但进一步查看了一番发现这里并没有 “保存的游戏” 的图标。
于是我推测，除了 `SHELL32.dll` ，还有其他储存图标的文件。

:::{#fig-current-icon-loc layout-ncol=2}

![属性 > 自定义 > 更改图标](https://raw.githubusercontent.com/Pinn32/img/refs/heads/main/blogs/fix-misplaced-sysfolders/fig15-1.png){width=85%"}  

![当前图标位置](https://raw.githubusercontent.com/Pinn32/img/refs/heads/main/blogs/fix-misplaced-sysfolders/fig15-2.png){width="85%"}

当前图标文件 - SHELL32.dll
:::


查看刚刚搜寻到的 [网站](https://www.digitalcitizen.life/where-find-most-windows-10s-native-icons/#How%20Are%20Windows%20Icons%20stored?) 得知, 还有很多包含图标的 dll 文件。

![其他包含图标的系统文件](https://raw.githubusercontent.com/Pinn32/img/refs/heads/main/blogs/fix-misplaced-sysfolders/fig-icon-dll.png){#fig-icon-dll style="width:20rem;"}



于是我尝试查看其他文件, 最终在 `imageres.dll` 内发现了 "保存的游戏" 的图标, 除此之外还有 "桌面", "视频" 等图标。

![找到图标 - imageres.dll](https://raw.githubusercontent.com/Pinn32/img/refs/heads/main/blogs/fix-misplaced-sysfolders/fig17.png){#fig-imageres style="width:25rem;"}



现在成功恢复图标了，但文件名称还未恢复至 "保存的游戏"，我又开始思考如何才能实现文件名是 `Saved Game` 的同时显示名称为 `保存的游戏` 。

![成功恢复图标](https://raw.githubusercontent.com/Pinn32/img/refs/heads/main/blogs/fix-misplaced-sysfolders/fig18.png){#fig-icon-recovered style="width:10rem;"}



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

![显示隐藏的项目](https://raw.githubusercontent.com/Pinn32/img/refs/heads/main/blogs/fix-misplaced-sysfolders/fig20.png){#fig-show-hidden style="width:45rem;"}


3. **点击 “查看”**
4. **取消勾选 “隐藏受保护的操作系统文件”**
5. **点击 "是"**

![取消隐藏受保护的操作系统文件](https://raw.githubusercontent.com/Pinn32/img/refs/heads/main/blogs/fix-misplaced-sysfolders/fig21.png){#fig-show-hidden-sysfiles style="width:25rem;"}

![确定显示](https://raw.githubusercontent.com/Pinn32/img/refs/heads/main/blogs/fix-misplaced-sysfolders/fig22.png){#fig-confirm style="width:35rem;"}



确定后, `Saved Games` 文件夹里出现 `desktop.ini` 文件。

![desktop.ini 文件](https://raw.githubusercontent.com/Pinn32/img/refs/heads/main/blogs/fix-misplaced-sysfolders/fig23.png){#fig-desktop-ini style="width:35rem;"}



用记事本打开后内容如下 (@fig-desktop-ini-content), 可见其中 `IconResource` 项是指向 `imageres.dll` 的, 即刚刚恢复的图标。

![desktop.ini 文件具体内容](https://raw.githubusercontent.com/Pinn32/img/refs/heads/main/blogs/fix-misplaced-sysfolders/fig24.png){#fig-desktop-ini-content style="width:22rem;"}



按照指示, 添加了 `LocalizedResourceName=保存的游戏` (@fig-modify-display-name), 但是文件名变成了乱码 (@fig-display-name-encode-error) (英文可以正常显示, 中文变成乱码, 说明编译方式不对)。

![修改文件显示名](https://raw.githubusercontent.com/Pinn32/img/refs/heads/main/blogs/fix-misplaced-sysfolders/fig25.png){#fig-modify-display-name style="width:22rem;"}

![显示名变成乱码](https://raw.githubusercontent.com/Pinn32/img/refs/heads/main/blogs/fix-misplaced-sysfolders/fig26.png){#fig-display-name-encode-error style="width:10rem;"}



我按照同样的方式打开 `视频` 文件夹的 `desktop.ini` 文件，发现 “视频” 二字的信息来自于 `shell32.dll` 文件。

!["视频"显示名信息来源](https://raw.githubusercontent.com/Pinn32/img/refs/heads/main/blogs/fix-misplaced-sysfolders/fig27.png){#fig-name-info-source style="width:22rem;"}



于是我搜索 `shell.32` 中的文件显示名资源。

![搜索 `shell.32` 名称资源](https://raw.githubusercontent.com/Pinn32/img/refs/heads/main/blogs/fix-misplaced-sysfolders/fig28.png){#fig-search-name-resource style="width:25rem;"}



结果只找到对于图标资源的讨论。

![搜索结果: 对图标资源的讨论](https://raw.githubusercontent.com/Pinn32/img/refs/heads/main/blogs/fix-misplaced-sysfolders/fig29.png){#fig-search-result-icon-resource style="width:35rem;"}


只好求助 AI：

![求助AI](https://raw.githubusercontent.com/Pinn32/img/main/img/pic-go/20260615212707012.png){#fig-ask-ai style="width:35rem;"}

但是 ChatGPT 给出的答案是虚构的。

![虚构答案](https://raw.githubusercontent.com/Pinn32/img/main/img/pic-go/20260615212844148.png){#fig-fake-answer style="width:35rem;"}

> 注：-21810 是 “链接”，不是 “保存的游戏”

我又问如何查看 `shell32.dll` 中的内容，它推荐使用 Visual Studio。

![询问如何查看 `shell32.dll` 内容](https://raw.githubusercontent.com/Pinn32/img/main/img/pic-go/20260615213053253.png){#fig-ask-visual-studio style="width:35rem;"}

结果编程 0 基础的我，不小心下载成了 Visual Studio Code，而这一不小心，竟是激发我对编程的兴趣的里程碑之一。这是我第一次了解什么是 IDE。后来有一次老师发现我没有用 Jupyter 写作业，而是用 VSCode，问我为什么想到用 VSCode，我掏出这篇文章。

![VSCode 和 Visual Studio](https://raw.githubusercontent.com/Pinn32/img/main/img/pic-go/20260615215305385.png){#fig-vscode-and-visual-studio style="width:20rem;"}

我按照 ChatGPT 的指示，新建解决方案 > 添加 > 现有项 > `C:\Windows\System32\shell32.dll` ，然后查看 dll 文件的目录。


![AI 指示](https://raw.githubusercontent.com/Pinn32/img/main/img/pic-go/20260615215723081.png){#fig-ai-suggest style="width:40rem;"}

![Visual Studio 界面](https://raw.githubusercontent.com/Pinn32/img/main/img/pic-go/20260615215843231.png){#fig-vs-interface style="width:45rem;"}


但是用 Visual Studio 只能查看资源目录，不能看具体的编号。况且 `shell32.dll` 文件内资源非常丰富，恐怕我徒手翻看也不能轻易找到 “保存的游戏” 的中文显示名称。

最后我想到直接查看别人电脑里的没改动过的文件信息。对照着直接进行更改。原来是 “-21814” ，这么近，我刚才如果再试几次可能就试出来了。（捂脸）

![对照别人电脑更改后](https://raw.githubusercontent.com/Pinn32/img/main/img/pic-go/20260615220143319.png){#fig-after-change style="width:30rem;"}

**"保存的游戏" —— 堂堂复活！**

![`保存的游戏` 复活](https://raw.githubusercontent.com/Pinn32/img/main/img/pic-go/20260615235720052.png){#fig-rebirth style="width:12rem;"}


现在 “保存的游戏” 文件夹的默认图标已经变成游戏图标了。

![默认图标恢复](https://raw.githubusercontent.com/Pinn32/img/main/img/pic-go/20260616000059488.png){#fig-default-icon style="width:30rem;"}

教训：以后再移动盘，只更改盘符，其他不动

![移动系统文件：只修改盘符](https://raw.githubusercontent.com/Pinn32/img/main/img/pic-go/20260616000208909.png){#fig-move-system-folder style="width:30rem;"}



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

```ini
[.ShellClassInfo]
LocalizedResourceName=@%SystemRoot%\system32\shell32.dll,<文件名对应数值>
IconResource=%SystemRoot%\system32\imageres.dll,<文件图标对应数值>
<其他项...>
```

> 注：设置完后记得重新隐藏第三步中显示的文件


(未完)

## 系统文件夹对应资源表格

表1：图标对应资源
表2：显示名称对应资源

注注注: 也可以用 `UTF-16 LE` 编码 (先搞清楚 `desktop.ini` 用的到底是什么编码), 在 `LocalizedResourceName=<这里>` 里填入编码后的中文字符, 比找资源 (`dll`) 里的数值更方便, 不过如果已经有数值列表, 也可以直接拷贝.