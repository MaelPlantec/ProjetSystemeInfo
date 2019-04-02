/* A Bison parser, made by GNU Bison 2.3.  */

/* Skeleton interface for Bison's Yacc-like parsers in C

   Copyright (C) 1984, 1989, 1990, 2000, 2001, 2002, 2003, 2004, 2005, 2006
   Free Software Foundation, Inc.

   This program is free software; you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation; either version 2, or (at your option)
   any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program; if not, write to the Free Software
   Foundation, Inc., 51 Franklin Street, Fifth Floor,
   Boston, MA 02110-1301, USA.  */

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

/* Tokens.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
   /* Put the tokens into the symbol table, so that GDB and other debuggers
      know about them.  */
   enum yytokentype {
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




#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
typedef union YYSTYPE
#line 7 "compiler_v3.y"
{
	int nb;
	char* str;
}
/* Line 1529 of yacc.c.  */
#line 108 "y.tab.h"
	YYSTYPE;
# define yystype YYSTYPE /* obsolescent; will be withdrawn */
# define YYSTYPE_IS_DECLARED 1
# define YYSTYPE_IS_TRIVIAL 1
#endif

extern YYSTYPE yylval;

