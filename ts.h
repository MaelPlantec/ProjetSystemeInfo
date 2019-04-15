#ifndef TS_H_
#define TS_H_

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define TAILLE 1024

#define DEBUTPILE 0

//void yyerror(char *);

typedef enum Type Type;
enum Type {INT = 1, CONST_INT = 1, TMP = 1};

struct ligne_ts {
  int ts_addr;
  char* ts_name;
  Type ts_type;
  unsigned int ts_profondeur;
};

struct ligne_ts ts[TAILLE];

unsigned int ts_index;

unsigned int ts_profondeur_actuelle;

void ts_init (void);

int ts_declaration(char* name, Type type);

int ts_get_addr(char * name);

void ts_depth_incr(void);

void ts_depth_decr(void);

void ts_pop (void);

int ts_add_tmp (void);

void ts_text (void);

#endif  /* TS_H */
