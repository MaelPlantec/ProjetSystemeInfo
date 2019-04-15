#ifndef TA_H_
#define TA_H_

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

// Taille maximale du tableau des instructions d'assembleur.
#define TAILLE_I 150
// T : Les opérations, les noms des registres ou les adresses ne dépasseront pas 6.
#define T 6

unsigned int ta_index;

struct ta_instru {
  char OPE[T];
  int A;
  int B;
  int C;
};

struct ta_instru ta[TAILLE_I];

void ta_init (void);

void ta_add (char* OPE, int A, int B, int C);

void ta_update_jmp(int indice_jmp, int addr);

void ta_text (void);

#endif  /* TA_H */
