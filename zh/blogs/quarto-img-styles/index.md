---
title: 'Quarto 图片居中样式'
author: 'Pinn Xu'
date: 2026-06-15
description: 'Quarto Website 图片居中样式探索与悬浮预览异常解决。'
categories: [Quarto, CSS, 电脑技巧, 解决方案]
image: "https://raw.githubusercontent.com/Pinn32/img/main/img/pic-go/20260615190606193.png"
---

<style>
figcaption {
    text-align: center;
}
</style>

# 图片大小控制

## 传统方法

在 Quarto Website 撰写过程中，最初，我通过 Quarto 内置的 width 属性控制图片大小：

```markdown
![图片标题](图片URL){#fig-title width="15%"}
```

这种方式简洁直观，无需额外编写 `style="width:15%"` 等行内样式，显示效果也较为理想。

![通过 width 百分比控制图片效果预览](https://raw.githubusercontent.com/Pinn32/img/main/img/pic-go/1.png){#fig-width-pct-preview style="width:35rem;"}

## 问题1：引用悬浮预览异常

在正文中使用交叉引用（如 `@fig-title`）后，我发现图片悬浮预览会继承 `width` 百分比设置，导致预览显示异常。

![问题1 - 悬浮预览异常](https://raw.githubusercontent.com/Pinn32/img/main/img/pic-go/20260615184737385.png){#fig-hover-error style="width:30rem;"}

为了解决这个问题，我尝试改用 `rem` 作为图片宽度单位，以兼顾页面缩放和悬浮预览。

首先尝试：

```markdown
![图片标题](图片URL){#fig-title width="7rem"}
```

但并未生效，因为 Quarto 的 width 属性不支持 rem 单位（支持 px、百分比等）。

随后改为：

```markdown
![图片标题](图片URL){#fig-title style="width:7rem;"}
```

## 问题2：图片无法居中

新的问题随之出现：图片不再居中，即使设置 `{fig-align="center"}` 也无效。

![问题2：图片不再居中显示](https://raw.githubusercontent.com/Pinn32/img/main/img/pic-go/20260615190316080.png){#fig-center-error style="width:35rem;"}


使用浏览器 `DevTools` 排查后发现，设置 `style="width:7rem"` 时，`Quarto` 会同步将父容器宽度限制为 `7rem`。

![父容器宽度限制](https://raw.githubusercontent.com/Pinn32/img/main/img/pic-go/20260615190502775.png){#fig-parent-width-limit style="width:35rem;"}

移除父容器宽度限制后，图片即可重新居中。

![去除父容器宽度限制后：恢复居中](https://raw.githubusercontent.com/Pinn32/img/main/img/pic-go/20260615190606193.png){#fig-remove-parent-width-limit style="width:35rem;"}

期间我还尝试过多种方案，例如：

```markdown
# 尝试1
:::{#fig-title width="100%"}
![](图片URL){style="width:7rem;"}
图片标题
:::

# 尝试2
:::{#fig-title style="width:100% !important;"}
![图片标题](图片URL){style="width:7rem;"}
:::

# 尝试3
:::{#fig-title style="text-align:center; width:100% !important;"}
![](图片URL){style="width:7rem;"}
图片标题
:::

# ...
```

但都未达到理想效果。

最终，我决定直接修改 css 样式，在 `style.css` 里添加了针对父容器的设置：

```css
.quarto-float.quarto-figure.quarto-figure-center.anchored {
    width: 100% !important;
}
```

再配合图片设置：

```markdown
![图片标题](图片URL){#fig-title style="width:7rem;"}
```

成功实现图片居中的同时，引用悬浮预览正常：

![实现居中](https://raw.githubusercontent.com/Pinn32/img/main/img/pic-go/20260615190729348.png){#fig-center-success style="width:30rem;"}

![实现悬浮正常](https://raw.githubusercontent.com/Pinn32/img/main/img/pic-go/20260615190756159.png){#fig-hover-success style="width:18rem;"}

# 图片和标题同时居中

解决图片居中后，图片标题仍然默认左对齐。

虽然 Quarto 提供了 `fig-cap-location` 属性，可将标题放置在 `top` 、 `bottom` 或 `margin` ，但无法控制标题对齐方式。

经过测试，最简单的方案是在图片样式中直接设置：

```markdown
# 方法1

![图片标题](图片URL){#fig-title style="text-align:center; width:7rem;"}
```

该方案无需额外容器，也无需拆分标题。

其他可行方案如下：

```markdown
# 方法2

:::{#fig-title fig-cap="此处写标题"}
![此处为空](图片URL){style="text-align:center; width:7rem;"}
:::

# 方法3

:::{#fig-title}
![此处为空](图片URL){style="text-align:center; width:7rem;"}
<注意此处必须空一行>
图片标题
:::
```

相比之下，方法1语法最简洁，代码高亮效果也最好；方法2和方法3不仅结构更复杂，还增加了额外的容器层级。

![语法高亮](https://raw.githubusercontent.com/Pinn32/img/main/img/pic-go/20260615190824762.png){#fig-syntax-highlight style="width:35rem;"}

如果希望当前页面所有图片标题均居中，则可直接添加 Internal CSS：

```markdown
<style>
figcaption {
		text-align: center;
}
</style>
```

对应图片写法保持不变：

```markdown
![图片标题](<图片URL>){#fig-title style="width:7rem;"}
```

# 总结

若希望在 Quarto Website 中实现：

- 使用 rem 控制图片宽度
- 交叉引用悬浮预览正常显示
- 图片居中
- 图片标题居中

可采用以下方案。


## 第一步：外部 CSS

```css
.quarto-float.quarto-figure.quarto-figure-center.anchored {
    width: 100% !important;
}
```

并在 _quarto.yml 中挂载：

```yaml
format:
	html:
		css:
			- path/to/style.css
```

## 第二步：页面级 Internal CSS

在页面最上方 (yaml块的下方) 添加 `<style>` 标签：

```markdown
<style>
figcaption {
		text-align: center;
}
</style>
```

## 第三步：图片行内样式

```markdown
![图a](URL){#fig-a style="width:20rem;"}
![图b](URL){#fig-b style="width:15rem;"}
```

---

本文即采用上述方案实现，点击页面右上角 `</> 代码` 可查看完整源代码。

