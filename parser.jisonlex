%%
\s+                   {/* skip whitespace */}
[0-9]+                {return 'NUMBER';}
\$\$\w+\b(.\w+\b)+?    {return 'PATH';}
"&"                   {return '&';}
" "									  {return ' ';}
[.]									  {return 'DECIMAL';}
":"									  {return ':';}
";"									  {return ';';}
","									  {return ',';}
"*" 								  {return '*';}
"/" 								  {return '/';}
"-" 								  {return '-';}
"+" 								  {return '+';}
"^" 								  {return '^';}
"(" 								  {return '(';}
")" 								  {return ')';}
">" 								  {return '>';}
"<" 								  {return '<';}
"NOT"								  {return 'NOT';}
"IF"                  {return 'IF';}
"AND"                 {return 'AND';}
"OR"                  {return 'OR';}
"NAND"                {return 'NAND';}
"NOR"                 {return 'NOR';}
'"'									  {return '"';}
"'"									  {return "'";}
"!"									  {return "!";}
"="									  {return '=';}
"%"									  {return '%';}
[#]									  {return '#';}
<<EOF>>								{return 'EOF';}
