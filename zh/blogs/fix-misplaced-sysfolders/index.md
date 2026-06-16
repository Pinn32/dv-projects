---
title: "误移系统文件夹恢复"
author: 'Pinn Xu'
date: 2024-04-22
description: "恢复意外移到磁盘根目录的 Windows 系统文件夹, 如 `文档`, `视频`, `图片`等。"
categories: [Windows, Powershell, 电脑技巧, 解决方案]
image: "https://raw.githubusercontent.com/Pinn32/img/main/img/pic-go/20260615210515071.png"
---

<style>
figcaption {
   text-align: center;
}
</style>


# 前言

这篇文章源自我在 Notion 写的第一篇较长的问题解决记录，也是我开始养成"记录解决过程"这一习惯的起点。其目的一是为了分享，二是留作日后自查。

写完这篇后，我使用 Notion 记录的频率大大提高。此外，对这个问题的深入研究让我第一次接触到 VSCode，这是我初识 IDE 的契机，也是激发我对编程兴趣的里程碑之一。

# 问题: 误移系统文件夹

某天整理 C 盘，发现 `C:\Users\<用户名>` 下还有一批系统文件夹未迁移至 E 盘，便打算一并处理。

![系统文件夹](https://raw.githubusercontent.com/Pinn32/img/refs/heads/main/blogs/fix-misplaced-sysfolders/fig1.png){#fig-sysfolders style="width:8rem;"}


我打开 `保存的游戏` 的 `属性 > 位置`，将路径 `C:\Users\Lenovo\Saved Games` 直接改成 `E:\` 并点击 `移动`。

![更改文件夹位置](https://raw.githubusercontent.com/Pinn32/img/refs/heads/main/blogs/fix-misplaced-sysfolders/fig2.png){#fig-relocate-folder style="width:24rem;"}


结果 `保存的游戏` 就此消失——我这才意识到，自己把 E 盘根目录本身设成了目标路径，于是开始搜索解决方案。但搜索结果与预期不符。

![搜寻解决办法](https://raw.githubusercontent.com/Pinn32/img/refs/heads/main/blogs/fix-misplaced-sysfolders/fig3.png){#fig-search-sol style="width:35rem;"}



改用其他关键词搜索类似系统文件夹：`视频`（名字太常见，结果嘈杂）、`3D 对象`（名字特殊，但知名度低）、`桌面`（情况特殊，方案未必通用）等。

![搜寻类似系统文件夹](https://raw.githubusercontent.com/Pinn32/img/refs/heads/main/blogs/fix-misplaced-sysfolders/fig4.png){#fig-search-other-sysfolders style="width:35rem;"} 



最终锁定解决方案：修改注册表。

![解决办法: 修改注册表](https://raw.githubusercontent.com/Pinn32/img/refs/heads/main/blogs/fix-misplaced-sysfolders/fig5.png){#fig-sol-modify-reg style="width:35rem;"}



# 解决: 修改注册表

按照以下步骤执行：

1. **在 E 盘新建目标文件夹 `E:\Saved Games`，用于存放 `保存的游戏`。**

2. **按 `Win + R` 打开运行窗口，输入 `regedit` 打开注册表编辑器。**

![打开注册表](https://raw.githubusercontent.com/Pinn32/img/refs/heads/main/blogs/fix-misplaced-sysfolders/fig6.png){#fig-open-reg style="width:25rem;"}



3. **定位并修改路径**  
   导航至以下路径：  
   `HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\User Shell Folders`  
   （注意：是 **User Shell Folders**，不是 Shell Folders）  
   
   找到数据值为 `E:\` 的条目，将其修改为 `E:\Saved Games`。  
   （务必先建好文件夹，再修改注册表）

![修改注册表](https://raw.githubusercontent.com/Pinn32/img/refs/heads/main/blogs/fix-misplaced-sysfolders/fig7.png){#fig-modify-reg style="width:40rem;"}



4. **重启电脑，验证结果**  
   重启后按 `Win + R` 输入 `shell:SavedGames`，若能跳转到 `E:\Saved Games`，则恢复成功。

![验证注册表修改成功](https://raw.githubusercontent.com/Pinn32/img/refs/heads/main/blogs/fix-misplaced-sysfolders/fig11.png){#fig-test-reg style="width:25rem;"}

![成功跳转 Saved Games](https://raw.githubusercontent.com/Pinn32/img/refs/heads/main/blogs/fix-misplaced-sysfolders/fig12.png){#fig-jump-saved-games style="width:35rem;"}


**此时文件夹图标仍为默认样式，中文名称 `保存的游戏` 也未显示（见 @fig-sysfolders）。但功能已恢复，以下步骤是为了恢复其外观。**



# 恢复图标

我首先尝试手动更改文件夹图标。

![直接搜索图标](https://raw.githubusercontent.com/Pinn32/img/refs/heads/main/blogs/fix-misplaced-sysfolders/fig13.png){#fig-search-fodler-icon style="width:40rem;"}



搜索到[一篇文章](https://www.digitalcitizen.life/where-find-most-windows-10s-native-icons/#How%20Are%20Windows%20Icons%20stored?)，介绍了 Windows 系统图标的存储位置。

![文章: Win图标存储位置](https://raw.githubusercontent.com/Pinn32/img/refs/heads/main/blogs/fix-misplaced-sysfolders/fig14.png){#fig-win-icon-loc style="width:35rem;"}



通过 `属性 > 自定义 > 更改图标` 发现，当前图标来自 `SHELL32.dll`，但其中并没有 `保存的游戏` 对应的图标，由此推断系统还有其他存储图标的 DLL 文件。

:::{#fig-current-icon-loc layout-ncol=2}

![属性 > 自定义 > 更改图标](https://raw.githubusercontent.com/Pinn32/img/refs/heads/main/blogs/fix-misplaced-sysfolders/fig15-1.png){width=85%"}  

![当前图标位置](https://raw.githubusercontent.com/Pinn32/img/refs/heads/main/blogs/fix-misplaced-sysfolders/fig15-2.png){width="85%"}

当前图标文件 - SHELL32.dll
:::


参考[文章](https://www.digitalcitizen.life/where-find-most-windows-10s-native-icons/#How%20Are%20Windows%20Icons%20stored?)中列出的多个 DLL 文件，逐一查看后，在 `imageres.dll` 中找到了 `保存的游戏` 的图标，以及 `桌面`、`视频` 等图标。

![其他包含图标的系统文件](https://raw.githubusercontent.com/Pinn32/img/refs/heads/main/blogs/fix-misplaced-sysfolders/fig-icon-dll.png){#fig-icon-dll style="width:20rem;"}

![找到图标 - imageres.dll](https://raw.githubusercontent.com/Pinn32/img/refs/heads/main/blogs/fix-misplaced-sysfolders/fig17.png){#fig-imageres style="width:25rem;"}



将图标更改为正确资源后，图标恢复正常。但文件夹的显示名称仍未还原为 `保存的游戏`。

![成功恢复图标](https://raw.githubusercontent.com/Pinn32/img/refs/heads/main/blogs/fix-misplaced-sysfolders/fig18.png){#fig-icon-recovered style="width:10rem;"}



# 恢复文件名

搜索"如何让文件名与显示名不同"，找到如下方案：

:::{#fig-search-results layout-nrow=2}

![搜索结果](https://raw.githubusercontent.com/Pinn32/img/refs/heads/main/blogs/fix-misplaced-sysfolders/fig19-1.png){width="60%"}

![搜索结果: 具体内容](https://raw.githubusercontent.com/Pinn32/img/refs/heads/main/blogs/fix-misplaced-sysfolders/fig19-2.png){width="60%"}

搜索结果 - 让文件名和显示名不一样

:::



**操作步骤：**

1. **勾选"显示隐藏的项目"**，点击 **选项**。
2. **点击"查看"** 标签页。
3. **取消勾选"隐藏受保护的操作系统文件"**，点击 **是**。

![显示隐藏的项目](https://raw.githubusercontent.com/Pinn32/img/refs/heads/main/blogs/fix-misplaced-sysfolders/fig20.png){#fig-show-hidden style="width:45rem;"}


![取消隐藏受保护的操作系统文件](https://raw.githubusercontent.com/Pinn32/img/refs/heads/main/blogs/fix-misplaced-sysfolders/fig21.png){#fig-show-hidden-sysfiles style="width:25rem;"}

![确定显示](https://raw.githubusercontent.com/Pinn32/img/refs/heads/main/blogs/fix-misplaced-sysfolders/fig22.png){#fig-confirm style="width:35rem;"}



此时 `Saved Games` 文件夹内出现 `desktop.ini` 文件。

![desktop.ini 文件](https://raw.githubusercontent.com/Pinn32/img/refs/heads/main/blogs/fix-misplaced-sysfolders/fig23.png){#fig-desktop-ini style="width:35rem;"}



用记事本打开，可见其中 `IconResource` 条目已指向 `imageres.dll`（即上一步恢复的图标）。

![desktop.ini 文件具体内容](https://raw.githubusercontent.com/Pinn32/img/refs/heads/main/blogs/fix-misplaced-sysfolders/fig24.png){#fig-desktop-ini-content style="width:22rem;"}



按指引添加 `LocalizedResourceName=保存的游戏`（@fig-modify-display-name），保存后文件名出现乱码（@fig-display-name-encode-error）。英文正常显示，中文乱码，说明编码格式不对。

![修改文件显示名](https://raw.githubusercontent.com/Pinn32/img/refs/heads/main/blogs/fix-misplaced-sysfolders/fig25.png){#fig-modify-display-name style="width:22rem;"}

![显示名变成乱码](https://raw.githubusercontent.com/Pinn32/img/refs/heads/main/blogs/fix-misplaced-sysfolders/fig26.png){#fig-display-name-encode-error style="width:10rem;"}



查看未受影响的 `视频` 文件夹的 `desktop.ini`，发现其显示名称通过引用 `shell32.dll` 中的资源索引实现（格式为 `@%SystemRoot%\system32\shell32.dll,-XXXXX`），并非直接写入中文字符串。

!["视频"显示名信息来源](https://raw.githubusercontent.com/Pinn32/img/refs/heads/main/blogs/fix-misplaced-sysfolders/fig27.png){#fig-name-info-source style="width:22rem;"}



于是搜索 `shell32.dll` 中的名称资源编号。

![搜索 `shell.32` 名称资源](https://raw.githubusercontent.com/Pinn32/img/refs/heads/main/blogs/fix-misplaced-sysfolders/fig28.png){#fig-search-name-resource style="width:25rem;"}



搜索结果仅涉及图标资源，未找到名称编号。

![搜索结果: 对图标资源的讨论](https://raw.githubusercontent.com/Pinn32/img/refs/heads/main/blogs/fix-misplaced-sysfolders/fig29.png){#fig-search-result-icon-resource style="width:35rem;"}


转而向 AI 求助：

![求助AI](https://raw.githubusercontent.com/Pinn32/img/main/img/pic-go/20260615212707012.png){#fig-ask-ai style="width:35rem;"}

但 ChatGPT 给出的编号是虚构的。

![虚构答案](https://raw.githubusercontent.com/Pinn32/img/main/img/pic-go/20260615212844148.png){#fig-fake-answer style="width:35rem;"}

> 注：-21810 对应的是"链接"，并非"保存的游戏"。

我进一步询问如何查看 `shell32.dll` 内容，ChatGPT 推荐使用 Visual Studio。

![询问如何查看 `shell32.dll` 内容](https://raw.githubusercontent.com/Pinn32/img/main/img/pic-go/20260615213053253.png){#fig-ask-visual-studio style="width:35rem;"}

编程零基础的我，手滑下载成了 Visual Studio **Code**。这一误打误撞，让我第一次接触到了 IDE。后来课上老师发现我用 VSCode 写作业而非 Jupyter，追问原因，我掏出了这篇文章。

![VSCode 和 Visual Studio](https://raw.githubusercontent.com/Pinn32/img/main/img/pic-go/20260615215305385.png){#fig-vscode-and-visual-studio style="width:20rem;"}

按 ChatGPT 指示，在 Visual Studio 中新建解决方案，加载 `C:\Windows\System32\shell32.dll` 查看资源目录。

![AI 指示](https://raw.githubusercontent.com/Pinn32/img/main/img/pic-go/20260615215723081.png){#fig-ai-suggest style="width:40rem;"}

![Visual Studio 界面](https://raw.githubusercontent.com/Pinn32/img/main/img/pic-go/20260615215843231.png){#fig-vs-interface style="width:45rem;"}


但 Visual Studio 只能显示资源目录结构，无法直接确认条目编号，加之 `shell32.dll` 内容庞大，逐条查找并不现实。

最后想到一个办法：直接对照另一台未修改过的电脑上的 `desktop.ini` 内容。结果正确编号是 `-21814`，与之前试过的 `-21810` 仅差 4，再多试几次可能就找到了。

![对照别人电脑更改后](https://raw.githubusercontent.com/Pinn32/img/main/img/pic-go/20260615220143319.png){#fig-after-change style="width:25rem;"}

**"保存的游戏" —— 堂堂复活！**

![`保存的游戏` 复活](https://raw.githubusercontent.com/Pinn32/img/main/img/pic-go/20260615235720052.png){#fig-rebirth style="width:12rem;"}


现在图标与显示名称均恢复默认。

![默认图标恢复](https://raw.githubusercontent.com/Pinn32/img/main/img/pic-go/20260616000059488.png){#fig-default-icon style="width:25rem;"}

教训：迁移系统文件夹时，只修改路径中的盘符，不要将根目录直接设为目标路径。

![移动系统文件：只修改盘符](https://raw.githubusercontent.com/Pinn32/img/main/img/pic-go/20260616000208909.png){#fig-move-system-folder style="width:25rem;"}



# 总结

## 问题

Win10 系统文件夹（Shell Folders，如 `桌面`、`文档`、`图片`）被意外移动至磁盘根目录（如 `D:\`、`E:\`），如何恢复？

## 解决方法

1. **新建目标文件夹**（如 `E:\Users\UserName\Desktop\`）
2. **修改注册表**
   - 按 `Win + R` 输入 `regedit`
   - 导航至 `HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\User Shell Folders`
   - 找到数据值为磁盘根目录（如 `E:\`）的条目
   - 将其改为新建文件夹的路径（如 `E:\Users\UserName\Desktop\`）
   - 保存后重启电脑
3. **显示系统隐藏文件**
   - 打开目标文件夹
   - 进入 `文件 > 选项 > 查看`
   - 勾选 `⏺ 显示隐藏的文件、文件夹或驱动器`
   - 取消勾选 `◻ 隐藏受保护的操作系统文件`
4. **修改 `desktop.ini`**
   - 用记事本打开 `desktop.ini`
   - 填写 `IconResource` 和 `LocalizedResourceName` 项

```ini
[.ShellClassInfo]
LocalizedResourceName=@%SystemRoot%\system32\shell32.dll,<显示名称对应编号>
IconResource=%SystemRoot%\system32\imageres.dll,<图标对应编号>
<其他项...>
```

> 注：修改完成后，记得重新隐藏步骤 3 中显示的系统文件。


(未完)

## 系统文件夹对应资源表格

表1：图标对应资源  
表2：显示名称对应资源

> 注：也可以使用 `UTF-16 LE` 编码将中文字符直接写入 `LocalizedResourceName=` 字段（需先确认 `desktop.ini` 的实际编码格式），比查找 DLL 资源编号更便捷；若已有编号列表，直接复制使用亦可。
