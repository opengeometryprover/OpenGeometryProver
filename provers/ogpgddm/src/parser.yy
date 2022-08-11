/* -*- bison -*-/

/*
 * Conjecture's parser
 */


%skeleton "lalr1.cc"
%require "3.7.5"

%defines

%define api.token.raw
%define api.token.constructor
%define api.value.type variant
%define parse.assert

%code requires {
    # include <string>
    class Driver;
}

// The parsing context
%param { Driver& drv }

%locations

%define parse.trace
%define parse.error detailed
%define parse.lac full

%code {
# include "foftodb.hpp"
}

%define api.token.prefix {TOK_}
%token
    MINUS                   "-"
    PLUS                    "+"
    STAR                    "*"
    SLASH                   "/"
    LPAREN                  "("
    RPAREN                  ")"
    LRPAREN                 "["
    RRPAREN                 "]"
    COMMA                   ","
    PERIOD                  "."
    FOF                     "fof"
    CONJ                    "conjecture"
    CONJUNCTION             "&"
    FORALL                  "!"
    COLON                   ":"
    SYNTACTICCONSEQUENCE    "=>"
    CIRCLE                  "circle"
    COLL                    "coll"
    CONG                    "cong"
    CONTRI                  "contri"
    CYCLIC                  "cyclic"
    EQANGLE                 "eqangle"
    EQRATIO                 "eqratio"
    MIDP                    "midp"
    PARA                    "para"
    PERP                    "perp"
    SIMTRI                  "simtri"
;

%token <std::string> IDENTIFIER "identifier"
%token <int> NUMBER "number"

%printer { yyo << $$; } <*>;

%%

%start unit;
unit: fof {};

fof:
    "fof" "(" "identifier" "," "conjecture" "," forall ":" "(" "(" antecedents ")" "=>" consequent ")" ")" "."
    {};

forall:
    "!" "[" varList "]"
    {};

antecedents:
    %empty {}
    | antecedents antecedent {}
    | antecedents antecedent "&" {}

antecedent:
    geocmd 
    {
	drv.antconcedent[drv.numGeoCmd] = 0;
	drv.numGeoCmd++;
    };

consequent:
    geocmd
    {
	drv.antconcedent[drv.numGeoCmd] = 1;
	drv.numGeoCmd++;
    };
  
geocmd:
    circle {};
    | coll {};
    | cong {};
    | contri {};
    | cyclic {};
    | eqangle {};
    | eqratio {};
    | para {};
    | perp {};
    | midp {};
    | simtri {};

circle:
    "circle" "(" "identifier" "," "identifier" "," "identifier" "," "identifier" ")"
    {
	drv.typeGeoCmd[drv.numGeoCmd] = "circle";
	drv.point1[drv.numGeoCmd]=$3;
	drv.point2[drv.numGeoCmd]=$5;
	drv.point3[drv.numGeoCmd]=$7;
	drv.point4[drv.numGeoCmd]=$9;
    }

coll:
    "coll" "(" "identifier" "," "identifier" "," "identifier" ")"
    {
	drv.typeGeoCmd[drv.numGeoCmd] = "coll";
	drv.point1[drv.numGeoCmd] = $3;
	drv.point2[drv.numGeoCmd] = $5;
	drv.point3[drv.numGeoCmd] = $7;
    };

cong:
    "cong" "(" "identifier" "," "identifier" "," "identifier" "," "identifier" ")"
    {
	drv.typeGeoCmd[drv.numGeoCmd] = "cong";
	drv.point1[drv.numGeoCmd]=$3;
	drv.point2[drv.numGeoCmd]=$5;
	drv.point3[drv.numGeoCmd]=$7;
	drv.point4[drv.numGeoCmd]=$9;
    }

contri:
    "contri" "(" "identifier" "," "identifier" "," "identifier" "," "identifier" "," "identifier" "," "identifier" ")"
    {
	drv.typeGeoCmd[drv.numGeoCmd] = "contri";
	drv.point1[drv.numGeoCmd]=$3;
	drv.point2[drv.numGeoCmd]=$5;
	drv.point3[drv.numGeoCmd]=$7;
	drv.point4[drv.numGeoCmd]=$9;
	drv.point5[drv.numGeoCmd]=$11;
	drv.point6[drv.numGeoCmd]=$13;
    }

cyclic:
    "cyclic" "(" "identifier" "," "identifier" "," "identifier" "," "identifier" ")"
    {
	drv.typeGeoCmd[drv.numGeoCmd] = "cyclic";
	drv.point1[drv.numGeoCmd]=$3;
	drv.point2[drv.numGeoCmd]=$5;
	drv.point3[drv.numGeoCmd]=$7;
	drv.point4[drv.numGeoCmd]=$9;
    }

eqangle:
    "eqangle" "(" "identifier" "," "identifier" "," "identifier" "," "identifier" "," "identifier" "," "identifier" "," "identifier" "," "identifier" ")"
    {
	drv.typeGeoCmd[drv.numGeoCmd] = "eqangle";
	drv.point1[drv.numGeoCmd]=$3;
	drv.point2[drv.numGeoCmd]=$5;
	drv.point3[drv.numGeoCmd]=$7;
	drv.point4[drv.numGeoCmd]=$9;
	drv.point5[drv.numGeoCmd]=$11;
	drv.point6[drv.numGeoCmd]=$13;
	drv.point7[drv.numGeoCmd]=$15;
	drv.point8[drv.numGeoCmd]=$17;
    }

eqratio:
    "eqratio" "(" "identifier" "," "identifier" "," "identifier" "," "identifier" "," "identifier" "," "identifier" "," "identifier" "," "identifier" ")"
    {
	drv.typeGeoCmd[drv.numGeoCmd] = "eqratio";
	drv.point1[drv.numGeoCmd]=$3;
	drv.point2[drv.numGeoCmd]=$5;
	drv.point3[drv.numGeoCmd]=$7;
	drv.point4[drv.numGeoCmd]=$9;
	drv.point5[drv.numGeoCmd]=$11;
	drv.point6[drv.numGeoCmd]=$13;
	drv.point7[drv.numGeoCmd]=$15;
	drv.point8[drv.numGeoCmd]=$17;
    }

para:
    "para" "(" "identifier" "," "identifier" "," "identifier" "," "identifier" ")"
    {
	drv.typeGeoCmd[drv.numGeoCmd] = "para";
	drv.point1[drv.numGeoCmd]=$3;
	drv.point2[drv.numGeoCmd]=$5;
	drv.point3[drv.numGeoCmd]=$7;
	drv.point4[drv.numGeoCmd]=$9;
    };

perp:
    "perp" "(" "identifier" "," "identifier" "," "identifier" "," "identifier"  ")"
    {
	drv.typeGeoCmd[drv.numGeoCmd] = "perp";
	drv.point1[drv.numGeoCmd]=$3;
	drv.point2[drv.numGeoCmd]=$5;
	drv.point3[drv.numGeoCmd]=$7;
	drv.point4[drv.numGeoCmd]=$9;
    };

midp:
    "midp" "(" "identifier" "," "identifier" "," "identifier" ")"
    {
	drv.typeGeoCmd[drv.numGeoCmd] = "midp";
	drv.point1[drv.numGeoCmd] = $3;
	drv.point2[drv.numGeoCmd] = $5;
	drv.point3[drv.numGeoCmd] = $7;
    };

simtri:
    "simtri" "(" "identifier" "," "identifier" "," "identifier" "," "identifier" "," "identifier" "," "identifier" ")"
    {
	drv.typeGeoCmd[drv.numGeoCmd] = "simtri";
	drv.point1[drv.numGeoCmd]=$3;
	drv.point2[drv.numGeoCmd]=$5;
	drv.point3[drv.numGeoCmd]=$7;
	drv.point4[drv.numGeoCmd]=$9;
	drv.point5[drv.numGeoCmd]=$11;
	drv.point6[drv.numGeoCmd]=$13;
    }

varList:
    %empty {}
    | varList "identifier" {}
    | varList "identifier" "," {}


%left "+" "-";
%left "*" "/";

%%

void yy::parser::error(const location_type& l, const std::string& m)
{
    std::cerr << l << ": " << m << '\n';
}
