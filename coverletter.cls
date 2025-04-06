\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{coverletter}[2024/07/28 Custom Cover Letter Class]

% --- Load Base Class FIRST ---
% Pass options like font size and paper size here
\PassOptionsToClass{11pt,a4paper}{article} % Pass options
\LoadClass{article} % Load the base class

% --- Essential Packages Needed Early ---
\RequirePackage{graphicx} % Needed for \includegraphics
\RequirePackage{xcolor}   % Needed for \definecolor and \pagecolor
\RequirePackage{setspace} % Added setspace package

% --- Other Packages ---
\RequirePackage[icelandic]{babel}
\RequirePackage{fontspec}
\RequirePackage{xunicode}
\RequirePackage{hyperref}
\RequirePackage{geometry}
\RequirePackage{fontawesome5}
\RequirePackage{tikz}
\RequirePackage{kvoptions}
\RequirePackage{array} % Needed for m{} column type

% --- Class Options (if any) ---
% ...

% --- Define Colors ---
\definecolor{primarycolor}{RGB}{42,157,143}
\definecolor{secondarycolor}{RGB}{231,111,81}
\definecolor{textgray}{RGB}{102,102,102}
\definecolor{bgcolor}{RGB}{245,245,245} % Define a light background color

% --- Page Geometry ---
% Reduce bottom margin slightly to increase text height
\geometry{
  top=1.0cm,
  bottom=0.5cm, % Reduced from 2.5cm
  left=2.5cm,
  right=2.5cm,
  heightrounded % Good practice to keep
}

% --- Page Style ---
\pagestyle{empty} % Use empty page style (no header, no footer/page number)
\pagecolor{bgcolor} % Set the background color for the page

% --- Font Configuration ---
\setmainfont{InterNerdFontPropo}[
    Path = /usr/share/fonts/inter/,
    UprightFont = InterNerdFontPropo-Regular.otf,
    BoldFont = InterNerdFontPropo-Bold.otf,
    ItalicFont = InterNerdFontPropo-Italic.otf,
    BoldItalicFont = InterNerdFontPropo-BoldItalic.otf
]
\newfontfamily{\monofont}{Iosevka}[
    UprightFeatures={Font=*},
    BoldFeatures={Font=* Bold},
    ItalicFeatures={Font=* Italic},
    BoldItalicFeatures={Font=* Bold Italic}
]

% --- Hyperref Setup ---
\hypersetup{
  colorlinks=true,
  urlcolor=secondarycolor,
  linkcolor=primarycolor
}

% --- Paragraph Spacing ---
\setlength{\parskip}{1.5\baselineskip} % Increased paragraph spacing further
\setlength{\parindent}{0pt}
\setstretch{1.15} % Set line spacing (adjust 1.1 to 1.25 as needed)

% --- Signature Command ---
\newcommand*{\signatureName}[1]{\def\@signatureName{#1}}
\newcommand*{\signatureTitle}[1]{\def\@signatureTitle{#1}}
\newcommand*{\signatureEmail}[1]{\def\@signatureEmail{#1}}
\newcommand*{\signaturePhone}[1]{\def\@signaturePhone{#1}}
\newcommand*{\signatureWebsite}[1]{\def\@signatureWebsite{#1}}
\newcommand*{\signatureGithub}[1]{\def\@signatureGithub{#1}}
\newcommand*{\signatureLinkedin}[1]{\def\@signatureLinkedin{#1}}
\newcommand*{\signatureImageFile}[1]{\def\@signatureImageFile{#1}}
\newcommand*{\signatureQRCodeFile}[1]{\def\@signatureQRCodeFile{#1}}

% Default values
\signatureName{}
\signatureTitle{}
\signatureEmail{}
\signaturePhone{}
\signatureWebsite{}
\signatureGithub{}
\signatureLinkedin{}
\signatureImageFile{signature.png}
\signatureQRCodeFile{qr.png}

% Command to output the signature block
\newcommand{\makesignature}{%
  \vspace{1cm} % Space before signature
  % Reduce middle column slightly to help avoid overfull hbox? Try 8.5cm
  \begin{tabular}{m{2.5cm} m{8.5cm} m{2.5cm}} % Reduced width m{9cm} -> m{8.5cm}
     % Column 1: Signature Image
     \begin{tikzpicture}
       \clip (0,0) circle (1.25cm);
       \node at (0,0) {\includegraphics[width=2.5cm, height=2.5cm, keepaspectratio]{\@signatureImageFile}};
     \end{tikzpicture}
     &
     % Column 2: Text Details - Raise slightly to better center? Try 2pt adjustment
     \raisebox{2pt}{% Add small raisebox adjustment
       \begin{tabular}[c]{@{}l@{}}
         {\color{primarycolor}\textbf{\monofont \@signatureName}}\\[0.2cm]
         \@signatureTitle\\[0.2cm]
         {\color{secondarycolor}\href{mailto:\@signatureEmail}{\monofont \@signatureEmail}}\\[0.2cm]
         {\color{textgray}\href{tel:\@signaturePhone}{\monofont \@signaturePhone}}\\[0.2cm]
         {\color{textgray}\href{\@signatureWebsite}{\monofont sveinbjorn.dev}}\\[0.1cm]
         {\color{textgray}\href{\@signatureGithub}{\monofont GitHub}} |
         {\color{textgray}\href{\@signatureLinkedin}{\monofont LinkedIn}}
       \end{tabular}%
     }
     &
     % Column 3: QR Code Image
     \includegraphics[width=2.5cm, height=2.5cm, keepaspectratio]{\@signatureQRCodeFile}
  \end{tabular}
}
% Note: No \LoadClass here, it's at the top now!
\endinput 