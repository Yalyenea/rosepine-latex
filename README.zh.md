# rosepine-latex

[Rosé Pine Dawn](https://rosepinetheme.com) 的 XeLaTeX / pdfLaTeX 模板。

[English](README.md)

英文用 **pdfLaTeX**，中文用 **XeLaTeX**。

```bash
git clone git@github.com:Yalyenea/rosepine-latex.git
cd rosepine-latex
just book ~/Projects/my-book zh
cd ~/Projects/my-book && just build
```

`DEST` 是新工程目录（相对当前目录，或绝对路径）。然后 `cd DEST && just build`。

| 命令 | 默认 | 种类 | 写这里 |
|------|------|------|--------|
| `just book DEST [zh\|en]` | `zh` | 书 | `manuscript/chapters/` |
| `just thesis DEST [zh\|en]` | `zh` | 学位论文 | `manuscript/chapters/` |
| `just paper DEST [bi\|en\|zh]` | `bi` | 论文 | `inputs/` / `inputs_zh/` |
| `just slide DEST [zh\|en]` | `zh` | 16:9 幻灯 | `frames/` |
| `just notes DEST [zh\|en]` | `zh` | 讲义 | `lectures/` |
| `just handout DEST [zh\|en]` | `zh` | 4 合 1 | `frames/` |
| `just exercises DEST [zh\|en]` | `zh` | 习题 | `problems/` |
| `just poster DEST [zh\|en]` | `zh` | A0 海报（默认横版） | `main.tex` |

中英书各建一个工程。海报竖版：在 `\input{preamble}` 之前写 `\posterlandscapefalse`。

## 结构

本仓库是工厂。`just <种类> DEST` 把对应 starter 拷到 `DEST` 并填好标题。

```
rosepine-latex/
  rosepine/           共享主题
  starters/           每种 × 每种语言一份
  scripts/scaffold.sh 上面那些 just 配方会调用
  docs/previews/      README 里的预览图
  justfile            just book / thesis / paper / …
```

| 路径 | 作用 |
|------|------|
| `rosepine/` | 共享主题，只在这里改 |
| `starters/book-en`、`book-zh` | 书 |
| `starters/thesis-en`、`thesis-zh` | 学位论文 |
| `starters/paper` | 论文（`bi` 中英都留） |
| `starters/slide-*` | 16:9 Beamer |
| `starters/notes-*` | 讲义 |
| `starters/handout-*` | 同一套 `frames/`，A4 四合一 |
| `starters/exercises-*` | 习题 |
| `starters/poster-*` | A0 海报 |
| `docs/previews/` | 下面那些首页图 |

`just book DEST` 会拷一份 starter，并写入 `rosepine/`。新工程里有 `justfile`、`preamble.tex` 和 `just build`。标题和作者在 `main.tex`。

```
# 书 / 学位论文
manuscript/main.tex          封面字段（学位论文还有学校、学位、导师）
manuscript/chapters.tex      章节清单
manuscript/chapters/         在这里写章
manuscript/refs.bib          学位论文参考文献
manuscript/imgs/
build/main.pdf               just build 之后

# 论文
main.tex / main_zh.tex       英文 / 中文入口
inputs/ / inputs_zh/         各节
refs.bib
build/<目录>-en.pdf          just build-en
build/<目录>-zh.pdf          just build-zh

# 幻灯 / 4 合 1
frames/                      一页一个文件
imgs/

# 讲义
lectures/

# 习题
problems/                    一份作业一个文件

# 海报
main.tex                     顶栏和 posterbox
imgs/
```

## 预览

| | 中文 | 英文 |
|---|:---:|:---:|
| 书 | <img src="docs/previews/book-zh.png" width="260" alt="中文书"> | <img src="docs/previews/book-en.png" width="260" alt="英文书"> |
| 学位论文 | <img src="docs/previews/thesis-zh.png" width="260" alt="中文学位论文"> | <img src="docs/previews/thesis-en.png" width="260" alt="英文学位论文"> |
| 论文 | <img src="docs/previews/paper-zh.png" width="260" alt="中文论文"> | <img src="docs/previews/paper-en.png" width="260" alt="英文论文"> |
| 幻灯 | <img src="docs/previews/slide-zh-1.png" width="260" alt="中文幻灯"> | <img src="docs/previews/slide-en-1.png" width="260" alt="英文幻灯"> |
| 讲义 | <img src="docs/previews/notes-zh.png" width="260" alt="中文讲义"> | <img src="docs/previews/notes-en.png" width="260" alt="英文讲义"> |
| 4 合 1 | <img src="docs/previews/handout-zh.png" width="260" alt="中文手出"> | <img src="docs/previews/handout-en.png" width="260" alt="英文手出"> |
| 习题 | <img src="docs/previews/exercises-zh.png" width="260" alt="中文习题"> | <img src="docs/previews/exercises-en.png" width="260" alt="英文习题"> |
| 海报 | <img src="docs/previews/poster-zh.png" width="260" alt="中文海报"> | <img src="docs/previews/poster-en.png" width="260" alt="英文海报"> |

## 依赖

- [`just`](https://github.com/casey/just)、`latexmk`、TeX Live
- 英文：pdfLaTeX，Latin Modern（`lmodern`）
- 中文：XeLaTeX，本机 **STZhongsong**（华文中宋）

MIT。配色：[Rosé Pine Dawn](https://rosepinetheme.com)。
