\newcommand{\filename}{apralyx}
\newcommand{\fileversion}{$Revision: 0.1 $}
\newcommand{\filedate}{2014/12/31}
\newcommand{\fileauthor}{$Author: Louis Melahn, L.C.$}

\NeedsTeXFormat{LaTeX2e}[1995/12/01]
\ProvidesClass{\filename}[\filedate \fileversion %
  : Thesis class for the Pontifical Regina Apostolorum %
   Athenaeum, based on memoir]

\DeclareOption{12pt}{\PassOptionsToClass{\CurrentOption}{memoir}}
\DeclareOption{a4paper}{\PassOptionsToClass{\CurrentOption}{memoir}}
\DeclareOption{oneside}{\PassOptionsToClass{\CurrentOption}{memoir}}
\DeclareOption{openany}{\PassOptionsToClass{\CurrentOption}{memoir}}
\DeclareOption{xetex}{\PassOptionsToClass{\CurrentOption}{memoir}}

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{memoir}}

% These are the default options.
\ExecuteOptions{12pt,a4paper,oneside,openany,xetex,indexfirst}

\ProcessOptions\relax

% This will be the class that "inherits" the current class.
\LoadClass{memoir}

%Packages and their setup.
\RequirePackage{pbox}

\RequirePackage{geometry}
%\geometry{top=3cm, bottom=3cm, left=4cm, right=3cm}

\RequirePackage{polyglossia}
\setdefaultlanguage{english}
\PolyglossiaSetup{english}{indentfirst=true}

\RequirePackage[style=apra,natbib=true,backend=biber]{biblatex}

% Custom standard header (i.e.)
\makepagestyle{standard}
\makeevenhead{standard}{}{}{\thepage}
\makeoddhead{standard}{}{}{\thepage}

% A custom \maketitle command that makes the APRA title page.
\renewcommand{\maketitle}{
  \newgeometry{top=2.5cm, bottom=2.5cm, left=3.5cm, right=2.5cm}
  \thispagestyle{empty}
  
  \begin{SingleSpace}
    {\centering \large \MakeTextUppercase{\theuniversity} \vskip 0.5em}
    {\centering \theschool \par}
  \end{SingleSpace}
  
  \begin{OnehalfSpace}
    \vfill
    {\centering \Huge \thetitle \par}
    \vfill
  \end{OnehalfSpace}

  \begin{DoubleSpace}
    \hfill
    \begin{tabular}{l}
      Professor: \theprofessor \\
      Student: \theauthor \\
      Student ID: \thestudentid \\
      \thecourse \\
      \thelocation, \thedate \\
    \end{tabular}
  \end{DoubleSpace}
  
  \mainmatter
  \restoregeometry
  \thispagestyle{empty}
  
  % The command to set the format of figures has to go here,
  % because apparently \mainmatter changes it for me.
  \renewcommand{\thefigure}{\arabic{figure}}
  
  % Set the line spacing: \SingleSpace, \OnehalfSpacing, or \DoubleSpace
  \OnehalfSpacing
  \pagestyle{standard}
}

% The following commands are for the data that fill the title page:

% No need to crash the compilation just because
% one of these is missing...
\gdef\theuniversity{---add university---}
\gdef\theschool{---add school---}
\gdef\theprofessor{---add professor---}
\gdef\thestudentid{---add student id---}
\gdef\thecourse{---add course---}
\gdef\thelocation{---add location---}
\gdef\thetitle{---add title---}
\gdef\thedate{---add date---}
\gdef\theauthor{---add author---}

\newcommand{\university}[1]{\gdef\theuniversity{#1}}
\newcommand{\school}[1]{\gdef\theschool{#1}}
\newcommand{\professor}[1]{\gdef\theprofessor{#1}}
\newcommand{\studentid}[1]{\gdef\thestudentid{#1}}
\newcommand{\course}[1]{\gdef\thecourse{#1}}
\newcommand{\location}[1]{\gdef\thelocation{#1}}

% Footnote adjustments:

% The font size for footnotes:
\renewcommand*{\footnotesize}{\fontsize{11}{13.3}\selectfont}

% Set the footnote rule to 5cm, as required by APRA's rules (code taken from latex.dtx).
\def\footnoterule{\vrule height 12pt depth 0pt width 0pt%
                            % Add a 12-pt-high,0-width vertical line to
                            % separate the rule line from the body text.
  \kern-3\p@
  \hrule \@width 5cm \kern 2.6\p@%% the \hrule is .4pt high
  \vrule height 0pt depth 6pt width 0pt%
                            % Add a 6-pt-high,0-width vertical line to
                            % separate the rule line from the footnote
                            % text.
    }

% Add a space between the footnote mark and the footnote text (code taken from book.cls).
\renewcommand\@makefntext[1]{%
    \parindent 1em%
    \noindent
    \hb@xt@1.8em{\hss\@makefnmark}~#1} % I added the space right here, before #1.
    
% Fix some numbering issues. Suitable for texts without chapters.
\setsecnumformat{\csname the#1\endcsname.~}
\counterwithout{section}{chapter}
\setsecnumdepth{paragraph}
\settocdepth{subsubsection}

% Linebreaking and that kind of thing should be sloppy.
\sloppy

% The following commands simply remove the parentheses from citations
% that occur in footnotes.
\DeclareCiteCommand{\smartcite}[\iffootnote\textnormal\mkbibfootnote]
  {\usebibmacro{prenote}}
  {\usebibmacro{citeindex}%
   \usebibmacro{cite}}
  {\multicitedelim}
  {\usebibmacro{postnote}}

\DeclareMultiCiteCommand{\smartcites}
    [\iffootnote\textnormal\mkbibfootnote]{\smartcite}{\multicitedelim}

% Specifies U.S.-style punctuation in citations.
\DefineBibliographyExtras{english}{%
  \uspunctuation%
}

% The following commands make \autocite available to LyX
\let\oldcite\citep
\let\citep\autocite

% The following code makes the regular (unstarred) version of
% \tableofcontents behave as if it were the starred version.
% (For whatever reason, I can't figure out how to make LyX use the
% starred version.)
\renewcommand{\tableofcontents}{%
  \@ifstar{\mem@tableofcontents{01}}
          {\mem@tableofcontents{01}}%
}