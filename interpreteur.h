#ifndef INTERPRETEUR_H_
#define INTERPRETEUR_H_

#include "ta.h"

#define NB_REGISTRES 3

int registres[NB_REGISTRES];
int memoire[1024];

void interpreteur_init(struct ta_instru ta[TAILLE_I], int max);

void traitement(struct ta_instru instru);

void affiche_registres(void);

void affiche_memoire(void);

#endif  /* INTERPRETEUR_H */
