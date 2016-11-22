% !TEX encoding = UTF-8 Unicode
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% APRA Thesis Tamplate
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
% Moreover, modified versions of this Work may be FREELY DISTRIBUTED
% WITHOUT RESTRICTION OR CONDITION.
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\def\filename{aprathesis}
\def\fileversion{$Revision: 0.99.0 $}
\def\filedate{2016/10/23}
\def\fileauthor{$Author: Louis Melahn, L.C.$}
\def\baseclass{memoir}

\NeedsTeXFormat{LaTeX2e}[1996/12/01]

\ProvidesClass{\filename}[\filedate \fileversion %
  : APRA thesis template, using Memoir.]

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Initial setup
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% The following packages need to be loaded at the very beginning,
% because we will be using them.
\RequirePackage{etoolbox}
\RequirePackage{xparse}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Options
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% This will allow me to add periods to all the sections.
% I have to put the code here
\newcommand*{\@addPeriodsToSections}{
  \setsecnumformat{\addperiod{\csname the##1\endcsname}\quad}
  \renewcommand{\cftpartaftersnum}{.}
  \renewcommand{\cftchapteraftersnum}{.}
  \renewcommand{\cftsectionaftersnum}{.}
  
  \@versionSpecificPeriodCommands
}

% A hook for thearticle-based version
\newcommand*{\@versionSpecificPeriodCommands}{}
\newcommand*{\@versionSpecificSectionFormatting}{}

% Define booleans for using the article-based version
\newbool{isArticle}
\newbool{isThesis}

% The following code will set the desired defaults for the base class,
% when no options are specified. This class will accept any global option
% that the base class accepts.
% If custom options are needed, they should also go here.
\DeclareOption{a4paper}{
    \PassOptionsToClass{\CurrentOption}{\baseclass}
    \PassOptionsToPackage{\CurrentOption}{geometry}
}
\DeclareOption{letter}{
    \PassOptionsToClass{\CurrentOption}{\baseclass}
    \PassOptionsToPackage{\CurrentOption}{geometry}
}
\DeclareOption{12pt}{\PassOptionsToClass{\CurrentOption}{\baseclass}}
\DeclareOption{oneside}{\PassOptionsToClass{\CurrentOption}{\baseclass}}
\DeclareOption{openany}{\PassOptionsToClass{\CurrentOption}{\baseclass}}
\DeclareOption{addperiods}{}
\DeclareOption{noperiods}{\renewcommand*{\@addPeriodsToSections}{}}
\DeclareOption{article}{\booltrue{isArticle}\boolfalse{isThesis}}
\DeclareOption{thesis}{\boolfalse{isArticle}\booltrue{isThesis}}
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{\baseclass}}

% The following are the default options:
\ExecuteOptions{a4paper,12pt,oneside,openany,xetex,indexfirst,addperiods,thesis}

% Now, process the options.
\ProcessOptions\relax

% Define version-specific actions.
% Make sure these follow \ProcessOptions.
\ifbool{isArticle}{
    \PassOptionsToClass{article}{memoir}
    \renewcommand*{\@versionSpecificPeriodCommands}{
        \renewcommand*{\printchapternum}{\chaptitlefont\thechapter.\quad}
    }
}{
    \renewcommand*{\@versionSpecificSectionFormatting}{
        \counterwithout{section}{chapter}
        \setsecnumdepth{paragraph}
        \settocdepth{subsubsection}
    }
}

\ifbool{isThesis}{
    \renewcommand*{\@versionSpecificPeriodCommands}{}
    \renewcommand*{\@versionSpecificSectionFormatting}{}
}{}

% Finally, load the base class.
\LoadClass{\baseclass}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Set up hyperref
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\RequirePackage{hyperref}

\hypersetup{
  colorlinks,
  bookmarksnumbered,
  bookmarkstype={toc},
  bookmarksopen={true},
  bookmarksopenlevel={1},
  pdfstartview={FitH},
  citecolor={black},
  linkcolor={black},
  urlcolor={black},
  pdfpagemode={UseOutlines},
  breaklinks=true
  }
  
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Margins
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\RequirePackage[top=3cm,bottom=3cm,left=4cm,right=3cm]{geometry}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Fonts
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Set up fonts in a separate package.
\RequirePackage{aprathesisfonts}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Packages needed for layout of title page
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\RequirePackage{pbox}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Miscellaneous layout
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Don’t try too hard to typeset things neatly.
% The APRA norms do not permit a publication-quality book.
\sloppy
\raggedbottom

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Line spacing
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Double spacing by default
\DoubleSpacing

%The following makes quote and quotation environments single spaced.
\expandafter\def\expandafter\quote\expandafter{\quote\SingleSpacing}
\expandafter\def\expandafter\quotation\expandafter{\quotation\SingleSpacing}


% Customize the \tableofcontents command so that
% (1) The contents don’t appear in the contents (use the starred version).
% (2) It is single spaced
% (3) There are no page numbers.

\let\old@tableofcontents\tableofcontents

\renewcommand*{\tableofcontents}{
    \clearpage                       % Otherwise \pagestyle affects the previous page.
    \begin{SingleSpacing}
    {                                % Enclosed in braces so that re-definition is temporary.
      \pagestyle{empty}              % Removes numbers from middle pages.
      \makepagestyle{plain} % Re-definition removes numbers from first page.
      \old@tableofcontents*
      \thispagestyle{empty}          % Removes numbers from last page.
    }
    \end{SingleSpacing}
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Title Page
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Set up the title page. In this section, I will us gdef, because
%I want the redefinitions to be unconditional.
\newcommand*{\university}[1]{\gdef\theuniversity{#1}}
\newcommand*{\school}[1]{\gdef\theschool{#1}}
\newcommand*{\subtitle}[1]{\gdef\thesubtitle{#1}}
\newcommand*{\professor}[1]{\gdef\theprofessor{#1}}
\newcommand*{\studentid}[1]{\gdef\thestudentid{#1}}
\newcommand*{\coursenumber}[1]{\gdef\thecoursenumber{#1}}
\newcommand*{\coursename}[1]{\gdef\thecoursename{#1}}
\newcommand*{\location}[1]{\gdef\thelocation{#1}}

%The following will avoid compile errors, with a gentle reminder to
%provide the necessary information
\university{UNIVERSITY}
\school{SCHOOL}
\title{TITLE}
\undef\thesubtitle % The subtitle is optional.
\professor{PROFESSOR}
\author{AUTHOR}
\studentid{STUDENT ID}
\coursenumber{COURSE NUMBER}
\coursename{COURSE NAME}
\location{LOCATION}
\date{DATE}

% Now the \maketitle command
\gdef\maketitle{

    \thispagestyle{empty}
    
    \newgeometry{top=2.5cm, bottom=2.5cm, left=3.5cm, right=2.5cm}

    {
    

        \setlength{\parindent}{0pt}
  
        \begin{center}
            \MakeUppercase{ \Large \theuniversity } \par \vspace{6pt}
            { \Large \theschool }
        \end{center}

        \vfill

        \begin{center}
            { \HUGE \thetitle\ifundef{\thesubtitle}{\par}{: \par \vspace{12pt} } }
            \ifundef{\thesubtitle}{}{ { \Large \begin{Spacing}{1.1} \thesubtitle \end{Spacing} } } 
        \end{center}
  
        \vfill
    
        \begin{Spacing}{1.3} 
            \hfill  {
                \large \pbox{\textwidth} {
                    Professor: \theprofessor\\
                    Student: \theauthor\\
                    Student ID: \thestudentid\\
                    \thecoursenumber{} \thecoursename\\
                    \thelocation, \thedate
                }
          }
      \end{Spacing}
      
    }
    
    \restoregeometry
    
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Footnote adjustments
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 
% Prevents footnotes from resetting.
\RequirePackage{remreset}
\@removefromreset{footnote}{chapter}

% Force the footnotes properly to the bottom.
\RequirePackage[bottom]{footmisc}

% Be sure that my customizations come after any footnote packages:

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
 
% To add space between footnotes, change footnotesep: \setlength{footnotesep}{\baselineskip}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Heading adjustments
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\@addPeriodsToSections

% Make sure that chapter numbers reset after parts, and sections after chapters.
\@addtoreset{chapter}{part}
\@addtoreset{section}{chapter}

%Sets what gets section numbers. 
%By default, this is set at the level of the subsection, but it can be set in the document.
\setsecnumdepth{subsection}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Language
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%TODO: allow different languages in options.
%%TODO: The headers need to be cleared
%%TODO: Chapter titles should be all caps.
\RequirePackage{csquotes}
\RequirePackage{polyglossia}
\setdefaultlanguage{english}
\PolyglossiaSetup{english}{indentfirst=true}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Bibliography
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% We will use biblates. We will use natbib, so as to make it easy to
% integrate with LyX.
\RequirePackage[style=apra,natbib=true,backend=biber]{biblatex}

% Specifies U.S.-style punctuation in citations.
\DefineBibliographyExtras{english}{%
  \uspunctuation%
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Headers
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Custom standard header (i.e.)
\makepagestyle{standard}
\makeevenhead{standard}{}{}{\thepage}
\makeoddhead{standard}{}{}{\thepage}

%Customize quote and quotation
%\expandafter\def\expandafter\quote\expandafter{\quote\begin{SingleSpacing}}
%\expandafter\def\expandafter\quote\expandafter{\quote\begin{SingleSpacing}}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Miscellaneous
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\RequirePackage{environ}

