%{
#include <string.h>
#include <stdlib.h>
#include <math.h>
#include "instruction.h"
#include "valeur.h"
#include "expression.h"
#include "constantes.h"
char* dupliquerChaine(char *);

#define YY_NO_INPUT
%}
%option nounput

ENT	[0-9]+
NBRE_ENTIER {ENT}
EXP [eE][+-]{ENT}
VIRG \.{ENT}
NBRE_REEL	{ENT}|{ENT}{VIRG}|{ENT}{EXP}|{ENT}{VIRG}{EXP}
ECRIRE [eE][cC][rR][iI][rR][eE]
LIRE [lL][iI][rR][eE]
RIEN [rR][iI][eE][nN]
IDENT [_a-zA-Z][_0-9a-zA-Z]*
BOOLEEN 0|1
ALLER_A [aA][lL][lL][eE][rR][aA]
SI [sS][iI]
ALORS [aA][lL][oO][rR][sS]
NON [nN][oO][nN]
OU [oO][uU]
ET [eE][tT]
VRAI [vV][rR][aA][iI]
FAUX [fF][aA][uU][xX]

%%
[ \t]		;
{NBRE_ENTIER}   {yylval.valeur = VAL_valeurEntiere(atoi(yytext)); return TERMINAL_CONSTANTE;}
{NBRE_REEL}    	{yylval.valeur = VAL_valeurReelle(atof(yytext)); return TERMINAL_CONSTANTE;}
{VRAI}          {yylval.valeur = VAL_valeurBooleenne(1); return TERMINAL_CONSTANTE;}
{FAUX}          {yylval.valeur = VAL_valeurBooleenne(0); return TERMINAL_CONSTANTE;}
{NON}           return OP_NON;
{OU}            return OP_OU;
{ET}            return OP_ET;
{SI}            return TERMINAL_SI;
{ALORS}         return TERMINAL_ALORS;
{ALLER_A}       return TERMINAL_ALLER_A;
{ECRIRE}        return TERMINAL_ECRIRE;
{LIRE}          return TERMINAL_LIRE;
{RIEN}		      return TERMINAL_RIEN;
{IDENT}		      {yylval.id = dupliquerChaine(yytext);return ID;}
[+] 	          return OP_ADD;
[-] 	          return OP_SOUS;
[*] 	          return OP_MUL;
[/] 	          return OP_DIV;
[(] 	          return PAR_G;
[)] 	          return PAR_D;
[=]             return TERMINAL_AFFEC;
[\n]            return TERMINAL_FIN;
[:]             return MARQUEUR_LABEL;
[>]             return OP_PLUS_GRAND;
[<]             return OP_PLUS_PETIT;
[<][=]          return OP_PLUS_PETIT_OU_EGAL;
[>][=]          return OP_PLUS_GRAND_OU_EGAL;
[=][=]          return OP_EGAL;
[!][=]          return OP_DIFFERENT;
%%

char* dupliquerChaine(char *chaine) {
  char* nouvelleChaine = malloc(strlen(chaine)+1);
  strcpy(nouvelleChaine, chaine);
  return nouvelleChaine;
}

int yywrap(void){
  return 1;
}
