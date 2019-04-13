#ifndef INTERPRETEUR_H_
#define INTERPRETEUR_H_

#include "ta.h"

int registres[3];
int memoire[1024];

void interpreteur_init(struct ta_instru ta[TAILLE_I], int max);

void traitement(struct ta_instru instru);

#endif  /* INTERPRETEUR_H */
