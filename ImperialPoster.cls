%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Imperial College London Poster
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
\ProvidesClass{ImperialPoster}[2024/02/22 Imperial College London Poster Class v1.0]

\usepackage{etoolbox} % Required for conditional logic and easily changing commands

\newtoggle{print} % Create toggle for a class option
\settoggle{print}{false} % Default value for the class option
\DeclareOption{print}{\settoggle{print}{true}} % Set the class option toggle if the class option was used in the template

\newtoggle{a1papersize} % Create toggle for a class option
\settoggle{a1papersize}{false} % Default value for the class option
\DeclareOption{a1papersize}{\settoggle{a1papersize}{true}} % Set the class option toggle if the class option was used in the template

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{article}} % Pass through any extra options specified to the base class
\ProcessOptions\relax % Process class options

\LoadClass{article} % Load the base class

%----------------------------------------------------------------------------------------
%	REQUIRED PACKAGES AND MISC CONFIGURATIONS
%----------------------------------------------------------------------------------------

\usepackage{graphicx} % Required for including images
\graphicspath{{Images/}{./}} % Specifies where to look for included images (trailing slash required)

\usepackage{anyfontsize} % Allows font sizes at arbitrary values

\usepackage{fontsize} % Allows changing the default font size to an arbitrary value
\iftoggle{a1papersize}{ % If the A1 paper size class option has been specified
	\changefontsize[32.5pt]{26pt} % Change the default font size and baselineskip for A1 paper size
	\setlength{\parskip}{32.5pt} % Vertical space between paragraphs
}{ % Otherwise default to A0 paper size settings
	\changefontsize[48pt]{36pt} % Change the default font size and baselineskip for A0 paper size
	\setlength{\parskip}{48pt} % Vertical space between paragraphs
}

\setlength{\parindent}{0pt} % Paragraph indentation

\raggedright % Suppress justification

% Style quotations
\renewenvironment{quote}{
	\ImperialSansMedium\iftoggle{a1papersize}{\fontsize{42pt}{52.5pt}}{\fontsize{60pt}{75pt}}\selectfont % Conditional font size based on paper size
}{
	\par\vspace{0.5\baselineskip} % Vertical whitespace after the quote
}

\usepackage{float} % Allows more precisely positioning floats e.g. \begin{figure}[H]

\newcommand{\largepercent}[1]{{\ImperialSansExtraBold\iftoggle{a1papersize}{\fontsize{150pt}{150pt}}{\fontsize{213pt}{213pt}}\selectfont\textcolor{ICLDarkBlue}{#1}}} % Styling of the large percentage value used to highlight important numbers

%----------------------------------------------------------------------------------------
%	MARGINS
%----------------------------------------------------------------------------------------

\usepackage[
	\iftoggle{a1papersize}{a1paper}{a0paper}, % Conditional paper size with A0 as the default
	top=\iftoggle{a1papersize}{5.6cm}{7.5cm}, % Top margin, conditional on paper size
	bottom=\iftoggle{a1papersize}{5.6cm}{7cm}, % Bottom margin, conditional on paper size
	left=2.5cm, % Left margin
	right=2.5cm, % Right margin
	footskip=\iftoggle{a1papersize}{2.3cm}{2.4cm}, % Space from the bottom margin to the baseline of the footer, conditional on paper size
	headsep=\iftoggle{a1papersize}{1.3cm}{1.5cm}, % Space from the top margin to the baseline of the header, conditional on paper size
	headheight=\iftoggle{a1papersize}{4.1cm}{5.75cm}, % Height of the header
	%showframe % Uncomment to show frames around the margins for debugging purposes
]{geometry}

\setlength{\columnsep}{1cm} % Horizontal space between columns

%----------------------------------------------------------------------------------------
%	COLUMNS
%----------------------------------------------------------------------------------------

\usepackage{multicol} % Required for outputting content in multiple columns on demand

\raggedcolumns % Don't stretch column content vertically so bottoms of columns align

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

% Define the other Imperial Sans font weights
\newfontface{\ImperialSansExtraBold}{ImperialSansText-Extrabold.ttf}
\newfontface{\ImperialSansExtraLight}{ImperialSansText-Extralight.ttf}
\newfontface{\ImperialSansSemiBold}{ImperialSansText-Semibold.ttf}
\newfontface{\ImperialSansMedium}{ImperialSansText-Medium.ttf}
\newfontface{\ImperialSansLight}{ImperialSansText-Light.ttf}

% Both {\small <text>\par} and \smalltext{<text>} will have the same effect in the template, with the latter being easier to use and the former being a standard LaTeX command
\renewcommand{\small}{%
	\iftoggle{a1papersize}{%
		\setlength{\parskip}{20pt}\fontsize{16pt}{20pt}\selectfont% A1 paper size font size
	}{%
		\setlength{\parskip}{30pt}\fontsize{24pt}{30pt}\selectfont% A0 paper size font size
	}%
}
\newcommand{\smalltext}[1]{{%
	\iftoggle{a1papersize}{%
		\setlength{\parskip}{20pt}\fontsize{16pt}{20pt}\selectfont% A1 paper size font size
	}{%
		\setlength{\parskip}{30pt}\fontsize{24pt}{30pt}\selectfont}% A0 paper size font size
	#1\par% The text itself followed by a \par for correct line spacing
}}

%----------------------------------------------------------------------------------------
%	HEADERS AND FOOTERS
%----------------------------------------------------------------------------------------

\usepackage{fancyhdr} % Required for customizing headers and footers
\pagestyle{fancy} % Enable custom headers and footers

\renewcommand{\headrulewidth}{0pt} % Top horizontal rule thickness
\renewcommand{\footrulewidth}{2pt} % Top horizontal rule thickness
\let\oldfootrule\footrule% Copy original footer rule command into \oldfootrule
\renewcommand{\footrule}{{\color{ICLBlue}\oldfootrule}} % Add color to footer rules

\fancyhf{} % Clear default headers/footers

\fancyhead[L]{% Left header
	\iftoggle{print}{% Use the CMYK logo for print mode
		\includegraphics[height=\iftoggle{a1papersize}{1.7615cm}{2.4126cm}]{ICL_Logo_Blue_CMYK.pdf}%
	}{% Otherwise use the RGB logo for screens
		\includegraphics[height=\iftoggle{a1papersize}{1.7615cm}{2.4126cm}]{ICL_Logo_Blue_RGB.pdf}%
	}%
	\expandafter\ifstrequal\expandafter{\coauthorlogosinternal}{}{}{\coauthorlogosinternal}% If coauthor logos were specified by the user
}
\fancyhead[C]{} % Center header
\fancyhead[R]{} % Right header

\fancyfoot[L]{% Left footer
	\color{ICLBlue}% Color
	\iftoggle{a1papersize}{\fontsize{32pt}{32pt}\selectfont}{\fontsize{45pt}{45pt}\selectfont}% Font size
	\raisebox{-1.5cm}{Imperial College London}\hfill\raisebox{-1.25cm}{imperial.ac.uk}% Footer text
}
\fancyfoot[C]{} % Center footer
\fancyfoot[R]{} % Right footer

%----------------------------------------------------------------------------------------
%	SECTIONS
%----------------------------------------------------------------------------------------

\usepackage{titlesec} % Required for modifying sections

\titleformat
	{\section} % Section type being modified
	[block] % Section layout type, can be: hang, block, display, runin, leftmargin, rightmargin, drop, wrap, frame
	{\raggedright\ImperialSansMedium\iftoggle{a1papersize}{\fontsize{42pt}{52.5pt}}{\fontsize{60pt}{75pt}}\selectfont} % Text formatting of the whole section, i.e. label and title
	{} % Section label (e.g. number) and its formatting
	{0pt} % Horizontal space between the section label and title
	{} % Code before the section title
	[] % Code after the section title

\titlespacing*{\section}{0pt}{0pt}{0pt} % Spacing around section titles, the order is: left, before and after

%------------------------------------------------

\titleformat
	{\subsection} % Section type being modified
	[block] % Section layout type, can be: hang, block, display, runin, leftmargin, rightmargin, drop, wrap, frame
	{\raggedright\bfseries} % Text formatting of the whole section, i.e. label and title
	{} % Section label (e.g. number) and its formatting
	{0pt} % Horizontal space between the section label and title
	{} % Code before the section title
	[] % Code after the section title

\titlespacing*{\subsection}{0pt}{0pt}{-\baselineskip} % Spacing around section titles, the order is: left, before and after

%------------------------------------------------

\newcommand{\boldsection}[1]{{\iftoggle{a1papersize}{\fontsize{42pt}{52.5pt}}{\fontsize{60pt}{75pt}}\selectfont\bfseries\textcolor{ICLDarkBlue}{#1}\par}} % Styling of bold sections

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
\definecolor{ICLDarkBlue}{RGB}{0, 0, 128}

%----------------------------------------------------------------------------------------
%	TABLES AND FIGURES
%----------------------------------------------------------------------------------------

\usepackage{booktabs} % Required for better horizontal rules in tables

\usepackage{array} % Required for manipulating table columns

\newcolumntype{R}[1]{>{\raggedleft\arraybackslash}p{#1}} % Define a new right-aligned paragraph column type
\newcolumntype{L}[1]{>{\raggedright\arraybackslash}p{#1}} % Define a new left-aligned (no justification) paragraph column type
\newcolumntype{C}[1]{>{\centering\arraybackslash}p{#1}} % Define a new centered paragraph column type

\setlength{\tabcolsep}{0.01\paperwidth} % Increase default padding between columns (6pt is the default)

\AfterEndEnvironment{figure}{\vspace{-\baselineskip}} % Remove extra vertical whitespace after figures
\AfterEndEnvironment{table}{\vspace{-\baselineskip}} % Remove extra vertical whitespace after figures

%----------------------------------------------------------------------------------------
%	CAPTIONS
%----------------------------------------------------------------------------------------

\usepackage{caption} % Required for customizing captions

\DeclareCaptionFormat{anyfontsize}{\iftoggle{a1papersize}{\fontsize{10pt}{12.5pt}\selectfont}{\fontsize{14pt}{17.5pt}\selectfont}#1#2#3} % Font size of captions in a new caption style
\captionsetup{format=anyfontsize, labelfont=bf} % Activate the custom caption style and style labels
\captionsetup{justification=justified, singlelinecheck=false} % Left-align captions

%----------------------------------------------------------------------------------------
%	LISTS
%----------------------------------------------------------------------------------------

\usepackage{enumitem} % Required for list customization

\setlist{
	leftmargin=*, % Remove the default margin to the left of lists
	labelsep=16pt, % Space between the label and item text
	nolistsep, % No extra whitespace above and below lists
}

\renewcommand{\labelitemi}{\textcolor{ICLBlue}{\textbullet}} % Customize the first level bullet point character
\renewcommand{\labelenumi}{\textcolor{ICLBlue}{\arabic{enumi}.}} % Customize the first level numbered list characters

%----------------------------------------------------------------------------------------
%	LINKS
%----------------------------------------------------------------------------------------

\usepackage{hyperref} % Required for links

\hypersetup{
	colorlinks=false, % Whether to color the text of links
	urlcolor=ICLBlue, % Color for \url and \href links
	linkcolor=ICLBlue, % Color for \nameref links
	citecolor=ICLBlue, % Color of reference citations
	hidelinks, % Hide the default boxes around links
}

%----------------------------------------------------------------------------------------
%	TITLE SECTION
%----------------------------------------------------------------------------------------

\newcommand{\titlesection}{
	\begingroup
		\color{ICLBlue} % Color
		\setlength{\arrayrulewidth}{2pt} % Thickness of table rules
		\begin{tabular}{@{} L{0.655\linewidth} | R{0.32\linewidth} @{}} % Column widths and text alignment
			\hline % Top rule
			\parbox[t]{\linewidth}{\vspace{0pt}\iftoggle{a1papersize}{\fontsize{42pt}{42pt}\selectfont}{\fontsize{62pt}{62pt}\selectfont}\bfseries\postertitle\vspace{20pt}} & \parbox[t]{\linewidth}{\vspace{0pt}\bfseries\posterauthors\vspace{20pt}}\\ % Poster title and authors in the 2 columns of the table, styled with whitespace above and below
			\hline % Bottom rule
		\end{tabular}
	\endgroup
}

%----------------------------------------------------------------------------------------
%	AFFILIATIONS
%----------------------------------------------------------------------------------------

\newcommand{\affiliation}[1]{\textsuperscript{#1}} % Command to output affiliation numbers in the author list

\newcommand{\affiliationentry}[2]{\textsuperscript{#1} #2} % Command to output affiliation institutions in a list

%----------------------------------------------------------------------------------------
%	COAUTHOR LOGOS
%----------------------------------------------------------------------------------------

\newcommand{\coauthorlogo}[2][\iftoggle{a1papersize}{1.7615cm}{2.4126cm}]{\hspace{2cm}\includegraphics[height=#1]{#2}} % Command to output a coauthor logo in the header

%----------------------------------------------------------------------------------------
%	CUSTOM COMMANDS
%----------------------------------------------------------------------------------------

\newcommand{\postertitle}[1]{\renewcommand{\postertitle}{#1}}
\newcommand{\posterauthors}[1]{\renewcommand{\posterauthors}{#1}}
\newcommand{\coauthorlogosinternal}{}\newcommand{\coauthorlogos}[1]{\renewcommand{\coauthorlogosinternal}{#1}}
