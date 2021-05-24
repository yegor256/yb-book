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
\ProvidesClass{ybook}[00.00.0000 0.0.0 The Template for ybBranded Books]

\RequirePackage{xkeyval}
\newif\ifdraft
\DeclareOptionX{draft}{\drafttrue}
\newif\ifcompact
\DeclareOptionX{compact}{\compacttrue}
\newif\ifmanuscript
\DeclareOptionX{manuscript}{\manuscripttrue}
\newif\ifcover
\DeclareOptionX{cover}{\covertrue\newcommand*\thebookpdf{#1}}
\ProcessOptionsX

\ifdraft
  \PassOptionsToClass{11pt}{book}
  \PassOptionsToClass{oneside}{book}
\else
  \ifmanuscript
    \PassOptionsToClass{12pt}{book}
    \PassOptionsToClass{oneside}{book}
  \else
    \PassOptionsToClass{11pt}{book}
    \PassOptionsToClass{twoside}{book}
  \fi
\fi

\LoadClass{book}

\RequirePackage{geometry}
\geometry{paperwidth=6in, paperheight=9in, bindingoffset=0.25in, left=0.75in, right=0.75in, top=0.75in, bottom=1.25in}
\ifdraft
  \geometry{a4paper, margin=1in, left=1.5in}
\else
  \ifmanuscript
    \geometry{a4paper, margin=1.2in}
  \fi
\fi

\RequirePackage[T2A,T1]{fontenc}
\RequirePackage[utf8]{inputenc}
\RequirePackage{anyfontsize}
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
\RequirePackage{tikz}
  \usetikzlibrary{positioning}
  \usetikzlibrary{shapes}
  \usetikzlibrary{fit}
\ifdraft\else
  \RequirePackage[letterspace=-50]{microtype}
\fi
\ifmanuscript
  \RequirePackage[tt=false,type1=true]{libertine}
\fi
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

\setstretch{1.2}
\ifdraft\setstretch{1.1}\fi
\ifcompact\setstretch{1.0}\fi
\ifmanuscript\setstretch{1.1}\fi

\ifcompact
  \renewcommand\section{\vspace{2em}\oldsection}
\fi

\ifdraft
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

\renewcommand\maketitle{
  {\LARGE\textbf{\thetitle}}
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
}

\newcommand\ybPrintTitlePage{
  \ifdraft\else
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
  \ifdraft\else
    \ifcompact\else\cleardoublepage\fi
    \setrelativestretch{0.7}{\tableofcontents}
  \fi
}

\newcommand\ybPrintIndex[1][Index]{
  \ifdraft\else
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
  \ifdefempty{\theemail{}}{}{
    \includegraphics[height=1em]{images/icon-email.pdf}
    \theemail{}
  }
  \includegraphics[height=1em]{images/icon-twitter.pdf}
  \includegraphics[height=1em]{images/icon-linkedin.pdf}
  \includegraphics[height=1em]{images/icon-github.pdf}
  \includegraphics[height=1em]{images/icon-instagram.pdf}
  \includegraphics[height=1em]{images/icon-facebook.pdf}
  \thesocial{}
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

\makeatletter\newcommand{\exec}[3][1=]{%
  \begingroup
  \let\%\@percentchar
  \let\{\@charlb
  \let\}\@charrb
  \ShellEscape{#3 > #2}%
  \endgroup%
  \ifthenelse{\isempty{#1}}{\input{#2}}{}%
}\makeatother
\makeatletter\let\primitiveinput\@@input\makeatother%
\ifcover
  \exec[noprint]{totalpages.exc}{qpdf --show-npages \thebookpdf | tr -d '[[:space:]]' | \{ cat; echo \%; \}}%
  \newcommand{\totalpages}{\primitiveinput totalpages.exc }%
  % The height of the page is 9 inches plus 0.125 "bleed" on top and
  % on the bottom.
  % Check this doc: https://kdp.amazon.com/en_US/help/topic/G201953020
  \newlength{\ybpageheight}%
  \setlength{\ybpageheight}{0.125in + 9in + 0.125in}%
  % The width is 6 inches plus 0.125 "bleed" on each side. The width of the
  % "spine" depends on the amount of pages in the book. Also, there is a
  %
  \newlength{\ybpagewidth}%
  \setlength{\ybpagewidth}{0.125in + 6in + 0.0025in * \totalpages + 6in + 0.125in}%
  \geometry{paperwidth=\ybpagewidth,paperheight=\ybpageheight,left=0pt,right=0pt,top=0pt,bottom=0pt}
\fi

\newcommand\ybPrintBibliography{%
  \AtNextBibliography{\small}%
  \raggedright%
  \ifmanuscript%
    \setlength\bibitemsep{0pt}%
    \newpage%
    \begin{multicols}{2}\setrelativestretch{1.0}{\printbibliography}\end{multicols}
  \else
    \printbibliography
  \fi
}

\newcommand\ybPrintCover{%
  \setlength{\parskip}{0pt}%
  \ttfamily%
  \begin{textblock}{2.4}[0.5,0](8,0)
    \begin{tikzpicture}
      \node [rectangle, inner sep=0em, fill=black, minimum width=2.4\TPHorizModule, minimum height=16\TPVertModule] at (0,0) {};
    \end{tikzpicture}
  \end{textblock}
  \begin{textblock}{2.4}[0.5,1](8,14)
    \centerline{\includegraphics[width=0.32in]{images/signature}}
  \end{textblock}
  \begin{textblock}{1}[0.5,0](8,2)
    \begin{tikzpicture}
      \node [color=white, inner sep=0cm, outer sep=0cm, rotate=270, minimum height=\TPHorizModule] at (0,0) {
        \textbf{\Large \thespinetext{}}
      };
    \end{tikzpicture}
  \end{textblock}
  \begin{textblock}{5}(10,9)
    \fontsize{32}{32}\selectfont\textbf{\thetitle{}}
  \end{textblock}
  \begin{textblock}{4}(10,10)
    \large\textbf{by \theauthor{}}
  \end{textblock}
  \begin{textblock}{5}(10,11)
    \raggedright
    TL;DR \thetldr{}
  \end{textblock}
  \begin{textblock}{4}[0,1](10,14)
    \theversion{}
    \quad
    \exec[]{date.exc}{git log -n 1 --pretty='format:\%ad' --date='format:\%e-\%b-\%Y'}
  \end{textblock}
  \begin{textblock}{4}[0,1](1,14)
    \small (c)
    \ifdefempty{\theyear{}}{}{\theyear{}-}\the\year{} \theauthor{}
  \end{textblock}
  \begin{textblock}{4}[0,1](1,2)
    \small \theprice{}
  \end{textblock}
  \ifdefempty{\thevolume}{}{
    \begin{textblock}{2}[1,1](15,14)
      \raggedleft
      \includegraphics[height=0.4in]{images/volume-\thevolume}
    \end{textblock}
  }
  \begin{textblock}{4}(10,2)
    \includegraphics[width=\textwidth]{\theimage}
  \end{textblock}
}

\RequirePackage[absolute]{textpos}
  \TPGrid{16}{16}

\AtBeginDocument{
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

\newcommand\tbd[1]{\colorbox{yellow}{#1}}

\newcommand\first[2]{\vspace{1em}{\setlength{\parindent}{0pt}\bfseries\LARGE #1}\textsc{#2}}

\newcommand{\shortenurl}{...}
\newcommand{\shorten}[1]{%
  \immediate\write18{/code/books/src/shorten.rb #1 > /tmp/shorten.tex}%
  \makeatletter\everyeof{\noexpand}
  \edef\shortenurl{\@@input /tmp/shorten.tex }
  \makeatother}

\newcommand*\thetitle{\textbackslash{}thetitle}
\newcommand*\thevolume{}
\newcommand*\thedate{}
\newcommand*\theemail{}
\newcommand*\thesocial{}
\newcommand*\theversion{\textbackslash{}theversion}
\newcommand*\theauthor{\textbackslash{}theauthor}
\newcommand*\thereviewer{\textbackslash{}thereviewer}
\newcommand*\theyear{\textbackslash{}theyear}
\newcommand*\theprice{\textbackslash{}theprice}
\newcommand*\thespinetext{\textbackslash{}thespinetext}
\newcommand*\theimage{images/cactus}
\newcommand*\thetldr{You have to renew the \ff{\textbackslash{}thetldr} command in order to change this text.}

\endinput
