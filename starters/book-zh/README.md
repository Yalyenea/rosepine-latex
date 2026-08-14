# ++PROJECT-TITLE-ZH++

Rose Pine 中文书脚手架（`ctexbook` + XeLaTeX）。

## 依赖

- `latexmk`, `xelatex`
- 字体：Latin Modern Roman、STZhongsong

## 编译

```bash
just build
# PDF: build/main.pdf
```

## 结构

- 真源：`manuscript/`
- 主题：`manuscript/rosepine/`（工厂 `rosepine/` 快照，独立演进）
- 产物：建议 `build/`（自行维护）

生成后请改封面字段（`main.tex` 中 `\Cover*`）与章节内容。
