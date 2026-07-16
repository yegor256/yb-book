%%
%% This is file `yb-book.cls',
%% generated with the docstrip utility.
%%
%% The original source files were:
%%
%% yb-book.dtx  (with options: `class')
%% (The MIT License)
%% 
%% Copyright (c) 2021-2026 Yegor Bugayenko
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
[2026-07-16 09.12.08 YB Branded Book Style]





















\RequirePackage{pgfopts}
\pgfkeys{
  /yb/.cd,
  apa/.store in=\yb@apa,
  authordraft/.store in=\yb@authordraft,
  compact/.store in=\yb@compact,
  manuscript/.store in=\yb@manuscript,
  colored/.store in=\yb@colored,
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

\RequirePackage{href-ul}

\PassOptionsToPackage{capitalize}{cleveref}
\RequirePackage{amsmath}
\RequirePackage{cleveref}
  \crefformat{section}{\S#2#1#3}


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

\RequirePackage{anyfontsize}

\RequirePackage{tikz}
  \usetikzlibrary{positioning}
  \usetikzlibrary{shapes}
  \usetikzlibrary{fit}

\RequirePackage{chngcntr}
  \counterwithout{footnote}{chapter}

\PassOptionsToPackage{synonym=hs}{handstroke}
\RequirePackage{handstroke}

\RequirePackage{lastpage}

\RequirePackage{paralist}

\RequirePackage{xcolor}

\RequirePackage{graphicx}

\PassOptionsToPackage{inline}{enumitem}
\RequirePackage{enumitem}
  \setlist{nosep}

\RequirePackage{float}

\RequirePackage{xfp}
\RequirePackage{xifthen}

\PassOptionsToPackage{autostyle=try}{csquotes}
\RequirePackage{csquotes}

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
  url=false,isbn=false}{biblatex}
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
  {\begingroup%
    \lstset{columns=fixed,basewidth=0.45em}}
  {\endgroup}

\makeatletter
\ifdefined\yb@authordraft
  \PassOptionsToPackage{nopatch=footnote}{microtype}
\else
  \PassOptionsToPackage{nopatch=footnote,protrusion=true}{microtype}
\fi
\makeatother
\RequirePackage{microtype}

\makeatletter
\let\yb@oldsection\section
\def\yb@secstart{\ifdefined\yb@sparse\newpage\fi}
\ifdefined\yb@authordraft
  \PassOptionsToPackage{medium}{titlesec}
  \RequirePackage{titlesec}
\else
  \PassOptionsToPackage{raggedright}{titlesec}
  \RequirePackage{titlesec}
    \titlespacing{\section}{0em}{2em}{1em}
  \renewcommand\section{\yb@secstart\yb@oldsection}
\fi
\ifdefined\yb@compact
  \renewcommand\section{\yb@secstart\vspace{2em}\yb@oldsection}
\fi
\makeatother

\makeatletter
\renewcommand\@makefntext[1]{%
  \raggedright%
  \parindent=1em%
  \noindent\hb@xt@1.8em{\hss\@makefnmark}#1}
\makeatother

\makeatletter
\ifdefined\yb@authordraft
  \PassOptionsToPackage{absolute}{textpos}
  \RequirePackage{textpos}
    \TPGrid{16}{16}
  \RequirePackage{fancyhdr}
  \pagestyle{fancy}
  \renewcommand\headrulewidth{0em}
  \renewcommand\footrulewidth{0em}
  \setlength{\headheight}{3em}
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
        font=\ttfamily\scriptsize, text width=24em] at (0,0) {%
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
    page \thepage{} of \pageref{LastPage}}
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
    Rendered on \thedate{}\\
  \fi
  \ifx\theversion\empty\else%
    Ver. \theversion{}
  \fi
}

\makeatletter
\newcommand\incolor[2]{%
  \ifdefined\yb@colored\textcolor{#1}{#2}\else#2\fi}
\makeatother

\newcommand\ix[2][]{%
  \incolor{brown}{#2}%
  \def\ixparam{#1}%
  \ifx\ixparam\empty%
    \index{#2}%
  \else%
    \index{#1}%
  \fi}

\renewcommand\emph[1]{\incolor{orange}{\textit{#1}}}

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
        \thedate{}\\
      \fi
      \ifx\theversion\empty\else%
        \theversion{}
      \fi
      \vspace*{\fill}
    \end{titlepage}
  \fi
}
\makeatother

\newcommand\ybEpigraph[3]{
  \cleardoublepage
  \vspace*{\fill}
  \begin{quote}
  \begin{raggedleft}
  ``#1'' \\[1em]
  {---} #2 \\
  \citetitle{#3}\\
  \citeyear{#3}\par
  \end{raggedleft}
  \end{quote}
  \vspace*{\fill}}

\makeatletter
\newcommand\ybPrintTOC{%
  \ifdefined\yb@authordraft\else%
    \ifdefined\yb@compact\else\cleardoublepage\fi%
    {\setstretch{0.7}\tableofcontents}%
  \fi%
}
\makeatother

\RequirePackage{imakeidx}
  \renewbibmacro*{citeindex}{\indexnames{labelname}{}}
  \makeindex
  \indexsetup{othercode={\hyphenpenalty=10000}}
\makeatletter
\newcommand\ybPrintIndex[1][Index]{%
  \ifdefined\yb@authordraft\else%
    \ifdefined\yb@compact\else\cleardoublepage\fi%
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
  leftmargin=1em,rightmargin=0em,
  innerleftmargin=1em,innerrightmargin=0em,
  innertopmargin=0em,innerbottommargin=0em,
  skipabove=0em,skipbelow=0em,
  linewidth=.2em,
  topline=false,bottomline=false,rightline=false}
\mdfdefinestyle{quoteeven}{backgroundcolor=black!0,
  rightmargin=1em,leftmargin=0em,
  innerrightmargin=1em,innerleftmargin=0em,
  innertopmargin=0em,innerbottommargin=0em,
  skipabove=0em,skipbelow=0em,
  linewidth=.2em,
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
  \ifdim\pagetotal<4\baselineskip\relax%
    \ClassWarning{yb-book}{ybQuote stays at the top of a page: \detokenize{#1}}%
  \fi%
  \ifdim\dimexpr\pagegoal-\pagetotal\relax<8\baselineskip\relax%
    \ClassWarning{yb-book}{ybQuote stays at the bottom of a page: \detokenize{#1}}%
  \fi%
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
    \begin{wrapfigure}{o}[2em]{0.4\textwidth}%
      \sffamily\checkoddpage%
      \ifoddpage%
        \begin{mdframed}[style=quoteodd]\yb@body\end{mdframed}%
      \else%
        \begin{mdframed}[style=quoteeven]\yb@body\end{mdframed}%
      \fi%
      \vspace{-1em}
    \end{wrapfigure}%
  \fi%
}
\makeatother

\makeatletter
\newcommand\ybTweet[1]{%
  \ifdefined\yb@authordraft\else%
    \ybQuote{#1}{}{}%
  \fi%
  }
\makeatother

\RequirePackage{perpage}
\PassOptionsToPackage{bottom,perpage,multiple}{footmisc}
\RequirePackage{footmisc}
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
    \setlength\bibitemsep{0em}%
    \newpage%
    \begin{multicols}{2}%
      {\setstretch{1.0}\printbibliography}%
    \end{multicols}%
  \else%
    \setlength\bibitemsep{.2em}%
    \@openrightfalse%
    \printbibliography[heading=bibintoc,title={#1}]%
    \ifdefined\yb@compact\@openrighttrue\fi%
  \fi%
}
\makeatother

\makeatletter
\AtBeginDocument{%
  \raggedbottom%
  \ifdefined\yb@authordraft%
    \raggedright%
  \fi%
  \setlength\topskip{0em}%
  \setlength\parindent{0em}%
  \setlength\fboxsep{0em}%
  \setlength\parskip{.5em}%
  \exhyphenpenalty=10000% to avoid line breaks before and after an em dash
  \widowpenalty=10000% to have fewer widows
  \clubpenalty=10000% to have fewer orphans
  \interfootnotelinepenalty=10000% to format footnotes better
  \hfuzz=3pt %
  \tolerance=1000 %
  \emergencystretch=1em %
  \hbadness=2000 %
}
\makeatother

\newcommand*\thetitle{\textbackslash{}thetitle}
\let\thevolume\empty
\let\thedate\empty
\newcommand*\theversion{\textbackslash{}theversion}
\newcommand*\theauthor{\textbackslash{}theauthor}
\newcommand*\thereviewer{\textbackslash{}thereviewer}

\endinput
%%
%% End of file `yb-book.cls'.
