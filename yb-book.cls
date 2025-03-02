%%
%% This is file `yb-book.cls',
%% generated with the docstrip utility.
%%
%% The original source files were:
%%
%% yb-book.dtx  (with options: `class')
%% (The MIT License)
%% 
%% Copyright (c) 2021-2025 Yegor Bugayenko
%% 
%% Permission is hereby granted, free of charge, to any person obtaining a copy
%% of this software and associated documentation files (the 'Software'), to deal
%% in the Software without restriction, including without limitation the rights
%% to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
%% copies of the Software, and to permit persons to whom the Software is
%% furnished to do so, subject to the following conditions:
%% 
%% The above copyright notice and this permission notice shall be included in all
%% copies or substantial portions of the Software.
%% 
%% THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
%% IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
%% FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
%% AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
%% LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
%% OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
%% SOFTWARE.

%%% \CheckSum{0}


\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{yb-book}
[2025/03/02 06.57.34 YB Branded Book Style]





















\RequirePackage{pgfopts}
\pgfkeys{
  /yb/.cd,
  apa/.store in=\yb@apa,
  authordraft/.store in=\yb@authordraft,
  compact/.store in=\yb@compact,
  manuscript/.store in=\yb@manuscript,
  sparse/.store in=\yb@sparse,
}
\ProcessPgfPackageOptions{/yb}

\makeatletter
\ifdefined\yb@authordraft
  \PassOptionsToClass{11pt}{book}
  \PassOptionsToClass{oneside}{book}
\else
  \ifdefined\yb@manuscript
    \PassOptionsToClass{12pt}{book}
    \PassOptionsToClass{oneside}{book}
  \else
    \PassOptionsToClass{11pt}{book}
    \PassOptionsToClass{twoside}{book}
  \fi
\fi
\makeatother
\LoadClass{book}

\RequirePackage[utf8]{inputenc}

\RequirePackage{geometry}
\geometry{
  paperwidth=6in, paperheight=9in,
  bindingoffset=0.25in,
  left=0.75in, right=0.75in, top=0.75in, bottom=1.25in}
\makeatletter
\ifdefined\yb@authordraft
  \geometry{a4paper, margin=1in, left=1.5in}
\else
  \ifdefined\yb@manuscript
    \geometry{a4paper, margin=1.2in}
  \fi
\fi
\makeatother

\RequirePackage{href-ul}

\RequirePackage{anyfontsize}

\RequirePackage{tikz}
  \usetikzlibrary{positioning}
  \usetikzlibrary{shapes}
  \usetikzlibrary{fit}

\RequirePackage{chngcntr}
  \counterwithout{footnote}{chapter}

\RequirePackage{lastpage}

\RequirePackage{paralist}

\RequirePackage{xcolor}

\RequirePackage{graphicx}

\RequirePackage[inline]{enumitem}
  \setlist{nosep}

\RequirePackage{float}

\RequirePackage[normalem]{ulem}

\RequirePackage{xfp}
\RequirePackage{xifthen}

\RequirePackage{soul}

\RequirePackage[autostyle=try]{csquotes}

\pagestyle{plain}

\RequirePackage{setspace}
  \setstretch{1.2}
  \makeatletter
  \ifdefined\yb@compact\setstretch{1.0}\fi
  \ifdefined\yb@manuscript\setstretch{1.1}\fi
  \ifdefined\yb@authordraft\setstretch{1.4}\fi
  \makeatother

\PassOptionsToPackage{indexing=cite,
  natbib=true,maxnames=2,minnames=1,doi=true,
  url=false,isbn=false,isbn=false}{biblatex}
\makeatletter
\ifdefined\yb@apa
  \PassOptionsToPackage{style=authoryear}{biblatex}
\else
  \PassOptionsToPackage{style=numeric}{biblatex}
\fi
\makeatother
\RequirePackage{doi}
\RequirePackage{biblatex}
  \DeclareCiteCommand{\citetitle}
    {\boolfalse{citetracker}%
     \boolfalse{pagetracker}%
     \usebibmacro{prenote}}
    {\ifciteindex
       {\indexnames{labelname}}
       {}%
     \printfield[citetitle]{labeltitle}}
    {\multicitedelim}
    {\usebibmacro{postnote}}
  \DeclareCiteCommand*{\citetitle}
    {\boolfalse{citetracker}%
     \boolfalse{pagetracker}%
     \usebibmacro{prenote}}
    {\ifciteindex
       {\indexnames{labelname}}
       {}%
     \printfield[citetitle]{title}}
    {\multicitedelim}
    {\usebibmacro{postnote}}

\newenvironment{condensed}
  {\begingroup\setstretch{1.0}\lsstyle}
  {\endgroup}

\makeatletter
\ifdefined\yb@authordraft\else
  \PassOptionsToPackage{letterspace=-50,nopatch=footnote}{microtype}
  \RequirePackage{microtype}
\fi
\makeatother

\makeatletter
\ifdefined\yb@manuscript
  \RequirePackage[tt=false,type1=true]{libertine}
\fi
\makeatother

\makeatletter
\let\yb@oldsection\section
\def\yb@secstart{\ifdefined\yb@sparse\newpage\fi}
\ifdefined\yb@authordraft
  \RequirePackage[medium]{titlesec}
\else
  \RequirePackage[raggedright]{titlesec}
    \titlespacing{\section}{0in}{6pt}{6pt}[1in]
  \renewcommand\section{\yb@secstart\yb@oldsection}
\fi
\ifdefined\yb@compact
  \renewcommand\section{\yb@secstart\vspace{2em}\yb@oldsection}
\fi
\makeatother

\makeatletter
\ifdefined\yb@authordraft
  \RequirePackage[absolute]{textpos}
    \TPGrid{16}{16}
  \RequirePackage{fancyhdr}
  \pagestyle{fancy}
  \renewcommand\headrulewidth{0pt}
  \renewcommand\footrulewidth{0pt}
  \setlength{\headheight}{16pt}
  \fancyhf{}
  \fancyhead[L,C,LO,CO]{}
  \fancyhead[R,RO]{
    \begin{textblock}{16}[0.5,0.5](8,8)%
      \tikz \node[minimum width=16\TPHorizModule] {%
        \fontsize{64}{64}\selectfont\bfseries%
        \rotatebox{45}{
          \tikz \node
          [fill=gray!6, font=\ttfamily\color{white}]
          {it is a draft};%
        }%
      };%
    \end{textblock}%
    \begin{textblock}{4}(11.5,1)%
      \tikz \node [color=gray, rotate=270,
        font=\ttfamily\scriptsize, text width=8in] at (0,0) {%
        Copyright \textcopyright{} \the\year{} by \theauthor{}.
        All rights reserved. No part of the contents of
        this book may be reproduced or transmitted in any
        form or by any means without the written permission
        of the publisher. This particular manuscript is
        printed for \textbf{\thereviewer{}} and may be used only
        for one-time review. The manuscript has to be destroyed
        after the review.%
      };
    \end{textblock}
  }
  \fancyfoot[C,CO,C]{\small\ttfamily%
    page \#\thepage{} of \pageref{LastPage}}
\fi
\makeatother

\renewcommand\maketitle{
  {\LARGE\textbf{\thetitle}}
  \\[1em]
  by \theauthor{}
  \\[4em]
  \ifx\thevolume\empty\else%
    Volume \thevolume{}\\
  \fi
  \ifx\thedate\empty\else%
    Rendered on \thedate{}
  \fi
  \ifx\theversion\empty\else%
    \\
    Ver. \theversion{}
  \fi
}

\makeatletter
\newcommand\ybPrintTitlePage{
  \ifdefined\yb@authordraft\else
    \begin{titlepage}
      \ttfamily
      \vspace*{\fill}
      \noindent
      {\Huge\thetitle}
      \\[1em]
      by \theauthor{}
      \\[4em]
      \ifx\thevolume\empty\else%
        Volume \thevolume{}\\
      \fi
      \ifx\thedate\empty\else%
        \thedate{}
      \fi
      \ifx\thedate\empty\else%
        \\
        \theversion{}
      \fi
      \vspace*{\fill}
    \end{titlepage}
  \fi
}
\makeatother

\makeatletter
\newcommand\ybPrintTOC{
  \ifdefined\yb@authordraft\else
    \ifdefined\yb@compact\else\cleardoublepage\fi
    {\setstretch{0.7}\tableofcontents}
  \fi
}
\makeatother

\RequirePackage{imakeidx}
  \renewbibmacro*{citeindex}{\indexnames{labelname}{}}
  \makeindex
  \indexsetup{othercode={\hyphenpenalty=10000}}
\makeatletter
\newcommand\ybPrintIndex[1][Index]{%
  \ifdefined\yb@authordraft\else
    \cleardoublepage%
    {%
      \setstretch{1.0}%
      \small%
      \addcontentsline{toc}{chapter}{#1}%
      \printindex%
    }%
  \fi%
}
\makeatother

\RequirePackage{wrapfig}
\RequirePackage{mdframed}
\RequirePackage{changepage}
  \strictpagecheck
\mdfdefinestyle{quoteodd}{backgroundcolor=black!0,
  leftmargin=6pt,rightmargin=0pt,
  innerleftmargin=6pt,innerrightmargin=0pt,
  innertopmargin=0pt,innerbottommargin=0pt,
  skipabove=0pt,skipbelow=0pt,
  linewidth=2pt,
  topline=false,bottomline=false,rightline=false}
\mdfdefinestyle{quoteeven}{backgroundcolor=black!0,
  rightmargin=6pt,leftmargin=0pt,
  innerrightmargin=6pt,innerleftmargin=0pt,
  innertopmargin=0pt,innerbottommargin=0pt,
  skipabove=0pt,skipbelow=0pt,
  linewidth=2pt,
  topline=false,bottomline=false,leftline=false}
\makeatletter
\newcommand\ybQuote[3]{%
  \ifthenelse{\isempty{#3}}{}{
    \ifx\hfuzz#2\hfuzz%
      \index{#3}%
    \else%
      \index{#3, #2}%
    \fi%
  }%
  \def\yb@body{%
    \raggedright%
    \ifx\hfuzz#3\hfuzz%
      #1%
    \else%
      ``#1''\\\raggedleft---#2 #3%
    \fi%
  }
  \ifdefined\yb@authordraft%
    \begin{wrapfigure}{r}{0.4\textwidth}%
      \begin{mdframed}[style=quoteodd]%
        \yb@body%
      \end{mdframed}%
    \end{wrapfigure}%
  \else%
    \begin{wrapfigure}{o}[12pt]{0.4\textwidth}%
      \sffamily\checkoddpage%
      \ifoddpage%
        \begin{mdframed}[style=quoteodd]\yb@body\end{mdframed}%
      \else%
        \begin{mdframed}[style=quoteeven]\yb@body\end{mdframed}%
      \fi%
      \vspace{-12pt}
    \end{wrapfigure}%
  \fi%
}
\makeatother

\RequirePackage{perpage}
\RequirePackage[bottom,perpage,multiple]{footmisc}
\makeatletter
  \let\yb@oldfootnote\footnote
\newcommand\yb@nexttoken\relax
\newcommand\yb@isfootnote{%
  \ifx\footnote\yb@nexttoken\textsuperscript{,}\fi}
\renewcommand\footnote[1]{%
  \yb@oldfootnote{#1}\futurelet\yb@nexttoken\yb@isfootnote}
\makeatother

\makeatletter
\newcommand\ybPrintBibliography[1][Bibliography]{%
  \AtNextBibliography{\small}%
  \raggedright%
  \ifdefined\yb@manuscript%
    \setlength\bibitemsep{0pt}%
    \newpage%
    \begin{multicols}{2}%
      {\setstretch{1.0}\printbibliography}%
    \end{multicols}%
  \else%
    \setlength\bibitemsep{.2em}%
    \printbibliography[heading=bibintoc,title={#1}]%
  \fi%
}
\makeatother

\makeatletter
\AtBeginDocument{%
  \raggedbottom%
  \ifdefined\yb@authordraft%
    \raggedright%
  \fi%
  \setlength\topskip{0mm}%
  \setlength\parindent{0pt}%
  \setlength\fboxsep{0pt}%
  \setlength\parskip{6pt}%
  \interfootnotelinepenalty=10000%
}
\makeatother

\newcommand*\thetitle{\textbackslash{}thetitle}
\newcommand*\thevolume{}
\newcommand*\thedate{}
\newcommand*\theversion{\textbackslash{}theversion}
\newcommand*\theauthor{\textbackslash{}theauthor}
\newcommand*\thereviewer{\textbackslash{}thereviewer}

\endinput
%%
%% End of file `yb-book.cls'.
