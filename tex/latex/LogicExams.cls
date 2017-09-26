% !TEX encoding = UTF-8 Unicode

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{LogicExams}[2016/09/30 Logic Exams]

\LoadClass[addpoints,11pt]{exam}

\RequirePackage{polyglossia}
\setmainlanguage{italian}

\pointpoints{punto}{punti}

%\RequirePackage{fontspec}
%\setmainfont[Mapping=tex-text,Numbers=OldStyle]{Linux Libertine O}
%\setsansfont[Mapping=tex-text]{Linux Biolinum O}
%\setmonofont{Linux Libertine O}

\RequirePackage{lmelahnDefaultFonts}

\RequirePackage{environ}
\RequirePackage{etoolbox}
\RequirePackage{xparse}
\RequirePackage{footnote}
\RequirePackage{pbox}
\RequirePackage{hanging}

\undef\testForQuestions

\NewEnviron{instructions}{%
  \begin{center}%
  \ifdef{\testForQuestions}{\hspace{-0.25in}}{}%  %% All this does is ensure that
                                                  %% the instructions remain properly
                                                  %% centered even when inside a
                                                  %% "questions" environment.
  \fbox{\fbox{\parbox{5.5in}{\centering \BODY}}}%
  \end{center}
  \par\noindent\ignorespacesafterend%\vspace{-0.25in}
}

\let\oldquestions\questions

\RenewEnviron{questions}{%
  \def\testForQuestions{QUESTIONS}
  \begin{oldquestions}\BODY\end{oldquestions}
  \undef\testForQuestions
}

\newcommand*{\testSection}[1]{\section*{%
  \ifdef{\testForQuestions}{\hspace{-0.25in}}{}%
  #1%
}}

\newcommand*{\testSubsection}[1]{\subsection*{%
  \ifdef{\testForQuestions}{\hspace{-0.25in}}{}%
  #1%
}}

\newcommand*{\personalData}[1]{%
  \noindent\makebox[\textwidth]{#1:\enspace\hrulefill}\par\vspace{0.1in}%
}

\undef\PRINTMYANSWERS

\let\oldprintanswers\printanswers
\renewcommand*{\printanswers}{\def\PRINTMYANSWERS{YES}\oldprintanswers}

\let\oldnoprintanswers\noprintanswers
\renewcommand*{\noprintanswers}{\undef\PRINTMYANSWERS\oldnoprintanswers}

\makeatletter

\DeclareDocumentCommand \answerLine { o } {%
  \vspace*{0.1in}%
  \IfNoValueTF {#1} {%
  }{%
    \ifdef{\PRINTMYANSWERS}{%
      \makebox[0pt][l]{\hspace*{6pt}\raisebox{3pt}{#1}}%
    }{}%
  }%
  \hrulefill\par
}

\makeatother

\newcommand*{\questionDef}[1]{\question\textbf{#1}: }
\newcommand*{\partDef}[1]{\part\textbf{#1}: }

\newcounter{saveQuestion}

\newcommand*{\saveQuestion}{%
	\setcounter{saveQuestion}{\value{question}}%
}
\newcommand*{\restoreQuestion}{%
	\setcounter{question}{\value{saveQuestion}}%
}

\newcommand*{\separator}{\begin{center}{\par\vspace{-0.15in}\rule{1in}{1pt}\vspace{-0.1in}\par}\end{center}}

\pagestyle{plain}

%\printanswers
\noprintanswers

\NewEnviron{EnglishText}{}
\NewEnviron{ItalianText}{}


\newcommand*{\useEnglish}{%
    \DeclareDocumentCommand\englishText{m}{##1}%
    \DeclareDocumentCommand\italianText{m}{}%
    \RenewEnviron{EnglishText}{\BODY}%
    \RenewEnviron{ItalianText}{}%
}

\newcommand*{\useItalian}{%
    \DeclareDocumentCommand\italianText{m}{##1}%
    \DeclareDocumentCommand\englishText{m}{}%
    \RenewEnviron{ItalianText}{\BODY}%
    \RenewEnviron{EnglishText}{}%
}

\useItalian
