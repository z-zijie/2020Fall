#include <iostream>
#include <fstream>
#include <string>
using namespace std;

int main()
{
    cout << "This application was developed to quickly generate tex templates for Homework." << endl;

    cout << "PLEASE ENTER the \"FILENAME\": ";
    string filename;
    getline(cin, filename);

    cout << "PLEASE ENTER the \"COURSE NAME\": ";
    string course_name;
    getline(cin, course_name);

    cout << "PLEASE ENTER the \"Title\": ";
    string title;
    getline(cin, title);

    cout << "PLEASE ENTER the \"Due Date\": ";
    string Due;
    getline(cin, Due);

    // Print the brief description
    cout << "==== ==== ==== ==== ==== ==== ==== ==== ==== ==== ====" << endl;
    cout << endl << "Here is the brief description for the LATEX template:" << endl;
    cout << "FILENAME: " << filename << endl;
    cout << "COURSE NAME: " << course_name << endl;
    cout << "TITLE: " << title << endl;
    cout << "DUE: " << Due << endl;
    cout << "---- ----- ----- ----- ----- ----- ----- ----- -----" << endl;
    cout << "The file \"" << filename << ".tex\" was located in the same directory as this program." << endl;

    // Generate the .tex file
    ofstream outfile (filename+".tex");

    string init_code;
    init_code = "\\documentclass{article}\n";
    init_code += "% --- Modify margins --- %\n";
    init_code += "\\usepackage{geometry}\n";
    init_code += "\\geometry{a4paper,scale=0.8}\n";
    init_code += "% --- Involved packages --- %\n";
    init_code += "\\usepackage{amssymb}\n";
    init_code += "\\usepackage{amsthm}\n";
    init_code += "\\usepackage{amsmath}\n";
    init_code += "\\usepackage{bm}\n";
    init_code += "\\usepackage{graphicx}\n";
    init_code += "\\usepackage{physics}\n";
    init_code += "\\usepackage{enumitem}\n";
    init_code += "\\usepackage{listings}\n";
    init_code += "\\usepackage{xcolor}\n";
    init_code += "\\usepackage[utf8]{inputenc}\n";
    init_code += "\\usepackage[english]{babel}\n";
    init_code += "\\usepackage{appendix}\n";

    init_code += "\n\\renewcommand{\\familydefault}{\\sfdefault}\n";

    init_code += "\n\\definecolor{codegreen}{rgb}{0,0.6,0}\n";
    init_code += "\\definecolor{codegray}{rgb}{0.5,0.5,0.5}\n";
    init_code += "\\definecolor{codepurple}{rgb}{0.58,0,0.82}\n";
    init_code += "\\definecolor{backcolour}{rgb}{0.95,0.95,0.92}\n";

    init_code += "\n";
    init_code += "\\lstdefinestyle{mystyle}{\n";
    init_code += "\t% backgroundcolor=\\color{backcolour},\n";
    init_code += "\tcommentstyle=\\color{codegreen},\n";
    init_code += "\tkeywordstyle=\\color{magenta},\n";
    init_code += "\tnumberstyle=\\tiny\\color{codegray},\n";
    init_code += "\tstringstyle=\\color{codepurple},\n";
    init_code += "\tbasicstyle=\\sffamily\\footnotesize,\n";
    init_code += "\tbreakatwhitespace=false,\n";
    init_code += "\tbreaklines=true,\n";
    init_code += "\tcaptionpos=b,\n";
    init_code += "\tkeepspaces=true,\n";
    init_code += "\t% numbers=left,\n";
    init_code += "\tnumbersep=5pt,\n";
    init_code += "\tshowspaces=false,\n";
    init_code += "\tshowstringspaces=false,\n";
    init_code += "\tshowtabs=false,\n";
    init_code += "\ttabsize=2\n";
    init_code += "}\n";

    init_code += "\n";
    init_code += "\\lstset{style=mystyle}\n";
    init_code += "\n";
    init_code += "% --- NewCommand --- %\n";
    init_code += "% \\newcommand{\\norm}[1]{\\left\\lVert#1\\right\\rVert}\n";
    init_code += "\n";
    init_code += "\\usepackage{hyperref}\n";
    init_code += "\\hypersetup{\n";
    init_code += "\tcolorlinks=true,\n";
    init_code += "\tlinkcolor=blue,\n";
    init_code += "\tfilecolor=magenta,\n";
    init_code += "\turlcolor=cyan,\n";
    init_code += "}\n\n";
    init_code += "\\urlstyle{same}\n\n\n\n\n\n";

    string title_information;
    title_information += "% --- Title information --- %\n";
    title_information += "\\title{";
    title_information += course_name;
    title_information += " - Fall 2020\\\\\n";
    title_information += "\t\t{\\Large \\textbf{";
    title_information += title;
    title_information += "}}\\\\\n";
    title_information += "\t\t{\\normalsize \\textbf{Due : ";
    title_information += Due;
    title_information += "}}\n";
    title_information += "\t}\n";
    title_information += "\\author{Zijie Zhang}\n";
    title_information += "\\date{\\today}\n\n\n";

    string begin_cmd;
    begin_cmd += "% --- main --- %\n";
    begin_cmd += "\\begin{document}\n";
    begin_cmd += "\t\\maketitle\n";

    string end_cmd;
    end_cmd = "\n\n\\end{document}";

    outfile << init_code << endl;
    outfile << title_information << endl;
    outfile << begin_cmd << endl;
    outfile << end_cmd << endl;
    outfile.close();

    return 0;
}