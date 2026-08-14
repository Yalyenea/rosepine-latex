# rosepine-latex

Rose Pine Dawn · XeLaTeX。clone 一次，开新工程一条命令。

```bash
git clone git@github.com:Yalyenea/rosepine-latex.git
cd rosepine-latex
just book ~/Projects/my-book zh
cd ~/Projects/my-book && just build
```

`DEST` 是新工程目录（相对当前目录，或绝对路径）。

| 命令 | 默认 | 说明 |
|------|------|------|
| `just book DEST [zh\|en]` | `zh` | 书 |
| `just paper DEST [bi\|en\|zh]` | `bi` | 论文 |
| `just slide DEST [zh\|en]` | `zh` | 16:9 幻灯 |
| `just notes DEST [zh\|en]` | `zh` | 讲义 |
| `just handout DEST [zh\|en]` | `zh` | 4 合 1 |
| `just exercises DEST [zh\|en]` | `zh` | 习题 |
| `just poster DEST [zh\|en]` | `zh` | A0 海报（默认横版） |

```bash
just              # 列表
just sync-theme   # 把 rosepine/ 同步进各 starter
just test
```

生成后改标题、作者，写正文。`just build` 把中间文件放在 `.tmp/`，PDF 放在 `build/`。  
中英书各建一个工程。海报竖版：在 `\input{preamble}` 之前写 `\posterlandscapefalse`。

引擎 XeLaTeX。字体：Latin Modern Roman；中文需本机 **STZhongsong**（华文中宋）。另需 `just`、`latexmk`。

MIT. 配色：[Rosé Pine Dawn](https://rosepinetheme.com).
