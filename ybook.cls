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

\newif\ifdraft
\DeclareOption{draft}{\drafttrue}
\ProcessOptions\relax

\ifdraft
  \LoadClass[11pt,oneside]{book}
  \RequirePackage[paperwidth=8.5in, paperheight=11in, bindingoffset=0.25in, left=0.75in, right=2in, top=0.75in, bottom=1.25in]{geometry}
\else
  \LoadClass[11pt,twoside]{book}
  \RequirePackage[paperwidth=6in, paperheight=9in, bindingoffset=0.25in, left=0.75in, right=0.75in, top=0.75in, bottom=1.25in]{geometry}
\fi

\RequirePackage[T2A,T1]{fontenc}
\RequirePackage[utf8]{inputenc}
\RequirePackage{tikz}
  \usetikzlibrary{positioning}
  \usetikzlibrary{fit}
\RequirePackage[letterspace=-50]{microtype}
\RequirePackage{soul} % in order to use \st{} to strikethrough
\RequirePackage[autostyle=try]{csquotes}
\RequirePackage{xifthen}

\RequirePackage[bottom,perpage,multiple]{footmisc}
  % see https://tex.stackexchange.com/questions/40072/incompatibility-between-footmisc-option-multiple-and-hyperref/62091#62091
  \let\oldFootnote\footnote
  \newcommand\nextToken\relax
  \renewcommand\footnote[1]{%
    \oldFootnote{#1}\futurelet\nextToken\isFootnote}
  \newcommand\isFootnote{%
    \ifx\footnote\nextToken\textsuperscript{,}\fi}

\RequirePackage{chngcntr}
  \counterwithout{footnote}{chapter}
\RequirePackage{lastpage}
\RequirePackage{paralist}
\RequirePackage{xcolor}
\RequirePackage{graphicx}
\RequirePackage{setspace}
\RequirePackage{textcomp}
\RequirePackage{imakeidx}
\RequirePackage[inline]{enumitem}
  \setlist{nosep}
\RequirePackage{float}
\RequirePackage[normalem]{ulem}

% To make \href{} links look nice, underscored
\RequirePackage[hidelinks]{hyperref}
  \makeatletter\begingroup
    \catcode`\$=6 %
    \catcode`\#=12 %
    \gdef\href@split$1#$2#$3\\$4{%
      \hyper@@link{$1}{$2}{\uline{$4}}%
      \endgroup
    }%
  \endgroup\makeatother

\makeindex\indexsetup{othercode={\hyphenpenalty=10000}}

\RequirePackage{qrcode}
\RequirePackage{wrapfig}
  \pagestyle{plain}
\RequirePackage{xfp}
\RequirePackage{verbatim}
  \newcommand{\setrelativestretch}[1]{%
    \begingroup\edef\x{\endgroup
      \noexpand\setstretch{\fpeval{(#1)*(\baselinestretch)}}%
    }\x
  }
  \newenvironment{listing}
    {\medskip\minipage{\linewidth}\setrelativestretch{0.9}\verbatim}%
    {\endverbatim\endminipage\medskip}
  \newenvironment{condensed}{%
    \setrelativestretch{0.85}%
    % This lsstyle is defined by 'letterspace' in microtype
    \lsstyle}{}

\let\oldsection\section
\ifdraft
  \RequirePackage[medium]{titlesec}
\else
  \RequirePackage[raggedright]{titlesec}
    \titlespacing{\section}{0in}{6pt}{6pt}[1in]
  \renewcommand\section{\newpage\oldsection}
\fi

\ifdraft
  \setstretch{1.1}
\else
  \setstretch{1.2}
\fi

\ifdraft
  \RequirePackage[absolute]{textpos}
    \TPGrid{16}{16}
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
\fi

\RequirePackage{shellesc}

\newcommand\ybPrintTitlePage{
  \ifdraft
    The Title Page will be printed here.
  \else
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
}

\newcommand\ybPrintTOC{
  \ifdraft
    The Table of Contents will be printed here.
  \else
    \cleardoublepage
    {
      \setstretch{0.7}
      \tableofcontents
    }
  \fi
}

\newcommand\ybPrintIndex[1][Index]{
  \ifdraft
    The Index will be printed here.
  \else
    \cleardoublepage
    {
      \setstretch{1.0}
      \small
      \addcontentsline{toc}{chapter}{#1}
      \printindex
    }
  \fi
}

\newcommand\ybPrintIcons{
  \includegraphics[height=1em]{images/email.pdf} book@yegor256.com
  \includegraphics[height=1em]{images/twitter.pdf}
  \includegraphics[height=1em]{images/linkedin.pdf}
  \includegraphics[height=1em]{images/github.pdf}
  \includegraphics[height=1em]{images/instagram.pdf}
  \includegraphics[height=1em]{images/facebook.pdf} yegor256
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
\newcommand\ybQuote[3]{%
  \ifthenelse{\isempty{#3}}{}{
    \ifx\hfuzz#2\hfuzz%
      \index{#3}%
    \else%
      \index{#3, #2}%
    \fi%
  }%
  \def\body{%
    \raggedright%
    \ifx\hfuzz#3\hfuzz%
      #1%
    \else%
      ``#1''\\\raggedleft---#2 #3%
    \fi%
  }
  \ifdraft%
    \begin{wrapfigure}{r}{0.4\textwidth}%
      \begin{mdframed}[style=quoteodd]%
        \body%
      \end{mdframed}%
    \end{wrapfigure}%
  \else%
    \begin{wrapfigure}{o}[12pt]{0.4\textwidth}%
      \sffamily\checkoddpage%
      \ifoddpage%
        \begin{mdframed}[style=quoteodd]\body\end{mdframed}%
      \else%
        \begin{mdframed}[style=quoteeven]\body\end{mdframed}%
      \fi%
      \vspace{-12pt}
    \end{wrapfigure}%
  \fi%
}

\AtBeginDocument{
  \makeatletter\newcommand{\exec}[1]{%
    \begingroup%
    \let\%\@percentchar%
    \ShellEscape{#1 2>&1 > target/exec.tex}%
    \endgroup%
    \input{target/exec.tex}%
  }\makeatother%
  \raggedbottom%
  \setlength\topskip{0mm}
  \setlength\parindent{0pt}
  \setlength\parskip{6pt}
  \interfootnotelinepenalty=10000
}

\newcommand\nospell[1]{#1}
\newcommand\blog[1]{%
  \shorten{#1}%
  \ifdraft\else%
    \begin{wrapfigure}[0]{R}{0.6in}%
      \vspace{-.75in}%
      \qrcode[height=0.6in]{\shortenurl}%
    \end{wrapfigure}%
  \fi%
  {\footnotesize\ttfamily{}Discuss at \shortenurl}\par%
}
\newcommand{\ff}[1]{\codebox{\vrule height 6pt depth 1pt width 0pt\texttt{#1}}}
  \RequirePackage{tcolorbox}
  \newtcbox{\codebox}{nobeforeafter,colframe=gray!80!white,colback=gray!5!white,boxrule=0.1pt,arc=1pt, boxsep=1.2pt,left=0.5pt,right=0.5pt,top=0.2pt,bottom=0.2pt,tcbox raise base}

\newcommand{\shortenurl}{...}
\newcommand{\shorten}[1]{%
  \immediate\write18{/code/books/src/shorten.rb #1 > /tmp/shorten.tex}%
  \makeatletter\everyeof{\noexpand}
  \edef\shortenurl{\@@input /tmp/shorten.tex }
  \makeatother}

\newcommand*\thetitle{Sample Book}
\newcommand*\thevolume{}
\newcommand*\thedate{}
\newcommand*\theversion{}
\newcommand*\theauthor{\nospell{Yegor Bugayenko}}
\newcommand*\thereviewer{Mr.~Anonymous}

\endinput
