%{

#include "filterJGEXtoFOF.tab.h"
%}

numero    [0-9]+
palavra   [A-Za-z]+
variavel  [a-zA-Z_][a-zA-Z0-9_']*
separador ";" 

%%

(.|\n)*HYPOTHESES { /* delete everything up to HYPOTHESES */ }
MIDPOINT        { return(MIDPOINT); }
BPOINT          { return(POINT); }
POINT           { return(POINT); }
PERPENDICULAR   { return(PERPENDICULAR); }
QUADRANGLE      { return(QUADRANGLE); }
PARALLELOGRAM   { return(PARALLELOGRAM); }
SQUARE          { return(SQUARE); }
NSQUARE         { return(NSQUARE); }
PSQUARE         { return(PSQUARE); }
PENTAGON        { return(PENTAGON); }
TRIANGLE        { return(TRIANGLE); }
PE_TRIANGLE     { return(PETRIANGLE); }
REFLECTION      { return(REFLECTION); }
ON_LINE         { return(ONLINE); }
ON_TLINE        { return(ONTLINE); }
ON_PLINE        { return(ONPLINE); }
ON_BLINE        { return(ONBLINE); }
ON_ALINE        { return(ONALINE); }
LINE            { return(LINE); }
ON_CIRCLE       { return(ONCIRCLE); }
ON_RCIRCLE      { return(ONRCIRCLE); }
CIRCLE          { return(CIRCLE); }
CYCLIC          { return(CYCLIC); }
R_TRIANGLE      { return(RTRIANGLE); }
ISO_TRIANGLE    { return(ISOTRIANGLE); }
SIM_TRIANGLE    { return(SIMTRIANGLE); }
EQ_TRIANGLE     { return(EQTRIANGLE); }
CON_TRIANGLE    { return(CONTRIANGLE); }
INTERSECTION_CC { return(INTERSECTIONCC); }
INTERSECTION_LC { return(INTERSECTIONLC); }
INTERSECTION_LL { return(INTERSECTIONLL); }
INTERSECTION_LT { return(INTERSECTIONLT); }
INTERSECTION_PP { return(INTERSECTIONPP); }
ORTHOCENTER     { return(ORTHOCENTER); }
CIRCUMCENTER    { return(CIRCUMCENTER); }
INCENTER        { return(INCENTER); }
COLLINEAR       { return(COLLINEAR); }
EQANGLE         { return(EQANGLE); }
S_ANGLE         { return(SANGLE); }
ANGLE_BISECTOR  { return(ANGLEBISECTOR); }
PARALLEL        { return(PARALLEL); }
EQDISTANCE      { return(EQDISTANCE); }
FOOT            { return(FOOT); }
LRATIO          { return(LRATIO); }
PRATIO          { return(PRATIO); }
TRATIO          { return(TRATIO); }
RATIO           { return(RATIO); }
LC_TANGENT      { return(LCTANGENT); }
R_TRAPEZOID     { return(RTRAPEZOID); }
TRAPEZOID       { return(TRAPEZOID); }
RECTANGLE       { return(RECTANGLE); }
SYM             { return(SYM); }
THM             { /* Ignora */ }
SHOW            { return(SHOW); }
SHOW": "NO      { return(NOSHOW); }
Dialog          { /* Ignora */ }
T h e o r e m(.|\n)*  { return(FINALIZA); }

{numero}       { 
                 yylval.number=atoi(yytext);
                 return(NUMERO); 
               }
{variavel}     {
                 yylval.string=strdup(yytext);
                 return(VARIABLE);
               }
{separador}    { return(SEPARADOR); }
[ \t]          { /* skip white spaces */ }
[\n]           { /*printf("%s",yytext);*/ } 
.              { /* skip everything else */ }
%%

