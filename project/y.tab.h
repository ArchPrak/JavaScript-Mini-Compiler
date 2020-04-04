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
    VAR = 258,
    TRUE = 259,
    FALSE = 260,
    RETURN = 261,
    FOR = 262,
    CONTINUE = 263,
    IF = 264,
    ELSE = 265,
    BREAK = 266,
    IDENTIFIER = 267,
    INC_OP = 268,
    DEC_OP = 269,
    AND_OP = 270,
    OR_OP = 271,
    L_OP = 272,
    G_OP = 273,
    TEQ_OP = 274,
    LE_OP = 275,
    GE_OP = 276,
    EQ_OP = 277,
    NE_OP = 278,
    INT_LITERAL = 279,
    STRING_LITERAL = 280
  };
#endif
/* Tokens.  */
#define VAR 258
#define TRUE 259
#define FALSE 260
#define RETURN 261
#define FOR 262
#define CONTINUE 263
#define IF 264
#define ELSE 265
#define BREAK 266
#define IDENTIFIER 267
#define INC_OP 268
#define DEC_OP 269
#define AND_OP 270
#define OR_OP 271
#define L_OP 272
#define G_OP 273
#define TEQ_OP 274
#define LE_OP 275
#define GE_OP 276
#define EQ_OP 277
#define NE_OP 278
#define INT_LITERAL 279
#define STRING_LITERAL 280

/* Value type.  */
#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED

union YYSTYPE
{
#line 9 "parse.y" /* yacc.c:1909  */

    int intVal;
    char* charVal;

#line 109 "y.tab.h" /* yacc.c:1909  */
};

typedef union YYSTYPE YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define YYSTYPE_IS_DECLARED 1
#endif


extern YYSTYPE yylval;

int yyparse (void);

#endif /* !YY_YY_Y_TAB_H_INCLUDED  */
