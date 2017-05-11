/* description: Parses end evaluates mathematical expressions. */
/* lexical grammar */
%{
  function toNum(str) {
    return str * 1;
  }
%}

%lex
%%
\s+                   {/* skip whitespace */}
[0-9]+                {return 'NUMBER';}
\"\w+\"               {return 'STRING';}
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
">="                  {return '>=';}
"<="                  {return '<=';}
"=="                  {return '==';}
"!="                  {return '!=';}
">" 								  {return '>';}
"<" 								  {return '<';}
"||"                  {return '||';}
"&&"                  {return '&&';}
"&"                   {return '&';}
"TRUE"                {return 'TRUE';}
"FALSE"               {return 'FALSE';}
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
/lex

/* operator associations and precedence (low-top, high- bottom) */
%left '='
%left '<=' '>=' 'NOT' '||' 'OR' 'NOR' 'NAND' 'AND' '&&' '==' '!='
%left '>' '<'
%left '+' '-'
%left '*' '/'
%left '^'
%left '&'
%left '%'
%left UMINUS

%start exprs

%% /* language grammar */

exprs
    : expr EOF {
        return $1;
    }
;

expr
  /* Arithmetic */
  : expr '+' expr {
    $$ = toNum($1) + toNum($3);
  }
  | expr '-' expr {
    $$ = toNum($1) - toNum($3);
  }
  | expr '*' expr {
    $$ = toNum($1) * toNum($3);
  }
  | expr '/' expr {
    $$ = toNum($1) / toNum($3);
  }
  | '(' expr ')' {
    $$ = $2;
  }
  | expr '==' expr {
    $$ = ($1 == $3);
  }
  | expr '!=' expr {
    $$ = ($1 != $3);
  }
  | expr '>=' expr {
    $$ = ($1 >= $3);
  }
  | expr '<=' expr {
    $$ = ($1 <= $3);
  }
  | expr '>' expr {
    $$ = ($1 > $3);
  }
  | expr '<' expr {
    $$ = ($1 < $3);
  }
  | NOT '(' expr ')' {
    $$ = !($3);
  }
  | AND '(' expr ',' expr ')' {
    $$ = ($3 && $5); 
  }
  | expr '&&' expr {
    $$ = ($1 && $3);
  }
  | OR '(' expr ',' expr ')' {
    $$ = ($3 || $5);
  }
  | expr '||' expr {
    $$ = ($1 || $3);
  }
  | IF '(' expr ',' expr ',' expr ')' {
    $$ = ($3 ? $5 : $7);
  }
  | number {
    $$ = $1;
  }
  | STRING {
    $$ = $1;
  }
  | bool {
    $$ = $1;
  }
;

bool
  : TRUE {
    $$ = true;
  }
  | FALSE {
    $$ = false;
  }
;

number
  : NUMBER {
    $$ = $1;
  }
	| NUMBER DECIMAL NUMBER {
    $$ = ($1 + '.' + $3) * 1;
  }
	| number '%' {
    $$ = $1 * 0.01;
  }
;

%%