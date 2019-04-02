#ifndef TS_H_
#define TS_H_

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define TAILLE 1024

//void yyerror(char *);

typedef enum Type Type;
enum Type {INT = 8, CONST_INT = 8};

struct ligne_ts {
  unsigned int ts_addr;
  char* ts_name;
  Type ts_type;
  unsigned int ts_profondeur;
};

struct ligne_ts ts[TAILLE];

unsigned int ts_index;

unsigned int ts_profondeur_actuelle;

void ts_init (void);

unsigned int ts_declaration(char* name, Type type);

unsigned int ts_get_addr(char * name);

void ts_depth_incr(void);

void ts_depth_decr(void);

#endif  /* TS_H */
