/* A Bison parser, made by GNU Bison 3.0.4.  */

/* Bison interface for Yacc-like parsers in C

   Copyright (C) 1984, 1989-1990, 2000-2015 Free Software Foundation, Inc.

   This program is free software: you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation, either version 3 of the License, or
   (at your option) any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program.  If not, see <http://www.gnu.org/licenses/>.  */

/* As a special exception, you may create a larger work that contains
   part or all of the Bison parser skeleton and distribute that work
   under terms of your choice, so long as that work isn't itself a
   parser generator using the skeleton or a modified version thereof
   as a parser skeleton.  Alternatively, if you modify or redistribute
   the parser skeleton itself, you may (at your option) remove this
   special exception, which will cause the skeleton and the resulting
   Bison output files to be licensed under the GNU General Public
   License without this special exception.

   This special exception was added by the Free Software Foundation in
   version 2.2 of Bison.  */

#ifndef YY_YY_INCLUDE_CONSTANTES_H_INCLUDED
# define YY_YY_INCLUDE_CONSTANTES_H_INCLUDED
/* Debug traces.  */
#ifndef YYDEBUG
# define YYDEBUG 0
#endif
#if YYDEBUG
extern int yydebug;
#endif

/* Token type.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
  enum yytokentype
  {
    ID = 258,
    TERMINAL_CONSTANTE = 259,
    PAR_G = 260,
    PAR_D = 261,
    MARQUEUR_LABEL = 262,
    TERMINAL_AFFEC = 263,
    TERMINAL_ECRIRE = 264,
    TERMINAL_FIN = 265,
    TERMINAL_LIRE = 266,
    TERMINAL_RIEN = 267,
    TERMINAL_ALLER_A = 268,
    TERMINAL_SI = 269,
    TERMINAL_ALORS = 270,
    OP_ADD = 271,
    OP_SOUS = 272,
    OP_DIV = 273,
    OP_MUL = 274,
    OP_PLUS_GRAND = 275,
    OP_PLUS_PETIT = 276,
    OP_PLUS_GRAND_OU_EGAL = 277,
    OP_PLUS_PETIT_OU_EGAL = 278,
    OP_EGAL = 279,
    OP_DIFFERENT = 280,
    OP_NON = 281,
    OP_OU = 282,
    OP_ET = 283
  };
#endif

/* Value type.  */
#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED

union YYSTYPE
{
#line 15 "src/analyseurSyntaxique.y" /* yacc.c:1909  */
VAL_Valeur valeur; EXP_Expression expression; INSTR_Instruction instruction; char* id;

#line 86 "include/constantes.h" /* yacc.c:1909  */
};

typedef union YYSTYPE YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define YYSTYPE_IS_DECLARED 1
#endif


extern YYSTYPE yylval;

int yyparse (INSTR_Instruction* pInstruction, char* label, int* pErreur);

#endif /* !YY_YY_INCLUDE_CONSTANTES_H_INCLUDED  */
