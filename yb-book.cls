% (The MIT License)
%
% Copyright (c) 2021-2022 Yegor Bugayenko
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
\ProvidesClass{yb-book}[00.00.0000 0.0.0 YB Branded Book Style]

\RequirePackage{xkeyval}

\makeatletter
\newif\ifyb@draft
\DeclareOptionX{draft}{\yb@drafttrue}
\newif\ifyb@compact
\DeclareOptionX{compact}{\yb@compacttrue}
\newif\ifyb@manuscript
\DeclareOptionX{manuscript}{\yb@manuscripttrue}
\ProcessOptionsX
\makeatother

\makeatletter\ifyb@draft
  \PassOptionsToClass{11pt}{book}
  \PassOptionsToClass{oneside}{book}
\else
  \ifyb@manuscript
    \PassOptionsToClass{12pt}{book}
    \PassOptionsToClass{oneside}{book}
  \else
    \PassOptionsToClass{11pt}{book}
    \PassOptionsToClass{twoside}{book}
  \fi
\fi\makeatother

\LoadClass{book}

\RequirePackage{geometry}
  \geometry{paperwidth=6in, paperheight=9in, bindingoffset=0.25in, left=0.75in, right=0.75in, top=0.75in, bottom=1.25in}
  \makeatletter\ifyb@draft
    \geometry{a4paper, margin=1in, left=1.5in}
  \else
    \ifyb@manuscript
      \geometry{a4paper, margin=1.2in}
    \fi
  \fi\makeatother

\RequirePackage[T1]{fontenc}
\RequirePackage[utf8]{inputenc}
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
\RequirePackage{setspace}
  \setstretch{1.2}
  \makeatletter\ifyb@draft\setstretch{1.1}\fi\makeatother
  \makeatletter\ifyb@compact\setstretch{1.0}\fi\makeatother
  \makeatletter\ifyb@manuscript\setstretch{1.1}\fi\makeatother
\RequirePackage{textcomp}
\RequirePackage[inline]{enumitem}
  \setlist{nosep}
\RequirePackage{float}
\RequirePackage[normalem]{ulem}
\RequirePackage{qrcode}
\RequirePackage{wrapfig}
  \pagestyle{plain}
\RequirePackage{xfp}
\RequirePackage{soul} % in order to use \st{} to strikethrough
\RequirePackage{xifthen}
\RequirePackage[autostyle=try]{csquotes}

\RequirePackage[indexing=cite,style=authoryear,natbib=true,maxnames=1,minnames=1,doi=false,url=false,isbn=false,isbn=false]{biblatex}
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
\RequirePackage{imakeidx}
  \renewbibmacro*{citeindex}{\indexnames{labelname}{}}
  \makeindex
  \indexsetup{othercode={\hyphenpenalty=10000}}

\newenvironment{condensed}{%
  \begingroup\setstretch{1.0}%
  % This lsstyle is defined by 'letterspace' in microtype
  \lsstyle}{\endgroup}

\makeatletter\ifyb@draft\else
  \RequirePackage[letterspace=-50]{microtype}
\fi\makeatother

\makeatletter\ifyb@manuscript
  \RequirePackage[tt=false,type1=true]{libertine}
\fi\makeatother

\RequirePackage[bottom,perpage,multiple]{footmisc}
  % see https://tex.stackexchange.com/questions/40072/incompatibility-between-footmisc-option-multiple-and-hyperref/62091#62091
  \makeatletter\let\yb@oldfootnote\footnote\makeatother
  \makeatletter\newcommand\yb@nexttoken\relax\makeatother
  \makeatletter\newcommand\yb@isfootnote{%
    \ifx\footnote\yb@nexttoken\textsuperscript{,}\fi}\makeatother
  \makeatletter\renewcommand\footnote[1]{%
    \yb@oldfootnote{#1}\futurelet\yb@nexttoken\yb@isfootnote}\makeatother

\makeatletter
  \let\yb@oldsection\section
  \ifyb@draft
    \RequirePackage[medium]{titlesec}
  \else
    \RequirePackage[raggedright]{titlesec}
      \titlespacing{\section}{0in}{6pt}{6pt}[1in]
    \renewcommand\section{\newpage\yb@oldsection}
  \fi
\makeatother

\makeatletter\ifyb@compact
  \renewcommand\section{\vspace{2em}\yb@oldsection}
\fi\makeatother

\makeatletter\ifyb@draft
  \RequirePackage{fancyhdr}
    \pagestyle{fancy}
    \renewcommand\headrulewidth{0pt}
    \renewcommand\footrulewidth{0pt}
    \fancyhf{}
    \fancyhead[L,C,LO,CO]{}
    \fancyhead[R,RO]{
      \begin{textblock}{4}(11.5,1)
        \begin{tikzpicture}
          \node [color=gray, rotate=270, font=\ttfamily\scriptsize, text width=5in] at (0,0) {
            Copyright \textcopyright{} \the\year{} by \theauthor{}.
            All rights reserved. No part of the contents of this book may be
            reproduced or transmitted in any form or by any means without the
            written permission of the publisher.
            This particular manuscript is printed for
            \textbf{\thereviewer{}} and may be used only for one-time review. The
            manuscript has to be destroyed after the review.
          };
        \end{tikzpicture}
      \end{textblock}
    }
    \fancyfoot[C,CO]{\small\ttfamily page \#\thepage{} of \pageref{LastPage}}
\fi\makeatother

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

\makeatletter\newcommand\ybPrintTitlePage{
  \ifyb@draft\else
    \begin{titlepage}
      \ttfamily
      \vspace*{\fill}
      \noindent
      {\Huge\textbf{\thetitle}}
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
}\makeatother

\makeatletter\newcommand\ybPrintTOC{
  \ifyb@draft\else
    \ifyb@compact\else\cleardoublepage\fi
    {\setstretch{0.7}\tableofcontents}
  \fi
}\makeatother

\makeatletter\newcommand\ybPrintIndex[1][Index]{
  \ifyb@draft\else
    \cleardoublepage
    {
      \setstretch{1.0}
      \small
      \addcontentsline{toc}{chapter}{#1}
      \printindex
    }
  \fi
}\makeatother

\newcommand\ybPrintIcons{%
  \ifdefempty{\theemail{}}{}{%
    \includegraphics[height=1em]{images/icon-email.pdf}%
    \theemail{}%
  }%
  \includegraphics[height=1em]{images/icon-twitter.pdf}%
  \includegraphics[height=1em]{images/icon-linkedin.pdf}%
  \includegraphics[height=1em]{images/icon-github.pdf}%
  \includegraphics[height=1em]{images/icon-instagram.pdf}%
  \includegraphics[height=1em]{images/icon-facebook.pdf}%
  \thesocial{}%
}

% quotes
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
\makeatletter\newcommand\ybQuote[3]{%
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
  \ifyb@draft%
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
}\makeatother

\makeatletter\newcommand\ybPrintBibliography{%
  \AtNextBibliography{\small}%
  \raggedright%
  \ifyb@manuscript%
    \setlength\bibitemsep{0pt}%
    \newpage%
    \begin{multicols}{2}{\setstretch{1.0}\printbibliography}\end{multicols}
  \else
    \printbibliography
  \fi
}\makeatother

\AtBeginDocument{%
  \raggedbottom%
  \setlength\topskip{0mm}%
  \setlength\parindent{0pt}%
  \setlength\fboxsep{0pt}%
  \setlength\parskip{6pt}%
  \interfootnotelinepenalty=10000%
}

\newcommand*\thetitle{\textbackslash{}thetitle}
\newcommand*\thevolume{}
\newcommand*\thedate{}
\newcommand*\theemail{\textbackslash{}theemail}
\newcommand*\thesocial{\textbackslash{}thesocial}
\newcommand*\theversion{\textbackslash{}theversion}
\newcommand*\theauthor{\textbackslash{}theauthor}
\newcommand*\thereviewer{\textbackslash{}thereviewer}
\newcommand*\theyear{\textbackslash{}theyear}
\newcommand*\theprice{\textbackslash{}theprice}

\endinput
