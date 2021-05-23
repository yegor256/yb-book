% (The MIT License)
%
% Copyright (c) 2021 Yegor Bugayenko
%
% Permission is hereby granted, free of charge, to any person obtaining a copy
% of this software and associated documentation files (the 'Software'), to deal
% in the Software without restriction, including without limitation the rights
% to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
% copies of the Software, and to permit persons to whom the Software is
% furnished to do so, subject to the following conditions:
%
% The above copyright notice and this permission notice shall be included in all
% copies or substantial portions of the Software.
%
% THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
% IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
% FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
% AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
% LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
% OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
% SOFTWARE.

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{ybook}[00.00.0000 0.0.0 The Template for yb-Branded Books]

\LoadClass{article}

\RequirePackage[absolute]{textpos}
\RequirePackage{tikz}
  \usetikzlibrary{shapes}
  \usetikzlibrary{positioning}
\RequirePackage{calc}
\RequirePackage{anyfontsize}
\RequirePackage{graphicx}
\RequirePackage{xifthen}
\RequirePackage{shellesc}
\RequirePackage{etoolbox}

\makeatletter\newcommand\exec[2][1=]{%
  \begingroup
  \let\%\@percentchar
  \let\{\@charlb
  \let\}\@charrb
  \ShellEscape{#2 > target/exec.tex}%
  \endgroup%
  \ifthenelse{\isempty{#1}}{\input{target/exec.tex}}{}%
}\makeatother
\makeatletter\let\primitiveinput\@@input\makeatother
\exec[noprint]{qpdf --show-npages target/book.pdf | tr -d '[[:space:]]' | \{ cat; echo \%; \}}
\newcommand{\totalpages}{\primitiveinput target/exec.tex }
% The height of the page is 9 inches plus 0.125 "bleed" on top and
% on the bottom.
% Check this doc: https://kdp.amazon.com/en_US/help/topic/G201953020
\newlength{\ybpageheight}
\setlength{\ybpageheight}{0.125in + 9in + 0.125in}
% The width is 6 inches plus 0.125 "bleed" on each side. The width of the
% "spine" depends on the amount of pages in the book. Also, there is a
%
\newlength{\ybpagewidth}
\setlength{\ybpagewidth}{0.125in + 6in + 0.0025in * \totalpages + 6in + 0.125in}
\RequirePackage[paperwidth=\ybpagewidth,paperheight=\ybpageheight,left=0pt,right=0pt,top=0pt,bottom=0pt]{geometry}
\setlength{\parindent}{0pt}
\setlength{\parskip}{0pt}
\AtBeginDocument{%
  \TPGrid{16}{16}\ttfamily
  \begin{textblock}{2.4}[0.5,0](8,0)
    \begin{tikzpicture}
      \node [rectangle, inner sep=0em, fill=black, minimum width=2.4\TPHorizModule, minimum height=16\TPVertModule] at (0,0) {};
    \end{tikzpicture}
  \end{textblock}
  \begin{textblock}{2.4}[0.5,1](8,14)
    \centerline{\includegraphics[width=0.32in]{/code/books/images/signature}}
  \end{textblock}
  \begin{textblock}{1}[0.5,0](8,2)
    \begin{tikzpicture}
      \node [color=white, inner sep=0cm, outer sep=0cm, rotate=270, minimum height=\TPHorizModule] at (0,0) {
        \textbf{\Large \ybspinetext}
      };
    \end{tikzpicture}
  \end{textblock}
  \begin{textblock}{5}(10,9)
    \fontsize{32}{32}\selectfont\textbf{\thetitle}
  \end{textblock}
  \begin{textblock}{4}(10,10)
    \large\textbf{by Yegor Bugayenko}
  \end{textblock}
  \begin{textblock}{5}(10,11)
    \raggedright
    TL;DR \thetldr{}
  \end{textblock}
  \begin{textblock}{4}[0,1](10,14)
    \theversion{}
    \quad
    \exec[]{git log -n 1 --pretty='format:\%ad' --date='format:\%e-\%b-\%Y'}
  \end{textblock}
  \begin{textblock}{4}[0,1](1,14)
    \small (c)
    \ifdefempty{\theyear{}}{}{\theyear{}-}\the\year{} \theauthor{}
  \end{textblock}
  \begin{textblock}{4}[0,1](1,2)
    \small \$40.96
  \end{textblock}
  \ifdefempty{\thevolume}{}{
    \begin{textblock}{2}[1,1](15,14)
      \raggedleft
      \includegraphics[height=0.4in]{images/volume-\thevolume}
    \end{textblock}
  }
  \begin{textblock}{4}(10,2)
    \includegraphics[width=\textwidth]{\theimage{}}
  \end{textblock}
}

\endinput
