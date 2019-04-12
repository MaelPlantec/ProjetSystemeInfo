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

#ifndef YY_YY_Y_TAB_H_INCLUDED
# define YY_YY_Y_TAB_H_INCLUDED
/* Debug traces.  */
#ifndef YYDEBUG
# define YYDEBUG 1
#endif
#if YYDEBUG
extern int yydebug;
#endif

/* Token type.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
  enum yytokentype
  {
    tMAIN = 258,
    tACCO = 259,
    tACCF = 260,
    tCONST = 261,
    tINT = 262,
    tID = 263,
    tNB = 264,
    tPTF = 265,
    tPLUS = 266,
    tMOINS = 267,
    tMUL = 268,
    tDIV = 269,
    tEGAL = 270,
    tINF = 271,
    tSUP = 272,
    tINFEG = 273,
    tSUPEG = 274,
    tPARO = 275,
    tPARF = 276,
    tVIRG = 277,
    tPV = 278,
    tIF = 279,
    tELSE = 280,
    tWHILE = 281,
    tERR = 282
  };
#endif
/* Tokens.  */
#define tMAIN 258
#define tACCO 259
#define tACCF 260
#define tCONST 261
#define tINT 262
#define tID 263
#define tNB 264
#define tPTF 265
#define tPLUS 266
#define tMOINS 267
#define tMUL 268
#define tDIV 269
#define tEGAL 270
#define tINF 271
#define tSUP 272
#define tINFEG 273
#define tSUPEG 274
#define tPARO 275
#define tPARF 276
#define tVIRG 277
#define tPV 278
#define tIF 279
#define tELSE 280
#define tWHILE 281
#define tERR 282

/* Value type.  */
#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED

union YYSTYPE
{
#line 8 "compiler_v4.y" /* yacc.c:1909  */

	int nb;
	char* str;

#line 113 "y.tab.h" /* yacc.c:1909  */
};

typedef union YYSTYPE YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define YYSTYPE_IS_DECLARED 1
#endif


extern YYSTYPE yylval;

int yyparse (void);

#endif /* !YY_YY_Y_TAB_H_INCLUDED  */
