---
title: "Recovering Misplaced Windows Shell Folders"
author: 'Pinn Xu'
date: 2024-04-22
description: "Recovering Windows shell folders such as Documents, Videos, and Pictures after they were accidentally moved to the root of a drive."
# categories: [Windows, desktop.ini, Shell Folders, Computer Tips, Knowhow]
categories: [Windows, Shell Folders, Knowhow]
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

The [Takeaways](#takeaways) section presents the summary of the problem and the shortest path to a fix. The remainder of the article documents how I diagnosed the problem and worked through it.


# Takeaways {#takeaways}

## The Problem

A Windows 10 shell folder (e.g., `Desktop`, `Documents`, `Pictures` ) was accidentally moved to the root of a drive (e.g., `D:\`, `E:\`). How can it be recovered?

## The Fix

1. **Create the target folder** (e.g., `E:\Users\UserName\Videos\`).
2. **Edit the registry.**
   - Press `Win + R` and type `regedit`.
   - Go to `HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\User Shell Folders`.
   - Find the entry whose value is the drive root (e.g., `E:\`).
   - Change it to the path of the folder you just created (e.g., `E:\Users\UserName\Videos\`).
   - Save and restart the computer.
3. **Show hidden system files.**
   - Open the target folder.
   - Go to `File > Options > View`.
   - Check `⏺ Show hidden files, folders, and drives`.
   - Uncheck `◻ Hide protected operating system files`.
4. **Restore icon & display name.**
   - Find `desktop.ini` in the target folder, open it in Notepad.
   - Set the `IconResource` and `LocalizedResourceName` entries to the right resource index (listed in @tbl-shellfolder-resource).

```ini
[.ShellClassInfo]
LocalizedResourceName=@%SystemRoot%\system32\shell32.dll,<NameResource index>
IconResource=%SystemRoot%\system32\imageres.dll,<IconResource index>
<OtherEntries...>
```

> Once finished, remember to re-hide the system files revealed in step 3.


# The Problem: Moving a Shell Folder by Mistake

While cleaning up my C drive one day, I noticed that a batch of shell folders under `C:\Users\<username>` had not yet been moved to the E drive, so I decided to relocate them all at once.

![System Folders](https://raw.githubusercontent.com/Pinn32/img/main/img/pic-go/20260618163644834.png){#fig-sysfolders style="width:12rem;"}

Taking the *Saved Games* file as an example, I opened its `Properties` , and clicked `Location` tab. Then I changed its path from `C:\Users\Lenovo\Saved Games` to `E:\`, and clicked `Move`.

![Changing the Folder Location](https://raw.githubusercontent.com/Pinn32/img/main/img/pic-go/20260618164612644.png){#fig-relocate-folder style="width:24rem;"}


However, the Saved Games folder suddenly vanished. At that point I realized I had set the root of the E drive itself as the destination. I thus began searching for a fix, but the results were not what I expected — people are talking about games rather than Windows shell folders.

I then tried other shell folders as search terms: *Videos* (too common a word, yielding noisy results), *3D Objects* (a distinctive name, but obscure), *Desktop* (a special case whose fixes might not generalize), etc.


After a few attempts, I settled on a solution: editing the registry.

![The Fix: Editing the Registry](https://raw.githubusercontent.com/Pinn32/img/main/img/pic-go/20260619150258176.png){#fig-sol-modify-reg style="width:35rem;"}



# The Fix: Editing the Registry

The steps are as follows:

1. **Create the target folder `E:\Saved Games\` to hold the Saved Games folder where you want to move.**

2. **Press `Win + R` to open the Run dialog, type `regedit`, and open the Registry Editor.**

![Opening the Registry Editor](https://raw.githubusercontent.com/Pinn32/img/main/img/pic-go/20260618165301964.png){#fig-open-reg style="width:25rem;"}



3. **Locate and change the path.**  
   Go to:  
   `HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\User Shell Folders`
   
   Find the entry whose value is `E:\` and change it to `E:\Saved Games`.  
   (Be sure to create the folder before editing the registry.)

![Editing the Registry](https://raw.githubusercontent.com/Pinn32/img/refs/heads/main/blogs/fix-misplaced-sysfolders/fig7.png){#fig-modify-reg style="width:40rem;"}



4. **Restart and verify.**  
   After restarting your computer, press `Win + R` and type `shell:SavedGames`. If it opens `E:\Saved Games`, the recovery succeeded.

![Verifying the Registry Change](https://raw.githubusercontent.com/Pinn32/img/refs/heads/main/blogs/fix-misplaced-sysfolders/fig11.png){#fig-test-reg style="width:25rem;"}

![Jumping to Saved Games](https://raw.githubusercontent.com/Pinn32/img/refs/heads/main/blogs/fix-misplaced-sysfolders/fig12.png){#fig-jump-saved-games style="width:35rem;"}


**At this point the folder works again, but it still shows the default folder icon.**

## Restoring the Icon

[An article](https://www.digitalcitizen.life/where-find-most-windows-10s-native-icons/#How%20Are%20Windows%20Icons%20stored?){target="_blank"} was found explaining where Windows stores its system icons.

![Article: Where Windows Stores Icons](https://raw.githubusercontent.com/Pinn32/img/refs/heads/main/blogs/fix-misplaced-sysfolders/fig14.png){#fig-win-icon-loc style="width:35rem;"}


Through `Properties > Customize > Change Icon`, I found that the current icon source was `SHELL32.dll` . However, the *Saved Games* icon was not included there, suggesting that shell folder icons are stored across multiple DLL files.

:::{#fig-current-icon-loc layout-ncol=2}

![Properties > Customize > Change Icon](https://raw.githubusercontent.com/Pinn32/img/main/img/pic-go/20260618175423568.png){width="90%"}  

![Current Icon Location](https://raw.githubusercontent.com/Pinn32/img/refs/heads/main/blogs/fix-misplaced-sysfolders/fig15-2.png){width="90%"}

Current icon file: SHELL32.dll
:::


I went through the DLL files listed in [the article](https://www.digitalcitizen.life/where-find-most-windows-10s-native-icons/#How%20Are%20Windows%20Icons%20stored?) and eventually found the *Saved Games* icon in `imageres.dll`, along with the icons for *Desktop*, *Videos*, and others.

![Other System Files Containing Icons](https://raw.githubusercontent.com/Pinn32/img/refs/heads/main/blogs/fix-misplaced-sysfolders/fig-icon-dll.png){#fig-icon-dll style="width:20rem;"}

![Icon found in imageres.dll](https://raw.githubusercontent.com/Pinn32/img/refs/heads/main/blogs/fix-misplaced-sysfolders/fig17.png){#fig-imageres style="width:25rem;"}



Once the icon was linked to the correct resource, it's icon was restored. 

![Icon Restored](https://raw.githubusercontent.com/Pinn32/img/refs/heads/main/blogs/fix-misplaced-sysfolders/fig18.png){#fig-icon-recovered style="width:10rem;"}

On an English-language system, this completes the recovery. On other systems, the folder's localized display name may still need to be restored. For example, on Simplified Chinese systems, the folder should display `保存的游戏` while keeping the actual folder name `Saved Games`.


## Restoring a Localized Display Name {#localized-name}

Searching for how to make a folder's display name differ from its actual folder name, I found the following solution:

![Search Results](https://raw.githubusercontent.com/Pinn32/img/main/img/pic-go/20260619151015705.png){#fig-search-results style="width:30rem;"}


**Steps:**

1. Open the target folder in **File Explorer**.
2. Click the **View** tab on the toolbar of the File Explorer window.
3. Check the **Hidden items** box, then click **Options**.
4. Click the **View** tab.
5. **Uncheck "Hide protected operating system files"**, then click **Yes** and **OK** to confirm change.

![Show Hidden Items](https://raw.githubusercontent.com/Pinn32/img/main/img/pic-go/20260618160908267.png){#fig-show-hidden style="width:45rem;"}

![Unhide Protected Operating System Files](https://raw.githubusercontent.com/Pinn32/img/main/img/pic-go/20260618161338780.png){#fig-show-hidden-sysfiles style="width:25rem;"}


A `desktop.ini` file now appears inside the `Saved Games` folder.

![The desktop.ini File](https://raw.githubusercontent.com/Pinn32/img/refs/heads/main/blogs/fix-misplaced-sysfolders/fig23.png){#fig-desktop-ini style="width:35rem;"}


**Step 6: Open it in Notepad.**  
We can see the `IconResource` entry is pointing to `imageres.dll`, which is the icon we restored previously.

![Content of desktop.ini](https://raw.githubusercontent.com/Pinn32/img/main/img/pic-go/20260618162811351.png){#fig-desktop-ini-content style="width:22rem;"}


Following the guide, I added the following line to `desktop.ini` (@fig-modify-display-name):

```ini
LocalizedResourceName=保存的游戏
```

![Editing the Display Name](https://raw.githubusercontent.com/Pinn32/img/refs/heads/main/blogs/fix-misplaced-sysfolders/fig25.png){#fig-modify-display-name style="width:22rem;"}

After saving, however, the name appeared as garbled text (@fig-display-name-encode-error). English displayed correctly while the Chinese characters turned into mojibake, indicating that the file encoding was wrong.

![Display Name Turned into Mojibake](https://raw.githubusercontent.com/Pinn32/img/refs/heads/main/blogs/fix-misplaced-sysfolders/fig26.png){#fig-display-name-encode-error style="width:10rem;"}


### Method 1: Change the File Encoding^[Added June 16, 2026] {#method-1}

The bottom-right corner of Notepad showed the current encoding as `UTF-8`, but `desktop.ini` should be saved as `UTF-16 LE`.

![Notepad's Default Encoding Method](https://raw.githubusercontent.com/Pinn32/img/main/img/pic-go/20260617121023832.png){#fig-default-encoding style="width:25rem;"}

To avoid garbling the Chinese name, enter it and then click `File > Save As`.

![Save As](https://raw.githubusercontent.com/Pinn32/img/main/img/pic-go/20260618194335092.png){#fig-save-as style="width:30rem;"}

Set `Save as type` to `All Files (*.*)` and `Encoding` to `UTF-16 LE`, then save and overwrite the original file.

![Changing the Encoding Method](https://raw.githubusercontent.com/Pinn32/img/main/img/pic-go/20260618194954213.png){#fig-modify-encoding style="width:35rem;"}


A moment later, the display name was restored.

![Saved Games Restored](https://raw.githubusercontent.com/Pinn32/img/main/img/pic-go/20260618195203026.png){#fig-rebirth-0 style="width:12rem;"}



### Method 2: Reference a Resource Index

Instead of changing the encoding, you can also reference a resource index. The index points to a localized string inside `shell32.dll` file, which resolves to the display name according to your Windows display language.

For example, @fig-name-info-source shows the `LocalizedResourceName` entry in the original `desktop.ini` file of the *Videos* folder is pointing to the resource in `shell32.dll` with the index `-21791`.

![Where the Videos Display Name Comes From](https://raw.githubusercontent.com/Pinn32/img/refs/heads/main/blogs/fix-misplaced-sysfolders/fig27.png){#fig-name-info-source style="width:22rem;"}


I thus started to looking for name resource indices inside `shell32.dll` , but the results covered mainly icon resources instead of name resources.

Then, I turned to AI for help, but ChatGPT gave me fabricated answers <i class="bi bi-emoji-frown" style="color:var(--pf-primary)"></i>.

When I asked how to inspect the contents of `shell32.dll`, ChatGPT recommended **Visual Studio**.

![Asking How to Inspect shell32.dll](https://raw.githubusercontent.com/Pinn32/img/main/img/pic-go/20260619001643834.png){#fig-ask-visual-studio style="width:35rem;"}

With no programming background, I mistakenly downloaded Visual Studio **Code** instead. It became my first encounter with an IDE. Later, when my professor noticed I was doing assignments in VSCode rather than Jupyter and asked why, I just pulled up this article <i class="bi bi-emoji-wink" style="color:var(--pf-primary)"></i>.

![VSCode and Visual Studio](https://raw.githubusercontent.com/Pinn32/img/main/img/pic-go/20260615215305385.png){#fig-vscode-and-visual-studio style="width:15rem;"}

Following ChatGPT's instructions, I created a new solution in Visual Studio and loaded `C:\Windows\System32\shell32.dll` to view its resource directory.

![AI's Instructions](https://raw.githubusercontent.com/Pinn32/img/main/img/pic-go/20260619221622134.png){#fig-ai-suggest style="width:40rem;"}


![Interface of Visual Studio](https://raw.githubusercontent.com/Pinn32/img/main/img/pic-go/20260615215843231.png){#fig-vs-interface style="width:45rem;"}


Visual Studio showed only the structure of the resource directory, not the actual entry indices. Since `shell32.dll` is very large, checking every entry by hand was not realistic.

In the end, I compared the `desktop.ini` file with one from another computer that hadn't be modified. The correct resource index turned out to be `-21814` — just four numbers away from the `-21810` I had tried earlier. I might have found it with a few more guesses <i class="bi bi-emoji-grin" style="color:var(--pf-primary)"></i>.

I added the following line to the `desktop.ini` in the *Saved Games* folder:

```ini
LocalizedResourceName=@%SystemRoot%\system32\shell32.dll,-21814
```

![After the Change](https://raw.githubusercontent.com/Pinn32/img/main/img/pic-go/20260619222135645.png){#fig-after-change style="width:25rem;"}

> More resource indices of display names and icons for common shell folders are listed in @tbl-shellfolder-resource.

**Saved Games shell folder is finally fully restored!**

![Saved Games Restored](https://raw.githubusercontent.com/Pinn32/img/main/img/pic-go/20260619224046895.png){#fig-rebirth style="width:12rem;"}


So far, both the icon and the display name were restored to their defaults.

![Default Icon Restored](https://raw.githubusercontent.com/Pinn32/img/main/img/pic-go/20260619224305642.png){#fig-default-icon style="width:25rem;"}



**Lesson Learned: When moving a shell folder, change only the drive letter in the path. Do not set the bare root directory as the destination.**

![Moving a Shell Folder: Change Only the Drive Letter](https://raw.githubusercontent.com/Pinn32/img/main/img/pic-go/20260619224636448.png){#fig-move-system-folder style="width:25rem;"}



# Appendix: Resource Indices for Shell Folders {.unnumbered}

Use the **icon** resource index to restore a folder's icon (needed on every system):

```ini
IconResource=%SystemRoot%\system32\imageres.dll,<IconResource index>
```

If your Windows display language gives the folder a localized name (see [Restoring a Localized Display Name](#localized-name)), also set the **name** resource index. It points to a localized string in `shell32.dll`, so the same number resolves to whatever your system language is:

```ini
LocalizedResourceName=@%SystemRoot%\system32\shell32.dll,<NameResource index>
```

For example, for the *Pictures* folder:

```ini
LocalizedResourceName=@%SystemRoot%\system32\shell32.dll,-21779
IconResource=%SystemRoot%\system32\imageres.dll,-113
```

> Note: the display-name resources for *Contacts* and *3D Objects* come from other DLL files, not `shell32.dll` (see [Footnotes](#footnotes)).

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
| 联系人 (Contacts) | wab32res.dll, -10100^[The *Contacts* name resource comes from `@%CommonProgramFiles%\system\wab32res.dll,-10100`.] | -181 |
| 3D对象 (3D Objects) | windows.<wbr>storage.dll, -21825^[The *3D Objects* name resource comes from `@%SystemRoot%\system32\windows.storage.dll,-21825`.] | -198 |

: Resource Indices for Shell Folders {#tbl-shellfolder-resource tbl-colwidths=[35,35,30]}

[>> View More Original desktop.ini Contents](https://superuser.com/a/1172777){target="_blank"}