%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Imperial College London Letterhead
% LaTeX Class
% Version 1.0 (February 22, 2024)
%
% For current versions and to report
% issues, please see:
% https://github.com/ImperialCollegeLondon/imperial_latex_templates
%
% © Imperial College London, 2024. This template, including logo and fonts, is 
% for use of Imperial staff and students only for university business. All rights 
% reserved to the copyright owners.
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%----------------------------------------------------------------------------------------
%	CLASS CONFIGURATION
%----------------------------------------------------------------------------------------

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{ImperialLetterhead}[2024/02/22 Imperial College London Letterhead Class v1.0]

\usepackage{etoolbox} % Required for conditional logic and easily changing commands

\newtoggle{print} % Create toggle for a class option
\settoggle{print}{false} % Default value for the class option
\DeclareOption{print}{\settoggle{print}{true}} % Set the class option toggle if the class option was used in the template

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{article}} % Pass through any extra options specified to the base class
\ProcessOptions\relax % Process class options

\LoadClass{article} % Load the base class

%----------------------------------------------------------------------------------------
%	REQUIRED PACKAGES AND MISC CONFIGURATIONS
%----------------------------------------------------------------------------------------

\usepackage{graphicx} % Required for including images
\graphicspath{{Images/}{./}} % Specifies where to look for included images (trailing slash required)

\usepackage{fontsize} % Allows changing the default font size to an arbitrary value
\changefontsize[12.5pt]{10pt} % Change the default font size and baselineskip

\setlength{\parindent}{0pt} % Paragraph indentation
\setlength{\parskip}{12.5pt} % Vertical space between paragraphs

\usepackage{tabto} % For tabbing text fixed distances

\raggedright % Suppress justification

\usepackage{url} % Automatically wrap URLs in \url{}
\appto\UrlNoBreaks{\do\:} % Stop URL breaks happening at colons

%----------------------------------------------------------------------------------------
%	MARGINS
%----------------------------------------------------------------------------------------

\usepackage[
	a4paper, % Paper size
	top=5.25cm, % Top margin
	bottom=3cm, % Bottom margin
	left=2.5cm, % Left margin
	right=2.5cm, % Right margin
	footskip=1cm, % Space from the bottom margin to the baseline of the footer
	headsep=0.75cm, % Space from the top margin to the baseline of the header
	headheight=3.5cm, % Height of the header
	%showframe % Uncomment to show frames around the margins for debugging purposes
]{geometry}

%----------------------------------------------------------------------------------------
%	FONTS
%----------------------------------------------------------------------------------------

\usepackage{fontspec} % Required for specifying custom fonts

\defaultfontfeatures{Ligatures=TeX} % To support LaTeX ligatures (e.g. `` and --)
\defaultfontfeatures{Path=Fonts/} % Specify the location of font files

% The default font family
\setmainfont{ImperialSansText}[
	UprightFont=*-Regular.ttf,
	BoldFont=*-Bold.ttf
]

% The monospace font used explicitly with \texttt{}/\ttfamily
\setmonofont{ImperialSansText}[
	UprightFont=*-Regular.ttf,
	BoldFont=*-Bold.ttf
]

\newfontfamily{\ImperialSansMedium}{ImperialSansText}[
	UprightFont=*-Medium.ttf,
	BoldFont=*-Bold.ttf,
]

% Define the other Imperial Sans font weights
\newfontface{\ImperialSansExtraBold}{ImperialSansText-Extrabold.ttf}
\newfontface{\ImperialSansExtraLight}{ImperialSansText-Extralight.ttf}
\newfontface{\ImperialSansSemiBold}{ImperialSansText-Semibold.ttf}
\newfontface{\ImperialSansLight}{ImperialSansText-Light.ttf}

%----------------------------------------------------------------------------------------
%	HEADERS AND FOOTERS
%----------------------------------------------------------------------------------------

\usepackage{fancyhdr} % Required for customizing headers and footers
\pagestyle{fancy} % Enable custom headers and footers

\renewcommand{\headrulewidth}{0pt} % Top horizontal rule thickness

\fancyhf{} % Clear default headers/footers

\fancyhead[L]{\vspace{1cm}\iftoggle{print}{\includegraphics[width=6cm]{ICL_Logo_Blue_CMYK.pdf}}{\includegraphics[width=6cm]{ICL_Logo_Blue_RGB.pdf}}} % Left header
\fancyhead[C]{} % Center header
\fancyhead[R]{% Right header
	\parbox[bottom][3.5cm][t]{6cm}{% Box holding the letter from information with a fixed width and height
		\raggedright% Suppress justification and hyphenation
		\color{ICLBlue}\fontsize{8pt}{10pt}\selectfont% Font color and size
		\textbf{\department}\\
		\textbf{Imperial College London}
		
		\ifnumless{\thepage}{2}{ % Only show department and institution on pages 2+
			\bigskip % Vertical whitespace
			
			\ImperialSansMedium % All subsequent lines to be at medium font weight
			
			\sendername\\
			\jobtitle\\
			\address\\
			\expandafter\ifstrequal\expandafter{\phoneinternal}{}{}{\contactinfo{T}{\phoneinternal}\\}
			\expandafter\ifstrequal\expandafter{\mobileinternal}{}{}{\contactinfo{M}{\mobileinternal}\\}
			\expandafter\ifstrequal\expandafter{\emailinternal}{}{}{\contactinfo{E}{\href{mailto:\emailinternal}{\emailinternal}}\\}
			\expandafter\ifstrequal\expandafter{\webinternal}{}{}{\contactinfo{W}{{\renewcommand\UrlFont{\ImperialSansMedium}\url{\webinternal}}}\\}
			\expandafter\ifstrequal\expandafter{\extracontactlinesinternal}{}{}{\extracontactlinesinternal}
		}{}
	}%
}

% Expand the headers and footers into the left and right margins
\fancyheadoffset[L]{1.5cm}
\fancyheadoffset[R]{1.5cm} 
\fancyfootoffset[L]{1.5cm} 
\fancyfootoffset[R]{1.5cm} 

\fancyfoot[L]{% Left footer
	\color{ICLBlue} % Color
	\renewcommand\arraystretch{2.5} % Increase table row heights
	\setlength\extrarowheight{-2pt} % Vertically center the content of table cells
	\begin{tabular}{@{} L{0.499\linewidth} @{} | @{} R{0.499\linewidth} @{}}
		\hline % Top rule
		Imperial College London & \href{https://imperial.ac.uk}{imperial.ac.uk}\\
		\hline % Bottom rule
	\end{tabular}
}
\fancyfoot[C]{} % Center footer
\fancyfoot[R]{} % Right footer

%----------------------------------------------------------------------------------------
%	COLORS
%----------------------------------------------------------------------------------------

% Convert colors to CMYK space if the print class option was used
\iftoggle{print}{
	\usepackage[usenames, svgnames, cmyk]{xcolor} % Required for defining and using custom colors
}{
	\usepackage[usenames, svgnames]{xcolor} % Required for defining and using custom colors
}

\definecolor{ICLBlue}{RGB}{0, 0, 205}

%----------------------------------------------------------------------------------------
%	TABLES
%----------------------------------------------------------------------------------------

\usepackage{booktabs} % Required for better horizontal rules in tables

\usepackage{array} % Required for manipulating table columns

\newcolumntype{R}[1]{>{\raggedleft\arraybackslash}p{#1}} % Define a new right-aligned paragraph column type
\newcolumntype{L}[1]{>{\raggedright\arraybackslash}p{#1}} % Define a new left-aligned (no justification) paragraph column type
\newcolumntype{C}[1]{>{\centering\arraybackslash}p{#1}} % Define a new centered paragraph column type

\setlength{\arrayrulewidth}{1pt} % Thickness of table rules

%----------------------------------------------------------------------------------------
%	LISTS
%----------------------------------------------------------------------------------------

\usepackage{enumitem} % Required for list customization

\setlist{itemsep=0pt, topsep=0pt} % Customize spacing around and inside lists

%----------------------------------------------------------------------------------------
%	LINKS
%----------------------------------------------------------------------------------------

\usepackage{hyperref} % Required for links

\hypersetup{
	colorlinks=true, % Whether to color the text of links
	urlcolor=ICLBlue, % Color for \url and \href links
	linkcolor=ICLBlue, % Color for \nameref links
	citecolor=ICLBlue, % Color of reference citations
	hidelinks, % Hide the default boxes around links
}

%----------------------------------------------------------------------------------------
%	LETTER ADDRESSEE
%----------------------------------------------------------------------------------------

\newcommand{\letterto}[1]{
	\begingroup
		\ImperialSansMedium % Medium font weight
		\fontsize{8pt}{10pt}\selectfont % Font size
		\color{ICLBlue} % Text color
		
		#1 % Letter addressee text
		
		\bigskip\bigskip\smallskip % Vertical whitespace
	\endgroup
}

%----------------------------------------------------------------------------------------
%	LETTER TITLE
%----------------------------------------------------------------------------------------

\newcommand{\lettertitle}[1]{{\large\textbf{#1}}} % For outputting a letter title

%----------------------------------------------------------------------------------------
%	LETTER SIGNATURE
%----------------------------------------------------------------------------------------

\newcommand{\signatureimage}[2][1.5cm]{\includegraphics[height=#1]{#2}} % Command to output a signature image which takes an optional parameter for the height of the image

%----------------------------------------------------------------------------------------
%	SENDER BLOCK COMMANDS
%----------------------------------------------------------------------------------------

\newcommand{\contactinfo}[2]{\textbf{#1}\tabto{10pt}#2} % Command to output a line of contact information in the sender block

%----------------------------------------------------------------------------------------
%	CUSTOM COMMANDS
%----------------------------------------------------------------------------------------

\newcommand{\letterfrom}[1]{\renewcommand{\letterfrom}{#1}}
\newcommand{\department}[1]{\renewcommand{\department}{#1}}
\newcommand{\sendername}[1]{\renewcommand{\sendername}{#1}}
\newcommand{\jobtitle}[1]{\renewcommand{\jobtitle}{#1}}
\newcommand{\address}[1]{\renewcommand{\address}{#1}}

\newcommand{\phoneinternal}{}\newcommand{\phone}[1]{\renewcommand{\phoneinternal}{#1}}
\newcommand{\mobileinternal}{}\newcommand{\mobile}[1]{\renewcommand{\mobileinternal}{#1}}
\newcommand{\emailinternal}{}\newcommand{\email}[1]{\renewcommand{\emailinternal}{#1}}
\newcommand{\webinternal}{}\newcommand{\web}[1]{\renewcommand{\webinternal}{#1}}
\newcommand{\extracontactlinesinternal}{}\newcommand{\extracontactlines}[1]{\renewcommand{\extracontactlinesinternal}{#1}}
