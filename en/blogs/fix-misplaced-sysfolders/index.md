---
title: "[未完] Recovering Misplaced Windows Shell Folders"
author: 'Pinn Xu'
date: 2024-04-22
description: "Recovering Windows shell folders such as Documents, Videos, and Pictures after they were accidentally moved to the root of a drive."
categories: [Windows, desktop.ini, Powershell, PC tips, Solutions]
image: "https://raw.githubusercontent.com/Pinn32/img/main/img/pic-go/20260615210515071.png"
# toc-expand: true
# toc-expand-level: 2
number-depth: 2
---

<style>
figcaption {
   text-align: center;
}
</style>


# Preface

This was the first extended troubleshooting write-up I kept in Notion, and it marked the start of my habit of documenting how I solve problems, both to share and to reference later.

The write-up prompted me to adopt Notion much more often as a regular tool. Investigating this particular problem also introduced me to VSCode, my first encounter with an IDE, and it is where my interest in programming began.

The [Summary](#summary) presents the key takeaways and the shortest path to a fix. The remainder of the article documents how I diagnosed the problem and worked through it.


# Summary {#summary}

## The Problem

A Windows 10 shell folder (such as Desktop, Documents, or Pictures) was accidentally moved to the root of a drive (such as `D:\` or `E:\`). How can it be recovered?

## The Fix

1. **Create the target folder** (for example `E:\Users\UserName\Videos\`).
2. **Edit the registry.**
   - Press `Win + R` and type `regedit`.
   - Go to `HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\User Shell Folders`.
   - Find the entry whose value is the drive root (such as `E:\`).
   - Change it to the path of the folder you just created (such as `E:\Users\UserName\Videos\`).
   - Save and restart the computer.

   > On an English‑language system the folder now works again and already shows its correct name; only the icon still needs restoring. (If your Windows display language gives the folder a localized name that differs from its English folder name, also see [Restoring a Localized Display Name - Method 1](#localized-name).)
3. **Show hidden system files.**
   - Open the target folder.
   - Go to `File > Options > View`.
   - Check `⏺ Show hidden files, folders, and drives`.
   - Uncheck `◻ Hide protected operating system files`.
4. **Restore the icon in `desktop.ini`.**
   - Open `desktop.ini` in Notepad.
   - Set the `IconResource` entry to the right resource index (listed in @tbl-shellfolder-resource).

   ```ini
   [.ShellClassInfo]
   IconResource=%SystemRoot%\system32\imageres.dll,<IconResource index>
   <OtherEntries...>
   ```

   > Note: once finished, remember to re-hide the system files revealed in step 3.


# The Problem: Moving a Shell Folder by Mistake

While cleaning up my C drive one day, I noticed that a batch of shell folders under `C:\Users\<username>` had not yet been moved to the E drive, so I decided to relocate them all at once.

![System folders](https://raw.githubusercontent.com/Pinn32/img/refs/heads/main/blogs/fix-misplaced-sysfolders/fig1.png){#fig-sysfolders style="width:8rem;"}


I opened `Properties > Location` for the Saved Games folder, changed the path from `C:\Users\Lenovo\Saved Games` to `E:\`, and clicked `Move`.

![Changing the folder location](https://raw.githubusercontent.com/Pinn32/img/refs/heads/main/blogs/fix-misplaced-sysfolders/fig2.png){#fig-relocate-folder style="width:24rem;"}


The Saved Games folder promptly vanished. At that point I realized I had set the root of the E drive itself as the destination. I began searching for a fix, but the results were not what I expected.

![Searching for a fix](https://raw.githubusercontent.com/Pinn32/img/refs/heads/main/blogs/fix-misplaced-sysfolders/fig3.png){#fig-search-sol style="width:35rem;"}



I then tried other shell folders as search terms: Videos (too common a word, yielding noisy results), 3D Objects (a distinctive name, but obscure), Desktop (a special case whose fixes might not generalize), and so on.

![Searching with other shell folders](https://raw.githubusercontent.com/Pinn32/img/refs/heads/main/blogs/fix-misplaced-sysfolders/fig4.png){#fig-search-other-sysfolders style="width:35rem;"} 



After a few attempts, I settled on a solution: editing the registry.

![The fix: editing the registry](https://raw.githubusercontent.com/Pinn32/img/refs/heads/main/blogs/fix-misplaced-sysfolders/fig5.png){#fig-sol-modify-reg style="width:35rem;"}



# The Fix: Editing the Registry

The steps are as follows:

1. **On the E drive, create the target folder `E:\Saved Games` to hold the Saved Games folder.**

2. **Press `Win + R` to open the Run dialog, type `regedit`, and open the Registry Editor.**

![Opening the registry](https://raw.githubusercontent.com/Pinn32/img/refs/heads/main/blogs/fix-misplaced-sysfolders/fig6.png){#fig-open-reg style="width:25rem;"}



3. **Locate and change the path.**  
   Go to:  
   `HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\User Shell Folders`  
   (Note: it's **User Shell Folders**, not Shell Folders.)  
   
   Find the entry whose value is `E:\` and change it to `E:\Saved Games`.  
   (Be sure to create the folder before editing the registry.)

![Editing the registry](https://raw.githubusercontent.com/Pinn32/img/refs/heads/main/blogs/fix-misplaced-sysfolders/fig7.png){#fig-modify-reg style="width:40rem;"}



4. **Restart and verify.**  
   After restarting, press `Win + R` and type `shell:SavedGames`. If it opens `E:\Saved Games`, the recovery succeeded.

![Verifying the registry change](https://raw.githubusercontent.com/Pinn32/img/refs/heads/main/blogs/fix-misplaced-sysfolders/fig11.png){#fig-test-reg style="width:25rem;"}

![Jumping to Saved Games](https://raw.githubusercontent.com/Pinn32/img/refs/heads/main/blogs/fix-misplaced-sysfolders/fig12.png){#fig-jump-saved-games style="width:35rem;"}


**At this point the folder works again, but it still shows the default icon (see @fig-sysfolders). On an English‑language system the name already displays correctly, so only the icon needs restoring; the next step covers that.**

> On a system whose display language gives the folder a localized name that differs from its English folder name — the author's Chinese system showed `保存的游戏` — that localized name is also lost. Restoring it is covered in [Restoring a Localized Display Name](#localized-name).



## Restoring the Icon

I first attempted to change the folder icon manually.

![Searching for the icon](https://raw.githubusercontent.com/Pinn32/img/refs/heads/main/blogs/fix-misplaced-sysfolders/fig13.png){#fig-search-fodler-icon style="width:40rem;"}



I found [an article](https://www.digitalcitizen.life/where-find-most-windows-10s-native-icons/#How%20Are%20Windows%20Icons%20stored?) explaining where Windows stores its system icons.

![Article: where Windows stores icons](https://raw.githubusercontent.com/Pinn32/img/refs/heads/main/blogs/fix-misplaced-sysfolders/fig14.png){#fig-win-icon-loc style="width:35rem;"}



Through `Properties > Customize > Change Icon`, I saw that the current icon came from `SHELL32.dll`, but that file did not contain the Saved Games icon. The icons are evidently distributed across other DLLs as well.

:::{#fig-current-icon-loc layout-ncol=2}

![Properties > Customize > Change Icon](https://raw.githubusercontent.com/Pinn32/img/refs/heads/main/blogs/fix-misplaced-sysfolders/fig15-1.png){width="85%"}  

![Current icon location](https://raw.githubusercontent.com/Pinn32/img/refs/heads/main/blogs/fix-misplaced-sysfolders/fig15-2.png){width="85%"}

Current icon file: SHELL32.dll
:::


Working through the DLLs the [article](https://www.digitalcitizen.life/where-find-most-windows-10s-native-icons/#How%20Are%20Windows%20Icons%20stored?) listed, one by one, I eventually located the Saved Games icon in `imageres.dll`, along with the icons for Desktop, Videos, and others.

![Other system files that contain icons](https://raw.githubusercontent.com/Pinn32/img/refs/heads/main/blogs/fix-misplaced-sysfolders/fig-icon-dll.png){#fig-icon-dll style="width:20rem;"}

![Icon found in imageres.dll](https://raw.githubusercontent.com/Pinn32/img/refs/heads/main/blogs/fix-misplaced-sysfolders/fig17.png){#fig-imageres style="width:25rem;"}



Once I pointed the icon at the correct resource, it displayed properly again. On an English‑language system this completes the recovery. (The author's Chinese system still showed the wrong name; restoring a localized display name is covered [below](#localized-name).)

![Icon restored](https://raw.githubusercontent.com/Pinn32/img/refs/heads/main/blogs/fix-misplaced-sysfolders/fig18.png){#fig-icon-recovered style="width:10rem;"}



## Restoring a Localized Display Name {#localized-name}

> **English‑language systems can skip this section.** After the registry fix the folder already shows its correct English name. The rest applies only when your Windows display language gives the folder a localized name that differs from its English folder name — for example the author's Chinese system, where the folder should read `保存的游戏` rather than `Saved Games`.

Searching for how to make a folder's display name differ from its actual (folder) name, I found the following:

:::{#fig-search-results layout-nrow=2}

![Search results](https://raw.githubusercontent.com/Pinn32/img/refs/heads/main/blogs/fix-misplaced-sysfolders/fig19-1.png){width="60%"}

![Search results: details](https://raw.githubusercontent.com/Pinn32/img/refs/heads/main/blogs/fix-misplaced-sysfolders/fig19-2.png){width="60%"}

Search results: making the display name differ from the folder name

:::



**Steps:**

1. **Check "Show hidden items"**, then click **Options**.
2. Click the **View** tab.
3. **Uncheck "Hide protected operating system files"**, then click **Yes**.

![Show hidden items](https://raw.githubusercontent.com/Pinn32/img/refs/heads/main/blogs/fix-misplaced-sysfolders/fig20.png){#fig-show-hidden style="width:45rem;"}


![Unhide protected operating system files](https://raw.githubusercontent.com/Pinn32/img/refs/heads/main/blogs/fix-misplaced-sysfolders/fig21.png){#fig-show-hidden-sysfiles style="width:25rem;"}

![Confirm](https://raw.githubusercontent.com/Pinn32/img/refs/heads/main/blogs/fix-misplaced-sysfolders/fig22.png){#fig-confirm style="width:35rem;"}



A `desktop.ini` file now appears inside the `Saved Games` folder.

![The desktop.ini file](https://raw.githubusercontent.com/Pinn32/img/refs/heads/main/blogs/fix-misplaced-sysfolders/fig23.png){#fig-desktop-ini style="width:35rem;"}



Opening it in Notepad, I saw that the `IconResource` entry already pointed to `imageres.dll`, the icon I had just restored.

![Inside desktop.ini](https://raw.githubusercontent.com/Pinn32/img/refs/heads/main/blogs/fix-misplaced-sysfolders/fig24.png){#fig-desktop-ini-content style="width:22rem;"}



Following the guide, I added the following line to `desktop.ini` (@fig-modify-display-name):

```ini
LocalizedResourceName=保存的游戏
```
 
After saving, however, the name appeared as garbled text (@fig-display-name-encode-error). English displayed correctly while the Chinese characters turned into mojibake, indicating that the file encoding was wrong.

![Editing the display name](https://raw.githubusercontent.com/Pinn32/img/refs/heads/main/blogs/fix-misplaced-sysfolders/fig25.png){#fig-modify-display-name style="width:22rem;"}

![Display name turned into mojibake](https://raw.githubusercontent.com/Pinn32/img/refs/heads/main/blogs/fix-misplaced-sysfolders/fig26.png){#fig-display-name-encode-error style="width:10rem;"}


### Method 1: Change the File Encoding^[Added 2026-06-16] {#method1}

The bottom-right corner of Notepad showed the current encoding as `UTF-8`, but `desktop.ini` should be saved as `UTF-16 LE`.

![Notepad's default encoding](https://raw.githubusercontent.com/Pinn32/img/main/img/pic-go/20260617121023832.png){#fig-default-encoding style="width:25rem;"}

To avoid garbling the Chinese name, enter it and then click `File > Save As`.

![Save As](https://raw.githubusercontent.com/Pinn32/img/main/img/pic-go/20260617134348580.png){#fig-save-as style="width:30rem;"}

Set `Save as type` to `All Files (*.*)` and `Encoding` to `UTF-16 LE`, then save over the original file.

![Changing the encoding](https://raw.githubusercontent.com/Pinn32/img/main/img/pic-go/20260617134443109.png){#fig-modify-encoding style="width:35rem;"}

After a moment, the name was restored.

![Saved Games is back](https://raw.githubusercontent.com/Pinn32/img/main/img/pic-go/20260615235720052.png){#fig-rebirth-0 style="width:12rem;"}



### Method 2: Reference a Resource Index

Instead of changing the encoding, you can reference a resource index. Because the index points to a localized string inside `shell32.dll`, the same number resolves to whatever your Windows display language is — it gives `Saved Games` on English system and `保存的游戏` on Simplified Chinese system. This is the portable way to restore the correct localized name in any language. ([see reference](https://superuser.com/a/1172777))

Looking at the `desktop.ini` of the still-intact Videos folder, I saw that its display name was not a literal Chinese string. Instead, it referenced a resource index in `shell32.dll` (in the form `@%SystemRoot%\system32\shell32.dll,-XXXXX`).

![Where the Videos display name comes from](https://raw.githubusercontent.com/Pinn32/img/refs/heads/main/blogs/fix-misplaced-sysfolders/fig27.png){#fig-name-info-source style="width:22rem;"}



I then went looking for the name resource indices inside `shell32.dll`.

![Searching for shell32 name resources](https://raw.githubusercontent.com/Pinn32/img/refs/heads/main/blogs/fix-misplaced-sysfolders/fig28.png){#fig-search-name-resource style="width:25rem;"}



The results, however, covered only icon resources, not name numbers.

![Search results: discussion of icon resources](https://raw.githubusercontent.com/Pinn32/img/refs/heads/main/blogs/fix-misplaced-sysfolders/fig29.png){#fig-search-result-icon-resource style="width:35rem;"}


I then turned to AI for help:

![Asking AI](https://raw.githubusercontent.com/Pinn32/img/main/img/pic-go/20260615212707012.png){#fig-ask-ai style="width:35rem;"}

The number ChatGPT provided, however, was fabricated.

![A made-up answer](https://raw.githubusercontent.com/Pinn32/img/main/img/pic-go/20260615212844148.png){#fig-fake-answer style="width:35rem;"}

> Note: -21810 is actually "链接" (Links), not "保存的游戏" (Saved Games).

When I asked how to inspect the contents of `shell32.dll`, ChatGPT recommended Visual Studio.

![Asking how to inspect shell32.dll](https://raw.githubusercontent.com/Pinn32/img/main/img/pic-go/20260615213053253.png){#fig-ask-visual-studio style="width:35rem;"}

Having no programming background, I mistakenly downloaded Visual Studio **Code** instead. That fortunate accident was my first encounter with an IDE. Later, when my professor noticed I was doing assignments in VSCode rather than Jupyter and asked why, I just pulled up this article <i class="bi bi-emoji-wink" style="color:var(--pf-primary)"></i>.

![VSCode and Visual Studio](https://raw.githubusercontent.com/Pinn32/img/main/img/pic-go/20260615215305385.png){#fig-vscode-and-visual-studio style="width:20rem;"}

Following ChatGPT's instructions, I created a new solution in Visual Studio and loaded `C:\Windows\System32\shell32.dll` to view its resource directory.

![AI's instructions](https://raw.githubusercontent.com/Pinn32/img/main/img/pic-go/20260615215723081.png){#fig-ai-suggest style="width:40rem;"}

![The Visual Studio interface](https://raw.githubusercontent.com/Pinn32/img/main/img/pic-go/20260615215843231.png){#fig-vs-interface style="width:45rem;"}


Visual Studio showed only the structure of the resource directory, not the actual entry numbers. Because `shell32.dll` is very large, checking every entry by hand was not realistic.

In the end, I compared against the `desktop.ini` on another computer I had not modified. The correct number turned out to be `-21814`, only 4 away from the `-21810` I had tried earlier; a few more guesses and I might have found it.

I added the following line to the `desktop.ini` in the Saved Games folder:

```ini
LocalizedResourceName=@%SystemRoot%\system32\shell32.dll,-21814
```

![After comparing with another computer](https://raw.githubusercontent.com/Pinn32/img/main/img/pic-go/20260615220143319.png){#fig-after-change style="width:25rem;"}

The resource indices of display names and icons for common shell folders are listed in @tbl-shellfolder-resource.


**Saved Games shell folder restored!**

![Saved Games is back](https://raw.githubusercontent.com/Pinn32/img/main/img/pic-go/20260615235720052.png){#fig-rebirth style="width:12rem;"}


With that, both the icon and the display name were restored to their defaults.

![Default icon restored](https://raw.githubusercontent.com/Pinn32/img/main/img/pic-go/20260616000059488.png){#fig-default-icon style="width:25rem;"}

**Lesson learned: when moving a shell folder, change only the drive letter in the path. Do not set the bare root directory as the destination.**

![Moving a shell folder: change only the drive letter](https://raw.githubusercontent.com/Pinn32/img/main/img/pic-go/20260616000208909.png){#fig-move-system-folder style="width:25rem;"}



# Appendix: Resource Numbers for Shell Folders {.unnumbered}

Use the **icon** resource index to restore a folder's icon (needed on every system):

```ini
IconResource=%SystemRoot%\system32\imageres.dll,<IconResource index>
```

If your Windows display language gives the folder a localized name (see [Restoring a Localized Display Name](#localized-name)), also set the **name** resource index. It points to a localized string in `shell32.dll`, so the same number resolves to whatever your system language is:

```ini
LocalizedResourceName=@%SystemRoot%\system32\shell32.dll,<NameResource index>
```

For example, for the Pictures folder:

```ini
LocalizedResourceName=@%SystemRoot%\system32\shell32.dll,-21779
IconResource=%SystemRoot%\system32\imageres.dll,-113
```

> Note: the display-name resources for Contacts and 3D Objects come from other DLL files, not `shell32.dll`.

| Folder | Name Resource Indices^[Unless marked otherwise, name resources come from `@%SystemRoot%\system32\shell32.dll,<index>`.] | Icon Resource Indices^[Icon resources come from `%SystemRoot%\system32\imageres.dll,<index>`.] |
| :----: | :------: | :------: |
| 桌面 (Desktop) | -21769 | -183 |
| 文档 (Documents) | -21770 | -112 |
| 图片 (Pictures) | -21779 | -113 |
| 音乐 (Music) | -21790 | -108 |
| 视频 (Videos) | -21791 | -189 |
| 下载 (Downloads) | -21798 | -184 |
| 搜索 (Searches) | -9031 | -18 |
| 链接 (Links) | -21810 | -185 |
| 收藏夹 (Favorites) | -21796 | -115 |
| 保存的游戏 (Saved Games) | -21814 | -177 |
| 联系人 (Contacts) | wab32res.dll,-10100^[The Contacts name resource comes from `@%CommonProgramFiles%\system\wab32res.dll,-10100`.] | -181 |
| 3D对象 (3D Objects) | windows.storage.dll,-21825^[The 3D Objects name resource comes from `@%SystemRoot%\system32\windows.storage.dll,-21825`.] | -198 |

: Resource indices for shell folders {#tbl-shellfolder-resource tbl-colwidths=[30,35,35]}
