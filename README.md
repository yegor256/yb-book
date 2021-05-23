[![make](https://github.com/yegor256/huawei.cls/actions/workflows/make.yml/badge.svg)](https://github.com/yegor256/ybook/actions/workflows/make.yml)

First, [install it](https://en.wikibooks.org/wiki/LaTeX/Installing_Extra_Packages)
from [CTAN](https://ctan.org/pkg/ybook) 
and then use in the preamble:

```tex
\documentclass{ybook}
\renewcommand*\theauthor{Jeff Lebowski}
\renewcommand*\thevolume{1}
\renewcommand*\thetitle{New Book About OOP}
\begin{document}
Hello, world!
\end{document}
```

You can use this class for your own book format too.

If you want to contribute yourself, make a fork, then create a branch, 
then run `make` in the root directory.
It should compile everything without errors. If not, submit an issue and wait.
Otherwise, make your changes and then run `make` again. If the build is
still clean, submit a pull request.
