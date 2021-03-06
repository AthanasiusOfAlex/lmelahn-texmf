% !TEX encoding = UTF-8 Unicode
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% APRA Thesis Template for LyX
% Class File
%
% Authors:
% Louis Melahn, L.C.
%
% Class license:
% LPPL v1.3c (http://www.latex-project.org/lppl) OR (at your option)
% any later version of the LPPL OR (at your option)
% GPLV3 (https://www.gnu.org/licenses/gpl.html) OR (at your option)
% any later version of the GPL.
% Moreover, no conditions are placed on distributing modified versions.
% (In particular, you may modify and distribute the work as if you are the
% Current Maintainer, as defined by the LPPL v. 1.3c or any later version.)
% If you license your modified work with the LPPL, you may (at your option)
% also grant this permission in your modified versions, but it is not required
% for you to do so.
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\providecommand{\filename}{apralyx}
\providecommand{\fileversion}{$Revision: 0.2 $}
\providecommand{\filedate}{2017/02/17}
\providecommand{\fileauthor}{$Author: Louis Melahn, L.C.$}

% This will allow me to add periods to all the sections.
\newcommand*{\@addPeriodsToSections}{
  \setsecnumformat{\addperiod{\csname the##1\endcsname}\quad}
  \renewcommand{\cftpartaftersnum}{.}
  \renewcommand{\cftchapteraftersnum}{.}
  \renewcommand{\cftsectionaftersnum}{.}
  
  \@versionSpecificPeriodCommands
}

\newcommand*{\@versionSpecificPeriodCommands}{}
\newcommand*{\@versionSpecificSectionFormatting}{}

\NeedsTeXFormat{LaTeX2e}[1995/12/01]
\ProvidesClass{\filename}[\filedate \fileversion %
  : Base class for the Pontifical Regina Apostolorum %
   Athenaeum, based on memoir]

\newif\ifapralyx@article
\newif\ifapralyx@thesis

\DeclareOption{12pt}{\PassOptionsToClass{\CurrentOption}{memoir}}
\DeclareOption{a4paper}{\PassOptionsToClass{\CurrentOption}{memoir}}
\DeclareOption{oneside}{\PassOptionsToClass{\CurrentOption}{memoir}}
\DeclareOption{openany}{\PassOptionsToClass{\CurrentOption}{memoir}}
\DeclareOption{xetex}{\PassOptionsToClass{\CurrentOption}{memoir}}
\DeclareOption{addperiods}{}
\DeclareOption{dontaddperiods}{\renewcommand*{\@addPeriodsToSections}{}}
\DeclareOption{article}{\apralyx@articletrue\apralyx@thesisfalse}
\DeclareOption{thesis}{\apralyx@thesistrue\apralyx@articlefalse}

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{memoir}}

% These are the default options.
\ExecuteOptions{12pt,a4paper,oneside,openany,xetex,indexfirst,addperiods,article}

%Process the options....
\ProcessOptions\relax

% Define version-specific things.
% Make sure these follow \ProcessOptions.
\ifapralyx@article
  \PassOptionsToClass{article}{memoir}
  \renewcommand*{\@versionSpecificPeriodCommands}{
    \renewcommand*{\printchapternum}{\chaptitlefont\thechapter.\quad}
  }
  \renewcommand*{\@versionSpecificSectionFormatting}{
    \counterwithout{section}{chapter}
    \setsecnumdepth{paragraph}
    \settocdepth{subsubsection}
  }
\fi

\ifapralyx@thesis
  \renewcommand*{\@versionSpecificPeriodCommands}{}
  \renewcommand*{\@versionSpecificSectionFormatting}{}
\fi



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

% Add periods to sections, as requested by options.
\@addPeriodsToSections

% The following code makes the regular (unstarred) version of
% \tableofcontents behave as if it were the starred version.
% (For whatever reason, I can't figure out how to make LyX use the
% starred version.)
\renewcommand{\tableofcontents}{%
  \@ifstar{\mem@tableofcontents{01}}
          {\mem@tableofcontents{01}}%
}

% Make sure that chapter numbers reset after parts, and sections after chapters.
\@addtoreset{chapter}{part}
\@addtoreset{section}{chapter}

%Sets what gets section numbers.
\setsecnumdepth{subsection}
